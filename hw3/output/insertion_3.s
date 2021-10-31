	.text
	.file	"insertion.ll"
	.globl	insertionSort           # -- Begin function insertionSort
	.p2align	4, 0x90
	.type	insertionSort,@function
insertionSort:                          # @insertionSort
# %bb.0:
	movq	length(%rip), %rax
	cmpq	$2, %rax
	jl	.LBB0_7
# %bb.1:                                # %while_cond_2.preheader.preheader
	movl	$1, %ecx
	jmp	.LBB0_2
	.p2align	4, 0x90
.LBB0_6:                                # %while_end_2
                                        #   in Loop: Header=BB0_2 Depth=1
	addq	$1, %rcx
	cmpq	%rax, %rcx
	je	.LBB0_7
.LBB0_2:                                # %while_cond_2.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_4 Depth 2
	movq	input-8(,%rcx,8), %rsi
	movq	input(,%rcx,8), %rdx
	cmpq	%rdx, %rsi
	jle	.LBB0_6
# %bb.3:                                # %while_body_2.preheader
                                        #   in Loop: Header=BB0_2 Depth=1
	leaq	-1(%rcx), %rdi
	.p2align	4, 0x90
.LBB0_4:                                # %while_body_2
                                        #   Parent Loop BB0_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%rdx, input(,%rdi,8)
	movq	%rsi, input+8(,%rdi,8)
	testq	%rdi, %rdi
	jle	.LBB0_6
# %bb.5:                                # %while_body_2
                                        #   in Loop: Header=BB0_4 Depth=2
	movq	input-8(,%rdi,8), %rsi
	addq	$-1, %rdi
	cmpq	%rdx, %rsi
	jg	.LBB0_4
	jmp	.LBB0_6
.LBB0_7:                                # %while_end_1
	retq
.Lfunc_end0:
	.size	insertionSort, .Lfunc_end0-insertionSort
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	callq	insertionSort
	movq	input+40(%rip), %rax
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.type	input,@object           # @input
	.data
	.globl	input
	.p2align	4
input:
	.quad	10                      # 0xa
	.quad	5                       # 0x5
	.quad	134                     # 0x86
	.quad	9                       # 0x9
	.quad	11                      # 0xb
	.quad	7                       # 0x7
	.quad	200                     # 0xc8
	.quad	65                      # 0x41
	.quad	74                      # 0x4a
	.quad	2                       # 0x2
	.size	input, 80

	.type	length,@object          # @length
	.globl	length
	.p2align	3
length:
	.quad	10                      # 0xa
	.size	length, 8


	.section	".note.GNU-stack","",@progbits
	.addrsig
