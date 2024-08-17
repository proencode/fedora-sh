
| ≪ [ 04 Communication Interfaces ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/04_Communication_Interfaces) | 05 Data Types and Object-Oriented Programming in Python | [ 06 File I/O and Python Utilities ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/06_File_I-O_and_Python_Utilities) ≫ |
|:----:|:----:|:----:|

# 05 Data Types and Object-Oriented Programming in Python
Chapter 5. Data Types and Object-Oriented Programming in Python
In this chapter, we will discuss data types and object-oriented programming (OOP) in Python. We will discuss data types including lists, dictionaries, tuples and sets in Python. We will also discuss OOP, it's necessity and how to write object-oriented code in Python for Raspberry Pi based projects (such as, using OOP to control appliances at home). We will discuss making use of OOP in a Raspberry Pi Zero project.

Lists
In Python, a list is a data type (its documentation is available here, https://docs.python.org/3.4/tutorial/datastructures.html#) that could be used to store elements in a sequence.

Note
The topics discussed in this chapter can be difficult to grasp unless used in practice. Any example that is represented using this notation: >>> indicates that it could be tested using the Python interpreter.

A list may consist of strings, objects (discussed in detail in this chapter) or numbers, and so on. For instance, the following are examples of lists:

>>> sequence = [1, 2, 3, 4, 5, 6]
    >>> example_list = ['apple', 'orange', 1.0, 2.0, 3]

Copy

Explain
In the preceding set of examples, the sequence list consists of numbers between 1 and 6 while the example_list list consists of a combination of strings, integer, and floating-point numbers. A list is represented by square brackets ([]). Items can be added to a list separated by commas:

>>> type(sequence)
    <class 'list'>

Copy

Explain
Since a list is an ordered sequence of elements, the elements of a list could be fetched by iterating through the list elements using a for loop as follows:

for item in sequence: 
    print("The number is ", item)

Copy

Explain
The output is something as follows:

    The number is  1
    The number is  2
    The number is  3
    The number is  4
    The number is  5
    The number is  6

Copy

Explain
Since Python's loop can iterate through a sequence of elements, it fetches each element and assigns it to item. This item is printed on the console.

Operations that could be performed on a list
In Python, the attributes of a data type can be retrieved using the dir() method. For example, the attributes available for the sequence list can be retrieved as follows:

>>> dir(sequence)
    ['__add__', '__class__', '__contains__', '__delattr__',
    '__delitem__', '__dir__', '__doc__', '__eq__',
    '__format__', '__ge__', '__getattribute__', '__getitem__',
    '__gt__', '__hash__', '__iadd__', '__imul__', '__init__', 
    '__iter__', '__le__', '__len__', '__lt__', '__mul__',
    '__ne__', '__new__', '__reduce__', '__reduce_ex__',
    '__repr__', '__reversed__', '__rmul__', '__setattr__', 
    '__setitem__', '__sizeof__', '__str__', '__subclasshook__', 
    'append', 'clear', 'copy', 'count', 'extend', 'index',
    'insert', 'pop', 'remove', 'reverse', 'sort']

Copy

Explain
These attributes enable performing different operations on a list. Let's discuss each attribute in detail.

Append element to list:
It is possible to add an element using the append() method:

>>> sequence.append(7)
    >>> sequence
    [1, 2, 3, 4, 5, 6, 7]

Copy

Explain
Remove element from list:
The remove() method finds the first instance of the element (passed an argument) and removes it from the list. Let's consider the following examples:

Example 1:
>>> sequence = [1, 1, 2, 3, 4, 7, 5, 6, 7]
       >>> sequence.remove(7)
       >>> sequence
       [1, 1, 2, 3, 4, 5, 6, 7]

Copy

Explain
Example 2:
>>> sequence.remove(1)
       >>> sequence
       [1, 2, 3, 4, 5, 6, 7]

Copy

Explain
Example 3:
>>> sequence.remove(1)
       >>> sequence
       [2, 3, 4, 5, 6, 7]

Copy

Explain
Retrieving the index of an element
The index() method returns the position of an element in a list:

>>> index_list = [1, 2, 3, 4, 5, 6, 7]
    >>> index_list.index(5)
    4

Copy

Explain
In this example, the method returns the index of the element 5. Since Python uses zero-based indexing that is the index is counted from 0 and hence the index of the element 5 is 4:

random_list = [2, 2, 4, 5, 5, 5, 6, 7, 7, 8]
    >>> random_list.index(5)
    3

Copy

Explain
In this example, the method returns the position of the first instance of the element. The element 5 is located at the third position.

Popping an element from the list
The pop() method enables removing an element from a specified position and return it:

>>> index_list = [1, 2, 3, 4, 5, 6, 7]
    >>> index_list.pop(3)
    4
    >>> index_list
    [1, 2, 3, 5, 6, 7]

Copy

Explain
In this example, the index_list list consists of numbers between 1 and 7. When the third element is popped by passing the index position (3) as an argument, the number 4 is removed from the list and returned.

If no arguments are provided for the index position, the last element is popped and returned:

>>> index_list.pop()
    7
    >>> index_list
    [1, 2, 3, 5, 6]

Copy

Explain
In this example, the last element (7) was popped and returned.

Counting the instances of an element:
The count() method returns the number of times an element appears in a list. For example, the element appears twice in the list: random_list.

    >>> random_list = [2, 9, 8, 4, 3, 2, 1, 7]
    >>> random_list.count(2)
    2

Copy

Explain
Inserting element at a specific position:
The insert() method enables adding an element at a specific position in the list. For example, let's consider the following example:

>>> day_of_week = ['Monday', 'Tuesday', 'Thursday',
    'Friday', 'Saturday']

Copy

Explain
In the list, Wednesday is missing. It needs to be positioned between Tuesday and Thursday at position 2 (Python uses zero based indexing that is the positions/indexes of elements are counted as 0, 1, 2, and so on.). It could be added using insert as follows:

>>> day_of_week.insert(2, 'Wednesday')
    >>> day_of_week
    ['Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday']

Copy

Explain
 

Challenge to the reader
In the preceding list, Sunday is missing. Use the insert attribute of lists to insert it at the correct position.

Extending a list
Two lists can be combined together using the extend() method. The day_of_week and sequence lists can be combined as follows:

>>> day_of_week.extend(sequence)
    >>> day_of_week
    ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday',
    'Saturday', 1, 2, 3, 4, 5, 6]

