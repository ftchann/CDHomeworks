	.text
	.file	"weighted_sum.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	movl	$1, %edi
	movl	$2, %esi
	movl	$3, %edx
	movl	$4, %ecx
	movl	$5, %r8d
	movl	$6, %r9d
	pushq	$8
	.cfi_adjust_cfa_offset 8
	pushq	$7
	.cfi_adjust_cfa_offset 8
	callq	ll_weighted_sum
	addq	$16, %rsp
	.cfi_adjust_cfa_offset -16
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
