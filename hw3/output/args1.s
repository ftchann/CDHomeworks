	.data
	.globl	toofew
toofew:
	.asciz	"argc < 3"
	.data
	.globl	toomany
toomany:
	.asciz	"argc > 3"
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$112, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	$3, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$1, %rax
	je	main.few
	jmp	main.else
	.text
main.few:
	leaq	toofew(%rip), %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	callq	ll_puts
	movq	%rax, -40(%rbp)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.else:
	movq	-8(%rbp), %rax
	movq	$3, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	cmpq	$1, %rax
	je	main.many
	jmp	main.right
	.text
main.many:
	leaq	toomany(%rip), %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	callq	ll_puts
	movq	%rax, -64(%rbp)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.right:
	movq	-16(%rbp), %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-16(%rbp), %rax
	movq	$2, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -96(%rbp)
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	movq	-96(%rbp), %rax
	movq	%rax, %rsi
	callq	ll_strcat
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	callq	ll_puts
	movq	%rax, -112(%rbp)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	