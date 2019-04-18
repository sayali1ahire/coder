;NAME: Sayali Gopal Ahire
;SE COMPUTER
;DIV A
;ROLL NO:08

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
   mov eax,60
   syscall
%endmacro

section .data

msg1 db '1.Hex to BCD:',0AH
     db '2.BCD TO hex',0AH
     db '3.Exit', 0AH
     db 'Enter your Choice',0AH
len1 equ $-msg1

msg2 db 'Enter the Hex. no :',0AH
len2 equ $-msg2
 
msg3 db 'Enter the BCD no :',0AH
len3 equ $-msg3

msg4 db ' Hex to BCD is :',0AH
len4 equ $-msg4

msg5 db 'BCD TO hex is:',0AH
len5 equ $-msg5

msg db "  ",0AH
len equ $-msg

section .bss

	ch1 resb 5
	num1 resb 5
	num2 resb 5
	res resb 5
        num2len equ $-num2 


section .text num2len equ $-num2 
global _start  
       _start:
       switch1:
               write len1,msg1
       	       read 5,ch1
       	       mov bl,[ch1]
       	       cmp bl,'1'
       	       je case1
       	       cmp bl,'2'
       	       je case2  
       	       cmp bl,'3'
       	       je case3
       	     
        case1:
                 write len2,msg2
                 read 5,num1
                 call accept
                 mov rax,rbx
                 mov rbx,0Ah
                 mov rcx,0
              t1:mov rdx,0
                 div rbx
                 push rdx
                 inc rcx
                 cmp rax,0
                 jne t1
                
                 mov r9,num2
                
             t2: pop rdx
                 add rdx,30h
                 mov [r9],rdx
                 inc r9
                 dec rcx
                 jnz t2
                  
                 write len4,msg4
                 write num2len,num2
                 write len,msg
                 jmp switch1  

	case2:
		  write len3,msg3
         	  read 6,num1
      		  mov ax,bx
      		  mov bx, 0AH
      		  mov cl,0 
     
                  mov rax,0
                  mov rbx,0AH
                  mov rcx,5
                  mov rdx,00
    	          mov r8,num1
      
               	 l1: mul rbx
	       	 mov rdx,00
     		 mov dl,[r8]
   	       	 sub dl,30H
      	         add rax,rdx
      	         inc r8
                 dec cl
                 jnz l1
    	         mov rbx,rax
     	         call display 
     		write len5,msg5 
    		write len,msg  
      	        jmp switch1  

        case3:exit
        
  
  display:
  	  mov rcx,2
  	  mov rdi,num2
  	  	
       l2:rol bl,4
          mov al,bl
          and al,0FH
          cmp al,0FH
          cmp al,09H
          jbe l3
          add al,07H
       l3:add al,30H
          mov [rdi],al
          inc rdi
          dec rcx
          jnz l2
          write 5,num2
          ret

     


	accept: 
	mov rbx,0 
	mov rcx,4 
	 
	mov r8,num1 
	 
	L5 : 
		shl rbx,4 
		mov al,[r8] 
		cmp al,39h 
		jbe L4
		sub al,07h 
        L4 : 
		sub al,30h 
		add rbx,rax 
		inc r8 
		dec rcx 
		jnz L5
		ret 

;OUTPUT
;gescoe@gescoe-OptiPlex-3020:~/Desktop/A34$ nasm -f elf64 s2.nasm
;gescoe@gescoe-OptiPlex-3020:~/Desktop/A34$ ld s2.o -o s2
;gescoe@gescoe-OptiPlex-3020:~/Desktop/A34$ ./s2
;1.Hex to BCD:
;2.BCD TO hex
;3.Exit
;Enter your Choice
;1
;Enter the Hex. no :
;000A
;Hex to BCD is :
;10  
;1.Hex to BCD:
;2.BCD TO hex
;3.Exit
;Enter your Choice
;2
;Enter the BCD no :
;00015
;BCD to Hex is:
;0F
BCD TO hex is:  
;1.Hex to BCD:
;2.BCD TO hex
;3.Exit
;Enter your Choice
;3
;gescoe@gescoe-OptiPlex-3020:~/Desktop/A34$ 




