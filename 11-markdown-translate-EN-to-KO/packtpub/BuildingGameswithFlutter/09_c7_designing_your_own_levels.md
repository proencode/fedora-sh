
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

> [ 08 C6 Playing Sound Effects and Music ](/packtpub/javascript_from_frontend_to_backend/08_c6_playing_sound_effects_and_music) <---> [ 10 C8 Scaling the Game for Web and Desktop ](/packtpub/javascript_from_frontend_to_backend/10_c8_scaling_the_game_for_web_and_desktop)

# Chapter 7: Designing Your Own Levels

So far, our game has used the physical limits of the device screen as the boundary for both George and our enemy sprites. In this chapter, we are going to show you how to make game levels that are bigger than the screen and how to scroll around the level using a camera to show part of the level.

We will show you how to add dynamic objects or sprites and how to deal with collisions on these larger levels. This is a very common technique and is used by most types of games, including platform games such as Sonic and 2D role-playing games such as Ultima or Zelda.

We will cover the following topics:

Introduction to Tiled
Loading a tile map
Adding dynamic objects to the map
Understanding map navigation
Detecting tile collisions
Technical requirements
To examine the source from this chapter, you can download it from https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter07 by following these steps:

From https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter07/assets/images/tiles.png, download the tiles.png file and move it into the assets/images local project folder.
From https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter07/assets/tiles/tiles.tmx, download the tiles.tmx file.
From https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter07/assets/tiles/tiles.tsx, download the tiles.tsx file.

Then, move both files into the assets/tiles local project folder after creating this folder.

Open the pubspec.yaml file and add the following library dependency:
flame_tiled: ^1.0.0

Copy
In the assets section of the same file, let's add the tile assets we just downloaded:
- assets/tiles/tiles.tmx
- assets/tiles/tiles.tsx
- assets/images/tiles.png

Copy
Save the file and allow pub get to download this dependency and validate the assets:
flutter pub get

Copy
Now that we have downloaded the required tile map files and dependencies, let's look into the software used to create tile maps.

Introduction to Tiled
Tiled is a free, open source, easy-to-use, and flexible level editor that can be downloaded from https://www.mapeditor.org/.

Figure 7.1 – Editing a map with the Tiled map editor
Figure 7.1 – Editing a map with the Tiled map editor

The levels we create with Tiled are known as tile maps. Tile maps are very common in 2D game development as they allow us to create large maps or levels out of fixed-size tiles.

A tile map is like a sprite sheet, which we have used before in Chapter 4, Drawing and Animating Graphics. The data is stored in one large image, and we extract what we need into smaller components.

This is a very performant and memory-efficient way of creating maps larger than the physical screen size. If you were to try and make this with a very large image, the image would need to be loaded into memory, which may cause the game to crash or run very slowly.

Let's look at an example of some graphics from a tile map and how they might be used. The following example is from the website https://opengameart.org/content/tilecraft-tile-set-ground#, which was made by user GrumpyDiamond.

As you can see in the following screenshot, it has different types of terrain that we can use to create a larger map:

Figure 7.2 – An image containing various terrains
Figure 7.2 – An image containing various terrains

Sometimes, tile map images also contain buildings or trees that you can use on the maps too, but in this example, we see tiles for making water, grass, paths, and a few plants.

We can then load this image and break each image part into its smaller tiles, which can then be used to create a larger map, as in the following screenshot:

Figure 7.3 – Using the terrain images to make a larger map
Figure 7.3 – Using the terrain images to make a larger map

Notice in Figure 7.3 that a much larger water area was created by reusing the smaller tile images to build something much bigger.

The Tiled tool makes creating tile maps very easy, including tools such as image editing, which allow you to draw with tiles onto the map however you like. You can export maps from Tiled in a variety of formats, but XML and JSON are the most common.

Tiled is a tool that is easy to get started with but also has advanced features beyond the scope of this book, so we won't go into any more detail about it here. Instead, we will provide the premade tile maps for use in our game, so that you can use them directly, but I do recommend spending some time with Tiled once you want to create tile maps for your own games.

When you export a map from Tiled, it has a lot of information about the map and tile size, but the map data section is represented as a 2D array, which could look something like this:

[

Copy
 [1, 1, 1, 1, 1, 1, 1, 1], 

Copy
 [1, 2, 2, 2, 2, 2, 2, 1], 

Copy
 [1, 2, 3, 3, 3, 3, 2, 1],

Copy
 [1, 2, 2, 2, 2, 2, 2, 1],

Copy
 [1, 1, 1, 1, 1, 1, 1, 1]

Copy
]

