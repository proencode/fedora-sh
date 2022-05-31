원본 제목: Chapter 1: An Introduction to Flutter
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/101
Title:
101 An Introduction to Flutter
Short Description:
Flutter for Beginners Second Edition 플러터 소개

![Figure 1.9 - Emulator displaying the Flutter app ](/flutter4beginners2_img/figure_1.9_-_emulator_displaying_the_flutter_app.jpg)
- cut line


# Chapter 1: An Introduction to Flutter
Flutter for Beginners Second Edition

In this chapter, you will learn the basics of the Flutter framework, the reasons for its creation, and what the future of Flutter may hold. You will learn about the thriving Flutter community, how it is contributing to the continued evolution of Flutter, and how and why Flutter has grown so quickly in the last couple of years. Along the way, you will see how to make (and run!) your first Flutter project, experience the excellent Flutter documentation, and see how Flutter is designed to work across a range of platforms including iOS, Android, Web, Windows, and Mac.

The following topics will be covered in this chapter:

- What is Flutter?
- Hello Flutter – a first glimpse of Flutter
- Widgets, widgets, everywhere
- Building and running Flutter

# Technical requirements

In this chapter, we will create, build, and run a Flutter application. To do this, you will need to set up your system so that it is capable of doing this.

Specifically, you will need to set up your system to have the following:

- A Flutter software development kit (SDK) installed and added to your PATH
- An integrated development environment (IDE) where you can view and edit Flutter code
- Android Studio and/or Xcode so that you can use the Android and iOS development tools and iOS simulators/Android emulators

The chapter will give you some guidance on how to set up your system, but as you will discover, the Flutter documentation is excellent and includes very accurate and up-to-date getting started guides: https://flutter.dev/docs/get-started/install.

Feel free to set up your system now or at the specific points required during the chapter.

You can find the source code for this chapter on GitHub at https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/lib/chapter_01.

# What is Flutter?

Since the advent of the Apple App Store (and subsequently the Google Play Store), there has been a way for organizations to share programs with mobile users in a very controlled and managed way. Much like web pages on the internet, mobile apps have proliferated to encompass all aspects of our life. And much like web pages, over the years, developers have iteratively discovered and learned the best ways to create reliable, scalable, and intuitive mobile apps.

As developers have learned to work within the mobile ecosystem, they have followed similar design patterns and framework ideas as were created to deal with the web ecosystem. Much like the complications of developing code for multiple browsers, in the mobile ecosystem, there has been the challenge of developing code that can work on both iOS and Android devices, with the dream always being to have one code base that works on all devices and even the web.

Flutter is a framework that is the culmination of this learning. Like most other frameworks, developers use a programming language specified by the framework, and structure their code in a way that aligns with the needs of the framework so that ultimately, the developer creates the least amount of "boilerplate" code and can focus on their business needs. Examples of "boilerplate" code would be how to manage touch input, how to connect to the internet, and how to package the app code to work with the App Store, Play Store, or web hosting service.

Flutter is a very new framework, and this means that it does not have a big section of the mobile development market yet, but this is changing, and the outlook for the next few years is highly positive.

When choosing a new programming language or framework, it is hugely important to developers and software companies that what they have chosen has certain key aspects that will ensure it is easy to pick up and that it has a bright future. Investing time and money into learning a new solution, and then developing a code base and development processes around that language and framework, is incredibly expensive. If that solution becomes outdated after a short period of time, there is poor support and documentation, there are a lack of new developers available to take your product forward, or the solution has scaling issues or usability problems, then that investment is wasted. Let's look at some of the aspects that suggest Flutter may be a good long-term investment.

## Backed by Google

Flutter, and the Dart programming language it depends on, were created by Google, and although they are open source, they continue to be backed by Google. This ensures the framework has all the tools it needs to succeed in the community, with support from the Google team, presence at big events such as Google I/O, and investment in continuous improvements in the code base.

From the launch of the first stable release during the Flutter Live Event at the end of 2018, the growth of Flutter is evident:

- More than 200 million users of Flutter apps
- More than 50,000 Flutter apps on the Play Store
- Nearly 500,000 developers
- The 18th most popular software repository on GitHub
Let's look at some of the reasons why Flutter has become so popular.

## Fuchsia OS and Flutter

It's not a secret anymore that Google has been working on a new operating system called Fuchsia OS, which has been rumored to be a potential future replacement for the Android OS. One thing to pay attention to is that Fuchsia OS may be a universal Google operating system that runs on more than just mobile phones, and this would directly affect Flutter adoption. This is because Flutter will be the first method of developing mobile apps for the new Fuchsia OS, and, not only this, Fuchsia uses Flutter as its UI rendering engine. With the system targeting more devices than just smartphones, as seems to be the case, Flutter will certainly have a lot of improvements.

