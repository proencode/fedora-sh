
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

> [ 02 C1 Getting Started with Flutter Games ](/packtpub/javascript_from_frontend_to_backend/02_c1_getting_started_with_flutter_games) <---> [ 04 C3 Building a Game Design ](/packtpub/javascript_from_frontend_to_backend/04_c3_building_a_game_design)

# Chapter 2: Working with the Flame Engine

Flame is a game engine that is added, as a library, to your Flutter project. It provides us with modules that allow us to build our game. These include support for images and sprites, animations, audio, collision detection, and more advanced modules for 2D physics and tile maps.

In this chapter, we will focus on how to get started with Flame and gain an understanding of the basics of the game engine, including its assets, game loops, and components. It's important to know all of this so that you have a good understanding of the library and how everything fits together to make games with Flame.

Once you are familiar with the basics of Flame, you will be able to progress to the more advanced topics later in the book.

In this chapter, we will cover the following topics:

Organizing the assets in your game
Adding the game loop
Working with components
Technical requirements
To examine the sources mentioned in this chapter, you can download them at https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter02.

The Flame project is evolving very quickly, so please refer to the very latest documentation for any changes or new features at https://flame-engine.org/docs/#/. At the time of writing, the latest version is 1.0.0, which has been integrated with Flutter v3.0.0 onward.

To install the latest version to your project, please add the following to your pubspec.yaml file:

dependencies:

Copy
  flame: 1.0.0

Copy
After saving the file, the dependency will be downloaded, and the Flame modules will become available. If you followed the example at the end of the previous chapter, then you will already have this set up, so please ensure you have already done this.

The newest versions of Flame can always be found in the pub repository at https://pub.dev/packages/flame/install.

Organizing the assets in your game
Your game will include many assets, such as images, audio, fonts, maps, and game data.

As with Flutter, Flame supports the asynchronous loading of assets and caching. However, it also builds on top of that functionality to add features that are useful for images and audio, to help use and manage those assets effectively. For example, if you have a sprite sheet containing many frames of animation, you can load them and split them into their individual sprites very easily. This is covered, in more depth, in Chapter 4, Drawing and Animating Graphics.

All of your assets go under the assets folder in Flutter. I recommend the following folder structure to keep everything well organized:

assets

Copy
--- audio

Copy
------ music

Copy
--------- music_menu.mp3

Copy
------ sounds

Copy
--------- sound_shoot.mp3

Copy
--- images

Copy
------ sprites

Copy
--------- sprite_player.png

Copy
--------- sprite_enemy.png

Copy
--- fonts

Copy
------ font_highscore.ttf

Copy
--- maps

Copy
------ map_level.tmx

Copy
If they are stored within the assets folder, Flutter and Flame allow you to organize your assets however you want.

In your pubspec.yaml file, the previous assets should then look like this:

flutter:

Copy
  assets:

Copy
    - assets/audio/music/music_menu.mp3

Copy
    - assets/audio/sound/sound_shoot.mp3

Copy
    - assets/images/sprites/player.png

Copy
    - assets/images/sprites/enemy.png

Copy
    - assets/fonts/font_highscore.ttf

Copy
    - assets/maps/map_level.tmx

Copy
I recommend prefixing the asset type to make it very clear what the asset is. For instance, you might have a player sound and a player sprite, so having them named sound_player.mp3 and sprite_player.png makes what they represent clearer.

Additionally, you should load any game assets for your current screen or level in advance at the start of the game or level. Flame has an onLoad() function that you can use to override this, which we will discuss further in the next section.

Flame has some helper functions to load the different asset types:

await Flame.images.load('player.png');

Copy
await FlameAudio.audioCache.load('explosion.mp3');

Copy
Here, the load function loads the asset into Flutter's internal memory cache for faster access. Also, it's important to use async/await as the assets are loading asynchronously, so we need to wait until the assets have been loaded before continuing.

Now that we understand how to add assets to our game, let's talk about how Flame constantly redraws the screen based on the current game state.

Adding the game loop
The game loop controls any updates to the game state and then draws any graphics on the screen to reflect the current game state.

For instance, the player might move the character they are controlling to the right, which will then increase the x position of the player's sprite during the game state update. Now that the game state has changed, the player will be drawn at the new position.

In a more complex game, hundreds of enemy sprites could also be moving around. Therefore, the state of these sprites also needs to be calculated.

This continues in a loop, where anything that is currently on the screen is updated and then redrawn. Each redraw is known as a game frame.

