	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-32(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$42, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	