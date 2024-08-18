
| ≪ [ 08 Awesome Things You Could Develop Using Python ](/packtpub/2024/817-Python_with_RaspPi_1ed/08_Awesome_Things_You_Could_Develop_Using_Python) | 09 Let's Build a Robot | [ 10 Home Automation Using The Raspberry Pi Zero ](/packtpub/2024/817-Python_with_RaspPi_1ed/10_Home_Automation_Using_The_Raspberry_Pi_Zero) ≫ |
|:----:|:----:|:----:|

# 09 Let's Build a Robot
Chapter 9. Lets Build a Robot!
In this chapter, we built an indoor robot (using the Raspberry Pi Zero as the controller) and documented our experience in a step-by-step guide. We wanted to demonstrate the awesomeness of the combination of Python programming language and the Raspberry Pi Zero's peripherals. We have also included suggestions to build an outdoor robot as well as suggestions for additional accessories for your robot. At the end of this chapter, we have included additional learning resources to build your own robot. Let's get started!

Note
In this chapter, we are going to access the Raspberry Pi Zero via remote login (SSH) and remotely transferred files from the Raspberry Pi Zero. If you are not familiar with the command-line interface, we recommend proceeding to Chapter 11, Tips and Tricks, to set up your local desktop environment.


A Raspberry Pi Zero powered robot

Since we will be making use of a camera for our robot, Raspberry Pi Zero v1.3 or higher is needed for this chapter. Your Raspberry Pi Zero's board version is available on the back. Refer to the following picture:


Identifying your Raspberry Pi Zero's version

Components of the robot
Let's discuss the components of the robot using the labeled picture as an aid (shown in the following figure):


Components of the robot

The following is an explanation for the components of the robot:

The Raspberry Pi Zero controls the movement of the robot using a motor driver circuit (stacked on top of the Raspberry Pi Zero)
The motors of the robot are connected to the motor driver circuit
A USB battery pack is used to power the Raspberry Pi Zero. A separate AA battery pack is used to drive the motors
The robot is also equipped with a camera module that helps with driving the robot
We have included a suggested list of components where we chose the cheapest source available for the component. You are welcome to substitute with your own components. For example, you can use a webcam instead of using the Raspberry Pi camera module:

Component

Source

Quantity

Price (in USD)

Chassis

https://www.adafruit.com/products/2943

1

9.95

Chassis top plate

https://www.adafruit.com/products/2944

1

4.95

A set of M2.5 rows, spacers, and nuts

http://a.co/dpdmb1B



1

11.99

DC motors in servo body

https://www.adafruit.com/products/2941

2

3.50

Wheel

https://www.adafruit.com/products/2744

2

2.50

Castor wheel

https://www.adafruit.com/products/2942

1

1.95

Raspberry Pi Zero

https://www.adafruit.com/products/3400

1

5.00

A Raspberry Pi Zero camera module

http://a.co/07iFhxC



1

24.99

A Raspberry Pi Zero camera adapter

https://www.adafruit.com/products/3157

1

5.95

A motor driver circuitry for Raspberry Pi Zero

https://www.adafruit.com/products/2348

1

22.50

USB battery pack

http://a.co/9vQLx2t

1

5.09

AA battery pack (4 batteries)

http://a.co/hVPxfzD

1

5.18

AA batteries

NA

4

N.A.

Raspberry Pi camera module mount

https://www.adafruit.com/products/1434

1

4.95

In the interest of saving time, we chose off-the-shelf accessories to build robot. We specifically chose Adafruit for the ease of purchase and shipping. If you are interested in building a robot that needs to suit outdoor conditions, we recommend a chassis similar to http://www.robotshop.com/en/iron-man-3-4wd-all-terrain-chassis-arduino.html.

As makers, we recommend making your own chassis and control circuitry (especially the motor drive). You can make use of software such as Autodesk Fusion (the link is available in the resources section) to design the chassis.

Setting up remote login
To control the robot remotely, we need to set up remote login access, that is, enable the SSH access. Secure Shell (SSH), and it is a protocol that enables remote access of a computer. The SSH access is disabled by default on the Raspbian operating system for security reasons. In this section, we will enable the SSH access to the Raspberry Pi Zero and change the Raspberry Pi Zero's default password.

Note
If you are not familiar with the SSH access, we have provided a quick tutorial in Chapter 11, Tips and Tricks. We would like to keep the focus on building the robot in this chapter.

Changing the password
Before we enable the SSH access, we need to change the default password of the Raspberry Pi Zero. This is to avoid any potential threat to your computer and your robot! We have advocated changing default passwords on multiple occasions in this chapter. Default passwords have wreaked havoc across the Internet.