The number of frames drawn per second reflects how smooth the game is. In Flutter, apps and games redraw at 60 frames per second (FPS) to allow for very smooth redrawing.

In Flame, there are two functions that we can override to control the updating of the game state and drawing:

void update (double deltaTime) 

Copy
void render (Canvas canvas)

Copy
Let's look at these functions in more detail.

Update
In the update function, a parameter is passed called deltaTime, which tells us the time that has elapsed since the previous frame was drawn. We need this value to ensure our sprites run at consistent speeds across different devices. Devices run at different speeds depending on the processing power, so if we ignore the delta value and just run everything at the maximum speed the processor can run, the player might have trouble controlling their character properly as it would be too fast. By using the deltaTime parameter in our movement calculation, we can guarantee our sprites will move at the speed that we want on devices with different processor speeds, ensuring a consistent speed on all devices.

To see this in practice, let's break down the example in Chapter 1, Getting Started with Flutter Games, to understand what is going on:

static const int squareSpeed = 250;

Copy
int squareDirection = 1;

Copy
Here, we want to set the speed of our square to the consistent value of 250. Our direction will be set to a positive value of 1. If you increase the x value of a sprite by 1, it will move to the right, whereas if you reduce it by -1, it will move left. For the y position, increasing by 1 will move the sprite down, while decreasing it will move the sprite up.

We can keep track of the position using a Rect, which represents a rectangle containing the x and y positions, along with the width and height of the rectangle.

In the update function, we then translate the x position by considering the speed and current direction using the deltaTime parameter, as follows:

squarePos = squarePos.translate(squareSpeed * 

Copy
  squareDirection * deltaTime, 0);

Copy
This translates the x value of the square position by multiplying the speed, direction, and deltaTime parameters together. The y value is 0, which means we are not translating the y value. This is because, in this example, we are not moving in the y direction. However, you can update them at the same time to travel diagonally if you ever need to.

Render
The render function has a Canvas object parameter, which is a blank canvas that we draw onto. The canvas class has many functions for drawing shapes and images directly onto the canvas, as follows:

canvas.drawRect(squarePos, squarePaint);

Copy
Here, we draw a rectangle on the canvas using the position of our sprite and using the color of the paint object to apply the paint styling. The paint object represents styling similar to CSS for the web by applying the styling to the square. In this example, the position is being updated manually by a fixed amount; however, in Chapter 5, Moving the Graphics with Input, we will go into greater detail about how to control the position based on the user's input.

In Flame, we implement the game loop by extending one of the base classes, which automatically calls our update and render functions continuously. In the first example from Chapter 1, Getting Started with Flutter Games, we used the Game mixin. This allowed us to override the update and render functions. This allowed us a lot of control over the process, but it can be very cumbersome once you start drawing and updating a lot of sprites. Then, when you start adding input controls and collision detection, it can quickly become difficult to maintain and keep track of everything.

Fortunately, Flame has classes to help with all this as your game grows, which we will discuss further in the next section.

Working with components
As with any growing code base, it's important to have a structure. This is so that the code is easy to maintain as we add more features to the game.

Currently, our code contains a simple example of how to render and update a square on the screen, using the Game mixin to override these functions.

Using the Game mixin gives us a lot of control over our code, but we would have to write a lot of extra code to support the game as the game grows. This is great once you become more familiar with Flame and games programming and want that level of control. However, to begin, it's better to extend from the FlameGame class.

Components provide us with a structured way to organize our game as our game increases in complexity.

FlameGame
The FlameGame class builds on the Game mixin and adds a lot of useful functionality to help us manage the complexity of our game as it grows. This includes the following:

Flame Component System
Collision detection tracking
Default implementations for render and update
Flame Component System allows us to split parts of our game up into components (classes) that represent an entity in our game, such as the player. For instance, we can have a SpriteComponent component to encapsulate everything related to our player sprite to manage drawing and updating any objects the player has collided with, or any other state that is specifically related to the player.

The FlameGame class maintains a list of all components for the game, and these can be added dynamically to the game as needed; for instance, we might add several enemy SpriteComponent components to the game and then remove them from the game as the player kills the enemies. Then, the FlameGame class will iterate over these components by telling each component to update and render itself.

Flame Component System has a lot of different types of components to help with managing different parts of our game. Here is a list of some of the most common components:

SpriteComponent: For managing any sprites our game has
JoystickComponent: A virtual joystick for managing input
TextComponent: Text that we draw on the screen, such as the score
ParticleComponent: Particle graphic effects
The complete hierarchy for the component system can be seen at https://docs.flame-engine.org/1.0.0/components.html.

