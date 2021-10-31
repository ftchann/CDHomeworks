	.text
	.file	"duplicate_factorial.ll"
	.globl	factorial               # -- Begin function factorial
	.p2align	4, 0x90
	.type	factorial,@function
factorial:                              # @factorial
# %bb.0:
	movl	$1, %eax
	testq	%rdi, %rdi
	jle	.LBB0_2
	.p2align	4, 0x90
.LBB0_1:                                # %then
                                        # =>This Inner Loop Header: Depth=1
	imulq	%rdi, %rax
	addq	$-1, %rdi
	jg	.LBB0_1
.LBB0_2:                                # %end
	retq
.Lfunc_end0:
	.size	factorial, .Lfunc_end0-factorial
                                        # -- End function
	.globl	factorial2              # -- Begin function factorial2
	.p2align	4, 0x90
	.type	factorial2,@function
factorial2:                             # @factorial2
# %bb.0:
	movl	$1, %eax
	testq	%rdi, %rdi
	jle	.LBB1_2
	.p2align	4, 0x90
.LBB1_1:                                # %then
                                        # =>This Inner Loop Header: Depth=1
	imulq	%rdi, %rax
	addq	$-1, %rdi
	jg	.LBB1_1
.LBB1_2:                                # %end
	retq
.Lfunc_end1:
	.size	factorial2, .Lfunc_end1-factorial2
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushq	%rbx
	movl	$5, %edi
	callq	factorial
	movq	%rax, %rbx
	movl	$5, %edi
	callq	factorial2
	addq	%rbx, %rax
	popq	%rbx
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
