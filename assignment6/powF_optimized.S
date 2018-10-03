	.file	"powF.c"
	.text
	.p2align 4,,15
	.globl	powF
	.type	powF, @function
powF:
.LFB11:
	.cfi_startproc
	testl	%edi, %edi
	movl	$1, %eax
	je	.L4
	.p2align 4,,10
	.p2align 3
.L3:
	imull	%esi, %eax
	subl	$1, %edi
	jne	.L3
	rep ret
	.p2align 4,,10
	.p2align 3
.L4:
	rep ret
	.cfi_endproc
.LFE11:
	.size	powF, .-powF
	.ident	"GCC: (GNU) 7.2.0"
	.section	.note.GNU-stack,"",@progbits
