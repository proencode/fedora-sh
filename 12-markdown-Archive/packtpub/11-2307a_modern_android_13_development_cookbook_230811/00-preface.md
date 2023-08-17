

@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/EEEEEEEEEE^[
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(`) 붙이기 => i`^[/.^[i`^[/RRRRRRRRRR^[
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(`) 붙이기 => i`^[/,^[i`^[/TTTTTTTTTT^[
@ Y -> 찾은 글자 ~ COLON 앞뒤로 backtick(`) 붙이기 => i`^[/;^[i`^[/YYYYYYYYYY^[
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(`) 붙이기 => i`^[/)^[i`^[/UUUUUUUUUU^[

@ A -> 빈 줄에 블록 시작하기 => 0C```^[^Mk0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i```^M-^[^M0i```^[0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi```^M^M^[kk
@ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
    마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------


> Title: Modern Android 13 Development Cookbook
> md Path: /packtpub/2307a-modern_android_13_development_cookbook-230811/
> this Chapter: 00-preface.md
> Images Folder: /packtpub/img2307a-modern_android_13_development_cookbook-230811/
> Short Description: By Madona S. Wambua Jul 2023 322 pages
> Link: https://subscription.packtpub.com/book/mobile/9781803235578/pref
> create: 2023-08-17 목 14:25:13

# Preface




/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /


Packt Logo
Browse Library
Search titles …
Sign In
Start Free Trial
Book image
Table of Contents (15 chapters)

Android is a powerful operating system widely used in various devices, phones, TVs, wearables, automobiles, and mor...
By Madona S. Wambua
Jul 2023
322 pages

Modern Android 13 Development Cookbook
Overview of this book
Android is a powerful operating system widely used in various devices, phones, TVs, wearables, automobiles, and more. This Android cookbook will teach you how to leverage the latest Android development technologies for creating incredible applications while making effective use of popular Jetpack libraries. You’ll also learn which critical principles to consider when developing Android apps. The book begins with recipes to get you started with the declarative UI framework, Jetpack Compose, and help you with handling UI states, Navigation, Hilt, Room, Wear OS, and more as you learn what's new in modern Android development. Subsequent chapters will focus on developing apps for large screens, leveraging Jetpack’s WorkManager, managing graphic user interface alerts, and tips and tricks within Android studio. Throughout the book, you'll also see testing being implemented for enhancing Android development, and gain insights into harnessing the integrated development environment of Android studio. Finally, you’ll discover best practices for robust modern app development. By the end of this book, you’ll be able to build an Android application using the Kotlin programming language and the newest modern Android development technologies, resulting in highly efficient applications.

Preface
Free Chapter 1 Chapter 1: Getting Started with Modern Android Development Skills
2 Chapter 2: Creating Screens Using a Declarative UI and Exploring Compose Principles
3 Chapter 3: Handling the UI State in Jetpack Compose and Using Hilt
4 Chapter 4: Navigation in Modern Android Development
5 Chapter 5: Using DataStore to Store Data and Testing
6 Chapter 6: Using the Room Database and Testing
7 Chapter 7: Getting Started with WorkManager
8 Chapter 8: Getting Started with Paging
9 Chapter 9: Building for Large Screens
10 Chapter 10: Implementing Your First Wear OS Using Jetpack Compose
11 Chapter 11: GUI Alerts – What’s New in Menus, Dialog, Toast, Snackbars, and More in Modern Android Development
12 Chapter 12: Android Studio Tips and Tricks to Help You during Development
13 Index
14 Other Books You May Enjoy

00 Preface
01.c1 Getting Started with Modern Android Development Skills
02.c2 Creating Screens Using a Declarative UI and Exploring Compose Principles
03.c3 Handling the UI State in Jetpack Compose and Using Hilt
04.c4 Navigation in Modern Android Development
05.c5 Using DataStore to Store Data and Testing
06.c6 Using the Room Database and Testing
07.c7 Getting Started with WorkManager
08.c8 Getting Started with Paging
09.c9 Building for Large Screens
10.c10 Implementing Your First Wear OS Using Jetpack Compose
11.c11 GUI Alerts – What’s New in Menus, Dialog, Toast, Snackbars, and More in Modern Android Development
12.c12 Android Studio Tips and Tricks to Help You during Development
13 Index
14 Other Books You May Enjoy


# Preface

Modern Android 14 Development Cookbook serves as a comprehensive guide for developers seeking to build cutting-edge Android applications using the latest advancements in technology. Android is the most widely used mobile operating system worldwide, powering billions of devices.

Android 13, the latest major release of the Android platform, introduces several exciting features and enhancements, designed to enhance user experiences, improve performance, and enable developers to create robust and innovative applications. This cookbook focuses on leveraging these new capabilities to build modern, feature-rich Android apps that meet the demands of today’s users.

With the rapid evolution of the Android ecosystem, developers face the challenge of staying up to date with the latest tools, libraries, and best practices. Modern Android 13 Development Cookbook addresses this challenge by providing practical recipes and step-by-step instructions to solve everyday development tasks and implement modern Android app architecture patterns.

As you progress through the recipes in this cookbook, you’ll build new short projects that will expose you to more patterns and components, helping you acquire valuable insights into building modern Android applications. I opted for this approach since this is a cookbook, and building one project for all chapters would have become redundant, so get ready to build. Whether you’re a beginner starting your Android development journey or an experienced developer seeking to level up your skills, Modern Android 13 Development Cookbook is your go-to resource to master the latest techniques and best practices in Android app development.

# Who this book is for

This book is designed to cater to Android developers with one to four years of experience in the field. Whether you’re a junior developer looking to expand your knowledge or a mid-level developer seeking to refine your skills, Modern Android 13 Development Cookbook provides valuable insights and practical solutions to enhance your Android development expertise.

By assuming a foundational understanding of Android development concepts and familiarity with the Android ecosystem, this book delves into more advanced topics and modern development techniques. It serves as a comprehensive resource to help you stay up to date with the latest advancements in Android 13 and learn how to leverage them effectively in your projects.

The cookbook format offers a practical approach, presenting a series of recipes that address everyday development tasks and challenges faced by Android developers. Each recipe provides clear, step-by-step instructions and relevant code examples, allowing you to implement the solutions directly in your projects.

With Modern Android 13 Development Cookbook as your guide, you’ll have the knowledge and skills to tackle Android projects as you advance your skills.

# What this book covers

Chapter 1, Getting Started with Modern Android Development Skills, provides an introduction to Modern Android Development and begins by introducing the basics of Android development, including the Android Studio IDE and the Kotlin programming language. It then goes on to discuss the different components of an Android app, such as creating your first button in Compose, the Android project structure, and utilizing the Gradlew command to run your Android project.

Chapter 2, Creating Screens Using a Declarative UI and Exploring Compose Principles, introduces the concept of a declarative UI and how it can be used to create screens in Android apps. Declarative UI is a way of describing the UI of an app in terms of what it should look like, rather than how it should be implemented. This makes it easier to create complex UIs that are both visually appealing and easy to maintain. The chapter then goes on to explore the fundamental principles of Jetpack Compose, the declarative UI framework for Android, with simple-to-follow projects.

Chapter 3, Handling the UI State in Jetpack Compose and Using Hilt, dives into the essential concepts of handling the UI state and using Hilt in Jetpack Compose, providing you with practical recipes to manage the state and ensure the robustness of your app effectively. By the end of this chapter, you’ll have a solid understanding of ViewModel concepts, Dependency Injection with Hilt, integrating Compose into existing projects, and writing comprehensive tests for both Compose views and ViewModels.

Chapter 4, Navigation in Modern Android Development, delves into the topic of navigation in Compose, exploring various recipes that will equip you with the skills needed to implement efficient and seamless navigation experiences in your Android app. By the end of this chapter, you’ll have a comprehensive understanding of navigation concepts and techniques in Compose, empowering you to build intuitive and interactive user experiences that seamlessly guide users through your app.

Chapter 5, Using Datastore to Store Data and Testing, dives into the essential aspects of implementing and managing DataStore in Android applications. We will cover a range of topics and provide practical recipes to help you become proficient in handling data within your Android projects. By the end of this chapter, you’ll have a comprehensive understanding of implementing DataStore, employing Dependency Injection, choosing between Android Proto DataStore and DataStore, managing data migration, and writing practice tests for your DataStore implementation.

Chapter 6, Using the Room Database and Testing, explores the powerful features of the Room database library and dives into testing strategies to ensure the integrity and functionality of your database-driven Android applications. By the end of this chapter, you’ll have a solid grasp of using the Room database library and testing strategies to ensure the quality and reliability of your database-driven Android applications.

Chapter 7, Getting Started with WorkManager, provides an overview of WorkManager, a powerful Jetpack library that enables efficient and flexible background processing in Android applications. We will cover the fundamental concepts and features of WorkManager, empowering you to incorporate background tasks seamlessly into your projects. By the end of this chapter, you’ll have a solid foundation in using WorkManager, enabling you to integrate efficient and reliable background processing capabilities into your Android applications.

Chapter 8, Getting Started with Paging, provides an introduction to Paging, a powerful Jetpack library that facilitates efficient and seamless data loading in Android applications. We cover the essential concepts and features of Paging, empowering you to implement data pagination and optimize the performance of your app. By the end of this chapter, you’ll have a solid understanding of Paging and its capabilities, enabling you to implement efficient data pagination in your Android applications.

Chapter 9, Building for Large Screens, explores the principles and techniques to design and build Android applications that deliver engaging experiences on foldable and other large screens, such as tablets. We will cover various aspects of adapting your app’s user interface, optimizing layouts, and leveraging the additional screen of real estate effectively as we utilize Material 3. By the end of this chapter, you’ll have a solid understanding of the principles and techniques to design and build Android applications that deliver engaging experiences on large screens.

Chapter 10, Implementing Your First Wear OS Using Jetpack Compose, provides guidance on the process of implementing your first Wear OS app using Jetpack Compose, a modern UI toolkit to build Android applications. We will cover the essential steps and concepts to create engaging and intuitive wearable experiences. By the end of this chapter, you’ll have a grasp of how components are created in Wear OS and be able to run Wear OS on your virtual device.

Chapter 11, GUI Alerts – What’s New in Menus, Dialog, Toast, Snackbars, and More in Modern Android Development, explores the latest enhancements and features in GUI alerts, menus, dialogs, toasts, snackbars, and other user interface components in Modern Android Development. We will cover the advancements that enable developers to create more interactive and engaging user experiences.

Chapter 12, Android Studio Tips and Tricks to Help You during Development, shares a collection of valuable tips and tricks to help you maximize your productivity and efficiency while using Android Studio for Android app development. We will cover the various features, shortcuts, and hidden gems that can streamline your workflow and enhance your development experience.

# To get the most out of this book

You will need to have Java installed on your laptop and Android Studio, which is the IDE we use. We assume that you have knowledge of Java installation and Git source control, since you will need to be able to get most of the code from the Technical requirement section to code along.

| Software/hardware covered in the book | Operating system requirements |
|:----:|:----:|
| Android Studio | Windows, macOS, or Linux |
| Java Version 11 | Android Studio Version |
| Android Studio | Flamingo \| 2022.2.1 Patch 1 |

If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book’s GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

# Download the example code files

You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/Modern-Android-13-Development-Cookbook. If there’s an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Download the color images

We also provide a PDF file that has color images of the screenshots and diagrams used in this book. You can download it here: https://packt.link/HlgRf.

# Conventions used

There are a number of text conventions used throughout this book.

`Code in text`: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: “In our second example, we have two functions, `main()` and `reverseString()`. `main()` takes nothing in its input.”

A block of code is set as follows:

```
fun main() {
    val stringToBeReversed = "Community"
    println(reverseString(stringToBeReversed))
}
fun reverseString(stringToReverse: String): String {
    return stringToReverse.reversed()
}
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

```
data class City(
    val id: Int,
    **@StringRes val nameResourceId: Int,**
    @DrawableRes val imageResourceId: Int
)
```

Any command-line input or output is written as follows:

```
$ git clone git@github.com:PacktPublishing/Modern-Android-13-Development-Cookbook.git
```

**Bold**: Indicates a new term, an important word, or words that you see on screen. For instance, words in menus or dialog boxes appear in **bold**. Here is an example: “Click **Finish** and wait for **Gradle** to sync.”
[I
Tips or important notes

Appear like this.

# Get in touch

Feedback from our readers is always welcome.

**General feedback**: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

**Errata**: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

**Piracy**: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

**If you are interested in becoming an author**: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

# Share Your Thoughts

Once you’ve read **Modern Android 13 Development Cookbook**, we’d love to hear your thoughts! Please select https://www.amazon.in/review/create-review/?asin=1803235578 for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we’re delivering excellent quality content.

# Download a free **PDF** copy of this book

Thanks for purchasing this book!

Do you like to read on the go but are unable to carry your print books everywhere? Is your **eBook** purchase not compatible with the device of your choice?

Don’t worry, now with every Packt book you get a **DRM-free PDF** version of that book at no cost.

Read anywhere, any place, on any device. Search, copy, and paste code from your favorite technical books directly into your application. 

The perks don’t stop there, you can get exclusive access to discounts, newsletters, and great free content in your inbox daily

Follow these simple steps to get the benefits:

1. Scan the **QR code** or visit the link below

![ Scan the QR code ](/packtpub/img2307a-modern_android_13_development_cookbook-230811/00.00-scan_the_qr_code.webp)


https://packt.link/free-ebook/9781803235578

2. Submit your proof of purchase
3. That’s it! We’ll send your free PDF and other benefits to your email directly

Previous Chapter
Next Chapter

