	.data
	.globl	gstr
gstr:
	.asciz	"hello, world!"
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	gstr(%rip), %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	callq	ll_puts
	movq	%rax, -32(%rbp)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	