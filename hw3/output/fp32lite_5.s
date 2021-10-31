	.text
	.file	"fp32lite.ll"
	.globl	fp32_to_int             # -- Begin function fp32_to_int
	.p2align	4, 0x90
	.type	fp32_to_int,@function
fp32_to_int:                            # @fp32_to_int
# %bb.0:
	movl	%edi, %eax
	andl	$2147483647, %eax       # imm = 0x7FFFFFFF
	cmpq	$1065353216, %rax       # imm = 0x3F800000
	jb	.LBB0_1
# %bb.2:                                # %compute
	movq	%rax, %rcx
	shrq	$23, %rcx
	movl	%edi, %edx
	andl	$8388607, %edx          # imm = 0x7FFFFF
	orq	$8388608, %rdx          # imm = 0x800000
	cmpq	$1258291199, %rax       # imm = 0x4AFFFFFF
	ja	.LBB0_4
# %bb.3:                                # %shift_right
	movb	$-106, %al
	subb	%cl, %al
	movl	%eax, %ecx
	shrq	%cl, %rdx
	jmp	.LBB0_5
.LBB0_1:
	xorl	%edx, %edx
	jmp	.LBB0_5
.LBB0_4:                                # %shift_left
	addb	$106, %cl
                                        # kill: def $cl killed $cl killed $rcx
	shlq	%cl, %rdx
.LBB0_5:                                # %check_sign
	movq	%rdx, %rax
	negq	%rax
	testl	%edi, %edi
	cmovnsq	%rdx, %rax
	retq
.Lfunc_end0:
	.size	fp32_to_int, .Lfunc_end0-fp32_to_int
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$1132389990, %edi       # imm = 0x437EE666
	jmp	fp32_to_int             # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
