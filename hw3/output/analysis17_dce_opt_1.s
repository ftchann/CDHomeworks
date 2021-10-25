	.text
	.file	"analysis17_dce_opt.ll"
	.globl	foo                     # -- Begin function foo
	.p2align	4, 0x90
	.type	foo,@function
foo:                                    # @foo
# %bb.0:
	movq	%rdi, %rax
	retq
.Lfunc_end0:
	.size	foo, .Lfunc_end0-foo
                                        # -- End function
	.globl	bar                     # -- Begin function bar
	.p2align	4, 0x90
	.type	bar,@function
bar:                                    # @bar
# %bb.0:                                # %l1
	addq	%rsi, %rdi
	leaq	(%rdi,%rdi,2), %rax
	addq	$-6, %rax
	retq
.Lfunc_end1:
	.size	bar, .Lfunc_end1-bar
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$5, %edi
	movl	$9, %esi
	jmp	bar                     # TAILCALL
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
