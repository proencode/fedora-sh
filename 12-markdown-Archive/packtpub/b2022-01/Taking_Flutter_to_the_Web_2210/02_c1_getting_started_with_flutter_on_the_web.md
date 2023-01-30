
@ Q -> # 붙이고 줄 띄우기 => 0i### ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/EEEEEEEEEE^[
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(`) 붙이기 => i`^[/\.^[i`^[/RRRRRRRRRR^[
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(`) 붙이기 => i`^[/,^[i`^[/TTTTTTTTTT^[
@ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(`) 붙이기 => i`^[/;^[i`^[/YYYYYYYYYY^[
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(`) 붙이기 => i`^[/)^[i`^[/UUUUUUUUUU^[
@ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(`) 붙이기 => i`^[/:^[i`^[/CCCCCCCCCC^[

@ A -> 빈 줄에 블록 시작하기 => 0C```^[^Mk0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i```^M-^[^M0i```^[0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi```^M^M^[kk
@ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
    마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

> [ 01 P1 Basics of Flutter Web ](/packtpub/taking_flutter_to_the_web/01_p1_basics_of_flutter_web) <---> [ 03 C2 Creating Your First Web App ](/packtpub/taking_flutter_to_the_web/03_c2_creating_your_first_web_app)

# 02 C1 Getting Started with Flutter on the Web

Flutter recently has become a very popular choice for building cross-platform applications. Flutter has gained a lot of popularity among mobile application developers and start-ups. With the introduction of stable web support and the preview of support for desktop, Flutter now supports building on six different platforms. In this chapter, we will learn how we can get started with Flutter web development.

By the end of this chapter, you will have a good understanding of the basics of Flutter on the web. You will understand what Flutter on the web is and how to get started with it. You will also understand how Flutter on the web is different from regular web and mobile development. The knowledge you gain in this chapter will also help you understand what you can build with Flutter on the web and when to use it.

In this chapter, we will cover the following main topics:

- Introduction to Flutter and Flutter on the web
- Why you should learn Flutter on the web
- What you can build with Flutter on the web
- Making and running a new Flutter web project
- Flutter on the web for web developers
- Flutter on the web for mobile developers
- Official Flutter documentation

# Technical requirements

The technical requirements for this chapter are as follows:

- A computer with a decent spec that can run Flutter. You can read the official Flutter getting started documentation for the required spec. Visit https://flutter.dev/docs/get-started/install and select your operating system to see the system requirements.
- Flutter installed and running with web support enabled.

You can download the latest code samples for this chapter from the book’s official GitHub repository at https://github.com/PacktPublishing/Taking-Flutter-to-the-Web/tree/main/Chapter01/chapter1_final.

# Introduction to Flutter and Flutter on the web

Imagine being able to write code in one language/framework and deploy it on six different platforms, with some of those platforms having completely different setups in terms of both UI and UX. This has been made possible by Flutter in a way that allows developers to respect the norms of each platform, enriching developers with the tools and techniques to develop on each of these platforms with a native feel. A cross-platform development framework has been needed by developers for a long time now, because of the high costs and length of development time for native code on each platform. Many frameworks have tried, but none of them have succeeded in the way that Flutter has. Flutter has worked openly in the community in close connection with developers to resolve their issues and problems. Focusing both on the developer experience as well as the native feel and performance of applications, Flutter has become a great tool for cross-platform application development.

![ 0200 Figure 1.1 – Flutter, a cross-platform UI framework ](/packtpub/taking_flutter_to_the_web_img/0200_figure_1.1_–_flutter__a_cross-platform_ui_framework.webp
)
Figure 1.1 – Flutter, a cross-platform UI framework

Imagine developing a mobile application for Android and iOS, and imagine writing the same code without any changes (or with just a few tweaks) and running on the web while maintaining the same amount of functionality, or more. Imagine that same code deploying native desktop apps for Mac, Windows, and Linux. Yes, that’s now possible with Flutter.

From Flutter version 2.0, Flutter web support has become stable. This means we are now able to build Android, iOS, and web apps from a single code base. Flutter’s web support delivers the same experiences on the web as on mobile. Using the same sets of widgets that you use to build a UI for mobile applications, you can now build and deploy web applications. This enables developers to build feature-rich, interactive, and graphics-intense web applications with Flutter.

However, you have to understand that as Flutter is an app-centric UI framework, it is different from traditional web development. We are not writing HTML, CSS, and JavaScript (JS). Instead, we’re developing web apps using the same widgets that we use to develop mobile applications with Flutter. Later on in this chapter, we will see how Flutter is different from traditional web development with HTML, CSS, and JS, and how to take advantage of those differences.

Flutter is a lucrative framework to learn. With its plugins and developer tooling ecosystem, the Flutter framework has become one of the best tools for cross-platform application development in recent years.

# Why you should learn Flutter on the web

If you are already developing mobile applications with Flutter, imagine the same code base deploying to the web with only a few or no tweaks required. Imagine not even having to write native code most of the time. If you don’t know much about the web, it doesn’t matter – with Flutter, you don’t need to. However, I do suggest gaining basic knowledge of the web as a platform and how it’s different from mobile applications. We will discuss this topic later in this chapter.

If you are a developer looking to enhance your toolbox, improve your career, and you are interested in mobile development, Flutter is the right choice for 2022. Not only is Flutter popular among developer communities, but it also has lots of job opportunities in the industry as Flutter has become one of the best cross-platform frameworks of choice among companies as well as developers.

It’s easy to learn Flutter as there are lots of resources online. There are tons of free and paid courses, articles, and videos. Thanks to Flutter being a popular choice in the community and being open source, many developers have created a lot of free content around it. There are thousands of open source example projects on GitHub, from small examples to full-fledged real-world applications. Having this amount of references makes it easy to learn. As Flutter is so popular among the developer community, many problems you may have while learning Flutter will have already been solved by the community. You can easily find answers on platforms such as GitHub and Stack Overflow.

Those of you who are confused about which framework to learn, as there are many alternatives, such as Kotlin Multiplatform, .NET MAUI, React Native, Ionic, Apache Cordova, and more that I may not even know about, I implore you to try Flutter at least once. I myself have tried both React Native and Flutter, and later have completely switched to Flutter as I love the whole ecosystem of tools it provides.

# What you can build with Flutter on the web

We can build any kind of app in Flutter and then successfully port it to the web. Does that mean we should build all web apps with Flutter? If not, how do we decide what and what not to build with Flutter on the web? The following scenarios are some examples of when it would be beneficial to choose Flutter instead of traditional forms to build web applications. You can also refer to these great case studies of applications built with Flutter on the web available on the official Flutter documentation while deciding what kind of applications benefit from Flutter on the web:

- Supernova (https://flutter.dev/showcase/supernova)
- Rive (https://flutter.dev/showcase/rive)
- iRobot (https://flutter.dev/showcase/irobot)
- Flutter Gallery (https://gallery.flutter.dev/)

And here are some community examples, built with Flutter on the web:

- Flutterando Community (https://flutterando.com.br/#/)
- Flutter Shape Maker (https://shapemaker.web.app/#/)
- Rows Spreadsheet App (https://rows.com/)

## Progressive Web Applications

**Progressive Web Applications (PWAs)** are a quite recently introduced form of web application that tries to bring the best of both worlds – applications and the web. We will learn more about PWAs later, in [ Chapter 11 ](/packtpub/taking_flutter_to_the_web/14_c11_building_and_deploying_a_flutter_web_application
), Building and Deploying a Flutter Web App. Flutter delivers high-quality PWAs that are integrated with a user’s environment, including installation, offline support, and tailored UX that is the same as Flutter’s mobile application. So, at the moment, Flutter is a very suitable choice for building a PWA.

## Single-page applications

With Flutter being a client-side framework, it is a great option for building complex standalone web apps that are rich with graphics and interactive content to reach end users on a wide variety of devices.

## Existing mobile applications

If you already have a mobile application built with Flutter and want to target new users on a web platform, Flutter on the web would be a great choice. With few or no modifications to your existing code, you will be able to easily port your existing application to the web and target a wide range of users and devices.

Now, before we dive into developing awesome web apps using Flutter, read and keep in mind the following paragraph from the official Flutter documentation (https://flutter.dev/web):

Not every HTML scenario is ideally suited for Flutter at this time. For example, text-rich, flow-based, static content such as blog articles benefit from the document-centric model that the web is built around, rather than the app-centric services that a UI framework like Flutter can deliver. However, you can use Flutter to embed interactive experiences into these websites.

Here, we need to understand that Flutter is an app-centric UI framework designed to build interactive experiences, which may not be suitable for all kinds of websites and web applications.

## Deciding when to use Flutter on the web

This is not a definitive guide to help you decide when to use Flutter on the web. However, this might help you in the process of deciding whether or not to build your next web app with Flutter.

With web applications, one thing I can say for certain is that if you have the time and budget to build a native web application, build it. Build a native web application with HTML, CSS, and JS, the languages of the web. Also, if the web is the primary focus of your business, and most of your target customers are on the web, I suggest going native.

However, in scenarios in which you have mobile applications built with Flutter and most of your customers are on mobile applications but you want to quickly try the web platform to get more target customers and get more traction for your business, Flutter on the web would be a quick and cost-effective choice.

When you are planning to build a PWA or a graphics-intense, interactive application, Flutter would still be a suitable choice. Choosing Flutter will also allow you to build for mobile and desktop platforms using the same code base.

# Making and running a new Flutterweb project

We’ll assume that you have already installed Flutter and the IDE of your choice. If you have not already, you can follow the official installation guide (https://flutter.dev) to install Flutter. You also need to install the Chrome browser in order to develop and run Flutter web apps.

In order to create a Flutter project with web support, make sure you are using Flutter 2.0 or newer. It’s best to use the latest stable release of Flutter, which at the time of writing this book is 3.0.5. In order to verify that you have installed Flutter and configured it to work properly, you can use the `doctor` command. In your terminal, enter the following command:

```
flutter doctor
```

If everything is set up correctly, you should see a message similar to the following:

```
[✓] Flutter (Channel stable, 3.0.5, on Linux, locale en_US.UTF-8)
[✓] Android toolchain - develop for Android devices (Android SDK version 30.0.3)
[✓] Chrome - develop for the web
[✓] Linux toolchain - develop for Linux desktop
[✓] Android Studio (version 4.2)
[✓] IntelliJ IDEA Community Edition (version 2021.1)
[✓] Connected device (2 available)
[✓] HTTP Host Availability
```

Based on the platform you are on and the tools you have set up, yours might have a few differences, but you should see Chrome checked, Flutter checked, version 2.0 or newer, and Visual Studio Code or Android Studio checked as the IDE.

If Chrome is not enabled and this is the first time you are using Flutter, then you may need to enable Flutter on the web. For that, you can use the following command in the terminal:

```
flutter config --enable-web
```

If you are not using the latest version of Flutter, you can do so by running the `upgrade` command from the terminal:

```
flutter upgrade
```

If Flutter is set up correctly, you will now be able to create your first project. In order to create your project, from the terminal window, go to your project folder and run the following command to create a new project:

```
flutter create flutter_blog
```

This command will create a new Flutter project called `flutter_blog` in your project folder. You can now use your favorite IDE to open the project. We will be using Visual Studio Code with Flutter and Dart extensions installed. The directory structure of your project should look like the following:

```
flutter_blog
├── android
├── ios
├── lib
├── web
└── pubspec.yaml
```

Make sure you have a `web` folder. If not, you will have to check your Flutter installation again and make sure everything is correct and that the web platform is enabled. If it’s not enabled, enable the web platform as discussed in the previous steps, and create a new project again.

Now, in order to run the project on the web, run the following command from your terminal:

```
flutter run -d chrome
```

If everything goes well, you should see the following output in the web browser:

![ 0201 Figure 1.2 – Flutter Demo Home Page ](/packtpub/taking_flutter_to_the_web_img/0201_figure_1.2_–_flutter_demo_home_page.webp
)
Figure 1.2 – Flutter Demo Home Page

Now, if we inspect the web app, we can see that Flutter widgets don’t compile to traditional HTML elements. We would rather see a canvas element that is rendering our whole app. To understand how this renders in the HTML page, you will have to look at `web/index.html`. Let’s look at it. The complete source code for the file can be found at https://github.com/PacktPublishing/Taking-Flutter-to-the-Web/blob/main/Chapter01/chapter1_final/web/index.html.

There is lots of HTML code. The important part is this script, which loads the Flutter Engine, which in turn loads our built app’s JavaScript code:

```
...
    window.addEventListener(‘load’, function(ev) {
      // Download main.dart.js
      _flutter.loader.loadEntrypoint({
        serviceWorker: {
          serviceWorkerVersion: serviceWorkerVersion,
        }
      }).then(function(engineInitializer) {
        return engineInitializer.initializeEngine();
      }).then(function(appRunner) {
        return appRunner.runApp();
      });
    });
...
```

Apart from the HTML boilerplate code, the only important block of code is this script in the body of the HTML. This script loads the dart file that is generated by Flutter and also does some other jobs to check whether Flutter Engine is initialized and make server workers work for PWAs. Flutter generates a single dart file for our dart code, and that script is what renders our Flutter application.

If you look at `lib/main.dart`, there is no difference in the code. The same code that builds the mobile app also builds the web app.

This is the main function that begins execution while building or running this application. This is the entry point for our Flutter application and loads the root widget that handles the rendering of our application UI:

```
void main() {
  runApp(MyApp());
}
```

It is a combination of the root widget and other widgets that renders the UI of the application:

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ‘Flutter Demo’,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ‘Flutter Demo Home Page’),
    );
  }
}
```

This is a simple stateful widget that, when built, displays basic text with a counter. It provides a floating action button, which, when tapped, increases the counter:

```
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key:
    key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              ‘You have pushed the button this many 
               times:’,
            ),
            Text(
              ‘$_counter’,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: ‘Increment’,
        child: Icon(Icons.add),
      ),
    );
  }
}
```

So, there is not actually any difference in the code we write for mobile and web for a simple application such as this. However, as the application grows and starts to have multiple features, we will have to decide how each feature looks and works for different platforms, and embed platform-specific logic. That is when the code will start to look different, but it will still be the same code that runs on mobile as well as the web.

Once you run or build a Flutter application for the web, in your project folder there will be a build folder, inside which there is a web folder. Now if you look inside the build folder, you have similar files as you have in the project’s root web folder. The `index.html` file is the exact same file. But there’s a new `main.dart.js` file that is loaded in `index.html`. `main.dart.js` is the file that contains all the code that we have written in Flutter. All the code that we have written is compiled and minified into one JavaScript file and that is what loads our app’s logic and UI.

# Flutter on the web for web developers

If you come from a web development background, this section is for you. Even if you don’t come from a development background, this section still might help you in understanding Flutter on the web in a more meaningful way. You cannot look at Flutter on the web the same way you look at web development. If you look at it that way, you will find lots of things about Flutter on the web that you will not like. Like some others online, you may feel that Flutter on the web is not performant, not ready for the web yet, and so on. As we have already talked about what types of apps benefit from Flutter on the web and what types of apps are not yet suitable to build using Flutter on the web earlier in this chapter, there’s no point arguing again here about the performance and web readiness of Flutter.

To understand Flutter web development, first, you need to understand how Flutter works for mobile apps and how it’s unique.

## Flutter as a UI framework

You need to look at Flutter on the web from the fresh perspective that it’s fundamentally different from web development using HTML. Flutter is designed to develop rich, interactive UIs, whereas the web traditionally was designed to serve textual content. But with advances in web technologies, nowadays we deliver all sorts of content on the web, including images, videos, and even graphics intensive games. You also need to think from the point of view that, even though the web is a different platform, Flutter on the web works a bit differently. Flutter is an app-centric UI framework. The web apps built with Flutter provide more of an app-like experience, instead of a traditional web-like experience. We should aim to use that to our advantage.

The first difference we need to understand is that the UI and logic we write with Flutter don’t translate to HTML elements, CSS, and JS one to one. Almost every piece of logic and UI that we write is translated to JavaScript, and the UI is rendered using a combination of the Canvas element, some CSS, SVGs, WebGL, and Web Assembly. Flutter has two different renderers for the web: an HTML renderer, and a CanvasKit renderer. We will learn in detail about these in [ Chapter 4 ](/packtpub/taking_flutter_to_the_web/06_c4_flutter_web_under_the_hood
), Web Flutter under the Hood. However, the fundamental difference is that the HTML renderer uses combinations of HTML elements, CSS, Canvas elements, and SVG elements, and is smaller in terms of download size. Whereas, CanvasKit is fully consistent with Flutter mobile and desktop and has faster performance with higher widget density, but has a bigger download size.

The next difference is that Flutter is not designed for a traditional web experience. We should also keep in mind that the web has also changed a lot since it was originally launched as a medium for sharing text. Only because of this advancement in the web has it been possible to serve all sorts of content including videos, games, and other rich and interactive UIs. Applications built with Flutter are suitable for the modern web.

The next thing that you need to understand is that Flutter on the web is a single-page, client-side application. When a user requests the application, the whole application is loaded entirely in memory. The application requests the information required for different parts of the application and loads it dynamically during execution. That also means that server-side rendering is not yet possible for Flutter web applications. Everything must work on the client. Because of this, SEO is terrible at the moment with Flutter. Though there are some packages in the works by the community, such as https://pub.dev/packages/seo_renderer, which tries to resolve the SEO problem, there hasn’t been any significant progress. So, applications such as blogs might not yet be suitable to be built using Flutter.

Finally, you need to understand that Flutter is not designed to build web pages or websites as we know them. We are not building Flutter web apps to serve traditional web content. Flutter is used to build app-centric, graphics-rich, and interactive applications. Flutter web applications are able to provide the same experience as their mobile application counterparts.

So, while thinking about building your next Flutter web application, do not think in terms of traditional web pages and websites. Rather, think of a mobile application or highly interactive content being delivered via the web.

# Flutter on the web for mobile developers

This section is for you if you come from a mobile development background and try to approach Flutter on the web in the same way you would mobile development. You must understand one important thing: the web is fundamentally a different platform than mobile. It has tons of differences compared to the mobile platform.

First and foremost, unlike mobile applications that target specific platforms and devices with specific capabilities, a web application might run on a wide range of devices including mobile devices, desktops, laptops, and even embedded devices. Each of these devices has a different `operating system (OS)` with different capabilities under the hood. Accessing device functionalities is not as easy as with mobile devices as there are many security concerns as well as performance issues. Though with HTML5 there has been a lot of improvement in accessing device capabilities, it is still not as powerful as mobile APIs themselves, due to the wide range of devices available for web browsing. As web developers, we will have to think of all those responsibilities. Though most of the work is already delegated to plugins with Flutter, we still must think of using those plugins effectively and also think of situations where certain functionalities may not be available and the app will still have to be usable.

The next thing to remember is that the mobile application is downloaded and installed on the user’s device. This means the application lives on the user’s device, whereas a web application lives somewhere in the network and is only downloaded once the user requests to view it via their browser. In most cases, when a web application is viewed, only the requested page or part of the application is downloaded to the user’s device. However, as we already discussed in the previous section, Flutter’s web application is a single-page web application, so the whole application is loaded when the user requests the application. In many cases, when the user wants to use the application again, they will have to download the application again, making a request via their browser. The key thing to understand from this difference is that a web application has to think carefully about its size, as it’s downloaded every time a user wants to use that application. In recent years, PWAs have come into being, and are essentially trying to be the best of both worlds. We will talk in detail about PWAs in later chapters.

Another thing to notice here is that as the mobile app lives on a user’s device, the user will have to download updates each time the developer pushes new updates. The user may decide not to update, however, when it comes to web apps living on the server, once the developer updates them, users will get the updated version on their next request. So, a web app is a lot easier to maintain compared to mobile apps.

Unlike mobile applications, a web application also has to take into account a wide range of devices and platforms. Each device and platform has its own pros and cons. The web developer has to think of each platform and device, too. There is a huge variety of possible devices, each with different screen sizes and densities, different platforms, and OSs with different capabilities that the web app could run on. There are also concepts such as `Responsive` and `Adaptive` designs, where the design should be made dynamic to adapt to each platform and device. As a web developer, you will have to think of how to leverage the tools provided by the framework to create a web application that feels and behaves natively on any platform it is accessed on, no matter the capabilities of that platform. We will discuss more on this topic in [ Chapter 3 ](/packtpub/taking_flutter_to_the_web/04_c3_building_responsive_and_adaptive_designs
), Building Responsive and Adaptive Designs.

Therefore, when you look at using Flutter for building web apps, you have to think beyond mobile development. In a web application, you will have to think of a wide range of screen sizes and the capabilities of devices that might run the application. You’ll need to think of the wide possibilities of different platforms. You’ll also have to think of the initial load time, as all the resources will have to be downloaded with the request.

# Official Flutter documentation

You can find the official Flutter documentation at https://flutter.dev/docs. It’s the best place to look for getting started with tutorials, references, and official guides. It also has great resources for those coming from other platforms such as React Native, Android, iOS, the web, or Xamarin.Forms. We will try to centralize web-specific knowledge in this book, but always remember to go back to the docs when you want to learn more and proceed beyond the scope of this book.

# Summary

In this chapter, we introduced you to Flutter on the web and also explained why you should learn Flutter. We then learned what it is good to build with Flutter on the web and what is not suitable (at this current time) to build with Flutter on the web. We also built and ran a default Flutter starter project on the web platform. Finally, we also introduced Flutter on the web from the perspective of a web developer and a mobile developer, and we described how building for Flutter on the web can be different from regular web app development and regular mobile development.

In the next chapter, we will start diving deep into creating our project for the book. We will begin by building a basic layout for our application.



> [ 01 P1 Basics of Flutter Web ](/packtpub/taking_flutter_to_the_web/01_p1_basics_of_flutter_web) <---> [ 03 C2 Creating Your First Web App ](/packtpub/taking_flutter_to_the_web/03_c2_creating_your_first_web_app)
>
> (1) Path: packtpub/taking_flutter_to_the_web/02_c1_getting_started_with_flutter_on_the_web
> (2) Markdown
> (3) Title: 02 C1 Getting Started with Flutter on the Web
> (4) Short Description: Publication date: 10월 2022 Publisher Packt Pages 206 ISBN 9781801817714
> (5) tags: flutter web
> Book Name: Taking Flutter to the Web
> Link: https://subscription.packtpub.com/book/web-development/9781801817714/pref/
> create: 2023-01-19 목 14:36:08
> Images: /packtpub/taking_flutter_to_the_web_img/
> .md Name: 02_c1_getting_started_with_flutter_on_the_web.md

