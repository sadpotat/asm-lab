.MODEL SMALL
.STACK 100H
.DATA
    MSG  DB 0DH,0AH,'$'
.CODE
MAIN PROC
               MOV  AX, @DATA
               MOV  DS, AX
    
               MOV  BL, 80H       ;INITIALIZATION
    
    PRINT_CHAR:
               MOV  AH,2
               MOV  CX, 10        ;COUNT FOR LOOP
    
    PRINT_LINE:
               CMP  BL,0          ;CHECKS IF BL EXCEEDS FFh
               JE   END_PRINT
               MOV  DL, BL
               INT  21H           ;DISPLAYS CHARACTER
               MOV  DL, ' '
               INT  21H           ;DISPLAYS A BLANK SPACE
               INC  BL
               LOOP PRINT_LINE    ;PRINTS 10 CHARACTERS IN A LINE
    
               LEA  DX, MSG
               MOV  AH, 9
               INT  21H           ;MOVES TO THE NEXT LINE
               CMP  BL,0
               JNE  PRINT_CHAR    ;MOVES TO THE NEXT LINE
     
    END_PRINT: 
               MOV  AX, 4CH
               INT  21H
               
MAIN ENDP
END MAIN

    
    
    
    