import processing.video.*;
import processing.serial.*;

/**
 * Simple Read + Video Timer
*/
Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
PImage Gimg; // need to call this variable type outside of the setup function. Do I need to do it for each image?
Movie eggV;
Movie coffeeV;
Movie sunriseV;
Movie toothbrushV;

void setup() 
{
  size(1112, 834); // 50% 10.5" iPad resolution
  background(0);
  // Serial.list()[4].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);
  // starting a timer
  int t = millis() / 1000;
  // loading in the videos
  // make sure to put these videos in a folder named 'data'!
  eggV = new Movie(this, "egg.mp4");
  coffeeV  = new Movie(this, "coffee.mp4");
  sunriseV = new Movie(this, "sunrise.mp4");
  sunriseV.loop();
  toothbrushV = new Movie(this, "teeth.mp4");
  toothbrushV.loop();
  
}

// apparently this is all you need in order to call the library and play the video
void movieEvent(Movie m) {
  m.read();
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
      eggV.loop();
      image(eggV, 0, 0);
      videoCheck("eggy bastard");
    }
    else if (textResponse.contains("grasshopper")) {
      println("Grasshopper!");
      toothbrushV.loop();
      image(toothbrushV, 0, 0);
      videoCheck("tooothy brushy");
    }
    else if (textResponse.contains("onetwothreefour")) {
      println("Shake it up!");
      sunriseV.loop();
      image(sunriseV, 0, 0);
      videoCheck("okey dokey sunrise");
    }
    else if (textResponse.contains("circle")) {
      println("round shape");
      videoCheck("yeah, receiving round shape");
      coffeeV.loop();
      image(coffeeV, 0, 0);
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

void videoCheck(String tx){
  text(tx, 0, 0);
}

void videoPlayer(String response){
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
