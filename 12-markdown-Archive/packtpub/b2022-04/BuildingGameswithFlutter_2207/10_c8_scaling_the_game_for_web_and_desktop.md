
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

> [ 09 C7 Designing Your Own Levels ](/packtpub/javascript_from_frontend_to_backend/09_c7_designing_your_own_levels) <---> [ 11 P3 Advanced Games Programming ](/packtpub/javascript_from_frontend_to_backend/11_p3_advanced_games_programming)

# Chapter 8: Scaling the Game for Web and Desktop

So far in this book, we have focused on building games for mobile devices that have small fixed-size screens. One of the benefits of Flutter, of course, is that it is a cross-platform framework that works on mobile, the web, and desktop.

However, when building a game that will run on a website, there are issues that we don't face on mobile. If, instead of launching one of the mobile emulators, you choose the Chrome browser as the target platform in Visual Studio Code and then run the game, you would notice that the map and UI are drawn incorrectly, that there is no background music, and touch events don't work properly.

In this chapter, we will convert the game so that it works on the web and desktop, making sure to fix these issues. When dealing with resizing, we will need to redraw the map and reposition all our components based on our new screen size. Some screens are very high resolution and larger than our physical map size of 1,600 x 1,600, which means we will need to ensure our game still looks great on these larger screens.

In this chapter, we will cover the following topics:

Building the game for the web and desktop
Setting background music
Setting Flutter Web build parameters
Navigating with key events
Technical requirements
To examine the source from this chapter, you can download it from https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter08.

Building the game for the web and desktop
As mentioned in the introduction, if you launched our game in Google Chrome, you would notice that the map and UI are drawn incorrectly and are in the wrong places. So, what is going on here?

The larger screen size that is changing constantly when we resize the screen is confusing our game, which currently thinks the size is fixed and the initial positions of our components are set relative to our fixed screen size. Because of this confusion, the graphics can look weird and our previously working touch events can now get confused because of this new screen size.

The solution to this is to ask the game to tell us when the screen is resized, and for us to use the new screen size to recalculate the positions of all our components. To make this more straightforward, we are going to mathematically calculate the boundaries of our game so that we know where the top, left, right, and bottom of our map are in relation to our new screen size, and then adjust the components based on this boundary.

The following image shows what we want to achieve by fixing the current user interface issues:

Figure 8.1 – The web version of the game with user interface issues fixed
Figure 8.1 – The web version of the game with user interface issues fixed

In Figure 8.1, you can see that when the screen is wider than the map, the tile component draws black borders for the empty space. As the screen's width is larger than the map's width, we see these black borders on the sides, but this is not the case for the height. The screen's height is less than the map's height, so no black borders are drawn at the top and bottom. This may be different on your screen depending on your screen size.

The red rectangle in the preceding image shows the boundary that we want to calculate so that we can adjust everything else relative to it. In this section, we will do just that.

Setting the new screen boundary
Now that we know the boundary we need to calculate, let's go ahead and add it to our code:

Open the maths_utils.dart file and add the following function:
Rect getGameScreenBounds(Vector2 canvasSize) {
}

Copy
At the top of the getGameScreenBounds function, add this code:
  double left = 0, right = 0, top = 0, bottom = 0;
  if (canvasSize.x > 1600) {
    left = (canvasSize.x - 1600) / 2;
  }
  if (canvasSize.y > 1600) {
    top = (canvasSize.y - 1600) / 2;
  }

Copy
Here, we initially define some variables to store our left, right, top, and bottom values.

If the width or height of the screen is less than the map size, 1,600 x 1,600, we set the default values to 0, 0 and only update the default values if the width or height of the screen is greater than the map size.

We pass in canvasSize to the function, which is the current screen size, and deduct 1600 to get the total difference between the two values. We then divide the total difference by 2 because we want to ensure any adjustments will center the map in the available space.

We will call this function at the start of the game, and every time the player changes the screen size by resizing the window, we will then adjust all the components based on this new screen size so they look correct.

