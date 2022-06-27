0i# A/----------------------xx-- @ Q
j0i```/^Copy$ddk0C```/--xx-- @ W
i`/ i`/---------------------xx-- @ E
i`/,i`/---------------------xx-- @ R
i`/\.i`/--------------------xx-- @ T
i`/)i`/---------------------xx-- @ Y

@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/---- @ E^[
@ R -> 찾은 글자 앞뒤로 backtick(`) 붙이기 => i`^[/,^[i`^[/---- @ R^[
@ T -> 찾은 글자 앞뒤로 backtick(`) 붙이기 => i`^[/\.^[i`^[/---- @ T^[
@ Y -> 찾은 글자 앞뒤로 backtick(`) 붙이기 => i`^[/)^[i`^[/---- @ Y^[
    마크다운 입력시 vi 커맨드 표시 ; (^{)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------


> Path: medium/2204_springboot_react_3e/03-101_setting_up_the_environment_and_tools
> Title: 101 Setting Up the Environment and Tools – Backend
> Short Description: By Juha Hinkula Publication date: 4월 2022 Publisher Packt Pages 378 ISBN 9781801816786
> Link: https://subscription.packtpub.com/book/web-development/9781801816786/pref
> tags: spring_boot react
> Images: / medium / 2204_springboot_react_3e /
> create: 2022-06-23 목 04:48:02


# Chapter 1: Setting Up the Environment and Tools – Backend

In this book, we will learn about full stack development using Spring Boot in the backend and React in the frontend. The first half of this book focuses on backend development, and in the second half of the book, we will implement the frontend.

In this chapter, we will set up the environment and tools needed for backend programming with Spring Boot. Spring Boot is a modern Java-based backend framework that makes development faster than with traditional Java-based frameworks. With Spring Boot, you can make a standalone web application that has an embedded application server.

There are a lot of different integrated development environment (IDE) tools that you can use to develop Spring Boot applications. In this chapter, we will install Eclipse, which is an open source IDE for multiple programming languages. We will create our first Spring Boot project by using the Spring Initializr project starter page. The project is then imported into Eclipse and executed. Reading the console log is a crucial skill when developing Spring Boot applications, which we will also cover.

In this chapter, we will look into the following topics:

- Installing Eclipse
- Understanding Maven
- Using Spring Initializr
- Installing MariaDB

# Technical requirements

The Java software development kit (SDK), version 8 or higher, is necessary to use the Eclipse IDE. In this book, we are using the Windows operating system, but all tools are available for Linux and macOS as well.

Download the code for this chapter from GitHub, at https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-and-React/tree/main/Chapter01.

Check out the following video to see the Code in Action: https://bit.ly/3t32Fx6

# Installing Eclipse

Eclipse is an open source programming IDE developed by the Eclipse Foundation. An installation package or installer can be downloaded from https://www.eclipse.org/downloads. Eclipse is available for Windows, Linux, and macOS.

You can either download a ZIP package of Eclipse or an installer package that executes the installation wizard. In the installer, you should select Eclipse IDE for Enterprise Java and Web Developers, as shown in the following screenshot:

![ 101-01 Eclipse installer ](/medium/2204_springboot_react_3e/101-01_eclipse_installer.webp)

If using the ZIP package, you just have to extract the package to your local disk, and it will contain an executable `eclipse.exe` file that you can run by double-clicking on the file. You should download the Eclipse IDE for Enterprise Java and Web Developers package.

Eclipse is an IDE for multiple programming languages, such as Java, C++, and Python. Eclipse contains different perspectives for your needs, which are a set of views and editors in the Eclipse workbench. The following screenshot shows common perspectives for Java development:

![ 101-02 Eclipse workbench ](/medium/2204_springboot_react_3e/101-02_eclipse_workbench.webp)

On the left-hand side, we have Project Explorer, where we can see our project structure and resources. Project Explorer is also used to open files by double-clicking on them. The files will be opened in the editor, which is located in the middle of the workbench. The Console view can be found in the lower section of the workbench. This view is really important because it shows application logging messages.

Important Note

You can get Spring Tool Suite (STS) for Eclipse if you want, but we are not going to use it in this book because the plain Eclipse installation is enough for our purposes. STS is a set of plugins that makes Spring application development simple, and you can find more information about it here: https://spring.io/tools.

Now that we have installed Eclipse, let's take a quick look at what Maven is and how it helps us.

# Understanding Maven

Apache Maven is a software project management tool that makes the software development process simpler and also unifies the development process.

Important Note

You can also use another project management tool called Gradle with Spring Boot, but in this book, we will focus on using Maven.

The basis of Maven is the Project Object Model (POM). The POM is a `pom.xml` file that contains basic information about a project. There are also all the dependencies that Maven should download to be able to build a project.

Basic information about a particular project can be found at the beginning of the `pom.xml` file, which defines—for example—the version of the application, the packaging format, and so on. The minimum version of the `pom.xml` file should contain the following:

- `project` root
- `modelVersion`
- `groupId`—Identifier (ID) of the project group
- `artifactId`—ID of the project (artifact)
- `version`—Version of the project (artifact)

Dependencies are defined in the `dependencies` section, as shown in the following `pom.xml` code:

```
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
    https://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <parent>
<groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-parent
             </artifactId>
        <version>2.5.2</version>
        <relativePath/> <!-- lookup parent from  
                 repository -->
    </parent>
    <groupId>com.packt</groupId>
    <artifactId>cardatabase</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <name>cardatabase</name>
    <description>Demo project for Spring Boot
          </description>
    <properties>
   <java.version>11</java.version>
    </properties>
    <dependencies>
    <dependency>

         <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web
                    </artifactId>
        </dependency>
        <dependency>  
          <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools
                    </artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>
        <dependency>

          <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test
                    </artifactId>
            <scope>test</scope>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>

         <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-maven-plugin
                      </artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

Maven is normally used from the command line, but Eclipse contains embedded Maven, and that handles all the Maven operations we need. Therefore, we are not focusing on Maven command-line usage here. The most important thing is to understand the structure of the `pom.xml` file and how to add new dependencies to it. We will learn how to add dependencies using Spring Initializr in the next section. Later in this book, we will also add new dependencies manually to the `pom.xml` file.

In the next section, we will create our first Spring Boot project and see how we can run it using the Eclipse IDE.

# Using Spring Initializr

We will create our backend project using Spring Initializr, which is a web-based tool that's used to create **Spring Boot** projects. Then, we will learn how to run our Spring Boot project using the Eclipse IDE. At the end of this section, we will also look at how you can utilize Spring Boot logging.

# Creating a project

To create our project using Spring Initalizr, complete the following steps:

1. Open Spring Initializr by navigating to https://start.spring.io using your web browser. You should then see the following page:

![ 101-03 Spring Initializr ](/medium/2204_springboot_react_3e/101-03_spring_initializr.webp)

2. We will generate a **Maven Project** with **Java** and the latest stable **Spring Boot** version. In the **Group** field, we will define our group ID (`com.packt`) that will also become a base package in our Java project. In the **Artifact** field, we will define an artifact ID (`cardatabase`) that will also be the name of our project in Eclipse.

Important Note

Select the correct Java version in Spring Initializr. In this book, we are using Java version 11. You should select the same version that you are using in your Eclipse IDE.

In the upcoming Spring Boot 3 version, the Java baseline is Java 17. But in this book, we are using Spring Boot 2.

3. By clicking the **ADD DEPENDENCIES…** button, we will select the starters and dependencies that are needed in our project. Spring Boot provides starter packages that simplify your Maven configuration. Spring Boot starters are actually a set of dependencies that you can include in your project. You can add dependencies by clicking the **ADD DEPENDENCIES…** button in Spring Initializr. We will start our project by selecting two dependencies—**Spring Web** and **Spring Boot DevTools**. You can type the dependencies into the search field or select from a list that appears, as illustrated in the following screenshot:

![ 101-04 Adding dependencies ](/medium/2204_springboot_react_3e/101-04_adding_dependencies.webp)

The **Spring Boot DevTools** dependency provides us with the Spring Boot developer tools, which provide automatic restart functionality. It makes development much faster because the application is automatically restarted when changes have been saved. The web starter pack is a base for full stack development and provides an embedded Tomcat server. After you have added dependencies, your **Dependencies** section in Spring Initializr should look like this:

![ 101-05 Spring Initializr dependencies ](/medium/2204_springboot_react_3e/101-05_spring_initializr_dependencies.webp)

4. Finally, you have to click on the Generate button, which generates a project starter ZIP package for us.

Next, we will learn how to run our project using the Eclipse IDE.

# Running the project

Perform the following steps to run the Maven project in the Eclipse IDE:

1. Extract the project ZIP package that we created in the previous topic and open Eclipse.
2. We are going to import our project into the Eclipse IDE. To start the import process, select the File | Import menu and the import wizard will be opened. The following screenshot shows the first page of the wizard:

![ 101-06 Import wizard Step 1 ](/medium/2204_springboot_react_3e/101-06_import_wizard_step_1.webp)

3. In the first phase, you should select Existing Maven Projects from the list under the Maven folder, and then go to the next phase by pressing the Next > button. The following screenshot shows the second step of the import wizard:

![ 101-07 Import wizard Step 2 ](/medium/2204_springboot_react_3e/101-07_import_wizard_step_2.webp)

4. In this phase, select the extracted project folder by pressing the **Browse...** button. Then, Eclipse will find the `pom.xml` file from the root of your project folder and show it inside the **Projects** section of the window.
5. Press the **Finish** button to finalize the import. If everything ran correctly, you should see the `cardatabase` project in the Eclipse IDE **Project Explorer**. It takes a while before the project is ready because all the dependencies will be downloaded by Maven after importing them. You can see the progress of the dependency download in the bottom-right corner of Eclipse. The following screenshot shows the Eclipse IDE **Project Explorer** after a successful import:

![ 101-08 Project Explorer ](/medium/2204_springboot_react_3e/101-08_project_explorer.webp)

**Project Explorer** also shows the package structure of our project. In the beginning, there is only one package called `com.packt.cardatabase`. Under that package is our main application class, called `CardatabaseApplication.java`.

6. Now, we don't have any functionality in our application, but we can run it and see whether everything has started successfully. To run the project, open the main class by double-clicking on it, as shown in the following screenshot, and then press the **Run** button in the Eclipse toolbar. Alternatively, you can select the **Run** menu and press **Run as | Java Application**:

![ 101-09 Cardatabase project ](/medium/2204_springboot_react_3e/101-09_cardatabase_project.webp)

You can see the **Console** view open in Eclipse, and that contains important information about the execution of the project. This is the view where all log texts and error messages appear, so it is really important to check the content of the view when something goes wrong.

Now, if the project was executed correctly, you should see the started `CardatabaseApplication` class in the text at the end of the console. The following screenshot shows the content of the Eclipse console after our Spring Boot project has been started:

![ 101-10 Eclipse console ](/medium/2204_springboot_react_3e/101-10_eclipse_console.webp)

In the root of our project, there is the `pom.xml` file, which is the Maven configuration file for our project. If you look at the dependencies inside the file, you can see that there are now dependencies that we selected on the Spring Initializr page. There is also a test dependency included automatically without any selection, as illustrated in the following code snippet:

```
<dependencies>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web
               </artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-devtools</artifactId>
        <scope>runtime</scope>
        <optional>true</optional>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-test
               </artifactId>
        <scope>test</scope>
    </dependency>
</dependencies>
```

In the following chapters, we are going to add more functionality to our application, and then we will add more dependencies manually to the `pom.xml` file.

Let's look at the Spring Boot main class more carefully. At the beginning of the class, there is the `@SpringBootApplication` annotation, which is actually a combination of multiple annotations, such as the following:

![ 101-11 Table SpringBootApplication annotations ](/medium/2204_springboot_react_3e/101-11_table_springbootapplication_annotations.webp)

The following code snippet shows the Spring Boot application's `main` class:

```
package com.packt.cardatabase;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.
SpringBootApplication;
@SpringBootApplication
public class CardatabaseApplication {
    public static void main(String[] args) {
        SpringApplication.run
                   (CardatabaseApplication.class, args);
    }
}
```

The execution of the application starts from the main method, as in standard Java applications.

Important Note

It is recommended that you locate the main application class in the root package above other classes. A common reason for an application not working correctly is due to Spring Boot being unable to find some critical classes.

# Spring Boot development tools

Spring Boot development tools make the application development process simpler. The most important feature of the development tools is automatic restart whenever files on `classpath` are modified. Projects will include the developer tools if the following dependency is added to the Maven `pom.xml` file:

```
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-devtools</artifactId>
    <scope>runtime</scope>
    <optional>true</optional>
</dependency>
```

Development tools are disabled when you create a fully-packed production version of your application. The application is automatically restarted when you make changes to your project's `classpath` files. You can test that by adding one comment line to your `main` class, as follows:

```
package com.packt.cardatabase;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.
SpringBootApplication;
@SpringBootApplication
public class CardatabaseApplication {
    public static void main(String[] args) {
        //  After  adding  this  comment  the  application  is           restarted
        SpringApplication.run
                   (CardatabaseApplication.class, args);
    }
}
```

After saving the file, you can see in the console that the application has restarted.

# Logs and problem solving

Logging can be used to monitor your application flow, and it is a good way to capture unexpected errors in your program code. Spring Boot starter packages provide a logback that we can use for logging without any configuration. The following sample code shows how you can use logging:

```
package com.packt.cardatabase;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.
SpringBootApplication;
@SpringBootApplication
public class CardatabaseApplication {
    private static final Logger logger = 
             LoggerFactory.getLogger
                 (CardatabaseApplication.class);

    public static void main(String[] args) {
        SpringApplication.run
                   (CardatabaseApplication.class, args);
        logger.info("Application started");
    }
}
```

The logger.info method prints a logging message in the console. Logging messages can be seen in the console after you run a project, as shown in the following screenshot:

![ 101-12 Logging message ](/medium/2204_springboot_react_3e/101-12_logging_message.webp)

There are seven different levels of logging: `TRACE`, `DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`, and `OFF`. You can configure the level of logging in your Spring Boot `application.properties` file. The file can be found in the `resources` folder inside your project, as illustrated in the following screenshot:

![ 101-13 Application properties file ](/medium/2204_springboot_react_3e/101-13_application_properties_file.webp)

If we set the logging level to `DEBUG`, we can see log messages from levels that are log level `DEBUG` or higher (that is `DEBUG`, `INFO`, `WARN`, and `ERROR`). In the following example, we set the log level for the root, but you can also set it at the package level:

```
logging.level.root=DEBUG
```

Now, when you run the project, you can't see the TRACE messages anymore. That might be a good setting for a development version of your application. The default logging level is `INFO` if you don't define anything else.

There is one common failure that you might encounter when running a Spring Boot application. Spring Boot uses Apache Tomcat (http://tomcat.apache.org/) as an application server by default. As a default, Tomcat is running on port `8080`. You can change the port in the `application.properties` file. The following setting will start Tomcat on port `8081`:

```
server.port=8081
```

If the port is occupied, the application won't start, and you will see the following message in the console:

![ 101-14 Port already in use ](/medium/2204_springboot_react_3e/101-14_port_already_in_use.webp)

If this happens, you will have to stop the process that is listening on port `8080` or use another port in your Spring Boot application.

In the next section, we will install a MariaDB database to use as a database in our backend.

# Installing MariaDB

In Chapter 3, Using JPA to Create and Access a Database, we are going to use MariaDB, so you will need to install it locally on your computer. MariaDB is a widely used open source relational database. MariaDB is available for Windows and Linux, and you can download the latest stable community version from https://mariadb.com/downloads/. MariaDB is developed under a GNU's Not UNIX (GNU) General Public License version 2 (GPLv2) license. The following steps guides you to install MariaDB:

1. For Windows, there is the Microsoft Installer (MSI) installer, which we will use here. Download the installer and execute it. Install all features from the installation wizard, as illustrated in the following screenshot:

![ 101-15 MariaDB installation Step 1 ](/medium/2204_springboot_react_3e/101-15_mariadb_installation_step_1.webp)

2. In the next step, you should give the password for the root user. This password is needed in the next chapter when we'll connect our application to the database. The process is illustrated in the following screenshot:

![ 101-16 MariaDB installation Step 2 ](/medium/2204_springboot_react_3e/101-16_mariadb_installation_step_2.webp)

3. In the next phase, we can use the default settings, as illustrated in the following screenshot3. :

![ 101-17 MariaDB installation Step 3 ](/medium/2204_springboot_react_3e/101-17_mariadb_installation_step_3.webp)

4. Now, the installation will start, and MariaDB will be installed on your local computer. The installation wizard will install **HeidiSQL** for us. This is a graphical easy-to-use database client. We will use this to add a new database and make queries to our database. You can also use the Command Prompt included in the installation package.
5. Open HeidiSQL and log in using the password that you gave in the installation phase. You should then see the following screen:

![ 101-18 HeidiSQL ](/medium/2204_springboot_react_3e/101-18_heidisql.webp)

We now have everything needed to start the implementation of the backend.

# Summary

In this chapter, we installed the tools that are needed for backend development with Spring Boot. For Java development, we used the Eclipse IDE, which is a widely used programming IDE. We created a new Spring Boot project by using the Spring Initializr page. After creating the project, it was imported to Eclipse and—finally—executed. We also covered how to solve common problems with Spring Boot and how to find important error and log messages. Finally, we installed a MariaDB database that we are going to use in the following chapters.

In the next chapter, we will understand what dependency injection (DI) is and how it can be used with the Spring Boot framework.

# Questions

1. What is Spring Boot?
1. What is the Eclipse IDE?
1. What is Maven?
1. How do we create a Spring Boot project?
1. How do we run a Spring Boot project?
1. How do we use logging with Spring Boot?
1. How do we find error and log messages in Eclipse?

# Further reading

Packt Publishing has other great resources for learning about Spring Boot, as listed here:

- Learning Spring Boot 2.0 - Second Edition by Greg L. Turnquist (https://www.packtpub.com/product/learning-spring-boot-2-0-second-edition/9781786463784)
- Spring 5.0 Projects by Nilang Patel (https://www.packtpub.com/product/spring-5-0-projects/9781788390415)

