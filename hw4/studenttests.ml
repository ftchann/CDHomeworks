open Assert
open Gradedtests
open Ast
open Astlib
open Driver
(* These tests are provided by you *)

(* You should also add additional test cases here to help you   *)
(* debug your program.                                          *)
let parse_tests = [
  (* ("parse exp test 15", exp_test "2 >= 3" (no_loc (CInt 1L))) *)


]

let provided_tests : suite = [
  Test("parse tests", parse_tests);
]