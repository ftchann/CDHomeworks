open Assert
open X86
open Simulator
open Asm
open Xor_test
open Add_test
open Sub_test
open Shift_test
open Invalid_test
open Kek

(* These tests are provided by you -- they will be graded manually *)

(* You should also add additional test cases here to help you   *)
(* debug your program.                                          *)


let program_test (p:prog) (ans:int64) () =
  let res = assemble p |> load |> run in
  if res <> ans
  then failwith (Printf.sprintf("Expected %Ld but got %Ld") ans res)
  else ()

let reverse a = 
      [ text "main"
          [ Movq,  [~$a; ~%R08] (* number *)
          ; Movq,  [~$0; ~%R09] (* accumulated *)
          ; Callq, [~$$"reverse"]
          ; Retq,  []
          ]
      ; text "reverse"
          [ Cmpq,  [~$0; ~%R08] 
          ; J Eq,  [~$$"return"]
          ; Movq,  [~$0; ~%R11] (* R11 is counter *)
          ; Movq,  [~%R08; ~%R12]
          ; Callq, [~$$"divide_by_10"] 
          ; Movq,  [~%R08; ~%R10]
          ; Callq, [~$$"mod_10"] 
          ; Imulq, [~$10; ~%R09] (* multiplies acc by 10 *)
          ; Addq,  [~%R10; ~%R09]
          ; Movq,  [~%R12; ~%R08]
          ; Jmp,   [~$$"reverse"]
          ]
      ; text "divide_by_10"     (* divides R08 by 10, puts it R11*)
       	  [ Cmpq,  [~$10; ~%R12]
          ; J Lt,  [~$$"div_ret"]
          ; Subq,  [~$10; ~%R12]
          ; Addq,  [~$1; ~%R11]
          ; Jmp,   [~$$"divide_by_10"]
          ]
      ; text "mod_10"            (* stores R08 % 10 in R10 *)
       	  [ Cmpq,  [~$10; ~%R10]
          ; J Lt,  [~$$"mod_ret"]
          ; Subq,  [~$10; ~%R10]
          ; Jmp,   [~$$"mod_10"]
          ]
      ; text "div_ret"
      	  [ Movq,  [~%R11; ~%R12]
      	  ; Retq,  []
      	  ]
      ; text "mod_ret"
      	  [ Retq,  [] ]
      ; text "return"
       	  [ Movq,  [~%R09; ~%Rax]
          ; Retq,  []
          ]
      ]

let indr =  
  [
    text "main" 
    [
      Movq, [~$(-11134); Ind1 (Lit 0x400300L)]
    ; Movq, [Ind1 (Lit 0x400300L); ~%Rax]
    ; Retq, []
    ]
  ]

let indr2 =  
  [
    text "main" 
    [
      Movq, [~$(0x400200); ~%Rax]
    ; Movq, [~$(-11134); Ind2 (Rax)]
    ; Movq, [Ind2 (Rax); ~%Rax]
    ; Retq, []
    ]
  ]

let indr3 = 
  [
    text "main"
    [
      Movq, [~$(0x400200); ~%Rax]
    ; Movq, [~$(-11134); Ind3 (Lit 3L, Rax)]
    ; Movq, [Ind1 (Lit 0x400203L); ~%Rax]
    ; Retq, []
    ]
  ]

let set1 =
  [
    text "main"
    [
      Movq, [~$(0x400200); ~%Rdx]
    ; Movq, [Imm (Lit 0xDEADBEEFBEEFEED0L); Ind2 Rdx]
    ; Cmpq, [~$0; ~$0]
    ; Set Eq, [Ind2 Rdx]
    ; Movq, [Ind2 Rdx; ~%Rax]
    ; Retq, []
    ]
  ]
let set2 =
  [
    text "main"
    [
      Movq, [~$(0x400200); ~%Rdx]
    ; Movq, [Imm (Lit 0xDEADBEEFBEEFDEADL); Ind2 Rdx]
    ; Cmpq, [~$0; ~$1]
    ; Set Eq, [Ind2 Rdx]
    ; Movq, [Ind2 Rdx; ~%Rax]
    ; Retq, []
    ]
  ]

let set3 = 
  [
    text "main"
    [
      Movq, [Imm (Lit 0xDEADBEEFBEEFDEADL); ~%Rax]
    ; Cmpq, [~$0; ~$0]
    ; Set Eq, [~%Rax]
    ; Retq, []
    ]
  ]


let provided_tests : suite = [
  Test ("Student-Provided Big Test for Part III: Score recorded as PartIIITestCase", [
  	("12", program_test (reverse 12) 21L);
  	("12345", program_test (reverse 12345) 54321L);
  	("222", program_test (reverse 222) 222L);
  	("9", program_test (reverse 9) 9L);
  	("17471", program_test (reverse 17471) 17471L);
  	("bigger number", program_test 
  		(reverse 256367) 763652L);
  	(* should not work for negatives! *)
  	("keep negs the same", program_test (reverse (-19)) (-19L)); 
    ("blub" , program_test indr (-11134L));
    ("blub2" , program_test indr2 (-11134L));
    ("blub2" , program_test indr3 (-11134L));
    ("set1"), program_test set1 0xDEADBEEFBEEFEE01L;
    ("set2"), program_test set2 0xDEADBEEFBEEFDE00L;
    ("set3"), program_test set3 0xDEADBEEFBEEFDE01L;
  ]);
  Test ("Debug", []);
  (* Test ("all_the_xor", xor_tests);
  Test ("all_the_add", add_tests); *)
  Test ("all_the_sub", sub_tests);
  (* Test ("all_the_shift", shift_tests);
  Test ("all_the_invalid", invalid_tests);
  Test ("all_the_kek", kek_tests); *)

] 
let () = 
let str = string_of_prog indr3 in
Printf.printf "%s" str