Copy

Explain
Lists can also be combined as follows:

>>> [1, 2, 3] + [4, 5, 6]
    [1, 2, 3, 4, 5, 6]

Copy

Explain
It is also possible to add a list as an element to another list:

sequence.insert(6, [1, 2, 3])
    >>> sequence
    [1, 2, 3, 4, 5, 6, [1, 2, 3]]

Copy

Explain
Clearing the elements of a list
All the elements of a list could be deleted using the clear() method:

>>> sequence.clear()
    >>> sequence
    []

Copy

Explain
Sorting the elements of a list
The elements of a list could be sorted using the sort() method:

random_list = [8, 7, 5, 2, 2, 5, 7, 5, 6, 4]
    >>> random_list.sort()
    >>> random_list
    [2, 2, 4, 5, 5, 5, 6, 7, 7, 8]

Copy

Explain
When a list consists of a collection of strings, they are sorted in the alphabetical order:

>>> day_of_week = ['Monday', 'Tuesday', 'Thursday',
    'Friday', 'Saturday']
    >>> day_of_week.sort()
    >>> day_of_week
    ['Friday', 'Monday', 'Saturday', 'Thursday', 'Tuesday']

Copy

Explain
Reverse the order of elements in list
The reverse() method enables the reversing the order of the list elements:

>>> random_list = [8, 7, 5, 2, 2, 5, 7, 5, 6, 4]
    >>> random_list.reverse()
    >>> random_list
    [4, 6, 5, 7, 5, 2, 2, 5, 7, 8]

Copy

Explain
Create copies of a list
The copy() method enables creating copies of a list:

>>> copy_list = random_list.copy()
    >>> copy_list
    [4, 6, 5, 7, 5, 2, 2, 5, 7, 8]

Copy

