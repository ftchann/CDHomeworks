	.text
	.file	"duplicate_lbl.ll"
	.globl	f1                      # -- Begin function f1
	.p2align	4, 0x90
	.type	f1,@function
f1:                                     # @f1
# %bb.0:                                # %start
	xorl	%eax, %eax
	cmpq	$10, %rdi
	setg	%al
	retq
.Lfunc_end0:
	.size	f1, .Lfunc_end0-f1
                                        # -- End function
	.globl	f2                      # -- Begin function f2
	.p2align	4, 0x90
	.type	f2,@function
f2:                                     # @f2
# %bb.0:                                # %start
	xorl	%eax, %eax
	cmpq	$10, %rdi
	setg	%al
	retq
.Lfunc_end1:
	.size	f2, .Lfunc_end1-f2
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushq	%rbx
	xorl	%edi, %edi
	callq	f1
	movq	%rax, %rbx
	movl	$15, %edi
	callq	f2
	addq	%rbx, %rax
	popq	%rbx
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
