	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$88, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$64, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	subq	$8, %rsp
	leaq	-96(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	$12, %rcx
	movq	$4, %rax
	imulq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	$52, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	cmpq	$1, %rax
	je	main.then
	jmp	main.else
	.text
main.then:
	movq	$8, %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.merge
	.text
main.else:
	movq	$0, %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.merge
	.text
main.merge:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	