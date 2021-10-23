	.data
	.globl	toofew
toofew:
	.asciz	"argc < 3"
	.data
	.globl	toomany
toomany:
	.asciz	"argc > 3"
	.text
	.globl	main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$24, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	$0, $0
	.text
main.few:
	movq	$0, $0
	movq	$0, $0
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.else:
	movq	$0, $0
	.text
main.many:
	movq	$0, $0
	movq	$0, $0
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	
	.text
main.right:
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	$0, $0
	movq	$0, %rax
	movq	%rbp, %rsp
	popq	%rbp
	retq	