Copy
The 2D array in the preceding code block is eight tiles wide and five tiles high. 1 in the array could represent the tile ID for some mountains, 2 might represent a path, and 3 might be water. So, in this example, the map has a path around a lake in the center of the map, with mountains around the outer edges.

Inside a game, we would load this data and iterate over the array and draw each visible tile based on its tile ID. We will draw the tiles starting at the top left, 0,0, and then go through the tile data line by line, drawing each tile in turn.

Now that we have had an introduction to tile maps, we will add our own to the game in the next section.

Loading a tile map
In the Technical requirements section, we added our tile map files and the flame_tiled library, which is used for loading and displaying tile maps.

Each tile is 32 x 32 pixels, and the map is 50 tiles wide by 50 tiles high, so our total map size in pixels will be 1,600 x 1,600 pixels, which is 50 * 32 for width and height.

You can open the tiles.tmx file in Tiled if you want to see how the tile map looks there, but here is a screenshot of how our tile map looks when loaded and drawn:

Figure 7.4 – The Gold Rush tile map
Figure 7.4 – The Gold Rush tile map

The map is basic with water around the edges and paths leading to the center of the map, with grass everywhere else on the map.

We will use this as our base, adding objects and enemies to the map and collision detection to the water areas to prevent George or the enemies from moving off the edges of the map.

Let's get started by loading the tile map and displaying it:

Open the main.dart file. In the onLoad function, we will add the following code to load the tile map into TiledComponent and make it a game component. Let's add this in the following code block, where we previously added the code for the Background component:
add(Background(george));
final tiledMap = await
  TiledComponent.load('tiles.tmx', Vector2.all(32));
add(tiledMap);

Copy
Add the following import at the top of the file:
import 'package:flame_tiled/flame_tiled.dart';

Copy
If you run the game now, you will see the tile map that we just loaded and George and some of the enemies. You'll only see some of the enemies because some will be drawn offscreen. You will need to switch your emulator from portrait to landscape to see the map correctly.

In the next section, we are going to remove the hardcoded enemies and start using a map layer to add the enemies dynamically to the map.

Adding dynamic objects to the map
So far in the game, we have added a couple of each enemy, but now we are going to show you how enemies and other objects can be added dynamically to the game.

This is very common in games because you may want some treasure or an enemy to spawn at a certain location on the map. Tiled has a really great way to help us with this, with a feature called layers. The two most common layers are tile layers and object layers. We already used tile layers to display our map in the previous section, Loading a tile map. Object layers allow us to define objects that will be drawn on top of the map.

In the following screenshot, we show our tile map opened in Tiled, where you can see we have two layers named Enemies and Map. The Map layer is our tile layer, and the Enemies layer shows an object layer. We will use this Enemies layer to define spawn points for our enemies:

Figure 7.5 – Our tile map showing the tile and object layers
Figure 7.5 – Our tile map showing the tile and object layers

We have initially placed 12 enemies on the map, 3 enemies in each quadrant. The enemies will wander around as mentioned in the Loading a tile map section. When we have loaded them in the game, we will read their locations from the tile map object layer, Enemies. So, let's add them to our game next:

Open the main.dart file and remove the four lines where we previously added our enemies in our onLoad function:
add (Zombie(position: Vector2(100, 200), 
  size: Vector2(32.0, 64.0), speed: 20.0));
add (Zombie(position: Vector2(300, 200),
  size: Vector2(32.0, 64.0), speed: 20.0));
add (Skeleton(position: Vector2(100, 600), 
  size: Vector2(32.0, 64.0), speed: 60.0));
add (Skeleton(position: Vector2(300, 600), 
  size: Vector2(32.0, 64.0), speed: 60.0));

Copy
Add the following code to replace the code we just removed:
final enemies =
  tiledMap.tileMap.getObjectGroupFromLayer('Enemies');
enemies.objects.asMap().forEach((index, position) {
  if (index % 2 == 0) {
    add(Skeleton(position: Vector2(position.x,
      position.y), size: Vector2(32.0, 64.0), 
        speed: 60.0));
  } else {
    add (Zombie(position: Vector2(position.x,
      position.y), size: Vector2(32.0, 64.0), speed:
        20.0));
  }
});

Copy
This code is to read the object layer from the tile map and iterate over the data, which contains 12 enemies, so that we place 6 skeletons and 6 zombies around the map.

