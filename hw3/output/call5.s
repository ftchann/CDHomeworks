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
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -72(%rbp)
	movq	-24(%rbp), %rcx
	movq	-72(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movq	-32(%rbp), %rcx
	movq	-80(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	-40(%rbp), %rcx
	movq	-88(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -96(%rbp)
	movq	-48(%rbp), %rcx
	movq	-96(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -104(%rbp)
	movq	-56(%rbp), %rcx
	movq	-104(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -112(%rbp)
	movq	-64(%rbp), %rcx
	movq	-112(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -120(%rbp)
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
	subq	$16, %rsp
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movq	-8(%rbp), %rax
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	movq	-8(%rbp), %rax
	movq	%rax, %r8 
	movq	-8(%rbp), %rax
	movq	%rax, %r9 
	movq	-8(%rbp), %rax
	movq	%rax, 0(%rsp)
	movq	-8(%rbp), %rax
	movq	%rax, 8(%rsp)
	callq	bar
	movq	%rax, -16(%rbp)
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
	movq	$3, %rax
	movq	%rax, %rdi
	callq	foo
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	