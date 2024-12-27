
Include Irvine32.inc
include macros.inc


buffersize=501
BUFFER_SIZE22 = 5000
BUFFER_SIZE2o=5000
.data
str11 BYTE " wrong choice enter again",0
contine BYTE " do you want to continue again, press 1 ",0
thankyou BYTE " ok thank you....",0
str2 BYTE "------------------------------------------ENTER DETAILS--------------------------------------------",0
enterbat  BYTE "Batsman Details: ",0
n    BYTE "Name:",0
m    BYTE "Matches:",0
r    BYTE "Total Runs:",0
d    BYTE "No. of time Dismissals:",0
b    BYTE "No. of Ball faced:",0
strkrate BYTE " strike rate: ",0
averagesb BYTE " average: ",0  

enterbol  BYTE "Bowler Details: ",0
n1    BYTE "Name:",0
m1    BYTE "Matches:",0
r1    BYTE "Total Runs:",0
w1    BYTE "No. of Wickets taken:",0
o1    BYTE "No.of Overs done:",0
bowler_a BYTE " average: ",0
bowl_ec BYTE " economy: ",0  

batsmanName byte buffersize  dup(?)
matches dword ?
runs word ?
dismissals byte ?
ballsFaced       byte ?
bavg             real4 ?
strikeratebat    real4 ?    

bowlerName       BYTE buffersize DUP(?)
matches_bowler   DWORD ?
runs_bowler      WORD ?
wickets          byte ?
overs           byte ?
bowleravg REAL4 ?
economy  REAL4  ?

;team
str_matches_team byte "enter matches played ",0
str_team_win byte "enter team win ",0
str_team_catches byte "enter team catches attempt or miss ",0
str_catches_attempt byte "enter catches attempt ",0
str_team_win_per byte " win percentage for this team is ",0
str_catch_efficiency byte " catch efficiency for this team is ",0

select DWORD ?
sizee_count dword 2

win_percentage REAL4 lengthof sizee_count  dup(?)

catch_effiecency REAL4  lengthof sizee_count dup(?)
matches_team byte ?
team_win word ?
team_catches byte ?
catches_attempt word ?

val22 dword ?
val23 dword 1
teamss byte " enter team detail ",0
swap dword ?
i dword ?
rate_win_perc  byte " rating win percentages of all teams ",0
counter dword ?

buffer BYTE BUFFER_SIZE2o DUP(?)
filename1 BYTE "output_options.txt",0
fileHandle2 HANDLE ?


;rating
s25 byte " - bad rating",0
s50 byte " - better rating",0
s75 byte " - good rating",0
s100 byte " - best rating",0


filename byte "player_details.txt",0
filehandle handle ?
stringlength dword ?
extras byte 10

stringlength2 dword ?

buffer22 BYTE BUFFER_SIZE2o DUP(?)
filename4 BYTE "team_data_options.txt",0
fileHandle4 HANDLE ?

team_str byte "team details: ",0
team_calc byte "team ",0
val_calc byte 'a'


.code

batsman_data PROC


 mov edx,offset filename
call createoutputfile
mov filehandle,eax


mov edx,offset enterbat
mov ecx,lengthof enterbat
call writetofile

mov edx,offset enterbat
call writestring
call crlf

mov eax,filehandle
mov edx,offset extras
mov ecx,lengthof extras
call writetofile

mov eax,filehandle
mov edx,offset n
mov ecx,lengthof n
call writetofile

mov edx,offset n
call writestring
 
mov ecx,buffersize  
mov edx,offset batsmanName
call readstring
mov stringlength,eax 

mov eax,filehandle
mov edx,offset batsmanName
mov ecx,stringlength
call writetofile

mov eax,filehandle
mov edx,offset extras
mov ecx,lengthof extras
call writetofile
invoke CloseHandle, filehandle

mov edx,offset m
call writestring
call Readdec
mov matches,eax



mov edx,offset r
call writestring
call readdec
mov runs,ax



mov edx,offset d
call writestring
call readdec
mov dismissals,al

mov edx,offset b
call writestring
call Readdec
mov ballsFaced,al



;calculate average and strikerate of batsman
;bavg=runs/dismissals

mov eax,0
mov ecx,0
mov ax ,runs
movzx bx,dismissals
div bl
movzx ecx,al
mov bavg,ecx
call crlf
mov edx, offset averagesb
call writestring
mov eax,bavg
call writehex ; because of float value
call crlf

