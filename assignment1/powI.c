/* Use to generate assembly file */
int powI(int pow, int base) {
  int acc, p;
  for (acc=1,p=0; p < pow; p++) {
    acc = acc * base;
  }
  return acc;
} 

	.file	"powI.c"			# Define the file it came from
	.text						# Define the executabl region
	.globl	powI				# Define the method as global
	.type	powI, @function		# Define the method as a function
powI:
.LFB0:			
	.cfi_startproc
	pushq	%rbp				# Save the old rbp value
	.cfi_def_cfa_offset 16		# Create an offset for local vars (acc, p) -- Creation of stackframe
	.cfi_offset 6, -16			# Move the local offset pointer
	movq	%rsp, %rbp			# Move the stack pointer value into rbp
	.cfi_def_cfa_register 6		# 
	movl	%edi, -20(%rbp)		# Define pow and put the value in
	movl	%esi, -24(%rbp)		# Define base and put the value in 
	movl	$1, -4(%rbp)		# set acc = 1
	movl	$0, -8(%rbp)		# Set p = 0
	jmp	.L2						# Execute the for loop
.L3:
	movl	-4(%rbp), %eax 		# Put acc into eax
	imull	-24(%rbp), %eax 	# Multiple eax (acc) by base
	movl	%eax, -4(%rbp) 		# set acc = eax
	addl	$1, -8(%rbp)		# p++
.L2:
	movl	-8(%rbp), %eax 		# Put p into eax
	cmpl	-20(%rbp), %eax 	# Compare eax (p) to pow
	jl	.L3 					# if p < pow, goto L3
	movl	-4(%rbp), %eax   	# p >= pow, so put acc into eax
	popq	%rbp				# Place back the old rbp value
	.cfi_def_cfa 7, 8
	ret   						# return acc -- Exit the function
	.cfi_endproc
.LFE0:
	.size	powI, .-powI
	.ident	"GCC: (GNU) 7.2.0"
	.section	.note.GNU-stack,"",@progbits