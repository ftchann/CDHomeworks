	.text
	.file	"analysis10_dce_opt.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %then
	movl	$60, %eax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
