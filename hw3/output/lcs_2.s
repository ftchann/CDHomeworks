	.data
	.globl	str1
str1:
	.quad	1
	.quad	2
	.quad	3
	.quad	2
	.quad	4
	.quad	1
	.quad	2
	.data
	.globl	str2
str2:
	.quad	2
	.quad	4
	.quad	3
	.quad	1
	.quad	2
	.quad	1
	.text
	.globl	lcs
lcs:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$128, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$1, %rax
	je	lcs.ret0
	jmp	lcs.interm
	.text
lcs.interm:
	movq	-32(%rbp), %rax
	cmpq	$1, %rax
	je	lcs.ret0
	jmp	lcs.then
	.text
lcs.then:
	movq	$1, %rcx
	movq	-8(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$1, %rcx
	movq	-16(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -48(%rbp)
	leaq	str1(%rip), %rax
	movq	$0, %rdx
	imulq	$56, %rdx
	addq	%rdx, %rax
	movq	-40(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	leaq	str2(%rip), %rax
	movq	$0, %rdx
	imulq	$48, %rdx
	addq	%rdx, %rax
	movq	-48(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-64(%rbp), %rax
	movq	-80(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	cmpq	$1, %rax
	je	lcs.eq_recurse
	jmp	lcs.not_eq_recurse
	.text
lcs.eq_recurse:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	callq	lcs
	movq	%rax, -96(%rbp)
	movq	$1, %rcx
	movq	-96(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
lcs.not_eq_recurse:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	callq	lcs
	movq	%rax, -112(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	callq	lcs
	movq	%rax, -120(%rbp)
	movq	-112(%rbp), %rax
	movq	-120(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rax
	cmpq	$1, %rax
	je	lcs.ret1
	jmp	lcs.ret2
	.text
lcs.ret1:
	movq	-112(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
lcs.ret2:
	movq	-120(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
lcs.ret0:
	movq	$0, %rax
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
	movq	$7, %rax
	movq	%rax, %rdi
	movq	$6, %rax
	movq	%rax, %rsi
	callq	lcs
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	