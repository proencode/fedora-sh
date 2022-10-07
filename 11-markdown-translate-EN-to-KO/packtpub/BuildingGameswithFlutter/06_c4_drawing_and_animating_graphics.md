
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

> [ 05 P2 Graphics and Sound ](/packtpub/javascript_from_frontend_to_backend/05_p2_graphics_and_sound) <---> [ 07 C5 Moving the Graphics with Input ](/packtpub/javascript_from_frontend_to_backend/07_c5_moving_the_graphics_with_input)

# Chapter 4: Drawing and Animating Graphics

In this chapter, we will go beyond drawing simple shapes and discuss how to draw and animate pixel graphics seen in most games. This will make our game look much nicer and bring the game to life as the characters animate around the screen.

In game programming, a graphic or image that is drawn to the screen is known as a sprite, which can be anything from a single non-animated image, a player character with multiple frames of animation, or even the background image drawn behind other graphics on the screen.

We will start by showing how to load and draw a simple sprite instead of our square, and then animate the sprite to show movement. Next, we will move the sprite around the screen and the animation will change based on the direction the sprite is currently moving in.

And finally, we will create an enemy sprite for the player sprite to collide into as we build on our knowledge of collision detection.

So, we will cover the following topics:

Drawing on the screen
Working with sprite animation
Moving a sprite around the screen
Colliding with other sprites
Let's get started by setting up the assets we will use for this chapter.

Technical requirements
To examine the source from this chapter, you can download it from https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter04.

For this chapter, you will also need to download some images to use for the animation.

Also, I used the sprite sheets downloadable from the following links:

For our player character, we will use the sprite sheet image at https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter04/assets/images/george.png.
For the enemies, we will use the sprite sheet image at https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter04/assets/images/zombie_n_skeleton.png.
Now, we will add the images to our game with the following steps:

Open your file manager and go to the goldrush folder for your project.
Create a folder called assets in the goldrush folder.
Go into the assets folder and create another folder called images.
Move the two images we downloaded into the images folder.
If you have set up everything correctly, your directory structure will look like this:

goldrush
--- assets
------ images
--------- george.png
--------- zombie_n_skeleton.png

Copy
Next, open the pubspec.yaml file located in the project folder.
Uncomment the assets line by removing the # symbol at the beginning of this line:
# assets:

Copy
Next, add the following lines below the asset line (notice the missing #):
  assets:
    - assets/images/george.png
    - assets/images/zombie_n_skeleton.png

Copy
If you now save the pubspec.yaml file, it will check for changes in the file to confirm that it is set up correctly. If this doesn't happen, you can manually run the following from a terminal:
flutter pub get

Copy
In this section, we downloaded and set up the sprites we will use during this chapter.

In the next section, we will see how to load the sprite sheets containing multiple animation frames and draw the sprite on the screen.

Drawing on the screen
Now that we are familiar with drawing basic shapes on the screen, which we covered in the previous chapter, we will expand our knowledge and start drawing sprites, which are more common in games.

Let's create a new SpriteComponent for our character, George, and load the sprite sheet:

In the components folder, create a new file called george.dart.
Open the file and add the following imports at the top of the file:
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

Copy
Create a class called George, which extends SpriteComponent:
class George extends SpriteComponent {
}

Copy
At the top of the class, let's define some variables for the sprite, screen dimensions, and sprite size:
late double screenWidth, screenHeight, centerX, centerY;
late double georgeSizeWidth = 48.0, georgeSizeHeight = 48.0;

Copy
As the sprite sheet size is 192 x 192 pixels with four rows and columns, this means that each individual frame is 192 / 4 = 48 pixels width and height, which is what we have set the values of georgeSizeWidth and georgeSizeHeight to.

Next, we will override the onLoad function, set up the screen variables, load the sprite sheet, and set up our sprite's position and size:
  @override
  Future<void> onLoad() async {
    super.onLoad();
    screenWidth = 
      MediaQueryData.fromWindow(window).size.width;
    screenHeight =
      MediaQueryData.fromWindow(window).size.height;
    centerX = 
      (screenWidth / 2) - (georgeSizeWidth / 2);
    centerY = 
      (screenHeight / 2) - (georgeSizeHeight / 2);
    var spriteImages = 
      await Flame.images.load('george.png');
    final spriteSheet = SpriteSheet(image:
      spriteImages, srcSize: Vector2(georgeSizeWidth,
        georgeSizeHeight));
    sprite = spriteSheet.getSprite(0, 0);
    position = Vector2(centerX, centerY);
    size = Vector2(georgeSizeWidth, georgeSizeHeight);
  }

Copy
Here, we use the Flame helper class to load the sprite sheet images and set up the sprite.

For now, we are going to get the first sprite frame and show only that frame. The first frame we get is 0, 0 in the sprite sheet:

Figure 4.1 – Sprite at 0, 0
Figure 4.1 – Sprite at 0, 0

Now, let's switch to the main.dart file, so we can add the George component to see it on the screen. In the onLoad function, we can remove the lines that add the Player and ScreenCollidable components, and add the George component, like this:
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(George());
  }

