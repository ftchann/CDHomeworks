	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$48, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$2, %rcx
	movq	$1, %rax
	xorq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$31, %rcx
	movq	$-3, %rax
	imulq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$99, %rcx
	movq	-32(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
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