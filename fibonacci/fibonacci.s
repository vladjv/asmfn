SYS_exit = 60

.text
.global _start

_start:

    mov (%rsp), %rbp
    # Pop from stack argc 
    lea -8(%rsp), %r8
    # Pop from stack argv[0]
    lea -8(%rsp), %r12
    # Store stack on base
    mov %rsp, %rbp

    movq (%rbp, %r8, 8), %rdi
    
    push %rbp

    movq %rsp, %rbp

    movq %r8, %rdi

    popq %rbp

    xorq %rdi, %rdi

    movq $SYS_exit, %rax

    syscall
