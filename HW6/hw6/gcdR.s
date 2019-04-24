	.file	"gcdR.c"
	.text
	.globl	gcdR
	.type	gcdR, @function
gcdR:
.LFB0:
	.cfi_startproc
	pushq	%rbp // Save previous stackbase/frame pointer register
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp // "CREATE" STACK MEMORY: Copy current stack-pointer register to the stackbase/frame pointer register
	.cfi_def_cfa_register 6
	subq	$16, %rsp // "CREATE" STACK MEMORY: Subtract the space needed for the function's data (16 bytes) from the stack pointer (moving it to lower address)
	movl	%edi, -4(%rbp) // "WRITE" STACK MEMORY: Copy the value to the "i" argument field in the AR
	movl	%esi, -8(%rbp) // "WRITE" STACK MEMORY: Copy the value to the "j" argument field in the AR
	cmpl	$0, -8(%rbp) // "READ" STACK MEMORY: Compare the value of the "j" argument field in the AR to zero
	jne	.L2 // Move to the else block if not equal
	movl	-4(%rbp), %eax // "READ" STACK MEMORY: Move the value of the "i" argument into the return register
	jmp	.L3 // Exit
.L2: // Else block
	movl	-4(%rbp), %eax // "READ" STACK MEMORY: Move the value of the "i" argument into a temporary register
	cltd
	idivl	-8(%rbp) // "WRITE" STACK MEMORY: Perform the modulo operation ("i" argument divided by "j" argument) - remainder is stored in %edx
	movl	-8(%rbp), %eax // Move new "j" argument to temporary register
	movl	%edx, %esi // Move new "j" argument into register for second param
	movl	%eax, %edi // Move new "i" argument into register for first param
	call	gcdR // Call the next recursive loop
.L3: // Exit
	leave // "DELETE" STACK MEMORY: Release the stack frame by copying the stackbase/frame pointer register contents into the stack pointer register, pop the value of the previous frame's stackbase/frame pointer into %rbp
	.cfi_def_cfa 7, 8
	ret 
	.cfi_endproc
.LFE0:
	.size	gcdR, .-gcdR
	.ident	"GCC: (Ubuntu 5.4.0-6ubuntu1~16.04.10) 5.4.0 20160609"
	.section	.note.GNU-stack,"",@progbits
