;A

.MODEL SMALL
 
.STACK 100H

.DATA 

sum dw 1
rem dw 0 
ten db 10

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX
 
; enter your code here 

mov ax,1
block_one:
add ax,3 
add sum,ax 

cmp ax,148
jle block_one
 

    
mov ax,1 
mov cx,1000 
mov ax, sum 


print_sum:
mov dx,0 
div cx 
mov rem, dx 
mov dl,al
mov ah,2 
add dl,30h
int 21h 

mov ax,cx
div ten
mov cl,al
mov ch,0   
mov ax,rem 

cmp cx,1
jge print_sum 


;exit to DOS
               


MAIN ENDP
    END MAIN

