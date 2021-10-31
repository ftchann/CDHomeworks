	.data
	.globl	tmp
tmp:
	.quad	0
	.quad	0
	.data
	.globl	v1
v1:
	.quad	2
	.quad	tmp
	.data
	.globl	v2
v2:
	.quad	1
	.quad	0
	.quad	v1
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$136, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	tmp(%rip), %rax
	movq	$0, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	leaq	tmp(%rip), %rax
	movq	$0, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	$10, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$11, %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	leaq	v2(%rip), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	addq	$16, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	$0, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	addq	$8, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	$0, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -88(%rbp)
	movq	$11, %rax
	movq	-88(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-80(%rbp), %rax
	movq	$0, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -104(%rbp)
	movq	$10, %rax
	movq	-88(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -120(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rcx
	movq	-120(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -136(%rbp)
	movq	-136(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	