.MODEL SMALL

.STACK 100H

.DATA
A DB 'PLEASE ENTER A CHAR: $'
NUM1 DB 'Y$'
NUM2 DB 'y$'
.CODE

MAIN PROC
    ; CODE HERE
    MOV AX, @DATA
    MOV DS, AX

    
    MOV AH, 9
    LEA DX, A
    INT 21H
    
    MOV AH, 1
    INT 21H
    MOV BL,AL
    
    CMP BL,NUM1
    JE YES_IT_IS
    CMP BL,NUM2
    JE YES_IT_IS
    JMP EXIT
    
    YES_IT_IS:
        MOV AH,2
        MOV DX, 0AH
        INT 21H
        MOV DX, 0DH
        INT 21H
        
        MOV DL,BL
        MOV AH,2
        INT 21H
     EXIT:
       

    
    MAIN ENDP
END MAIN

