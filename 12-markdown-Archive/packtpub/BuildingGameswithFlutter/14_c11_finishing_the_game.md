
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

> [ 13 C10 Making Intelligent Enemies with AI ](/packtpub/javascript_from_frontend_to_backend/13_c10_making_intelligent_enemies_with_ai) <---> [ 15 Other Books You May Enjoy ](/packtpub/javascript_from_frontend_to_backend/15_other_books_you_may_enjoy)

# Chapter 11: Finishing the Game

The game is looking great and is nearly complete, but we want to tie up some loose ends in this chapter to finish it off. At the moment, we only have the main game screen; however, games often have many screens in them, such as a menu screen or settings screen.

In this chapter, we will add a few more screens and show you how to navigate between them. We will create these screens with standard Flutter widgets and show you how you can mix Flutter and Flame together. Specifically, in our settings screen, we will add an option for controlling the music volume and persist the user's music volume preference, and then use this when playing the game.

After wrapping up the game code, we will discuss a few other things to consider when developing a game, such as how to make money from it, what else is worth learning as you continue to learn more about game development, and where to get help when you get stuck developing your games.

We will cover the following topics in this chapter:

Wrapping up the game
Monetizing your game
What else should I learn?
Where to get help?
Technical requirements
To examine the source from this chapter, you can download it from https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter11.

In this chapter, we will save the user's preference for the music volume, so let's add the library for persisting this value in our game:

Open the pubspec.yaml file and add the following dependency:
shared_preferences: ^2.0.15

Copy
Save the file and allow pub get to download this dependency and validate the assets:
flutter pub get

Copy
In the next section, we will discuss the final code we need to add to the game to wrap things up, including the game screens and navigation.

Wrapping up the game
In this section, we will add three new screens and navigate between these screens.

These screens are as follows:

Menu screen: The first screen the player will see, with options to play the game, view the settings, or exit the game.
Settings screen: The settings allow us to change the music volume via a Slider widget or go back to the menu screen.
Game over screen: We will show this screen when the player's health is 0 and allow them to go back to the menu screen to play again.
These three screens will use standard Flutter widgets; we will use Flutter navigation routes to navigate between them and our game widget to play the game.

Let's get started by adding each of these screens.

Adding a menu screen
In this section, we will add a menu screen to help us navigate between each of the game's screens by following these steps:

In the project's lib directory, create a new folder called widgets to hold our new widget screens.
Create three new files in the widgets folder called screen_menu.dart, screen_settings.dart, and screen_gameover.dart.
Open the screen_menu.dart file and add the following code:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: 
            CrossAxisAlignment.center,
          children: [
            getGameTitle(),
            getGameMenu(context)
          ]
        )
      ),
    );
  }
  Widget getGameTitle() {}
  Widget getGameMenu(BuildContext context) {}
}

Copy
Here, we add a class called MenuScreen, which is StatelessWidget, and set up the basic structure for the layout, where we will have a title at the top and a few menu items that we can click on in the menu.

Let's expand the getGameTitle function to return a Text widget for the title:
Widget getGameTitle() {
  return Text('Gold Rush', style: TextStyle(color: 
    Colors.yellow, fontSize: 64.0));
}

Copy
Next, we will expand the getGameMenu function to add menu options for Play Game, Settings, and Exit Game; they will be Text widgets wrapped in GestureDetector widgets so that they are clickable.
For the first two options, we will use navigator routes to move to the new screens, and we will use a SystemNavigator function to exit the game:

Widget getGameMenu(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(40.0),
    child: Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context,
              "/game", (r) => false);
        }, 
        child: Text('Play Game', style: TextStyle(
          color: Colors.blue, fontSize: 32.0))),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(context,
              "/settings", (r) => false);
        }, 
        child: Text('Settings', style: TextStyle(
          color: Colors.blue, fontSize: 32.0))),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () { SystemNavigator.pop(); }, 
        child: Text('Exit Game', style: TextStyle(
          color: Colors.red, fontSize: 32.0))),
      ),
    ]),
  );
}

Copy
Here, we have a simple widget that draws the menu, which is a simple column of menu items in the middle, with a title at the top and an exit option below the menu items. Clicking on these options tells the navigator to change to a different page.

Here, you can see how the menu screen should look:

Figure 11.1 – The game menu screen, allowing you to play the game or view the settings
Figure 11.1 – The game menu screen, allowing you to play the game or view the settings

Next, let's continue for now with the settings screen.

Adding a settings screen
In this section, we will add a settings screen to allow us to choose the volume of the background music by following these steps:

