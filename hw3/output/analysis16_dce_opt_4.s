	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$144, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-152(%rbp), %rax
	movq	%rax, -24(%rbp)
	subq	$8, %rsp
	leaq	-160(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	$6, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$7, %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.foo
	.text
main.foo:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	$0, %rax
	movq	-56(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	cmpq	$1, %rax
	je	main.retb
	jmp	main.loop
	.text
main.loop:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	$0, %rax
	movq	-72(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	cmpq	$1, %rax
	je	main.reta
	jmp	main.continue_loop
	.text
main.continue_loop:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	-72(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	cmpq	$1, %rax
	je	main.if
	jmp	main.else
	.text
main.if:
	movq	-72(%rbp), %rcx
	movq	-88(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.loop
	.text
main.else:
	movq	-88(%rbp), %rcx
	movq	-72(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.loop
	.text
main.reta:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -136(%rbp)
	movq	-136(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.retb:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -144(%rbp)
	movq	-144(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	