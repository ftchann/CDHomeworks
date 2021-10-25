	.text
	.file	"sieve.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	movl	$347, %edi              # imm = 0x15B
	jmp	is_prime                # TAILCALL
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.globl	is_prime                # -- Begin function is_prime
	.p2align	4, 0x90
	.type	is_prime,@function
is_prime:                               # @is_prime
	.cfi_startproc
# %bb.0:                                # %start1
	pushq	%r14
	.cfi_def_cfa_offset 16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset %rbx, -24
	.cfi_offset %r14, -16
	movq	%rdi, %r14
	movl	$8, %edi
	movl	$10000, %esi            # imm = 0x2710
	callq	ll_malloc
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rax)
	movl	$2, %ecx
	.p2align	4, 0x90
.LBB1_1:                                # %loop1
                                        # =>This Inner Loop Header: Depth=1
	movq	$1, (%rax,%rcx,8)
	addq	$1, %rcx
	cmpq	$10000, %rcx            # imm = 0x2710
	jne	.LBB1_1
# %bb.2:                                # %loop2.preheader
	movq	%rax, %rbx
	addq	$32, %rbx
	movl	$2, %edx
	movl	$16, %esi
	cmpq	$1, (%rax,%rdx,8)
	je	.LBB1_4
	.p2align	4, 0x90
.LBB1_7:                                # %else1
                                        # =>This Inner Loop Header: Depth=1
	addq	$1, %rdx
	addq	$16, %rbx
	addq	$8, %rsi
	cmpq	$10000, %rdx            # imm = 0x2710
	je	.LBB1_8
# %bb.3:                                # %loop2
                                        #   in Loop: Header=BB1_7 Depth=1
	cmpq	$1, (%rax,%rdx,8)
	jne	.LBB1_7
.LBB1_4:                                # %loop2
	cmpq	$4999, %rdx             # imm = 0x1387
	ja	.LBB1_7
# %bb.5:                                # %loop3.preheader
	leaq	(%rdx,%rdx), %rdi
	movq	%rbx, %rcx
	.p2align	4, 0x90
.LBB1_6:                                # %loop3
                                        # =>This Inner Loop Header: Depth=1
	movq	$0, (%rcx)
	addq	%rdx, %rdi
	addq	%rsi, %rcx
	cmpq	$10000, %rdi            # imm = 0x2710
	jb	.LBB1_6
	jmp	.LBB1_7
.LBB1_8:                                # %end2
	movq	(%rax,%r14,8), %rax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	is_prime, .Lfunc_end1-is_prime
	.cfi_endproc
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
