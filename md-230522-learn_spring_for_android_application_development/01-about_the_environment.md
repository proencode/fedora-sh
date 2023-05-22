
# About the Environment

The title of this book makes reference to two of the greatest stage names—Spring, ostensibly the best framework of Java, and Android, which has the greatest number of clients of any operating system. This book will help to you learn and develop a product-ready application on your own which will be lightweight, secure, powerful, and responsive.

Before start learning about the Spring and Android, we will demonstrate examples and code from Kotlin, as this programming language is very new to developers. These days, Kotlin is so popular that Google has declared it the official language of Android. Moreover, the Spring language also supports Kotlin. In this book, we will figure out how to make a robust, secure, and intense server dependent on Spring in the Kotlin language, and use the substance and utilize of this server in an Android application as a client.

In this chapter, you will learn how to set up the environment to create Spring and Android projects, including the required tools and applications. This will include going through steps with accompanying images for visualization purposes. The developers who know Java, at that point, will have some leeway since it is the common platform among Spring and Kotlin. We will demonstrate the code and models with Kotlin that runs on JVM. The Kotlin is designed by JetBrains. On the off-chance that you are new to Kotlin and Spring, being familiar with Java will allow you to write code in Kotlin with ease.

The following topics will be covered in this chapter:

> Setting up the environment
> Spring
>  Java
>  Kotlin
> Apache Tomcat
> Integrated development environments
> Android

# Technical requirements

To run these frameworks, we need some tools and a specific operating system. Here is the list of these:

> **Operating system**: Linux and macOS are recommended for development because we can find all the required packages for these OSes and they are lighter than Windows.
> **IDE**: My recommended IDE is IntelliJ IDEA (Ultimate version). This is the best IDE for Java, but you have to purchase it to use it. You can also use Eclipse and Netbeans; only one of these is necessary to develop Spring applications. We will show all the projects in IntelliJ, but we will also learn the setup of the environments for Spring in both IntelliJ IDEA and Eclipse.
You can find all the examples from this chapter on GitHub: https://github.com/PacktPublishing/Learn-Spring-for-Android-Application-Development/.

# Setting up the environment

An environment setup is one of the prime parts before developing an application. To the developers who are currently working with Spring, feel free to skip this part. This section is for new developers, who need to set up the foundation and the instruments to begin developing.

Here are the steps of how to set up the environment in the accompanying segments.

## Spring

Spring is the most powerful Java application framework; it is currently the most popular in the enterprise world. It helps to create high-performing applications that have easily-testable and reusable code. This is open source and was written by Rod Johnson, first released under the Apache 2.0 license in June 2003.

To create and run Spring applications, you need some tools and language supports. You also need a server to test and run your project in your operating system. We will show you how to set up the environment for Spring.

The following software and tools are needed with the current version:

> Java (version 1.8)
> Kotlin (version 1.3)
> Apache Tomcat (version 9.0.11)
> IntelliJ Ultimate (version 2018.2.2) or Eclipse Photon
> Spring Framework Libraries (version 5.0.8.RELEASE)

# Java

Java is available in two editions:

> Standard Edition (J2SE)
> Enterprise Edition (J2EE)

Here, we will opt for Standard Edition. Java is free to download and use for all operating systems.

You can download Java 10.0.2 from http://www.oracle.com/technetwork/java/javase/downloads/index.html.
Download for your operating system.

After installation, please check whether Java is installed. To check, open your Terminal and type `java --version`. If Java is installed successfully, you will see the following Java version:


Fig-01.01-Check java version

Alternatively, you will see an error. If this occurs, try to install it again to resolve it.

## Kotlin

Developed by JetBrains, Kotlin is an open source and statically-typed programming language. It runs on the Java Virtual Machine (JVM) and can be compiled to JavaScript source code or use the LLVM compiler infrastructure. Kotlin is easy to learn, especially for Java developers.

To use Kotlin, you don't need to download or set it up separately like Java. It comes with the IDEs. Kotlin is a built-in feature of Android Studio, IntelliJ Ultimate, or IntelliJ Community. To use Kotlin in Eclipse, you need to follow these steps:

1. Go to help -> **Eclipse Marketplace from the Eclipse toolbar.
1. In the search box, write `Kotlin`, there you will find the **Kotlin** plugin.
1. Install it and you can write code in **Kotlin**:


Fig-01.02-Eclipse Marketplace

> We highly recommend using IntelliJ IDE to implement the latest version of Kotlin. The Eclipse plugin does not have the latest version of Kotlin.
{.is-success}

# Apache Tomcat

We require a steady, free, and open source web server that we can use to create and run Spring-Framework-based ventures. We will utilize Apache Tomcat, which is easy to understand for all developers of Java. You can also use Jetty or Undertow to develop in Spring.

