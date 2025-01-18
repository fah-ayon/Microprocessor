.MODEL SMALL

.STACK 100H

.DATA
RNG1 DB 'i$'
RNG2 DB 'k$'
RNG3 DB 'l$'
RNG4 DB 'm$'




.CODE

MAIN PROC
    ; CODE HERE
    MOV AX, @DATA
    MOV DS, AX
    

    MOV AL,3     ;GIVE INPUT HERE
    MOV BL, AL
    MOV CH,0

    
    CMP BL, CH
    JL EXIT
    
    MOV CH,3
    CMP BL, CH
    JLE PRINT_1


    MOV CH,6
    CMP BL, CH
    JLE PRINT_2

        
    MOV CH,9
    CMP BL, CH
    JLE PRINT_3
    
    MOV CL, 10
    SUB CL, '0'
    MOV CH,10
    CMP BL, CH
    JE PRINT_4
    JMP EXIT
    
    PRINT_1:
        MOV DL,RNG1
        MOV AH,2
        INT 21H
        JMP EXIT    
    
    PRINT_2:
        MOV DL,RNG2
        MOV AH,2
        INT 21H
        JMP EXIT      

    PRINT_3:
        MOV DL,RNG3
        MOV AH,2
        INT 21H
        JMP EXIT      
    
    PRINT_4:
        MOV DL,RNG4
        MOV AH,2
        INT 21H  




    EXIT:
    
    MAIN ENDP
END MAIN