
SUBR	START	0
		CLEAR 	X
		LDS		#beseda
		LDT		#len
LOOP	LDA		in, X
		. jump to subroutine
		JSUB	HORN
		. write in array
		STA		rez, X
		ADDR	S, X
		COMPR	X, T
		. if array is not at the end
		JLT		LOOP
halt    J      	halt
		END		SUBR

. dirties T
. return in A
HORN	STT 	oldt
		STX 	oldx
		CLEAR 	X
		. x+2
		LDX		a3
		ADDR	A, X
		. (x+2)*x+3
		LDT		a2
		MULR	A, X
		ADDR	T, X
		. ((x+2)*x+3)*x+4
		LDT		a1
		MULR	A, X
		ADDR	T, X
		. (((x+2)*x+3)*x+4)*x+5
		LDT		a0
		MULR	A, X
		ADDR	T, X
		RMO		X, A
		LDT		oldt
		LDX		oldx
		RSUB
oldt	RESW	1
oldx	RESW	1

in     	WORD 	X'000000'
		WORD	X'000002'
		WORD	X'000005'
		WORD	X'00000A'
       	WORD 	X'00002A'
last 	EQU 	*
len    	EQU 	last-in
beseda	EQU		3
a0		WORD	X'000005'
a1		WORD	X'000004'
a2		WORD	X'000003'
a3		WORD	X'000002'
rez		RESW	5
