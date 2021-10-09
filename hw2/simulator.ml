(* X86lite Simulator *)

(* See the documentation in the X86lite specification, available on the 
   course web pages, for a detailed explanation of the instruction
   semantics.
*)

open X86

module Overflow = struct
let logor (x:int64) (y:int64) : Int64_overflow.t = 
  let res = Int64.logor x y in
  { value = res; overflow = false} 
let lognot (x:int64) : Int64_overflow.t = 
  let res = Int64.lognot x in
  { value = res; overflow = false} 
let logxor (x:int64) (y:int64) : Int64_overflow.t = 
  let res = Int64.logxor x y in
  { value = res; overflow = false} 
let logand (x:int64) (y:int64) : Int64_overflow.t = 
  let res = Int64.logand x y in
  { value = res; overflow = false} 
let shift_left (x:int64) (y:int) : Int64_overflow.t =
  let ans = Int64.shift_left x y in
  let compans = Int64.compare ans 0L in
  let compx = Int64.compare x 0L in
  let overflow = (y = 1) && ((compx < 0) && (compans > 0) || (compx > 0) && (compans < 0)) in
  { Int64_overflow.value = ans; Int64_overflow.overflow = overflow} 
let shift_right (x:int64) (y:int) : Int64_overflow.t =
  let ans = Int64.shift_right x y in
  let overflow = (y <> 1) in
  { Int64_overflow.value = ans; Int64_overflow.overflow = overflow} 
let shift_right_logical (x:int64) (y:int) : Int64_overflow.t =
  let ans = Int64.shift_right_logical x y in
  let compans = Int64.compare ans 0L in
  let overflow = (y = 1) && (compans < 0) in
  { Int64_overflow.value = ans; Int64_overflow.overflow = overflow} 
end

open Overflow
(* simulator machine state -------------------------------------------------- *)

let mem_bot = 0x400000L          (* lowest valid address *)
let mem_top = 0x410000L          (* one past the last byte in memory *)
let mem_size = Int64.to_int (Int64.sub mem_top mem_bot)
let nregs = 17                   (* including Rip *)
let ins_size = 8L                (* assume we have a 8-byte encoding *)
let exit_addr = 0xfdeadL         (* halt when m.regs(%rip) = exit_addr *)

(* Your simulator should raise this exception if it tries to read from or
   store to an address not within the valid address space. *)
exception X86lite_segfault

(* The simulator memory maps addresses to symbolic bytes.  Symbolic
   bytes are either actual data indicated by the Byte constructor or
   'symbolic instructions' that take up eight bytes for the purposes of
   layout.

   The symbolic bytes abstract away from the details of how
   instructions are represented in memory.  Each instruction takes
   exactly eight consecutive bytes, where the first byte InsB0 stores
   the actual instruction, and the next sevent bytes are InsFrag
   elements, which aren't valid data.

   For example, the two-instruction sequence:
        at&t syntax             ocaml syntax
      movq %rdi, (%rsp)       Movq,  [~%Rdi; Ind2 Rsp]
      decq %rdi               Decq,  [~%Rdi]

   is represented by the following elements of the mem array (starting
   at address 0x400000):

       0x400000 :  InsB0 (Movq,  [~%Rdi; Ind2 Rsp])
       0x400001 :  InsFrag
       0x400002 :  InsFrag
       0x400003 :  InsFrag
       0x400004 :  InsFrag
       0x400005 :  InsFrag
       0x400006 :  InsFrag
       0x400007 :  InsFrag
       0x400008 :  InsB0 (Decq,  [~%Rdi])
       0x40000A :  InsFrag
       0x40000B :  InsFrag
       0x40000C :  InsFrag
       0x40000D :  InsFrag
       0x40000E :  InsFrag
       0x40000F :  InsFrag
       0x400010 :  InsFrag
*)
type sbyte = InsB0 of ins       (* 1st byte of an instruction *)
           | InsFrag            (* 2nd - 8th bytes of an instruction *)
           | Byte of char       (* non-instruction byte *)

(* memory maps addresses to symbolic bytes *)
type mem = sbyte array

(* Flags for condition codes *)
type flags = { mutable fo : bool
             ; mutable fs : bool
             ; mutable fz : bool
             }

(* Register files *)
type regs = int64 array

(* Complete machine state *)
type mach = { flags : flags
            ; regs : regs
            ; mem : mem
            }

(* simulator helper functions ----------------------------------------------- *)

