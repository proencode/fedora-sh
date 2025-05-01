
| ≪ [ 000 Preface ](/books/packtpub/2024/1202-Spring_Boot_3_React/000_Preface) | 101 Setting Up the Environment and Tools | [ 102 Understanding Dependency Injection ](/books/packtpub/2024/1202-Spring_Boot_3_React/102_Understanding_Dependency_Injection) ≫ |
|:----:|:----:|:----:|

# Part 1: Backend Programming with Spring Boot

# 101 Setting Up the Environment and Tools – Backend

In this book, we will learn about full stack development using Spring Boot in the backend and React in the frontend. The first part of this book focuses on backend development. The second part of this book focuses on frontend programming with React. In the third part, we will implement the frontend.

In this chapter, we will set up the environment and tools needed for backend programming with Spring Boot. Spring Boot is a modern Java-based backend framework that makes development faster than traditional Java-based frameworks. With Spring Boot, you can make a standalone web application that has an embedded application server.

There are a lot of different integrated development environment (IDE) tools that you can use to develop Spring Boot applications. In this chapter, we will install Eclipse, which is an open-source IDE for multiple programming languages. We will create our first Spring Boot project by using the Spring Initializr project starter page. Reading the console logs is a crucial skill when developing Spring Boot applications, which we will also cover.

In this chapter, we will look into the following topics:

Installing Eclipse
Understanding Gradle
Using Spring Initializr
Installing MariaDB
Technical requirements
The Java software development kit (JDK), version 17 or higher, is necessary to use with Eclipse and Spring Boot 3. In this book, we are using the Windows operating system, but all tools are available for Linux and macOS as well. You can get the JDK installation package from Oracle (https://www.oracle.com/java/technologies/downloads/) or you can use OpenJDK versions as well. You can check the version of the installed Java SDK by typing the java –version command in your terminal.

Download the code for this chapter from GitHub at https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter01.

Installing Eclipse
Eclipse is an open-source programming IDE developed by the Eclipse Foundation. An installation package or installer can be downloaded from https://www.eclipse.org/downloads. Eclipse is available for Windows, Linux, and macOS. You can also use other IDE tools like IntelliJ or VS Code if you are familiar with them.

You can either download a ZIP package of Eclipse or an installer package that executes the installation wizard. In the installer, you should select Eclipse IDE for Enterprise Java and Web Developers, as shown in the following screenshot:


Figure 1.1: Eclipse installer

If using the ZIP package, you have to extract the package to your local disk, and it will contain an executable eclipse.exe file, which you can run by double-clicking on the file. You should download the Eclipse IDE for Enterprise Java and Web Developers package.

Eclipse is an IDE for multiple programming languages, such as Java, C++, and Python. Eclipse contains different perspectives for your needs, which are a set of views and editors in the Eclipse workbench. The following screenshot shows common perspectives for Java development:


Figure 1.2: Eclipse workbench

On the left-hand side, we have the Project Explorer, where we can see our project structure and resources. The Project Explorer is also used to open files by double-clicking on them. The files will be opened in the editor, which is in the middle of the workbench. The Console view can be found in the lower section of the workbench. This view is really important because it shows application logging messages.

IMPORTANT NOTE

You can get Spring Tool Suite (STS) for Eclipse if you want, but we are not going to use it in this book because the plain Eclipse installation is enough for our purposes. STS is a set of plugins that makes Spring application development simple, and you can find more information about it here: https://spring.io/tools.

Now that we have installed Eclipse, let’s take a quick look at what Gradle is and how it helps us.

Understanding Gradle
Gradle is a build automation tool that makes the software development process simpler and also unifies the development process. It manages our project dependencies and handles the build process.

IMPORTANT NOTE

You can also use another project management tool called Maven with Spring Boot, but we will focus on using Gradle in this book because it’s faster and more flexible than Maven.

We don’t need to perform any installations to use Gradle in our Spring Boot project since we are utilizing the Gradle wrapper within our project.

The Gradle configuration is done in the project’s build.gradle file. The file can be customized to fit the specific needs of the project and can be used to automate tasks such as building, testing, and deploying the software. The build.gradle file is an important part of the Gradle build system and is used to configure and manage the build process for a software project. The build.gradle file typically includes information about the project’s dependencies, like external libraries and frameworks that are needed for the project to compile. You can use either the Kotlin or Groovy programming languages to write build.gradle files. In this book, we are using Groovy. The following is one example of a Spring Boot project’s build.gradle file:

plugins {
    id 'java'
    id 'org.springframework.boot' version '3.1.0'
    id 'io.spring.dependency-management' version '1.1.0'
}
group = 'com.packt'
version = '0.0.1-SNAPSHOT'
sourceCompatibility = '17'
repositories {
    mavenCentral()
}
dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-web'
    developmentOnly 'org.springframework.boot:spring-boot-devtools'
    testImplementation 'org.springframework.boot:spring-boot-starter-
    test'
}
tasks.named('test') {
    useJUnitPlatform()
}

