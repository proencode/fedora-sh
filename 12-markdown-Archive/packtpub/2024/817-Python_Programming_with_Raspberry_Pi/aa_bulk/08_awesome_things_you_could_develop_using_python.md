
| ≪ [ 07 Requests and Web Frameworks ](/packtpub/2024/817-Python_with_RaspPi_1ed/07_Requests_and_Web_Frameworks) | 08 Awesome Things You Could Develop Using Python | [ 09 Let's Build a Robot ](/packtpub/2024/817-Python_with_RaspPi_1ed/09_Let_s_Build_a_Robot) ≫ |
|:----:|:----:|:----:|

# 08 Awesome Things You Could Develop Using Python
Chapter 8. Awesome Things You Could Develop Using Python
In this chapter, we will discuss some advanced topics in Python. We will also discuss certain unique topics (such as image processing) that let you get started with application development in Python.

Image processing using a Raspberry Pi Zero
The Raspberry Pi Zero is an inexpensive piece of hardware that is powered by a 1 GHz processor. While it is not powerful to run certain advanced image processing operations, it can help you learn the basics on a $25 budget (the cost of Raspberry Pi Zero and a camera).

Note
We recommend using a 16 GB card (or higher) with your Raspberry Pi Zero in order to install the image processing tool set discussed in this section.

For example, you could use a Raspberry Pi Zero to track a bird in your backyard. In this chapter, we are going to discuss different ways to get started with image processing on the Raspberry Pi Zero.

In order to test some examples using the camera in this section, a Raspberry Pi Zero v1.3 or later is required. Check the back of your Raspberry Pi Zero to verify the board version:


Identifying your Raspberry Pi Zero's version

OpenCV
OpenCV is an open source toolbox that consists of different software tools developed for image processing. OpenCV is a cross-platform toolbox that has been developed with support for different operating systems. Because OpenCV is available under an open source license, researchers across the world have contributed to its growth by developing tools and techniques. This has made developing applications with relative ease. Some applications of OpenCV include face recognition and license plate recognition.

Note
Due to its limited processing power, it can take several hours to complete the installation of the framework. It took us approximately 10 hours at our end.

We followed the instructions to install OpenCV on the Raspberry Pi Zero from http://www.pyimagesearch.com/2015/10/26/how-to-install-opencv-3-on-raspbian-jessie/.We specifically followed the instructions to install OpenCV with Python 3.x bindings and verified the installation process. It took us approximately 10 hours to finish installing OpenCV on the Raspberry Pi Zero. We are not repeating the instructions in the interest of not reinventing the wheel.

The verification of the installation
Let's make sure that the OpenCV installation and its Python bindings work. Launch the command-line terminal and make sure that you have launched the cv virtual environment by executing the workon cv command (you can verify that you are in the cv virtual environment):


Verify that you are in the cv virtual environment

Now, let's make sure that our installation works correctly. Launch the Python interpreter from the command line and try to import the cv2 module:

>>> import cv2
    >>> cv2.__version__
    '3.0.0'

Copy

Explain
This proves that OpenCV is installed on the Raspberry Pi Zero. Let's write a hello world example involving OpenCV. In this example, we are going to open an image (this can be any color image on your Raspberry Pi Zero's desktop) and display it after converting it to grayscale. We will be using the following documentation to write our first example: http://docs.opencv.org/3.0-beta/doc/py_tutorials/py_gui/py_image_display/py_image_display.html.

According to the documentation, we need to make use of the imread() function to read the contents of the image file. We also need to specify the format in which we would like to read the image. In this case, we are going to read the image in grayscale format. This is specified by cv2.IMREAD_GRAYSCALE that is passed as the second argument to the function:

import cv2

img = cv2.imread('/home/pi/screenshot.jpg',cv2.IMREAD_GRAYSCALE)

Copy

Explain
Now that the image is loaded in grayscale format and saved to the img variable, we need to display it in a new window. This is enabled by the imshow() function. According to the documentation, we can display an image by specifying the window name as the first argument and the image as the second argument:

cv2.imshow('image',img)

Copy

Explain
In this case, we are going to open a window named image and display the contents of img that we loaded in the previous step. We will display the image until a keystroke is received. This is achieved using the cv2.waitKey() function. According to the documentation, the waitkey() function listens for keyboard events:

cv2.waitKey(0)

Copy

