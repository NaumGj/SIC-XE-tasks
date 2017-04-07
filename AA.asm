
AA		START	0
		CLEAR 	X
		LDS		beseda
		LDT		#len
loop	LDA		niz, X
test	TD		device
		JEQ		test
		WD		device
		ADDR	S, X
		COMPR	X, T
		JLT		loop
halt    J      	halt
		END		AA


beseda	WORD	3
device	BYTE	X'AA'
niz		WORD	83
		WORD	73
		WORD	67
		WORD	47
		WORD	88
		WORD	69
		WORD	10
last 	EQU 	*
len    	EQU 	last-niz