.MODEL SMALL
 DATA SEGMENT
PromptStr DB 'Enter a word with 10 letters or less to end enter the dollar sign:',13,10,'$'
WORD DB '_','_','_','_','_','_','_','_','_','_','$'
GUESS DB '_',' ','_',' ','_',' ','_',' ','_',' ','_',' ','_',' ','_',' ','_',' ','_','$' 
WINOUTPUT DB 'You won','$'  
LOSTOUTPUT DB 'You lost','$'
ATTEMPTS DB ' Attempts left','$'  
 DATA ENDS
 CODE SEGMENT
 ASSUME CS:CODE, DS: DATA
 MOV AX,DATA
 MOV DS,AX
 MOV AH,9          
 MOV DX,OFFSET PromptStr     
 INT 21h 
 MOV SI,OFFSET WORD
 MOV DI,OFFSET GUESS
 MOV CL,0
LOOPINPUT:
 INC CL
 MOV AH,1     
 INT 21h 
 MOV [SI],AL
 INC SI
 CMP AL,'$'
 JE END_INPUT
 ADD DI,2
CMP CL,10
JNE LOOPINPUT 
END_INPUT: 
 MOV [DI],'$' 
 MOV CL,9
LOOP1: 
 SUB CL,1
 MOV DL, 10
 MOV AH,2
 INT 21h
 MOV DL, 13
 MOV AH,2
 INT 21h
 MOV AH,9          
 MOV DX,OFFSET GUESS     
 INT 21h
 MOV DL, 10
 MOV AH,2
 INT 21h
 MOV DL, 13
 MOV AH,2
 INT 21h
 MOV SI,OFFSET WORD
 MOV DI,OFFSET GUESS
 MOV AH,1     
 INT 21h 
LOOP2: 
 CMP [SI],AL
 JNE NOTCORRECT
CORRECT:
 MOV [DI],AL
 JMP NOTCORRECT 
NOTCORRECT:
 INC SI
 ADD DI,2  
CMP [SI],'$'  
JNE LOOP2
 MOV SI,OFFSET WORD
 MOV DI,OFFSET GUESS 
LOOP3:
 MOV AL,[DI]
 CMP [SI],AL
 JNE CHECK
 INC SI
 ADD DI,2
CMP [SI],'$'  
JNE LOOP3
 JMP WIN
CHECK:
 MOV DL, 10
 MOV AH,2
 INT 21h
 MOV DL, 13
 MOV AH,2
 INT 21h    
 MOV AH,9  
 MOV AL,CL
 ADD AL,'0'
 MOV DL, AL
 MOV AH,2
 INT 21h
 MOV AH,9          
 MOV DX,OFFSET ATTEMPTS      
 INT 21h
CMP CL,0
JNE LOOP1
JMP LOST     
WIN:
 MOV DL, 10
 MOV AH,2
 INT 21h
 MOV DL, 13
 MOV AH,2
 INT 21h    
 MOV AH,9          
 MOV DX,OFFSET WINOUTPUT      
 INT 21h
 JMP END        
LOST: 
 MOV DL, 10
 MOV AH,2
 INT 21h
 MOV DL, 13
 MOV AH,2
 INT 21h
 MOV AH,9          
 MOV DX,OFFSET LOSTOUTPUT     
 INT 21h  
END:    
 MOV AH,4Ch
 INT 21h
 CODE ENDS