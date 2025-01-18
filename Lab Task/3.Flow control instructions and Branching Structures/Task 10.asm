.MODEL SMALL

.STACK 100H

.DATA
A DB 'PLEASE ENTER A NUMBER: $'
B DB 'MAXIMUM NUMBER IS: $'
C DB 'MINIMUM NUMBER IS: $'

NUM1 DB ?
NUM2 DB ?
NUM3 DB ?

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
    MOV NUM1, AL
    
    MOV DL, ','
    MOV AH,2
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV NUM2, AL 
    
    MOV DL, ','
    MOV AH,2
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV NUM3, AL
    
    ;FOR MAXIMUM
    
    MOV CH, NUM1
    MOV CL, NUM2
    MOV BH, NUM3
    
    CMP CH, CL
    JG CHECKER1  
    MOV CH, CL
    JMP CHECKER1 
    
    
    CHECKER1:
        CMP CH,BH
        JG MAX1
        MOV CH, BH
        JMP MAX1
    
    MAX1:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX, B
        INT 21H
        
        MOV DL,CH
        MOV AH,2
        INT 21H
        
    ;FOR MINIMUM
    
    MOV CH, NUM1
    MOV CL, NUM2
    MOV BH, NUM3        
        
    
    CMP CH, CL
    JL CHECKER2  
    MOV CH, CL
    JMP CHECKER2
    
    CHECKER2:
        CMP CH,BH
        JL MINI
        MOV CH,BH
        JMP MINI
    MINI:
         
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX, C
        INT 21H
        
        MOV DL,CH
        MOV AH,2
        INT 21H
                    

    
    MAIN ENDP
END MAIN