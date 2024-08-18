
| 🏁 817 Python Programming with Raspberry Pi - 1th Ed | 00 Preface | [ 01 Getting Started with Python and the Raspberry Pi Zero ](/packtpub/2024/817-Python_with_RaspPi_1ed/01_Getting_Started_with_Python_and_the_Raspberry_Pi_Zero) ≫ |
|:----:|:----:|:----:|

# 00 Preface

## Credits

| Authors | Copy Editors |
|:----|:----|
| Sai Yamanoor / Srihari Yamanoor | Safis Editing / Dipti Mankame |
| Reviewer | Project Coordinator |
| Ian McAlpine | Judie Jose |
| Commissioning Editor | Proofreader |
| Vijin Boricha | Safis Editing |
| Acquisition Editor | Indexer |
| Rahul Nair | Pratik Shirodkar |
| Content Development Editor | Graphics |
| Abhishek Jadhav | Kirk D'Penha |
| Technical Editor | Production Coordinator |
| Gaurav Suri | Shantanu N. Zagade |

## About the Authors
Sai Yamanoor is an embedded systems engineer working for a private startup school in the San Francisco Bay Area, where he builds devices that helps students achieve their full potential. He completed his graduate studies in Mechanical Engineering at Carnegie Mellon University, Pittsburgh PA, and his undergraduate work in Mechatronics Engineering from Sri Krishna College of Engineering and Technology, Coimbatore, India. His interests, deeply rooted in DIY and ppen software and hardware cultures, include developing gadgets and apps that improve Quality of Life, Internet of Things, crowdfunding, education, and new technologies. In his spare time, he plays with various devices and architectures such as the Raspberry Pi, Arduino, Galileo, Android devices and others. Sai blogs about his adventures with Mechatronics at the aptly named Mechatronics Craze blog at http://mechatronicscraze.wordpress.com/. You can find his project portfolios at http://saiyamanoor.com.

This book is Sai's second title and he has earlier published a book titled Raspberry Pi Mechatronics Projects.

I would like to thank my parents for encouraging me in all my endeavors and for making me what I am today. I am thankful to my brother who has helped me shape my career all these years. I would like to sincerely apologize to Balaji Raghavendra for the mixup with the first book and sincerely thank him for his reviews and advice on the first book. I am also thankful to the team at Packt, especially Abhishek who was patient and understanding under trying circumstances.

Srihari Yamanoor is a mechanical engineer, working on medical devices, sustainability, and robotics in the San Francisco Bay Area. He completed his graduate studies in Mechanical Engineering at Stanford University, and his undergraduate studies in  Mechanical Engineering from PSG College of Technology, Coimbatore, India. He is severally certified in SolidWorks, Simulation, Sustainable Design, PDM as well as, in quality and reliability engineering and auditing. His interests have a wide range, from DIY, crowdfunding, AI, travelling, and photography to gardening and ecology. In his spare time, he is either traveling across California, dabbling in nature photography, or at home, tinkering with his garden and playing with his cats.

I have many people to thank for any and all success in my life, one of the culminations being this second book. I start with my parents for always making sure that I put my career and education first. My brother Sai Yamanoor, is the main reason I have my name on not one, but two books! I have to thank several professors and teachers, not the least of whom are Kenneth Waldron, Dr. Radhakrishnan, Dr. R. Rudramoorthy, Dr. K.A. Jagadeesh, Cyril "Master", and the Late "Master" Williams. Of course, I'd be remiss, if I didn’t acknowledge my mentors, Russ Sampson, James Stubbs, Mukund Patel, and Anna Tamura. Then, I have my dearest friends, Patrick Nguyen, Anna Jao, Andrew Eib, Vishnu Prasad Ramachandran, and David Ma, who have put up with my quirks over the last several years, patiently offering advice and helping me weather several storms. I too would like to apologize to Balaji Raghavendra, who was left out of the acknowledgements from our last book, purely by accident, and nevertheless, inexcusably so. Without your help, we would not have been able to complete that book and start on this one. I second Sai in recognizing Abhishek Jadhav’s immeasurable patience and guidance throughout the course of the publication of this book.  Last but not the least, there are my beloved felines, the glaring that keeps me going – Bob, Gi-Ve, Fish Bone and Saxi.We would like to acknowledge that 100% of the proceeds in revenue and profits of the authors, is being turned over to worthy non-profits.