Copy
We can now remove the following imports of the Player and ScreenCollidable components that were used to show the green square, which we used in Chapter 2, Working with the Flame Engine:
import 'components/player.dart';
import 'package:flame/comonents.dart';

Copy
And, as we are no longer using the Player component, we can also delete the player.dart file containing the Player component, which is not needed anymore.
As we have added the George component, we need to add the import for the class at the top of the file with other imports:
import 'package:goldrush/components/george.dart';

Copy
If you run the game now, you will see a single frame showing George on a black background.

It's difficult to see against the black background though, so let's create a Background component and change the background color, which will be drawn before George, so we can see the sprite more clearly.

In the components folder, create a new file called background.dart. Open the file and enter the following imports and code:
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
class Background extends PositionComponent {
  static final backgroundPaint = 
    BasicPalette.white.paint(); 
  late double screenWidth, screenHeight;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    screenWidth = 
      MediaQueryData.fromWindow(window).size.width;
    screenHeight =
      MediaQueryData.fromWindow(window).size.height;
    position = Vector2(0, 0);
    size = Vector2(screenWidth, screenHeight);
  }
  @override
  void render(Canvas canvas) {
    super.render(canvas);
canvas.drawRect(Rect.fromPoints(position.toOffset(),
  size.toOffset()), backgroundPaint);
  }
}

Copy
In the onLoad function, we set backgroundPaint to white to make the George sprite more visible. We also set the position to 0, 0, and the size to the full width and height of the screen, so that when we paint the white color in the render function, it covers the whole screen.

Back in the main.dart file, let's add import to the top of the file and the Background component to the onLoad function:
import 'components/background.dart';
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Background());
    add(George());
  }

Copy
Note that we add the Background component before the George component so that it gets drawn first.

If you run this, you will now see George drawn against a white background, which is much easier to see:

Figure 4.2 – George on a white background
Figure 4.2 – George on a white background

In the next section, we will discuss how to animate George instead of just showing a single frame.

Working with sprite animation
Let's change the George class to play an animation sequence instead of just a single frame by changing the class:

