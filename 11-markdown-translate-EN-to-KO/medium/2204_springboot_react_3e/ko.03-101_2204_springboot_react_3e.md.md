



> Path: medium/2204_springboot_react_3e/03-101_setting_up_the_environment_and_tools
> Title: 101 Setting Up the Environment and Tools – Backend
> Short Description: By Juha Hinkula Publication date: 4월 2022 Publisher Packt Pages 378 ISBN 9781801816786
> Link: https://subscription.packtpub.com/book/web-development/9781801816786/pref
> tags: spring_boot react
> Images: / medium / 2204_springboot_react_3e /
> create: 2022-06-23 목 04:48:02

# Chapter 1: Setting Up the Environment and Tools – Backend 환경 및 도구 설정 - 백엔드

In this book, we will learn about full stack development using Spring Boot in the backend and React in the frontend.
이 책에서 뭘 배우냐, Full Stack 개발에 대해서인데 Spring Boot 로 백엔드애 쓰는거와 React 로 프론트엔드아 쓰는거지

The first half of this book focuses on backend development, and in the second half of the book, we will implement the frontend.
책의 앞쪽 반은 백엔드 개발에 초점을 두고 나머지 반은 프론트엔드 구현을 할거야

In this chapter, we will set up the environment and tools needed for backend programming with Spring Boot.
이 장에서 하려는건 환경과 도구인데 어따 쓰냐면 백엔드 프로그래밍의 Spring Boot 용이지

Spring Boot is a modern Java-based backend framework that makes development faster than with traditional Java-based frameworks.
Spring Boot 는 최신 Java 기반 백엔드 프레임워크라서 개발이 훨씬 빨라, 전에쓰던 Java 기반 프레임워크보다.

With Spring Boot, you can make a standalone web application that has an embedded application server.
Spring Boot 를 쓰면 만들수 있는게 스탠드얼론 웹 앱인데 이게 어플리케이션 서버가 내장된 거거든.



There are a lot of different integrated development environment (IDE) tools that you can use to develop Spring Boot applications.
여기엔 여러가지 통합개발환경 IDE 가 있는데 그거 다 쓸 수 있어 Spring Boot 앱 개발할때.

In this chapter, we will install Eclipse, which is an open source IDE for multiple programming languages.
이 장에서 이클립스 설치할건데, 그거 오픈소스 IDE고 여러 프로그래밍에 쓸수 있어.

We will create our first Spring Boot project by using the Spring Initializr project starter page.
이제 만들건 첫번째 Spring Boot 프로젝트고, 뭘로 하냐면 Spring Initalizr 프로젝트 스타터 페이지 를 써.

The project is then imported into Eclipse and executed.
프로젝트는 일단 이클립스로 임포트한 다음에 실행하자

Reading the console log is a crucial skill when developing Spring Boot applications, which we will also cover.
콘솔로그 보는건 중요한 기술이거든? Spring Boot 애플리케이션 개발하려면, 그래서 그것도 다룰거야




In this chapter, we will look into the following topics:
이 장에서는 다음 주제를 살펴 보겠습니다.




- Installing Eclipse
- 일식 설치

- Understanding Maven
- Maven 이해

- Using Spring Initializr
-Spring initializr 사용

- Installing MariaDB
-Mariadb 설치




# Technical requirements
# 기술 요구 사항




The Java software development kit (SDK), version 8 or higher, is necessary to use the Eclipse IDE. In this book, we are using the Windows operating system, but all tools are available for Linux and macOS as well.
Eclipse IDE를 사용하려면 버전 8 이상의 Java Software Development Kit (SDK)가 필요합니다.이 책에서는 Windows 운영 체제를 사용하고 있지만 모든 도구는 Linux 및 MacOS에서도 사용할 수 있습니다.




Download the code for this chapter from GitHub, at https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-and-React/tree/main/Chapter01.
https://github.com/packtpublishing/full-stack-development-with-spring-boot-and-react/tree/main/chapter01 에서이 장의 코드를 다운로드하십시오.




Check out the following video to see the Code in Action: https://bit.ly/3t32Fx6
다음 비디오를 확인하려면 코드를 확인하십시오. https://bit.ly/3t32fx6




