	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
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
	movq	$18, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	