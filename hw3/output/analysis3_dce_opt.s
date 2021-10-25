	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	jmp	main.l2
	.text
main.l2:
	jmp	main.l3
	.text
main.l3:
	jmp	main.l4
	.text
main.l4:
	jmp	main.l5
	.text
main.l5:
	jmp	main.l6
	.text
main.l6:
	jmp	main.l7
	.text
main.l7:
	jmp	main.l8
	.text
main.l8:
	jmp	main.l9
	.text
main.l9:
	jmp	main.lexit
	.text
main.lexit:
	movq	$188, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	