	.text
	.file	"euclid.ll"
	.globl	gcd_rec                 # -- Begin function gcd_rec
	.p2align	4, 0x90
	.type	gcd_rec,@function
gcd_rec:                                # @gcd_rec
# %bb.0:
	movq	%rdi, %rax
	.p2align	4, 0x90
.LBB0_1:                                # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_3 Depth 2
	testq	%rsi, %rsi
	je	.LBB0_4
# %bb.2:                                # %neq0.preheader
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%rax, %rcx
	movq	%rsi, %rax
	movq	%rcx, %rsi
	.p2align	4, 0x90
.LBB0_3:                                # %neq0
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	subq	%rax, %rsi
	cmpq	%rax, %rsi
	jg	.LBB0_3
	jmp	.LBB0_1
.LBB0_4:                                # %eq0
	retq
.Lfunc_end0:
	.size	gcd_rec, .Lfunc_end0-gcd_rec
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$424, %edi              # imm = 0x1A8
	movl	$34, %esi
	jmp	gcd_rec                 # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
