	.text
	.file	"list1.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movq	hd+8(%rip), %rax
	movq	8(%rax), %rax
	movq	(%rax), %rax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.type	hd,@object              # @hd
	.data
	.globl	hd
	.p2align	3
hd:
	.quad	1                       # 0x1
	.quad	md
	.size	hd, 16

	.type	md,@object              # @md
	.globl	md
	.p2align	3
md:
	.quad	2                       # 0x2
	.quad	tl
	.size	md, 16

	.type	tl,@object              # @tl
	.globl	tl
	.p2align	3
tl:
	.quad	3                       # 0x3
	.quad	0
	.size	tl, 16


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym md
	.addrsig_sym tl
