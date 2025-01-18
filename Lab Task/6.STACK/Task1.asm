.MODEL SMALL
 
.STACK 100H  

.DATA
a db 1,2,3,4,5
b db 5 dup(?)
c db 'Please enter a number: $'
result db '00$'
.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX
 
mov ah,9
lea dx, c
int 21h

mov ah,1
int 21h

mov ah,0
mov cx,0
sub al, 30h

start:
cmp al,0
je exit
push ax
dec al
inc cx
jmp start

exit: 
mov dx,0
addition:
pop bx

add dx,bx

loop addition

mov ax, dx

sub al, 'A'
add al, 10    ; input - 'A' + 10

    
mov ah,0     ; clear for division
mov cl, 10
div cl
add al, '0'  ; Convert quotient to ASCII
    
mov result[0], al
    
mov al, ah
add al, '0'
mov result[1], al


mov ah, 9
lea dx, result 
int 21h


;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