First, change the class definition to extend from SpriteAnimationComponent instead of SpriteComponent:
class George extends SpriteAnimationComponent {

Copy
Because we are going to set up an animation within SpriteAnimationComponent, we can remove the references to georgeSprite as this will be managed by the class. So, let's remove or comment the following lines:
// late Sprite georgeSprite;
// georgeSprite = spriteSheet.getSprite(0, 0);

Copy
You can also remove or comment the render function now as the drawing will be managed by the class:

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   georgeSprite.render(canvas);
  // }

Copy
To create an animation from the sprite sheet we set up, the SpriteSheet class has a createAnimation helper function, which allows us to set which row the animation should be created from. If you look closely at our george.png file, you will notice that our animations are in columns and not rows. At the time of writing, the current version of the Flame createAnimation library works with rows and not columns, so we will use Dart extensions to add a variant of createAnimation to the SpriteSheet class that works on columns too. After the class definition for our SpriteAnimationComponent in george.dart, add the following:
extension CreateAnimationByColumn on SpriteSheet {
    SpriteAnimation createAnimationByColumn({
      required int column,
      required double stepTime,
      bool loop = true,
      int from = 0,
      int? to,
    }) {
    to ??= columns;
    final spriteList = List<int>.generate(to - from, 
      (i) => from + i)
        .map((e) => getSprite(e, column))
        .toList();
    return SpriteAnimation.spriteList(
      spriteList,
      stepTime: stepTime,
      loop: loop,
    );
  }
}

Copy
This extension will create a list of sprites based on the column and then create a SpriteAnimation from the sprite list.

Now, we can use the sprite list to create an animation that we will assign to our SpriteAnimationComponent animation field. At the end of the onLoad function, add the following code:
animation = spriteSheet.createAnimationByColumn(
  column: 0, stepTime: 0.2);

Copy
Here, we call the new createAnimationByColumn extension function, passing 0 for the first column animation, and the stepTime animation speed to 0.2, which gives the impression of a normal walking speed in the animation.

Now, we have expanded our sprite by drawing multiple frames to create an animation.

In the next section, we will set up animations for each of George's directions and move him around the screen, changing directions every few seconds, and changing the animation to match the direction he is traveling in.

Moving a sprite around the screen
Now that we have the George sprite animating, we will build on that and change the animation based on the direction of travel:

Let's add some variables at the top of the George class to store the animations and direction information:
  late SpriteAnimation georgeDownAnimation, 
    georgeLeftAnimation, georgeUpAnimation, 
    georgeRightAnimation;
  double elapsedTime = 0.0;
  double georgeSpeed = 40.0;
  int currentDirection = down;
  static const int down = 0, left = 1, up = 2, 
    right = 3;

Copy
Below the onLoad function, define a new function called changeDirection, which we will call every 3 seconds to change George's direction randomly:
  void changeDirection() {
    Random random = Random();
    int newDirection = random.nextInt(4);
    switch (newDirection) {
      case down:
        animation = georgeDownAnimation;
        break;
      case left:
        animation = georgeLeftAnimation;
        break;
      case up:
        animation = georgeUpAnimation;
        break;
      case right:
        animation = georgeRightAnimation;
        break;
    }
    currentDirection = newDirection;
  }

Copy
Here, we generate a random number between 0 and 3 that maps to our columns. Then, we set the animation class field to use the animations, which we will initialize shortly. Finally, we set the current direction to be the new direction, which we can use to move the sprite later.

At the bottom of the onLoad function, remove the line that sets up the class field animation, as we now do this in the changeDirection function, and replace it with the following lines to initialize the animations:
    georgeDownAnimation = 
      spriteSheet.createAnimationByColumn(column: 0, 
        stepTime: 0.2);
    georgeLeftAnimation = 
      spriteSheet.createAnimationByColumn(column: 1,
        stepTime: 0.2);
    georgeUpAnimation = 
      spriteSheet.createAnimationByColumn(column: 2, 
        stepTime: 0.2);
    georgeRightAnimation = 
      spriteSheet.createAnimationByColumn(column: 3, 
        stepTime: 0.2);
    changeDirection();

Copy
Now we have our animations set up, let's add an update function to change direction every 3 seconds and move the sprite in the same direction that the animation is facing. Under the changeDirection function, add the following update function code:
  @override
  void update(double deltaTime) {
    super.update(deltaTime);
    elapsedTime += deltaTime;
    if (elapsedTime > 3.0) {
      changeDirection();
      elapsedTime = 0.0;
    }
    switch (currentDirection) {
      case down:
        position.y += georgeSpeed * deltaTime;
        break;
      case left:
        position.x -= georgeSpeed * deltaTime;
        break;
      case up:
        position.y -= georgeSpeed * deltaTime;
        break;
      case right:
        position.x += georgeSpeed * deltaTime;
        break;
    }
  }

Copy
Finally, let's fix the import for the Random class by adding the following line at the top of this file:
import 'dart:math';

Copy
If you run the code now, you will see George move around for 3 seconds and then change direction randomly, occasionally continuing in the same direction if the random number chosen is the same as the previous 3 seconds. If you let this run for a while, you may see George vanish off the side of the screen, as we currently aren't detecting when he collides with the edge of the screen.

In the next section, we will make George flip direction when he collides with the edge of the screen, and add zombies and skeletons that move around and die if George collides with them.

Colliding with other sprites
Let's fix the issue with George wandering off the edge of the screen that we saw at the end of the last section and flip the direction if he hits the edge of the screen. To do this, follow these steps:

In the onLoad function of main.dart, let's add the ScreenCollidable component to the bottom of the function so we can detect collisions between George and the screen edges:
add(ScreenCollidable());

Copy
In the george.dart file, change the class definition to add the HasHitBoxes and Collidable mixins:
class George extends SpriteAnimationComponent with HasHitBoxes, Collidable {

Copy
At the bottom of the onLoad function, add the HitboxRectangle shape for the collision detection:
addHitbox(HitboxRectangle());

Copy
Add the following import at the top of the file to resolve the reference to HitboxRectangle:
import 'package:flame/geometry.dart';

Copy
At the bottom of this class file, after the update function definition, add the following onCollision function definition:
  @override
  void onCollision(Set<Vector2> points, 
    Collidable other) {
    if (other is ScreenCollidable) {
      switch (currentDirection) {
        case down:
          currentDirection = up;
          animation = georgeUpAnimation;
          break;
        case left:
          currentDirection = right;
          animation = georgeRightAnimation;
          break;
        case up:
          currentDirection = down;
          animation = georgeDownAnimation;
          break;
        case right:
          currentDirection = left;
          animation = georgeLeftAnimation;
          break;
      }
      elapsedTime = 0.0;
    }
  }

Copy
Here, we flip the currentDirection and animation if George collides with the edge of the screen; for instance, if George was moving right, he will now move left, and the animation will change to georgeLeftAnimation. We also reset elapsedTime to 0.0 so that our 3-second counter starts again.

If you run the game now, you will see that after some time, when George hits the side of the screen, he will flip direction and the animation will update. You can change the georgeSpeed variable value to speed this up if you like.

Next, let's add the zombies and skeletons to the game!

If you look at the sprite sheet for the zombies and skeletons, you will notice both are in the same sprite sheet, both are organized by rows and now columns, and both have a zombie and a skeleton on each row. So, while we are building the animations, we must specify a from and to field to indicate which part of the sprite sheet makes up the animation.

For example, for the animation that makes the zombie's direction walk to the left, it would be on row 1, from column 0 to 2. The sprite image is 192 pixels wide by 256 pixels high containing six frames horizontally and four frames down, so to calculate the size of a sprite, it would be as follows:

192 / 6 = 32
256 / 4 = 64 

Copy
So, our sprite size is 32 pixels in width and 64 pixels high:

Figure 4.3 – Enemy sprites, showing the size of each frame
Figure 4.3 – Enemy sprites, showing the size of each frame

If we make a class for our zombie and skeleton, the code would be very similar to the George class because we need to load the sprites, organize them into animations, update the animations based on directions, and flip the direction if we bump into the edge of the screen.

To avoid a lot of unnecessary code duplication, we are going to create a base class for all our sprites for this common functionality. Then, the individual classes will be much smaller to keep the code clean and easy to read.

To start with, we will move a lot of the code from the George class into a new base class we will call Character. As we do this, we will make the variable names more generic, such as renaming georgeSpeed to speed and adding a constructor to pass values such as the position, size, and speed to make this more flexible.

In the components folder, create a new file called character.dart with the following class definition:
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
class Character extends SpriteAnimationComponent with
  HasHitboxes, Collidable {
}

Copy
Next, we add a constructor for passing the position, size, and speed and some variables for the animations and direction information:
  Character({required Vector2 position, 
    required Vector2 size, required double speed}) {
      this.position = position;
      this.size = size;
      this.speed = speed;
  }
  late SpriteAnimation downAnimation, leftAnimation,
    upAnimation, rightAnimation;
  late double speed;
  double elapsedTime = 0.0;
  int currentDirection = down;
  static const int down = 0, left = 1, up = 2, 
    right = 3;

Copy
As you can see, the variable naming is more generic now in this base class.

Next, we will migrate the three functions (changeDirection, update, and onCollision) from the George class to the Character class.
First, we will add the changeDirection function:

