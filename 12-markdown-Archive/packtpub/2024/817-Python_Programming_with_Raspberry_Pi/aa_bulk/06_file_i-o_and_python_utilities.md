
| ≪ [ 05 Data Types and Object-Oriented Programming in Python ](/packtpub/2024/817-Python_with_RaspPi_1ed/05_Data_Types_and_Object-Oriented_Programming_in_Python) | 06 File I/O and Python Utilities | [ 07 Requests and Web Frameworks ](/packtpub/2024/817-Python_with_RaspPi_1ed/07_Requests_and_Web_Frameworks) ≫ |
|:----:|:----:|:----:|

# 06 File I/O and Python Utilities
Chapter 6. File I/O and Python Utilities
In this chapter, we are going to discuss file I/O, that is reading, writing and appending to file in detail. We are also going to discuss Python utilities that enable manipulating files and interacting with the operating system. Each topic has a different level of complexity that we will discuss using an example. Let's get started!

File I/O
We are discussing file I/O for two reasons:

In the world of Linux operating systems, everything is a file. Interaction with peripherals on the Raspberry Pi is similar to reading from/writing to a file. For example: In Chapter 4, Communication Interfaces, we discussed serial port communication. You should be able to observe that serial port communication is like a file read/write operation.
We use file I/O in some form in every project. For example: Writing sensor data to a CSV file or reading pre-configured options for a web server, and so on.
Hence, we thought it would be useful to discuss file I/O in Python as its own chapter (detailed documentation available from here: https://docs.python.org/3/tutorial/inputoutput.html#reading-and-writing-files) and discuss examples where it could play a role while developing applications on the Raspberry Pi Zero.

Reading from a file
Let's create a simple text file, read_file.txt with the following text: I am learning Python Programming using the Raspberry Pi Zero and save it to the code samples directory (or any location of your choice).

To read from a file, we need to make use of the Python's in-built function: open to open the file. Let's take a quick look at a code snippet that demonstrates opening a text file to read its content and print it to the screen:

if __name__ == "__main__":
    # open text file to read
    file = open('read_line.txt', 'r')
    # read from file and store it to data
    data = file.read()
    print(data)
    file.close()

Copy

Explain
Let's discuss this code snippet in detail:

The first step in reading the contents of the text file is opening the file using the in-built function open. The file in question needs to be passed as an argument along with a flag r that indicates we are opening the file to read the contents (We will discuss other flag options as we discuss each reading/writing files.)
Upon opening the file, the open function returns a pointer (address to the file object) that is stored in the file variable.
       file = open('read_line.txt', 'r')

Copy

Explain
This file pointer is used to read the contents of the file and print it to the screen:
       data = file.read()
       print(data)

Copy

Explain
After reading the contents of the file, the file is closed by calling the close() function.
Run the preceding code snippet (available for download along with this chapter—read_from_file.py) using IDLE3 or the command-line terminal. The contents of the text file would be printed to the screen as follows:

I am learning Python Programming using the Raspberry Pi Zero

Copy

Explain


Reading lines
Sometimes, it is necessary to read the contents of a file by line-by-file. In Python, there are two options to do this: readline() and readlines():

readline(): As the name suggests, this in-built function enables reading one line at a time. Let's review this using an example:
       if __name__ == "__main__":
          # open text file to read
          file = open('read_line.txt', 'r')

          # read a line from the file
          data = file.readline()
          print(data)

          # read another line from the file
          data = file.readline()
          print(data)

          file.close()

Copy

Explain
When the preceding code snippet is executed (available for download as read_line_from_file.py along with this chapter), the read_line.txt file is opened and a single line is returned by the readline() function. This line is stored in the variable data. Since the function is called twice in this program, the output is as follows:

       I am learning Python Programming using the Raspberry Pi Zero.

       This is the second line.

Copy

Explain
A new line is returned every time the readline function is called and it returns an empty string when the end-of-file has reached.

readlines(): This function reads the entire content of a file in lines and stores each it to a list:
       if __name__ == "__main__":
           # open text file to read
           file = open('read_lines.txt', 'r')

           # read a line from the file
           data = file.readlines()
           for line in data:
               print(line)

           file.close()

Copy

Explain
Since the lines of the files is stored as a list, it could be retrieved by iterating through the list:

       data = file.readlines()
           for line in data:
               print(line)

Copy

Explain
The preceding code snippet is available for download along with this chapter as read_lines_from_file.py.

Writing to a file
Perform the following steps in order to write to a file:

The first step in writing to a file is opening a file with the write flag: w. If the file name that was passed as an argument doesn't exist, a new file is created:
      file = open('write_file.txt', 'w')

Copy

Explain
Once the file is open, the next step is passing the string to be written as argument to the write() function:
      file.write('I am excited to learn Python using
      Raspberry Pi Zero')

Copy

Explain
Let's put the code together where we write a string to a text file, close it, re-open the file and print the contents of the file to the screen:
       if __name__ == "__main__":
          # open text file to write
          file = open('write_file.txt', 'w')
          # write a line from the file
          file.write('I am excited to learn Python using
          Raspberry Pi Zero \n')
          file.close()

          file = open('write_file.txt', 'r')
          data = file.read()
          print(data)
          file.close()

Copy

Explain
The preceding code snippet is available for download along with this chapter (write_to_file.py).
When the preceding code snippet is executed, the output is shown as follows:
I am excited to learn Python using Raspberry Pi Zero

Copy

Explain
Appending to a file
Whenever a file is opened using the write flag w, the contents of the file are deleted and opened afresh to write data. There is an alternative flag a that enables appending data to the end of the file. This flag also creates a new file if the file (that is passed as an argument to open) doesn't exist. Let's consider the code snippet below where we append a line to the text file write_file.txt from the previous section:

if __name__ == "__main__":
   # open text file to append
   file = open('write_file.txt', 'a')
   # append a line from the file
   file.write('This is a line appended to the file\n')
   file.close()

   file = open('write_file.txt', 'r')
   data = file.read()
   print(data)
   file.close()

Copy

Explain
When the preceding code snippet is executed (available for download along with this chapter—append_to_file.py), the string This is a line appended to the file is appended to the end of the text of the file. The contents of the file will include the following:

I am excited to learn Python using Raspberry Pi Zero
    This is a line appended to the file

Copy

Explain
seek
Once a file is opened, the file pointer that is used in file I/O moves from the beginning to the end of the file. It is possible to move the pointer to a specific position and read the data from that position. This is especially useful when we are interested in a specific line of a file. Let's consider the text file write_file.txt from the previous example. The contents of the file include:

I am excited to learn Python using Raspberry Pi Zero
    This is a line appended to the file

Copy

Explain
Let's try to skip the first line and read only the second line using seek:

if __name__ == "__main__":
   # open text file to read

   file = open('write_file.txt', 'r')

   # read the second line from the file
   file.seek(53)

   data = file.read()
   print(data)
   file.close()

Copy

Explain
In the preceding example (available for download along with this chapter as seek_in_file.py), the seek function is used to move the pointer to byte 53 that is the end of first line. Then the file's contents are read and stored into the variable. When this code snippet is executed, the output is as follows:

This is a line appended to the file

Copy

Explain
Thus, seek enables moving the file pointer to a specific position.

Read n bytes
The seek function enables moving the pointer to a specific position and reading a byte or n bytes from that position. Let's re-visit reading write_file.txt and try to read the word excited in the sentence I am excited to learn Python using Raspberry Pi Zero.

if __name__ == "__main__":
   # open text file to read and write
   file = open('write_file.txt', 'r')

   # set the pointer to the desired position
   file.seek(5)
   data = file.read(1)
   print(data)

   # rewind the pointer
   file.seek(5)
   data = file.read(7)
   print(data)
   file.close()

Copy

Explain
The preceding code can be explained in the following steps:

In the first step, the file is opened using the read flag and the file pointer is set to the fifth byte (using seek)—the position of the letter e in the contents of the text file.
Now, we read one byte from the file by passing it as an argument to the read function. When an integer is passed as an argument, the read function returns the corresponding number of bytes from the file. When no argument is passed, it reads the entire file. The read function returns an empty string if the file is empty:
       file.seek(5)
       data = file.read(1)
       print(data)

Copy

Explain
In the second part, we try to read the word excited from the text file. We rewind the position of the pointer back to the fifth byte. Then we read seven bytes from the file (length of the word excited).
When the code snippet is executed (available for download along with this chapter as seek_to_read.py), the program should print the letter e and the word excited:
       file.seek(5)
       data = file.read(7)
       print(data)

Copy

Explain
r+
We discussed reading and writing to files using the r and w flags. There is another called r+. This flag enables reading and writing to a file. Let's review an example that enables us to understand this flag.

Let's review the contents of write_file.txt once again:

I am excited to learn Python using Raspberry Pi Zero
    This is a line appended to the file

Copy

Explain
Let's modify the second line to read: This is a line that was modified. The code sample is available for download along with this chapter as seek_to_write.py.

if __name__ == "__main__":
   # open text file to read and write
   file = open('write_file.txt', 'r+')

   # set the pointer to the desired position
   file.seek(68)
   file.write('that was modified \n')

   # rewind the pointer to the beginning of the file
   file.seek(0)
   data = file.read()
   print(data)
   file.close()

Copy

Explain
Let's review how this example works:

The first step in this example is opening the file using the r+ flag. This enables reading and writing to the file.
The next step is moving to the 68th byte of the file
The that was modified string is written to the file at this position. The spaces at the end of the string are used to overwrite the original content of the second sentence.
Now, the file pointer is set to the beginning of the file and its contents are read.
When the preceding code snippet is executed, the modified file contents are printed to the screen as follows:
I am excited to learn Python using Raspberry Pi Zero
       This is a line that was modified

Copy

Explain
There is another a+ flag that enables appending data to the end of the file and reading at the same time. We will leave this to the reader to figure out using the examples discussed so far.

Note
We have discussed different examples on reading and writing to files in Python. It can be overwhelming without sufficient experience in programming. We strongly recommend working through the different code samples provided in this chapter

Challenge to the reader
Use the a+ flag to open the write_file.txt file (discussed in different examples) and append a line to the file. Set the file pointer using seek and print its contents. You may open the file only once in the program.

The with keyword
So far, we discussed different flags that could be used to open files in different modes. The examples we discussed followed a common pattern—open the file, perform read/write operations and close the file. There is an elegant way of interacting with files using the with keyword. If there are any errors during the execution of the code block that interacts with a file, the with keyword ensures that the file is closed and the associated resources are cleaned up on exiting the code block. As always, let's review the with keyword with an example:

if __name__ == "__main__":
   with open('write_file.txt', 'r+') as file:
         # read the contents of the file and print to the screen
         print(file.read())
         file.write("This is a line appended to the file")

         #rewind the file and read its contents
         file.seek(0)
         print(file.read())
   # the file is automatically closed at this point
   print("Exited the with keyword code block")

Copy

Explain
In the preceding example (with_keyword_example), we skipped closing the file as the with keyword takes care of closing the file once the execution of the indented code block is complete. The with keyword also takes care of closing the file while leaving the code block due to an error. This ensures that the resources are cleaned up properly in any scenario. Going forward, we will be using the with keyword for file I/O.

configparser
Let's discuss some aspects of Python programming that is especially helpful while developing applications using the Raspberry Pi. One such tool is the configparser available in Python. The configparser module (https://docs.python.org/3.4/library/configparser.html) is used to read/write config files for applications.

In software development, config files are generally used to store constants such as access credentials, device ID, and so on In the context of a Raspberry Pi, configparser could be used to store the list of all GPIO pins in use, addresses of sensors interfaced via the I2C interface, and so on. Let's discuss three examples where we learn making use of the configparser module. In the first example we will create a config file using the configparser. In the second example, we will make use of the configparser to read the config values and in the third example, we will discuss modifying config files in the final example.

Example 1:

In the first example, let's create a config file that stores information including device ID, GPIO pins in use, sensor interface address, debug switch, and access credentials:

import configparser

if __name__ == "__main__":
   # initialize ConfigParser
   config_parser = configparser.ConfigParser()

   # Let's create a config file
   with open('raspi.cfg', 'w') as config_file:
         #Let's add a section called ApplicationInfo
         config_parser.add_section('AppInfo')

         #let's add config information under this section
         config_parser.set('AppInfo', 'id', '123')
         config_parser.set('AppInfo', 'gpio', '2')
         config_parser.set('AppInfo', 'debug_switch', 'True')
         config_parser.set('AppInfo', 'sensor_address', '0x62')

         #Let's add another section for credentials
         config_parser.add_section('Credentials')
         config_parser.set('Credentials', 'token', 'abcxyz123')
         config_parser.write(config_file)
   print("Config File Creation Complete")

Copy

Explain
Let's discuss the preceding code example (available for download along with this chapter as config_parser_write.py) in detail:

The first step is importing the configparser module and creating an instance of the ConfigParser class. This instance is going to be called config_parser:
       config_parser = configparser.ConfigParser()

Copy

Explain
Now, we open a config file called raspi.cfg using the with keyword. Since the file doesn't exist, a new config file is created.
The config file is going to consist of two sections namely AppInfo and Credentials.


The two sections could be created using the add_section method as follows:
       config_parser.add_section('AppInfo')
       config_parser.add_section('Credentials')

Copy

Explain
Each section is going to consist of different set of constants. Each constant could be added to the relevant section using the set method. The required arguments to the set method include the section name (under which the parameter/constant is going to be located), the name of the parameter/constant and its corresponding value. For example: The id parameter can be added to the AppInfo section and assigned a value of 123 as follows:
       config_parser.set('AppInfo', 'id', '123')

Copy

Explain
The final step is saving these config values to the file. This is accomplished using the config_parser method, write. The file is closed once the program exits the indented block under the with keyword:
       config_parser.write(config_file)

Copy

Explain
Note
We strongly recommend trying the code snippets yourself and use these snippets as a reference. You will learn a lot by making mistakes and possibly arrive with a better solution than the one discussed here.

When the preceding code snippet is executed, a config file called raspi.cfg is created. The contents of the config file would include the contents shown as follows:

[AppInfo]
id = 123
gpio = 2
debug_switch = True
sensor_address = 0x62

[Credentials]
token = abcxyz123

Copy

Explain
Example 2:

Let's discuss an example where we read config parameters from a config file created in the previous example:

import configparser

if __name__ == "__main__":
   # initialize ConfigParser
   config_parser = configparser.ConfigParser()

   # Let's read the config file
   config_parser.read('raspi.cfg')

   # Read config variables
   device_id = config_parser.get('AppInfo', 'id')
   debug_switch = config_parser.get('AppInfo', 'debug_switch')
   sensor_address = config_parser.get('AppInfo', 'sensor_address')

   # execute the code if the debug switch is true
   if debug_switch == "True":
         print("The device id is " + device_id)
         print("The sensor_address is " + sensor_address)

Copy

Explain
Note
If the config files are created in the format shown, the ConfigParser class should be able to parse it. It is not really necessary to create config files using a Python program. We just wanted to show programmatic creation of config files as it is easier to programmatically create config files for multiple devices at the same time.

The preceding example is available for download along with this chapter (config_parser_read.py). Let's discuss how this code sample works:

The first step is initializing an instance of the ConfigParser class called config_parser.
The second step is loading and reading the config file using the instance method read.
Since we know the structure of the config file, let's go ahead and read some constants available under the section AppInfo. The config file parameters can be read using the get method. The required arguments include the section under which the config parameter is located and the name of the parameter. For example: The config id parameter is located under the AppInfo section. Hence, the required arguments to the method include AppInfo and id:
      device_id = config_parser.get('AppInfo', 'id')

Copy

Explain


Now that the config parameters are read into variables, let's make use of it in our program. For example: Let's test if the debug_switch variable (a switch to determine if the program is in debug mode) and print the other config parameters that were retrieved from the file:
       if debug_switch == "True":
           print("The device id is " + device_id)
           print("The sensor_address is " + sensor_address)

Copy

Explain
Example 3:

Let's discuss an example where we would like to modify an existing config file. This is especially useful in situations where we need to update the firmware version number in the config file after performing a firmware update.

The following code snippet is available for download as config_parser_modify.py along with this chapter:

import configparser

if __name__ == "__main__":
   # initialize ConfigParser
   config_parser = configparser.ConfigParser()

   # Let's read the config file
   config_parser.read('raspi.cfg')

   # Set firmware version
   config_parser.set('AppInfo', 'fw_version', 'A3')

   # write the updated config to the config file
   with open('raspi.cfg', 'w') as config_file:
       config_parser.write(config_file)

Copy

Explain
Let's discuss how this works:

As always, the first step is initializing an instance of the ConfigParser class. The config file is loaded using the method read:
       # initialize ConfigParser
       config_parser = configparser.ConfigParser()

       # Let's read the config file
       config_parser.read('raspi.cfg')

Copy

Explain
The required parameter is updated using the set method (discussed in a previous example):
       # Set firmware version
       config_parser.set('AppInfo', 'fw_version', 'A3')

Copy

Explain
The updated config is saved to the config file using the write method:
       with open('raspi.cfg', 'w') as config_file:
          config_parser.write(config_file)

Copy

Explain
Challenge to the reader
Using example 3 as a reference, update the config parameter debug_switch to the value False. Repeat example 2 and see what happens.

Reading/writing to CSV files
In this section, we are going to discuss reading/writing to CSV files. This module (https://docs.python.org/3.4/library/csv.html) is useful in data logging applications. Since we will be discussing data logging in the next chapter, let's review reading/writing to CSV files.

Writing to CSV files
Let's consider a scenario where we are reading data from different sensors. This data needs to be recorded to a CSV file where each column corresponds to a reading from a specific sensor. We are going to discuss an example where we record the value 123, 456, and 789 in the first row of the CSV file and the second row is going to consist of values including Red, Green, and Blue:

The first step in writing to a CSV file is opening a CSV file using the with keyword:
       with open("csv_example.csv", 'w') as csv_file:

Copy

Explain
The next step is initializing an instance of the writer class of the CSV module:
       csv_writer = csv.writer(csv_file)

Copy

Explain


Now, each row is added to the file by creating a list that contains all the elements that need to be added to a row. For example: The first row can be added to the list as follows:
       csv_writer.writerow([123, 456, 789])

Copy

Explain
Putting it altogether, we have:
       import csv
       if __name__ == "__main__":
          # initialize csv writer
          with open("csv_example.csv", 'w') as csv_file:
                csv_writer = csv.writer(csv_file)
                csv_writer.writerow([123, 456, 789])
                csv_writer.writerow(["Red", "Green", "Blue"])

Copy

Explain
When the above code snippet is executed (available for download as csv_write.py along with this chapter), a CSV file is created in the local directory with the following contents:
       123,456,789
       Red,Green,Blue

Copy

Explain
Reading from CSV files
Let's discuss an example where we read the contents of the CSV file created in the previous section:

The first step in reading a CSV file is opening it in read mode:
       with open("csv_example.csv", 'r') as csv_file:

Copy

Explain
Next, we initialize an instance of the reader class from the CSV module. The contents of the CSV file are loaded into the object csv_reader:
       csv_reader = csv.reader(csv_file)

Copy

Explain
Now that the contents of the CSV file are loaded, each row of the CSV file could be retrieved as follows:
       for row in csv_reader:
           print(row)

Copy

Explain


Put it all together:
       import csv

       if __name__ == "__main__":
          # initialize csv writer
          with open("csv_example.csv", 'r') as csv_file:
                csv_reader = csv.reader(csv_file)

                for row in csv_reader:
                      print(row)

Copy

Explain
When the preceding code snippet is executed (available for download along with this chapter as csv_read.py), the contents of the file are printed row-by-row where each row is a list that contains the comma separated values:
['123', '456', '789']
       ['Red', 'Green', 'Blue']

Copy

Explain
Python utilities
Python comes with several utilities that enables interacting with other files and the operating system itself. We have identified all those Python utilities that we have used in our past projects. Let's discuss the different modules and their uses as we might use them in the final project of this book.

The os module
As the name suggests, this module (https://docs.python.org/3.1/library/os.html) enables interacting with the operating system. Let's discuss some of its applications with examples.

Checking a file's existence
The os module could be used to check if a file exists in a specific directory. For example: We extensively made use of the write_file.txt file. Before opening this file to read or write, we could check the file's existence:

import os
if __name__ == "__main__":
    # Check if file exists
    if os.path.isfile('/home/pi/Desktop/code_samples/write_file.txt'):
        print('The file exists!')
    else:
        print('The file does not exist!')

Copy

Explain
In the preceding code snippet, we make use of the isfile() function, available with the os.path module. When a file's location is passed an argument to the function, it returns True if the file exists at that location. In this example, since the file write_file.txt exists in the code examples directory, the function returns True. Hence the message, The file exists is printed to the screen:

if os.path.isfile('/home/pi/Desktop/code_samples/write_file.txt'):
    print('The file exists!')
else:
    print('The file does not exist!')

Copy

Explain
Checking for a folder's existence
Similar to os.path.isfile(), there is another function called os.path.isdir(). It returns True if a folder exists at a specific location. We have been reviewing all code samples from a folder called code_samples located on the Raspberry Pi's desktop. It's existence could be confirmed as follows:

# Confirm code_samples' existence
if os.path.isdir('/home/pi/Desktop/code_samples'):
    print('The directory exists!')
else:
    print('The directory does not exist!')

Copy

Explain
Deleting files
The os module also enables deleting files using the remove() function. Any file that is passed as an argument to the function is deleted. In the File I/O section, we discussed reading from files using the text file, read_file.txt. Let's delete the file by passing it as an argument to the remove() function:

os.remove('/home/pi/Desktop/code_samples/read_file.txt')

Copy

Explain


Killing a process
It is possible to kill an application running on the Raspberry Pi by passing process pid to the kill() function. In the previous chapter, we discussed the light_scheduler example that runs as a background process on the Raspberry Pi. To demonstrate killing a process, we are going to attempt killing that process. We need to determine the process pid of the light_scheduler process (you may pick an application that was started by you as a user and not do not touch root processes). The process pid could be retrieved from the command-line terminal using the following command:

    ps aux

Copy

Explain
It spits out the processes currently running on the Raspberry Pi (shown in the following figure). The process pid for the light_scheduler application is 1815:


light_scheduler daemon's PID

Assuming we know the process pid of the application that needs to be killed, let's review killing the function using kill(). The arguments required to kill the function include the process pid and signal (signal.SIGKILL) that needs to be sent to the process to kill the application:

import os
import signal
if __name__ == "__main__":
    #kill the application
    try:
        os.kill(1815, signal.SIGKILL)
    except OSError as error:
        print("OS Error " + str(error))

Copy

Explain
The signal module (https://docs.python.org/3/library/signal.html) contains the constants that represents the signals that could be used to stop an application. In this code snippet, we make use of the SIGKILL signal. Try running the ps command (ps aux) and you will notice that the light_scheduler application has been killed.

Monitoring a process
In the previous example, we discussed killing an application using the kill() function. You might have noticed that we made use of something called the try/except keywords to attempt killing the application. We will discuss these keywords in detail in the next chapter.

It is also possible to monitor whether an application is running using the kill() function using the try/except keywords. We will discuss monitoring processes using the kill() function after introducing the concept of trapping exceptions using try/except keywords.

All examples discussed in the os module are available for download along with this chapter as os_utils.py.

The glob module
The glob module (https://docs.python.org/3/library/glob.html) enables identifying files of a specific extension or files that have a specific pattern. For example, it is possible to list all Python files in a folder as follows:

# List all files
for file in glob.glob('*.py'):
    print(file)

Copy

Explain
The glob() function returns a list of files that contains the .py extension. A for loop is used to iterate through the list and print each file. When the preceding code snippet is executed, the output contains the list of all code samples belonging to this chapter (output truncated for representation):

read_from_file.py
config_parser_read.py
append_to_file.py
read_line_from_file.py
config_parser_modify.py
python_utils.py
config_parser_write.py
csv_write.py

Copy

Explain
This module is especially helpful with listing files that have a specific pattern. For example: Let's consider a scenario where you would like to upload files that were created from different trials of an experiment. You are only interested in files that are of the following format: file1xx.txt where x stands for any digit between 0 and 9. Those files could be sorted and listed as follows:

# List all files of the format 1xx.txt
for file in glob.glob('txt_files/file1[0-9][0-9].txt'):
    print(file)

Copy

Explain
In the preceding example, [0-9] means that the file name could contain any digit between 0 and 9. Since we are looking for files of the file1xx.txt format, the search pattern that is passed an argument to the glob() function is file1[0-9][0-9].txt.

When the preceding code snippet is executed, the output contains all text files of the specified format:

txt_files/file126.txt
txt_files/file125.txt
txt_files/file124.txt
txt_files/file123.txt
txt_files/file127.txt

Copy

Explain
We came across this article that explains the use of expressions for sorting files: http://www.linuxjournal.com/content/bash-extended-globbing. The same concept can be extended to searching for files using the glob module.

Challenge to the reader
The examples discussed with the glob module are available for download along with this chapter as glob_example.py. In one of the examples, we discussed listing files of a specific format. How would you go about listing files that are of the following format: filexxxx.*? (Here x represents any number between 0 and 9. * represents any file extension.)

The shutil module
The shutil module (https://docs.python.org/3/library/shutil.html) enables moving and copying files between folders using the move() and copy() methods. In the previous section, we listed all text files within the folder, txt_files. Let's move these files to the current directory (where the code is being executed) using move(), make a copy of these files once again in txt_files and finally remove the text files from the current directory:

import glob
import shutil
import os
if __name__ == "__main__":
    # move files to the current directory
    for file in glob.glob('txt_files/file1[0-9][0-9].txt'):
        shutil.move(file, '.')
    # make a copy of files in the folder 'txt_files' and delete them
    for file in glob.glob('file1[0-9][0-9].txt'):
        shutil.copy(file, 'txt_files')
        os.remove(file)

Copy

Explain
In the preceding example (available for download along with this chapter as shutil_example.py), the files are being moved as well as copied from the origin to the destination by specifying the source and the destination as the first and second arguments respectively.

The files to be moved (or copied) are identified using the glob module. Then, each file is moved or copied using their corresponding methods.

The subprocess module
We briefly discussed this module in the previous chapter. The subprocess module (https://docs.python.org/3.2/library/subprocess.html) enables launching another program from within a Python program. One of the commonly used functions from the subprocess module is Popen.Any process that needs to be launched from within the program needs to be passed as a list argument to the Popen function:

import subprocess
if __name__ == "__main__":
    subprocess.Popen(['aplay', 'tone.wav'])

Copy

Explain
In the preceding example, tone.wav (WAVE file that needs to be played) and the command that needs to be run are passed as a list argument to the function. There are several other commands from the subprocess module that serve a similar purpose. We leave it to your exploration.

The sys module
The sys module (https://docs.python.org/3/library/sys.html) allows interacting with the Python run-time interpreter. One of the functions of the sys module is parsing command-line arguments provided as inputs to the program. Let's write a program that reads and prints the contents of the file that is passed as an argument to the program:

import sys
if __name__ == "__main__":
    with open(sys.argv[1], 'r') as read_file:
        print(read_file.read())

Copy

Explain
Try running the preceding example as follows:

python3 sys_example.py read_lines.txt

Copy

Explain
The preceding example is available for download along with this chapter as sys_example.py. The list of command-line arguments passed while running the program are available as a argv list in the sys module. argv[0] is usually the name of the Python program and argv[1] is usually the first argument passed to the function.

When sys_example.py is executed with read_lines.txt as an argument, the program should print the contents of the text file:

I am learning Python Programming using the Raspberry Pi Zero.
This is the second line.
Line 3.
Line 4.
Line 5.
Line 6.
Line 7.

Copy

Explain


Summary
In this chapter, we discussed file I/O – reading and writing to files, different flags used to read, write, and append to files. We talked about moving file pointers to different points in a file to retrieve specific content or overwrite the contents of a file at a specific location. We discussed the ConfigParser module in Python and its application in storing/retrieving config parameters for applications along with reading and writing to CSV files.

Finally, we discussed different Python utilities that have a potential use in our project. We will be extensively making use of file I/O and the discussed Python utilities in our final project. We strongly recommend familiarizing yourself with the concepts discussed in this chapter before moving onto the final projects discussed in this book.

In the upcoming chapters, we will discuss uploading sensor data stored in CSV files to the cloud and logging errors encountered during the execution of an application. See you in the next chapter!




| ≪ [ 05 Data Types and Object-Oriented Programming in Python ](/packtpub/2024/817-Python_with_RaspPi_1ed/05_Data_Types_and_Object-Oriented_Programming_in_Python) | 06 File I/O and Python Utilities | [ 07 Requests and Web Frameworks ](/packtpub/2024/817-Python_with_RaspPi_1ed/07_Requests_and_Web_Frameworks) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 06 File I/O and Python Utilities
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: /packtpub/2024/817-Python_with_RaspPi_1ed/06_File_I-O_and_Python_Utilities
> Book Jemok: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 16:35:09
> .md Name: 06_file_i-o_and_python_utilities.md

