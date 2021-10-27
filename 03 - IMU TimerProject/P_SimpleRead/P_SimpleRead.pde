/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
*/


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
PImage Gimg; // need to call this variable type outside of the setup function. Do I need to do it for each image?
PImage Grassimg;
PImage onetwoImg;
PImage circleImg;


void setup() 
{
  size(400, 400);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);
  Gimg = loadImage("gretz.png");
  Grassimg = loadImage("grass.png");
  onetwoImg = loadImage("1234.png"); 
  circleImg = loadImage("circle.png");
}

void draw(){
  if ( myPort.available() > 0) {  // If data is available,
    println("connected");
    //print(myPort.readString());
    //String fullResponse[] = split(myPort.readString(), "guess: "); 
    //String textResponse = fullResponse[1];
    // read the strings being sent by the classifier
    // unfortunately response has all the other strings in it (as possibles)
    // i'll strip the response using the line break as split
    String textResponse = myPort.readString();
    //print("The Response is: " + textResponse);
    if (textResponse != null) {
      println("passing to function");
      if (textResponse.contains("hockeyswipe")) {
      println("Gretzky!");
      image(Gimg, 0, 0, 400, 400);
    }
    else if (textResponse.contains("grasshopper")) {
      println("Grasshopper!");
      image(Grassimg, 0, 0, 400, 400);
    }
    else if (textResponse.contains("onetwothreefour")) {
      println("Shake it up!");
      image(onetwoImg, 0, 0, 400, 400);
    }
    else if (textResponse.contains("circle")) {
      println("round shape");
      image(circleImg, 0, 0, 400, 400);
    }
    else {
      println("nothing received");
  }
    }
    else {
      println(" null detected");
    }
  }
}



/**

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
