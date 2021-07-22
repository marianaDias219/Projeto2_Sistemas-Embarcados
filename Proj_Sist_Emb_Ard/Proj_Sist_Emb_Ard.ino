#include <Ultrasonic.h>
 
//Define os pinos para o trigger e echo
#define pino_trigger 4
#define pino_echo 5
String dados = "";
 
//Inicializa o sensor nos pinos definidos acima
Ultrasonic ultrasonic(pino_trigger, pino_echo);
 
void setup()
{
  Serial.begin(9600);
}
 
void loop()
{ 
  //Le as informacoes do sensor em cm 
  float cmMsec;
  int binario;
  long microsec = ultrasonic.timing();
  cmMsec = ultrasonic.convert(microsec, Ultrasonic::CM);
  //Exibe informacoes no monitor serial
  if(cmMsec > 5){
   binario = 1;
  }else{
   binario = 0;
  }
  dados+=binario;
  Serial.println(dados);
  delay(1000);
}