Copy

Explain
The build.gradle file typically contains the following parts:

Plugins: The plugins block defines the Gradle plugins that are used in the project. In this block, we can define the version of Spring Boot.
Repositories: The repositories block defines the dependency repositories that are used to resolve dependencies. We are using the Maven Central repository, from which Gradle pulls the dependencies.
Dependencies: The dependencies block specifies the dependencies that are used in the project.
Tasks: The tasks block defines the tasks that are part of the build process, such as testing.
Gradle is often used from the command line, but we are using the Gradle wrapper and Eclipse, which handles all the Gradle operations we need. The wrapper is a script that invokes a declared version of Gradle, and it standardizes your project to a given Gradle version. Therefore, we are not focusing on Gradle command-line usage here. The most important thing is to understand the structure of the build.gradle file and how to add new dependencies to it. We will learn how to add dependencies using Spring Initializr in the next section. Later in this book, we will also add new dependencies manually to the build.gradle file.

In the next section, we will create our first Spring Boot project and see how we can run it using the Eclipse IDE.

Using Spring Initializr
We will create our backend project using Spring Initializr, a web-based tool that’s used to create Spring Boot projects. Then, we will learn how to run our Spring Boot project using the Eclipse IDE. At the end of this section, we will also look at how you can use Spring Boot logging.

Creating a project
To create our project using Spring Initalizr, complete the following steps:

Open Spring Initializr by navigating to https://start.spring.io using your web browser. You should see the following page:

Figure 1.3: Spring Initializr

We will generate a Gradle - Groovy project with Java and the latest stable Spring Boot 3.1.x version. If you are using a newer major or minor version, you should check the release notes about what’s changed. In the Group field, we will define our group ID (com.packt), which will also become a base package in our Java project. In the Artifact field, we will define an artifact ID (cardatabase), which will also be the name of our project in Eclipse.
IMPORTANT NOTE

Select the correct Java version in Spring Initializr. In this book, we are using Java version 17. In Spring Boot 3, the Java baseline is Java 17.

By clicking the ADD DEPENDENCIES… button, we will select the starters and dependencies that are needed in our project. Spring Boot provides starter packages that simplify your Gradle configuration. Spring Boot starters are actually a set of dependencies that you can include in your project. We will start our project by selecting two dependencies: Spring Web and Spring Boot DevTools. You can type the dependencies into the search field or select from a list that appears, as illustrated in the following screenshot:

Figure 1.4: Adding dependencies

The Spring Boot DevTools dependency gives us the Spring Boot developer tools, which provide an automatic restart functionality. This makes development much faster because the application is automatically restarted when changes have been saved.

The Spring Web starter pack is a base for full stack development and provides an embedded Tomcat server. After you have added dependencies, your Dependencies section in Spring Initializr should look like this:


Figure 1.5: Spring Initializr dependencies

Finally, click on the GENERATE button, which generates a project starter ZIP package for us.
Next, we will learn how to run our project using the Eclipse IDE.

Running the project
Perform the following steps to run the Gradle project in the Eclipse IDE:

Extract the project ZIP package that we created in the previous section and open Eclipse.
We are going to import our project into the Eclipse IDE. To start the import process, select the File | Import menu and the import wizard will be opened. The following screenshot shows the first page of the wizard:

Figure 1.6: Import wizard (step 1)

In the first phase, you should select Existing Gradle Project from the list under the Gradle folder, and then click the Next > button. The following screenshot shows the second step of the import wizard:

Figure 1.7: Import wizard (step 2)

In this phase, click the Browse... button and select the extracted project folder.
Click the Finish button to finalize the import. If everything ran correctly, you should see the cardatabase project in the Eclipse IDE Project Explorer. It takes a while before the project is ready because all the dependencies will be downloaded by Gradle after importing them. You can see the progress of the dependency download in the bottom-right corner of Eclipse. The following screenshot shows the Eclipse IDE Project Explorer after a successful import:

Figure 1.8: Project Explorer

