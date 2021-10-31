	.data
	.globl	glist
glist:
	.quad	20
	.quad	17
	.quad	13
	.quad	14
	.quad	6
	.quad	5
	.quad	4
	.quad	3
	.quad	2
	.quad	1
	.text
	.globl	sort
sort:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$176, %rsp
	movq	%rdi, -8(%rbp)
	subq	$8, %rsp
	leaq	-184(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	$1, %rax
	movq	-16(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	sort.loop
	.text
sort.loop:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	$9, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	cmpq	$1, %rax
	je	sort.body
	jmp	sort.done
	.text
sort.body:
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	-32(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	$1, %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	-64(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-56(%rbp), %rax
	movq	-80(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	cmpq	$1, %rax
	je	sort.bumpc
	jmp	sort.swap
	.text
sort.bumpc:
	movq	-32(%rbp), %rcx
	movq	$1, %rax
	addq	%rcx, %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	movq	-16(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	sort.loop
	.text
sort.swap:
	movq	-56(%rbp), %rax
	movq	-72(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-80(%rbp), %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-32(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rax
	cmpq	$1, %rax
	je	sort.decc
	jmp	sort.loop
	.text
sort.decc:
	movq	-56(%rbp), %rax
	movq	-72(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-80(%rbp), %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rcx
	movq	-32(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rax
	movq	-16(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	sort.loop
	.text
sort.done:
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$9, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -168(%rbp)
	movq	-168(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -176(%rbp)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$208, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	glist(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	leaq	glist(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	leaq	glist(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$2, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -40(%rbp)
	leaq	glist(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$3, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	leaq	glist(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$4, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	leaq	glist(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$5, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -64(%rbp)
	leaq	glist(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$6, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	leaq	glist(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$7, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -80(%rbp)
	leaq	glist(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$8, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -88(%rbp)
	leaq	glist(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$9, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -96(%rbp)
	leaq	glist(%rip), %rax
	movq	%rax, %rdi
	callq	sort
	movq	%rax, -104(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -112(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -120(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -136(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -144(%rbp)
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -152(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -160(%rbp)
	movq	-80(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -168(%rbp)
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -176(%rbp)
	movq	-96(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -184(%rbp)
	movq	-120(%rbp), %rcx
	movq	-112(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -192(%rbp)
	movq	-184(%rbp), %rcx
	movq	-192(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -200(%rbp)
	movq	-176(%rbp), %rcx
	movq	-200(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -208(%rbp)
	movq	-208(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	