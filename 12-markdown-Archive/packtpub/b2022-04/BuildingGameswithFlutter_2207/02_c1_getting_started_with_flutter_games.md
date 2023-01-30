
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

> [ 01 P1 Game Basics ](/packtpub/javascript_from_frontend_to_backend/01_p1_game_basics) <---> [ 03 C2 Working with the Flame Engine ](/packtpub/javascript_from_frontend_to_backend/03_c2_working_with_the_flame_engine)

# Chapter 1: Getting Started with Flutter Games

Welcome to Building Games with Flutter!

We will show you how to use Google's Flutter framework to build scalable games that work across mobile and web platforms. Flutter may seem a strange choice at first for building games because there are more established frameworks for making games, such as Unity or Unreal Engine, but a lot of these tools are very complex to learn and it takes a long time to start producing games with them.

Building on your existing knowledge of Flutter and Dart, we will take you through the steps needed to build a 2D game that will work across all supported platforms. Starting with the basics, we will build on this knowledge and gradually get on to more advanced game topics. By the end of the book, you will be able to make your own 2D games containing the following:

Animating graphics around the screen
Playing sound effects and music
Controlling your player with keys, joystick, or gestures
Detecting when graphics collide
Creating game level maps and navigating around them
Designing games
Scaling the game across different platforms
Advanced graphical effects
Intelligent enemies
We will cover the core concepts with examples and then build on this, chapter by chapter, gradually building up a full game that works across different devices. Each chapter will contain code samples to help learn the building blocks of game development, along with the code, image, and sound resources to build our complete game. The game involves the player navigating around a map and avoiding the enemies while collecting as much gold as they can.

In this chapter, we want to delve a bit deeper into Flutter and Dart and what features they have that make them a great choice for game development. This will give you an understanding of why Flutter and Dart can be used for fast, smooth games across many platforms.

In this chapter, we will cover the following topics:

Working with Flutter
Using Dart
Summarizing the book
Creating a simple example animation
We have a lot to cover, so let's get started!

Technical requirements
In this chapter, you should have your code editor set up along with the latest versions of Flutter and Dart installed. The book is based on Flutter v3.0.0, Dart 2.17.0, and Flame v1.0.0.

All the source code for this book can be downloaded from the Git repository at https://github.com/PacktPublishing/Building-Games-with-Flutter.git.

The source code for this chapter specifically can be found here: https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter01.

Working with Flutter
You will have used Flutter to build apps or websites before and may be wondering whether Flutter is good enough to make great games. Flutter is a great choice for game programming for the following reasons:

Flutter has very fast rendering times and is scalable across many platforms.
Flutter games aim to draw at 60 frames per second (FPS) for smooth animation, or 120 FPS on devices capable of supporting higher refresh rates.
Flutter code uses a single code base to make maintenance easier and enables the code to run on many devices.
The Flutter core is written in C++, which makes games run at native speeds.
Flutter is cost-effective due to being open source (businesses like Flutter because they don't have to pay for expensive licenses as they have to with some other frameworks).
Unlike other frameworks, Flutter does not use native components and instead draws its own, all drawn with the lightning-fast Skia Graphics Engine. Skia is an open source graphics library that works on a variety of hardware and software platforms, which abstracts away platform-specific graphics APIs that are different on each platform. The APIs provide functionality for drawing shapes, text, and images.

Now that we have explained Flutter, let's delve deeper into the language that Flutter uses, Dart.

Using Dart
In this section, we will discuss Dart and the language features that make it a great fit for game development. We will discuss how Dart is compiled, and how it uses threads and garbage collection. We will also discuss great features such as how hot reload aids us in developing code fast.

Compilation types
Computer programming languages can be either static or dynamic. A static language will be compiled into machine code before it runs, such as C++. A dynamic language is executed by an interpreter, so it does not need to be compiled before running (such as JavaScript).

As programming languages evolved, virtual machines were invented, which made it easier to port a language to a new hardware platform. The code is converted to bytecode, which is then run on the virtual machine. Java is an example of a language that uses bytecode.

The virtual machine imitates hardware in software and can be ported to run on different hardware platforms, making the code portable.

As compiler technology evolved, just-in-time (JIT) compilers were invented, which improved the performance of code running on virtual machines by compiling the code on the fly.

Compiling a program into machine code before running became known as ahead-of-time (AOT) compilation. Dart is unique in that it supports both JIT and AOT compilation types, which provides a massive advantage for developers. Developers can distribute the app compiled with AOT for maximum speed and performance, which helps games run smoothly.

When running in JIT compilation mode, Flutter and Dart have an amazing feature called stateful hot reload that cuts down development time.

Hot reload
Flutter uses the JIT compiler to allow you to reload and run code in less than a second. This allows you to change code and see the changes reflected on the emulator or web browser instantly, while retaining the internal state of the game.

This is great for game development as you can modify code and see the effect of the change, which speeds up development massively. It feels like painting with code!

For instance, you might reposition a graphic by a few pixels or change a color. In traditional development, you would have to rebuild the code (which could take many minutes) to see the change, but in Flutter, this is instant.

Native bridge
Dynamic languages such as JavaScript communicate with the native code on the platform over a bridge, which is very slow. They do this for things such as drawing the native components of the platform they are running on.

The native bridge is used to provide an interface between dynamic code and native code for all code, sending state information for user interface (UI) components.

In Flutter, instead of this, Skia draws all the components on a canvas (and makes them look and feel like native components), so it bypasses the need for a native bridge.

This is massive because with a native bridge you also need to pass the state of the UI components before they can be drawn, which slows everything down and can cause your UI to skip frames instead of keeping the animation smooth.

Garbage collection
Dart uses an advanced garbage collection system that quickly handles short-lived objects in memory.

As Flutter rebuilds the widget tree every frame, it throws away the old objects and recreates new objects. In a language such as Java, this would cause issues, but Dart is optimized to handle this very quickly.

Most languages require the use of locks to access shared memory, but Dart can perform its garbage collection most of the time without using locks. This fast garbage collection results in very smooth graphics performance, which greatly enhances our game.

Thread control
The developer has more control over code execution in Dart due to the way threads are implemented. Because Dart doesn't usually require locks for accessing shared memory, unlike most other languages, we have more control over the execution of the code.

Without locks, we avoid a type of call called a race condition, which can happen when separate threads want access to the shared resource (in this case, memory) and it can't be accessed because some other thread has locked access and the lock has to be released before other threads can access it.

In this section, we have discussed how the features of the Dart language help us to write fast games. In the next section, we will summarize what you will learn throughout the book.

Summarizing the book
In the following subsections, let's start to take a look at what each chapter will explore.

Flame
In the next chapter, Chapter 2, Working with the Flame Engine, we will cover the basics of how to use the Flame engine library to set up a game loop, and how to organize your assets for efficient loading.

Designing a game
It is important to plan ahead so that you have a blueprint to refer to as you progress through your game.

In Chapter 3, Building a Game Design, we will talk about how to plan and design a game using an example that I will refer to throughout the book.

Graphics
Apart from text-based games, all games have graphics. The graphics are the first thing someone will see when deciding whether to buy or play your game, so it's important for these to look nice if you want to sell your game.

In Chapter 4, Drawing and Animating Graphics, we will show you how to draw graphics on the screen, and how to animate them so they look real. We will also show you how to detect when graphics collide with each other, such as a bullet hitting an enemy, which can be used to trigger another animation, such as the enemy exploding.

Input
All games require some type of input, whether this is touching a screen, pressing a key, or moving a virtual joystick to control a player.

In Chapter 5, Moving the Graphics with Input, we will explain the many methods for controlling the character so that the input and animation are synchronized and feel smooth and responsive.

Sounds
Sound effects and music play an important part in games to enhance the experience for the player. The background music also plays an important part in any game; as you play the game, the music can change to highlight something important in the game or to change the mood of the game.

In Chapter 6, Playing Sound Effects and Music, we will discuss how to synchronize playing a sound effect in response to a game event, such as playing an explosion sound when a bullet collides with an enemy.

Level design
Most games are not played on a single screen and require careful thought about how each level is designed.

In Chapter 7, Designing Your Own Levels, we will explain how to load graphics, sounds, and level data that is needed for the current level, to ensure we don't run into memory or performance issues, which can be a real problem when developing games for low-end devices such as mobile phones.

We will also explain how to make a map that is larger than the physical screen, and how to navigate your player around the screen and scroll the map as the player moves around.

Cross-platform games
One of the key benefits of using Flutter and Dart is the cross-platform features it has for making the game work across multiple devices. We will discuss this topic in more detail in Chapter 8, Scaling the Game for Web and Desktop.

Advanced graphics effects
As we mentioned earlier, graphics are the first thing a user sees so they must look impressive.

In Chapter 9, Implementing Advanced Graphics Effects, we discuss advanced graphical effects and what we can do to make your game look amazing.

We will use particle effects to enhance the existing graphics and make the game really stand out.

We will also discuss how graphical layers can be used to draw graphics more efficiently when there is a lot of animation on the screen.

Game AI
Games are more fun when they are realistic, which we can achieve with artificial intelligence (AI).

In Chapter 10, Making Intelligent Enemies with AI, we will show you how to make enemies that can move from one location to another, avoiding obstacles and enemies that can hunt you when they see you.

Finishing the game
In Chapter 11, Finishing the Game, we will discuss some things needed to finish off the game. This will include other screens that most games have, such as a splash screen for branding and a settings screen for game options (such as controlling the volume of the music).

We will discuss how to sell your game on app stores and how to increase sales of your game through in-app purchases.

Finally, by this point in the book, we will have taught you the basics of game programming but there is so much more you could learn. We will discuss what else you should learn if you want to make more advanced games, and where to go for help if you get stuck while making games.

Now that we have provided an overview of the chapters we will cover throughout the book, in the next section, we will go through a simple animation example to show you how easy it is to get started with game programming in Flutter.

Creating a simple example animation
Here is a code sample for you to run to show how easy it is to draw and animate a simple shape.

To run this example, follow these steps:

First, create a new project in the command line by running the following command:
flutter create goldrush

Copy
Open the goldrush folder that Flutter created in your code editor, and then open the pubspec.yaml file.
Update the description to the following:
description: Flutter game from Building Games with Flutter

Copy
Update the environment SDK to the following:
  sdk: ">=2.17.0 <3.0.0"

Copy
This is the latest version of the SDK at the time of writing the book, and supports the latest features of Flutter and Dart.

Under the dependencies section, we need to add a library called Flame (which we will talk more about in the next chapter):
cupertino_icons: ^1.0.2
flame: 1.0.0

Copy
Flame is a great library and provides us with a lot of functionality needed to build games using Flutter and Dart.

Now that we have finished updating the pubspec.yaml file, save the changes.
After saving the changes, your code editor should download the new dependency. If this doesn't update, you can manually run the following command from the command line in the same directory as your project:
flutter pub get

Copy
Next, open the lib/main.dart file and delete all the boilerplate code.
Then, we need to set up the imports we will need for this example:
import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

Copy
Under this, we need to add our main function to initialize the game and the screen:
void main() async {
  final goldRush = GoldRush();
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();
  runApp(
    GameWidget(game: goldRush)
  );
}

Copy
Here, we set up our GoldRush game object (which we will define next) and told Flame that we want to run the game in full screen and in portrait mode. We also ran the app, passing the GameWidget.

Next, let's set up the game widget and some variables that we will use in the game:
class GoldRush with Loadable, Game {
  static const int squareSpeed = 250;
  static final squarePaint = 
    BasicPalette.green.paint();
  static final squareWidth = 100.0, squareHeight = 
    100.0;
  late Rect squarePos;
  int squareDirection = 1;
  late double screenWidth, screenHeight, centerX, 
    centerY;

Copy
Let's break down what we did here:

Here, we set up the animation speed of the square to be 250; you can adjust this to a higher number to make the animation faster or lower to make the animation slower.
We set the color of our box to green.
The width and height of the box are set to a fixed size of 100 pixels.
Because we will adjust the position of the box, we use Rect for the square position, which will be initialized in onLoad once we have calculated the center of the screen for the starting position.
We set the direction to be a positive value, which will increase the x value and move the box to the right.
Finally, we set up the variables for the screen width and height, and the center of the screen.
In the onLoad function, we will calculate the center starting position of the box based on the screen size:
  @override
  Future<void> onLoad() async {
    super.onLoad();
    screenWidth =
      MediaQueryData.fromWindow(window).size.width;
    screenHeight =
      MediaQueryData.fromWindow(window).size.height;
    centerX = (screenWidth / 2) - (squareWidth / 2);
    centerY = (screenHeight / 2) - (squareHeight / 2);
    squarePos = Rect.fromLTWH(centerX, centerY, 
      squareWidth, squareHeight);
  }

Copy
Next, we will define the render function, which draws the square on the screen at its current position:
  @override
  void render(Canvas canvas) {
    canvas.drawRect(squarePos, squarePaint); 
  }

Copy
Next, we update the square position every frame based on its speed and direction, plus the time that has elapsed since the previous frame.
Then, if the position of the square has reached the edge of the screen, we can flip the direction of the square:

  @override
  void update(double deltaTime) {
    squarePos = squarePos.translate(squareSpeed *
      squareDirection * deltaTime, 0);
    if (squareDirection == 1 && squarePos.right >
    screenWidth) {
      squareDirection = -1;
    } else if (squareDirection == -1 && squarePos.left
      < 0) {
      squareDirection = 1;
    }
  }
}

Copy
Now, we can run the example and see our simple green square animating from left to right, reversing its direction when it hits the side of the screen.
Now, we have gone through a simple animation example to show how easy it is to get started and to give you a feel for game programming with Flutter.

Feel free to play with the code, maybe changing the color of the square or adding more squares at a different position. In the next chapter, we will dig deeper into this code.

Summary
In this chapter, we explained why Flutter and Dart are well suited to multiplatform game development. We explained the building blocks of games that we will focus on in each section of the book. Finally, we showed you a simple code example to play with.

In the next chapter, we will start using Flame, the game engine library that works with Flutter to add features related to game programming.

Questions
What is the minimum constant frame rate that Flutter draws at?
What is the name of the graphics engine used by Flutter?
Which platforms can we support with Flutter?
What is Skia and what is it used for?
What types of compilation does Dart support and why are they beneficial?
Why is stateful hot reload beneficial for rapid game development?
Why is Dart's garbage collection beneficial for the smooth animation used in games?



> [ 01 P1 Game Basics ](/packtpub/javascript_from_frontend_to_backend/01_p1_game_basics) <---> [ 03 C2 Working with the Flame Engine ](/packtpub/javascript_from_frontend_to_backend/03_c2_working_with_the_flame_engine)
>
> Title: 02 C1 Getting Started with Flutter Games
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/02_c1_getting_started_with_flutter_games
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 02_c1_getting_started_with_flutter_games.md

