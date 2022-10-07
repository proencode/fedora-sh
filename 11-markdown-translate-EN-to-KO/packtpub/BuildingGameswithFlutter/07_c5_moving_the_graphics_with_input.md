
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

> [ 06 C4 Drawing and Animating Graphics ](/packtpub/javascript_from_frontend_to_backend/06_c4_drawing_and_animating_graphics) <---> [ 08 C6 Playing Sound Effects and Music ](/packtpub/javascript_from_frontend_to_backend/08_c6_playing_sound_effects_and_music)

# Chapter 5: Moving the Graphics with Input

In this chapter, we will take control of our own character and move them around the screen with virtual joysticks and touch events, so the player can choose where they want to move their character.

We will start by looking at how to draw onscreen controls that behave like a thumb-stick on a PlayStation controller, with action buttons for things such as attacking and jumping. Next, we will connect the virtual controls with our George sprite and get him moving around the screen. And finally, we will discuss an alternative or addition to virtual controls, by controlling George with touch events, such as tapping on the screen and moving George to a tapped location.

So, we will cover the following topics:

Drawing onscreen controls
Moving our character with onscreen controls
Moving our character with touch
Technical requirements
To examine the source from this chapter, you can download it from https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter05.

You can find additional information on Flame input in the online documentation at https://docs.flame-engine.org/1.0.0/gesture-input.html and https://docs.flame-engine.org/1.0.0/other-inputs.html.

In the next section, we will start by adding the onscreen controls and drawing them on the screen.

Drawing onscreen controls
In this section, we will add a joystick and a button to the screen that will allow us to control the character and some text for showing the player their score. These three components will form part of our Heads-Up Display (HUD), which is part of the user interface, showing game information that is drawn over the other graphics in the game and remains in a fixed position. The type of information could be the player's health, the number of lives remaining, or, in our case, the game score.

We will encapsulate our HUD into a single component, which makes showing or hiding it easier. The HUD component will contain JoyStickComponent for controlling the direction that George moves; the joystick will work by dragging an onscreen circle within a larger circle in the direction you want to move. The HUD will also include HudButtonComponent, an onscreen button that the player can press to double George's walking speed, making him run.

We will connect the HUD components in the next section, but for now, let's draw them on the screen:

First, create a folder inside the components folder called hud to hold our components.
Inside the hud folder, create four files called hud.dart, joystick.dart, run_button.dart, and score_text.dart.
In the run_button.dart file, add the following imports and class definition:
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
class RunButton extends HudButtonComponent {
}

Copy
Next, we will add the constructor inside the class definition; this will include the values we need to pass to the HudButtonComponent base class via a call with super:
  RunButton({
    required button,
    buttonDown, 
    EdgeInsets? margin,
    Vector2? position,
    Vector2? size,
    Anchor anchor = Anchor.center,
    onPressed,
  }) : super(
    button: button,
    buttonDown: buttonDown,
    margin: margin,
    position: position,
    size: size ?? button.size,
    anchor: anchor,
    onPressed: onPressed
  );

Copy
Below this constructor, let's add a Boolean variable to keep track of whether this button is pressed or not, the default being false:
bool buttonPressed = false;

Copy
HudButtonComponent has a mixin called Tappable that allows us to detect when this button is pressed on the screen and override callbacks for onTapUp, onTapDown, and onTapCancel, which we will use to update the buttonPressed Boolean. Let's add these functions after the buttonPressed definition:
  @override
  bool onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    buttonPressed = true;
    return true;
  }
  @override
  bool onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    buttonPressed = false;
    return false;
  }
  @override
  bool onTapCancel() {
    super.onTapCancel();
    buttonPressed = false;
    return true;
  }

Copy
We will use RunButton in the HUD component in the hud.dart file, but for now, let's move on to defining TextComponent for our score.

Open the score_text.dart file and add the following imports and class definition:
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';
class ScoreText extends HudMarginComponent {
}