Explain
Accessing list elements
The list elements could be accessed by specifying the index position of the list_name[i] element. For example, the zeroth list element of the random_list list could be accessed as follows:

    >>> random_list = [4, 6, 5, 7, 5, 2, 2, 5, 7, 8]
    >>> random_list[0]4>>> random_list[3]7

Copy

Explain
Accessing a set of elements within a list
It is possible to access elements between specified indices. For example, it is possible to retrieve all elements between indices 2 and 4:

>>> random_list[2:5]
    [5, 7, 5]

Copy

Explain
The first six elements of a list could be accessed as follows:

>>> random_list[:6]
    [4, 6, 5, 7, 5, 2]

Copy

Explain
The elements of a list could be printed in the reverse order as follows:

>>> random_list[::-1]
    [8, 7, 5, 2, 2, 5, 7, 5, 6, 4]

Copy

Explain
Every second element in the list could be fetched as follows:

>>> random_list[::2]
    [4, 5, 5, 2, 7]

Copy

Explain
It is also possible to fetch every second element after the second element after skipping the first two elements:

>>> random_list[2::2]
    [5, 5, 2, 7]

Copy

Explain
List membership
It is possible to check if a value is a member of a list using the in keyword. For example:

    >>> random_list = [2, 1, 0, 8, 3, 1, 10, 9, 5, 4]

Copy

Explain
In this list, we could check if the number 6 is a member:

>>> 6 in random_list
    False
    >>> 4 in random_list
    True

Copy

Explain
Let's build a simple game!
This exercise consists of two parts. In the first part, we will review building a list containing ten random numbers between 0 and 10. The second part is a challenge to the reader. Perform the following steps:

The first step is creating an empty list. Let's create an empty list called random_list. An empty list can be created as follows:
       random_list = []

Copy

Explain
We will be making use of Python's random module (https://docs.python.org/3/library/random.html) to generate random numbers. In order to generate random numbers between 0 and 10, we will make use of the randint() method from the random module:
       random_number = random.randint(0,10)

Copy

Explain
Let's append the generated number to the list. This operation is repeated 10 times using a for loop:
       for index in range(0,10):
             random_number = random.randint(0, 10)
             random_list.append(random_number)
       print("The items in random_list are ")
       print(random_list)

Copy

Explain
The generated list looks something like this:
The items in random_list are
       [2, 1, 0, 8, 3, 1, 10, 9, 5, 4]

Copy

Explain
We discussed generating a list of random numbers. The next step is taking user input where we ask the user to make a guess for a number between 0 and 10. If the number is a member of the list, the message Your guess is correct is printed to the screen, else, the message Sorry! Your guess is incorrect is printed. We leave the second part as a challenge to the reader. Get started with the list_generator.py code sample available for download with this chapter.

