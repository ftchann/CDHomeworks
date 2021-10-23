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

type layout = (uid * X86.operand) list

(* A context contains the global type declarations (needed for getelementptr
   calculations) and a stack layout. *)
type ctxt = { tdecls : (tid * ty) list
            ; layout : layout
            }

(* useful for looking up items in tdecls or layouts *)
let lookup m x = List.assoc x m


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

let rec memberOf (layout:layout) (a:Ll.uid) = 
  match layout with
    | (x,z)::y ->   if (String.equal x a) then Some z
                    else memberOf y a
    | [] -> None 


let compile_operand (ctxt:ctxt) (dest:X86.operand):  Ll.operand -> ins =
  fun (op:Ll.operand) ->
    begin match op with 
      | Null -> Asm.(Movq, [~$0 ; dest])
      | Const x -> Asm.(Movq, [~$(Int64.to_int x) ; dest])
      | Id uid -> (
        match memberOf ctxt.layout ("kappa"^uid) with 
        | Some x -> Asm.(Movq, [x; dest])
        | None -> 
          (
            match memberOf ctxt.layout ("param"^uid) with 
              | Some x -> Asm.(Movq, [x; dest])
              | None -> Asm.(Movq, [~$(-123456); dest]) 
          )
        )
      | Gid x -> Asm.(Leaq, [Ind3 (Lbl (Platform.mangle x), Rip); dest])
    end
    



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
  begin match t with
  | Void 
  | I8 
  | Fun _ -> 0
  | I1 
  | I64 
  | Ptr _ -> 8
  | Struct [] -> 0
  | Struct (y::x) -> size_ty tdecls y + size_ty tdecls (Struct x)
  | Array (x, y) -> x * size_ty tdecls y
  | Namedt x -> size_ty tdecls (lookup tdecls x)
  end




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
let compile_gep (ctxt:ctxt) (op : Ll.ty * Ll.operand) (path: Ll.operand list) : ins list =
failwith "compile_gep not implemented"


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
let compile_insn (ctxt:ctxt) ((uid:uid), (i:Ll.insn)) : X86.ins list =
    let compile_binop (op:Ll.bop) (tz:Ll.ty) (op1:Ll.operand) (op2:Ll.operand) : X86.ins list =
      let toX86 (op:Ll.bop) : X86.opcode =
        match op with
          | Add -> Addq
          | Sub -> Subq
          | Mul -> Imulq
          | Shl -> Shlq
          | Lshr -> Shrq
          | Ashr -> Sarq
          | And -> Andq
          | Or -> Orq
          | Xor -> Xorq
      in  
      let x1 = compile_operand ctxt (Reg Rax) op2 in
      let x2 = compile_operand ctxt (Reg Rdi) op1 in
      let x3 = Asm.(toX86 op, [~%Rdi ; ~%Rax]) in
      x1 :: x2 ::  x3 :: []
    in

    begin match i with
      | Binop (op, ty, a , b) -> compile_binop op ty a b
      | Alloca ty -> [Asm.(Movq, [~$0; ~$0])]
      | Load (ty, op) -> [Asm.(Movq, [~$0; ~$0])]
      | Store (ty, op, op2) -> [Asm.(Movq, [~$0; ~$0])]
      | Icmp (cnd, ty, op, op2) -> [Asm.(Movq, [~$0; ~$0])]
      | Call (ty, op, tyopl) -> [Asm.(Movq, [~$0; ~$0])]
      | Bitcast (ty, op, ty2) -> [Asm.(Movq, [~$0; ~$0])]
      | Gep (ty, op, opl) -> [Asm.(Movq, [~$0; ~$0])]
    end



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

let compile_terminator (fn:string) (ctxt:ctxt) (t:Ll.terminator) : ins list =
  let compileEpilogue =
    [Movq, [Reg Rbp; Reg Rsp]]
    @ [Popq, [Reg Rbp]]
    @ [Retq, []] in

  begin match t with 
    | Ret (x, y) -> 
      ( match y with 
      | Some y -> Asm.[((compile_operand ctxt (Reg Rax)) y)]
      | None -> Asm.[(Movq, [~$0; ~%Rax])] (* maybe better to leave empty idk? *)
      ) @ compileEpilogue
    | Br x -> Asm.[(Jmp, [~$$(mk_lbl fn x)])]
    (*| Cbr (op, lb1, lb2) -> []*)
    | _ -> []
  end


(* compiling blocks --------------------------------------------------------- *)
(* This helper function computes the location of the nth incoming
   function argument: either in a register or relative to %rbp,
   according to the calling conventions.  You might find it useful for
   compile_fdecl.

   [ NOTE: the first six arguments are numbered 0 .. 5 ]
*)


