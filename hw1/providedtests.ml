open Assert
open Hellocaml

(* These tests are provided by you -- they will NOT be graded *)

(* You should also add additional test cases here to help you   *)
(* debug your program.                                          *)

let case1 : exp = Neg (Neg (Var "x"))
let case2 : exp = Neg (Neg (Const 1L))
let case3 : exp = Mult(Neg(Const 1L), Var "x")
let case4 : exp = (Mult(Neg(Const 1L), Neg(Var "x")))



let provided_tests : suite = [
  Test ("Student-Provided Tests For Problem 1-3", [
    ("case1", assert_eqf (fun () -> 42) prob3_ans );
    ("case2", assert_eqf (fun () -> 25) (prob3_case2 17) );
    ("case3", assert_eqf (fun () -> prob3_case3) 64);
  ]);

  Test ("Student-Provided Tests For Problem 4-5", [
    ("case1", assert_eqf (fun () -> optimize case1) (Var "x"));
    ("case2", assert_eqf (fun () -> optimize case2) (Const 1L));
    ("case3", assert_eqf (fun () -> optimize case3) (Neg( Var "x")));
    ("case4", assert_eqf (fun () -> optimize case4)  (Var "x"));
  ]);


  
] 
