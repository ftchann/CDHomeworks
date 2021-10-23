        .data
        .globl  gbl
gbl:
        .quad   1
        .quad   2
        .quad   3
        .quad   4
        .quad   5
        .quad   6
        .quad   7
        .text
        .globl  main
main:
        pushq   %rbp
        movq    %rsp, %rbp
        subq    $32, %rsp
        movq    %rdi, -8(%rbp)
        movq    %rsi, -16(%rbp)
        leaq    gbl(%rip), %rax
        movq    $0, %rdx
        imulq   $56, %rdx
        addq    %rdx, %rax
        movq    $2, %rdx
        imulq   $48, %rdx
        addq    %rdx, %rax
        movq    %rax, -24(%rbp)
        movq    -24(%rbp), %rax
        movq    (%rax), %rax
        movq    %rax, -32(%rbp)
        movq    -32(%rbp), %rax
        movq    %rbp, %rsp
        popq    %rbp
        retq
