.include "print_number.s"

.text
.global     _start
_start: 
    push    %rbp
    mov     %rsp, %rbp
    
    movq    $20, %rdi
    call    factorial

    mov     %rax, %rdi
    call    print_number

    xor     %rdi, %rdi
    mov $60,%rax

    syscall

.func factorial
factorial:
    pushq   %rbp
    movq    %rsp, %rbp
    
    mov     %rdi, %rax
.L01:
    decq    %rdi
    cmp     $0x1, %rdi
    jle      factorial_end
    imulq   %rdi, %rax
    jmp     .L01

factorial_end:
    pop     %rbp
    retq

.endfunc
