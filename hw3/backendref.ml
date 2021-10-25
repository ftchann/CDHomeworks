(* ll ir compilation -------------------------------------------------------- *)

open Ll
open X86

(* Overview ----------------------------------------------------------------- *)

(* We suggest that you spend some time understanding this entire file and
   how it fits with the compiler pipeline before making changes.  The suggested
   plan for implementing the compiler is provided on the project web page.
*)


(* helpers ------------------------------------------------------------------ *)

(* Map LL comparison operations to X86 condition codes *)
let compile_cnd = function
  | Ll.Eq  -> X86.Eq
  | Ll.Ne  -> X86.Neq
  | Ll.Slt -> X86.Lt
  | Ll.Sle -> X86.Le
  | Ll.Sgt -> X86.Gt
  | Ll.Sge -> X86.Ge



(* locals and layout -------------------------------------------------------- *)

(* One key problem in compiling the LLVM IR is how to map its local
   identifiers to X86 abstractions.  For the best performance, one
   would want to use an X86 register for each LLVM %uid.  However,
   since there are an unlimited number of %uids and only 16 registers,
   doing so effectively is quite difficult.  We will see later in the
   course how _register allocation_ algorithms can do a good job at
   this.

   A simpler, but less performant, implementation is to map each %uid
   in the LLVM source to a _stack slot_ (i.e. a region of memory in
   the stack).  Since LLVMlite, unlike real LLVM, permits %uid locals
   to store only 64-bit data, each stack slot is an 8-byte value.

   [ NOTE: For compiling LLVMlite, even i1 data values should be
   represented as a 8-byte quad. This greatly simplifies code
   generation. ]

   We call the datastructure that maps each %uid to its stack slot a
   'stack layout'.  A stack layout maps a uid to an X86 operand for
   accessing its contents.  For this compilation strategy, the operand
   is always an offset from %rbp (in bytes) that represents a storage slot in
   the stack.
*)

type layout = (uid, X86.operand) Hashtbl.t (*(uid * X86.operand) list*)

(* A context contains the global type declarations (needed for getelementptr
   calculations) and a stack layout. *)
type ctxt = { tdecls : (tid * ty) list
            ; layout : layout
            ; mutable instack : uid list
            }

(* useful for looking up items in tdecls or layouts *)
let lookup m x = List.assoc x m

let get_uid lay uid = match (Hashtbl.find_opt lay uid) with Some a -> a | None -> failwith @@ uid ^ " not found"
let add_uid lay uid = if Hashtbl.mem lay uid then failwith "Redefinition" else Hashtbl.add lay uid

(* compiling operands  ------------------------------------------------------ *)

(* LLVM IR instructions support several kinds of operands.

   LL local %uids live in stack slots, whereas global ids live at
   global addresses that must be computed from a label.  Constants are
   immediately available, and the operand Null is the 64-bit 0 value.

     NOTE: two important facts about global identifiers:

     (1) You should use (Platform.mangle gid) to obtain a string
     suitable for naming a global label on your platform (OS X expects
     "_main" while linux expects "main").

     (2) 64-bit assembly labels are not allowed as immediate operands.
     That is, the X86 code: movq _gid %rax which looks like it should
     put the address denoted by _gid into %rax is not allowed.
     Instead, you need to compute an %rip-relative address using the
     leaq instruction:   leaq _gid(%rip).

   One strategy for compiling instruction operands is to use a
   designated register (or registers) for holding the values being
   manipulated by the LLVM IR instruction. You might find it useful to
   implement the following helper function, whose job is to generate
   the X86 instruction that moves an LLVM operand into a designated
   destination (usually a register).
*)
let compile_operand (ctxt:ctxt) (dest:X86.operand) (op:Ll.operand) : ins = 
  match op with 
    | Null -> Asm.(Movq, [~$0; dest])
    | Const c -> Asm.(Movq, [Imm (Lit c); dest])
    | Gid g -> Asm.(Leaq, [Ind3 (Lbl (Platform.mangle g), Rip); dest])
    | Id i -> Asm.(Movq, [get_uid ctxt.layout i; dest])