If you run the game now, you will see that we have some enemies. However, you will currently see fewer of them because they are spread out around the map. Currently, we are only showing the top-left corner of the map, but before we learn to figure out how to move around the map in the Understanding map navigation section, let's add some other objects to the map.

If you recall from earlier in the book, in Chapter 1, Getting Started with Flutter Games, the final goal of the game is to collect gold coins to build up your score, but we don't yet have any gold coins in the game. So, let's fix that by introducing a new animated coin sprite and placing them in random locations all over the map. Of course, we could add these as an object layer on the tile map if we wanted to, but as we have seen how we can add fixed objects with the enemies, let's make the coins' locations random to make the game more fun.

Download the coins image from https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter07/assets/images/coins.png and save the image in our assets/images project folder.
Download the coin audio file from https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter07/assets/audio/sounds/coin.wav and save the audio file in our assets/audio/sounds project folder.
Open the pubspec.yaml file and add the following line to your list of assets:
- assets/images/coins.png
- assets/audio/sounds/coin.wav

Copy
Save the file and allow pub get to validate the asset:
flutter pub get

Copy
In the component folder, create a file called coin.dart and open it. Then add the following class definition for the Coin class, which loads the coin image, creates an animation, and sets up the collision detection on the coin:
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
class Coin extends SpriteAnimationComponent with 
  HasHitboxes, Collidable {
  Coin({required Vector2 position, required Vector2
    size}) : super(position: position, size: size);
  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    var spriteImages = 
      await Flame.images.load('coins.png');
    final spriteSheet = 
      SpriteSheet(image: spriteImages, srcSize: size);
    animation = spriteSheet.createAnimation(row: 0,
      stepTime: 0.1, from: 0, to: 7);
    
    addHitbox(HitboxRectangle());
  }
}

Copy
Open the main.dart file and add the following imports at the top of the file:
import 'package:goldrush/components/coin.dart';
import 'dart:math';

Copy
In the onLoad function, add the following code below where we add the enemies; this will add the coins to the map:
Random random =  
  Random(DateTime.now().millisecondsSinceEpoch);
for (int i = 0; i < 50; i++) {
  int randomX = random.nextInt(48) + 1;
  int randomY = random.nextInt(48) + 1;
  double posCoinX = (randomX * 32) + 5;
  double posCoinY = (randomY * 32) + 5;
  add(Coin(position: Vector2(posCoinX, posCoinY),
    size: Vector2(20, 20)));
}

Copy
The code creates a random number generator using the current clock time as the seed to initialize the random numbers, which will make the numbers truly random.

If you want a more predictable sequence of numbers generated, you can pass the same fixed integer each time. This can be useful in games where you want to create a set of level data that's always the same but appears to be random.

Next, we generate a number between 1 and 48, because we don't want to draw coins on the water tiles. Later, we will add collision detection to the water tiles to prevent the player or enemies from walking on the water. By generating a number with these bounds, it will give us a location on the map related to the map array data.

We then take those numbers and multiply the number by 32, which is the size of the map tile, and add 5 to get the posCoinX and posCoinY values, which is the location of the coin in pixels.

We then use these values to add a new coin component to the map at this position.

Note that we do all this in a loop that adds 50 coins to the map, some of which will be currently offscreen until we add the map navigation.

Now that we have our coins added to the map, let's continue and update the George class so that George can collect the coins.
Open the george.dart file and at the top of the file, add the following import:
import 'package:goldrush/components/coin.dart';

Copy
At the bottom of the onLoad function, update the line that loads the audio files into the audio cache to load the coin.wav audio file:
await FlameAudio.audioCache.loadAll(
  ['sounds/enemy_dies.wav', 'sounds/running.wav', 
   'sounds/coin.wav']);

Copy
Finally, at the bottom of the onCollision function, let's add a check for a collision with a coin – if we collide with a coin, it will remove the coin from the game, update our score by 20, and play the coin audio:
if (other is Coin) {
  other.removeFromParent();
  hud.scoreText.setScore(20);
  FlameAudio.play('sounds/coin.wav', volume: 1.0);
}

Copy
If you run the game now, you will see the spinning coins on the map and you will be able to move George around a little to collect the coins. However, you will notice that we are still constrained to the top-left corner of the map, even if we try to move beyond this top corner.

In the next section, we will break George and the enemies free of this restriction, allowing them to move around the map by adding navigation to the game map!

