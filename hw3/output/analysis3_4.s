	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$88, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$7, %rcx
	movq	$7, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	jmp	main.l2
	.text
main.l2:
	movq	-24(%rbp), %rcx
	movq	$2, %rax
	imulq	%rcx, %rax
	movq	%rax, -32(%rbp)
	jmp	main.l3
	.text
main.l3:
	movq	$32, %rcx
	movq	-32(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	jmp	main.l4
	.text
main.l4:
	movq	$1, %rcx
	movq	-40(%rbp), %rax
	shlq	%cl, %rax
	movq	%rax, -48(%rbp)
	jmp	main.l5
	.text
main.l5:
	movq	$60, %rcx
	movq	-48(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -56(%rbp)
	jmp	main.l6
	.text
main.l6:
	movq	$2, %rcx
	movq	-56(%rbp), %rax
	sarq	%cl, %rax
	movq	%rax, -64(%rbp)
	jmp	main.l7
	.text
main.l7:
	movq	-64(%rbp), %rcx
	movq	$255, %rax
	andq	%rcx, %rax
	movq	%rax, -72(%rbp)
	jmp	main.l8
	.text
main.l8:
	movq	-72(%rbp), %rcx
	movq	$64, %rax
	orq	%rcx, %rax
	movq	%rax, -80(%rbp)
	jmp	main.l9
	.text
main.l9:
	movq	$255, %rcx
	movq	-80(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -88(%rbp)
	jmp	main.lexit
	.text
main.lexit:
	movq	-88(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	