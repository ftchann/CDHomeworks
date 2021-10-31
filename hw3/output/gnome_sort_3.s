	.text
	.file	"gnome_sort.ll"
	.globl	sort                    # -- Begin function sort
	.p2align	4, 0x90
	.type	sort,@function
sort:                                   # @sort
# %bb.0:
	leaq	8(%rdi), %rcx
	leaq	16(%rdi), %rsi
	movl	$1, %r9d
	movl	$2, %r8d
	movb	$1, %r10b
	jmp	.LBB0_1
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
	movq	%r8, %r9
.LBB0_5:                                # %loop.outer.backedge
                                        #   in Loop: Header=BB0_1 Depth=1
	leaq	1(%r9), %r8
	testq	%r9, %r9
	setg	%r10b
	leaq	(%rdi,%r9,8), %rcx
	leaq	(%rdi,%r9,8), %rsi
	addq	$8, %rsi
	cmpq	$9, %r9
	jge	.LBB0_6
	.p2align	4, 0x90
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rcx), %rax
	movq	(%rsi), %rdx
	cmpq	%rdx, %rax
	jl	.LBB0_2
# %bb.3:                                # %swap
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%rax, (%rsi)
	movq	%rdx, (%rcx)
	testb	$1, %r10b
	je	.LBB0_1
# %bb.4:                                # %decc
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%rax, (%rsi)
	movq	%rdx, (%rcx)
	addq	$-1, %r9
	jmp	.LBB0_5
.LBB0_6:                                # %done.split
	retq
.Lfunc_end0:
	.size	sort, .Lfunc_end0-sort
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$glist, %edi
	callq	sort
	movq	glist+8(%rip), %rax
	addq	glist(%rip), %rax
	subq	glist+64(%rip), %rax
	addq	glist+72(%rip), %rax
	retq
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.type	glist,@object           # @glist
	.data
	.globl	glist
	.p2align	4
glist:
	.quad	20                      # 0x14
	.quad	17                      # 0x11
	.quad	13                      # 0xd
	.quad	14                      # 0xe
	.quad	6                       # 0x6
	.quad	5                       # 0x5
	.quad	4                       # 0x4
	.quad	3                       # 0x3
	.quad	2                       # 0x2
	.quad	1                       # 0x1
	.size	glist, 80


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym glist
