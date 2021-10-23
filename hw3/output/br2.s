	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$12, %rax
	movq	$5, %rdi
	addq	%rdi, %rax
	movq	%rax, -24(%rbp)
	jmp	main.next
	.text
main.next:
	jmp	main.end
	.text
main.end:
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	