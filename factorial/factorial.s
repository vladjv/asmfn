.include "print_number.s"
.include "asciiconv.s"
SYS_exit = 60

.text
.global     _start
_start: 
    # Pop argc
    popq    %r8
    # Pop argv[0]
    popq    %r12
    # Pop char *argv[1]
    popq    %r12

    push    %rbp

    mov     %rsp, %rbp
    
    cmpq    $2, %r8

    jne     usage

    # Store argv[1] at rdi
    movq    %r12, %rdi

    call    asciitol

    mov     %rax, %rdi

    cmp     $0, %rdi
    jle      usage

    cmpq    $30, %rdi
    jg      usage

    call    factorial

    mov     %rax, %rdi

    call    print_number

    xor     %rdi, %rdi

    mov     $SYS_exit,%rax

    syscall

usage:
    movq    $STDOUT_FILENO, %rdi
    movq    $err_str, %rsi
    movq    $err_str_len, %rdx
    movq    $SYS_write, %rax
    syscall

    mov     $1, %rdi
    mov     $SYS_exit, %rax
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

.section .rodata
err_str: .asciz "Usage is: factorial N", "\n"
.equ err_str_len, . - err_str

