	.text
	.globl	fp32_to_int
fp32_to_int:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$384, %rsp
	movq	%rdi, -8(%rbp)
	subq	$8, %rsp
	leaq	-392(%rbp), %rax
	movq	%rax, -16(%rbp)
	subq	$8, %rsp
	leaq	-400(%rbp), %rax
	movq	%rax, -24(%rbp)
	subq	$8, %rsp
	leaq	-408(%rbp), %rax
	movq	%rax, -32(%rbp)
	subq	$8, %rsp
	leaq	-416(%rbp), %rax
	movq	%rax, -40(%rbp)
	subq	$8, %rsp
	leaq	-424(%rbp), %rax
	movq	%rax, -48(%rbp)
	subq	$8, %rsp
	leaq	-432(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	$2147483648, %rcx
	movq	-8(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -64(%rbp)
	movq	-64(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setne	%al
	movq	%rax, -72(%rbp)
	movq	-72(%rbp), %rax
	movq	-16(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$2147483647, %rcx
	movq	-8(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	-24(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -104(%rbp)
	movq	$23, %rcx
	movq	-104(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -112(%rbp)
	movq	-112(%rbp), %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -128(%rbp)
	movq	$127, %rcx
	movq	-128(%rbp), %rax
	subq	%rcx, %rax
	movq	%rax, -136(%rbp)
	movq	-136(%rbp), %rax
	movq	-32(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	$0, %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -160(%rbp)
	movq	-160(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -168(%rbp)
	movq	-168(%rbp), %rax
	cmpq	$1, %rax
	je	fp32_to_int.check_exponent
	jmp	fp32_to_int.check_sign
	.text
fp32_to_int.check_exponent:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -176(%rbp)
	movq	-176(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setge	%al
	movq	%rax, -184(%rbp)
	movq	-184(%rbp), %rax
	cmpq	$1, %rax
	je	fp32_to_int.compute
	jmp	fp32_to_int.check_sign
	.text
fp32_to_int.compute:
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -192(%rbp)
	movq	-192(%rbp), %rcx
	movq	$23, %rax
	subq	%rcx, %rax
	movq	%rax, -200(%rbp)
	movq	-200(%rbp), %rax
	movq	-48(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -216(%rbp)
	movq	$8388607, %rcx
	movq	-216(%rbp), %rax
	andq	%rcx, %rax
	movq	%rax, -224(%rbp)
	movq	-224(%rbp), %rax
	movq	-56(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -240(%rbp)
	movq	$8388608, %rcx
	movq	-240(%rbp), %rax
	orq	%rcx, %rax
	movq	%rax, -248(%rbp)
	movq	-248(%rbp), %rax
	movq	-56(%rbp), %rdi
	movq	%rax, (%rdi)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -264(%rbp)
	movq	-264(%rbp), %rax
	movq	$0, %rdi
	cmpq	%rdi, %rax
	movq	$0, %rax
	setg	%al
	movq	%rax, -272(%rbp)
	movq	-272(%rbp), %rax
	cmpq	$1, %rax
	je	fp32_to_int.shift_right
	jmp	fp32_to_int.shift_left
	.text
fp32_to_int.shift_right:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -280(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -288(%rbp)
	movq	-288(%rbp), %rcx
	movq	-280(%rbp), %rax
	shrq	%cl, %rax
	movq	%rax, -296(%rbp)
	movq	-296(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	fp32_to_int.check_sign
	.text
fp32_to_int.shift_left:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -312(%rbp)
	movq	-48(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -320(%rbp)
	movq	-320(%rbp), %rcx
	movq	$0, %rax
	subq	%rcx, %rax
	movq	%rax, -328(%rbp)
	movq	-328(%rbp), %rcx
	movq	-312(%rbp), %rax
	shlq	%cl, %rax
	movq	%rax, -336(%rbp)
	movq	-336(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	fp32_to_int.check_sign
	.text
fp32_to_int.check_sign:
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -352(%rbp)
	movq	-352(%rbp), %rax
	cmpq	$1, %rax
	je	fp32_to_int.negate
	jmp	fp32_to_int.return
	.text
fp32_to_int.negate:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -360(%rbp)
	movq	-360(%rbp), %rcx
	movq	$0, %rax
	subq	%rcx, %rax
	movq	%rax, -368(%rbp)
	movq	-368(%rbp), %rax
	movq	-40(%rbp), %rdi
	movq	%rax, (%rdi)
	jmp	fp32_to_int.return
	.text
fp32_to_int.return:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -384(%rbp)
	movq	-384(%rbp), %rax
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
	movq	$1132389990, %rax
	movq	%rax, %rdi
	callq	fp32_to_int
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	