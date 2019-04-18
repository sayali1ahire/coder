%macro write 2
mov edx,%1
mov esi,%2
mov edi,1
mov eax,1
syscall
%endmacro

%macro read 2
mov edx,%1
mov esi,%2
mov edi,0
mov eax,0
syscall
%endmacro

%macro exit 0
mov rax,60
syscall
%endmacro

section .data
		arr dq 123456789ABCDEFh,-123456789000000h,123456789000000h,7FFFFFFFFFFFFFFh
		n equ 4
		pmsg db 'positive no. count',0AH
		plen equ $-pmsg
		nmsg db 'negative no. count',0AH
		nlen equ $-nmsg
		nwline db 10
		
section .bss
pcnt resb 10
ncn resb 10
num2 resb 14
section .text
mov rsi,arr
mov rdi,n
mov rbx,0
mov rcx,0
up:mov rax,[rsi]
	cmp rax,000000000000000h
	js negative
	positive:inc rbx
	jmp next
	negative :inc rcx
	next:add rsi,8
	dec rdi
	jnz up
	mov[pcnt],rbx
	mov[ncnt],rcx
	write plen,pmsg
	mov rax,[pcnt]
	call display
	write nlen,nmsg
	mov rax,[ncnt]
	call display
	mov rax 60
	syscall
display: 
       	mov bl,[res]
            mov ecx,2
            mov edi,num2               
         l5:rol bl,4
            mov al,bl
            and al,0fh
            cmp al,09h
            jbe l4
            add al,07h
         l4:add al,30h
            mov[edi],al
            inc edi
            dec ecx
            jnz l5
            write 2,num2
            ret 
			
		
