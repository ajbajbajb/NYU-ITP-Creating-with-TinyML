/*
  kNN Color Classifier
*/

// Import the kNN lib, AFTER IMPORTING IT FROM THE LIBRARIES
#include <Arduino_KNN.h>
// Import the sensor lib
#include <Arduino_APDS9960.h>

// Create a KNNClassifier to classify 3 colors
const int NUM_CLASSES = 5;
KNNClassifier classifier(NUM_CLASSES);

// The k in kNN. How many closest neighbors to find and compare too
const int K = 3;

// How many examples to "train" the classifier on
const int NUM_SAMPLES_PER_CLASS = 30; 

// How close we have to be to trigger a read
const int PROXIMITY_THRESHOLD = 1;

// How bright the reading should be
const int BRIGHTNESS_THRESHOLD = 200;

// Names for each class
const String label[NUM_CLASSES] = {"Orange", "White", "Blue - Green", "Red", "Finger"};

// Array holding our current rgb color values
float color[3];

void readColor(float color[]){

    int proximity = 100;
    
    // The detected proximity that may range from 0 to 255 where 0 is the closest and 255 is the farthest.
    while(proximity > PROXIMITY_THRESHOLD){
      // Wait for it to become available
      while (!APDS.proximityAvailable());
      proximity = APDS.readProximity();
//      Serial.print("Proximity: ");
//      Serial.println(proximity);
    }
    
    int r, g, b;
    r = g = b = 0;
    int brightness = 0;
    while( brightness < BRIGHTNESS_THRESHOLD ){
        if (APDS.colorAvailable()) {

            // Read color
            int rTemp, gTemp, bTemp;
            APDS.readColor(rTemp, gTemp, bTemp);
            r += rTemp;
            g += gTemp;
            b += bTemp;

            brightness = r + g + b;
        }
    }

    // Normalize colors to floats between 0 - 1
    color[0] = (float)r / brightness;
    color[1] = (float)g / brightness;
    color[2] = (float)b / brightness;
    
    Serial.print("Read float color: [");
    Serial.print(color[0]);
    Serial.print(",");
    Serial.print(color[1]);
    Serial.print(",");
    Serial.print(color[2]);
    Serial.println("]");
    
}

void collectSamples(){
  
  // Ask user for the name of each object
  for (int currentClass = 0; currentClass < NUM_CLASSES; currentClass++) {

    // Ask user to show examples of each object
    for (int currentExample = 0; currentExample < NUM_SAMPLES_PER_CLASS; currentExample++) {

      Serial.print("Show me an example of ");
      Serial.println(label[currentClass]);

      // Wait for an object then read its color
      readColor(color);

      Serial.print("Captures sample ");
      Serial.print(currentExample);
      Serial.print(" out of ");
      Serial.println(NUM_SAMPLES_PER_CLASS);
      
      // Add example color to the k-NN model
      classifier.addExample(color, currentClass);

    }
      // Wait for the object to move away again
    while (!APDS.proximityAvailable() || APDS.readProximity() < PROXIMITY_THRESHOLD);
  }
}

void blinkResponse(int x) {
  // had to dick around with the numbers to make it work, bc zero index lists
    for (int blinkNum = 1; blinkNum <= (x + 1); blinkNum ++) {
        Serial.print("Blink!");            // let the monitor know it's blinking
        digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
        delay(200);                       // wait a flash
         digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
        delay(200);                       // wait a flash
 
    }
    Serial.println("");
}

void setup() {
  //SETUP LED FOR BLINK RESPONSE
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
  // Wait for serial
  while (!Serial);

  if (!APDS.begin()) {
    Serial.println("Error initializing APDS9960 sensor.");
  }

  Serial.println("Ready to classify colors");

  collectSamples();
}

void loop() {
  int classification;

  // Wait for the object to move away again
  while (!APDS.proximityAvailable() || APDS.readProximity() < PROXIMITY_THRESHOLD );

  Serial.println("Let me guess your object");

  // Wait for an object then read its color
  readColor(color);

  // Classify the object
  classification = classifier.classify(color, K);

  // Print the classification
  Serial.print("You showed me ");
  Serial.println(label[classification]);
  blinkResponse(classification);
}