(* The index of a register in the regs array *)
let rind : reg -> int = function
  | Rip -> 16
  | Rax -> 0  | Rbx -> 1  | Rcx -> 2  | Rdx -> 3
  | Rsi -> 4  | Rdi -> 5  | Rbp -> 6  | Rsp -> 7
  | R08 -> 8  | R09 -> 9  | R10 -> 10 | R11 -> 11
  | R12 -> 12 | R13 -> 13 | R14 -> 14 | R15 -> 15

(* Helper functions for reading/writing sbytes *)

(* Convert an int64 to its sbyte representation *)
let sbytes_of_int64 (i:int64) : sbyte list =
  let open Char in 
  let open Int64 in
  List.map (fun n -> Byte (shift_right i n |> logand 0xffL |> to_int |> chr))
           [0; 8; 16; 24; 32; 40; 48; 56]

(* Convert an sbyte representation to an int64 *)
let int64_of_sbytes (bs:sbyte list) : int64 =
  let open Char in
  let open Int64 in
  let f b i = match b with
    | Byte c -> logor (shift_left i 8) (c |> code |> of_int)
    | _ -> 0L
  in
  List.fold_right f bs 0L

(* Convert a string to its sbyte representation *)
let sbytes_of_string (s:string) : sbyte list =
  let rec loop acc = function
    | i when i < 0 -> acc
    | i -> loop (Byte s.[i]::acc) (pred i)
  in
  loop [Byte '\x00'] @@ String.length s - 1

(* Serialize an instruction to sbytes *)
let sbytes_of_ins (op, args:ins) : sbyte list =
  let check = function
    | Imm (Lbl _) | Ind1 (Lbl _) | Ind3 (Lbl _, _) -> 
      invalid_arg "sbytes_of_ins: tried to serialize a label!"
    | o -> ()
  in
  List.iter check args;
  [InsB0 (op, args); InsFrag; InsFrag; InsFrag;
   InsFrag; InsFrag; InsFrag; InsFrag]

(* Serialize a data element to sbytes *)
let sbytes_of_data : data -> sbyte list = function
  | Quad (Lit i) -> sbytes_of_int64 i
  | Asciz s -> sbytes_of_string s
  | Quad (Lbl _) -> invalid_arg "sbytes_of_data: tried to serialize a label!"


(* It might be useful to toggle printing of intermediate states of your 
   simulator. Our implementation uses this mutable flag to turn on/off
   printing.  For instance, you might write something like:

     [if !debug_simulator then print_endline @@ string_of_ins u; ...]

*)
let debug_simulator = ref false

(* Interpret a condition code with respect to the given flags. *)
let interp_cnd {fo; fs; fz} : cnd -> bool = fun x -> 
    begin match x with
    | Eq -> fz
    | Neq -> not fz
    | Gt -> (not fz) && (fs = fo)
    | Lt ->  fs <> fo
    | Le -> (fz) || (fs <> fo)
    | Ge -> fs = fo
  end


let debugFlags (f:flags) : unit = begin
    Printf.printf "fo: %s fs: %s fz: %s\n" (string_of_bool f.fo)
    (string_of_bool f.fs) (string_of_bool f.fz);

    Printf.printf "eq: %s neq: %s lt: %s le: %s gt: %s ge: %s\n\n"
    (string_of_bool (interp_cnd f Eq))
    (string_of_bool (interp_cnd f Neq))
    (string_of_bool (interp_cnd f Lt))
    (string_of_bool (interp_cnd f Le))
    (string_of_bool (interp_cnd f Gt))
    (string_of_bool (interp_cnd f Ge))

  end

let debugReg (r:regs) : unit = begin
    let rs1 = [Rax;Rbx;Rcx;Rdx] in
    let rs = [Rip;Rsi;Rdi;Rbp;Rsp] in
    let rs2 = [R08;R09;R10;R11;R12;R13;R14;R15] in

    let rec kappa l = 
      begin match l with
        | [] -> Printf.printf "\n"
        | x::y -> Printf.printf ("%s: %s ") (string_of_reg x) (Int64.to_string r.(rind x));
                  kappa y;
      end in
    kappa rs1;
    kappa rs;
    kappa rs2
  end


(* Maps an X86lite address into Some OCaml array index,
   or None if the address is not within the legal address space. *)
let map_addr (addr:quad) : int option =
  if ((addr >= mem_top) || (addr < mem_bot)) then None
  else Some (Int64.to_int (Int64.sub addr mem_bot))  