Copy
Note here that the ScoreText class extends HudMarginComponent and not TextComponent. This is because we want to place TextComponent with margins around it. We will create TextComponent inside this class, add it as a child component of HudMarginComponent, and pass the margins into the class via the constructor, which we will add next.

Add the following constructor inside the class to pass the margins to the class:
ScoreText({EdgeInsets? margin}) : super (margin: margin);

Copy
Below the constructor, add the following variables for score and the TextComponent child:
int score = 0;
String scoreText = "Score: ";
late TextPaint _regularPaint;
late TextComponent scoreTextComponent;

Copy
Below these variables, let's add the onLoad function, which is called when the component is first used, to set up TextComponent:
@override
Future<void> onLoad() async {
  super.onLoad();
  TextStyle textStyle = TextStyle(color: 
    BasicPalette.blue.color, fontSize: 30.0);
  regularPaint = TextPaint(style: textStyle);
  scoreTextComponent = TextComponent(text: scoreText +
    score.toString(), textRenderer: _regularPaint);
  add(scoreTextComponent);
} 

Copy
Here, we are setting the text color to blue and adding scoreTextComponent as a child to ScoreText.

Finally, for TextComponent, we want to expose a function for updating the score that will get updated every time George collides with one of the enemy sprites. So, let's add the setScore function below the onLoad function:
  setScore(int score) {
    this.score += score;
    scoreTextComponent.text = 
      scoreText + this.score.toString();
  }

Copy
Next, we will add a simple JoystickComponent for controlling George's movement. To do that, open the joystick.dart file and add the following code:
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
class Joystick extends JoystickComponent {
  Joystick({required PositionComponent knob, 
    PositionComponent? background, EdgeInsets?
      margin}) : super (knob: knob, background: 
        background, margin: margin);
}

Copy
We will keep this simple for now, but it's worth keeping JoystickComponent in its own file in case you want to style it more later, by using custom images for the joystick instead of colors.

Now that we have our joystick, run button, and score text components, let's create a HUD component that will handle the initialization of these components. First, open the hud.dart file and add the following imports and class definition:
import 'package:flame/components.dart';
import 
  'package:goldrush/components/hud/run_button.dart';
import 
  'package:goldrush/components/hud/score_text.dart';
import 
  'package:goldrush/components/hud/joystick.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
class HudComponent extends PositionComponent {
}

Copy
Here, we extend from PositionComponent, giving us control over how we arrange our child components with margins. PositionComponent is a base class that allows the positioning of components within it.

At the top of the HudComponent class, let's add a constructor that sets priority to 20:
HudComponent() : super(priority: 20);

Copy
priority is used to indicate the order components are drawn, with the default being 0. So, setting this higher than 0 will ensure that the HUD is drawn on top of everything else.

Later, when we start using a map that is larger than the physical screen, the character and enemies will move around the map, but we want the score to stay at the top left of the screen while the map scrolls around.

Below this, we now define the variables to hold our child components:
late Joystick joystick;
late RunButton runButton;
late ScoreText scoreText;

Copy
Now, set these child components up on the onLoad function:
  @override
  Future<void> onLoad() async {
    super.onLoad();
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
      margin: const EdgeInsets.only(left: 40, bottom: 
        40),
    );
    runButton = RunButton(
    button: CircleComponent(radius: 25.0, paint:
      buttonRunPaint),
    buttonDown: CircleComponent(radius: 25.0, paint:
      buttonDownRunPaint),      
    margin: const EdgeInsets.only(right: 20, bottom: 
      50),
      onPressed: () => {}
    );
    scoreText = ScoreText(margin: const 
      EdgeInsets.only(left: 40, top: 60));
    add(joystick);
    add(runButton);
    add(scoreText);
    positionType = PositionType.viewport;
  }

Copy
Here, we set up some Paint objects for the colors of the components.

Next, we set up the joystick, using circles for the knob and background, and set the margin at the bottom left of the screen where the joystick will be located.

Then, we set up the run button in a similar way, with its margin at the bottom right to draw it opposite the joystick.

We then set the score text up with the margin at the top left of the screen.

