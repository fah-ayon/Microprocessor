.MODEL SMALL
.STACK 100H
.DATA
a db "Please enter the length of your name: $"
b db "Please enter your name: $"
d db "your name is: $"
c db ?


.CODE
MAIN PROC
  ;iniitialize DS
  MOV AX,@DATA
  MOV DS,AX
  ; enter your code here
    
    mov ah,9
    lea dx, a
    int 21h
    
    mov ah,1
    int 21h
    sub al, 30h
    mov cx, 0
    mov cl, al
    mov bl, cl
    
    mov ah,2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    
    
    mov ah,9
    lea dx,b
    int 21h
    
    mov si,0
    
    store_name:
        mov ah,1
        int 21h
        mov c[si],al
        add si, 1
        loop store_name
     
    
    
    mov ah, 2
    mov dl, 0ah
    int 21h
    mov dl, 0dh
    int 21h
    
    mov ah,9
    lea dx,d
    int 21h
    
    mov cl, bl
    mov si,0
    mov ah,2

    print:
        mov dl, c[si]
        int 21h
        add si,1
        loop print    
    

  ;exit to DOS
  MOV AX,4C00H
  INT 21H
MAIN ENDP
END MAIN