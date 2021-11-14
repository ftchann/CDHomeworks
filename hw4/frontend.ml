open Ll
open Llutil
open Ast

(* instruction streams ------------------------------------------------------ *)

(* As in the last project, we'll be working with a flattened representation
   of LLVMlite programs to make emitting code easier. This version
   additionally makes it possible to emit elements will be gathered up and
   "hoisted" to specific parts of the constructed CFG
   - G of gid * Ll.gdecl: allows you to output global definitions in the middle
     of the instruction stream. You will find this useful for compiling string
     literals
   - E of uid * insn: allows you to emit an instruction that will be moved up
     to the entry block of the current function. This will be useful for
     compiling local variable declarations
*)

type elt =
  | L of Ll.lbl             (* block labels *)
  | I of uid * Ll.insn      (* instruction *)
  | T of Ll.terminator      (* block terminators *)
  | G of gid * Ll.gdecl     (* hoisted globals (usually strings) *)
  | E of uid * Ll.insn      (* hoisted entry block instructions *)

type stream = elt list
let ( >@ ) x y = y @ x
let ( >:: ) x y = y :: x
let lift : (uid * insn) list -> stream = List.rev_map (fun (x,i) -> I (x,i))

(* Build a CFG and collection of global variable definitions from a stream *)
let cfg_of_stream (code:stream) : Ll.cfg * (Ll.gid * Ll.gdecl) list  =
    let gs, einsns, insns, term_opt, blks = List.fold_left
      (fun (gs, einsns, insns, term_opt, blks) e ->
        match e with
        | L l ->
           begin match term_opt with
           | None ->
              if (List.length insns) = 0 then (gs, einsns, [], None, blks)
              else failwith @@ Printf.sprintf "build_cfg: block labeled %s has\
                                               no terminator" l
           | Some term ->
              (gs, einsns, [], None, (l, {insns; term})::blks)
           end
        | T t  -> (gs, einsns, [], Some (Llutil.Parsing.gensym "tmn", t), blks)
        | I (uid,insn)  -> (gs, einsns, (uid,insn)::insns, term_opt, blks)
        | G (gid,gdecl) ->  ((gid,gdecl)::gs, einsns, insns, term_opt, blks)
        | E (uid,i) -> (gs, (uid, i)::einsns, insns, term_opt, blks)
      ) ([], [], [], None, []) code
    in
    match term_opt with
    | None -> failwith "build_cfg: entry block has no terminator"
    | Some term ->
       let insns = einsns @ insns in
       ({insns; term}, blks), gs


(* compilation contexts ----------------------------------------------------- *)

(* To compile OAT variables, we maintain a mapping of source identifiers to the
   corresponding LLVMlite operands. Bindings are added for global OAT variables
   and local variables that are in scope. *)

module Ctxt = struct

  type t = (Ast.id * (Ll.ty * Ll.operand)) list
  let empty = []

  (* Add a binding to the context *)
  let add (c:t) (id:id) (bnd:Ll.ty * Ll.operand) : t = (id,bnd)::c

  (* Lookup a binding in the context *)
  let lookup (id:Ast.id) (c:t) : Ll.ty * Ll.operand =
    List.assoc id c

  (* Lookup a function, fail otherwise *)
  let lookup_function (id:Ast.id) (c:t) : Ll.ty * Ll.operand =
    match List.assoc id c with
    | Ptr (Fun (args, ret)), g -> Ptr (Fun (args, ret)), g
    | _ -> failwith @@ id ^ " not bound to a function"

  let lookup_function_option (id:Ast.id) (c:t) : (Ll.ty * Ll.operand) option =
    try Some (lookup_function id c) with _ -> None

end

(* compiling OAT types ------------------------------------------------------ *)

(* The mapping of source types onto LLVMlite is straightforward. Booleans and ints
   are represented as the corresponding integer types. OAT strings are
   pointers to bytes (I8). Arrays are the most interesting type: they are
   represented as pointers to structs where the first component is the number
   of elements in the following array.

   The trickiest part of this project will be satisfying LLVM's rudimentary type
   system. Recall that global arrays in LLVMlite need to be declared with their
   length in the type to statically allocate the right amount of memory. The
   global strings and arrays you emit will therefore have a more specific type
   annotation than the output of cmp_rty. You will have to carefully bitcast
   gids to satisfy the LLVM type checker.
*)