(* compiling call  ---------------------------------------------------------- *)

(* You will probably find it helpful to implement a helper function that
   generates code for the LLVM IR call instruction.

   The code you generate should follow the x64 System V AMD64 ABI
   calling conventions, which places the first six 64-bit (or smaller)
   values in registers and pushes the rest onto the stack.  Note that,
   since all LLVM IR operands are 64-bit values, the first six
   operands will always be placed in registers.  (See the notes about
   compiling fdecl below.)

   [ NOTE: It is the caller's responsibility to clean up arguments
   pushed onto the stack, so you must free the stack space after the
   call returns. ]

   [ NOTE: Don't forget to preserve caller-save registers (only if
   needed). ]
*)

(* compiling getelementptr (gep)  ------------------------------------------- *)

(* The getelementptr instruction computes an address by indexing into
   a datastructure, following a path of offsets.  It computes the
   address based on the size of the data, which is dictated by the
   data's type.

   To compile getelementptr, you must generate x86 code that performs
   the appropriate arithmetic calculations.
*)

(* [size_ty] maps an LLVMlite type to a size in bytes.
    (needed for getelementptr)

   - the size of a struct is the sum of the sizes of each component
   - the size of an array of t's with n elements is n * the size of t
   - all pointers, I1, and I64 are 8 bytes
   - the size of a named type is the size of its definition

   - Void, i8, and functions have undefined sizes according to LLVMlite.
     Your function should simply return 0 in those cases
*)
let rec size_ty (tdecls:(tid * ty) list) (t:Ll.ty) : int =
  match t with
    | Array (n, t) -> n * (size_ty tdecls t)
    | Struct t -> List.fold_left (+) 0 (List.map (size_ty tdecls) t)
    | Namedt t -> size_ty tdecls (lookup tdecls t)
    | I1 | I64 | Ptr _ -> 8
    | Void | I8 | Fun _ -> 0

(* Generates code that computes a pointer value.

   1. op must be of pointer type: t*

   2. the value of op is the base address of the calculation

   3. the first index in the path is treated as the index into an array
     of elements of type t located at the base address

   4. subsequent indices are interpreted according to the type t:

     - if t is a struct, the index must be a constant n and it
       picks out the n'th element of the struct. [ NOTE: the offset
       within the struct of the n'th element is determined by the
       sizes of the types of the previous elements ]

     - if t is an array, the index can be any operand, and its
       value determines the offset within the array.

     - if t is any other type, the path is invalid

   5. if the index is valid, the remainder of the path is computed as
      in (4), but relative to the type f the sub-element picked out
      by the path so far
*)
let compile_gep (ctxt:ctxt) (dest:X86.operand) (op : Ll.ty * Ll.operand) (path: Ll.operand list) : ins list =
  let tmp1 = Asm.(~%Rax) in
  let tmp2 = Asm.(~%Rcx) in
  let basetype = match op with (Ptr t, o) -> t in
  let baseo = match op with (t, o) -> o in

  let get_base_addr = (compile_operand ctxt tmp1 baseo) in
  let rec add_sizes n tlist = 
    match n with
      | 0 -> 0
      | x -> match tlist with h::tl -> ((size_ty ctxt.tdecls h) + (add_sizes (n-1) tl)) | [] -> failwith "gep"
  in
    
  let add_offset ((last_type:Ll.ty), (insns:ins list)) (o:Ll.operand) : Ll.ty * ins list = 
    let get_type t = match t with Namedt t -> (lookup ctxt.tdecls t) | _ -> t in
    match (get_type last_type) with 
      | Struct tlist -> let n = match o with Const c -> (Int64.to_int c) in 
                        let off = add_sizes n tlist in
                        (List.nth tlist n, insns@Asm.[Addq, [~$off; tmp1]])
      | Array (n, t) -> (t, insns@[compile_operand ctxt tmp2 o]@Asm.[Imulq, [~$(size_ty ctxt.tdecls t); tmp2]; Addq, [tmp2; tmp1]])
      | _ -> (Void, insns)
  in
  [get_base_addr]@(match (List.fold_left add_offset (Array (0, basetype), []) path) with (t, i) -> i)@[Movq, [tmp1; dest]]

