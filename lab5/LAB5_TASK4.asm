.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 0DH, 0AH, 'ENTER A HEX DIGIT: $'
    MSG2 DB 0DH, 0AH, 'IN DECIMAL IT IS: $'
    MSG3 DB 0DH, 0AH, 'IN DECIMAL IT IS: 1$'
    MSG4 DB 0DH, 0AH, 'DO YOU WANT TO DO IT AGAIN? $'
    MSG5 DB 0DH, 0AH, 'PLEASE TRY AGAIN$'
    MSG6 DB 0DH, 0AH, 'THE PROGRAM WILL NOW TERMINATE$'
.CODE
MAIN PROC
               MOV AX, @DATA
               MOV DS, AX
               MOV CX, 0         ;COUNTER FOR INVALID TRIES
    
    PROG:      
               LEA DX, MSG1
               MOV AH, 9
               INT 21H           ;DISPLAYS MSG1
    
               MOV AH, 1
               INT 21H           ;INPUT
               MOV BL, AL
    
    ;CHECKS IF INPUT IS LEGAL
               CMP BL, '0'
               JB  INVALID
               CMP BL, '9'
               JBE NOCON         ;JUMPS IF CONVERSION IS NOT NEEDED
               CMP BL, 'A'
               JB  INVALID
               CMP BL, 'F'
               JBE CONV          ;JUMPS IF CONVERSION IS NEEDED
    
    INVALID:   
               INC CX
               CMP CX, 3
               JAE TERMINATE     ;TERMINATES PROCESS IF MORE THAN 3 TRIES FAIL
               LEA DX, MSG5
               MOV AH, 9
               INT 21H           ;DISPLAYS MSG5
               JMP PROG
    
    TERMINATE: 
               LEA DX, MSG6
               MOV AH, 9
               INT 21H
               JMP END_PROG
    
    CONV:      
               SUB BL,11H
               LEA DX, MSG3
               JMP PRINT_CHAR
    NOCON:     
               LEA DX, MSG2
    PRINT_CHAR:
               MOV CX, 0         ;RESETS COUNTER AFTER A SUCCESSFUL INPUT
               MOV AH, 9
               INT 21H           ;DISPLAYS MSG2 OR MSG3
               MOV AH, 2
               MOV DL, BL
               INT 21H           ;DISPLAYS BL
    
               LEA DX, MSG4
               MOV AH, 9         ;DISPLAYS MSG4
               INT 21H
               MOV AH, 1
               INT 21H           ;INPUT
    
               CMP AL, 'Y'
               JE  PROG
               CMP AL, 'y'
               JE  PROG
    
    END_PROG:  
               MOV AX, 4CH
               INT 21H
               
MAIN ENDP
END MAIN
