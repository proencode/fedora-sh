
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

> [ 15 Other Books You May Enjoy ](/packtpub/javascript_from_frontend_to_backend/15_other_books_you_may_enjoy) <---> End

# Appendix: Answers

Chapter 1
The minimum constant frame rate Flutter draws at is 60 frames per second.
The graphics engine used by Flutter is Skia.
Android, iPhone, Mac, Linux, Windows, and the Web can be supported with Flutter.
Skia is an open-source graphics engine that provides graphics APIs for drawing shapes, text, and images.
Dart supports both just-in-time and ahead-of-time compilation. Just-in-time compilation provides great features like stateful hot reload while debugging, and ahead-of-time compilation provides high performances when the game is released.
Stateful hot reload allows you to make a change to your code, reload it, and instantly see the change (it's like painting with code!).
Dart uses fast garbage collection for short lived objects, allowing Dart to rebuild the widget tree at 60 frames per second for smooth animation.
Chapter 2
deltaTime is the time that has elapsed between frames. This is used to ensure that the frame rate stays constant across devices with different processing powers.
The Flame Component System allows us to build a flexible architecture for our game which is essential as our game grows.
HitboxRectangle is used for detecting shapes that are squares or rectangles.
Chapter 3
A synopsis gives a high-level summary of the game's goals used to entice players to play the game.
George's health will reduce by 25% when an enemy attacks him.
George's score increases by 20 points for every gold coin collected.
Water is used to define boundaries that George or the enemies cannot cross.
Chapter 4
A sprite is a graphic or image asset that can be static or animated.
The functions createAnimationByColumn or createAnimationByRow return a sprite animation list.
SpriteAnimationComponent reduces the amount of extra code we need as animation is built into the component by design.
A range is specified using the to and from parameters to represent the start and end animation frames.
A base class allows us to set up common behaviors that the sprites will share.
Chapter 5
A HUD is a Heads-Up Display. It represents a user interface that we want to draw on top of our game, showing things like score and health.
To detect touches, we use the Tappable mixin.
A TextComponent is used to draw text on the screen.
A joystick has an inner control which needs to be dragged to the outer control to register a value for the joystick's direction.
Chapter 6
We use the flame_audio library to add audio to our games.
Loading audio into a memory cache ahead of time improves your game's performance, as we are usually going to play the same sound effects many times in the game.
We need to clear the buffer to prevent holding onto the resource and causing memory leaks, which may crash our game.
We need to listen for pause events when the game is backgrounded and resume events when the game is brought back into focus.
We need to store a reference to the AudioPlayer that is returned for longer sound effects, so we can control the sound if the game is paused or resumed.
We use the volume parameter passed to the play function of FlameAudio.
Chapter 7
The Tiled application allows us to create tile maps that are much larger than the physical screen of our game, by using tile sets made up of small tiles to represent things like grass or water.
Tile maps reuse each tile, meaning that they take up much less memory than storing a larger image.
Tile map data is stored in a 2D array to represent the width and height of the map.
We can use tile layers for representing the tiles and object layers for objects we want to draw on top of the map.
To adjust the map as a sprite moves around, we use a camera and set up the followComponent function with the component that we want to focus on while it moves.
We can add collidable objects as an object layer in our tile map and then create components from these by reading the object with the tile map getObjectGroupFromLayer function.
A collidable object can be active, passive, or inactive. We use these to reduce the amount of collision checks between collidable objects, which helps the game's performance.
Chapter 8
Web browsers require audio permissions to be enabled when first loaded to prevent web sites irritating the user with annoying noises.
Our game is set up with an initial size based on the dimensions of the screen. If this changes, everything now needs to be recalculated, otherwise things like the joysticks won't be positioned correctly.
The default TiledComponent doesn't need a position and size. but to fix issues when resizing, we need to be able to recalculate these values. So, we wrap the component in a PositionComponent to give us the position and size values.
We can use canvaskit for prioritizing performance or html for prioritizing download size.
We use the KeyboardHandler mixin to listen for key events.
Chapter 9
lifespan and count are common properties to set when using particles. They represent how long the particle should be shown for and how many should be shown, respectively.
Particles created a lot of objects very quickly and can use up a lot of memory, so we need to free up the memory once the particle is no longer in use.
MovingParticle, CircleParticle, and ComputedParticle are examples of particles that Flame supports.
Flame supports the PreRenderedLayer for static images and the DynamicLayer for animated images.
We need to delegate the rendering of the super class to the layer class so that the layer processor can do its work of generating the shadow image.
Chapter 10
We can use the distanceTo function to measure the distance between two position vectors.
The algorithm we used in Gold Rush for pathfinding is known as A* (A Star).
We can multiply or divide the x or y position by the tile size to convert between world and grid coordinates.
Turning withDiagonal to true provides more natural movement to our characters, otherwise the characters will move at right angles which look robotic!
Every time we change direction, we must match the correct animation, or we will get issues like the sprite appearing to walk backwards.
Chapter 11
To persist simple data, we use the shared_preferences library.
To monetize a game, we can use adverts, in-app purchases, or a fixed cost purchase.
The Navigator class is used to change screens in Flutter.
With in-app purchases, you can resell the same digital asset to many people for a repeatable revenue stream.
Why subscribe?
Spend less time learning and more time coding with practical eBooks and Videos from over 4,000 industry professionals
Improve your learning with Skill Plans built especially for you
Get a free eBook or video every month
Fully searchable for easy access to vital information
Copy and paste, print, and bookmark content
Did you know that Packt offers eBook versions of every book published, with PDF and ePub files available? You can upgrade to the eBook version at packt.com and as a print book customer, you are entitled to a discount on the eBook copy. Get in touch with us at customercare@packtpub.com for more details.

At www.packt.com, you can also read a collection of free technical articles, sign up for a range of free newsletters, and receive exclusive discounts and offers on Packt books and eBooks.



> [ 15 Other Books You May Enjoy ](/packtpub/javascript_from_frontend_to_backend/15_other_books_you_may_enjoy) <---> End
>
> Title: 17 Appendix: Answers
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/17_appendix_answers
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 17_appendix_answers.md

