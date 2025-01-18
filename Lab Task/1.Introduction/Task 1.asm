;Task 1

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
 mov bx, ax

 ;exit to DOS

 MOV AX,4C00H
 INT 21H

MAIN ENDP
    END MAIN
