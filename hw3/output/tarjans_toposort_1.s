	.text
	.file	"tarjans_toposort.ll"
	.globl	DFSVisit                # -- Begin function DFSVisit
	.p2align	4, 0x90
	.type	DFSVisit,@function
DFSVisit:                               # @DFSVisit
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	movq	%r8, %r14
	movq	%rcx, %r12
	movq	%rdx, %r15
	movq	%rsi, %r13
	movq	%rdi, %rbx
	movb	$1, (%rsi,%rcx)
.LBB0_1:                                # %loadNeighborsthread-pre-split
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB0_2 Depth 2
	movq	(%rbx,%r12,8), %rax
	.p2align	4, 0x90
.LBB0_2:                                # %loadNeighbors
                                        #   Parent Loop BB0_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	testq	%rax, %rax
	je	.LBB0_5
# %bb.3:                                # %neighborLoop
                                        #   in Loop: Header=BB0_2 Depth=2
	movq	(%rax), %rcx
	movq	8(%rax), %rax
	movq	%rax, (%rbx,%r12,8)
	cmpb	$0, (%r13,%rcx)
	jne	.LBB0_2
# %bb.4:                                # %visitNeighbor
                                        #   in Loop: Header=BB0_1 Depth=1
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r15, %rdx
	movq	%r14, %r8
	callq	DFSVisit
	jmp	.LBB0_1
.LBB0_5:                                # %done
	movq	(%r14), %rax
	movq	%r12, (%r15,%rax,8)
	addq	$-1, %rax
	movq	%rax, (%r14)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end0:
	.size	DFSVisit, .Lfunc_end0-DFSVisit
                                        # -- End function
	.globl	tarjanTopoSort          # -- Begin function tarjanTopoSort
	.p2align	4, 0x90
	.type	tarjanTopoSort,@function
tarjanTopoSort:                         # @tarjanTopoSort
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
	movq	%rdx, %r14
	movq	%rsi, %r13
	movq	%rdi, %r15
	movq	$11, (%rsp)
	xorl	%ecx, %ecx
	movq	%rsp, %r12
	jmp	.LBB1_1
	.p2align	4, 0x90
.LBB1_2:                                # %DFSLoop.backedge
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	%rbx, %rcx
	cmpq	$12, %rbx
	je	.LBB1_3
.LBB1_1:                                # %visitedCheck
                                        # =>This Inner Loop Header: Depth=1
	leaq	1(%rcx), %rbx
	cmpb	$1, (%r13,%rcx)
	je	.LBB1_2
# %bb.4:                                # %visit
                                        #   in Loop: Header=BB1_1 Depth=1
	movq	%r15, %rdi
	movq	%r13, %rsi
	movq	%r14, %rdx
	movq	%r12, %r8
	callq	DFSVisit
	jmp	.LBB1_2
.LBB1_3:                                # %done
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	retq
.Lfunc_end1:
	.size	tarjanTopoSort, .Lfunc_end1-tarjanTopoSort
                                        # -- End function
	.globl	sortsEqualRec           # -- Begin function sortsEqualRec
	.p2align	4, 0x90
	.type	sortsEqualRec,@function
sortsEqualRec:                          # @sortsEqualRec
# %bb.0:
	movb	$1, %al
	cmpq	$12, %rdi
	je	.LBB2_3
# %bb.1:                                # %rec.preheader
	movb	$1, %al
	.p2align	4, 0x90
.LBB2_2:                                # %rec
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rsi,%rdi,8), %rcx
	cmpq	(%rdx,%rdi,8), %rcx
	leaq	1(%rdi), %rdi
	sete	%cl
	andb	%cl, %al
	cmpq	$12, %rdi
	jne	.LBB2_2
.LBB2_3:                                # %base
	retq
.Lfunc_end2:
	.size	sortsEqualRec, .Lfunc_end2-sortsEqualRec
                                        # -- End function
	.globl	sortsEqual              # -- Begin function sortsEqual
	.p2align	4, 0x90
	.type	sortsEqual,@function
sortsEqual:                             # @sortsEqual
# %bb.0:
	movq	%rsi, %rdx
	movq	%rdi, %rsi
	xorl	%edi, %edi
	jmp	sortsEqualRec           # TAILCALL
.Lfunc_end3:
	.size	sortsEqual, .Lfunc_end3-sortsEqual
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$dag, %edi
	movl	$nodesVisited, %esi
	movl	$topoSortComputed, %edx
	callq	tarjanTopoSort
	movl	$topoSortAnswer, %edi
	movl	$topoSortComputed, %esi
	jmp	sortsEqual              # TAILCALL
.Lfunc_end4:
	.size	main, .Lfunc_end4-main
                                        # -- End function
	.type	nodeA,@object           # @nodeA
	.data
	.globl	nodeA
	.p2align	3
