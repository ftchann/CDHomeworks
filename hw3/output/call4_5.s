	.text
	.file	"call4.ll"
	.globl	bar                     # -- Begin function bar
	.p2align	4, 0x90
	.type	bar,@function
bar:                                    # @bar
# %bb.0:
	leaq	(%rdi,%rsi), %rax
	retq
.Lfunc_end0:
	.size	bar, .Lfunc_end0-bar
                                        # -- End function
	.globl	foo                     # -- Begin function foo
	.p2align	4, 0x90
	.type	foo,@function
foo:                                    # @foo
# %bb.0:
	movq	%rdi, %rsi
	jmp	bar                     # TAILCALL
.Lfunc_end1:
	.size	foo, .Lfunc_end1-foo
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$17, %edi
	jmp	foo                     # TAILCALL
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