(* This helper function computes the location of the nth incoming
   function argument: either in a register or relative to %rbp,
   according to the calling conventions.  You might find it useful for
   compile_fdecl.

   [ NOTE: the first six arguments are numbered 0 .. 5 ]
*)
let arg_loc (n : int) : operand =
  match n with 
    | 0 -> Reg Rdi
    | 1 -> Reg Rsi
    | 2 -> Reg Rdx
    | 3 -> Reg Rcx
    | 4 -> Reg R08
    | 5 -> Reg R09
    | x -> Ind3 (Lit (Int64.of_int (((x-6)+2)*8)), Rbp)

(* compiling instructions  -------------------------------------------------- *)

(* The result of compiling a single LLVM instruction might be many x86
   instructions.  We have not determined the structure of this code
   for you. Some of the instructions require only a couple of assembly
   instructions, while others require more.  We have suggested that
   you need at least compile_operand, compile_call, and compile_gep
   helpers; you may introduce more as you see fit.

   Here are a few notes:

   - Icmp:  the Setb instruction may be of use.  Depending on how you
     compile Cbr, you may want to ensure that the value produced by
     Icmp is exactly 0 or 1.

   - Load & Store: these need to dereference the pointers. Const and
     Null operands aren't valid pointers.  Don't forget to
     Platform.mangle the global identifier.

   - Alloca: needs to return a pointer into the stack

   - Bitcast: does nothing interesting at the assembly level
*)

let get_stack_size (ctxt:ctxt) : int = 
  let get_max key (o:X86.operand)  i2  = 
    match o with 
      | (Ind3 (Lit i1, _)) -> if Int64.compare i1 i2 < 0 then i1 else i2
      | _ -> i2
  in
  -(Int64.to_int (Hashtbl.fold get_max ctxt.layout 0L))

