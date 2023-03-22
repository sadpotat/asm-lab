.MODEL SMALL
.STACK 100H 
.DATA
MSG1 DB 'Sadia$'
MSG2 DB '170021105$'
MSG3 DB 'Sec:C$'
.CODE 
MAIN PROC  
    MOV AX, @DATA
    MOV DS, AX 
          
    MOV AH, 2 
    MOV DX, 0B25H
    XOR BH, BH
    INT 10H
    
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DX, 0C23H
    XOR BH, BH
    INT 10H
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DX, 0D25H
    XOR BH, BH
    INT 10H
    
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN