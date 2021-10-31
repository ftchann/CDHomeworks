	.data
	.globl	x
x:
	.quad	1
	.data
	.globl	y
y:
	.quad	2
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$5, %rax
	leaq	y(%rip), %rdi
	movq	%rax, (%rdi)
	movq	$5, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	