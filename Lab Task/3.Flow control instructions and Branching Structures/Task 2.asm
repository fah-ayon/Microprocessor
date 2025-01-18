.MODEL SMALL

.STACK 100H

.DATA
A DB "Enter the first Char: $"
B DB "Enter the second char: $"
C DB 'Winner is : $'
D DB 'BOTH ARE EQUAL!$'
.CODE

MAIN PROC
    ; CODE HERE
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,9h
    LEA DX, A
    INT 21h
    MOV AH, 1h
    INT 21h
    MOV CH, AL
    
    MOV AH,2h
    MOV DX, 0AH
    INT 21h
    MOV DX, 0DH
    INT 21h
    
    MOV AH, 9h
    LEA DX, B
    INT 21h
    MOV AH, 1
    INT 21h
    MOV CL, AL
    
    
    CMP CH, CL
    JG B_IS_FIRST
    JL A_IS_FIRST
    JE BOTH_EQUAL
    JMP EXIT
    
    A_IS_FIRST:
        MOV AH,2h
        MOV DX, 0AH
        INT 21h
        MOV DX, 0DH
        INT 21h
        
        MOV AH, 9h
        LEA DX, C
        INT 21h
    
        MOV DL, CH
        MOV AH,2h
        INT 21h
        JMP EXIT
        
    B_IS_FIRST:
        MOV AH,2h
        MOV DX, 0AH
        INT 21h
        MOV DX, 0DH
        INT 21h
        
        MOV AH, 9h
        LEA DX, C
        INT 21h
    
        MOV DL, CL
        MOV AH,2h
        INT 21h
        JMP EXIT
    
    BOTH_EQUAL:
    
        MOV AH,2h
        MOV DX, 0AH
        INT 21h
        MOV DX, 0DH
        INT 21h
        
        
        MOV AH,9
        LEA DX, D
        INT 21H
        
        
    EXIT:        
    
     
    
    
    MAIN ENDP
END MAIN