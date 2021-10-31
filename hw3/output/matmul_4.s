	.data
	.globl	mat1
mat1:
	.quad	1
	.quad	2
	.quad	3
	.quad	4
	.data
	.globl	mat2
mat2:
	.quad	5
	.quad	6
	.quad	7
	.quad	8
	.data
	.globl	mat3
mat3:
	.quad	19
	.quad	22
	.quad	43
	.quad	50
	.data
	.globl	matr
matr:
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$88, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-96(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$10000000, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.loop
	.text
main.loop:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	cmpq	$1, %rax
	je	main.exit
	jmp	main.body
	.text
main.body:
	leaq	mat1(%rip), %rax
	movq	%rax, %rdi
	leaq	mat2(%rip), %rax
	movq	%rax, %rsi
	leaq	matr(%rip), %rax
	movq	%rax, %rdx
	callq	matmul
	movq	%rax, -56(%rbp)
	leaq	mat3(%rip), %rax
	movq	%rax, %rdi
	leaq	matr(%rip), %rax
	movq	%rax, %rsi
	callq	mateq
	movq	%rax, -64(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	$1, %rcx
	movq	-72(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.loop
	.text
main.exit:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	matmul
matmul:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$224, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	subq	$8, %rsp
	leaq	-232(%rbp), %rax
	movq	%rax, -32(%rbp)
	subq	$8, %rsp
	leaq	-240(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	$0, %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	matmul.starti
	.text
matmul.starti:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	$2, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	cmpq	$1, %rax
	je	matmul.theni
	jmp	matmul.endi
	.text
matmul.theni:
	movq	$0, %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	matmul.startj
	.text
matmul.startj:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	$2, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	cmpq	$1, %rax
	je	matmul.thenj
	jmp	matmul.endj
	.text
matmul.thenj:
	movq	-24(%rbp), %rax
	movq	$0, %rdx
	imulq	$32, %rdx
	addq	%rdx, %rax
	movq	-56(%rbp), %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	-80(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -96(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$32, %rdx
	addq	%rdx, %rax
	movq	-56(%rbp), %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -104(%rbp)
	movq	-16(%rbp), %rax
	movq	$0, %rdx
	imulq	$32, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	-80(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -112(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$32, %rdx
	addq	%rdx, %rax
	movq	-56(%rbp), %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -120(%rbp)
	movq	-16(%rbp), %rax
	movq	$0, %rdx
	imulq	$32, %rdx
	addq	%rdx, %rax
	movq	$1, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	-80(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -128(%rbp)
	movq	-104(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -136(%rbp)
	movq	-112(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -144(%rbp)
	movq	-120(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -152(%rbp)
	movq	-128(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -160(%rbp)
	movq	-144(%rbp), %rcx
	movq	-136(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -168(%rbp)
	movq	-160(%rbp), %rcx
	movq	-152(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -176(%rbp)
	movq	-176(%rbp), %rcx
	movq	-168(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -184(%rbp)
	movq	-184(%rbp), %rax
	movq	-96(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rcx
	movq	-80(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -200(%rbp)
	movq	-200(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	matmul.startj
	.text
matmul.endj:
	movq	$1, %rcx
	movq	-56(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -216(%rbp)
	movq	-216(%rbp), %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	matmul.starti
	.text
matmul.endi:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	mateq
mateq:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$200, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-208(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$0, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-216(%rbp), %rax
	movq	%rax, -40(%rbp)
	subq	$8, %rsp
	leaq	-224(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	$0, %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	mateq.starti1
	.text
mateq.starti1:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	$2, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	cmpq	$1, %rax
	je	mateq.theni1
	jmp	mateq.endi1
	.text
mateq.theni1:
	movq	$0, %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	mateq.startj1
	.text
mateq.startj1:
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	$2, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	cmpq	$1, %rax
	je	mateq.thenj1
	jmp	mateq.endj1
	.text
mateq.thenj1:
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$32, %rdx
	addq	%rdx, %rax
	movq	-64(%rbp), %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	-88(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -104(%rbp)
	movq	-16(%rbp), %rax
	movq	$0, %rdx
	imulq	$32, %rdx
	addq	%rdx, %rax
	movq	-64(%rbp), %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	movq	-88(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -112(%rbp)
	movq	-104(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -120(%rbp)
	movq	-112(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rcx
	movq	-120(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -136(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -144(%rbp)
	movq	-144(%rbp), %rcx
	movq	-136(%rbp), %rax
	orq	%rcx, %rax
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rcx
	movq	-88(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -168(%rbp)
	movq	-168(%rbp), %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	mateq.startj1
	.text
mateq.endj1:
	movq	$1, %rcx
	movq	-64(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -184(%rbp)
	movq	-184(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	mateq.starti1
	.text
mateq.endi1:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -200(%rbp)
	movq	-200(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	