	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	-40(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	