
| ≪ [ 02 Arithmetic Operations, Loops, and Blinky Lights ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/02_Arithmetic_Operations__Loops__and_Blinky_Lights) | 03 Conditional Statements, Functions, and Lists | [ 04 Communication Interfaces ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/04_Communication_Interfaces) ≫ |
|:----:|:----:|:----:|

# 03 Conditional Statements, Functions, and Lists
Chapter 3. Conditional Statements, Functions, and Lists
In this chapter, we will build upon what you learned in the previous chapter. You will learn about conditional statements and how to make use of logical operators to check conditions using conditional statements. Next, you will learn to write simple functions in Python and discuss interfacing inputs to the Raspberry Pi's GPIO header using a tactile switch (momentary push button). We will also discuss motor control (this is a run-up to the final project) using the Raspberry Pi Zero and control the motors using the switch inputs. Let's get to it! In this chapter, we will discuss the following topics:

Conditional statements in Python
 Using conditional inputs to take actions based on GPIO pin states
Breaking out of loops using conditional statement
Functions in Python
GPIO callback functions
Motor control in Python
 

Conditional statements
In Python, conditional statements are used to determine if a specific condition is met by testing whether a condition is true or false. Conditional statements are used to determine how a program is executed. For example, conditional statements could be used to determine whether it is time to turn on the lights. The syntax is as follows:

if condition_is_true:

  do_something()

Copy

Explain
The condition is usually tested using a logical operator, and the set of tasks under the indented block is executed. Let's consider the example, check_address_if_statement.py (available for download with this chapter) where the user input to a program needs to be verified using a yes or no question:

check_address = input("Is your address correct(yes/no)? ") 
if check_address == "yes": 
  print("Thanks. Your address has been saved") 
if check_address == "no": 
  del(address) 
  print("Your address has been deleted. Try again")

Copy

Explain
In this example, the program expects a yes or no input. If the user provides the input yes, the condition if check_address == "yes" is true, the message Your address has been saved is printed on the screen.

Likewise, if the user input is no, the program executes the indented code block under the logical test condition if check_address == "no" and deletes the variable address.

An if-else statement
In the preceding example, we used an if statement to test each condition. In Python, there is an alternative option named the if-else statement. The if-else statement enables testing an alternative condition if the main condition is not true:

check_address = input("Is your address correct(yes/no)? ") 
if check_address == "yes": 
  print("Thanks. Your address has been saved") 
else: 
  del(address) 
  print("Your address has been deleted. Try again")

Copy

Explain
In this example, if the user input is yes, the indented code block under if is executed. Otherwise, the code block under else is executed.

if-elif-else statement
In the preceding example, the program executes any piece of code under the else block for any user input other than yes that is if the user pressed the return key without providing any input or provided random characters instead of no, the if-elif-else statement works as follows:

check_address = input("Is your address correct(yes/no)? ") 
if check_address == "yes": 
  print("Thanks. Your address has been saved") 
elif check_address == "no": 
  del(address) 
  print("Your address has been deleted. Try again") 
else: 
  print("Invalid input. Try again")

Copy

Explain
If the user input is yes, the indented code block under the if statement is executed. If the user input is no, the indented code block under elif (else-if) is executed. If the user input is something else, the program prints the message: Invalid input. Try again.

It is important to note that the code block indentation determines the block of code that needs to be executed when a specific condition is met. We recommend modifying the indentation of the conditional statement block and find out what happens to the program execution. This will help understand the importance of indentation in Python.

In the three examples that we discussed so far, it could be noted that an if statement does not need to be complemented by an else statement. The else and elif statements need to have a preceding if statement or the program execution would result in an error.

Breaking out of loops
Conditional statements can be used to break out of a loop execution (for loop and while loop). When a specific condition is met, an if statement can be used to break out of a loop:

i = 0 
while True: 
  print("The value of i is ", i) 
  i += 1 
  if i > 100: 
    break

