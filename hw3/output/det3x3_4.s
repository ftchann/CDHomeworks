	.data
	.globl	row1
row1:
	.quad	4
	.quad	3
	.quad	6
	.data
	.globl	row2
row2:
	.quad	5
	.quad	1
	.quad	2
	.data
	.globl	row3
row3:
	.quad	6
	.quad	1
	.quad	1
	.text
	.globl	calc_det
calc_det:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$264, %rsp
	leaq	row1(%rip), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	leaq	row1(%rip), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	leaq	row1(%rip), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	movq	$2, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	leaq	row2(%rip), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	leaq	row2(%rip), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -40(%rbp)
	leaq	row2(%rip), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	movq	$2, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	leaq	row3(%rip), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	leaq	row3(%rip), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -64(%rbp)
	leaq	row3(%rip), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	movq	$2, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -88(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -96(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -104(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -112(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -120(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -136(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -144(%rbp)
	movq	-144(%rbp), %rcx
	movq	-112(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -152(%rbp)
	movq	-120(%rbp), %rcx
	movq	-136(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -160(%rbp)
	movq	-144(%rbp), %rcx
	movq	-104(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -168(%rbp)
	movq	-120(%rbp), %rcx
	movq	-128(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -176(%rbp)
	movq	-136(%rbp), %rcx
	movq	-104(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -184(%rbp)
	movq	-128(%rbp), %rcx
	movq	-112(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -192(%rbp)
	movq	-160(%rbp), %rcx
	movq	-152(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -200(%rbp)
	movq	-168(%rbp), %rcx
	movq	-176(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -208(%rbp)
	movq	-192(%rbp), %rcx
	movq	-184(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -216(%rbp)
	movq	-200(%rbp), %rcx
	movq	-80(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -224(%rbp)
	movq	-208(%rbp), %rcx
	movq	-88(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -232(%rbp)
	movq	-216(%rbp), %rcx
	movq	-96(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -240(%rbp)
	movq	-232(%rbp), %rcx
	movq	-224(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -248(%rbp)
	movq	-248(%rbp), %rcx
	movq	-240(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -256(%rbp)
	movq	-96(%rbp), %rcx
	movq	-80(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -264(%rbp)
	movq	-256(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	callq	calc_det
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	