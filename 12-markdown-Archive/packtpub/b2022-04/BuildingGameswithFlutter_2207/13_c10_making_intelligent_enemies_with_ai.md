
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

> [ 12 C9 Implementing Advanced Graphics Effects ](/packtpub/javascript_from_frontend_to_backend/12_c9_implementing_advanced_graphics_effects) <---> [ 14 C11 Finishing the Game ](/packtpub/javascript_from_frontend_to_backend/14_c11_finishing_the_game)

# Chapter 10: Making Intelligent Enemies with AI

The game is coming along nicely now, but there isn't really any challenge to it yet. We collect the coins or kill our enemies, but that's all very predictable and easy.

In this chapter, we are going to change the game to make it more challenging by adding a health value to our player, George, and making the enemies chase us instead, reducing our health for each enemy that hits us. If our health gets to zero, we lose the game. So, the objective will be to collect the coins while avoiding the enemies.

To make the enemies appear more intelligent, we will use very simple Artificial Intelligence (AI) algorithms for the enemies to detect when George is nearby and, when they can see him, their movement will change from random movements to moving in George's direction to attack him.

We will then add some extra water to the map as obstacles and discuss how to move from your origin to the destination while avoiding the water and walking around it to reach your destination.

We will cover the following topics in this chapter:

Making enemies chase the player
Navigating obstacles with pathfinding
Technical requirements
To examine the source from this chapter, you can download it from https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter10.

The following steps will add a library to the pubspec file to assist with pathfinding, along with some new and updated assets:

In this chapter, we will use updated versions of the tile map files, so please download these updated tile map files and place them in the assets/tiles folder, overriding the existing files:
https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter10/assets/tiles/tiles.tmx

https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter10/assets/tiles/tiles.tsx

Open the pubspec.yaml file and add the following dependency:
a_star_algorithm: ^0.3.0

Copy
In this chapter, we will use a modified version of the sprite sheet for our character George, so let's update that.
Download the george.png image from the following URL, https://raw.githubusercontent.com/PacktPublishing/Building-Games-with-Flutter/main/chapter10/assets/images/george.png, and overwrite the file in the assets/images folder. Note that as we already have a reference in the pubspec.yaml file for george.png, we don't need to do anything further with it.

Save the file and allow pub get to download this dependency and validate the assets:
flutter pub get

Copy
Making enemies chase the player
There are two main challenges associated with making enemies chase the player that we need to overcome, making the player believe the enemy is showing intelligence and is hunting them down. They are as follows:

The first is that the player is near enough to the enemy so that the enemy may see or hear them. You don't want enemies to start chasing players when they are on the other side of the map, otherwise, the effect is lost and isn't believable.
The second is that the enemy is facing the player when they start chasing. If the enemy is walking in the opposite direction, the player might be able to sneak past them without the enemy noticing. So we won't make them chase when they are not even facing the player.
To overcome these challenges, we will track the distance between the player and enemy at every update, which happens 60 times per second. If the distance between them is below a certain value, and if the angle between the player and enemy indicates that the enemy is facing the player, then we will start the enemy chasing the player. If the player can run away from the enemy, then the enemy will return to its normal movement pattern. We will also change the enemies' speed so that the normal movement speed is trebled when they are chasing.

Let's get started by making the enemies chase the player:

Open the character_enemy.dart file and, outside of the class definition, add the following enum for defining whether we are walking about or chasing the player:
enum EnemyMovementType { 
  WALKING, 
  CHASING
}

Copy
In the EnemyCharacter class, below the constructor, add the following variables:
Character playerToTrack;
EnemyMovementType enemyMovementType = 
  EnemyMovementType.WALKING;
static const DISTANCE_TO_TRACK = 150.0;
double walkingSpeed, chasingSpeed;

Copy
Here, we create variables for tracking the character we want to chase and set the enemy movement type to walking by default. We set a constant for the distance check that we will use for detecting whether the enemy is near to the player and create some values for maintaining the walking and chasing speeds.

