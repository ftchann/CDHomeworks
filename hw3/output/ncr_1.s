	.text
	.file	"ncr.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movl	$9, %edi
	callq	fac
	movq	%rax, %r14
	movl	$3, %edi
	callq	fac
	movq	%rax, %rbx
	movl	$6, %edi
	callq	fac
	imulq	%rbx, %rax
	movq	%r14, %rdi
	movq	%rax, %rsi
	popq	%rbx
	popq	%r14
	jmp	div                     # TAILCALL
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.globl	div                     # -- Begin function div
	.p2align	4, 0x90
	.type	div,@function
div:                                    # @div
# %bb.0:
	xorl	%eax, %eax
	cmpq	%rsi, %rdi
	jl	.LBB1_3
	.p2align	4, 0x90
.LBB1_1:                                # %recc
                                        # =>This Inner Loop Header: Depth=1
	subq	%rsi, %rdi
	addq	$1, %rax
	cmpq	%rsi, %rdi
	jge	.LBB1_1
.LBB1_3:                                # %rett
	retq
.Lfunc_end1:
	.size	div, .Lfunc_end1-div
                                        # -- End function
	.globl	fac                     # -- Begin function fac
	.p2align	4, 0x90
	.type	fac,@function
fac:                                    # @fac
# %bb.0:
	movl	$1, %eax
	testq	%rdi, %rdi
	jle	.LBB2_2
	.p2align	4, 0x90
.LBB2_1:                                # %rec
                                        # =>This Inner Loop Header: Depth=1
	imulq	%rdi, %rax
	cmpq	$2, %rdi
	leaq	-1(%rdi), %rdi
	jge	.LBB2_1
.LBB2_2:                                # %rett
	retq
.Lfunc_end2:
	.size	fac, .Lfunc_end2-fac
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
