	.text
	.file	"gep1.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movq	$5, v2(%rip)
	movl	$v2, %edi
	callq	foo
	movq	v2(%rip), %rax
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.globl	foo                     # -- Begin function foo
	.p2align	4, 0x90
	.type	foo,@function
foo:                                    # @foo
# %bb.0:
	movq	$6, (%rdi)
	retq
.Lfunc_end1:
	.size	foo, .Lfunc_end1-foo
                                        # -- End function
	.type	gint,@object            # @gint
	.data
	.globl	gint
	.p2align	3
gint:
	.quad	42                      # 0x2a
	.size	gint, 8

	.type	v1,@object              # @v1
	.globl	v1
	.p2align	3
v1:
	.quad	0                       # 0x0
	.quad	gint
	.size	v1, 16

	.type	v2,@object              # @v2
	.globl	v2
	.p2align	3
v2:
	.quad	1                       # 0x1
	.quad	0
	.size	v2, 16

	.type	gstr,@object            # @gstr
	.globl	gstr
gstr:
	.asciz	"hello, world!"
	.size	gstr, 14


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym gint
	.addrsig_sym v2