As you can see from the component diagram at the top of Flame's website, there are a lot of components in which to handle different things, but most of the interesting ones extend from PositionComponent.

The PositionComponent component represents an object on the screen that has variables to keep track of the position, the size, and the angle direction of the component.

SpriteComponent extends from PositionComponent, so it gains these variables by default because we are going to need to position and size our sprites.

It then adds extra variables that are more specific to sprites, such as the renderFlipX and renderFlipY variables, to reverse anything drawn to the canvas. This can be useful if you have an image of a character walking from left to right; by setting renderFlipX to true, it will then draw the sprite images in reverse so that it appears to be walking from right to left.

Any components that are added to the FlameGame class can also be tracked for collision detection once we have set up the component's bounding boxes. After setting this up, we will get a callback in an onCollision function that we override. This tells us which components our component has collided with. This makes something that is quite difficult to keep track of much simpler. We will discuss collision detection, in more depth, later.

Let's convert our existing code to use the FlameGame class and Flame Component System.

Converting our code to use components
In this section, we will convert our previous code to use components that improve the readability and maintainability of our code. To do this, perform the following steps:

Create a new directory under our lib directory to store our components, called components. You can do this in Visual Studio Code by right-clicking on the lib folder and selecting New Folder. Alternatively, you can do this from the command line within the lib directory:
mkdir components

Copy
In the new components directory, create a new file, called player.dart, where we will add our new component code for the player.
Open the file, and let's start defining our player's PositionComponent. At the top of the file, import the components package from the Flame library:
import 'dart.ui';
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

