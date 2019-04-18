%macro write 2
mov rdx,%1
mov rsi,%2
mov rdi,1
mov rax,1
syscall
%endmacro

%macro read 2
mov rdx,%1
mov rsi,%2
mov rdi,0
mov rax,0
syscall
%endmacro

%macro exit 0
mov rax,60
syscall
%endmacro

section .data
msg db 'enter 4 digit hex no',0AH
len equ $-msg
msg1 db 'bcd no is:',0AH
len1 equ $-msg1

section .bss
num1 resb 5
num2 resb 5

section .text
global _start
       _start:
write len,msg
read 5,num1
call accept
mov ax,bx
mov bx,0AH
mov cl,0

l1:
    mov dx,0
    div bx
    push rdx
    inc cl
    cmp ax,0
    jne l1
    mov r9,num2
l2:
    pop rdx 
    add dl,30h
    mov [r9],dl
    inc r9
    dec cl
    jnz l2
    write len1,msg1
    write 5,num2
    exit 
   
accept:
    mov bl,0
    mov rcx,4
    mov esi,num1
l3:
    shl bl,4
    mov al,[esi]   
    cmp al,39h
    jbe l4
    sub al,07h	
l4:
    sub al,30h
    add bl,al
    inc esi
    dec ecx
    jnz l3
    ret
