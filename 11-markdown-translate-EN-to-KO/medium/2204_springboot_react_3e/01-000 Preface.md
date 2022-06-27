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


> Path: medium/2204_springboot_react_3e/01-000-preface
> Title: 000 Preface
> Short Description: By Juha Hinkula Publication date: 4월 2022 Publisher Packt Pages 378 ISBN 9781801816786
> Link: https://subscription.packtpub.com/book/web-development/9781801816786/pref
> tags: spring_boot react
> Images: / medium / 2204_springboot_react_3e /
> create: 2022-06-22 수 17:09:15

# Preface

Getting started with full stack development can be daunting. Even developers who are familiar with the best tools, such as Spring Boot and React, can struggle to nail the basics, let alone master the more advanced elements. If you're one of these developers, this comprehensive guide covers everything you need!

This updated edition of the Full Stack Development with Spring Boot and React book will take you from novice to proficient in this expansive domain. Taking a practical approach, this book will first walk you through the latest Spring Boot features for creating a robust backend, covering everything from setting up the environment and dependency injection to security and testing.

Once this has been covered, you'll advance to React frontend programming. If you've ever wondered about custom Hooks, third-party components, and MUI, this book will demystify all that and much more. You'll explore everything that goes into developing, testing, securing, and deploying your applications using all the latest tools from Spring Boot, React, and other cutting-edge technologies.

By the end of this book, you'll not only have learned the theory of building modern full stack applications but also have developed valuable skills that add value in any setting.

# Who this book is for

This book is for Java developers who are familiar with Spring Boot but don't know where to start when it comes to building full stack applications. You'll also find this book useful if you're a frontend developer with knowledge of JavaScript basics, looking to learn full stack development, or a full stack developer experienced in other technology stacks, looking to learn a new one.

# What this book covers

Chapter 1, Setting Up the Environment and Tools – Backend, explains how to install the software needed for backend development and how to create your first Spring Boot application.

Chapter 2, Understanding Dependency Injection, explains the basics of dependency injection.

Chapter 3, Using JPA to Create and Access a Database, introduces JPA and explains how to create and access databases with Spring Boot.

Chapter 4, Creating a RESTful Web Service with Spring Boot, explains how to create RESTful web services using Spring Data REST.

Chapter 5, Securing and Testing Your Backend, explains how to secure your backend using Spring Security and JWT.

Chapter 6, Setting Up the Environment and Tools – Frontend, explains how to install the software needed for frontend development.

Chapter 7, Getting Started with React, introduces the basics of the React library.

Chapter 8, Consuming the REST API with React, shows how to use REST APIs with React using the Fetch API.

Chapter 9, Useful Third-Party Components for React, demonstrates some useful components that we'll use in our frontend development.

Chapter 10, Setting up the Frontend for Our Spring Boot RESTful Web Service, explains how to set up the React app and Spring Boot backend for frontend development.

Chapter 11, Adding CRUD Functionalities, shows how to implement CRUD functionalities to the React frontend.

Chapter 12, Styling the Frontend with React MUI, shows how to polish the user interface using the React MUI component library.

Chapter 13, Testing Your Frontend, explains the basics of React frontend testing.

Chapter 14, Securing Your Application, explains how to secure the frontend using JWT.

Chapter 15, Deploying Your Application, demonstrates how to deploy an application to Heroku and how to use Docker containers.

Chapter 16, Best Practices, explains the basic technologies that are needed to become a full stack developer and covers some basic best practices for software development.

# To get the most out of this book

You will need Spring Boot version 2.x in this book. There are some major changes in the upcoming Spring Boot version 3 that are mentioned in the book. All code examples are tested using Spring Boot 2.6 and React 18 on Windows. When installing any React libraries, you should check the latest installation command from their documentation and see whether there are any major changes related to the version used in this book.

![ 000-01 that are mentioned in the book ](/medium/2204_springboot_react_3e/000-01_that_are_mentioned_in_the_book.png)

If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book's GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

# Download the example code files

You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-and-React. If there's an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Code in Action

The Code in Action videos for this book can be viewed at https://bit.ly/3t3Qe4r .

# Download the color images

We also provide a PDF file that has color images of the screenshots and diagrams used in this book. You can download it here: https://static.packt-cdn.com/downloads/9781801816786_ColorImages.pdf.

# Conventions used

There are a number of text conventions used throughout this book.

`Code in text`: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: "Import `Button` to the `AddCar.js` file."

A block of code is set as follows:

```
<dependency>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

```
public class Car { 
    @Id 
    @GeneratedValue(strategy=GenerationType.AUTO) 
    private long id; 
    private String brand, model, color, registerNumber; 
    private int year, price; 
}
```

Any command-line input or output is written as follows:

```
npm install component_name
```

**Bold**: Indicates a new term, an important word, or words that you see onscreen. For instance, words in menus or dialog boxes appear in **bold**. Here is an example: "You can select the **Run** menu and press **Run as** | **Java Application**."

Tips or Important Notes

Appear like this.

# Get in touch

Feedback from our readers is always welcome.

General feedback: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

Errata: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

Piracy: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

If you are interested in becoming an author: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

# Share Your Thoughts

Once you've read Full Stack Development with Spring Boot and React, we'd love to hear your thoughts! Please select https://www.amazon.in/review/create-review/error?asin=1801816786 for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we're delivering excellent quality content.