Open the screen_settings.dart file and add the code from here: https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter11/lib/widgets/screen_settings.dart.
In this code block, we will set up StatefulWidget this time, as we want to keep track of the music volume value and persist this for using the SharedPreferences library we added earlier in the Technical requirements section.

We store the current music volume in a variable called musicVolume. In the initState function, we try and read this value from the shared preferences and set it to 25% as a default if this has not been previously set.

Let's continue and build the UI for the settings screen by completing the empty functions.

Here is the code for the getSettingsTitle function:
Widget getSettingsTitle() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
    child: Text('Settings', style: TextStyle(color:
      Colors.yellow, fontSize: 64.0)),
  );
}

Copy
Here, we return a Text widget for our title, which is styled in yellow and has a font size of 64.

The following is the code for the getMusicVolumeLabel function:
Widget getMusicVolumeLabel() {
  return Text('Music Volume', style: TextStyle(color:
    Colors.blue, fontSize: 32.0));
}

Copy
Here, we return a Text widget for our volume label, which is styled in blue and has a font size of 32.

The following is the code for the getVolumeSlider function:

Widget getVolumeSlider() {
  return SizedBox(
    width: 250.0,
    child: Slider(
      value: musicVolume, 
      min: 0.0,
      max: 100.0,
      label: '${musicVolume.round()}',
      divisions: 4,
      onChanged: (double newMusicVolume) {
        SharedPreferences.getInstance().then((prefs) 
          => prefs.setDouble('musicVolume', 
            newMusicVolume));
        setState(() => musicVolume = newMusicVolume);
    }),
  );
}

Copy
Here, we return a Slider widget wrapped around a fixed SizedBox widget that has values for the music volume between 0 and 100. Whenever the slider value is changed, we set the musicVolume value in the widget and save this to the shared preferences.

The following is the code for the getBackLabel function:
Widget getBackLabel() {
  return GestureDetector(
    onTap: () { Navigator.pushNamedAndRemoveUntil(
      context, "/", (r) => false); }, 
    child: Text('Back', style: TextStyle(color: 
      Colors.red, fontSize: 32.0))
  );}

Copy
Here, we return a Text label to go back to the main menu and use Navigator to return the player to the top-level route if this is clicked.

The following screenshot shows our settings screen along with a slider to set the music volume:

Figure 11.2 – The Settings screen with the adjustable music volume
Figure 11.2 – The Settings screen with the adjustable music volume

Now that the settings screen is complete, let's work on our final screen, which is the game over screen.

Adding a game over screen
In this section, we will add a game over screen to let the user know the game has ended. To do this, open the screen_gameover.dart file and add the code from here: https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter11/lib/widgets/screen_gameover.dart.

In this code block, we show a simple screen to indicate that the game is over and a link to go back to the menu, where the user can play again, change the settings, or quit the game.

Here is the game over screen that is shown when George dies:

Figure 11.3 – The game over screen when George dies
Figure 11.3 – The game over screen when George dies

Now that we have our three extra screens, let's tie these together with navigation routes and music volume.

Compiling all screens with navigation routes and music volume
In this section, we will tie all the navigation together and also adjust the music volume, based on the settings menu choice. To do this, we will follow these steps:

Open the main.dart file and import the screens and shared preference library:
import 
  'package:goldrush/widgets/screen_gameover.dart';
import 'package:goldrush/widgets/screen_menu.dart';
import
  'package:goldrush/widgets/screen_settings.dart';
import 
 'package:shared_preferences/shared_preferences.dart';

Copy
Let's rewrite the main function to use routes. Replace the existing main function with the following:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gold Rush',
      initialRoute: '/',
      routes: {
        '/': (context) => MenuScreen(),
        '/settings': (context) => SettingsScreen(),
        '/gameover': (context) => GameOverScreen(),
        '/game': (context) => GameWidget(game:
          GoldRush()),
      },
    ),
  );
}

Copy
Here, we set the screen up as full-screen landscape as we did before in Chapter 7, Designing Your Own Levels, but now we have four navigation routes defaulting, with the initial route pointing to the menu screen.

In the onLoad function of the GoldRush class, let's read the musicVolume value from shared preferences and set up the playback of the music with this value. Note that if the player has not gone into the settings and changed this value, the volume will default to 25%.
Returning to where the background audio is initialized, add the following code:

var musicVolume;
await SharedPreferences.getInstance()
  .then((prefs) => prefs.getDouble('musicVolume') ?? 
    25.0)
  .then((savedMusicVolume) => musicVolume = 
    savedMusicVolume);

Copy
Next, change the line that starts playing the music to the following:
await FlameAudio.bgm.play('music/music.mp3', volume:
  (musicVolume / 100));

