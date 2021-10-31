	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$104, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$1, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$2, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.foo:
	subq	$8, %rsp
	leaq	-112(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	$1, %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-120(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	$2, %rax
	movq	-64(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rcx
	movq	-80(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -96(%rbp)
	movq	$10, %rcx
	movq	-96(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	