  void changeDirection() {
    Random random = new Random();
    int newDirection = random.nextInt(4);
    switch (newDirection) {
      case down:
        animation = downAnimation;
        break;
      case left:
        animation = leftAnimation;
        break;
      case up:
        animation = upAnimation;
        break;
      case right:
        animation = rightAnimation;
        break;
    }
    currentDirection = newDirection;
  }

Copy
Now that we have added changeDirection, let's add the update function:

  @override
  void update(double deltaTime) {
    super.update(deltaTime);
    elapsedTime += deltaTime;
    if (elapsedTime > 3.0) {
      changeDirection();
      elapsedTime = 0.0;
    }
    switch (currentDirection) {
      case down:
        position.y += speed * deltaTime;
        break;
      case left:
        position.x -= speed * deltaTime;
        break;
      case up:
        position.y -= speed * deltaTime;
        break;
      case right:
        position.x += speed * deltaTime;
        break;
    }
  }

Copy
Next, let's add the onCollision function:

  @override
  void onCollision(Set<Vector2> points, 
    Collidable other) {
    if (other is ScreenCollidable) {
      switch (currentDirection) {
        case down:
          currentDirection = up;
          animation = upAnimation;
          break;
        case left:
          currentDirection = right;
          animation = rightAnimation;
          break;
        case up:
          currentDirection = down;
          animation = downAnimation;
          break;
        case right:
          currentDirection = left;
          animation = leftAnimation;
          break;
      }
      elapsedTime = 0.0;
    }
  }
}

Copy
As you can see from these three functions, they have the same functionality that we have in the George class, but we have named the variables to be more generic now, which is better for a base class.

Because we created an extension function for the George class for creating animations by columns, we will bring that over to the character.dart file too. The function will be available to use in all our sprites so that we can either create them by column or row.

After the class definition for the Character base class and at the bottom of the character.dart file, add the extension code for createAnimationByColumn:

extension CreateAnimationByColumn on SpriteSheet {
    SpriteAnimation createAnimationByColumn({
      required int column,
      required double stepTime,
      bool loop = true,
      int from = 0,
      int? to,
    }) {
    to ??= columns;
    final spriteList = 
      List<int>.generate(to - from, (i) => from + i)
      .map((e) => getSprite(e, column))
      .toList();
    return SpriteAnimation.spriteList(
      spriteList,
      stepTime: stepTime,
      loop: loop,
    );
  }
}

Copy
Now we have our Character base component set up, this makes the George class a lot simpler.

In the George class, delete all the code and replace it with the following:
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:goldrush/components/character.dart';
class George extends Character {
  George({required Vector2 position, 
    required Vector2 size, required double speed}) : 
      super(position: position, size: size, 
        speed: speed);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    var spriteImages = 
      await Flame.images.load('george.png');
    final spriteSheet = SpriteSheet(image: 
      spriteImages, srcSize: Vector2(width, height));
    downAnimation =
      spriteSheet.createAnimationByColumn(column: 0,
        stepTime: 0.2);
    leftAnimation =
      spriteSheet.createAnimationByColumn(column: 1, 
        stepTime: 0.2);
    upAnimation = 
      spriteSheet.createAnimationByColumn(column: 2,
        stepTime: 0.2);
    rightAnimation = 
      spriteSheet.createAnimationByColumn(column: 3, 
        stepTime: 0.2);
    changeDirection();
    addHitbox(HitboxRectangle());
  }
}

