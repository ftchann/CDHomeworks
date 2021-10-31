	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$347, %rax
	movq	%rax, %rdi
	callq	is_prime
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	is_prime
is_prime:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$288, %rsp
	movq	%rdi, -8(%rbp)
	movq	$8, %rax
	movq	%rax, %rdi
	movq	$10000, %rax
	movq	%rax, %rsi
	callq	ll_malloc
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	$0, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movq	$0, %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-16(%rbp), %rax
	movq	$1, %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -40(%rbp)
	movq	$0, %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	is_prime.start1
	.text
is_prime.start1:
	subq	$8, %rsp
	leaq	-296(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	$2, %rax
	movq	-56(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	is_prime.cmp1
	.text
is_prime.cmp1:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	$10000, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rax
	cmpq	$1, %rax
	je	is_prime.loop1
	jmp	is_prime.end1
	.text
is_prime.loop1:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -88(%rbp)
	movq	-16(%rbp), %rax
	movq	-88(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -96(%rbp)
	movq	$1, %rax
	movq	-96(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$1, %rcx
	movq	-88(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	-56(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	is_prime.cmp1
	.text
is_prime.end1:
	jmp	is_prime.start2
	.text
is_prime.start2:
	movq	$2, %rax
	movq	-56(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	is_prime.cmp2
	.text
is_prime.cmp2:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -136(%rbp)
	movq	-136(%rbp), %rax
	movq	$10000, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -144(%rbp)
	movq	-144(%rbp), %rax
	cmpq	$1, %rax
	je	is_prime.loop2
	jmp	is_prime.end2
	.text
is_prime.loop2:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -152(%rbp)
	movq	-16(%rbp), %rax
	movq	-152(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -160(%rbp)
	movq	-160(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -168(%rbp)
	movq	-168(%rbp), %rax
	movq	$1, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -176(%rbp)
	movq	-176(%rbp), %rax
	cmpq	$1, %rax
	je	is_prime.then1
	jmp	is_prime.else1
	.text
is_prime.then1:
	subq	$8, %rsp
	leaq	-304(%rbp), %rax
	movq	%rax, -184(%rbp)
	movq	-152(%rbp), %rcx
	movq	-152(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -192(%rbp)
	movq	-192(%rbp), %rax
	movq	-184(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	is_prime.cmp3
	.text
is_prime.cmp3:
	movq	-184(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -208(%rbp)
	movq	-208(%rbp), %rax
	movq	$10000, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -216(%rbp)
	movq	-216(%rbp), %rax
	cmpq	$1, %rax
	je	is_prime.loop3
	jmp	is_prime.end3
	.text
is_prime.loop3:
	movq	-16(%rbp), %rax
	movq	-208(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -224(%rbp)
	movq	$0, %rax
	movq	-224(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-152(%rbp), %rcx
	movq	-208(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -240(%rbp)
	movq	-240(%rbp), %rax
	movq	-184(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	is_prime.cmp3
	.text
is_prime.end3:
	jmp	is_prime.else1
	.text
is_prime.else1:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -256(%rbp)
	movq	$1, %rcx
	movq	-256(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -264(%rbp)
	movq	-264(%rbp), %rax
	movq	-56(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	is_prime.cmp2
	.text
is_prime.end2:
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	imulq	$8, %rdx
	addq	%rdx, %rax
	movq	%rax, -280(%rbp)
	movq	-280(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -288(%rbp)
	movq	-288(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	