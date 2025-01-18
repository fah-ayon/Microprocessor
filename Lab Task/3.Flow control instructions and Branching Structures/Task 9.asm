.MODEL SMALL

.STACK 100H

.DATA
B DB 'IT IS DIVISIBLE BY 5 AND 11$'
C DB 'NO! IT IS NOT DIVISIBLE BY 5 AND 11$'

.CODE

MAIN PROC
    ; CODE HERE
    MOV AX, @DATA
    MOV DS, AX
    
    
    MOV AL,55H
    MOV CH,5H
    MOV CL,11H
    MOV AH, 0
    MOV BH, AL

    DIV CH
    
    MOV BL,0
    
    CMP AH,BL
    JE DIV_5
    JMP NO_IT_IS_NOT
    
    DIV_5:
        MOV AL,BH
        DIV CL
        CMP AH,BL
        JE DIV_11
        JMP NO_IT_IS_NOT
        
    DIV_11:
        MOV AH,2
        MOV DX, 0AH
        INT 21H
        MOV DX, 0DH
        INT 21H
        
        MOV AH,9
        LEA DX, B
        INT 21H
        JMP EXIT
        
    NO_IT_IS_NOT:
        MOV AH,2
        MOV DX, 0AH
        INT 21H
        MOV DX, 0DH
        INT 21H
        
        MOV AH,9
        LEA DX, C
        INT 21H
        
    EXIT:


    
    MAIN ENDP
END MAIN

