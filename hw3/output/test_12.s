	.text
	.globl	bar
bar:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$120, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8 , -40(%rbp)
	movq	%r9 , -48(%rbp)
	movq	16(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	24(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdi
	addq	%rdi, %rax
	movq	-24(%rbp), %rax
	movq	-72(%rbp), %rdi
	addq	%rdi, %rax
	movq	-32(%rbp), %rax
	movq	-80(%rbp), %rdi
	addq	%rdi, %rax
	movq	-40(%rbp), %rax
	movq	-88(%rbp), %rdi
	addq	%rdi, %rax
	movq	-48(%rbp), %rax
	movq	-96(%rbp), %rdi
	addq	%rdi, %rax
	movq	-56(%rbp), %rax
	movq	-104(%rbp), %rdi
	addq	%rdi, %rax
	movq	-64(%rbp), %rax
	movq	-112(%rbp), %rdi
	addq	%rdi, %rax
	movq	-120(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	foo
foo:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	$0, $0
	movq	-16(%rbp), %rax
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
	movq	$0, $0
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	