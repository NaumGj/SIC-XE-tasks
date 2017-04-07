
ARITA	START	0
		. sestevanje
		LDA		x
		ADD		y
		STA		sum
		. odstevanje
		LDA		x
		SUB		y
		STA		diff
		. mnozenje
		LDA		x
		MUL		y
		STA		prod
		. deljenje
		LDA		x
		DIV		y
		STA		quot
		. ostanek
		MUL		y
		STA		prodmod
		LDA		x
		SUB		prodmod
		STA		mod
		J		ARITA
		END		ARITA

x		WORD	X'000011'
y		WORD	X'000004'
sum		RESW	1
diff	RESW	1
prod	RESW	1
quot	RESW	1
mod		RESW	1
prodmod	RESW	1