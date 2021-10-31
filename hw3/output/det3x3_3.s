	.text
	.file	"det3x3.ll"
	.globl	calc_det                # -- Begin function calc_det
	.p2align	4, 0x90
	.type	calc_det,@function
calc_det:                               # @calc_det
# %bb.0:
	movq	row2(%rip), %r9
	movq	row2+8(%rip), %r8
	movq	row2+16(%rip), %rsi
	movq	row3(%rip), %r10
	movq	row3+8(%rip), %rax
	movq	row3+16(%rip), %rcx
	movq	%rcx, %rdx
	imulq	%r8, %rdx
	movq	%rax, %rdi
	imulq	%rsi, %rdi
	subq	%rdi, %rdx
	imulq	%r9, %rcx
	imulq	%r10, %rsi
	subq	%rcx, %rsi
	imulq	%r9, %rax
	imulq	%r8, %r10
	subq	%r10, %rax
	imulq	row1(%rip), %rdx
	imulq	row1+8(%rip), %rsi
	imulq	row1+16(%rip), %rax
	addq	%rsi, %rax
	addq	%rdx, %rax
	retq
.Lfunc_end0:
	.size	calc_det, .Lfunc_end0-calc_det
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	jmp	calc_det                # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.type	row1,@object            # @row1
	.data
	.globl	row1
	.p2align	4
row1:
	.quad	4                       # 0x4
	.quad	3                       # 0x3
	.quad	6                       # 0x6
	.size	row1, 24

	.type	row2,@object            # @row2
	.globl	row2
	.p2align	4
row2:
	.quad	5                       # 0x5
	.quad	1                       # 0x1
	.quad	2                       # 0x2
	.size	row2, 24

	.type	row3,@object            # @row3
	.globl	row3
	.p2align	4
row3:
	.quad	6                       # 0x6
	.quad	1                       # 0x1
	.quad	1                       # 0x1
	.size	row3, 24


	.section	".note.GNU-stack","",@progbits
	.addrsig