## About the Reviewer
Ian McAlpine had his first introduction to computers was his school's Research Machines RML-380Z and his physics teacher's Compukit UK101. That was followed by a Sinclair ZX81 and then a BBC Micro Model A, which he still has to this day. That interest resulted in a MEng degree in Electronic Systems Engineering from Aston University and an MSc degree in Information Technology from the University of Liverpool. Ian is currently a Senior Product Expert in the BI & Analytics Competence Centre at SAP Labs in Vancouver, Canada.


The introduction of the Raspberry Pi rekindled his desire to "tinker", but also provided an opportunity to give back to the community. Consequently Ian was a very active volunteer for 3 years on The MagPi, a monthly magazine for the Raspberry Pi, which you can read online or download for free at http://www.raspberrypi.org/magpi/. He also holds an amateur radio license (callsign VE7FTO) and is a communications volunteer for his local community Emergency Management Office. He was a technical reviewer for Packt books, such as Raspberry Pi Cookbook for Python Programmers, Raspberry Pi Projects for Kids, and Raspberry Pi 2 Server Essentials.

 
I would like to thank my darling wife, Louise, and my awesome kids Emily and Molly for allowing me to disappear into my "office"…and for training our dog to fetch me!

## cktPub.com
For support files and downloads related to your book, please visit www.PacktPub.com.

Did you know that Packt offers eBook versions of every book published, with PDF and ePub files available? You can upgrade to the eBook version at www.PacktPub.com and as a print book customer, you are entitled to a discount on the eBook copy. Get in touch with us at service@packtpub.com for more details.

At www.PacktPub.com, you can also read a collection of free technical articles, sign up for a range of free newsletters and receive exclusive discounts and offers on Packt books and eBooks.

![ Mapt_logo ](/packtpub/2024/817/00/0.0-mapt_logo.webp)

Figure 0.0: Mapt logo

https://www.packtpub.com/mapt

Get the most in-demand software skills with Mapt. Mapt gives you full access to all Packt books and video courses, as well as industry-leading tools to help you plan your personal development and advance your career.

Why subscribe?
> - Fully searchable across every book published by Packt
> - Copy and paste, print, and bookmark content
> - On demand and accessible via a web browser

## Customer Feedback

Thanks for purchasing this Packt book. At Packt, quality is at the heart of our editorial process. To help us improve, please leave us an honest review on this book's Amazon page at https://www.amazon.com/dp/1786467577.


If you'd like to join our team of regular reviewers, you can e-mail us at customerreviews@packtpub.com. We award our regular reviewers with free eBooks and videos in exchange for their valuable feedback. Help us be relentless in improving our products!

## Preface
The Raspberry Pi represents the best in innovation in computer science, education, entertainment, hobby hacking, and several other categories that you can classify the device family into. Even as this book is entering publication, the Raspberry Pi family of products have become the third best selling computers of all time. It is anyone’s guess that with the continuing innovation coming out of the Raspberry Pi Foundation and the thousands of people across the planet constantly demonstrating newer and better examples innovative solutions with the various flavors of Raspberry Pi, what new heights this product line might reach!

One of the main goals of the Raspberry Pi is affordability. And the purpose of this book is to allow the beginner to learn Programming in Python, as well as manipulating hardware. The reader may have worked a little bit on hardware, and a little bit on programming, and want to strengthen skills in either area. The reader may also just be interested in doing more projects with the Pi Zero in Python, and of course, some of the projects in this book, briefly highlighted below might be of interest.

