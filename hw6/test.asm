        .text
        .globl  f
f:
        pushq   %rbp
        movq    %rsp, %rbp
        movq    %rcx, %r10
        movq    16(%rbp), %r11
        pushq   24(%rbp)
        popq    -8(%rbp)
        subq    $8, %rsp
        movq    %rsp, -72(%rbp)
        subq    $8, %rsp
        movq    %rsp, -64(%rbp)
        subq    $8, %rsp
        movq    %rsp, -56(%rbp)
        subq    $8, %rsp
        movq    %rsp, -48(%rbp)
        subq    $8, %rsp
        movq    %rsp, -40(%rbp)
        subq    $8, %rsp
        movq    %rsp, -32(%rbp)
        subq    $8, %rsp
        movq    %rsp, -24(%rbp)
        subq    $8, %rsp
        movq    %rsp, -16(%rbp)
        movq    %rdi, %rax
        movq    -72(%rbp), %rcx
        movq    %rax, (%rcx)
        movq    %rsi, %rax
        movq    -64(%rbp), %rcx
        movq    %rax, (%rcx)
        movq    %rdx, %rax
        movq    -56(%rbp), %rcx
        movq    %rax, (%rcx)
        movq    %r10, %rax
        movq    -48(%rbp), %rcx
        movq    %rax, (%rcx)
        movq    %r8 , %rax
        movq    -40(%rbp), %rcx
        movq    %rax, (%rcx)
        movq    %r9 , %rax
        movq    -32(%rbp), %rcx
        movq    %rax, (%rcx)
        movq    %r11, %rax
        movq    -24(%rbp), %rcx
        movq    %rax, (%rcx)
        movq    -8(%rbp), %rax
        movq    -16(%rbp), %rcx
        movq    %rax, (%rcx)
        movq    -72(%rbp), %rax
        movq    (%rax), %rax
        movq    %rax, %rsi
        movq    -64(%rbp), %rax
        movq    (%rax), %rax
        movq    %rax, %rdi
        addq    %rdi, %rsi
        movq    -56(%rbp), %rax
        movq    (%rax), %rax
        movq    %rax, %rdi
        addq    %rdi, %rsi
        movq    -48(%rbp), %rax
        movq    (%rax), %rax
        movq    %rax, %rdi
        addq    %rdi, %rsi
        movq    -40(%rbp), %rax
        movq    (%rax), %rax
        movq    %rax, %rdi
        addq    %rdi, %rsi
        movq    -32(%rbp), %rax
        movq    (%rax), %rax
        movq    %rax, %rdi
        addq    %rdi, %rsi
        movq    -24(%rbp), %rax
        movq    (%rax), %rax
        movq    %rax, %rdi
        addq    %rdi, %rsi
        movq    -16(%rbp), %rax
        movq    (%rax), %rax
        movq    %rax, %rdi
        addq    %rsi, %rdi
        movq    %rdi, %rax
        movq    %rbp, %rsp
        popq    %rbp
        retq
        .text
        .globl  main
main:
        pushq   %rbp
        movq    %rsp, %rbp
        pushq   $-3
        pushq   $-4
        movq    $-5, %r9 
        movq    $5, %r8 
        movq    $4, %rcx
        movq    $3, %rdx
        movq    $2, %rsi
        movq    $1, %rdi
        callq   f
        addq    $16, %rsp
        movq    %rax, %rdi
        movq    %rdi, %rax
        movq    %rbp, %rsp
        popq    %rbp
        retq
