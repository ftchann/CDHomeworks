	.data
	.globl	input
input:
	.quad	10
	.quad	5
	.quad	134
	.quad	9
	.quad	11
	.quad	7
	.quad	200
	.quad	65
	.quad	74
	.quad	2
	.data
	.globl	length
length:
	.quad	10
	.text
	.globl	insertionSort
insertionSort:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$240, %rsp
	subq	$8, %rsp
	leaq	-248(%rbp), %rax
	movq	%rax, -8(%rbp)
	subq	$8, %rsp
	leaq	-256(%rbp), %rax
	movq	%rax, -16(%rbp)
	leaq	length(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	$1, %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	insertionSort.while_cond_1
	.text
insertionSort.while_cond_1:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-24(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	cmpq	$1, %rax
	je	insertionSort.while_body_1
	jmp	insertionSort.while_end_1
	.text
insertionSort.while_body_1:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	-16(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	insertionSort.while_cond_2
	.text
insertionSort.while_cond_2:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -80(%rbp)
	movq	$1, %rcx
	movq	-72(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -88(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	-88(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -104(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	-72(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -120(%rbp)
	movq	-104(%rbp), %rax
	movq	-120(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rcx
	movq	-80(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -136(%rbp)
	movq	-136(%rbp), %rax
	cmpq	$1, %rax
	je	insertionSort.while_body_2
	jmp	insertionSort.while_end_2
	.text
insertionSort.while_body_2:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -144(%rbp)
	movq	$1, %rcx
	movq	-144(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -152(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	-144(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -160(%rbp)
	movq	-160(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -168(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	-152(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -176(%rbp)
	movq	-176(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -184(%rbp)
	movq	-168(%rbp), %rax
	movq	-176(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-184(%rbp), %rax
	movq	-160(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rcx
	movq	-144(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -208(%rbp)
	movq	-208(%rbp), %rax
	movq	-16(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	insertionSort.while_cond_2
	.text
insertionSort.while_end_2:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -224(%rbp)
	movq	$1, %rcx
	movq	-224(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -232(%rbp)
	movq	-232(%rbp), %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	insertionSort.while_cond_1
	.text
insertionSort.while_end_1:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	callq	insertionSort
	movq	%rax, -24(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	$5, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	