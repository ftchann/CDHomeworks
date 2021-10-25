	.text
	.file	"our_test.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movq	$10, tmp(%rip)
	movq	$11, tmp+8(%rip)
	movq	v2+16(%rip), %rax
	movq	8(%rax), %rax
	movq	$10, (%rax)
	movq	tmp(%rip), %rax
	subq	tmp+8(%rip), %rax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.type	tmp,@object             # @tmp
	.bss
	.globl	tmp
	.p2align	3
tmp:
	.zero	16
	.size	tmp, 16

	.type	v1,@object              # @v1
	.data
	.globl	v1
	.p2align	3
v1:
	.quad	2                       # 0x2
	.quad	tmp
	.size	v1, 16

	.type	v2,@object              # @v2
	.globl	v2
	.p2align	4
v2:
	.quad	1                       # 0x1
	.quad	0
	.quad	v1
	.size	v2, 24


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym tmp
	.addrsig_sym v1