Copy
During the testing of the navigation, a bug was found where the enemies and coins were invisible when playing the game for the first time. This is due to the z-order priority being incorrect, which makes the map draw on top of the sprites. So, let's fix that now by setting the priority higher.
In the same onLoad function, change the initialization of the Skeleton, like this:

var skeleton = Skeleton(player: george, position:
  Vector2(position.x + gameScreenBounds.left,
    position.y + gameScreenBounds.top), size: 
      Vector2(32.0, 64.0), speed: 20.0);
children.changePriority(skeleton, 15);
add(skeleton);

Copy
Next, update the Zombie initialization, like this:
var zombie = Zombie(player: george, position: 
  Vector2(position.x + gameScreenBounds.left, 
    position.y + gameScreenBounds.top), size: 
      Vector2(32.0, 64.0), speed: 20.0);
children.changePriority(zombie, 15);
add(zombie);

Copy
And finally, for the sprites, update the Coin initialization, like this:
var coin = Coin(position: Vector2(posCoinX, posCoinY),
  size: Vector2(20, 20));
children.changePriority(coin, 15);
add(coin);

Copy
Now that we are done updating the navigation and music playback, let's fix one last thing.
When George's health gets to 0, we want to trigger the navigation to show the game over screen. Open the george.dart file and, in the onCollision function, change the health check code block to the following:

if (health > 0) {
  health -= 25;
  hud.healthText.setHealth(health);
} 
if (health == 0) {
  Navigator.pushNamedAndRemoveUntil(gameRef.buildContext
  !, "/gameover", (r) => false);
}

Copy
This will replace the previous else clause, where we had a to-do action to show the game over screen.

We have now the complete code for the game! If you run the game now, you can see the simple screens and navigate around them, and you can adjust the music volume from off to full volume.

When you have built your own game, it would be great to sell the game, and who knows – you may make the next successful blockbuster game, such as Angry Birds, and become very rich! In the next section, we will discuss exactly that – how to make money from your game.

Monetizing your game
Once you have developed your own game, you may want to try to make some money from the game. There are a few ways to do this, depending on the platforms you wish to support. But in this section, we will focus on the three most common ways so that you can decide what is best for you, as there are pros and cons to each way.

The three main ways to monetize your game are as follows:

Adverts
In-app purchases
Purchase
In the following subsections, we will discuss each of these options.

Adverts
There are many advert providers, and each provides its own libraries for Flutter. The recommended one for mobile is Google's own Mobile Ads SDK, which Google provides an official library for. This is easy to integrate, and you will make money by showing adverts to the players within your game.

Be aware that overuse of adverts will annoy players, so please try and think of the experience the user will get while playing the game to try and balance this out.

Let's look at the pros and cons of using adverts in your game:

Pros:
a. Easy to integrate.

b. Repeat income from a constant revenue stream.

Cons:
a. Can be annoying for users.

b. Money paid for adverts is quite low.

Now, let's look at another monetization option, in-app purchases.

In-app purchases
In-app purchases can be a great way to make money from your game. Generally, with this type of game, you give it away free and then take small micropayments in the game, which work through Google Play or Apple's App Store.

You are purchasing virtual goods that only exist in that game. For instance, in our game, you can purchase extra lives or a better weapon to use in exchange for real money.

Be aware that some existing games that use in-app purchases have a reputation for paying to win, where the user that is willing to pay to buy the best items in the game can win the game easily. This is controversial, especially in multiplayer games where you can buy success in the game.

From our view as developers, virtual goods provide an interesting way to monetize our games. This is because the game assets are virtual, and they can be sold many times to different players and provide a reliable, repeatable revenue stream.

Let's look at the pros and cons of using in-app purchases in your game:

Pros:
a. You can sell the same virtual goods to many different users.

Cons:
a. It can be fiddly to set up in the mobile developer portals.

b. It can be irritating to users if overused.

Now that we have discussed the pros and cons of in-app purchases, let's look at our final option, purchase.

Purchase
One-time purchases are also another valid option for monetizing your app. You can set a fixed price for your game that the users pay once.

Be aware that players tend to want to see updated content in the game, such as new levels. So, if you only make money from a fixed price, you will be maintaining the game for free, aside from any new sales you may make by updating the content.

Let's look at the pros and cons of using purchases in your game.

Pros:
a. It's hassle free, and you only have to set the price once.

Cons:
a. There's no repeat income from existing customers.

If you want to further read up on ways to monetize your game, please check out https://flutter.dev/monetization, which goes into more detail.

