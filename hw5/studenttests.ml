open Assert
open Gradedtests

(* These tests are provided by you -- they will be graded manually *)

(* You should also add additional test cases here to help you   *)
(* debug your program.                                          *)

let global_struct_test = [
  ("ourprograms/changed_order_global_struct.oat", "", "254");
  ("ourprograms/changed_order_normal_struct.oat", "", "8")
]

let provided_tests : suite = [
  Test ("Global struct Test", executed_oat_file global_struct_test)
  
] 
