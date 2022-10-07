
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

> [ 07 C5 Moving the Graphics with Input ](/packtpub/javascript_from_frontend_to_backend/07_c5_moving_the_graphics_with_input) <---> [ 09 C7 Designing Your Own Levels ](/packtpub/javascript_from_frontend_to_backend/09_c7_designing_your_own_levels)

# Chapter 6: Playing Sound Effects and Music

In this chapter, we will bring our game to life by adding sound effects and music that will enhance the game. Audio is a very important part of any game; it can alert you to key events happening in a game or create atmosphere. Imagine walking through a forest in a game and hearing a nearby river or the birds singing in the trees. It makes the whole game more immersive if the sound matches what you would expect to hear if you were in that forest.

It is important though that if the player puts the game in the background to, for example, check their email, that we stop the music or sound from playing, and that the sound resumes when they return to the game, otherwise the ongoing sound could be annoying for the player. To handle this, we will cover how to listen for these life cycle events so that we ensure the audio is paused and resumed correctly.

Audio also takes up memory and we will discuss how Flame uses an audio cache to help load and keep these audio resources so we can play them whenever we need them in a game. Often, sound effects are played multiple times, so we need to be able to access these easily and play them repeatedly when needed.

So, in this chapter, we will cover the following topics:

Playing background music
Playing sound effects
Controlling the volume
Technical requirements
To examine the source from this chapter, you can download it from https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter06.

You can find additional information on Flame audio in the online documentation at https://docs.flame-engine.org/1.0.0/audio.html.

To get started playing sounds and music in our game, we must download the asset files and add them to our pubspec.yaml file. We can find all the sound files we want to add at the excellent free website https://freesound.org.

The sound effects and music we want to add are the following:

Background music playing throughout the game
A sound effect for when an enemy dies
A sound effect when George moves around
Here are some I found while browsing the site, but feel free to browse the site and find other sounds you may prefer:

Background music – https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter06/assets/audio/music/music.mp3
George movement – https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter06/assets/audio/sounds/running.wav
Enemy dying – https://github.com/PacktPublishing/Building-Games-with-Flutter/blob/main/chapter06/assets/audio/sounds/enemy_dies.wav
In the following steps, we will download some sounds to use in our game:

Download the music and sound effects mentioned or find some of your own on the website.
Rename the music file to be called music.mp3, George's movement sound to be called running.wav, and the enemy dying sound to be called enemy_dies.wav.
Open the assets folder and create a new folder called audio.
In the audio folder, create a folder called music and a folder called sounds.
In the music folder, add the music.mp3 file.
In the sounds folder, add the enemy_dies.wav and running.wav files.
Next, open the pubspec.yaml file and add the following assets below the existing assets that we have for the sprite images:
- assets/audio/music/music.mp3
- assets/audio/sounds/enemy_dies.wav
- assets/audio/sounds/running.wav

Copy
Under the line where we added the Flame library, we will add a line for the Flame audio library, so your dependencies should now look like this:
flame: 1.0.0
flame_audio: ^1.0.0

Copy
Save this file, and pub get will update to validate the new assets and download the Flame audio library.
Now that we have the audio files set up as assets, let's add them to the game.

Playing background music
In this section, we will add the music playback, which will load at the start of the game and continue playing while we play the game. The Flame audio library has a static class called Bgm (background music) that adds music to the audio cache and will pause and resume the music when the app is backgrounded or brought back to the front. We get this functionality built into the Bgm class, so it requires very little code to get the music loaded and playing. As you will see in the next section regarding the playing of sound effects, we must do a bit more work to ensure sound effects pause and resume when backgrounded. Unfortunately, this is how it currently works in the Flame library at this time, but hopefully, this will be improved in future versions of the library.

To add the music playback to the code, do the following:

Open the main.dart file and import the Flame audio library:
import 'package:flame_audio/flame_audio.dart';

Copy
At the top of the onLoad function, add the following code to initialize the library, load the music into the audio cache, and play the background music:
FlameAudio.bgm.initialize();
await FlameAudio.bgm.load('music/music.mp3');
await FlameAudio.bgm.play('music/music.mp3');

Copy
In the MyGame class, below the onLoad function, add the following code, which stops playing the music and clears in the audio cache when the game closes:
@override
void onRemove() {
  FlameAudio.bgm.stop();
  FlameAudio.bgm.clearAll();
  super.onRemove();
}

