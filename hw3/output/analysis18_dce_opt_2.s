	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$96, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-104(%rbp), %rax
	movq	%rax, -24(%rbp)
	jmp	main.bar
	.text
main.bar:
	subq	$8, %rsp
	leaq	-112(%rbp), %rax
	movq	%rax, -32(%rbp)
	subq	$8, %rsp
	leaq	-120(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	$14, %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$42, %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.foo
	.text
main.foo:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-72(%rbp), %rcx
	movq	-64(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	-80(%rbp), %rcx
	movq	-88(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	