Explain
The 0 argument indicates that we are going to wait indefinitely for a keystroke. According to the documentation, when the duration, in milliseconds, is passed as an argument, the waitkey() function listens to keystrokes for the specified duration. When any key is pressed, the window is closed by the destroyAllWindows() function:

cv2.destroyAllWindows()

Copy

Explain
Putting it all together, we have this:

import cv2

img = cv2.imread('/home/pi/screenshot.jpg',cv2.IMREAD_GRAYSCALE)
cv2.imshow('image',img)
cv2.waitKey(0)
cv2.destroyAllWindows()

Copy

Explain
The preceding code sample is available for download along with this chapter as opencv_test.py. Once you are done installing OpenCV libraries, try loading an image as shown in this example. It should load an image in grayscale, as shown in the following figure:


The Raspberry Pi desktop loaded in grayscale

This window would close at the press of any key.

A challenge to the reader
In the preceding example, the window closes at the press of any key. Take a look at the documentation and determine if it is possible to close all windows at the press of a mouse button.

Installing the camera to the Raspberry Zero
A camera connector and a camera is required for testing our next example. One source to buy the camera and the adapter is provided here:

Name

Source

Raspberry Pi Zero camera adapter

https://thepihut.com/products/raspberry-pi-zero-camera-adapter

Raspberry Pi camera

https://thepihut.com/products/raspberry-pi-camera-module



Perform the following steps to install a camera to the Raspberry Pi Zero:

The first step is interfacing the camera to the Raspberry Pi Zero. The camera adapter can be installed as shown in the following figure. Lift the connector tab and slide the camera adapter and press the connector gently:



We need to enable the camera interface on the Raspberry Pi Zero. On your desktop, go to Preferences and launch Raspberry Pi Configuration. Under the Interfaces tab of the Raspberry Pi configuration, enable the camera, and save the configuration:

Enable the camera interface

Let's test the camera by taking a picture by running the following command from the command-line terminal:
raspistill -o /home/pi/Desktop/test.jpg

Copy

Explain
It should take a picture and save it to your Raspberry Pi's desktop. Verify that the camera is functioning correctly. If you are not able to get the camera working, we recommend the troubleshooting guide published by the Raspberry Pi Foundation: https://www.raspberrypi.org/documentation/raspbian/applications/camera.md.
The camera cable is a bit unwieldy, and it can make things difficult while trying to take a picture. We recommend using a camera mount. We found this one to be useful (shown in the following image) at http://a.co/hQolR7O:


Use a mount for your Raspberry Pi's camera

Let's take the camera for a spin and use it alongside OpenCV libraries:

We are going to take a picture using the camera and display it using the OpenCV framework. In order to access the camera in Python, we need the picamera package. This can be installed as follows:
pip3 install picamera

Copy

Explain
Let's make sure that the package works as intended with a simple program. The documentation for the picamera package is available at https://picamera.readthedocs.io/en/release-1.12/api_camera.html.
The first step is initializing the PiCamera class. This is followed by flipping the image across the vertical axis. This is only required because the camera is mounted upside down on the mount. This may not be necessary with other mounts:
       with PiCamera() as camera:
       camera.vflip = True

Copy

Explain
Before taking a picture, we can preview the picture that is going to be captured using the start_preview() method:
       camera.start_preview()

Copy

Explain


Let's preview for 10 seconds before we take a picture. We can take a picture using the capture() method:
       sleep(10)
       camera.capture("/home/pi/Desktop/desktop_shot.jpg")
       camera.stop_preview()

Copy

Explain
The capture() method requires the file location as an argument (as shown in the preceding snippet). Once we are done, we can close the camera preview using stop_preview().
Putting it altogether, we have this:
       from picamera import PiCamera
       from time import sleep

       if __name__ == "__main__":
         with PiCamera() as camera:
           camera.vflip = True
           camera.start_preview()
           sleep(10)
           camera.capture("/home/pi/Desktop/desktop_shot.jpg")
           camera.stop_preview()

Copy

Explain
The preceding code sample is available for download along with this chapter as picamera_test.py. A snapshot taken using the camera is shown in the following figure:


Image captured using the Raspberry Pi camera module



Let's combine this example with the previous one—convert this image to grayscale and display it until a key is pressed. Ensure that you are still within the cv virtual environment workspace.
Let's convert the captured image to grayscale as follows:
       img = cv2.imread("/home/pi/Desktop/desktop_shot.jpg",
       cv2.IMREAD_GRAYSCALE)

Copy

