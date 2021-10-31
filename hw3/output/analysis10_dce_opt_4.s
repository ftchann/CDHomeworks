	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$168, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-176(%rbp), %rax
	movq	%rax, -24(%rbp)
	subq	$8, %rsp
	leaq	-184(%rbp), %rax
	movq	%rax, -32(%rbp)
	subq	$8, %rsp
	leaq	-192(%rbp), %rax
	movq	%rax, -40(%rbp)
	subq	$8, %rsp
	leaq	-200(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	$3, %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-208(%rbp), %rax
	movq	%rax, -64(%rbp)
	subq	$8, %rsp
	leaq	-216(%rbp), %rax
	movq	%rax, -72(%rbp)
	subq	$8, %rsp
	leaq	-224(%rbp), %rax
	movq	%rax, -80(%rbp)
	movq	$12, %rax
	movq	-80(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rax
	cmpq	$1, %rax
	je	main.then
	jmp	main.else
	.text
main.then:
	subq	$8, %rsp
	leaq	-232(%rbp), %rax
	movq	%rax, -96(%rbp)
	subq	$8, %rsp
	leaq	-240(%rbp), %rax
	movq	%rax, -104(%rbp)
	movq	-80(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -112(%rbp)
	movq	$10, %rcx
	movq	-112(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
	movq	-80(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.merge
	.text
main.else:
	movq	-80(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -136(%rbp)
	movq	$10, %rcx
	movq	-136(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -144(%rbp)
	movq	-144(%rbp), %rax
	movq	-80(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.merge
	.text
main.merge:
	movq	-80(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -160(%rbp)
	movq	$30, %rcx
	movq	-160(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -168(%rbp)
	movq	-168(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	