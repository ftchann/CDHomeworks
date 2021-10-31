	.data
	.globl	root
root:
	.quad	node1
	.quad	node2
	.quad	5
	.data
	.globl	node1
node1:
	.quad	node3
	.quad	node4
	.quad	2
	.data
	.globl	node2
node2:
	.quad	node5
	.quad	0
	.quad	8
	.data
	.globl	node3
node3:
	.quad	0
	.quad	0
	.quad	1
	.data
	.globl	node4
node4:
	.quad	0
	.quad	0
	.quad	3
	.data
	.globl	node5
node5:
	.quad	0
	.quad	0
	.quad	7
	.text
	.globl	tree_search
tree_search:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$104, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$1, %rax
	je	tree_search.null_node
	jmp	tree_search.valid_node
	.text
tree_search.valid_node:
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	addq	$16, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-16(%rbp), %rax
	movq	-40(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	cmpq	$1, %rax
	je	tree_search.found
	jmp	tree_search.not_found
	.text
tree_search.null_node:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
tree_search.found:
	movq	$1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
tree_search.not_found:
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	addq	$0, %rax
	movq	%rax, -56(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$24, %rdx
	addq	%rdx, %rax
	addq	$8, %rax
	movq	%rax, -64(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	callq	tree_search
	movq	%rax, -88(%rbp)
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	callq	tree_search
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rcx
	movq	-88(%rbp), %rax
	orq	%rcx, %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
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
	leaq	root(%rip), %rax
	movq	%rax, %rdi
	movq	$7, %rax
	movq	%rax, %rsi
	callq	tree_search
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	