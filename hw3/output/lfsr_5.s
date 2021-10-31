	.text
	.file	"lfsr.ll"
	.globl	one_iteration           # -- Begin function one_iteration
	.p2align	4, 0x90
	.type	one_iteration,@function
one_iteration:                          # @one_iteration
# %bb.0:
	leaq	(%rdi,%rdi), %rax
	xorq	%rdi, %rax
	leaq	(,%rdi,8), %rcx
	shlq	$4, %rdi
	xorq	%rdi, %rcx
	xorq	%rax, %rcx
	movq	%rcx, %rax
	shrq	$63, %rax
	orq	%rcx, %rax
	retq
.Lfunc_end0:
	.size	one_iteration, .Lfunc_end0-one_iteration
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %end
	movl	$4, %edi
	jmp	one_iteration           # TAILCALL
.Lfunc_end1:
	.size	main, .Lfunc_end1-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
