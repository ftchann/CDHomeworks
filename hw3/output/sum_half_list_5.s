	.text
	.file	"sum_half_list.ll"
	.globl	sum_half_list           # -- Begin function sum_half_list
	.p2align	4, 0x90
	.type	sum_half_list,@function
sum_half_list:                          # @sum_half_list
# %bb.0:
	xorl	%eax, %eax
	testq	%rdi, %rdi
	je	.LBB0_3
	.p2align	4, 0x90
.LBB0_1:                                # %else
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rdi), %rcx
	movq	8(%rdi), %rdi
	sarq	%rcx
	addq	%rcx, %rax
	testq	%rdi, %rdi
	jne	.LBB0_1
.LBB0_3:                                # %then
	retq
.Lfunc_end0:
	.size	sum_half_list, .Lfunc_end0-sum_half_list
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$test, %edi
	jmp	sum_half_list           # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.type	one_elt,@object         # @one_elt
	.data
	.globl	one_elt
	.p2align	3
one_elt:
	.quad	1                       # 0x1
	.quad	0
	.size	one_elt, 16

	.type	two_elts,@object        # @two_elts
	.globl	two_elts
	.p2align	3
two_elts:
	.quad	2                       # 0x2
	.quad	one_elt
	.size	two_elts, 16

	.type	three_elts,@object      # @three_elts
	.globl	three_elts
	.p2align	3
three_elts:
	.quad	4                       # 0x4
	.quad	two_elts
	.size	three_elts, 16

	.type	four_elts,@object       # @four_elts
	.globl	four_elts
	.p2align	3
four_elts:
	.quad	8                       # 0x8
	.quad	three_elts
	.size	four_elts, 16

	.type	test,@object            # @test
	.globl	test
	.p2align	3
test:
	.quad	16                      # 0x10
	.quad	four_elts
	.size	test, 16


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym one_elt
	.addrsig_sym two_elts
	.addrsig_sym three_elts
	.addrsig_sym four_elts
	.addrsig_sym test
