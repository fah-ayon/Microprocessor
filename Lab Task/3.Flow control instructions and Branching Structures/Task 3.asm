.MODEL SMALL

.STACK 100H

.DATA

.CODE

MAIN PROC
    ; CODE HERE
    MOV AX, @DATA
    MOV DS, AX
    
    
    MOV AX, 0   
    MOV CX, 0
    CMP AX,CX
    JL NEGETIVE
    JG POSITIVE
    JE EQUAL
    JMP EXIT
    
    NEGETIVE:
        MOV BX, 1
        NEG BX
        JMP EXIT
    
    POSITIVE:
        MOV BX, 1
        JMP EXIT
        
    EQUAL:
        MOV BX, 0
        
    EXIT:
    
    MAIN ENDP
END MAIN