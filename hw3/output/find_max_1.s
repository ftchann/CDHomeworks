	.text
	.file	"find_max.ll"
	.globl	find_max                # -- Begin function find_max
	.p2align	4, 0x90
	.type	find_max,@function
find_max:                               # @find_max
# %bb.0:
	movq	$-64, %rcx
	movq	input(%rip), %rdx
	.p2align	4, 0x90
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	movq	%rdx, %rax
	movq	input+64(%rcx), %rdx
	cmpq	%rdx, %rax
	cmovgeq	%rax, %rdx
	addq	$8, %rcx
	jne	.LBB0_1
# %bb.2:                                # %end
	retq
.Lfunc_end0:
	.size	find_max, .Lfunc_end0-find_max
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	jmp	find_max                # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.type	input,@object           # @input
	.data
	.globl	input
	.p2align	4
input:
	.quad	50                      # 0x32
	.quad	60                      # 0x3c
	.quad	40                      # 0x28
	.quad	70                      # 0x46
	.quad	30                      # 0x1e
	.quad	80                      # 0x50
	.quad	20                      # 0x14
	.quad	80                      # 0x50
	.size	input, 64

	.type	length,@object          # @length
	.globl	length
	.p2align	3
length:
	.quad	8                       # 0x8
	.size	length, 8


	.section	".note.GNU-stack","",@progbits
	.addrsig
