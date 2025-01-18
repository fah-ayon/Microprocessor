.MODEL SMALL

.STACK 100H

.DATA
A DB 'ENTER A DIGIT: $'
DAY1 DB 'SATURDAY$'
DAY2 DB 'SUNDAY$'
DAY3 DB 'MONDAY$'
DAY4 DB 'TUESDAY$'
DAY5 DB 'WEDNESDAY$'
DAY6 DB 'THURSDAY$'
DAY7 DB 'FRIDAY$'




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
    
    MOV CL,1
    CMP BL,CL
    JE PRINT1
    JL EXIT
    
    MOV CL,2
    CMP BL,CL
    JE PRINT2
     
    MOV CL,3
    CMP BL,CL
    JE PRINT3

    MOV CL,4
    CMP BL,CL
    JE PRINT4

    MOV CL,5
    CMP BL,CL
    JE PRINT5
    
    MOV CL,6
    CMP BL,CL
    JE PRINT6
    
    MOV CL,7
    CMP BL,CL
    JE PRINT7
    JMP EXIT
    
    PRINT1:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        

        
        MOV AH,9
        LEA DX, DAY1
        INT 21H
        
        JMP EXIT

    PRINT2:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX, DAY2
        INT 21H

        JMP EXIT
        
    PRINT3:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX, DAY3
        INT 21H
        
        JMP EXIT
        
    PRINT4:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX, DAY4
        INT 21H
        
        JMP EXIT

    PRINT5:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX, DAY5
        INT 21H
        
        JMP EXIT
        
    PRINT6:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX, DAY6
        INT 21H
        
        JMP EXIT
        
    PRINT7:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX, DAY7
        INT 21H
                
        
                        

    EXIT:
    
    MAIN ENDP
END MAIN