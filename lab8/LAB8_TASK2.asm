.MODEL SMALL
.STACK 100H 
.DATA
MSG1 DB '*$'
MSG2 DB '***$'
MSG3 DB '*****$'   
MSG4 DB '*******$'
.CODE 
MAIN PROC  
    MOV AX, @DATA
    MOV DS, AX 
          
    MOV AH, 2 
    MOV DX, 0104H
    XOR BH, BH
    INT 10H
    
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DX, 0203H
    XOR BH, BH
    INT 10H
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DX, 0302H
    XOR BH, BH
    INT 10H
    
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    
    MOV AH, 2
    MOV DX, 0401H
    XOR BH, BH
    INT 10H
    
    LEA DX, MSG4
    MOV AH, 9
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN