
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

> [ 03 C2 Working with the Flame Engine ](/packtpub/javascript_from_frontend_to_backend/03_c2_working_with_the_flame_engine) <---> [ 05 P2 Graphics and Sound ](/packtpub/javascript_from_frontend_to_backend/05_p2_graphics_and_sound)

# Chapter 3: Building a Game Design

Now that we have discussed Flame and shown you some basic animation, we want to discuss the game we are going to build throughout the rest of the book.

The game will be called Gold Rush, and has the following objectives:

Avoid being attacked by zombies and skeletons.
Explore the map, collecting as many gold coins as you can before you die.
It will be a simple game but will teach you a lot of skills by adding a lot of common features included in most games, including the following:

Drawing sprite graphics
Detecting collisions between sprites
Controlling a player with virtual joysticks, touch, or keys
Playing music and sounds
Drawing and moving around maps larger than the screen
Drawing particle and shadow advanced graphical effects
Creating intelligent enemies
Navigating around obstacles
Navigating between game screens
We will go through each of these topics in turn, gradually building out a full game. We will cover the following topics in this chapter:

Planning a game
Designing the game screens
Planning a game
Let's start by defining a synopsis for our game that we could use to market the game and give a brief reason to the player why they might want to play the game. Here is the synopsis:

In Gold Rush, you play as an explorer who must travel across the land in search of wealth by collecting any gold coins you can find. Beware, though: the path ahead won't be easy. You must avoid the zombies and skeletons that roam the land in search of your blood!

A nice, simple summary that tells the player what the goal of the game is and what they must do to succeed (collect as much gold as possible) while avoiding losing the game (by being attacked by zombies and skeletons).

In most games, you have a main character who is the game representation of yourself. In our game, this is George.

Figure 3.1 – Our protagonist, George
Figure 3.1 – Our protagonist, George

George will move around the game map controlled by the player either by the touch on a location on the screen, by controlling the on-screen joystick, or with the keys on a physical keyboard.

George can run to try to escape the enemies that are chasing him. His health is measured as a percentage that starts at 100% and decreases by 25% each time he is caught by a zombie or skeleton. Once George's health reaches 0, it's game over.

There are two types of enemies in the game – zombies and skeletons.

Figure 3.2 – Our game enemies, zombies and skeletons
Figure 3.2 – Our game enemies, zombies and skeletons

The enemies will chase George when he is nearby and within their line of sight. When they catch George, they will explode on impact and die, reducing George's health by 25%.

George will take the risk of being killed by zombies and skeletons because he can become very rich by avoiding the enemies and collecting the gold coins that are scattered around the map.

Figure 3.3 – The gold coins George collects to become richer
Figure 3.3 – The gold coins George collects to become richer

Every time George collects a spinning gold coin, his score increases by 20.

George has a large game world to explore, which will scroll around the screen as he explores.

Figure 3.4 – The game world George can explore
Figure 3.4 – The game world George can explore

The game world is mostly grass but has paths that George can follow. The map is surrounded by water, which George cannot cross. There is a central diamond area, which is the focal point of the map and is surrounded by water for decoration.

The game world is made up of a tile map using the Tiled application, which allows us to reuse smaller tiles to make larger maps efficiently. The following image is used to create our game world map (available at https://opengameart.org) and is originally created by Luis Zuno:

Figure 3.5 – The tile map used to create our game world map
Figure 3.5 – The tile map used to create our game world map

The game will use music and sound to enhance the game. There is background music that will play while the game is playing, and the volume for this will be changeable in the game settings.

There are three sound effects that we will use during the game:

George movement – A running sound that will play constantly while George is moving.
Enemy dying – Every time an enemy attacks George, it will die and make this sound.
Coins – Every time George collects a coin, this sound will play.
The sound will stop playing if the game is placed in the background on mobile.

Now that we have discussed our game content, let's discuss the designs of the game screens and how to navigate between them.

Designing the game screens
Now that we have discussed the elements of the game, let's discuss the screens we will use in the game and how the player will navigate between them.

The following is a basic outline to illustrate the flow of the game screens:

Figure 3.6 – Gold Rush screen game flow
Figure 3.6 – Gold Rush screen game flow

Here, we can see the player is shown the game menu at the start, where they can play the game, go to the settings screen, or exit the game.

If they choose Play Game, the game is loaded and they begin to play the game.

If they choose Settings, they can adjust the music and then return to the game menu.

The Game Over!! screen will be shown when the player dies in the game and then they can return to the game menu.

Let's have a look at the final designs and appearances for these screens.

The following screenshot shows the game menu screen:

Figure 3.7 – The game menu screen for Gold Rush
Figure 3.7 – The game menu screen for Gold Rush

This is what the Settings screen will look like:

Figure 3.8 – The Settings screen for Gold Rush
Figure 3.8 – The Settings screen for Gold Rush

Figure 3.9 shows the screen when the game is over:

Figure 3.9 – The Game Over!! screen for Gold Rush
Figure 3.9 – The Game Over!! screen for Gold Rush

The following screenshot shows George, the enemies, the map, and virtual controls for Gold Rush:

Figure 3.10 – Game screen showing George, the enemies, the map, and virtual controls
Figure 3.10 – Game screen showing George, the enemies, the map, and virtual controls

In this section, we walked through how the game screens will look and how to navigate between them.

Summary
In this chapter, we discussed the aim of the game and what the sprites and screens will look like.

When you are planning your games, try and put together a game design document like we discussed in this chapter, as it will be a useful blueprint of the game you intend to build that you can refer to during game development.

Try and think about the content that you want to add, even if you don't know how it will look yet. You can even draw stick men figures to represent the sprites if you haven't made the final decision of which sprites you will use.

In the next chapter, we will start to build out the game, starting with drawing and animating sprites.

Questions
Why is making a synopsis a good idea for your game?
How much health will George lose when an enemy attacks him?
How many points does George gain for collecting a gold coin?
What is water used for on the game map?



> [ 03 C2 Working with the Flame Engine ](/packtpub/javascript_from_frontend_to_backend/03_c2_working_with_the_flame_engine) <---> [ 05 P2 Graphics and Sound ](/packtpub/javascript_from_frontend_to_backend/05_p2_graphics_and_sound)
>
> Title: 04 C3 Building a Game Design
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/04_c3_building_a_game_design
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 04_c3_building_a_game_design.md

