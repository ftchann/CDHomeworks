	.text
	.file	"analysis9_dce_opt.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %end
	movl	$18144000, %eax         # imm = 0x114DB00
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
