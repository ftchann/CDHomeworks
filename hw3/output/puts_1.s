	.text
	.file	"puts.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	movq	8(%rsi), %rdi
	movq	16(%rsi), %rsi
	callq	strcat
	xorl	%eax, %eax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	strcat                  # -- Begin function strcat
	.p2align	4, 0x90
	.type	strcat,@function
strcat:                                 # @strcat
	.cfi_startproc
# %bb.0:
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset %rbx, -16
	callq	ll_strcat
	movq	%rax, %rbx
	movq	%rax, %rdi
	callq	ll_puts
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	strcat, .Lfunc_end1-strcat
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
