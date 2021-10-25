	.text
	.file	"log.ll"
	.globl	log                     # -- Begin function log
	.p2align	4, 0x90
	.type	log,@function
log:                                    # @log
# %bb.0:
	xorl	%eax, %eax
	cmpq	$1, %rdi
	je	.LBB0_3
	.p2align	4, 0x90
.LBB0_1:                                # %else
                                        # =>This Inner Loop Header: Depth=1
	shrq	%rdi
	addq	$1, %rax
	cmpq	$1, %rdi
	jne	.LBB0_1
.LBB0_3:                                # %then
	retq
.Lfunc_end0:
	.size	log, .Lfunc_end0-log
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$16, %edi
	jmp	log                     # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
