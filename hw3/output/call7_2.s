	.text
	.globl	bar
bar:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$64, %rsp
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
	subq	$16, %rsp
	movq	$1, %rax
	movq	%rax, %rdi
	movq	$2, %rax
	movq	%rax, %rsi
	movq	$3, %rax
	movq	%rax, %rdx
	movq	$4, %rax
	movq	%rax, %rcx
	movq	$5, %rax
	movq	%rax, %r8 
	movq	$6, %rax
	movq	%rax, %r9 
	movq	$7, %rax
	movq	%rax, 0(%rsp)
	movq	$8, %rax
	movq	%rax, 8(%rsp)
	callq	bar
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	