open Ll
open Datastructures

(* The lattice of symbolic constants ---------------------------------------- *)
module SymConst =
  struct
    type t = NonConst           (* Uid may take on multiple values at runtime *)
           | Const of int64     (* Uid will always evaluate to const i64 or i1 *)
           | UndefConst         (* Uid is not defined at the point *)

    let compare s t =
      match (s, t) with
      | (Const i, Const j) -> Int64.compare i j
      | (NonConst, NonConst) | (UndefConst, UndefConst) -> 0
      | (NonConst, _) | (_, UndefConst) -> 1
      | (UndefConst, _) | (_, NonConst) -> -1

    let to_string : t -> string = function
      | NonConst -> "NonConst"
      | Const i -> Printf.sprintf "Const (%LdL)" i
      | UndefConst -> "UndefConst"

    
  end

(* The analysis computes, at each program point, which UIDs in scope will evaluate 
   to integer constants *)
type fact = SymConst.t UidM.t



(* flow function across Ll instructions ------------------------------------- *)
(* - Uid of a binop or icmp with const arguments is constant-out
   - Uid of a binop or icmp with an UndefConst argument is UndefConst-out
   - Uid of a binop or icmp with an NonConst argument is NonConst-out
   - Uid of stores and void calls are UndefConst-out
   - Uid of all other instructions are NonConst-out
 *)
let insn_flow (u,i:uid * insn) (d:fact) : fact =
    let biop bop op1 op2 =
      let matcher op =
      match op with
      | Const x -> SymConst.Const x
      | Id x 
      | Gid x -> 
        (
          let res = UidM.find_opt x d in
          match res with
          | None -> SymConst.UndefConst 
          | Some x -> x
        )
      | Null -> failwith "operand Null"
      in
      
      let calc x y =
        match bop with
        | Add -> Int64.add x y
        | Sub -> Int64.sub x y
        | Mul -> Int64.mul x y
        | Shl -> Int64.shift_left x (Int64.to_int y)
        | Lshr -> Int64.shift_right_logical x (Int64.to_int y)
        | Ashr -> Int64.shift_right x (Int64.to_int y)
        | And -> Int64.logand x y
        | Or -> Int64.logor x y
        | Xor -> Int64.logxor x y
      in
      
      let t1 = matcher op1 in   
      let t2 = matcher op2 in

      match t1, t2 with
      | Const x, Const y -> SymConst.Const (calc x y)
      | UndefConst, _ -> UndefConst
      | _, UndefConst -> UndefConst
      | NonConst, _ -> SymConst.NonConst 
      | _, NonConst -> SymConst.NonConst
  in
    
  let x = match i with  
  | Binop (bop, _, op1, op2) -> biop bop op1 op2
  | Icmp (cnd, _, op1, op2) -> 
    (
    let res = biop Ll.Sub op1 op2 in
    match res with 
    | SymConst.Const x -> 
      (
        match cnd with
        | Ll.Eq -> if x = 0L then SymConst.Const 1L else SymConst.Const 0L
        | Ll.Ne -> if x <> 0L then SymConst.Const 1L else SymConst.Const 0L
        | Ll.Slt -> if x < 0L then SymConst.Const 1L else SymConst.Const 0L
        | Ll.Sle -> if x <= 0L then SymConst.Const 1L else SymConst.Const 0L
        | Ll.Sgt -> if x > 0L then SymConst.Const 1L else SymConst.Const 0L
        | Ll.Sge -> if x >= 0L then SymConst.Const 1L else SymConst.Const 0L
      )
    | a -> a 
    ) 
  | Store _
  | Call (Void, _, _) -> SymConst.UndefConst
  | _ -> SymConst.NonConst
  in
  UidM.add u x d
  

(* The flow function across terminators is trivial: they never change const info *)
let terminator_flow (t:terminator) (d:fact) : fact = d

