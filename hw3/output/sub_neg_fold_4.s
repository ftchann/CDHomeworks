	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$10, %rcx
	movq	$9, %rax
	subq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$-1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	