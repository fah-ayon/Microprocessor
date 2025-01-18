.MODEL SMALL

.STACK 100H

.DATA
A DB "Enter a num: $"

NUM1 DB '1$ '
NUM2 DB '2$'
NUM3 DB '3$'
NUM4 DB '4$'

.CODE

MAIN PROC
    ; CODE HERE
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, A
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV CL, AL
    
    CMP CL, NUM1
    JE PRINT_O
    
    CMP CL, NUM2
    JE PRINT_E
    
    CMP CL, NUM3
    JE PRINT_O
    
    CMP CL, NUM4
    JE PRINT_E
    
    JMP EXIT
    
    PRINT_O:
        MOV AH,2
        MOV DX, 0AH
        INT 21H
        MOV DX, 0DH
        INT 21H
        
        MOV DL, 'o'
        MOV AH, 2
        INT 21H
        JMP EXIT
    
    PRINT_E:
        MOV AH,2
        MOV DX, 0AH
        INT 21H
        MOV DX, 0DH
        INT 21H        
        
        MOV DL, 'e'
        MOV AH, 2
        INT 21H
        
    EXIT:
    
    MAIN ENDP
END MAIN