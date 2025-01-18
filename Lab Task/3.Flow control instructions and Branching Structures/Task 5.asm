.MODEL SMALL

.STACK 100H

.DATA
A DB 'PLEASE ENTER A CHAR: $'
.CODE

MAIN PROC
    ; CODE HERE
    MOV AX, @DATA
    MOV DS, AX
    
    
    MOV AH, 9
    LEA DX, A
    INT 21H
    
    MOV CL, 'a'
    MOV AH, 1
    INT 21H
    MOV BL,AL
    CMP BL,CL
    JL UPPERCASE
    JMP EXIT
    
    UPPERCASE:
        MOV AH,2
        MOV DX,  0AH
        INT 21H
        MOV DX, 0DH
        INT 21H
        
        MOV DL,BL
        MOV AH,2
        INT 21H
     EXIT:
       

    
    MAIN ENDP
END MAIN