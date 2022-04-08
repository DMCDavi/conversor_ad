#line 1 "E:/davim/GitHub/conversor_ad/conversor_ad.c"
float analog_reading = 0;

float MXP4115_Read(float valor) {
 valor /= 204.8;
 valor += 0.475;
 valor /= 0.045;
 return valor;
}

void Init_AD() {
 ADCON0 = 0x01;
 ADCON1 = 0x0E;
 ADCON2 = 0xA6;
 ADRESH = 0;
 ADRESL = 0;
}

void Config_Ports() {
 TRISA = 0xFF;
 TRISB = 0x00;
 PORTB = 0x00;
}

void main() {
 Init_AD();
 Config_Ports();

 while (1) {

 ADCON0.GO = 1;
 while (ADCON0.GO == 1);
 analog_reading = MXP4115_Read((ADRESH * 256) | (ADRESL));

 if (analog_reading > 0 && analog_reading < 5) {
 LATB = 0x80;
 } else if (analog_reading >= 5 && analog_reading < 10) {
 LATB = 0xC0;
 } else if (analog_reading >= 15 && analog_reading < 20) {
 LATB = 0xE0;
 } else if (analog_reading >= 25 && analog_reading < 30) {
 LATB = 0xF0;
 } else if (analog_reading >= 35 && analog_reading < 40) {
 LATB = 0xF8;
 } else if (analog_reading >= 45 && analog_reading < 50) {
 LATB = 0xFC;
 } else if (analog_reading >= 55 && analog_reading < 60) {
 LATB = 0xFE;
 } else if (analog_reading >= 65) {
 LATB = 0xFF;
 }

 }
}