Note
Recommended reading Mirai botnet attack: http://fortune.com/2016/10/23/internet-attack-perpetrator/.

On your desktop, go to Menu | Preferences and launch Raspberry Pi Configuration. Under the System tab, there is an option to change the password under the System tab (shown in the following screenshot):


Change your Raspberry Pi Zero's default password

Enabling SSH access
Under the Interfaces tab of the Raspberry Pi configuration, select Enable for SSH (as shown in the following screenshot):


Enable SSH under the Interfaces tab

Reboot your Raspberry Pi Zero, and you should be able to access your Raspberry Pi Zero via SSH.

Note
Refer to Chapter 11, Tips and Tricks, for the SSH access to your Raspberry Pi Zero from Windows, *nix operating systems (beyond the scope of this chapter).

Chassis setup
The robot is going to have a differential steering mechanism. Thus, it is going to be steered by two motors. It is going to be supported by a third castor that acts as a support.

In a differential steering mechanism arrangement, the robot moves in the forward direction or backward direction when both the wheels of the robot are rotating in the same direction. The robot can turn left or right by rotating one wheel faster than the other wheel. For example, in order to rotate left, the right motor needs to rotate faster than the left and vice versa.

In order to reach a better understanding of the differential steering mechanism, we recommend building out the chassis and testing it with the Raspberry Pi Zero (We are going to test our chassis using a simple program in the later part of this chapter).

Note
We have provided additional resources on differential steering at the end of this chapter.


Chassis prep for the robot

The chassis comes with the required provisions along with the screws required to mount the motors. Ensure that the motor's wires are facing the same side (Refer to the picture given later). Similarly, the castor wheel can be assembled at the front, as shown in the picture here:

Assemble motors and mount castor wheels

The next step is mounting the wheels. The wheels are designed to be press-fitted directly onto the motor shaft.

Assembling wheels onto the servo



Lock the wheels in place using a screw (comes with the wheels)

Lock the wheel onto the shaft

Thus, we are done setting up the chassis for the robot. Let's move on to the next section.

