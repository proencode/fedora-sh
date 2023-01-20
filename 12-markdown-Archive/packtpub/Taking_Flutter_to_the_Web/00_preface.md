
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

> Begin <---> [ 01 P1 Basics of Flutter Web ](/packtpub/taking_flutter_to_the_web/01_p1_basics_of_flutter_web)

# 00 Preface

Taking Flutter to the Web is a book about Flutter and Dart that teaches you to take your basic Flutter knowledge and build responsive web applications.

# Who this book is for

This book is intended for Flutter mobile developers and Dart programmers who want to consolidate their basic Flutter knowledge and build responsive web applications with Flutter.

# What this book covers

[ Chapter 1 ](
), Getting Started with Flutter on the Web, introduces the Flutter ecosystem and the web as a part of that ecosystem. It also makes clear why we should learn Flutter on the web and what benefits it can add. Finally, it describes what types of web apps should and shouldn’t be built with Flutter. You will also get to know some real-world Flutter web applications.

[ Chapter 2 ](
), Creating Your First Web App, will describe how to start a Flutter project with web platform support. We will build and run a Flutter project on the web using Flutter widgets. This will be a dynamic and responsive app that interacts with its audience.

[ Chapter 3 ](
), Building Responsive and Adaptive Designs, will teach us that the web has a huge number of target devices of different screen sizes and densities. As Flutter is cross-platform, each platform needs to have a native feel. This chapter covers the concept of adaptive and responsive design, which lets us just build apps that are responsive and adaptive to the platform – the web.

[ Chapter 4 ](
), Flutter Web under the Hood, will look at how Flutter renders its widgets as web apps. Understanding these inner workings will help us build better web apps using Flutter.

[ Chapter 5 ](
), Understanding Routes and Navigation, will detail how to use routes and navigation in Flutter on the web. This chapter will cover navigation with a special focus on how this occurs on the web. You will see how to use declarative navigation and understand its benefits.

[ Chapter 6 ](
), Architecting and Organizing, will cover the need for proper architecture and we will learn about simple yet scalable architecture. This chapter discusses why scalable architecture is important and how you can organize files and folders to make it easier to scale and work. You will understand the MVVM architecture, which is simple yet scalable, and see how to practically apply it in an application.

[ Chapter 7 ](
), Implementing Persistence, will teach us how to save data locally using various options – simple key-value storage, or more advanced object storage. You will discover how to persist simple key-value data, which is useful for user settings, and how to use the offline storage for caching, as well as key-value data using HiveDB.

[ Chapter 8 ](
), State Management in Flutter, will outline the basics of state management, as well as covering how to use Riverpod as a state management solution. You will discover the importance of state management and the various options available for it.

[ Chapter 9 ](
), Integrating Appwrite, will teach us how to integrate Appwrite, an open source BaaS for web and mobile applications with services such as Authentication, Database, Cloud Functions, and more.

[ Chapter 10 ](
), Firebase Integration, will detail how to integrate and use Firebase solutions to build dynamic web apps using Flutter. We will cover the authentication part, wherein we will be able to authenticate users. We will see how to implement Firestore to save and load dynamic content.

[ Chapter 11 ](
), Building and Deploying a Flutter Web Application, will expand upon the concepts required to build and deploy web apps developed with Flutter. In this final chapter, we will also learn how to automate our task of building and deploy web apps using CI/CD.

# To get the most out of this book

In order to get the most out of this book, you need to have some basic knowledge and understanding of programming.

We assume you have basic knowledge and understanding of the following:

- Basic programming
- Working with the command line
- The Dart programming language
- The Flutter framework

To gain the most benefits, it is always advised to practice by following along with the lessons. When the lesson is code-heavy, it is advised to keep calm and proceed one step at a time.

![ 0000 Preface ](/packtpub/taking_flutter_to_the_web_img/0000_preface.webp
)
0000_preface.webp

To follow along and run the codes provided for each chapter, you need to install Flutter. You can do so by following the official guide at https://docs.flutter.dev/get-started/install. To build and run Flutter and Dart on the web once they are installed, all you need is to install the Google Chrome browser.

If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book’s GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

# Download the example code files

You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/Taking-Flutter-to-the-Web. If there's an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Download the color images

We also provide a PDF file that has color images of the screenshots and diagrams used in this book. You can download it here: https://packt.link/YvdST

# Conventions used

There are a number of text conventions used throughout this book.

`Code in text`: Indicates code words in the text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example:

“Then, in the `main.dart` file, first import `firebase_core` and `firebase_options.dart` generated by `flutterfire_cli`.”

A block of code is set as follows:

```
Future<bool> anonymousLogin() async {
  if (isLoggedIn) {
    error = 'Already logged in';
    return false;
  }
}
```

Any command-line input or output is written as follows:

```
flutter pub get
```

**Bold**: Indicates a new term, an important word, or words that you see onscreen. For instance, words in menus or dialog boxes appear in **bold**. Here is an example: “Click on the **Start new project** button.”

Tips or important notes

Appear like this.

# Get in touch

Feedback from our readers is always welcome.

**General feedback**: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

**Errata**: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

**Piracy**: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

**If you are interested in becoming an author**: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

# Share Your Thoughts

Once you’ve read Taking Flutter to the Web, we’d love to hear your thoughts! [ Please click here to go straight to the Amazon review page ](https://subscription.packtpub.com/book/web-development/9781801817714/pref/preflvl1sec09/share-your-thoughts) for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we’re delivering excellent quality content.



> Begin <---> [ 01 P1 Basics of Flutter Web ](/packtpub/taking_flutter_to_the_web/01_p1_basics_of_flutter_web)
>
> (1) Path: packtpub/taking_flutter_to_the_web/00_preface
> (2) Markdown
> (3) Title: 00 Preface
> (4) Short Description: Publication date: 10월 2022 Publisher Packt Pages 206 ISBN 9781801817714
> (5) tags: flutter web
> Book Name: Taking Flutter to the Web
> Link: https://subscription.packtpub.com/book/web-development/9781801817714/pref/
> create: 2023-01-19 목 14:36:08
> Images: /packtpub/taking_flutter_to_the_web_img/
> .md Name: 00_preface.md