Copy

Explain
In the preceding example, the while loop is executed in an infinite loop. The value of i is incremented and printed on the screen. The program breaks out of the while loop when the value of i is greater than 100 and the value of i is printed from 1 to 100.

The applications of conditional statements: executing tasks using GPIO
In the previous chapter, we discussed interfacing outputs to the Raspberry Pi's GPIO. Let's discuss an example where a simple push button is pressed. A button press is detected by reading the GPIO pin state. We are going to make use of conditional statements to execute a task based on the GPIO pin state.

Let us connect a button to the Raspberry Pi's GPIO. All you need to get started are a button, pull-up resistor, and a few jumper wires. The figure given later shows an illustration on connecting the push button to the Raspberry Pi Zero. One of the push button's terminals is connected to the ground pin of the Raspberry Pi Zero's GPIO pin.

The schematic of the button's interface is shown here:


Raspberry Pi GPIO schematic

The other terminal of the push button is pulled up to 3.3V using a 10 K resistor. The junction of the push button terminal and the 10 K resistor is connected to the GPIO pin 2 (refer to the BCM GPIO pin map shared in the earlier chapter).


Interfacing the push button to the Raspberry Pi Zero's GPIO - an image generated using Fritzing

 

Let's review the code required to review the button state. We make use of loops and conditional statements to read the button inputs using the Raspberry Pi Zero.

We will be making use of the gpiozero library introduced in the previous chapter. The code sample for this section is GPIO_button_test.py and available for download along with this chapter.

In a later chapter, we will discuss object-oriented programming (OOP). For now, let's briefly discuss the concept of classes for this example. A class in Python is a blueprint that contains all the attributes that define an object. For example, the Button class of the gpiozero library contains all attributes required to interface a button to the Raspberry Pi Zero's GPIO interface. These attributes include button states and functions required to check the button states and so on. In order to interface a button and read its states, we need to make use of this blueprint. The process of creating a copy of this blueprint is called instantiation.

Let's get started with importing the gpiozero library and instantiate the Button class of the gpiozero library (we will discuss Python's classes, objects, and their attributes in a later chapter). The button is interfaced to GPIO pin 2. We need to pass the pin number as an argument during instantiation:

from gpiozero import Button 

#button is interfaced to GPIO 2 
button = Button(2)

Copy

Explain
The gpiozero library's documentation is available at http://gpiozero.readthedocs.io/en/v1.2.0/api_input.html. According to the documentation, there is a variable named is_pressed in the Button class that could be tested using a conditional statement to determine if the button is pressed:

if button.is_pressed: 
    print("Button pressed")

Copy

Explain
Whenever the button is pressed, the message Button pressed is printed on the screen. Let's stick this code snippet inside an infinite loop:

from gpiozero import Button 

#button is interfaced to GPIO 2 
button = Button(2)

while True: 
  if button.is_pressed: 
    print("Button pressed")

Copy

Explain
In an infinite while loop, the program constantly checks for a button press and prints the message as long as the button is being pressed. Once the button is released, it goes back to checking whether the button is pressed.

Breaking out a loop by counting button presses
Let's review another example where we would like to count the number of button presses and break out of the infinite loop when the button has received a predetermined number of presses:

i = 0 
while True: 
  if button.is_pressed: 
    button.wait_for_release() 
    i += 1 
    print("Button pressed") 

  if i >= 10: 
    break

Copy

Explain
The preceding example is available for downloading along with this chapter as GPIO_button_loop_break.py.

In this example, the program checks for the state of the is_pressed variable. On receiving a button press, the program can be paused until the button is released using the wait_for_release method. When the button is released, the variable used to store the number of presses is incremented by one.

The program breaks out of the infinite loop, when the button has received 10 presses.


A red momentary push button interfaced to Raspberry Pi Zero GPIO pin 2

