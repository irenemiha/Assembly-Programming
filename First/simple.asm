%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
    
    mov eax, 0
label:
    mov byte[edi + eax], byte[esi + eax]
    add byte[edi + eax], edx
    cmp byte[edi + eax], 90
    jg daca
    jle contor

daca:
    sub byte[edi + eax], 26

contor:
    add eax, 1
    cmp eax, ecx
    jl label
    
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY