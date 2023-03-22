.MODEL SMALL
.STACK 100H
.DATA
  MSG1  DB 'TYPE A BINARY NUMBER, UP TO 16 DIGITS: $'
  MSG2  DB 0DH, 0AH, 'IN HEX IT IS '
  CHAR1 DB ?
  CHAR2 DB ?
  CHAR3 DB ?
  CHAR4 DB ?,'h$'
.CODE
MAIN PROC
           MOV  AX, @DATA
           MOV  DS, AX
    
           LEA  DX, MSG1
           MOV  AH, 9
           INT  21H               ;DISPLAYS MSG1
    
           MOV  CX, 16            ;LOOP COUNT
           MOV  BX, 0             ;INITIALIZATION
           MOV  AH, 1
  INPUT:   
           INT  21H               ;INPUT
           CMP  AL, 0DH           ;CHECKS FOR CARRIAGE RETURN
           JE   ENDINPUT          ;JUMPS OUT OF LOOP
           SHL  BX, 1             ;MAKES SPACE FOR NEW INPUT
           CMP  AL,'1'
           JE   INPUT1
           JMP  INPUT0
  INPUT1:                         ;STORES 1 IN BIT 0 OF BX
           OR   BX, 1
  INPUT0:                         ;LEAVES 0 IN BIT 0 OF BX
           LOOP INPUT
    
  ENDINPUT:
           MOV  DX, BX            ;STORES INPUT IN BINARY
           MOV  CL, 4             ;COUNTER FOR SHIFT
           SHR  BH, CL            ;SHIFTS BITS TO THE RIGHT SO THAT
  ;ONLY BITS WE'LL BE CONVERTING TO
  ;HEX ARE STORED INTO VARIABLES
  ;4 BITS WILL BE CONVERTED AT A TIME
           MOV  CHAR1, BH         ;FIRST 4 BITS ARE STORED IN CHAR1
           CMP  CHAR1, 9          ;CHECKS FOR A-F
           JBE  HEXSKIP1          ;SKIPS IF 0-9
           SUB  CHAR1, 9          ;SUBTRACTS SO THAT THE LAST 4 BITS
  ;MATCH THE REQUIRED ASCII CODE
           OR   CHAR1, 01000000B  ;1ST 4-BITS OF BINARY INPUT IS NOW
  ;A-F'S ASCII CODE
           JMP  HEX1
  HEXSKIP1:
           OR   CHAR1, 00110000B  ;CONVERTS 1ST 4-BITS OF BINARY INPUT TO
  ;CORRESPONDING HEX DIGIT'S ASCII CODE
  HEX1:    
    
           MOV  BX, DX            ;INITIALIZATION FOR CONVERSION
           AND  BH, 0FH           ;BITS 4-7 OF BH ARE MADE 0
           MOV  CHAR2, BH         ;CHAR2 CONTAINS 2ND 4BITS OF INPUT
           CMP  CHAR2, 9
           JBE  HEXSKIP2
           SUB  CHAR2, 9
           OR   CHAR2, 01000000B
           JMP  HEX2
  HEXSKIP2:
           OR   CHAR2, 00110000B
  HEX2:    
    
           MOV  BX, DX
           AND  BX, 00F0H         ;BITS 0-3 ARE MADE 0
           MOV  CL, 4
           SHR  BL, CL
           MOV  CHAR3, BL         ;CHAR3 CONTAINS 3RD 4BITS OF INPUT
           CMP  CHAR3, 9
           JBE  HEXSKIP3
           SUB  CHAR3, 9
           OR   CHAR3, 01000000B
           JMP  HEX3
  HEXSKIP3:
           OR   CHAR3, 00110000B
  HEX3:    
     
           MOV  BX, DX
           AND  BX, 000FH         ;LAST 4BITS REMAIN
           MOV  CHAR4, BL         ;CHAR4 CONTAINS LAST 4BITS OF INPUT
           CMP  CHAR4, 9
           JBE  HEXSKIP4
           SUB  CHAR4, 9
           OR   CHAR4, 01000000B
           JMP  HEX4
  HEXSKIP4:
           OR   CHAR4, 00110000B
  HEX4:    
    
    
           LEA  DX, MSG2
           MOV  AH, 9
           INT  21H               ;DISPLAYS MSG2
    
           MOV  AH,4CH
           INT  21H
    
MAIN ENDP
END MAIN    