nodeA:
	.quad	2                       # 0x2
	.quad	nodeB
	.size	nodeA, 16

	.type	nodeB,@object           # @nodeB
	.globl	nodeB
	.p2align	3
nodeB:
	.quad	7                       # 0x7
	.quad	0
	.size	nodeB, 16

	.type	nodeC,@object           # @nodeC
	.globl	nodeC
	.p2align	3
nodeC:
	.quad	5                       # 0x5
	.quad	nodeD
	.size	nodeC, 16

	.type	nodeD,@object           # @nodeD
	.globl	nodeD
	.p2align	3
nodeD:
	.quad	8                       # 0x8
	.quad	nodeE
	.size	nodeD, 16

	.type	nodeE,@object           # @nodeE
	.globl	nodeE
	.p2align	3
nodeE:
	.quad	9                       # 0x9
	.quad	0
	.size	nodeE, 16

	.type	nodeF,@object           # @nodeF
	.globl	nodeF
	.p2align	3
nodeF:
	.quad	4                       # 0x4
	.quad	0
	.size	nodeF, 16

	.type	nodeG,@object           # @nodeG
	.globl	nodeG
	.p2align	3
nodeG:
	.quad	10                      # 0xa
	.quad	0
	.size	nodeG, 16

	.type	nodeH,@object           # @nodeH
	.globl	nodeH
	.p2align	3
nodeH:
	.quad	2                       # 0x2
	.quad	nodeI
	.size	nodeH, 16

	.type	nodeI,@object           # @nodeI
	.globl	nodeI
	.p2align	3
nodeI:
	.quad	8                       # 0x8
	.quad	0
	.size	nodeI, 16

	.type	nodeJ,@object           # @nodeJ
	.globl	nodeJ
	.p2align	3
nodeJ:
	.quad	4                       # 0x4
	.quad	0
	.size	nodeJ, 16

	.type	nodeK,@object           # @nodeK
	.globl	nodeK
	.p2align	3
nodeK:
	.quad	8                       # 0x8
	.quad	0
	.size	nodeK, 16

	.type	nodeL,@object           # @nodeL
	.globl	nodeL
	.p2align	3
nodeL:
	.quad	0                       # 0x0
	.quad	nodeM
	.size	nodeL, 16

	.type	nodeM,@object           # @nodeM
	.globl	nodeM
	.p2align	3
nodeM:
	.quad	4                       # 0x4
	.quad	nodeN
	.size	nodeM, 16

	.type	nodeN,@object           # @nodeN
	.globl	nodeN
	.p2align	3
nodeN:
	.quad	7                       # 0x7
	.quad	nodeO
	.size	nodeN, 16

	.type	nodeO,@object           # @nodeO
	.globl	nodeO
	.p2align	3
nodeO:
	.quad	8                       # 0x8
	.quad	0
	.size	nodeO, 16

	.type	dag,@object             # @dag
	.globl	dag
	.p2align	4
dag:
	.quad	nodeA
	.quad	nodeC
	.quad	nodeF
	.quad	nodeG
	.quad	0
	.quad	nodeH
	.quad	0
	.quad	nodeJ
	.quad	0
	.quad	nodeK
	.quad	0
	.quad	nodeL
	.size	dag, 96

	.type	nodesVisited,@object    # @nodesVisited
	.bss
	.globl	nodesVisited
nodesVisited:
	.zero	12
	.size	nodesVisited, 12

	.type	topoSortComputed,@object # @topoSortComputed
	.data
	.globl	topoSortComputed
	.p2align	4
topoSortComputed:
	.zero	96,255
	.size	topoSortComputed, 96

	.type	topoSortAnswer,@object  # @topoSortAnswer
	.globl	topoSortAnswer
	.p2align	4
topoSortAnswer:
	.quad	11                      # 0xb
	.quad	6                       # 0x6
	.quad	3                       # 0x3
	.quad	10                      # 0xa
	.quad	1                       # 0x1
	.quad	9                       # 0x9
	.quad	5                       # 0x5
	.quad	8                       # 0x8
	.quad	0                       # 0x0
	.quad	7                       # 0x7
	.quad	2                       # 0x2
	.quad	4                       # 0x4
	.size	topoSortAnswer, 96


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym nodeA
	.addrsig_sym nodeB
	.addrsig_sym nodeC
	.addrsig_sym nodeD
	.addrsig_sym nodeE
	.addrsig_sym nodeF
	.addrsig_sym nodeG
	.addrsig_sym nodeH
	.addrsig_sym nodeI
	.addrsig_sym nodeJ
	.addrsig_sym nodeK
	.addrsig_sym nodeL
	.addrsig_sym nodeM
	.addrsig_sym nodeN
	.addrsig_sym nodeO
	.addrsig_sym dag
	.addrsig_sym nodesVisited
	.addrsig_sym topoSortComputed
	.addrsig_sym topoSortAnswer
