.MODEL SMALL
 
.STACK 100H

.DATA
a db 1,2,3,4,5
b db 5 dup(?)
.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX


mov ax, 5
mov bx, 4
sub ax, bx


mov ax, 6
mov bx, 7
sub ax, bx
neg ax  ;1' compliment

;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
