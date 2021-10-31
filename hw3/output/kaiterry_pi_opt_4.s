	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$1, %rax
	cmpq	$1, %rax
	je	main.then1
	jmp	main.else1
	.text
main.then1:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.else1:
	movq	$1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	