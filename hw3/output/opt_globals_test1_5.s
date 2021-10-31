	.text
	.file	"opt_globals_test1.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movq	$5, y(%rip)
	movl	$5, %eax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.type	x,@object               # @x
	.data
	.globl	x
	.p2align	3
x:
	.quad	1                       # 0x1
	.size	x, 8

	.type	y,@object               # @y
	.globl	y
	.p2align	3
y:
	.quad	2                       # 0x2
	.size	y, 8


	.section	".note.GNU-stack","",@progbits
	.addrsig