(* module for instantiating the generic framework --------------------------- *)
module Fact =
  struct
    type t = fact
    let forwards = true

    let insn_flow = insn_flow
    let terminator_flow = terminator_flow
    
    let normalize : fact -> fact = 
      UidM.filter (fun _ v -> v != SymConst.UndefConst)

    let compare (d:fact) (e:fact) : int  = 
      UidM.compare SymConst.compare (normalize d) (normalize e)

    let to_string : fact -> string =
      UidM.to_string (fun _ v -> SymConst.to_string v)

    (* The constprop analysis should take the meet over predecessors to compute the
       flow into a node. You may find the UidM.merge function useful *)
    let combine (ds:fact list) : fact = 
      let helper (d:fact) (e:fact) : fact =
        UidM.union (
          fun (key:string) (t1:SymConst.t) (t2:SymConst.t) ->
            let x = begin match t1, t2 with
            | SymConst.Const x, SymConst.Const y -> 
              if (x = y) then (SymConst.Const x) 
              else SymConst.NonConst
            | SymConst.UndefConst, SymConst.UndefConst -> SymConst.UndefConst
            | SymConst.UndefConst, SymConst.Const x  -> SymConst.Const x
            | SymConst.Const x, SymConst.UndefConst -> SymConst.Const x
            | SymConst.NonConst, _ 
            | _, SymConst.NonConst -> SymConst.NonConst
            
            end in
            Some x
        ) d e 
      in

      List.fold_left helper UidM.empty ds       
    
  end

(* instantiate the general framework ---------------------------------------- *)
module Graph = Cfg.AsGraph (Fact)
module Solver = Solver.Make (Fact) (Graph)

(* expose a top-level analysis operation ------------------------------------ *)
let analyze (g:Cfg.t) : Graph.t =
  (* the analysis starts with every node set to bottom (the map of every uid 
     in the function to UndefConst *)
  let init l = UidM.empty in

  (* the flow into the entry node should indicate that any parameter to the
     function is not a constant *)
  let cp_in = List.fold_right 
    (fun (u,_) -> UidM.add u SymConst.NonConst)
    g.Cfg.args UidM.empty 
  in
  let fg = Graph.of_cfg init cp_in g in
  Solver.solve fg


(* run constant propagation on a cfg given analysis results ----------------- *)
(* HINT: your cp_block implementation will probably rely on several helper 
   functions.                                                                 *)
let run (cg:Graph.t) (cfg:Cfg.t) : Cfg.t =
  let open SymConst in
  

  let cp_block (l:Ll.lbl) (cfg:Cfg.t) : Cfg.t =
    let b = Cfg.block cfg l in
    let cb = Graph.uid_out cg l in




    let helper (l:(Ll.uid*Ll.insn)list) ((uid, ins): (Ll.uid* Ll.insn)) : (Ll.uid* Ll.insn) list =
      let map = cb uid in

      let map_op (op: Ll.operand)  : Ll.operand = 
        begin match op with
        | Ll.Id id 
        | Ll.Gid id ->
          let value_opt = UidM.find_opt id map in

          begin match value_opt with
          | Some SymConst.Const x -> Ll.Const x
          | _ -> op
          end
        | _ -> op
        end
      in


      let newins =
        match ins with
        | Binop (bop, ty, op1, op2) -> Binop (bop, ty, map_op op1, map_op op2)
        | Alloca ty -> Alloca ty
        | Load (ty, op) -> Load (ty, map_op op)
        | Store (ty, op1, opt2) -> Store (ty, map_op op1, map_op opt2)
        | Icmp (cnd, ty, op1, op2) -> Icmp (cnd, ty, map_op op1, map_op op2)
        | Call (ty, op, opl) -> 
          let newop = map_op op in
          let newopl = List.map (fun (ty, op) -> (ty, map_op op)) opl in
          Call (ty, newop, newopl)
        | Bitcast (ty1, op, ty2) -> Bitcast (ty1, map_op op, ty2)
        | Gep (ty, op, opl) -> 
          let newop = map_op op in
          let newopl = List.map map_op opl in
          Gep (ty, newop, newopl)
      in
      
      l@[(uid, newins)]
    in

    let ins = List.fold_left helper [] b.insns in
    let term = 
      let uid, terminator = b.term in
      let map = cb uid in

      let map_op (op: Ll.operand)  : Ll.operand = 
        begin match op with
        | Ll.Id id 
        | Ll.Gid id ->
          let value_opt = UidM.find_opt id map in

          begin match value_opt with
          | Some SymConst.Const x -> Ll.Const x
          | _ -> op
          end
        | _ -> op
        end
      in

      let newt = match terminator with
      | Br x -> Br x
      | Ret (ty, op_opt) ->
        (
        let op = match op_opt with
        | Some op -> Some (map_op op)
        | None -> None in
        Ret (ty, op)
        )
      | Cbr (op, lbl1, lbl2) -> Cbr (map_op op, lbl1, lbl2)   
      in
      (uid, newt)
    in


    let newb : Ll.block = {insns= ins; term= term} in
    
    Cfg.add_block l newb cfg

  in

  LblS.fold cp_block (Cfg.nodes cfg) cfg
