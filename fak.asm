
fakt	START	0
		. prebere byte iz naprave (FA)
test	CLEAR	A
		TD		device
		JEQ		test
		RD		device
		. ce je prebran bajt = 0, se program konca
		COMP 	#0
		JEQ		halt
		. inicializiraj sklad
		JSUB	init
		. rekurziven klic za izracun faktoriele
		JSUB	fakrek
		. izpisi rezultat
		RMO		S, A
		JSUB	echonum
		J 		test
halt    J      	halt
		END		fakt

. rezultat vracam v register S
fakrek	COMP	#1
		. ce je stevilo (parameter) enak 1, vrni 1
		JEQ		out
		. shrani registra L in A
		STL		@stackptr
		JSUB	push
		STA		@stackptr
		JSUB	push
		. od registra A odstej 1 in ga poslji spet kot parameter v rekurzivnem klicu
		SUB		#1
		JSUB	fakrek
		. vzami registra A in L s sklada
		JSUB	pop
		LDA		@stackptr
		JSUB	pop
		LDL		@stackptr
		. zmnozi A z rezultatom poklicane rekurzivne funkcije
		MULR	A, S
		RSUB
out		LDS		#1
		RSUB

init	STA 	olda
		LDA		#stack
		STA 	stackptr
		LDA		olda

push	STA 	olda
		LDA		stackptr
		ADD		#3
		STA 	stackptr
		LDA		olda
		RSUB

pop		STA 	olda
		LDA		stackptr
		SUB		#3
		STA 	stackptr
		LDA		olda
		RSUB

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
		JEQ		out2

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
out2 	STT 	rez, X
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

out3	LDA 	newline
test5	TD		stdout
		JEQ		test5
		WD		stdout
		LDA		olda
		LDS		olds
		LDT		oldt
		LDX		oldx
		RSUB

device	BYTE	X'FA'
in		WORD	4
olda	RESW	1
olds	RESW	1
oldt	RESW	1
oldx	RESW	1
stdout	BYTE	X'01'
ten		WORD	X'00000A'
one		WORD	X'000001'
gonum	WORD	X'000030'
newline	WORD	10
rez		RESW	10
stackptr	RESW	1
stack 	RESW	512