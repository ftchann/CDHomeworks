open Assert
open Gradedtests
(* These tests are provided by you -- they will not be graded  *)

(* You should also add additional test cases here to help you   *)
(* debug your program.     

*)
let gep_tests =
  [
  "llprograms/gep9.ll", 5L;
  "llprograms/gep10.ll", 3L]

let arithmetic_tests =
  [ "llprograms/add_twice.ll", 29L 
  ; "llprograms/sub_neg.ll", 255L
  ; "llprograms/arith_combo.ll", 4L
  ; "llprograms/gcd_euclidian.ll", 2L
  ; "llprograms/return_intermediate.ll", 18L ]
  
let binary_search_tests =
  [ "llprograms/binarysearch.ll", 8L]
let provided_tests : suite = [
  GradedTest("gep tests", 10, executed gep_tests);
  GradedTest("arithmetic test", 10, executed arithmetic_tests);
  GradedTest("binarysearch test", 10, executed binary_search_tests);
] 
