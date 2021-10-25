	.text
	.file	"callback1.ll"
	.globl	foo                     # -- Begin function foo
	.p2align	4, 0x90
	.type	foo,@function
foo:                                    # @foo
# %bb.0:
	leaq	(%rdi,%rsi), %rax
	retq
.Lfunc_end0:
	.size	foo, .Lfunc_end0-foo
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	movl	$foo, %edi
	callq	ll_callback
	movq	%rax, %rdi
	callq	ll_ltoa
	movq	%rax, %rdi
	callq	ll_puts
	xorl	%eax, %eax
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym foo
