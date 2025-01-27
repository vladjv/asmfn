SYS_write = 1
STDOUT_FILENO = 1
SYS_exit = 60

.section text
.global _start

_start:
    push %rbp
    mov %rsp, %rbp

    movq n, %rdi
    call print_number

    mov $SYS_exit, %rax
    mov $0, %rdi
    syscall

print_number:
    push %rbp
    mov  %rsp, %rbp

    # Store number to print
    push %rdi

    # Allocate space for sorted number
    sub 0x10, %rsp
    
    # Zero-out number digit incrementor
    xor %r12, %r12
    
.L01:
    # Check last div remainder is zero
    cmpq  $0, -8(%rbp)
    # If zero, print number
    jz print
    
    # Increment number digit incrementor
    inc %r12

    # Load last div remainder result to operator `div` as a divisor
    mov -8(%rbp), %rax

    # Set rbx to 10
    mov $10, %rbx

    
    # Zero-out rdx to store div quotient
    xor %rdx, %rdx

    # Divide rax by rbx
    # After operation rax constains remainder and rdx the quotient
    div %rbx

    # Store div remainder back into rbp - 8
    mov %rax, -8(%rbp)

    # Normalize quotient at rdx to be a correct ASCII character
    add 0x30, %dl

    mov $-8, %r13


    # Store substract correct digit offset to %r13
    sub %r12, %r13

    # Store ASCII number in reverse order at rbp - 8 - r13
    # So first iteration will be rbp - 8 + offset
    # rbp - 8 - (-7) == rbp - 15 and so on...
    movb %cl, (%rbp, %r13)

    jmp .L01

print:
    mov $SYS_write, %rax
    mov $STDOUT_FILENO, %rdi
    
    # Load properly sorted ASCII number into rsi
    lea (%rbp, %r13), %rsi
    # r12 contains the number of processed digits (or bytes)
    mov %r12, %rdx

    syscall

end:
    add 0x10, %rsp
    popq %rbp
    retq


.section .rodata
n: .int 423321
