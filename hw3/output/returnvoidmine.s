	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$80, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8 , -40(%rbp)
	movq	%r9 , -48(%rbp)
	movq	40(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	32(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	24(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	16(%rbp), %rax
	movq	%rax, -80(%rbp)
	movq	%rbp, %rsp
	popq	%rbp
	retq	