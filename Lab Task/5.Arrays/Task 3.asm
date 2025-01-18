.MODEL SMALL
.STACK 100H
.DATA
a db 'Please give me a number: $' ; Prompt message
c db 'Maximum number is: $'  ; Prompt message
b db 3 dup(?)                        ; Array to store digits
newline db 0Dh,0Ah, '$'              ; Newline for output


.CODE
MAIN PROC
    ; Initialize DS
    MOV AX, @DATA
    MOV DS, AX
    
    mov ah,9
    lea dx, a
    int 21h
    
    mov cx, 3
    mov si,0
    input:
        mov ah,1
        int 21h
        mov b[si], al
        add si, 1
        loop input
        
    
    mov ah, 9
    lea dx, newline
    int 21h
    
    mov ah,9
    lea dx, c
    int 21h
    
    mov si, 0
    compare:
        mov bh, b[si]
        mov bl, b[si+1]
        cmp bh,bl
        jge next
        mov bh, bl
        jmp next
        
        next:
            inc si
            mov bl, b[si+1]
            cmp bh, bl
            jge print
            mov bh, bl
            jmp print
            
    print:
        mov dl, bh
        mov ah,2
        int 21h    

    ; Exit to DOS
    mov ah, 4Ch
    int 21h
MAIN ENDP
END MAIN
