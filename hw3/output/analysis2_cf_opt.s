	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$56, %rsp
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
	leaq	-64(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	$0, %rax
	movq	$49, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -48(%rbp)
	movq	$0, %rax
	cmpq	$1, %rax
	je	main.l1
	jmp	main.l2
	.text
main.l1:
	movq	-40(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	$49, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.l2:
	movq	$8, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	