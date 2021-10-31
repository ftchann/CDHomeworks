	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$88, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$9, %rcx
	movq	$5, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$15, %rcx
	movq	-24(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rcx
	movq	-32(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$1, %rcx
	movq	-40(%rbp), %rax
	shlq	%cl, %rax
	movq	%rax, -48(%rbp)
	movq	-24(%rbp), %rcx
	movq	-48(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -56(%rbp)
	movq	$3, %rcx
	movq	-56(%rbp), %rax
	sarq	%cl, %rax
	movq	%rax, -64(%rbp)
	movq	-24(%rbp), %rcx
	movq	-32(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rcx
	movq	-56(%rbp), %rax
	orq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movq	-56(%rbp), %rcx
	movq	-24(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	