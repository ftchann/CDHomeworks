	.text
	.globl	foo
foo:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	bar
bar:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$72, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-80(%rbp), %rax
	movq	%rax, -24(%rbp)
	subq	$8, %rsp
	leaq	-88(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$2, %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	$3, %rcx
	movq	-48(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -56(%rbp)
	jmp	bar.l1
	.text
bar.l1:
	subq	$8, %rsp
	leaq	-96(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	$12, %rax
	movq	%rax, %rdi
	movq	$2, %rax
	movq	%rax, %rsi
	callq	foo
	movq	%rax, -72(%rbp)
	movq	-56(%rbp), %rax
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
	movq	$5, %rax
	movq	%rax, %rdi
	movq	$9, %rax
	movq	%rax, %rsi
	callq	bar
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	