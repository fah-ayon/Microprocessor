;1

.MODEL SMALL
 
.STACK 100H

.DATA
A dw 06h
B dw 05h
.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX


mov ax, A
mov bx, B
sub bx,ax
neg bx
mov ax, bx

;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN





;2


.MODEL SMALL
 
.STACK 100H

.DATA
A dw 06h

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX


mov ax, A
inc ax
neg ax


;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN





;3

.MODEL SMALL
 
.STACK 100H

.DATA
A dw 6h
B dw 5h
C dw  ?

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX


mov ax, A
mov bx, B
mov cx, c
inc bx
add ax, bx
mov cx, ax


;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN




;4 


.MODEL SMALL
 
.STACK 100H

.DATA
A dw 6h
B dw 8h

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX


mov ax, A
mov bx, B
dec ax
sub bx, ax
mov ax, bx



;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