let getImm (i:imm) : int64 = 
  begin match i with
    | Lit x -> x
    | Lbl x -> failwith "Label shouldnt be here"
  end


(* get value of the operand *)
let getValue (m:mach) (opop:operand option) : int64 option = 
  (* No operand specified *)
  if opop = None then None else
  
  (* extract the operand itself *)
  let op = match opop with 
    | Some x -> x
    | _ -> failwith "opop impossible"
  in
  (* Helper function to extract from memory *)
  let extractInt64 (v: (int option)) : int64 = 
    begin match v with 
      | None -> raise X86lite_segfault
      | Some k -> 
        begin 
          (* basically read out the lsbytes and then convert them *)
          let lsbytes = [m.mem.(k); m.mem.(k+1); m.mem.(k+2);
            m.mem.(k+3); m.mem.(k+4); m.mem.(k+5); m.mem.(k+6); m.mem.(k+7)] in
          int64_of_sbytes lsbytes
        end
    end in
  
  (* Actual matching *)
  begin match op with
    | Imm x -> Some (getImm x)
    | Reg x -> Some (m.regs.(rind x))
    | Ind1 x -> Some (extractInt64 (map_addr (getImm x)))
    | Ind2 x -> Some (extractInt64 (map_addr m.regs.(rind x)))
    | Ind3 (x, y) -> Some (extractInt64 (map_addr (Int64.add m.regs.(rind y) (getImm x))))
  end

  

(* Simple instruction to facilitate writing to an memory location *)
let rec writeMem (m:mach) (l:sbyte list) (addr: int option): unit = 
  let adr = begin match addr with
    | None -> failwith "unwrap_int doesnt work..."  (* SEGFAULT HERE MAYBE ? ? ? *)
    | Some x -> x
  end in
  (* recursively writing the memory *)
  begin match l with
    | [] -> ()
    | x::y -> (m.mem.(adr) <- x); (writeMem m y (Some (adr + 1)))
  end
  (* not side effect free *)


(* takes an value of an operand and then writes to an destination specified by another operand *)
let writeTo (m:mach) (src_vo: int64 option) (desto:operand option) : unit =
  (* if nothing to do *)
  if src_vo = None then () else if desto = None then () else
  
  let src_value = match src_vo with
    | Some c -> c
    | _ -> failwith "writeTo src_value impossible" in

  let dest = match desto with
    | Some c -> c
    | _ -> failwith "writeTo dest impossible" in
  
  (* get the sbytes list *)
  let src_sbytes = sbytes_of_int64 src_value in

  begin match dest with
    | Reg y -> m.regs.(rind y) <- src_value
    | Ind1 x -> writeMem m src_sbytes (map_addr (getImm x))
    | Ind2 x -> writeMem m src_sbytes (map_addr m.regs.(rind x))
    | Ind3 (x, y) -> writeMem m src_sbytes (map_addr (Int64.add m.regs.(rind y) (getImm x)))
    | Imm x -> failwith "Imm x in writeTo dest"
  end


