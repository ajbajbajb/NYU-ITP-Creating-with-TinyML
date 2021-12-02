// include the ble library to connect over bluetooth. 
#include <ArduinoBLE.h>

#define RED_PIN 22
#define GREEN_PIN 23
#define BLUE_PIN 24


BLEService nanoService("13012F00-F8C3-4F4A-A8F4-15CD926DA146"); 
BLEByteCharacteristic redLEDCharacteristic("13012F01-F8C3-4F4A-A8F4-15CD926DA146", BLERead | BLEWrite);
BLEByteCharacteristic greenLEDCharacteristic("13012F02-F8C3-4F4A-A8F4-15CD926DA146", BLERead | BLEWrite);
BLEByteCharacteristic blueLEDCharacteristic("13012F03-F8C3-4F4A-A8F4-15CD926DA146", BLERead | BLEWrite);

void setup() {
  Serial.begin(9600);

  if (DEBUG) {
    while (!Serial);
  }
  // put your setup code here, to run once:

}

void loop() {
  // put your main code here, to run repeatedly:

}
