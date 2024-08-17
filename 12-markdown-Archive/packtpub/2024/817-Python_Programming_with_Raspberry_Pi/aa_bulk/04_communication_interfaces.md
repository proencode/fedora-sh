
| ≪ [ 03 Conditional Statements, Functions, and Lists ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/03_Conditional_Statements__Functions__and_Lists) | 04 Communication Interfaces | [ 05 Data Types and Object-Oriented Programming in Python ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/05_Data_Types_and_Object-Oriented_Programming_in_Python) ≫ |
|:----:|:----:|:----:|

# 04 Communication Interfaces
Chapter 4. Communication Interfaces
So far, we have discussed loops, conditional statements, and functions in Python. We also discussed interfacing output devices and simple digital input devices.

In this chapter, we will discuss the following communication interfaces:

UART – serial port
Serial Peripheral Interface
I2C interface
Note
We will be making use of different sensors/electronic components to demonstrate writing code in Python for these interfaces. We leave it up to you to pick a component of your choice to explore these communication interfaces.

UART – serial port
Universal Asynchronous Receiver/Transmitter (UART), a serial port, is a communication interface where the data is transmitted serially in bits from a sensor to the host computer. Using a serial port is one of the oldest forms of communication protocol. It is used in data logging where microcontrollers collect data from sensors and transmit the data via a serial port. There are also sensors that transmit data via serial communication as responses to incoming commands.

