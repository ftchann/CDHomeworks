	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$3, %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$1, %rax
	je	main.then
	jmp	main.else
	.text
main.then:
	movq	$7, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.else:
	movq	$9, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	