Understanding map navigation
Now that we have our tile map loaded and enemies and coins dynamically added to the map, we can fix the navigation so we can wander around the map. But before we do that, let's talk about cameras and how we use them in our game.

A camera allows us to change what we see on the screen, which is very useful when you have a map that is larger than the physical screen. We can use this to do the following:

Zoom the camera to show more or less of the map.
Show a different part of the map than George's current location on the map.
Move to a different part of the map using animation for a smooth transition.
Link the camera's position to follow George, so that when George moves around the map, the camera updates and George stays visible, and the map moves around his position.
Most games use a combination of these, but it is the last point we are most interested in, as we want the camera to follow George as he moves around.

Important Note

Look up cameras in the Flame documentation if you are interested in learning more about the other points. The documentation for cameras can be found at https://docs.flame-engine.org/main/camera_and_viewport.html.

Let's get started with fixing the navigation:

Open the main.dart file and at the bottom on the onLoad function, add the following code:
camera.speed = 1;
camera.followComponent(george, worldBounds: 
  Rect.fromLTWH(0, 0, 1600, 1600));

Copy
Here, we set the camera speed, set the camera to follow George, and set the bounds of the world to be 1,600 x 1,600, which is the 50 tiles' width and height times the pixel size of each tile, which is 32.

If you run this now and navigate around the map, you may notice a couple of issues:

a. The enemies don't wander any further than the original screen size.

b. You can only touch to move within the original screen size.

Let's fix each of these issues in turn.

The reason why the enemies don't move around the map is that they are colliding with the ScreenCollidable that we added when the screen was a fixed size. As we will do the collision for this in the next section, we can just delete the line where we added the ScreenCollidable file at the bottom of the onLoad function:
add(ScreenCollidable());

Copy
The reason why you can only touch within the physical screen bounds is that the touch events are picked up in the Background class, and the Background class size is currently based on the physical dimensions of the screen.
Also, now, as we are drawing the map, the background is only used to detect and pass on the touch event to George, so we can remove most of the drawing code from the Background class. Open the background.dart file and change all the code in the class and add the reduced code, as follows:

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'george.dart';
class Background extends PositionComponent with 
  Tappable {
  Background(this.george);
  final George george;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    position = Vector2(0, 0);
    size = Vector2(1600, 1600);
  }
  @override
  bool onTapUp(TapUpInfo info) {
    george.moveToLocation(info);
    return true;
  }
}

Copy
Apart from reducing the code in this class, the main change is at the bottom of the onLoad function, where we set the size to 1,600 x 1,600, which is the map size and not the screen size that we had previously in the Drawing onscreen controls section of Chapter 5, Moving the Graphics with Input.

If you run the game now, you will see these issues are fixed and we can navigate around and collect coins. Unfortunately, now that we have removed ScreenCollidable, George and the enemies can walk off the sides of the screen.

In the next section, we will fix this by making the water around the map into a collidable object that we can check for as we move around the map, detecting whether we collide with the water and preventing George or the enemies from moving over it.

Detecting tile collisions
So far in our game, we have used component-level collision detection to detect collisions between George and the coins and enemies. When you are working with map levels, you will generally add other objects on the map that act as barriers, such as water, buildings, or trees. As the player navigates around maps with these types of items, we want to ensure that neither George nor enemies walk through these objects.

In the Understanding map navigation section, we removed the ScreenCollidable component to allow the enemies to freely move around the map, but now the enemies and George can wander off the map.

In this section, we are going to add a water barrier that will go around the map. We will check for collisions to prevent both George and the enemies from being able to leave the map. We will read the map locations of the water from an object layer and create new Water components. We will make these components collidable and add these to the game so that Flame will check for collisions with the water and we can prevent George or the enemies from moving over the water.

This presents some interesting challenges because with our previous collision checks, we just remove the enemy or coin when George collides with them, and George can continue to move in the direction he is traveling in, but now we will have to prevent movement when we collide with the water. Before we get into that, let's first talk a little bit more about what is happening when Flame checks for collisions.

Understanding collisions
When we set up a component to be collidable, we are adding a shape around the object. Then, Flame can use these shapes to calculate if one shape intersects with another shape and trigger a collision detection if that happens.

As the game grows, we keep adding more items that can be collided with, and the problem with this process is that for every collidable item we add to the game, there needs to be a collision check. The more collision checks we have, the more effort is required by the processor to handle all the math behind that. Eventually, if you have too many collision checks, the performance of the game will degrade, and you will notice that the game starts to slow down.

