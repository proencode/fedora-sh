
| ≪ [ 10 Home Automation Using The Raspberry Pi Zero ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/10_Home_Automation_Using_The_Raspberry_Pi_Zero) | 11 Tips and Tricks | 817 Python Programming with Raspberry Pi 1ed 🔔 |
|:----:|:----:|:----:|

# 11 Tips and Tricks
Chapter 11. Tips and Tricks
We have discussed different concepts of Python programming and the applications you could develop in Python using the Raspberry Pi Zero as a platform. Before we call it a day, we would like to present some tips and tricks that could be useful to you. We will also discuss topics that we promised to discuss in this chapter.

Change your Raspberry Pi's password
As you develop applications, you will gravitate toward buying more than one Raspberry Pi Zero boards. As soon as you finish setting up the micro SD card and power up the board, change the default password for your Raspbian login. Default passwords on connected devices wreaked havoc during Mirai botnet attacks of 2016 (https://blogs.akamai.com/2016/10/620-gbps-attack-post-mortem.html). Considering the magnitude of the attacks, the Raspberry Pi foundation released a new OS update (https://www.raspberrypi.org/blog/a-security-update-for-raspbian-pixel/) that disables SSH access to the Raspberry Pi by default. You can change the password in the following two ways:

Change it from the desktop. Go to Menu | Preferences | Raspberry Pi Configuration. Under the System tab, select Change Password.
Launch the command-line terminal and enter passwd at the prompt. It will prompt you for the current password of the Raspberry Pi desktop followed by the new password.
Updating your OS
From time to time, there might be relevant security updates for the Raspbian OS. Subscribe to updates from the Raspberry Pi foundation's blog to keep yourself informed of such alerts. Whenever there is an update for your OS, it could be updated from the Command Prompt as follows:

sudo apt-get update
    sudo apt-get dist-upgrade

Copy

Explain
Note
Sometimes, OS updates can break the stability of some interface drivers. Proceed with caution and check relevant forums for any reports of problems.

Setting up your development environment
Let's discuss setting up your development environment in order to work on your Raspberry Pi Zero:

SSH access to the Raspberry Pi is disabled by default. Launch Raspberry Pi configuration from your desktop. On the top-left corner, Go to Menu | Preferences | Raspberry Pi Configuration:

Launch Raspberry Pi configuration

Under the Interfaces tab of the Raspberry Pi configuration, enable SSH and VNC and click on OK to save changes.

Enable SSH and VNC

Launch the Raspberry Pi's Command Prompt and type the following command: ifconfig. If you connected your Raspberry Pi Zero to the network using a Wi-Fi adapter, locate the IP address of your Raspberry Pi Zero under wlan0, as shown in the following screenshot. In this case, the IP address is 192.168.86.111:

IP address of the Raspberry Pi Zero

You can also find the IP address by hovering over the Wi-Fi symbol on the top-right corner.
Note
The IP address information may not be useful if your network is behind a firewall. For example, public wireless networks, such as a coffee shop, have firewalls.

Now that the Raspberry Pi Zero is set up for SSH access, let's try to gain access to the Raspberry Pi remotely.

SSH access via Windows
If you have a Windows laptop, download PuTTY client from (http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). Launch putty.exe.

Launch putty.exe

Enter the IP address of your Raspberry Pi Zero in the highlighted area and click on Open.
Select Yes if a prompt (like the one shown in the following screenshot) shows up to save the settings:

Select Yes

Log in as pi and enter your Raspberry Pi's password:

Log in as pi

You have now gained remote access of your Raspberry Pi. Try executing the commands on your desktop.

Play with the remote desktop

If the PuTTY SSH session disconnects for some reason, right-click and select Restart Session.

Restart a session with a right-click

SSH access via Linux/macOS
Perform the following steps for SSH access via Linux/macOS:

On a macOS, you can launch the Terminal as follows: Press command + spacebar and launch the search tool. Enter Terminal and click on the first option to launch a new Terminal window.

Launch Terminal

On the Terminal, log in to your Raspberry Pi using the ssh command:
       ssh pi@192.168.86.111 -p 22

Copy

Explain
 

Enter the password of your Raspberry Pi when prompted and gain remote access to your Raspberry Pi.

Remote access via macOS terminal

On an Ubuntu desktop, a Terminal can be launched using the shortcut Ctrl + Alt + T on the keyboard. SSH access is similar to that of macOS.

An SSH access via Ubuntu

Transferring files to/from your Pi
While writing code for your project, it would be easier to write the code on a laptop and transfer the files to the Raspberry Pi to test it remotely. This is helpful, especially while remote access is necessary (for example, the robot in Chapter 9, Let's build a robot!).

WinSCP
On a Windows machine, WinSCP (https://winscp.net/eng/index.php) could be used for files transfers in both directions. Download the software and install it on your laptop.
Launch WinSCP and enter the IP address, username, and password of the Raspberry Pi Zero in the window. Under the File protocol: drop-down menu, choose SFTP or SCP.

Enter the IP address, username, and password

Click on Yes when the software prompts whether it is a trusted host:

Click on Yes on this warning

If the credentials are correct, the software should provide the remote access of the Raspberry Pi Zero's filesystem. In order to download files or upload files, just right-click and choose the upload/download option (shown in the following screenshot):

Upload/download files with a right-click

Mac/Linux environment
In a Mac/Linux OS environment, the scp command could be used to transfer files to/from Raspberry Pi. For example, a file could transferred to the Raspberry Pi using the following syntax:

scp <filename> pi@<IP address>:<destination>
       scp my_file pi@192.168.1.2:/home/pi/Documents

Copy

Explain
A file could be transferred from the Raspberry Pi as follows:

scp pi@<IP address>:<file location> <local destination>
       scp pi@192.168.1.2:/home/pi/Documents/myfile Documents

Copy

Explain
Git
Git is a version control tool that can be helpful while developing applications. It also enables sharing code samples with others. For example, this book's latest code samples are all checked into https://github.com/sai-y/pywpi.git. Since git enables version control, it is possible to save copies of the code at different stages of the project. It is also possible to revert to a known working version if there are problems in the code.

While writing this book, we wrote our code using text editors, such as Notepad++ and Sublime Text editor. and saved them to our repositories on github. On the Raspberry Pi side, we made a copy of the repository from github and tested our code. Git also enables creating branches, which is a cloned image of the code repository. Git branches enable working on a new feature or fix an existing problem without breaking the working version of the code. Once the feature has been implemented or a problem is fixed, we can merge the changes with the main branch of the repository. We recommend finishing this tutorial to understand the importance of Git, so refer to https://guides.github.com/activities/hello-world/.

Command-line text editors
From time to time, there might be a need to make minor changes to code files or change configuration files from the command line. It is impractical to use a graphical text editor every time. There are command-line text editors that can come handy with some practice.

One useful text editor that comes with the Raspbian OS is nano. nano is a very simple text editor, and it is very easy to use. For example, let's consider a scenario where we would like to add a secret key for an API in your code file. This could be accomplished by opening the file via the Command Prompt (SSH or the command-line terminal from the desktop):

nano visual_aid.py

Copy

Explain
It should open the contents of the file, as shown in the following screenshot:


nano text editor

Navigate to the line that needs editing using the keyboard's arrow keys. The line could be edited manually, or the secret key could be pasted into the file (CMD + V on Mac, Ctrl + Shift + V on Ubuntu Terminal and simply right-click on PuTTY).
Once the file editing is complete, press Ctrl + X to finish editing and Press Y to save the changes:

Save changes

Press Enter at the next prompt to save the contents to the file.

Save contents to the original file

Learning to use command-line text editors can come handy while working on projects.

Note
There are other text editors such as vi and vim. However, nano text editor is much simpler to use.

 

Graphical text editors
Apart from IDLE's graphical text editor, there are many other text editors out there. On Windows, we recommend using Notepad++ (https://notepad-plus-plus.org/). It comes with a lot of plugins and features that distinguish Python keywords from other parts of the code. It also provides visual aid to indent your code properly.


Notepad++ editor

While Notepad++ is free, there is a cross-platform (there is a version for Windows, Ubuntu, and Mac) text editor named Sublime (https://www.sublimetext.com/) that comes with an evaluation license, but the license costs USD 70. We believe that it is worth the cost because it comes with a rich development environment.


Sublime text editor

SSH aliases (on Mac/Linux Terminals)
While working on a project, SSH aliases can come handy for the remote access of the Raspberry Pi. An alias is a shortcut for any command. For example, an alias for SSH login can be implemented as follows:

nano ~/.bash_aliases

Copy

Explain
Add the following line to the file (make sure that the IP address of the Raspberry Pi is added):

alias my_pi='ssh pi@192.168.1.2 -p 2' 

Copy

Explain
Load the alias file:

source ~/.bash_aliases

Copy

Explain
Now, we can access the pi simply by calling my_pi into the Command Prompt. Try it for yourself!

Saving SSH sessions on PuTTY
In a Windows environment, it is possible to save SSH sessions for repeated usage. Launch Putty, enter the IP address of the Raspberry Pi, and save it with a session name, as shown in the following screenshot:


Save session

 

Whenever the SSH access to the Raspberry Pi is needed, launch PuTTY and load my_session (shown in the following screenshot):


Load session

VNC access to Raspberry Pi
While enabling SSH, we also enabled VNC. VNC is a tool that enables remote viewing of the Raspberry Pi desktop. Because VNC is already enabled on the Raspberry Pi, download and install VNC viewer (https://www.realvnc.com/download/viewer/). VNC viewer is available for all operating systems:

Log in is very simple. Just enter the Raspberry Pi's username and password:

Login

It should take you directly to the Raspberry Pi's desktop.

Raspberry Pi desktop via VNC

SSH via USB OTG port
Note
This trick is meant for advanced users only.

We came across this nifty trick at https://gist.github.com/gbaman/975e2db164b3ca2b51ae11e45e8fd40a. This is helpful when you do not have a USB Wi-Fi adapter and a USB OTG converter. We can connect the Raspberry Pi's USB-OTG port directly to the USB port of a computer (using a micro-USB cable) and access it via SSH. This is enabled due to the fact that the USB OTG port of the Raspberry Pi Zero enumerates as a USB-over-Ethernet device when connected to a computer:

Once the micro SD card is flashed with the Raspbian Jessie OS, open the SD card's contents and locate the file config.txt.
At the end of the file, config.txt, add the following line to the file: dtoverlay=dwc2.
In the file, cmdline.txt, add modules-load=dwc2,g_ether after rootwait. Make sure that each parameter of this file is separated by a single space.
Save the file and insert the SD card into your Raspberry Pi Zero.
On a command-line terminal, log in using ssh pi@raspberrypi.local. This should work on Mac/Ubuntu environment. In a Windows environment, Bonjour protocol drivers are necessary (https://support.apple.com/kb/DL999?locale=en_US). In addition, RNDIS Ethernet drivers are also necessary (http://developer.toradex.com/knowledge-base/how-to-install-microsoft-rndis-driver-for-windows-7).
The RUN switch of the Raspberry Pi Zero board
The Raspberry Pi Zero has a terminal marked RUN with two pins. This terminal could be used to reset the Raspberry Pi Zero. This is especially if the Raspberry Pi Zero is installed some place inaccessible. The Raspberry Pi Zero can be reset by connecting a momentary push button across the two pins. Because a momentary contact is sufficient to reset the board, this terminal can be useful where the Raspberry Pi Zero is installed at a very distant location, and it could reset using an Internet connection (provided that there is another device that controls the RUN terminal pins).


The location of the Run Pins on the Raspberry Pi Zero

Note
We also found this excellent tutorial to set up a reset switch for the Raspberry Pi - https://blog.adafruit.com/2014/10/10/making-a-reset-switch-for-your-raspberry-pi-model-b-run-pads-piday-raspberrypi-raspberry_pi/.

GPIO pin mapping
For an absolute beginner with the Raspberry Pi Zero, this GPIO mapping plate can be handy. It maps all the GPIO pins of the Raspberry Pi Zero.


GPIO Plate for the Raspberry Pi Zero. Picture source: adafruit.com

It freely fits and sits directly on the top of the GPIO pins, as shown in the picture. The labels can help with prototyping.

Stackable breadboard
This stackable breadboard is useful to a beginner in electronics. It provides access to all the GPIO pins and a breadboard is sitting right next to it. This can be helpful to quickly prototype circuits for your project needs.


Stackable breadboard

 

Note
This breadboard is available at (http://rasp.io/prohat/). We also found another enclosure with breadboard right next to it-http://a.co/dLdxaO1.



| ≪ [ 10 Home Automation Using The Raspberry Pi Zero ](/packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/10_Home_Automation_Using_The_Raspberry_Pi_Zero) | 11 Tips and Tricks | 817 Python Programming with Raspberry Pi 1ed 🔔 |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 11 Tips and Tricks
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: packtpub/2024/817_Python_Programming_with_Raspberry_Pi_1ed/11_Tips_and_Tricks
> Book Title: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> tags: Python RaspPi
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 11:35:58
> .md Name: 11_tips_and_tricks.md

