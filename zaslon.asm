
ZASLON	START	0
		. izracunaj konec zaslona
		LDA		screen
		ADD 	scrlen
		STA 	scrend
		CLEAR	A
		. vsakic zamenjaj register S (0 pomeni ' ', 1 pomeni 'A')
		CLEAR	S
loop	LDT		one
		ADDR	T, S
		COMPR	S, T
		JEQ		nozero
		LDS		#0
nozero	JSUB	scrop
		J		loop
		END		ZASLON

.dirties A, T, S, X
scrop	STA 	olda
		STS 	olds
		STT 	oldt
		STX 	oldx
		. glede na register S izbere kaj se bo izpisalo
		LDA		char
		LDT		one
		COMPR	S, T
		JEQ		nospac
		LDA		space
		. v registru T je trenutna pozicija na zaslonu
nospac	LDT		screen
		STT 	pos
		LDX		scrend
print	LDT		pos
		. ce smo prisli do konca zaslona, gremo ven
		COMPR	T, X
		JEQ		out
		. izpisemo znak na zaslonu
		STCH	@pos
		LDS		one
		. povecamo T in shranimo v pos
		ADDR	S, T
		STT 	pos
		J 		print
out		LDA		olda
		LDS		olds
		LDT		oldt
		LDX		oldx
		RSUB

. podatki o zaslonu
screen  WORD	X'00B800'
scrcols BYTE   	X'000050'
scrrows BYTE   	X'000019'
scrlen	BYTE	X'0007D0'
scrend	RESW	1
pos		RESW	1

char	BYTE	X'000041'
space	BYTE	X'000020'
one		BYTE	X'000001'
olda	RESW	1
olds	RESW	1
oldt	RESW	1
oldx	RESW	1
