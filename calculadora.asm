section .data
    prompt1 db 'Digite o primeiro número: ', 0
    prompt1_len equ $ - prompt1 - 1
    prompt2 db 'Digite o segundo número: ', 0
    prompt2_len equ $ - prompt2 - 1
    prompt_op db 'Operação (+, -, *, /): ', 0
    prompt_op_len equ $ - prompt_op - 1
    result_msg db 'Resultado: ', 0
    result_msg_len equ $ - result_msg - 1
    err_div0 db 'Erro: Divisão por zero!', 10, 0
    err_div0_len equ $ - err_div0 - 1
    err_op db 'Operador inválido!', 10, 0
    err_op_len equ $ - err_op - 1
    newline db 10

section .bss
    num1 resb 16
    num2 resb 16
    op resb 2
    result resb 32

section .text
    global _start

_start:
    ; Primeiro número
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt1
    mov rdx, prompt1_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, num1
    mov rdx, 16
    syscall

    mov rsi, num1
    call atoi
    push rax

    ; Segundo número
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt2
    mov rdx, prompt2_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, num2
    mov rdx, 16
    syscall

    mov rsi, num2
    call atoi
    push rax

    ; Operador
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_op
    mov rdx, prompt_op_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, op
    mov rdx, 2
    syscall

    pop rbx             ; num2
    pop rax             ; num1

    mov cl, [op]
    cmp cl, '+'
    je soma
    cmp cl, '-'
    je subtrai
    cmp cl, '*'
    je multiplica
    cmp cl, '/'
    je divide

    ; Operador inválido
    mov rsi, err_op
    mov rdx, err_op_len
    jmp erro

soma:
    add rax, rbx
    jmp exibe

subtrai:
    sub rax, rbx
    jmp exibe

multiplica:
    imul rax, rbx
    jmp exibe

divide:
    test rbx, rbx
    jz div_zero
    cqo
    idiv rbx
    jmp exibe

div_zero:
    mov rsi, err_div0
    mov rdx, err_div0_len
    jmp erro

erro:
    mov rax, 1
    mov rdi, 1
    syscall
    jmp sair

exibe:
    mov rdi, result
    call itoa
    mov rsi, result
    call strlen

    push rdx
    mov rax, 1
    mov rdi, 1
    mov rsi, result_msg
    mov rdx, result_msg_len
    syscall

    pop rdx
    mov rax, 1
    mov rdi, 1
    mov rsi, result
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

sair:
    mov rax, 60
    xor rdi, rdi
    syscall

; Funções auxiliares
atoi:
    xor rax, rax
    xor rcx, rcx
    xor rbx, rbx

    cmp byte [rsi], '-'
    jne .loop
    inc rcx
    inc rsi

.loop:
    mov bl, [rsi]
    cmp bl, 10
    je .fim
    sub bl, '0'
    imul rax, 10
    add rax, rbx
    inc rsi
    jmp .loop

.fim:
    test rcx, rcx
    jz .positivo
    neg rax
.positivo:
    ret

itoa:
    push rbp
    mov rbp, rsp
    sub rsp, 32

    test rax, rax
    jns .positivo
    neg rax
    mov byte [rdi], '-'
    inc rdi

.positivo:
    mov rbx, 10
    xor rcx, rcx

.converte:
    xor rdx, rdx
    div rbx
    add dl, '0'
    push rdx
    inc rcx
    test rax, rax
    jnz .converte

.pop:
    pop rax
    mov [rdi], al
    inc rdi
    dec rcx
    jnz .pop

    mov byte [rdi], 10
    inc rdi
    mov byte [rdi], 0
    leave
    ret

strlen:
    xor rdx, rdx
.contador:
    mov al, [rsi + rdx]
    cmp al, 10
    je .fim
    test al, al
    jz .fim
    inc rdx
    jmp .contador
.fim:
    inc rdx
    ret
