	.text
	.file	"sum_tree.ll"
	.globl	sum_tree                # -- Begin function sum_tree
	.p2align	4, 0x90
	.type	sum_tree,@function
sum_tree:                               # @sum_tree
# %bb.0:
	pushq	%r14
	pushq	%rbx
	testq	%rdi, %rdi
	je	.LBB0_1
# %bb.3:                                # %else.preheader
	movq	%rdi, %r14
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB0_4:                                # %else
                                        # =>This Inner Loop Header: Depth=1
	movq	8(%r14), %rdi
	addq	16(%r14), %rbx
	callq	sum_tree
	movq	(%r14), %r14
	addq	%rbx, %rax
	movq	%rax, %rbx
	testq	%r14, %r14
	jne	.LBB0_4
	jmp	.LBB0_2
.LBB0_1:
	xorl	%eax, %eax
.LBB0_2:                                # %then
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end0:
	.size	sum_tree, .Lfunc_end0-sum_tree
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$test, %edi
	jmp	sum_tree                # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.type	test1,@object           # @test1
	.data
	.globl	test1
	.p2align	4
test1:
	.quad	0
	.quad	0
	.quad	100                     # 0x64
	.size	test1, 24

	.type	test2,@object           # @test2
	.globl	test2
	.p2align	4
test2:
	.quad	test1
	.quad	0
	.quad	10                      # 0xa
	.size	test2, 24

	.type	test3,@object           # @test3
	.globl	test3
	.p2align	4
test3:
	.quad	0
	.quad	0
	.quad	1                       # 0x1
	.size	test3, 24

	.type	test,@object            # @test
	.globl	test
	.p2align	4
test:
	.quad	test2
	.quad	test3
	.quad	5                       # 0x5
	.size	test, 24


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym test1
	.addrsig_sym test2
	.addrsig_sym test3
	.addrsig_sym test