Copy
Next, we define the outline for our Player class by overriding the update and render functions:
class Player extends PositionComponent {
  @override
  void update(double deltaTime) {
    super.update(deltaTime);
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}

Copy
A requirement of the overriding components is that we must call the base class using super for both the update and render functions.
In the update and render functions, let's copy the code from our GoldRush game class to our Player class after the super calls to the base class:

@override
void update(double deltaTime) {
super.update(deltaTime);
squarePos = squarePos.translate(squareSpeed * 
  squareDirection * deltaTime, 0);
if (squareDirection == 1 && 
  squarePos.right > screenWidth) {
    squareDirection = -1;
    } 
else if (squareDirection == -1 && 
  squarePos.left < 0) {
      squareDirection = 1;
    }
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(squarePos, squarePaint);
  }

Copy
In your code editor, the square variables might now be highlighted in red; this is because we haven't yet defined those variables in this class. So, to do that, let's move them from the GoldRush class and add the following to the top of the Player class:
  static const int squareSpeed = 250;
  static final squarePaint = 
    BasicPalette.green.paint();
  static final squareWidth = 100.0,
    squareHeight = 100.0;
  late Rect squarePos;
  int squareDirection = 1;
  late double screenWidth, screenHeight, centerX, 
    centerY;

Copy
To calculate the initial square position, the screen dimensions, and the center of the screen, let's move the onLoad function from the GoldRush class to inside our Player component, just below where we defined the variables:
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
Now, in the GoldRush class, you can remove the variables and the functions for render, update, and onLoad that have moved to the Player class.
Next, let's change the class definition to use the FlameGame class instead of the Game mixin:
class GoldRush extends FlameGame {

Copy
In the GoldRush class imports, you can tidy up any imports that are no longer required in this class for palette and the UI.
Now we are going to add the Player component to our FlameGame class so that it can keep track of this component for drawing and updating purposes. Let's add the Player component to the GoldRush onLoad function:

@override
Future<void> onLoad() async {
   super.onLoad();
   add(Player());
}

Copy
Then, update the imports to add the Player component:
import 'components/player.dart';

Copy
Now, if you run the game, you will see that everything works as before, with the green square animating from left to right and bouncing off the sides.
Because we added the Player component to the onLoad function, the FlameGame class is now tracking the component and calling its own onLoad function to initialize the sprite. Then, it continuously calls the sprite's update and render functions to animate the square.

As mentioned previously, another great feature of using the FlameGame class is the collision detection tracking for every registered component once we have initialized the component's bounding box. So, let's do that next.

In the GoldRush class, first, we add the HasCollidables mixin as follows:
class GoldRush extends FlameGame with HasCollidables {

Copy
This tells the FlameGame class to start tracking any collidable objects that we want to track.

In the onLoad function, we are now going to add a special type of collidable object that we want to check for, called ScreenCollidable. If we add ScreenCollidable to our list of collidable components to track, we will be notified any time our bouncing square hits the edges of the screen:
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Player());
    add(ScreenCollidable());
  }

Copy
Also, let's import package:flame/components.dart where ScreenCollidable is, as follows:
import 'package:flame/components.dart';

Copy
Now, in our Player class, in the line that defines the class, we need to add the HasHitboxes and Collidable mixins:
class Player extends PositionComponent with HasHitboxes, Collidable {

Copy
This will allow us to receive a callback when we collide with the sides of the screen in the onCollision function, which we will implement next.

Implement the onCollision function by adding the following:
  @override
  void onCollision(Set<Vector2> points,
    Collidable other) {
    if (other is ScreenCollidable) {
      if (squareDirection == 1) {
        squareDirection = -1;
      } else {
        squareDirection = 1;
      }
    }
  }

Copy
Here, when we receive a callback to onCollision to tell us what component we have collided with, we check whether we have collided with ScreenCollidable, and if so, we simply flip the direction the square is traveling in.

Now that we are using the built-in collision tracking system, we must set up the position of our sprite correctly for the bounding box to be set, so we will use the built-in position variable that is inherited from the PositionComponent component.
First, you can delete or comment the squarePos rectangle as we no longer need this:

// late Rect squarePos;

Copy
Then, in the onLoad function, delete or comment the following line:
// squarePos = Rect.fromLTWH(centerX, centerY, 
//   squareWidth, squareHeight);

Copy
Below this, we will set up the internal variables, position and size:
position = Vector2(centerX, centerY);
size = Vector2(squareWidth, squareHeight);

Copy
Here, we are setting the position and size based on our existing variables where we calculate the center of the screen and have a fixed value for the width and height.

Next, we need to add a shape for the HitBox mixin or it won't detect that it has collided with anything. There are a few built-in shapes that you can use depending on the shape of your sprite and which points of the sprite you want to use for collision detection. Most commonly, your sprites will be rectangular/square-shaped, so you could use HitBoxRectangle as your shape. However, if your sprite were a ball, you would use HitBoxCircle instead. You can also make custom shapes, but in most cases, that is unnecessary.
Our shape is a square, so let's add our shape for the collision tracking where we just set up the position and size, as follows:

addHitbox(HitboxRectangle());

Copy
Our onLoad function should now look like this:
  @override
  Future<void> onLoad() async {
    super.onLoad();
    screenWidth = 
      MediaQueryData.fromWindow(window).size.width;
    screenHeight = 
      MediaQueryData.fromWindow(window).size.height;
    centerX = (screenWidth / 2) - (squareWidth / 2);
    centerY = (screenHeight / 2) - (squareHeight / 2);
    position = Vector2(centerX, centerY);
    size = Vector2(squareWidth, squareHeight);
    addHitbox(HitboxRectangle());
  }

Copy
Now that we have removed our squarePos rectangle, we need to update the render and update functions to use the internal position value:
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderHitboxes(canvas, paint: squarePaint);
  }

Copy
Because we have set up a HitBox mixin that is the same shape and uses the position and size of the PositionComponent component, we can use a built-in function, called renderHitboxes, to draw our shape. Note that we pass in our squarePaint object to keep the look the same.

In the update function, we can remove a lot of code, as updating the position has now become much simpler and our direction change is already handled by the collision tracking:

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
    position.x += 
      squareSpeed * squareDirection * deltaTime;
  }

Copy
Now our code is looking better, and the Player class is taking care of updating its location and rendering, along with dealing with any collisions.

Summary
In this chapter, you were introduced to Flame, which is a great library for building games with Flutter. Additionally, you learned how to set up Flame and organize your assets. We covered the game loop and why the render and update functions are important. Finally, we covered components and converted our existing code to use components for a more organized structure as our game expands.

In the next chapter, we will discuss how to design games using the design template, which we will use for our own game: Gold Rush!

Questions
What does the deltaTime value that is passed to the update function represent?
How does Flame Component System benefit your code?
What shape should you use for detecting a collision with square sprites?



> [ 02 C1 Getting Started with Flutter Games ](/packtpub/javascript_from_frontend_to_backend/02_c1_getting_started_with_flutter_games) <---> [ 04 C3 Building a Game Design ](/packtpub/javascript_from_frontend_to_backend/04_c3_building_a_game_design)
>
> Title: 03 C2 Working with the Flame Engine
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/03_c2_working_with_the_flame_engine
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 03_c2_working_with_the_flame_engine.md

