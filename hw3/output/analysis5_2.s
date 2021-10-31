	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$2, %rcx
	movq	$5, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$5, %rcx
	movq	$2, %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$2, %rcx
	movq	-24(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	