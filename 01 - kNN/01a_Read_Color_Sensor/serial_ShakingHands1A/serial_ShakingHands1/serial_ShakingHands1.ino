char val;
int ledPin = LED_BUILTIN;
boolean ledState = LOW;


void establishContact() {
  while (Serial.available() <= 0) {
      Serial.println("A");
      delay(300);
      
    }
}
  // put your main code here, to run repeatedly:

void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT); // set pin as OUTPUT
  Serial.begin(9600);
  establishContact(); // send a byte to establish contact until receiver responds

}

void loop() {
  if (Serial.available() > 0) {
    val = Serial.read(); // read it and store in a val
    if (val == '1') {
      ledState = !ledState; // flip the ledState
      digitalWrite(ledPin, ledState);
      Serial.println("Switching!");
    }
    delay(100);
  } 
    else {
      Serial.println("Listening!");
      delay(50);
    
  }
}
