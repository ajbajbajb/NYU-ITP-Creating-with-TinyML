# %% [markdown]
# You need to use `ipykernel` to use jupyter notebooks in a virtual environment. 
# 
# Just FYI I am not quite used to doing things this way. I'll guess I'll get around to it...
# 
# `pipenv shell`
# `pipenv install ipykernel'
# 
# `python - m ipykernel install - -user - -display-name pipenv_test - -name pipenv_test`
# 
# Then to use this virtual environment in vscode you have to select the kernel from the drop down menu with the different python options on the upper right of the window. It should be the one at the bottom with the name of the virtual environment root folder.

# %% [markdown]
# 

# %%

import serial
import time
import matplotlib.pyplot as plt


# %%

port = '/dev/cu.usbmodem14101'
baud = 9600
timeoutLength = 1


ser = serial.Serial(port, baud, timeout=timeoutLength)  # open serial port
print('You are connected to: ' + ser.name + ' at ' + str(baud))         # check which port was really used
time.sleep(1)

# ser.write(b'hello')     # write a string
# ser.close()             # close port
# s = ser.read()
# print(s)


# %% [markdown]
# Read the port.

# %%
line = ser.readline()
string = line.decode()
string


# %%
data = []
for i in range(200):
    line = ser.readline()
    if line:
        string = line.decode()
        string = int(string.strip())
        print(string)
        data.append(string)


# %%
ser.close()

# %% [markdown]
# Plotting the data on a little chart

# %%
plt.plot(data)
plt.xlabel('Time')
plt.ylabel('Proximity Reading')
plt.title('Proximity Sensor over the a little sequence')
plt.show()

# %%



