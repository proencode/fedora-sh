
| ≪ [ 06 File I/O and Python Utilities ](/packtpub/2024/817-Python_with_RaspPi_1ed/06_File_I-O_and_Python_Utilities) | 07 Requests and Web Frameworks | [ 08 Awesome Things You Could Develop Using Python ](/packtpub/2024/817-Python_with_RaspPi_1ed/08_Awesome_Things_You_Could_Develop_Using_Python) ≫ |
|:----:|:----:|:----:|

# 07 Requests and Web Frameworks
Chapter 7. Requests and Web Frameworks
The main topics of this chapter are requests and web frameworks in Python. We are going to discuss libraries and frameworks that enable retrieving data from the Web (for example, get weather updates), upload data to a remote server (for example, log sensor data), or control appliances on a local network. We will also discuss topics that will help with learning the core topics of this chapter.

The try/except keywords
So far, we have reviewed and tested all our examples assuming the ideal condition, that is, the execution of the program will encounter no errors. On the contrary, applications fail from time to time either due to external factors, such as invalid user input and poor Internet connectivity, or program logic errors caused by the programmer. In such cases, we want the program to report/log the nature of error and either continue its execution or clean up resources before exiting the program. The try/except keywords offer a mechanism to trap an error that occurs during a program's execution and take remedial action. Because it is possible to trap and log an error in crucial parts of the code, the try/except keywords are especially useful while debugging an application.

Let's understand the try/except keywords by comparing two examples. Let's build a simple guessing game where the user is asked to guess a number between 0 and 9:

A random number (between 0 and 9) is generated using Python's random module. If the user's guess of the generated number is right, the Python program declares the user as the winner and exits the game.
If the user input is the letter x, the program quits the game.
The user input is converted into an integer using the int() function. A sanity check is performed to determine whether the user input is a number between 0 and 9.
The integer is compared against a random number. If they are the same, the user is declared the winner and the program exits the game.
Let's observe what happens when we deliberately provide an erroneous input to this program (the code snippet shown here is available for download along with this chapter as guessing_game.py):

import random

if __name__ == "__main__":
    while True:
        # generate a random number between 0 and 9
        rand_num = random.randrange(0,10)

        # prompt the user for a number
        value = input("Enter a number between 0 and 9: ")

        if value == 'x':
            print("Thanks for playing! Bye!")
            break

        input_value = int(value)

        if input_value < 0 or input_value > 9:
            print("Input invalid. Enter a number between 0 and 9.")


        if input_value == rand_num:
            print("Your guess is correct! You win!")
            break
        else:
            print("Nope! The random value was %s" % rand_num)

Copy

Explain
Let's execute the preceding code snippet and provide the input hello to the program:

Enter a number between 0 and 9: hello
    Traceback (most recent call last):
        File "guessing_game.py", line 12, in <module>
            input_value = int(value)
    ValueError: invalid literal for int() with base 10: 'hello'

Copy

Explain
In the preceding example, the program fails when it is trying to convert the user input hello to an integer. The program execution ends with an exception. An exception highlights the line where the error has occurred. In this case, it has occurred in line 10:

File "guessing_game.py", line 12, in <module>
    input_value = int(value)

Copy

Explain
The nature of the error is also highlighted in the exception. In this example, the last line indicates that the exception thrown is ValueError:

ValueError: invalid literal for int() with base 10: 'hello'

Copy

Explain
Let's discuss the same example (available for download along with this chapter as try_and_except.py) that makes use of the try/except keywords. It is possible to continue playing the game after trapping this exception and printing it to the screen. We have the following code:

import random

if __name__ == "__main__":
    while True:
        # generate a random number between 0 and 9
        rand_num = random.randrange(0,10)

        # prompt the user for a number
        value = input("Enter a number between 0 and 9: ")

        if value == 'x':
            print("Thanks for playing! Bye!")

        try:
            input_value = int(value)
        except ValueError as error:
            print("The value is invalid %s" % error)
            continue

        if input_value < 0 or input_value > 9:
            print("Input invalid. Enter a number between 0 and 9.")
            continue

        if input_value == rand_num:
            print("Your guess is correct! You win!")
            break
        else:
            print("Nope! The random value was %s" % rand_num)