Functions in Python
We briefly discussed functions in Python. Functions execute a predefined set of task. print is one example of a function in Python. It enables printing something to the screen. Let's discuss writing our own functions in Python.

A function can be declared in Python using the def keyword. A function could be defined as follows:

def my_func(): 
   print("This is a simple function")

Copy

Explain
In this function my_func, the print statement is written under an indented code block. Any block of code that is indented under the function definition is executed when the function is called during the code execution. The function could be executed as my_func().

Passing arguments to a function:
A function is always defined with parentheses. The parentheses are used to pass any requisite arguments to a function. Arguments are parameters required to execute a function. In the earlier example, there are no arguments passed to the function.

Let's review an example where we pass an argument to a function:

def add_function(a, b): 
  c = a + b 
  print("The sum of a and b is ", c)

Copy

Explain
In this example, a and b are arguments to the function. The function adds a and b and prints the sum on the screen. When the function add_function is called by passing the arguments 3 and 2 as add_function(3,2) where a is 3 and b is 2, respectively.

Hence, the arguments a and b are required to execute function, or calling the function without the arguments would result in an error. Errors related to missing arguments could be avoided by setting default values to the arguments:

def add_function(a=0, b=0): 
  c = a + b 
  print("The sum of a and b is ", c)

Copy

Explain
The preceding function expects two arguments. If we pass only one argument to this function, the other defaults to zero. For example, add_function(a=3), b defaults to 0, or add_function(b=2), a defaults to 0. When an argument is not furnished while calling a function, it defaults to zero (declared in the function).

Similarly, the print function prints any variable passed as an argument. If the print function is called without any arguments, a blank line is printed.

Returning values from a function
Functions can perform a set of defined operations and finally return a value at the end. Let's consider the following example:

def square(a): 
   return a**2

Copy

Explain
In this example, the function returns a square of the argument. In Python, the return keyword is used to return a value requested upon completion of execution.

The scope of variables in a function
There are two types of variables in a Python program: local and global variables. Local variables are local to a function, that is, it is a variable declared within a function is accessible within that function. The example is as follows:

def add_function(): 
  a = 3 
  b = 2 
  c = a + b 
  print("The sum of a and b is ", c)

Copy

Explain
In this example, the variables a and b are local to the function add_function. Let's consider an example of a global variable:

a = 3 
b = 2 
def add_function(): 
  c = a + b 
  print("The sum of a and b is ", c) 

add_function()

Copy

Explain
In this case, the variables a and b are declared in the main body of the Python script. They are accessible across the entire program. Now, let's consider this example:

a = 3 
def my_function(): 
  a = 5 
  print("The value of a is ", a)

my_function() 
print("The value of a is ", a)

Copy

Explain
The program output is:

      The value of a is

      5

      The value of a is

      3

Copy

Explain
In this case, when my_function is called, the value of a is 5 and the value of a is 3 in the print statement of the main body of the script. In Python, it is not possible to explicitly modify the value of global variables inside functions. In order to modify the value of a global variable, we need to make use of the global keyword:

a = 3 
def my_function(): 
  global a 
  a = 5 
  print("The value of a is ", a)

my_function() 
print("The value of a is ", a)

Copy

Explain
In general, it is not recommended to modify variables inside functions as it is not a very safe practice of modifying variables. The best practice would be passing variables as arguments and returning the modified value. Consider the following example:

a = 3 
def my_function(a): 
  a = 5 
  print("The value of a is ", a) 
  return a 

a = my_function(a) 
print("The value of a is ", a)

Copy

Explain
In the preceding program, the value of a is 3. It is passed as an argument to my_function. The function returns 5, which is saved to a. We were able to safely modify the value of a.

GPIO callback functions
Let's review some uses of functions with the GPIO example. Functions can be used in order to handle specific events related to the GPIO pins of the Raspberry Pi. For example, the gpiozero library provides the capability of calling a function either when a button is pressed or released:

from gpiozero import Button 

def button_pressed(): 
  print("button pressed")

