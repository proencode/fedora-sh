
| 🏁 1202 Full Stack Development with Spring Boot 3 and React 4Ed | 000 Preface | [ 101 Setting Up the Environment and Tools ](/books/packtpub/2024/1202-Spring_Boot_3_React/101_Setting_Up_the_Environment_and_Tools) ≫ |
|:----:|:----:|:----:|

# 000 Preface

https://subscription.packtpub.com/book/web-development/9781805122463/pref

If you’re an existing Java developer who wants to go full stack or pick up another frontend framework, this book is your concise introduction to React. In this three-part build-along, you’ll create a robust Spring Boot backend, a React frontend, and then deploy them together.

This new edition is updated to Spring Boot 3 and includes expanded content on security and testing. For the first time ever, it also covers React development with the in-demand TypeScript.

You’ll explore the elements that go into creating a REST API and testing, securing, and deploying your applications. You’ll learn about custom Hooks, third-party components, and MUI.

By the end of this book, you’ll be able to build a full stack application using the latest tools and modern best practices.

# Who this book is for

This book is for Java developers who have basic familiarity with Spring Boot but don’t know where to start when it comes to building full stack applications. Basic knowledge of JavaScript and HTML will help you to follow along.

You’ll also find this book useful if you’re a frontend developer with knowledge of JavaScript basics and looking to learn full stack development, or a full stack developer experienced in other technology stacks looking to learn a new one.

# What this book covers

## Part 1: Backend Programming with Spring Boot

*Chapter 1, Setting Up the Environment and Tools – Backend*, explains how to install the software needed in this book for backend development and how to create your first Spring Boot application.

*Chapter 2, Understanding Dependency Injection*, explains the basics of dependency injection and how it is achieved in Spring Boot.

*Chapter 3, Using JPA to Create and Access a Database*, introduces JPA and explains how to create and access databases with Spring Boot.

*Chapter 4, Creating a RESTful Web Service with Spring Boot*, explains how to create RESTful web services using Spring Data REST.

*Chapter 5, Securing Your Backend*, explains how to secure your backend using Spring Security and JWTs.

*Chapter 6, Testing Your Backend, covers testing in Spring Boot*. We will create a few unit and integration tests for our backend and learn about test-driven development.

## Part 2: Frontend Programming with React

*Chapter 7, Setting Up the Environment and Tools – Frontend*, explains how to install the software needed in this book for frontend development.

*Chapter 8, Getting Started with React*, introduces the basics of the React library.

*Chapter 9, Introduction to TypeScript*, covers the basics of TypeScript and how to use it to create React apps.

*Chapter 10, Consuming the REST API with React*, shows how to use REST APIs with React using the Fetch API.

*Chapter 11, Useful Third-Party Components for React*, demonstrates some useful components that we’ll use in our frontend development.

## Part 3: Full Stack Development

*Chapter 12, Setting Up the Frontend for Our Spring Boot RESTful Web Service*, explains how to set up the React app and Spring Boot backend for frontend development.

*Chapter 13, Adding CRUD Functionalities*, shows how to implement CRUD functionalities to the React frontend.

*Chapter 14, Styling the Frontend with MUI*, shows how to polish the user interface using the React MUI component library.

*Chapter 15, Testing Your Frontend*, explains the basics of React frontend testing.

*Chapter 16, Securing Your Application*, explains how to secure the frontend using JWTs.

*Chapter 17, Deploying Your Application*, demonstrates how to deploy an application with AWS and Netlify, and how to use Docker containers.

## To get the most out of this book

You will need Spring Boot version 3.x in this book. All code examples are tested using Spring Boot 3.1 and React 18 on Windows. When installing any React libraries, you should check the latest installation command from their documentation and see whether there are any major changes related to the version used in this book.

The technical requirements for each chapter are stated at the start of the chapter.

> If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book’s GitHub repository at https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition. Doing so will help you avoid any potential errors related to the copying and pasting of code.

## Download the example code files

You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition. If there’s an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

## Download the color images

We also provide a PDF file that has color images of the screenshots and diagrams used in this book. You can download it here: https://packt.link/gbp/9781805122463

## Conventions used

There are a number of text conventions used throughout this book.

`Code in text`: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: “Import `Button` into the `AddCar.js` file.”

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

**Bold**: Indicates a new term, an important word, or words that you see onscreen. For instance, words in menus or dialog boxes appear in **bold**. Here is an example: “You can select the **Run** menu and press Run as | Java Application.”

> IMPORTANT NOTES
> 
> Appear like this.

> TIPS
> 
> Appear like this.
{.is_info}

# Get in touch

Feedback from our readers is always welcome.

**General feedback**: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

**Errata**: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

**Piracy**: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

**If you are interested in becoming an author**: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

## Share your thoughts

Once you’ve read *Full Stack Development with Spring Boot 3 and React, Fourth Edition*, we’d love to hear your thoughts! Please [click here to go straight to the Amazon review pagei](https://packt.link/r/1805122460) for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we’re delivering excellent quality content.

## Download a free PDF copy of this book

Thanks for purchasing this book!

Do you like to read on the go but are unable to carry your print books everywhere?

Is your eBook purchase not compatible with the device of your choice?

Don’t worry, now with every Packt book you get a DRM-free PDF version of that book at no cost.

Read anywhere, any place, on any device. Search, copy, and paste code from your favorite technical books directly into your application.

The perks don’t stop there, you can get exclusive access to discounts, newsletters, and great free content in your inbox daily

Follow these simple steps to get the benefits:

1. Scan the QR code or visit the link below

https://packt.link/free-ebook/9781805122463

2. Submit your proof of purchase
3. That’s it! We’ll send your free PDF and other benefits to your email directly



| 🏁 1202 Full Stack Development with Spring Boot 3 and React 4Ed | 000 Preface | [ 101 Setting Up the Environment and Tools ](/books/packtpub/2024/1202-Spring_Boot_3_React/101_Setting_Up_the_Environment_and_Tools) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 000 Preface
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/000_Preface
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:21
> .md Name: 000_preface.md

