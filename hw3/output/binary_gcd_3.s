	.text
	.file	"binary_gcd.ll"
	.globl	binary_gcd              # -- Begin function binary_gcd
	.p2align	4, 0x90
	.type	binary_gcd,@function
binary_gcd:                             # @binary_gcd
# %bb.0:
	cmpq	%rsi, %rdi
	je	.LBB0_1
.LBB0_2:                                # %term1.lr.ph
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
	movq	%rsi, %rcx
	.p2align	4, 0x90
.LBB0_3:                                # %term1
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	testq	%rdi, %rdi
	je	.LBB0_14
# %bb.4:                                # %term2
                                        #   in Loop: Header=BB0_3 Depth=2
	testq	%rcx, %rcx
	je	.LBB0_1
# %bb.5:                                # %gcd
                                        #   in Loop: Header=BB0_3 Depth=2
	testb	$1, %dil
	je	.LBB0_8
# %bb.6:                                # %u_odd
                                        #   in Loop: Header=BB0_3 Depth=2
	testb	$1, %cl
	jne	.LBB0_10
# %bb.7:                                # %v_even
                                        #   in Loop: Header=BB0_3 Depth=2
	shrq	%rcx
	cmpq	%rcx, %rdi
	jne	.LBB0_3
	jmp	.LBB0_1
.LBB0_8:                                # %u_even
                                        #   in Loop: Header=BB0_2 Depth=1
	shrq	%rdi
	testb	$1, %cl
	je	.LBB0_17
# %bb.9:                                #   in Loop: Header=BB0_2 Depth=1
	movq	%rdi, %rax
	movq	%rsi, %rdi
	jmp	.LBB0_13
.LBB0_10:                               # %v_odd
                                        #   in Loop: Header=BB0_2 Depth=1
	movq	%rdi, %rax
	subq	%rcx, %rax
	jle	.LBB0_12
# %bb.11:                               # %u_gt
                                        #   in Loop: Header=BB0_2 Depth=1
	shrq	%rax
	movq	%rcx, %rdi
	jmp	.LBB0_13
.LBB0_12:                               # %v_gt
                                        #   in Loop: Header=BB0_2 Depth=1
	subq	%rdi, %rcx
	shrq	%rcx
	movq	%rcx, %rax
.LBB0_13:                               # %tailrecurse.outer.backedge
                                        #   in Loop: Header=BB0_2 Depth=1
	movq	%rdi, %rsi
	cmpq	%rdi, %rax
	movq	%rax, %rdi
	jne	.LBB0_2
	jmp	.LBB0_18
.LBB0_1:
	movq	%rdi, %rax
	retq
.LBB0_14:
	movq	%rsi, %rax
	retq
.LBB0_17:                               # %both_even
	shrq	%rsi
	callq	binary_gcd
	addq	%rax, %rax
.LBB0_18:                               # %ret_u
	retq
.Lfunc_end0:
	.size	binary_gcd, .Lfunc_end0-binary_gcd
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$21, %edi
	movl	$15, %esi
	jmp	binary_gcd              # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
