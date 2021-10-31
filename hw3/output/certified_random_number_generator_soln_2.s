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
	movq	$8, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.loop
	.text
main.loop:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	$1, %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.lfsr_step
	.text
main.lfsr_step:
	movq	$4, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.loop_end
	.text
main.loop_end:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	