The book starts off with some warm up examples, helping develop a familiarity with the Raspberry Pi environment, and the projects increase in variety and complexity as the book progresses. While, readers who have advanced a bit before approaching the book can skip a few chapters, we recommend beginners progress through all chapters, since the concepts build on top of each other.

## What this book covers

Chapter 1, Getting Started with Python and the Raspberry Pi Zero, introduces the Raspberry Pi Zero and the Python programming language, its history, and its features. We will set up the Raspberry Pi for Python development and write the first program.

Chapter 2, Arithmetic Operations, Loops, and Blinky Lights, walks through the arithmetic operations in Python and loops in Python. In the second half of the chapter, we will discuss the Raspberry Pi Zero’s GPIO interface and then learn to blink an LED using a GPIO pin.

Chapter 3, Conditional Statements, Functions, and Lists, discusses the types of conditional statements, variables, and logical operators in Python. We will also discuss functions in Python. Then, we will learn to write a function that is used to control DC motors using the Raspberry Pi Zero.

Chapter 4, Communication Interfaces, covers all the communication interfaces available on the Raspberry Pi Zero. This includes the I2C, UART, and the SPI interface. These communication interfaces are widely used to interface sensors. Hence, we will demonstrate the operation of each interface using a sensor as an example.

Chapter 5, Data Types and Object-Oriented Programming in Python, discusses object-oriented programming in Python and the advantages of object-oriented programming. We will discuss this using a practical example.

Chapter 6, File I/O and Python Utilities, discusses reading and writing to files. We discuss creating and updating config files. We will also discuss some utilities available in Python.

Chapter 7, Requests and Web Frameworks, discusses libraries and frameworks that enable retrieving data from the Web. We will discuss an example, fetching local weather information. We will also discuss running a web server on the Raspberry Pi Zero.

Chapter 8, Awesome Things You Could Develop Using Python, discusses libraries and frameworks that enable retrieving data from the web. We will discuss examples such as fetching the local weather information. We will also discuss running a web server on the Raspberry Pi Zero.

Chapter 9, Let's Build a Robot!, shows how we built an indoor robot using the Raspberry Pi Zero as the controller and documented our experience as a step-by-step guide. We wanted to demonstrate the awesomeness of the combination of Python and the Raspberry Pi Zero’s peripherals.

Chapter 10, Home Automation Using The Raspberry Pi Zero, discusses four projects, a voice-activated personal assistant, a web framework-based appliance control, a physical activity motivation tool, and a smart lawn sprinkler. Through these projects we provide more examples of the new hardware and programming implementations.

Chapter 11, Tips and Tricks, concludes the book with useful hardware and software tips and shortcuts that will help you as you step beyond the concepts and exercises in this book to implement your own projects and solutions, or simply explore the areas of programming and hardware hacking as a hobby and a source of entertainment.

## What you need for this book

The following hardware is recommended:

> - A laptop computer, with any OS
> - Raspberry Pi Zero
> - A microSD card, either 8 GB or 16 GB
> - A USB keyboard
> - A USB mouse
> - A display with HDMI input
> - A USB Wi-Fi card
> - Power supply, minimum 500 mA.
> - Display cables
> - Other accessories, as required to complete the various projects in the book

## Who this book is for

This book is primarily aimed at hobbyists and makers. So, some basic exposure to programming, hardware and the Linux OS is assumed. Even without exposure to these areas, it is possible to follow along and benefit from the book. Wherever possible, we have tried our best to point you to free, open and/or cost effective resources to follow along with the projects in the book.

## Conventions

In this book, you will find a number of text styles that distinguish between different kinds of information. Here are some examples of these styles and an explanation of their meaning.

Code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles are shown as follows: "The `remove()` method finds the first instance of the element (passed an argument) and removes it from the list."

A block of code is set as follows:

```python
      try: 
         input_value = int(value) 
      except ValueError as error:  
         print("The value is invalid %s" % error)
```

Any command-line input or output is written as follows:

```bash
    sudo pip3 install schedule
```

