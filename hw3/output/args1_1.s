	.text
	.file	"args1.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	cmpq	$2, %rdi
	jg	.LBB0_3
# %bb.1:                                # %few
	movl	$toofew, %edi
	jmp	.LBB0_2
.LBB0_3:                                # %else
	cmpq	$3, %rdi
	jne	.LBB0_4
# %bb.5:                                # %right
	movq	8(%rsi), %rdi
	movq	16(%rsi), %rsi
	callq	ll_strcat
	movq	%rax, %rdi
	jmp	.LBB0_2
.LBB0_4:                                # %many
	movl	$toomany, %edi
.LBB0_2:                                # %few
	callq	ll_puts
	xorl	%eax, %eax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	toofew,@object          # @toofew
	.data
	.globl	toofew
toofew:
	.asciz	"argc < 3"
	.size	toofew, 9

	.type	toomany,@object         # @toomany
	.globl	toomany
toomany:
	.asciz	"argc > 3"
	.size	toomany, 9


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym toofew
	.addrsig_sym toomany