Motor driver and motor selection
The motor driver circuit (https://www.adafruit.com/product/2348) can be used to connect four DC motors or two stepper motors. The motor driver is rated to provide 1.2 A of current per motor under continuous operation. This sufficiently meets the robot's motor power requirement.

Preparing the motor driver circuit
The motor driver circuit comes as a kit, and it requires some soldering (shown in the figure here).


Adafruit DC and Stepper Motor HAT for Raspberry Pi-Mini Kit (picture source: adafruit.com)

The first step in the assembly process is to solder the 40 pin header. Stack the header on top of your Raspberry Pi Zero and as shown in the picture here:

Stack the header on top of the Raspberry Pi Zero



Position the motor driver (as shown in the picture here) on top of the header. Hold on to the motor driver board so that the board is not tilted while soldering.

Stack the motor HAT on top of the Raspberry Pi Zero

Solder the corner pins of the motor driver first and proceed to solder the other pins.

Note the motor driver board soldered such that the board is parallel to the Raspberry Pi Zero

Now, solder the 3.5 mm terminals (see the blue colored ones in the picture) by flipping the board

Solder the 3.5 mm terminals

The motor driver board is ready to use!

The motor driver is ready to use

Raspberry Pi Zero and motor driver assembly
In this section, we are going to test the movements of the robot. This includes testing the motor driver and basic movements of the robot.

Raspberry Pi Zero and motor driver assembly
In this section, we are going to assemble the Raspberry Pi Zero and the motor driver on to the robot chassis.

In order to mount the Raspberry Pi Zero on to the chassis, we need 4 M2.5 screws and nuts (Mounting hole specification available at https://www.raspberrypi.org/documentation/hardware/raspberrypi/mechanical/rpi-zero-v1_2_dimensions.pdf).
The chassis we selected comes with slots that enables mounting the Raspberry Pi Zero directly on to the chassis. Based on your chassis design, you may have to drill clearance holes to mount the Raspberry Pi Zero.

Mounting the Raspberry Pi Zero onto the chassis

Note
While mounting the Raspberry Pi Zero, we ensured that we are able to plug in the HDMI cable, USB cable, and so on for testing purposes.



The chassis we have used is made of anodized aluminum;hence, it is nonconductive. We mounted the Raspberry Pi Zero directly, without any insulation between the chassis and the Raspberry Pi Zero.
Note
Ensure that you don't short circuit any component by accidentally exposing them directly to conductive metal surfaces.

Stack the motor driver on top of the Raspberry Pi Zero (as shown in the previous section).
The two motors of the robot need to be connected to the Raspberry Pi Zero:
The motor driver comes with motor terminals M1 through M4. Let's connect the left and right DC motors to M1 and M2, respectively.

Red and black wires connected from both the motors to the motor driver terminals

Each motor comes with two terminals, that is, black wire and a red wire. Connect the black wire to the left-most terminal of the bridge M1 and the red wire to the right-hand side terminal of the bridge M1 (as shown in the picture earlier). Similarly, the right motor is connected to the bridge M2.
Now, that we have connected the motors, we need to test the motor function and verify that the motors are rotating in the same direction. In order to do so, we need to set up the robot's power supply.

Robot Power supply setup
In this section, we will discuss setting up the power supply for the Raspberry Pi Zero. We will discuss powering the Raspberry Pi Zero and the motors of the robot. Let's discuss the major components of our robot and their power consumption:

The Raspberry Pi Zero requires a 5V power supply, and it draws about 150 mA of current (Source: http://raspberrypi.stackexchange.com/a/40393/1470).
The two DC motors of the robot consume about 150 mA each.
The camera module consumes 250 mA of current (Source: https://www.raspberrypi.org/help/faqs/#cameraPower).
The total power consumption estimate is about 550 mA (150 + 150*2 + 250).

In order to calculate the battery capacity, we also need to decide the duration of continuous operation before requiring a recharge. We wanted the robot to operate at least for 2 hours before requiring a recharge. The battery capacity can be calculated using the following formula:


In our case, this would be:

550mA * 2 hours = 1100 mAh

Note
We also found a battery life calculator from Digi-Key:http://www.digikey.com/en/resources/conversion-calculators/conversion-calculator-battery-life

According to the Digi-Key calculator, we need to account for factors that affect the battery life. Accounting for such factors, the battery capacity would be:

1100 mAh /0.7 = 1571.42 mAh

We took this number into account while purchasing a battery for the robot. We decided to purchase this 2200mAh USB battery pack that operates at 5V (shown in the picture later and the link for purchase has been shared with the bill of materials discussed earlier in this chapter):


2200 mAh 5V USB battery pack

Ensure that the battery pack is fully charged before assembling it on to the robot:

Once the battery pack is fully charged, mount it on to the robot using double-sided tape and plug a micro-USB cable, as shown in the picture:

2200 mAh 5V USB battery pack

We need to verify that the Raspberry Pi Zero powers up when a battery pack is used.
Plug in the HDMI cable (that is connected to a monitor) and using a very short micro-USB cable, try to power up the Raspberry Pi Zero and make sure that everything powers up correctly.
Setting up the motor power supply
Now that we have set up the power supply for the robot and verified that the Raspberry Pi Zero powers up using the USB battery pack, we will discuss power supply options to drive the motors of the robot. We are discussing this because the type of motor, and its power supply determines the performance of our robot. Let's get started!

Let's revisit the motor driver that we set up in the previous section. The unique feature of this motor driver is that it is equipped with its own voltage regulator and polarity protection. Thus, it enables connecting an external power supply to power the motors (shown in the picture here)


Motor driver power terminals

This motor driver enables driving any motor with a voltage requirement of 5-12V and current rating of 1.2A. There are two options to power the motors of your robot:

Using the Raspberry Pi Zero's 5V GPIO power supply
Using an external power supply
Using the Raspberry Pi Zero's 5V power supply
The motor driver is designed such that it can act as a prototyping platform. There is a bank of 5V and 3.3V power supply pins that is connected to the Raspberry Pi Zero's 5V and 3.3V GPIO pins. These GPIO pins are rated to provide a current of 1.5A (Source: https://pinout.xyz/pinout/pin2_5v_power). They are directly connected to the 5V USB input of your Raspberry Pi Zero. (The USB battery pack used in this robot is rated to provide an output of 5V, 1 A).

The first step in connecting the Raspberry Pi's 5V GPIO power supply is soldering a red and black piece of wire (of appropriate length) from the 5V and GND pins, respectively (as shown in the figure here):

Solder red and black pieces of wires from 5V and GND pins

Now, connect the red and black wires to terminal marked 5-12V motor power (Red wire goes to + and Black wire goes to -).

Connect 5V and GND to the motor power supply terminals

Now, power up your Raspberry Pi Zero and measure the voltage across your motor power supply terminals. It should be receiving 5V, and the power LED of the motor driver should be glowing green (as shown in the next picture). If not, check the solder connections of the motor driver.

Green LED lights up when the Raspberry Pi Zero is powered up

This method is useful only when low-power motors are used (like the ones used in this chapter). If you have a motor with a higher voltage rating (voltage rating greater than 5V), you need to connect an external power supply. We will review connecting an external power supply in the next section.
Note
If you find your Raspberry Pi Zero constantly resetting itself while driving your robot, it is possible that the USB battery pack is not able to drive the robot's motors. It is time to connect an external power supply!

Using an external power supply
In this section, we are going to discuss connecting an external power supply to drive the motors. We will discuss connecting a 6V power supply to power the motors.

We will make use of a battery pack that consists of 4 AA batteries to drive the motors (battery packs available at http://a.co/hVPxfzD).
We need to install the battery pack such that it leads could be connected to the motor drivers power terminals.
The robot chassis kit came with an additional aluminum plate that could be used to install the battery pack (shown in the figure here):

Additional aluminium plate to hold the battery pack

We made use of four M2.5 stand-offs (shown in the picture) to hold the aluminum plate:

Assemble M2.5 stand-offs to hold the aluminium plate

Now, we used M2.5 screws to secure the aluminum plate (as shown in the figure here):

Secure the aluminium plate

Using double-sided tape, the battery pack was installed (the battery pack contains four AA batteries) on top of the aluminum plate. Then, the red and black wires of the battery pack are connected to the + and - terminals of the motor driver, respectively (as shown in the figure here).

Battery installed on the aluminium plate

Slide the battery pack switch to ON, and the motor driver should turn on as explained in the previous section.
Thus, the power supply setup is complete. In the next section, we will discuss taking the robot on a test drive.

Note
If you are looking for a battery with a higher capacity for your robot, we recommend considering LiPo batteries. This also means that you need motors with a better rating and a chassis that can withstand the battery weight.

Testing the motors
In this section, we will verify that the motor driver is detected by the Raspberry Pi Zero and test the motor function. In the test, we will verify that the motors are rotating in the same direction.

Motor driver detection
In this section, we will verify that the motor driver is detected by the Raspberry Pi Zero. The Raspberry Pi Zero talks to the motor driver via the I2C interface (Refer to Chapter 4, Communication Interfaces, if you are not familiar with the I2C interface). Hence, we need to enable the I2C interface of the Raspberry Pi Zero. There are two ways to enable the I2C interface:

Method 1: From the Desktop

Like enabling ssh by launching the Raspberry Pi Configuration from your Raspberry Pi Zero's desktop, you can enable the I2C interface from the interface tab of the configuration (shown in the snapshot here):


Enable I2C interface

Method 2: From the command line

We strongly recommend using this method as a practice toward getting comfortable with the command-line interface on the Raspberry Pi and remote login via ssh.

Log in to your Raspberry Pi Zero via ssh (Refer to Chapter 11, Tips and Tricks, for a tutorial on the ssh access).
Upon login, launch raspi-config as follows:
sudo raspi-config.

Copy

Explain


It should launch the config options menu (shown in the screenshot here):

The raspi-config menu

Select Option 7: Advanced Options (using the keyboard) and select A7: I2C

Select the I2C interface

Select Yes to enable the I2C interface.

Enable the I2C interface

Now that the I2C interface is enabled, let's get started with detecting the motor driver.
Detecting motor driver
The motor driver is connected to I2C port-1 (the I2C port-0 serves a different purpose. Refer to Chapter 11, Tips and Tricks, for more information). We will make use of the i2cdetect command to scan for devices connected via the I2C interface. On your command-line interface, run the following command:


sudo i2cdetect -y 1

Copy

Explain
It provides an output that looks like this:



0

1

2

3

4

5

6

7

8

9

a

b

c

d

e

f


00:

-- -- -- -- -- -- -- -- -- -- -- -- --


10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


60: 60 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --


70: 70 -- -- -- -- -- -- --


Copy

Explain
I2C chips come with a 7-bit address that is used to identify the chip and establish communication. In this case, the I2C interface address is 0x60 (refer to the motor driver documentation at https://learn.adafruit.com/adafruit-dc-and-stepper-motor-hat-for-raspberry-pi). As shown in the output earlier, the Raspberry Pi Zero detects the motor driver. It is time to test if we can control the motors.

Motor test
In this section, we are going to test the motors; that is, determine if we can drive the motors using the motor driver. In this test, we determined if the Raspberry Pi's supply was sufficient to drive the motors (or whether an external battery pack) was necessary.

In order to get started, we need to install the motor driver libraries (distributed by Adafruit under MIT license) and its dependency packages.

Dependencies
The dependencies for the motor driver libraries may be installed from the command-line terminal of your Raspberry Pi Zero as follows (you may skip this step if you installed these tools while working on Chapter 4, Communication Interfaces):

sudo apt-get update
    sudo apt-get install python3-dev python3-smbus

Copy

Explain
The next step is cloning the motor driver library:

git clone https://github.com/sai-y/Adafruit-Motor-HAT-Python-
    Library.git

Copy

Explain
Note
This library is a fork of the Adafruit Motor HAT library. We fixed some issues to make the library installation compatible with Python 3.x.

The library can be installed as follows:

cd Adafruit-Motor-HAT-Python-Library
    sudo python3 setup.py install

Copy

Explain
Now that the libraries are installed, let's write a program that rotates the motors continuously:

As always, the first step is importing the MotorHAT module:
       from Adafruit_MotorHAT import Adafruit_MotorHAT,
       Adafruit_DCMotor

Copy

Explain
The next step is to create an instance of the MotorHAT class and establish the interface with the motor driver (as discussed in the previous section, the motor driver's 7-bit address is 0x60).
The motors of the robot are connected to channels 1 and 2. Hence, we need to initialize two instances of the Adafruit_DCMotor class that represent the left and right motors of the robot:
       left_motor = motor_driver.getMotor(1)
       right_motor = motor_driver.getMotor(2)

Copy

Explain
The next step is setting the motor speed and motor direction. The motor speed can be set using an integer between 0 and 255 (which corresponds to 0% and 100% of the motor's rated rpm). Let's set the motor speed at 100%:
       left_motor.setSpeed(255)
       right_motor.setSpeed(255)

Copy

Explain
Let's rotate the motors in the forward direction:
       left_motor.run(Adafruit_MotorHAT.FORWARD)
       right_motor.run(Adafruit_MotorHAT.FORWARD)

Copy

Explain
Let's rotate both the motors in the forward direction for 5 seconds and then reduce the speed:
       left_motor.setSpeed(200)
       right_motor.setSpeed(200)

Copy

Explain
Now, let's rotate the motors in the reverse direction:
       left_motor.run(Adafruit_MotorHAT.BACKWARD)
       right_motor.run(Adafruit_MotorHAT.BACKWARD)

Copy

Explain
Let's turn off the motors once we are done rotating the motors in the reverse direction for 5 seconds:
       left_motor.run(Adafruit_MotorHAT.RELEASE)
       right_motor.run(Adafruit_MotorHAT.RELEASE)

Copy

Explain
Putting it altogether:

from Adafruit_MotorHAT import Adafruit_MotorHAT, Adafruit_DCMotor
from time import sleep


if __name__ == "__main__":
  motor_driver = Adafruit_MotorHAT(addr=0x60)

  left_motor = motor_driver.getMotor(1)
  right_motor = motor_driver.getMotor(2)

  left_motor.setSpeed(255)
  right_motor.setSpeed(255)

  left_motor.run(Adafruit_MotorHAT.FORWARD)
  right_motor.run(Adafruit_MotorHAT.FORWARD)

  sleep(5)

  left_motor.setSpeed(200)
  right_motor.setSpeed(200)

  left_motor.run(Adafruit_MotorHAT.BACKWARD)
  right_motor.run(Adafruit_MotorHAT.BACKWARD)

  sleep(5)

  left_motor.run(Adafruit_MotorHAT.RELEASE)
  right_motor.run(Adafruit_MotorHAT.RELEASE)

Copy

Explain
The preceding code sample is available for download along with this chapter as motor_test.py. Recharge the USB battery pack before you test the motors. We picked the test duration long enough to verify the motor direction, performance, and so on.

Note
If your Raspberry Pi Zero seems to be resetting itself while running or the motors aren't running at the rated speed, it is an indicator that the motors are not being driven with the sufficient current. Switch over to a power source that meets the requirement (this may involve switching from the GPIO's power supply to the battery pack or switching to a battery pack of higher capacity).

Now that the motors are tested, let us set up a camera for the robot.

Camera setup
Note
You will need a Raspberry Pi Zero 1.3 or higher to set up the camera. We discussed identifying your Raspberry Pi Zero's board version at the beginning of this chapter. You may also skip this section if you are familiar with setting up the camera from Chapter 8, Awesome Things You Could Develop Using Python.

In this section, we will set up the camera for the robot. The Raspberry Pi Zero (v1.3 onward) comes with a camera adapter. This enables adding a camera module to the robot (designed and manufactured by the Raspberry Pi foundation). The camera module was designed to suit different models of the Raspberry Pi.

The Raspberry Pi Zero's camera interface needs an adapter that is different than the ones meant for other models. The sources to purchase the camera and the adapter were shared with the bill of materials of this chapter.

Let's get started:

Ensure that your Raspberry Pi Zero is powered down and identify the shorter side of the camera adapter. In the image shown here, the shorter side is to the right.

Pi Zero Camera Adapter-Image source: adafruit.com

Carefully, slide out the camera interface of the Raspberry Pi zero (as shown in the picture here). Pay attention to avoid breaking your camera interface tab.

Slide the tabs of the camera interface carefully

Gently slide in the camera module. Latch the camera adapter cable and gently tug on it to make sure that the adapter cable doesn't slide out of its position. The camera adapter should be seated, as shown in the picture here.

Camera adapter placement

Repeat the exercise for the other end of the camera adapter to interface it with the camera module.

Insert adapter on the other side

The camera adapter cable can be unwieldy while trying to install the camera on the robot. We recommend installing a mount (source shared in the bill of materials).

Raspberry Pi camera module mount

Using the double-sided tape, install the camera to the front of your robot.

Camera mounted in front of the robot

Log in to your Raspberry Pi Zero's desktop via ssh to enable and test the camera interface.
Enabling the camera interface is similar to enabling the I2C interface discussed earlier in this chapter. Launch Raspberry Pi configuration using the raspi-config command:
sudo raspi-config

Copy

Explain
Select Option P1: Enable Camera (found under Interfacing Options of the main configuration menu) and enable the camera:


The screenshot of the Raspberry Configuration screen

Reboot your Raspberry Pi Zero!
Verification of camera function
Once your reboot is complete, run the following command from the Command Prompt:
raspistill -o test_picture

Copy

Explain
Since your robot is completely assembled, the HDMI port of your Raspberry Pi Zero is probably inaccessible. You should retrieve the file using the scp command.
Note
On a Windows Machine, you can copy files from your Raspberry Pi Zero using a tool such as WinSCP. On a Mac/Linux desktop, you can use the scp command. Refer to Chapter 11, Tips and Tricks, for a detailed tutorial on remote login and copying of files from your Raspberry Pi Zero.

scp pi@192.168.86.111:/home/pi/test_output.

Copy

Explain
Examine the picture taken using the Raspberry Pi camera module to verify its function

Picture of a coffee cup taken using the Raspberry Pi camera module

Now that we have verified the function of the robot's components, we are going to bring everything together in the next section.

The web interface
Our objective behind building this robot as one of our final projects is to demonstrate using the topics discussed in this book in application development. To that end, we are going to make use of object-oriented programming and web frameworks to build a web interface to control the robot.

In Chapter 7, Requests and Web Frameworks, we discussed the flask web framework. We are going to make use of flask to stream a live view of the camera module to a browser. We are also going to add buttons to the web interface that enables steering the robot. Let's get started!

Note
Refer to Chapter 7, Requests and Web Frameworks, for installation instructions and a basic tutorial on the flask framework.

Let's get started by implementing a simple web interface where we add four buttons to control the robot in the forward, reverse, left, and right directions. Let's assume that the robot moves at maximum speed in all directions.

We are going to make use of object-oriented programming to implement the motor control. We are going to demonstrate the use of object-oriented programming to simplify things (this concept of simplification is known as abstraction). Let's implement a Robot class that implements the motor control. This Robot class would initialize the motor driver and handle all control functions of the robot.

Open a file named robot.py to implement the Robot class.
In order to control the movement of the robot, the robot needs the motor driver channels that are being used (to drive the motors) as inputs during initialization.
Hence, the __init__() function of the Robot class would be something as follows:
       import time
       from Adafruit_MotorHAT import Adafruit_MotorHAT


       class Robot(object):
         def __init__(self, left_channel, right_channel):
           self.motor = Adafruit_MotorHAT(0x60)
           self.left_motor = self.motor.getMotor(left_channel)
           self.right_motor = self.motor.getMotor(right_channel)

Copy

Explain
In the preceding code snippet, the __init__() function requires the channels being used to connect the left and right motors to the motor driver board as arguments.
When an instance of the Robot class is created, the motor driver (Adafruit_MotorHAT) is initialized and the motor channels are initialized.
Let's write methods to move the robot in the forward and reverse directions:
       def forward(self, duration):
         self.set_speed()
         self.left_motor.run(Adafruit_MotorHAT.FORWARD)
         self.right_motor.run(Adafruit_MotorHAT.FORWARD)
         time.sleep(duration)
         self.stop()

       def reverse(self, duration):
         self.set_speed()
         self.left_motor.run(Adafruit_MotorHAT.BACKWARD)
         self.right_motor.run(Adafruit_MotorHAT.BACKWARD)
         time.sleep(duration)
         self.stop()

Copy

Explain
Let's also write methods to move the robot in left- and right-hand side directions. In order to turn the robot left, we need to turn the left motor off and keep the right motor on and vice versa. This creates a turning moment and turns the robot in that direction:
       def left(self, duration):
         self.set_speed()
         self.right_motor.run(Adafruit_MotorHAT.FORWARD)
         time.sleep(duration)
         self.stop()

       def right(self, duration):
         self.set_speed()
         self.left_motor.run(Adafruit_MotorHAT.FORWARD)
         time.sleep(duration)
         self.stop()

Copy

Explain
Thus, we have implemented a Robot class that drives the robot in the four directions. Let's implement a simple test so that we can test the Robot class before we use it in our main program:
       if __name__ == "__main__":
         # create an instance  of the robot class with channels 1 and 2
         robot = Robot(1,2)
         print("Moving forward...")
         robot.forward(5)
         print("Moving backward...")
         robot.reverse(5)
         robot.stop()

Copy

Explain
The preceding code sample is available for download along with this chapter as robot.py. Try to run the program with the motor driver. It should run the motor in forward and reverse directions for 5 seconds. Now that we have implemented a stand-alone module for the robot's control, let's move on to the web interface.

Camera setup for the web interface
Note
You will encounter some issues even after following the instructions to the tee. We have included references that we used to fix the problem at the end of this chapter.

In this section, we will set up the camera to stream to a browser. The first step is installing the motion package:

sudo apt-get install motion

Copy

Explain
Once the package is installed, the following configuration changes need to be applied:

Edit the following parameters in /etc/motion/motion.conf:
daemon on
       threshold 99999
       framerate 90
       stream_maxrate 100
       stream_localhost off

Copy

Explain
Include the following parameter in /etc/default/motion:
       start_motion_daemon=yes

Copy

Explain
Edit /etc/init.d/motion as follows:
start)

       if check_daemon_enabled ; then

       if ! [ -d /var/run/motion ]; then

       mkdir /var/run/motion

       fi

       chown motion:motion /var/run/motion

       sudo modprobe bcm2835-v4l2

       chmod 777 /var/run/motion

       sleep 30

       log_daemon_msg "Starting $DESC" "$NAME"

Copy

Explain
Reboot your Raspberry Pi Zero.
The next step assumes that you have installed the flask framework and tried out the basic example from Chapter 7, Requests and Web Frameworks.
Create a folder named templates within the folder where your flask framework and Robot class files are located) and create a file named index.html in the folder with the following contents:
<!DOCTYPE html>
       <html>
         <head>
           <title>Raspberry Pi Zero Robot</title>
         </head>

         <body>
          <iframe id="stream"
          src="http://<IP_Address_of_your_Raspberry_Pi>
          :8081/?action=stream" width="320" height="240">
          </iframe>
         </body>
       </html>

Copy

Explain
In the preceding code snippet, include the IP address of your Raspberry Pi Zero and save it as index.html.


Create a file named web_interface.py and serve index.html saved to the templates folder:
from flask import Flask, render_template
       app = Flask(__name__)

       @app.route("/")
       def hello():
           return render_template('index.html')

       if __name__ == "__main__":
           app.run('0.0.0.0')

Copy

Explain
Run the flask server using the following command:
python3 web_interface.py

Copy

Explain
Open a browser on your laptop and go to the IP address of your Raspberry Pi Zero (port 5000) to see a live stream of your Raspberry Pi cam module.

The snapshot of the live webcam stream (Raspberry Pi Cam module)

Let's move on to the next step to add buttons to the web interface.

Buttons for robot control
In this section, we will add implement buttons to the web interface to drive the robot.

The first step is adding four buttons to index.html. We will be making use of HTML Table to add four buttons (Code snippet shortened for brevity and refer to http://www.w3schools.com/html/html_tables.asp for more information on HTML tables):
       <table style="width:100%; max-width: 500px; height:300px;">
         <tr>
           <td>
             <form action="/forward" method="POST">
               <input type="submit" value="forward" style="float:
               left; width:80% ;">
               </br>
             </form>
           </td>
       ...
       </table>

Copy

Explain
In web_interface.py, we need to implement a method that accepts POST requests from the buttons. For example, the method to accept requests from /forward can be implemented as follows:
       @app.route('/forward', methods = ['POST'])
       def forward():
           my_robot.forward(0.25)
           return redirect('/')

Copy

Explain
Putting it altogether, web_interface.py looks something as follows:
       from flask import Flask, render_template, request, redirect
       from robot import Robot

       app = Flask(__name__)
       my_robot = Robot(1,2)

       @app.route("/")
       def hello():
           return render_template('index.html')

       @app.route('/forward', methods = ['POST'])
       def forward():
           my_robot.forward(0.25)
           return redirect('/')

       @app.route('/reverse', methods = ['POST'])
       def reverse():
           my_robot.reverse(0.25)
           return redirect('/')

       @app.route('/left', methods = ['POST'])
       def left():
           my_robot.left(0.25)
           return redirect('/')

       @app.route('/right', methods = ['POST'])
       def right():
           my_robot.right(0.25)
           return redirect('/')

       if __name__ == "__main__":
           app.run('0.0.0.0')

Copy

Explain
The preceding code sample is available for download along with this chapter as web_interface.py (along with index.html). Add the following line to /etc/rc.local(before exit 0):

python3 /<path_to_webserver_file>/web_interface.py

Copy

Explain
Reboot your Raspberry Pi Zero, and you should see a live feed of the robot's camera. You should also be able to control the robot from the browser!


Control your robot a browser!



Troubleshooting tips
Here are some of the problems we encountered while building the robot:

We broke our Raspberry Pi Zero's camera interface tab while assembling the camera module. We had to replace the Raspberry Pi Zero.
We encountered some ghost issues with our motor drive circuitry. We were not able to detect the motor driver on certain occasions. We had to replace the power supply for the motor driver. We will keep this book's website updated when we find the root cause of this issue.
We encountered a lot of issues getting the web stream setup for the browser. We had to tweak a lot of settings to get it working. We found some articles to fix the issue. We have shared them in the references section of this book.
Project enhancements
Consider making enhancements to the web interface such that you could alter the speed of your robot.
If you are planning to build a robot that operates in outdoor conditions, you potentially add a GPS sensor. Most GPS sensors stream data via the UART interface. We recommend reading Chapter 4, Communication Interfaces for examples.
The distance of obstacles can be measured using this sensor: https://www.adafruit.com/products/3317. This can be helpful in telemetry applications.
* In this book, we used a camera to drive the robot. It is possible to take pictures and understand the objects in a scene using this image understanding tool:https://cloud.google.com/vision/.


Summary
In this chapter, we built a robot that consists of a pair of motors driven by a Raspberry Pi using a motor driver. The robot is also equipped with a camera module to aid steering the robot. It consists of two battery packs to power the Raspberry Pi Zero and motors, respectively. We will also upload a video of the robot's operation to this book's website.

Note
Learning resources

Differential steering mechanism: https://www.robotix.in/tutorial/mechanical/drivemechtut/
Video lecture on differential steering mechanism: https://www.coursera.org/learn/mobile-robot/lecture/GnbnD/differential-drive-robots
Make Magazine: Building your own chassis: https://makezine.com/projects/designing-a-robot-chassis/
Society of robots: Guide to building your own chassis: http://www.societyofrobots.com/mechanics_chassisconstruction.shtml
Adafruit's motor driver documentation: https://learn.adafruit.com/adafruit-dc-and-stepper-motor-hat-for-raspberry-pi
Adafruit motor selection guide: https://learn.adafruit.com/adafruit-motor-selection-guide
Adafruit's guide on building a simple Raspberry Pi based robot:https://learn.adafruit.com/simple-raspberry-pi-robot/overview
Flask framework and form submission:http://opentechschool.github.io/python-flask/core/form-submission.html
Raspberry Pi Camera Setup for web streaming: http://jamespoole.me/2016/04/29/web-controlled-robot-with-video-stream/




| ≪ [ 08 Awesome Things You Could Develop Using Python ](/packtpub/2024/817-Python_with_RaspPi_1ed/08_Awesome_Things_You_Could_Develop_Using_Python) | 09 Let's Build a Robot | [ 10 Home Automation Using The Raspberry Pi Zero ](/packtpub/2024/817-Python_with_RaspPi_1ed/10_Home_Automation_Using_The_Raspberry_Pi_Zero) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 09 Let's Build a Robot
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: /packtpub/2024/817-Python_with_RaspPi_1ed/09_Let_s_Build_a_Robot
> Book Jemok: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 16:35:09
> .md Name: 09_let_s_build_a_robot.md