Copy
If you run the game now, you will hear our music playing. If you background the app on mobile, you will notice the music stops playing and will resume if you bring the game back to the foreground. If you close the game completely, by killing the app, you will notice the music also stops.

It is important to do these steps on the onRemove function so that we avoid memory leaks. In the next section, we will add sound effects to the game when we move George and when an enemy dies.

Playing sound effects
As mentioned in the previous section, when playing sound effects, we need to handle the pausing and resuming of the sound effects if they are still playing when the app is put in the background, for instance, to check something else on your phone, as this is not currently handled by the library.

We will initially update our Character class, which is our top-level base class for all our sprites, to add onPaused and onResumed callbacks, which all our sprites can use.

We will then listen for life cycle change events in our game and if these are called, we will iterate over all our sprites and pass on these events.

And finally, as the sound effects are related to George, we will update the George class to play sounds and pause and resume these sound effects when needed. Let's get started:

Open up the character.dart file. At the bottom of the Character class, add the following function definitions:
void onPaused() {}
void onResumed() {}

Copy
Note that we will leave these functions empty as we will override these in the George class.

Open the main.dart file, and below the onRemove function that we recently added, add the following code to listen and handle life cycle events:
@override
void lifecycleStateChange(AppLifecycleState state) {
  switch(state) {
    case AppLifecycleState.paused:
      children.forEach((component) { 
        if (component is Character) {
          component.onPaused();
        }
      });
      break;
    case AppLifecycleState.resumed:
      children.forEach((component) { 
        if (component is Character) {
          component.onResumed();
        }
      });
      break;
    case AppLifecycleState.inactive:
    case AppLifecycleState.detached:
      break;
  }
}

Copy
In the lifecycleStateChange function that we override, we are passing an AppLifecycleState event, which can be either a paused, resumed, inactive, or detached event. As we only care about the paused and resumed states, these are the only events we handle in this function.

Flame keeps track of all the children components we have added to the game in a variable called children, which is a set of data we can iterate over. Don't forget that HudComponent and ScreenCollidable are also components that will be in this dataset, so we must check when we iterate over the data that the class is of the Character type and ignore the other component types.

We can then safely pass on the pause and resume event via our onPaused and onResumed callbacks as we know these are available to any classes that use Character as a base class, such as our enemy sprites or George sprite.

Add the following import for the Character class:
Import 'package:goldrush/components/character.dart';

Copy
Open the george.dart file and add the following imports:
import 'package:flame_audio/flame_audio.dart';
import 'package:audioplayers/audioplayers.dart';

Copy
The two sound effects we will play are when an enemy collides with George and when George walks or runs, controlled by the joystick or touch. If you have played the sounds that we downloaded, you will notice the enemy dying sound effect is short and the running sound effect is much longer. The challenge is that if George keeps moving longer than the sound effect lasts, we need to keep the sound playing by looping the sound.
Also, as mentioned earlier, if the game is put in the background, we need to pause the sound and then resume it from the same point if the user returns to the game. Because of this, we need to store a reference to AudioPlayer returned when playing the long-looped audio returned from the running sound effect, meaning  we have control over its playback.

Let's create a couple of variables at the top of the George class that we have opened for tracking whether a user is moving and for accessing the audio player state:

bool isMoving = false;
late AudioPlayer audioPlayerRunning;

Copy
At the bottom of the onLoad function, let's load the sound effects into the audio cache:
await FlameAudio.audioCache.loadAll(
  ['sounds/enemy_dies.wav', 'sounds/running.wav']);

Copy
We use await on this line to wait until all the sound effect files are loaded into the cache.

At the bottom of the onCollision function after the code block that checks whether the other is a zombie or skeleton and sets the score, add the following code to play the enemy dies sound effect when we collide with an enemy:
FlameAudio.play('sounds/enemy_dies.wav');

Copy
At the bottom of the George class, let's add the two functions for pausing and resuming AudioPlayer when the app is put in the background:
@override
void onPaused() {
  if (isMoving) {
    audioPlayerRunning.pause();
  }
}
@override
void onResumed() async {
  if (isMoving) {
    audioPlayerRunning.resume();
  }
}

