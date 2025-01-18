
;Task 1

.MODEL SMALL
 
.STACK 100H

.DATA




.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
    mov dx, 2000h
    mov ax, 036DFh
    mov bx,0AFh
    mul bx
    
    
    
    
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN





;Task 2



.MODEL SMALL
 
.STACK 100H

.DATA




.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
    mov dx, 08A32h
    mov ax, 0F4D5h
    mov bx, 0C9A5h
    div bx
    
    
    
    
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN


;Task 3


.MODEL SMALL
 
.STACK 100H

.DATA




.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
   
    mov ax, 0CA92h
    mov bx,0BAF9h
    mul bx   ;16bit x 16bit multiply total 32bit, DX will store higher 16bit and AX will store lower 16bit
    
    
    
    
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN


; Task 4

.MODEL SMALL
 
.STACK 100H

.DATA




.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
   
    mov ax, 0C2A2h
    mov bx,0ABCDh
    mov cx, 0BEDh
   
    mul bx 
    div cx  
    
    
    
    
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN

