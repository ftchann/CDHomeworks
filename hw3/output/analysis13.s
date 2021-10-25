	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$120, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$1, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$2, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$3, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	$4, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	$5, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movq	$7, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -72(%rbp)
	movq	$3, %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	cmpq	$1, %rax
	je	main.one
	jmp	main.wrong
	.text
main.one:
	movq	$1, %rax
	movq	-32(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	cmpq	$1, %rax
	je	main.two
	jmp	main.wrong
	.text
main.two:
	movq	-40(%rbp), %rax
	movq	$3, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setne	%al
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	cmpq	$1, %rax
	je	main.three
	jmp	main.wrong
	.text
main.three:
	movq	-48(%rbp), %rax
	movq	$4, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	cmpq	$1, %rax
	je	main.four
	jmp	main.wrong
	.text
main.four:
	movq	-56(%rbp), %rax
	movq	$10, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setle	%al
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	cmpq	$1, %rax
	je	main.five
	jmp	main.wrong
	.text
main.five:
	movq	$10, %rax
	movq	-64(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
	cmpq	$1, %rax
	je	main.correct
	jmp	main.wrong
	.text
main.correct:
	movq	-72(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.wrong:
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	