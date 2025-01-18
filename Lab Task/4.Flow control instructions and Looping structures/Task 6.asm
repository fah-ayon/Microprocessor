.MODEL SMALL
 
.STACK 100H

.DATA
a db 'Enter a hex digit: $'
b db 'In decimal it is: $'
c db 'Do you want to do it again? (y/n) $'
d db 'ILLEGAL CHARACTER - ENTER 0 .. 9 OR A .. F$'
result db ?



.CODE  
MAIN PROC

    ;iniitialize DS
    
    MOV AX,@DATA
    MOV DS,AX
     
    ; enter your code here 
    
start:
    
    mov ah,9
    lea dx, a
    int 21h
    

    mov ah,1
    int 21h

    mov result, al

    cmp result, '9'
    jg high
    jle low
    
    high:

       cmp result, 'F'
       jg exit         
       sub al, 'A'
       add al, 10
       mov ah, 0
       mov cl, 10
       div cl
       add al, '0'
       mov result, al
       mov cl, ah

       mov dx, 0ah
       mov ah,2
       int 21h
       mov dx, 0dh
       mov ah,2
       int 21h

    
       mov ah,9
       lea dx, b
       int 21h



       
       mov dl, result
       mov ah,2 
       int 21h  
       
       mov al, cl
       add al, '0'
       mov result, al
       

       mov dl, result
       mov ah,2 
       int 21h       
       jmp again

    
    
    
    low:
    mov dx, 0ah
    mov ah,2
    int 21h
    mov dx, 0dh
    mov ah,2
    int 21h

    
    mov ah,9
    lea dx, b
    int 21h
    
    mov dl, result
    mov ah,2 
    int 21h

    again: 
    mov dx, 0ah
    mov ah,2
    int 21h
    mov dx, 0dh
    mov ah,2
    int 21h

    


    mov ah,9
    lea dx, c
    int 21h
    mov ah,1
    int 21h
    cmp al, 'y'


    mov dx, 0ah
    mov ah,2
    int 21h
    mov dx, 0dh
    mov ah,2
    int 21h    
    
    
    je start
    
    jmp exit2 


exit:

       mov dx, 0ah
       mov ah,2
       int 21h
       mov dx, 0dh
       mov ah,2
       int 21h

    
       mov ah,9
       lea dx, d
       int 21h

       
exit2:
 

MAIN ENDP
    END MAIN
