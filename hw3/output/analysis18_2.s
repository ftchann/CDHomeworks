	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$144, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-152(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$9, %rcx
	movq	$5, %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rcx
	movq	$3, %rax
	imulq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$2, %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -48(%rbp)
	jmp	main.bar
	.text
main.bar:
	subq	$8, %rsp
	leaq	-160(%rbp), %rax
	movq	%rax, -56(%rbp)
	subq	$8, %rsp
	leaq	-168(%rbp), %rax
	movq	%rax, -64(%rbp)
	subq	$8, %rsp
	leaq	-176(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-32(%rbp), %rax
	movq	-56(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-40(%rbp), %rax
	movq	-64(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-48(%rbp), %rax
	movq	-64(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.foo
	.text
main.foo:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -104(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -112(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -120(%rbp)
	movq	-112(%rbp), %rcx
	movq	-104(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -128(%rbp)
	movq	-120(%rbp), %rcx
	movq	-128(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -136(%rbp)
	movq	-136(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-136(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	