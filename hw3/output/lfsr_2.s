	.text
	.globl	one_iteration
one_iteration:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$80, %rsp
	movq	%rdi, -8(%rbp)
	movq	$1, %rcx
	movq	-8(%rbp), %rax
	shlq	%cl, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$2, %rcx
	movq	-16(%rbp), %rax
	shlq	%cl, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$1, %rcx
	movq	-32(%rbp), %rax
	shlq	%cl, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	$63, %rcx
	movq	-56(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -64(%rbp)
	movq	$1, %rcx
	movq	-64(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rcx
	movq	-56(%rbp), %rax
	orq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
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
	movq	$1, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$0, %rcx
	movq	$12, %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$1, %rax
	cmpq	$1, %rax
	je	main.loop
	jmp	main.loop
	.text
main.loop:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	$1, %rcx
	movq	-48(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	callq	one_iteration
	movq	%rax, -72(%rbp)
	movq	-56(%rbp), %rax
	movq	$5, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	cmpq	$1, %rax
	je	main.end
	jmp	main.loop
	.text
main.end:
	movq	-72(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	