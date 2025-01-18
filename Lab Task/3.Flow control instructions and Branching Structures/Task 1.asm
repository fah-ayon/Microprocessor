.MODEL SMALL

.STACK 100H

.DATA
A DB "GREATER$"
B DB "EQUAL$"

.CODE

MAIN PROC
    ; CODE HERE
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AX, 6
    NEG AX
    MOV BX, 0
    
    CMP AX, BX
    JL L1
    JG L2
    JE L3
    
    JMP EXIT
    
    
    L2:
        MOV AH,9
        LEA DX,A
        INT 21H
        JMP EXIT 
        
    L1: 
        MOV DX, '5'
        MOV AH, 2
        INT 21H
        JMP EXIT
    
    L3:
        MOV AH,9
        LEA DX,B
        INT 21H
        JMP EXIT  
       

     
        
    EXIT:
        
    
    
    MAIN ENDP
END MAIN