Dictionaries
A dictionary (https://docs.python.org/3.4/tutorial/datastructures.html#dictionaries) is a data type that is an unordered collection of key and value pairs. Each key in a dictionary has an associated value. An example of a dictionary is:

    >>> my_dict = {1: "Hello", 2: "World"}
    >>> my_dict

    {1: 'Hello', 2: 'World'}

Copy

Explain
A dictionary is created by using the braces {}. At the time of creation, new members are added to the dictionary in the following format: key: value (shown in the preceding example). In the previous example 1 and 2 are keys while 'Hello' and 'World' are the associated values. Each value added to a dictionary needs to have an associated key.

The elements of a dictionary do not have an order i.e. the elements cannot be retrieved in the order they were added. It is possible to retrieving the values of a dictionary by iterating through the keys. Let's consider the following example:

>>> my_dict = {1: "Hello", 2: "World", 3: "I", 4: "am",
    5: "excited", 6: "to", 7: "learn", 8: "Python" }

Copy

Explain
There are several ways to print the keys or values of a dictionary:

>>> for key in my_dict:

    ... 

    print(my_dict[value])

    ...

    Hello

    World

    I

    am

    excited

    to

    learn

    Python

Copy

Explain
In the preceding example, we iterate through the keys of the dictionary and retrieve the value using the key, my_dict[key]. It is also possible to retrieve the values using the values() method available with dictionaries:

>>> for value in my_dict.values():

... 

    print(value)

...

    Hello

    World

    I

am

    excited

    to

    learn

Python

Copy

Explain
The keys of a dictionary can be an integer, string, or a tuple. The keys of a dictionary need to be unique and it is immutable, that is a key cannot be modified after creation. Duplicates of a key cannot be created. If a new value is added to an existing key, the latest value is stored in the dictionary. Let's consider the following example:

A new key/value pair could be added to a dictionary as follows:
>>> my_dict[9] = 'test'

       >>> my_dict

       {1: 'Hello', 2: 'World', 3: 'I', 4: 'am', 5: 'excited',
       6: 'to', 7: 'learn', 8: 'Python', 9: 'test'}

Copy

Explain
Let's try creating a duplicate of the key 9:
>>> my_dict[9] = 'programming'

       >>> my_dict

{1: 'Hello', 2: 'World', 3: 'I', 4: 'am', 5: 'excited',
       6: 'to', 7: 'learn', 8: 'Python', 9: 'programming'}

Copy

Explain
As shown in the preceding example, when we try to create a duplicate, the value of the existing key is modified.
It is possible to have multiple values associated with a key. For example, as a list or a dictionary:
>>> my_dict = {1: "Hello", 2: "World", 3: "I", 4: "am",
      "values": [1, 2, 3,4, 5], "test": {"1": 1, "2": 2} }

Copy

Explain
Dictionaries are useful in scenarios like parsing CSV files and associating each row with a unique key. Dictionaries are also used to encode and decode JSON data

Tuples
A tuple (pronounced either like two-ple or tuh-ple) is an immutable data type that are ordered and separated by a comma. A tuple can be created as follows:

>>> my_tuple = 1, 2, 3, 4, 5

      >>> my_tuple

      (1, 2, 3, 4, 5)

Copy

Explain
Since tuples are immutable, the value at a given index cannot be modified:

>>> my_tuple[1] = 3
    Traceback (most recent call last):
      File "<stdin>", line 1, in <module>
    TypeError: 'tuple' object does not support item assignment

Copy

Explain
A tuple can consist of a number, string, or a list. Since lists are mutable, if a list is a member of a tuple, it can be modified. For example:

>>> my_tuple = 1, 2, 3, 4, [1, 2, 4, 5]
    >>> my_tuple[4][2] = 3
    >>> my_tuple
    (1, 2, 3, 4, [1, 2, 3, 5])

Copy

Explain
Tuples are especially useful in scenarios where the value cannot be modified. Tuples are also used to return values from a function. Let's consider the following example:

>>> for value in my_dict.items():

    ... 

    print(value)

    ...

    (1, 'Hello')

    (2, 'World')

    (3, 'I')

    (4, 'am')

    ('test', {'1': 1, '2': 2})

    ('values', [1, 2, 3, 4, 5])

Copy

Explain
In the preceding example, the items() method returns a list of tuples.

Sets
A set (https://docs.python.org/3/tutorial/datastructures.html#sets) is an unordered collection of immutable elements without duplicate entries. A set could be created as follows:

>>> my_set = set([1, 2, 3, 4, 5])

    >>> my_set

    {1, 2, 3, 4, 5}

Copy

Explain
Now, let's add a duplicate list to this set:

>>> my_set.update([1, 2, 3, 4, 5])

    >>> my_set

    {1, 2, 3, 4, 5}

Copy

Explain
Sets enable avoid duplication of entries and saving the unique entries. A single element can be added to a set as follows:

>>> my_set = set([1, 2, 3, 4, 5])

    >>> my_set.add(6)

    >>> my_set

    {1, 2, 3, 4, 5, 6}

Copy

Explain
Sets are used to test memberships of an element among different sets. There are different methods that are related to membership tests. We recommend learning about each method using the documentation on sets (run help(my_set) to find the different methods available for membership tests).

OOP in Python
OOP is a concept that helps simplifying your code and eases application development. It is especially useful in reusing your code. Object-oriented code enables reusing your code for sensors that use the communications interface. For example, all sensors that are equipped with a UART port could be grouped together using object-oriented code.

One example of OOP is the GPIO Zero library (https://www.raspberrypi.org/blog/gpio-zero-a-friendly-python-api-for-physical-computing/) used in previous chapters. In fact, everything is an object in Python.

Object-oriented code is especially helpful in collaboration with other people on a project. For example, you could implement a sensor driver using object-oriented code in Python and document its usage. This enables other developers to develop an application without paying attention to the nitty-gritty detail behind the sensor's interface. OOP provides modularity to an application that simplifies application development. We are going to review an example in this chapter that demonstrates the advantage of OOP. In this chapter, we will be making use of OOP to bring modularity to our project.

Let's get started!

Revisiting the student ID card example
Let's revisit the ID card example from Chapter 2, Arithmetic Operations, Loops, and Blinky Lights (input_test.py). We discussed writing a simple program that captures and prints the information belonging to a student. A student's contact information could be retrieved and stored as follows:

name = input("What is your name? ") 
address = input("What is your address? ") 
age = input("How old are you? ")

Copy

Explain
Now, consider a scenario where the information of 10 students has to be saved and retrieved at any point during program execution. We would need to come up with a nomenclature for the variables used to save the student information. It would be a clutter if we use 30 different variables to store information belonging to each student. This is where object oriented programming can be really helpful.

Let's rewrite this example using OOP to simplify the problem. The first step in OOP is declaring a structure for the object. This is done by defining a class. The class determines the functions of an object. Let's write a Python class that defines the structure for a student object.

Class
Since we are going to save student information, the class is going to be called Student. A class is defined using the class keyword as follows:

class Student(object):

Copy

Explain
Thus, a class called Student has been defined. Whenever a new object is created, the method __init__() (the underscore indicate that the init method is a magic method, that is it is a function that is called by Python when an object is created) is called internally by Python. This method is defined within the class:

class Student(object): 
    """A Python class to store student information""" 

    def __init__(self, name, address, age): 
        self.name = name 
        self.address = address 
        self.age = age

Copy

Explain
In this example, the arguments to the __init__ method include name, age and address. These arguments are called attributes. These attributes enable creating a unique object that belongs to the Student class. Hence, in this example, while creating an instance of the Student class, the attributes name, age, and address are required arguments.

Let's create an object (also called an instance) belonging to the Student class:

student1 = Student("John Doe", "123 Main Street, Newark, CA", "29")

Copy

Explain
In this example, we created an object belonging to the Student class called student1 where John Doe (name), 29 (age) and 123 Main Street, Newark, CA(address) are attributes required to create an object. When we create an object that belongs to the Student class by passing the requisite arguments (declared earlier in the __init__() method of the Student class), the __init__() method is automatically called to initialize the object. Upon initialization, the information related to student1 is stored under the object student1.

Now, the information belonging to student1 could be retrieved as follows:

print(student1.name) 
print(student1.age) 
print(student1.address)

Copy

Explain
Now, let's create another object called student2:

student2 = Student("Jane Doe", "123 Main Street, San Jose, CA", "27")

Copy

Explain
We created two objects called student1 and student2. Each object's attributes are accessible as student1.name, student2.name and so on. In the absence of object oriented programming, we will have to create variables like student1_name, student1_age, student1_address, student2_name, student2_age and student2_address and so on. Thus, OOP enables modularizing the code.

Adding methods to a class
Let's add some methods to our Student class that would help retrieve a student's information:

class Student(object): 
    """A Python class to store student information""" 

    def __init__(self, name, age, address): 
        self.name = name 
        self.address = address 
        self.age = age 

    def return_name(self): 
        """return student name""" 
        return self.name 

    def return_age(self): 
        """return student age""" 
        return self.age 

    def return_address(self): 
        """return student address""" 
        return self.address

Copy

Explain
In this example, we have added three methods namely return_name(), return_age() and return_address() that returns the attributes name, age and address respectively. These methods of a class are called callable attributes. Let's review a quick example where we make use of these callable attributes to print an object's information.

student1 = Student("John Doe", "29", "123 Main Street, Newark, CA") 
print(student1.return_name()) 
print(student1.return_age()) 
print(student1.return_address())

Copy

Explain
So far, we discussed methods that retrieves information about a student. Let's include a method in our class that enables updating information belonging to a student. Now, let's add another method to the class that enables updating address by a student:

def update_address(self, address): 
    """update student address""" 
    self.address = address 
    return self.address

Copy

Explain
Let's compare the student1 object's address before and after updating the address:

print(student1.address()) 
print(student1.update_address("234 Main Street, Newark, CA"))

Copy

Explain
This would print the following output to your screen:

123 Main Street, Newark, CA
    234 Main Street, Newark, CA

Copy

Explain
Thus, we have written our first object-oriented code that demonstrates the ability to modularize the code. The preceding code sample is available for download along with this chapter as student_info.py.

Doc strings in Python
In the object oriented example, you might have noticed a sentence enclosed in triple double quotes:

    """A Python class to store student information"""

Copy

Explain
This is called a doc string. The doc string is used to document information about a class or a method. Doc strings are especially helpful while trying to store information related to the usage of a method or a class (this will be demonstrated later in this chapter). Doc strings are also used at the beginning of a file to store multi-line comments related to an application or a code sample. Doc strings are ignored by the Python interpreter and they are meant to provide documentation about a class to fellow programmers.

Similarly, the Python interpreter ignores any single line comment that starts with a # sign. Single line comments are generally used to make a specific note on a block of code. The practice of including well-structured comments makes your code readable.

For example, the following code snippet informs the reader that a random number between 0 and 9 is generated and stored in the variable rand_num:

# generate a random number between 0 and 9 
rand_num = random.randrange(0,10)

Copy

Explain
On the contrary, a comment that provides no context is going to confuse someone who is reviewing your code:

# Todo: Fix this later

Copy

Explain
It is quite possible that you may not be able to recall what needs fixing when you revisit the code later.

self
In our object-oriented example, the first argument to every method had an argument called self. self refers to the instance of the class in use and the self keyword is used as the first argument in methods that interact with the instances of the class. In the preceding example, self refers to the object student1. It is equivalent to initializing an object and accessing it as follows:

Student(student1, "John Doe", "29", "123 Main Street, Newark, CA") 
Student.return_address(student1)

Copy

Explain
The self keyword simplifies how we access an object's attributes in this case. Now, let's review some examples where we make use of OOP involving the Raspberry Pi.

Speaker controller
Let's write a Python class (tone_player.py in downloads) that plays a musical tone indicating that the boot-up of your Raspberry Pi is complete. For this section, you will need a USB sound card and a speaker interfaced to the USB hub of the Raspberry Pi.

Let's call our class TonePlayer. This class should be capable of controlling the speaker volume and playing any file passed as an argument while creating an object:

class TonePlayer(object): 
    """A Python class to play boot-up complete tone""" 

    def __init__(self, file_name): 
        self.file_name = file_name

Copy

Explain
In this case, the file that has to be played by the TonePlayer class has to be passed an argument. For example:

       tone_player = TonePlayer("/home/pi/tone.wav")

Copy

Explain
We also need to be able to set the volume level at which the tone has to be played. Let's add a method to do the same:

def set_volume(self, value): 
    """set tone sound volume""" 
    subprocess.Popen(["amixer", "set", "'PCM'", str(value)], 
    shell=False)

Copy

Explain
In the set_volume method, we make use of Python's subprocess module to run the Linux system command that adjusts the sound drive volume.

The most essential method for this class is the play command. When the play method is called, we need to play the tone sound using Linux's a play command:

def play(self):
    """play the wav file"""
    subprocess.Popen(["aplay", self.file_name], shell=False)

Copy

Explain
Put it all together:

import subprocess 

class TonePlayer(object): 
    """A Python class to play boot-up complete tone""" 

    def __init__(self, file_name): 
        self.file_name = file_name 

    def set_volume(self, value): 
        """set tone sound volume""" 
        subprocess.Popen(["amixer", "set", "'PCM'", str(value)],
        shell=False) 

    def play(self): 
        """play the wav file""" 
        subprocess.Popen(["aplay", self.file_name], shell=False) 


if __name__ == "__main__": 
    tone_player = TonePlayer("/home/pi/tone.wav") 
    tone_player.set_volume(75) 
    tone_player.play()

Copy

Explain
Save the TonePlayer class to your Raspberry Pi (save it to a file called tone_player.py) and use a tone sound file from sources like freesound (https://www.freesound.org/people/zippi1/sounds/18872/). Save it to a location of your choice and try running the code. It should play the tone sound at the desired volume!

Now, edit /etc/rc.local and add the following line to the end of the file (right before the exit 0 line):

python3 /home/pi/toneplayer.py

Copy

Explain
This should play a tone whenever the Pi boots up!

Light control daemon
Let's review another example where we implement a simple daemon using OOP that turns on/off lights at specified times of the day. In order to be able to perform tasks at scheduled times, we will make use of the schedule library (https://github.com/dbader/schedule). It could be installed as follows:

sudo pip3 install schedule

Copy

Explain
Let's call our class, LightScheduler. It should be capable of accepting start and top times to turn on/off lights at given times. It should also provide override capabilities to let the user turn on/off lights as necessary. Let's assume that the light is controlled using PowerSwitch Tail II (http://www.powerswitchtail.com/Pages/default.aspx). It is interfaced as follows:


Raspberry Pi Zero interfaced to the PowerSwitch Tail II

The following is the LightSchedular class created:

class LightScheduler(object): 
    """A Python class to turn on/off lights""" 

    def __init__(self, start_time, stop_time): 
        self.start_time = start_time 
        self.stop_time = stop_time 
        # lamp is connected to GPIO pin2.
        self.lights = OutputDevice(2)

Copy

Explain
Whenever an instance of LightScheduler is created, the GPIO pin is initialized to control the PowerSwitch Tail II. Now, let's add methods to turn on/off lights:

def init_schedule(self): 
        # set the schedule 
        schedule.every().day.at(self.start_time).do(self.on) 
        schedule.every().day.at(self.stop_time).do(self.off) 

    def on(self): 
        """turn on lights""" 
        self.lights.on() 

    def off(self): 
        """turn off lights""" 
        self.lights.off()

Copy

Explain
In the init_schedule() method, the start and stop times that were passed as arguments are used to initialize schedule to turn on/off the lights at the specified times.

Put it together, we have:

import schedule 
import time 
from gpiozero import OutputDevice 

class LightScheduler(object): 
    """A Python class to turn on/off lights""" 

    def __init__(self, start_time, stop_time): 
        self.start_time = start_time 
        self.stop_time = stop_time 
        # lamp is connected to GPIO pin2.
        self.lights = OutputDevice(2) 

    def init_schedule(self): 
        # set the schedule 
        schedule.every().day.at(self.start_time).do(self.on) 
        schedule.every().day.at(self.stop_time).do(self.off) 

    def on(self): 
        """turn on lights""" 
        self.lights.on() 

    def off(self): 
        """turn off lights""" 
        self.lights.off() 


if __name__ == "__main__": 
    lamp = LightScheduler("18:30", "9:30") 
    lamp.on() 
    time.sleep(50) 
    lamp.off() 
    lamp.init_schedule() 
    while True:
        schedule.run_pending() 
        time.sleep(1)

Copy

Explain
In the preceding example, the lights are scheduled to be turned on at 6:30 p.m. and turned off at 9:30 a.m. Once the jobs are scheduled, the program enters an infinite loop where it awaits task execution. This example could be run as a daemon by executing the file at start-up (add a line called light_scheduler.py to /etc/rc.local). After scheduling the job, it will continue to run as a daemon in the background.

Note
This is just a basic introduction to OOP and its applications (keeping the beginner in mind). Refer to this book's website for more examples on OOP.

Summary
In this chapter, we discussed lists and the advantages of OOP. We discussed OOP examples using the Raspberry Pi as the center of the examples. Since the book is targeted mostly towards beginners, we decided to stick to the basics of OOP while discussing examples. There are advanced aspects that are beyond the scope of the book. We leave it up to the reader to learn advanced concepts using other examples available on this book's site.



| ≪ [ 04 Communication Interfaces ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/04_Communication_Interfaces) | 05 Data Types and Object-Oriented Programming in Python | [ 06 File I/O and Python Utilities ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/06_File_I-O_and_Python_Utilities) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 05 Data Types and Object-Oriented Programming in Python
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/05_Data_Types_and_Object-Oriented_Programming_in_Python
> Book Title: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> tags: Python RaspPi
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 11:35:57
> .md Name: 05_data_types_and_object-oriented_programming_in_python.md

