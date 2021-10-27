import processing.video.*;
import processing.serial.*;

/**
 * Simple Read + Video Timer
*/
Serial myPort;  // Create object from Serial class
int val;  // Data received from the serial port
int time;
String status;
int timer;
PImage Gimg; // need to call this variable type outside of the setup function. Do I need to do it for each image?
int bgColor = 50;
int videoXY = 130;
String textResponse;
// instantiate movies as Movie objects
Movie eggV, coffeeV, sunriseV, toothbrushV;

void setup() {
  size(840, 560); // 
  // Serial.list()[4].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[4];
  myPort = new Serial(this, portName, 9600);
  // starting a timer
  time = millis();
  // loading in the videos
  // make sure to put these videos in a folder named 'data'!
  eggV = new Movie(this, "egg.mp4");
  coffeeV  = new Movie(this, "coffee.mp4");
  sunriseV = new Movie(this, "sunrise.mp4");
  toothbrushV = new Movie(this, "teeth.mp4");
  toothbrushV.speed(1);
  eggV.speed(1);
  sunriseV.speed(5);
  coffeeV.speed(1);
  background(100);
  status = "ready";
  timerGo(0);
}

// apparently this is all you need in order to call the library and play the video
void movieEvent(Movie m) {
  m.read();
}

void draw(){
  statusText(status);    
  eggV.loop();
  coffeeV.loop();
  sunriseV.loop();
  toothbrushV.loop();
  if (myPort.available() > 0) {  // If data is available,
    println("connected");
    textResponse = myPort.readString();
    //print("The Response is: " + textResponse);
    println("passing " + textResponse + " to function");
  //  if (textResponse != null) {
  //    println("passing " + textResponse + " to function");
  //    println("this is the time:" + str(time));
  //    videoPlayer(textResponse);
  //  }
  //  else {
  //    println("nothing received");  
  //    background(20);
  //}
  }
  videoPlayer(textResponse);
}
void videoCheck(String tx){
  println(tx, 0, 0);
}

void timerGo(int duration){
      rect(10, 450, 100, 40);
      fill(30);
      textSize(30);
      if (duration == 0) {
         text("Ready", 20, 480);
      } else {
        text(((millis()/1000)-duration), 20, 480);
      }
      fill(255);
}
void statusText(String s){
    textSize(80);
    text(s, 10, 80);
    fill(255);
}
void videoPlayer(String response){
  if (response != null) {
      if (response.contains("hockeyswipe")) {
      background(bgColor);
      println("swipe means egg!");
      eggV.play();
      timerGo(420);
      image(eggV, videoXY, videoXY);
      statusText("Perfect Egg");
    }
    else if (response.contains("grasshopper")) {
      background(bgColor);
      println("Grasshopper means toothbrush!");
      toothbrushV.loop();
      image(toothbrushV, videoXY, videoXY);
      statusText("brush for 2 mins");
      timerGo(120);
    }
    else if (response.contains("onetwothreefour")) {
      background(bgColor);
      sunriseV.loop();
      image(sunriseV, videoXY, videoXY);
      statusText("ok, another 20 mins");
      timerGo(1200);
    }
    else if (response.contains("circle")) {
      background(bgColor);
      println("Circle -> Coffee");
      statusText("Coffee");
      coffeeV.loop();
      image(coffeeV, videoXY, videoXY);
      timerGo(3000);
    }
    else {
      println("nothing received");
  }
    }
    else {
      println(" null detected");
    }
  }
  
  
  
  
      //if (response == '
      //background(50);
      //println("round shape");
      //text(response, 50, 50);
      //textSize(40);
      //status = "Coffee";
      //timerGo(300);
      //videoCheck("yeah, receiving round shape");
      //image(coffeeV, 0, 0);
      //coffeeV.loop();
      //}


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
