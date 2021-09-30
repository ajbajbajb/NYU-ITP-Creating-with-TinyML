

/*
  APDS9960 - Color Sensor

  This example reads Color data from the on-board APDS9960 sensor of the
  Nano 33 BLE Sense and prints the color RGB (red, green, blue) values
  to the Serial Monitor once a second.

  The circuit:
  - Arduino Nano 33 BLE Sense

  This example code is in the public domain.
*/
// add JSON
#include <ArduinoJson.h>
DynamicJsonDocument doc(200);
#include <Arduino_APDS9960.h>

void setup() {
//  SET UP A SERIAL COMMUNICATION AT 9600 BAUD RATE
  Serial.begin(9600);
  while (!Serial);

  if (!APDS.begin()) {
    Serial.println("Error initializing APDS9960 sensor.");
  }
}

void loop() {
  // Check if a color reading is available
  while (!APDS.colorAvailable()) {
    delay(5);
  }
  int r, g, b;
  // read the color
  APDS.readColor(r, g, b);
  // create JSON doc
  doc["red"] = r;
  doc["green"] = g;
  doc["blue"] = b;

  // output Serialized JSON to the Serial
  Serial.println(serializeJson(doc, Serial));
  
  // print the values with marks between
//  Serial.print(r);
//  Serial.print(g);
//  Serial.println(b);

  // wait a bit before reading again
  delay(2000);
}
