#mod_use "x86/x86.ml";;
#load "nums.cma";;
#mod_use "int64_overflow.ml";;
#mod_use "util/assert.ml";;
#mod_use "simulator.ml";;

#use "simulator.ml";;
#use "gradedtests.ml";;
#use "providedtests.ml";;
#use "studenttests.ml";;
let () = 
  begin
    Simulator.debug_simulator := true;
  end


let nil = 0xC15341 
  let cnt = 50 
  let start = -40 
  let pen_ult = -50 
  let ult = -1 
  let heap_top = 0x400100 

  (* Part 3 program: linked_list_max
   *
   * Description: Provides functionality to initialize and add elements to a
   * linked list. Given program adds cnt integers to the linked list, starting at
   * the value of start and incrementing by one for each subsequent element.
   * Additionally, two final elements, pen_ult and ult, are added manually to
   * allow for different test cases to be implemented. The program then finds
   * the maximum element of the list.
   *
   * Registers: *)
  
  let linked_list_max =
    [ text "main"
        [ Movq, [~$heap_top; ~%Rbp]
        ; Callq, [~$$"init"]
        ; Movq, [~$cnt; ~%Rcx]
        ; Movq, [~$start; ~%R08]
        ]
    ; text "lbl1"
        [ Cmpq, [~$1; ~%Rcx]
        ; J Lt, [~$$"lbl2"]
        ; Callq, [~$$"cons"]
        ; Incq, [~%R08]
        ; Decq, [~%Rcx]
        ; Jmp, [~$$"lbl1"]
        ]
    ; text "lbl2"
        [ Movq, [~$pen_ult; ~%R08]
        ; Callq, [~$$"cons"]
        ; Movq, [~$ult; ~%R08]
        ; Callq, [~$$"cons"]
        ; Callq, [~$$"max"]
        ; Retq, []
        ]
    ; text "init"
        [ Movq, [~$nil; Ind2 Rbp]
        ; Movq, [~%Rbp; ~%Rdx]
        ; Retq, []
        ]
    ; text "cons"
        [ Movq, [~%R08; Ind3 (Lit 8L, Rbp)]
        ; Movq, [~%Rdx; Ind3 (Lit 16L, Rbp)]
        ; Addq, [~$16; ~%Rbp]
        ; Movq, [~%Rbp; ~%Rdx]
        ; Retq, []
        ]
    ; text "max"
        [ Subq, [~$8; ~%Rsp]
        ; Cmpq, [Ind2 Rdx; ~$nil]
        ; J Eq, [~$$"exit"]
        ; Movq, [Ind3 (Lit (Int64.neg 8L), Rdx); Ind2 Rsp]
        ; Movq, [Ind2 Rdx; ~%Rdx]
        ; Callq, [~$$"max"]
        ]
    ; text "lbl3"
        [ Cmpq, [~%Rax; Ind2 Rsp]
        ; J Gt, [~$$"lbl4"]
        ; Addq, [~$8; ~%Rsp]
        ; Retq, []
        ]
    ; text "lbl4"
        [ Movq, [Ind2 Rsp; ~%Rax]
        ; Addq, [~$8; ~%Rsp]
        ; Retq, []
        ]
    ; text "exit"
        [ Movq, [Imm (Lit (Int64.min_int)); ~%Rax]
        ; Addq, [~$8; ~%Rsp]
        ; Retq, []
        ]
    ];;

let x = assemble linked_list_max
let y = load x


(*let z = run y*)