We will not go into the theory behind serial port communications (there's plenty of theory available on the Web at https://en.wikipedia.org/wiki/Universal_asynchronous_receiver/transmitter). We will be discussing the use of the serial port to interface different sensors with the Raspberry Pi.

Raspberry Pi Zero's UART port
Typically, UART ports consist of a receiver (Rx) and a transmitter (Tx) pin that receive and transmit data. The Raspberry Pi's GPIO header comes with an UART port. The GPIO pins 14 (the Tx pin) and 15 (is the Rx pin) serve as the UART port for the Raspberry Pi:


GPIO pins 14 and 15 are the UART pins (image source: https://www.rs-online.com/designspark/introducing-the-raspberry-pi-b-plus)

Setting up the Raspberry Pi Zero serial port
In order to use the serial port to talk to sensors, the serial port login/console needs to be disabled. In the Raspbian OS image, this is enabled by default as it enables easy debugging.

The serial port login can be disabled via raspi-config:

Launch the terminal and run this command:
sudo raspi-config

Copy

Explain
 

Select Advanced Options from the main menu of raspi-config:

Select Advanced Options from the raspi-config menu

Select the A8 Serial option from the drop-down menu:

Select A8 Serial from the dropdown

Disable serial login:

Disable serial login

Finish the configuration and reboot at the end:

Save config and reboot

Example 1 – interfacing a carbon dioxide sensor to the Raspberry Pi
We will be making use of the K30 carbon dioxide sensor (its documentation is available here, http://co2meters.com/Documentation/Datasheets/DS30-01%20-%20K30.pdf). It has a range of 0-10,000 ppm, and the sensor provides it carbon dioxide concentration readings via serial port as a response to certain commands from the Raspberry Pi.

The following diagram shows the connections between the Raspberry Pi and the K30 carbon dioxide sensor:


K30 carbon dioxide sensor interfaced with the Raspberry Pi

The receiver (Rx) pin of the sensor is connected to the transmitter (Tx-GPIO 14 (UART_TXD)) pin of the Raspberry Pi Zero (the yellow wire in the preceding figure). The transmitter (Tx) pin of the sensor is connected to the receiver (Rx-GPIO 15 (UART_RXD)) pin of the Raspberry Pi Zero (the green wire in the preceding figure).

In order to power the sensor, the G+ pin of the sensor (the red wire in the preceding figure) is connected to the 5V pin of the Raspberry Pi Zero. The G0 pin of the sensor is connected to the GND pin of the Raspberry Pi Zero (black wire in the earlier figure).

Typically, serial port communication is initiated by specifying the baud rate, the number of bits in a frame, stop bit, and flow control.

Python code for serial port communication
We will make use of the pySerial library (https://pyserial.readthedocs.io/en/latest/shortintro.html#opening-serial-ports) for interfacing the carbon dioxide sensor:

As per the sensor's documentation, the sensor output can be read by initiating the serial port at a baud rate of 9600, no parity, 8 bits, and 1 stop bit. The GPIO serial port is ttyAMA0. The first step in interfacing with the sensor is initiating serial port communication:
       import serial 
       ser = serial.Serial("/dev/ttyAMA0")

Copy

Explain
As per the sensor documentation (http://co2meters.com/Documentation/Other/SenseAirCommGuide.zip), the sensor responds to the following command for the carbon dioxide concentration:

Command to read carbon dioxide concentration from the sensor-borrowed from the sensor datasheet

The command can be transmitted to the sensor as follows:
       ser.write(bytearray([0xFE, 0x44, 0x00, 0x08, 0x02, 0x9F, 0x25]))

Copy

Explain
The sensor responds with a 7-byte response, which can be read as follows:
       resp = ser.read(7)

Copy

Explain
 

The sensor's response is in the following format:

Carbon dioxide sensor response

According to the datasheet, the sensor data size is 2 bytes. Each byte can be used to store a value of 0 and 255. Two bytes can be used to store values up to 65,535 (255 * 255). The carbon dioxide concentration could be calculated from the message as follows:
       high = resp[3] 
       low = resp[4] 
       co2 = (high*256) + low

Copy

Explain
Put it all together:
       import serial 
       import time 
       import array 
       ser = serial.Serial("/dev/ttyAMA0") 
       print("Serial Connected!") 
       ser.flushInput() 
       time.sleep(1) 

       while True: 
           ser.write(bytearray([0xFE, 0x44, 0x00, 0x08,
           0x02, 0x9F, 0x25])) 
           # wait for sensor to respond 
           time.sleep(.01) 
           resp = ser.read(7) 
           high = resp[3] 
           low = resp[4] 
           co2 = (high*256) + low 
           print() 
           print() 
           print("Co2 = " + str(co2)) 
           time.sleep(1)

Copy

Explain
Save the code to a file and try executing it.
I2C communication
Inter-Integrated Circuit (I2C) communication is a type of serial communication that allows interfacing multiple sensors to the computer. I2C communication consists of two wires of a clock and a data line. The Raspberry Pi Zero's clock and data pins for I2C communication are GPIO 3 (SCL) and GPIO 2 (SDA), respectively. In order to communicate with multiple sensors over the same bus, sensors/actuators that communicate via I2C protocol are usually addressed by their 7-bit address. It is possible to have two or more Raspberry Pi boards talking to the same sensor on the same I2C bus. This enables building a sensor network around the Raspberry Pi.

The I2C communication lines are open drain lines; hence, they are pulled up using resistors, as shown in the following figure:


I2C setup

Let's review an example of I2C communication using an example.

Example 2 – PiGlow
The PiGlow is a piece of add-on hardware for the Raspberry Pi that consists of 18 LEDs interfaced with the SN3218 chip. This chip permits controlling the LEDs via the I2C interface. The chip's 7-bit address is 0x54.

To interface the add-on hardware, the SCL pin is connected to GPIO 3 and SDA pin to GPIO 2; the ground pins and the power supply pins are connected to the counterparts of the add-on hardware, respectively.

The PiGlow comes with a library that comes which abstracts the I2C communication: https://github.com/pimoroni/piglow.

Although the library is a wrapper around the I2C interface for the library, we recommend reading through the code to understand the internal mechanism to operate the LEDs:


PiGlow stacked on top of the Raspberry Pi

Installing libraries
The PiGlow library may be installed by running the following from the command-line terminal:

curl get.pimoroni.com/piglow | bash

Copy

Explain
Example
On the completion of installation, switch to the example folder (/home/pi/Pimoroni/piglow) and run one of the examples:

python3 bar.py

Copy

Explain
It should run blinky light effects as shown in the following figure:


Blinky lights on the PiGlow

Similarly, there are libraries to talk to real-time clocks, LCD displays, and so on using I2C communication. If you are interested in writing your own interface that provides the nitty-gritty detail of I2C communication with sensors/output devices, check out this book's accompanying website for some examples.

Example 3 – Sensorian add-on hardware for the Raspberry Pi
The Sensorian is an add-on hardware designed for the Raspberry Pi. This add-on hardware comes with different types of sensors, including a light sensor, barometer, accelerometer, LCD display interface, flash memory, capacitive touch sensors, and a real-time clock.

The sensors on this add-on hardware is sufficient to learn using all the communication interfaces discussed in this chapter:


Sensorian hardware stacked on top of the Raspberry Pi Zero

In this section, we will discuss an example where we will measure the ambient light levels using a Raspberry Pi Zero via the I2C interface. The sensor on the add-on hardware board is the APDS-9300 sensor (www.avagotech.com/docs/AV02-1077EN).

I2C drivers for the lux sensor
The drivers are available from the GitHub repository for the Sensorian hardware (https://github.com/sensorian/sensorian-firmware.git). Let's clone the repository from the command-line terminal:

git clone https://github.com/sensorian/sensorian-firmware.git 

Copy

Explain
Let's make use of the drivers (which is available in the  ~/sensorian-firmware/Drivers_Python/APDS-9300 folder) to read the values from the two ADC channels of the sensor:

import time 
import APDS9300 as LuxSens 
import sys 

AmbientLight = LuxSens.APDS9300() 
while True: 
   time.sleep(1) 
   channel1 = AmbientLight.readChannel(1)                       
   channel2 = AmbientLight.readChannel(0) 
   Lux = AmbientLight.getLuxLevel(channel1,channel2) 
   print("Lux output: %d." % Lux)

Copy

Explain
With the ADC values available from both the channel, the ambient light value can be calculated by the driver using the following formula (retrieved from the sensor datasheet):


Ambient light levels calculated using the ADC values

This calculation is performed by the attribute getLuxLevel. Under normal lighting conditions, the ambient light level (measured in lux) was around 2. The measured output was 0 when we covered the lux sensor with the palm. This sensor could be used to measure ambient light and adjust the room lighting accordingly.

Challenge
We discussed measuring ambient light levels using the lux sensor. How do we make use of the lux output (ambient light levels) to control the room lighting?

The SPI interface
There is another type of serial communication interface named the Serial Peripheral Interface (SPI). This interface has to be enabled via raspi-config (this is similar to enabling serial port interface earlier in this chapter). Using the SPI interface is similar to that of I2C interface and the serial port.

Typically, an SPI interface consists of a clock line, data-in, data-out, and a Slave Select (SS) line. Unlike I2C communication (where we could connect multiple masters), there can be only one master (the Raspberry Pi Zero), but multiple slaves on the same bus. The SS pin enables selecting a specific sensor that the Raspberry Pi Zero is reading/writing data when there are multiple sensors connected to the same bus.

Example 4 – writing to external memory chip
Let's review an example where we write to a flash memory chip on the Sensorian add-on hardware via the SPI interface. The drivers for the SPI interface and the memory chip are available from the same GitHub repository.

Since we already have the drivers downloaded, let's review an example available with drivers:

import sys 
import time   
import S25FL204K as Memory

Copy

Explain
Let's initialize and write the message hello to the memory:

Flash_memory = Memory.S25FL204K() 
Flash_memory.writeStatusRegister(0x00) 
message = "hello" 
flash_memory.writeArray(0x000000,list(message), message.len())

Copy

Explain
Now, let's try to read the data we just wrote to the external memory:

data = flash_memory.readArray(0x000000, message.len()) 
print("Data Read from memory: ") 
print(''.join(data))

Copy

Explain
The code sample is available for download with this chapter (memory_test.py).

We were able to demonstrate using the SPI to read/write to an external memory chip.

Challenge to the reader
In the figure here, there is an LED strip (https://www.adafruit.com/product/306) interfaced to the SPI interface of the Raspberry Pi add on hardware using the Adafruit Cobbler (https://www.adafruit.com/product/914). We are providing a clue on how to interface the LED strip to the Raspberry Pi Zero. We would like to see if you are able to find a solution to interface the LED strip by yourself. Refer to this book's website for the answer.


LED strip interfaced with the Adafruit Cobbler for the Raspberry Pi Zero

Summary
In this chapter, we have discussed different communication interfaces that are available on the Raspberry Pi Zero. These interfaces include I2C, SPI, and UART. We will be making use of these interfaces in our final projects. We discussed these interfaces using a carbon dioxide sensor, LED driver, and a sensor platform. In the next chapter, we will discuss object-oriented programming and its distinct advantages. We will discuss the need for object-oriented programming using an example. Object-oriented programming can be especially helpful in scenarios where you have to write your own drivers to control a component of your robot or write an interface library for a sensor.



| ≪ [ 03 Conditional Statements, Functions, and Lists ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/03_Conditional_Statements__Functions__and_Lists) | 04 Communication Interfaces | [ 05 Data Types and Object-Oriented Programming in Python ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/05_Data_Types_and_Object-Oriented_Programming_in_Python) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 04 Communication Interfaces
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/04_Communication_Interfaces
> Book Title: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> tags: Python RaspPi
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 11:35:57
> .md Name: 04_communication_interfaces.md

