	.text
	.file	"linear_search.ll"
	.globl	search                  # -- Begin function search
	.p2align	4, 0x90
	.type	search,@function
search:                                 # @search
# %bb.0:
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB0_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	cmpq	$5, %rcx
	je	.LBB0_4
# %bb.2:                                # %check
                                        #   in Loop: Header=BB0_1 Depth=1
	cmpq	%rdi, (%rsi,%rcx,8)
	leaq	1(%rcx), %rcx
	jne	.LBB0_1
# %bb.3:
	movl	$1, %eax
.LBB0_4:                                # %true
	retq
.Lfunc_end0:
	.size	search, .Lfunc_end0-search
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$3, %edi
	movl	$glist, %esi
	jmp	search                  # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.type	glist,@object           # @glist
	.data
	.globl	glist
	.p2align	4
glist:
	.quad	1                       # 0x1
	.quad	2                       # 0x2
	.quad	3                       # 0x3
	.quad	4                       # 0x4
	.quad	5                       # 0x5
	.size	glist, 40


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym glist
