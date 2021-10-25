	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$384, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$1, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rcx
	movq	$0, %rax
	subq	%rcx, %rax
	movq	%rax, -32(%rbp)
	movq	$5, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rcx
	movq	$0, %rax
	subq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	$10, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rcx
	movq	$0, %rax
	subq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movq	$60, %rcx
	movq	$0, %rax
	addq	%rcx, %rax
	movq	%rax, -72(%rbp)
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rax
	addq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rax
	imulq	%rcx, %rax
	movq	%rax, -96(%rbp)
	movq	-24(%rbp), %rcx
	movq	-56(%rbp), %rax
	shlq	%cl, %rax
	movq	%rax, -104(%rbp)
	movq	-72(%rbp), %rcx
	movq	-64(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -112(%rbp)
	movq	-24(%rbp), %rcx
	movq	-64(%rbp), %rax
	sarq	%cl, %rax
	movq	%rax, -120(%rbp)
	movq	-24(%rbp), %rcx
	movq	-40(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -128(%rbp)
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rax
	orq	%rcx, %rax
	movq	%rax, -136(%rbp)
	movq	-40(%rbp), %rcx
	movq	-56(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -144(%rbp)
	movq	-80(%rbp), %rax
	movq	$15, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -152(%rbp)
	movq	-88(%rbp), %rax
	movq	$5, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -160(%rbp)
	movq	-96(%rbp), %rax
	movq	$50, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -168(%rbp)
	movq	-104(%rbp), %rax
	movq	$20, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -176(%rbp)
	movq	-112(%rbp), %rax
	movq	$15, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -184(%rbp)
	movq	-120(%rbp), %rax
	movq	-48(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -192(%rbp)
	movq	-128(%rbp), %rax
	movq	$1, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -200(%rbp)
	movq	-136(%rbp), %rax
	movq	$15, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -208(%rbp)
	movq	-144(%rbp), %rax
	movq	$15, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -216(%rbp)
	movq	-144(%rbp), %rax
	movq	$14, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setne	%al
	movq	%rax, -224(%rbp)
	movq	-144(%rbp), %rax
	movq	$16, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setl	%al
	movq	%rax, -232(%rbp)
	movq	-144(%rbp), %rax
	movq	$15, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setle	%al
	movq	%rax, -240(%rbp)
	movq	-144(%rbp), %rax
	movq	$14, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -248(%rbp)
	movq	-144(%rbp), %rax
	movq	-32(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -256(%rbp)
	movq	-144(%rbp), %rax
	movq	$15, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -264(%rbp)
	movq	$1, %rcx
	movq	-152(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -272(%rbp)
	movq	-272(%rbp), %rcx
	movq	-160(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -280(%rbp)
	movq	-280(%rbp), %rcx
	movq	-168(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -288(%rbp)
	movq	-288(%rbp), %rcx
	movq	-176(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -296(%rbp)
	movq	-296(%rbp), %rcx
	movq	-184(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -304(%rbp)
	movq	-304(%rbp), %rcx
	movq	-192(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -312(%rbp)
	movq	-312(%rbp), %rcx
	movq	-200(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -320(%rbp)
	movq	-320(%rbp), %rcx
	movq	-208(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -328(%rbp)
	movq	-328(%rbp), %rcx
	movq	-216(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -336(%rbp)
	movq	-336(%rbp), %rcx
	movq	-224(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -344(%rbp)
	movq	-344(%rbp), %rcx
	movq	-232(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -352(%rbp)
	movq	-352(%rbp), %rcx
	movq	-240(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -360(%rbp)
	movq	-360(%rbp), %rcx
	movq	-248(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -368(%rbp)
	movq	-368(%rbp), %rcx
	movq	-256(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -376(%rbp)
	movq	-376(%rbp), %rcx
	movq	-264(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -384(%rbp)
	movq	-384(%rbp), %rax
	cmpq	$1, %rax
	je	main.then1
	jmp	main.else1
	.text
main.then1:
	movq	$1, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.else1:
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	