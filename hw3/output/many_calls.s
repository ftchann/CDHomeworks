	.text
	.globl	foo
foo:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$56, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8 , -40(%rbp)
	movq	%r9 , -48(%rbp)
	movq	16(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$72, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-80(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$9999999, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.loop_condition
	.text
main.loop_condition:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	cmpq	$1, %rax
	je	main.loop_body
	jmp	main.post_loop
	.text
main.loop_body:
	subq	$8, %rsp
	movq	$0, %rax
	movq	%rax, %rdi
	movq	$0, %rax
	movq	%rax, %rsi
	movq	$0, %rax
	movq	%rax, %rdx
	movq	$0, %rax
	movq	%rax, %rcx
	movq	$0, %rax
	movq	%rax, %r8 
	movq	$0, %rax
	movq	%rax, %r9 
	movq	$0, %rax
	movq	%rax, 0(%rsp)
	callq	foo
	movq	%rax, -56(%rbp)
	movq	$1, %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.loop_condition
	.text
main.post_loop:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	