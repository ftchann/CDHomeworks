	.data
	.globl	valuesSeen
valuesSeen:
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.data
	.globl	inputArray
inputArray:
	.quad	5
	.quad	7
	.quad	14
	.quad	0
	.quad	0
	.quad	9
	.quad	12
	.quad	5
	.quad	5
	.quad	6
	.data
	.globl	outputArray
outputArray:
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.text
	.globl	insert
insert:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$104, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	subq	$8, %rsp
	leaq	-112(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-24(%rbp), %rax
	movq	-32(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	cmpq	$1, %rax
	je	insert.finishInsert
	jmp	insert.innerInsertLoop
	.text
insert.innerInsertLoop:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	leaq	outputArray(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	-64(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	movq	-8(%rbp), %rax
	movq	-72(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rcx
	movq	-64(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-88(%rbp), %rax
	movq	-32(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	cmpq	$1, %rax
	je	insert.finishInsert
	jmp	insert.innerInsertLoop
	.text
insert.finishInsert:
	movq	-32(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	countSortInPlace
countSortInPlace:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$192, %rsp
	subq	$8, %rsp
	leaq	-200(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	$0, %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	countSortInPlace.countLoop
	.text
countSortInPlace.countLoop:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	leaq	inputArray(%rip), %rax
	movq	$0, %rdx
	imulq	$80, %rdx
	addq	%rdx, %rax
	movq	-24(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	leaq	valuesSeen(%rip), %rax
	movq	$0, %rdx
	imulq	$120, %rdx
	addq	%rdx, %rax
	movq	-40(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	$1, %rcx
	movq	-56(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-80(%rbp), %rax
	movq	$10, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	cmpq	$1, %rax
	je	countSortInPlace.performInsertions
	jmp	countSortInPlace.countLoop
	.text
countSortInPlace.performInsertions:
	movq	$0, %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-208(%rbp), %rax
	movq	%rax, -112(%rbp)
	movq	$0, %rax
	movq	-112(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	countSortInPlace.insertionLoop
	.text
countSortInPlace.insertionLoop:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	leaq	valuesSeen(%rip), %rax
	movq	$0, %rdx
	imulq	$120, %rdx
	addq	%rdx, %rax
	movq	-128(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -136(%rbp)
	movq	-136(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -144(%rbp)
	movq	-112(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -152(%rbp)
	movq	-128(%rbp), %rax
	movq	%rax, %rdi
	movq	-144(%rbp), %rax
	movq	%rax, %rsi
	movq	-152(%rbp), %rax
	movq	%rax, %rdx
	callq	insert
	movq	%rax, -160(%rbp)
	movq	-160(%rbp), %rax
	movq	-112(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rcx
	movq	-128(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -176(%rbp)
	movq	-176(%rbp), %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-176(%rbp), %rax
	movq	$15, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -192(%rbp)
	movq	-192(%rbp), %rax
	cmpq	$1, %rax
	je	countSortInPlace.complete
	jmp	countSortInPlace.insertionLoop
	.text
countSortInPlace.complete:
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
	callq	countSortInPlace
	movq	%rax, -24(%rbp)
	leaq	outputArray(%rip), %rax
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