	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$80, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-88(%rbp), %rax
	movq	%rax, -24(%rbp)
	subq	$8, %rsp
	leaq	-96(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	$1, %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.guard
	.text
main.body:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	$2, %rcx
	movq	-48(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.guard
	.text
main.end:
	movq	$10, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.guard:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	$10, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	cmpq	$1, %rax
	je	main.body
	jmp	main.end