Let's continue in our getGameScreenBounds function and set our right and top variables next:
if (canvasSize.x < 1600) {
  right = canvasSize.x;
} else {
  right = left + 1600;
}
if (canvasSize.y < 1600) {
  bottom = canvasSize.y;
} else {
  bottom = top + 1600;
}
return Rect.fromLTRB(left, top, right, bottom);

Copy
Here, we check whether the screen's width is less than 1600, and if it is, we set the right value to the screen's width. Otherwise, to get the right value, we add the left value and the map's width, 1600.

Then we do the same calculation for the bottom value using the screen's height instead.

Next, we create a rectangle to store our values and return it from the function.

Important Note

All the values are based on the absolute pixel values to help us when we calculate the positions of the components, and especially the HUD, which must align closely with the corners.

Finally, we add the following import at the top of the file to resolve the references to the Vector2 and Rect classes we use in this function:
import 'package:flame/extensions.dart';

Copy
Now that we have the maths sorted for calculating the bounds when the screen resizes, let's start applying this to our components.

Fixing the sprites
We will start with George and the enemies, which have a top-level base class of Character. So, let's listen for the game resize event in that class:

Open the character.dart file and add the following variable to the Character class to keep track of the original position of the sprite:
late Vector2 originalPosition;

Copy
Next, let's add the code to listen for the game resize event by overriding the onGameResize function that is part of the Component class, which all our sprites inherit from. Then we adjust the current position based on originalPosition and the current game screen bounds, as shown here:
@override
void onGameResize(Vector2 canvasSize) {
super.onGameResize(canvasSize);
Rect gameScreenBounds = 
  getGameScreenBounds(canvasSize);
position = Vector2(originalPosition.x + 
  gameScreenBounds.left, originalPosition.y + 
    gameScreenBounds.top);
}

Copy
Now that we have the code for handling the resizing, let's add the imports at the top of this file:
import 'package:goldrush/utils/math_utils.dart';
import 'package:flame/extensions.dart';

Copy
With the Character base class resizing now handled, it's very easy to fix George and the enemies. We just need to store the original position in the constructor and the sprites will move correctly when the screen is resized by their callback to onGameResize, which is handled in their Character base class.

So, open the george.dart file and change the constructor to this:
George({required this.hud, required Vector2 position, 
  required Vector2 size, required double speed}) : 
    super(position: position, size: size, speed: 
      speed) {
    originalPosition = position;
  }

Copy
Next, open the skeleton.dart file and change the constructor to this:
Skeleton({required Vector2 position, required Vector2
  size, required double speed}) : super(position:
    position, size: size, speed: speed) {
  originalPosition = position;
}

Copy
Then, open the zombie.dart file and change the constructor to this:
Zombie({required Vector2 position, required Vector2
  size, required double speed}) : super(position:
    position, size: size, speed: speed) {
  originalPosition = position;
}

Copy
Now that we have fixed our main sprites, let's fix the Coin and Water components.

Fixing the coin and water components
To start fixing the water and coin components, perform the following steps:

Open the coin.dart file, change the Coin class constructor, and add a variable for the original position like this:
Coin({required Vector2 position, required Vector2 
  size}) :
  originalPosition = position,
  super(position: position, size: size);
late Vector2 originalPosition;

Copy
Add the following onGameResize function to the Coin class:
@override
void onGameResize(Vector2 canvasSize) {
  super.onGameResize(canvasSize);
  Rect gameScreenBounds = 
    getGameScreenBounds(canvasSize);
  position = Vector2(originalPosition.x + 
    gameScreenBounds.left, originalPosition.y + 
      gameScreenBounds.top);
}

Copy
And finally for the Coin class, let's add the imports at the top of the file:
import 'dart:ui';
import 'package:goldrush/utils/math_utils.dart';

Copy
The code we have added to the Coin class is similar to what we added to the Character classes where we store the originalPosition in the constructor, and then use this value with the new screen size when the game gets resized to calculate our new position.