The Project Explorer also shows the package structure of our project. In the beginning, there is only one package called com.packt.cardatabase. Under that package is our main application class, called CardatabaseApplication.java.
Now, we don’t have any functionality in our application, but we can run it and see whether everything has started successfully. To run the project, open the main class by double-clicking on it, as shown in the following screenshot, and then click the Run button (the play icon) in the Eclipse toolbar. Alternatively, you can select the Run menu and click Run as | Java Application:

Figure 1.9: The Cardatabase project

You can see the Console view open in Eclipse, which contains important information about the execution of the project. As we discussed before, this is the view where all log text and error messages appear, so it is really important to check the content of the view when something goes wrong.

If the project was executed correctly, you should see the started CardatabaseApplication class in the text at the end of the console. The following screenshot shows the content of the Eclipse console after our Spring Boot project has been started:


Figure 1.10: Eclipse console

You can also run your Spring Boot Gradle project from the command prompt or terminal using the following command (in your project folder):

gradlew bootRun

Copy

Explain
In the root of our project, there is the build.gradle file, which is the Gradle configuration file for our project. If you look at the dependencies inside the file, you can see that there are now dependencies that we selected on the Spring Initializr page. There is also a test dependency included automatically, as illustrated in the following code snippet:

dependencies {
    implementation 'org.springframework.boot:spring-boot-starter-
    web'
    developmentOnly 'org.springframework.boot:spring-boot-
    devtools'
    testImplementation 'org.springframework.boot:spring-boot-
    starter-test'
}

Copy

Explain
In the following chapters, we are going to add more functionality to our application, and then we will add more dependencies manually to the build.gradle file.

Let’s look at the Spring Boot main class more carefully:

package com.packt.cardatabase;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class CardatabaseApplication {
    public static void main(String[] args) {
        SpringApplication.run(CardatabaseApplication.class, args);
    }
}

Copy

Explain
At the beginning of the class, there is the @SpringBootApplication annotation, which is actually a combination of multiple annotations:

Annotation

Description

@EnableAutoConfiguration

This enables Spring Boot’s automatic configuration, so your project will automatically be configured based on dependencies. For example, if you have the spring-boot-starter-web dependency, Spring Boot assumes that you are developing a web application and configures your application accordingly.

@ComponentScan

This enables the Spring Boot component scan to find all the components of your application.

@Configuration

This defines a class that can be used as a source of bean definitions.

Table 1.1: SpringBootApplication annotations

The execution of the application starts from the main() method, as in standard Java applications.

IMPORTANT NOTE

It is recommended that you locate the main application class in the root package above other classes. All packages under the package containing the application class will be covered by Spring Boot’s component scan. A common reason for an application not working correctly is due to Spring Boot being unable to find critical classes.

Spring Boot development tools
Spring Boot development tools make the application development process simpler. The most important feature of the development tools is automatic restart whenever files on the classpath are modified. Projects will include the developer tools if the following dependency is added to the Gradle build.gradle file:

developmentOnly 'org.springframework.boot:spring-boot-devtools'

Copy

Explain
Development tools are disabled when you create a fully packaged production version of your application. You can test automatic restart by adding one comment line to your main class, as follows:

package com.packt.cardatabase;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class CardatabaseApplication {
    public static void main(String[] args) {
        // After adding this comment the application is restarted
        SpringApplication.run(CardatabaseApplication.class, args);
    }
}

Copy

Explain
After saving the file, you can see in the console that the application has restarted.

Logs and problem-solving
Logging can be used to monitor your application flow, and it is a good way to capture unexpected errors in your program code. The Spring Boot starter package provides the Logback, which we can use for logging without any configuration. The following sample code shows how you can use logging. The Logback uses Simple Logging Façade for Java (SLF4J) as its native interface:

package com.packt.cardatabase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
@SpringBootApplication
public class CardatabaseApplication {
    private static final Logger logger = LoggerFactory.getLogger(
        CardatabaseApplication.class
    );
    
    public static void main(String[] args) {
        SpringApplication.run(CardatabaseApplication.class, args);
        logger.info("Application started");
    }
}

Copy

Explain
The logger.info method prints a log message to the console. Log messages can be seen in the console after you run a project, as shown in the following screenshot:


Figure 1.11: Log message

There are seven different levels of logging: TRACE, DEBUG, INFO, WARN, ERROR, FATAL, and OFF. You can configure the level of logging in your Spring Boot application.properties file. The file can be found in the /resources folder inside your project, as illustrated in the following screenshot:


Figure 1.12: Application properties file

If we set the logging level to DEBUG, we can see log messages from levels that are log level DEBUG or higher (that is DEBUG, INFO, WARN, and ERROR). In the following example, we set the log level for the root, but you can also set it at the package level:

logging.level.root=DEBUG

Copy

Explain
Now, when you run the project, you can no longer see TRACE messages. The TRACE level contains all application behavior details, which is not needed unless you need full visibility of what is happening in your application. It might be a good setting for a development version of your application. The default logging level is INFO if you don’t define anything else.

There is one common failure that you might encounter when running a Spring Boot application. Spring Boot uses Apache Tomcat (http://tomcat.apache.org/) as an application server by default, which runs on port 8080 by default. You can change the port in the application.properties file. The following setting will start Tomcat on port 8081:

server.port=8081

Copy

Explain
If the port is occupied, the application won’t start, and you will see the following APPLICATION FAILED TO START message in the console:


Figure 1.13: Port already in use

If this happens, you will have to stop the process that is listening on port 8080 or use another port in your Spring Boot application. You can avoid this by clicking the Terminate button (red square) in the Eclipse console before running the application.

In the next section, we will install a MariaDB database to use as a database in our backend.

Installing MariaDB
In Chapter 3, Using JPA to Create and Access a Database, we are going to use MariaDB, so you will need to install it locally on your computer. MariaDB is a widely used open-source relational database. MariaDB is available for Windows, Linux, and macOS, and you can download the latest stable community server at https://mariadb.com/downloads/community/. MariaDB is developed under a GNU General Public License, version 2 (GPLv2) license.

The following steps guide you to install MariaDB:

For Windows, there is the Microsoft Installer (MSI), which we will use here. Download the installer and execute it. Install all features from the installation wizard, as illustrated in the following screenshot:

Figure 1.14: MariaDB installation (step 1)

In the next step, you should give a password for the root user. This password is needed in the next chapter when we connect our application to the database. The process is illustrated in the following screenshot:

Figure 1.15: MariaDB installation (step 2)

In the next phase, we can use the default settings, as illustrated in the following screenshot:

Figure 1.16: MariaDB installation (step 3)

Now, the installation will start, and MariaDB will be installed on your local computer. The installation wizard will install HeidiSQL for us. This is an easy-to-use, graphical database client. We will use this to add a new database and make queries to our database. You can also use the Command Prompt included in the installation package.
Open HeidiSQL and log in using the password that you gave in the installation phase. You should then see the following screen:

Figure 1.17: HeidiSQL

IMPORTANT NOTE

HeidiSQL is only available for Windows. If you are using Linux or macOS, you can use DBeaver (https://dbeaver.io/) instead.

We now have everything needed to start the implementation of the backend.

Summary
In this chapter, we installed the tools that are needed for backend development with Spring Boot. For Java development, we set up Eclipse, a widely used programming IDE. We created a new Spring Boot project using the Spring Initializr page. After creating the project, it was imported to Eclipse and executed. We also covered how to solve common problems with Spring Boot and how to find important error and log messages. Finally, we installed a MariaDB database, which we are going to use in the following chapters.

In the next chapter, we will understand what dependency injection (DI) is and how it can be used with the Spring Boot framework.

Questions
What is Spring Boot?
What is the Eclipse IDE?
What is Gradle?
How do we create a Spring Boot project?
How do we run a Spring Boot project?
How do we use logging with Spring Boot?
How do we find error and log messages in Eclipse?
Further reading
Packt has other resources for learning about Spring Boot, as listed here:

Learning Spring Boot 3.0, Third Edition, by Greg L. Turnquist (https://www.packtpub.com/product/learning-spring-boot-30-third-edition/9781803233307)
Microservices with Spring Boot 3 and Spring Cloud, Third Edition, by Magnus Larsson (https://www.packtpub.com/product/microservices-with-spring-boot-3-and-spring-cloud-third-edition/9781805128694)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e



| ≪ [ 000 Preface ](/books/packtpub/2024/1202-Spring_Boot_3_React/000_Preface) | 101 Setting Up the Environment and Tools | [ 102 Understanding Dependency Injection ](/books/packtpub/2024/1202-Spring_Boot_3_React/102_Understanding_Dependency_Injection) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 101 Setting Up the Environment and Tools
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/101_Setting_Up_the_Environment_and_Tools
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:21
> .md Name: 101_setting_up_the_environment_and_tools.md

