.MODEL SMALL
.STACK 100H
.CODE 
MAIN PROC
    MOV AX, 0B800H
    MOV DS, AX
    MOV DI, 0
    ADD DI, 2 
    MOV [DI], 7020H
    ADD DI, 158
    MOV [DI], 7020H
    ADD DI, 4
    MOV [DI], 7020H
    ADD DI, 158
    MOV [DI], 7020H
    IF 1
    MOV AH, 2
    MOV DL, '0'
    INT 21H
    ENDIF
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP
END MAIN