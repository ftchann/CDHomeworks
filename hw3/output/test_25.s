	.text
	.globl	factorial
factorial:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	jmp	factorial.start
	.text
factorial.start:
	movq	$0, $0
	movq	$0, $0
	.text
factorial.then:
	movq	$0, $0
	movq	$0, $0
	movq	$-123456, %rax
	movq	$-123456, %rdi
	imulq	%rdi, %rax
	movq	$0, $0
	movq	$0, $0
	movq	$1, %rax
	movq	$-123456, %rdi
	subq	%rdi, %rax
	movq	$0, $0
	jmp	factorial.start
	.text
factorial.end:
	movq	$0, $0
	movq	$-123456, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	-40(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	