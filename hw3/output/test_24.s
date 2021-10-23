	.text
	.globl	foo
foo:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$0, %rsp
	movq	$42, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	bar
bar:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$0, %rsp
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$64, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	.text
main.then:
	movq	$0, $0
	movq	$0, $0
	jmp	main.end
	.text
main.else:
	movq	$0, $0
	movq	$0, $0
	jmp	main.end
	.text
main.end:
	movq	$0, $0
	movq	$-123456, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	