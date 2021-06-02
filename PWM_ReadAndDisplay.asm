; Starting code with basic constants and simple subroutine

ORG 0
Start:


;TODO

;How to translate degree into count
;degree = 360/currentCount

;Calculate the angle moved
;The angle moved in degrees per count = 360/540
	
;Take in switches to use as desired position

;Calculate Velocity
	;You will probably need a perifial device that outputs a 10hz timer
	
;Take in other switches to use as desired velocity
;Test:
	CALL GetDesiredPos
	LOAD MaxSpeed
	OUT PWM
	;JUMP Test
	
	Loop:
		IN Quad
		CALL Abs
		OUT Hex0
		;LOAD MaxSpeed
		;OUT PWM
		
		CALL CheckPos
		JUMP Loop
	
	
GetDesiredPos:
	IN Switches
	AND Bit06
	
	STORE DisPos
	
	ADD DisPos
	STORE DisPos
	;*2
	
	ADD DisPos
	STORE DisPos
	;*4
	
	ADD DisPos
	STORE DisPosBuff
	;*8
	
	ADD DisPosBuff
	STORE DisPos
	;*16
	
	ADD DisPosBuff
	STORE DisPos
	;*24
	
	RETURN
	
	
CheckPos:
		
		;It must be in increments of 16 degrees with accuracy +-8 degrees
		;Incements of 24 counts with accuracy of 12 counts
		;So we need to represent 1080 counts both ways
		; 1080/24 = 90 90 requires 7 bits
		; So 0 - 6 will be positions 
		; 7 will be direction

		IN Quad
		CALL Abs
		
		SUB DisPos
		;OUT Hex0
		JPOS Stop
		LOAD MaxSpeed
		OUT PWM
		RETURN
		
Stop:
	LOAD Zero
	OUT PWM
	JUMP Loop

CalcDegree:
	IN PWM
	CALL Mod540
	RETURN
	
Mod540:
	JNEG Exit
	ADDI -540
	JUMP Mod540
	
	Exit:
		ADDI 540
		RETURN


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
One:	   DW 1
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
Bit06:	   DW &B0001111111
LoByte:    DW &H00FF
HiByte:    DW &HFF00

Count:      DW 0
DisPos:     DW 0
DisPosBuff: DW 0

MaxSpeed:   DW 15
MinSpeed:   DW 0


; IO address constants
Switches:  EQU &H000
LEDs:      EQU &H001
Timer:     EQU &H002
Hex0:      EQU &H004
Hex1:      EQU &H005
Increment: EQU &H0F0
Quad:	   EQU &H0F1
PWM: 	   EQU &H0F2
Velocity:  EQU &H0F3