def button_released(): 
  print("button released")

#button is interfaced to GPIO 2 
button = Button(2) 
button.when_pressed = button_pressed 
button.when_released = button_released

while True: 
  pass

Copy

Explain
In this example, we make use of the attributes when_pressed and when_released of the library's GPIO class. When the button is pressed, the function button_pressed is executed. Likewise, when the button is released, the function button_released is executed. We make use of the while loop to avoid exiting the program and keep listening for button events. The pass keyword is used to avoid an error and nothing happens when a pass keyword is executed.

This capability of being able to execute different functions for different events is useful in applications like home automation. For example, it could be used to turn on lights when it is dark and vice versa.

DC motor control in Python
In this section, we will discuss motor control using the Raspberry Pi Zero. Why discuss motor control? As we progress through different topics in this book, we will culminate in building a mobile robot. Hence, we need to discuss writing code in Python to control a motor using a Raspberry Pi.

In order to control a motor, we need an H-bridge motor driver (Discussing H-bridge is beyond our scope. There are several resources for H-bridge motor drivers: http://www.mcmanis.com/chuck/robotics/tutorial/h-bridge/). There are several motor driver kits designed for the Raspberry Pi. In this section, we will make use of the following kit: https://www.pololu.com/product/2753.

The Pololu product page also provides instructions on how to connect the motor. Let's get to writing some Python code to operate the motor:

from gpiozero import Motor 
from gpiozero import OutputDevice 
import time

motor_1_direction = OutputDevice(13) 
motor_2_direction = OutputDevice(12)

motor = Motor(5, 6)

motor_1_direction.on() 
motor_2_direction.on()

motor.forward()

time.sleep(10)

motor.stop()

motor_1_direction.off() 
motor_2_direction.off()

Copy

Explain

Raspberry Pi based motor control

In order to control the motor, let's declare the pins, the motor's speed pins and direction pins. As per the motor driver's documentation, the motors are controlled by GPIO pins 12, 13 and 5, 6, respectively.

from gpiozero import Motor 
from gpiozero import OutputDevice 
import time 

motor_1_direction = OutputDevice(13) 
motor_2_direction = OutputDevice(12) 

motor = Motor(5, 6)

Copy

Explain
Controlling the motor is as simple as turning on the motor using the on() method and moving the motor in the forward direction using the forward() method:

motor.forward()

Copy

Explain
Similarly, reversing the motor direction could be done by calling the reverse() method. Stopping the motor could be done by:

motor.stop()

Copy

Explain
Some mini-project challenges for the reader
Here are some of mini-project challenged for our readers:

In this chapter, we discussed interfacing inputs for the Raspberry Pi and controlling motors. Think about a project where we could drive a mobile robot that reads inputs from whisker switches and operate a mobile robot. Is it possible to build a wall following robot in combination with the limit switches and motors?
We discussed controlling a DC motor in this chapter. How do we control a stepper motor using a Raspberry Pi?
How can we interface a motion sensor to control the lights at home using a Raspberry Pi Zero?
Read on to find out!

Note
Interested in playing tricks on your friends with your Raspberry Pi Zero? Check this book's website!

Summary
In this chapter, we discussed conditional statements and the applications of conditional statements in Python. We also discussed functions in Python, passing arguments to a function, returning values from a function and scope of variables in a Python program. We discussed callback functions and motor control in Python.



| ≪ [ 02 Arithmetic Operations, Loops, and Blinky Lights ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/02_Arithmetic_Operations__Loops__and_Blinky_Lights) | 03 Conditional Statements, Functions, and Lists | [ 04 Communication Interfaces ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/04_Communication_Interfaces) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 03 Conditional Statements, Functions, and Lists
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/03_Conditional_Statements__Functions__and_Lists
> Book Title: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> tags: Python RaspPi
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 11:35:57
> .md Name: 03_conditional_statements__functions__and_lists.md