In this section, we discussed ways of monetizing your game. In the next section, we will discuss what else is worth learning to expand your game development knowledge.

What else should I learn?
Now you have mastered the basics of game development with Flame, let's look at what else you can learn that are more advanced topics but are very useful in expanding your game development knowledge.

Forge2d
A lot of games use advanced physics to make the games more realistic, such as using gravity to affect how sprites jump and fall or calculating the trajectory of a falling bird in Angry Birds.

There is a very good physics engine available called Forge2d, which is based on the famous Box2d engine, which is worth investigating if you want to make your games more realistic.

You can find everything you need to get started at https://docs.flame-engine.org/1.0.0/forge2d.html.

Nakama
Single-player games can be a lot of fun, but games go to a whole new level when you play them with your friends. Multiplayer game development is a very complex subject to do from scratch, but it is a useful subject to learn and can improve your games a lot. Fortunately, Flutter has a good library that handles all the complex stuff needed to build multiplayer games, which works well with Flame.

The library is called Nakama, which is discussed at https://heroiclabs.com/docs/nakama/getting-started/, and the Flutter library for this is at https://github.com/obrunsmann/flutter_nakama.

Nakama has many features. Here are a few of the things it can do:

Multiplayer gaming between different players
Real-time chat between players
Leaderboards for tracking who has the highest score
User accounts with logins
Nakama covers many more multiplayer features than we cover here, so it is recommended that you check out their website (https://heroiclabs.com/docs/nakama/getting-started/) for more information.

Rive
Rive is a cross-platform animation tool that allows you to export an animation and play it back, using libraries specific to each platform. If you are familiar with the old Flash animations, this is similar.

You can read more about Rive at https://rive.app/. The Flame library for Rive can be found at https://pub.dev/packages/flame_rive.

What games shall I make?
Flame is suitable for all types of 2D games, so you can make whatever game you like. The difficulty is that some types of games are more complicated to code than others.

If you plan on making role-playing games, which are very popular, be aware that these are very complicated games to make, as they often simulate real-world mechanics and require you to build a lot of content for the game.

Start simple with games such as tic-tac-toe and build up to games such as Sokoban or Breakout, before moving on to platform games such as Mario.

There is a great article at https://gamefromscratch.com/just-starting-out-what-games-should-i-make/ to give you some more ideas about what games to make and in what order you should make them.

In the next section, we will discuss where to get help when you get stuck with Flutter/Flame.

Where to get help?
There will be times when you are making your game that you will get stuck. You may not know how to implement something or there might be a bug with the Flame library or Flutter SDK, for instance.

Here, I have compiled a list of great resources where you can seek help if you get stuck:

Flame Discord (https://discord.gg/5unKpdQD78): Here, you can ask the Flame development team questions and get excellent advice on how to use Flame.
We especially want to thank Spydon, Erick, and Wolfen on the Flame Discord server for all the help they gave while I worked on the book.

Stack Overflow: The same people who monitor Flame Discord monitor Stack Overflow, where you can also post questions. Be sure to tag your questions with the #flame tag.
Flame documentation: The Flame documentation can be found at https://pub.dev/documentation/flame/latest/, and you can find many examples and tutorials for Flame at https://github.com/flame-engine/flame/tree/main/examples and https://github.com/flame-engine/awesome-flame#articles--tutorials.
Flutter community page: For more general Flutter help, please check out the Flutter community page at https://flutter.dev/community, where you can find links to the Flutter Discord and Slack channels.
In this section, we discussed where to get help when you get stuck with Flame or Flutter.

Summary
In this chapter, we learned how to mix our game widget with other Flutter widgets and navigate between screens to complete our game. We also gave the player the option to change the music volume on the settings screen.

We discussed options for monetizing your game and what to learn next to improve your game development knowledge. Finally, we reviewed where to get help if you get stuck with your game.

We have covered a lot in the book, and you now have the knowledge to build a variety of 2D games with Flutter and Flame. Good luck with your game development journey. I look forward to seeing the games that you create.

Questions
What library should we use to persist simple data such as the music volume?
What options are there for monetizing your game?
Which Flutter class is used to change screens?
What is the main benefit of monetizing your game with in-app purchases?



> [ 13 C10 Making Intelligent Enemies with AI ](/packtpub/javascript_from_frontend_to_backend/13_c10_making_intelligent_enemies_with_ai) <---> [ 15 Other Books You May Enjoy ](/packtpub/javascript_from_frontend_to_backend/15_other_books_you_may_enjoy)
>
> Title: 14 C11 Finishing the Game
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/14_c11_finishing_the_game
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 14_c11_finishing_the_game.md

