; Starting code with basic constants and simple subroutine

ORG 0
Start:
	IN Quad
	CALL Mod6
	;IN Increment
	
	CALL DisplayWithNeg
	JUMP Start
	
DisplayWithNeg:
	OUT HEX1
	CALL Negate
	OUT HEX0
	RETURN
	
Mod6:
	JNEG Exit
	ADDI -6
	JUMP Mod6
	
	Exit:
		ADDI 6
		RETURN




;******************************************************************************
; Abs: 2's complement absolute value
; Returns abs(AC) in AC
; Negate: 2's complement negation
; Returns -AC in AC
;******************************************************************************
Abs:
	JPOS   Abs_r        ; If already positive, return
Negate:
	XOR    NegOne       ; Flip all bits
	ADDI   1            ; Add one
Abs_r:
	RETURN



; Useful values
Zero:      DW 0
NegOne:    DW -1
One:
Bit0:      DW &B0000000001
Bit1:      DW &B0000000010
Bit2:      DW &B0000000100
Bit3:      DW &B0000001000
Bit4:      DW &B0000010000
Bit5:      DW &B0000100000
Bit6:      DW &B0001000000
Bit7:      DW &B0010000000
Bit8:      DW &B0100000000
Bit9:      DW &B1000000000
LoByte:    DW &H00FF
HiByte:    DW &HFF00


; IO address constants
Switches:  EQU &H000
LEDs:      EQU &H001
Timer:     EQU &H002
Hex0:      EQU &H004
Hex1:      EQU &H005
Increment: EQU &H0F0
Quad:	   EQU &H0F1

