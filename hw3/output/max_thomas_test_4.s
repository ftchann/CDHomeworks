	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$160, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-168(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$1, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-176(%rbp), %rax
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-184(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-40(%rbp), %rax
	movq	-56(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-192(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-56(%rbp), %rax
	movq	-72(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-200(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	-72(%rbp), %rax
	movq	-88(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-208(%rbp), %rax
	movq	%rax, -104(%rbp)
	movq	-88(%rbp), %rax
	movq	-104(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-216(%rbp), %rax
	movq	%rax, -120(%rbp)
	movq	-104(%rbp), %rax
	movq	-120(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-224(%rbp), %rax
	movq	%rax, -136(%rbp)
	movq	-120(%rbp), %rax
	movq	-136(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-232(%rbp), %rax
	movq	%rax, -152(%rbp)
	movq	-136(%rbp), %rax
	movq	-152(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$120, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	