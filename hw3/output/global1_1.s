	.text
	.file	"global1.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movq	gbl(%rip), %rax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.type	gbl,@object             # @gbl
	.data
	.globl	gbl
	.p2align	3
gbl:
	.quad	12                      # 0xc
	.size	gbl, 8


	.section	".note.GNU-stack","",@progbits
	.addrsig
