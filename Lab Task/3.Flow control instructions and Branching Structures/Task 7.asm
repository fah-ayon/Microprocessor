.MODEL SMALL

.STACK 100H

.DATA
A DB 'PLEASE ENTER A NUM: $'
B DB 'IT IS AN EVEN NUMBER!$'
C DB 'IT IS AN ODD NUMBER!$'
.CODE

MAIN PROC
    ; CODE HERE
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH,9
    LEA DX, A
    INT 21H
    
    MOV AH,1
    INT 21H
    

    MOV AH,0
    SUB AL, '0' ;CONVERT FORM ASCII TO DEC
    MOV BL,2 
    DIV BL
    MOV CH,AH
    MOV CL, 0
    
    CMP CH,CL
    JE IT_IS_EVEN
    JMP IT_IS_ODD
    
    
    IT_IS_EVEN:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX, B
        INT 21H
        JMP EXIT
    IT_IS_ODD:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX, C
        INT 21H        
    EXIT:    

    
    MAIN ENDP
END MAIN