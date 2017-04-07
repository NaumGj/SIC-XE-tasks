
POL		START	0
		. preberi x
		CLEAR 	A
		LDX		x
		RMO		X, S
		. 5
		ADD		a0
		. 4x
		LDT		a1
		MULR	S, T
		ADDR	T, A
		. 3x^2
		LDT		a2
		MULR	X, S
		MULR	S, T
		ADDR	T, A
		. 2x^3
		LDT		a3
		MULR	X, S
		MULR	S, T
		ADDR	T, A
		. x^4
		MULR	X, S
		ADDR	S, A
		STA		rez
halt    J      halt
		END		POL

x		WORD	X'000002'
a0		WORD	X'000005'
a1		WORD	X'000004'
a2		WORD	X'000003'
a3		WORD	X'000002'
rez		RESW	1
