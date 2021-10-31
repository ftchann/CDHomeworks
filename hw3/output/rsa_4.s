	.text
	.globl	rsa_decrypt
rsa_decrypt:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$320, %rsp
	movq	%rdi, -8(%rbp)
	movq	$0, %rcx
	movq	$56807, %rax
	addq	%rcx, %rax
	movq	%rax, -16(%rbp)
	movq	$0, %rcx
	movq	$51683, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rcx
	movq	-16(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$0, %rcx
	movq	$1409083253, %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	$0, %rcx
	movq	$65537, %rax
	addq	%rcx, %rax
	movq	%rax, -48(%rbp)
	subq	$8, %rsp
	leaq	-328(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-8(%rbp), %rax
	movq	-56(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-336(%rbp), %rax
	movq	%rax, -72(%rbp)
	movq	-40(%rbp), %rax
	movq	-72(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-344(%rbp), %rax
	movq	%rax, -88(%rbp)
	movq	$1, %rax
	movq	-88(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-352(%rbp), %rax
	movq	%rax, -104(%rbp)
	movq	$0, %rax
	movq	-104(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	rsa_decrypt._cond__14
	.text
rsa_decrypt._cond__14:
	movq	-104(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -120(%rbp)
	movq	-72(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	movq	-120(%rbp), %rax
	movq	-128(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -136(%rbp)
	movq	-136(%rbp), %rax
	cmpq	$1, %rax
	je	rsa_decrypt._body__13
	jmp	rsa_decrypt._post__12
	.text
rsa_decrypt._body__13:
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -144(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rcx
	movq	-144(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -160(%rbp)
	movq	-160(%rbp), %rax
	movq	-88(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-104(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -176(%rbp)
	movq	$1, %rcx
	movq	-176(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -184(%rbp)
	movq	-184(%rbp), %rax
	movq	-104(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	rsa_decrypt._cond__14
	.text
rsa_decrypt._post__12:
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -200(%rbp)
	subq	$8, %rsp
	leaq	-360(%rbp), %rax
	movq	%rax, -208(%rbp)
	movq	-200(%rbp), %rax
	movq	-208(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-368(%rbp), %rax
	movq	%rax, -224(%rbp)
	movq	-32(%rbp), %rax
	movq	-224(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-208(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -240(%rbp)
	subq	$8, %rsp
	leaq	-376(%rbp), %rax
	movq	%rax, -248(%rbp)
	movq	-240(%rbp), %rax
	movq	-248(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	rsa_decrypt._cond__35
	.text
rsa_decrypt._cond__35:
	movq	-248(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -264(%rbp)
	movq	-224(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -272(%rbp)
	movq	-264(%rbp), %rax
	movq	-272(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -280(%rbp)
	movq	-280(%rbp), %rax
	cmpq	$1, %rax
	je	rsa_decrypt._body__34
	jmp	rsa_decrypt._post__33
	.text
rsa_decrypt._body__34:
	movq	-248(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -288(%rbp)
	movq	-224(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -296(%rbp)
	movq	-296(%rbp), %rcx
	movq	-288(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -304(%rbp)
	movq	-304(%rbp), %rax
	movq	-248(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	rsa_decrypt._cond__35
	.text
rsa_decrypt._post__33:
	movq	-248(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -320(%rbp)
	movq	-320(%rbp), %rax
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
	movq	$42, %rax
	movq	%rax, %rdi
	callq	rsa_decrypt
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	