.MODEL SMALL

.STACK 100H

.DATA
A DB 'PLEASE ENTER A LETTER: $'
ALPH1 DB 'A$'
ALPH2 DB 'E$'
ALPH3 DB 'I$'
ALPH4 DB 'O$'
ALPH5 DB 'U$'
ALPH6 DB 'a$'
ALPH7 DB 'e$'
ALPH8 DB 'i$'
ALPH9 DB 'o$'
ALPH10 DB 'u$'

B DB 'IT IS VOWEL$'
C DB 'IT IS CONSONANT$'

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
    
    MOV BL, AL
    
    CMP BL, ALPH1
    JE IT_IS_V
    CMP BL, ALPH2
    JE IT_IS_V     
    CMP BL, ALPH3
    JE IT_IS_V    
    CMP BL, ALPH4
    JE IT_IS_V   
    CMP BL, ALPH5
    JE IT_IS_V
    CMP BL, ALPH6
    JE IT_IS_V
    CMP BL, ALPH7
    JE IT_IS_V
    CMP BL, ALPH8
    JE IT_IS_V
    CMP BL, ALPH9
    JE IT_IS_V
    CMP BL, ALPH10
    JE IT_IS_V
    
    JMP IT_IS_C
    
    
    IT_IS_V:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX,B
        INT 21H
        
        JMP EXIT
       
    IT_IS_C:
        MOV AH,2
        MOV DX,0AH
        INT 21H
        MOV DX,0DH
        INT 21H
        
        MOV AH,9
        LEA DX,C
        INT 21H
      
    EXIT:
     

    
    MAIN ENDP
END MAIN

