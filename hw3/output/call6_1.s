	.text
	.file	"call6.ll"
	.globl	baz                     # -- Begin function baz
	.p2align	4, 0x90
	.type	baz,@function
baz:                                    # @baz
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
	.size	baz, .Lfunc_end0-baz
                                        # -- End function
	.globl	bar                     # -- Begin function bar
	.p2align	4, 0x90
	.type	bar,@function
bar:                                    # @bar
# %bb.0:
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	movq	%r9, %r14
	movq	40(%rsp), %r15
	movq	48(%rsp), %r12
	addq	%rsi, %rdi
	addq	%rdi, %rdx
	addq	%rdx, %rcx
	leaq	(%rcx,%r8), %rbx
	movq	%rdx, %rsi
	movq	%rcx, %rdx
	movq	%rbx, %rcx
	pushq	%r12
	pushq	%r15
	callq	baz
	addq	$16, %rsp
	addq	%r14, %rbx
	addq	%r15, %rbx
	addq	%r12, %rbx
	addq	%rbx, %rax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	retq
.Lfunc_end1:
	.size	bar, .Lfunc_end1-bar
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
.Lfunc_end2:
	.size	foo, .Lfunc_end2-foo
                                        # -- End function
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	movl	$1, %edi
	jmp	foo                     # TAILCALL
.Lfunc_end3:
	.size	main, .Lfunc_end3-main
                                        # -- End function

	.section	".note.GNU-stack","",@progbits
	.addrsig
