
_MXP4115_Read:

;conversor_ad.c,3 :: 		float MXP4115_Read(float valor) {
;conversor_ad.c,4 :: 		valor /= 204.8;
	MOVLW       205
	MOVWF       R4 
	MOVLW       204
	MOVWF       R5 
	MOVLW       76
	MOVWF       R6 
	MOVLW       134
	MOVWF       R7 
	MOVF        FARG_MXP4115_Read_valor+0, 0 
	MOVWF       R0 
	MOVF        FARG_MXP4115_Read_valor+1, 0 
	MOVWF       R1 
	MOVF        FARG_MXP4115_Read_valor+2, 0 
	MOVWF       R2 
	MOVF        FARG_MXP4115_Read_valor+3, 0 
	MOVWF       R3 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_MXP4115_Read_valor+0 
	MOVF        R1, 0 
	MOVWF       FARG_MXP4115_Read_valor+1 
	MOVF        R2, 0 
	MOVWF       FARG_MXP4115_Read_valor+2 
	MOVF        R3, 0 
	MOVWF       FARG_MXP4115_Read_valor+3 
;conversor_ad.c,5 :: 		valor += 0.475;
	MOVLW       51
	MOVWF       R4 
	MOVLW       51
	MOVWF       R5 
	MOVLW       115
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_MXP4115_Read_valor+0 
	MOVF        R1, 0 
	MOVWF       FARG_MXP4115_Read_valor+1 
	MOVF        R2, 0 
	MOVWF       FARG_MXP4115_Read_valor+2 
	MOVF        R3, 0 
	MOVWF       FARG_MXP4115_Read_valor+3 
;conversor_ad.c,6 :: 		valor /= 0.045;
	MOVLW       236
	MOVWF       R4 
	MOVLW       81
	MOVWF       R5 
	MOVLW       56
	MOVWF       R6 
	MOVLW       122
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_MXP4115_Read_valor+0 
	MOVF        R1, 0 
	MOVWF       FARG_MXP4115_Read_valor+1 
	MOVF        R2, 0 
	MOVWF       FARG_MXP4115_Read_valor+2 
	MOVF        R3, 0 
	MOVWF       FARG_MXP4115_Read_valor+3 
;conversor_ad.c,7 :: 		return valor;
;conversor_ad.c,8 :: 		}
L_end_MXP4115_Read:
	RETURN      0
; end of _MXP4115_Read

_Init_AD:

;conversor_ad.c,10 :: 		void Init_AD() {
;conversor_ad.c,11 :: 		ADCON0 = 0x01; //select channel AN0, enable A/D module
	MOVLW       1
	MOVWF       ADCON0+0 
;conversor_ad.c,12 :: 		ADCON1 = 0x0E; //use VDD, VSS as reference and configure AN0 for analog
	MOVLW       14
	MOVWF       ADCON1+0 
;conversor_ad.c,13 :: 		ADCON2 = 0xA6; //result right justified, acquisition time = 8 TAD, FOSC/64
	MOVLW       166
	MOVWF       ADCON2+0 
;conversor_ad.c,14 :: 		ADRESH = 0; /* Flush ADC output Register */
	CLRF        ADRESH+0 
;conversor_ad.c,15 :: 		ADRESL = 0;
	CLRF        ADRESL+0 
;conversor_ad.c,16 :: 		}
L_end_Init_AD:
	RETURN      0
; end of _Init_AD

_Config_Ports:

;conversor_ad.c,18 :: 		void Config_Ports() {
;conversor_ad.c,19 :: 		TRISA = 0xFF; //sets PORTA as all inputs, bit0 is AN0
	MOVLW       255
	MOVWF       TRISA+0 
;conversor_ad.c,20 :: 		TRISB = 0x00; //sets PORTB as all outputs
	CLRF        TRISB+0 
;conversor_ad.c,21 :: 		PORTB = 0x00; //sets all outputs of PORTB off to begin with
	CLRF        PORTB+0 
;conversor_ad.c,22 :: 		}
L_end_Config_Ports:
	RETURN      0
; end of _Config_Ports

_main:

;conversor_ad.c,24 :: 		void main() {
;conversor_ad.c,25 :: 		Init_AD();
	CALL        _Init_AD+0, 0
;conversor_ad.c,26 :: 		Config_Ports();
	CALL        _Config_Ports+0, 0
;conversor_ad.c,28 :: 		while (1) {
L_main0:
;conversor_ad.c,30 :: 		ADCON0.GO = 1; //do A/D measurement
	BSF         ADCON0+0, 1 
;conversor_ad.c,31 :: 		while (ADCON0.GO == 1); /* Wait for End of conversion i.e. Go/done'=0 conversion completed */
L_main2:
	BTFSS       ADCON0+0, 1 
	GOTO        L_main3
	GOTO        L_main2
L_main3:
;conversor_ad.c,32 :: 		analog_reading = MXP4115_Read((ADRESH * 256) | (ADRESL)); /*Combine 8-bit LSB and 2-bit MSB*/
	MOVF        ADRESH+0, 0 
	MOVWF       R1 
	CLRF        R0 
	MOVF        ADRESL+0, 0 
	IORWF       R0, 1 
	MOVLW       0
	IORWF       R1, 1 
	CALL        _int2double+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_MXP4115_Read_valor+0 
	MOVF        R1, 0 
	MOVWF       FARG_MXP4115_Read_valor+1 
	MOVF        R2, 0 
	MOVWF       FARG_MXP4115_Read_valor+2 
	MOVF        R3, 0 
	MOVWF       FARG_MXP4115_Read_valor+3 
	CALL        _MXP4115_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _analog_reading+0 
	MOVF        R1, 0 
	MOVWF       _analog_reading+1 
	MOVF        R2, 0 
	MOVWF       _analog_reading+2 
	MOVF        R3, 0 
	MOVWF       _analog_reading+3 
;conversor_ad.c,34 :: 		if (analog_reading > 0 && analog_reading < 5) {
	MOVF        R0, 0 
	MOVWF       R4 
	MOVF        R1, 0 
	MOVWF       R5 
	MOVF        R2, 0 
	MOVWF       R6 
	MOVF        R3, 0 
	MOVWF       R7 
	CLRF        R0 
	CLRF        R1 
	CLRF        R2 
	CLRF        R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
L__main39:
;conversor_ad.c,35 :: 		LATB = 0x80;
	MOVLW       128
	MOVWF       LATB+0 
;conversor_ad.c,36 :: 		} else if (analog_reading >= 5 && analog_reading < 10) {
	GOTO        L_main7
L_main6:
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       129
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
L__main38:
;conversor_ad.c,37 :: 		LATB = 0xC0;
	MOVLW       192
	MOVWF       LATB+0 
;conversor_ad.c,38 :: 		} else if (analog_reading >= 15 && analog_reading < 20) {
	GOTO        L_main11
L_main10:
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       112
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
L__main37:
;conversor_ad.c,39 :: 		LATB = 0xE0;
	MOVLW       224
	MOVWF       LATB+0 
;conversor_ad.c,40 :: 		} else if (analog_reading >= 25 && analog_reading < 30) {
	GOTO        L_main15
L_main14:
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       112
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
L__main36:
;conversor_ad.c,41 :: 		LATB = 0xF0;
	MOVLW       240
	MOVWF       LATB+0 
;conversor_ad.c,42 :: 		} else if (analog_reading >= 35 && analog_reading < 40) {
	GOTO        L_main19
L_main18:
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       12
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
L__main35:
;conversor_ad.c,43 :: 		LATB = 0xF8;
	MOVLW       248
	MOVWF       LATB+0 
;conversor_ad.c,44 :: 		} else if (analog_reading >= 45 && analog_reading < 50) {
	GOTO        L_main23
L_main22:
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       52
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main26
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main26
L__main34:
;conversor_ad.c,45 :: 		LATB = 0xFC;
	MOVLW       252
	MOVWF       LATB+0 
;conversor_ad.c,46 :: 		} else if (analog_reading >= 55 && analog_reading < 60) {
	GOTO        L_main27
L_main26:
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       92
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main30
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       112
	MOVWF       R6 
	MOVLW       132
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main30
L__main33:
;conversor_ad.c,47 :: 		LATB = 0xFE;
	MOVLW       254
	MOVWF       LATB+0 
;conversor_ad.c,48 :: 		} else if (analog_reading >= 65) {
	GOTO        L_main31
L_main30:
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       2
	MOVWF       R6 
	MOVLW       133
	MOVWF       R7 
	MOVF        _analog_reading+0, 0 
	MOVWF       R0 
	MOVF        _analog_reading+1, 0 
	MOVWF       R1 
	MOVF        _analog_reading+2, 0 
	MOVWF       R2 
	MOVF        _analog_reading+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       0
	BTFSC       STATUS+0, 0 
	MOVLW       1
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main32
;conversor_ad.c,49 :: 		LATB = 0xFF;
	MOVLW       255
	MOVWF       LATB+0 
;conversor_ad.c,50 :: 		}
L_main32:
L_main31:
L_main27:
L_main23:
L_main19:
L_main15:
L_main11:
L_main7:
;conversor_ad.c,52 :: 		}
	GOTO        L_main0
;conversor_ad.c,53 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