Let's do the same for the Water class.

Open the water.dart file, change the Water class constructor, and add a variable for the original position like this:
Water({required Vector2 position, required Vector2 
  size, required this.id}) :
  originalPosition = position,
  super(position: position, size: size);
late Vector2 originalPosition;

Copy
Add the following onGameResize function to the Water class:
@override
void onGameResize(Vector2 canvasSize) {
  super.onGameResize(canvasSize);
  Rect gameScreenBounds = 
    getGameScreenBounds(canvasSize);
  position = Vector2(originalPosition.x + 
    gameScreenBounds.left, originalPosition.y + 
      gameScreenBounds.top);
}

Copy
And finally for the Water class, let's add the imports at the top of the file:
import 'package:goldrush/utils/math_utils.dart';
import 'dart:ui';

Copy
Now that we have fixed the sprites, let's fix the background and the tile map.

Fixing the background and tile map
For our tile map, we currently use TiledComponent, which itself extends from the Component class. This is the base class for all other components, and this class doesn't itself have a position. This is a problem for tracking the game bounds for the tile map. So, the solution for this is to wrap our TiledComponent around another class, which we will name TileMapComponent.

TileMapComponent is itself a position component and we will make TiledComponent a child of the new TileMapComponent class. By doing this, we can freely position this new class when the screen resizes.

So, let's continue and add this new wrapper class:

In the components folder, create a new file called tilemap.dart and add the following code:
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:goldrush/utils/math_utils.dart';
class TileMapComponent extends PositionComponent {
  TileMapComponent(this.tiledComponent) {
    add(tiledComponent);
  }
  TiledComponent tiledComponent;
  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    Rect gameScreenBounds = 
      getGameScreenBounds(canvasSize);
    if (canvasSize.x > 1600) {
      double xAdjust = (canvasSize.x - 1600) / 2;
      position = Vector2(gameScreenBounds.left + 
        xAdjust, gameScreenBounds.top);
    } else {
      position = Vector2(gameScreenBounds.left,
        gameScreenBounds.top);
    }
    size = Vector2(1600, 1600);
  }
}

Copy
In this new class, we take TiledComponent via the constructor and add it as a child component, so it will be positioned in the same position as this class. Then, in the onGameResize function, we are adjusting the position and fixing the size of this component to the map size, 1,600 x 1,600.

Moving on to the Background class, in this class, we want to remove the position and size settings – that happens currently in the onLoad function – by removing this function and then setting position and size in the onGameResize function.

Open the background.dart file, remove the onLoad function completely, and add the following code:
@override
void onGameResize(Vector2 canvasSize) {
  super.onGameResize(canvasSize);
  Rect gameScreenBounds =
    getGameScreenBounds(canvasSize);
  if (canvasSize.x > 1600) {
    double xAdjust = (canvasSize.x - 1600) / 2;
    position = Vector2(gameScreenBounds.left +
      xAdjust, gameScreenBounds.top);
  } else {
    position = Vector2(gameScreenBounds.left,
      gameScreenBounds.top);
  }
  size = Vector2(1600, 1600);
}

Copy
As with the TileMapComponent object we just added, this sets position and size based on the new screen size, after a resize.

Important Note

Please note that onGameResize is always called when the component is first created and then again any time after that if the screen is resized. Therefore, we don't need to do anything on onLoad anymore.

Next, let's add the imports:
import 'package:goldrush/utils/math_utils.dart';
import 'dart:ui';

Copy
Finally for the Background class, we are going to change the constructor to increase the priority of the component to ensure that touch events are being picked up currently. Please change the constructor to the following:
Background(this.george) : super(priority: 20);

Copy
In the next section, we will discuss how to fix the HUD components.

Fixing the HUD components
Now let's move on to fixing the HUD components.

Currently, in our HUD, we use the margins to adjust the joystick, run button, and score text locations based on the corners of the screen. There are some known issues at present with the Flame library when the game screen resizes that prevent this from working correctly.