let compile_insn (ctxt:ctxt) (fn:string) ((uid:uid), (i:Ll.insn)) : X86.ins list =
  let tmp1 = Asm.(~%Rax) in
  let tmp2 = Asm.(~%Rcx) in
  let stack_size = get_stack_size ctxt in
  let dest = get_uid ctxt.layout uid in
  (* Printf.printf "uid: %s, operand: %s\n" uid @@ X86.string_of_operand dest; *)
  let reverse_tail params = 
    let rec reverse_tail_rec params params_new i =
      match params with 
        | h::tl -> if i < 6 then (reverse_tail_rec tl (params_new@[h]) (i+1))
                   else params_new@(List.rev params) 
        | [] -> params_new
    in reverse_tail_rec params [] 0
  in
  let setup_param i op = 
    match i with
      | x when x < 6 -> [compile_operand ctxt (arg_loc i) (match op with (_, op) -> op)] 
      | x -> [compile_operand ctxt (tmp1) (match op with (_, op) -> op)]@[Pushq, [tmp1]]
  in
  match i with 
   | Binop (bo, t, op1, op2) -> [ compile_operand ctxt tmp1 op1
                                  ; compile_operand ctxt tmp2 op2] @ 
                                  begin match bo with
                                   | Add -> [Addq, [tmp1; tmp2] ; Movq, [tmp2; dest]]
                                   | Sub -> [Subq, [tmp2; tmp1] ; Movq, [tmp1; dest]]
                                   | Mul -> [Imulq, [tmp1; tmp2] ; Movq, [tmp2; dest]]
                                   | Shl -> [Shlq, [tmp2; tmp1] ; Movq, [tmp1; dest]]
                                   | Lshr -> [Shrq, [tmp2; tmp1]; Movq, [tmp1; dest]]
                                   | Ashr -> [Sarq, [tmp2; tmp1]; Movq, [tmp1; dest]]
                                   | And -> [Andq, [tmp1; tmp2]; Movq, [tmp2; dest]]
                                   | Or -> [Orq, [tmp1; tmp2]; Movq, [tmp2; dest]]
                                   | Xor -> [Xorq, [tmp1; tmp2]; Movq, [tmp2; dest]]
                                  end 
   | Icmp (c, t, op1, op2) ->  [ compile_operand ctxt tmp1 op1
                                  ; compile_operand ctxt tmp2 op2
                                  ; Cmpq, [tmp2; tmp1] ; Movq, [Asm.(~$0); tmp1]] @

                                  (* Set by dault to true, if condition holds, then skip one instruction
                                     which would set it to 0, if not, execute normally *)

                                  begin match c with
                                    | Eq -> [Set Eq, [tmp1]]
                                    | Ne -> [Set Neq, [tmp1]]
                                    | Slt -> [Set Lt, [tmp1]]
                                    | Sle -> [Set Le, [tmp1]]
                                    | Sgt -> [Set Gt, [tmp1]]
                                    | Sge -> [Set Ge, [tmp1]]
                                  end
                                  @ [Movq, [tmp1; dest]] 
   | Alloca t -> if (List.mem uid ctxt.instack) then () else ctxt.instack<-ctxt.instack@[uid] ; [] (* let size = size_ty ctxt.tdecls t in ; [] *)

   | Load (t, o) -> begin match o with 
                      | Gid g -> [compile_operand ctxt tmp1 o]@Asm.[Movq, [Ind2 Rax; tmp1] ; Movq, [tmp1; dest]] (* Get from mem *)
                      | Id i -> if List.mem i ctxt.instack then 
                                [compile_operand ctxt tmp1 o]@Asm.[Movq, [tmp1; dest]]
                                else 
                                  [compile_operand ctxt tmp1 o]@[Movq, [Ind2 Rax; tmp1] ; Movq, [tmp1; dest]] 
                      | _ -> failwith "load error"
                    end
   | Store (t, o1, o2) -> begin match t with
                            | I1 | I8 | I64 -> [compile_operand ctxt tmp1 o1] (* o1 is value *)
                            | _ -> begin match o1 with 
                                    | Gid g -> [compile_operand ctxt tmp1 o1] (* o1 is pointer *)
                                    | Id i -> [Leaq, [get_uid ctxt.layout i; tmp1]]
                                    | _ -> failwith "store error"
                                    end
                          end
                          @
                          begin match o2 with
                            | Gid g -> [compile_operand ctxt tmp2 o2]@[Movq, [tmp1; Ind2 Rcx]]                            
                            | Id i -> if List.mem i ctxt.instack then
                                        Asm.[Movq, [tmp1; get_uid ctxt.layout i]] (* Stack slot contains value *)
                                      else
                                        [compile_operand ctxt tmp2 o2]@[Movq, [tmp1; Ind2 Rcx]] (* Stack slot contains pinter *)
                            | _ -> failwith "store fail"
                          end
   | Call (t, Gid fn, params) -> (List.flatten (List.mapi setup_param (reverse_tail params)))
                                @ Asm.[ Callq, [~$$(Platform.mangle fn)] ]
                                @ (if (List.length params) > 6 then Asm.[ Addq, [~$(8*((List.length params) - 6)); ~%Rsp] ]
                                   else [])
                                @ (match t with Void -> [] | _ -> Asm.[ Movq, [~%Rax; dest] ])
   | Call (t, Id fn, params) -> (List.flatten (List.mapi setup_param (reverse_tail params)))
                                @ Asm.[compile_operand ctxt tmp1 (Id fn) ; Callq, [Ind2 Rax]]
                                @ (if (List.length params) > 6 then Asm.[ Addq, [~$(8*((List.length params) - 6)); ~%Rsp] ]
                                   else [])
                                @ (match t with Void -> [] | _ -> Asm.[ Movq, [~%Rax; dest] ])
   | Bitcast (t1, o, t2) -> begin match o with
                              | Id i -> begin match t1 with
                                        | Ptr x when (List.mem i ctxt.instack) -> [Leaq, [get_uid ctxt.layout i; tmp1]]
                                        | _ -> [compile_operand ctxt tmp1 o]
                                        end
                              | _ -> [compile_operand ctxt tmp1 o]
                            end @ [Movq, [tmp1; dest]]
   | Gep (t, op, oplist) -> compile_gep ctxt dest (t, op) oplist
   | _ -> failwith "Not implemented"
