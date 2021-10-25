	.text
	.file	"quicksort.ll"
	.globl	partition               # -- Begin function partition
	.p2align	4, 0x90
	.type	partition,@function
partition:                              # @partition
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %r12
	cmpq	%rdx, %rsi
	jg	.LBB0_5
# %bb.1:                                # %loop_body.preheader
	movq	(%r12,%r14,8), %r13
	movq	%r15, %rbx
	cmpq	%r13, (%r12,%rbx,8)
	jl	.LBB0_3
	.p2align	4, 0x90
.LBB0_4:                                # %if_end
                                        # =>This Inner Loop Header: Depth=1
	addq	$1, %rbx
	cmpq	%r14, %rbx
	jg	.LBB0_5
# %bb.2:                                # %loop_body
                                        #   in Loop: Header=BB0_4 Depth=1
	cmpq	%r13, (%r12,%rbx,8)
	jge	.LBB0_4
.LBB0_3:                                # %if_body
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%rbx, %rdx
	callq	swap
	addq	$1, %r15
	jmp	.LBB0_4
.LBB0_5:                                # %loop_exit
	movq	%r12, %rdi
	movq	%r15, %rsi
	movq	%r14, %rdx
	callq	swap
	movq	%r15, %rax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end0:
	.size	partition, .Lfunc_end0-partition
                                        # -- End function
	.globl	swap                    # -- Begin function swap
	.p2align	4, 0x90
	.type	swap,@function
swap:                                   # @swap
# %bb.0:
	movq	(%rdi,%rsi,8), %rax
	movq	(%rdi,%rdx,8), %rcx
	movq	%rax, (%rdi,%rdx,8)
	movq	%rcx, (%rdi,%rsi,8)
	retq
.Lfunc_end1:
	.size	swap, .Lfunc_end1-swap
                                        # -- End function
	.globl	quicksort               # -- Begin function quicksort
	.p2align	4, 0x90
	.type	quicksort,@function
quicksort:                              # @quicksort
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	cmpq	%rdx, %rsi
	jge	.LBB2_3
# %bb.1:                                # %sort_case.preheader
	movq	%rdx, %r14
	movq	%rsi, %r12
	movq	%rdi, %r15
	.p2align	4, 0x90
.LBB2_2:                                # %sort_case
                                        # =>This Inner Loop Header: Depth=1
	movq	%r15, %rdi
	movq	%r12, %rsi
	movq	%r14, %rdx
	callq	partition
	movq	%rax, %rbx
	leaq	-1(%rax), %rdx
	addq	$1, %rbx
	movq	%r15, %rdi
	movq	%r12, %rsi
	callq	quicksort
	movq	%rbx, %r12
	cmpq	%r14, %rbx
	jl	.LBB2_2
.LBB2_3:                                # %trivial
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end2:
	.size	quicksort, .Lfunc_end2-quicksort
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	pushq	%r15
	.cfi_def_cfa_offset 24
	pushq	%r14
	.cfi_def_cfa_offset 32
	pushq	%r13
	.cfi_def_cfa_offset 40
	pushq	%r12
	.cfi_def_cfa_offset 48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	subq	$264, %rsp              # imm = 0x108
	.cfi_def_cfa_offset 320
	.cfi_offset %rbx, -56
	.cfi_offset %r12, -48
	.cfi_offset %r13, -40
	.cfi_offset %r14, -32
	.cfi_offset %r15, -24
	.cfi_offset %rbp, -16
	movq	input(%rip), %r14
	movq	input+8(%rip), %rbx
	movq	input+16(%rip), %r15
	movq	input+24(%rip), %r12
	movq	input+32(%rip), %r13
	movups	input+40(%rip), %xmm0
	movups	%xmm0, 240(%rsp)        # 16-byte Spill
	movups	input+56(%rip), %xmm0
	movups	%xmm0, 224(%rsp)        # 16-byte Spill
	movups	input+72(%rip), %xmm0
	movups	%xmm0, 208(%rsp)        # 16-byte Spill
	movups	input+88(%rip), %xmm0
	movups	%xmm0, 192(%rsp)        # 16-byte Spill
	movq	input+104(%rip), %rbp
	movl	$input, %edi
	movl	$13, %edx
	xorl	%esi, %esi
	callq	quicksort
	movaps	input(%rip), %xmm0
	movaps	input+16(%rip), %xmm1
	movaps	input+32(%rip), %xmm2
	movaps	input+48(%rip), %xmm3
	movaps	input+64(%rip), %xmm4
	movaps	input+80(%rip), %xmm5
	movaps	input+96(%rip), %xmm6
	movups	%xmm6, 168(%rsp)
	movups	%xmm5, 152(%rsp)
	movups	%xmm4, 136(%rsp)
	movups	%xmm3, 120(%rsp)
	movups	%xmm2, 104(%rsp)
	movups	%xmm1, 88(%rsp)
	movups	%xmm0, 72(%rsp)
	movq	%rbp, 64(%rsp)
	movups	192(%rsp), %xmm0        # 16-byte Reload
	movups	%xmm0, 48(%rsp)
	movups	208(%rsp), %xmm0        # 16-byte Reload
	movups	%xmm0, 32(%rsp)
	movups	224(%rsp), %xmm0        # 16-byte Reload
	movups	%xmm0, 16(%rsp)
	movups	240(%rsp), %xmm0        # 16-byte Reload
	movups	%xmm0, (%rsp)
	movl	$output_str, %edi
	movq	%r14, %rsi
	movq	%rbx, %rdx
	movq	%r15, %rcx
	movq	%r12, %r8
	movq	%r13, %r9
	callq	printf
	movl	$1, %eax
	addq	$264, %rsp              # imm = 0x108
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%r12
	.cfi_def_cfa_offset 40
	popq	%r13
	.cfi_def_cfa_offset 32
	popq	%r14
	.cfi_def_cfa_offset 24
	popq	%r15
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
	.cfi_endproc
                                        # -- End function
	.type	output_str,@object      # @output_str
	.data
	.globl	output_str
	.p2align	4
output_str:
	.asciz	"Initial array: %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld; Sorted array: %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld"
	.size	output_str, 170

	.type	input,@object           # @input
	.globl	input
	.p2align	4
input:
	.quad	4                       # 0x4
	.quad	1                       # 0x1
	.quad	50                      # 0x32
	.quad	50                      # 0x32
	.quad	7                       # 0x7
	.quad	0                       # 0x0
	.quad	5                       # 0x5
	.quad	10                      # 0xa
	.quad	9                       # 0x9
	.quad	11                      # 0xb
	.quad	0                       # 0x0
	.quad	100                     # 0x64
	.quad	3                       # 0x3
	.quad	8                       # 0x8
	.size	input, 112


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym output_str
	.addrsig_sym input
