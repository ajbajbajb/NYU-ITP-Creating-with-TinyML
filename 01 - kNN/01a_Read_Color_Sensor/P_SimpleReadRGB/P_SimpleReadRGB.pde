/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
JSONArray colors; // JSONParse Output
String red, blue, green;

void setup() 
{
  size(200, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  colors = loadJSONArray(val);
  red = colors.getJSONObject("red");
}

void draw()
{
  
  if ( myPort.available() > 0) {  // If data is available,
    println("ready");
    val = myPort.readStringUntil('\n');         // read it and store it in val
  }
  background(255);             // Set background to white
  if (val == "A") {              // If the serial value is 0,
    fill(0);                   // set fill to black
  } 
  else {// If the serial value is not 0,
    println(val);
    println(red);
    fill(100,0,0);
    //fill(127,0,0);                 // set fill to light gray
  }
  rect(0, 0, 200, 200);
}



/*

// Wiring / Arduino Code
// Code for sensing a switch status and writing the value to the serial port.

int switchPin = 4;                       // Switch connected to pin 4

void setup() {
  pinMode(switchPin, INPUT);             // Set pin 0 as an input
  Serial.begin(9600);                    // Start serial communication at 9600 bps
}

void loop() {
  if (digitalRead(switchPin) == HIGH) {  // If switch is ON,
    Serial.write(1);               // send 1 to Processing
  } else {                               // If the switch is not ON,
    Serial.write(0);               // send 0 to Processing
  }
  delay(100);                            // Wait 100 milliseconds
}

*/
