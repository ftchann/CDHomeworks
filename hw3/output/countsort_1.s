	.text
	.file	"countsort.ll"
	.globl	insert                  # -- Begin function insert
	.p2align	4, 0x90
	.type	insert,@function
insert:                                 # @insert
# %bb.0:
	leaq	(%rdx,%rsi), %rax
	testq	%rsi, %rsi
	je	.LBB0_3
# %bb.1:                                # %innerInsertLoop.preheader
	leaq	outputArray(,%rdx,8), %rcx
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB0_2:                                # %innerInsertLoop
                                        # =>This Inner Loop Header: Depth=1
	movq	%rdi, (%rcx,%rdx,8)
	addq	$1, %rdx
	cmpq	%rdx, %rsi
	jne	.LBB0_2
.LBB0_3:                                # %finishInsert
	retq
.Lfunc_end0:
	.size	insert, .Lfunc_end0-insert
                                        # -- End function
	.globl	countSortInPlace        # -- Begin function countSortInPlace
	.p2align	4, 0x90
	.type	countSortInPlace,@function
countSortInPlace:                       # @countSortInPlace
# %bb.0:
	pushq	%rbx
	movq	$-80, %rax
	.p2align	4, 0x90
.LBB1_1:                                # %countLoop
                                        # =>This Inner Loop Header: Depth=1
	movq	inputArray+80(%rax), %rcx
	addq	$1, valuesSeen(,%rcx,8)
	addq	$8, %rax
	jne	.LBB1_1
# %bb.2:                                # %insertionLoop.preheader
	xorl	%eax, %eax
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB1_3:                                # %insertionLoop
                                        # =>This Inner Loop Header: Depth=1
	movq	valuesSeen(,%rbx,8), %rsi
	movq	%rbx, %rdi
	movq	%rax, %rdx
	callq	insert
	addq	$1, %rbx
	cmpq	$15, %rbx
	jne	.LBB1_3
# %bb.4:                                # %complete
	popq	%rbx
	retq
.Lfunc_end1:
	.size	countSortInPlace, .Lfunc_end1-countSortInPlace
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	callq	countSortInPlace
	movq	outputArray+40(%rip), %rax
	retq
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function
	.type	valuesSeen,@object      # @valuesSeen
	.bss
	.globl	valuesSeen
	.p2align	4
valuesSeen:
	.zero	120
	.size	valuesSeen, 120

	.type	inputArray,@object      # @inputArray
	.data
	.globl	inputArray
	.p2align	4
inputArray:
	.quad	5                       # 0x5
	.quad	7                       # 0x7
	.quad	14                      # 0xe
	.quad	0                       # 0x0
	.quad	0                       # 0x0
	.quad	9                       # 0x9
	.quad	12                      # 0xc
	.quad	5                       # 0x5
	.quad	5                       # 0x5
	.quad	6                       # 0x6
	.size	inputArray, 80

	.type	outputArray,@object     # @outputArray
	.bss
	.globl	outputArray
	.p2align	4
outputArray:
	.zero	80
	.size	outputArray, 80


	.section	".note.GNU-stack","",@progbits
	.addrsig
