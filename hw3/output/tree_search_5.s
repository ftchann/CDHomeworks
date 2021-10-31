	.text
	.file	"tree_search.ll"
	.globl	tree_search             # -- Begin function tree_search
	.p2align	4, 0x90
	.type	tree_search,@function
tree_search:                            # @tree_search
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	testq	%rdi, %rdi
	je	.LBB0_1
# %bb.2:                                # %valid_node
	movq	%rsi, %rbx
	movl	$1, %eax
	cmpq	%rsi, 16(%rdi)
	je	.LBB0_4
# %bb.3:                                # %not_found
	movq	(%rdi), %rax
	movq	8(%rdi), %r14
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	tree_search
	movq	%rax, %r15
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	tree_search
	orq	%r15, %rax
	jmp	.LBB0_4
.LBB0_1:
	xorl	%eax, %eax
.LBB0_4:                                # %null_node
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end0:
	.size	tree_search, .Lfunc_end0-tree_search
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$root, %edi
	movl	$7, %esi
	jmp	tree_search             # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.type	root,@object            # @root
	.data
	.globl	root
	.p2align	4
root:
	.quad	node1
	.quad	node2
	.quad	5                       # 0x5
	.size	root, 24

	.type	node1,@object           # @node1
	.globl	node1
	.p2align	4
node1:
	.quad	node3
	.quad	node4
	.quad	2                       # 0x2
	.size	node1, 24

	.type	node2,@object           # @node2
	.globl	node2
	.p2align	4
node2:
	.quad	node5
	.quad	0
	.quad	8                       # 0x8
	.size	node2, 24

	.type	node3,@object           # @node3
	.globl	node3
	.p2align	4
node3:
	.quad	0
	.quad	0
	.quad	1                       # 0x1
	.size	node3, 24

	.type	node4,@object           # @node4
	.globl	node4
	.p2align	4
node4:
	.quad	0
	.quad	0
	.quad	3                       # 0x3
	.size	node4, 24

	.type	node5,@object           # @node5
	.globl	node5
	.p2align	4
node5:
	.quad	0
	.quad	0
	.quad	7                       # 0x7
	.size	node5, 24


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym root
	.addrsig_sym node1
	.addrsig_sym node2
	.addrsig_sym node3
	.addrsig_sym node4
	.addrsig_sym node5
