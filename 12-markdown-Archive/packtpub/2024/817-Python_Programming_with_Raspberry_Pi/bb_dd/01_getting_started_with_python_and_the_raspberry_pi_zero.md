
| ≪ [ 00 Preface ](/packtpub/2024/817-Python_with_RaspPi_1ed/00_Preface) | 01 Getting Started with Python and the Raspberry Pi Zero | [ 02 Arithmetic Operations, Loops, and Blinky Lights ](/packtpub/2024/817-Python_with_RaspPi_1ed/02_Arithmetic_Operations__Loops__and_Blinky_Lights) ≫ |
|:----:|:----:|:----:|

# 01 Getting Started with Python and the Raspberry Pi Zero

Over the past few years, the Raspberry Pi family of single board computers has proved to be a revolutionary set of tools for learning, fun, and several serious projects! People over the world are now equipped with the means to learn computer architecture, computer programming, robotics, sensory systems, home automation, and much more, with ease and without blowing a hole in their wallets. This book hopes to help you, the reader, in the journey to learn programming in Python through the Raspberry Pi Zero. Among programming languages, Python is simultaneously one of the simplest and easiest to learn as well as one of the most versatile languages. Join us over the next few chapters as we first familiarize ourselves with the **Raspberry Pi Zero**, a unique and excitingly simple and cheap computer and Python, gradually building projects of increasing challenge and complexity.

In this chapter, we will discuss the following:

> - Introduction to the Raspberry Pi Zero and its features
> - The setup of the Raspberry Pi Zero
> - An introduction to the Python programming language
> - The setup of the development environment and writing the first program

# Let's get started!

In the first chapter, we will learn about the Raspberry Pi Zero, set things up for learning Python with this book, and write our first piece of code in Python.

## Things needed for this book

The following items are needed for this book. The sources provided are just a suggestion. The reader is welcome to buy them from an equivalent alternative source:

| Name | Link | Cost (in USD) |
|:----|:----|:----|
| Raspberry Pi Zero (v1.3 or higher) | (The purchase of the Raspberry Pi would be discussed separately) | $5.00 |
| USB hub | http://amzn.com/B003M0NURK | $7.00 approx |
| USB OTG cable | https://www.adafruit.com/products/1099 | $2.50 |
| Micro HDMI to HDMI adapter cable | https://www.adafruit.com/products/1358 | $6.95 |
| USB Wi-Fi adapter | http://amzn.com/B00LWE14TO | $9.45 |
| Micro USB power supply | http://amzn.com/B00DZLSEVI | $3.50 |
| Electronics starter kit (or similar) | http://amzn.com/B00IT6AYJO | $25.00 |
| 2x20 headers | https://www.adafruit.com/products/2822 | $0.95 |
| NOOBS micro SD card or a blank 8 GB micro SD card | http://amzn.com/B00ENPQ1GK | $13.00 |
| Raspberry Pi camera module (optional) | http://a.co/6qWiJe6 | $25.00 |
| Raspberry Pi camera adapter (optional) | https://www.adafruit.com/product/3170 | $5.95 |
 

