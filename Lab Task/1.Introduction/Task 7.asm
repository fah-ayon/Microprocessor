; 1


.MODEL SMALL
 
.STACK 100H

.DATA
X dw 6h
Y dw 8h

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX


mov ax, X
mov bx, Y
mul bx



;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
    
    
    
    
    
; 2

.MODEL SMALL
 
.STACK 100H

.DATA
X dw 10h
Y dw 5h

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX


mov ax, X
mov bx, Y
div bx          ;in byte division dividend is 16 bit it must kept in AX 
                ; after division 8 bit quotient in AL and 8 bit remainder in AH
                ;In word division dividend 32 bit must be kept in DX:AX 
                ;After division 16 bit quoitient is in AX and 16 bit remainder is in DX



;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN
    
    
    
    
;3


.MODEL SMALL
 
.STACK 100H

.DATA
X dw 10h
Y dw 5h
Z dw 10h

.CODE
MAIN PROC

;iniitialize DS

MOV AX,@DATA
MOV DS,AX


mov ax, X
mov bx, Y
mov cx, Z
mul bx
div cx



;exit to DOS
               
MOV AX,4C00H
INT 21H

MAIN ENDP
    END MAIN

