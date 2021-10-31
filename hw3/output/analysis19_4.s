	.data
	.globl	tmp
tmp:
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-48(%rbp), %rax
	movq	%rax, -24(%rbp)
	leaq	tmp(%rip), %rax
	movq	$0, %rdx
	imulq	$40, %rdx
	addq	%rdx, %rax
	movq	$3, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	$5, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	