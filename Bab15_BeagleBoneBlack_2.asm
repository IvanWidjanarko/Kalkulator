INPUT	EQU P1
SEVSEG	EQU P0
DATA1	EQU 0
DATA2	EQU 1
DATA3	EQU 2
MODE	EQU 6 
ANGKA:	DB 0C0H ;0
	DB 0F9H ;1
	DB 0A4H ;2
	DB 0B0H ;3
	DB 099H ;4
	DB 092H ;5
	DB 082H ;6
	DB 0F8H ;7
	DB 080H ;8
	DB 090H ;9
	DB 0FFH ;LED MATI SEMUA

	ORG 00H
	MOV DPTR,#ANGKA		;Simpan alamat
RESET:	MOV DATA1,#0FFH
	MOV DATA2,#0FFH
	MOV DATA3,#0FFH
	MOV MODE,#0FFH

IDLE:	MOV INPUT,#0FFH
	CLR INPUT.0
	JNB INPUT.4,SATU
	JNB INPUT.5,DUA
	JNB INPUT.6,TIGA
	JNB INPUT.7,AA
	SETB INPUT.0
	CLR INPUT.1
	JNB INPUT.4,EMPAT
	JNB INPUT.5,LIMA
	JNB INPUT.6,ENAM
	JNB INPUT.7,BB
	SETB INPUT.1
	CLR INPUT.2
	JNB INPUT.4,TUJUH
	JNB INPUT.5,LAPAN
	JNB INPUT.6,SEMBIL
	JNB INPUT.7,CC
	SETB INPUT.2
	CLR INPUT.3
	JNB INPUT.4,TITIK
	JNB INPUT.5,NOL
	JNB INPUT.6,PAGER
	JNB INPUT.7,DD
	SETB INPUT.3
	MOV A,#10
	ACALL WRITE
	SJMP IDLE

NOL:	MOV A, #0
	SJMP SERIAL
SATU:	MOV A, #1
	SJMP SERIAL
DUA:	MOV A, #2
	SJMP SERIAL
TIGA:	MOV A, #3
	SJMP SERIAL
EMPAT:	MOV A, #4
	SJMP SERIAL
LIMA:	MOV A, #5
	SJMP SERIAL
ENAM:	MOV A, #6
	SJMP SERIAL
TUJUH:	MOV A, #7
	SJMP SERIAL
LAPAN:	MOV A, #8
	SJMP SERIAL
SEMBIL:	MOV A, #9
	SJMP SERIAL
AA:	MOV R6,#01H
	SJMP BEK
BB:	MOV R6,#02H
BEK:	MOV A,#10
	ACALL WRITE
	JMP IDLE
CC:	
DD:	SJMP EQUAL
TITIK:
PAGER: 	ACALL WRITE
	JMP IDLE

WRITE:	MOVC A,@A+DPTR
	MOV P2,#0FFH
	MOV SEVSEG,#0FFH
	CLR P2.0
	MOV SEVSEG,#0FFH
	MOV SEVSEG,#0FFH
	MOV SEVSEG,A
	RET
	
SERIAL:	CJNE R6,#0FFh,ite2
ite1:	MOV DATA1, A
	ACALL WRITE
	JMP IDLE
ite2:	MOV DATA2, A
	ACALL WRITE
	JMP IDLE
	
EQUAL:	MOV A,DATA1
	CJNE R6,#02h,tambah
kurang:	SUBB A,DATA2
	SJMP hasil
tambah:	CJNE R6,#01h,hendi
	ADD A,DATA2

hasil:	MOV DATA3, A
	MOVC A,@A+DPTR
	MOV P2,#0FFH
	MOV SEVSEG,#0FFH
	CLR P2.2
	MOV SEVSEG,#0FFH
	MOV SEVSEG,A
	MOV P2,#0FFH

hendi:	MOV R6,#0FFH
	JMP RESET

END