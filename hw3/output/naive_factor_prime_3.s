	.text
	.file	"naive_factor_prime.ll"
	.globl	naive_mod               # -- Begin function naive_mod
	.p2align	4, 0x90
	.type	naive_mod,@function
naive_mod:                              # @naive_mod
# %bb.0:
	movq	%rsi, %rax
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB0_1:                                # %start
                                        # =>This Inner Loop Header: Depth=1
	addq	%rax, %rcx
	cmpq	%rdi, %rcx
	jle	.LBB0_1
# %bb.2:                                # %final
	addq	%rdi, %rax
	subq	%rcx, %rax
	retq
.Lfunc_end0:
	.size	naive_mod, .Lfunc_end0-naive_mod
                                        # -- End function
	.globl	naive_prime             # -- Begin function naive_prime
	.p2align	4, 0x90
	.type	naive_prime,@function
naive_prime:                            # @naive_prime
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	movq	%rdi, %r15
	movl	$2, %ebx
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB1_1:                                # %loop
                                        # =>This Inner Loop Header: Depth=1
	movq	%rbx, %rax
	imulq	%rbx, %rax
	cmpq	%r15, %rax
	jg	.LBB1_2
# %bb.3:                                # %inc
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	%rbx, %rsi
	addq	$1, %rbx
	movq	%r15, %rdi
	callq	naive_mod
	testq	%rax, %rax
	jne	.LBB1_1
	jmp	.LBB1_4
.LBB1_2:
	movl	$1, %r14d
.LBB1_4:                                # %final_false
	movq	%r14, %rax
	popq	%rbx
	popq	%r14
	popq	%r15
	retq
.Lfunc_end1:
	.size	naive_prime, .Lfunc_end1-naive_prime
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$19, %edi
	jmp	naive_prime             # TAILCALL
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
