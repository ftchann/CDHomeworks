	.text
	.file	"gep4.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movq	gbl+8(%rip), %rax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.type	gbl,@object             # @gbl
	.data
	.globl	gbl
	.p2align	4
gbl:
	.quad	1                       # 0x1
	.quad	2                       # 0x2
	.quad	3                       # 0x3
	.quad	4                       # 0x4
	.quad	5                       # 0x5
	.quad	6                       # 0x6
	.quad	7                       # 0x7
	.size	gbl, 56


	.section	".note.GNU-stack","",@progbits
	.addrsig
