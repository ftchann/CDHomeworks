	.text
	.file	"call5.ll"
	.globl	bar                     # -- Begin function bar
	.p2align	4, 0x90
	.type	bar,@function
bar:                                    # @bar
# %bb.0:
	leaq	(%rdi,%rsi), %rax
	addq	%rdx, %rax
	addq	%rcx, %rax
	addq	%r8, %rax
	addq	%r9, %rax
	addq	8(%rsp), %rax
	addq	16(%rsp), %rax
	retq
.Lfunc_end0:
	.size	bar, .Lfunc_end0-bar
                                        # -- End function
	.globl	foo                     # -- Begin function foo
	.p2align	4, 0x90
	.type	foo,@function
foo:                                    # @foo
# %bb.0:
	movq	%rdi, %rsi
	movq	%rdi, %rdx
	movq	%rdi, %rcx
	movq	%rdi, %r8
	movq	%rdi, %r9
	pushq	%rdi
	pushq	%rdi
	callq	bar
	addq	$16, %rsp
	retq
.Lfunc_end1:
	.size	foo, .Lfunc_end1-foo
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$3, %edi
	jmp	foo                     # TAILCALL
.Lfunc_end2:
	.size	main, .Lfunc_end2-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
