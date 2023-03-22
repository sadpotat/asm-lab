.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 'TYPE A CHARACTER: $'
    MSG2 DB 0DH, 0AH, 'ASCII CODE OF '
    CHAR DB ?,' IN BINARY IS $'
    MSG3 DB 0DH, 0AH, 'THE NUMBER OF 1 BITS IS '
    NUM  DB ?,'$'
.CODE
MAIN PROC
               MOV  AX, @DATA
               MOV  DS, AX
    
               LEA  DX, MSG1
               MOV  AH, 9
               INT  21H           ;DISPLAYS MSG1
               MOV  AH, 1
               INT  21H           ;INPUT
    
               MOV  BL, AL        ;STORES INPUT IN REGISTER BL
               MOV  BH, 0         ;COUNTER FOR NO. OF 1 BITS
               MOV  CHAR, AL      ;STORES INPUT IN CHAR VARIABLE
               LEA  DX, MSG2
               MOV  AH, 9
               INT  21H           ;DISPLAYS MSG2
    
               MOV  CX, 8         ;COUNTER FOR LOOP
               MOV  AH, 2
    ASCII:     
    ;LOOP FOR DISPLAYING ASCII AND COUNTING 1 BITS
               RCL  BL, 1         ;ROTATES BITS TO THE LEFT THROUGH CARRY
               JC   CARRY1        ;JUMPS IF THERE IS CARRY
               MOV  DL, '0'
               INT  21H           ;DISPLAYS 0
               JMP  SKIP_CARRY
    CARRY1:                       ;DISPLAYS 1 IF THERE IS CARRY
               MOV  DL, '1'
               INT  21H
               INC  BH
    SKIP_CARRY:                   ;JUMP HERE IF THERE IS NO CARRY
               LOOP ASCII
               ADD  BH, '0'       ;CONVERTS NUM TO CHAR
               MOV  NUM, BH       ;STORES NO. OF 1'S IN NUM VARIABLE
    
               LEA  DX, MSG3
               MOV  AH, 9
               INT  21H           ;DISPLAYS MSG3
    
               MOV  AH,4CH
               INT  21H

MAIN ENDP
END MAIN
    
    
    
    
    