Change the constructor to the following code to set up some of the values we created in step 2:
EnemyCharacter({required Character player, required 
  Vector2 position, required Vector2 size, required 
    double speed}) : 
  playerToTrack = player,
  walkingSpeed = speed,
  chasingSpeed = speed * 2,
  super(position: position, size: size, speed: speed);

Copy
Here, we set up the chasing speed to be twice as fast as our walking speed.

Let's import the math_utils.dart file so that we can use the getAngle function to determine whether this enemy is facing the player:
import 'package:goldrush/utils/math_utils.dart';

Copy
Next, let's create a function called isPlayerNearAndVisible to check that the player is close by and visible to the enemy by facing in the player's direction:
bool isPlayerNearAndVisible() {
  bool isPlayerNear = position.distanceTo(
    playerToTrack.position) < DISTANCE_TO_TRACK;
  bool isEnemyFacingPlayer = false;
  var angle = 
    getAngle(position, playerToTrack.position);
  if ((angle > 315 && angle < 360) || (angle > 0 && 
    angle < 45) ) { // Facing right
    isEnemyFacingPlayer = currentDirection == 
      Character.right;
  } else if (angle > 45 && angle < 135) { 
    // Facing down
    isEnemyFacingPlayer = currentDirection ==
      Character.down;
  } else if (angle > 135 && angle < 225) {
    // Facing left
    isEnemyFacingPlayer = currentDirection == 
      Character.left;
  } else if (angle > 225 && angle < 315) { 
    // Facing up 
    isEnemyFacingPlayer = currentDirection == 
      Character.up;
  }
  return isPlayerNear && isEnemyFacingPlayer;
}

Copy
In the isPlayerNearAndVisible function, we first measure the distance to the player from our enemy position, check whether it is less than our DISTANCE_TO_TRACK value, and then set the isPlayerNear value to true if needed.

Next, we use the getAngle function to get the angle between the enemy and player and then use this to check whether the angle we are facing matches the currentDirection we are facing. If this matches, then the enemy is facing the player and we set the isEnemyFacingPlayer flag as needed.

If both values are true, we will return true from this function to indicate the enemy is near enough and can see the player, which we will use in the update function next to change the enemyMovementType from walking to chasing.

Let's rewrite the update function in the EnemyCharacter class. First, remove the existing update function and replace it with the code from GitHub at https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter10/lib/components/character_enemy.dart.
Let's go through the changes we have made to this function.

The previous update code is now in a switch/case block if the enemy is in the default walking state. We initially call the isPlayerNearAndVisible function we created in Step 4 and set our current speed to chasingSpeed if the player is near and visible, and to walkingSpeed if not.

If the enemyMovementType is WALKING, the enemy will walk around as before, but when CHASING, the enemy will run directly toward the player at the increased speed.

Now, let's update the Skeleton and Zombie classes to take a reference to the player class, George, which extends from the Character class, and pass this reference to the EnemyCharacter base class.
Open the skeleton.dart file and change the constructor like this:

