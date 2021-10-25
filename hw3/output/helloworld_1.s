	.text
	.file	"helloworld.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	movl	$gstr, %edi
	callq	ll_puts
	xorl	%eax, %eax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.type	gstr,@object            # @gstr
	.data
	.globl	gstr
gstr:
	.asciz	"hello, world!"
	.size	gstr, 14


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym gstr
