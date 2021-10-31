	.text
	.file	"slowsort.ll"
	.globl	slowsort                # -- Begin function slowsort
	.p2align	4, 0x90
	.type	slowsort,@function
slowsort:                               # @slowsort
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	cmpq	%rsi, %rdi
	jge	.LBB0_5
# %bb.1:                                # %notdone.preheader
	movq	%rsi, %rbx
	movq	%rdi, %r14
	jmp	.LBB0_2
	.p2align	4, 0x90
.LBB0_4:                                # %finish
                                        #   in Loop: Header=BB0_2 Depth=1
	addq	$-1, %rbx
	cmpq	%r14, %rbx
	jle	.LBB0_5
.LBB0_2:                                # %notdone
                                        # =>This Inner Loop Header: Depth=1
	leaq	(%r14,%rbx), %r15
	sarq	%r15
	leaq	1(%r15), %r12
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	slowsort
	movq	%r12, %rdi
	movq	%rbx, %rsi
	callq	slowsort
	movq	input(,%r15,8), %rax
	movq	input(,%rbx,8), %rcx
	cmpq	%rax, %rcx
	jge	.LBB0_4
# %bb.3:                                # %swap
                                        #   in Loop: Header=BB0_2 Depth=1
	movq	%rcx, input(,%r15,8)
	movq	%rax, input(,%rbx,8)
	jmp	.LBB0_4
.LBB0_5:                                # %done
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end0:
	.size	slowsort, .Lfunc_end0-slowsort
                                        # -- End function
	.globl	issorted                # -- Begin function issorted
	.p2align	4, 0x90
	.type	issorted,@function
issorted:                               # @issorted
# %bb.0:                                # %succ
	movb	$1, %al
	retq
.Lfunc_end1:
	.size	issorted, .Lfunc_end1-issorted
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:                                # %succ
	pushq	%rbx
	movq	length(%rip), %rbx
	leaq	-1(%rbx), %rsi
	xorl	%edi, %edi
	callq	slowsort
	movq	input-8(,%rbx,8), %rax
	popq	%rbx
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function
	.type	length,@object          # @length
	.data
	.globl	length
	.p2align	3
length:
	.quad	31                      # 0x1f
	.size	length, 8

	.type	input,@object           # @input
	.globl	input
	.p2align	4
input:
	.quad	5                       # 0x5
	.quad	100                     # 0x64
	.quad	2                       # 0x2
	.quad	0                       # 0x0
	.quad	18                      # 0x12
	.quad	10                      # 0xa
	.quad	2                       # 0x2
	.quad	1                       # 0x1
	.quad	22                      # 0x16
	.quad	98                      # 0x62
	.quad	107                     # 0x6b
	.quad	105                     # 0x69
	.quad	116                     # 0x74
	.quad	116                     # 0x74
	.quad	101                     # 0x65
	.quad	110                     # 0x6e
	.quad	20                      # 0x14
	.quad	23                      # 0x17
	.quad	102                     # 0x66
	.quad	23                      # 0x17
	.quad	98                      # 0x62
	.quad	97                      # 0x61
	.quad	98                      # 0x62
	.quad	121                     # 0x79
	.quad	15                      # 0xf
	.quad	5                       # 0x5
	.quad	16                      # 0x10
	.quad	116                     # 0x74
	.quad	105                     # 0x69
	.quad	110                     # 0x6e
	.quad	155                     # 0x9b
	.size	input, 248


	.section	".note.GNU-stack","",@progbits
	.addrsig
