
VI		START	0
TEST	TD		stdin
		JEQ		TEST
		RD		stdin
TEST2	TD		stdout
		JEQ		TEST2
		WD		stdout
		J		TEST
		END		VI
		
stdin	BYTE	X'00'
stdout	BYTE	X'01'
