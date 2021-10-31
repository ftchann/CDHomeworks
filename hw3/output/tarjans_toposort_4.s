	.data
	.globl	nodeA
nodeA:
	.quad	2
	.quad	nodeB
	.data
	.globl	nodeB
nodeB:
	.quad	7
	.quad	0
	.data
	.globl	nodeC
nodeC:
	.quad	5
	.quad	nodeD
	.data
	.globl	nodeD
nodeD:
	.quad	8
	.quad	nodeE
	.data
	.globl	nodeE
nodeE:
	.quad	9
	.quad	0
	.data
	.globl	nodeF
nodeF:
	.quad	4
	.quad	0
	.data
	.globl	nodeG
nodeG:
	.quad	10
	.quad	0
	.data
	.globl	nodeH
nodeH:
	.quad	2
	.quad	nodeI
	.data
	.globl	nodeI
nodeI:
	.quad	8
	.quad	0
	.data
	.globl	nodeJ
nodeJ:
	.quad	4
	.quad	0
	.data
	.globl	nodeK
nodeK:
	.quad	8
	.quad	0
	.data
	.globl	nodeL
nodeL:
	.quad	0
	.quad	nodeM
	.data
	.globl	nodeM
nodeM:
	.quad	4
	.quad	nodeN
	.data
	.globl	nodeN
nodeN:
	.quad	7
	.quad	nodeO
	.data
	.globl	nodeO
nodeO:
	.quad	8
	.quad	0
	.data
	.globl	dag
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
	.data
	.globl	nodesVisited
nodesVisited:
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.quad	0
	.data
	.globl	topoSortComputed
topoSortComputed:
	.quad	-1
	.quad	-1
	.quad	-1
	.quad	-1
	.quad	-1
	.quad	-1
	.quad	-1
	.quad	-1
	.quad	-1
	.quad	-1
	.quad	-1
	.quad	-1
	.data
	.globl	topoSortAnswer
topoSortAnswer:
	.quad	11
	.quad	6
	.quad	3
	.quad	10
	.quad	1
	.quad	9
	.quad	5
	.quad	8
	.quad	0
	.quad	7
	.quad	2
	.quad	4
	.text
	.globl	DFSVisit
DFSVisit:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$184, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	%r8 , -40(%rbp)
	movq	-16(%rbp), %rax
	movq	$0, %rdx
	imulq	$96, %rdx
	addq	%rdx, %rax
	movq	-32(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	$1, %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$96, %rdx
	addq	%rdx, %rax
	movq	-32(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -64(%rbp)
	jmp	DFSVisit.loadNeighbors
	.text
DFSVisit.loadNeighbors:
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	cmpq	$1, %rax
	je	DFSVisit.done
	jmp	DFSVisit.neighborLoop
	.text
DFSVisit.neighborLoop:
	movq	-72(%rbp), %rax
	movq	$0, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	addq	$0, %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -96(%rbp)
	movq	-72(%rbp), %rax
	movq	$0, %rdx
	imulq	$16, %rdx
	addq	%rdx, %rax
	addq	$8, %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	-64(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-16(%rbp), %rax
	movq	$0, %rdx
	imulq	$96, %rdx
	addq	%rdx, %rax
	movq	-96(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -136(%rbp)
	movq	-136(%rbp), %rax
	cmpq	$1, %rax
	je	DFSVisit.loadNeighbors
	jmp	DFSVisit.visitNeighbor
	.text
DFSVisit.visitNeighbor:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdx
	movq	-96(%rbp), %rax
	movq	%rax, %rcx
	movq	-40(%rbp), %rax
	movq	%rax, %r8 
	callq	DFSVisit
	movq	%rax, -144(%rbp)
	jmp	DFSVisit.loadNeighbors
	.text
DFSVisit.done:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -152(%rbp)
	movq	-24(%rbp), %rax
	movq	$0, %rdx
	imulq	$96, %rdx
	addq	%rdx, %rax
	movq	-152(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -160(%rbp)
	movq	-32(%rbp), %rax
	movq	-160(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rcx
	movq	-152(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -176(%rbp)
	movq	-176(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	tarjanTopoSort
tarjanTopoSort:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$112, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	subq	$8, %rsp
	leaq	-120(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	$0, %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-128(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	$11, %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	tarjanTopoSort.DFSLoop
	.text
tarjanTopoSort.DFSLoop:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	$12, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	cmpq	$1, %rax
	je	tarjanTopoSort.done
	jmp	tarjanTopoSort.visitedCheck
	.text
tarjanTopoSort.visitedCheck:
	movq	-16(%rbp), %rax
	movq	$0, %rdx
	imulq	$96, %rdx
	addq	%rdx, %rax
	movq	-64(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -88(%rbp)
	movq	$1, %rcx
	movq	-64(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-88(%rbp), %rax
	cmpq	$1, %rax
	je	tarjanTopoSort.DFSLoop
	jmp	tarjanTopoSort.visit
	.text
tarjanTopoSort.visit:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdx
	movq	-64(%rbp), %rax
	movq	%rax, %rcx
	movq	-48(%rbp), %rax
	movq	%rax, %r8 
	callq	DFSVisit
	movq	%rax, -112(%rbp)
	jmp	tarjanTopoSort.DFSLoop
	.text
tarjanTopoSort.done:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	sortsEqualRec
sortsEqualRec:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$96, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	$12, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	cmpq	$1, %rax
	je	sortsEqualRec.base
	jmp	sortsEqualRec.rec
	.text
sortsEqualRec.base:
	movq	$1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
sortsEqualRec.rec:
	movq	$1, %rcx
	movq	-8(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdx
	callq	sortsEqualRec
	movq	%rax, -48(%rbp)
	movq	-16(%rbp), %rax
	movq	$0, %rdx
	imulq	$96, %rdx
	addq	%rdx, %rax
	movq	-8(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	movq	-24(%rbp), %rax
	movq	$0, %rdx
	imulq	$96, %rdx
	addq	%rdx, %rax
	movq	-8(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -64(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-72(%rbp), %rax
	movq	-80(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -88(%rbp)
	movq	-48(%rbp), %rcx
	movq	-88(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	cmpq	$1, %rax
	je	sortsEqualRec.equal
	jmp	sortsEqualRec.notEqual
	.text
sortsEqualRec.equal:
	movq	$1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
sortsEqualRec.notEqual:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	sortsEqual
sortsEqual:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, %rax
	movq	%rax, %rdi
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	callq	sortsEqualRec
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	dag(%rip), %rax
	movq	%rax, %rdi
	leaq	nodesVisited(%rip), %rax
	movq	%rax, %rsi
	leaq	topoSortComputed(%rip), %rax
	movq	%rax, %rdx
	callq	tarjanTopoSort
	movq	%rax, -24(%rbp)
	leaq	topoSortAnswer(%rip), %rax
	movq	%rax, %rdi
	leaq	topoSortComputed(%rip), %rax
	movq	%rax, %rsi
	callq	sortsEqual
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	