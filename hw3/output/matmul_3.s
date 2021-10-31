	.text
	.file	"matmul.ll"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
# %bb.0:
	pushq	%rbx
	movq	$-10000000, %rbx        # imm = 0xFF676980
	.p2align	4, 0x90
.LBB0_1:                                # %body
                                        # =>This Inner Loop Header: Depth=1
	movl	$mat1, %edi
	movl	$mat2, %esi
	movl	$matr, %edx
	callq	matmul
	incq	%rbx
	jne	.LBB0_1
# %bb.2:                                # %exit
	xorl	%eax, %eax
	popq	%rbx
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
                                        # -- End function
	.globl	matmul                  # -- Begin function matmul
	.p2align	4, 0x90
	.type	matmul,@function
matmul:                                 # @matmul
# %bb.0:
	xorl	%r8d, %r8d
	.p2align	4, 0x90
.LBB1_1:                                # %startj.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_2 Depth 2
	movq	%r8, %rax
	shlq	$4, %rax
	leaq	(%rdi,%rax), %r9
	leaq	(%rdi,%rax), %r10
	addq	$8, %r10
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB1_2:                                # %thenj
                                        #   Parent Loop BB1_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%rsi,%rcx,8), %r11
	imulq	(%r9), %r11
	movq	16(%rsi,%rcx,8), %rax
	imulq	(%r10), %rax
	addq	%r11, %rax
	movq	%rax, (%rdx,%rcx,8)
	addq	$1, %rcx
	cmpq	$2, %rcx
	jne	.LBB1_2
# %bb.3:                                # %endj
                                        #   in Loop: Header=BB1_1 Depth=1
	addq	$1, %r8
	addq	$16, %rdx
	cmpq	$2, %r8
	jne	.LBB1_1
# %bb.4:                                # %endi
	retq
.Lfunc_end1:
	.size	matmul, .Lfunc_end1-matmul
                                        # -- End function
	.globl	mateq                   # -- Begin function mateq
	.p2align	4, 0x90
	.type	mateq,@function
mateq:                                  # @mateq
# %bb.0:
	xorl	%r8d, %r8d
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB2_1:                                # %startj1.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_2 Depth 2
	xorl	%edx, %edx
	.p2align	4, 0x90
.LBB2_2:                                # %thenj1
                                        #   Parent Loop BB2_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%rsi,%rdx,8), %rcx
	xorq	(%rdi,%rdx,8), %rcx
	orq	%rcx, %rax
	addq	$1, %rdx
	cmpq	$2, %rdx
	jne	.LBB2_2
# %bb.3:                                # %endj1
                                        #   in Loop: Header=BB2_1 Depth=1
	addq	$1, %r8
	addq	$16, %rsi
	addq	$16, %rdi
	cmpq	$2, %r8
	jne	.LBB2_1
# %bb.4:                                # %endi1
	retq
.Lfunc_end2:
	.size	mateq, .Lfunc_end2-mateq
                                        # -- End function
	.type	mat1,@object            # @mat1
	.data
	.globl	mat1
	.p2align	4
mat1:
	.quad	1                       # 0x1
	.quad	2                       # 0x2
	.quad	3                       # 0x3
	.quad	4                       # 0x4
	.size	mat1, 32

	.type	mat2,@object            # @mat2
	.globl	mat2
	.p2align	4
mat2:
	.quad	5                       # 0x5
	.quad	6                       # 0x6
	.quad	7                       # 0x7
	.quad	8                       # 0x8
	.size	mat2, 32

	.type	mat3,@object            # @mat3
	.globl	mat3
	.p2align	4
mat3:
	.quad	19                      # 0x13
	.quad	22                      # 0x16
	.quad	43                      # 0x2b
	.quad	50                      # 0x32
	.size	mat3, 32

	.type	matr,@object            # @matr
	.bss
	.globl	matr
	.p2align	4
matr:
	.zero	32
	.size	matr, 32


	.section	".note.GNU-stack","",@progbits
	.addrsig
	.addrsig_sym mat1
	.addrsig_sym mat2
	.addrsig_sym matr