Explain
The following is the image converted upon capture:


Image converted to grayscale upon capture

Now we can display the grayscale image as follows:
       cv2.imshow("image", img)
       cv2.waitKey(0)
       cv2.destroyAllWindows()

Copy

Explain
The modified example is available for download as picamera_opencvtest.py.

So far, we have demonstrated developing image processing applications in Python. In Chapter 10, Home Automation Using the Raspberry Pi Zero, we have demonstrated another example using OpenCV. This should get you kick-started with learning OpenCV in Python. We also recommend checking out examples available with the OpenCV Python binding documentation (link provided in the introduction part of this section).

Speech recognition
In this section, we will discuss developing a speech recognition example in Python involving speech recognition. We will make use of the requests module (discussed in the previous chapter) to transcribe audio using wit.ai (https://wit.ai/).

Note
There are several speech recognition tools, including Google's Speech API, IBM Watson, Microsoft Bing's speech recognition API. We are demonstrating wit.ai as an example.

Speech recognition can be useful in applications where we would like to enable the Raspberry Pi Zero responses to voice commands. For example, in Chapter 10, Home Automation Using the Raspberry Pi Zero, we will be working on a home automation project. We could make use of speech recognition to respond to voice commands.

Let's review building the speech recognition application in Python using wit.ai (its documentation is available here at https://github.com/wit-ai/pywit). In order to perform speech recognition and recognize voice commands, we will need a microphone. However, we will demonstrate using a readily available audio sample. We will make use of audio samples made available by a research publication (available at http://ecs.utdallas.edu/loizou/speech/noizeus/clean.zip).

Note
The wit.ai API license states that the tool is free to use, but the audio uploaded to their servers are used to tune their speech transcription tool.

We will now attempt transcribing the sp02.wav audio sample performing the following steps:

The first step is signing up for an account with wit.ai. Make a note of the API as shown in the following screenshot:

The first step is installing the requests library. It could be installed as follows:
pip3 install requests

Copy

Explain
According to the wit.ai documentation, we need to add custom headers to our request that includes the API key (replace $TOKEN with the token from your account). We also need to specify the file format in the header. In this case, it is a .wav file, and the sampling frequency is 8000 Hz:
       import requests

       if __name__ == "__main__":
         url = 'https://api.wit.ai/speech?v=20161002'
         headers = {"Authorization": "Bearer $TOKEN",
                    "Content-Type": "audio/wav"}

Copy

Explain
In order to transcribe the audio sample, we need to attach the audio sample in the request body:
       files = open('sp02.wav', 'rb')
       response = requests.post(url, headers=headers, data=files)
       print(response.status_code)
       print(response.text)

Copy

Explain


Putting it all together, gives us this:
       #!/usr/bin/python3

       import requests

       if __name__ == "__main__":
         url = 'https://api.wit.ai/speech?v=20161002'
         headers = {"Authorization": "Bearer $TOKEN",
                    "Content-Type": "audio/wav"}
         files = open('sp02.wav', 'rb')
         response = requests.post(url, headers=headers, data=files)
         print(response.status_code)
         print(response.text)

Copy

Explain
The preceding code sample is available for download along with this chapter as wit_ai.py. Try executing the preceding code sample, and it should transcribe the audio sample: sp02.wav. We have the following code:

200
{
  "msg_id" : "fae9cc3a-f7ed-4831-87ba-6a08e95f515b",
  "_text" : "he knew the the great young actress",
  "outcomes" : [ {
    "_text" : "he knew the the great young actress",
    "confidence" : 0.678,
    "intent" : "DataQuery",
    "entities" : {
      "value" : [ {
        "confidence" : 0.7145905790744499,
        "type" : "value",
        "value" : "he",
        "suggested" : true
      }, {
        "confidence" : 0.5699616515542044,
        "type" : "value",
        "value" : "the",
        "suggested" : true
      }, {
        "confidence" : 0.5981701138805214,
        "type" : "value",
        "value" : "great",
        "suggested" : true
      }, {
        "confidence" : 0.8999612482250062,
        "type" : "value",
        "value" : "actress",
        "suggested" : true
      } ]
    }
  } ],
  "WARNING" : "DEPRECATED"
}

Copy

Explain
The audio sample contains the following recording: He knew the skill of the great young actress. According to the wit.ai API, the transcription is He knew the the great young actress. The word error rate is 22% (https://en.wikipedia.org/wiki/Word_error_rate).

Note
We will be making use of the speech transcription API to issue voice commands in our home automation project.

Automating routing tasks
In this section, we are going to discuss automating routing tasks in Python. We took two examples such that they demonstrate the ability of a Raspberry Pi Zero acting as a personal assistant. The first example involves improving your commute, whereas the second example serves as an aid to improve your vocabulary. Let's get started.

Improving daily commute
Many cities and public transit systems have started sharing data with the public in the interest of being transparent and improving their operational efficiency. Transit systems have started sharing advisories and transit information to the public through an API. This enables anyone to develop mobile applications that provide information to commuters. At times, it helps with easing congestion within the public transit system.

This example was inspired by a friend who tracks bicycle availability in San Francisco's bike share stations. In the San Francisco Bay Area, there is a bicycle sharing program that enables commuters to rent a bike from a transit center to their work. In a crowded city like San Francisco, bike availability at a given station fluctuates depending on the time of day.

This friend wanted to plan his day based on bike availability at the nearest bike share station. If there are very few bikes left at the station, this friend preferred leaving early to rent a bike. He was looking for a simple hack that would push a notification to his phone when the number of bikes is below a certain threshold. San Francisco's bike share program makes this data available at http://feeds.bayareabikeshare.com/stations/stations.json.

Let's review building a simple example that would enable sending a push notification to a mobile device. In order to send a mobile push notification, we will be making use of If This Then That (IFTTT)—a service that enables connecting your project to third-party services.

In this example, we will parse the data available in JSON format, check the number of available bikes at a specific station, and if it is lower than the specified threshold, it triggers a notification on your mobile device.

Let's get started:

The first step is retrieving the bike availability from the bike share service. This data is available in JSON format at http://feeds.bayareabikeshare.com/stations/stations.json. The data includes bike availability throughout the network.
The bike availability at each station is provided with parameters, such as station ID, station name, address, number of bikes available, and so on.
In this example, we will retrieve the bike availability for the Townsend at 7th station in San Francisco. The station ID is 65 (open the earlier-mentioned link in a browser to find id). Let's write some Python code to retrieve the bike availability data and parse this information:
       import requests

       BIKE_URL = http://feeds.bayareabikeshare.com/stations
       /stations.json

       # fetch the bike share information
       response = requests.get(BIKE_URL)
       parsed_data = response.json()

Copy

Explain
The first step is fetching the data using a GET request (via the requests module). The requests module provides an inbuilt JSON decoder. The JSON data can be parsed by calling the json() function.



Now, we can iterate through the dictionary of stations and find the bike availability at Townsend at 7th, by performing the following steps:
In the retrieved data, each station's data is furnished with an ID. The station ID in question is 65 (open the data feed URL provided earlier in a browser to understand the data format; a snippet of the data is shown in the following screenshot):

A snippet of the bike share data feed fetched using a browser

We need to iterate through the values and determine if the station id matches that of Townsend at 7th:
              station_list = parsed_data['stationBeanList']
              for station in station_list:
                if station['id'] == 65 and
                   station['availableBikes'] < 2:
                  print("The available bikes is %d" % station
                  ['availableBikes'])

Copy

Explain
If there are less than 2 bikes available at the station, we push a mobile notification to our mobile device.
In order to receive mobile notifications, you need to install IF by IFTTT app (available for Apple and Android devices).
We also need to set up a recipe on IFTTT to trigger mobile notifications. Sign up for an account at https://ifttt.com/.
IFTTT is a service that enables creating recipes that connecting devices to different applications and automating tasks. For example, it is possible to log events tracked by the Raspberry Pi Zero to a spreadsheet on your Google Drive.

All recipes on IFTTT follow a common template—if this then that, that is, if a particular event has occurred, then a specific action is triggered. For this example, we need to create an applet that triggers a mobile notification on receiving a web request.



You can start creating an applet using the drop-down menu under your account, as shown in the following screenshot:

Start creating a recipe on IFTTT

It should take you to a recipe setup page (shown as follows). Click on this and set up an incoming web request:

Click on this

Select the Maker Webhooks channel as the incoming trigger:

Select the Maker Webhooks channel



Select Receive a web request. A web request from the Raspberry Pi would act as a trigger to send a mobile notification:

Select Receive a web request

Create a trigger named mobile_notify:

Create a new trigger named mobile_notify

It is time to create an action for the incoming trigger. Click on that.

Click on that

Select Notifications:

Select Notifications

Now, let's format the notification that we would like to receive on our devices:

Setup notification for your device



In the mobile notification, we need to receive the number of bikes available at the bike share station. Click on the + Ingredient button and select Value1.

Format the message to suit your needs. For example, when a notification is triggered by the Raspberry Pi, it would be great to receive a message in the following format: Time to go home! Only 2 bikes are available at Townsend & 7th!


Once you are satisfied with the message format, select Create action and your recipe should be ready!

Create a recipe

In order to trigger a notification on our mobile device, we need a URL to make the POST request and a trigger key. This is available under Services | Maker Webhooks | Settings in your IFTTT account.
The trigger can be located here:


Open the URL listed in the preceding screenshot in a new browser window. It provides the URL for the POST request as well as an explanation on (shown in the following screenshot) how to make a web request:


Making a POST request using the earlier-mentioned URL (key concealed for privacy)

While making a request (as explained in the IFTTT documentation), if we include the number of bikes in the JSON body of request (using Value1), it can be shown on the mobile notification.
Let's revisit the Python example to make a web request when the number of bikes is below a certain threshold. Save the IFTTT URL and your IFTTT access key (retrieved from your IFTTT account) to your code as follows:
       IFTTT_URL = "https://maker.ifttt.com/trigger/mobile_notify/
       with/key/$KEY"

Copy

Explain
When the number of bikes is below a certain threshold, we need to make a POST request with the bike information encoded in the JSON body:
       for station in station_list:
         if station['id'] == 65 and
            station['availableBikes'] < 3:
           print("The available bikes is %d" %
           station['availableBikes'])
           payload = {"value1": station['availableBikes']}
           response = requests.post(IFTTT_URL, json=payload)
           if response.status_code == 200:
             print("Notification successfully triggered")

Copy

Explain
In the preceding code snippet, if there are less than three bikes, a POST request is made using the requests module. The number of available bikes is encoded with the key value1:
       payload = {"value1": station['availableBikes']}

Copy

Explain
Putting it all together, we have this:
       #!/usr/bin/python3

       import requests
       import datetime

       BIKE_URL = "http://feeds.bayareabikeshare.com/stations/
       stations.json"
       # find your key from ifttt
       IFTTT_URL = "https://maker.ifttt.com/trigger/mobile_notify/
       with/key/$KEY"

       if __name__ == "__main__":
         # fetch the bike share information
         response = requests.get(BIKE_URL)
         parsed_data = response.json()
         station_list = parsed_data['stationBeanList']
         for station in station_list:
           if station['id'] == 65 and
              station['availableBikes'] < 10:
             print("The available bikes is %d" % station
             ['availableBikes'])
         payload = {"value1": station['availableBikes']}
             response = requests.post(IFTTT_URL, json=payload)
             if response.status_code == 200:
               print("Notification successfully triggered")

Copy

Explain
The preceding code sample is available for download along with this chapter as bike_share.py. Try executing it after setting up a recipe on IFTTT. If necessary, adjust the threshold for the number of available bikes. You should receive a mobile notification on your device:


Notification on your mobile device

A challenge to the reader
In this example, the bike information is fetched and parsed and if necessary, a notification is triggered. How would you go about modifying this code example to make sure that it is executed between a given time of the day? (hint: make use of datetime module).

How would you go about building a desktop display that serves as a visual aid?

Project challenge
Try to find out if the transit systems in your area provide such data to its users. How would you make use of the data to help commuters save time? For example, how would you provide transit system advisories to your friends/colleagues using such data?

Note
On completion of the book, we will post a similar example using the data from San Francisco Bay Area Rapid Transit (BART).

Improving your vocabulary
It is possible to improve your vocabulary using Python! Imagine setting up a large display that is installed somewhere prominently and updated on a daily basis. We will be making use of the wordnik API (sign up for an API key at https://www.wordnik.com/signup):

The first step is to install the wordnik API client for python3:
git clone https://github.com/wordnik/wordnik-python3.git
       cd wordnik-python3/
       sudo python3 setup.py install

Copy

Explain
Note
There are restrictions on the wordnik API usage. Refer to the API documentation for more details.

Let's review writing our first example using the wordnik Python client. In order to fetch the word of the day, we need to initialize the WordsApi class. According to the API documentation, this could be done as follows:
       # sign up for an API key
       API_KEY = 'API_KEY'
       apiUrl = 'http://api.wordnik.com/v4'
       client = swagger.ApiClient(API_KEY, apiUrl)
       wordsApi = WordsApi.WordsApi(client)

Copy

Explain
Now that the WordsApi class is initialized, let's go ahead and fetch the word of the day:
       example = wordsApi.getWordOfTheDay()

Copy

Explain
This returns a WordOfTheDay object. According to the wordnik Python client documentation, this object consists of different parameters including the word, its synonym, source, usage, and so on. The word of the day and its synonym could be printed as follows:
       print("The word of the day is %s" % example.word)
       print("The definition is %s" %example.definitions[0].text)

Copy

Explain


Putting it all together, we have this:
       #!/usr/bin/python3

       from wordnik import *

       # sign up for an API key
       API_KEY = 'API_KEY'
       apiUrl = 'http://api.wordnik.com/v4'

       if __name__ == "__main__":
         client = swagger.ApiClient(API_KEY, apiUrl)
         wordsApi = WordsApi.WordsApi(client)
         example = wordsApi.getWordOfTheDay()
         print("The word of the day is %s" % example.word)
         print("The definition is %s" %example.definitions[0].text)

Copy

Explain
The preceding code snippet is available for download along with this chapter as wordOfTheDay.py. Sign up for an API key, and you should be able to retrieve the word of the day:

The word of the day is transpare
       The definition is To be, or cause to be, transparent; to appear,
       or cause to appear, or be seen, through something.

Copy

Explain
A challenge to the reader
How would you daemonize this application such that the word of the day is updated every day? (hint: cronjob or datetime).

Project challenge
It is possible to build a word game using the wordnik API. Think of a word game that is entertaining as well as helps improve your vocabulary. How would you go about building something that prompts questions to the player and accepting answer inputs?

Try displaying the word of the day on a display. How would you implement this?

Logging
This is a topic that is going to be useful for the next two chapters. Logging (https://docs.python.org/3/library/logging.html) helps with troubleshooting a problem. It helps with determining the root cause of a problem by tracing back through the sequence of events logged by the application. While we will be making extensive use of logging in the next two chapters, let's review logging using a simple application. In order to review logging, let's review it by making a POST request:

The first step in logging is setting the log file location and the log level:
       logging.basicConfig(format='%(asctime)s : %(levelname)s :
       %(message)s', filename='log_file.log', level=logging.INFO)

Copy

Explain
While initializing the logging class, we need to specify the format for logging information, errors, and so on to the file. In this case, the format is as follows:

       format='%(asctime)s : %(levelname)s : %(message)s'

Copy

Explain
The log messages are in the following format:

       2016-10-25 20:28:07,940 : INFO : Starting new HTTPS
       connection (1):
       maker.ifttt.com

Copy

Explain
The log messages are saved to a file named log_file.log.

The logging level determines the level of logging needed for our application. The different log levels include DEBUG, INFO, WARN, and ERROR.

In this example, we have set the logging level to INFO. So, any log message belonging to INFO, WARNING, or ERROR levels are saved to the file.

If the logging level is set to ERROR, only those log messages are saved to the file.

Let's log a message based on the outcome of the POST request:
       response = requests.post(IFTTT_URL, json=payload)
       if response.status_code == 200:
         logging.info("Notification successfully triggered")
       else:
         logging.error("POST request failed")

Copy

Explain


Putting it all together, we have this:
       #!/usr/bin/python3

       import requests
       import logging

       # find your key from ifttt
       IFTTT_URL = "https://maker.ifttt.com/trigger/rf_trigger/
       with/key/$key"

       if __name__ == "__main__":
         # fetch the bike share information
         logging.basicConfig(format='%(asctime)s : %(levelname)s
         : %(message)s', filename='log_file.log', level=logging.INFO)
         payload = {"value1": "Sample_1", "value2": "Sample_2"}
         response = requests.post(IFTTT_URL, json=payload)
         if response.status_code == 200:
           logging.info("Notification successfully triggered")
         else:
           logging.error("POST request failed")

Copy

Explain
The preceding code sample (logging_example.py) is available for download along with this chapter. This is a very soft introduction to the concept of logging in Python. We are going to make use of logging to troubleshoot any errors in our project.

In the final chapter, we will discuss best practices in logging.

Threading in Python
In this section, we are going to discuss the concept of threading in Python. We will be making use of threading in the next chapter. Threads enable running multiple processes at the same time. For example, we can run motors while listening to incoming events from sensors. Let's demonstrate this with an example.

We are going to emulate a situation where we would like to process events from sensors of the same type. In this example, we are just going to print something to the screen. We need to define a function that listens to events from each sensor:

def sensor_processing(string):
  for num in range(5):
    time.sleep(5)
    print("%s: Iteration: %d" %(string, num))

Copy

Explain
We can make use of the preceding function to listen for sensor events from three different sensors at the same time using the threading module in Python:

thread_1 = threading.Thread(target=sensor_processing, args=("Sensor 1",))
thread_1.start()

thread_2 = threading.Thread(target=sensor_processing, args=("Sensor 2",))
thread_2.start()

thread_3 = threading.Thread(target=sensor_processing, args=("Sensor 3",))
thread_3.start()

Copy

Explain
Putting it all together, we have this:

import threading
import time

def sensor_processing(string):
  for num in range(5):
    time.sleep(5)
    print("%s: Iteration: %d" %(string, num))

if __name__ == '__main__':
  thread_1 = threading.Thread(target=sensor_processing, args=("Sensor 1",))
  thread_1.start()

  thread_2 = threading.Thread(target=sensor_processing, args=("Sensor 2",))
  thread_2.start()

  thread_3 = threading.Thread(target=sensor_processing, args=("Sensor 3",))
  thread_3.start()

Copy

Explain
The preceding code sample (available for download as threading_example.py) starts three threads that listens to events from three sensors at the same time. The output looks something like this:

Thread 1: Iteration: 0
Thread 2: Iteration: 0
Thread 3: Iteration: 0
Thread 2: Iteration: 1
Thread 1: Iteration: 1
Thread 3: Iteration: 1
Thread 2: Iteration: 2
Thread 1: Iteration: 2
Thread 3: Iteration: 2
Thread 1: Iteration: 3
Thread 2: Iteration: 3
Thread 3: Iteration: 3
Thread 1: Iteration: 4
Thread 2: Iteration: 4
Thread 3: Iteration: 4

Copy

Explain
In the next chapter, we are going to make use of threading to control the motors of a robot-based on sensor inputs.

PEP8 style guide for Python
PEP8 is a style guide for Python that helps programmers write readable code. It is important to follow certain conventions to make our code readable. Some examples of coding conventions include the following:

Inline comments should start with a #  and be followed by a single space.
Variables should have the following convention: first_var.
Avoiding trailing whitespaces on each line. For example, if name == "test": should not be followed by whitespaces.
Note
You can read the entire PEP8 standards at https://www.python.org/dev/peps/pep-0008/#block-comments.

Verifying PEP8 guidelines
There are tools to verify PEP8 standards of your code. After writing a code sample, ensure that your code adheres to PEP8 standards. This can be done using the pep8 package. It can be installed as follows:

pip3 install pep8

Copy

Explain
Let's check whether one of our code samples has been written according to the PEP8 convention. This can be done as follows:

pep8 opencv_test.py

Copy

Explain
The check indicated the following errors:

opencv_test.py:5:50: E231 missing whitespace after ','
    opencv_test.py:6:19: E231 missing whitespace after ','

Copy

Explain
As the output indicates, the following lines are missing a whitespace after a comma on lines 5 and 6:


Missing trailing whitespace after the comma

Let's fix the problem, and our code should adhere to PEP8 conventions. Recheck the file and the errors would have disappeared. In order to make your code readable, always run a PEP8 check before checking in your code to a public repository.

Summary
In this chapter, we discussed advanced topics in Python. We discussed topics including speech recognition, building a commuter information tool, and a Python client to improve your vocabulary. There are advanced tools in Python that are widely used in the fields of data science, AI, and so on. We hope that the topics discussed in this chapter are the first step in learning such tools.




| ≪ [ 07 Requests and Web Frameworks ](/packtpub/2024/817-Python_with_RaspPi_1ed/07_Requests_and_Web_Frameworks) | 08 Awesome Things You Could Develop Using Python | [ 09 Let's Build a Robot ](/packtpub/2024/817-Python_with_RaspPi_1ed/09_Let_s_Build_a_Robot) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 08 Awesome Things You Could Develop Using Python
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: /packtpub/2024/817-Python_with_RaspPi_1ed/08_Awesome_Things_You_Could_Develop_Using_Python
> Book Jemok: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 16:35:09
> .md Name: 08_awesome_things_you_could_develop_using_python.md