So, we will rewrite part of the HUD to use position instead of margins, and then we can apply our usual calculations of getting the game screen bounds and adjusting the position of the HUD components when the screen resizes.

As in step 2 of the Fixing the background and tile map section, with the Background class, we are going to remove the onLoad functionality and do the resizing in the onGameResize function. We are also going to split this function in two. The first time onGameResize is called, we need to create the HUD components and add them as children adjusting their positions based on the screen size. Every time after that when onGameResize is called, we will just update the HUD components' new positions.

To keep track of this, we will create a variable called isInitialised to track whether we have set up the HUD components already and call the correct code based on that:

Open the hud.dart file and add the isInitialised variable at the top of the class:
bool isInitialised = false;

Copy
Remove the onLoad function and add the following code:
@override
void onGameResize(Vector2 canvasSize) {
  super.onGameResize(canvasSize);
  Rect gameScreenBounds =
    getGameScreenBounds(canvasSize);
  if(!isInitialised) {
  } else {
  }
}

Copy
In the first if code block that checks whether isInitialised is false, add the following code:
final joystickKnobPaint = 
  BasicPalette.blue.withAlpha(200).paint();
final joystickBackgroundPaint = 
  BasicPalette.blue.withAlpha(100).paint();
final buttonRunPaint = 
  BasicPalette.red.withAlpha(200).paint();
final buttonDownRunPaint =
  BasicPalette.red.withAlpha(100).paint();
joystick = Joystick(
knob: CircleComponent(radius: 20.0, paint: 
  joystickKnobPaint),
background: CircleComponent(radius: 40.0, paint: 
  joystickBackgroundPaint),
position: Vector2(gameScreenBounds.left + 100,
  gameScreenBounds.bottom - 80),
);
runButton = RunButton(
button: CircleComponent(radius: 25.0, paint: 
  buttonRunPaint),
buttonDown: CircleComponent(radius: 25.0, paint:
  buttonDownRunPaint),
position: Vector2(gameScreenBounds.right - 80,
  gameScreenBounds.bottom - 80),
onPressed: () => {}
);
scoreText = ScoreText(position: Vector2(
  gameScreenBounds.left + 80, gameScreenBounds.top + 
    60));
add(joystick);
add(runButton);
add(scoreText);
positionType = PositionType.viewport;
isInitialised = true;

Copy
Most of this code will be familiar from our previous onLoad function. Then we set up our HUD components using position instead of margins and add them as children. And then set the isInitialised variable to true, so we don't rerun this code every time the game is resized and keep on adding more components.

You may notice at this point that the child components show an error as they don't currently have a position value, but we will fix that soon.

In the else block, please add the following code, which will update the position of components that we created in the if block:
joystick.position = Vector2(gameScreenBounds.left + 
  80, gameScreenBounds.bottom - 80);
runButton.position = Vector2(gameScreenBounds.right –
  80, gameScreenBounds.bottom - 80);
scoreText.position = Vector2(gameScreenBounds.left + 
  80, gameScreenBounds.top + 60);

Copy
And finally, for the HudComponent class, let's add the imports at the top of the file:
import 'package:goldrush/utils/math_utils.dart';

Copy
Next, let's fix the Joystick and ScoreText classes to use positions instead of margin. Note the RunButton class already had the position value in its constructor, so we don't need to update the RunButton class.

Open the joystick.dart file and change the constructor to the following:
Joystick({required PositionComponent knob,
  PositionComponent? background, Vector2? position}) :
    super (knob: knob, background: background, 
      position: position);

Copy
We can also now remove the unused import:
import 'package:flutter/material.dart';

Copy
Open the score_text.dart file and change the constructor to the following:
ScoreText({Vector2? position}) : super (position:
  position);

Copy
Now let's switch our focus to tying up all these component changes by making changes in our main.dart file to use the new game screen bounds.

