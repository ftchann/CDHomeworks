	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-56(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	$2, %rcx
	movq	$1, %rax
	imulq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$2, %rax
	movq	-40(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -48(%rbp)
	movq	$42, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	