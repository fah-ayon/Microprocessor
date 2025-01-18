.MODEL SMALL
 
.STACK 100H

.DATA
a dw 2120h
b dw 1240h



.CODE  
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX
 
; enter your code here 

mov dx, 2120h
mov ax, 1240h
mov bx,0FFFFh
div bx




;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
