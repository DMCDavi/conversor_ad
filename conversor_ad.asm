
_main:

;conversor_ad.c,6 :: 		void main() {
;conversor_ad.c,7 :: 		TRISB = 0xF0; //Configura o RB0, RB1, RB2 e RB3 como saída
	MOVLW       240
	MOVWF       TRISB+0 
;conversor_ad.c,8 :: 		out1 = ~out1;
	BTG         LATB0_bit+0, BitPos(LATB0_bit+0) 
;conversor_ad.c,9 :: 		out2 = ~out2;
	BTG         LATB1_bit+0, BitPos(LATB1_bit+0) 
;conversor_ad.c,10 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