The other items needed for this include a USB mouse, USB keyboard, and a monitor with the HDMI output or DVI output. We will also need an HDMI cable (or DVI to HDMI cable if the monitor has an DVI output). Some vendors such as the Pi Hut sell the Raspberry Pi Zero accessories as a kit (for example, https://thepihut.com/collections/raspberry-pi-accessories/products/raspberry-pi-zero-essential-kit).

> Apart from the components mentioned in this section, we will also discuss certain features of the Raspberry Pi Zero and Python programming using additional components such as sensors and GPIO expanders. These components are optional but definitely useful while learning the different aspects of Python programming.
> 
> The electronics starter kit mentioned in the bill of materials is just an example. Feel free to order any beginners electronics kit (that contains a similar mix of electronic components).

## Buying the Raspberry Pi Zero

The Raspberry Pi Zero is sold by distributors such as the **Newark element14**, **Pi Hut**, and **Adafruit**. At the time of writing this book, we encountered difficulties in buying a Raspberry Pi Zero. We recommend monitoring websites such as www.whereismypizero.com to find out when the Raspberry Pi Zero becomes available. We believe that it is rare to locate the Pi Zero because of its popularity. We are not aware if there might be an abundant stock of the Raspberry Pi Zero in the future. The examples discussed in this book are also compatible with the other flavors of the Raspberry Pi (for example, Raspberry Pi 3).

![ 1.1 Pi Zero availability information provided by www.whereismypizero.com ](/packtpub/2024/817/01/1.1-pi_zero_availability.webp)

Figure 1.1: Pi Zero availability information provided by www.whereismypizero.com

While purchasing the Raspberry Pi Zero, make sure that the board version is 1.3 or higher. The board version is printed on the backside of the board (the example of this is shown in the following picture). Verify that the board version using the seller's product description before purchase:

![ 1.2 Raspberry Pi board version ](/packtpub/2024/817/01/1.2-raspberry_pi_board.webp)

Figure 1.2: Raspberry Pi board version

# Introduction to the Raspberry Pi Zero

The Raspberry Pi Zero is a small computer that costs about $5 and smaller than a credit card, designed by the **Raspberry Pi Foundation** (a nonprofit organization with the mission to teach computer science to students, especially those who lack of access to the requisite tools). The Raspberry Pi Zero was preceded by the **Raspberry Pi Models A and  B**. A detailed history of the Raspberry Pi and the different models of the Raspberry Pi is available on http://elinux.org/RPi_General_History. The Raspberry Pi Zero was released on 26th November 2015 (*Thanksgiving Day*).

> A fun fact for the readers is that one of the authors of this book, Sai Yamanoor, drove from San Francisco to Los Angeles (700+ miles for a round trip in one day) on the day after Thanksgiving to buy the Raspberry Pi Zero from a local store.

 

## The features of the Raspberry Pi Zero

The Raspberry Pi Zero is powered by a 1 GHz BCM2835 processor and 512 MB RAM. BCM2835 is a **System on a Chip (SoC)** developed by Broadcom semiconductors. SoC is one where all the components required to run a computer are available on a single chip (for example, the BCM2835 includes CPU, GPU, peripherals such as USB interface). The documentation for the BCM2835 SoC is available at https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2835/README.md.

![ 1.3 The Raspberry Pi Zero board version 1.3 ](/packtpub/2024/817/01/1.3-the_raspberry_pi.webp)

Figure 1.3: The Raspberry Pi Zero board version 1.3

Let's briefly discuss the features of the Raspberry Pi Zero using the preceding picture marked with numbered rectangles:

1. **The mini HDMI interface**: The mini HDMI interface is used to connect a display to the Raspberry Pi Zero. The HDMI interface can be used to drive a display of maximum resolution of 1920x1080 pixels.
1. **USB On-The-Go interface**: In the interest of keeping things low cost, the Raspberry Pi Zero comes with a USB **On-The-Group (OTG)** interface. This interface enables interfacing USB devices such as a mouse and keyboard. Using a USB OTG to USB-A female converter. We need a USB hub to interface any USB accessory.
1. **Power supply**: The micro-B USB adapter is used to power the Raspberry Pi zero, and it draws about a maximum of 200 mA of current.
1. **micro SD card slot**: The Raspberry Pi's **operating system (OS)** resides in a micro SD card and the **bootloader** on the processor loads it upon powering up.
1. **GPIO interface**: The Raspberry Pi Zero comes with a 40-pin **general purpose input/output (GPIO)** header that is arranged in two rows of 20 pins. The Raspberry Pi Zero's GPIO interface is shipped without a soldered header. The GPIO header is used to interface sensors, control actuators, and interface appliances. The GPIO header also consists of communication interfaces such as UART and I2C. We will discuss the GPIO in detail in the second chapter.
1. **RUN and TV pins**: There are two pins labeled as **RUN** below the GPIO header. These pins are used to reset the Raspberry Pi using a small tactile switch/push button. The TV pin is used to provide a composite video output.
1. **Camera interface**: Raspberry Pi Zero boards (version 1.3 or higher) come with a camera interface. This enables interfacing a camera designed by the Raspberry Pi Foundation (https://www.raspberrypi.org/products/camera-module-v2/).

All these features of the Raspberry Pi have enabled them to be used by hobbyists in projects involving home automation, holiday decorations, and more, limited only by your imagination. Scientists have used them in experiments, including tracking of bees, tracking wildlife, perform computation-intensive experiments. Engineers have used the Raspberry Pi to build robots, mine bitcoins, check Internet speeds to send Twitter messages when the speeds are slow, and order pizza!

# The setup of the Raspberry Pi Zero

In this section, we will solder some headers onto the Raspberry Pi, load the OS onto a micro SD card, and fire the Raspberry Pi Zero for the first example.

## Soldering the GPIO headers

In this book, we will discuss the different aspects of Python programming using the Raspberry Pi's GPIO pins. The Raspberry Pi Zero ships without the GPIO header pins. Let's go ahead and solder the GPIO pins. We have also uploaded a video tutorials to this book's website that demonstrates soldering the headers onto the Raspberry Pi Zero.

As mentioned before, the Raspberry Pi's GPIO section consists of 40 pins. This is arranged in two rows of 20 pins each. We will need either two sets of 20-pin male headers or a 20-pin double-row male header. These are available from vendors such as **Digikey** and **Mouser**. The headers for the Raspberry Pi are also sold as a kit by vendors like the Pi Hut (https://thepihut.com/collections/raspberry-pi-zero/products/raspberry-pi-zero-essential-kit).

![ 1.4 2x20 headers for the Raspberry Pi Zero ](/packtpub/2024/817/01/1.4-2x20_headers_for.webp)

Figure 1.4: 2x20 headers for the Raspberry Pi Zero

In order to solder the headers onto the Raspberry Pi Zero, arrange the headers on a breadboard, as shown in the following figure:

![ 1.5 Arranging the headers to solder onto the Raspberry Pi ](/packtpub/2024/817/01/1.5-arranging_the_headers.webp)

Figure 1.5: Arranging the headers to solder onto the Raspberry Pi

Perform the following steps:

1. Arrange the Raspberry Pi on top of the headers upside down.
1. Gently hold the Raspberry Pi (to make sure that the headers are positioned correctly while soldering) and solder the headers onto the Raspberry Pi.
1. Inspect the board to ensure that the headers are soldered properly and carefully remove the Raspberry Pi Zero off the breadboard.

![ 1.6 Headers soldered onto the Raspberry Pi ](/packtpub/2024/817/01/1.6-headers_soldered_onto.webp)

Figure 1.6: Headers soldered onto the Raspberry Pi

We are all set to make use of the GPIO pins in this book! Let's move on to the next section.

> Soldering the headers onto the Raspberry Pi using a breadboard might damage the breadboard if the right temperature setting isn't used. The metal contacts of the breadboard might permanently expand resulting in permanent damage. Training in basic soldering techniques is crucial, and there are plenty of tutorials on this topic.

## Enclosure for the Raspberry Pi Zero

Setting up a Raspberry Pi zero inside an enclosure is completely optional but definitely useful while working on your projects. There are a plenty of enclosures sold by vendors. Alternatively, you may download an enclosure design from **Thingiverse** and 3D print them. We found this enclosure to suit our needs at http://www.thingiverse.com/thing:1203246 as it provides access to the GPIO headers. 3D printing services such as **3D Hubs** (https://www.3dhubs.com/) would print the enclosure for a charge of $9 via a local printer. Alternately, you can also use predesigned project enclosures or design one that can be constructed using **plexiglass** or similar materials.

![ 1.7 Raspberry Pi Zero in an enclosure ](/packtpub/2024/817/01/1.7-raspberry_pi_zero.webp)

Figure 1.7: Raspberry Pi Zero in an enclosure

## OS setup for the Raspberry Pi

Let's go ahead and prepare a micro SD card to set up the Raspberry Pi Zero. In this book, we will be working with the **Raspbian OS**. The Raspbian OS has a wide user base, and the OS is officially supported by the Raspberry Pi Foundation. Hence, it is easier to find support on forums while working on projects as more people are familiar with the OS.

### micro SD card preparation

If you had purchased a micro SD card that comes pre-flashed with the Raspbian **New Out of the Box Software (NOOBS)** image, you may skip the micro SD card preparation:

The first step is downloading the Raspbian NOOBS image. The image can be downloaded from https://www.raspberrypi.org/downloads/noobs/.

![ 1.8 Downloads the Raspberry Pi NOOBS image ](/packtpub/2024/817/01/1.8-downloads_the_raspberry.webp)

Figure 1.8: Downloads the Raspberry Pi NOOBS image

2. Format your SD card using the **SD Card Formatter** tool. Make sure that the `FORMAT SIZE ADJUSTMENT` is `ON` as shown in the snapshot (available from https://www.sdcard.org/downloads/formatter_4/index.html):

![ 1.9 Format the SD card ](/packtpub/2024/817/01/1.9-format_the_sd.webp)

Figure 1.9: Format the SD card

3. Extract the downloaded ZIP file and copy the contents of the file to the formatted micro SD card.
1. Set up the Raspberry Pi (not necessarily in the same order):

> - Interface the HDMI cable from the monitor via the mini HDMI interface
> - USB hub via the USB OTG interface of the Raspberry Pi Zero
> - Micro-USB cable to power the Raspberry Pi Zero
> - Plug in a Wi-Fi adapter, a keyboard, and a mouse to the Raspberry Pi Zero

![ 1.10 Raspberry Pi Zero with the keyboard, the mouse, and the Wi-Fi adapter ](/packtpub/2024/817/01/1.10-raspberry_pi_zero.webp)

Figure 1.10: Raspberry Pi Zero with the keyboard, the mouse, and the Wi-Fi adapter

5. Power up the Raspberry Pi, and it should automatically flash the OS onto the SD card and launch the desktop at startup.
1. The first step after startup is changing the Raspberry Pi's password. Go to menu (the Raspberry Pi symbol located at the top-left corner) and select `Raspberry Pi Configuration` under `Preferences`.

![ 1.11 Launch Raspberry Pi configuration ](/packtpub/2024/817/01/1.11-launch_raspberry_pi.webp)

Figure 1.11: Launch Raspberry Pi configuration

7. Under the System tab, change the password:

![ 1.12 Change the password ](/packtpub/2024/817/01/1.12-change_the_password.webp)

Figure 1.12: Change the password

8. Under the `Localisation` tab, change the locale, time zone, and keyboard settings based upon your region.
 
1.  When the installation is complete, connect the Raspberry Pi Zero to the wireless network (using the wireless tab on the top right).

![ 1.13 Raspberry Pi desktop upon launch ](/packtpub/2024/817/01/1.13-raspberry_pi_desktop.webp)

Figure 1.13: Raspberry Pi desktop upon launch

10. Let's launch the command-line terminal of the Raspberry Pi to perform some software updates.

![ 1.14 Launching the command-line terminal ](/packtpub/2024/817/01/1.14-launching_the_command-line.webp)

Figure 1.14: Launching the command-line terminal

11. Run the following commands from the command-line terminal:

```bash
sudo apt-get update
       sudo apt-get upgrade
```

The OS upgrade should complete within a couple of minutes.

> The Raspberry Pi Foundation hosts a video on its website that provides a visual aid to set up the Raspberry Pi. This video is available at https://vimeo.com/90518800.

# Let's learn Python!

Python is a high-level programming language invented by Guido Van Rossum. It is advantageous to learn Python using the Raspberry Pi for the following reasons:

> - It has a very simple syntax and hence is very easy to understand.
> - It offers the flexibility of implementing ideas as a sequence of scripts. This is helpful to hobbyists to implement their ideas.
> - There are Python libraries for the Raspberry Pi's GPIO. This enables easy interfacing of sensors/appliances with the Raspberry Pi.
> - Python is used in a wide range of applications by technology giants such as Google. These applications range from simple robots to personal AI assistance and control modules in space.
> - The Raspberry Pi has a growing fan base. This combined with the vast user base of Python means that there is no scarcity of learning resources or support for projects.

In this book, we will learn Python version 3.x. We will learn each major aspect of Python programming using a demonstrative example. Find out the awesomeness of Python by learning to do things by yourself! Keep in mind that there is Python 2.x, and it has subtle differences from Python 3.x.

> If you are comfortable with the Linux command-line terminal, we recommend setting up your Raspberry Pi for remote development, as shown in Chapter 11, Tips and Tricks.

# The Hello World example

Since we are done setting up the Raspberry Pi, let's get things rolling by writing our first piece of code in Python. While learning a new programming language, it is customary to get started by printing `Hello World` on the computer screen. Let's print the following message: `I am excited to learn Python programming with the Raspberry Pi Zero` using Python.

In this book, we will learn Python using the **Integrated Development and Learning Environment (IDLE)** tool. We chose IDLE for the following reasons:

> - The tool is installed and shipped as a package in the Raspbian OS image. No additional installation is required.
> - It is equipped with an interactive tool that enables performing checks on a piece of code or a specific feature of the Python language.
> - It comes with a text editor that enables writing code according to the conventions of the Python programming language. The text editor provides a color code for different elements of a Python script. This helps in writing a Python script with relative ease.
> - The tool enables a step-by-step execution of any code sample and identify problems in it.

## Setting up your Raspberry Pi Zero for Python programming

Before we get started, let's go ahead and set up the Raspberry Pi Zero to suit our needs:

1. Let's add a shortcut to IDLE3 (for developing in Python 3.x) on the Raspberry Pi's desktop. Under the Programming submenu (located at the top-left corner of your Raspberry Pi Zero's desktop), right-click on `Python 3 (IDLE)` and click on `Add to desktop`. This adds a shortcut to the IDLE tool on your desktop thus making it easily accessible.

![ 1.15 Add shortcut to IDLE3 to the Raspberry Pi's desktop ](/packtpub/2024/817/01/1.15-add_shortcut_to.webp)

Figure 1.15: Add shortcut to IDLE3 to the Raspberry Pi's desktop

2. In order to save all the code samples, let's go ahead and create a folder named `code_samples` on the Raspberry Pi's desktop. Right-click on your desktop and create a new folder.

### IDLE's interactive tool

Let's write our first example using IDLE's interactive tool:

1. Launch the IDLE3 (meant for Python 3.x) tool from the Raspberry Pi Zero's desktop by double-clicking on it.
1. From the IDLE's interactive command-line tool, type the following line:

```python
       print("I am excited to learn Python with the Raspberry Pi Zero")
```

3. This should print the following to the interactive command-line tool's screen:

![ 1.16 We did it! We wrote a single line that prints out a line of text to the Raspberry Pi's screen. ](/packtpub/2024/817/01/1.16-we_did_it.webp)

Figure 1.16: We did it! We wrote a single line that prints out a line of text to the Raspberry Pi's screen.

### The text editor approach

The command-line tool is useful for test coding logic, but it is neither practical nor elegant to write code using the interactive tool. It is easier to write a bunch of code at a time and test it. Let's repeat the same example using IDLE's text editor:

1. Launch IDLE's text editor (in IDLE, `File | New File`), enter the `hello world` line discussed in the previous section and save it as `helloworld.py`.
1. Now, the code could be executed by either pressing the F5 key or clicking on `Run Module` from the drop-down menu `Run`, and you will get the output as shown in the following figure:

![ 1.17 you will get the output as shown in the following figure ](/packtpub/2024/817/01/1.17-you_will_get.webp)

Figure 1.17: you will get the output as shown in the following figure

### Launching the Python interpreter via the Linux Terminal

It is also possible to use the Python interpreter via the **Linux Terminal**. Programmers mostly use this to test their code or refer to the Python documentation tool, **pydoc**. This approach is convenient if the readers plan to use a text editor other than IDLE:

1. Launch the Raspberry Pi's command-line terminal from the desktop toolbar.

![ 1.18 Launching the command-line terminal ](/packtpub/2024/817/01/1.18-launching_the_command-line.webp)

Figure 1.18: Launching the command-line terminal

2. Type the command, `python3` and press *Enter*. This should launch Python 3.x on the terminal.
1. Now, try running the same piece of code discussed in the previous section:

```python
       print("I am excited to learn Python with the Raspberry Pi Zero")
```

This would give the following screenshot as the result:

![ 1.19 The result should be similar to that of the previous two sections ](/packtpub/2024/817/01/1.19-the_result_should.webp)

Figure 1.19: The result should be similar to that of the previous two sections

The Python interpreter in the Linux Terminal may be closed by typing `exit()` and pressing the return key

### Executing Python scripts using the Linux Terminal

It is possible to execute code written using any text editor via the Linux Terminal. For example, Let's say the file `helloworld.py` is saved in a folder named `code_samples` on the Raspberry Pi's desktop. This file may be executed as follows from the Linux Terminal:

> If you are not familiar with the Linux command-line terminal, we have written up some tutorials to familiarize yourself with the command-line terminal on this book's website.

1. On the Linux Terminal, switch to the directory where the Python script is located:

```bash
cd /home/pi/Desktop/code_samples
```

2. Execute the Python script as follows:

```bash
python3 helloworld.py
```

3. Alternatively, the Python script could be executed using its absolute location path:

```bash
python3 /home/pi/Desktop/code_samples/hello_world.py
```

We did it! We just wrote our first piece of code and discussed different ways to execute the code.

### The print() function

In our first `helloworld` example, we discussed printing something on the screen. We used the `print()` function to obtain our result. In Python, a function is a code block that executes a set of defined tasks. The `print()` function is a part of Python's standard library that prints any combination of alphanumeric characters that is passed as an argument between the quotes. The `print()` function is used to print information to the screen. It is especially helpful while trying to debug the code. In this example, the `print()` function was used to print a message on the screen.

In this chapter, the function `print()` executed the string `I am excited to learn Python programming with the Raspberry Pi Zero` (we will discuss strings in the later section of this book). It is also possible to write custom function to execute a repetitive task required by the user.

Similarly, the `exit()` function executes the predefined task of exiting the Python interpreter at the user's call.

### The help() function

While getting started, it is going to be difficult to remember the syntax of every function in Python. It is possible to refer to a function's documentation and syntax using the help function in Python. For example, in order to find the use of the print function in Python, we can call help on the command-line terminal or the interactive shell as follows:

```bash
    help(print)
```

This would return a detailed description of the function and its syntax:

![ 1.20 This would return a detailed description of the function and its syntax ](/packtpub/2024/817/01/1.20-this_would_return.webp)

Figure 1.20: This would return a detailed description of the function and its syntax

# Summary

That's it! In this chapter, we set up the Raspberry Pi Zero to write our first program in Python. We also explored different options to write a Python program. You are now ready and on your way to learn Python with the Raspberry Pi. In the next chapter, we will dig deeper and learn more about the GPIO pins while executing a simple project that makes LEDs blink.



| ≪ [ 00 Preface ](/packtpub/2024/817-Python_with_RaspPi_1ed/00_Preface) | 01 Getting Started with Python and the Raspberry Pi Zero | [ 02 Arithmetic Operations, Loops, and Blinky Lights ](/packtpub/2024/817-Python_with_RaspPi_1ed/02_Arithmetic_Operations__Loops__and_Blinky_Lights) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 01 Getting Started with Python and the Raspberry Pi Zero
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: /packtpub/2024/817-Python_with_RaspPi_1ed/01_Getting_Started_with_Python_and_the_Raspberry_Pi_Zero
> Book Jemok: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 16:35:08
> .md Name: 01_getting_started_with_python_and_the_raspberry_pi_zero.md

