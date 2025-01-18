
mov ah, 02h
mov cx,80
mov dl,2ah
print:
    int 21h
    loop print