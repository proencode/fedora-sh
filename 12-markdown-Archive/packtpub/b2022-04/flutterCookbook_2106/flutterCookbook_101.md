원본 제목: 1 Preface
Flutter Cookbook By Simone Alessandria, Brian Kayfitz
Publication date: 6월 2021 Publisher Packt Pages 646 ISBN 9781838823382
원본 링크: https://subscription.packtpub.com/book/mobile/9781838823382/pref
Path:
packtpub/flutterCookbook/101
Title:
101 Preface
Short Description:
Flutter Cookbook 머리말

---------- cut line ----------


# Preface

This book contains over 100 short recipes that will help you learn Flutter by example. These recipes cover the most important Flutter features that will allow you to develop real-world apps. In every recipe, you will learn and immediately use some of the tools that make Flutter so successful: widgets, state management, asynchronous programming, connecting to web services, persisting data, creating animations, using Firebase and machine learning, and developing responsive apps that work on different platforms, including desktop and the web.

Flutter is a developer-friendly, open source toolkit created by Google that you can use to create applications for Android and iOS mobile devices, and now that Flutter 2.2 has been released, you can also use the same code base for the web and desktop.

There are 15 chapters in this book, which you can read independently from one another: each chapter contains recipes that highlight and leverage a single Flutter feature. You can choose to follow the flow of the book or skip to any chapter if you feel confident with the concepts introduced in earlier chapters.

Flutter uses Dart as a programming language. Chapter 2, Dart: A Language You Already Know, is an introduction to Dart, its syntax, and its patterns, and it gives you the necessary knowledge to be productive when using Dart in Flutter.

In later chapters, you'll see recipes that go beyond basic examples; you will be able to play with code and get hands-on experience in using basic, intermediate, and advanced Flutter tools.

# Who this book is for

This book is for developers who are familiar with an object-oriented programming language. If you understand concepts such as variables, functions, classes, and objects, this book is for you. 

Prior knowledge of Dart is not required as it is introduced in Chapter 2, Dart: A Language You Already Know. 

If you already know and use languages such as Java, C#, Swift, Kotlin, and JavaScript, you will find Dart surprisingly easy to learn.

# What this book covers

Chapter 1, Getting Started with Flutter, will help you set up your development environment.

Chapter 2, Dart: A Language You Already Know, introduces Dart, its syntax, and its patterns.

Chapter 3, Introduction to Widgets, shows how to build simple user interfaces with Flutter.

Chapter 4, Mastering Layout and Taming the Widget Tree, shows how to build more complex screens made of several widgets.

Chapter 5, Adding Interactivity and Navigation to Your App, contains several recipes that add interactivity to your apps, including interacting with buttons, reading a text from a TextField, changing the screen, and showing alerts.

Chapter 6, Basic State Management, introduces the concept of State in Flutter: instead of having screens that just show widgets, you will learn how to build screens that can keep and manage data.

Chapter 7, The Future Is Now: Introduction to Asynchronous Programming, contains several examples of one of the most useful and interesting features in programming languages: the concept of the asynchronous execution of tasks.

Chapter 8, Data Persistence and Communicating with the Internet, gives you the tools to connect to web services and persist data into your device.

Chapter 9, Advanced State Management with Streams, shows how to deal with Streams, which are arguably the best tool to create reactive apps.

Chapter 10, Using Flutter Packages, teaches you how to choose, use, build, and publish Flutter packages.

Chapter 11, Adding Animations to Your App, gives you the tools you need to build engaging animations in your apps.

Chapter 12, Using Firebase, shows how to leverage a powerful backend without any code!

Chapter 13, Machine Learning with Firebase MLKit, shows how to add machine learning features to your apps by using Firebase.

Chapter 14, Distributing Your Mobile App, outlines the steps required to publish an app into the main stores: the Google Play Store and the Apple App Store.

Chapter 15, Flutter Web and Desktop, shows you how to use the same code base to build apps for the web and desktop.

# To get the most out of this book

Some experience in at least one object-oriented programming language is strongly recommended.

In order to follow along with the code, you will need a Windows PC, Mac, Linux, or Chrome OS machine connected to the web, with at least 8 GB of RAM and the permissions to install new software. 

An Android or iOS device is suggested but not necessary as there are simulators/emulators that can run on your machine. All software used in this book is open source or free to use. 

Chapter 1, Getting Started with Flutter, explains in detail the installation process; however, you should have the following: 

| Software/hardware covered in the book | OS requirements |
|:---|:---|
| Visual Studio Code, Android Studio, or IntelliJ Idea | Windows, macOS, or Linux |
| Flutter SDK | | Windows, macOS, or Linux |
| An emulator/simulator or an iOS or Android device | Windows, macOS, or Linux (macOS is needed only for iOS) |
 

## In order to create apps for iOS, you will need a Mac.

If you are using the digital version of this book, we advise you to type the code yourself or access the code via the GitHub repository (link available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

If you like this book or want to share your ideas about it, please write a review on your favorite platform. This will help us make this book better, and you'll also earn the authors' and reviewer's everlasting gratitude.

# Download the example code files

You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/Flutter-Cookbook. In case there's an update to the code, it will be updated on the existing GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Download the color images

We also provide a PDF file that has color images of the screenshots/diagrams used in this book. You can download it here: https://static.packt-cdn.com/downloads/9781838823382_ColorImages.pdf.

# Conventions used

There are a number of text conventions used throughout this book.

CodeInText: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: "Edit the increaseValue method again. This time, use the null-check operator."

A block of code is set as follows:

```
void variablePlayground() {
 basicTypes();
 untypedVariables();
 typeInterpolation();
 immutableVariables();
}
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

```
final int numValue = 42; // this is ok
// NOT OK: const int or var int.
```

Any command-line input or output is written as follows:

```
$ mkdir css
$ cd css
```

Bold: Indicates a new term, an important word, or words that you see onscreen. For example, words in menus or dialog boxes appear in the text like this. Here is an example: "In DartPad, make sure Null Safety is disabled"

> Warnings or important notes appear like this.
{.is-info}

> Tips and tricks appear like this.
{.is-success}

# Sections

In this book, you will find several headings that appear frequently (Getting ready, How to do it..., How it works..., There's more..., and See also).

To give clear instructions on how to complete a recipe, use these sections as follows:

# Getting ready

This section tells you what to expect in the recipe and describes how to set up any software or any preliminary settings required for the recipe.

# How to do it…

This section contains the steps required to follow the recipe.

# How it works…

This section usually consists of a detailed explanation of what happened in the previous section.

# There's more…

This section consists of additional information about the recipe in order to make you more knowledgeable about the recipe.

# See also

This section provides helpful links to other useful information for the recipe.

# Get in touch

Feedback from our readers is always welcome.

General feedback: If you have questions about any aspect of this book, mention the book title in the subject of your message and email us at customercare@packtpub.com.

Errata: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata, selecting your book, clicking on the Errata Submission Form link, and entering the details.

Piracy: If you come across any illegal copies of our works in any form on the Internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

If you are interested in becoming an author: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

# Reviews

Please leave a review. Once you have read and used this book, why not leave a review on the site that you purchased it from? Potential readers can then see and use your unbiased opinion to make purchase decisions, we at Packt can understand what you think about our products, and our authors can see your feedback on their book. Thank you!

For more information about Packt, please visit packt.com.
