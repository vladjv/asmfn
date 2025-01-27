SYS_write = 1
STDOUT_FILENO = 1

    .text
.global _start

print_number:
	push %rbp
	movq %rsp, %rbp
	
	push %rdi
	sub $0x10, %rsp
	
	xor %r12, %r12
.print_L01:
	cmpq $0, -8(%rbp)
	je print
	
	xor %rdx, %rdx
	mov $10, %rbx
	mov -8(%rbp), %rax
	
	divq %rbx
	
	mov %rax, -8(%rbp)
	
	inc %r12
	mov $-8, %r13
	sub %r12, %r13
	
	add $0x30, %dl
	movb %dl, (%rbp, %r13)
	
	jmp .print_L01
	
	
print:
	mov $STDOUT_FILENO, %rdi
	lea (%rbp, %r13), %rsi
	mov %r12, %rdx
	mov $SYS_write, %rax
	syscall
	
	add $0x18, %rsp

	popq %rbp
	retq
