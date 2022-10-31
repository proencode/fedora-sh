
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

> [ 11 P3 Advanced Games Programming ](/packtpub/javascript_from_frontend_to_backend/11_p3_advanced_games_programming) <---> [ 13 C10 Making Intelligent Enemies with AI ](/packtpub/javascript_from_frontend_to_backend/13_c10_making_intelligent_enemies_with_ai)

# Chapter 9: Implementing Advanced Graphics Effects

So far in the book, we have used graphics for animating sprite components and drawing tile maps, but there is a lot more that we can do to improve the visual aspect of the game.

In this chapter, we are going to discuss how to use particles and shadows to improve our game. We will use particle effects to make the coins and enemies explode when they are collided with and we will use layers to add a shadow effect to our sprites. These are simple yet efficient ways to improve our game visuals that run very quickly and don't affect the frame rate too much, so they are worth using to improve our game.

We will cover the following topics in this chapter:

What are particle effects?
Animating with particles
Creating shadows with layers
Technical requirements
To examine the source from this chapter, you can download it from https://github.com/PacktPublishing/Building-Games-with-Flutter/tree/main/chapter09.

What are particle effects?
Particle effects are an easy way to create dynamic effects such as fire, smoke, explosions, and magical effects for our games. Particles have various properties that can be changed, which include the following:

How long a particle lives
How often a new particle is created
The position where the particle is created
The angle, distance, and speed of travel
What colors the particles should be
How physics affects the particles
A good example of a particle effect is fireworks. Fireworks explode in a variety of colors and travel at different speeds and angles as they vanish into nothing in the sky after a short time.

Flame supports many types of particle effects, which you can see examples of at https://examples.flame-engine.org/#/Rendering_Particles. These are discussed in more detail in the Flame documentation at https://docs.flame-engine.org/1.0.0/particles.html, but let's summarize some of the different types of particles here for your reference:

MovingParticle – Moves the child particle between two points during its lifetime
AcceleratedParticle – Applies basic physics-based effects to the particle, such as gravity or speed dampening
CircleParticle – Draws circles in different sizes
SpriteParticle – Uses sprite images in your particle
ComputedParticle – For more advanced control of the particle, which may need computed values to affect the particle
In our game, we want to make the coins explode outward while fading out the alpha value. We will make these particles yellow to match the coin color. For our enemies, we will reuse the exploding effect but instead make the particles red to look like blood.

We will use ComputedParticle from the previous list of different types of particles, as we want to split the exploding particles into 12 pieces. Each of these pieces will be moving outward from the center at increasing 30-degree angles, which we will calculate with basic trigonometry. The particle will be generated and calculated from these values, and the opacity will be adjusted as it fades out based on the particle's progress.

Remember, particles have a lifespan that we can set. So, we will fade out the particle when it gets nearer to the end of its lifespan.

The actual drawing will be a simple circle with the position, angle, and opacity calculated.

Let's get started with the code for the particles in the next section.

Animating with particles
In this section, we will show you how to create great particle effects and animate them. First, we will create a new file for storing our effects in the utils folder, which we can use from anywhere:

In the utils folder, create a new file called effects.dart and open the file.
Add the following code for creating the exploding particle:
Particle explodingParticle(Vector2 origin, 
  MaterialColor color) {
  double distanceToMove = 15.0;
  return Particle.generate(
    lifespan: 0.8,
    count: 12,
    generator: (i) {
      double angle = i * 30;
      double xx = 
        origin.x  + (distanceToMove * cos(angle));
      double yy = 
        origin.x  + (distanceToMove * sin(angle));
      Vector2 destination = Vector2(xx, yy);
      return ComputedParticle(renderer: (Canvas 
        canvas, Particle particle) {
        Paint paint = Paint()..color = 
          color.withOpacity(1.0 - particle.progress);
        canvas.drawCircle(Offset.zero, 1.5, paint);
      }).moving(from: origin, to: destination);
    }
  );
}

Copy
Here, we have the explodingParticle function, which returns ComputedParticle. The function takes an origin position for where the particle effect should start along with a color that we should use for the particle.

