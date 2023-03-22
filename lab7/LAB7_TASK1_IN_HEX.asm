.MODEL SMALL
.STACK 100H
.DATA
MSG1 DB 'ENTER THE FIRST INTEGER (0-FFFF): $'
MSG2 DB 0DH, 0AH, 'ENTER THE SECOND INTEGER (0-FF): $'
MSG3 DB 0DH, 0AH, 'THEIR GCD IS '
CHAR1 DB ?
CHAR2 DB ?
CHAR3 DB ?
CHAR4 DB ?,'$'
M DW ?
N DW ?
.CODE
PROC MAIN
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    MOV AH, 1
    
    ;INPUT1
    CALL INPUT
    MOV M, BX 
    
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
    MOV AH, 1
    
    ;INPUT2
    CALL INPUT
    MOV N, BX
            
    GCD:
    XOR DX, DX
    MOV AX, M
    DIV N 
    MOV BX, N
    CMP DX, 0
    JE GCD_FOUND    
    MOV M, BX
    MOV N, DX
    JMP GCD
    
        
    GCD_FOUND:
    
    MOV DX, BX
    AND BX, 0F000H
    MOV CL, 12
    SHR BX, CL
    CALL HEXCONV
    MOV CHAR1, BL 
    
    MOV BX, DX
    AND BX, 0F00H
    MOV CL, 8
    SHR BX, CL
    CALL HEXCONV
    MOV CHAR2, BL
    
    MOV BX, DX
    AND BX, 00F0H
    MOV CL, 4
    SHR BX, CL
    CALL HEXCONV
    MOV CHAR3, BL
    
    MOV BX, DX
    AND BX, 000FH
    CALL HEXCONV
    MOV CHAR4, BL
    
    
    LEA DX, MSG3
    MOV AH, 9
    INT 21H
    
    MOV AX, 4CH
    INT 21H
    MAIN ENDP

INPUT PROC
    PUSH AX
    PUSH CX
    PUSH DX
    XOR BX, BX
    
    INP:
    MOV AH, 1
    INT 21H              ;TAKES INPUT
    CMP AL, 0DH          ;CHECKS FOR CARRIAGE RETURN
    JE ENDINP            ;CARRIAGE RET MARKS THE END OF THE HEX NUMBER
    
    CMP AL, '9'
    JBE NOCON        
    CMP AL, 'A'
    JAE CONV
    
    ;CONVERTING FROM CHAR TO BINARY
    NOCON:
    AND AL, 0FH            ;LAST 4BITS ARE SIMILAR TO BINARY VALUE
    MOV CL, 4              ;COUNT FOR SHIFT
    SHL BX, CL
    OR BL, AL              ;CONCATENATES 4BITS AT A TIME
    JMP INP            
    
    CONV:
    AND AL, 0FH            ;TAKES BITS 0-3
    ADD AL, 9              ;ADDING 1001 CONVERTS HEX A-F TO BINARY
    MOV CL, 4
    SHL BX, CL
    OR BL, AL
    JMP INP
    
    ENDINP:
    
    POP DX
    POP CX
    POP AX
    RET
    INPUT ENDP

HEXCONV PROC
    PUSH AX
    PUSH CX
    PUSH DX
    
    CMP BL, 9           ;CHECKS FOR A-F
    JBE SKIP           ;SKIPS IF 0-9
    SUB BL, 9           ;SUBTRACTS SO THAT THE LAST 4 BITS
                             ;MATCH THE REQUIRED ASCII CODE
    OR BL, 01000000B    ;1ST 4-BITS OF BINARY SUM IS NOW
                             ;A-F'S ASCII CODE
    JMP HEX               
    SKIP:
    OR BL, 00110000B    ;CONVERTS 1ST 4-BITS OF BINARY SUM TO
                           ;CORRESPONDING HEX DIGIT'S ASCII CODE
    HEX:

    POP DX
    POP CX
    POP AX
    RET
    HEXCONV ENDP

END MAIN