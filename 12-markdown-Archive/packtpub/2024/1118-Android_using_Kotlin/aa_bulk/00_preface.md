

| 🏁 1118 Thriving in Android Development Using Kotlin | 00 Preface | [ 01 Pt1-Creating WhatsPackt, a Messaging App ](/books/packtpub_2024/1118-Android_using_Kotlin/01_Pt1-Creating_WhatsPackt_a_Messaging_App) ≫ |
|:----:|:----:|:----:|

`Kotlin을 사용한 Android 개발 추진`

프로덕션 급 앱 개발을위한 최신 Android 기능 사용에 대한 프로젝트 기반 안내서
게마 소코로 로드리게스 / 2024 년 7 월 / 410 페이지 / 제 1 판
2024-11-18 월 입력시작년월일

`Thriving in Android Development Using Kotlin`
( Android using Kotlin )

A project-based guide to using the latest Android features for developing production-grade apps
Gema Socorro Rodríguez / Jul 2024 / 410 pages / 1st Edition

```
00 Preface
01 Part 1: Creating WhatsPackt, a Messaging App
02 Chapter 1: Building the UI for Your Messaging App
03 Chapter 2: Setting Up WhatsPackt’s Messaging Abilities
04 Chapter 3: Backing Up Your WhatsPackt Messages
05 Part 2: Creating Packtagram, a Photo Media App
06 Chapter 4: Building the Packtagram UI
07 Chapter 5: Creating a Photo Editor Using CameraX
08 Chapter 6: Adding Video and Editing Functionality to Packtagram
09 Part 3: Creating Packtflix, a Video Media App
10 Chapter 7: Starting a Video Streaming App and Adding Authentication
11 Chapter 8: Adding Media Playback to Packtflix with ExoPlayer
12 Chapter 9: Extending Video Playback in Your Packtflix App
13 Index
14 Other Books You May Enjoy
```


# 00 Preface
https://subscription.packtpub.com/book/mobile/9781837631292/pref

As an Android developer, I consider myself honored to be part of a community that has the power to touch and improve the lives of users worldwide. Android development is not just about writing code; it’s also about creating experiences that resonate, inspire, and connect people in meaningful ways. I have to recognize that my passion for Android development stems from the profound impact we, as developers, can have on individuals and communities.

The Android community is a vibrant and dynamic ecosystem, characterized by innovation, collaboration, and a relentless pursuit of excellence. From the early days of simple apps to the complex, feature-rich applications of today, Android developers have continuously pushed the boundaries of what is possible. This book is a tribute to that spirit of innovation. It aims to help you gather the skills and knowledge to build applications that offer real value to users.

Whether you are creating messaging apps, social networking platforms, or video streaming services, as we will do in this book, the core principles of Android development remain the same – a commitment to quality, a focus on user experience, and an eagerness to learn and adapt. As you embark on this journey, remember that you are part of a global community of developers who share your passion and dedication. Together, we can continue to innovate and create apps that make a difference in the world.

# Who this book is for
If you are a mid-level Android engineer, this book is for you, as it will teach you how to solve issues that occur in real-world apps and can be used as a reference for your day-to-day work. This book can also help junior engineers, as it will start exposing them to complex problems and the best practices to solve them.

It will be beneficial to have a basic understanding of Android and Kotlin concepts such as Views, Activities, lifecycles, and Kotlin coroutines.

# What this book covers
In Chapter 1, Building the UI for Your Messaging App, you will begin by building the WhatsPackt messaging app, focusing on making critical technical decisions and creating the necessary structure for development. This chapter will guide you through defining the app’s structure and navigation, setting up and organizing modules, and selecting a dependency injection framework. You will also gain hands-on experience with Jetpack Navigation and Jetpack Compose to build the main screen, chats list, and messages list, resulting in a solid foundation for the app’s user interface.

In Chapter 2, Setting Up WhatsPackt’s Messaging Abilities, you will explore how to connect the WhatsPackt messaging app to a backend server using WebSockets, enabling real-time, one-to-one conversations. This chapter covers establishing WebSocket connections, handling messages within ViewModels, and implementing best practices to update the user interface and manage message storage. Additionally, you will learn to manage synchronization and error handling and implement push notifications to alert users of new messages. By the end of this chapter, you will have a comprehensive understanding of the essential technologies needed to create a robust messaging system.

In Chapter 3, Backing Up Your WhatsPackt Messages, you will focus on data handling and persistence in the WhatsPackt messaging app, ensuring messages are stored correctly and can be quickly retrieved, even in the event of device failures or accidental deletions. This chapter introduces Room, a persistence library that simplifies database management in Android, and guides you through its architecture and implementation. You will also learn to create effective caching mechanisms, set up and secure Cloud Storage for Firebase for backups, and use WorkManager to schedule asynchronous tasks, ensuring the safety and reliability of your chat data. By the end of this chapter, you’ll have a robust data persistence strategy for your messaging app.

In Chapter 4, Building the Packtagram UI, you will begin creating Packtagram, an Instagram-like social networking app, starting with setting up a robust project structure and defining the file hierarchy and modules. This chapter covers the essential aspects of project organization and choosing the right architecture pattern for scalability. You will then develop user-friendly interfaces for the news feed and stories, ensuring seamless navigation and interaction. Additionally, you will learn to retrieve data from servers, using Retrofit and Moshi, and implement effective data caching strategies to improve performance and user experience by reducing network calls.

In Chapter 5, Creating a Photo Editor Using CameraX, you will enhance the Packtagram app by integrating CameraX, a powerful tool for seamless photo capturing and editing. This chapter will guide you through implementing CameraX to transform the photography experience, allowing users to tweak and personalize their shots with intuitive editing tools. Additionally, you will explore using machine learning to recognize photo themes and suggest relevant hashtags, adding an intelligent layer to the app’s functionality.

