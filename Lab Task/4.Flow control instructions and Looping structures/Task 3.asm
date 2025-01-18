mov cx, 10

start: 
    mov ah,1
    int 21h    
    mov ah, 2h
    mov dl, 08h
    int 21h
    
    mov dl, 2ah
    
    int 21h

loop start