Copy
As you can see, we only need to load the sprite sheet and set up the animations and we're good to go. It's a lot less code and much cleaner now it inherits the direction, movement, and collision code from the base class.

Now, let's set up a class for the zombie. In the components folder, create a new file called zombie.dart and add the following code:
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:goldrush/components/character.dart';
class Zombie extends Character {
  Zombie({required Vector2 position, required Vector2
    size, required double speed}) : super(position: 
      position, size: size, speed: speed);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    var spriteImages = await 
      Flame.images.load('zombie_n_skeleton.png');
    final spriteSheet = SpriteSheet(image: 
      spriteImages, srcSize: size);
    downAnimation = spriteSheet.createAnimation(
      row: 0, stepTime: 0.2, from: 0, to: 2);
    leftAnimation = spriteSheet.createAnimation(
      row: 1, stepTime: 0.2, from: 0, to: 2);
    upAnimation = spriteSheet.createAnimation(
      row: 3, stepTime: 0.2, from: 0, to: 2);
    rightAnimation = spriteSheet.createAnimation(
      row: 2, stepTime: 0.2, from: 0, to: 2);
    changeDirection();
    
    addHitbox(HitboxRectangle());
  }
}

Copy
Once again, the amount of code is small, just setting up the animation in the onLoad function. As it extends the Character class, we get all the same code we have for George too.

The main difference here is we use the built-in sprite sheet's createAnimation function instead of our extension function, as this sprite sheet is in rows and not columns. For the zombies, the animation frames are from columns 0 to 2, so we add those parameters in the createAnimation call too.

