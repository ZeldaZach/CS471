	.file	"powF.c"
	.text
	.globl	powF
	.type	powF, @function
powF:
.LFB0:
	.cfi_startproc
	pushq	%rbp			-- Write; Put the return address on the stack
	.cfi_def_cfa_offset 16	-- Create; Allocate memory
	.cfi_offset 6, -16		-- Create the offsets for memory on stack
	movq	%rsp, %rbp		-- Write; Move the old location to the stack pointer
	.cfi_def_cfa_register 6
	subq	$16, %rsp		-- Create; Create 16bytes of memory on the stack
	movl	%edi, -4(%rbp)	-- Write; Put pow (arg) into edi
	movl	%esi, -8(%rbp)	-- Write; Put base (arg) into esi
	cmpl	$0, -4(%rbp)	-- Compare 0 to pow (arg)
	jne	.L2					-- If not the same, goto L2
	movl	$1, %eax		-- Put 1 into the return register
	jmp	.L3					-- Goto L3
.L2:
	movl	-4(%rbp), %eax	-- Put EAX into the stack space (pow)
	leal	-1(%rax), %edx  -- Put the address of EAX into RAX (stackPtr)
	movl	-8(%rbp), %eax 	-- Modify the value on the stack with a new value (pow-1)
	movl	%eax, %esi		-- Put stack pointer into EAX
	movl	%edx, %edi		-- Move EDI into EAX
	call	powF 			-- Recursively call the function
	imull	-8(%rbp), %eax  -- Multiply base by EAX (from iter powF)
.L3:
	leave
	.cfi_def_cfa 7, 8		-- Delete; Remove stack memory
	ret
	.cfi_endproc
.LFE0:
	.size	powF, .-powF
	.ident	"GCC: (GNU) 7.2.0"
	.section	.note.GNU-stack,"",@progbits
