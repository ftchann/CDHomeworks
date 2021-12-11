        .text
        .globl  bar
bar:
        pushq   %rbp
        movq    %rsp, %rbp
        pushq   16(%rbp)
        popq    -8(%rbp)
        pushq   24(%rbp)
        popq    -16(%rbp)
        movq    -8(%rbp), %rax
        movq    %rbp, %rsp
        popq    %rbp
        retq
        .text
        .globl  main
main:
        pushq   %rbp
        movq    %rsp, %rbp
        pushq   $8
        pushq   $7
        movq    $6, %r9
        movq    $5, %r8
        movq    $4, %rcx
        movq    $3, %rdx
        movq    $2, %rsi
        movq    $1, %rdi
        callq   bar
        addq    $16, %rsp
        movq    %rax, %rdi
        movq    %rdi, %rax
        movq    %rbp, %rsp
        popq    %rbp
        retq
