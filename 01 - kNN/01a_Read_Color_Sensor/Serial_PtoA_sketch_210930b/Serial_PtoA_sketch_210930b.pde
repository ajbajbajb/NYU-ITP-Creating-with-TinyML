import processing.serial.*;

// FROM PROCESSING to ARDUINO

Serial myPort;

void setup()
{
  size(200,200);
  String portName = Serial.list()[3]; // the port number for the Arduino on this computer
  myPort = new Serial(this, portName, 9600); // making sure the communication is on the same channel as the Ard freq
}

void draw() {
  if (mousePressed == true)
  {
    myPort.write('1');
    print('1');
  } else 
  {
    myPort.write('0');
  }
}
