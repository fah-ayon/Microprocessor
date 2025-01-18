.MODEL SMALL
 
.STACK 100H

.DATA
a db '?$'
b db 'The sum of $'
c db ' and $'
d db ' is $'

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
    sub bl,30h
    mov cl, bl
    
    mov ah,1
    int 21h
    
    mov bh, al
    sub bh,30h
    mov ch, bh
    
    add bh,bl
    add bh, 30h
    
    
    mov ah, 2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h
    
    mov ah, 9
    lea dx, b
    int 21h
    
    mov dl, cl
    add dl, 30h
    mov ah, 2
    int 21h
    
    mov ah, 9
    lea dx, c
    int 21h
    
    mov dl, ch
    add dl, 30h
    mov ah, 2
    int 21h
    
    
    mov ah, 9
    lea dx, d
    int 21h
    
    mov dl, bh
    mov ah,2
    int 21h    
    
    


      
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN


