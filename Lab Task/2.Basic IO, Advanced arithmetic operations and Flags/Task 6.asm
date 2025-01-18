.MODEL SMALL
 
.STACK 100H

.DATA
a db 'ENTER THREE INITIALS: $'


.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah, 1
    int 21h
    mov bh, al
    
    mov ah,1
    int 21h
    mov bl,al
    
    mov ah,1
    int 21h
    mov ch, al
    
    
    mov ah,2
    mov dx, 0AH
    int 21h
    mov dx, 0Dh
    int 21h
    
    mov dl, bh
    mov ah,2
    int 21h
    
    mov ah,2
    mov dx, 0AH
    int 21h
    mov dx, 0Dh
    int 21h
    
    mov dl, bl
    mov ah,2
    int 21h
    
    mov ah,2
    mov dx, 0AH
    int 21h
    mov dx, 0Dh
    int 21h    
    
    mov dl, ch
    mov ah, 2
    int 21h


      
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN


