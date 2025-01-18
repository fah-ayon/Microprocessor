.MODEL SMALL
 
.STACK 100H

.DATA




.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
   
    mov ax, 2
    inc ax
    mov bx, 3
    dec bx
    mul bx
    mov cx, ax ;(1 + 2) * (3 – 1)
    mov ax, 2
    mov bx, 1
    mul bx
    mov bx, ax ;(1 * 2)
    mov ax, cx ;now ax=6
    mov cx, 5
    div cx     ;result will store in AX
    add ax, 3
    add ax, 2  ;result + 3 + 2
    sub ax, bx ;(1 + 2) * (3 – 1) / 5 + 3 + 2 – (1 * 2)
      
    
    
    
    
    ;exit to DOS
                   
    MOV AX,4C00H
    INT 21H

MAIN ENDP
    END MAIN


