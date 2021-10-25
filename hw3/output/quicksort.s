	.data
	.globl	output_str
output_str:
	.asciz	"Initial array: %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld; Sorted array: %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld %lld"
	.data
	.globl	input
input:
	.quad	4
	.quad	1
	.quad	50
	.quad	50
	.quad	7
	.quad	0
	.quad	5
	.quad	10
	.quad	9
	.quad	11
	.quad	0
	.quad	100
	.quad	3
	.quad	8
	.text
	.globl	partition
partition:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$184, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	-24(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	subq	$8, %rsp
	leaq	-192(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-16(%rbp), %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-200(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-16(%rbp), %rax
	movq	-64(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	partition.loop_condition
	.text
partition.loop_condition:
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	-24(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setle	%al
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	cmpq	$1, %rax
	je	partition.loop_body
	jmp	partition.loop_exit
	.text
partition.loop_body:
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -96(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	-96(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	-40(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
	cmpq	$1, %rax
	je	partition.if_body
	jmp	partition.if_end
	.text
partition.if_body:
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-128(%rbp), %rax
	movq	%rax, %rsi
	movq	-96(%rbp), %rax
	movq	%rax, %rdx
	callq	swap
	movq	%rax, -136(%rbp)
	movq	$1, %rcx
	movq	-128(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -144(%rbp)
	movq	-144(%rbp), %rax
	movq	-64(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	partition.if_end
	.text
partition.if_end:
	movq	$1, %rcx
	movq	-80(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -160(%rbp)
	movq	-160(%rbp), %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	partition.loop_condition
	.text
partition.loop_exit:
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -176(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-176(%rbp), %rax
	movq	%rax, %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdx
	callq	swap
	movq	%rax, -184(%rbp)
	movq	-176(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	swap
swap:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$72, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	-16(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	-24(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-48(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-56(%rbp), %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	quicksort
quicksort:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$72, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	-24(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	cmpq	$1, %rax
	je	quicksort.sort_case
	jmp	quicksort.trivial
	.text
quicksort.sort_case:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdx
	callq	partition
	movq	%rax, -40(%rbp)
	movq	$1, %rcx
	movq	-40(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	$1, %rcx
	movq	-40(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	movq	-48(%rbp), %rax
	movq	%rax, %rdx
	callq	quicksort
	movq	%rax, -64(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-56(%rbp), %rax
	movq	%rax, %rsi
	movq	-24(%rbp), %rax
	movq	%rax, %rdx
	callq	quicksort
	movq	%rax, -72(%rbp)
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
quicksort.trivial:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$376, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -32(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$2, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -40(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$3, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$4, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -56(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$5, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -64(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$6, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -72(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$7, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -80(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$8, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -88(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$9, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -96(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$10, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -104(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$11, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -112(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$12, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -120(%rbp)
	leaq	input(%rip), %rax
	movq	$0, %rdx
	imulq	$112, %rdx
	addq	%rdx, %rax
	movq	$13, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -128(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -136(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -144(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -152(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -160(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -168(%rbp)
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -176(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -184(%rbp)
	movq	-80(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -192(%rbp)
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -200(%rbp)
	movq	-96(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -208(%rbp)
	movq	-104(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -216(%rbp)
	movq	-112(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -224(%rbp)
	movq	-120(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -232(%rbp)
	movq	-128(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -240(%rbp)
	leaq	input(%rip), %rax
	movq	%rax, %rdi
	movq	$0, %rax
	movq	%rax, %rsi
	movq	$13, %rax
	movq	%rax, %rdx
	callq	quicksort
	movq	%rax, -248(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -256(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -264(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -272(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -280(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -288(%rbp)
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -296(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -304(%rbp)
	movq	-80(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -312(%rbp)
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -320(%rbp)
	movq	-96(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -328(%rbp)
	movq	-104(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -336(%rbp)
	movq	-112(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -344(%rbp)
	movq	-120(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -352(%rbp)
	movq	-128(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -360(%rbp)
	leaq	output_str(%rip), %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	$0, %rdx
	imulq	$0, %rdx
	addq	%rdx, %rax
	movq	%rax, -368(%rbp)
	subq	$184, %rsp
	movq	-368(%rbp), %rax
	movq	%rax, %rdi
	movq	-136(%rbp), %rax
	movq	%rax, %rsi
	movq	-144(%rbp), %rax
	movq	%rax, %rdx
	movq	-152(%rbp), %rax
	movq	%rax, %rcx
	movq	-160(%rbp), %rax
	movq	%rax, %r8 
	movq	-168(%rbp), %rax
	movq	%rax, %r9 
	movq	-176(%rbp), %rax
	movq	%rax, 0(%rsp)
	movq	-184(%rbp), %rax
	movq	%rax, 8(%rsp)
	movq	-192(%rbp), %rax
	movq	%rax, 16(%rsp)
	movq	-200(%rbp), %rax
	movq	%rax, 24(%rsp)
	movq	-208(%rbp), %rax
	movq	%rax, 32(%rsp)
	movq	-216(%rbp), %rax
	movq	%rax, 40(%rsp)
	movq	-224(%rbp), %rax
	movq	%rax, 48(%rsp)
	movq	-232(%rbp), %rax
	movq	%rax, 56(%rsp)
	movq	-240(%rbp), %rax
	movq	%rax, 64(%rsp)
	movq	-256(%rbp), %rax
	movq	%rax, 72(%rsp)
	movq	-264(%rbp), %rax
	movq	%rax, 80(%rsp)
	movq	-272(%rbp), %rax
	movq	%rax, 88(%rsp)
	movq	-280(%rbp), %rax
	movq	%rax, 96(%rsp)
	movq	-288(%rbp), %rax
	movq	%rax, 104(%rsp)
	movq	-296(%rbp), %rax
	movq	%rax, 112(%rsp)
	movq	-304(%rbp), %rax
	movq	%rax, 120(%rsp)
	movq	-312(%rbp), %rax
	movq	%rax, 128(%rsp)
	movq	-320(%rbp), %rax
	movq	%rax, 136(%rsp)
	movq	-328(%rbp), %rax
	movq	%rax, 144(%rsp)
	movq	-336(%rbp), %rax
	movq	%rax, 152(%rsp)
	movq	-344(%rbp), %rax
	movq	%rax, 160(%rsp)
	movq	-352(%rbp), %rax
	movq	%rax, 168(%rsp)
	movq	-360(%rbp), %rax
	movq	%rax, 176(%rsp)
	callq	printf
	movq	%rax, -376(%rbp)
	movq	$1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	