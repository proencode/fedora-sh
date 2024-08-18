
| ≪ [ 09 Let's Build a Robot ](/packtpub/2024/817-Python_with_RaspPi_1ed/09_Let_s_Build_a_Robot) | 10 Home Automation Using The Raspberry Pi Zero | [ 11 Tips and Tricks ](/packtpub/2024/817-Python_with_RaspPi_1ed/11_Tips_and_Tricks) ≫ |
|:----:|:----:|:----:|

# 10 Home Automation Using The Raspberry Pi Zero
Chapter 10. Home Automation Using the Raspberry Pi Zero
As the title of the chapter suggests, we will discuss home improvement projects involving the Raspberry Pi Zero in this chapter. We selected our projects such that each example could be executed as a weekend project.

The projects include the following topics:

Voice-activated personal assistant
Web framework-based appliance control
Physical activity motivation tool
Smart lawn sprinkler
Voice activated personal assistant
In our first project, we are going to emulate personal assistants such as Google Home (https://madeby.google.com/home/) and Amazon Echo (http://a.co/cQ6zJk6) using a Raspberry Pi Zero. We will build an application where we can add reminders and events to a calendar and controlling appliances.

We will be making use of houndify (houndify.com)—a tool that is designed to provide interactions with smart devices. We will install the requisite software tools on the Raspberry Pi Zero. We will interface a button to the Raspberry Pi Zero's GPIO. We will write some code to create reminders and turn on/off appliances using Houndify.

The following accessories (apart from your Raspberry Pi Zero) are recommended for this project:

Item

Source

Price (in USD)

USB sound card

http://a.co/824dfM8

8.79

Microphone amplifier board with adjustable gain

https://www.adafruit.com/products/1713

7.95

3.5 mm auxiliary cable

https://www.adafruit.com/products/2698

2.50

Momentary push button set

https://www.adafruit.com/products/1009

5.95

Breadboard, resistors, jumper wires, and capacitors

N. A.

N. A.

Speaker (suggestion)

http://a.co/3h9uaTI

14.99

Installing requisite packages
The first step is installing the requisite packages for the project. This includes the following packages: python3-pyaudio python3-numpy. They may be installed as follows:

sudo apt-get update
sudo apt-get install alsa-utils mplayer python3-numpy

Copy

Explain
How does it work?
The following are the steps to be performed:

A push button is interfaced to the Raspberry Pi Zero's GPIO. When the GPIO button is pressed, the recorder is turned on (at the start of a beep sound from the speaker).
The recorder accepts the user request and processes it using the Houndify library.
The assistant processes the audio file using Houndify and responds to the user request.
Note
In this project, we are using a push button to start listening to user requests, whereas commercially available products, such as Amazon's Echo or the Google Home, have special hardware (along with software) to enable this capability. We are using a push button to simplify the problem.

Setting up the audio tools
In this section, we will connect the USB sound card, speaker, and the microphone for the project.

Connecting the speaker
Perform the following steps to connect to speakers:

Connect the USB sound card to your Raspberry Pi Zero and find out if the USB sound card enumerates using the lsusb command (on your Raspberry Pi Zero's command-line terminal):

USB sound card enumeration

Cheap USB sound cards typically have an input terminal (to connect a microphone) and an output terminal (to connect a speaker). Both the terminals are standard 3.5 mm jacks. The input terminal is pink and typically marked with a microphone symbol. The output terminal is green and marked with a speaker symbol.
Connect a speaker to the output terminal (green) of the USB sound card.
On your Raspberry Pi Zero's command-line terminal, list all the audio sources connected to your Raspberry Pi Zero using the following command:
       aplay -l
       **** List of PLAYBACK Hardware Devices ****
       card 0: ALSA [bcm2835 ALSA], device 0: bcm2835 
         ALSA [bcm2835 ALSA]
       Subdevices: 8/8
       Subdevice #0: subdevice #0
       Subdevice #1: subdevice #1
       Subdevice #2: subdevice #2
       Subdevice #3: subdevice #3
       Subdevice #4: subdevice #4
       Subdevice #5: subdevice #5
       Subdevice #6: subdevice #6
       Subdevice #7: subdevice #7
       card 0: ALSA [bcm2835 ALSA], device 1: bcm2835 
         ALSA [bcm2835 IEC958/HDMI]
       Subdevices: 1/1
       Subdevice #0: subdevice #0
       card 1: Set [C-Media USB Headphone Set], 
         device 0: USB Audio [USB Audio]
       Subdevices: 1/1
       Subdevice #0: subdevice #0

Copy

Explain
As shown in the aplay command's output, the sound card is listed as card 1. We need this information to set the USB sound card as the default audio source
Open your sound configuration file from the command line as follows:
       nano ~/.asoundrc

Copy

Explain
Make sure that the configuration file's source is set to card 1 (the soundcard):
       pcm.!default {
               type hw
               card 1
       }

       ctl.!default {
               type hw
               card 1
       }

Copy

Explain
Save the configuration file (by pressing Ctrl + X and press Y to confirm the name of the file. Press Enter to save the file. Refer to Chapter 11, Tips and Tricks chapter for a detailed tutorial) and reboot your Raspberry Pi Zero.

On reboot, test if the speaker works by downloading a wave file (Freesound.org has plenty of wave files). From the command-line terminal, play your file as follows:
       aplay test.wav

Copy

Explain
If everything is configured properly, you should be able to play audio using your USB sound card and speaker. If you are not able to play the audio, check the connections and make sure that your USB sound card is enumerated correctly and you have chosen the right audio source in the configuration file. In the next section, we will set up the microphone.

Connecting the microphone
In this section, we will be setting up an omnidirectional microphone to listen for commands/inputs.

Note
We tested off-the-shelf electret microphones, and the audio quality was not sufficient to perform speech recognition on the recorded audio samples. As an alternative, we recommend boundary microphones for a wide pickup, for example, http://a.co/8YKSy4c.


MAX9814 with omnidirectional microphone Source: Adafruit.com

The gain of the amplifier can be set to three levels: 60 dB when the gain pin is unconnected, 50 dB when the gain pin is connected to ground, and 40 dB when the gain pin is connected to Vdd.
Connect Vdd and the GND pins to the 5V and GND pins of the Raspberry Pi's GPIO pins (,pins 4 and 6 of the Raspberry Pi's GPIO).
 

Cut the 3.5 mm cable into two halves. It consists of three wires connected to the Tip, Ring and Sleeve of the 3.5 mm connector (as shown in the picture here). Use a multimeter to identify the Sleeve, Tip, and Ring wires of the 3.5 mm connector.

Cut the auxiliary cable and identify the three wires of the cable

Connect a 100 mF electrolytic capacitor to the output of the amplifier where the positive lead is connected to the output and the other end is connected to the tip of the 3.5 mm connector. The ground pin of the amplifier is connected to the sleeve of the 3.5 mm connector.

Microphone connections to the 3.5 mm connector

The microphone is ready to use. Power the microphone using the GPIO pins of the Raspberry Pi Zero and plug the 3.5 mm connector into the input terminals of the USB sound card (marked with the microphone symbol).


Microphone connected to 3.5 mm connector

We are ready to test the microphone and set an optimal capture volume. From the Raspberry Pi Zero's command-line terminal, run the following command:

       arecord -f dat -D plughw:2 
         --duration=10~/home/pi/rectest.wav

Copy

Explain
This will record the file for 10 seconds. Play it back using the aplay command:

       aplay rectest.wav

Copy

Explain
You should be able to hear the recorded conversation. Check your connections whether you don't hear anything (GND, 5V, amplifier output pins, and so on. We have also included additional resources for the microphone troubleshooting at the end of this chapter). If the recorded content is too loud or too feeble, adjust the capture volume using alsamixer. Launch alsamixer from the command-line terminal:


alsamixer control panel

Press F5 to view all options. Use the arrow keys to adjust the value and M to disable autogain control. Let's move on to the next section where we build our application.

Houndify
Houndify (www.houndify.com) is a tool that enables adding voice interaction to devices. Their free account enables performing 44 different types of actions. Sign up for an account on their website and activate it (via your e-mail).

Once your account is activated, go to your account dashboard to create a new client:
Note
On creating a new account, a new client is automatically created. This client may not work properly. Delete it and create a new client from the dashboard.


Create new client

Give a name to your application and select the platform to be Home Automation.

Name the application and select the platform

The next step is selecting domains, that is, the nature of applications the assistant must support. Select Weather, Stock Market, Dictionary, and so on.

Enable domains

 

Click on Save & Continue. Once you have created your new client, click on it (from the dashboard) to retrieve the following credentials: Client ID and Client Key.

Copy the Client id and the Client Key from the dashboard

We also need to download the SDK for Python 3.x (latest version available at https://docs.houndify.com/sdks#python):
       wget 
       https://static.houndify.com/sdks/python
       /0.5.0/houndify_python3_sdk_0.5.0.tar.gz

Copy

Explain
Extract the package as follows:
       tar -xvzf houndify_python3_sdk_0.5.0.tar.gzrm 
       houndify_python3_sdk_0.5.0.tar.gz

Copy

Explain
The SDK comes with plenty of examples to get started. Let's consider a scenario where you would like to find out the weather at your current location by interacting with the voice assistant:
Get your current GPS coordinates from a tool such as Google Maps. For example, the GPS coordinates for a specific intersection in San Francisco, California is 37.778724, -122.414778. Let's try to find the weather at this specific location.
 

Open the sample_wave.py file and modify line 39 of the file:
              client.setLocation(37.778724, -37.778724)

Copy

Explain
Save the file and from the command-line terminal, change directories to the Houndify SDK folder:
              cd houndify_python3_sdk_0.5.0/ 
              ./sample_wave.py <client_id> <client_key> 
              test_audio/whatistheweatherthere_nb.wav

Copy

Explain
After processing the request, it should print a detailed response:
              src="//static.midomi.com/corpus/H_Zk82fGHFX/build/js/
              templates.min.js"></script>'}}, 'TemplateName': 
              'VerticalTemplateList', 'AutoListen': False, 
              'WeatherCommandKind': 'ShowWeatherCurrentConditions', 
              'SpokenResponseLong': 'The weather is 45 degrees and
              mostly clear in San Francisco.',

Copy

Explain
We verified the function and setup of the Houndify SDK by testing the example. We uploaded an audio file to the Houndify server requesting the current weather information (play the audio file and find out). The sample_wave.py script takes the client_id, client_key, and the audio file as inputs. It prints out the output from the Houndify server.

Note
You need to enable specific domains to retrieve specific information. For example, we enabled the weather domain to retrieve the weather information. It is also possible to add custom commands to the program.

In the next section, we will modify sample_wave.py to build our application.

Building voice commands
Let's get started with building our voice assistant that we can use to find the weather and turn on/off lights. Because we enabled the weather domain while setting up our Houndify account, we need to add custom commands to turn on/off lights:

On your Houndify dashboard, go to your client's home page. Dashboard | Click on your client.
Locate Custom Commands on the navigation bar to the left. Let's add a custom command each to turn on and turn off the light.
 

Delete ClientMatch #1 that comes as a template with the custom commands.

Locate Custom commands and Delete Client Match #1

Select Add ClientMatch to add a custom command to turn on lights. Populate the fields with the following information:
Expression: ["Turn"].("Lights"). ["ON"]
Result: {"action": "turn_light_on"}
SpokenResponse: Turning Lights On
SpokenResponseLong: Turning your Lights On
WrittenResponse: Turning Lights On
WrittenResponseLong: Turning your Lights On
Repeat the preceding steps to add a command to turn lights off
Test and verify that these commands work using sample_wave.py. Make your own recording for the test. We have also provided audio files along with this chapter's download (available in the folder audio_files).

Let's make a copy of sample_wave.py to build our assistant. We recommend reading through the file and familiarizing yourself with its function. The detailed documentation for the Houndify SDK is available at https://docs.houndify.com/sdks/docs/python:

In the file stream_wav.py, the StreamingHoundClient class is used to send audio queries, such as request for weather information and commands to turn on/off lights.
The MyListener class inherits the HoundListener class (from the houndify SDK).
The MyListener class implements callback functions for three scenarios:
Partial Transcription (the onPartialTranscript method)
Complete Transcription (the onFinalResponse method)
Error State (the onError method)
We need to make use of action intents to turning on/off lights using voice command.
When we implemented the custom commands on the Houndify website, we added an action intent for each command. For example, the action intent for turning on the lights was:
       { 
           "action": "turn_light_on"
       }

Copy

Explain
In order to turn on/off the lights based on the received action intent, we need to import the OutputDevice class from gpiozero:
       from gpiozero import OutputDevice

Copy

Explain
 

 

The GPIO pin that controls the light is initialized in the __init__ method of the MyListener class:
       class MyListener(houndify.HoundListener): 
         def __init__(self): 
           self.light = OutputDevice(3)

Copy

Explain
On completing transcription, if an action intent is received, the lights are either turned on or turned off. It is implemented as follows:
       def onFinalResponse(self, response): 
         if "AllResults" in response: 
           result = response["AllResults"][0] 
           if result['CommandKind'] == "ClientMatchCommand": 
             if result["Result"]["action"] == "turn_light_on": 
               self.light.on() 
             elif result["Result"]["action"] == "turn_light_off": 
               self.light.off()

Copy

Explain
Note
response is a dictionary that consists of the parsed json response. Refer to the SDK documentation and try printing the response yourself to understand its structure.

We also need to announce the voice assistant's action while turning on/off lights. We explored different text-to-speech tools, and they sounded robotic when compared with off-the-shelf products such as the Google Home or Amazon Echo. We came across this script that makes use of the Google Speech-to-Text engine at http://elinux.org/RPi_Text_to_Speech_(Speech_Synthesis).
Note
Because the script makes use of Google's text-to-speech engine, it connects to the Internet to fetch the transcribed audio data.

 

Open a new shell script from the Raspberry Pi's command-line terminal:
              nano speech.sh

Copy

Explain
Paste the following contents:
              #!/bin/bash 
              say() { local IFS=+;/usr/bin/mplayer
              -ao alsa -really-quiet -noconsolecontrols 
              "http://translate.google.com/translate_tts?
              ie=UTF-8&client=tw-ob&q=$*&tl=En-us"; } 
              say $*

Copy

Explain
Make the file executable:
              chmod u+x speech.sh

Copy

Explain
We are going to make use of this script to announce any actions by the assistant. Test it from the command line using the following code:
              ~/speech.sh "Hello, World!"

Copy

Explain
The system calls to announce the voice assistant actions are implemented as follows:
              if result["Result"]["action"] == "turn_light_on": 
                self.light.on() 
                os.system("~/speech.sh Turning Lights On") 
              elif result["Result"]["action"] == "turn_light_off": 
                self.light.off() 
                os.system("~/speech.sh Turning Lights Off")

Copy

Explain
Let's test what we have built so far in this section. The preceding code snippets are available for download along with this chapter as voice_assistant_inital.py. Make it executable as follows:

chmod +x voice_assistant_initial.py

Copy

Explain
Test the program as follows (audio files are also available for download with this chapter):

./voice_assistant.py turn_lights_on.wav

Copy

Explain
 

Adding a button
Let's add a button to our voice assistant. This momentary push button is connected to pin 2 (BCM numbering) and the LED is connected to pin 3.


Voice Assistant interface setup

In order to read the button presses, we need to import the Button class from gpiozero:
       from gpiozero import Button, OutputDevice

Copy

Explain
When a button is pressed, the voice assistant needs to play a beep sound indicating that it is awaiting the user's command. Beep sounds of your choice can be downloaded from www.freesound.org.
 

Following the beep sound, the user command is recorded for a duration of 5 seconds. The recorded file is then processed using the Houndify SDK. The following code snippet shows the trigger function that is called when the button is pressed:
       def trigger_function(): 
         os.system("aplay -D plughw:1,0 /home/pi/beep.wav") 
         os.system("arecord -D plughw:2,0 -f S16_LE -d 5 
         /home/pi/query.wav") 
         os.system("aplay -D plughw:1,0 /home/pi/beep.wav") 
         call_houndify()

Copy

Explain
The trigger function is registered as follows:
       button = Button(4) 
       button.when_released = trigger_function

Copy

Explain
Connect the button and the LED to the Raspberry Pi's GPIO interface to test the voice assistant.


Voice assistant setup

The voice assistant code file is available for download along with this chapter as voice_assistant.py. Download the code sample and try the following commands:

What is the weather in San Francisco?What is the weather in Santa Clara, California?Turn Lights OnTurn Lights Off

Copy

Explain
We have shared a video (on this book's site) that demonstrates the function of the voice assistant. Now, we have demonstrated the voice assistant using an LED. In order to control a table lamp, simply replace the LED with a power switch tail II (http://www.powerswitchtail.com/Pages/default.aspx).


Things to keep in mind:

Add voice_assistant.py to /etc/rc.local so that it starts automatically on boot.
The entire setup can be unwieldy. Assemble the components inside an enclosure to organize the wiring.
Because the project involves electrical appliances, use prescribed cables and terminate them properly. Ensure that the cables are connected properly. We will share examples of the same on our website.
Project ideas and enhancements:

Currently, the assistant works only at the press of a button. How will you make it listen for a keyword? For example, "Ok, Google" or "Alexa"?
Is it possible to have a remote trigger? Think something on the lines of Amazon Tap.
If you have lights such as Philips Hue or Internet-connected switches such as WeMo switch smartplug or the TP-Link Smart switch, you can control them using a voice assistant. IFTTT provides applets to control them yourself. Create a maker channel web hook to control them. Refer to Chapter 8 for examples.
Web framework based appliance control/dashboard
In this section, we will review building a dashboard in order to control appliances. This could be a dashboard for the aquarium where you would like to monitor all the requisite parameters for the tank or a dashboard for the garden where you can control the flow control valves for your garden based on information from the sensors. We will demonstrate this with a simple example and show how you can use it to meet your requirements.

We will make use of the flask framework to build our dashboard. If you haven't installed the flask framework (from the previous chapters), you can install it as follows:

sudo pip3 install flask

Copy

Explain
If you are not familiar with the flask framework, we have written up some basics and getting started in Chapter 7, Requests and Web Frameworks. We are going to discuss controlling the relay board (shown in the picture here) from a web dashboard (available at http://a.co/1qE0I3U).


Relay module

The relay board consists of eight relays that could be used to control eight devices. The relays are rated for 10A, 125V AC and 10A, 28V DC.

Note
It is important to follow safety regulations while trying to control AC appliances using a relay board. If you are a beginner in electronics, we recommend using the unit, http://a.co/9WJtANZ. It comes with the requisite circuitry and protections (shown in the following figure). Safety first!


Enclosed high power relay for Raspberry Pi

Each relay on the 8-relay board consists of the following components: an optocoupler, transistor, relay, and a freewheeling diode (shown in the schematic here):


Schematic of one relay on 8-relay board (generated using fritzing)

Note
The schematic is used to explain the function of the relay board; hence, it is not accurate. It is missing some discrete components.

The relay board requires a 5V power supply (through the Vcc pin):

Vcc, GND and GPIO pins

Each relay on the relay board is controlled by pins IN1 through IN8. Each pin is connected to an optocoupler (optoisolator-U1 in the schematic). The function of the isolator is to separate the Raspberry Pi from high voltages connected to the relay. It protects from any transient voltages while switching the relays (we have provided additional resources at the end of this chapter to better understand optocouplers).
The phototransistor of the optocoupler is connected to the base of an NPN transistor. The NPN transistor's collector pin is connected to a relay, whereas the emitter is connected to the ground.
The relay is driven by an active-low signal that is when a 0V signal is given to one of the pins, IN1 through IN8. The phototransistor (of the optocoupler) sends a high signal to the base of the transistor. Here, the transistor acts as a switch. It closes the circuit and thus energizes the relay. This is basically the transistor switching circuit that we discussed in an earlier chapter except for an additional component, the optocoupler. An LED lights up indicating that the relay is energized.

The components of each relay circuit (labeled)

 

Note
We strongly recommend reading about optocouplers to understand their need and how an active-low signal to this relay board drives the relays.

Across each relay, there is a flywheel diode. A flywheel diode protects the circuit from any inductive kickback voltages of the relay when the relay is de-energized/turned off. (We have included a reading resource on relays and inductive kickbacks at the end of this chapter.)
Each relay has three terminals, namely the common terminal, normally open terminal, and the normally closed terminal. When an active-low signal is used to drive one of the relays, the common terminal comes into contact with the normally open terminal. When the relay is de-energized, the common terminal comes into contact with the normally closed terminal. Hence, the terminals have the name, normally open and normally closed (The terminals are highlighted with the labels N.O., C, and N.C. in the picture here).

The terminals of a relay

The device that needs to be controlled using the web dashboard needs to be connected to the relay terminals, as shown in the schematic given later. For example, let's consider a device that is powered using a 12V adapter. The device's needs to be rigged such that the positive terminal of the power jack is connected to the common terminal of the relay. The normally open terminal is connected to the device's positive line. The device's ground is left untouched. Keep the power adapter plugged in, and the device shouldn't turn on as long as the relay is not energized. Let's review controlling this device using a web dashboard.

Schematic to rig a 12V DC appliance with a relay

Note
For an AC power appliance, we recommend using the power switch tail II or the AC relay unit discussed earlier in this section. They are safe for hobby grade applications.

 

Building the web dashboard
The first step is creating the html template for the dashboard. Our dashboard is going to enable controlling four appliances, that is, turn them on or off:

In our dashboard, we need an htmltable where each row on the table represents a device, as follows:
       <table> 
           <tr> 
               <td> 
                   <input type="checkbox" name="relay" 
                    value="relay_0">Motor</input> </br> 
               </td> 
           <td> 
               <input type="radio" name="state_0" value="On">On
               </input> 
                   <input type="radio" name="state_0" value="Off" 
                   checked="checked">Off</input>
           </td> 
       </table>

Copy

Explain
In the preceding code snippet, each device state is encapsulated in a data cell <td>, each device is represented by a checkbox, and the device state is represented by an on/off radio button. For example, a motor is represented as follows:
       <td> 
          <input type="checkbox" name="relay" 
          value="relay_0">Motor</input> </br> 
       </td> 
       <td> 
          <input type="radio" name="state_0" value="On">On
          </input> 
           <input type="radio" name="state_0" value="Off" 
           checked="checked">Off</input>   
       </td>

Copy

Explain
 

On the dashboard, this would be represented as follows:


Device represented by a checkbox and radio button

The table is encapsulated in an html form:
       <form action="/energize" method="POST"> 
          <table> 
          . 
          . 
          . 
          </table> 
       </form>

Copy

Explain
The device states are submitted to the flask server when the user hits the energize button:
       <input type="submit" value="Energize" class="button">

Copy

Explain

Energize button

On the server side, we need to set up the GPIO pins used to control the relays:
       NUM_APPLIANCES = 4 

       relay_index = [2, 3, 4, 14]

Copy

Explain
The list relay_index represents the GPIO pins being used to control the relays.
Before starting the server, we need to create an OutputDevice object (from the gpiozero module) for all the devices:
       for i in range(NUM_APPLIANCES): 
               devices.append(OutputDevice(relay_index[i], 
                                      active_high=False))

Copy

Explain
The OutputDevice object meant for each device/relay is initialized and added to the devices list.
When the form is submitted (by hitting the energize button), the POST request is handled by the energize() method.
We are controlling four devices that are represented by relay_x, and their corresponding states are represented by state_x, that is, On or Off. The default state is Off.
When a form is submitted by the user, we determine if the POST request contains information related to each device. If a specific device needs to be turned on/off, we call the on()/off() method of that device's object:
       relays = request.form.getlist("relay") 
       for idx in range(0, NUM_APPLIANCES): 
           device_name = "relay_" + str(idx) 
           if device_name in relays: 
               device_state = "state_" + str(idx) 
               state = request.form.get(device_state) 
               print(state) 
               if state == "On": 
                   print(state) 
                   devices[idx].on() 
               elif state == "Off": 
                   print(state) 
                   devices[idx].off()

Copy

Explain
In the preceding code snippet, we fetch information related to all relays as a list:
       relays = request.form.getlist("relay")

Copy

Explain
In the form, each device is represented by a value relay_x (relay_0 through relay_3). A for loop is used to determine a specific relay is turned on/off. The state of each device is represented by the value state_x where x corresponds to the device (from 0 through 3).
The GPIO pins used in this example are connected to the relay board pins, IN1 through IN4. The relay board is powered by the Raspberry Pi's GPIO power supply. Alternatively, you may power it using an external power supply. (You still need to connect the ground pin of the Raspberry Pi Zero to the relay board.)
The earlier-mentioned dashboard is available along with this chapter under the subfolder flask_framework_appliance (including the flask server, html files, and so on.). In the following snapshot, the Motor and Tank Light 2 are checked and set to On. In the picturehere, the first and the third relay are energized.

Turning on Motor and Tank Light 2


Relays 1 and 3 energized

Exercise for the reader:

In this section, we made use of a POST request to control devices. How would you make use of a GET request to display room temperature from a temperature sensor?

Project ideas/enhancements:

With some basic web design skills, you should be able to build a dashboard with better aesthetic appeal.
Keep in mind that a dashboard should provide as detailed information as possible. Determine how data visualization tools could enhance your dashboard.
Consider replacing the checkbox and radio buttons with a sliding toggle switch (the type used in mobile applications).
You can build a dashboard for switching holiday light sequences from your local browser. Think of ways to compete with your neighbours during the holidays.
You can permanently install the relay board and the Raspberry Pi Zero in a weather proof enclosure as given at http://www.mcmelectronics.com/product/21-14635. Check out this book's website for some examples.
Personal Health Improvement—Sitting is the new smoking
Note
This project makes use of specific accessories. You are welcome to substitute it with alternatives.

So far, we have discussed projects that could be an enhancement around your living environment. In this section, we are going to write some Python code on the Raspberry Pi Zero and build a tool that helps improving your personal help.

According to the World Health Organization, physical activity of 150 minutes in a week can help you stay healthy. Recent studies have found that walking 10,000 steps in a day can help avoid life style diseases. We have been making use of pedometers to keep track of our daily physical activity. It is difficult to maintain consistency in physical activity as we tend to ignore our personal health over daily commitments. For example, in the physical activity timeline shown here, you will note that all the physical activity is concentrated toward the end of the day.


Physical activity in a day (data fetched from a commercially available pedometer)

We are going to build a visual aid that would remind us to stay physically active. We believe that this tool should help put your personal fitness tracker to good use. The following are the recommended accessories for this project:

Pedometer: The cost of pedometers vary anywhere from $20-$100. We recommend getting a tracker from Fitbit since it comes with extensive developer resources. It is not required to have a tracker. We are going to demonstrate this visual aid using a Fitbit One (http://a.co/8xyNSmg) and suggest alternatives at the end.
Pimoroni Blinkt (optional): This is an LED strip (https://www.adafruit.com/product/3195) that can be stacked on top of your Raspberry Pi Zero's GPIO pins (shown in the picture here).

Pimoroni Blinkt

Pimoroni Rainbow HAT (optional https://www.adafruit.com/products/3354): This is an add-on hardware designed for the Android Things platform on the Raspberry Pi. It comes with LEDs, 14-segment displays, and a buzzer. It can come handy for the project.

Rainbow HAT for android things

Alternatively, you may add LED strips and components to this visual aid using your creativity.
Installing requisite software packages
The first step is installing the requisite packages. Because we are going to make use of the Fitbit tracker, we need to install the fitbit python client:

sudo pip3 install fitbit cherrypy schedule

Copy

Explain
If you are going to make use of the Pimoroni Blinkt LED strip, you should install the following package:

sudo apt-get install python3-blinkt

Copy

Explain
If you are going to be making use of the rainbow HAT, the following package needs to be installed:

curl -sS https://get.pimoroni.com/rainbowhat | bash

Copy

Explain
Getting access keys for Fitbit client
We need access keys to make use of the Fitbit API. There is a script available from the fitbit python client repository at https://github.com/orcasgit/python-fitbit.

Note
The access keys can also be obtained from the command-line terminal of a Linux or Mac OS laptop.

Create a new app at https://dev.fitbit.com/apps:

Register a new app at dev.fitbit.com

While registering a new application, fill in the description including the name of your application and give a temporary description, organization, website, and so on, and set the OAuth 2.0 Application Type to Personal and access type to Read-Only. Set the callback URL to http://127.0.0.1:8080.

Set callback URL

 

Once your application is created, copy the Client ID and Client Secret from application's dashboard.

Note down the client_id and client secret

From the Raspberry Pi's command-line terminal, download the following script:
       wget https://raw.githubusercontent.com/orcasgit/
       python-fitbit/master/gather_keys_oauth2.py

Copy

Explain
Note
The next step needs to be executed by opening the command-line terminal from your Raspberry Pi Zero's desktop (not via remote access).

Execute the script by passing the client id and client secret as arguments:
       python3 gather_keys_oauth2.py <client_id> <client_secret>

Copy

Explain
It should launch a browser on your Raspberry Pi Zero's desktop and direct you to a page on https://www.fitbit.com/home requesting your authorization to access your information.

Authorize access to your data

If the authorization was successful, it should redirect you to a page where the following information is displayed:

Authorization to access the Fitbit API

 

Close the browser and copy the refresh_token and access_token information displayed on the command prompt.

Copy access_token and refresh_token

We are ready to use the Fitbit API! Let's test it out!

Fitbit API Test
The documentation for the Fitbit API is available at http://python-fitbit.readthedocs.org/.Let's write a simple example to get today's physical activity:

The first step is import the fitbit module:
       import fitbit

Copy

Explain
We have to initialize the fitbit client using the client key, client secret, access_token, and refresh_token earlier in this section:
       fbit_client = fitbit.Fitbit(CONSUMER_KEY, 
                                   CONSUMER_SECRET, 
                                   access_token=ACCESS_TOKEN, 
                                       refresh_token=REFRESH_TOKEN)

Copy

Explain
According to the Fitbit API documentation, the current day's physical activity can be retrieved using the intraday_time_series() method.
The required arguments to retrieve the physical activity include the resource that needs to be retrieved; that is, steps, detail_level, that is, the smallest time interval for which the given information needs to be retrieved, start times and the end times.
 

The start time is 12:00 a.m. of the current day, and the end time is the current time. We will be making use of the datetime module to get the current time. There is a function named strftime that gives us the current time in the hour:minute format.
Note
Make sure that your Raspberry Pi Zero's OS time is correctly configured with the local time zone settings.

       now = datetime.datetime.now() 
       end_time = now.strftime("%H:%M") 
       response = fbit_client.intraday_time_series('activities/steps', 
         detail_level='15min', 
         start_time="00:00", 
         end_time=end_time)

Copy

Explain
The fitbit client returns a dictionary containing the current day's physical activity and intraday activity in 15-minute intervals:
       print(response['activities-steps'][0]['value'])

Copy

Explain
This example is available for download along with this chapter as fitbit_client.py. If you have a Fitbit tracker, register an application and test this example for yourself.
Building the visual aid
Let's build a visual aid where we display the number of steps taken in a given day using an LED strip. The LED strip would light up like a progress bar based on the daily physical activity.

The first step is importing the requisite libraries while building the visual aid. This includes the fitbit and blinkt libraries. We will also import some additional libraries:
       import blinkt 
       import datetime 
       import fitbit 
       import time 
       import schedule

Copy

Explain
 

Make sure that you have the requisite tokens discussed earlier in this section:
       CONSUMER_KEY = "INSERT_KEY" 
       CONSUMER_SECRET = "INSERT_SECRET" 
       ACCESS_TOKEN = "INSER_TOKEN" 
       REFRESH_TOKEN = "INSERT_TOKEN"

Copy

Explain
A new refresh token is needed every 8 hours. This is a feature of the API's authorization mechanism. Hence, we need a function that gets a new token using the existing token:
       def refresh_token(): 
           global REFRESH_TOKEN 
           oauth = fitbit.FitbitOauth2Client(client_id=CONSUMER_KEY, 
             client_secret=CONSUMER_SECRET, 
             refresh_token=REFRESH_TOKEN, 
             access_token=ACCESS_TOKEN) 
           REFRESH_TOKEN = oauth.refresh_token()

Copy

Explain
In the function refresh_token(), we are making use of the FitbitOauth2Client class to refresh the token. It is important to note that we have made use of the global keyword. The global keyword helps with modifying the REFRESH_TOKEN and enables the use of the new token in other parts of the program. Without the global keyword, the changes made to any variable is restricted to the refresh_token() function.
Note
In general, it is a bad practice to make use of the global keyword. Use it with your best judgement.

Next, we need a function to retrieve steps using the Fitbit class. We are going to use the same procedure as the previous example. Initialize the fitbit class and retrieve the steps using intraday_time_series:
       def get_steps(): 
           num_steps = 0 
           client = fitbit.Fitbit(CONSUMER_KEY, 
                                  CONSUMER_SECRET, 
                                  access_token=ACCESS_TOKEN, 
                                  refresh_token=REFRESH_TOKEN) 
           try: 
               now = datetime.datetime.now() 
               end_time = now.strftime("%H:%M") 
               response = 
                client.intraday_time_series('activities/steps', 
                  detail_level='15min', 
                  start_time="00:00", 
                  end_time=end_time) 
           except Exception as error: 
               print(error) 
           else: 
               str_steps = response['activities-steps'][0]['value'] 
               print(str_steps) 
               try: 
                   num_steps = int(str_steps) 
               except ValueError: 
                   pass 
           return num_steps

Copy

Explain
In the main function, we schedule a timer that refreshes the token every 8 hours using the schedule library (https://pypi.python.org/pypi/schedule):
       schedule.every(8).hours.do(refresh_token)

Copy

Explain
We check for the steps every 15 minutes and light up the LEDs accordingly. Because the Pimoroni Blinkt consists of eight LEDs, we can light up one LED for every 1250 steps of physical activity:
       # update steps every 15 minutes 
       if (time.time() - current_time) > 900: 
           current_time  = time.time() 
           steps = get_steps() 

       num_leds = steps // 1250 

       if num_leds > 8: 
           num_leds = 8 

       for i in range(num_leds): 
           blinkt.set_pixel(i, 0, 255, 0) 

       if num_leds <= 7:  
           blinkt.set_pixel(num_leds, 255, 0, 0) 
           blinkt.show() 
           time.sleep(1) 
           blinkt.set_pixel(num_leds, 0, 0, 0) 
           blinkt.show() 
           time.sleep(1)

Copy

Explain
 

For every multiple of 1250 steps, we set an LED's color to green using the blinkt.set_pixel() method. We set the next LED to a blinking red. For example, at the time of writing this section, the total number of steps was 1604. This is (1250 x1) + 354 steps. Hence, we light up one LED in green and the next LED blinks red. This indicates that the steps are in progress.
The picture here shows the blinking red LED when the progress was less than 1250 steps:

Physical activity progress less than 1250 steps

After walking around, the progress shifted to the right by one LED:

Physical activity at 1604 steps

 

The next step is to set off a buzzer when there is no minimum physical activity. This is achieved by connecting a buzzer to the GPIO pins of the Raspberry Pi Zero. We have demonstrated the use of a buzzer in an earlier chapter.
The earlier example is available for download along with this chapter as visual_aid.py. We will let you figure out the logic to set off a buzzer when there is no minimum physical activity in a period (for example, an hour).
Install this visual aid somewhere prominent and find out if it motivates you to stay physically active! If you make use of the Pimoroni Rainbow HAT, you can display the steps using the 14-segment display.

Smart lawn sprinkler
In drought-struck states like California, United States, there are severe restrictions on water usage in certain parts of the state. For example: In summer, some cities passed an ordinance restricting water usage to 250 gallons per day. In such states, it is ridiculous to find lawn sprinklers going off the day before the rain. We are going to build a lawn sprinkler controller that only turns on when there is no rain predicted for the next day.

In order to build a smart lawn sprinkler, we need a flow control solenoid valve (for example, https://www.sparkfun.com/products/10456). Make sure that the valve can meet the water pressure requirements. This flow control valve can be interfaced to the Raspberry Pi Zero using a transistor switching circuit discussed in earlier chapters or the relay board we discussed earlier in this chapter.

We will be making use of DarkSky API (https://darksky.net) to fetch the weather information. It provides a simple response format that could be used to determine if it was going to rain the next day.
Sign up for a free account at the website and get a developer key from the console.
According to the API documentation, the local weather information may be obtained as follows:
       https://api.darksky.net/forecast/[key]/[latitude],[longitude]

Copy

Explain
The latitude and longitudinal coordinates can be obtained using a simple web search. For example, the request URL for Newark, CA is:
       URL = ("https://api.darksky.net/forecast/key" 
       "/37.8267,-122.4233?exclude=currently,minutely,hourly")

Copy

Explain
The response includes the current, minutely, and hourly forecasts. They can be excluded using the exclude parameter as shown in the preceding URL.
Now, we need to turn on the sprinkler only if it is not going to rain the next day. According to the API documentation, the weather forecast is returned as a Data Point object. The data points include a field named icon that indicates whether it is going to be clear, cloudy, or rainy.
Let's write a method check_weather() that fetches the weather for the week:
       def check_weather(): 
          try: 
                response = requests.get(URL) 
          except Exception as error: 
                print(error) 
          else: 
                if response.status_code == 200: 
                      data = response.json() 
                      if data["daily"]["data"][1]["icon"] == "rain": 
                            return True 
                      else: 
                            return False

Copy

Explain
If the GET request was successful, which can be determined by the status code of the response, the json response is decoded using the json() method.
The next day's weather information is available at data["daily"]["data"][1] (Print the response and verify it for yourself).
Since the icon key provides a machine-readable response, it could be used to turn on the sprinkler. Hence, the check_weather() returns True if it is going to rain and vice versa.
We will let you figure out interfacing the solenoid valve using the GPIO pins. The earlier code sample is available for download along with this chapter as lawn_sprinkler.py.

Exercise for the reader:

We are making use of the next day's weather information to turn on the sprinkler. Go through the documentation and modify the code to account for current weather information.

Project enhancements:

How would you go about adding a moisture sensor to the controller?
How would you interface the sensor to the Raspberry Pi Zero and make use of it in turn on the sprinkler?
Summary
In this chapter, we reviewed four projects involving the Raspberry Pi Zero (and Python programming) that focused on specific improvements around the house. This includes a voice assistant, web framework-based appliance control, physical activity motivation tool, and a smart lawn sprinkler. The idea behind these projects were to demonstrate the applications of python programming in improving our quality of life. We could demonstrate that it is possible to build applications (using the Raspberry Pi Zero) that can serve as a better alternative to expensive off-the-shelf products.

We also recommend the following project ideas for your consideration:

Slack channel-based appliance control: Are you concerned about the temperature conditions back home for your pets while you are away at work? How about setting up a temperature sensor to send a slack channel alert suggesting that you turn on the air conditioner?
Tabletop fountain: Using a Raspberry Pi Zero and an RGB LED strip, you can create lighting effects for a tabletop fountain.
Bird feeder monitor: This is something we have been working on for a while now. We are trying to track birds that come to feed in a backyard feeder. The bird feeder is equipped with a Raspberry Pi Zero and a camera. Stay tuned to this book's website for some updates.
Holiday lights controller: How about some special light and audio effects during the holidays?
Controlling off-the-shelf products using Raspberry Pi Zero: Do you have a lot of Wi-Fi-enabled electrical outlets lying around unused? Why not try to control them using your Raspberry Pi Zero (hint: IFTTT).
Pomodoro timer: Have you heard of the Pomodoro technique for productivity? How about an interactive device to improve your productivity?
Note
Learning Resources

Setting USB Soundcard as the default audio source: http://raspberrypi.stackexchange.com/a/44825/1470
arecord/aplay options: http://quicktoots.linux-audio.com/toots/quick-toot-arecord_and_rtmix-1.html
MAX9814 setup tutorial: https://learn.adafruit.com/adafruit-agc-electret-microphone-amplifier-max9814/wiring-and-test
Understanding optocouplers: https://www.elprocus.com/opto-couplers-types-applications/
Relays and kickback voltages: http://www.coilgun.info/theoryinductors/inductivekickback.htm



| ≪ [ 09 Let's Build a Robot ](/packtpub/2024/817-Python_with_RaspPi_1ed/09_Let_s_Build_a_Robot) | 10 Home Automation Using The Raspberry Pi Zero | [ 11 Tips and Tricks ](/packtpub/2024/817-Python_with_RaspPi_1ed/11_Tips_and_Tricks) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 10 Home Automation Using The Raspberry Pi Zero
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: /packtpub/2024/817-Python_with_RaspPi_1ed/10_Home_Automation_Using_The_Raspberry_Pi_Zero
> Book Jemok: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 16:35:09
> .md Name: 10_home_automation_using_the_raspberry_pi_zero.md
