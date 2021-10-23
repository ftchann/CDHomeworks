	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$6969, -24(%rbp)
	movq	$6969, -32(%rbp)
	movq	$6969, -40(%rbp)
	jmp	main.next
	.text
main.next:
	jmp	main.end
	.text
main.end:
	movq	$-123456, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	