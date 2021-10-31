	.text
	.file	"editdistance.ll"
	.globl	writedp                 # -- Begin function writedp
	.p2align	4, 0x90
	.type	writedp,@function
writedp:                                # @writedp
# %bb.0:
	leaq	(%rdi,%rdi,2), %rax
	shlq	$5, %rax
	movq	%rdx, dp(%rax,%rsi,8)
	retq
.Lfunc_end0:
	.size	writedp, .Lfunc_end0-writedp
                                        # -- End function
	.globl	getdp                   # -- Begin function getdp
	.p2align	4, 0x90
	.type	getdp,@function
getdp:                                  # @getdp
# %bb.0:
	leaq	(%rdi,%rdi,2), %rax
	shlq	$5, %rax
	movq	dp(%rax,%rsi,8), %rax
	retq
.Lfunc_end1:
	.size	getdp, .Lfunc_end1-getdp
                                        # -- End function
	.globl	getval                  # -- Begin function getval
	.p2align	4, 0x90
	.type	getval,@function
getval:                                 # @getval
# %bb.0:
	movq	(%rdi), %rax
	retq
.Lfunc_end2:
	.size	getval, .Lfunc_end2-getval
                                        # -- End function
	.globl	min2                    # -- Begin function min2
	.p2align	4, 0x90
	.type	min2,@function
min2:                                   # @min2
# %bb.0:                                # %agt
	movq	%rdi, %rax
	cmpq	%rsi, %rdi
	cmovgq	%rsi, %rax
	retq
.Lfunc_end3:
	.size	min2, .Lfunc_end3-min2
                                        # -- End function
	.globl	min3                    # -- Begin function min3
	.p2align	4, 0x90
	.type	min3,@function
min3:                                   # @min3
# %bb.0:
	pushq	%rbx
	movq	%rdx, %rbx
	callq	min2
	movq	%rax, %rdi
	movq	%rbx, %rsi
	popq	%rbx
	jmp	min2                    # TAILCALL
.Lfunc_end4:
	.size	min3, .Lfunc_end4-min3
                                        # -- End function
	.globl	compute_cost            # -- Begin function compute_cost
	.p2align	4, 0x90
	.type	compute_cost,@function
compute_cost:                           # @compute_cost
# %bb.0:                                # %cont
	pushq	%rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rsi, %r14
	movq	%rdi, %r13
	leaq	-1(%rdi), %r15
	movq	arr1-8(,%rdi,8), %rax
	leaq	-1(%rsi), %r12
	xorl	%ebx, %ebx
	cmpq	arr2-8(,%rsi,8), %rax
	setne	%bl
	movq	%r15, %rdi
	callq	getdp
	movq	%rax, (%rsp)            # 8-byte Spill
	movq	%r13, %rdi
	movq	%r12, %rsi
	callq	getdp
	movq	%rax, %rbp
	movq	%r15, %rdi
	movq	%r12, %rsi
	callq	getdp
	movq	(%rsp), %rcx            # 8-byte Reload
	leaq	1(%rcx), %rdi
	leaq	1(%rbp), %rsi
	addq	%rax, %rbx
	movq	%rbx, %rdx
	callq	min3
	movq	%r13, %rdi
	movq	%r14, %rsi
	movq	%rax, %rdx
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	jmp	writedp                 # TAILCALL
.Lfunc_end5:
	.size	compute_cost, .Lfunc_end5-compute_cost
                                        # -- End function
	.globl	levenshtein             # -- Begin function levenshtein
	.p2align	4, 0x90
	.type	levenshtein,@function
levenshtein:                            # @levenshtein
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB6_1:                                # %init1
                                        # =>This Inner Loop Header: Depth=1
	movq	%rbx, %rdi
	xorl	%esi, %esi
	movq	%rbx, %rdx
	callq	writedp
	addq	$1, %rbx
	movl	$arr1len, %edi
	callq	getval
	cmpq	%rax, %rbx
	jl	.LBB6_1
# %bb.2:                                # %init2.preheader
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB6_3:                                # %init2
                                        # =>This Inner Loop Header: Depth=1
	xorl	%edi, %edi
	movq	%rbx, %rsi
	movq	%rbx, %rdx
	callq	writedp
	addq	$1, %rbx
	movl	$arr2len, %edi
	callq	getval
	cmpq	%rax, %rbx
	jl	.LBB6_3
# %bb.4:                                # %iterrow.outer.preheader
	movl	$1, %r14d
	.p2align	4, 0x90
.LBB6_5:                                # %iterrow.outer
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_6 Depth 2
	movl	$1, %ebx
	.p2align	4, 0x90
.LBB6_6:                                # %iterrow
                                        #   Parent Loop BB6_5 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	compute_cost
	addq	$1, %rbx
	movl	$arr2len, %edi
	callq	getval
	cmpq	%rax, %rbx
	jl	.LBB6_6
# %bb.7:                                # %newrow
                                        #   in Loop: Header=BB6_5 Depth=1
	movq	%rax, %r15
	addq	$1, %r14
	movl	$arr1len, %edi
	callq	getval
	cmpq	%rax, %r14
	jl	.LBB6_5
# %bb.8:                                # %term
	addq	$-1, %rax
	addq	$-1, %r15
	movq	%rax, %rdi
	movq	%r15, %rsi
	popq	%rbx
	popq	%r14
	popq	%r15
	jmp	getdp                   # TAILCALL
.Lfunc_end6:
	.size	levenshtein, .Lfunc_end6-levenshtein
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	jmp	levenshtein             # TAILCALL
.Lfunc_end7:
	.size	main, .Lfunc_end7-main
                                        # -- End function
	.type	arr1,@object            # @arr1
	.data
	.globl	arr1
	.p2align	4
arr1:
	.quad	107                     # 0x6b
	.quad	105                     # 0x69
	.quad	116                     # 0x74
	.quad	116                     # 0x74
	.quad	101                     # 0x65
	.quad	110                     # 0x6e
	.size	arr1, 48

	.type	arr2,@object            # @arr2
	.globl	arr2
	.p2align	4
arr2:
	.quad	98                      # 0x62
	.quad	97                      # 0x61
	.quad	98                      # 0x62
	.quad	121                     # 0x79
	.quad	115                     # 0x73
	.quad	105                     # 0x69
	.quad	116                     # 0x74
	.quad	116                     # 0x74
	.quad	105                     # 0x69
	.quad	110                     # 0x6e
	.quad	103                     # 0x67
	.size	arr2, 88

	.type	arr1len,@object         # @arr1len
	.globl	arr1len
	.p2align	3
arr1len:
	.quad	6                       # 0x6
	.size	arr1len, 8

	.type	arr2len,@object         # @arr2len
	.globl	arr2len
	.p2align	3
arr2len:
	.quad	11                      # 0xb
	.size	arr2len, 8

	.type	dp,@object              # @dp
	.bss
	.globl	dp
	.p2align	4
dp:
	.zero	672
	.size	dp, 672


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym arr1len
	.addrsig_sym arr2len