# Installing Eclipse
# 일식 설치




Eclipse is an open source programming IDE developed by the Eclipse Foundation. An installation package or installer can be downloaded from https://www.eclipse.org/downloads. Eclipse is available for Windows, Linux, and macOS.
Eclipse는 Eclipse Foundation에서 개발 한 오픈 소스 프로그래밍 IDE입니다.설치 패키지 또는 설치 프로그램은 https://www.eclipse.org/downloads에서 다운로드 할 수 있습니다.Eclipse는 Windows, Linux 및 MacOS에 사용할 수 있습니다.




You can either download a ZIP package of Eclipse or an installer package that executes the installation wizard. In the installer, you should select Eclipse IDE for Enterprise Java and Web Developers, as shown in the following screenshot:
Eclipse의 Zip 패키지 또는 설치 마법사를 실행하는 설치 프로그램 패키지를 다운로드 할 수 있습니다.설치 프로그램에서 다음 스크린 샷과 같이 Enterprise Java 및 웹 개발자 용 Eclipse IDE를 선택해야합니다.




![ 101.00 Eclipse installer ](/medium/2204_springboot_react_3e/101.00_eclipse_installer.webp)




If using the ZIP package, you just have to extract the package to your local disk, and it will contain an executable `eclipse.exe` file that you can run by double-clicking on the file. You should download the Eclipse IDE for Enterprise Java and Web Developers package.
Zip 패키지를 사용하는 경우 패키지를 로컬 디스크로 추출하면 파일에서 두 번 클릭하여 실행할 수있는 실행 파일이 포함됩니다.Enterprise Java 및 Web Developers 패키지 용 Eclipse IDE를 다운로드해야합니다.




Eclipse is an IDE for multiple programming languages, such as Java, C++, and Python. Eclipse contains different perspectives for your needs, which are a set of views and editors in the Eclipse workbench. The following screenshot shows common perspectives for Java development:
Eclipse는 Java, C ++ 및 Python과 같은 여러 프로그래밍 언어의 IDE입니다.Eclipse에는 Eclipse Workbench의 견해 및 편집자 인 귀하의 요구에 대한 다양한 관점이 포함되어 있습니다.다음 스크린 샷은 Java 개발에 대한 일반적인 관점을 보여줍니다.




![ 101.01 Eclipse workbench ](/medium/2204_springboot_react_3e/101.01_eclipse_workbench.webp)
! [101.01 Eclipse Workbench] (/medium/2204_springboot_react_3e/101.01_eclipse_workbench.webp)




On the left-hand side, we have Project Explorer, where we can see our project structure and resources. Project Explorer is also used to open files by double-clicking on them. The files will be opened in the editor, which is located in the middle of the workbench. The Console view can be found in the lower section of the workbench. This view is really important because it shows application logging messages.
왼쪽에는 프로젝트 탐색기가있어 프로젝트 구조와 리소스를 볼 수 있습니다.Project Explorer는 파일을 두 번 클릭하여 파일을 여는 데 사용됩니다.파일은 워크 벤치 중간에있는 편집기에서 열립니다.콘솔보기는 워크 벤치의 하단 섹션에서 찾을 수 있습니다.이보기는 응용 프로그램 로깅 메시지를 보여주기 때문에 정말 중요합니다.




Important Note
중요 사항




You can get Spring Tool Suite (STS) for Eclipse if you want, but we are not going to use it in this book because the plain Eclipse installation is enough for our purposes. STS is a set of plugins that makes Spring application development simple, and you can find more information about it here: https://spring.io/tools.
원한다면 Eclipse 용 STS (Spring Tool Suite)를 얻을 수 있지만 일반 Eclipse 설치가 우리의 목적을 위해 충분하기 때문에이 책에서는 사용하지 않을 것입니다.STS는 Spring Application Development를 간단하게 만드는 플러그인 세트이며 여기에서는 https://spring.io/tools에서 자세한 정보를 찾을 수 있습니다.




