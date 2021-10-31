	.data
	.globl	one_elt
one_elt:
	.quad	1
	.quad	0
	.data
	.globl	two_elts
two_elts:
	.quad	2
	.quad	one_elt
	.data
	.globl	three_elts
three_elts:
	.quad	4
	.quad	two_elts
	.data
	.globl	four_elts
four_elts:
	.quad	8
	.quad	three_elts
	.data
	.globl	test
test:
	.quad	16
	.quad	four_elts
	.text
	.globl	sum_half_list
sum_half_list:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$72, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	cmpq	$1, %rax
	je	sum_half_list.then
	jmp	sum_half_list.else
	.text
sum_half_list.then:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
sum_half_list.else:
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	addq	$0, %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	$1, %rcx
	movq	-32(%rbp), %rax
	sarq	%cl, %rax
	movq	%rax, -40(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	addq	$8, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	callq	sum_half_list
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
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
	leaq	test(%rip), %rax
	movq	%rax, %rdi
	callq	sum_half_list
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	