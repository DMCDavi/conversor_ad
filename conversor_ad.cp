#line 1 "E:/davim/GitHub/conversor_ad/conversor_ad.c"





void main() {
 TRISB = 0xF0;
  LATB0_bit  = ~ LATB0_bit ;
  LATB1_bit  = ~ LATB1_bit ;
}
