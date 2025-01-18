.MODEL SMALL
.STACK 100H
.DATA
a db 'Please enter 5 digits: $' ; Prompt message
c db 'Here is your sorted array: $'  ; Prompt message
b db 5 dup(?)                        ; Array to store digits
newline db 0Dh,0Ah, '$'              ; Newline for output


.CODE
MAIN PROC
    ; Initialize DS
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt
    mov ah, 9
    lea dx, a
    int 21h

    ; Input 5 digits
    mov cx, 5        ; Loop counter for 5 digits
    mov si, 0        ; Array index

store_input:
    mov ah, 1        ; Function 1: Read a character
    int 21h
    sub al, '0'      ; Convert ASCII to numeric (e.g., '5' -> 5)
    mov b[si], al    ; Store numeric value in the array
    inc si           ; Move to the next array index
    loop store_input ; Repeat 5 times

    ; Bubble Sort
    mov cx, 4        ; Outer loop (number of passes = n-1)
outer_loop:
    mov si, 0        ; Reset index for each pass
    mov dx, cx       ; Inner loop counter (dynamic)

inner_loop:
    mov al, b[si]    ; Load current element into AL
    mov ah, b[si+1]  ; Load next element into AH
    cmp al, ah       ; Compare the two elements
    jle no_swap      ; If AL <= AH, no swap needed

    ; Swap the elements
    mov b[si], ah    ; Store AH in current position
    mov b[si+1], al  ; Store AL in the next position

no_swap:
    inc si           ; Move to the next pair
    dec dx           ; Decrease inner loop counter
    jnz inner_loop   ; Repeat inner loop until dx = 0

    loop outer_loop  ; Repeat outer loop (cx times)

    ; Print sorted array
    lea dx, newline  ; Print newline
    mov ah, 9
    int 21h
    mov ah, 9
    lea dx,c
    int 21h

    mov cx, 5        ; Loop counter for 5 elements
    mov si, 0        ; Reset index

print_array:
    mov dl, b[si]    ; Load the sorted value
    add dl, '0'      ; Convert numeric value back to ASCII
    mov ah, 2        ; Function 2: Print character
    int 21h
    inc si           ; Move to the next element
    loop print_array ; Repeat 5 times

    ; Exit to DOS
    mov ah, 4Ch
    int 21h
MAIN ENDP
END MAIN
