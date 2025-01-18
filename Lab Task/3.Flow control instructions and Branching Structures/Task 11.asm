.MODEL SMALL

.STACK 100H

.DATA
A DB 'PLEASE ENTER A SIDE: $'
SIDE_1 DB ?
SIDE_2 DB ?
SIDE_3 DB ?

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
    SUB AL,'0' ;CONVERT ASCII TO DEC
    MOV SIDE_1, AL
    
    MOV DL, ','
    MOV AH,2
    INT 21H
    
    MOV AH,1
    INT 21H
    SUB AL,'0' 
    MOV SIDE_2, AL
    
    MOV DL, ','
    MOV AH,2
    INT 21H
        
    MOV AH,1
    INT 21H
    SUB AL,'0' 
    MOV SIDE_3, AL
    
    
    MOV CL, SIDE_1
    MOV CH, SIDE_2
    MOV BL, SIDE_3
    
    ADD CL,CH
    CMP CL,BL
    JL NOT_YET
    
    MOV CL, SIDE_1
    MOV CH, SIDE_2
    MOV BL, SIDE_3
    
    ADD CL,BL
    CMP CL,CH
    JL NOT_YET    

    
    MOV CL, SIDE_1
    MOV CH, SIDE_2
    MOV BL, SIDE_3
    
    ADD CH,BL
    CMP CH,CL
    JL NOT_YET
    
    MOV AH,2
    MOV DX,0AH
    INT 21H
    MOV DX, 0DH
    INT 21H
    
    MOV DL, 'Y'
    MOV AH,2
    INT 21H
    JMP EXIT
    
    NOT_YET:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX, 0DH
        INT 21H
        
        MOV DL, 'N'
        MOV AH,2
        INT 21H       
    EXIT:
    
    MAIN ENDP
END MAIN