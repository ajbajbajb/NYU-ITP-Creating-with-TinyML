#include <Arduino_APDS9960.h>
char val;
int ledPin = LED_BUILTIN;

void setup() {
   pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
  //  SET UP A SERIAL COMMUNICATION AT 9600 BAUD RATE
  Serial.begin(9600);
  while (!Serial);
}
//  if (!APDS.begin()) {
//    Serial.println("Error initializing APDS9960 sensor.");
// NOT USING THIS INITIALLY BECAUSE WE'RE JUST SENDING INFO
//}


void loop() {
  if (Serial.available()){
    // if there's data available to read
    val = Serial.read(); // read  it and store it in val
  }
  if (val == '1')
  { //if 1 was received, turn on the light
    digitalWrite(ledPin, HIGH);
  } else {
    // if 0 was received, turn it off
    digitalWrite(ledPin, LOW);
  }
  delay(10); // wait 10 milliseconds for next reading

}
