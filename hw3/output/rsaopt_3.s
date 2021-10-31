	.text
	.file	"rsaopt.ll"
	.globl	rsa_decrypt             # -- Begin function rsa_decrypt
	.p2align	4, 0x90
	.type	rsa_decrypt,@function
rsa_decrypt:                            # @rsa_decrypt
# %bb.0:
	movl	$1, %esi
	movl	$1409083253, %eax       # imm = 0x53FCE775
	.p2align	4, 0x90
.LBB0_1:                                # %_body__13
                                        # =>This Inner Loop Header: Depth=1
	imulq	%rdi, %rsi
	addq	$-1, %rax
	jne	.LBB0_1
# %bb.2:                                # %_post__33
	movl	$2935956180, %eax       # imm = 0xAEFF22D4
	leaq	(%rsi,%rax), %rcx
	cmpq	%rax, %rsi
	cmovleq	%rsi, %rax
	subq	%rax, %rcx
	movabsq	$6746367931765152049, %rdx # imm = 0x5D9FE9E3E0F2D931
	movq	%rcx, %rax
	mulq	%rdx
	shrq	$30, %rdx
	movl	$2935956181, %edi       # imm = 0xAEFF22D5
	imulq	%rdx, %rdi
	movq	%rcx, %rax
	subq	%rdi, %rax
	subq	%rcx, %rax
	addq	%rsi, %rax
	retq
.Lfunc_end0:
	.size	rsa_decrypt, .Lfunc_end0-rsa_decrypt
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$42, %edi
	jmp	rsa_decrypt             # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