;strikerate=(runs/no.of ball faced)*100
mov bl,ballsFaced
mov eax,0
mov ax,runs
div bl
mov ecx,0
mov cl,100
mul  cl
call crlf
mov edx,0
movzx edx,ax
mov strikeratebat,edx
call crlf
mov edx, offset strkrate
call writestring
mov eax,strikeratebat
call writehex ; because of float value

call crlf
call crlf



ret 
batsman_data endp


bowler_data PROC
mov stringlength2,0
invoke CreateFile, offset filename, FILE_APPEND_DATA or GENERIC_WRITE, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
mov filehandle, eax
invoke SetFilePointer, filehandle, 0, 0, FILE_END

mov eax,filehandle
mov edx,offset extras
mov ecx,lengthof extras
call writetofile

mov eax, filehandle
 mov edx, offset extras
 mov ecx, lengthof extras
call WriteToFile


mov eax, filehandle
mov edx,offset enterbol
call writestring
mov ecx, lengthof enterbol
call WriteToFile

call crlf

mov eax,filehandle
mov edx,offset extras
mov ecx,lengthof extras
call writetofile


mov edx,offset n1
call writestring
mov eax,filehandle
mov ecx,lengthof n1
call writetofile

mov ecx,buffersize 
mov edx,OFFSET bowlerName
call Readstring
mov stringlength2,eax

 mov eax, filehandle
  mov edx, offset bowlerName
  mov ecx, stringlength2
 call WriteToFile

 mov eax, filehandle
 mov edx, offset extras
 mov ecx, lengthof extras
call WriteToFile
 invoke CloseHandle, filehandle

mov edx,offset m1
call writestring
mov edx, OFFSET matches
call Readdec
mov eax,matches_bowler
mov edx,offset r1
call writestring
mov eax,0
call Readdec
mov runs_bowler,ax
mov edx,offset w1
call writestring
mov eax,0
call Readdec
mov wickets,al
mov edx,offset o1
call writestring
call Readdec
mov overs ,al

;average=runs/wickets
mov eax,0
mov ecx,0
mov ax,runs_bowler
mov bl,wickets
div bl
movzx ecx,al
mov bowleravg,ecx
call crlf
mov edx, offset bowler_a
call writestring
mov eax,bowleravg
call writehex ; because of float value

;economy=runs/overs
mov eax,0
mov ax,runs_bowler
mov bl,overs
div bl
mov edx,0
movzx edx,ax
mov economy,edx
call crlf
mov edx, offset bowl_ec 
call writestring
mov eax,economy
call writehex ; because of float value
call crlf



ret
bowler_data ENDP

calculate_team PROC
call crlf
mov eax,0
mov edx,offset str_matches_team
call writestring
call readdec
mov matches_team,al
mov eax,0
call crlf
mov edx,offset str_team_win
call writestring
call readdec
mov team_win,ax
mov eax,0
call crlf
mov edx,offset str_team_catches
call writestring
call readdec
mov team_catches,al
mov eax,0
call crlf
mov edx,offset str_catches_attempt
call writestring
call readdec
mov catches_attempt,ax
mov eax,0
call crlf

;win per=(win *100/matches)
mov eax,0
mov ax,team_win
mov ecx,0
mov cx,100
mul cx
mov ebx,0
mov bl,matches_team
div bl
call crlf
mov edx,0
movzx edx,ax
mov win_percentage[esi],edx
call crlf
mov edx, offset str_team_win_per
call writestring
mov eax,win_percentage[esi]
call writehex
call crlf




;catch eff=(catches attempt/catches)*100
mov eax,0
mov ax,catches_attempt
mov ecx,0
mov cx,100
mul cx
mov ebx,0
mov bl,team_catches
div bl

call crlf
mov edx,0
movzx edx,ax
mov catch_effiecency[edi],edx
call crlf
mov edx, offset str_catch_efficiency
call writestring
mov eax,catch_effiecency[edi]
call writehex
call crlf


ret
calculate_team endp


printed2 PROC
invoke CreateFile, offset filename, FILE_APPEND_DATA or GENERIC_WRITE, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
mov filehandle, eax
invoke SetFilePointer, filehandle, 0, 0, FILE_END
mov eax, filehandle
mov edx,offset extras
mov ecx,lengthof extras
call writetofile
mov eax, filehandle
 mov edx, offset team_calc
 mov ecx, lengthof team_calc
call WriteToFile
mov eax, filehandle
 mov edx, offset val_calc
 mov ecx, lengthof val_calc
