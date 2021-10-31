	.text
	.file	"binarysearch.ll"
	.globl	contains                # -- Begin function contains
	.p2align	4, 0x90
	.type	contains,@function
contains:                               # @contains
# %bb.0:
	movq	16(%rdi), %rcx
	movl	$1, %eax
	cmpq	%rsi, %rcx
	je	.LBB0_8
	.p2align	4, 0x90
.LBB0_2:                                # %notequal
                                        # =>This Inner Loop Header: Depth=1
	cmpq	%rsi, %rcx
	jle	.LBB0_6
# %bb.3:                                # %left
                                        #   in Loop: Header=BB0_2 Depth=1
	movq	(%rdi), %rdi
	testq	%rdi, %rdi
	jne	.LBB0_5
	jmp	.LBB0_7
	.p2align	4, 0x90
.LBB0_6:                                # %right
                                        #   in Loop: Header=BB0_2 Depth=1
	movq	8(%rdi), %rdi
	testq	%rdi, %rdi
	je	.LBB0_7
.LBB0_5:                                # %tailrecurse.backedge
                                        #   in Loop: Header=BB0_2 Depth=1
	movq	16(%rdi), %rcx
	cmpq	%rsi, %rcx
	jne	.LBB0_2
.LBB0_8:                                # %equal
	retq
.LBB0_7:
	xorl	%eax, %eax
	retq
.Lfunc_end0:
	.size	contains, .Lfunc_end0-contains
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
	movl	$node1, %edi
	movl	$50, %esi
	callq	contains
	movq	%rax, 16(%rsp)          # 8-byte Spill
	movl	$node1, %edi
	movl	$25, %esi
	callq	contains
	movq	%rax, %rbx
	movl	$node1, %edi
	movl	$75, %esi
	callq	contains
	movq	%rax, 8(%rsp)           # 8-byte Spill
	movl	$node1, %edi
	movl	$10, %esi
	callq	contains
	movq	%rax, (%rsp)            # 8-byte Spill
	movl	$node1, %edi
	movl	$30, %esi
	callq	contains
	movq	%rax, %r13
	movl	$node1, %edi
	movl	$60, %esi
	callq	contains
	movq	%rax, %rbp
	movl	$node1, %edi
	movl	$80, %esi
	callq	contains
	movq	%rax, %r14
	movl	$node1, %edi
	movl	$1, %esi
	callq	contains
	movq	%rax, %r15
	movl	$node1, %edi
	movl	$100, %esi
	callq	contains
	movq	%rax, %r12
	movl	$node1, %edi
	movl	$120, %esi
	callq	contains
	addq	16(%rsp), %rbx          # 8-byte Folded Reload
	addq	8(%rsp), %rbx           # 8-byte Folded Reload
	addq	(%rsp), %rbx            # 8-byte Folded Reload
	addq	%r13, %rbx
	addq	%rbp, %rbx
	addq	%r14, %rbx
	addq	%r15, %rbx
	addq	%r12, %rbx
	addq	%rax, %rbx
	movq	%rbx, %rax
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.type	node1,@object           # @node1
	.data
	.globl	node1
	.p2align	4
node1:
	.quad	node2
	.quad	node3
	.quad	50                      # 0x32
	.size	node1, 24

	.type	node2,@object           # @node2
	.globl	node2
	.p2align	4
node2:
	.quad	node4
	.quad	node5
	.quad	25                      # 0x19
	.size	node2, 24

	.type	node3,@object           # @node3
	.globl	node3
	.p2align	4
node3:
	.quad	node6
	.quad	node7
	.quad	75                      # 0x4b
	.size	node3, 24

	.type	node4,@object           # @node4
	.globl	node4
	.p2align	4
node4:
	.quad	node8
	.quad	0
	.quad	10                      # 0xa
	.size	node4, 24

	.type	node5,@object           # @node5
	.globl	node5
	.p2align	4
node5:
	.quad	0
	.quad	0
	.quad	30                      # 0x1e
	.size	node5, 24

	.type	node6,@object           # @node6
	.globl	node6
	.p2align	4
node6:
	.quad	0
	.quad	0
	.quad	60                      # 0x3c
	.size	node6, 24

	.type	node7,@object           # @node7
	.globl	node7
	.p2align	4
node7:
	.quad	0
	.quad	0
	.quad	80                      # 0x50
	.size	node7, 24

	.type	node8,@object           # @node8
	.globl	node8
	.p2align	4
node8:
	.quad	0
	.quad	0
	.quad	1                       # 0x1
	.size	node8, 24


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym node1
	.addrsig_sym node2
	.addrsig_sym node3
	.addrsig_sym node4
	.addrsig_sym node5
	.addrsig_sym node6
	.addrsig_sym node7
	.addrsig_sym node8