Tomcat is an open source web server. This allows the utilization of Java Servlets and **JavaServer Pages (JSP)** for the Java server. The core segment of Tomcat is Catalina.

> Apache Tomcat is a web server and not an application server.
{.is-info}

You can download Tomcat 9.0.11 from https://tomcat.apache.org/download-90.cgi.

If you use Tomcat version 9, you have to use Java version 8 or later. According to the Apache Tomcat source, this version builds on Tomcat 8.0.x and 8.5.x, and implements the Servlet 4.0, JSP 2.3, EL 3.0, WebSocket 1.1, and JASPIC 1.1 specifications (the versions required by the Java EE 8 platform).

Let's see how to configure and verify the Tomcat server.

# Configuring Tomcat

You can configure the Tomcat server in two ways—either using the Terminal or from the IDE. To set up the server, you have to download the Tomcat server's content from https://tomcat.apache.org/download-90.cgi.

Configuring Tomcat by these following steps:

1. Download a binary distribution of the core module from the link.
1. Extract the file. This creates a folder named `apache-tomcat-9.0.11` (version number can be changed).
1. To access it with ease, rename the folder `Tomcat` and move it to `/usr/local` (for Linux) or `/Library` (for macOS):

Fig-01.03-Project files

For Linux, use these steps:
```
// If you have an older version of Tomcat, then remove it before using the newer one
sudo rm -rf /usr/local/Tomcat        // To remove exist TomCat

sudo mv ~/Download/Tomcat /usr/local // To move TomCat from the download directory to your desire direction
```


For macOS, use these steps:
```
// If you have an older version of Tomcat, then remove it before using the newer one
sudo rm -rf /Library/Tomcat            // To remove exist TomCat

sudo mv Downloads/Tomcat /Library/     // To move TomCat from the download directory to your desire direction
```


To check the current directory, type the following:

- For Linux: `cd /usr/local/Tomcat/`
- For macOS: `cd /Library/Tomcat/`

4. Type `ls` to see a list of this directory:

Fig-01.04-check tomcat files in terminal

5. Change the ownership of the `/usr/local/Tomcat` or `/Library/Tomcat` folder hierarchy:

- For Linux: `sudo chown -R <your_username> /usr/local/Tomcat/`
- For macOS: `sudo chown -R <your_username> /Library/Tomcat/`

6. Make all scripts executable:

