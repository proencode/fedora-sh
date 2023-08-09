
How to Build Android Apps with Kotlin - Second Edition
By Alex Forrester, Eran Boudjnah, Alexandru Dumbravan, and 2 more
$39.99
eBook version
Buy
$49.99
Print + eBook
Buy
About this Book
Looking to kick-start your app development journey with Android 13, but don’t know where to start? How to Build Android Apps with Kotlin is a comprehensive guide that will help jump-start your Android development practice. This book starts with the fundamentals of app development, enabling you to utilize Android Studio and Kotlin to get started with building Android projects. You'll learn how to create apps and run them on virtual devices through guided exercises. Progressing through the chapters, you'll delve into Android's RecyclerView to make the most of lists, images, and maps, and see how to fetch data from a web service. You'll also get to grips with testing, learning how to keep your architecture clean, understanding how to persist data, and gaining basic knowledge of the dependency injection pattern. Finally, you'll see how to publish your apps on the Google Play store. You'll work on realistic projects that are split up into bitesize exercises and activities, allowing you to challenge yourself in an enjoyable and attainable way. You'll build apps to create quizzes, read news articles, check weather reports, store recipes, retrieve movie information, and remind you where you parked your car. By the end of this book, you'll have the skills and confidence to build your own creative Android applications using Kotlin.
Publication date:
5월 2023

Publisher
Packt

Pages
704

ISBN
9781837634934

# Preface

Android has ruled the app market for the past decade, and developers are increasingly looking to start building their own Android apps. How to Build Android Apps with Kotlin starts with the building blocks of Android development, teaching you how to use Android Studio, the **integrated development environment** (**IDE**) for Android, with the Kotlin programming language for app development.

Then, you’ll learn how to create apps and run them on virtual devices using guided exercises. You’ll cover the fundamentals of Android development, from structuring an app to building out the UI with activities, fragments, and various navigation patterns. Progressing through the chapters, you’ll delve into Android’s RecyclerView to make the most of displaying lists of data and become comfortable with fetching data from a web service and handling images.

You’ll then learn about mapping, location services, and the permissions model before working with notifications and how to persist data. Next, you’ll build user interfaces using Jetpack Compose. Moving on, you’ll get to grips with testing, covering the full spectrum of the test pyramid. You’ll also learn how Android Architecture Components (AAC) is used to cleanly structure your code and explore various architecture patterns and the benefits of dependency injection.

Coroutines and the Flow API are covered for asynchronous programming. The focus then returns to the UI, demonstrating how to add motion and transitions when users interact with your apps. Toward the end, you’ll build an interesting app to retrieve and display popular movies from a movie database, and then see how to publish your apps on Google Play.

By the end of this book, you’ll have the skills and confidence needed to build fully-fledged Android apps using Kotlin.

# Who this book is for

If you want to build your own Android apps using Kotlin but are unsure of how to begin, then this book is for you. A basic understanding of the Kotlin programming language will help you grasp the topics covered in this book more quickly.

# What this book covers

Chapter 1, Creating Your First App, shows how to use Android Studio to build your first Android app. Here, you will create an Android Studio project, understand what it’s made up of, and explore the tools necessary for building and deploying an app on a virtual device. You will also learn about the structure of an Android app.

Chapter 2, Building User Screen Flows, dives into the Android ecosystem and the building blocks of an Android application. Concepts such as activities and their lifecycle, intents, and tasks will be introduced, as well as restoring the state and passing data between screens or activities.

Chapter 3, Developing the UI with Fragments, teaches you the fundamentals of using fragments for the user interface of an Android application. You will learn how to use fragments in multiple ways to build application layouts for phones and tablets, including using the Jetpack Navigation component.

Chapter 4, Building App Navigation, goes through the different types of navigation in an application. You will learn about navigation drawers with sliding layouts, bottom navigation, and tabbed navigation.

Chapter 5, Essential Libraries: Retrofit, Moshi, and Glide, gives you an insight into how to build apps that fetch data from a remote data source with the use of the Retrofit library and the Moshi library to convert data into Kotlin objects. You will also learn about the Glide library, which loads remote images into your app.

Chapter 6, Adding and Interacting with RecyclerView, introduces the concept of building lists and displaying them with the help of the RecyclerView widget.

Chapter 7, Android Permissions and Google Maps, presents the concept of permissions and how to request them from the user in order for your app to execute specific tasks, as well as introducing you to the Maps API.

Chapter 8, Services, WorkManager, and Notifications, details the concept of background work in an Android app and how you can have your app execute certain tasks in a way that is invisible to the user, as well as covering how to show a notification of this work.

Chapter 9, Building User Interfaces Using Jetpack Compose, shows how Jetpack Compose works, how to apply styles and themes, and how to use Jetpack Compose in projects started with layout files.

Chapter 10, Unit Tests and Integration Tests with JUnit, Mockito, and Espresso, teaches you about the different types of tests for an Android application, what frameworks are used for each type of test, and the concept of test-driven development.

Chapter 11, Android Architecture Components, provides an insight into components from the Android Jetpack libraries, such as ViewModel, which will help separate the business logic from the user interface code. We will then look at how we can use observable data streams such as LiveData to deliver data to the user interface. Finally, we will look at the Room library to analyze how we can persist data.

Chapter 12, Persisting Data, shows you the various ways to store data on a device, from SharedPreferences to files. The Repository concept will also be introduced, giving you an idea of how to structure your app in different layers.