let rec cmp_ty : Ast.ty -> Ll.ty = function
  | Ast.TBool  -> I1
  | Ast.TInt   -> I64
  | Ast.TRef r -> Ptr (cmp_rty r)

and cmp_rty : Ast.rty -> Ll.ty = function
  | Ast.RString  -> I8
  | Ast.RArray u -> Struct [I64; Array(0, cmp_ty u)]
  | Ast.RFun (ts, t) ->
      let args, ret = cmp_fty (ts, t) in
      Fun (args, ret)

and cmp_ret_ty : Ast.ret_ty -> Ll.ty = function
  | Ast.RetVoid  -> Void
  | Ast.RetVal t -> cmp_ty t

and cmp_fty (ts, r) : Ll.fty =
  List.map cmp_ty ts, cmp_ret_ty r


let typ_of_binop : Ast.binop -> Ast.ty * Ast.ty * Ast.ty = function
  | Add | Mul | Sub | Shl | Shr | Sar | IAnd | IOr -> (TInt, TInt, TInt)
  | Eq | Neq | Lt | Lte | Gt | Gte -> (TInt, TInt, TBool)
  | And | Or -> (TBool, TBool, TBool)

let typ_of_unop : Ast.unop -> Ast.ty * Ast.ty = function
  | Neg | Bitnot -> (TInt, TInt)
  | Lognot       -> (TBool, TBool)

