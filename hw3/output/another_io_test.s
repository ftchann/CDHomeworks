	.data
	.globl	format
format:
	.asciz	"Hello, world!%s %s %lld %lld %lld %lld %lld %lld"
	.data
	.globl	text
text:
	.asciz	"2020"
	.data
	.globl	integer
integer:
	.quad	4
	.text
	.globl	changetext
changetext:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	leaq	integer(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	$1, %rcx
	movq	-8(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	integer(%rip), %rdi
	movq	%rax, (%rdi)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$72, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	format(%rip), %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	leaq	text(%rip), %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	callq	changetext
	movq	%rax, -56(%rbp)
	leaq	integer(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	subq	$24, %rsp
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	movq	-48(%rbp), %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	movq	%rax, %rcx
	movq	$4, %rax
	movq	%rax, %r8 
	movq	$5, %rax
	movq	%rax, %r9 
	movq	$6, %rax
	movq	%rax, 0(%rsp)
	movq	$7, %rax
	movq	%rax, 8(%rsp)
	movq	$8, %rax
	movq	%rax, 16(%rsp)
	callq	printf
	movq	%rax, -72(%rbp)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	