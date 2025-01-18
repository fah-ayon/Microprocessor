.MODEL SMALL
 
.STACK 100H

.DATA
a db 'ENTER A HEX DIGIT: $'
b db  'IN DECIMAL IT IS $'
result db '00 $' 



.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
    mov ah, 9 ;showing promt
    lea dx, a
    int 21h
    
    mov ah,1   ;taking input
    int 21h
    

    sub al, 'A'
    add al, 10    ; input - 'A' + 10

    
    mov ah,0     ; clear for division
    mov cl, 10
    div cl
    add al, '0'  ; Convert quotient to ASCII
    
    mov result[0], al
    
    mov al, ah
    add al, '0'
    mov result[1], al
    
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h
    
    lea dx, result
    mov ah, 9
    int 21h


    
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN

