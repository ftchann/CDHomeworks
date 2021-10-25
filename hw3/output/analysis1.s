	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$7, %rcx
	movq	$7, %rax
	imulq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	-8(%rbp), %rcx
	movq	$42, %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	subq	$8, %rsp
	leaq	-56(%rbp), %rax
	movq	%rax, -40(%rbp)
	jmp	main.l1
	.text
main.l1:
	movq	-40(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	