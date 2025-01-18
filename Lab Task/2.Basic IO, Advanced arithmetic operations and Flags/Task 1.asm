.MODEL SMALL
 
.STACK 100H

.DATA
a db 'Display the message: $'



.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,1
    int 21h
      
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN


