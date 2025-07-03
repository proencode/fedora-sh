
| 🏁 0625 Beginning C++ Game Programming | 00 Preface | [ 01 Welcome to Beginning C++ Game Programming, 3Ed ](/books/packtpub/2025/0625/01) ≫ |
|:----:|:----:|:----:|

# 00 Preface

Beginning C++ Game Programming - Third Edition
By : John Horton

# Overview of this book
Always dreamed of creating your own games? With the third edition of Beginning C++ Game Programming, you can turn that dream into reality! This beginner-friendly guide is updated and improved to include the latest features of VS 2022, SFML, and modern C++20 programming techniques. You'll get a fun introduction to game programming by building four fully playable games of increasing complexity. You'll build clones of popular games such as Timberman, Pong, a Zombie survival shooter, and an endless runner. The book starts by covering the basics of programming. You'll study key C++ topics, such as object-oriented programming (OOP) and C++ pointers and get acquainted with the Standard Template Library (STL). The book helps you learn about collision detection techniques and game physics by building a Pong game. As you build games, you'll also learn exciting game programming concepts such as vertex arrays, directional sound (spatialization), OpenGL programmable shaders, spawning objects, and much more. You’ll dive deep into game mechanics and implement input handling, levelling up a character, and simple enemy AI. Finally, you'll explore game design patterns to enhance your C++ game programming skills. By the end of the book, you'll have gained the knowledge you need to build your own games with exciting features from scratch.
🧩

# Preface
Always dreamed of creating your own games? With the third edition of Beginning C++ Game Programming, you can turn that dream into reality! This beginner-friendly guide is updated and improved to include the latest features of VS 2022, SFML, and modern C++20 programming techniques. You will get a fun introduction to game programming by building four fully playable games of increasing complexity. You’ll build clones of popular games such as Timberman, Pong, a Zombie survival shooter, and an endless runner.

The book starts by covering the basics of programming. You’ll study key C++ topics, such as object-oriented programming (OOP) and C++ pointers, and get acquainted with the Standard Template Library (STL). The book helps you learn about collision detection techniques and game physics by building a Pong game. As you build games, you’ll also learn exciting game programming concepts such as vertex arrays, directional sound (spatialization), OpenGL programmable shaders, spawning objects, and much more. You’ll dive deep into game mechanics and implement input handling, levelling up a character, and simple enemy AI. Finally, you’ll explore game design patterns to enhance your C++ game programming skills.

By the end of the book, you’ll have gained the knowledge you need to build your own games with exciting features from scratch.
🧩

# Who this book is for
This book is perfect for you if you have no C++ programming knowledge, you need a beginner-level refresher course, or you want to learn how to build games or just use games as an engaging way to learn C++.

Whether you aspire to publish a game (perhaps on Steam) or just want to impress friends with your creations, you’ll find this book useful.
🧩

# What this book covers
Chapter 1, Welcome to Beginning C++ Game Programming, Third Edition: This chapter outlines the journey to writing exciting games for PC using C++ and the OpenGL powered SFML. This third edition has an overwhelming focus on improving and expanding upon what you will learn in game programming. All the C++ basics from variables in the beginning, through loops, object-oriented programming, the Standard Template Library, SFML features, and newer C++ possibilities, have been added to and expanded upon. By the end of this book, you will not only have four playable games but also have a deep and solid grounding in C++.

Chapter 2, Variables, Operators, and Decisions: Animating Sprites: In this chapter, we will do quite a bit more drawing on the screen. We will animate some clouds that travel at a random height and a random speed across the background and a bee that does the same in the foreground. To achieve this, we will need to learn some more of the basics of C++. We will be learning how C++ stores data with variables as well as how to manipulate those variables with the C++ operators and how to make decisions that branch our code on different paths based on the value of variables. Once we have learned all this, we will be able to reuse our knowledge about the SFML Sprite and Texture classes to implement our cloud and bee animations.

Chapter 3, C++ Strings, SFML Time, Player Input, and HUD: In this chapter, we will spend around half the time learning how to manipulate text and display it on the screen and the other half looking at timing and how a visual time bar can inform the player and create a sense of urgency in the game.

Chapter 4, Loops, Arrays, Switch, Enumerations, and Functions – Implementing Game Mechanics: This chapter probably has more C++ information than any other chapter in the book. It is packed with fundamental concepts that will move our understanding on enormously. It will also begin to shed light on some of the murky areas we have been skipping over a little bit, like functions, the game loop, and loops in general.

Chapter 5, Collisions, Sound, and End Conditions: Making the Game Playable: This is the final phase of the first project. By the end of this chapter, you will have your first completed game. Once you have Timber!!! up and running, be sure to read the last section of this chapter as it will suggest ways to make the game better. Here is what we will cover in this chapter: adding the rest of the sprites, handling the player input, animating the flying log, handling death, adding sound effects, adding features, and improving Timber!!!.
🧩



Chapter 6, Object-Oriented Programming – Starting the Pong Game: In this chapter, there’s a little bit of theory, but the theory will give us the knowledge that we need to start using object-oriented programming (OOP). OOP helps us organize our code into human-recognizable structures and handle complexity. We will not waste any time in putting that theory to good use as we will use it to code the next project, a Pong game. We will get to look behind the scenes at how we can create new C++ types that we can use as objects. We will achieve this by coding our first class. To get started, we will look at a simplified Pong game scenario so that we can learn about some class basics, and then we will start again and code a Pong game for real using the principles we have learned.

Chapter 7, AABB Collision Detection and Physics – Finishing the Pong Game: In this chapter, we will code our second class. We will see that although the ball is obviously quite different from the bat, we will use the exact same techniques to encapsulate the appearance and functionality of a ball inside a Ball class, just like we did with the bat and the Bat class. We will then add the finishing touches to the Pong game by coding some collision detection and scorekeeping. This might sound complicated but as we are coming to expect, SFML will make things much easier than they otherwise would be.

Chapter 8, SFML Views – Starting the Zombie Shooter Game: In this project, we will be making even more use of OOP, and to a powerful effect. We will also be exploring the SFML View class. This versatile class will allow us to easily divide our game up into layers for different aspects of the game. In the Zombie Shooter project, we will have a layer for the HUD and a layer for the main game. This is necessary because the game world expands each time the player clears a wave of zombies. Eventually, the game world will be bigger than the screen and the player will need to scroll. The use of the View class will prevent the text of the HUD from scrolling with the background.

Chapter 9, C++ References, Sprite Sheets, and Vertex Arrays: In Chapter 4, Loops, Arrays, Switch, Enumerations, and Functions – Implementing Game Mechanics, we talked about scope. This is the concept that variables declared in a function or inner block of code only have scope (that is, can be seen or used) in that function or block. Using only the C++ knowledge we have currently, this can cause a problem. What do we do if we need to work on a few complex objects that are needed in the main function? This could imply all the code must be in the main function.

In this chapter, we will explore C++ references, which allow us to work on variables and objects that are otherwise out of scope. In addition to this, these references will help us avoid having to pass large objects between functions, which is a slow process. It is slow because each time we do this, a copy of the variable or object must be made.

Armed with this new knowledge of references, we will look at the SFML VertexArray class, which allows us to build up a large image that can be quickly and efficiently drawn to the screen using multiple parts in a single image file. By the end of this chapter, we will have a scalable, random, scrolling background that’s been made using references and a VertexArray object.

Chapter 10, Pointers, the Standard Template Library, and Texture Management: In this chapter, we will learn a lot as well as get plenty done in terms of the game in this chapter. We will first learn about the fundamental C++ topic of pointers. Pointers are variables that hold a memory address. Typically, a pointer will hold the memory address of another variable. This sounds a bit like a reference, but we will see how they are much more powerful and use a pointer to handle an ever-expanding horde of zombies.

We will also learn about the Standard Template Library (STL), which is a collection of classes that allow us to quickly and easily implement common data management techniques.
🧩



Chapter 11, Coding the TextureHolder Class and Building a Horde of Zombies: Now that we have understood the basics of the STL, we will be able to use that new knowledge to manage all the textures from the game because if we have 1,000 zombies, we don’t really want to load a copy of a zombie graphic into the GPU for each and every one.

We will also dig a little deeper into OOP and use a static function, which is a function of a class that can be called without an instance of the class. At the same time, we will see how we can design a class to ensure that only one instance can ever exist. This is ideal when we need to guarantee that different parts of our code will use the same data.

Chapter 12, Collision Detection, Pickups, and Bullets: So far, we have implemented the main visual aspects of our game. We have a controllable character running around in an arena full of zombies that chase them. The problem is that they don’t interact with each other. A zombie can wander right through the player without leaving a scratch. We need to detect collisions between the zombies and the player.

If the zombies are going to be able to injure and eventually kill the player, it is only fair that we give the player some bullets for their gun. We will then need to make sure that the bullets can hit and kill the zombies.

At the same time, if we are writing collision detection code for bullets, zombies, and the player, it would be a good time to add a class for health and ammo pickups as well.

Here is what we will do and the order in which we will cover things in this chapter: shooting bullets, adding a crosshair and hiding the mouse pointer, spawning pickups, and detecting collisions

Chapter 13, Layering Views and Implementing the HUD: In this chapter, we will get to see the real value of SFML Views. We will add a selection of SFML Text objects and manipulate them as we did before in the Timber!!! project and the Pong project. What’s new is that we will draw the HUD using a second View instance. This way, the HUD will stay neatly positioned over the top of the main game action, regardless of what the background, player, zombies, and other game objects are doing.

Chapter 14, Sound Effects, File I/O, and Finishing the Game: We are nearly done with this project. This short chapter will demonstrate how we can easily manipulate files stored on the hard drive using the C++ standard library, and we will also add sound effects. Of course, we know how to add sound effects, but we will discuss exactly where the calls to the play function will go in the code. We will also tie up a few loose ends to make the game complete. In this chapter, we will cover the following topics: saving and loading the hi-score using file input and file output, adding sound effects, allowing the player to level up, and spawning a new wave.

Chapter 15, Run!: Welcome to the final project. Run, Run is an endless runner where the objective of the player is to stay ahead of the disappearing platforms that are catching them up from behind. In this project, we will learn loads of new game programming techniques and even more C++ topics to implement those techniques. Perhaps the best improvement this game will have over the previous games is that it will be way more object oriented than any of the others. There will be many, many more classes than any of the preceding projects but most of the code files for these classes will be short and uncomplicated. Furthermore, we will build a game where the functionality and appearance of all the in-game objects is pushed out to classes, leaving the main game loop unchanged regardless of what the GameObjects do. This is powerful because it means you can make a hugely varied game just by designing new standalone components (classes) that describe the behavior and appearance of the required game entity. This means you can use the same code structure for a completely different game of your own design. But there is way more to come than just this. Read on for details.
🧩



Chapter 16, Sound, Game Logic, Inter-Object Communication, and the Player: In this chapter, we will quickly implement our game’s sound. We have done this before, so it won’t be hard. In fact, in just half a dozen lines of code, we will also add music to our sound features. Later in the project, but not in this chapter, we will add directional (spatialized) sound.

In this chapter, we will wrap all our sound-related code into a single class called SoundEngine. Once we have some noise, we will then move on to get started on the player. We will achieve the entire player character functionality just by adding two classes: one that extends Update and one that extends Graphics. This creation of new game objects by extending these two classes will be how we do almost everything else for the entire game. We will also see the simple way that objects communicate with each other using pointers.

Chapter 17, Graphics, Camera, Action: In this chapter, we will talk in depth about the way the graphics will work in this project. As we will be coding the cameras that do the drawing in this chapter, now seems like a good time to talk about the graphics too. If you looked in the graphics folder, there is just one graphic. Furthermore we are not calling window.draw at any point in our code so far. We will discuss why draw calls should be kept to a minimum as well as implement our Camera classes that will handle this for us. Finally, in this chapter, we will be able to run the game and see the cameras in action, including the main view, the radar view, and the timer text.

Chapter 18, Coding the Platforms, Player Animations, and Controls: In this chapter, we will code the platforms and the player animation and controls. In my opinion, we have done the hard work already and most of what follows has a much higher reward-to-effort ratio. Hopefully this chapter will be interesting as we will see how the platforms will ground the player and enable them to run, as well as seeing how we loop through the frames of animation to create a smooth running effect for the player. We will do the following: coding the platforms, adding functionality to the player, coding the Animator class, coding the animations, and adding a smooth running animation to the player.

Chapter 19, Building the Menu and Making It Rain: In this chapter, we will implement two significant features. One is a menu screen to keep the player informed of their options for starting, pausing, restarting, and quitting the game. The other job will be to create a simple raining effect. You could argue the raining effect isn’t necessary, even that it doesn’t fit the game, but it is easy, fun, and a good trick to learn. What you should expect by now, and yet is still perhaps the most interesting aspect of this chapter, is how we will achieve both these objectives by coding classes derived from Graphics and Update, composing them in GameObject instances, and they will just work alongside all our other game entities.

Chapter 20, Fireballs and Spatialization: In this chapter, we will be adding all the sound effects and the HUD. We have done this in two of the previous projects, but we will do things a bit differently this time. We will explore the concept of sound spatialization and how SFML makes this complicated concept nice and easy. In addition, we will build a HUD class to encapsulate our code that draws information to the screen.

Chapter 21, Parallax Backgrounds and Shaders: This is the last chapter and our last opportunity to work on our game. It will be fully playable with all the features by the end. Here is what we will do to wrap up the Run game. We will learn a bit more about OpenGL, shaders, and the Graphics Library Shading Language (GLSL), finish the CameraGraphics class by implementing a scrolling background and shader, a code a shader by using someone else’s code, and finally run the completed game
🧩



# To get the most out of this book
There are no knowledge prerequisites for this book. You do not need to know how to program as the book takes you from zero knowledge to four playable games. It will help a little if you have played a few video games and you are determined to learn.

## Download the example code files
The code bundle for the book is hosted on GitHub at https://github.com/PacktPublishing/Beginning-C-Game-Programming-Third-Edition. We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

## Download the color images
We also provide a PDF file that has color images of the screenshots/diagrams used in this book. You can download it here: https://packt.link/gbp/9781835081747.

## Conventions used
There are a number of text conventions used throughout this book.

CodeInText: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. For example: “My main project directory is D:\VS Projects\Timber.”

A block of code is set as follows:

```
int playerScore = 0;
char playerInitial = 'J';
float valuePi = 3.141f;
bool isAlive = true;
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

```
// Make a tree sprite
Texture textureTree;
textureTree.loadFromFile("graphics/tree.png");
Sprite spriteTree;
spriteTree.setTexture(textureTree);
spriteTree.setPosition(810, 0);
while (window.isOpen())
{
```

Any command-line input or output is written as follows:

```
# cp /usr/src/asterisk-addons/configs/cdr_mysql.conf.sample
     /etc/asterisk/cdr_mysql.conf
```

Bold: Indicates a new term, an important word, or words that you see on the screen. For instance, words in menus or dialog boxes appear in the text like this. For example: “Select System info from the Administration panel.”

Warnings or important notes appear like this.

Tips and tricks appear like this.
🧩



# Get in touch
Feedback from our readers is always welcome.

General feedback: Email feedback@packtpub.com and mention the book’s title in the subject of your message. If you have questions about any aspect of this book, please email us at questions@packtpub.com.

Errata: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you reported this to us. Please visit http://www.packtpub.com/submit-errata, click Submit Errata, and fill in the form.

Piracy: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packtpub.com with a link to the material.

If you are interested in becoming an author: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit http://authors.packtpub.com.

Share your thoughts
Once you’ve read Beginning C++ Game Programming, Third Edition, we’d love to hear your thoughts! Please click here to go straight to the Amazon review page for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we’re delivering excellent quality content.

Download a free PDF copy of this book
Thanks for purchasing this book!

Do you like to read on the go but are unable to carry your print books everywhere?

Is your eBook purchase not compatible with the device of your choice?

Don’t worry, now with every Packt book you get a DRM-free PDF version of that book at no cost.

Read anywhere, any place, on any device. Search, copy, and paste code from your favorite technical books directly into your application.

The perks don’t stop there, you can get exclusive access to discounts, newsletters, and great free content in your inbox daily.

Follow these simple steps to get the benefits:

Scan the QR code or visit the link below:

https://packt.link/free-ebook/9781835081747

Submit your proof of purchase.
That’s it! We’ll send your free PDF and other benefits to your email directly.
🧩

| 🏁 0625 Beginning C++ Game Programming | 00 Preface | [ 01 Welcome to Beginning C++ Game Programming, 3Ed ](/packtpub/2025/0625_beginning_c++_game_programming/01_welcome_to_beginning_c++_game_programming,_3ed) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2025/0625_beginning_c++_game_programming/00_preface __
> (2) Markdown
> (3) Title: 00 Preface
> (4) Short Description: John Horton May 2024 648 pages 3rd Edition
> (5) tags: C++, game
> Book Name: 0625 Beginning C++ Game Programming
> Link: https://subscription.packtpub.com/book/game-development/9781835081747/pref
> create: 2025-06-29 일 13:52:11
> Images: /packtpub/2025/0625_beginning_c++_game_programming_img/ __
> .md Name: 00_preface.md __


---------- cut line ----------

ff-func-key-setting.vi

| q     | w     | e     | r     | t     | y     | u     | i     | o     | p     |
:------:|------:|------:|------:|------:|------:|------:|------:|------:|------:|
|### title | \`\`\` \`\`\` Expl| \`xxx\`|\`xxx\`|\`xxx\`|\`xxx\`|\`xxx\`|\`xxx \`|\`xxx \`| 없 음 |
| a     | s     | d     | f     | g     | h     | j     | k     | l     |
| 없 음 | 없 음 | \*\*xxx\*\*| \*\*xxx\*\*| \*\*xxx\*\*| \*\*xxx\*\*| \*\*xxx\*\*| \*\*xxx\*\*| \*\*xxx\*\*|

마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------
