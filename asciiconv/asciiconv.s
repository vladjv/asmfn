asciitol:
    # Function receives a char *
    # Function returns a 64-bit number
    push    %rbp
    mov     %rsp, %rbp

    # Reset address counter for accessing string bytes
    xor     %rbx, %rbx

    # Reset current ASCII byte register
    xor     %rcx, %rcx

    # Reset temporary accumulator
    xor     %r8, %r8
    
    # Negative number flag
    xor     %r12, %r12
.ATOIL01:
    # Load ASCII byte in stack
    movb    (%rdi, %rbx), %cl

    # If string byte is 0, end function
    cmpb    $0, %cl
    je      asciitol_end

    inc     %rbx
    
    # If flag is not set, try to parse ASCII negative sign
    test    %r12, %r12
    jnz     flag_end
    cmp     $0x2d, %cl
    sete    %r12b
    # After setting negative flag, parse next ASCII byte
    je      .ATOIL01
flag_end:
    # Strip 0x30 from ASCII number
    and     $0x0F, %cl

    # If stripped ASCII byte is not a number, end function
    cmp     $0, %cl
    jl      asciitol_end

    # If stripped ASCII byte is not a number, end function
    cmp     $9, %cl
    jg      asciitol_end

    # r8 = cl + (10 * r8)
    mov     $10, %rax
    imul    %r8
    mov     %rax, %r8
    add     %rcx, %r8

    jmp     .ATOIL01

negate:
    # Negative accumulator register and clear flag
    neg     %r8
    xor     %r12, %r12
asciitol_end:
    # Jump if negative sign is found in ASCII string
    testb   %r12b, %r12b
    jnz     negate
    
    pop     %rbp

    mov     %r8, %rax

    retq 
