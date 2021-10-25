	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$9, %rcx
	movq	$5, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$6, %rcx
	movq	$3, %rax
	imulq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$14, %rcx
	movq	$18, %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$4, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	