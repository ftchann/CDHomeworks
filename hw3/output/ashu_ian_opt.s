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
	je	main.then22
	jmp	main.else21
	.text
main.else21:
	jmp	main.merge20
	.text
main.merge20:
	movq	$-1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.then22:
	movq	$5, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	