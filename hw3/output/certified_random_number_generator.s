	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$168, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-176(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$0, %rcx
	movq	$8, %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.loop
	.text
main.loop:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	$1, %rcx
	movq	-48(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.lfsr_step
	.text
main.lfsr_step:
	movq	$0, %rcx
	movq	$46421, %rax
	shrq	%cl, %rax
	movq	%rax, -72(%rbp)
	movq	$2, %rcx
	movq	$46421, %rax
	shrq	%cl, %rax
	movq	%rax, -80(%rbp)
	movq	$3, %rcx
	movq	$46421, %rax
	shrq	%cl, %rax
	movq	%rax, -88(%rbp)
	movq	$5, %rcx
	movq	$46421, %rax
	shrq	%cl, %rax
	movq	%rax, -96(%rbp)
	movq	-80(%rbp), %rcx
	movq	-72(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -104(%rbp)
	movq	-88(%rbp), %rcx
	movq	-104(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -112(%rbp)
	movq	-96(%rbp), %rcx
	movq	-112(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -120(%rbp)
	movq	$1, %rcx
	movq	-120(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -128(%rbp)
	movq	$1, %rcx
	movq	$8, %rax
	shrq	%cl, %rax
	movq	%rax, -136(%rbp)
	movq	$15, %rcx
	movq	-128(%rbp), %rax
	shlq	%cl, %rax
	movq	%rax, -144(%rbp)
	movq	-144(%rbp), %rcx
	movq	-136(%rbp), %rax
	orq	%rcx, %rax
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.loop_end
	.text
main.loop_end:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -168(%rbp)
	movq	-168(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	