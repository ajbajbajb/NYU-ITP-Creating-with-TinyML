import processing.serial.*;

Serial myPort;
String val;
// since we're doing serial handhsaking 
// we need to check if we've heard from the microcontroller
boolean firstContact = false; // assume not!

void setup() {
    size(200,200);
    // initialize your serial port and set the baud rate to 9600
    myPort = new Serial(this, Serial.list()[3], 9600);
    myPort.bufferUntil('\n');
}
void draw() {
  //we can leave the draw method empty, 
  //because all our programming happens in the serialEvent (see below)
}

//
// read the incoming data
// see if there's actually anything in it (i.e. it's not empty or 'null')
// trim whitespace and other unimportant stuff
// if it's our first time hearing the right thing, change our firstContact boolean and let Arduino know we're ready for more data
// if it's not our first run, print the data to the console and send back any valid mouse clicks (as 1's) we got in our window
// finally, tell Arduino we're ready for more data

void serialEvent( Serial myPort) {
  //put the incoming data into a String - 
  //the '\n' is our end delimiter indicating the end of a complete packet
  val = myPort.readStringUntil('\n');
  //make sure our data isn't empty before continuing
  if (val != null) {
    //trim whitespace and formatting characters (like carriage return)
    val = trim(val);
    println(val);
  
      //look for our 'A' string to start the handshake
    //if it's there, clear the buffer, and send a request for data
    if (firstContact == false) {
      if (val.equals("A")) {
        myPort.clear();
        firstContact = true;
        myPort.write("A");
        println("contact");
      }
    }
    else { //if we've already established contact, keep getting and parsing data
      println(val);
  
      if (mousePressed == true) 
        {                           //if we clicked in the window
          myPort.write('1');        //send a 1
          println("1");
        }
    
        // when you've parsed the data you have, ask for more:
          myPort.write("A");
        }
  }
}
