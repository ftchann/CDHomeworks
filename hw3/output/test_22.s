	.data
	.globl	gbl
gbl:
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.quad	5
	.quad	6
	.quad	7
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, %rax
	movq	$0, %rdi
	addq	%rdi, %rax
	movq	%rax, -24(%rbp)
	movq	$0, $0
	movq	$0, $0
	movq	-40(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	