	.text
	.globl	factorial
factorial:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	$0, $0
	.text
factorial.ret1:
	movq	$1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
factorial.recurse:
	movq	$1, %rax
	movq	-8(%rbp), %rdi
	subq	%rdi, %rax
	movq	$0, $0
	movq	$-123456, %rax
	movq	-8(%rbp), %rdi
	imulq	%rdi, %rax
	movq	$-123456, %rax
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