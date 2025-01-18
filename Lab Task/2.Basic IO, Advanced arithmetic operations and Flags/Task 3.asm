;1

.MODEL SMALL
 
.STACK 100H

.DATA
a db 'Put a character: $'



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
    
    mov bl, al
    
    mov ah,2
    mov dx, 0ah
    int 21h
    
    mov dl, bl
    mov ah,2
    int 21h
      
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN




;2


.MODEL SMALL
 
.STACK 100H

.DATA
a db 'Give me a uppercase letter: $'



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
    
    mov bl, al
    

    
    mov dl, bl
    add dl, 20h ;upper-lower
    mov ah,2
    int 21h
      
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN


