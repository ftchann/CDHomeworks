	.text
	.globl	rsa_decrypt
rsa_decrypt:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$280, %rsp
	movq	%rdi, -8(%rbp)
	subq	$8, %rsp
	leaq	-288(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-296(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	$1409083253, %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-304(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	$1, %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-312(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	$0, %rax
	movq	-64(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	rsa_decrypt._cond__14
	.text
rsa_decrypt._body__13:
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rcx
	movq	-80(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -112(%rbp)
	movq	$1, %rcx
	movq	-112(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
	movq	-64(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	rsa_decrypt._cond__14
	.text
rsa_decrypt._body__34:
	movq	-264(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -136(%rbp)
	movq	-240(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -144(%rbp)
	movq	-144(%rbp), %rcx
	movq	-136(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rax
	movq	-264(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	rsa_decrypt._cond__35
	.text
rsa_decrypt._cond__14:
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -168(%rbp)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -176(%rbp)
	movq	-168(%rbp), %rax
	movq	-176(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -184(%rbp)
	movq	-184(%rbp), %rax
	cmpq	$1, %rax
	je	rsa_decrypt._body__13
	jmp	rsa_decrypt._post__12
	.text
rsa_decrypt._cond__35:
	movq	-264(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -192(%rbp)
	movq	-240(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -200(%rbp)
	movq	-192(%rbp), %rax
	movq	-200(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -208(%rbp)
	movq	-208(%rbp), %rax
	cmpq	$1, %rax
	je	rsa_decrypt._body__34
	jmp	rsa_decrypt._post__33
	.text
rsa_decrypt._post__12:
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -216(%rbp)
	subq	$8, %rsp
	leaq	-320(%rbp), %rax
	movq	%rax, -224(%rbp)
	movq	-216(%rbp), %rax
	movq	-224(%rbp), %rdi
	movq	%rax, (%rdi)
	subq	$8, %rsp
	leaq	-328(%rbp), %rax
	movq	%rax, -240(%rbp)
	movq	$2935956181, %rax
	movq	-240(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-224(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -256(%rbp)
	subq	$8, %rsp
	leaq	-336(%rbp), %rax
	movq	%rax, -264(%rbp)
	movq	-256(%rbp), %rax
	movq	-264(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	rsa_decrypt._cond__35
	.text
rsa_decrypt._post__33:
	movq	-264(%rbp), %rax
	movq	(%rax), %rax
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
	movq	$42, %rax
	movq	%rax, %rdi
	callq	rsa_decrypt
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	