Skeleton({required Character player, required Vector2 
  position, required Vector2 size, required double 
    speed}) : super(player: player, position:
      position, size: size, speed: speed) {

Copy
Open the zombie.dart file and change the constructor like this:
Zombie({required Character player, required Vector2
  position, required Vector2 size, required double
    speed}) : super(player: player, position: 
      position, size: size, speed: speed) {

Copy
Add the following import to resolve the reference to Character in the constructor:
import 'package:goldrush/components/character.dart';

Copy
Let's now tie all this together by passing the player reference to the enemy classes.
Open the main.dart file and change the code where you add the enemies like this:

if (index % 2 == 0) {
  add(Skeleton(player: george, position:
    Vector2(position.x + gameScreenBounds.left,
      position.y + gameScreenBounds.top), size: 
        Vector2(32.0, 64.0), speed: 20.0));
} else {
  add (Zombie(player: george, position:
    Vector2(position.x + gameScreenBounds.left,
      position.y + gameScreenBounds.top), size: 
        Vector2(32.0, 64.0), speed: 20.0));
}

Copy
Also, because we changed the George's image earlier, we need to update the new size to 32, 32, where we create George in the onLoad function of main.dart:
var george = George(barrierOffsets: barrierOffsets,
  hud: hud, position: Vector2(gameScreenBounds.left +
    300, gameScreenBounds.top + 300), size: 
      Vector2(32.0, 32.0), speed: 40.0);

Copy
If you run the game now and move George near to an enemy while the enemy is facing George, you will see the enemy chase George. If the enemy catches George, you will see the enemy collide and explode, as discussed previously in the Animating with particles section of Chapter 9, Implementing Advanced Graphics Effects.

Let's change this now to give George a health value of 100%, which we will reduce by 25% every time an enemy attacks George and not increase our score. In the next chapter, we will add some user interface screens that will show Game Over when George's health reaches 0, but for now, we will just get the mechanism working.

In the hud folder, create a new file called health_text.dart and add the code from here: https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter10/lib/components/hud/health_text.dart.
This code block will look very familiar as it's the same as the ScoreText component, but with all the references to score changed to health.

Open the hud.dart file and add the following import:
import
  'package:goldrush/components/hud/health_text.dart';

Copy
At the top of the HudComponent class, add the following variable to show the HealthText value:
late HealthText healthText;

Copy
In the onGameResize function, at the bottom of the if block, change the code as follows to initialize the healthText value and add it to the HUD:
scoreText = ScoreText(position: Vector2(
  gameScreenBounds.left + 80, gameScreenBounds.top +
    60));
healthText = HealthText(position: Vector2(
  gameScreenBounds.right - 80, gameScreenBounds.top + 
    60));
add(joystick);
add(runButton);
add(scoreText);
add(healthText);

Copy
At the bottom of the else block in the same function, add the following line to update the healthText position:
joystick.position = Vector2(gameScreenBounds.left +
  80, gameScreenBounds.bottom - 80);
RunButton.position = Vector2(gameScreenBounds.right -
  80, gameScreenBounds.bottom - 80);
scoreText.position = Vector2(gameScreenBounds.left +
  80, gameScreenBounds.top + 60);
healthText.position = Vector2(gameScreenBounds.right -
  80, gameScreenBounds.top + 60);

Copy
Open the george.dart file and, in the variables section at the top, add the following code:
int health = 100;

Copy
In the onCollision function, let's change the if block to check whether we have hit a Zombie or Skeleton, so the code looks like the following:
if (other is Zombie || other is Skeleton) {
  gameRef.add(ParticleComponent(explodingParticle(
    other.position, Colors.red)));
  other.removeFromParent();
  if (health > 0) {
    health -= 25;
    hud.healthText.setHealth(health);
  } else {
    // TODO: Show game over screen here
  }
  FlameAudio.play('sounds/enemy_dies.wav', volume: 
    1.0);
}

Copy
If you run the code now, you will see the health value in the top-right corner, which will reduce every time you collide with an enemy, as shown in the following figure:

Figure 10.1 – Health score reduced when hit by an enemy
Figure 10.1 – Health score reduced when hit by an enemy

In the next section, we will add some water obstacles to the map and discuss how to navigate around them. We will also discuss how we can enhance our enemies' AI, meaning that they will not chase you if they can't see you because they are blocked by a water obstacle.

Navigating obstacles with pathfinding
In this section, we will discuss how to move our character from A to B when there are obstacles in the way. There are many solutions to this problem, but a common solution in games development that we are going to use is called the A Star algorithm.

The algorithm is an efficient way to calculate a route on a 2D grid. Remember, a tile map is a 2D grid that uses tile IDs to represent what is drawn on the map. We provide the algorithm with our grid coordinates for our start location (the current location of George) and our end location (where we tap on the screen), along with a list of grid coordinates for any obstacles that are in the way. The algorithm then returns a list of grid offsets that represent a path, which we can follow to navigate to our touched location while avoiding all obstacles!

Our initial challenge is that when we move George around, we are using pixels to represent the location, but the algorithm works in grid coordinates. For instance, if George was at the top left of the map (ignoring the water), his pixel coordinate might be 48, 48, but his grid coordinate will be 1, 1.

Let's start by creating a new file with some helper functions that let us convert between George's world coordinate (pixel) and his grid coordinate:

First, create and open a new file in the utils folder called map_utils.dart, and then add the following code:
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
const  int TILE_SIZE = 32;
Offset worldToGridOffset(Vector2 mapLocation) {
  double x = 
    (mapLocation.x / TILE_SIZE).floor().toDouble();
  double y = 
    (mapLocation.y / TILE_SIZE).floor().toDouble();
  return Offset(x, y);
}
Vector2 gridOffsetToWorld(Offset gridOffset) {
  double x = (gridOffset.dx * TILE_SIZE);
  double y = (gridOffset.dy * TILE_SIZE);
  return Vector2(x, y);
}

Copy
Here, we have two functions for converting between the world and grid coordinates while taking into account our tile size of 32 x 32.

Next, we will update our George class to update our code when we move to a touched location, to first calculate the path with the A Star algorithm, and then navigate along the path while changing the direction we are facing as we navigate the path.

Open the george.dart file and add the following imports to the file:
import 'package:goldrush/utils/map_utils.dart';
import 
  'package:a_star_algorithm/a_star_algorithm.dart';

Copy
Next, add the following variables at the top of the class to keep track of the barrier offset locations, our path to the destination, and our current path step:
List<Offset> barrierOffsets;
List<Offset> pathToTargetLocation = [];
int currentPathStep = -1;

Copy
Let's now update the constructor to pass in the barrierOffsets:
George({required this.barrierOffsets, required 
  this.hud, required Vector2 position, required 
    Vector2 size, required double speed}) : super(
      position: position, size: size, speed: speed) {

Copy
Next, let's update the moveToLocation function to set up the new variables:
void moveToLocation(TapUpInfo info) {
  pathToTargetLocation = AStar(
    rows: 50,
    columns: 50,
    start: worldToGridOffset(position),
    end: worldToGridOffset(info.eventPosition.game),
    withDiagonal: true,
    barriers: barrierOffsets
  ).findThePath().toList();
  targetLocation = info.eventPosition.game;
  faceCorrectDirection();

Copy
As pathToTargetLocation[0] is the same as the current position, we set currentPathStep to the next step, 1:

  currentPathStep = 1; 
  targetLocation = gridOffsetToWorld(
    pathToTargetLocation[currentPathStep]);
  targetLocation.add(Vector2(16, 16));
  movingToTouchedLocation = true;
}

Copy
Here, we store the result of the A Star algorithm in the pathToTargetLocation variable.

We pass in our number of rows and columns, which is the same as our map size, 50 x 50. We set the withDiagonal value to allow the path to take shortcuts, which looks more natural. You can try setting this value to false when we run this code to see the difference and to decide your preference. We pass in barrierOffsets, which will be passed in via the constructor. Finally, we convert George's position and the touched location to the grid offset coordinates. The result will be a path to the location while avoiding the water obstacles.

If you load the updated map that we downloaded in the Technical requirements section of this chapter into the Tiled application, you will see that we have placed water obstacles in the center of the map, which we can use to test that the path navigation works.

After getting the A Star result, we set targetLocation to be the touched location, and then call a new function that we will define soon, called faceCorrectDirection. This new function ensures that George is facing the correct direction when he starts navigating the path to the target location.

Next, we set currentPathStep to start at 1, rather than at the start of the list in position 0. This is because, when we get the result of the algorithm, it inserts our current location at position 0 and, as we are already at that location, we don't need to move there!

We then set targetLocation based on the offset at the currentPathStep to 1 and convert this back to world coordinates for our movement. Remember, we need to use grid coordinates in order for the algorithm to work, but we require world coordinates for our movement in real pixels. Finally, we add a vector of 16, 16 to our targetLocation.

This is because, when we convert to world coordinates, we are basing this on the top-left corner of the tile, but we want to move George based on the center of the tile, so we add 16, 16 to the x and y values of the vectors, which is half of the tile size, 32.

Finally in this function, we set movingToTouchedLocation to true, which starts George moving toward the targetLocation in the update function.

Next, we need to change the update function to walk along the path. This function allows us to change the next path step by walking between each path step until we reach the final point in the path.
In the previous step, we referenced a new function called faceCurrentDirection, which we will also use again when we change the update function, so let's create that first.

Below the update function, create a new function called faceCurrentDirection and add the following code:

void faceCorrectDirection() {
    var angle = getAngle(position, targetLocation);
    if ((angle > 315 && angle < 360) || (angle > 0 && 
      angle < 45) ) { // Facing right
      animation = rightAnimation;
      currentDirection = Character.right;
    } 
    else if (angle > 45 && angle < 135) { 
      // Facing down
      animation = downAnimation;
      currentDirection = Character.down;
    } 
    else if (angle > 135 && angle < 225) {
      // Facing left
      animation = leftAnimation;
      currentDirection = Character.left;
    } 
    else if (angle > 225 && angle < 315) { 
      // Facing up 
      animation = upAnimation;
      currentDirection = Character.up;
    }
}

Copy
Finally in this step, we are going to change the update function to change the targetLocation when each path step is taken until we reach our touched location.
Because the update function is quite large now, we are going to refactor this function completely to make it easier to manage our code.

We will create three new functions for each movement type, moveByJoystick, moveByKeyboard, and moveByTouch. We will move the relevant parts of the update function into the first two functions, but for the third, we will do a rewrite because we are now using our path around the obstacles.

Below our update function, add the following three empty function stubs to start:

void moveByJoystick(double dt) async {}
void moveByKeyboard(double dt) async {}
void moveByTouch(double dt) async {}

Copy
Next, add the code (available at https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter10/lib/components/george.dart) from the update function to the moveByJoystick function.
Next, add the following code from the update function to the moveByKeyboard function:
movePlayer(dt);
playing = true;
movingToTouchedLocation = false;
if (!isMoving) {
  isMoving = true;
  audioPlayerRunning = await FlameAudio.loopLongAudio(
    'sounds/running.wav', volume: 1.0);
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
Next, add the following code from the update function to the moveByTouch function:
if (!isMoving) {
  isMoving = true;
  audioPlayerRunning = await FlameAudio.loopLongAudio(
    'sounds/running.wav', volume: 1.0);
}
movePlayer(dt);
double threshold = 2.0;
var difference = targetLocation - position;
if (difference.x.abs() < threshold &&
   difference.y.abs() < threshold) {
  if (currentPathStep < pathToTargetLocation.length –
    1) {
    currentPathStep++;
    targetLocation = gridOffsetToWorld(
      pathToTargetLocation[currentPathStep]);
    targetLocation.add(Vector2(16, 16));
  } else {
    stopAnimations();
    audioPlayerRunning.stop();          
    isMoving = false;
    movingToTouchedLocation = false;
    return;
  }
}
playing = true;
if (currentPathStep <= pathToTargetLocation.length) {
  faceCorrectDirection();
}

Copy
In the moveByTouch function, we have changed a few things – so let's go through the parts that are different from our previous touch code discussed in earlier chapters.

We still check whether our location after moving the player is within the threshold, but we have increased the threshold to 2.0, which helps with touch to move, especially when the character is running. If we have arrived at the targetLocation, we check whether there are any more steps and increase currentPathStep if there are more steps, and then update targetLocation to the new path location. Once again, because each offset in the path relates to the top-left corner of the grid cell, we add 16,16 to the target location to center it. If there are no more steps, we stop the animation and sound.

At each step change, we adjust the direction the character is facing to ensure that the character faces the direction of travel to the next path step.

Now that we have our three movement functions defined, let's rewrite the simplified update function. Replace the current update function in its entirety with the following new code that uses our new movement functions:
@override
void update(double dt) async {
  super.update(dt);
  speed = (hud.runButton.buttonPressed ||
    keyRunningPressed) ? runningSpeed : walkingSpeed;
  final bool isMovingByKeys = keyLeftPressed ||
    keyRightPressed || keyUpPressed || keyDownPressed;
  if (!hud.joystick.delta.isZero()) {
    moveByJoystick(dt);
  } else if (isMovingByKeys) {
      moveByKeyboard(dt);
  } else {
    if (movingToTouchedLocation) {
      moveByTouch(dt);
    } else {
      if (playing) {
        stopAnimations();
      }
      if (isMoving) {
        isMoving = false;
        audioPlayerRunning.stop();
      }
    }
  }
}

Copy
Now that we have finished updating the George class, let's move on to the main class to connect everything together.

Open the main.dart file and add the following import for the map utils functions:
import 'package:goldrush/utils/map_utils.dart';

Copy
In the onLoad function, below where we load and play the background music, add the following code to initialize the water barriers and then pass these to the George class via the constructor for use with pathfinding:
FlameAudio.bgm.initialize();
await FlameAudio.bgm.load('music/music.mp3');
await FlameAudio.bgm.play('music/music.mp3', volume:
  0.1);
final tiledMap = await TiledComponent.load(
  'tiles.tmx', Vector2.all(32));
add(TileMapComponent(tiledMap));
List<Offset> barrierOffsets = [];
final water = 
  tiledMap.tileMap.getObjectGroupFromLayer('Water');
water.objects.forEach((rect) {
  if (rect.width == 32 && rect.height == 32) {
    barrierOffsets.add(worldToGridOffset(Vector2(
      rect.x, rect.y)));
  }
  add(Water(position: Vector2(rect.x +
   gameScreenBounds.left, rect.y + 
     gameScreenBounds.top), size: Vector2(rect.width,
       rect.height), id: rect.id));
});
var hud = HudComponent();
var george = George(barrierOffsets: barrierOffsets, 
  hud: hud, position: Vector2(gameScreenBounds.left + 
    300, gameScreenBounds.top + 300), size: 
      Vector2(32.0, 32.0), speed: 40.0);
add (george);
children.changePriority(george, 15);

Copy
Please note that we have moved the code for initializing the tile map and water objects, meaning you can remove the other references for that in this function.

If you run the game now and use touch to move toward the center of the map inside of the water barriers, you will see George walk around the water barriers to get to his location!

Summary
In this chapter, we improved our character and enemies by making them appear more intelligent. The enemies now chase George if he is near enough and within their line of sight, and George can now move around the map while avoiding obstacles.

In the final chapter, we will add some new screens to the game to tie everything together.

We will add a simple menu intro screen with a link to a settings screen and talk about how we can navigate between screens within the game. We will also discuss how you could improve the game further, how to monetize your games, and what else is worth learning to expand your games' programming skills.

Questions
What function can we call to measure the distance between two positions to detect whether an enemy is near a player?
What is the name of the algorithm we use for pathfinding in our game?
How can we convert between world and grid coordinates?
Why would we set withDiagonal to true in our pathfinding algorithm?
Why must we adjust the direction in which we are facing at each step of our pathfinding?



> [ 12 C9 Implementing Advanced Graphics Effects ](/packtpub/javascript_from_frontend_to_backend/12_c9_implementing_advanced_graphics_effects) <---> [ 14 C11 Finishing the Game ](/packtpub/javascript_from_frontend_to_backend/14_c11_finishing_the_game)
>
> Title: 13 C10 Making Intelligent Enemies with AI
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/13_c10_making_intelligent_enemies_with_ai
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 13_c10_making_intelligent_enemies_with_ai.md

