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
	subq	$120, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-128(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-136(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-16(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$2, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	$3, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -72(%rbp)
	movq	-56(%rbp), %rcx
	movq	-72(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movq	-64(%rbp), %rcx
	movq	-80(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -88(%rbp)
	jmp	bar.l1
	.text
bar.l1:
	subq	$8, %rsp
	leaq	-144(%rbp), %rax
	movq	%rax, -96(%rbp)
	movq	$0, %rax
	movq	-96(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$12, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	movq	$2, %rax
	movq	%rax, %rsi
	callq	foo
	movq	%rax, -120(%rbp)
	movq	-88(%rbp), %rax
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