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
	je	main.then
	jmp	main.else
	.text
main.then:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.else:
	movq	$1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	