Now, let's set up the skeleton enemy. In the components folder, create a new file called skeleton.dart and add the following code:
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:goldrush/components/character.dart';
class Skeleton extends Character {
  Skeleton({required Vector2 position, required
    Vector2 size, required double speed}) : super(
      position: position, size: size, speed: speed);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    var spriteImages = await 
      Flame.images.load('zombie_n_skeleton.png');
    final spriteSheet = SpriteSheet(
      image: spriteImages, srcSize: size);
    downAnimation = spriteSheet.createAnimation(
      row: 0, stepTime: 0.2, from: 3, to: 5);
    leftAnimation = spriteSheet.createAnimation(
      row: 1, stepTime: 0.2, from: 3, to: 5);
    upAnimation = spriteSheet.createAnimation(
      row: 3, stepTime: 0.2, from: 3, to: 5);
    rightAnimation = spriteSheet.createAnimation(
      row: 2, stepTime: 0.2, from: 3, to: 5);
    changeDirection();
    
    addHitbox(HitboxRectangle());
  }
}

Copy
As with the zombie code, it's compact and inherits most functionality from the Character component. Because of the way the sprite sheet image is set up, we set the from and to fields to 3 to 5, respectively, to grab the correct animation frames for the skeleton.

Now we have the zombies and skeletons set up, let's add some extra collision code to the George class so that every time the George sprite collides with either a zombie or skeleton, it will delete the enemy from the screen as if the enemy had been killed.

At the bottom of the George class, add the following onCollision function:
  @override
  void onCollision(Set<Vector2> points, 
    Collidable other) {
    super.onCollision(points, other);
    if (other is Zombie || other is Skeleton) {
      other.removeFromParent();
    }
  }

Copy
Next, add the imports at the top of the George file for the Zombie and Skeleton classes:
import 'package:goldrush/components/skeleton.dart';
import 'package:goldrush/components/zombie.dart';

Copy
Finally, let's add the same imports that we just added to the George file to the main.dart file. Then, in the onLoad function, let's add the following code to add some zombies and skeletons and update George to pass the position, size, and speed:
add(George(position: Vector2(200, 400), 
  size: Vector2(48.0, 48.0), speed: 40.0));
add (Zombie(position: Vector2(100, 200), size: 
  Vector2(32.0, 64.0), speed: 20.0));
add (Zombie(position: Vector2(300, 200), size: 
  Vector2(32.0, 64.0), speed: 20.0));
add (Skeleton(position: Vector2(100, 600), size: 
  Vector2(32.0, 64.0), speed: 60.0));
add (Skeleton(position: Vector2(300, 600), size: 
  Vector2(32.0, 64.0), speed: 60.0));

Copy
If you run the code now, you will see a few zombies and skeletons and George wandering around, randomly changing direction every few seconds and when they hit the edges. If George collides with an enemy, the enemy will be removed from the screen.

Here is a picture of how the game looks so far:

Figure 4.4 – George and the enemy sprites
Figure 4.4 – George and the enemy sprites

In this section, we added enemy sprites to the game and collision code to detect when George collides with the enemies. We extracted the common code for movement and animation changes to a base class called Character and then built the sprite classes using this.

Summary
In this chapter, we showed you how to load graphics from a sprite sheet and extract and play the animations. Then, we showed you how to move the sprites around and change the animation to match the direction of travel. Finally, we showed you how to animate multiple sprites independently and detect when they collide with each other or the screen edges.

In the next chapter, we will add more interactivity by learning how to control your player character with virtual joysticks and buttons. We will also look at other methods of input control, including detecting touch events on the screen and using them to control the player character.

Questions
What is a sprite?
What functions should we use for the code which initializes the animations?
What are the benefits of using SpriteAnimationComponent?
What parameters should you set in the createAnimation function to specify a range within a sprite sheet?
What is the benefit of creating a base class for all our sprites?



> [ 05 P2 Graphics and Sound ](/packtpub/javascript_from_frontend_to_backend/05_p2_graphics_and_sound) <---> [ 07 C5 Moving the Graphics with Input ](/packtpub/javascript_from_frontend_to_backend/07_c5_moving_the_graphics_with_input)
>
> Title: 06 C4 Drawing and Animating Graphics
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/06_c4_drawing_and_animating_graphics
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 06_c4_drawing_and_animating_graphics.md

