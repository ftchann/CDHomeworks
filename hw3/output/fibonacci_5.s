	.text
	.file	"fibonacci.ll"
	.globl	fibonacci               # -- Begin function fibonacci
	.p2align	4, 0x90
	.type	fibonacci,@function
fibonacci:                              # @fibonacci
# %bb.0:
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %rbx
	cmpq	$1, %rdi
	jg	.LBB0_3
# %bb.1:                                # %base_case
	movq	%rbx, %rax
	jmp	.LBB0_2
.LBB0_3:                                # %recurse
	leaq	-1(%rbx), %rdi
	addq	$-2, %rbx
	callq	fibonacci
	movq	%rax, %r14
	movq	%rbx, %rdi
	callq	fibonacci
	addq	%r14, %rax
.LBB0_2:                                # %base_case
	popq	%rbx
	popq	%r14
	retq
.Lfunc_end0:
	.size	fibonacci, .Lfunc_end0-fibonacci
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$6, %edi
	jmp	fibonacci               # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
