;NAME: Arpita Anil Devargaonkar
;SE COMPUTER
;DIV A
;ROLL NO:34

%macro scall 4
	mov rax,%1 
	mov rdi,%2
	mov rsi,%3
	mov rdx,%4
	syscall
%endmacro

%macro fopen 1
	mov rax,2	;open file
	mov rdi,%1	;filename
	mov rsi,2		;mode RW
	mov rdx,0777o;file permission
	syscall
%endmacro

%macro fread 3
	mov rax,0
	mov rdi,%1
	mov rsi,%2
	mov rdx,%3
	syscall
%endmacro

%macro fwrite 3
	mov rax,1
	mov rdi,%1
	mov rsi,%2
	mov rdx,%3
	syscall
%endmacro

%macro fclose 1
	mov rax,3
	mov rdi,%1
	syscall
%endmacro

section .data

fmsg db 'Enter file name:' ,0Ah
fmsg_len equ $-fmsg

err db 'Error while opening file.', 0Ah
err_len equ $-err

pre db 'File is present.' ,0Ah
pre_len equ $-pre

dlt db 'File is deleted sucessfully.', 0Ah
dlt_len equ $-dlt

write db 'File write sucessfully.' ,0Ah
write_len equ $-write

section .bss

choice resb 2
filename1 resb 50
filename2 resb 50
filehandle1 resq 1
filehandle2 resq 1
buff resb 1024
bufflen equ $-buff
act_len resq 2
cnt1 resq 1
cnt2 resq 2
dispbuff resb 5 

section .text
   global _start
            _start: 	     
             	     scall 1,1,fmsg,fmsg_len 	; write message
             	     scall 0,0,filename1,50	;read message/filename
             	     dec rax
             	     mov byte[filename1+rax],0	;checking end of argument
             	     mov rax,87		;system call for delete
             	     mov rdi,filename1	;move addr of file to be deleted in rdi
             	     syscall
             	    
             	     cmp rax,-1H
             	     jle Error
	     	     scall 1,1,dlt,dlt_len
	     	     jmp nxt



		Error:
		         scall 1,1,err,err_len
		
		nxt:
		      mov rax,60
		      syscall



;OUTPUT
;gescoe@gescoe-OptiPlex-3020:~/Desktop/A34$ nasm -f elf64 dlt.nasm
;gescoe@gescoe-OptiPlex-3020:~/Desktop/A34$ ld -o dlt dlt.o
;gescoe@gescoe-OptiPlex-3020:~/Desktop/A34$ ./dlt
;Enter file name:
;b.txt
;File is deleted sucessfully.




