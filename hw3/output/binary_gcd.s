	.text
	.globl	binary_gcd
binary_gcd:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$232, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$1, %rax
	je	binary_gcd.ret_u
	jmp	binary_gcd.term1
	.text
binary_gcd.term1:
	movq	$0, %rax
	movq	-8(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	cmpq	$1, %rax
	je	binary_gcd.ret_v
	jmp	binary_gcd.term2
	.text
binary_gcd.term2:
	movq	$0, %rax
	movq	-16(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	sete	%al
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	cmpq	$1, %rax
	je	binary_gcd.ret_u
	jmp	binary_gcd.gcd
	.text
binary_gcd.gcd:
	movq	$1, %rcx
	movq	$0, %rax
	subq	%rcx, %rax
	movq	%rax, -48(%rbp)
	movq	-8(%rbp), %rcx
	movq	-48(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rcx
	movq	$1, %rax
	andq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movq	$0, %rax
	movq	-64(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setne	%al
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	cmpq	$1, %rax
	je	binary_gcd.u_even
	jmp	binary_gcd.u_odd
	.text
binary_gcd.u_odd:
	movq	-16(%rbp), %rcx
	movq	-48(%rbp), %rax
	xorq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movq	-80(%rbp), %rcx
	movq	$1, %rax
	andq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	$0, %rax
	movq	-88(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setne	%al
	movq	%rax, -96(%rbp)
	movq	-96(%rbp), %rax
	cmpq	$1, %rax
	je	binary_gcd.v_even
	jmp	binary_gcd.v_odd
	.text
binary_gcd.v_odd:
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -104(%rbp)
	movq	-104(%rbp), %rax
	cmpq	$1, %rax
	je	binary_gcd.u_gt
	jmp	binary_gcd.v_gt
	.text
binary_gcd.v_gt:
	movq	-8(%rbp), %rcx
	movq	-16(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -112(%rbp)
	movq	$1, %rcx
	movq	-112(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	callq	binary_gcd
	movq	%rax, -128(%rbp)
	movq	-128(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
binary_gcd.u_gt:
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -136(%rbp)
	movq	$1, %rcx
	movq	-136(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -144(%rbp)
	movq	-144(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	callq	binary_gcd
	movq	%rax, -152(%rbp)
	movq	-152(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
binary_gcd.v_even:
	movq	$1, %rcx
	movq	-16(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -160(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	movq	-160(%rbp), %rax
	movq	%rax, %rsi
	callq	binary_gcd
	movq	%rax, -168(%rbp)
	movq	-168(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
binary_gcd.u_even:
	movq	$1, %rcx
	movq	-16(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -176(%rbp)
	movq	$0, %rax
	movq	-176(%rbp), %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setne	%al
	movq	%rax, -184(%rbp)
	movq	-184(%rbp), %rax
	cmpq	$1, %rax
	je	binary_gcd.ue_vo
	jmp	binary_gcd.both_even
	.text
binary_gcd.ue_vo:
	movq	$1, %rcx
	movq	-8(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -192(%rbp)
	movq	-192(%rbp), %rax
	movq	%rax, %rdi
	movq	-16(%rbp), %rax
	movq	%rax, %rsi
	callq	binary_gcd
	movq	%rax, -200(%rbp)
	movq	-200(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
binary_gcd.both_even:
	movq	$1, %rcx
	movq	-8(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -208(%rbp)
	movq	$1, %rcx
	movq	-16(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -216(%rbp)
	movq	-208(%rbp), %rax
	movq	%rax, %rdi
	movq	-216(%rbp), %rax
	movq	%rax, %rsi
	callq	binary_gcd
	movq	%rax, -224(%rbp)
	movq	$1, %rcx
	movq	-224(%rbp), %rax
	shlq	%cl, %rax
	movq	%rax, -232(%rbp)
	movq	-232(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
binary_gcd.ret_u:
	movq	-8(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
binary_gcd.ret_v:
	movq	-16(%rbp), %rax
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
	movq	$21, %rax
	movq	%rax, %rdi
	movq	$15, %rax
	movq	%rax, %rsi
	callq	binary_gcd
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	