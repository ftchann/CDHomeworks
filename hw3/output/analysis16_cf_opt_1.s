	.text
	.file	"analysis16_cf_opt.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %foo
	movl	$6, %edx
	movl	$7, %ecx
.LBB0_1:                                # %continue_loop.lr.ph
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_2 Depth 2
	movq	%rdx, %rax
	movq	%rcx, %rdx
	.p2align	4, 0x90
.LBB0_2:                                # %continue_loop
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	subq	%rax, %rdx
	jl	.LBB0_4
# %bb.3:                                # %else
                                        #   in Loop: Header=BB0_2 Depth=2
	movq	%rdx, %rcx
	jne	.LBB0_2
	jmp	.LBB0_6
	.p2align	4, 0x90
.LBB0_4:                                # %if
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%rax, %rdx
	subq	%rcx, %rdx
	testq	%rcx, %rcx
	jne	.LBB0_1
# %bb.5:                                # %reta.loopexit22
	subq	%rcx, %rax
.LBB0_6:                                # %reta
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