In Chapter 6, Adding Video and Editing Functionality to Packtagram, you will elevate the Packtagram app functionality by integrating video capabilities, transforming it into a comprehensive multimedia platform. This chapter covers capturing high-quality videos using the CameraX library and enhancing them with FFmpeg to process tasks, such as adding captions and filters. You will also learn to efficiently upload videos to Cloud Storage for Firebase, ensuring the smooth handling of large files and an improved user experience. By the end of this chapter, you will have significantly enriched Packtagram, making it a versatile platform for both photo and video sharing.

In Chapter 7, Starting a Video Streaming App and Adding Authentication, you will begin creating Packtflix, a video streaming app, focusing on multimedia content delivery and user authentication. This chapter starts with setting up the project structure and modules from scratch. You’ll implement robust user authentication using OAuth2 to ensure secure access to accounts and personal preferences. Following authentication, you’ll use Jetpack Compose to build dynamic and responsive lists to showcase movies and create detailed screens for each movie or series, providing users with all the necessary information. By the end of this chapter, you’ll have a solid foundation for your streaming app.

In Chapter 8, Adding Media Playback to Packtflix with ExoPlayer, you will enhance the Packtflix app by integrating robust video playback capabilities using ExoPlayer, a versatile library offering extensive customization and support for various media formats. This chapter begins with an overview of media options in Android, highlighting ExoPlayer’s advantages. You will learn the basics of ExoPlayer, including its architecture and key components, and how to integrate it into your app. Following this, you will create a responsive video playback UI, manage playback controls, and adjust video quality. Additionally, you will add subtitles to ensure accessibility, enriching the user experience with high-quality video content.

In Chapter 9, Extending Video Playback in Your Packtflix App, you will expand the capabilities of the Packtflix app with extended video playback features, focusing on Picture-in-Picture (PiP) mode and media casting. This chapter will guide you through creating a miniature video player that overlays other apps, allowing users to continue watching while multitasking. Additionally, you will learn to use MediaRouter and the Cast SDK to transfer video playback to larger screens, such as TVs with Google Chromecast. By the end of this chapter, you’ll have a solid understanding of PiP functionalities and media casting, significantly improving the user experience of your Android app.

# To get the most out of this book
| Software/hardware covered in the book | Operating system requirements |
|:----|:----|
| Android Studio Jellyfish : 2023.3.1 | Windows, macOS, or Linux |

You will need to have Android Studio installed on your computer, as it will be the primary development environment used throughout the chapters. Additionally, a basic understanding of Git is recommended, as you will need it to download and manage the code repositories provided in the book.

If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book’s GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

# Download the example code files
You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/Thriving-in-Android-Development-using-Kotlin. If there’s an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Conventions used
There are a number of text conventions used throughout this book.

`Code in text`: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: “For example, in the `build.gradle` file of the `:app` module, include the following code in the `dependencies` section.”

A block of code is set as follows:
```
class MessagesRepository @Inject constructor(    private val dataSource: MessagesSocketDataSource ): IMessagesRepository {    override suspend fun getMessages(): Flow<Message> {        return dataSource.connect()    }
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:
```
Scaffold(
    topBar = {
        TopAppBar(
            title = {
               Text(stringResource(R.string.chat_title,
               uiState.name.orEmpty()))
            }
        )
    },
```

**Bold**: Indicates a new term, an important word, or words that you see on screen. For instance, words in menus or dialog boxes appear in **bold**. Here is an example: “Android Studio will offer us a set of templates to start with. We will choose the **Empty Activity** option, as shown in the following screenshot:”

Tips or important notes

Appear like this.

# Get in touch
Feedback from our readers is always welcome.

**General feedback**: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

**Errata**: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

**Piracy**: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packtpub.com with a link to the material.

**If you are interested in becoming an author**: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

# Share Your Thoughts
Once you’ve read Thriving in Android Development Using Kotlin, we’d love to hear your thoughts! Please click here to go straight to the Amazon review page for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we’re delivering excellent quality content.

# Download a free PDF copy of this book
Thanks for purchasing this book!

Do you like to read on the go but are unable to carry your print books everywhere?

Is your eBook purchase not compatible with the device of your choice?

Don’t worry, now with every Packt book you get a DRM-free PDF version of that book at no cost.

Read anywhere, any place, on any device. Search, copy, and paste code from your favorite technical books directly into your application.

The perks don’t stop there, you can get exclusive access to discounts, newsletters, and great free content in your inbox daily

Follow these simple steps to get the benefits:

1. Scan the QR code or visit the link below

https://packt.link/free-ebook/9781837631292

2. Submit your proof of purchase
1. That’s it! We’ll send your free PDF and other benefits to your email directly


| 🏁 1118 Thriving in Android Development Using Kotlin | 00 Preface | [ 01 Pt1-Creating WhatsPackt, a Messaging App ](/books/packtpub_2024/1118-Android_using_Kotlin/01_Pt1-Creating_WhatsPackt_a_Messaging_App) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 00 Preface
> (2) Short Description: Android using Kotlin
> (3) Path: books/packtpub_2024/1118-Android_using_Kotlin/00_Preface
> Book Jemok: Thriving in Android Development Using Kotlin
> AuthorDate: Gema Socorro Rodríguez / Jul 2024 / 410 pages 1Ed
> Link: https://subscription.packtpub.com/book/mobile/9781837631292/pref
> create: 2024-11-19 화 12:29:06
> .md Name: 00_preface.md

