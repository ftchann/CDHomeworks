	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, %rax
	cmpq	$1, %rax
	je	main.l1
	jmp	main.l2
	.text
main.l1:
	movq	$1, %rax
	cmpq	$1, %rax
	je	main.l2
	jmp	main.l3
	.text
main.l2:
	movq	$2500, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.l3:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	