We want the particle to move a short distance of 15.0, which we use to calculate its destination position based on the angle of travel from the origin. The final destination where the particle will travel to over its lifespan is calculated using trigonometry.

We generate 12 particles at 30-degree angles, which is 12 * 30 = 360 degrees, to cover all directions outward. The lifespan is set to just under a second at 0.8, so the explosion happens rapidly and fades away.

Finally, this is wrapped with MovingParticle, which moves the particle between the origin and the destination over its lifespan.

After the lifespan time has expired, the particle is removed from the game, so we don't need to manually monitor this as Flame does this for us by removing expiring particles from the game.

At the top of the effects.dart file, add the following imports for the particle effects:
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/material.dart';
import 'dart:math';

Copy
Let's continue by creating the particle effects in the George class when our player collides with a coin or an enemy.

Open the george.dart file and add the following imports:
import 'package:goldrush/utils/effects.dart';
import 'package:goldrush/main.dart';
import 'package:flutter/material.dart';

Copy
In the George class definition, we need to get a reference to the GoldRush class. This is needed so that when we create the particle, we base the origin position based on the world coordinates. So, let's update that code:
class George extends Character with KeyboardHandler, HasGameRef<GoldRush> {

Copy
In the onCollision function, let's add the particle to the game via the gameRef reference we just added in the previous code block, where we check whether the collision is with Zombie or Skeleton:
if (other is Zombie || other is Skeleton) {
gameRef.add(ParticleComponent(explodingParticle(other.position, Colors.red)));

Copy
Next, let's do the same where we check whether we have collided with a Coin object:
if (other is Coin) {
gameRef.add(ParticleComponent(explodingParticle(other.position, Colors.yellow)));

Copy
If you run the game now, you will see the coins explode into yellow particles when we collide with them, and the enemies explode into red particles when we collide with them.

Now that we have some nice-looking particle effects in the game, let's move on to adding some shadows using layers in the next section.

Creating shadows with layers
Layers are a feature of Flame that allow us to group things we want to draw together or draw a prerendered graphic that doesn't change much. In your game, you may have a background that you draw once from a combination of sprites or images, but then it is used as a static image that you use as a background and draw the other moving sprites on top.

It would be inefficient to keep creating this background if it isn't changing. So, you can create it once and store it as a layer, which you can draw before you render the other game graphics.

In Flame, there are two types of layers:

PreRenderedLayer – For static images
DynamicLayer – For things that are moving
PreRenderedLayer would be suitable for backgrounds due to its static nature.

You may also want to change something in the layer and regenerate the layer, and then cache the resulting image in the layer. For example, you may want to create a weather effect in the game where the raindrops are updated and redrawn on the layer, and then this layer is drawn on top of your game world to give the impression it is raining or snowing. For this type of effect, DynamicLayer would be more suitable.

Flame also provides something called layer processors, which allow us to add effects to the entire layer. Currently, the only supported layer processor is called ShadowProcessor, which applies a shadow to the entire layer. It is possible to make your own processors though by extending the LayerProcessor class if you want to create other processors.

We can use ShadowProcessor in combination with our sprites to create a shadow behind each sprite to make them really stand out in the game. This is done by drawing our sprites into a layer after applying the shadow processor.

Let's get started by creating our layer class:

Open the effects.dart file and below the explodingParticle function we added earlier in Step 2 of the Animating with particles section, add the following class definition for our layer:
class ShadowLayer extends DynamicLayer {
  final Function renderFunction;
  ShadowLayer(this.renderFunction) {
    preProcessors.add(ShadowProcessor(color:
      Colors.black, offset: const Offset(4, 4)));
  }
  @override
  void drawLayer() {
    renderFunction(canvas);
  }
}

Copy
Here, we create a class called ShadowLayer, which is a DynamicLayer. In the constructor, we add the shadow processor to the list of preprocessors so that the shadow effect gets applied before drawing the sprites. Note that this is a list of preprocessors, so if you do create your own, you can add multiple effects to your layers. Also, there is a postprocessors list available too, which adds effects after your sprites are drawn if you need it.

We set the shadow to be black and drawn at an offset 4, 4 pixels away from where the sprite is drawn to give the effect of a shadow behind the sprite.

In the constructor, we pass a function reference that is then used when we call drawLayer(). We do this because we want to hold a reference to the super class render function, so that we delegate the drawing to the layer. So, our sprites will draw onto the layer where they will have their shadow applied, and then we call on the super class to draw the layer to the game, based on whatever animation frame we are currently rendering.

Because of this, when we render our sprites in the render function, we will render into ShadowLayer and not make a call to the super class there, or we will be drawing twice, which is inefficient and not needed.

Now, at the top of the file, let's add an import for the layer package:
import 'package:flame/layers.dart';

Copy
Next, let's set up the Coin class first and add a shadow to all our coins, so we can see how this delegated rendering works in practice.

Open the coin.dart file and add the following import at the top of the file:
import 'package:goldrush/utils/effects.dart';

Copy
In the Coin class, add a variable to store ShadowLayer below where we store originalPosition:
  late Vector2 originalPosition;
  late ShadowLayer shadowLayer;

Copy
Add the following import for ShadowLayer:
import 'package:goldrush/utils/effects.dart';

Copy
At the bottom of the onLoad function, add the following line to initialize the shadow layer:
shadowLayer = ShadowLayer(super.render);

Copy
Here, we can see we are passing the function reference to the super class render function.

At the bottom of the Coin class, add the following override for the render function, which delegates the drawing to shadowLayer:
@override
void render(Canvas canvas) {
  shadowLayer.render(canvas);
}

Copy
If you run the game now, you will see our shadow effect behind all the coins in the game.

Figure 9.1 – Shadow effects on the sprites
Figure 9.1 – Shadow effects on the sprites

Let's continue and apply the same effect to our enemy sprites and our player sprite, George.

We will add this to the Character class, which is the base class for George and our enemies, to reduce duplicate code.

Open the character.dart file and add the following import for the layer package:
import 'package:goldrush/utils/effects.dart';

Copy
In the Character class, add a variable to store ShadowLayer below where we store originalPosition:
  late Vector2 originalPosition;
  late ShadowLayer shadowLayer;

Copy
Add the following onLoad function to the Character class to initialize the shadow layer:
@override
Future<void> onLoad() async {
  super.onLoad();
  shadowLayer = ShadowLayer(super.render);
}

Copy
Finally, add the render function to the Character class to delegate the drawing to shadowLayer:
@override
void render(Canvas canvas) {
  shadowLayer.render(canvas);
}

Copy
Note that you may see a message about calling the render function of the super class, but we want to avoid this as it will be called from within our shadow layer, so it is omitted here.

If you run the game now, you will see that our player and enemies now have lovely shadow effects behind them, which really makes them stand out nicely against the background!

Summary
In this chapter, we learned how to apply advanced graphical effects to our game to make the game look much better. We added particle effects to make the coins and enemies explode when collided with and added some nice shadow effects behind our player, enemies, and coins.

In the next chapter, we are going to discuss how to make our player and enemies appear more intelligent by adding game Artificial Intelligence (AI) to them.

We will change the behavior of the enemies – instead of us attacking them, they will attack us! The enemies will chase George when he gets too near to them and will still explode when they hit us, but we will add a health value to George that will decrease if we collide with an exploding enemy. Also, the enemies will only chase if they are facing and can see George and are within a certain distance.

Plus, we will add some further obstacles to our game and show you how to use pathfinding to make sure George walks around obstacles in our game world when moving, by touching the screen.

Questions
What are some properties that are common to particle effects?
Why do particles need to be removed from the game by setting a lifespan?
What are some examples of particles that Flame supports?
What are the different types of layers that Flame supports?
Why do we need to delegate the rendering of the super class to the layer class?



> [ 11 P3 Advanced Games Programming ](/packtpub/javascript_from_frontend_to_backend/11_p3_advanced_games_programming) <---> [ 13 C10 Making Intelligent Enemies with AI ](/packtpub/javascript_from_frontend_to_backend/13_c10_making_intelligent_enemies_with_ai)
>
> Title: 12 C9 Implementing Advanced Graphics Effects
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/12_c9_implementing_advanced_graphics_effects
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 12_c9_implementing_advanced_graphics_effects.md

