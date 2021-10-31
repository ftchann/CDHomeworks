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
	movq	$14, %rax
	subq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$-1, %rcx
	movq	$-1, %rax
	imulq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$1, %rcx
	movq	$1, %rax
	shlq	%cl, %rax
	movq	%rax, -48(%rbp)
	movq	$14, %rcx
	movq	$2, %rax
	shrq	%cl, %rax
	movq	%rax, -56(%rbp)
	movq	$3, %rcx
	movq	$0, %rax
	sarq	%cl, %rax
	movq	%rax, -64(%rbp)
	movq	$14, %rcx
	movq	$-1, %rax
	andq	%rcx, %rax
	movq	%rax, -72(%rbp)
	movq	$14, %rcx
	movq	$0, %rax
	orq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movq	$0, %rcx
	movq	$14, %rax
	xorq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	$14, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	