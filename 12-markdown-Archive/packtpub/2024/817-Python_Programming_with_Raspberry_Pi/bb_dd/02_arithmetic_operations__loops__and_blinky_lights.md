
| ≪ [ 01 Getting Started with Python and the Raspberry Pi Zero ](/packtpub/2024/817-Python_with_RaspPi_1ed/01_Getting_Started_with_Python_and_the_Raspberry_Pi_Zero) | 02 Arithmetic Operations, Loops, and Blinky Lights | [ 03 Conditional Statements, Functions, and Lists ](/packtpub/2024/817-Python_with_RaspPi_1ed/03_Conditional_Statements__Functions__and_Lists) ≫ |
|:----:|:----:|:----:|

# 02 Arithmetic Operations, Loops, and Blinky Lights
Chapter 2. Arithmetic Operations, Loops, and Blinky Lights
In the previous chapter, we discussed printing a line of text on the screen. In this chapter, we will review arithmetic operations and variables in Python. We will also discuss strings and accepting user inputs in Python. You will learn about the Raspberry Pi's GPIO and its features and write code in Python that makes an LED blink using the Raspberry Pi's GPIO. We will also discuss a practical application of controlling the Raspberry Pi's GPIO.

In this chapter, we will cover the following topics:

Arithmetic operations in Python
Bitwise operators in Python
Logical operators in Python
Data types and variables in Python
Loops in Python
Raspberry Pi Zero's GPIO interface.
Hardware required for this chapter
In this chapter, we will be discussing examples where we will be controlling the Raspberry Pi's GPIO. We will need a breadboard, jumper wires, LEDs, and some resistors (330 or 470 Ohms) to discuss these examples.

We will also need some optional hardware that we will discuss in the last section of this chapter.

Arithmetic operations
Python enables performing all the standard arithmetic operations. Let's launch the Python interpreter and learn more:

Addition: Two numbers can be added using the + operand. The result is printed on the screen. Try the following example using the python interpreter:
       >>>123+456 
       579

Copy

Explain
Subtraction: Two numbers can be added using the - operand:
       >>>456-123 
       333 
       >>>123-456 
       -333

Copy

Explain
Multiplication: Two numbers can be multiplied as follows:
       >>>123*456 
       56088

Copy

Explain
Division: Two numbers can be divided as follows:
       >>>456/22 
       20.727272727272727
       >>>456/2.0 
       228.0 
       >>>int(456/228) 
       2

Copy

Explain
Modulus operator: In Python, the modulus operator (%) returns the remainder of a division operation:
       >>>4%2 
       0 
       >>>3%2 
       1

Copy

