.MODEL SMALL

.STACK 100H

.DATA
A DB 'USER INPUT: $'
TYP1 DB '31 DAYS$'
TYP2 DB '30 DAYS$'
TYP3 DB '28 DAYS$'

NUM1 DB '2$'
NUM2 DB '8$'


.CODE

MAIN PROC
    ; CODE HERE
    MOV AX, @DATA
    MOV DS, AX

    MOV AH,9
    LEA DX,A
    INT 21H
    
    MOV AH,1
    INT 21H
    SUB AL, '0'
    MOV BL,AL
    
    MOV CL, NUM1
    SUB CL, '0'
    CMP BL, CL
    JE TYP_3
    MOV CL, NUM2
    SUB CL, '0'
    CMP BL, CL
    JE TYP_1
    
    MOV CL,2
    MOV AL,BL
    MOV AH, 0
    DIV CL
    CMP AH,0H
    JE TYP_2
    JG TYP_1
    JMP EXIT
    
    TYP_1:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX, 0DH
        INT 21H
        
        MOV AH,9
        LEA DX, TYP1
        INT 21H
        JMP EXIT
        
    TYP_2:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX, 0DH
        INT 21H
        
        MOV AH,9
        LEA DX, TYP2
        INT 21H
        JMP EXIT
        
    TYP_3:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX, 0DH
        INT 21H
        
        MOV AH,9
        LEA DX, TYP3
        INT 21H
        JMP EXIT            

    EXIT:
    
    MAIN ENDP
END MAIN