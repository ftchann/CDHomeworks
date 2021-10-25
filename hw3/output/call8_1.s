	.text
	.file	"call8.ll"
	.globl	foo                     # -- Begin function foo
	.p2align	4, 0x90
	.type	foo,@function
foo:                                    # @foo
# %bb.0:
	movq	%r9, %rax
	retq
.Lfunc_end0:
	.size	foo, .Lfunc_end0-foo
                                        # -- End function
	.globl	bar                     # -- Begin function bar
	.p2align	4, 0x90
	.type	bar,@function
bar:                                    # @bar
# %bb.0:
	movq	8(%rsp), %rax
	retq
.Lfunc_end1:
	.size	bar, .Lfunc_end1-bar
                                        # -- End function
	.globl	baz                     # -- Begin function baz
	.p2align	4, 0x90
	.type	baz,@function
baz:                                    # @baz
# %bb.0:
	movq	16(%rsp), %rax
	retq
.Lfunc_end2:
	.size	baz, .Lfunc_end2-baz
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$21, %eax
	retq
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