call WriteToFile
 mov edx,offset extras
mov ecx,lengthof extras
call writetofile
invoke CloseHandle, filehandle
inc val_calc
ret
printed2 ENDP

team_data PROC

mov eax,0
mov edx,OFFSET filename4
call OpenInputFile
mov fileHandle4,eax

                                                                                                                                                                                                                                                                                                                                                                  mov ecx,sizeof filename1
mov edx,OFFSET buffer22
mov ecx,BUFFER_SIZE2o
call ReadFromFile

mov edx,OFFSET buffer22 ; display the buffer
call WriteString
call Crlf

mov eax,fileHandle4
call CloseFile



mov edx,0
mov eax,0
mov ecx,0
mov ebx,0

mov ecx,sizee_count
mov esi,0
mov edi,0
l2:
mov val22,ecx
mov edx,offset teamss
call writestring
mov eax,val23
call writedec
call crlf
call calculate_team
add esi,4
add edi,4
inc val23
call crlf
call crlf
mov matches_team ,0
mov team_win ,0
mov team_catches,0
mov catches_attempt,0 
mov ecx,val22
loop l2



invoke CreateFile, offset filename, FILE_APPEND_DATA or GENERIC_WRITE, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
mov filehandle, eax
invoke SetFilePointer, filehandle, 0, 0, FILE_END
mov edx,offset rate_win_perc
call writestring
mov eax, filehandle
 mov edx, offset extras
 mov ecx, lengthof extras
call WriteToFile

mov eax, filehandle
 mov edx, offset team_str
 mov ecx, lengthof team_str
call WriteToFile

mov eax, filehandle
 mov edx, offset extras
 mov ecx, lengthof extras
call WriteToFile

mov eax, filehandle
 mov edx, offset rate_win_perc
 mov ecx, lengthof rate_win_perc
call WriteToFile
mov eax, filehandle
 mov edx, offset extras
 mov ecx, lengthof extras
call WriteToFile
 invoke CloseHandle, filehandle

 mov edx,offset rate_win_perc
call writestring
 mov esi,0
 mov ecx,sizee_count
call crlf

printt:
push ecx
call printed2

 call printed
 add esi,4
 pop ecx
 loop printt
 
ret
team_data ENDP

printed PROC

invoke CreateFile, offset filename, FILE_APPEND_DATA or GENERIC_WRITE, FILE_SHARE_READ, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
mov filehandle, eax
invoke SetFilePointer, filehandle, 0, 0, FILE_END
mov eax,filehandle
mov edx,offset extras
mov ecx,lengthof extras
call writetofile
mov eax,win_percentage[esi]
  cmp eax,25
 jle r25
 cmp eax,50
 jle r50
 cmp eax,75
 jle r75
 cmp eax,100
 jle r100
r25:
 call writedec
    mov edx, OFFSET s25
	mov ecx, lengthof s25
    
    jmp printRating
r50:
 call writedec
mov edx, OFFSET s50
 mov ecx, lengthof s50   
    jmp printRating
r75:
 call writedec
    mov edx, OFFSET s75
 mov ecx, lengthof s75   
    jmp printRating
r100:
 call writedec
 mov ecx, lengthof s75
    mov edx, OFFSET s100
printRating:
mov eax,0
call writestring
mov eax,filehandle
call writetofile
 call crlf
  invoke CloseHandle, filehandle
ret
printed endp

main PROC

againn:

mov edx,OFFSET filename1
call OpenInputFile
mov fileHandle2,eax

                                                                                                                                                                                                                                                                                                                                                                  mov ecx,sizeof filename1
mov edx,OFFSET buffer
mov ecx,BUFFER_SIZE2o
call ReadFromFile

mov edx,OFFSET buffer ; display the buffer
call WriteString
call Crlf

mov eax,fileHandle2
call CloseFile




call readdec
call crlf
call crlf
mov edx,offset str2
call writestring
call crlf
call crlf
CMP eax,1
jne next
call batsman_data
jmp exii3

;bowler
next:
CMP eax,2
jne nnext
call bowler_data
jmp exii3

nnext:
cmp eax,3
jne wrongg
call team_data
jmp exii3

wrongg:
mov edx,offset str11
call writestring
call crlf
call crlf
jmp againn

exii3:
call crlf
mov edx,offset contine
call writestring 
call readdec
cmp eax,1
je againn

exii:
mov edx,offset thankyou
call writestring 
exit 
main ENDP 
END main