Explain
The floor operator (//) is the opposite of the modulus operator. This operator returns the floor of the quotient, that is, the integer result, and discards the fractions:
       >>>9//7 
       1 
       >>>7//3 
       2 
       >>>79//25 
       3

Copy

Explain
Bitwise operators in Python
In Python, it is possible to perform bit-level operations on numbers. This is especially helpful while parsing information from certain sensors. For example, Some sensors share their output at a certain frequency. When a new data point is available, a certain bit is set indicating that the data is available. Bitwise operators can be used to check whether a particular bit is set before retrieving the datapoint from the sensor.

If you are interested in a deep dive on bitwise operators, we recommend getting started at https://en.wikipedia.org/wiki/Bitwise_operation.

Consider the numbers 3 and 2 whose binary equivalents are 011 and 010, respectively. Let's take a look at different operators that perform the operation on every bit of the number:

The AND operator: The AND operator is used to perform the AND operation on two numbers. Try this using the Python interpreter:
       >>>3&2 
       2

Copy

Explain
This is equivalent to the following AND operation:

   0 1 1 &
   0 1 0
   --------
   0 1 0 (the binary representation of the number 2)

Copy

Explain
The OR operator: The OR operator is used to perform the OR operation on two numbers as follows:
       >>>3|2 
       3

Copy

Explain
This is equivalent to the following OR operation:

   0 1 1 OR
   0 1 0
   --------
   0 1 1 (the binary representation of the number 3)

Copy

Explain
The NOT operator: The NOT operator flips the bits of a number. see the following example:
       >>>~1 
       -2

Copy

Explain
In the preceding example, the bits are flipped, that is, 1 as 0 and 0 as 1. So, the binary representation of 1 is 0001 and when the bitwise NOT operation is performed, the result is 1110. The interpreter returns the result as -2 because negative numbers are stored as their two's complement. The two's complement of 1 is -2.

Note
For a better understanding of two's complement and so on, we recommend reading the following articles, https://wiki.python.org/moin/BitwiseOperators and https://en.wikipedia.org/wiki/Two's_complement.

The XOR operator: An exclusive OR operation can be performed as follows:
       >>>3^2 
       1

Copy

Explain
Left shift operator: The left shift operator enables shifting the bits of a given value to the left by the desired number of places. For example, bit shifting the number 3 to the left gives us the number 6. The binary representation of the number 3 is 0011. Left shifting the bits by one position will give us 0110, that is, the number 6:
       >>>3<<1 
       6

Copy

Explain
Right shift operator: The right shift operator enables shifting the bits of a given value to the right by the desired number of places. Launch the command-line interpreter and try this yourself. What happens when you bit shift the number 6 to the right by one position?
Logical operators
Logical operators are used to check different conditions and execute the code accordingly. For example, detecting a button interfaced to the Raspberry Pi's GPIO being pressed and executing a specific task as a consequence. Let's discuss the basic logical operators:

EQUAL: The EQUAL (==) operator is used to compare if two values are equal:
       >>>3==3 
       True 
       >>>3==2 
       False

Copy

Explain
NOT EQUAL: The NOT EQUAL (!=) operator compares two values and returns True if they are not equal:
       >>>3!=2 
       True 
       >>>2!=2 
       False

Copy

Explain
GREATER THAN: This operator (>) returns True if one value is greater than the other value:
       >>>3>2 
       True 
       >>>2>3 
       False

Copy

Explain
LESS THAN: This operator compares two values and returns True if one value is smaller than the other:
       >>>2<3 
       True 
       >>>3<2 
       False

Copy

Explain
GREATER THAN OR EQUAL TO (>=): This operator compares two values and returns True if one value is greater/bigger than or equal to the other value:
       >>>4>=3 
       True 
       >>>3>=3 
       True 
       >>>2>=3 
       False

Copy

Explain
LESS THAN OR EQUAL TO (<=): This operator compares two values and returns True if one value is smaller than or equal to the other value:
       >>>2<=2 
       True 
       >>>2<=3 
       True 
       >>>3<=2 
       False

Copy

Explain
Data types and variables in Python
In Python, variables are used to store a result or a value in the computer's memory during the execution of a program. Variables enable easy access to a specific location on the computer's memory and enables writing user-readable code.

For example, let's consider a scenario where a person wants a new ID card from an office or a university. The person would be asked to fill out an application form with relevant information, including their name, department, and emergency contact information. The form would have the requisite fields. This would enable the office manager to refer to the form while creating a new ID card.

Similarly, variables simplify code development by providing means to store information in the computer's memory. It would be very difficult to write code if one had to write code keeping the storage memory map in mind. For example, it is easier to use the variable called name rather than a specific memory address like 0x3745092.

There are different kinds of data types in Python. Let's review the different data types:

In general, names, street addresses, and so on are a combination of alphanumeric characters. In Python, they are stored as strings. Strings in Python are represented and stored in variables as follows:
       >>>name = 'John Smith' 
       >>>address = '123 Main Street'

Copy

Explain
Numbers in Python could be stored as follows:
       >>>age = 29 
       >>>employee_id = 123456 
       >>>height = 179.5 
       >>>zip_code = 94560

Copy

Explain
Python also enables storing boolean variables. For example, a person's organ donor status can be either as True or False:
       >>>organ_donor = True

Copy

Explain
It is possible to assign values to multiple variables at the same time:
       >>>a = c= 1 
       >>>b = a

Copy

Explain
A variable may be deleted as follows:
       >>>del(a)

Copy

Explain
There are other data types in Python, including lists, tuples, and dictionaries. We will discuss this in detail in the next chapter.

Reading inputs from the user
In the previous chapter, we printed something on the screen for the user. Now, we will discuss a simple program where we ask the user to enter two numbers and the program returns the sum of two numbers. For now, we are going to pretend that the user always provides a valid input.

In Python, user input to a Python program can be provided using the input() function (https://docs.python.org/3/library/functions.html#input):

    var = input("Enter the first number: ")

Copy

Explain
In the preceding example, we are making use of the input() function to seek the user's input of the number. The input() function takes the prompt ("Enter the first number: ") as an argument and returns the user input. In this example, the user input is stored in the variable, var. In order to add two numbers, we make use of the input() function to request user to provide two numbers as input:

    var1 = input("Enter the first number: ") 
    var2 = input("Enter the second number: ") 
    total = int(var1) + int(var2) 
    print("The sum is %d" % total)

Copy

Explain
We are making use of the input() function to seek user input on two numbers. In this case, the user number is stored in var1 and var2, respectively. The user input is a string. We need to convert them into integers before adding them. We can convert a string to an integer using the int() function (https://docs.python.org/3/library/functions.html#int).

The int() function takes the string as an argument and returns the converted integer. The converted integers are added and stored in the variable, total. The preceding example is available for download along with this chapter as input_function.py.

Note
If the user input is invalid, the int() function will throw an exception indicating that an error has occurred. Hence, we assumed that user inputs are valid in this example. In a later chapter, we will discuss catching exceptions that are caused by invalid inputs.

The following snapshot shows the program output:


The input_function.py output

The formatted string output
Let's revisit the example discussed in the previous section. We printed the result as follows:

    print("The sum is %d" % total)

Copy

Explain
In Python, it is possible to format a string to display the result. In the earlier example, we make use of %d to indicate that it is a placeholder for an integer variable. This enables printing the string with the integer. Along with the string that is passed an argument to the print() function, the variable that needs to be printed is also passed an argument. In the earlier example, the variables are passed using the % operator. It is also possible to pass multiple variables:

print("The sum of %d and %d is %d" % (var1, var2, total))

Copy

Explain
It is also possible to format a string as follows:

print("The sum of 3 and 2 is {total}".format(total=5))

Copy

Explain
The str.format() method
The format() method enables formatting the string using braces ({}) as placeholders. In the preceding example, we use total as a placeholder and use the format method of the string class to fill each place holder.

An exercise for the reader
Make use of the format() method to format a string with more than one variable.

Let's build a console/command-line application that takes inputs from the user and print it on the screen. Let's create a new file named input_test.py, (available along with this chapter's downloads) take some user inputs and print them on the screen:

    name = input("What is your name? ") 
    address = input("What is your address? ") 
    age = input("How old are you? ") 

    print("My name is " + name) 
    print("I am " + age + " years old") 
    print("My address is " + address)

Copy

Explain
Execute the program and see what happens:


The input_test.py output

The preceding example is available for download along with this chapter as input_test.py.

Another exercise for the reader
Repeat the earlier example using the string formatting techniques.

Concatenating strings
In the preceding example, we printed the user inputs in combination with another string. For example, we took the user input name and printed the sentence as My name is Sai. The process of appending one string to another is called concatenation.

In Python, strings can be concatenated by adding + between two strings:

    name = input("What is your name? ") 
    print("My name is " + name)

Copy

Explain
It is possible to concatenate two strings, but it is not possible to concatenate an integer. Let's consider the following example:

    id = 5 
    print("My id is " + id)

Copy

Explain
It would throw an error implying that integers and strings cannot be combined:


An exception

It is possible to convert an integer to string and concatenate it to another string:

    print("My id is " + str(id))

Copy

Explain
This would give the following result:


Loops in Python
Sometimes, a specific task has to be repeated several times. In such cases, we could use loops. In Python, there are two types of loops, namely the for loop and while loop. Let's review them with specific examples.

A for loop
In Python, a for loop is used to execute a task for n times. A for loop iterates through each element of a sequence. This sequence could be a dictionary, list, or any other iterator. For example, let's discuss an example where we execute a loop:

    for i in range(0, 10): 
       print("Loop execution no: ", i)

Copy

Explain
In the preceding example, the print statement is executed 10 times:


In order to execute the print task 10 times, the range() function (https://docs.python.org/2/library/functions.html#range) was used. The range function generates a list of numbers for a start and stop values that are passed as an arguments to the function. In this case, 0 and 10 are passed as arguments to the range() function. This returns a list containing numbers from 0 to 9. The for loop iterates through the code block for each element in steps of 1. The range function can also generate a list of numbers in steps of 2. This is done by passing the start value, stop value, and the step value as arguments to the range() function:

    for i in range(0, 20, 2): 
       print("Loop execution no: ", i)

Copy

Explain
In this example, 0 is the start value, 20 is the stop value, and 2 is the step value. This generates a list of 10 numbers in steps of two:


The range function can be used to count down from a given number. Let's say we would like to count down from 10 to 1:

    for i in range(10, 0, -1): 
       print("Count down no: ", i)

Copy

Explain
The output would be something like:


The general syntax of the range function is range(start, stop, step_count). It generates a sequence of numbers from start to n-1 where n is the stop value.

Indentation
Note the indentation in the for loop block:

    for i in range(10, 1, -1): 
       print("Count down no: ", i)

Copy

Explain
Python executes the block of code under the for loop statement. It is one of the features of the Python programming language. It executes any piece of code under the for loop as long as it has same level of indentation:

    for i in range(0,10): 
       #start of block 
       print("Hello") 
       #end of block

Copy

Explain
The indentation has the following two uses:

It makes the code readable
It helps us identify the block of code to be executed in a loop
It is important to pay attention to indentation in Python as it directly affects how a piece of code is executed.

Nested loops
In Python, it is possible to implement a loop within a loop. For example, let's say we have to print x and y coordinates of a map. We can use nested loops to implement this:

for x in range(0,3): 
   for y in range(0,3): 
         print(x,y)

Copy

Explain
The expected output is:


Be careful about code indentation in nested loops as it may throw errors. Consider the following example:

for x in range(0,10): 
   for y in range(0,10): 
   print(x,y)

Copy

Explain
The Python interpreter would throw the following error:

    SyntaxError: expected an indented block

Copy

Explain
This is visible in the following screenshot:


Hence, it is important to pay attention to indentation in Python (especially nested loops) to successfully execute the code. IDLE's text editor automatically indents code as you write them. This should aid with understanding indentation in Python.

A while loop
while loops are used when a specific task is supposed to be executed until a specific condition is met. while loops are commonly used to execute code in an infinite loop. Let's look at a specific example where we would like to print the value of i from 0 to 9:

i=0 
while i<10: 
  print("The value of i is ",i) 
  i+=1

Copy

Explain
Inside the while loop, we increment i by 1 for every iteration. The value of i is incremented as follows:

i += 1

Copy

Explain
This is equivalent to i = i+1.

This example would execute the code until the value of i is less than 10. It is also possible to execute something in an infinite loop:

i=0 
while True: 
  print("The value of i is ",i) 
  i+=1

Copy

Explain
The execution of this infinite loop can be stopped by pressing Ctrl + C on your keyboard.

It is also possible to have nested while loops:

i=0 
j=0 
while i<10: 
  while j<10: 
    print("The value of i,j is ",i,",",j) 
    i+=1 
    j+=1

Copy

Explain
Similar to for loops, while loops also rely on the indented code block to execute a piece of code.

Note
Python enables printing a combination of strings and integers as long as they are presented as arguments to the print function separated by commas. In the earlier-mentioned example, The value of i,j is, i are arguments to the print function. You will learn more about functions and arguments in the next chapter. This feature enables formatting the output string to suit our needs.

Raspberry Pi's GPIO
The Raspberry Pi Zero comes with a 40-pin GPIO header. Out of these 40 pins, we can use 26 pins either to read inputs (from sensors) or control outputs. The other pins are power supply pins (5V, 3.3V, and Ground pins):


Raspberry Pi Zero GPIO mapping (source: https://www.raspberrypi.org/documentation/usage/gpio-plus-and-raspi2/README.md)

We can use up to 26 pins of the Raspberry Pi's GPIO to interface appliances and control them. But, there are certain pins that have an alternative function, which will be discussed in the later chapters.

The earlier image shows the mapping of the Raspberry Pi's GPIO pins. The numbers in the circle correspond to the pin numbers on the Raspberry Pi's processor. For example, GPIO pin 2 (second pin from the left on the bottom row) corresponds to the GPIO pin 2 on the Raspberry Pi's processor and not the physical pin location on the GPIO header.

In the beginning, it might be confusing to try and understand the pin mapping. Keep a GPIO pin handout (available for download along with this chapter) for your reference. It takes some time to get used to the GPIO pin mapping of the Raspberry Pi Zero.

Note
The Raspberry Pi Zero's GPIO pins are 3.3V tolerant, that is, if a voltage greater than 3.3V is applied to the pin, it may permanently damage the pin. When set to high, the pins are set to 3.3V and 0V when the pins are set to low.

Blinky lights
Let's discuss an example where we make use of the Raspberry Pi Zero's GPIO. We will interface an LED to the Raspberry Pi Zero and make it blink on and off with a 1-second interval.

Let's wire up the Raspberry Pi zero to get started:


Blinky schematic generated using Fritzing

In the preceding schematic, the GPIO pin 2 is connected to the anode (the longest leg) of the LED. The cathode of the LED is connected to the ground pin of the Raspberry Pi Zero. A 330 Ohm current limiting resistor is also used to limit the flow of the current.


Breadboard connections to the Raspberry Pi Zero

Code
We will make use of the python3-gpiozero library (https://gpiozero.readthedocs.io/en/v1.3.1/). The Raspbian Jessie OS image comes with the pre-installed library. It is very simple to use, and it is the best option to get started as a beginner. It supports a standard set of devices that helps us get started easily.

For example, in order to interface an LED, we need to import the LED class from the gpiozero library:

from gpiozero import LED

Copy

Explain
We will be turning the LED on and off at a 1-second interval. In order to do so, we will be importing the time library. In Python, we need to import a library to make use of it. Since we interfaced the LED to the GPIO pin 2, let's make a mention of that in our code:

import time 

led = LED(2)

Copy

Explain
We just created a variable named led and defined that we will be making use of GPIO pin 2 in the LED class. Let's make use of a while loop to turn the LED on and off with a 1-second interval.

The gpiozero library's LED class comes with functions named on() and off() to set the GPIO pin 2 to high and low, respectively:

while True: 
    led.on() 
    time.sleep(1) 
    led.off() 
    time.sleep(1)

Copy

Explain
In Python's time library, there is a sleep function that enables introducing a 1-second delay between turning on/off the LED. This is executed in an infinite loop! We just built a practical example using the Raspberry Pi Zero.

Putting all the code together in a file named blinky.py (available for download along with this book), run the code from the command-line terminal (alternatively, you may use IDLE3):

python3 blinky.py

Copy

Explain
The applications of GPIO control
Now that we have implemented our first example, let's discuss some possible applications of being able to control the GPIO. We could use the Raspberry Pi's GPIO to control the lights in our homes. We will make use of the same example to control a table lamp!

There is a product called the PowerSwitch Tail II (http://www.powerswitchtail.com/Pages/default.aspx) that enables interfacing AC appliances like a table lamp to a Raspberry Pi. The PowerSwitch Tail comes with control pins (that can take a 3.3V high signal) that could be used to turn on/off a lamp. The switch comes with the requisite circuitry/protection to interface it directly to a Raspberry Pi Zero:


The Pi Zero interfaced to the PowerSwitch Tail II

Let's take the same example from the previous section and connect the GPIO pin 2 to the +in pin of the PowerSwitch Tail. Let's connect the ground pin of the Raspberry Pi Zero's GPIO header to the PowerSwitch Tail's -in pain. The PowerSwitch Tail should be connected to the AC mains. The lamp should be connected to the AC output of the switch. If we use the same piece of code and connect a lamp to the PowerSwitch Tail, we should be able to turn on/off with a 1-second interval.


PowerSwitch Tail II connected to a Raspberry Pi Zero

Note
This appliance control using the LED blinking code is just an example. It is not recommended to turn on/off a table lamp at such short intervals. In future chapters, we will make use of the Raspberry Pi Zero's GPIO to control appliances from anywhere on the Internet.

Summary
In this chapter, we reviewed the integers, boolean, and string data types as well as arithmetic operations and logical operators in Python. We also discussed accepting user inputs and loops. We introduced ourselves to the Raspberry Pi Zero's GPIO and discussed an LED blinking example. We took the same example to control a table lamp!

Have you heard of the chat application named Slack? How about controlling a table lamp at home from your laptop at work? If that piques your interest, work with us toward that over the next few chapters.



| ≪ [ 01 Getting Started with Python and the Raspberry Pi Zero ](/packtpub/2024/817-Python_with_RaspPi_1ed/01_Getting_Started_with_Python_and_the_Raspberry_Pi_Zero) | 02 Arithmetic Operations, Loops, and Blinky Lights | [ 03 Conditional Statements, Functions, and Lists ](/packtpub/2024/817-Python_with_RaspPi_1ed/03_Conditional_Statements__Functions__and_Lists) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 02 Arithmetic Operations, Loops, and Blinky Lights
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: /packtpub/2024/817-Python_with_RaspPi_1ed/02_Arithmetic_Operations__Loops__and_Blinky_Lights
> Book Jemok: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 16:35:08
> .md Name: 02_arithmetic_operations__loops__and_blinky_lights.md

