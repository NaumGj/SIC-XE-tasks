
ARITB	START	0
		. preberi x in y
		LDA		x
		LDS		y
		RMO		A, T
		. sestevanje
		ADDR	S, A
		STA		sum
		RMO		T, A
		. odstevanje
		SUBR	S, A
		STA		diff
		RMO		T, A
		. mnozenje
		MULR	S, A
		STA		prod
		RMO		T, A
		. deljenje
		DIVR	S, A
		STA		quot
		. ostanek
		MULR	A, S
		RMO		T, A
		SUBR	S, A
		STA		mod
		J		ARITB
		END		ARITB

x		WORD	X'000011'
y		WORD	X'000004'
sum		RESW	1
diff	RESW	1
prod	RESW	1
quot	RESW	1
mod		RESW	1
prodmod	RESW	1