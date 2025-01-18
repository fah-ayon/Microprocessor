.MODEL SMALL
 
.STACK 100H

.DATA
a dw "enter three initials: $"
b dw "output: $"


.CODE  
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX
 
; enter your code here 

lea dx, a
mov ah,9
int 21h

mov ah,1
int 21h
mov bl,al
sub bl, 20h

mov ah,2
mov dl, 0dh
int 21h
mov dx, 0ah
int 21h

mov ah,1
int 21h
mov bh,al
sub bh, 20h 

mov ah,2
mov dl, 0dh
int 21h
mov dx ,0ah
int 21h




mov ah,1
int 21h
mov cl,al
sub cl, 20h

mov ah,2
mov dl, 0dh
int 21h
mov dx, 0ah
int 21h 


lea dx, b
mov ah,9
int 21h


mov dl,cl
mov ah,2
int 21h



mov ah,2
mov dl, 0dh
int 21h
mov dx, 0ah
int 21h


mov dl,bh

mov ah,2
int 21h


mov ah,2
mov dl, 0dh
int 21h
mov dx ,0ah
int 21h


mov dl,bl
mov ah,2
int 21h
mov dl,bl








mov ah,1
;exit to DOS
               
MOV AX,4C00H
INT 21H
MAIN ENDP
    END MAIN


