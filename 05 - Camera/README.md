# Capturing images and training an Image Classifier
For this experiment we're going to use the Arducam Mini 2MP Plus to capture and classify images on the Arduino Nano 33 BLE Sense

## Connecting the camera
### Connect the camera to the Arduino as follows:

| ArduCam Pin | Arduino Pin |
|------------|-------------|
| CS         | D7          |
| MOSI       | D11         |
| MISO       | D12         |
| SCK        | D13         |
| GND        | GND         |
| VCC        | 3.3V        |
| SDA        | A4          |
| SCL        | A5          |

### For reference, here's the Arduino BLE 33 Nano Sense pinout diagram:
![Pinout](images/ble33nanosense_pinout.png?raw=true "Pinout")

### And a picture of a working connection
![Connected](images/connected.png?raw=true "Connected")


## Test connection

### Installing necessary software
1. Install [Processing](https://processing.org/download) if you haven't done so previously
1. ArduCAM:
    1. Download https://github.com/ArduCAM/Arduino and copy its `ArduCAM`
    subdirectory into `Arduino/libraries`.
    1. Edit `Arduino/libraries/ArduCAM/memorysaver.h` and ensure that
    "#define OV2640_MINI_2MP_PLUS" is not commented out. Ensure all other
    defines in the same section are commented out.
1. JPEGDecoder:
    1. Open the Arduino IDE and install `JPEGDecoder` Library Manager
    1. Edit "Arduino/Libraries/JPEGDecoder/src/User_Config.h" and comment out
     "#define LOAD_SD_LIBRARY" and "#define LOAD_SDFAT_LIBRARY".

### Build and upload the (modified) Teachable Machine Arduino sketch
1. Open up the `05a_TM_Uploader_ArduCam/05a_TM_Uploader_ArduCam.ino` sketch in the Arduino IDE.
1. Build and upload

### Run the Processing Image Capture sketch
1. Open Processing
1. Go to `Sketch->Import Library...->Add Library...` and search for and install: 
    * controlP5
    * websockets
1. Open `05a_TM_Connector/TM_Connector/TM_Connector.pde`.
1. Run the sketch.
1. If you get an Error related to javax imports. Try the `05a_TM_Connector/TM_Connector_JavaxFix/TM_Connector_JavaxFix.pde` sketch instead.
1. When the sketch is running - select the port your Arduino is connected to from the dropdown (same port you used to upload the sketch in the Arduino IDE)
1. You should now get a feed from your Arduino / Camera! If not, double check all connections and try again.

## Train a model using the Teachable Machine
1. Go to [https://teachablemachine.withgoogle.com](https://teachablemachine.withgoogle.com/) 
1. Click `Get Started`
1. `Image Project`
1. Select Embedded image model
1. Click `Device` under the class you want to try. You should get a feed from your Arduino - If not, go back to processing and make sure it's still running and getting a feed.
1. Train a model.
1. Download and run on the Arduino