Now that we have installed Eclipse, let's take a quick look at what Maven is and how it helps us.
이제 우리는 Eclipse를 설치 했으므로 Maven이 무엇인지, 그것이 어떻게 도움이되는지 간단히 살펴 보겠습니다.




# Understanding Maven
# Maven 이해




Apache Maven is a software project management tool that makes the software development process simpler and also unifies the development process.
Apache Maven은 소프트웨어 개발 프로세스를 더 간단하게 만들고 개발 프로세스를 통합하는 소프트웨어 프로젝트 관리 도구입니다.




Important Note
중요 사항




You can also use another project management tool called Gradle with Spring Boot, but in this book, we will focus on using Maven.
Spring Boot와 함께 Gradle이라는 다른 프로젝트 관리 도구를 사용할 수도 있지만이 책에서는 Maven 사용에 중점을 둘 것입니다.




The basis of Maven is the Project Object Model (POM). The POM is a `pom.xml` file that contains basic information about a project. There are also all the dependencies that Maven should download to be able to build a project.
Maven의 기초는 POM (Project Object Model)입니다.POM은 프로젝트에 대한 기본 정보가 포함 된`pom.xml` 파일입니다.프로젝트를 구축하기 위해 Maven이 다운로드 해야하는 모든 의존성도 있습니다.




Basic information about a particular project can be found at the beginning of the `pom.xml` file, which defines—for example—the version of the application, the packaging format, and so on. The minimum version of the `pom.xml` file should contain the following:
특정 프로젝트에 대한 기본 정보는`pom.xml` 파일의 시작 부분에서 찾을 수 있으며, 예를 들어 응용 프로그램 버전, 포장 형식 등을 정의합니다.`pom.xml` 파일의 최소 버전에는 다음이 포함되어야합니다.




- `project` root
-`project` 루트

- `modelVersion`
-`modelversion '

- `groupId`—Identifier (ID) of the project group
-`GroupId`— 프로젝트 그룹의 식별자 (ID)

- `artifactId`—ID of the project (artifact)
-`artifactid ' - 프로젝트 (Artifact)

- `version`—Version of the project (artifact)
-`버전 ' - 프로젝트의 버전 (Artifact)




Dependencies are defined in the `dependencies` section, as shown in the following `pom.xml` code:
종속성은 다음`pom.xml` 코드와 같이 '종속성'섹션에 정의되어 있습니다.




```
```

<?xml version="1.0" encoding="UTF-8"?>
<? xml 버전 = "1.0"encoding = "utf-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" 
<project xmlns = "http://maven.apache.org/pom/4.0.0"

    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
xmlns : xsi = "http://www.w3.org/2001/xmlschema-instance"

    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
xsi : schemalocation = "http://maven.apache.org/pom/4.0.0

    https://maven.apache.org/xsd/maven-4.0.0.xsd">
https://maven.apache.org/xsd/maven-4.0.0.xsd ">

    <modelVersion>4.0.0</modelVersion>
<modelversion> 4.0.0 </modelversion>

    <parent>
<부모>

<groupId>org.springframework.boot</groupId>
<groupid> org.springframework.boot </groupid>

      <artifactId>spring-boot-starter-parent
<artifactid> 스프링 부트 스타터 부모

             </artifactId>
</artifactid>

        <version>2.5.2</version>
<버전> 2.5.2 </버전>

        <relativePath/> <!-- lookup parent from  
<realiveativePath/> <!- 조회 부모

                 repository -->
저장소 ->

    </parent>
</부모>

    <groupId>com.packt</groupId>
<groupid> com.packt </groupid>

    <artifactId>cardatabase</artifactId>
<itifactid> 카 다타베이스 </artifactid>

    <version>0.0.1-SNAPSHOT</version>
<버전> 0.0.1-snapshot </version>

    <name>cardatabase</name>
<NAME> 카타베이스 </name>

    <description>Demo project for Spring Boot
<설명> 스프링 부트의 데모 프로젝트

          </description>
</description>

    <properties>
<속성>

   <java.version>11</java.version>
<java.version> 11 </java.version>

    </properties>
</속성>

    <dependencies>
<의존성>

    <dependency>
<의존성>

