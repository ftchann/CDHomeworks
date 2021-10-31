	.data
	.globl	arr1
arr1:
	.quad	107
	.quad	105
	.quad	116
	.quad	116
	.quad	101
	.quad	110
	.data
	.globl	arr2
arr2:
	.quad	98
	.quad	97
	.quad	98
	.quad	121
	.quad	115
	.quad	105
	.quad	116
	.quad	116
	.quad	105
	.quad	110
	.quad	103
	.data
	.globl	arr1len
arr1len:
	.quad	6
	.data
	.globl	arr2len
arr2len:
	.quad	11
	.data
	.globl	dp
dp:
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
	.text
	.globl	writedp
writedp:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	leaq	dp(%rip), %rax
	movq	$0, %rdx
	imulq	$672, %rdx
	addq	%rdx, %rax
	movq	-8(%rbp), %rdx
	imulq	$96, %rdx
	addq	%rdx, %rax
	movq	-16(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	getdp
getdp:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	dp(%rip), %rax
	movq	$0, %rdx
	imulq	$672, %rdx
	addq	%rdx, %rax
	movq	-8(%rbp), %rdx
	imulq	$96, %rdx
	addq	%rdx, %rax
	movq	-16(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	getval
getval:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	min2
min2:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$1, %rax
	je	min2.agt
	jmp	min2.bgt
	.text
min2.agt:
	movq	-16(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
min2.bgt:
	movq	-8(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	min3
min3:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$40, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	callq	min2
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	callq	min2
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	compute_cost
compute_cost:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$168, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$1, %rcx
	movq	-8(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -24(%rbp)
	leaq	arr1(%rip), %rax
	movq	$0, %rdx
	imulq	$48, %rdx
	addq	%rdx, %rax
	movq	-24(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	$1, %rcx
	movq	-16(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -48(%rbp)
	leaq	arr2(%rip), %rax
	movq	$0, %rdx
	imulq	$88, %rdx
	addq	%rdx, %rax
	movq	-48(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -64(%rbp)
	subq	$8, %rsp
	leaq	-176(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-40(%rbp), %rax
	movq	-64(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	cmpq	$1, %rax
	je	compute_cost.ifeq
	jmp	compute_cost.ifnoteq
	.text
compute_cost.ifeq:
	movq	$0, %rax
	movq	-72(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	compute_cost.cont
	.text
compute_cost.ifnoteq:
	movq	$1, %rax
	movq	-72(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	compute_cost.cont
	.text
compute_cost.cont:
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	callq	getdp
	movq	%rax, -104(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	callq	getdp
	movq	%rax, -112(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	movq	-48(%rbp), %rax
	movq	%rax, %rsi
	callq	getdp
	movq	%rax, -120(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	movq	$1, %rcx
	movq	-104(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -136(%rbp)
	movq	$1, %rcx
	movq	-112(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -144(%rbp)
	movq	-128(%rbp), %rcx
	movq	-120(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -152(%rbp)
	movq	-136(%rbp), %rax
	movq	%rax, %rdi
	movq	-144(%rbp), %rax
	movq	%rax, %rsi
	movq	-152(%rbp), %rax
	movq	%rax, %rdx
	callq	min3
	movq	%rax, -160(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	-160(%rbp), %rax
	movq	%rax, %rdx
	callq	writedp
	movq	%rax, -168(%rbp)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	levenshtein
levenshtein:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$280, %rsp
	subq	$8, %rsp
	leaq	-288(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	$0, %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-296(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	$0, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	levenshtein.init1
	.text
levenshtein.init1:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	movq	$0, %rax
	movq	%rax, %rsi
	movq	-40(%rbp), %rax
	movq	%rax, %rdx
	callq	writedp
	movq	%rax, -48(%rbp)
	movq	$1, %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	leaq	arr1len(%rip), %rax
	movq	%rax, %rdi
	callq	getval
	movq	%rax, -72(%rbp)
	movq	-56(%rbp), %rax
	movq	-72(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	cmpq	$1, %rax
	je	levenshtein.init2
	jmp	levenshtein.init1
	.text
levenshtein.init2:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -88(%rbp)
	movq	$0, %rax
	movq	%rax, %rdi
	movq	-88(%rbp), %rax
	movq	%rax, %rsi
	movq	-88(%rbp), %rax
	movq	%rax, %rdx
	callq	writedp
	movq	%rax, -96(%rbp)
	movq	$1, %rcx
	movq	-88(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	leaq	arr2len(%rip), %rax
	movq	%rax, %rdi
	callq	getval
	movq	%rax, -120(%rbp)
	movq	-104(%rbp), %rax
	movq	-120(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rax
	cmpq	$1, %rax
	je	levenshtein.proc
	jmp	levenshtein.init2
	.text
levenshtein.proc:
	movq	$1, %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	levenshtein.iterrow
	.text
levenshtein.iterrow:
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -152(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -160(%rbp)
	movq	-152(%rbp), %rax
	movq	%rax, %rdi
	movq	-160(%rbp), %rax
	movq	%rax, %rsi
	callq	compute_cost
	movq	%rax, -168(%rbp)
	movq	$1, %rcx
	movq	-160(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -176(%rbp)
	movq	-176(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	leaq	arr2len(%rip), %rax
	movq	%rax, %rdi
	callq	getval
	movq	%rax, -192(%rbp)
	movq	-176(%rbp), %rax
	movq	-192(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -200(%rbp)
	movq	-200(%rbp), %rax
	cmpq	$1, %rax
	je	levenshtein.newrow
	jmp	levenshtein.iterrow
	.text
levenshtein.newrow:
	movq	$1, %rcx
	movq	-152(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -208(%rbp)
	movq	-208(%rbp), %rax
	movq	-8(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	leaq	arr1len(%rip), %rax
	movq	%rax, %rdi
	callq	getval
	movq	%rax, -232(%rbp)
	movq	-208(%rbp), %rax
	movq	-232(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -240(%rbp)
	movq	-240(%rbp), %rax
	cmpq	$1, %rax
	je	levenshtein.term
	jmp	levenshtein.iterrow
	.text
levenshtein.term:
	leaq	arr1len(%rip), %rax
	movq	%rax, %rdi
	callq	getval
	movq	%rax, -248(%rbp)
	movq	$1, %rcx
	movq	-248(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -256(%rbp)
	leaq	arr2len(%rip), %rax
	movq	%rax, %rdi
	callq	getval
	movq	%rax, -264(%rbp)
	movq	$1, %rcx
	movq	-264(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -272(%rbp)
	movq	-256(%rbp), %rax
	movq	%rax, %rdi
	movq	-272(%rbp), %rax
	movq	%rax, %rsi
	callq	getdp
	movq	%rax, -280(%rbp)
	movq	-280(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	callq	levenshtein
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	