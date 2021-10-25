	.data
	.globl	input
input:
	.quad	50
	.quad	60
	.quad	40
	.quad	70
	.quad	30
	.quad	80
	.quad	20
	.quad	80
	.data
	.globl	length
length:
	.quad	8
	.text
	.globl	find_max
find_max:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$128, %rsp
	subq	$8, %rsp
	leaq	-136(%rbp), %rax
	movq	%rax, -8(%rbp)
	subq	$8, %rsp
	leaq	-144(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	$0, %rax
	movq	-16(%rbp), %rdi
	movq	%rax, (%rdi)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$64, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	find_max.loop
	.text
find_max.loop:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$64, %rdx
	addq	%rdx, %rax
	movq	-56(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	-72(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	cmpq	$1, %rax
	je	find_max.update_max
	jmp	find_max.move_on
	.text
find_max.update_max:
	movq	-72(%rbp), %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	find_max.move_on
	.text
find_max.move_on:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rcx
	movq	$1, %rax
	addq	%rcx, %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	-16(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-112(%rbp), %rax
	movq	$8, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rax
	cmpq	$1, %rax
	je	find_max.end
	jmp	find_max.loop
	.text
find_max.end:
	movq	-80(%rbp), %rax
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
	callq	find_max
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	