Let's look at some of the math that we have in the game so far, to put this in context:

We have 12 enemies in the game, 6 zombies and 6 skeletons.
We have 50 coins in the game.
We are going to add borders around the edges of the map, so that could be around 200 water components due to each edge having 50 tiles with 4 edges around the map.
We also have our player, George.
This is 263 collidable objects in the game. At the moment, every one of these collidable objects has a collision check with every other collidable object in the game. So, that is 263 * 263 = 69,169 collision checks. That's nearly 70,000 collision checks, and that's happening every frame!

That's a scary number of collision checks and it's surprising our game is still running!

If you think about it, most of those checks are a complete waste, because a coin cannot collide with other coins as they are all spread out around the map, and they don't move. This is the same for the water objects that we will add too. Also, the water objects can't collide with the coins either as they are in different locations.

Fortunately, Flame provides a great solution to this issue by allowing us to set collidableType on the collidable component to let us tell Flame whether we should do a check or not for this object.

The three collidable types are as follows:

Active: An active collidable collides with other collidable objects that are of the active or passive type. This is the default collidable type, if you don't set the value for all collidable objects.
Passive: A passive collidable collides with other collidables of the active type but not with other passive collidable objects.
Inactive: An inactive collidable will not collide with other collidable objects.
The solution for us to reduce the number of collision checks is to make the Water and Coin objects passive and leave George and the enemy objects in their default active state.

Implementing collisions
Let's get started by adding the Water objects to our game:

In the project's component folder, create a new file called water.dart and add the following code:
import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
class Water extends PositionComponent with 
  HasHitboxes, Collidable {
  Water({required Vector2 position, required Vector2
    size, required this.id}) : super(position: 
      position, size: size);
  
  int id;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    
    collidableType = CollidableType.passive;
    
    addHitbox(HitboxRectangle());
  }
}

Copy
Here, we define the Water object, which is a rectangular area that has a position and size.

In the onLoad function, we set collidableType to be of the CollidableType.passive type and add a hitbox for the collision checks between George and Water and the enemies and Water.

Open the main.dart file and at the bottom of the onLoad function, add the following code below where we added the coins:
final water = 
  tiledMap.tileMap.getObjectGroupFromLayer('Water');
water.objects.forEach((rect) {
  add(Water(position: Vector2(rect.x, rect.y), size: 
    Vector2(rect.width, rect.height), id: rect.id));
});

Copy
Here, we get the water objects from the tile map as an object group and iterate over these objects, using the x, y, width, and height values from this to create and add a Water component to the game.

If you open the tile map in Tiled, you can see that the Water object layer consists of four simple rectangles, which reduces the amount of collisions checks. We don't really care about which individual water tile we collide with, so we can just check the four edges.

At the top of the same file, add the following import for the Water component:
import 'package:goldrush/components/water.dart';

Copy
Open the coin.dart file and add the following code to the onLoad function to set collidableType to be passive:
super.onLoad();
collidableType = CollidableType.passive;

