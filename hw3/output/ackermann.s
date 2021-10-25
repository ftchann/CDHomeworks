	.text
	.globl	ack
ack:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$104, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-112(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	cmpq	$1, %rax
	je	ack.mnonzero
	jmp	ack.mzero
	.text
ack.mzero:
	movq	$1, %rdi
	movq	-16(%rbp), %rax
	addq	%rdi, %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	ack.end
	.text
ack.mnonzero:
	movq	-16(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	cmpq	$1, %rax
	je	ack.nnonzero
	jmp	ack.nzero
	.text
ack.nzero:
	movq	$1, %rdi
	movq	-8(%rbp), %rax
	subq	%rdi, %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	movq	$1, %rax
	movq	%rax, %rsi
	callq	ack
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	ack.end
	.text
ack.nnonzero:
	movq	$1, %rdi
	movq	-8(%rbp), %rax
	subq	%rdi, %rax
	movq	%rax, -64(%rbp)
	movq	$1, %rdi
	movq	-16(%rbp), %rax
	subq	%rdi, %rax
	movq	%rax, -80(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-80(%rbp), %rax
	movq	%rax, %rsi
	callq	ack
	movq	%rax, -88(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	movq	-88(%rbp), %rax
	movq	%rax, %rsi
	callq	ack
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	ack.end
	.text
ack.end:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$2, %rax
	movq	%rax, %rdi
	movq	$2, %rax
	movq	%rax, %rsi
	callq	ack
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	