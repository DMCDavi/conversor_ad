#define out1 LATB0_bit //controle da saída 1
#define out2 LATB1_bit //controle da saída 2
#define out3 LATB2_bit //controlP¶s saída 3
#define out4 LATB3_bit //controle da saída 4

void main() {
  TRISB = 0xF0; //Configura o RB0, RB1, RB2 e RB3 como saída
  out1 = ~out1;
  out2 = ~out2;
}