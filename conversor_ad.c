#define out1 LATB0_bit //controle da sa�da 1
#define out2 LATB1_bit //controle da sa�da 2
#define out3 LATB2_bit //controlP�s sa�da 3
#define out4 LATB3_bit //controle da sa�da 4

void main() {
  TRISB = 0xF0; //Configura o RB0, RB1, RB2 e RB3 como sa�da
  out1 = ~out1;
  out2 = ~out2;
}