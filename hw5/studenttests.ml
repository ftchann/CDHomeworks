open Assert
open Gradedtests

(* These tests are provided by you -- they will be graded manually *)

(* You should also add additional test cases here to help you   *)
(* debug your program.                                          *)

let tc_err_tests = [
  "ourprograms/while_rettype.oat";
  "ourprograms/struct_type.oat"
]

let tc_ok_tests = [
  "ourprograms/if_rettype.oat"
]

let global_struct_test = [
  ("ourprograms/changed_order_global_struct.oat", "", "254");
  ("ourprograms/changed_order_normal_struct.oat", "", "8");
  ("ourprograms/side_effects.oat", "", "3")
]

let provided_tests : suite = [
  Test("tc_ok_tests",typecheck_file_correct tc_ok_tests);
  Test("tc_err_tests", typecheck_file_error tc_err_tests);
  Test ("Global struct Test", executed_oat_file global_struct_test)
  
] 
