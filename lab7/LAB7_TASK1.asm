.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'ENTER THE FIRST INTEGER: $'
    MSG2 DB 0DH, 0AH, 'ENTER THE SECOND INTEGER: $'
    MSG3 DB 0DH, 0AH, 'THEIR GCD IS $'
    DECI DB 10D
    M    DW ?
    N    DW ?
.CODE
MAIN PROC
              MOV  AX, @DATA
              MOV  DS, AX
    
              LEA  DX, MSG1
              MOV  AH, 9
              INT  21H          ;DISPLAYS MSG1
              MOV  AH, 1
    
    ;INPUT1
              CALL INPUTDEC
              MOV  M, BX        ;STORES THE FIRST INTEGER
    
              LEA  DX, MSG2
              MOV  AH, 9
              INT  21H          ;DISPLAYS MSG2
              MOV  AH, 1
    
    ;INPUT2
              CALL INPUTDEC
              MOV  N, BX        ;STORES THE SECOND INTEGER
            
    GCD:      
              XOR  DX, DX       ;CLEARS DX FOR DIV
              MOV  AX, M        ;STORES M AS DIVIDEND
              DIV  N            ;DIVIDES M BY N
              MOV  BX, N        ;STORES N IN REGISTER TO REPLACE M LATER
              CMP  DX, 0        ;IF REMAINDER=0, N IS GCD
              JE   GCD_FOUND
              MOV  M, BX        ;M IS REPLACED BY N
              MOV  N, DX        ;N IS REPLACED BY REMAINDER
              JMP  GCD          ;REPEATS IF GCD IS NOT FOUND
    
        
    GCD_FOUND:
              LEA  DX, MSG3
              MOV  AH, 9
              INT  21H          ;DISPLAYS MSG3
              CALL OUTPUTDEC
    
              MOV  AX, 4CH
              INT  21H
MAIN ENDP

INPUTDEC PROC                   ;PROC FOR GETTING DECIMAL INPUT IN HEX
              PUSH AX
              PUSH CX
              PUSH DX
              XOR  BX, BX
    
    INP:      
              XOR  CX, CX       ;CLEARS CX FOR NEXT INPUT
              MOV  AH, 1
              INT  21H          ;TAKES INPUT
              CMP  AL, 0DH      ;CHECKS FOR CARRIAGE RETURN
              JE   ENDINP       ;CARRIAGE RET MARKS THE END OF THE INTEGER
    
              AND  AL, 0FH      ;LAST 4BITS ARE ITS BINARY VALUE

              OR   CL, AL       ;NEW DIGIT IN CL
              MOV  AX, BX       ;PRECEDING DIGITS ARE
              MUL  DECI         ;MULTIPLIED BY 10D AND
              ADD  AX, CX       ;THE NEW DIGIT IS ADDED
              XOR  BX, BX
              OR   BX, AX       ;BX NOW CONTAINS PRESENT INPUT
              JMP  INP
    
    ENDINP:   
    ;OUTPUT IN BX
              POP  DX
              POP  CX
              POP  AX
              RET
INPUTDEC ENDP

OUTPUTDEC PROC                  ;PROC TO DISPLAY GCD IN DECIMAL
              PUSH AX
              PUSH CX
              PUSH DX
              MOV  AX, BX
              MOV  BX, 10D      ;USING DECI WASN'T WORKING
    ;SO I HAD TO USE A REGISTER
              XOR  CX, CX       ;CLEARS CX TO USE AS COUNTER
    
    OP:       
              XOR  DX, DX
              DIV  BX           ;HEX GCD IS DIV BY 10D
              PUSH DX           ;REMAINDER IS PUSHED INTO STACK
              INC  CX           ;CX COUNTS NO. OF DIGITS IN GCD
              CMP  AX, 0        ;CHECKS IF QUOTIENT=0
              JNE  OP
    
              MOV  AH, 2
    PRINT:    
              POP  DX
              OR   DL, 30H      ;CONVERTING TO ASCII
              INT  21H          ;DISPLAYS DIGIT OF GCD
              LOOP PRINT
    ;OUTPUT IN BX
              POP  DX
              POP  CX
              POP  AX
              RET
OUTPUTDEC ENDP

END MAIN