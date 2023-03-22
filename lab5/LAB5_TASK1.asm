.MODEL SMALL
.STACK 100H
.DATA
    MSG  DB 0DH,0AH,'$'
.CODE
MAIN PROC
             MOV AX, @DATA
             MOV DS, AX
    
             MOV AH, 2
             MOV DL, '?'
             INT 21H          ;DISPLAYS ?
    
             MOV AH, 1
             INT 21H
             MOV BH, AL       ;1ST LETTER
             INT 21H
             MOV BL, AL       ;2ND LETTER
    
             LEA DX, MSG
             MOV AH, 9
             INT 21H          ;MOVES TO THE NEXT LINE
    
             MOV AH, 2
             CMP BL, BH       ;COMPARES ASCII VALUES TO FIND THEIR ORDER
             JAE BH_FIRST
             JB  BL_FIRST
    
    BH_FIRST:
             MOV DL, BH
             INT 21H
             MOV DL, BL
             INT 21H
             JMP END_CASE
    
    BL_FIRST:
             MOV DL, BL
             INT 21H
             MOV DL, BH
             INT 21H
    
    END_CASE:
             MOV AX, 4CH
             INT 21H
             
MAIN ENDP
END MAIN
                      