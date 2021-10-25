	.text
	.file	"lcs.ll"
	.globl	lcs                     # -- Begin function lcs
	.p2align	4, 0x90
	.type	lcs,@function
lcs:                                    # @lcs
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	testq	%rdi, %rdi
	je	.LBB0_5
# %bb.1:
	testq	%rsi, %rsi
	je	.LBB0_5
# %bb.2:                                # %then
	movq	%rdi, %rbx
	addq	$-1, %rdi
	leaq	-1(%rsi), %r14
	movq	str1-8(,%rbx,8), %rax
	cmpq	str2-8(,%rsi,8), %rax
	jne	.LBB0_4
# %bb.3:                                # %eq_recurse
	movq	%r14, %rsi
	callq	lcs
	addq	$1, %rax
	jmp	.LBB0_6
.LBB0_5:                                # %ret1
	xorl	%eax, %eax
	jmp	.LBB0_6
.LBB0_4:                                # %not_eq_recurse
	callq	lcs
	movq	%rax, %r15
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	lcs
	cmpq	%rax, %r15
	cmovlq	%rax, %r15
	movq	%r15, %rax
.LBB0_6:                                # %ret1
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end0:
	.size	lcs, .Lfunc_end0-lcs
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$7, %edi
	movl	$6, %esi
	jmp	lcs                     # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function
	.type	str1,@object            # @str1
	.data
	.globl	str1
	.p2align	4
str1:
	.quad	1                       # 0x1
	.quad	2                       # 0x2
	.quad	3                       # 0x3
	.quad	2                       # 0x2
	.quad	4                       # 0x4
	.quad	1                       # 0x1
	.quad	2                       # 0x2
	.size	str1, 56

	.type	str2,@object            # @str2
	.globl	str2
	.p2align	4
str2:
	.quad	2                       # 0x2
	.quad	4                       # 0x4
	.quad	3                       # 0x3
	.quad	1                       # 0x1
	.quad	2                       # 0x2
	.quad	1                       # 0x1
	.size	str2, 48


	.section	".note.GNU-stack","",@progbits
	.addrsig
