	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$128, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-136(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$5, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-144(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	$1, %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.guard
	.text
main.guard:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	$10, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setle	%al
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	cmpq	$1, %rax
	je	main.body
	jmp	main.end
	.text
main.body:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rcx
	movq	-72(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -104(%rbp)
	movq	$1, %rcx
	movq	-104(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.guard
	.text
main.end:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	