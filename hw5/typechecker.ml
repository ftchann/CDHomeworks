open Ast
open Astlib
open Tctxt

(* Error Reporting ---------------------------------------------------------- *)
(* NOTE: Use type_error to report error messages for ill-typed programs. *)

exception TypeError of string

let type_error (l : 'a node) err =
  let _, (s, e), _ = l.loc in
  raise (TypeError (Printf.sprintf "[%d, %d] %s" s e err))

(* initial context: G0 ------------------------------------------------------ *)
(* The Oat types of the Oat built-in functions *)
let builtins =
  [
    ("array_of_string", ([ TRef RString ], RetVal (TRef (RArray TInt))));
    ("string_of_array", ([ TRef (RArray TInt) ], RetVal (TRef RString)));
    ("length_of_string", ([ TRef RString ], RetVal TInt));
    ("string_of_int", ([ TInt ], RetVal (TRef RString)));
    ("string_cat", ([ TRef RString; TRef RString ], RetVal (TRef RString)));
    ("print_string", ([ TRef RString ], RetVoid));
    ("print_int", ([ TInt ], RetVoid));
    ("print_bool", ([ TBool ], RetVoid));
  ]

(* binary operation types --------------------------------------------------- *)
let typ_of_binop : Ast.binop -> Ast.ty * Ast.ty * Ast.ty = function
  | Add | Mul | Sub | Shl | Shr | Sar | IAnd | IOr -> (TInt, TInt, TInt)
  | Lt | Lte | Gt | Gte -> (TInt, TInt, TBool)
  | And | Or -> (TBool, TBool, TBool)
  | Eq | Neq -> failwith "typ_of_binop called on polymorphic == or !="

(* unary operation types ---------------------------------------------------- *)
let typ_of_unop : Ast.unop -> Ast.ty * Ast.ty = function
  | Neg | Bitnot -> (TInt, TInt)
  | Lognot -> (TBool, TBool)

(* subtyping ---------------------------------------------------------------- *)
(* Decides whether H |- t1 <: t2 
    - assumes that H contains the declarations of all the possible struct types

    - you will want to introduce addition (possibly mutually recursive) 
      helper functions to implement the different judgments of the subtyping
      relation. We have included a template for subtype_ref to get you started.
      (Don't forget about OCaml's 'and' keyword.)
*)

let rec subtype (c : Tctxt.t) (t1 : Ast.ty) (t2 : Ast.ty) : bool =
  match (t1, t2) with
  | TInt, TInt -> true
  | TBool, TBool -> true
  | TNullRef r1, TNullRef r2 -> subtype_ref c r1 r2
  | TRef r1, TRef r2 -> subtype_ref c r1 r2
  | TRef r1, TNullRef r2 -> subtype_ref c r1 r2
  | _ -> false

(* Decides whether H |-r ref1 <: ref2 *)
and subtype_ref (c : Tctxt.t) (t1 : Ast.rty) (t2 : Ast.rty) : bool =
  match (t1, t2) with
  | RString, RString -> true
  | RArray t1, RArray t2 -> t1 = t2
  | RStruct xx, RStruct yy -> (
      let s1 = Tctxt.lookup_struct_option xx c in
      let s2 = Tctxt.lookup_struct_option yy c in
      (* looked up as option since error if struct doesnt exist dunno if necessary tho
         cuz its not really wrong typed if it doesnt exist..*)
      match (s1, s2) with
      | Some x, Some y ->
          (* checks field for field if the type is the same *)
          let rec checker (l1 : Ast.field list) (l2 : Ast.field list) : bool =
            match (l1, l2) with
            | a :: b, d :: e ->
                if a.ftyp = d.ftyp && String.equal a.fieldName d.fieldName then
                  checker b e
                else false
            | _, [] -> true
            | [], a :: b -> false
          in

          checker x y
      | _ -> false )
  | RFun (t1, rt1), RFun (t2, rt2) ->
      (* checking param for param if they are subtype of eachother... *)
      let rec checker (l1 : Ast.ty list) (l2 : Ast.ty list) : bool =
        match (l1, l2) with
        | a :: b, d :: e -> if subtype c d a then checker b e else false
        | [], [] -> true
        | _ -> false
      in

      (*subtype of return*)
      let subret (l1 : Ast.ret_ty) (l2 : Ast.ret_ty) : bool =
        match (l1, l2) with
        | RetVoid, RetVoid -> true
        | RetVal x, RetVal y -> subtype c x y
        | _ -> false
      in

      checker t1 t2 && subret rt1 rt2
  | _ -> false

(* well-formed types -------------------------------------------------------- *)
(* Implement a (set of) functions that check that types are well formed according
   to the H |- t and related inference rules

    - the function should succeed by returning () if the type is well-formed
      according to the rules

    - the function should fail using the "type_error" helper function if the 
      type is 

    - l is just an ast node that provides source location information for
      generating error messages (it's only needed for the type_error generation)

    - tc contains the structure definition context
 *)
let rec typecheck_ty (l : 'a Ast.node) (tc : Tctxt.t) (t : Ast.ty) : unit =
  match t with
  | TInt -> ()
  | TBool -> ()
  | TRef x -> typeref l tc x
  | TNullRef x -> typeref l tc x

and typeref (l : 'a Ast.node) (tc : Tctxt.t) (t : Ast.rty) : unit =
  match t with
  | RString -> ()
  | RArray t -> typecheck_ty l tc t
  | RStruct x -> (
      let s = Tctxt.lookup_struct_option x tc in
      match s with
      | Some y -> ()
      | None -> type_error l @@ "TypeError in typeref for " ^ x )
  | RFun (tl, rt) ->
      List.iter (fun x -> typecheck_ty l tc x) tl;
      typeret l tc rt

and typeret (l : 'a Ast.node) (tc : Tctxt.t) (t : ret_ty) : unit =
  match t with RetVoid -> () | RetVal x -> typecheck_ty l tc x

(* typechecking expressions ------------------------------------------------- *)
(* Typechecks an expression in the typing context c, returns the type of the
   expression.  This function should implement the inference rules given in the
   oad.pdf specification.  There, they are written:

       H; G; L |- exp : t

   See tctxt.ml for the implementation of the context c, which represents the
   four typing contexts: H - for structure definitions G - for global
   identifiers L - for local identifiers

   Returns the (most precise) type for the expression, if it is type correct
   according to the inference rules.

   Uses the type_error function to indicate a (useful!) error message if the
   expression is not type correct.  The exact wording of the error message is
   not important, but the fact that the error is raised, is important.  (Our
   tests also do not check the location information associated with the error.)

   Notes: - Structure values permit the programmer to write the fields in any
   order (compared with the structure definition).  This means that, given the
   declaration struct T { a:int; b:int; c:int } The expression new T {b=3; c=4;
   a=1} is well typed.  (You should sort the fields to compare them.)

*)
let rec typecheck_exp (c : Tctxt.t) (e : Ast.exp node) : Ast.ty =
  match e.elt with
  | CNull x -> TNullRef x
  | CBool x -> TBool
  | CInt x -> TInt
  | CStr x -> TRef RString
  | Id x -> (
      let id = Tctxt.lookup_option x c in
      match id with
      | Some t -> t
      | None -> type_error e @@ "Didnt find Id named: " ^ x )
  | CArr (ty, list) ->
      let all_good =
        List.fold_left
          (fun b exp ->
            let cty = typecheck_exp c exp in
            if subtype c cty ty then b && true else false)
          true list
      in
      if all_good then TRef (RArray ty) else type_error e @@ "TypeError in CArr"
  | NewArr (ty, len, id, exp2) ->
      let lty = typecheck_exp c len in
      if lty = TInt then
        let cnew = Tctxt.add_local c id TInt in
        let cty = typecheck_exp cnew exp2 in
        if subtype c cty ty then TRef (RArray ty)
        else type_error e @@ "TypeError in NewArr"
      else type_error e @@ "TypeError in NewArr"
  | Index (arr, i) ->
      let arr_ty = typecheck_exp c arr in
      let i_ty = typecheck_exp c i in
      if i_ty = TInt then
        match arr_ty with
        | TRef (RArray t) -> t
        | _ -> type_error e @@ "TypeError in Index"
      else type_error e @@ "TypeError in Index"
  | Length arr -> (
      let arr_ty = typecheck_exp c arr in
      match arr_ty with
      | TRef (RArray _) -> TInt
      | _ -> type_error e @@ "TypeError in Length"
      (* fields is of type cfield list*) )
  | CStruct (structName, fields) -> (
      let hlistOpt = Tctxt.lookup_struct_option structName c in
      match hlistOpt with
      | Some h ->
          let hlist = h in
          let sorted_hlist =
            List.sort
              (fun (a : field) (b : field) ->
                let a_name = a.fieldName in
                let b_name = b.fieldName in
                compare a_name b_name)
              hlist
          in
          let sorted_fields =
            List.sort
              (fun (a : Ast.cfield) (b : Ast.cfield) ->
                let a_name, _ = a in
                let b_name, _ = b in
                compare a_name b_name)
              fields
          in
          (* ensure length for zipWith*)
          if List.length sorted_fields = List.length sorted_hlist then
            (* map2 = zipWith*)
            let all_good_list =
              List.map2
                (fun (a : field) (b : Ast.cfield) ->
                  let aty = a.ftyp in
                  let _, bexp = b in
                  let bty = typecheck_exp c bexp in
                  subtype c bty aty)
                sorted_hlist sorted_fields
            in
            let all_good =
              List.fold_left (fun a b -> a && b) true all_good_list
            in

            if all_good then TRef (RStruct structName)
            else type_error e @@ "TypeError in CStruct fields"
          else type_error e @@ "TypeError length is wrong"
      | None -> type_error e @@ "TypeError in CStruct None??" )
  | Proj (exp, id) -> (
      let ty = typecheck_exp c exp in
      let structname =
        match ty with
        | TRef (RStruct x) -> x
        | _ -> type_error e @@ "TypeError in Proj"
      in
      let hlistOpt = Tctxt.lookup_struct_option structname c in

      match hlistOpt with
      | Some h -> (
          let hlist = h in
          let field_opt =
            List.find_opt
              (fun (a : field) ->
                let fieldName = a.fieldName in
                fieldName = id)
              hlist
          in
          match field_opt with
          | Some field -> field.ftyp
          | None -> type_error e @@ "TypeError in Proj Field not found" )
      | None -> type_error e @@ "TypeError in Proj Struct not found" )
  | Call (func_exp, arg_list) -> (
      let func_ty = typecheck_exp c func_exp in
      match func_ty with
      | TRef (RFun (param_list, RetVal ty)) ->
          if List.length param_list = List.length arg_list then
            let all_good_list =
              List.map2
                (fun (a : Ast.exp node) (b : Ast.ty) ->
                  let aty = typecheck_exp c a in
                  subtype c aty b)
                arg_list param_list
            in

            let all_good =
              List.fold_left (fun a b -> a && b) true all_good_list
            in
            if all_good then ty else type_error e @@ "TypeError in Call"
          else type_error e @@ "TypeError in Call wrong length"
      | _ -> type_error e @@ "TypeError in Call" )
  | Bop (op, exp1, exp2) -> (
      match op with
      | Eq | Neq ->
          let ty1 = typecheck_exp c exp1 in
          let ty2 = typecheck_exp c exp2 in
          if subtype c ty1 ty2 && subtype c ty2 ty1 then TBool
          else type_error e @@ "TypeError in Eq"
      | _ ->
          let ty1 = typecheck_exp c exp1 in
          let ty2 = typecheck_exp c exp2 in
          let cty1, cty2, ty = typ_of_binop op in
          if cty1 = ty1 && cty2 = ty2 then ty
          else type_error e @@ "TypeError in Bop" )
  | Uop (op, expr) -> (
      match op with
      | Bitnot | Neg -> (
          let ty = typecheck_exp c expr in
          match ty with
          | TInt -> TInt
          | _ -> type_error e @@ "uop shouldve been of type int" )
      | Lognot -> (
          let ty = typecheck_exp c expr in
          match ty with
          | TBool -> TBool
          | _ -> type_error e @@ "uop with lognot shouldve been of type bool" )
      )

(* statements --------------------------------------------------------------- *)

(* Typecheck a statement 
   This function should implement the statment typechecking rules from oat.pdf.  

   Inputs:
    - tc: the type context
    - s: the statement node
    - to_ret: the desired return type (from the function declaration)

   Returns:
     - the new type context (which includes newly declared variables in scope
       after this statement
     - A boolean indicating the return behavior of a statement:
        false:  might not return
        true: definitely returns 

        in the branching statements, both branches must definitely return

        Intuitively: if one of the two branches of a conditional does not 
        contain a return statement, then the entier conditional statement might 
        not return.
  
        looping constructs never definitely return 

   Uses the type_error function to indicate a (useful!) error message if the
   statement is not type correct.  The exact wording of the error message is
   not important, but the fact that the error is raised, is important.  (Our
   tests also do not check the location information associated with the error.)

   - You will probably find it convenient to add a helper function that implements the 
     block typecheck rules.
*)
let rec typecheck_stmt (tc : Tctxt.t) (s : Ast.stmt node) (to_ret : ret_ty) :
    Tctxt.t * bool =
  let bodyhelper ((c, flag) : Tctxt.t * bool) (s : stmt node) : Tctxt.t * bool =
    if flag then type_error s @@ "We already had an return in the block"
    else typecheck_stmt c s to_ret
  in

  match s.elt with
  | Assn (lhs, expr) ->
      (* check if t in L or not global function id *)
      (*let func : Ast.ty = TRef (RFun (typs, y.frtyp)) in*)
      ( match lhs.elt with
      | Id t -> (
          match Tctxt.lookup_local_option t tc with
          | Some y -> ()
          | None -> (
              match Tctxt.lookup_global_option t tc with
              | Some (TRef (RFun (_, _))) ->
                  type_error s
                  @@ "lefthandside of assignment is globalfunction with name: "
                  ^ t
              | _ -> () ) )
      | _ -> () );

      let e = typecheck_exp tc expr in
      let l = typecheck_exp tc lhs in

      if subtype tc e l then (tc, false)
      else type_error s @@ "Tried to assign wrong type"
  | Decl (id, expr) ->
      let x = Tctxt.lookup_local_option id tc in

      let _ =
        match x with
        | Some _ -> type_error s @@ "variable is already declared: " ^ id
        | None -> ()
      in

      let ty = typecheck_exp tc expr in

      (Tctxt.add_local tc id ty, false)
  | Ret exp -> (
      match (exp, to_ret) with
      | Some e, RetVal x ->
          let typ : Ast.ty = typecheck_exp tc e in
          if subtype tc typ x then (tc, true)
          else type_error s @@ "Wrong return type"
      (* Maybe e can be a void too... but I think its not possible with the rules *)
      | Some e, RetVoid -> type_error s @@ "Expected Void as return type"
      | None, RetVal x ->
          type_error s @@ "Got void return type but expected another type"
      | None, RetVoid -> (tc, true) )
  | SCall (f, args) -> (
      let func = typecheck_exp tc f in

      let typs2 = List.map (fun x -> typecheck_exp tc x) args in

      let rec checker l1 l2 : bool =
        match (l1, l2) with
        | x :: y, z :: t -> if subtype tc x z then checker y t else true
        | [], [] -> false
        | _ -> true
      in

      match func with
      | (TRef (RFun (typs, rettyp)) | TNullRef (RFun (typs, rettyp)))
        when rettyp = RetVoid ->
          if checker typs2 typs then
            type_error s @@ "SCall param types dont match"
          else (tc, false)
      | _ -> type_error s @@ "Scall statement wasnt a function" )
  | If (expr, b1, b2) ->
      let e = typecheck_exp tc expr in

      if e <> TBool then type_error s "expr in if wasn't of type boolean"
      else
        let _, r1 = List.fold_left bodyhelper (tc, false) b1 in
        let _, r2 = List.fold_left bodyhelper (tc, false) b2 in

        (* we did return if both blocks return *)
        (tc, r1 && r2)
  | Cast (ref, id, exp, b1, b2) ->
      let e = typecheck_exp tc exp in

      let refN =
        match e with
        | TNullRef r -> r
        | _ -> type_error s @@ "expr in cast wasnt of type TNullRef: " ^ id
      in

      if subtype_ref tc refN ref then
        (* add to local context if type isnt null *)
        let new_c = Tctxt.add_local tc id (TRef ref) in
        let _, r1 = List.fold_left bodyhelper (new_c, false) b1 in
        let _, r2 = List.fold_left bodyhelper (tc, false) b2 in
        (tc, r1 && r2)
      else type_error s @@ "nullref wasnt subtype of ref: " ^ id
  | For (vdecls, expopt, stmtopt, block) ->
      (* declare new variables *)
      let new_c =
        List.fold_left
          (fun (c : Tctxt.t) (id, expr) ->
            let e = typecheck_exp c expr in
            Tctxt.add_local c id e)
          tc vdecls
      in

      let _ =
        match expopt with
        | Some e ->
            if TBool <> typecheck_exp new_c e then
              type_error s @@ "expr not bool in for loop"
        | None -> ()
      in

      let _ =
        match stmtopt with
        | Some s -> typecheck_stmt new_c s to_ret
        | None -> (tc, false)
      in

      (* does never return *)
      let _, _ = List.fold_left bodyhelper (new_c, false) block in
      (tc, false)
  | While (exp, block) ->
      if TBool <> typecheck_exp tc exp then
        type_error s @@ "wrong typed condition in while"
      else
        (* does never return *)
        let _, _ = List.fold_left bodyhelper (tc, false) block in
        (tc, false)

(* struct type declarations ------------------------------------------------- *)
(* Here is an example of how to implement the TYP_TDECLOK rule, which is 
   is needed elswhere in the type system.
 *)

(* Helper function to look for duplicate field names *)
let rec check_dups fs =
  match fs with
  | [] -> false
  | h :: t -> List.exists (fun x -> x.fieldName = h.fieldName) t || check_dups t

let typecheck_tdecl (tc : Tctxt.t) id fs (l : 'a Ast.node) : unit =
  if check_dups fs then type_error l ("Repeated fields in " ^ id)
  else List.iter (fun f -> typecheck_ty l tc f.ftyp) fs

(* function declarations ---------------------------------------------------- *)
(* typecheck a function declaration 
    - extends the local context with the types of the formal parameters to the 
      function
    - typechecks the body of the function (passing in the expected return type
    - checks that the function actually returns
*)
let typecheck_fdecl (tc : Tctxt.t) (f : Ast.fdecl) (l : 'a Ast.node) : unit =
  let rec checker (c : Tctxt.local_ctxt) vn : bool =
    match c with
    | x :: y -> if fst x <> vn then checker y vn else true
    | [] -> false
  in

  let helper (c : Tctxt.t) (arg : Ast.ty * Ast.id) : Tctxt.t =
    if checker tc.locals (snd arg) then
      type_error l @@ "Two params have the same name: " ^ snd arg
    else Tctxt.add_local c (snd arg) (fst arg)
  in

  (* extending the context with local variables *)
  let new_c = List.fold_left helper tc f.args in

  let bodyhelper ((c, flag) : Tctxt.t * bool) (s : stmt node) : Tctxt.t * bool =
    if flag then type_error s @@ "We already had an return in " ^ f.fname
    else typecheck_stmt c s f.frtyp
  in

  (* THIS ISNT FINAL *)
  (*
       we shouldnt iterate over statements like that I think
       But I dont know how to deal with it... Do we always only return at the end?
       Are we allowed to return in the middle of a block? What about returns in if's?
       Idea atm to simply throw type error if flag is already set and we keep iterating...
       maybe its the wrong direction or what ever..

       It might even be right I think..
  *)
  let last_c, breturn = List.fold_left bodyhelper (new_c, false) f.body in
  if not breturn then type_error l @@ "No return statement in " ^ f.fname

(* creating the typchecking context ----------------------------------------- *)

(* The following functions correspond to the
   judgments that create the global typechecking context.

   create_struct_ctxt: - adds all the struct types to the struct 'S'
   context (checking to see that there are no duplicate fields

     H |-s prog ==> H'


   create_function_ctxt: - adds the the function identifiers and their
   types to the 'F' context (ensuring that there are no redeclared
   function identifiers)

     H ; G1 |-f prog ==> G2


   create_global_ctxt: - typechecks the global initializers and adds
   their identifiers to the 'G' global context

     H ; G1 |-g prog ==> G2    


   NOTE: global initializers may mention function identifiers as
   constants, but can't mention other global values *)

let create_struct_ctxt (p : Ast.prog) : Tctxt.t =
  (* return true if duplicate struct *)
  let rec checker (s : Tctxt.struct_ctxt) (sn : string) : bool =
    match s with
    | x :: y -> if fst x <> sn then checker y sn else true
    | [] -> false
  in

  let helper (c : Tctxt.t) (d : Ast.decl) : Tctxt.t =
    match d with
    | Gtdecl x ->
        let sn, fl = x.elt in

        if checker c.structs sn then
          type_error x @@ "Duplicate struct with name: " ^ sn
        else Tctxt.add_struct c sn fl
    | _ -> c
  in

  List.fold_left helper Tctxt.empty p

let rec checker (s : Tctxt.global_ctxt) (fn : string) : bool =
  match s with
  | x :: y -> if fst x <> fn then checker y fn else true
  | [] -> false

let create_function_ctxt (tc : Tctxt.t) (p : Ast.prog) : Tctxt.t =
  (* addint builtin function cuz I forgot them ,,,, *)
  let builtinhelper (c : Tctxt.t) d : Tctxt.t =
    let fn = fst d in
    let sec = snd d in

    let func : Ast.ty = TRef (RFun (fst sec, snd sec)) in

    if checker c.globals fn then failwith "builtin already defined"
    else Tctxt.add_global c fn func
  in

  (*[ "array_of_string",  ([TRef RString],  RetVal (TRef(RArray TInt)))*)
  let helper (c : Tctxt.t) (d : Ast.decl) : Tctxt.t =
    match d with
    | Gfdecl x ->
        let y = x.elt in
        let fn = y.fname in

        (* builds type list for later *)
        let typs = List.map (fun x -> fst x) y.args in

        let func : Ast.ty = TRef (RFun (typs, y.frtyp)) in

        if checker c.globals fn then
          type_error x @@ "Duplicate function with name: " ^ fn
        else Tctxt.add_global c y.fname func
    | _ -> c
  in

  let newc = List.fold_left helper tc p in
  List.fold_left builtinhelper newc builtins

let create_global_ctxt (tc : Tctxt.t) (p : Ast.prog) : Tctxt.t =
  let helper (c : Tctxt.t) (d : Ast.decl) : Tctxt.t =
    match d with
    | Gvdecl x ->
        let y = x.elt in
        let vn = y.name in

        let vtyp : Ast.ty = typecheck_exp tc y.init in

        if checker c.globals vn then
          type_error x @@ "Duplicate function with name: " ^ vn
        else Tctxt.add_global c y.name vtyp
    | _ -> c
  in

  List.fold_left helper tc p

(* This function implements the |- prog and the H ; G |- prog 
   rules of the oat.pdf specification.   
*)
let typecheck_program (p : Ast.prog) : unit =
  let sc = create_struct_ctxt p in
  let fc = create_function_ctxt sc p in
  let tc = create_global_ctxt fc p in
  List.iter
    (fun p ->
      match p with
      | Gfdecl ({ elt = f } as l) -> typecheck_fdecl tc f l
      | Gtdecl ({ elt = id, fs } as l) -> typecheck_tdecl tc id fs l
      | _ -> ())
    p