(* Compiler Invariants

   The LLVM IR type of a variable (whether global or local) that stores an Oat
   array value (or any other reference type, like "string") will always be a
   double pointer.  In general, any Oat variable of Oat-type t will be
   represented by an LLVM IR value of type Ptr (cmp_ty t).  So the Oat variable
   x : int will be represented by an LLVM IR value of type i64*, y : string will
   be represented by a value of type i8**, and arr : int[] will be represented
   by a value of type {i64, [0 x i64]}**.  Whether the LLVM IR type is a
   "single" or "double" pointer depends on whether t is a reference type.

   We can think of the compiler as paying careful attention to whether a piece
   of Oat syntax denotes the "value" of an expression or a pointer to the
   "storage space associated with it".  This is the distinction between an
   "expression" and the "left-hand-side" of an assignment statement.  Compiling
   an Oat variable identifier as an expression ("value") does the load, so
   cmp_exp called on an Oat variable of type t returns (code that) generates a
   LLVM IR value of type cmp_ty t.  Compiling an identifier as a left-hand-side
   does not do the load, so cmp_lhs called on an Oat variable of type t returns
   and operand of type (cmp_ty t)*.  Extending these invariants to account for
   array accesses: the assignment e1[e2] = e3; treats e1[e2] as a
   left-hand-side, so we compile it as follows: compile e1 as an expression to
   obtain an array value (which is of pointer of type {i64, [0 x s]}* ).
   compile e2 as an expression to obtain an operand of type i64, generate code
   that uses getelementptr to compute the offset from the array value, which is
   a pointer to the "storage space associated with e1[e2]".

   On the other hand, compiling e1[e2] as an expression (to obtain the value of
   the array), we can simply compile e1[e2] as a left-hand-side and then do the
   load.  So cmp_exp and cmp_lhs are mutually recursive.  [[Actually, as I am
   writing this, I think it could make sense to factor the Oat grammar in this
   way, which would make things clearer, I may do that for next time around.]]


   Consider globals7.oat

   /--------------- globals7.oat ------------------
   global arr = int[] null;

   int foo() {
     var x = new int[3];
     arr = x;
     x[2] = 3;
     return arr[2];
   }
   /------------------------------------------------

   The translation (given by cmp_ty) of the type int[] is {i64, [0 x i64}* so
   the corresponding LLVM IR declaration will look like:

   @arr = global { i64, [0 x i64] }* null

   This means that the type of the LLVM IR identifier @arr is {i64, [0 x i64]}**
   which is consistent with the type of a locally-declared array variable.

   The local variable x would be allocated and initialized by (something like)
   the following code snippet.  Here %_x7 is the LLVM IR uid containing the
   pointer to the "storage space" for the Oat variable x.

   %_x7 = alloca { i64, [0 x i64] }*                              ;; (1)
   %_raw_array5 = call i64*  @oat_alloc_array(i64 3)              ;; (2)
   %_array6 = bitcast i64* %_raw_array5 to { i64, [0 x i64] }*    ;; (3)
   store { i64, [0 x i64]}* %_array6, { i64, [0 x i64] }** %_x7   ;; (4)

   (1) note that alloca uses cmp_ty (int[]) to find the type, so %_x7 has
       the same type as @arr

   (2) @oat_alloc_array allocates len+1 i64's

   (3) we have to bitcast the result of @oat_alloc_array so we can store it
        in %_x7

   (4) stores the resulting array value (itself a pointer) into %_x7

  The assignment arr = x; gets compiled to (something like):

  %_x8 = load { i64, [0 x i64] }*, { i64, [0 x i64] }** %_x7     ;; (5)
  store {i64, [0 x i64] }* %_x8, { i64, [0 x i64] }** @arr       ;; (6)

  (5) load the array value (a pointer) that is stored in the address pointed
      to by %_x7

  (6) store the array value (a pointer) into @arr

  The assignment x[2] = 3; gets compiled to (something like):

  %_x9 = load { i64, [0 x i64] }*, { i64, [0 x i64] }** %_x7      ;; (7)
  %_index_ptr11 = getelementptr { i64, [0 x  i64] },
                  { i64, [0 x i64] }* %_x9, i32 0, i32 1, i32 2   ;; (8)
  store i64 3, i64* %_index_ptr11                                 ;; (9)

  (7) as above, load the array value that is stored %_x7

  (8) calculate the offset from the array using GEP

  (9) store 3 into the array

  Finally, return arr[2]; gets compiled to (something like) the following.
  Note that the way arr is treated is identical to x.  (Once we set up the
  translation, there is no difference between Oat globals and locals, except
  how their storage space is initially allocated.)

  %_arr12 = load { i64, [0 x i64] }*, { i64, [0 x i64] }** @arr    ;; (10)
  %_index_ptr14 = getelementptr { i64, [0 x i64] },
                 { i64, [0 x i64] }* %_arr12, i32 0, i32 1, i32 2  ;; (11)
  %_index15 = load i64, i64* %_index_ptr14                         ;; (12)
  ret i64 %_index15

  (10) just like for %_x9, load the array value that is stored in @arr

  (11)  calculate the array index offset

  (12) load the array value at the index

*)

(* Global initialized arrays:

  There is another wrinkle: To compile global initialized arrays like in the
  globals4.oat, it is helpful to do a bitcast once at the global scope to
  convert the "precise type" required by the LLVM initializer to the actual
  translation type (which sets the array length to 0).  So for globals4.oat,
  the arr global would compile to (something like):

  @arr = global { i64, [0 x i64] }* bitcast
           ({ i64, [4 x i64] }* @_global_arr5 to { i64, [0 x i64] }* )
  @_global_arr5 = global { i64, [4 x i64] }
                  { i64 4, [4 x i64] [ i64 1, i64 2, i64 3, i64 4 ] }

*)



(* Some useful helper functions *)

(* Generate a fresh temporary identifier. Since OAT identifiers cannot begin
   with an underscore, these should not clash with any source variables *)
let gensym : string -> string =
  let c = ref 0 in
  fun (s:string) -> incr c; Printf.sprintf "_%s%d" s (!c)

(* Amount of space an Oat type takes when stored in the satck, in bytes.
   Note that since structured values are manipulated by reference, all
   Oat values take 8 bytes on the stack.
*)
let size_oat_ty (t : Ast.ty) = 8L

(* Generate code to allocate a zero-initialized array of source type TRef (RArray t) of the
   given size. Note "size" is an operand whose value can be computed at
   runtime *)
let oat_alloc_array (t:Ast.ty) (size:Ll.operand) : Ll.ty * operand * stream =
  let ans_id, arr_id = gensym "array", gensym "raw_array" in
  let ans_ty = cmp_ty @@ TRef (RArray t) in
  let arr_ty = Ptr I64 in
  ans_ty, Id ans_id, lift
    [ arr_id, Call(arr_ty, Gid "oat_alloc_array", [I64, size])
    ; ans_id, Bitcast(arr_ty, Id arr_id, ans_ty) ]

(* Compiles an expression exp in context c, outputting the Ll operand that will
   recieve the value of the expression, and the stream of instructions
   implementing the expression.

   Tips:
   - use the provided cmp_ty function!

   - string literals (CStr s) should be hoisted. You'll need to make sure
     either that the resulting gid has type (Ptr I8), or, if the gid has type
     [n x i8] (where n is the length of the string), convert the gid to a
     (Ptr I8), e.g., by using getelementptr.

   - use the provided "oat_alloc_array" function to implement literal arrays
     (CArr) and the (NewArr) expressions

*)

let cmp_bop (bop:Ast.binop) (op1:Ll.operand) (op2:Ll.operand) : (Ll.insn) = 

  match bop with
  | Add -> Binop(Ll.Add, Ll.I64, op1, op2)
  | Sub -> Binop(Ll.Sub, Ll.I64, op1, op2)
  | Mul -> Binop(Ll.Mul, Ll.I64, op1, op2)
  | IAnd -> Binop(Ll.And, Ll.I64, op1, op2)
  | IOr -> Binop(Ll.Or, Ll.I64, op1, op2)
  | Shl -> Binop(Ll.Shl, Ll.I64, op1, op2)
  | Shr -> Binop(Ll.Lshr, Ll.I64, op1, op2)
  | Sar -> Binop(Ll.Ashr, Ll.I64, op1, op2)

  | Eq -> Icmp(Ll.Eq, Ll.I64, op1, op2)
  | Neq -> Icmp(Ll.Ne, Ll.I64, op1, op2)
  | Lt -> Icmp(Ll.Slt, Ll.I64, op1, op2)
  | Lte -> Icmp(Ll.Sle, Ll.I64, op1, op2)
  | Gt -> Icmp(Ll.Sgt, Ll.I64, op1, op2)
  | Gte -> Icmp(Ll.Sge, Ll.I64, op1, op2)
  
  | And -> Binop(Ll.And, Ll.I1, op1, op2)
  | Or -> Binop(Ll.Or, Ll.I1, op1, op2)


let rec cmp_exp (c:Ctxt.t) (exp:Ast.exp node) : Ll.ty * Ll.operand * stream =
  
  begin match exp.elt with 
  | CInt i -> (Ll.I64, Ll.Const i, [])
  | CNull x -> (Ptr (cmp_rty x), Ll.Null, []) (*what type*)
  | CBool b -> (Ll.I1, Ll.Const (if b then 1L else 0L), [])
  | Bop (bop, exp1, exp2) ->
    let ans = gensym "ans" in
    let _, op1, stream1 = cmp_exp c exp1 in 
    let _, op2, stream2 = cmp_exp c exp2 in
    let _, _, ty = typ_of_binop bop in
    let ins = cmp_bop bop op1 op2 in
    (cmp_ty ty, Ll.Id ans, stream1>@stream2>::I(ans ,ins))
  | Uop (uop, exp) -> 
    let _, op, stream = cmp_exp c exp in
    let _, ty = typ_of_unop uop in
    let ans = gensym "ans" in
    let ins = match uop with 
      | Neg -> Binop(Ll.Sub, Ll.I64, Ll.Const 0L, op)     
      | Lognot -> Binop(Ll.Xor, Ll.I1, Ll.Const 1L, op)
      | Bitnot -> Binop(Ll.Xor, Ll.I64, Ll.Const Int64.minus_one, op)
    in
    (cmp_ty ty, Ll.Id ans, stream>::I(ans, ins))
  | Id i -> 
    let pty, op = Ctxt.lookup i c in
    begin match pty with
      | Ptr (Fun (_, y)) ->
        (y, Ll.Gid i, [])
      | Ptr x -> 
        let ty = x in
        let ans = gensym "ans" in
        let ins = I (ans, Ll.Load (pty, op)) in
        (ty, Ll.Id ans, ins::[])
      | _ -> failwith "Id wasnt pointer"
    end
  | Call (id, args) ->     
      let id_ty, id_op, id_stream = cmp_exp c id in
      (* types of our call parameters*)
      let tyopl, args_stream = List.fold_left
        (fun (tyopl, argl) expr -> 
          let ty, op, s = cmp_exp c expr in
          
          tyopl@[(ty,op)], argl>@s 
        ) 
        ([], []) args in
      (* maybe cast*)
      (*get call arguments types*)
      let ans = gensym "ans" in
      let callins = I(ans ,Call (id_ty, id_op, tyopl)) in

      (id_ty, Ll.Id ans, args_stream>@[callins])

  | NewArr (ty, len) ->
    let _, len_op, len_stream = cmp_exp c len in
    let arr_ty, arr_op, arr_stream = oat_alloc_array ty len_op in
    (arr_ty, arr_op, len_stream>@arr_stream)

  | Index (arr, index) -> 
    let arr_ty, arr_op, arrs = cmp_exp c arr in
    let i_ty, i_op, is = cmp_exp c index in
    let ans = gensym "ans" in
    let gep = gensym "gepptr" in
    let gepins = I (gep, Gep (arr_ty, arr_op, [Ll.Const 0L; Ll.Const 1L; i_op])) in
    let ans_ty = match arr_ty with
      | Ptr (Struct [_; Ll.Array (_, x)]) -> x
      | _ -> failwith "impossible"
    in
    let loadins = I (ans, Load ( Ptr ans_ty,Ll.Id gep)) in

    (* arr_ty = { i64, [0 x i64] }*)

    (ans_ty, Ll.Id ans, arrs>@is>@[gepins]>@[loadins])

  | CArr (ty, exp_list) -> 
    let len = List.length exp_list in
    let arr_ty, arr_op, arr_stream = oat_alloc_array ty (Ll.Const (Int64.of_int len)) in

    let fold_helper (i, stream_list) expr = 
      let ans = gensym "ans" in
      let gepins = I (ans, Gep (arr_ty, arr_op, [Ll.Const 0L; Ll.Const 1L; Ll.Const (Int64.of_int i)])) in

      let ty, op, exps = cmp_exp c expr in
      let storeins = I ("", Store (ty, op, Ll.Id ans)) in
      (i + 1, stream_list>@[gepins]>@exps>@[storeins])

    in

    let _, exp_stream = List.fold_left fold_helper (0, []) exp_list in
    (arr_ty, arr_op, arr_stream>@exp_stream)
(* Compiles an expression exp in context c, outputting the Ll operand that will
   recieve the value of the expression, and the stream of instructions
   implementing the expression.

   Tips:
   - use the provided cmp_ty function!

   - string literals (CStr s) should be hoisted. You'll need to make sure
     either that the resulting gid has type (Ptr I8), or, if the gid has type
     [n x i8] (where n is the length of the string), convert the gid to a
     (Ptr I8), e.g., by using getelementptr.

   - use the provided "oat_alloc_array" function to implement literal arrays
     (CArr) and the (NewArr) expressions
*)

  | CStr s -> 
    let gs = gensym "lstring" in
    let len = String.length s + 1 in
    let arty = (Array (len, I8)) in
    let gdel = (arty, GString s) in
    let ans = gensym "ans" in
    let gep = I (ans, Gep (Ptr arty, Ll.Gid gs, [Const 0L;Const 0L])) in

    let gins = G (gs, gdel) in   
    (Ptr I8, Ll.Id ans, [gins]>::gep)
  end

 (*
| Call of exp node * exp node list -> maybe cast
*) 

(* Compile a statement in context c with return typ rt. Return a new context,
   possibly extended with new local bindings, and the instruction stream
   implementing the statement.

   Left-hand-sides of assignment statements must either be OAT identifiers,
   or an index into some arbitrary expression of array type. Otherwise, the
   program is not well-formed and your compiler may throw an error.

   Tips:
   - for local variable declarations, you will need to emit Allocas in the
     entry block of the current function using the E() constructor.

   - don't forget to add a bindings to the context for local variable
     declarations

   - you can avoid some work by translating For loops to the corresponding
     While loop, building the AST and recursively calling cmp_stmt

   - you might find it helpful to reuse the code you wrote for the Call
     expression to implement the SCall statement

   - compiling the left-hand-side of an assignment is almost exactly like
     compiling the Id or Index expression. Instead of loading the resulting
     pointer, you just need to store to it!

 *)
let cmp_lhs (c:Ctxt.t) (lhs:Ast.exp node) : Ll.ty * Ll.operand * stream = 
  match lhs.elt with
  | Id i ->
    let pty, op = Ctxt.lookup i c in
    (pty, op, [])
  | Index (arr, index) -> 
    let arr_ty, arr_op, arrs = cmp_exp c arr in
    let i_ty, i_op, is = cmp_exp c index in
    let gep = gensym "gepptr" in
    let gepins = I (gep, Gep (arr_ty, arr_op, [Ll.Const 0L; Ll.Const 1L; i_op])) in
    let ans_ty = match arr_ty with
        | Ptr (Struct [_; Ll.Array (_, x)]) -> x
        | _ -> failwith "impossible"
    in
    (Ptr ans_ty, Ll.Id gep, arrs>@is>@[gepins])
  | _ -> failwith "invalid lhs"

let rec cmp_stmt (c:Ctxt.t) (rt:Ll.ty) (stmt:Ast.stmt node) : Ctxt.t * stream = 
  begin match stmt.elt with
    | Ret None -> (c, [ T (Ll.Ret (rt, None)) ])
    | Ret (Some x) -> 
      let ty, op, stream = cmp_exp c x in
      let enda = T (Ll.Ret (ty, Some op)) in
      (c, stream>::enda)
    | Assn (lhs, exp) ->
      let _, op1, stream1 = cmp_lhs c lhs in
      let ty2, op2, stream2 = cmp_exp c exp in 
      let ins = I ("", Store(ty2, op2, op1)) in
      (c, stream1>@stream2>::ins)
    | Decl (id, exp) ->
      let ty, op, stream = cmp_exp c exp in
      let ans = gensym "ans" in
      let new_c = Ctxt.add c id (Ptr ty, Ll.Id ans) in
      let all = E (ans, Alloca ty) in
      let s = I ("", Store(ty, op, Ll.Id ans)) in
      (new_c, stream>::all>::s)
    | While (cond, body) ->
      let ty, op, stream = cmp_exp c cond in 

      let lpre = gensym "pre" in
      let lbody = gensym "body" in
      let lpost = gensym "post" in
      let _, block = cmp_block c rt body in
      let cnd = gensym "cnd" in
      let compare = I (cnd, Icmp(Ll.Eq, ty, op, Ll.Const 0L)) in

      let l1 = L lpre in
      let l2 = L lbody in
      let l3 = L lpost in

      let br1 = T (Cbr (Ll.Id cnd, lpost, lbody)) in
      let br2 = T (Br lpre) in
      
      (c, [br2]>@[l1]>@stream>@[compare]>@[br1]>@[l2]>@block>@[br2]>@[l3])

    | If (cond, block1, block2) -> 
      let ty, op, stream = cmp_exp c cond in 
      let cnd = gensym "cnd" in
      let compare = I (cnd, Icmp(Ll.Eq, ty, op, Ll.Const 0L)) in
      let lthen = gensym "then" in
      let lelse = gensym "else" in
      let lmerge = gensym "merge" in
      let _, thenblock = cmp_block c rt block1 in
      let _, elseblock = cmp_block c rt block2 in

      let condbr = T (Cbr( Ll.Id cnd, lelse, lthen)) in
      let mergebr = T (Br lmerge) in
      
      (c, stream>@[compare]>@[condbr]>@[(L lthen)]>@thenblock>@[mergebr]>@[(L lelse)]>@elseblock>@[mergebr]>@[(L lmerge)])

    | For (vdecls, cond, stmt_opt, body) -> 

      let vdecls_stmt = List.map (fun x -> no_loc (Decl x)) vdecls in
      let c_new, v_stream = cmp_block c Void vdecls_stmt in

      let ty, op, expr_stream = match cond with 
      | Some x -> cmp_exp c_new x 
      (*if None then true*)
      | None -> (I1, Ll.Const 0L, [])
      in

      let _, bodys = cmp_block c_new rt body in
      
      let stmts = match stmt_opt with
      | Some x -> 
          let _, stmtstream = cmp_stmt c_new rt x in
          (stmtstream)
      | None -> []
      in

      let cnd = gensym "cnd" in
      let compare = I (cnd, Icmp(Ll.Eq, ty, op, Ll.Const 0L)) in

      let lpre = gensym "pre" in
      let lbody = gensym "body" in
      let lpost = gensym "lpost" in

      let brpre = T (Br lpre) in
      let condbr = T (Cbr( Ll.Id cnd, lpost, lbody)) in

      (c, v_stream >@ [brpre] >@ [L lpre] >@expr_stream >@ [compare] >@ [condbr] >@ [L lbody] >@ bodys >@ stmts >@ [brpre] >@ [L lpost] ) 

    | SCall (id, args) ->
      let id_ty, id_op, id_stream = cmp_exp c id in
      (* types of our call parameters*)
      let tyopl, args_stream = List.fold_left
        (fun (tyopl, argl) expr -> 
          let ty, op, s = cmp_exp c expr in
          tyopl@[(ty,op)], argl>@s 
        ) 
        ([], []) args in
      (* maybe cast*)
      (*get call arguments types*)

      let callins = I("" ,Call (id_ty, id_op, tyopl)) in
      (c, args_stream>@[callins])
      
  end

(*
  not done yet
  | SCall of exp node * exp node list
*)
  

(* Compile a series of statements *)
and cmp_block (c:Ctxt.t) (rt:Ll.ty) (stmts:Ast.block) : Ctxt.t * stream =
  List.fold_left (fun (c, code) s ->
      let c, stmt_code = cmp_stmt c rt s in
      c, code >@ stmt_code
    ) (c,[]) stmts



(* Adds each function identifer to the context at an
   appropriately translated type.

   NOTE: The Gid of a function is just its source name
*)
let cmp_function_ctxt (c:Ctxt.t) (p:Ast.prog) : Ctxt.t =
    List.fold_left (fun c -> function
      | Ast.Gfdecl { elt={ frtyp; fname; args } } ->
         let ft = TRef (RFun (List.map fst args, frtyp)) in
         Ctxt.add c fname (cmp_ty ft, Gid fname)
      | _ -> c
    ) c p

(* Populate a context with bindings for global variables
   mapping OAT identifiers to LLVMlite gids and their types.

   Only a small subset of OAT expressions can be used as global initializers
   in well-formed programs. (The constructors starting with C).
*)
let cmp_global_ctxt (c:Ctxt.t) (p:Ast.prog) : Ctxt.t =
  List.fold_left (fun c -> function
  | Ast.Gvdecl {elt = {name; init}} ->
    let ty = match init.elt with
    | CNull rt -> Ptr (cmp_rty rt)
    | CBool _ -> I1
    | CInt _ -> I64
    | CStr _ -> Ptr I8
    | CArr (ty, _) -> Ptr (Struct [I64; Array(0, cmp_ty ty)])
    | _ -> failwith "not global type"  
    in

    Ctxt.add c name (Ptr ty, (Ll.Gid name))

  | _ -> c
  ) c p




let cmp_fdecl (c:Ctxt.t) (f:Ast.fdecl node) : Ll.fdecl * (Ll.gid * Ll.gdecl) list =
  let elt = f.elt in

  let frtyp = elt.frtyp in
  let args = List.rev elt.args in
  let body = elt.body in

  let new_c, ins_l, ty_l, uid_l = List.fold_left (
    fun (c,ins_l, ty_l, uid_l) (a, b) ->

      let uid = gensym b^"_alloc" in
      let ll_ty = cmp_ty a in
      let new_c = Ctxt.add c b (Ptr ll_ty, Ll.Id uid) in
      (*Ll.id uid is a pointer*)
      let allo = E (uid, Alloca ( ll_ty )) in
      let store = I (gensym "store", Store (ll_ty, Ll.Id b, Ll.Id uid)) in

      new_c, ins_l>::allo>::store, ty_l>::ll_ty, uid_l>::b
    )
    (c,[], [],  []) args in

  let ll_retty = cmp_ret_ty frtyp in

  let final_ins = if (ll_retty = Void) then [] else
    let ret_uid = gensym "ret_hate" in 
    let ret_stupid_alloca = E (ret_uid, Alloca ll_retty) in
    let ret_loaded = gensym "lock_and_loaded" in
    let ret_load = I(ret_loaded, Load (Ptr ll_retty, Ll.Id ret_uid)) in
    let final_return = T(Ret (ll_retty, Some (Ll.Id ret_loaded))) in
    [ret_stupid_alloca]>:: ret_load>:: final_return
  in
  let newc, block = cmp_block new_c ll_retty body in
  let stream = (ins_l >@ block) in
  let cfg, glist = cfg_of_stream stream in
  let fdcl : Ll.fdecl = {f_cfg = cfg; f_param = uid_l; f_ty = (ty_l, ll_retty)} in
  fdcl, glist




(* Compile a global initializer, returning the resulting LLVMlite global
   declaration, and a list of additional global declarations.

   Tips:
   - Only CNull, CBool, CInt, CStr, and CArr can appear as global initializers
     in well-formed OAT programs. Your compiler may throw an error for the other
     cases

   - OAT arrays are always handled via pointers. A global array of arrays will
     be an array of pointers to arrays emitted as additional global declarations.
*)
(*       @arr      [@_global_arr5 ]*)



let rec cmp_gexp c (e:Ast.exp node) : Ll.gdecl * (Ll.gid * Ll.gdecl) list =
  match e.elt with
  | CNull rt -> (Ll.Ptr (cmp_rty rt), GNull), []
  | CBool b -> (Ll.I1, GInt (if b then 1L else 0L)), []
  | CInt i -> (Ll.I64 , GInt i), [] 
  | CStr s ->
    let ls = gensym "gstring" in
    let len = String.length s + 1 in
    let gdel = (Array (len, I8), GString s) in

    let s_ptr = Ptr I8 in
     (s_ptr, GBitcast (Ptr (Array (len, I8)), GGid ls, s_ptr)) , [(ls, gdel)]

  | CArr (ty, exp_list) -> 
    let lglobal = gensym "garray" in
    let len = List.length exp_list in
    let array_ty = Struct [Ll.I64; Array(len , cmp_ty ty)] in
    let array_ty_ptr = Ptr (array_ty) in
    let array_ty_to_ptr = Ptr (Struct [Ll.I64; Array(0 , cmp_ty ty)]) in

    let fold_helper (gl, rl) exp =
      let gd, gidd_l = cmp_gexp c exp in
      [gd]>@gl, rl>@gidd_l
    in
    let gdecl_list, rest_list = List.fold_left fold_helper ([], []) exp_list in

    let llgdecl = (array_ty, GStruct [ (I64, (GInt (Int64.of_int len))) ; ( Array(len, cmp_ty ty) , GArray gdecl_list)] ) in
    let garr = (lglobal, llgdecl) in 
    
(*
    This expression has type Ll.operand * (Ll.ty * Ll.ginit)
       but an expression was expected of type Ll.gid * Ll.gdecl
       Type Ll.operand is not compatible with type Ll.gid = string*) 
    (array_ty_to_ptr, GBitcast (array_ty_ptr, GGid lglobal, array_ty_to_ptr)), garr::rest_list
    
  | _ -> failwith "not global type"
(* Oat internals function context ------------------------------------------- *)
let internals = [
    "oat_alloc_array",         Ll.Fun ([I64], Ptr I64)
  ]

(* Oat builtin function context --------------------------------------------- *)
let builtins =
  [ "array_of_string",  cmp_rty @@ RFun ([TRef RString], RetVal (TRef(RArray TInt)))
  ; "string_of_array",  cmp_rty @@ RFun ([TRef(RArray TInt)], RetVal (TRef RString))
  ; "length_of_string", cmp_rty @@ RFun ([TRef RString],  RetVal TInt)
  ; "string_of_int",    cmp_rty @@ RFun ([TInt],  RetVal (TRef RString))
  ; "string_cat",       cmp_rty @@ RFun ([TRef RString; TRef RString], RetVal (TRef RString))
  ; "print_string",     cmp_rty @@ RFun ([TRef RString],  RetVoid)
  ; "print_int",        cmp_rty @@ RFun ([TInt],  RetVoid)
  ; "print_bool",       cmp_rty @@ RFun ([TBool], RetVoid)
  ]

(* Compile a OAT program to LLVMlite *)
let cmp_prog (p:Ast.prog) : Ll.prog =
  (* add built-in functions to context *)
  let init_ctxt =
    List.fold_left (fun c (i, t) -> Ctxt.add c i (Ll.Ptr t, Gid i))
      Ctxt.empty builtins
  in
  let fc = cmp_function_ctxt init_ctxt p in

  (* build global variable context *)
  let c = cmp_global_ctxt fc p in

  (* compile functions and global variables *)
  let fdecls, gdecls =
    List.fold_right (fun d (fs, gs) ->
        match d with
        | Ast.Gvdecl { elt=gd } ->
           let ll_gd, gs' = cmp_gexp c gd.init in
           (fs, (gd.name, ll_gd)::gs' @ gs)
        | Ast.Gfdecl fd ->
           let fdecl, gs' = cmp_fdecl c fd in
           (fd.elt.fname,fdecl)::fs, gs' @ gs
      ) p ([], [])
  in

  (* gather external declarations *)
  let edecls = internals @ builtins in
  { tdecls = []; gdecls; fdecls; edecls }