(* compiling terminators  --------------------------------------------------- *)

(* prefix the function name [fn] to a label to ensure that the X86 labels are 
   globally unique . *)
let mk_lbl (fn:string) (l:string) = fn ^ "." ^ l

(* Compile block terminators is not too difficult:

   - Ret should properly exit the function: freeing stack space,
     restoring the value of %rbp, and putting the return value (if
     any) in %rax.

   - Br should jump

   - Cbr branch should treat its operand as a boolean conditional

   [fn] - the name of the function containing this terminator
*)

let deallocate_stack (size:int) : ins list = (if size <> 0 then Asm.[Addq, [~$size; ~%Rsp]] else [])@Asm.[ Popq, [~%Rbp]]

let compile_terminator (fn:string) (ctxt:ctxt) (t:Ll.terminator) : ins list =
  let stack_size = get_stack_size ctxt in
  let tmp1 = Asm.(~%Rax) in
  match t with 
    | Ret (typ, op) -> (match op with Some op -> Asm.[(compile_operand ctxt ~%Rax op)] | None -> []) @ (deallocate_stack stack_size) @ [Retq, []]
    | Br l -> Asm.[Jmp, [~$$(mk_lbl fn l)]]
    | Cbr (op, l1, l2) -> Asm.[(compile_operand ctxt tmp1 op) ; Cmpq, [~$1; tmp1] ; J Eq, [~$$ (mk_lbl fn l1)] ; Jmp, [~$$ (mk_lbl fn l2)]]

(* compiling blocks --------------------------------------------------------- *)

(* We have left this helper function here for you to complete. 
   [fn] - the name of the function containing this block
   [ctxt] - the current context
   [blk]  - LLVM IR code for the block
*)
let compile_block (fn:string) (ctxt:ctxt) (blk:Ll.block) : ins list =
  let comp_block = List.flatten (List.map (compile_insn ctxt fn) blk.insns) in
  let comp_term = (compile_terminator fn ctxt (match blk.term with (_, term) -> term)) in
  comp_block @ comp_term


let compile_lbl_block fn lbl ctxt blk : elem =
  Asm.text (mk_lbl fn lbl) (compile_block fn ctxt blk)

(* compile_fdecl ------------------------------------------------------------ *)


(* We suggest that you create a helper function that computes the
   stack layout for a given function declaration.

   - each function argument should be copied into a stack slot
   - in this (inefficient) compilation strategy, each local id
     is also stored as a stack slot.
   - see the discussion about locals

*)
let stack_layout (args : uid list) ((block, lbled_blocks):cfg) (tdecls:(tid * ty) list) : layout =
  let l = Hashtbl.create 0 in

  let uid_t_from_block b : (string * Ll.ty) list =  (* Return tuple list with (uid, type) *)
    let get_type i = 
      match i with
        | Binop (b, t, op1, op2) -> t
        | Alloca t -> (Ptr t)
        | Load (t, o) -> t
        | Store _ -> Void
        | Icmp _ -> I1 
        | Call (t, o1, tl) -> t
        | Bitcast (t1, o, t2) -> t2
        | Gep (t, o, ops) -> (Ptr t)
    in
    let uid_t_from_ins i = (match i with (u, i) -> (u, get_type i)) in
    List.map uid_t_from_ins b.insns
  in
  
  let map_uid_type (stack_size:int) (uid, typ) = 
    let type_size = size_ty tdecls typ in 
    add_uid l uid (Ind3 (Lit (Int64.of_int (-(stack_size + type_size))), Rbp));
    (stack_size + type_size)
  in

  let uid_t : (string * Ll.ty) list = List.flatten @@ [uid_t_from_block block]@[List.concat_map (fun (l, b) -> (uid_t_from_block b)) lbled_blocks] in
  List.iteri (fun i uid -> add_uid l uid (Ind3 (Lit (Int64.of_int (-((i+1)*8))), Rbp))) args;
  List.fold_left map_uid_type (8 * (List.length args)) uid_t;
  l

