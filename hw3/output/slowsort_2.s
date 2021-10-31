	.data
	.globl	length
length:
	.quad	31
	.data
	.globl	input
input:
	.quad	5
	.quad	100
	.quad	2
	.quad	0
	.quad	18
	.quad	10
	.quad	2
	.quad	1
	.quad	22
	.quad	98
	.quad	107
	.quad	105
	.quad	116
	.quad	116
	.quad	101
	.quad	110
	.quad	20
	.quad	23
	.quad	102
	.quad	23
	.quad	98
	.quad	97
	.quad	98
	.quad	121
	.quad	15
	.quad	5
	.quad	16
	.quad	116
	.quad	105
	.quad	110
	.quad	155
	.text
	.globl	slowsort
slowsort:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$136, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$1, %rax
	je	slowsort.done
	jmp	slowsort.notdone
	.text
slowsort.notdone:
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$1, %rcx
	movq	-32(%rbp), %rax
	sarq	%cl, %rax
	movq	%rax, -40(%rbp)
	movq	$1, %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	callq	slowsort
	movq	%rax, -56(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	callq	slowsort
	movq	%rax, -64(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$248, %rdx
	addq	%rdx, %rax
	movq	-40(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$248, %rdx
	addq	%rdx, %rax
	movq	-16(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	movq	-80(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	cmpq	$1, %rax
	je	slowsort.swap
	jmp	slowsort.finish
	.text
slowsort.swap:
	movq	-96(%rbp), %rax
	movq	-72(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-80(%rbp), %rax
	movq	-88(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	slowsort.finish
	.text
slowsort.finish:
	movq	$1, %rcx
	movq	-16(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -128(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-128(%rbp), %rax
	movq	%rax, %rsi
	callq	slowsort
	movq	%rax, -136(%rbp)
	jmp	slowsort.done
	.text
slowsort.done:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	issorted
issorted:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$104, %rsp
	leaq	length(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	$1, %rcx
	movq	-8(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -16(%rbp)
	subq	$8, %rsp
	leaq	-112(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$0, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	issorted.loop
	.text
issorted.loop:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$248, %rdx
	addq	%rdx, %rax
	movq	-40(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	$1, %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -64(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$248, %rdx
	addq	%rdx, %rax
	movq	-64(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-64(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-56(%rbp), %rax
	movq	-80(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setle	%al
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	cmpq	$1, %rax
	je	issorted.checkloop
	jmp	issorted.succ
	.text
issorted.checkloop:
	movq	-40(%rbp), %rax
	movq	-16(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	cmpq	$1, %rax
	je	issorted.succ
	jmp	issorted.loop
	.text
issorted.fail:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
issorted.succ:
	movq	$1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	length(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	$1, %rcx
	movq	-24(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$0, %rax
	movq	%rax, %rdi
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	callq	slowsort
	movq	%rax, -40(%rbp)
	callq	issorted
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	cmpq	$1, %rax
	je	main.succ
	jmp	main.fail
	.text
main.fail:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.succ:
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$248, %rdx
	addq	%rdx, %rax
	movq	-32(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	