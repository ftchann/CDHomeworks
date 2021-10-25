	.text
	.file	"factrect.ll"
	.globl	factorial               # -- Begin function factorial
	.p2align	4, 0x90
	.type	factorial,@function
factorial:                              # @factorial
# %bb.0:
	movl	$1, %eax
	testq	%rdi, %rdi
	je	.LBB0_2
	.p2align	4, 0x90
.LBB0_1:                                # %recurse
                                        # =>This Inner Loop Header: Depth=1
	imulq	%rdi, %rax
	addq	$-1, %rdi
	jne	.LBB0_1
.LBB0_2:                                # %ret1
	retq
.Lfunc_end0:
	.size	factorial, .Lfunc_end0-factorial
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$5, %edi
	jmp	factorial               # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
