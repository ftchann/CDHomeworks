	.text
	.file	"ackermann.ll"
	.globl	ack                     # -- Begin function ack
	.p2align	4, 0x90
	.type	ack,@function
ack:                                    # @ack
# %bb.0:
	pushq	%rbx
	movq	%rsi, %rax
	testq	%rdi, %rdi
	jg	.LBB0_1
	jmp	.LBB0_5
	.p2align	4, 0x90
.LBB0_3:                                # %nnonzero
                                        #   in Loop: Header=BB0_1 Depth=1
	addq	$-1, %rax
	movq	%rax, %rsi
	callq	ack
.LBB0_4:                                # %tailrecurse.backedge
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%rbx, %rdi
	testq	%rbx, %rbx
	jle	.LBB0_5
.LBB0_1:                                # %mnonzero
                                        # =>This Inner Loop Header: Depth=1
	leaq	-1(%rdi), %rbx
	testq	%rax, %rax
	jg	.LBB0_3
# %bb.2:                                #   in Loop: Header=BB0_1 Depth=1
	movl	$1, %eax
	jmp	.LBB0_4
.LBB0_5:                                # %mzero
	addq	$1, %rax
	popq	%rbx
	retq
.Lfunc_end0:
	.size	ack, .Lfunc_end0-ack
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$2, %edi
	movl	$2, %esi
	jmp	ack                     # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
