
fakt	START	0
		. inicializiraj stack pointer
		JSUB	init
		. izvedi algoritem selection sort
		LDX		i
		. na vsakem koraku najdi najmanjsi element v neurejenem delu tabele
loopmin	JSUB	minind
		. zamenjaj elemente
		STX		swap1
		STT 	swap2
		JSUB	swap
		. izpisi tabelo
		JSUB	echotab
		LDX		i
		LDT		#3
		ADDR	T, X
		STX		i
		LDT		#len
		COMPR	X, T
		. ce smo uredili tabelo, algoritem se vstavi
		JEQ		halt
		J 		loopmin
halt    J      	halt
		END		fakt

. dirties A, S, X
. return tab T
. najdi najmanjsi element v neurejenem delu tabele
. v i je meja med urejenim in neurejenim delom
minind	STA 	olda
		STS 	olds
		STX 	oldx
		LDX		i
		LDA		tab, X
		LDT		i
minloop	LDS		#3
		ADDR	S, X
		LDS		#len
		COMPR	X, S
		JEQ		out4
		LDS		tab, X
		COMPR	A, S
		JLT		minloop
		RMO		S, A
		RMO		X, T
		J 		minloop
out4	LDA		olda
		LDS		olds
		LDX		oldx
		RSUB


. dirties A, S, X
. zamenjaj dva elementa v tabeli
swap	STA 	olda
		STS 	olds
		STX 	oldx
		LDX		swap1
		LDA		tab, X
		LDX		swap2
		LDS		tab, X
		STA 	tab, X
		LDX		swap1
		STS		tab, X
		LDA		olda
		LDS		olds
		LDX		oldx
		RSUB

. dirties A, X
. na sklad shranimo register L ker znotraj klicem funkcijo za izpis posameznega stevila
echotab	STL		@stackptr
		JSUB	push
		STA		olda
		STX		oldx
		CLEAR	X
looptab	LDA		tab, X
		. izpisi stevilo
		JSUB	echonum
		. izpisi presledek
		LDA 	space
test2	TD		stdout
		JEQ		test2
		WD		stdout
		LDA		i
		COMPR	A, X
		. ce je potrebno izpisi navpicno crto in presledek
		JEQ		dline
		. ce ne skoci naprej
		J 		noline
dline	LDA 	line
test3	TD		stdout
		JEQ		test3
		WD		stdout
		LDA 	space
test5	TD		stdout
		JEQ		test5
		WD		stdout
		. ce je konec tabele koncaj z izpisovanjem, ce ne vrni se v zanki in izpisi naslednje stevilo
noline	LDA		#3
		ADDR	A, X
		LDA		#len
		COMPR	X, A
		JEQ		out1
		J 		looptab
		. izpisi znak za novo vrstico
out1	LDA 	newline
test1	TD		stdout
		JEQ		test1
		WD		stdout
		. vzami register L iz sklada
		JSUB	pop
		LDL		@stackptr
		LDA		olda
		LDX		oldx
		RSUB

.dirties A, T, S, X
echonum	STA 	olda
		STS 	olds
		STT 	oldt
		STX 	oldx
		. stevilko delimo z 10 in shranjujemo njene stevke v pomnilniku
		CLEAR 	X
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
out3	LDA		olda
		LDS		olds
		LDT		oldt
		LDX		oldx
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

tab		WORD	23
		WORD	18
		WORD	4
		WORD	63
		WORD	40
		WORD	79
		WORD	2
		WORD	11
		WORD	12
		WORD	1
		WORD	90
		WORD	45
		WORD	22
		WORD	7
		WORD	6
last 	EQU 	*
len    	EQU 	last-tab
i 		WORD	0
newline	WORD	10
space	WORD	32
line	WORD	124
swap1	RESW	1
swap2	RESW	1
olda	RESW	1
olds	RESW	1
oldt	RESW	1
oldx	RESW	1
stdout	BYTE	X'01'
gonum	WORD	X'000030'
rez		RESW	10
stackptr	RESW	1
stack 	RESW	100