(* Monad library *)
let ( >>= ) (x: 'a option) (op : 'a -> 'a option) : 'a option =
  match x with
    | None -> None
    | Some a -> op a



(* simple wrapper function *)
let return (x: 'a) : 'a option = Some x

let setFlags (op:opcode) (m:mach) (ans:int64) (overflow:bool) : unit =
  begin
    let compans = Int64.compare ans 0L in
    if compans = 0 then m.flags.fz <- true else m.flags.fz <- false;
    if compans < 0 then m.flags.fs <- true else m.flags.fs <- false;
    m.flags.fo <- overflow
  end

let doarith (op:opcode) (m:mach) (x:int64 option) (y:int64 option) : int64 option =
  x >>= fun a -> 
  y >>= fun b ->
  let t = begin match op with
    | Addq -> Int64_overflow.add a b
    | Subq -> Int64_overflow.sub a b  
    | Imulq -> Int64_overflow.mul a b
    | Xorq -> Overflow.logxor a b
    | Orq -> Overflow.logor a b
    | Andq -> Overflow.logand a b
    | Shlq -> Overflow.shift_left a (Int64.to_int b)
    | Sarq -> Overflow.shift_right a (Int64.to_int b)
    | Shrq -> Overflow.shift_right_logical a (Int64.to_int b)
    | _ -> failwith "not arith"
  end in
  let result = t.value in
  let _ = setFlags op m result t.overflow in
  return result

let doarith1 (op:opcode) (m:mach) (x : int64 option) : int64 option = 
  x >>= fun a ->
  let t = begin match op with
  | Incq -> Int64_overflow.succ a
  | Decq -> Int64_overflow.pred a
  | Negq -> Int64_overflow.neg a
  | Notq -> Overflow.lognot a
  | _ -> failwith "not arith"
  end in
  let oldflags = m.flags in
  let result = t.value in
  let _ = setFlags op m result t.overflow in
  if op = Notq then (m.flags.fo <- oldflags.fo; m.flags.fz <- oldflags.fz; m.flags.fs <- oldflags.fs);
  return result

let comp (m:mach) (x:int64 option) (y:int64 option) : unit =
  let _ = doarith Subq m x y in ()

let push (m:mach) (v: int64 option) : unit =
  let oldreg = m.regs.(rind Rsp) in
  let _ = m.regs.(rind Rsp) <- (Int64.sub oldreg 8L) in
  writeTo m v (Some (Ind2 Rsp)) 
let pop (m:mach) (dest: operand option) : unit =
  let value = getValue m (Some (Ind2 Rsp)) in
  let oldreg = m.regs.(rind Rsp) in
  let _ = m.regs.(rind Rsp) <- (Int64.add oldreg 8L) in
  writeTo m value dest
let leq (m:mach) (i: operand option) (dest: operand option) : unit =
  let ind = begin match i with
    | Some c -> c
    | _ -> failwith "leq not good"
  end in
  let address = begin match ind with
    | Reg y -> failwith "Imm x in writeTo dest"
    | Imm x -> failwith "Imm x in writeTo dest"
    | Ind1 x -> getImm x
    | Ind2 x -> m.regs.(rind x)
    | Ind3 (x, y) -> (Int64.add m.regs.(rind y) (getImm x))
  end in
  writeTo m (Some address) dest

let jump (m:mach) (v: int64 option) : unit =
  let value = begin match v with
    | Some c -> c
    | _ -> failwith "Missing value"
  end in
  m.regs.(rind Rip) <- value(*Int64.sub value 8L*)


let set (m:mach) (byte:char) (byte2:int64) (desto: operand option) : unit =
  
  begin match desto with
    | Some Reg y -> m.regs.(rind y) <- (Int64.add (Int64.logand m.regs.(rind y) 0xFFFFFFFFFFFFFF00L) (byte2))
    | Some Ind1 x -> writeMem m [Byte byte] (map_addr (getImm x))
    | Some Ind2 x -> writeMem m [Byte byte] (map_addr m.regs.(rind x))
    | Some Ind3 (x, y) -> writeMem m [Byte byte] (map_addr (Int64.add m.regs.(rind y) (getImm x)))
    | Some Imm x -> failwith "Imm x in writeTo dest"
    | _ -> failwith "set issue no operand"
  end



(* Simulates one step of the machine:
    - fetch the instruction at %rip
    - compute the source and/or destination information from the operands
    - simulate the instruction semantics
    - update the registers and/or memory appropriately
    - set the condition flags
*)
let step (m:mach) : unit =
  begin
    (* fetch $rip *)
    let ip = m.regs.(rind Rip) in

    (* get instruction *)
    let index = map_addr ip in
    let instrdata = m.mem.(
      begin match index with
        | None -> raise X86lite_segfault
        | Some x -> x
      end
    ) in

    (* Debugging *)
    if (!debug_simulator) then (
      Printf.printf "\n";
      begin match instrdata with
        | InsB0 a -> Printf.printf "Instr: %s\n\n" (string_of_ins a)
        | _ -> failwith "No Instr at this location"
      end;
      debugFlags m.flags;
      debugReg m.regs;
    );
    (* update instr *)
    Array.set m.regs (rind Rip) (Int64.add 8L m.regs.(rind Rip));

    (* Simulate Instruction *)
    begin match instrdata with
      (* actually an instruction *)
      | InsB0 x -> (
        let instr = x in

        (* extract the operands *)
        let op1 =
          begin match instr with
            | (_, x::_) -> Some x
            | (_, []) -> None
          end in
        
        let op2 =
          begin match instr with
            | (_, _x::y::_) -> Some y
            | (_, _) -> None
          end in
        
        (* extract the actual value of the operands *)
        let op1v = getValue m op1 in
        let op2v = getValue m op2 in

        (* match on opcode *)
        let opcode = 
          match instr with
            | (x, _) -> x in

          begin match opcode with
            | Movq -> writeTo m op1v op2
            | Pushq -> push m op1v
            | Popq -> pop m op1  
            | Leaq -> leq m op1 op2

            | Incq -> writeTo m (doarith1 opcode m op1v) op1
            | Decq -> writeTo m (doarith1 opcode m op1v) op1
            | Negq -> writeTo m (doarith1 opcode m op1v) op1
            | Notq -> writeTo m (doarith1 opcode m op1v) op1

            | Addq -> writeTo m (doarith opcode m op2v op1v) op2
            | Subq -> writeTo m (doarith opcode m op2v op1v) op2
            | Imulq -> writeTo m (doarith opcode m op2v op1v) op2
            | Xorq -> writeTo m (doarith opcode m op2v op1v) op2
            | Orq -> writeTo m (doarith opcode m op2v op1v) op2
            | Andq -> writeTo m (doarith opcode m op2v op1v) op2
            | Shlq -> writeTo m (doarith opcode m op2v op1v) op2
            | Sarq -> writeTo m (doarith opcode m op2v op1v) op2
            | Shrq -> writeTo m (doarith opcode m op2v op1v) op2

            | Jmp -> jump m op1v 
            | J x -> if (interp_cnd (m.flags) x) then jump m op1v
            | Cmpq -> comp m op2v op1v
            | Set x -> if (interp_cnd (m.flags) x) then (set m '\x01' 1L op1) else (set m '\x00' 0L op1)
            | Callq -> push m (Some (m.regs.(rind Rip))); jump m op1v
            | Retq -> pop m (Some (Reg Rip)); 
          end;     
      )
      (* No instruction *)
      | _ -> failwith "No Instr at this location"
    end;

    if (!debug_simulator) then (
      Printf.printf "\nAfter:\n";
      debugFlags m.flags;
      debugReg m.regs;

      Printf.printf "\n";
    );


  end
  

(* Runs the machine until the rip register reaches a designated
   memory address. Returns the contents of %rax when the 
   machine halts. *)
let run (m:mach) : int64 = 
  while m.regs.(rind Rip) <> exit_addr do step m done;
  m.regs.(rind Rax)

(* assembling and linking --------------------------------------------------- *)

(* A representation of the executable *)
type exec = { entry    : quad              (* address of the entry point *)
            ; text_pos : quad              (* starting address of the code *)
            ; data_pos : quad              (* starting address of the data *)
            ; text_seg : sbyte list        (* contents of the text segment *)
            ; data_seg : sbyte list        (* contents of the data segment *)
            }

(* Assemble should raise this when a label is used but not defined *)
exception Undefined_sym of lbl

(* Assemble should raise this when a label is defined more than once *)
exception Redefined_sym of lbl


 type map = (lbl * quad) list

module Map = struct
  let rec contains (m:map) (k:lbl) : bool =
    begin match m with
    | (x, y)::tl -> 
        if x = k then true else contains tl k
    | [] -> false
    end

  let rec lookup (m:map) (k:lbl) : quad =
    begin match m with
    | (x, y)::tl -> 
      if x = k then Int64.add y mem_bot else lookup tl k
    | [] -> raise (Undefined_sym k)
    end
end

(* compute the size of a data field *)
let data_size (size:int64) (d:data) : int64 = 
begin match d with
| Asciz a -> 
  let len = Int64.of_int (String.length a) in
    Int64.add size (Int64.add 1L len)
| Quad q -> 
  begin match q with
  | Lit _ -> Int64.add size 8L
  | Lbl _ -> invalid_arg "serialize header"
  end
end 

(* Calculates the size of text and data field *)
let compute_size (s:(int64 * int64)) (e:elem) : (int64 * int64) =
let size_t, size_d = s in
begin match e.asm with
| Text t -> 
    (* calculate the amount of instr space needed and add it *)
    let list_size = (Int64.of_int (List.length t)) in
    (Int64.add size_t (Int64.mul list_size 8L), size_d)
    (* could be list of ascii thus needs another fold_left *)
| Data d -> (size_t, Int64.add size_d (List.fold_left data_size 0L d))
end

let data_helper (dataseg: sbyte list) (data:data) : sbyte list =
  let sbyte_of_data = sbytes_of_data data in
  dataseg @ sbyte_of_data

let handle_data (input:(int64 * map * sbyte list)) (e:elem) : (int64 * map * sbyte list) =
  let offset, _map, dataseg = input in
  begin match e.asm with
    | Data datalist ->
      let new_map =  
        if (Map.contains _map e.lbl) then 
          raise (Redefined_sym e.lbl)
        else 
          let old_data_seg_size = Int64.of_int (List.length dataseg) in
          _map @ [(e.lbl, Int64.add offset old_data_seg_size)]
        in
      let new_dataseg = List.fold_left data_helper dataseg datalist in
      (offset, new_map, new_dataseg)
    | Text _ -> input
  end


let handle_instr (input:int64*map) (e:elem) : (int64*map) =
  let index, _map = input in
  begin match e.asm with 
    | Data _ -> input
    | Text inslist -> 
      let new_map = 
        if (Map.contains _map e.lbl) then
          raise (Redefined_sym e.lbl)
        else   
          _map @ [(e.lbl, index)] in
      let list_size = (Int64.of_int (List.length inslist)) in
      let list_realsize = (Int64.add index (Int64.mul list_size 8L)) in
      (list_realsize, new_map)
  end

let labeler (input:ins list * map) (ins:ins) : (ins list * map) =
  let old_inslist, _map = input in

  let labelop (op:operand) : operand = 
    begin match op with
      | Imm (Lbl x) -> Imm (Lit (Map.lookup _map x))
      | Ind1 (Lbl x) -> Ind1 (Lit (Map.lookup _map x))
      | Ind3 (Lbl x, k) -> Ind3 (Lit (Map.lookup _map x), k)
      | _ -> op
    end
  in

  let new_ins : ins = 
    begin match ins with
      | (opcode, []) -> ins
      | (opcode, op1::[]) -> (opcode, (labelop op1)::[])
      | (opcode, op1::op2::[]) -> (opcode, (labelop op1)::(labelop op2)::[])
      | (_, _) -> failwith "labeler doesnt like this"
    end
   in
  (old_inslist @ [new_ins], _map)

let serilize (textseg: sbyte list) (ins:ins) : (sbyte list) =
  textseg @ sbytes_of_ins ins 

let serializeInstr (input:map*sbyte list) (e:elem) : (map*sbyte list) = 
  let _map, textseg = input in
  begin match e.asm with
    | Data _ -> input
    | Text inslist -> 
      let new_inslist, _map  = List.fold_left labeler ([],_map) inslist in
      (_map , List.fold_left serilize textseg new_inslist)
  end
  
(* Convert an X86 program into an object file:
   - separate the text and data segments
   - compute the size of each segment
      Note: the size of an Asciz string section is (1 + the string length)
            due to the null terminator

   - resolve the labels to concrete addresses and 'patch' the instructions to 
     replace Lbl values with the corresponding Imm values.

   - the text segment starts at the lowest address
   - the data segment starts after the text segment

  HINT: List.fold_left and List.fold_right are your friends.
 *)
let assemble (p:prog) : exec =
  let text_size, data_size = List.fold_left compute_size (0L, 0L) p in
  let _, _map, data_segg = List.fold_left handle_data (text_size, [], []) p in
  let _, _map = List.fold_left handle_instr (0L, _map) p in
  let _, text_segg = List.fold_left serializeInstr (_map, []) p in
  { entry    = Map.lookup _map "main"              (* address of the entry point *)
  ; text_pos = mem_bot              (* starting address of the code *)
  ; data_pos = Int64.add mem_bot text_size             (* starting address of the data *)
  ; text_seg = text_segg       (* contents of the text segment *)
  ; data_seg = data_segg        (* contents of the data segment *)
  }



  
(* Convert an object file into an executable machine state. 
  - allocate the mem array
  - set up the memory state by writing the symbolic bytes to the 
      appropriate locations 
    - create the inital register state
      - initialize rip to the entry point address
      - initializes rsp to the last word in memory 
      - the other registers are initialized to 0
    - the condition code flags start as 'false'

  Hint: The Array.make, Array.blit, and Array.of_list library functions 
  may be of use.
*)
let load {entry; text_pos; data_pos; text_seg; data_seg} : mach = 
  let memm = Array.make mem_size (Byte '\x00') in
  let prog = Array.of_list (text_seg@data_seg) in
  let prog_size = (Array.length prog) in
  let exit_address = Array.of_list (sbytes_of_int64 exit_addr) in
  
  Array.blit prog 0 memm 0 prog_size;
  Array.blit exit_address 0 memm (mem_size - 8) 8;

  let regss = Array.make nregs 0L in
  regss.(rind Rip) <- entry;
  regss.(rind Rsp) <- Int64.sub mem_top 8L;
  

  let flagss = { fo = false; fs = false; fz = false} in
  {
    flags = flagss;
    regs = regss;
    mem = memm
  }
  

