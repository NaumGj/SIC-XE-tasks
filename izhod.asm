
IZHOD	START	0
		CLEAR	X
		LDA		chara
		JSUB	echoch
		JSUB	echonl
		ADD		#1
		JSUB	echoch
		JSUB	echonl
		LDA		#addr
		JSUB	echostr
		LDA		number
		JSUB	echonum
		JSUB	echonl
halt    J      	halt
		END		IZHOD

echoch	TD		stdout
		JEQ		echoch
		WD		stdout
		RSUB

. dirties A
echonl	STA 	olda
		LDA		newline
test2	TD		stdout
		JEQ		test2
		WD		stdout
		LDA		olda
		RSUB

echostr	STA 	olda
		STA		posred
loop3	LDA		@posred
		. ce je niz 0, to pomeni da se niz zakljuci
		COMP 	#0
		JEQ		out2
		. izpisemo char
		TD		stdout
		JEQ		loop3
		WD		stdout
		. povecamo naslov za 1 besedo (3 byte)
		LDA 	posred
		ADD 	#3
		STA 	posred
		J 		loop3
out2	LDA		olda
		RSUB

.echonu	STA 	olda
.		STS 	olds
.		STT 	oldt
.		STX 	oldx
.		LDS		#1
.		LDT		ten
.loop1	MULR	T, S
.		COMPR	S, A
.		JLT		loop1
.loop2	LDT		#1
.		COMPR	S, T
.		JEQ		out
.		LDT		ten
.		DIVR	T, S
.		RMO		A, X
.		DIVR	S, A
.		ADD		gonum
.test3	TD		stdout
.		JEQ		test3
.		WD		stdout
.		SUB 	gonum
.		MULR	S, A
.		SUBR	A, X
.		RMO		X, A
.		J 		loop2
.out		LDA		olda
.		LDS		olds
.		LDT		oldt
.		LDX		oldx
.		RSUB

.dirties A, T, S and X
echonum	STA 	olda
		STS 	olds
		STT 	oldt
		STX 	oldx
		. stevilko delimo z 10 in shranjujemo njene stevke v pomnilniku
izloci	LDS		#10
		RMO		A, T
		DIVR	S, A
		. ce je kvocient deljenja 0, gremo ven
		COMP 	#0
		JEQ		out

		. izracunamo stevko in jo shranimo
		MULR	A, S
		RMO		T, A
		SUBR	S, A
		STA		rez, X
		RMO		T, A
		LDS		#10
		DIVR	S, A
		. X register je za indeks
		LDT 	#3
		ADDR 	T, X
		J 		izloci
		. shranimo se zadnjo ostalo stevko (prva stevka v stevilu)
out 	STT 	rez, X
		LDT 	#3
		ADDR 	T, X
		. se sprehodimo po tabele od nazaj proti naprej in izpisujemo stevke
		. pri tem se pomagam z indeksnim registrom X
izpis	LDT		#3
		SUBR 	T, X
		LDA		rez, X
		. dodam 48 da pridem do ASCII kode stevil
		ADD		gonum
test4	TD		stdout
		JEQ		test4
		WD		stdout
		. nato 48 odstejem
		SUB 	gonum
		LDT		#0
		COMPR	X, T
		. ce je X = 0, smo izpisali vse
		JEQ		out3
		J 		izpis

out3	LDA		olda
		LDS		olds
		LDT		oldt
		LDX		oldx
		RSUB

stdout	BYTE	X'01'
newline	WORD	10
chara	WORD	65
olda	RESW	1
olds	RESW	1
oldt	RESW	1
oldx	RESW	1
number	WORD	X'375F00'
ten		WORD	X'00000A'
gonum	WORD	X'000030'
naslov	WORD	X'0000DE'
addr	EQU		*	
str		WORD	83
		WORD	73
		WORD	67
		WORD	47
		WORD	88
		WORD	69
		WORD	10
		WORD	0
posred	RESW	1
rez		RESW	10