let arg_loc (n : int) : operand = 
  begin match n with
    | 0 -> Reg Rdi
    | 1 -> Reg Rsi
    | 2 -> Reg Rdx
    | 3 -> Reg Rcx
    | 4 -> Reg R08
    | 5 -> Reg R09
    | x -> Ind3 (Lit (Int64.of_int (((x-6)+2)*8)), Rbp) 
  end
let compilePrologue (layout:layout) : ins list =

  let rec createPara (l:layout) = 
    begin match l with
      | (x, y)::z ->  if String.equal (String.sub x 0 5) "param" then x :: createPara z
                      else createPara z 
      | [] -> []
    end
  in

  let para = createPara layout in

  let ins : ins list = 
    [Pushq, [Reg Rbp]]
  @ [Movq, [Reg Rsp;Reg Rbp]]
  @ [Subq, [Imm (Lit (Int64.of_int ((List.length layout)*8))); Reg Rsp]] 
  in

  let rec getIndex a l c = 
    match l with
    | [] -> failwith "should never happen"
    | x::y -> if (x=a) then c else getIndex a y (c+1) 
  in

  let rec f (l:layout) : ins list =
    begin match l with
      | (x,y)::z -> 
        if List.mem x para then 
          if ((getIndex x para 0) < 6) then [Movq, [arg_loc (getIndex x para 0) ; y]] @ f z
          else [Movq, [arg_loc (getIndex x para 0) ; Reg Rax]]
              @[Movq, [Reg Rax ; y]] @ f z

        else f z
      | _ -> []
    end
  in

  ins @ f layout
(* We have left this helper function here for you to complete. 
   [fn] - the name of the function containing this block
   [ctxt] - the current context
   [blk]  - LLVM IR code for the block
*)
let compile_block (fn:string) (ctxt:ctxt) (blk:Ll.block) : ins list =

  (* generate List of Inst *)
  let genInstr (ins:(Ll.uid * Ll.insn)) : ins list =
    compile_insn ctxt ins
  in
  let inslist2 = List.map genInstr blk.insns in
  let inslist = List.flatten inslist2 in
    
  (* generate terminator *)
  let tuid, tty = match blk.term with | (y, z) -> y, z in
  let terminator = compile_terminator fn ctxt tty in

  inslist @ terminator

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
let stack_layout (args : uid list) ((block, lbled_blocks):cfg) : layout =
  let g (c:int) = Ind3 (Lit (Int64.of_int (c*(-8))), Rbp) in

  let rec f (l:uid list) (c:int) : layout = 
    match l with
      | x::y -> ("param"^x, g c) :: f y (c+1)
      | [] -> []
  in

  let rec uid_layout (l:(Ll.uid * Ll.insn) list) (lay:layout) : layout =
    let newlay = match l with
      | (x, _)::y -> 
        (match memberOf lay ("kappa"^x) with 
              | None -> ("kappa"^x, g ((List.length lay)+1)) :: lay 
              | Some kappa -> lay
                )
      | [] -> lay
    in
    begin match l with 
      | _::y -> uid_layout y newlay
      | [] -> newlay
    end
  in 
    

  let rec k (l:(string * Ll.block) list) = 
    match l with
      | (_, blocks)::y -> block.insns @ k y  
      | [] -> []
  in

  let inss = block.insns @ k lbled_blocks in

  let layp = f args 1 in

  let layb = uid_layout inss layp in

  (*
  let fold_helper  (elem:(string * X86.operand)) : string =
    let (a, _) = elem in
    a
  in
  
  let smap = List.map fold_helper layb;
  in

  let rec stringi (l:string list) : string =
    match l with
    | x::y -> x^(stringi y)
    | [] -> ""
  in 
    

  let s = stringi smap in
  failwith s;
*)

  layb

  


  

  

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







let compile_fdecl (tdecls:(tid * ty) list) (name:string) ({ f_ty; f_param; f_cfg }:fdecl) : prog =
  let layout : layout = stack_layout f_param f_cfg in
  let ctxt : ctxt = {tdecls=tdecls ; layout=layout} in

  let entry = match f_cfg with (b, _) -> b in
  let prologue = compilePrologue ctxt.layout in
  let entryC = prologue @ compile_block name ctxt entry in 
  let blocks = match f_cfg with (_, b) -> b in

  let f (b:string * Ll.block) =
    match b with 
      | (x, y) -> compile_lbl_block name x ctxt y 
  in 



  let blocksC = List.map f blocks in

  [Asm.gtext name entryC] @ blocksC



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
