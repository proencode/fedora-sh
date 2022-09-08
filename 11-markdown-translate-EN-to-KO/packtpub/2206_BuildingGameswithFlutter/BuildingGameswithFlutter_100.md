




# Preface
With its powerful tools and quick implementation capabilities, Flutter provides a new way to build scalable cross-platform apps. In this book, you'll learn how to build on your knowledge and use Flutter as the foundation for creating games.

This game development book takes a hands-on approach to building a complete game from scratch. You'll see how to get started with the Flame library and build a simple animated example to test Flame. You'll then discover how to organize and load images and audio in your Flutter game. As you advance, you'll gain insights into the game loop and set it up for fast and efficient processing. The book also guides you in using Tiled to create maps, add sprites to the maps that the player can interact with, and see how to use tilemap collision to create paths for a player to walk on. Finally, you'll learn how to make enemies more intelligent with artificial intelligence (AI).

By the end of the book, you'll have gained the confidence to build fun multiplatform games with Flutter.

# Who this book is for
If you are a Flutter developer looking to apply your Flutter programming skills to games development, this book is for you. Basic knowledge of Dart will assist with understanding the concepts covered.

# What this book covers
`Chapter 1`, Getting Started with Flutter Games, explains why to use Flutter/Dart for game programming. You'll see why Flutter and Dart allow the rapid development of cross-platform games and cover the key concepts involved in game programming.

`Chapter 2`, Working with the Flame Engine, provides an overview of the Flame engine used throughout the book to build games.

`Chapter 3`, Building a Game Design, introduces the game we will be building, along with the game's design. The game we will build throughout the book is Gold Rush, and we'll see how to plan the content and screens for the game to build a game plan.

`Chapter 4`, Drawing and Animating Graphics, gives you a detailed look at how to draw and animate graphics on the screen. You will see what sprites are and how we move them around the screen, learn how to animate sprites for realism, and see how to detect when sprites bump into other sprites on the screen.

`Chapter 5`, Moving the Graphics with Input, provides a detailed look at how to move graphics with touch events and onscreen buttons. By drawing an onscreen joystick, we show how to move a sprite around the screen in response to the user's control of the joystick and see how to use touchscreens to move sprites.

`Chapter 6`, Playing Sound Effects and Music, gives you a detailed look at playing music and sounds in response to game events.

`Chapter 7`, Designing Your Own Levels, explains how to create game levels and navigate around them.

`Chapter 8`, Scaling the Game for Web and Desktop, details how to get the same game working across different platforms by scaling up the graphics for different screen resolutions and how navigation could differ between a computer and a phone due to the lack of physical keys on a phone.

`Chapter 9`, Implementing Advanced Graphics Effects, explains how to enhance your game graphics with powerful particle and layer effects.

`Chapter 10`, Making Intelligent Enemies with AI, covers adding intelligence to games with AI. You will see how using AI allows us to make enemies appear more intelligent by chasing our player when they are close, and how we can make our player avoid obstacles while navigating the map.

`Chapter 11`, Finishing the Game, shows you how to add extra screens to your game and navigate between them. It also explains what else you could learn and where to go for help.

# To get the most out of this book
You will be expected to have some knowledge of Flutter and Dart but no knowledge of game development. The book does not teach either Flutter or Dart.

It's assumed that you have a good knowledge of your development tool of choice, such as Visual Studio Code.

B17699_Preface_Table.jpg

If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book's GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

The code for the book was developed with Visual Studio Code but works equally well with Android Studio and other editors.

# Download the example code files
You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/Building-Games-with-Flutter. If there's an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Download the color images
We also provide a PDF file that has color images of the screenshots and diagrams used in this book. You can download it here: https://static.packt-cdn.com/downloads/9781801816984_ColorImages.pdf

# Conventions used
There are a number of text conventions used throughout this book.

`Code in text`: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: "Now that you have finished updating the `pubspec.yaml` file, save the changes."

A block of code is set as follows:
```
void main() async {
  final goldRush = GoldRush();
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();
  runApp(
    GameWidget(game: goldRush)
  );
}
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:
```
cd build/web/
python3 -m http.server 8000 &
```
Any command-line input or output is written as follows:
```
flutter pub get
```

**Bold**: Indicates a new term, an important word, or words that you see onscreen. For instance, words in menus or dialog boxes appear in **bold**. Here is an example: "**The Game Over!!** screen will be shown when the player dies in the game and then they return to the game menu."

Tips or Important Notes

Appear like this.

# Get in touch
Feedback from our readers is always welcome.

General feedback: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

Errata: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

Piracy: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

If you are interested in becoming an author: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

