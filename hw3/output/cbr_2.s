	.text
	.globl	foo
foo:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$0, %rsp
	movq	$42, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	bar
bar:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$0, %rsp
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$104, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	subq	$8, %rsp
	leaq	-112(%rbp), %rax
	movq	%rax, -24(%rbp)
	subq	$8, %rsp
	leaq	-120(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	$0, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$100, %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setne	%al
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	cmpq	$1, %rax
	je	main.then
	jmp	main.else
	.text
main.then:
	callq	foo
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.end
	.text
main.else:
	callq	bar
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	main.end
	.text
main.end:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	