New terms and important words are shown in bold. Words that you see on the screen, for example, in menus or dialog boxes, appear in the text like this: "Select the `A8 Serial` option from the drop-down menu."

> Warnings or important notes appear in a box like this.

> Tips and tricks appear like this.

## Reader feedback

Feedback from our readers is always welcome. Let us know what you think about this book-what you liked or disliked. Reader feedback is important for us as it helps us develop titles that you will really get the most out of. To send us general feedback, simply e-mail `feedback@packtpub.com`, and mention the book's title in the subject of your message. If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, see our author guide at www.packtpub.com/authors.

## Customer support

Now that you are the proud owner of a Packt book, we have a number of things to help you to get the most from your purchase.

## Downloading the example code

You can download the example code files for this book from your account at http://www.packtpub.com. If you purchased this book elsewhere, you can visit http://www.packtpub.com/support and register to have the files e-mailed directly to you.

You can download the code files by following these steps:

1. Log in or register to our website using your e-mail address and password.
1. Hover the mouse pointer on the `SUPPORT` tab at the top.
1. Click on `Code Downloads & Errata`.
1. Enter the name of the book in the `Search` box.
1. Select the book for which you're looking to download the code files.
1. Choose from the drop-down menu where you purchased this book from.
1. Click on `Code Download`.

Once the file is downloaded, please make sure that you unzip or extract the folder using the latest version of:

> - WinRAR / 7-Zip for Windows
> - Zipeg / iZip / UnRarX for Mac
> - 7-Zip / PeaZip for Linux

You can download the latest code samples from the code repository belonging to this book from the author's code repository at https://github.com/sai-y/pywpi. You can find additional resources including bonus projects at http://pywithpi.com.

The code bundle for the book is also hosted on Packt's GitHub repository at https://github.com/PacktPublishing/Python-Programming-with-Raspberry-Pi-Zero. We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

## Downloading the color images of this book

We also provide you with a PDF file that has color images of the screenshots/diagrams used in this book. The color images will help you better understand the changes in the output. You can download this file from https://www.packtpub.com/sites/default/files/downloads/PythonProgrammingwithRaspberryPiZero_ColorImages.pdf.

## Errata

Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you find a mistake in one of our books-maybe a mistake in the text or the code-we would be grateful if you could report this to us. By doing so, you can save other readers from frustration and help us improve subsequent versions of this book. If you find any errata, please report them by visiting http://www.packtpub.com/submit-errata, selecting your book, clicking on the `Errata Submission Form` link, and entering the details of your errata. Once your errata are verified, your submission will be accepted and the errata will be uploaded to our website or added to any list of existing errata under the Errata section of that title.

To view the previously submitted errata, go to https://www.packtpub.com/books/content/support and enter the name of the book in the search field. The required information will appear under the `Errata` section.

## Piracy

Piracy of copyrighted material on the Internet is an ongoing problem across all media. At Packt, we take the protection of our copyright and licenses very seriously. If you come across any illegal copies of our works in any form on the Internet, please provide us with the location address or website name immediately so that we can pursue a remedy.

Please contact us at `copyright@packtpub.com` with a link to the suspected pirated material.

We appreciate your help in protecting our authors and our ability to bring you valuable content.

## Questions

If you have a problem with any aspect of this book, you can contact us at `questions@packtpub.com`, and we will do our best to address the problem.



| 🏁 817 Python Programming with Raspberry Pi - 1th Ed | 00 Preface | [ 01 Getting Started with Python and the Raspberry Pi Zero ](/packtpub/2024/817-Python_with_RaspPi_1ed/01_Getting_Started_with_Python_and_the_Raspberry_Pi_Zero) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 00 Preface
> (2) Short Description: Python with RaspPi 1ed
> (3) Path: /packtpub/2024/817-Python_with_RaspPi_1ed/00_Preface
> Book Jemok: Python Programming with Raspberry Pi - 1th Ed
> AuthorDate: By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed
> Link: https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1
> create: 2024-08-17 토 16:35:08
> .md Name: 00_preface.md

