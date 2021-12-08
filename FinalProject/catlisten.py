
import serial
import time
import matplotlib.pyplot as plt
from IPython.display import clear_output
import ftplib


f = open("C:/Users/alexj/Desktop/keys.txt")
keys = f.read()
keys = keys.split()
print(keys[0])
HOSTNAME = "gator4252.hostgator.com"
USERNAME = keys[0]
PASSWORD = keys[1]

# %%
# For OSX
# port = '/dev/cu.usbmodem14101'
# FOR WINDOWS

port = 'COM6'
baud = 115200
timeoutLength = 1


ser = serial.Serial(port, baud, timeout=timeoutLength)  # open serial port
ser.flushInput() # used to clear the queue to that data doesn't overlap and create erroneous data points.

def listener():
    while True:
        try:
            # print('You are connected to: ' + ser.name + ' at ' + str(baud))         # check which port was really used
            line = ser.readline()
            string = line.decode()
            string = string.split()
            percent = float(string[1])
            print('Listening...' + str(string[0]) + str(string[1]))
            if percent >= 0.9:
                print('We heard the sound of the Cat Flap...')
                writetosite(1)
                break
        except:
            print('Keyboard Interrupt')
            break
# ser.write(b'hello')     # write a string
# ser.close()             # close port
# s = ser.read()


def writetosite(value):
    JS_str = "let cat = " + str(value) + ";"
    js_file = open("cathere/cat.js", "w")
    js_file.write(JS_str)
    js_file.close()
    ftp_server = ftplib.FTP(HOSTNAME, USERNAME, PASSWORD)
    with open('cat.js', 'rb') as file:
        ftp_server.storbinary(f"STOR cathere/cat.js", file)
    time.sleep(10)
    listener()
# print(s)
listener()




