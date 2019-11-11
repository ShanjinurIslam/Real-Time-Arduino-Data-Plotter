#include <SoftwareSerial.h>
SoftwareSerial BTSerial(0,1); 

int getValue(){ //acts as a sensor data value generator
  return random(256) ; //emulates ECG Data Values
}

void setup() {
  BTSerial.begin(9600);
  randomSeed(analogRead(0));
}
void loop() {
 //need one start command from mobile device
 while (BTSerial.available()) { 
  BTSerial.println(getValue());
  delay(1000);
 }
}