Chapter 13, Dependency Injection with Dagger, Hilt, and Koin, explains the concept of dependency injection and the benefits it provides to an application. Frameworks such as Dagger, Hilt, and Koin are introduced to help you manage your dependencies.

Chapter 14, Coroutines and Flow, introduces you to doing background operations and data manipulations with coroutines and Flow. You’ll also learn about manipulating and displaying data using Flow operators and LiveData transformation.

Chapter 15, Architecture Patterns, explains the architecture patterns you can use to structure your Android projects to separate them into different components with distinct functionality. These make it easier for you to develop, test, and maintain your code.

Chapter 16, Animations and Transitions with CoordinatorLayout and MotionLayout, discusses how to enhance your apps with animations and transitions with `CoordinatorLayout` and `MotionLayout`.

Chapter 17, Launching Your App on Google Play, concludes this book by showing you how to publish your apps on Google Play: from preparing a release to creating a Google Play Developer account, and finally launching your app.

# To get the most out of this book

Each great journey begins with a humble step. Before we can do awesome things in Android, we need to be prepared with a productive environment. In this section, we will see how to do that.

## Minimum hardware requirements

For an optimal learning experience, we recommend the following hardware configuration:

- Processor: Intel Core i5 or equivalent or higher
- Memory: 8 GB RAM or more
- Storage: 8 GB available space minimum

## Software requirements

You’ll also need the following software installed in advance:

- OS: 64-bit Windows 8/10/11, macOS, or 64-bit Linux
- Android Studio Electric Eel or higher

## Installation and setup

Before you start this book, you will need to install Android Studio Electric Eel (or higher), which is the software you will be using throughout the chapters. You can download Android Studio from https://developer.android.com/studio.

On macOS, launch the DMG file and drag and drop Android Studio into the `Applications` folder. Once this is done, open Android Studio. On Windows, launch the EXE file. If you’re using Linux, unpack the ZIP file into your preferred location. Open your Terminal and navigate to the `android-studio/bin/` directory and execute `studio.sh`.

Next, the **Data Sharing** dialog will pop up; click either the **Send usage statistics to Google** button or the **Don’t send** button to disable sending anonymous usage data to Google:


![ The Data Sharing dialog ](/packtpub/how_to_build_android_apps_with_kotlin_2ed/01.00-the_data_sharing_dialog.webp)

The Data Sharing dialog

In the **Welcome** dialog, click the **Next** button to start the setup:


![ The Welcome dialog ](/packtpub/how_to_build_android_apps_with_kotlin_2ed/01.01-the_welcome_dialog.webp)

The Welcome dialog

In the **Install Type** dialog, select **Standard** to install the recommended settings. Then, click the **Next** button:


![ The Install Type dialog ](/packtpub/how_to_build_android_apps_with_kotlin_2ed/01.02-the_install_type_dialog.webp)

The Install Type dialog

In the **Select UI Theme** dialog, choose your preferred IDE theme—either **Light** or **Darcula** (dark theme)—then click the **Next** button:


![ The Select UI Theme dialog ](/packtpub/how_to_build_android_apps_with_kotlin_2ed/01.03-the_select_ui_theme_dialog.webp)

The Select UI Theme dialog

In the **Verify Settings** dialog, review your settings and then click the **Finish** button. The setup wizard downloads and installs additional components, including the Android SDK:


![ The Verify Settings dialog ](/packtpub/how_to_build_android_apps_with_kotlin_2ed/01.04-the_verify_settings_dialog.webp)

The Verify Settings dialog

Once the download finishes, you can click the **Finish** button. You are now ready to create your Android project.

**If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book’s GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.**

# Download the example code files

You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/How-to-Build-Android-Apps-with-Kotlin-Second-Edition. If there’s an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Download the color images

We also provide a PDF file that has color images of the screenshots and diagrams used in this book. You can download it here: https://packt.link/vnOCn.

# Conventions used

There are a number of text conventions used throughout this book.

`Code in text`: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: “You can find it in the main project window under `MyApplication` | `app` | `src` | `main`.”

A block of code is set as follows:

```
<resources>
    <string name="app_name">My Application</string>
</resources>
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

```
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="app_name">My Application</string>
    <string name="first_name_text">First name:</string>
    <string name="last_name_text">Last name:</string>
</resources>
```

**Bold**: Indicates a new term, an important word, or words that you see onscreen. For instance, words in menus or dialog boxes appear in **bold**. Here is an example: “Click **Finish** and your virtual device will be created.”

Tips or important notes

Appear like this.

# Get in touch

Feedback from our readers is always welcome.

**General feedback**: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

**Errata**: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

**Piracy**: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at `copyright@packt.com` with a link to the material.

**If you are interested in becoming an author**: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

# Share your thoughts

Once you’ve read How to Build Android Apps with Kotlin, Second Edition, we’d love to hear your thoughts! Please select https://www.amazon.in/review/create-review/error?asin=1837634939 for this book and share your feedback.

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

![ Scan the QR code ](/packtpub/how_to_build_android_apps_with_kotlin_2ed/01.05-scan_the_qr_code.webp)

https://packt.link/free-ebook/9781837634934

2. Submit your proof of purchase
3. That’s it! We’ll send your free PDF and other benefits to your email directly

Previous Chapter
Next Chapter