For Linux: sudo chmod +x /usr/local/Tomcat/bin/*.sh
For macOS: sudo chmod +x /Library/Tomcat/bin/*.sh

7. To check the contents of Tomcat, use the following command:

For Linux: `ls -al /usr/local/Tomcat/bin/*.sh`
For macOS: `ls -al /Library/Tomcat/bin/*.sh`

8. You can see that every file is listed with `-rwxr-xr-x@`, where `-x` means executable. Executable demonstrates to us the authorization status to get to the files:

Fig-01.05-Check the tomcat executable files in terminal

9. To start and stop, type the following:

- For macOS:
```
/Library/Tomcat/bin/startup.sh
/Library/Tomcat/bin/shutdown.sh
```

- For Linux:
```
/usr/local/Tomcat/bin/startup.sh
/usr/local/Tomcat/bin/shutdown.sh
```

10. To turn on and off the Tomcat server, use this command:

Fig-01.06-To turn on and off

## Verifying Tomcat

1. After starting the server, go to your browser and enter `http://localhost:8080`, which will show you the default page:

Fig-01.06-Default tomcat local hosting
Default tomcat local hosting
This is how we can configure Tomcat from the Terminal.

## Integrated development environment

When it comes to writing Java programs, you can use any text editor. However, we encourage you to use an `integrated development environment (IDE)` because they provide numerous features. IntelliJ IDEA, Eclipse, and NetBeans are the best of them. IntelliJ is a paid IDE, but you can use Eclipse or NetBeans, which are free.

We can use IDE to do the following:

- Manage Tomcat
- Develop apps and web apps where there is no need to remember the full name of the methods and signatures
- Highlight compile errors

In this book, we will work with Eclipse and IntelliJ IDEA.
You can download the Ultimate version, which has a 30-day free trial, from https://www.jetbrains.com/idea/download/.

To download the Eclipse, visit http://www.eclipse.org/downloads/packages/.

For Spring, you should download Eclipse IDE for the Java EE Developers version.

For both, once you start IDE, it will ask for a workspace. You can create a folder of your choice and give the path of that folder.

## IntelliJ IDEA

IntelliJ IDEA is a Java coordinated development environment for developing computer software. It is developed by JetBrains and is accessible as an Apache 2 Licensed people group release and in a restrictive business version. Both can be utilized for business development.

> The latest version of Kotlin comes built-in with IntelliJ IDEA ultimate and IntelliJ IDEA community.
{.is-info}

## Eclipse

Eclipse is an incorporated development environment utilized in computer programming and is the most generally-utilized Java IDE. It contains a base workspace and an extensible module framework for tweaking the environment. Eclipse is composed generally in Java and its essential utility is for developing Java applications, yet it might likewise be utilized to develop applications in other programming dialects by means of modules, including Ada, ABAP, C, C++, C#, Clojure, COBOL, D, Erlang, Fortran, Groovy, Haskell, JavaScript, Julia, Lasso, Lua, NATURAL, Perl, PHP, Prolog, Python, R, Ruby (including the Ruby on Rails framework), Rust, Scala, and Scheme.

To use Kotlin in Eclipse, you will need to install the Kotlin plugin.

> Eclipse doesn't have the latest version of Kotlin.
{.is-info}

After creating a project, you’ll need to integrate the Tomcat server manually. However, if you use Spring Boot, you don't need to do anything because this comes with the Tomcat server.

Follow these steps to create a web project and implement the Tomcat server into your project:

1. Visit new > New Dynamic Web Project.
1. Provide a Project Name.
1. To integrate Tomcat, click New Runtime:

Fig-01.07-new project create

4. Download version 9+, select Apache Tomcat v9.0, and click Finish:

Fig-01.08-tomcat version selection

5. Select the latest Dynamic web module version.
6. Click Finish.

You will find these files after creating the project:


Fig-01.09-Project files

7. Go to the Server tab, which is in the bottom-left window:

Fig-01.10-project IDE interface

8. Select Tomcat v9.0 Server at localhost.
9. Hit the start button.
10. Once the server is started, verify it by visiting http://localhost:8080 in a browser.
11. If everything is OK, you can start and stop the Tomcat server from here.

# Android

Android is a mobile operating system developed by Google, in light of an altered form of the Linux kernel and other open source software and designed basically for touchscreen mobile gadgets, for example, cell phones and tablets. What's more, Google has additionally developed Android TV for televisions, Android Auto for vehicles, and Wear OS for wristwatches, each with a specific UI. Variations of Android are likewise utilized on IoT, advanced cameras, PCs, and various hardware. It was first developed by Android Inc., which Google purchased in 2005, and Android was disclosed in 2007. The first commercial Android devices were launched in September 2008. The current version has since experienced numerous significant discharges, with the present variant being 9 Pie, released in August 2018. The core Android source code is known as Android Open Source Project (AOSP) and is authorized under the Apache License.

In this book, we will figure out how to create a REST API, security, and a database in a Spring platform on a server. We will also learn how to make an Android application and retrieve data from the server, as well as its utilization as a client.

Android Studio is the main IDE among the different IDEs to make an Android application. This is the official IDE for Android. This is based on the IntelliJ IDEA of JetBrains, which is structured especially for Android application development.

To download Android Studio, visit https://developer.android.com/studio/. Here, you will find the latest version of Android Studio to download. The best part is that this includes JRE, the latest SDK, and other important plugins to develop.

Install the Android Studio application after downloading it. This tool is very easy to use.

> Don't forget to update and download the latest version of the SDK platform. To update or install a new SDK platform, go to the SDK Manager. In the SDK Platform, you can see the list of all the Android version's platforms.
If you have read and installed the environment without any hassle, you are ready to proceed with learning the information in this book. We have submitted the code on GitHub and shared the link in the Technical requirements section, so you can use that example code.
{.is-success}

# Summary

This chapter is mainly for those developers who are new to this platform. We have shown the setup procedure using some specific tools and applications and you can also develop your project with different tools and applications. We have looked at how to set up an environment to develop Spring and Android. You are now familiar with all the required tools and software. Now can you configure the Tomcat server in your OS and familiarize yourself with how to start and stop the server. You can decide which IDE you need for developing. We also learned the installation procedure for Android Studio without any hassle. Lastly, there are no criteria to use the latest version of the tools or software.

In the next chapter, we will explore Kotlin, which is a statically-typed programming language and the official language for Android.

# Questions

1. Is the Spring Framework built on Java SE or Java EE?
2.  What are the alternative IDEs of Eclipse and IntelliJ IDEA for developing Spring?
3.  Is Tomcat a web server or an application server?
4.  What are the alternatives of the Tomcat server for running Spring?
5.  Is Android Studio the IDE to develop Android?

# Further reading

Mastering Spring 5.0 (https://www.packtpub.com/application-development/mastering-spring-50) by Ranga Karanam

Previous Chapter
End of Chapter 1
Next Chapter

