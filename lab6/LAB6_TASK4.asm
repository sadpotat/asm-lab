.MODEL SMALL
.STACK 100H
.DATA
  MSG1  DB 'ENTER A DECIMAL DIGIT STRING $'
  MSG2  DB 0DH,0AH, 'THE SUM OF THE DIGITS IN HEX IS '
  CHAR1 DB ?
  CHAR2 DB ?
  CHAR3 DB ?
  CHAR4 DB ?,'$'
  MSG3  DB 0DH, 0AH, 'PLEASE TRY AGAIN', 0DH, 0AH,'$'
.CODE
MAIN PROC
             MOV AX, @DATA
             MOV DS, AX
    
  STARTAGAIN:
             LEA DX, MSG1
             MOV AH, 9
             INT 21H
    
  INPUT:     
             MOV AH, 1
             INT 21H
             CMP AL, 0DH
             JE  ENDINPUT
             CMP AL, '0'
             JB  INVALID
             CMP AL, '9'
             JA  INVALID
             JMP VALID
    
  INVALID:   
             LEA DX, MSG3
             MOV AH, 9
             INT 21H
             XOR BX, BX
             JMP STARTAGAIN
    
  VALID:     
             AND AX, 000FH
             ADD BX, AX
             JMP INPUT
    
  ENDINPUT:  
    
  ;CONVERTING FROM BINARY TO HEX CHAR
             MOV DX, BX            ;STORES SUM IN BINARY
             MOV CL, 4             ;COUNTER FOR SHIFT
             SHR BH, CL            ;SHIFTS BITS TO THE RIGHT SO THAT
  ;ONLY BITS WE'LL BE CONVERTING TO
  ;HEX ARE STORED INTO VARIABLES
  ;4 BITS WILL BE CONVERTED AT A TIME
             MOV CHAR1, BH         ;FIRST 4 BITS ARE STORED IN CHAR1
             CMP CHAR1, 9          ;CHECKS FOR A-F
             JBE HEXSKIP1          ;SKIPS IF 0-9
             SUB CHAR1, 9          ;SUBTRACTS SO THAT THE LAST 4 BITS
  ;MATCH THE REQUIRED ASCII CODE
             OR  CHAR1, 01000000B  ;1ST 4-BITS OF BINARY SUM IS NOW
  ;A-F'S ASCII CODE
             JMP HEX1
  HEXSKIP1:  
             OR  CHAR1, 00110000B  ;CONVERTS 1ST 4-BITS OF BINARY SUM TO
  ;CORRESPONDING HEX DIGIT'S ASCII CODE
  HEX1:      
    
             MOV BX, DX            ;INITIALIZATION FOR CONVERSION
             AND BH, 0FH           ;BITS 4-7 OF BH ARE MADE 0
             MOV CHAR2, BH         ;CHAR2 CONTAINS 2ND 4BITS OF SUM
             CMP CHAR2, 9
             JBE HEXSKIP2
             SUB CHAR2, 9
             OR  CHAR2, 01000000B
             JMP HEX2
  HEXSKIP2:  
             OR  CHAR2, 00110000B
  HEX2:      
    
             MOV BX, DX
             AND BX, 00F0H         ;BITS 0-3 ARE MADE 0
             MOV CL, 4
             SHR BL, CL
             MOV CHAR3, BL         ;CHAR3 CONTAINS 3RD 4BITS OF SUM
             CMP CHAR3, 9
             JBE HEXSKIP3
             SUB CHAR3, 9
             OR  CHAR3, 01000000B
             JMP HEX3
  HEXSKIP3:  
             OR  CHAR3, 00110000B
  HEX3:      
     
             MOV BX, DX
             AND BX, 000FH         ;LAST 4BITS REMAIN
             MOV CHAR4, BL         ;CHAR4 CONTAINS LAST 4BITS OF SUM
             CMP CHAR4, 9
             JBE HEXSKIP4
             SUB CHAR4, 9
             OR  CHAR4, 01000000B
             JMP HEX4
  HEXSKIP4:  
             OR  CHAR4, 00110000B
  HEX4:      
    
             LEA DX, MSG2
             MOV AH, 9
             INT 21H
    
             MOV AX, 4CH
             INT 21H
    
MAIN ENDP
END MAIN