Copy

Explain
Let's discuss how the same example works with the try/except keywords:

From the previous example, we know that when a user provides the wrong input (for example, a letter instead of a number between 0 and 9), the exception occurs at line 10 (where the user input is converted into an integer), and the nature of the error is named ValueError.
It is possible to avoid interruption of the program's execution by wrapping this in a try...except block:
      try:
         input_value = int(value)
      except ValueError as error:
         print("The value is invalid %s" % error)

Copy

Explain
On receiving a user input, the program attempts converting the user input into an integer under the try block.
If ValueError has occurred, error is trapped by the except block, and the following message is printed to the screen along with the actual error message:
       except ValueError as error:
           print("The value is invalid %s" % error)

Copy

Explain
Try executing the code example and try providing an invalid input. You will note that the program prints the error message (along with the nature of the error) and goes back to the top of the game loop and continues seeking valid user input:
Enter a number between 0 and 9: 3
       Nope! The random value was 5
       Enter a number between 0 and 9: hello
       The value is invalid invalid literal for int() with
       base 10: 'hello'
       Enter a number between 0 and 10: 4
       Nope! The random value was 6

Copy

Explain
The try...except block comes with a substantial processing power cost. Hence, it is important to keep the try...except block as short as possible. Because we know that the error occurs on the line where we attempt converting the user input into an integer, we wrap it in a try...except block to trap an error.

Thus, the try/except keywords are used to prevent any abnormal behavior in a program's execution due to an error. It enables logging the error and taking remedial action. Similar to the try...except block, there are also try...except...else and try...except...else code blocks. Let's quickly review those options with a couple of examples.

try...except...else
The try...except...else block is especially useful when we want a certain block of code to be executed only when no exceptions are raised. In order to demonstrate this concept, let's rewrite the guessing game example using this block:

try:
    input_value = int(value)
except ValueError as error:
    print("The value is invalid %s" % error)
else:
    if input_value < 0 or input_value > 9:
        print("Input invalid. Enter a number between 0 and 9.")
    elif input_value == rand_num:
        print("Your guess is correct! You win!")
        break
    else:
        print("Nope! The random value was %s" % rand_num)

Copy

Explain
The modified guessing game example that makes use of the try...except...else block is available for download along with this chapter as try_except_else.py. In this example, the program compares the user input against the random number only if a valid user input was received. It otherwise skips the else block and goes back to the top of the loop to accept the next user input. Thus, try...except...else is used when we want a specific code block to be executed when no exceptions are raised due to the code in the try block.

try...except...else...finally
As the name suggests, the finally block is used to execute a block of code on leaving the try block. This block of code is executed even after an exception is raised. This is useful in scenarios where we need to clean up resources and free up memory before moving on to the next stage.

Let's demonstrate the function of the finally block using our guessing game. To understand how the finally keyword works, let's make use of a counter variable named count that is incremented in the finally block, and another counter variable named valid_count that is incremented in the else block. We have the following code:

count = 0
valid_count = 0
while True:
  # generate a random number between 0 and 9
  rand_num = random.randrange(0,10)

  # prompt the user for a number
  value = input("Enter a number between 0 and 9: ")

  if value == 'x':
      print("Thanks for playing! Bye!")

  try:
      input_value = int(value)
  except ValueError as error:
      print("The value is invalid %s" % error)
  else:
      if input_value < 0 or input_value > 9:
          print("Input invalid. Enter a number between 0 and 9.")
          continue

      valid_count += 1
      if input_value == rand_num:
          print("Your guess is correct! You win!")
          break
      else:
          print("Nope! The random value was %s" % rand_num)
  finally:
      count += 1

print("You won the game in %d attempts "\
      "and %d inputs were valid" % (count, valid_count))

Copy

Explain
The preceding code snippet is from the try_except_else_finally.py code sample (available for download along with this chapter). Try executing the code sample and playing the game. You will note the total number of attempts it took to win the game and the number of inputs that were valid:

Enter a number between 0 and 9: g
    The value is invalid invalid literal for int() with
    base 10: 'g'
    Enter a number between 0 and 9: 3
    Your guess is correct! You win!
    You won the game in 9 attempts and 8 inputs were valid

Copy

Explain
This demonstrates how the try-except-else-finally block works. Any code under the else keyword is executed when the critical code block (under the try keyword) is executed successfully, whereas the code block under the finally keyword is executed while exiting the try...except block (useful for cleaning up resources while exiting a code block).

Try providing invalid inputs while playing the game using the previous code example to understand the code block flow.

Connecting to the Internet – web requests
Now that we discussed the try/except keywords, let's make use of it to build a simple application that connects to the Internet. We will write a simple application that retrieves the current time from the Internet. We will be making use of the requests library for Python (http://requests.readthedocs.io/en/master/#).

The requests module enables connecting to the Web and retrieving information. In order to do so, we need to make use of the get() method from the requests module to make a request:

import requests
response = requests.get('http://nist.time.gov/actualtime.cgi')

Copy

Explain
In the preceding code snippet, we are passing a URL as an argument to the get() method. In this case, it is the URL that returns the current time in the Unix format (https://en.wikipedia.org/wiki/Unix_time).

Let's make use of the try/except keywords to make a request to get the current time:

#!/usr/bin/python3

import requests

if __name__ == "__main__":
  # Source for link: http://stackoverflow.com/a/30635751/822170
  try:
    response = requests.get('http://nist.time.gov/actualtime.cgi')
    print(response.text)
  except requests.exceptions.ConnectionError as error:
    print("Something went wrong. Try again")

Copy

Explain
In the preceding example (available for download along with this chapter as internet_access.py), the request is made under the try block, and the response (returned by response.text) is printed to the screen.

If there is an error while executing the request to retrieve the current time, ConnectionError is raised (http://requests.readthedocs.io/en/master/user/quickstart/#errors-and-exceptions). This error could either be caused by the lack of an Internet connection or an incorrect URL. This error is caught by the except block. Try running the example, and it should return the current time from time.gov:

<timestamp time="1474421525322329" delay="0"/>

Copy

Explain
The application of requests – retrieving weather information
Let's make use of the requests module to retrieve the weather information for the city of San Francisco. We will be making use of the OpenWeatherMap API (openweathermap.org) to retrieve the weather information:

In order to make use of the API, sign up for an API account and get an API key (it is free of charge):

An API key from openweathermap.org

According to the API documentation (openweathermap.org/current), the weather information for a city can be retrieved using http://api.openweathermap.org/data/2.5/weather?zip=SanFrancisco&appid=API_KEY&units=imperial as the URL.


Substitute API_KEY with the key from your account and use it to retrieve the current weather information in a browser. You should be able to retrieve the weather information in the following format:
       {"coord":{"lon":-122.42,"lat":37.77},"weather":[{"id":800,
       "main":"Clear","description":"clear sky","icon":"01n"}],"base":
       "stations","main":{"temp":71.82,"pressure":1011,"humidity":50,
       "temp_min":68,"temp_max":75.99},"wind":
       {"speed":13.04,"deg":291},
       "clouds":{"all":0},"dt":1474505391,"sys":{"type":3,"id":9966,
       "message":0.0143,"country":"US","sunrise":1474552682,
       "sunset":1474596336},"id":5391959,"name":"San
       Francisco","cod":200}

Copy

Explain
The weather information (shown previously) is returned in the JSON format. JavaScript Object Notation (JSON) is a data format that is widely used to exchange data over the Web. The main advantage of JSON format is that it is in a readable format and many popular programming languages support encapsulating data in JSON format. As shown in the earlier snippet, JSON format enables exchanging information in readable name/value pairs.

Let's review retrieving the weather using the requests module and parsing the JSON data:

Substitute the URL in the previous example (internet_access.py) with the one discussed in this example. This should return the weather information in the JSON format.
The requests module provides a method to parse the JSON data. The response could be parsed as follows:
       response = requests.get(URL)
       json_data = response.json()

Copy

Explain
The json() function parses the response from the OpenWeatherMap API and returns a dictionary of different weather parameters (json_data) and their values.
Since we know the response format from the API documentation, the current temperature could be retrieved from the parsed response as follows:
       print(json_data['main']['temp'])

Copy

Explain
Putting it all together, we have this:
       #!/usr/bin/python3

       import requests

       # generate your own API key
       APP_ID = '5d6f02fd4472611a20f4ce602010ee0c'
       ZIP = 94103
       URL = """http://api.openweathermap.org/data/2.5/weather?zip={}
       &appid={}&units=imperial""".format(ZIP, APP_ID)

       if __name__ == "__main__":
         # API Documentation: http://openweathermap.org/
         current#current_JSON
         try:
           # encode data payload and post it
           response = requests.get(URL)
           json_data = response.json()
           print("Temperature is %s degrees Fahrenheit" %
           json_data['main']['temp'])
         except requests.exceptions.ConnectionError as error:
           print("The error is %s" % error)

Copy

Explain
The preceding example is available for download along with this chapter as weather_example.py. The example should display the current temperature as follows:

Temperature is 68.79 degrees Fahrenheit

Copy

Explain
The application of requests – publishing events to the Internet
In the previous example, we retrieved information from the Internet. Let's consider an example where we have to publish a sensor event somewhere on the Internet. This could be either a cat door opening while you are away from home or someone at your doorstep stepping on the doormat. Because we discussed interfacing sensors to the Raspberry Pi Zero in the previous chapter, let's discuss a scenario where we could post these events to Slack—a workplace communication tool, Twitter, or cloud services such as Phant (https://data.sparkfun.com/).

In this example, we will post these events to Slack using requests. Let's send a direct message to ourselves on Slack whenever a sensor event such as a cat door opening occurs. We need a URL to post these sensor events to Slack. Let's review generating a URL in order to post sensor events to Slack:

The first step in generating a URL is creating an incoming webhook. A webhook is a type request that can post messages that are carried as a payload to applications such as Slack.


If you are a member of a Slack team named TeamX, launch your team's application directory, namely teamx.slack.com/apps in a browser:

Launch your team's app directory

Search for incoming webhooks in your app directory and select the first option, Incoming WebHooks (as shown in the following screenshot):

Select incoming webhooks

Click on Add Configuration:

Add Configuration

Let's send a private message to ourselves when an event occurs. Select Privately to           (you) as the option and create a webhook by clicking on Add Incoming WebHooks integration:

Select Privately to you



We have generated a URL to send direct messages about sensor events (URL partially concealed):

Generated URL

Now, we can send direct message to ourselves on Slack using the previously-mentioned URL. The sensor event can be published to Slack as a JSON payload. Let's review posting a sensor event to Slack.
For example, let's consider posting a message when a cat door opens. The first step is preparing the JSON payload for the message. According to the Slack API documentation (https://api.slack.com/custom-integrations), the message payload needs to be in the following format:
       payload = {"text": "The cat door was just opened!"}

Copy

Explain
In order to publish this event, we will make use of the post() method from the requests module. The data payload needs to be encoded in JSON format while posting it:
       response = requests.post(URL, json.dumps(payload))

Copy

Explain
Putting it all together, we have this:
       #!/usr/bin/python3

       import requests
       import json

       # generate your own URL
       URL = 'https://hooks.slack.com/services/'

       if __name__ == "__main__":
         payload = {"text": "The cat door was just opened!"}
         try:
           # encode data payload and post it
           response = requests.post(URL, json.dumps(payload))
           print(response.text)
         except requests.exceptions.ConnectionError as error:
           print("The error is %s" % error)

Copy

Explain
On posting the message, the request returns ok as a response. This indicates that the post was successful.
Generate your own URL and execute the preceding example (available for download along with this chapter as slack_post.py). You will receive a direct message on Slack:

Direct message on Slack

Now, try interfacing a sensor to the Raspberry Pi Zero (discussed in previous chapters) and post the sensor events to Slack.

It is also possible to post sensor events to Twitter and have your Raspberry Pi Zero check for new e-mails and so on. Check this book's website for more examples.

Flask web framework
In our final section, we will discuss web frameworks in Python. We will discuss the Flask framework (http://flask.pocoo.org/). Python-based frameworks enable interfacing sensors to a network using the Raspberry Pi Zero. This enables controlling appliances and reading data from sensors from anywhere within a network. Let's get started!

Installing Flask
The first step is installing the Flask framework. It can be done as follows:

sudo pip3 install flask

Copy

Explain
Building our first example
The Flask framework documentation explains building the first example. Modify the example from the documentation as follows:

#!/usr/bin/python3

from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello World!"

if __name__ == "__main__":
    app.run('0.0.0.0')

Copy

Explain
Launch this example (available for download along with this chapter as flask_example.py) and it should launch a server on the Raspberry Pi Zero visible to the network. On another computer, launch a browser and enter the IP address of the Raspberry Pi Zero along with port number, 5000, as a suffix (as shown in the following snapshot). It should take you to the index page of the server that displays the message Hello World!:


The Flask framework-based web server on the Raspberry Pi Zero

You can find the IP address of your Raspberry Pi Zero using the ifconfig command on the command-line terminal.

Controlling appliances using the Flask framework
Let's try turning on/off appliances at home using the Flask framework. In previous chapters, we made use of PowerSwitch Tail II to control a table lamp using the Raspberry Pi Zero. Let's try to control the same using the Flask framework. Connect PowerSwitch Tail, as shown in the following figure:


Controlling a table lamp using the Flask framework

According to the Flask framework documentation, it is possible to route a URL to a specific function. For example, it is possible to bind /lamp/<control> using route() to the control() function:

@app.route("/lamp/<control>")
def control(control):
  if control == "on":
    lights.on()
  elif control == "off":
    lights.off()
  return "Table lamp is now %s" % control

Copy

Explain
In the preceding code snippet, <control> is a variable that can be passed on as an argument to the binding function. This enables us to turn the lamp on/off. For example, <IP address>:5000/lamp/on turns on the lamp, and vice versa. Putting it all together, we have this:

#!/usr/bin/python3

from flask import Flask
from gpiozero import OutputDevice

app = Flask(__name__)
lights = OutputDevice(2)

@app.route("/lamp/<control>")
def control(control):
  if control == "on":
    lights.on()
  elif control == "off":
    lights.off()
  return "Table lamp is now %s" % control

if __name__ == "__main__":
    app.run('0.0.0.0')

Copy

Explain
The preceding example is available for download along with this chapter as appliance_control.py. Launch the Flask-based web server and open a web server on another computer. In order to turn on the lamp, enter <IP Address of the Raspberry Pi Zero>:5000/lamp/on as URL:

This should turn on the lamp:


Thus, we have built a simple framework that enables controlling appliances within the network. It is possible to include buttons to an HTML page and route them to a specific URL to perform a specific function. There are several other frameworks in Python that enable developing web applications. We have merely introduced you to different applications that are possible with Python. We recommend that you check out this book's website for more examples, such as controlling Halloween decorations and other holiday decorations using the Flask framework.

Summary
In this chapter, we discussed the try/except keywords in Python. We also discussed developing applications that retrieves information from the Internet, as well as publishing sensor events to the Internet. We also discussed the Flask web framework for Python and demonstrated the control of appliances within a network. In the next chapter, we will discuss some advanced topics in Python.




| ≪ [ 06 File I/O and Python Utilities ](/packtpub/2024/817-Python_with_RaspPi_1ed/06_File_I-O_and_Python_Utilities) | 07 Requests and Web Frameworks | [ 08 Awesome Things You Could Develop Using Python ](/packtpub/2024/817-Python_with_RaspPi_1ed/08_Awesome_Things_You_Could_Develop_Using_Python) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 07 Requests and Web Frameworks
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: /packtpub/2024/817-Python_with_RaspPi_1ed/07_Requests_and_Web_Frameworks
> Book Jemok: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 16:35:09
> .md Name: 07_requests_and_web_frameworks.md

