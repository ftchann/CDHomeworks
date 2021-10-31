	.text
	.file	"cbr.ll"
	.globl	foo                     # -- Begin function foo
	.p2align	4, 0x90
	.type	foo,@function
foo:                                    # @foo
# %bb.0:
	movl	$42, %eax
	retq
.Lfunc_end0:
	.size	foo, .Lfunc_end0-foo
                                        # -- End function
	.globl	bar                     # -- Begin function bar
	.p2align	4, 0x90
	.type	bar,@function
bar:                                    # @bar
# %bb.0:
	xorl	%eax, %eax
	retq
.Lfunc_end1:
	.size	bar, .Lfunc_end1-bar
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %then
	movl	$42, %eax
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