Copy
In the update function, we have a few changes to make to play the long looping audio and to control it. In the code block at the top of the update function, where we are already checking whether the joystick has moved, let's add the following code where we set playing = true;, so it looks like this:
playing = true;
movingToTouchedLocation = false;
if (!isMoving) {
  isMoving = true;
  audioPlayerRunning = await 
    FlameAudio.loopLongAudio('sounds/running.wav');
}

Copy
As we are waiting for the long-looped audio, we need to change the function signature to be asynchronous. Do this with the following change:
@override
void update(double dt) async {

Copy
In the else block, in the code block where we check whether movingToTouchedLocation is true, we will add the same code that we added for the joystick check, to start the audio playing and set the flag for isMoving to true:
} else {
  if (movingToTouchedLocation) {
    if (!isMoving) {
      isMoving = true;
      audioPlayerRunning = await
       FlameAudio.loopLongAudio('sounds/running.wav');
    }

Copy
Because we added the code in both locations, the running sound will start playing irrespective of whether the player controls George with either the joystick or by touch.

Further down this update function, where we called stopAnimations and set movingToTouchedLocation to false and return, let's stop the audio and set isMoving to false:
stopAnimations();
audioPlayerRunning.stop();          
isMoving = false;
movingToTouchedLocation = false;

Copy
This code is within the code block where we check the threshold value and decide whether George is near enough to the touched location to stop him from moving.

At the bottom of the update function in the final else block, we will add the same isMoving check we added for the touched location check. This will stop the running sound effect when the user stops moving the joystick, so we have both the joystick and touch covered.
The else block at the bottom of the function should now look like this:

} else {
  if (playing) {
    stopAnimations();
  }
  if (isMoving) {
    isMoving = false;
    audioPlayerRunning.stop();
  }
}

Copy
In this section, we added sound effects for George running and colliding with an enemy. We also added the correct handling for stopping the long-looped running sound when George stops moving or when the game is moved to the background.

If you run the game now, you will hear the background music playing but the sound effects may be difficult to hear at the same time because of the music playing too. This is because both the sound effects and music have the same default volume, making it difficult to hear them both clearly.

In the next section, we will adjust the volume of the sound effects and music to fix this issue and make it easier to hear the sound effects.

Controlling the volume
Fixing the volume of the music and sound effects is very easy and only requires a few small changes. Let's take a look:

Open the main.dart file. In the onLoad function, where we added the call to play the background music, change this line to pass the volume parameter:
await FlameAudio.bgm.play('music/music.mp3',
  volume: 0.1);

Copy
Here we set the music volume to 0.1, keeping it low so we can hear the sound effects better. The volume parameter can be any value between 0.0 and 1.0 (0.0 mutes the sound of the music or sound effect completely, whereas 1.0 plays the sound at full volume).

Open the george.dart file and let's update the calls to play each sound effect to use the volume parameter. In the onCollision function, update the enemy dying sound effect like this:
FlameAudio.play('sounds/enemy_dies.wav', volume: 1.0);

Copy
In the update function, change the two calls to play the running sound effect, and add the volume parameter in both places:
audioPlayerRunning = await FlameAudio.loopLongAudio(
  'sounds/running.wav', volume: 1.0);

Copy
If you run the game now, you will be able to hear the sound effects over the music.

Summary
In this chapter, we introduced music and sound effects to make the game better. We handled the playback and paused the sound when the app is in the background, and resumed it when the player returns to the game, by handling the life cycle events.

In the next chapter, we will go beyond the limits of the physical screen and learn how to make game levels that use maps that we can scroll around as we move around the map.

Questions
Which library do we use to add audio to our games?
Why is it beneficial to load the audio into the audio cache?
Why do we need to clear the audio buffer after the components are removed from the game?
Which life cycle change states do we need to handle when the game is backgrounded?
What class do we use to keep a reference to a longer sound effect?
How do we change the default volume for music or sound effects?



> [ 07 C5 Moving the Graphics with Input ](/packtpub/javascript_from_frontend_to_backend/07_c5_moving_the_graphics_with_input) <---> [ 09 C7 Designing Your Own Levels ](/packtpub/javascript_from_frontend_to_backend/09_c7_designing_your_own_levels)
>
> Title: 08 C6 Playing Sound Effects and Music
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/08_c6_playing_sound_effects_and_music
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 08_c6_playing_sound_effects_and_music.md

