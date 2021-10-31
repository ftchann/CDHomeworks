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
	je	main.one
	jmp	main.wrong
	.text
main.correct:
	movq	$7, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.five:
	movq	$1, %rax
	cmpq	$1, %rax
	je	main.correct
	jmp	main.wrong
	.text
main.four:
	movq	$1, %rax
	cmpq	$1, %rax
	je	main.five
	jmp	main.wrong
	.text
main.one:
	movq	$1, %rax
	cmpq	$1, %rax
	je	main.two
	jmp	main.wrong
	.text
main.three:
	movq	$1, %rax
	cmpq	$1, %rax
	je	main.four
	jmp	main.wrong
	.text
main.two:
	movq	$1, %rax
	cmpq	$1, %rax
	je	main.three
	jmp	main.wrong
	.text
main.wrong:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	