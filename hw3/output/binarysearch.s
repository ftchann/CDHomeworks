	.data
	.globl	node1
node1:
	.quad	node2
	.quad	node3
	.quad	50
	.data
	.globl	node2
node2:
	.quad	node4
	.quad	node5
	.quad	25
	.data
	.globl	node3
node3:
	.quad	node6
	.quad	node7
	.quad	75
	.data
	.globl	node4
node4:
	.quad	node8
	.quad	0
	.quad	10
	.data
	.globl	node5
node5:
	.quad	0
	.quad	0
	.quad	30
	.data
	.globl	node6
node6:
	.quad	0
	.quad	0
	.quad	60
	.data
	.globl	node7
node7:
	.quad	0
	.quad	0
	.quad	80
	.data
	.globl	node8
node8:
	.quad	0
	.quad	0
	.quad	1
	.text
	.globl	contains
contains:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$112, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	addq	$16, %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	-16(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	cmpq	$1, %rax
	je	contains.equal
	jmp	contains.notequal
	.text
contains.equal:
	movq	$1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
contains.notequal:
	movq	-32(%rbp), %rax
	movq	-16(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	cmpq	$1, %rax
	je	contains.left
	jmp	contains.right
	.text
contains.left:
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	addq	$0, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	cmpq	$1, %rax
	je	contains.none
	jmp	contains.left_next
	.text
contains.left_next:
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
contains.right:
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	addq	$8, %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	cmpq	$1, %rax
	je	contains.none
	jmp	contains.right_next
	.text
contains.right_next:
	movq	-96(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
contains.none:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$248, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, %rcx
	movq	$50, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	$0, %rcx
	movq	$25, %rax
	addq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$0, %rcx
	movq	$75, %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$0, %rcx
	movq	$10, %rax
	addq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	$0, %rcx
	movq	$30, %rax
	addq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	$0, %rcx
	movq	$60, %rax
	addq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movq	$0, %rcx
	movq	$80, %rax
	addq	%rcx, %rax
	movq	%rax, -72(%rbp)
	movq	$0, %rcx
	movq	$1, %rax
	addq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movq	$0, %rcx
	movq	$100, %rax
	addq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	$0, %rcx
	movq	$120, %rax
	addq	%rcx, %rax
	movq	%rax, -96(%rbp)
	leaq	node1(%rip), %rax
	movq	%rax, %rdi
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -104(%rbp)
	leaq	node1(%rip), %rax
	movq	%rax, %rdi
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -112(%rbp)
	leaq	node1(%rip), %rax
	movq	%rax, %rdi
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -120(%rbp)
	leaq	node1(%rip), %rax
	movq	%rax, %rdi
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -128(%rbp)
	leaq	node1(%rip), %rax
	movq	%rax, %rdi
	movq	-56(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -136(%rbp)
	leaq	node1(%rip), %rax
	movq	%rax, %rdi
	movq	-64(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -144(%rbp)
	leaq	node1(%rip), %rax
	movq	%rax, %rdi
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -152(%rbp)
	leaq	node1(%rip), %rax
	movq	%rax, %rdi
	movq	-80(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -160(%rbp)
	leaq	node1(%rip), %rax
	movq	%rax, %rdi
	movq	-88(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -168(%rbp)
	leaq	node1(%rip), %rax
	movq	%rax, %rdi
	movq	-96(%rbp), %rax
	movq	%rax, %rsi
	callq	contains
	movq	%rax, -176(%rbp)
	movq	-112(%rbp), %rcx
	movq	-104(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -184(%rbp)
	movq	-128(%rbp), %rcx
	movq	-120(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -192(%rbp)
	movq	-144(%rbp), %rcx
	movq	-136(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -200(%rbp)
	movq	-160(%rbp), %rcx
	movq	-152(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -208(%rbp)
	movq	-176(%rbp), %rcx
	movq	-168(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -216(%rbp)
	movq	-192(%rbp), %rcx
	movq	-184(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -224(%rbp)
	movq	-208(%rbp), %rcx
	movq	-200(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -232(%rbp)
	movq	-232(%rbp), %rcx
	movq	-224(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -240(%rbp)
	movq	-216(%rbp), %rcx
	movq	-240(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -248(%rbp)
	movq	-248(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	