
HORN	START	0
		. preberi x
		LDX		x
		. x+2
		LDA		a3
		ADDR	X, A
		. (x+2)*x+3
		LDT		a2
		MULR	X, A
		ADDR	T, A
		. ((x+2)*x+3)*x+4
		LDT		a1
		MULR	X, A
		ADDR	T, A
		. (((x+2)*x+3)*x+4)*x+5
		LDT		a0
		MULR	X, A
		ADDR	T, A
		STA		rez
halt    J      halt
		END		HORN

x		WORD	X'000002'
a0		WORD	X'000005'
a1		WORD	X'000004'
a2		WORD	X'000003'
a3		WORD	X'000002'
rez		RESW	1