Open the main.dart file and add the following imports at the top of the file:
import 'package:goldrush/components/tilemap.dart';
import 'package:goldrush/utils/math_utils.dart';

Copy
In the onLoad function, we want to set up the originalPosition variables for each component by calculating the game screen bounds and using the result from this along with our intended position to adjust the position when the screen is resized.

Continuing in the main.dart file, let's add the code to get the game screen bounds below where we call onLoad in the base class:
@override
Future<void> onLoad() async {
  super.onLoad();
  Rect gameScreenBounds = 
    getGameScreenBounds(canvasSize);

Copy
Next, let's update where we create the George class by passing the position. Let's also change the priority of the George component to fix a loading issue that only happens on the web:
var george = George(hud: hud, position: 
  Vector2(gameScreenBounds.left + 300, 
    gameScreenBounds.top + 300), size: Vector2(48.0, 
      48.0), speed: 40.0);
add (george);
children.changePriority(george, 15);

Copy
Where we create and load the TiledComponent data, we now need to wrap it with our new TileMapComponent:
final tiledMap = await 
  TiledComponent.load('tiles.tmx', Vector2.all(32));
add(TileMapComponent(tiledMap));

Copy
Let's change the positions of the Skeleton and Zombie classes next:
if (index % 2 == 0) {
  add(Skeleton(position: Vector2(position.x + 
    gameScreenBounds.left, position.y + 
      gameScreenBounds.top), size: Vector2(32.0,
        64.0), speed: 60.0));
} else {
  add(Zombie(position: Vector2(position.x + 
    gameScreenBounds.left, position.y + 
      gameScreenBounds.top), size: Vector2(32.0,
        64.0), speed: 20.0));
}

Copy
Next, let's fix the Coin class with the new position:
double posCoinX = (randomX * 32) + 5 + gameScreenBounds.left;
double posCoinY = (randomY * 32) + 5 + gameScreenBounds.top;

Copy
And next, let's fix the Water class' position:
add(Water(position: Vector2(rect.x +
  gameScreenBounds.left, rect.y + 
    gameScreenBounds.top), size: Vector2(rect.width, 
      rect.height), id: rect.id));

Copy
And finally for the user interface issues, let's update the camera so that when it follows George, it considers the new game screen bounds:
camera.followComponent(george, worldBounds: 
  Rect.fromLTWH(gameScreenBounds.left, 
    gameScreenBounds.top, 1600, 1600));

Copy
If you have not previously set up the app for the web, you may need to run the following command in the project folder to create the web folder for the project: flutter create.

Note

All these changes will modify the existing lines in place and use the new game screen bounds along with an initial position where needed.

Now that we have fixed the user interface issues, let's look at why the music isn't playing in the background.

Setting background music
Modern browsers such as Chrome, Safari, and Firefox block websites from playing audio in the background until the user has interacted with the page to ensure that this is what the user really wants. Websites often open pop up sites that annoy users with advertisements. So, the companies that make these browsers added measures such as preventing background audio to give the user more control over these annoying popups.

The browsers specifically don't want background music attempting to play when a page is first loaded, which we are trying to do by starting the music in our game's onLoad function. To fix this for our game temporarily, we can click on the padlock icon that is to the left of the website address and enable any sound permissions in Chrome. Then refresh the page and you will hear the background music again.

Figure 8.2 – Audio permissions in the Chrome browser
Figure 8.2 – Audio permissions in the Chrome browser

This is fine for development, but obviously not great for your players who may visit your website. In the final chapter, Chapter 11, Finishing the Game, we will add some setting screens to the game and allow the player to turn on background music based on a user interface interaction. This will allow the user to turn the music on or off, based on the player's preferences.

In the next section, we will discuss build parameters that we can set to improve the performance of Flutter Web.

Setting Flutter Web build parameters
If you run the game now using Chrome as the device, you will see you can resize the browser window and the page will resize, and components will be updated based on this, although when running the game, the performance isn't great. So, let's discuss how we compile the code for a release and deploy it via a web server for better performance.

When building a web release, we must pass a parameter to the flutter build web command to indicate the web renderer we want to choose from these two options:

html: Choose this web renderer if you are optimizing download size over performance.
canvaskit: Choose this web renderer if you are prioritizing performance and pixel-perfect consistency across platforms.
We will use canvaskit as performance is more important than download size nowadays, but just be aware that html is there as an option if you ever need it:

Let's run the command that will create our release build.
Open a command-line terminal in the project folder and type the following:

flutter build web --release --web-renderer canvaskit

Copy
When this has finished compiling, it will save the web code in the build/web folder.

Next, let's run the web server from the build/web folder:
cd build/web/
python3 -m http.server 8000 &

Copy
Here, we move to the folder where the web code is and run the web server.

We are using the build in web server that the Python language provides for free.

If you don't have Python installed, please go online and install it from https://www.python.org/downloads/ before running this command.

If you have your own web host, you can also upload the contents of the build/web folder to your web host.

With the web server running our game, open any browser and enter http://localhost:8000/ in the browser's address bar.
The game will load, and you will see it running in your browser. You will also notice it loads and runs a lot faster than running it via the Chrome device.

When you have finished playing the game on the web, you should shut down the web server. Because the web server is running in the background, we need to bring it to the foreground first to shut it down.

In your terminal, press the Enter key to start a new line and then type the following to bring the web server to the foreground:
fg

Copy
Next, hit the keys Ctrl + C to stop the web server.
If you need to start and stop the web server as you add new pieces of code that you want to test, please be aware of a couple of things:

You should always compile a release build from the project folder.
You should always run the web server from the build/web folder.
In this section, we addressed the issues with dynamically sized user interfaces and discussed a workaround for the background audio issue. We also discussed how to create a release build for the web and tested this on a web server.

In the next section, we will discuss how to navigate with physical keys.

Navigating with key events
Our game already allows the player character to be controlled with either the joystick or touch events, but for websites, a more common method would be to use the keyboard to control the character.

In this section, we will add keyboard control as another option, so let's get started.

To listen for keyboard events in the game, we first have to tell our game that some of our components will listen for keyboard events:

Open the main.dart file and change the class definition to include the HasKeyboardHandlerComponents mixin:
class GoldRush extends FlameGame with HasCollidables, 
  HasDraggables, HasTappables, 
    HasKeyboardHandlerComponents {

Copy
Add the following input import at the top of the same file:
import 'package:flame/input.dart';

Copy
Open the george.dart file where we will listen for keyboard events and change the class definition to add the KeyboardHandler mixin:
class George extends Character with KeyboardHandler {

Copy
Add the following import at the top of the same file:
import 'package:flutter/services.dart';

Copy
Next, let's add some variables to store the state of the keys that are pressed:
bool keyLeftPressed = false, keyRightPressed = false,
  keyUpPressed = false, keyDownPressed = false, 
    keyRunningPressed = false;

Copy
In our game, we will use the following key mappings:

a. Left = A key

b. Right = D key

c. Up = W key

d. Down = S key

e. Run = R key

Override the following function to the George class to listen for key events and set the variable set up in step 5 correctly, if any of the keys are pressed:
@override
bool onKeyEvent(RawKeyEvent event, 
  Set<LogicalKeyboardKey> keysPressed) {
  if (event.data.keyLabel.toLowerCase().contains('a')) 
    { keyLeftPressed = (event is RawKeyDownEvent); }
  if (event.data.keyLabel.toLowerCase().contains('d'))
    { keyRightPressed = (event is RawKeyDownEvent); }
  if (event.data.keyLabel.toLowerCase().contains('w'))
    { keyUpPressed = (event is RawKeyDownEvent); }
  if (event.data.keyLabel.toLowerCase().contains('s'))
    { keyDownPressed = (event is RawKeyDownEvent); }
  if (event.data.keyLabel.toLowerCase().contains('r'))
    { keyRunningPressed = (event is RawKeyDownEvent); }
  return true;
}

Copy
Here, we check whether the key event data key label equals the letter we mapped, and then set the appropriate variable if the key is pressed.

Note that we convert the data to lowercase in case the player has the caps lock pressed on the keyboard, which would generate a key event of S and not s.

Add the following import to resolve the key classes:
Import 'package:flutter/services.dart';

Copy
At the top of the update function and below our call to super.update(dt);, let's change the speed value based on whether the run button is pressed or whether the r key is pressed. Also, we will create a Boolean to track whether we are moving using the keys if any of our variables from step 5 are set to true:
speed = (hud.runButton.buttonPressed || 
  keyRunningPressed) ? runningSpeed : walkingSpeed;
final bool isMovingByKeys = keyLeftPressed ||
  keyRightPressed || keyUpPressed || keyDownPressed;

Copy
Below this, in the update function, we have a check – if the joystick is non-zero, meaning that it is being used. This check looks like this:
if (!hud.joystick.delta.isZero()) {

Copy
Let's add an else if clause at the end of that if block for our key movement and add the following code, which will go between the if block and the else block:

} else if (isMovingByKeys) {
  movePlayer(dt);
  playing = true;
  movingToTouchedLocation = false;
  if (!isMoving) {
    isMoving = true;
    audioPlayerRunning = await 
      FlameAudio.loopLongAudio('sounds/running.wav', 
        volume: 1.0);
  }
  
  if (keyUpPressed && (keyLeftPressed ||
    keyRightPressed)) {
    animation = upAnimation;
    currentDirection = Character.up;
  } else if (keyDownPressed && (keyLeftPressed || 
    keyRightPressed)) {
    animation = downAnimation;
    currentDirection = Character.down;
  } else if (keyLeftPressed) {
    animation = leftAnimation;
    currentDirection = Character.left;
  } else if (keyRightPressed) {
    animation = rightAnimation;
    currentDirection = Character.right;
  } else if (keyUpPressed) {
    animation = upAnimation;
    currentDirection = Character.up;
  } else if (keyDownPressed) {
    animation = downAnimation;
    currentDirection = Character.down;
  } else {
    animation = null;
  }

Copy
This code works the same as the way the joystick handles movement, by trying to move our player if it doesn't collide with the water and playing the walking steps sound.

Then it sets the animation and currentDirection variables correctly based on the key pressed.

In the stopAnimations function, let's reset the movement keys when animations are stopped:
void stopAnimations() {
  animation?.currentIndex = 0;
  playing = false;
  keyLeftPressed = false;
  keyRightPressed = false;
  keyUpPressed = false;
  keyDownPressed = false;
}

Copy
If you run the game now on the Chrome device, you will be able to control George with the keys on the keyboard.

Summary
In this chapter, we converted the game to work on the web by fixing user interface issues when resizing the browser window and allowing movement to be controlled via the keyboard.

In the next few chapters, we are going to start tackling the more advanced topics of game development, starting in the next chapter with implementing advanced graphical effects.

We will use particle effects to make our enemies explode when we kill them and use layers to create cool shadow effects for our sprites.

Questions
Why doesn't music play in the background when a web page first loads?
Why does resizing the game window cause our graphics to be drawn incorrectly?
Why do we have to wrap TiledComponent in another class to fix the user interface issues with it?
Which web renderers are available for building a web release?
What mixin do we need to use to listen for keyboard events?



> [ 09 C7 Designing Your Own Levels ](/packtpub/javascript_from_frontend_to_backend/09_c7_designing_your_own_levels) <---> [ 11 P3 Advanced Games Programming ](/packtpub/javascript_from_frontend_to_backend/11_p3_advanced_games_programming)
>
> Title: 10 C8 Scaling the Game for Web and Desktop
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/10_c8_scaling_the_game_for_web_and_desktop
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 10_c8_scaling_the_game_for_web_and_desktop.md