Copy
Let's change the collision for the enemies first as it's a very quick change. Open the character_enemy.dart file and at the top of the onCollision function, let's change the object check to use the Water object instead of ScreenCollidable with the following code:
if (other is Water) {

Copy
Next, we need to add the import for the Water class at the top of this file:
import 'package:goldrush/components/water.dart';

Copy
Moving on, Flame has debugMode, which we can set to true to see the bounding boxes (a box that shows the boundary limits of the area of detection) of the collidable boxes, which is useful for debugging collision detection. Let's add that next.

Open the main.dart file and at the top of the onLoad function, add the following line:
debugMode = true;

Copy
If you run the game now, you will see the bounding boxes and you may notice an issue.

The Skeleton and Zombie sprites have a large amount of space at the top of the sprites, which means if George collides with the top of these sprites, the collision will happen sooner than expected because of the extra space in the image. To get around this, we can pass two values to HitboxRectangle, which are relation and relativeOffset.

The relation value defines the relationship between the length of the horizontal and vertical sides and the size of the bounding box, and the relativeOffset value is the position of your shape in relation to its size from (-1,-1) to (1,1).

To fix the space issue at the top of the enemy sprite classes, open both the zombie.dart and skeleton.dart files, and at the bottom of the onLoad function, change the line that adds the hitbox in both classes to the following code:

addHitbox(HitboxRectangle(relation: Vector2(1.0, 0.7))..relativeOffset = Vector2(0.0, 0.3));

Copy
If you run the game now, you will see the bounding box is tightly aligned with the size of the sprite, which will give us much better results with the collision detection.

We can also tweak the sprite that we use for George to improve the bounding box further on the George sprite. Open the george.dart file and at the bottom of the onLoad function, change the line that adds the hitbox to the following code:
addHitbox(HitboxRectangle(relation: Vector2(0.7, 0.7))..relativeOffset = Vector2(0.0, 0.1));

Copy
Please note that the values are different from the ones we used for the enemy sprites.

Now that we have finished tweaking our bounding boxes, we can now remove the debugMode line in the main.dart file.
Let's continue adding the final collision checks in the George class.
At the top of the George class where we previously defined the class variables, add these two new variables, which we will use to keep track of whether we have collided with the Water component and what the direction of travel was when we collided:

int collisionDirection = Character.down;
bool hasCollided = false;

Copy
We set collisionDirection to down because George starts the game facing down.

Next, let's add an import for the Water object, which we are going to use in the collision check. At the top of the file where the rest of the imports are, add the following import:
import 'package:goldrush/components/water.dart';

Copy
At the bottom of the onCollision function, let's add the following code to set the collision variables when a collision is detected with the Water border:
if (other is Water) {
  if (!hasCollided) {
    if (movingToTouchedLocation) {
        movingToTouchedLocation = false;
    } else {
      hasCollided = true;
      collisionDirection = currentDirection;
    }
  }
}

Copy
We will use these values in the next few steps to prevent us from moving George when we collide with the water. But also notice in the preceding code that if a collision has been detected and we are moving to a touched location, we now set movingToTouchedLocation to false to stop George from continuing to try to move.

We also want to set the hasCollided variable back to false when a collision has ended, and fortunately Flame has a function called onCollisionEnd that we can override and will get called when the objects have stopped colliding:
@override
void onCollisionEnd(Collidable other) {
  hasCollided = false;
}

Copy
Next, we will create a function for handling all our movement code and will only allow the movement if there hasn't been a collision. Because we calculate the movement of a touched location differently, we will split the code up based on whether we are moving to a touched location or not, or whether the player is using the joystick to control the movement:
void movePlayer(double delta) {
  if (!(hasCollided && collisionDirection == 
    currentDirection)) {
    if (movingToTouchedLocation) {
      position.add((targetLocation - 
        position).normalized() * (speed * delta));
    } else {
      switch (currentDirection) {
        case Character.left:
          position.add(Vector2(delta * -speed, 0));
        break;
        case Character.right:
          position.add(Vector2(delta * speed, 0));
        break;
        case Character.up:
          position.add(Vector2(0, delta * -speed));
        break;
        case Character.down:
          position.add(Vector2(0, delta * speed));
        break;
      }
    }
  }
}

Copy
Let's update the update function and replace the two places where we change the sprite position for both touch and joystick control.
Replace the following line with movePlayer(dt);:

position.add(hud.joystick.relativeDelta * speed * dt);

Copy
Also, replace the following line with movePlayer(dt);:

position += (targetLocation - position).normalized() * (speed * dt);

Copy
If you run the app now and move around with the joystick or by touch, you will see that you can't go outside of the screen, as we now collide with the water and prevent the player from moving over the water and outside the bounds of the screen.

Summary
In this chapter, we learned all about tile maps, how to create them and add dynamic objects, and how to navigate around them while avoiding colliding with our collision objects.

So far in the book, we have mainly been building the game for mobile, but Flutter also supports other platforms. In the next chapter, we will show you how to build the app for web and desktop, convert the game to support the bigger available screen area, and add extra controls to move George around with the keyboard.

Questions
What is the Tiled application used for?
Why should we use a tile map instead of one large image for the map?
How is map data stored inside a tile map?
What are the different types of layers that we can use on our tile maps?
How can we use a camera to adjust the map to keep a sprite in focus while we navigate around the map?
How can we add collidable objects using tile maps?
What are the three collidable types and why are they needed?



> [ 08 C6 Playing Sound Effects and Music ](/packtpub/javascript_from_frontend_to_backend/08_c6_playing_sound_effects_and_music) <---> [ 10 C8 Scaling the Game for Web and Desktop ](/packtpub/javascript_from_frontend_to_backend/10_c8_scaling_the_game_for_web_and_desktop)
>
> Title: 09 C7 Designing Your Own Levels
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/09_c7_designing_your_own_levels
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 09_c7_designing_your_own_levels.md

