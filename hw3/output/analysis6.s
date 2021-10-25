	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, %rcx
	movq	$2, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$0, %rcx
	movq	$3, %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$0, %rcx
	movq	$4, %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$0, %rax
	cmpq	$1, %rax
	je	main.then
	jmp	main.else
	.text
main.then:
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.else:
	movq	$1, %rax
	cmpq	$1, %rax
	je	main.then
	jmp	main.merge
	.text
main.merge:
	movq	-40(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	