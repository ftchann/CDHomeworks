	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$56, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, %rcx
	movq	$30, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$24, %rcx
	movq	$420, %rax
	subq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rcx
	movq	$24, %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	subq	$8, %rsp
	leaq	-64(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-40(%rbp), %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$420, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	