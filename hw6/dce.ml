(** Dead Code Elimination  *)
open Ll
open Datastructures


(* expose a top-level analysis operation ------------------------------------ *)
(* TASK: This function should optimize a block by removing dead instructions
   - lb: a function from uids to the live-OUT set at the 
     corresponding program point
   - ab: the alias map flowing IN to each program point in the block
   - b: the current ll block

   Note: 
     Call instructions are never considered to be dead (they might produce
     side effects)

     Store instructions are not dead if the pointer written to is live _or_
     the pointer written to may be aliased.

     Other instructions are dead if the value they compute is not live.

   Hint: Consider using List.filter
 *)
let dce_block (lb:uid -> Liveness.Fact.t) 
              (ab:uid -> Alias.fact)
              (b:Ll.block) : Ll.block =
  (*We will simply compute the results of the analysis at each program point, 
  then iterate over the blocks of the CFG removing any instructions that do not contribute
   to the output of the program.
   
   For all instructions except store and call, the instruction can be removed if the UID it defines is not live-out at the point of definition

    A store instruction can be remove if we know the UID of the destination pointer is not aliased and not live-out 
      at the program
   point of the store
A call instruction can never be removed
   *)

  let helper (uid, ins) : bool = 
    match ins with
    | Store (_, _, Id x) ->
      let live_set = lb uid in
      if (UidS.mem x live_set) then true
      else (
      let alias_set = ab uid in
        let res = UidM.find_opt x alias_set in
        match res with
        | None 
        | Some Alias.SymPtr.UndefAlias 
        | Some Alias.SymPtr.Unique -> false
        | Some Alias.SymPtr.MayAlias -> true
      )
    (* always true with gid *)
    | Store _ -> true
    | Call _ -> true
    | _ -> 
      let live_set = lb uid in
      UidS.mem uid live_set
  in
   
  let newins = List.filter helper b.insns in
  {insns= newins; term = b.term}

   

let run (lg:Liveness.Graph.t) (ag:Alias.Graph.t) (cfg:Cfg.t) : Cfg.t =

  LblS.fold (fun l cfg ->
    let b = Cfg.block cfg l in

    (* compute liveness at each program point for the block *)
    let lb = Liveness.Graph.uid_out lg l in

    (* compute aliases at each program point for the block *)
    let ab = Alias.Graph.uid_in ag l in 

    (* compute optimized block *)
    let b' = dce_block lb ab b in
    Cfg.add_block l b' cfg
  ) (Cfg.nodes cfg) cfg

