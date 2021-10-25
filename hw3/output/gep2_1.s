	.text
	.file	"gep2.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movq	tmp+24(%rip), %rax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.type	tmp,@object             # @tmp
	.data
	.globl	tmp
	.p2align	4
tmp:
	.quad	1                       # 0x1
	.quad	2                       # 0x2
	.quad	3                       # 0x3
	.quad	4                       # 0x4
	.quad	5                       # 0x5
	.size	tmp, 40


	.section	".note.GNU-stack","",@progbits
	.addrsig
