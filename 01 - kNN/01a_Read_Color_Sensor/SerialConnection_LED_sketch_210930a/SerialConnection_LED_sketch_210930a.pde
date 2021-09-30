

import processing.serial.*;

Serial myPort; // create object from Serial class
String val; // data received from the serial port


void setup() {
  // I know that the first port in the serial list on my mac 
  // is Serial.list()[0].
  // On windows machines, this generally opens COM1.
  // open whatever port is the one you're using
  String portName = Serial.list()[3];
  // on my mac the first few serial ports are occupied by bluetooth headsets etc. I was on port 3
  // also it's important to close out the Serial Monitor on Arduino before you run this Processing sketch 
  // otherwise it will say 'busy'. Why is this?
  
  myPort = new Serial(this, portName, 9600);
}

void draw()
{
  if ( myPort.available() > 0)
  { // if data is available,
  val = myPort.readStringUntil('\n'); // read it until the end of the line and store in a value
  }
print(val);
}