(* The code for the entry-point of a function must do several things:

   - since our simple compiler maps local %uids to stack slots,
     compiling the control-flow-graph body of an fdecl requires us to
     compute the layout (see the discussion of locals and layout)

   - the function code should also comply with the calling
     conventions, typically by moving arguments out of the parameter
     registers (or stack slots) into local storage space.  For our
     simple compilation strategy, that local storage space should be
     in the stack. (So the function parameters can also be accounted
     for in the layout.)

   - the function entry code should allocate the stack storage needed
     to hold all of the local stack slots.
*)

let rec move_params n : ins list = match n with 
  | 0 -> []
  | x when x > 6 -> (move_params (n-1)) @ 
                    Asm.[ Movq , [(arg_loc (n-1)) ; ~%Rax] ; Movq, [~%Rax ; Ind3 (Lit (Int64.of_int (-8*n)), Rbp)]]
  | x -> (move_params (n-1)) @ Asm.[ Movq , [(arg_loc (n-1)) ; Ind3 (Lit (Int64.of_int (-8*n)), Rbp)]]

let allocate_stack (size:int) : ins list = 
  Asm.[ Pushq, [~%Rbp] ; Movq, [~%Rsp; ~%Rbp]] 
  @ (if size > 0 then Asm.[ Subq, [~$(size); ~%Rsp] ] else [])
  
let compile_fdecl (tdecls:(tid * ty) list) (name:string) ({ f_ty; f_param; f_cfg }:fdecl) : X86.prog =
  let l = stack_layout f_param f_cfg tdecls in
  (* (Hashtbl.iter (fun id op -> Printf.printf "%s: %s\n" id (X86.string_of_operand op))) l; *)
  let ctxt = { tdecls = tdecls ; layout = l ; instack = [] } in

  let param_size = List.length f_param in 
  let stack_size = get_stack_size ctxt in
  let stack_allocator = (allocate_stack stack_size) @ (move_params param_size) in

  let entry_block = (match f_cfg with (bl, _) -> bl) in
  let blocks = (match f_cfg with (_, blcks) -> blcks) in
  let compiled_entry = Asm.gtext name ((stack_allocator)@(compile_block name ctxt entry_block)) in
  let compiled_blocks = List.map (fun (label, block) -> (compile_lbl_block name label ctxt block)) blocks in

  let compiled_func = [compiled_entry] @ compiled_blocks in

  compiled_func

(* compile_gdecl ------------------------------------------------------------ *)
(* Compile a global value into an X86 global data declaration and map
   a global uid to its associated X86 label.
*)
let rec compile_ginit : ginit -> X86.data list = function
  | GNull     -> [Quad (Lit 0L)]
  | GGid gid  -> [Quad (Lbl (Platform.mangle gid))]
  | GInt c    -> [Quad (Lit c)]
  | GString s -> [Asciz s]
  | GArray gs | GStruct gs -> List.map compile_gdecl gs |> List.flatten
  | GBitcast (t1,g,t2) -> compile_ginit g

and compile_gdecl (_, g) = compile_ginit g


(* compile_prog ------------------------------------------------------------- *)
let compile_prog {tdecls; gdecls; fdecls} : X86.prog =
  let g = fun (lbl, gdecl) -> Asm.data (Platform.mangle lbl) (compile_gdecl gdecl) in
  let f = fun (name, fdecl) -> compile_fdecl tdecls name fdecl in
  (List.map g gdecls) @ (List.map f fdecls |> List.flatten)