After that, we add the HUD components and set positionType to PositionType.viewport.

PositionType ensures that this component is drawn on top of everything, even if the game camera moves around.

Please note that for the run button, it takes a function callback for when the button is pressed, but because we are managing the tap handling ourselves in the run button class, we can just ignore this and pass {} instead.

Let's add our HudComponent to the game so we can see our new components. Open the main.dart file and add the following import to the top of the file:
import 'package:goldrush/components/hud/hud.dart';

Copy
At the top of the onLoad function, let's add our HudComponent:
add(HudComponent());

Copy
As the HudComponent class contains components that are draggable (Joystick) and tappable (RunButton), we must pass the mixins for HasDraggables and HasTappables to the class definition for MyGame:
class MyGame extends FlameGame with HasCollidables, HasDraggables, HasTappables {

Copy
If you run the game now, you will see the new components displayed with the existing game sprites:

Figure 5.1 – The game with the HUD controls
Figure 5.1 – The game with the HUD controls

In this section, we learned how to add a joystick, a button, and a score to our game and positioned them on the screen.

In the next section, we will connect the joystick to George's movement and make him run faster when the run button is pressed. We will also update the score by 10 when George collides with an enemy.

Moving our character with onscreen controls
In this section, we will start by connecting George's movement to the joystick.

Currently, the George class inherits his movement from the base class, Character, which it shares with the Skeleton and Zombie classes. As George will have different movement code from the enemy sprites, let's refactor the code to allow the enemy sprites' movement code. We will move the existing movement code into an EnemyCharacter class, which will become the new base class for the enemy sprites and remove this code from the Character class.

Let's get started:

In the components folder, create a file called character_enemy.dart.
Open the file and add the code at https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter05/lib/components/character_enemy.dart.
In this code, the EnemyCharacter class extends our Character class, and we have copied the onCollision, update, and changeDirection functions straight from the Character class.

In the changeDirection function in the EnemyCharacter class, you will need to update the switch case block to prepend the directions with the Character base class. Once done, the block will look like this:
    switch (newDirection) {
      case Character.down:
        animation = downAnimation;
        break;
      case Character.left:
        animation = leftAnimation;
        break;
      case Character.up:
        animation = upAnimation;
        break;
      case Character.right:
        animation = rightAnimation;
        break;
    }

Copy
Open the zombie.dart and skeleton.dart files, and inside them both, instead of extending from Character, change the class definition to extend from EnemyCharacter.
Remove the previous import for character.dart and replace this with the following:
import 'character_enemy.dart';

Copy
Open the character.dart class and remove the functions for onCollision, update, and changeDirection that we now have in the EnemyCharacter class. You can also remove the import for the math package now too.
Open the file for george.dart and remove the line for changeDirection in the onLoad function.
If you run the game now, you will see George is invisible because we have not updated him and set his animation yet. Let's fix that by adding the following code in the onLoad function in the george.dart file:
    animation = downAnimation;
    playing = false;

Copy
Next, we will set up some variables for walkingSpeed and runningSpeed that will be toggled when the run button is pressed. At the top of the George class, below the constructor, add the following variables:
late double walkingSpeed, runningSpeed;

Copy
Then, at the top of the onLoad function, let's set walkingSpeed to equal the default speed that the sprite will move at and runningSpeed to be twice as fast:
    walkingSpeed = speed;
    runningSpeed = speed * 2;

Copy
Because we want to read the status on the joystick and the run button, we need to get a reference to HudComponent. So, let's pass the HUD via the constructor and store the HUD in a variable:
final HudComponent hud;

Copy
Then, update the constructor to pass the HUD so that we can access the values from the HUD in this class:
George({required this.hud, required Vector2 position, required Vector2 size, required double speed}) : super(position: position, size: size, speed: speed);

Copy
Next, we need to add the import for HudComponent:
import 'package:goldrush/components/hud/hud.dart';

Copy
Now, we will add the update function below the onCollision function and connect the run button to the speed variable:
  @override
  void update(double dt) {
    super.update(dt);
    speed = hud.runButton.buttonPressed ?
      runningSpeed : walkingSpeed;
}

Copy
If the run button is pressed, the speed will be runningSpeed; otherwise, it will be walkingSpeed.

After the line that sets the speed for walking and running, let's add the code that links the joystick to the character's movements and set the character's direction and animation based on the direction of the joystick:
    if (!hud.joystick.delta.isZero()) {
      position.add(hud.joystick.relativeDelta * speed 
        * dt);
      playing = true;
      
      switch (hud.joystick.direction) {
        case JoystickDirection.up:
        case JoystickDirection.upRight:
        case JoystickDirection.upLeft:
          animation = upAnimation;
          currentDirection = Character.up;
        break;
        case JoystickDirection.down:
        case JoystickDirection.downRight:
        case JoystickDirection.downLeft:
          animation = downAnimation;
          currentDirection = Character.down;
        break;
        case JoystickDirection.left:
          animation = leftAnimation;
          currentDirection = Character.left;
        break;
        case JoystickDirection.right:
          animation = rightAnimation;
          currentDirection = Character.right;
        break;
        case JoystickDirection.idle:
          animation = null;
        break;
      }
    } else {
    if (playing) {
      stopAnimations();
    }
  }

Copy
Here, if the joystick reading is 0, the character doesn't move, but if it is above 0, the character is moving. If the joystick is moving, we update our position based on the value from the joystick, the current speed, and deltaTime. Then, based on the joystick direction, we set the correct direction and animation. If there is no joystick movement, we check whether the animation is playing; if it is, we will call stopAnimations, which we will define next.

At the bottom of the class, we will create a new function called stopAnimations with the following code:
  void stopAnimations() {
    animation?.currentIndex = 0;
    playing = false;
  }

Copy
The stopAnimations function stops the animation from playing by setting the variable to false and sets the current animation index to 0; this draws the first frame of the animation as a static image. This gives the impression that we animate the character while the joystick is being used and the character George stands still when we stop using the joystick.

Let's increase the score by 10 every time an enemy is killed. In the onCollision function, update the function like so to increase the score:
    if (other is Zombie || other is Skeleton) {
      other.removeFromParent();
      hud.scoreText.setScore(10);
    }

Copy
Finally, open the main.dart file and update the onLoad function so that we create HudComponent as its own variable. This is used to store the HUD value that is passed to the George class as a parameter:
  @override
  Future<void> onLoad() async {
    var hud = HudComponent();
    add(Background());
    add (George(hud: hud, position: Vector2(200, 400),
      size: Vector2(48.0, 48.0), speed: 40.0));
    add (Zombie(position: Vector2(100, 200),
      size: Vector2(32.0, 64.0), speed: 20.0));
    add (Zombie(position: Vector2(300, 200),
      size: Vector2(32.0, 64.0), speed: 20.0));
    add (Skeleton(position: Vector2(100, 600), 
      size: Vector2(32.0, 64.0), speed: 60.0));
    add (Skeleton(position: Vector2(300, 600),
      size: Vector2(32.0, 64.0), speed: 60.0));
    add(ScreenCollidable());
    add(hud);
  }

Copy
If you run the app now, you will be able to control George with the joystick and chase down and kill the enemies much quicker when you collide with them. If you press and hold the run button while you are controlling the joystick, you will see George move at his running speed.

In this section, we added a HUD containing a joystick, run button, and score text, which we connected to the game to control George's movement and update the score when George kills an enemy.

In the next section, we will show you an alternative way to control George instead of using the joystick control, by detecting touch events on the screen and then moving George to that location.

Moving our character with touch
Now that we have George moving with the joystick, let's look at an alternative method for moving our character via screen touch events, which is very popular in games. With mobile devices having very sensitive high-resolution screens nowadays, we can use touch events or gestures to move our character from its current location to the location on the screen that was tapped. Using trigonometry, we can calculate the angle between the origin and target locations and use the angle to move George in the correct direction, with the correct animation that matches the direction.

We are already detecting a tap event for the run button via the HasTappables mixin. So, to detect touches on the screen, we need to add the Tappable mixin to the Background class and override onTapUp to get an x and y location that we can use to calculate the movement.

Because we need to know this coordinate inside of the George class, we will need to pass in a reference to the George class into the Background class so that we can pass the tap event when the player touches the screen.

To get started, let's modify the Background class:

Open the background.dart file. Add the following constructor and variable for holding the reference to the George class at the top of the class. We will use this for passing events back to the George class when the player touches the screen, and we will call a function on the George class called moveToLocation and pass the tap event:
  Background(this.george);
  final George george;

Copy
Resolve the reference to the George class with this import:
import 'george.dart';

Copy
Change the Background class definition by adding the Tappable mixin:
class Background extends PositionComponent with Tappable {

Copy
Add the following code to the bottom of the class to override the onTapUp function and pass the TapUpInfo event to the George class:
  @override
  bool onTapUp(TapUpInfo info) {
    george.moveToLocation(info);
    return true;
  }

Copy
At the moment, the moveToLocation function doesn't exist in the George class, but we will add that later when we update the George class. Because we are going to use the touch event, we return true from this function to indicate that the touch event was handled.

Add the following import to resolve the TapUpInfo reference:
import 'package:flame/input.dart';

Copy
In the main.dart file's onLoad function, let's make the George class into a variable, and then we can pass that into the Background class constructor. To do this, change the first few lines on the onLoad function like this:
  @override
  Future<void> onLoad() async {
    var hud = HudComponent();
    var george = George(hud: hud, position: 
      Vector2(200, 400), size: Vector2(48.0, 48.0), 
        speed: 40.0);
    add(Background(george));
    add (george);

Copy
Note that only the top part of the onLoad function is presented here to show the changed lines, but the rest of the lines that add the enemies, HUD, and ScreenCollidable are left the same.

Before we make the final changes to the George class, let's create a math utility class for storing a function to get the angle between George's location and the location on the screen where the player touches.

In the lib folder, create a new folder called utils, and in that folder, create a new file called math_utils.dart.
Open the new math_utils.dart file and add the following code for the getAngle function:
import 'dart:math';
import 'package:flame/components.dart';
  
double getAngle(Vector2 origin, Vector2 target) {
  double dx = target.x - origin.x;
  double dy = -(target.y - origin.y);
  double angleInRadians = atan2(dy, dx);
  if (angleInRadians < 0) {
    angleInRadians = angleInRadians.abs();
  }
  else {
    angleInRadians = 2 * pi - angleInRadians;
  }
  return angleInRadians * radians2Degrees;
}

Copy
We are not going to go into much detail about how the getAngle function works, but it uses basic trigonometry covered in most high school math classes. The getAngle function will return an angle between 0 and 360, with 0 degrees facing right, 90 degrees facing down, 180 degrees facing left, and 270 degrees facing up.

Open the george.dart file and add the following imports for the math utilities class:
import 'package:goldrush/utils/math_utils.dart';

Copy
In the George class, after the constructor, let's add a couple of variables for the targetLocation vector and a variable to track whether we are moving via touch:
  late Vector2 targetLocation;
  bool movingToTouchedLocation = false;

Copy
Now, let's add the moveToLocation function we referenced earlier in the Background component, set targetLocation to the touch event that was passed, and set movingToTouchedLocation to true:
  void moveToLocation(TapUpInfo info) {
    targetLocation = info.eventPosition.game;
    movingToTouchedLocation = true;
  }

Copy
Sprites have an anchor point that defaults to the top left of the sprite in Flame, so if we touch on the screen the sprite would be moved and the top-left corner of the sprite would align with the touched point on the screen. It feels more natural to center the sprite around the center of the sprite rather than the top left, so let's update the anchor point to be in the center.

At the bottom of the onLoad function and before adding the hitbox, add the following code to set the anchor in the center of the sprite.
anchor = Anchor.center;
addHitbox(HitboxRectangle());

Copy
Finally, we are going to add code to our update function that will move George to the touched location. In the update function, look for the else block containing the following code:
if (playing) {
  stopAnimations();
}

Copy
Replace it with this code block:

if (movingToTouchedLocation) {
    } else {
      if (playing) {
        stopAnimations();
      }
    }

Copy
Inside the if code block, add the following code to set the new anchor position:
position += (targetLocation - position).normalized() * (speed * dt);

Copy
This code updates George's position based on the difference between targetLocation and the current position, while taking account of the current speed and the time since the last update was called, to ensure the movement is smooth.

When we arrive at the touched location, we want to stop any animations from playing and set movedToTouchedLocation to false. Because we are moving the character based on fractions that could have rounding issues, we allow for a small threshold value in deciding whether George is near enough to the touched location, and if he is, we stop the animations. So, let's continue inside this code block and add the check for the threshold:
double threshold = 1.0;
var difference = targetLocation - position;
if (difference.x.abs() < threshold && 
  difference.y.abs() < threshold) {
  stopAnimations();
  movingToTouchedLocation = false;
  return;
}

Copy
Finally, we will use the getAngle function we created earlier and use the angle to decide what direction George is moving in and which is the closest animation to this. For instance, we only have four animations – up, down, left, and right – so we will approximate the direction by splitting the directions into four 90-degree quadrants, illustrated by the following diagram:
Figure 5.2 – The quadrant mapping to move direction
Figure 5.2 – The quadrant mapping to move direction

Based on our diagram, if we are moving between 45 degrees and 135 degrees, we are approximately moving down, so we can set the direction to down and use downAnimation to animate the sprite correctly. Remember that 0 degrees points east, and we need 2 checks for moving right, between 315 to 360 degrees and 0 to 45 degrees. So, let's add code for this logic, continuing in the same code block:

      playing = true;
      var angle = getAngle(position, targetLocation);
      if ((angle > 315 && angle < 360) || (angle > 0 
        && angle < 45) ) { // Moving right
        animation = rightAnimation;
        currentDirection = Character.right;
      } 
      // Moving down
      else if (angle > 45 && angle < 135) { 
        animation = downAnimation;
        currentDirection = Character.down;
      } 
      // Moving left
      else if (angle > 135 && angle < 225) { 
        animation = leftAnimation;
        currentDirection = Character.left;
      } 
      // Moving up
      else if (angle > 225 && angle < 315) { 
        animation = upAnimation;
        currentDirection = Character.up;
      }

Copy
Now, if you run the code, you can control George by touching anywhere on the screen, and he will move there. You can also use the joystick if you want to. Whichever movement method you prefer, the run button will still make George run faster while pressed. Also, note that if you use touch to move the character and then switch to joystick control, it will interrupt the movement caused by the touch, allowing you to manually control George's movement.

Summary
We covered a lot in this chapter, and the game is really starting to take shape. We learned how to create onscreen controls for our game with a joystick and a run button, as well as how to add text on the screen for our score. We then learned an alternative method for controlling George by allowing you to touch the screen to move him to the touched location.

The game is a bit quiet at the moment, though. In most games, music soundtracks and sound effects are used to create atmosphere and bring them to life. In the next chapter, we will add some music and sounds to the game to enhance it further.

Questions
What is a HUD and what is it used for in our game?
Which mixin do we use to convert a component to detect when it is touched?
What component do we use to draw text on the screen?
Why do you think JoystickComponent needs the HasDraggables mixin?



> [ 06 C4 Drawing and Animating Graphics ](/packtpub/javascript_from_frontend_to_backend/06_c4_drawing_and_animating_graphics) <---> [ 08 C6 Playing Sound Effects and Music ](/packtpub/javascript_from_frontend_to_backend/08_c6_playing_sound_effects_and_music)
>
> Title: 07 C5 Moving the Graphics with Input
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/07_c5_moving_the_graphics_with_input
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 07_c5_moving_the_graphics_with_input.md

