.MODEL SMALL
 
.STACK 100H

.DATA
a db 'Please enter a number: $'
b db 'Please enter a number: $'
c db 'Addition result is: $'
d db 'Subtraction result is: $'
e db 'Multiplication result is: $' 
f db 'Division result is: $'
.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
    ;Addition Part
    
    mov ah, 9
    lea dx, a
    int 21h   ;showing message that stored in a
    
    mov ah,1
    int 21h   ;taking input 1 
    
    
    mov bl, al  ;moving input 1 to bl
    sub bl, 30h 
    
    
    ;new line
    mov ah,2
    mov dl, 0Dh
    int 21h     
    mov dl, 0Ah
    int 21h
    
    mov ah,9 
    lea dx, b
    int 21h     ;showing message that stored in b
    
    mov ah, 1
    int 21h     ;taking input 2
    
    
    mov bh, al  ;moving input 2 to cl
    sub bh, 30h 
    
    
    ;new line
    mov ah,2
    mov dl, 0Ah
    int 21h
    mov dl, 0Dh
    int 21h
    
    
    mov ah,9
    lea dx, c
    int 21h    ;showing message that stored in c 
    
    add bh, bl
    add bh,30h
    
    mov dl, bh 
 
    
    mov ah, 2
    int 21h
    
    
    mov ah,2
    mov dx, 0ah
    int 21h
    mov dx, 0dh
    int 21h     
    
    
    ;Subtraction Part
    
    mov ax, 0
    mov bx, 0
    mov dx, 0
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h
    
    
    mov ah, 9
    lea dx, a
    int 21h
    
    mov ah,1
    int 21h
    
    mov bl, al
    sub bl,30h
    
    mov ah,2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h
    
    mov ah,9
    lea dx, b
    int 21h
    
    mov ah, 1
    int 21h
    mov bh, al
    sub bh, 30h
    
    sub bl, bh
    
    mov ah, 2
    mov dx, 0Ah
    int 21h
    mov dx, 0Dh
    int 21h
    
    mov ah,9
    lea dx, d
    int 21h
    
    mov dl, bl
    add dl,30h
    
    mov ah, 2
    int 21h
    
    mov ah,2
    mov dx, 0ah
    int 21h
    mov dx, 0dh
    int 21h 
    
    
    ;multiplication part
    
    mov ah,2
    mov dx, 0ah
    int 21h
    mov dx, 0dh
    int 21h 
    
    mov ah,9
    lea dx, a
    int 21h
    
    mov ah,1
    int 21h
    mov bl,al
    sub bl, 30h
    
    mov ah,2
    mov dx, 0ah
    int 21h
    mov dx, 0dh
    int 21h 
    
    mov ah,9
    lea dx, b
    int 21h
        
    mov ah,1
    int 21h
    sub al, 30h
    mul bl
    mov bh, al
    
    mov ah,2
    mov dx, 0ah
    int 21h
    mov dx, 0dh
    int 21h
         


    
    mov ah,9
    lea dx, e
    int 21h
    
    mov dl, bh
    add dl, 30h 
    
    mov ah, 2
    int 21h
    
    mov ah,2
    mov dx, 0ah
    int 21h
    mov dx, 0dh
    int 21h 
    
    
    ;Division Part 
    

    
    mov ah,2
    mov dx, 0ah
    int 21h
    mov dx, 0dh
    int 21h         ;new line
    
    mov ah,9
    lea dx, a
    int 21h         ;promt print
    
    mov ah,1
    int 21h
    sub al, 30h
    mov bl,al       ;moving input to bl
    
    
    mov ah,2
    mov dx, 0ah
    int 21h
    mov dx, 0dh
    int 21h         ;new line
    
    mov ah,9
    lea dx, b
    int 21h        ;promt print
        
    mov ah,1
    int 21h
    sub al, 30h
    mov cl, al      ;moving 2nd input to cl

    mov al, bl
    mov ah, 0   ;must need to make ah 0 for 
    div cl
    mov ch,al

    
    mov ah,2
    mov dx, 0ah
    int 21h
    mov dx, 0dh
    int 21h
         


    
    mov ah,9
    lea dx, f
    int 21h
    
    mov dl, ch
    add dl, 30h 

    
    mov ah, 2
    int 21h
    
    mov ah,2
    mov dx, 0ah
    int 21h
    mov dx, 0dh
    int 21h   
    
    
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN