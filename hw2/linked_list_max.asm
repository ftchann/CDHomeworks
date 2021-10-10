main:
        movq    $4194560, %rbp
        callq   init
        movq    $50, %rcx
        movq    $-40, %r8 
        .text
lbl1:
        cmpq    $1, %rcx
        jl      lbl2
        callq   cons
        incq    %r8 
        decq    %rcx
        jmp     lbl1
        .text
lbl2:
        movq    $-50, %r8 
        callq   cons
        movq    $-1, %r8 
        callq   cons
        callq   max
        retq
        .text
init:
        movq    $12669761, (%rbp)
        movq    %rbp, %rdx
        retq
        .text
cons:
        movq    %r8 , 8(%rbp)
        movq    %rdx, 16(%rbp)
        addq    $16, %rbp
        movq    %rbp, %rdx
        retq
        .text
max:
        subq    $8, %rsp
        cmpq    (%rdx), $12669761
        je      exit
        movq    -8(%rdx), (%rsp)
        movq    (%rdx), %rdx
        callq   max
        .text
lbl3:
        cmpq    %rax, (%rsp)
        jg      lbl4
        addq    $8, %rsp
        retq
        .text
lbl4:
        movq    (%rsp), %rax
        addq    $8, %rsp
        retq
        .text
exit:
        movq    $-9223372036854775808, %rax
        addq    $8, %rsp
        retq    - : unit = ()