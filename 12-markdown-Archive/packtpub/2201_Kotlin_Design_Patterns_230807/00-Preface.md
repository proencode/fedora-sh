
Kotlin Design Patterns and Best Practices - Second Edition
4 (1 reviews total)
By Alexey Soshin
$33.99
eBook version
Buy
$41.99
Print + eBook
Buy
About this Book
This book shows you how easy it can be to implement traditional design patterns in the modern multi-paradigm Kotlin programming language, and takes you through the new patterns and paradigms that have emerged. This second edition is updated to cover the changes introduced from Kotlin 1.2 up to 1.5 and focuses more on the idiomatic usage of coroutines, which have become a stable language feature. You'll begin by learning about the practical aspects of smarter coding in Kotlin, as well as understanding basic Kotlin syntax and the impact of design patterns on your code. The book also provides an in-depth explanation of the classical design patterns, such as Creational, Structural, and Behavioral families, before moving on to functional programming. You'll go through reactive and concurrent patterns, and finally, get to grips with coroutines and structured concurrency to write performant, extensible, and maintainable code. By the end of this Kotlin book, you'll have explored the latest trends in architecture and design patterns for microservices. You’ll also understand the tradeoffs when choosing between different architectures and make informed decisions.
Publication date:
1월 2022

Publisher
Packt

Pages
356

ISBN
9781801815727

# Preface

Design patterns enable you as a developer to speed up the development process by providing you with proven development paradigms. Reusing design patterns helps prevent complex issues that can cause major problems, improves your code base, promotes code reuse, and makes an architecture more robust.

The mission of this book is to ease the adoption of design patterns in Kotlin and provide good practices for programmers.

The book begins by showing you the practical aspects of smarter coding in Kotlin, explaining the basic Kotlin syntax and the impact of design patterns. From there, the book provides an in-depth explanation of the classical creational, structural, and behavioral design pattern families, before heading into functional programming. It then takes you through reactive and concurrent patterns, teaching you about using streams, threads, and coroutines to write better code along the way.

By the end of the book, you will be able to efficiently address common problems faced while developing applications and be comfortable working on scalable and maintainable projects of any size.

# Who this book is for

This book is for developers who would like to master design patterns with Kotlin in order to build reliable, scalable, and maintainable applications. Prior programming knowledge is highly advised in order to get started with this book. Prior design pattern knowledge would be helpful, but is not mandatory.

# What this book covers

Chapter 1, Getting Started with Kotlin, covers basic Kotlin syntax and discusses what design patterns are good for and why they should be used in Kotlin. The goal of this chapter is not to cover the entire Kotlin vocabulary but to get you familiar with some basic concepts and idioms. The following chapters will slowly expose you to more language features as they become relevant to the design patterns we'll discuss.

Chapter 2, Working with Creational Patterns, explains all the classical creational patterns. These patterns deal with how and when to create your objects. Mastering these patterns will allow you to manage the life cycle of your objects better and write code that is easy to maintain.

Chapter 3, Understanding Structural Patterns, focuses on how to create hierarchies of objects that are flexible and simple to extend. It covers the Decorator and Adapter patterns, among others.

Chapter 4, Getting Familiar with Behavioral Patterns, covers behavioral patterns with Kotlin. Behavioral patterns deal with how objects interact with one another and how objects can change behavior dynamically. We'll see how objects can communicate efficiently and in a decoupled manner.

Chapter 5, Introducing Functional Programming, covers the basic principles of functional programming and how they fit into the Kotlin programming language. It will cover topics such as immutability, higher-order functions, and functions as values.

Chapter 6, Threads and Coroutines, dives deeper into how to launch new threads in Kotlin and covers the reasons why coroutines can scale much better than threads. We will discuss how the Kotlin compiler treats coroutines and the relationship with coroutine scopes and dispatchers.

Chapter 7, Controlling the Data Flow, covers higher-order functions for collections. We'll see how sequences, channels, and flows apply those functions in a concurrent and reactive manner.

Chapter 8, Designing for Concurrency, explains how concurrent design patterns help us manage many tasks at once and structure their life cycle. By using these patterns efficiently, we can avoiding problems such as resource leaks and deadlocks.

Chapter 9, Idioms and Anti-Patterns, discusses the best and worst practices in Kotlin. You'll learn what idiomatic Kotlin code should look like and also which patterns to avoid. After completing this chapter, you should be able to write more readable and maintainable Kotlin code, as well as avoiding some common pitfalls.

Chapter 10, Concurrent Microservices with Ktor, puts the skills we've learned so far to use by building a microservice using the Kotlin programming language. For that, we'll use the Ktor framework, which was developed by JetBrains.

Chapter 11, Reactive Microservices with Vert.x, demonstrates an alternative approach to building microservices with Kotlin by using the Vert.x framework, which is based on reactive design patterns. We'll discuss the tradeoffs between the approaches, looking at some real code examples, and figure out when to use them.

Assessments contains all the answers to the questions from all the chapters in this book.

# To get the most out of this book

You should have basic knowledge of Java and know what the JVM is. It is also assumed that you are comfortable working with the command line. A few command-line examples we use in this book are based on OS X but could be easily adapted for Windows or Linux.


If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book's GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

Download the example code files
You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/Kotlin-Design-Patterns-and-Best-Practices. If there's an update to the code, it will be updated in the GitHub repository.

We have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

Download the color images
We also provide a PDF file that has color images of the screenshots and diagrams used in this book. You can download it here: https://static.packt-cdn.com/downloads/9781801815727_ColorImages.pdf.

Conventions used
There are a number of text conventions used throughout this book.

Code in text: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: "From the listener side, handling exceptions is as simple as wrapping the collect() function in a try/catch block."

A block of code is set as follows:

val chan = produce(capacity = 10) { 
    (1..10).forEach { 
        send(it) 
    } 
}

Copy

Explain
When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

flow {
    (1..10).forEach {
    ...
        if (it == 9) {
            throw RuntimeException()
        }
    }
}

Copy

Explain
Any command-line input or output is written as follows:

...
4 seconds -> received 30
5 seconds -> received 40
6 seconds -> received 49
...

Copy

Explain
Bold: Indicates a new term, an important word, or words that you see onscreen. For instance, words in menus or dialog boxes appear in bold. Here is an example: "On the next screen, choose JUnit 5 as your Test framework and set Target JVM version to 1.8, then click Finish."

Tips or Important Notes

Appear like this.

Get in touch
Feedback from our readers is always welcome.

General feedback: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

Errata: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

Piracy: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

If you are interested in becoming an author: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

Share Your Thoughts
Once you've read Kotlin Design Patterns and Best Practices, we'd love to hear your thoughts! Please click here to go straight to the Amazon review page for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we're delivering excellent quality content.

Previous Chapter
Next Chapter