The growth of the framework's adoption is directly related to the new Fuchsia OS. As it gets closer to launch, it is important for Google to have mobile apps targeting the new system. For example, Google has announced that Android apps will be compatible with the new OS, making the transition to, and adoption of, Flutter significantly easier.

## Dart

The Dart programming language was first unveiled by Google at the GOTO conference in 2011, and Dart 1.0 was released at the end of 2013. Initially viewed as a replacement for JavaScript (the main web programming language), the uptake of Dart by developers was relatively low. However, thanks to the emergence of Flutter and its reliance on Dart, the Dart programming language has seen a huge rise in usage.

So why did the Flutter project choose the Dart programming language? Since its inception, one of Flutter's main goals was to be a high-performance alternative to existing cross-platform frameworks. But not only that; to significantly improve the mobile developer's experience was one of the crucial points of the project.

With this in mind, Flutter needed a programming language that allowed it to accomplish these goals, and Dart seemed to be the perfect match for the following reasons:

- Dart compilation: Dart is flexible enough to provide different ways of running the code, so Flutter uses Dart ahead of time (AOT) compilation with performance in mind when compiling a release version of the application, and it uses just in time (JIT) compilation with sub-second compilation of code in development time, aiming for fast feedback for code changes. Dart JIT and AOT refer to when the compilation phase takes place. In AOT, code is compiled during the build process and before running the code; in JIT, code is compiled while running (check out the Dart introduction section in the next chapter).
- High performance: Due to Dart's support for AOT compilation, Flutter does not require a slow bridge between realms (for example, non-native Flutter code to native device code), which makes Flutter apps responsive and allows a fast startup.
- Garbage collection: Flutter uses a functional-style flow with short-lived objects, and this means a lot of short-lived allocations. Dart garbage collection works without locks, helping with fast allocation.
- Easy to learn: Dart is a flexible, robust, modern, and advanced language. The language has been adapted as Flutter has become more popular, with lots of syntactic sugar, and fundamental design changes, that really help with Flutter app creation. Although it is still evolving, the language has a well-defined object-oriented framework with familiar functionalities to dynamic and static languages, an active community, and very well-structured documentation.
- Declarative UI: In Flutter, you use a declarative style to lay out widgets, which means that widgets are immutable and are only lightweight "blueprints." To change the UI, a widget triggers a rebuild on itself and its subtree. In the opposite imperative style (the most common), we can change specific component properties after they are created.Declarative UIWe will explore this a lot more throughout the book, but if you want to understand the concept of the Flutter declarative UI at this point, then take a look at the official introduction to declarative UI from Flutter: https://flutter.dev/docs/get-started/flutter-for/declarative.
- Dart syntax for layout: Different from many frameworks that have a separate syntax for layout, in Flutter, the layout is specified inline within the Dart code. This gives greater flexibility and reduces the developer's cognitive load. Flutter has great tools for debugging layout as well as rendering performance.
- These are great reasons why Dart fits perfectly with Flutter. However, there is a key area of Flutter that is probably why you are learning and using it, and why it is a game-changer in the app development world, and that is a single code base for multiple platforms. Let's take a look at that now.

## One code base to rule them all

The primary goal of the Flutter framework is to be a toolkit for building apps that are equivalent in performance, usability, and features to native apps (apps created directly for iOS or Android) while using only a single code base. You may have heard it stated often that there are big advantages to having a single code base. Let's see why that is the case:

- Multiple languages to learn: If a developer wants to develop for multiple platforms, they must learn how to do something in one OS and programming language, and later, the same thing in another OS and programming language. The developer then needs to decide whether to focus on one platform for a period of time, causing a mismatch of features/bug fixes between the apps, or constantly switch between platforms, impacting productivity and potentially introducing bugs.
- Long/more expensive development cycles: If you decide to create multiple development teams to avoid the previous issues, there are consequences in terms of cost, multiple deadlines, different capabilities of native frameworks, and disparate sets of bug reports.
- Inconsistency: Different native capabilities, or different development teams developing features in slightly different ways, may lead to inconsistencies between apps, annoying users and making bug reporting more complicated to diagnose.

Flutter is not the first attempt to create a single code base and there are existing frameworks available that have similar promises. However, they can suffer from some serious drawbacks:

- Performance: Some frameworks use workarounds to allow consistency of user experience across platforms. One of these is to effectively have a web page running inside a native app using a webview (a built-in web browser). This tends to have much worse performance than native apps, leading to a poor user experience.
- Design constraints: Some frameworks are based on languages that were designed before the mobile experience was created. This can mean they are not designed well for certain user interactions or certain device capabilities, leading to complicated or obscure code, and the inherent maintenance issues this can cause.
- Not quite one code base: Although some frameworks suggest a single code base approach to app development, once you get into the details, you find that you still need to write some platform-specific code, which causes code duplication and allows single platform bugs to creep in.

