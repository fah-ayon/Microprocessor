.MODEL SMALL
 
.STACK 100H

.DATA
a db '**********$' 



.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
;1
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h

;2
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h

;3
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h

;4
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h
          
;5
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h

;6
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h

;7
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h
    
;8
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h   

;9
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h

;10
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h

    
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN

