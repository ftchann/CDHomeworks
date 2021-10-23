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
	.globl	factorial2
factorial2:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	jmp	factorial2.start
	.text
factorial2.start:
	movq	$0, $0
	movq	$0, $0
	.text
factorial2.then:
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
	jmp	factorial2.start
	.text
factorial2.end:
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
	subq	$56, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	-48(%rbp), %rax
	movq	-40(%rbp), %rdi
	addq	%rdi, %rax
	movq	-56(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	