Now let's see how Flutter counters these problems.

### High performance

Right now, it is hard to say that Flutter's performance is always better in practice than other frameworks, but it's safe to say that its aim is to be. For example, its rendering layer was developed with a high frame rate in mind. As we will see in the Flutter rendering section, some of the existing frameworks rely on JavaScript and HTML rendering, which might cause overheads in performance because everything is drawn in a webview (a visual component like a web browser).

Some use original equipment manufacturer (OEM) widgets but rely on a bridge to request the OS API to render the components, which creates a bottleneck in the application because it needs an extra step to render the user interface (UI). See the Flutter rendering section for more details of the Flutter rendering approach compared to others.

Some points that make Flutter's performance great are the following:

- Flutter owns the pixels: Flutter renders the application pixel by pixel (see the next section), interacting directly with the Skia graphics engine.
- No extra layers or additional OS API calls: As Flutter owns the app rendering, it does not need additional calls to use the OEM widgets, so no bottleneck.
- Flutter is compiled to native code: Flutter uses the Dart AOT compiler to produce native code. That means there's no overhead in setting up an environment to interpret Dart code on the fly, and it runs just like a native app, starting more quickly than frameworks that need some kind of interpreter.

### Full control of the UI

The Flutter framework chooses to do all the UI by itself, rendering the visual components directly to the canvas, as we have seen previously, requiring nothing more than the canvas from the platform so it's not limited by rules and conventions. Most of the time, frameworks just reproduce what the platform offers in another way. For example, other webview-based cross-platform frameworks reproduce visual components using HTML elements with CSS styling. Other frameworks emulate the creation of the visual components and pass them to the device platform, which will render the OEM widgets like a natively developed app. We are not talking about performance here, so what else does Flutter offer by not using the OEM widgets and doing the job all by itself?

Let's see:

- Ruling all the pixels on the device: Frameworks limited by OEM widgets will reproduce at most what a native developed app would, as they use only the platform's available components. On the other hand, frameworks based on web technologies may reproduce more than platform-specific components, but may also be limited by the mobile web engine available on the device. By getting control of the UI rendering, Flutter allows the developer to create the UI in their own way by exposing an extensible and rich Widgets API, which provides tools that can be used to create a unique UI with no drawbacks in performance and no limits in design.
- Platform UI kits: By not using OEM widgets, Flutter can break the platform design, but it does not. Flutter is equipped with packages that provide platform design widgets, the Material set in Android, and Cupertino in iOS. We will see more on platform UI kits in Chapter 5, Widgets – Building Layouts in Flutter.
- Achievable UI design requirements: Flutter provides a clean and robust API with the ability to reproduce layouts that are faithful to the design requirements. Unlike web-based frameworks that rely on CSS layout rules that can be large and complicated and even conflicting, Flutter simplifies this by adding semantic rules that can be used to make complex but efficient and beautiful layouts.
- Smoother look and feel: In addition to native widget kits, Flutter seeks to provide a native platform experience where the application is running, so fonts, gestures, and interactions are implemented in a platform-specific way, bringing a natural feel to the user, like a native application.

We refer to visual components as widgets, which we will go into more detail on that in the Widgets, widgets, everywhere section in this chapter.

## Open source framework

Having a big company such as Google behind it is fundamental to a framework such as Flutter (see React, for example, which is maintained by Facebook). In addition, community support becomes even more important as it becomes more popular.

By being open source, the community and Google can work together to do the following:

- Help with bug fixes and documentation through code collaboration
- Create new educational content about the framework
- Support documentation and usage
- Make improvement decisions based on real feedback

Improving the developer experience is one of the main goals of the framework. Therefore, in addition to being close to the community, the framework provides great tools and resources for developers. Let's see them.

Developer resources and tooling
The focus on developers in the Flutter framework goes from documentation and learning resources to providing tools to helping with productivity:

- Documentation and learning resources: Flutter websites are rich for developers coming from other platforms, including many examples and use cases, for example, the famous Google Codelabs (https://codelabs.developers.google.com/?cat=Flutter).
- IDE integration: Flutter, and Dart, have a completed, integrated IDE experience with Android Studio, IntelliJ, and Visual Studio Code. Within this book, we will show examples from Visual Studio Code, but these examples will work very similarly in Android Studio and IntelliJ.
- Command-line tools: Dart has tools that help with analyzing, running, and managing dependencies and these are also part of Flutter. In addition, Flutter has commands to help with debugging, deploying, inspecting layout rendering, and integration with IDEs through Dart plugins. Here's a list of the various commands:

![Figure 1.1 - Available commands in Flutter ](/flutter4beginners2_img/figure_1.1_-_available_commands_in_flutter.jpg)

- Quick setup: Flutter has the create command shown in the preceding list that allows you to create a new and fully functional Flutter project with minimal input. IDEs also offer a Flutter project creation menu option, replicating the command-line functionality.
- Environment issue diagnostics: Flutter comes with the flutter doctor tool, which is a command-line tool that guides the developer through the system setup by indicating what is needed in order to be ready to set up a Flutter environment. We will see this tool in action when we set up your environment very soon. The flutter doctor command also identifies connected devices and whether there are any upgrades available.
- Hot reload: This is a huge benefit to developers and a feature that is getting a lot of attention. By combining the capabilities of the Dart language (such as JIT compilation) and the power of Flutter, it is possible for the developer to instantly see design changes made to code in the simulator or device. In Flutter, there is no specific tool for layout preview. Hot reload makes it unnecessary.

Now that we have learned about the benefits of Flutter, let's start looking at the software's compilation process.

# Hello Flutter – a first glimpse of Flutter

OK, let's start getting our hands dirty with some code. Flutter comes with a simple Hello World app that we will get running and then look at in some detail. First of all though, we need to get your system ready for some Flutter action!

## Installing Flutter

Flutter is very easy to install. Head over to the Flutter docs web pages to install Flutter and Dart for your operating system: https://flutter.dev/docs/get-started/install.

The installation documentation for Flutter is comprehensive, with explanations and potential issues all described there. Ensure that you read the installation documentation fully and complete all the steps so that your system is correctly prepared for our journey into Flutter.

You will download the SDK and place it somewhere on your filesystem. Note that downloading Flutter will also download a compatible version of Dart and the relevant dart command-line tool. You should not need to download Dart separately.

### Updating your PATH

The installation documentation also explains how to update your PATH so that you can run Flutter commands from your command line. Please do follow these instructions because you will be using the command line regularly to interact with Flutter and Dart.

After installation and PATH setup, you should run the Flutter doctor command to see how ready your system is for Flutter. You will do this from your command line / terminal:
a
```
C:\src\flutter>flutter doctor
```

Here is an example of the output:

![Figure 1.2 - Flutter doctor command-line output ](/flutter4beginners2_img/figure_1.2_-_flutter_doctor_command-line_output.jpg)

You are likely to see errors in the flutter doctor report at this point because we haven't set up your development environment yet.

If you are unable to run the Flutter doctor command, then it is likely an issue with your PATH, as mentioned previously. Double-check that the path to your Flutter folder is correct and points to the flutter/bin subfolder. Also try closing your command line / terminal and opening it again because the PATH, in some situations, is only updated when the command line / terminal is opened.

## Development environment

As mentioned previously, Flutter has excellent support in Android Studio, IntelliJ, and Visual Studio Code. This book will generally be agnostic of IDE, but, where required, will show examples from Visual Studio Code.

All three IDEs can be downloaded from the internet. Android Studio and Visual Studio Code are free, and IntelliJ has both a free Community edition and a paid-for Ultimate edition.

If you are planning to work with Android devices (and because Flutter is cross-platform I would expect you will), then you will need to download and install Android Studio regardless of the IDE you decide to develop code with. This is because installing Android Studio also installs the Android SDK, Android SDK command-line tools, and Android SDK build tools. These are required by Flutter when interacting with Android devices, running Android emulators, and building the app ready for use on the Android Play Store.

On macOS devices, you will also need to install and configure Xcode to allow you to build your app for iOS. Follow the instructions in the Flutter getting started documentation to ensure Xcode is configured correctly.

### Important note

You can only build iOS apps on Macs. This is a restriction imposed by Apple and is imposed on all app development, not just Flutter. If this is an issue, then there are options such as cloud-based Mac instances you can use, or virtualization software to allow you to run a Mac virtual machine. An exploration of this is beyond the scope of this book. However, when developing Flutter apps, you can build and test quite happily on Android for the vast majority of the time, only switching to iOS for late-stage testing.

Once you have both your IDE installed and Android Studio (or just Android Studio if that is your IDE of choice), and Xcode installed and configured (if you are on a Mac), then rerun flutter doctor to check everything is ready to go.

## Hello world!

With the Flutter development environment configured, we can start using Flutter commands. The typical way to start a Flutter project is to run the following command:

```
flutter create <output_directory>
```

Here, output_directory will also be the Flutter project name if you do not specify it as an argument. By running the preceding command, the folder with the provided name will be generated with a sample Flutter project in it. We will analyze the project in a few moments. First, it is good to know that there are some useful options to manipulate the resulting project from the flutter create command. The main ones are as follows:

- --org: This can be used to change the owner organization of the project. If you already know Android or iOS development, this is a reverse domain name, and is used to identify package names on Android and as a prefix in the iOS bundle identifier. The default value is com.example.
- -s,--sample=<id>: Most of the official examples for widget usage have a unique ID that you can use to quickly clone the example to your machine. Whenever you are exploring the Flutter docs website (https://docs.flutter.dev), you can take a sample ID from it and use it with this argument.
- -i, --ios-language, and -a, --android-language: These are used to specify the language for the native part code of the project, and are only used if you plan to write native platform code.
- --project-name: Use this to change the project's name. It must be a valid Dart package identifier. If you do not specify this parameter, it tries to use the same name as the output directory. Note that this argument must be the last in the list of arguments provided.Valid Dart package identifiers
- As specified in the Dart documentation: "Package names should be all lowercase, with underscores to separate words, 'just_like_this'. Use only basic Latin letters and Arabic digits: [a- z0-9_]. Also, make sure the name is a valid Dart identifier – that it doesn't start with digits and isn't a reserved word."

Let's see a typical Flutter project structure created with the flutter create hello_world command:

![Figure 1.3 - Typical Flutter project structure ](/flutter4beginners2_img/figure_1.3_-_typical_flutter_project_structure.jpg)

Listing the basic structure elements, we get the following:

- android/ios: This contains the platform-specific codes. If you already know the Android project structure from Android Studio, there is no surprise here. The same goes for Xcode iOS projects.
- hello_flutter.iml: This is a typical IntelliJ project file, which contains the JAVA_MODULE information used by the IDE.
- lib directory: This is the main folder of a Flutter application; the generated project will contain at least a main.dart file to start work on. We will be checking this file in detail soon.
- pubspec.yaml and pubspec.lock: This pubspec.yaml file is what defines a Dart package. This is one of the main files of the project and defines the app build number, lists dependencies on external plugins, images, and fonts and more. We will be looking at this in more detail in Chapter 5, Widgets – Building Layouts in Flutter.
- README.md: This is a standard README document that is very common in open source projects. It allows you to document how to set up and use your code so that other developers can easily get your code running.
- test directory: This contains all the test-related files of the project. Here, we can add unit tests and also widget tests to ensure we do not introduce bugs into our code as we develop it.

Most of the commands that we explore can be replicated in the IDE. It is worth noting that the IDEs use these command-line tools behind the scenes to interact with the project.

Now that you have created your first Flutter project (congratulations by the way!), you should open it up in your IDE so that you can start to explore it a lot more.

# Widgets, widgets, everywhere

Flutter widgets are a core part of the framework and are used constantly throughout your code. You will hear the saying "Everything is a widget," and that is almost true in Flutter. In this section, we will see how Flutter renders the user interface and then how Flutter applies the widgets idea to app development to create awesome UIs.

Widgets can be understood as the visual (but not only that) representation of parts of the application. Many widgets are put together to compose the UI of an application. Imagine it as a puzzle in which you define the pieces.

The intention of widgets is to provide a way for your application to be modular, scalable, and expressive with less code and without imposing limitations. The main characteristics of the widgets UI in Flutter are composability and immutability.

## Flutter rendering

One of the main aspects that makes Flutter unique is the way that it draws the visual components to the screen. A key differentiator to existing frameworks is how the application communicates with the platform's SDK, what it asks the SDK to do, and what it does by itself:

![Figure 1.4 - Flutter communication with the platform SDK ](/flutter4beginners2_img/figure_1.4_-_flutter_communication_with_the_platform_sdk.jpg)

The platform SDK can be seen as the interface between applications and the operating system and services. Each system provides its own SDK with its own capabilities and is based on a programming language (that is, Kotlin/Java for the Android SDK and Swift/Objective C for the iOS SDK).

## Flutter – rendering by itself

Flutter chooses to do all the rendering work by itself. The only thing it needs from the platform's SDK is access to Services APIs and a canvas to draw the UI on:

![Figure 1.5 - Flutter access to services and the canvas ](/flutter4beginners2_img/figure_1.5_-_flutter_access_to_services_and_the_canvas.jpg)

Flutter moves the widgets and rendering to the app, from where it gets the customization and extensibility. Through a canvas, it can draw anything and also access events to handle user inputs and gestures by itself. The bridge in Flutter is done by platform channels.

## Composability

For the widget user interface structures, Flutter chooses composition over inheritance, with the goal of keeping each widget simple and with a well-defined purpose. Meeting one of the framework's goals, flexibility, Flutter allows the developer to make many combinations to achieve incredible results.

### Composition versus inheritance

Inheritance derives one class from another. For example, you may have a class such as Vehicle and subclasses of Car and Motorbike. The Car and Motorbike classes would inherit the abilities of the Vehicle class and then add their own specializations. In this instance, Car is a Vehicle and Motorbike is a Vehicle.

Composition defines a class as the sum of its parts. For example, you may have an Engine class and a Wheel class. In this model, a Car is composed of an Engine, four Wheels, and other specializations; a Car has an Engine and a Car has Wheels. Composability is less rigid than inheritance and allows for things such as dependency injection and modifications at runtime.

## Immutability

Flutter is based on the reactive style of programming, where the widget instances are short-lived and change their descriptions (whether visually or not) based on configuration changes, so it reacts to changes and propagates these changes to its composing widgets, and so on.

A Flutter widget may have a state associated with it, and when the associated state changes, it can be rebuilt to match the representation.

The terms state and reactive are well known in the React style of programming, disseminated by Facebook's famous React library.

## Everything is a widget

Flutter widgets are everywhere in an application. Maybe not everything is a widget, but almost everything is. Even the app is a widget in Flutter, and that's why this concept is so important. A widget represents a part of a UI, but it does not mean it's only something that is visible. It can be any of the following:

- A visual/structural element that is a basic structural element, such as the Button or Text widgets
- A layout-specific element that may define the position, margins, or padding, such as the Padding widget
- A style element that may help to colorize and theme a visual/structural element, such as the Theme widget
- An interaction element that helps to respond to user interactions in different ways, such as the GestureDetector widget

Let's have a quick look at a widget so you can get a feel for what we are referring to. Open your IDE and take a look at the lib/main.dart file. You will see a section like this:

```
class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

Not only is this your first example of a Flutter widget, it is also your first chance to see Dart. If you are from a Java, C++, Objective-C, and so on, background, then it should look relatively familiar to you. Components of code are held in Class definitions that describe fields and methods, with inheritance through the extends keyword.

This MyApp class runs the whole show and is itself a widget. In this instance, it is a StatelessWidget, as you can see from the extends section. We will explore StatelessWidgets (and their alter ego, the StatefulWidget) in a lot of detail later on, but for the moment, it's sufficient to know that a StatelessWidget holds no state, it exists to compose other widgets that may or may not hold their own state.

One key point to note is the build method. This method is used to update the display and is called when some external activity happens – for example, the user interacts with the device, some data is sent from a database, or a timer is triggered at a set time.

In this build method, the MyApp widget simply returns another widget, MaterialApp, which itself will have a build method that may also return widgets. Ultimately, you will reach leaf widgets that will render graphics to the display.

Widgets are the basic building blocks of an interface. To build a UI properly, Flutter organizes the widgets in a widget tree.

### The widget tree

This is another important concept in Flutter layouts. It's where widgets come to life. The widget tree is the logical representation of all the UI's widgets. It is computed during layout (measurements and structural info) and used during rendering (frame to screen) and hit testing (touch interactions), and this is the thing Flutter does best. By using a lot of optimization algorithms, it tries to manipulate the tree as little as possible, reducing the total amount of work spent on rendering, aiming for greater efficiency:

![Figure 1.6 - Example widget tree ](/flutter4beginners2_img/figure_1.6_-_example_widget_tree.jpg)

Widgets are represented in the tree as nodes. Each widget may have a state associated with it; every change to its state results in rebuilding the widget and the child involved.

As you can see, the tree's child structure is not static, and is defined by the widget's description. The children relations in widgets are what makes the UI tree; it exists by composition, so it's common to see Flutter's built-in widgets exposing child or children properties, depending on the purpose of the widget.

The widget tree does not work alone in the framework. It has the help of the element tree; a tree that relates to the widget tree by representing the built widget on the screen, so every widget will have a corresponding element in the element tree after it is built.

The element tree has an important task in Flutter. It helps to map onscreen elements to the widget tree. Also, it determines how widget rebuilding is done in update scenarios. When a widget changes and needs to be rebuilt, this will cause an update to the corresponding element. The element stores the type of the corresponding widget and a reference to its children elements. In the case of repositioning, for example, a widget, the element will check the type of the corresponding new widget, and if there is a match, it will update itself with the new widget description.

The element tree can be thought of as a pre-render auxiliary tree to the widget tree. If you need more information on that, you can check the official docs at https://docs.flutter.io/flutter/widgets/Element-class.html.

You have now learned the basics of how to put a Flutter app together, so let's look at the build process and options in some more detail.

# Building and running Flutter

The way an application is built is fundamental to how it will perform on the target platform. This is an important step regarding performance. Even though you do not necessarily need to know this for every kind of application, knowing how the application is built helps you to understand and measure possible improvements.

As we have already pointed out, Flutter relies on the AOT compilation of Dart for release mode and the JIT compilation of Dart for development/debug mode. Dart is one of only a few languages that are capable of being compiled to both AOT and JIT, and Flutter makes the most of this advantage. Let's look at the different build options available, why you would use each one, and how the capabilities of Dart lead to an optimal developer and user experience.

## Debug mode

During development, Flutter uses JIT compilation in debug mode. Debug mode compilation is optimized for fast feedback, and therefore sacrifices execution speed and binary size. However, due to the power of Dart's compiler, interactions between the code and the simulator/device are still fast, and debugging tools allow developers to step into the source code and analyze the widget layout.

## Release mode

In release mode, debugging information is not necessary, and the focus is performance. Flutter uses a technique that is common to game engines. By using AOT mode, Dart code is compiled to native code, and the app loads the Flutter library and delegates rendering, input, and event handling to it through the Skia engine.

### Skia graphics library

Skia is an open source library that provides APIs for 2D graphics. It is used in Flutter as well as Google Chrome, Android, Firefox, and many others. It is also backed by Google, like Dart and Flutter.

## Profile mode
Sometimes you need to analyze the performance of your app. Profile mode retains just enough debugging ability to create a profile or your app's performance, while attempting to be a true reflection of your app's real-world performance. This mode is only available on physical devices because emulators will not have representative characteristics.

## Supported platforms
Currently, Flutter supports ARM Android devices running at least on API 19 (Android 4.4 or KitKat) , and iOS devices on iOS 9 or later (which includes iPhone 4S and later). As you would expect, Flutter apps can be run on device emulators, and debugging works equally well on physical and emulated devices.

Additionally, Flutter Web is in the beta channel, and desktop support (Windows, macOS, and Linux) are available on the Alpha channel. As you can see, the vision for Flutter is to allow developers to have a single code base for mobile, web, and desktop!

We are not going to go into more detail on Flutter's compilation aspects as they are beyond the scope of this book. For more information, you can read https://flutter.dev/docs/resources/faq#how-does-flutter-run-my-code-on-android and https://flutter.dev/docs/resources/faq#how-does-flutter-run-my-code-on-ios.

## The pubspec.yaml file

The pubspec.yaml file in Flutter is actually a file that is used to define Dart packages. Besides that, it contains an additional section for configurations specific to Flutter. Let's see the pubspec.yaml file's contents in details:

```
name: hello_flutter
description: A new Flutter project.
version: 1.0.0+1
```

The beginning of the file is simple. As we already know, the name property is defined when we execute the pub create command. Next is the default project description; feel free to change this to something more interesting. Note that if you do so, your IDE may suddenly run the flutter pub get command. We'll see why in a bit.

### Description during create

Like many parts of the pubspec.yaml file, you can specify the description during the flutter create command by using the –description argument.

The version property follows the Dart package conventions: the version number, plus an optional build version number separated by +. In addition to that, Flutter allows you to override these values during the build. We will take a more detailed look at that in Chapter 12, Releasing Your App to the World.

Then we have the dependencies section of the pubspec file:

```
environment:
  sdk: ">=2.12.0 <3.0.0"
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.1
dev_dependencies:
  flutter_test:
    sdk: flutter
    // ">
```

We start with the environment property. This specifies the version of Dart that your code will work with. This entry is specifying that your code will need version 2.12.0 of Dart or above, but will not run on Dart 3.0.0. As per standard versioning, you would expect that if Dart 3.0.0 is released, it will have some backward-incompatible changes that may stop your code from compiling. This happened when Dart was updated from 1.x.x to 2.x.x. By restricting your allowed Dart versions, this means your code will not need to support Dart 3.x.x until you are ready to do so. Note that Dart 2.12 is a significant milestone for Dart because it introduced the concept of null safety. We will explore null safety in Chapter 2, An Introduction to Dart.

Then we have the dependencies property. This starts with the main dependency of a Flutter application, the Flutter SDK itself, which contains many of Flutter's core packages.

As an additional dependency, the generator adds the cupertino_icons package, which contains icon assets used by the built-in Flutter Cupertino widgets (there's more on that in the next chapter).

As you add other dependencies (and I would bet my hat that you will add a lot of dependencies), they will also appear here.

The dev_dependencies property contains only the flutter_test package dependency provided by the Flutter SDK itself, which contains Flutter-specific extensions to the Dart test package. We will explore this in Chapter 11, Testing and Debugging

In the final block of the file, there's a dedicated flutter section:

```
flutter:
  uses-material-design: true
# To add assets to your application, add an assets section, like this:
# assets:
#     - images/a_dot_burr.jpeg
#     - images/a_dot_ham.jpeg
# ...
# To add custom fonts to your application, add a fonts section here,
# fonts:
#     - family: Schyler
#     fonts:
#     - asset: fonts/Schyler-Regular.ttf
#     - asset: fonts/Schyler-Italic.ttf
#     style: italic
```

This flutter section allows us to configure resources that are bundled in the application to be used during runtime, such as images, fonts, music, sound effects, and videos.

Let's have a closer look:

- uses-material-design: We will see the Material widgets provided by Flutter in the next chapter. In addition to them, we can use also Material Design icons (https://material.io/tools/icons/?style=baseline), which are in a custom font format. For this to work properly, we need to activate this property (set it to true) so the icons are included in the application.
- assets: This property is used to list the resource paths that will be bundled with the final application. The assets files and folders can be organized in any way; what matters for Flutter is the path to the files. You specify the path of the file relative to the project's root. This is used later in Dart code when you need to refer to an asset file. Here's an example of adding a single image:

```
assets:
  images/home_background.jpeg
```

Often you will want to add many images, and listing them individually would be onerous. An alternative is to include a whole folder:

```
assets:
  images/
```

You add the / character at the end of the path that is used to specify that you want to include all files in that folder. Note that this doesn't include subfolders; they would need to be listed as well:

```
assets:
  images/
  images/icons/
```

- fonts: This property allows us to add custom fonts to the application.

We will be checking how to load different assets in the course of the book whenever we need to. Also, you can read more on asset specification details on the Flutter docs website: https://flutter.io/docs/development/ui/assets-and-images.

## Running the generated project

The default application that we created earlier has a counter to demonstrate the React style of programming in Flutter. We will look in more detail at Dart code in the next chapter, but let's look at the main.dart file a little bit more before we try running the application.

### The lib/main.dart file

We explored the main.dart file earlier to look at a widget. This file is also the entry point of the Flutter application:

```
void main() => runApp(MyApp());
```

The main function is the Dart entry point of an application; this is where the execution of your app will start. Flutter then takes over the execution in the runApp function, which is called by passing your top-level (or root) widget as a parameter. This is the widget we saw earlier, the MyApp widget.

### Flutter run

To execute a Flutter application, we must have a connected device or simulator. The check is done by using the flutter doctor tool we have explored before, and the flutter emulators tool, which will run an emulator/simulator on your system. The following command lets you know the existing Android and iOS emulators that can be used to run the project:

```
flutter emulators
```

You will get something similar to the following screenshot:

![Figure 1.7 - Output from the flutter emulators command ](/flutter4beginners2_img/figure_1.7_-_output_from_the_flutter_emulators_command.jpg)

You can check how to manage your Android emulators on https://developer.android.com/studio/run/managing-avds. For iOS device simulators, you should use the Xcode Simulator developer tool.

### Emulator versus simulator

You will notice that Android has emulators and iOS has simulators. The Android emulator mimics the software and hardware of an Android device. In contrast, the iOS simulator only mimics the software of an iOS device. It is therefore highly recommended that you test your app on a true iOS device before releasing it to the world to ensure there are no hardware issues such as excessive memory consumption.

Alternatively, you can choose to run the app on a physical device. You will need to set up your device for development, so for the moment it is probably easier to use an emulator or simulator.

After asserting that we have a device connected that can run the app, we can use the following command:

```
flutter run
```

You will see output similar to the following:

![Figure 1.8 - Output from the flutter run command ](/flutter4beginners2_img/figure_1.8_-_output_from_the_flutter_run_command.jpg)

This command starts the debugger and makes the hot reload functionality available, as you can see. The first run of the application will generally take a little longer than subsequent executions.

The emulator or simulator should start up and, after a pause to load the operating system, it should run your Flutter application. If you see the following screen, then congratulations. You have just run your first ever Flutter application and should be proud of yourself!

![Figure 1.9 - Emulator displaying the Flutter app ](/flutter4beginners2_img/figure_1.9_-_emulator_displaying_the_flutter_app.jpg)

The application is up and running; you can see a debug mark in the top-right corner. That means it's not a release version running; the app is in debug mode, which means you have all the debug mode goodies available to you, such as hot reload and code debug facilities.

The preceding example was run on an iPhone 6s simulator. The same result would be achieved by using an Android emulator, or an Android virtual device (AVD).

# Summary

In this chapter, we started playing with the Flutter framework. First, we learned some important concepts about Flutter, mainly the concepts of widgets. We saw that widgets are the central part of the Flutter world, where the Flutter team continually works to improve existing widgets and add new ones. This is because the widget concept is everywhere, from rendering performance to the final result on screen.

We also saw how to start a Flutter application project with the framework tools, the basic project structure of files, and the peculiarities of the pubspec.yaml file. At the end, we saw how to run a project on an emulator or simulator.

In the next chapter, we will look deeper into Dart. You have had a sneak peek when we looked at widgets and you will have seen how similar it is to other common programming languages such as Java, C#, and Swift. Dart is a great language, and I must confess it is my favorite language to work with. Hopefully, you will share some of this love by the end of the next chapter.

