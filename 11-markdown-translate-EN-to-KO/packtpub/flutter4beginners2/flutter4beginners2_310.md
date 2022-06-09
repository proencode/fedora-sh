원본 제목: Chapter 10: Using Widget Manipulations and Animations
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/310
Title:
310 Using Widget Manipulations and Animations
Short Description:
Flutter for Beginners Second Edition 위젯 조작 및 애니메이션 사용

![Figure 10.5 - Using animation to move a button ](/flutter4beginners2_img/figure_10.5_-_using_animation_to_move_a_button.jpg)
- cut line


# Chapter 10: Using Widget Manipulations and Animations
Flutter for Beginners Second Edition

The built-in widgets and those available via plugins will allow you to create a great-looking app, but Flutter allows you to manipulate these widgets with layout transformations, such as opacity, rotations, and decorations, allowing you to further improve the user experience (UX) of your app. In this chapter, you will learn how to add these transformations to widgets.

Taking this widget manipulation a step further, Flutter has great support for animations that can be combined and extended to bring the user interface (UI) to life. You will learn about animations, including the use of Tween animations to manage an animation timeline and curve and using AnimatedBuilder to add and combine beautiful animations.

Finally, we will look at some widgets that have animation built directly into them, allowing you to skip the added complication of animation setup and management. They don't fit every situation, but when just a touch of animation is required, they can be perfect.

The following topics will be covered in this chapter:

- Transforming widgets with the Transform class
- Introducing animations
- Using animations
- Using AnimatedBuilder
- Implicitly animated widgets

# Technical requirements

You will need your development environment again for this chapter as we will explore animations for the Hello World project. Look back at Chapter 1, An Introduction to Flutter, if you need to set up your integrated development environment (IDE) or refresh your knowledge of the development environment requirements.

You can find the source code for this chapter on GitHub at https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/lib/chapter_10.

# Transforming widgets with the Transform class

We have looked at lots of widgets throughout the previous chapters, but sometimes we may need to change a widget's appearance to improve the UX. In response to user input or to make cool effects in the layout, we may need to move the widget around the screen, change its size, or even distort it a little bit.

If you've ever tried to achieve this in native programming languages, you may have found it difficult. Flutter, as mentioned previously, is highly focused on UI design and aims to make the developer's life easier by simplifying what could easily have been a complicated area.

In this section, we will first look at the Transform widget because it is an incredibly useful widget when you look at widget manipulation. We will then delve deeper into the widget to see the kinds of manipulations it allows us to do.

## The Transform widget

The Transform widget is one of the best examples of the Flutter framework's power and consistency. It's a single-purpose widget that simply applies a graphic transformation to its child, and nothing more. Having widgets focused on one single purpose is fundamental to a better layout structure, and Flutter does this very well.

The Transform widget, as its name suggests, does a single task—it transforms its underlying child. Although its task is very complex, it hides most of this complexity from the developer. Let's have a look at its constructor, as follows:

```
const Transform({
  Key,
  required Matrix4 transform,
  Offset origin, AlignmentGeometry alignment,
  bool transformHitTests: true,
  Widget child
})
```

As you can see, besides the typical key property, this widget does not need many arguments to do its job. Let's see these arguments, as follows:

- transform: This is the only required property and is used to describe the transformation that will be applied to the child widget. The type is a Matrix4 instance, a four-dimensional (4D) matrix that describes the transformation in a mathematical way. We will look in more detail at this in the next section, Understanding the Matrix4 class.
- origin: This is the origin of the coordinate system at which to apply the transform matrix. The origin property is specified by the Offset type, representing, in this case, a point (x,y) in the Cartesian system that is relative to the upper-left corner of the render widget.
- alignment: As with origin, it can be used to manipulate the position of the applied transform matrix. We can use this to specify origin in a more flexible way, as origin requires us to use real positional values. Nothing prevents you from using both origin and alignment at the same time.
- transformHitTests: This specifies whether hit tests (that is, taps) are evaluated in the transformed version of the widget.
- child: This is the child widget to which the transformation will be applied.

The Matrix4 transform is critical to the Transform class, so let's look at that in more detail.

## Understanding the Matrix4 class

In Flutter, transformations are represented by a 4D matrix. Although it sounds very intimidating, a 4D matrix is simply a matrix that has four rows and four columns, as shown here:

![Figure 10.1 - 4D identity matrix ](/flutter4beginners2_img/figure_10.1_-_4d_identity_matrix.jpg)

The value of the matrix shown is the identity matrix. This is a special value because it effectively says to make no changes in the transformation. As the values in the matrix are changed, then the widget is transformed in different ways.

Often, we don't need to know the specific values of the matrix to make a transformation. Besides methods such as matrix addition or multiplication, the Matrix4 class contains methods that help with the construction and manipulation of geometric transformations. Some of them are listed here:

- Rotation: rotateX(), rotateY(), and rotateZ() are some examples of methods that rotate the matrix through a specific axis.
- Scale: scale(), with some variants, is used to apply a scale on the matrix using double values of the corresponding axes (x, y, and z) or through vector representations with the Vector3 and Vector4 classes.
- Translation: Just as before, we can translate the matrix using the translate() method with specific x, y, or z values and Vector3 and Vector4 instances.
- Skew: This is used to skew the matrix around the x axis with skewX() or y axis with skewY().

Let's see how we can use the Matrix4 class to enact different types of transformations.

## Exploring the types of transformations

The Transform class provides facilities to the developer through its factory constructors. There are many of them for each of the possible transformations, making it extremely easy to apply a transformation to a widget without any deeper knowledge of geometric calculations. They are listed here:

- Transform.rotate(): Constructs a Transform widget that rotates its child around its center.
- Transform.scale(): Constructs a Transform widget that scales its child uniformly.
- Transform.translate(): Constructs a Transform widget that translates its child by an x,y offset.

Let's look at each of the transformation types in more detail.

### Rotate transformation

The rotate transformation appears in situations where we want to simply make our widget rotate. By using the Transform.rotate() constructor, we can get a rotated widget. It does not differ too much from the default Transform constructor. The differences are listed here:

- Absence of the transform property: We are using the rotate() variant because we want to apply a rotation, so we do not need to specify the whole matrix for this. We simply use the angle property instead.
- Angle: This specifies the desired rotation in clockwise radians.
- Origin: By default, the rotation is applied relative to the center of the child. However, we can use the origin property to manipulate the origin of the rotation, as if we were translating the center of the widget by the origin offset, causing the rotation to be relative to another point if we want to.

We can use something like this:

```
Transform.rotate(
  angle: -45 * (math.pi / 180.0),
  child: ElevatedButton(
    child: Text("Rotated button"),
    onPressed: () {},
  ),
);
```

In this example, we have specified the angle in radians (315° clockwise is the same as -45° anti-clockwise), and the child widget that will be rotated—in this case, an ElevatedButton widget.

The exact same result is achieved using the Transform widget's default constructor and a Matrix4 transformation instead, as illustrated in the following code snippet:

```
Transform(
  transform: Matrix4.rotationZ(-45 * (pi / 180.0)),
  alignment: Alignment.center,
  child: ElevatedButton (
    child: Text("Rotated button"),
    onPressed: () {},
  ),
);
```

The arguments that we need to provide in order to get the same result are a transform property with the rotation through the z axis, and an alignment property of the transformation specifying the center of the child widget.

### Scale transformation

The scale transformation appears in situations where we want to simply cause our widget to change its size, either by increasing or decreasing its scale. Just as with the rotate() factory constructor, this variant does not differ too much from the default one. Here are some further details regarding this:

- Absence of the transform property: Here, again, we use the scale property instead of the whole transformation matrix.
- Scale: This is what we use to specify the desired scale in double format, 1.0 being the widget's original size. It represents the scalar to be applied to each x and y axis.
- Alignment: By default, the scale is applied relative to the center of the child. Here, we can use the alignment property to change the origin of the scale. Again, we can combine the alignment and origin properties to get the desired result.

For example, to scale up a widget, we can run the following code:

```
Transform.scale(
  scale: 2.0,
  child: ElevatedButton(
  child: Text("scaled up"),
    onPressed: () {},
  ),
);
```

Here, we have specified a scale property of 2.0, which doubles the size of the child widget, and again specified that the child widget is ElevatedButton. Obviously, you could just set the size of ElevatedButton to avoid having a transformation.

And to get the same result using the default Transform constructor, we use the following code:

```
Transform(
  transform: Matrix4.identity()..scale(2.0, 2.0),
  alignment: Alignment.center,
  child: ElevatedButton(
    child: Text("scaled up"),
    onPressed: () {},
  ),
);
```

In a very similar way to the rotation, we must specify both the origin of the transformation with the alignment property and the Matrix4 instance describing the scale transformation.

### Translate transformation

The translate transformation is likely to appear in animations, as described later in the chapter in the Using animations section.

Here, we have even fewer properties compared to previous transformations. The differences are listed as follows:

- The absence of the transform and alignment properties: The transformation will be applied by the offset value, so we do not need the transform matrix.
- Offset: This time, offset simply specifies the translation to be applied on the child widget; this is different from the previous transformations, where it affects the origin point of the applied transformation.

By using the Transform.translate() constructor, we move the widget around the screen, by adding a Transform widget as a parent of the widget we want to move around, as illustrated in the following code snippet:

```
Transform.translate(
  offset: Offset(100, 300),
  child: ElevatedButton(
    child: Text("translated to bottom"),
    onPressed: () {},
  ),
);
```

The default constructor can also be used with Matrix4 specifying the translation, as follows:

```
Transform(
  transform: Matrix4.translationValues(100, 300, 0),
  child: ElevatedButton(
    child: Text("translated to bottom"),
    onPressed: () {},
  ),
);
```

We only need to specify the transform property with the Matrix4 instance describing the translation.

### Composed transformations

We can—and most probably will—combine a number of the previously seen transformations to achieve unique effects, such as rotating at the same time as we move and scale a widget.

Composing transformations can be done in two ways, as follows:

- Using the default Transform widget constructor and generating our desired transformation using the Matrix4-provided methods to compose it.
- Using multiple Transform widgets in a nested way with the rotate(), scale(), and translate() factory constructors, achieving the same effect.

For clarity, let's look at how we would nest multiple Transform widgets, as follows:

```
Transform.translate(
  offset: Offset(70, 200),
  child: Transform.rotate(
    angle: -45 * (math.pi / 180.0),
    child: Transform.scale(
      scale: 2.0,
      child: ElevatedButton(
        child: Text("multiple transformations"),
        onPressed: () {},
      ),
    ),
  ),
);
```

As you can see, we add a Transform widget as a child to another Transform widget, composing the transformation. Although simpler to read, this method has a drawback: we add more widgets than needed to the widget tree.

When we add multiple transformations to a widget at the same time, we have to pay attention to the order of transformations. Experiment by yourself: exchanging the Transform widgets' positions will cause different results.

As an alternative, we can use the default Transform constructor with the composed transformation with the Matrix4 object instead, as follows:

```
Transform(
  alignment: Alignment.center,
  transform: Matrix4.translationValues(70, 200, 0)
    ..rotateZ(-45 * (math.pi / 180.0))
    ..scale(2.0, 2.0),
  child: ElevatedButton(
    child: Text("multiple transformations"),
    onPressed: () {},
  ),
);
```

Just as before, we specify the alignment of the transformation as the center of the child widget and then the Matrix4 instance to describe it. As you can see, it is very similar to the multiple Transform widgets version but without nested widgets, causing a deeper widget tree.

Now we have explored how to manipulate widgets in a static way, let's look at making an animation to allow a widget to move from one state to another in a smooth way.

# Introducing animations

In Flutter, animations are widely supported, and the framework provides multiple ways of animating widgets. Additionally, there are built-in ready-to-use animations that we only need to plug into widgets to make them animate. Though Flutter abstracts many of the complexities that animations involve, there are some important concepts we need to understand before diving into the subject of animations.

## The Animation<T> class

In Flutter, animations consist of a status and a value of type T, where the T type is defined on the creation of the Animation classes. The animation status corresponds to the animation state (that is, whether it's running or completed); its value changes while the animation runs, and it is this value that is intended to drive any widget changes during the animation execution.

Besides holding the information about the animation, this class also exposes callbacks, so other classes can know the animation's current status and value.

An Animation<T> class instance is only responsible for holding and exposing the status and value properties. It does not know anything about visual feedback, what is drawn on screen, or how to draw it (that is, the build() functions).

One of the most common kinds of animation you will see is the Animation<double> type representation, as a double value can easily be used to manipulate any kind of value in a sense of proportional space.

The Animation class generates a sequence (not necessarily linear) of values between determined minimum and maximum values. This process is also known as interpolation and is not only linear—it can be defined as a step function or a curve. Flutter provides multiple functions and facilities for operating animations. These are listed as follows:

- AnimationController: Despite what its name suggests, it is not used to control the animation objects. Instead, it inherits from Animation<T> and allows control over the generation of animation values.
- CurvedAnimation: This is an animation that applies a curve to another animation. There is a whole range of built-in curves available that will manipulate the animation values generated to fit different needs.
- Tween: This helps to create a linear interpolation between a beginning and ending value.

The Animation class exposes ways of accessing its state and value during a running cycle. Through status listeners, we can know when an animation begins, ends, or goes in the reverse direction. By using its addStatusListener() method, we can, for example, manipulate our widgets in response to animation start or end events. In the same way, we can add value listeners with the addListener() method, so we are notified every time the animation value changes, and we can rebuild our widgets by using the setState method.

## AnimationController

AnimationController is one of the most used Flutter animation classes. It is derived from the Animation<double> class and adds some fundamental methods for manipulating animations. The Animation class is the basis of animation in Flutter; as mentioned in the previous section, it does not have any animation control-related methods. AnimationController adds these controls to the animation concept, such as the following:

- Play and stop controls: AnimationController adds the ability to play an animation forward or backward or to stop it.
- Duration: Real animations have a finite time to play—that is, they play for a while and finish, or repeat.
- Allows setting of the animation's current value: This causes the animation to stop and notifies the status and value listeners.
- Allows definition of the upper and lower bound of the animation: This is done so that we can know the deemed values before and after playing the animation.

Let's check the AnimationController constructor and analyze its main properties, as follows:

```
AnimationController({
  Double? value,
  Duration? duration,
  String? debugLabel,
  double lowerBound: 0.0,
  double upperBound: 1.0,
  AnimationBehavior animationBehaviour:
    AnimationBehavior.normal,
  required TickerProvider vsync, 
})
```

As you can see, some properties are self-explanatory, but let's review them, as follows:

- value: This is the initial value of the animation, and it defaults to lowerBound if not specified.
- duration: This is the duration of the animation.
- debugLabel: This is a string to help during debugging. It identifies the controller in debug output.
- lowerBound: This cannot be null, so it will default to 0.0 if not supplied. It is the smallest value of the animation in which it is deemed to be dismissed—typically, the start value when running.
- upperBound: Also, this cannot be null, so it will default to 1.0 if not supplied. It is the largest value of the animation at which it is deemed to be complete—typically, the end value when running.
- animationBehavior: This configures how AnimationController behaves when animations are disabled, possibly due to accessibility requirements. If it's value is set to AnimationBehavior.normal, the animation duration will be reduced to match the request to disable animations. If it's set to AnimationBehavior.preserve, AnimationController, it will preserve its behavior, perhaps because the functionality of the app will be impacted by disabling the animation.
- vsync: This is a TickerProvider instance that the controller will use to obtain a signal whenever a frame triggers.

You may be wondering what TickerProvider is, so let's take a deeper look at that concept.

### TickerProvider and Ticker

The TickerProvider interface describes objects capable of providing Ticker objects.

Tickers are used by any class that needs to know when the next frame is going to be built. They are commonly used indirectly via AnimationController instances. When using the State class, we can extend it with TickerProviderStateMixin or SingleTickerProviderStateMixin to have TickerProvider and use it with AnimationController objects.

## CurvedAnimation

The CurvedAnimation class is used to define the progression of an Animation class as a non-linear curve. We can use this to modify an existing animation by changing its interpolation method. It is also useful when we want to use a different curve when playing an animation forward in reverse mode, by using its curve and reverseCurve properties respectively.

The Curves class defines many curves ready to use in our animation rather than the Curves.linear one. Let's look at some of the options as listed on the Flutter documentation web pages, as follows:

![Figure 10.2 - Flutter Curves documentation ](/flutter4beginners2_img/figure_10.2_-_flutter_curves_documentation.jpg)

Check out the Curves documentation page to see, in detail, how each of the curves behaves: https://api.flutter.dev/flutter/animation/Curves-class.html.

## Tween

Besides all of these classes, we have one that can help in specific tasks regarding the range of the animation. As we have seen, by default, the simple start and end values of animation are 0.0 and 1.0 respectively. We can, by using a Tween class, change the range or type of AnimationController without modifying it. Tween classes can be of any type, and we can also create our custom Tween class if we want. The point is, a Tween class returns values at periods between the beginning and the end, which you can pass as props to whatever you're animating, so it's always getting updated. For example, we can change the size of a widget, position, opacity, color, and so on by using specific Tween classes for each one.

We also have other Tween descendant classes such as the CurveTween class available so that we can modify an animation curve, or ColorTween, which creates interpolation between colors.

Now you have a base knowledge of animations, let's actually see them in action in the next section.

# Using animations

When working with animations, we are not going to always be creating exactly the same animation objects, but we can find some similarities in use cases. Tween objects are useful for changing the type and range of an animation. We will, most of the time, be composing animations with AnimationController, CurvedAnimation, and Tween instances.

Before we use a custom Tween implementation, let's revisit our widget transformations from the earlier Transforming widgets with the Transform class section by applying the transformation in an animated way. We will get the same final effect but in a smooth and dynamic way.

## Rotate animation

Instead of changing the button rotation directly, we can instead make it progressive by using the AnimationController class. An example of this kind of animation is shown in the following screenshot:

![Figure 10.3 - Using animation to rotate a button ](/flutter4beginners2_img/figure_10.3_-_using_animation_to_rotate_a_button.jpg)

In the following example, we are creating our widget in a very similar way to the earlier Rotate transformation section:

```
_rotationAnimationButton() {
  return Transform.rotate(
    angle: _angle,
    child: ElevatedButton(
      child: Text("Rotated button"),
      onPressed: () {
        if (_animation.status == AnimationStatus.completed) {
          _animation.reset();
          _animation.forward();
        }
      },
    ),
  );
}
```

As you can see, there are two important things to notice, as follows:

- The angle value is now defined with an _angle property instead of directly assigning a literal.
- In the onPressed property, we check whether _animation is completed, and if it is, we restart it from the beginning.

Now, let's see how the animation part is done. We need to know how to create our AnimationController object and make it run. Let's take a look at our example class first, as follows:

```
class _RotationAnimationsState extends
    State<RotationAnimations> with
    SingleTickerProviderStateMixin {
  double _angle = 0.0;
  AnimationController? _animation;
  ...
}
```

A few things are important to notice in this class, as follows:

- We have created a StatefulWidget object called RotationAnimations, to make use of the SingleTickerProviderStateMixin class and provide the required Ticker object for our controller to run.
- Besides that, we have the _angle property, used to define our button's current angle. We can use the setState() method to cause it to be built with a new angle.
- And finally, we have our _animation object, to hold an animation and allow us to manage it.

The initState() function from our State class is the perfect place to set up the animation and start it. This function is illustrated in the following code snippet:

```
@override
void initState() {
  super.initState();
  _animation = createRotationAnimation();
  _animation.forward();
}
```

As you can see, we define our animation through the createRotationAnimation() method and make it run by calling its forward() function. Now, let's see how the animation is defined, as follows:

```
createRotationAnimation() {
  var animation = AnimationController(
    vsync: this,
    debugLabel: "animations demo",
    duration: Duration(seconds: 3),
  );
  animation.addListener(() {
    setState(() {
      _angle = (animation.value * 360.0) * (pi / 180);
    });
  });
  return animation;
}
```

We can break up the creation of the animation into two important parts, as follows:

- There's the animation definition itself, where we set the animation debugLabel property for debugging purposes; the vsync property, so that it can have Ticker and know when to produce a new animation value; and finally, the animation duration.
- A second important step is to listen for the animation value changes. Here, whenever the animation has a new value, we get it, multiply it by 360°, and then convert it to radians so that we get a proportional rotation value.

As you can see, we can generate our desired values based on double animation values, so, most of the time, Animation<double> will be enough to play with animations.

If we wanted to, we could add a different curve to the animation by using CurveTween, for example, as you can see in the createBounceInRotationAnimation() method shown here:

```
createBounceInRotationAnimation() {
  var controller = AnimationController(
    vsync: this,
    debugLabel: "animations demo",
    duration: Duration(seconds: 3),
  );
  var animation = controller.drive(
    CurveTween(
      curve: Curves.bounceIn,
    )
  );
  animation.addListener(() {
    setState(() {
      _angle = (animation.value * 360.0) * _toRadians;
    });
  });
  return controller;
}
```

Here, we create another animation instance by using the controller's drive() method and passing the desired curve with a CurveTween object. Notice that we have added listeners to the new animation object instead of the controller, as we want values relative to the curve.

An important point to notice is that we have to dispose of our AnimationController class instance at the end of the lifetime of our State class to prevent memory leaks, as illustrated in the following code snippet:

```
@override
void dispose() {
  _animation.dispose();
  super.dispose();
}
```

This must be done for every kind of animation we do, as we will always be working with AnimationController.

Now, let's see how to create scale animations.

## Scale animation

To create a scale animation and have a more fluid UI than changing the scale attribute directly, we again can use the AnimationController class to achieve a result similar to this:

![Figure 10.4 - Using animation to scale a button ](/flutter4beginners2_img/figure_10.4_-_using_animation_to_scale_a_button.jpg)

This time, to build our ElevatedButton widget with a scale, we define a Transform widget with the well-known Transform.scale constructor, as follows:

```
_scaleAnimationButton() {
  return Transform.scale(
    scale: _scale,
    child: ElevatedButton(
      child: Text("Scaled button"),
      onPressed: () {
        if (_animation.status == AnimationStatus.completed) {
          _animation.reverse();
        } else if (_animation.status == 
        AnimationStatus.dismissed) {
          _animation.forward();
        }
      },
    ),
  );
}
```

Notice that we now use a _scale property and take a look at the change in the onPressed method. Here, we play the animation in reverse mode by using the reverse() function of AnimationController if it is completed, and play forward if it is at its initial state (that is, after reversing it).

The creation of an animation object occurs in a very similar way to rotation animation, but there are slight modifications to the controller construction, as illustrated in the following code snippet:

```
createScaleAnimation() {
  var animation = AnimationController(
    vsync: this,
    lowerBound: 1.0,
    upperBound: 2.0,
    debugLabel: "animations demo",
    duration: Duration(seconds: 2),
  );
  animation.addListener(() {
    setState(() {
      _scale = animation.value;
    });
  });
  return animation;
}
```

As you can see, we now change the controller's lowerBound and upperBound values to make more sense in our case, as we want the button to grow until its size is twice as big, and we do not want it to be smaller than its initial size (scale = 1.0). Besides that, we change our animation value listener just to get the value from the animation without any calculations.

## Translate animation

Just as we have done with the rotate and scale animations, we can accomplish a better look in our translation transformation and make it smoother by using AnimationController, as illustrated in the following screenshot:

![Figure 10.5 - Using animation to move a button ](/flutter4beginners2_img/figure_10.5_-_using_animation_to_move_a_button.jpg)

The construction of our widget is similar to the rotate and scale animations; the only exception is the usage of the Transform.translate() construction. Now, we have a different value type than double. Let's see what we need to change to make an Offset animation. Here's the code you'll need:

```
createTranslateAnimation() {
  var controller = AnimationController(
    vsync: this,
    debugLabel: "animations demo",
    duration: Duration(seconds: 2),
  );
  var animation = controller.drive(
    Tween<Offset>(
      begin: Offset.zero,
      end: Offset(70, 200),
    ),
  );
  animation.addListener(() {
    setState(() {
      _offset = animation.value;
    });
  });
  return controller;
}
```

As you can see, here, we used a different approach to modify our Offset widget. We used a Tween<Offset> instance and passed it down to the AnimationController object through the drive() method, just like we did with CurveTween before. This works because the Offset class overrides mathematical operators such as subtraction and addition. The code is illustrated in the following snippet:

```
// part of geometry.dart file from dart:ui package
class Offset extends OffsetBase {
  ...
  Offset operator -(Offset other) => new Offset(dx - 
  other.dx, dy - other.dy);
  Offset operator +(Offset other) => new Offset(dx + 
  other.dx, dy + other.dy);
  ...
}
```

This makes the calculation of intermediate offsets (animation values) possible, and then the interpolation between two Offset values can be achieved.

Now we have explored animations, let's look at how we can use the AnimatedBuilder class to improve the quality of our code.

# Using AnimatedBuilder

Looking at the code that we wrote in the last section, there is nothing wrong with it— it's neither too complex nor too big. However, looking closely, we can see a small problem with it—our button animation is mixed up with other widgets. As long as our code does not scale and get more complex, this is fine, but we know this is not the case most of the time, so we might have a real problem.

The AnimatedBuilder class can help us with the task of separating responsibilities. Our widget, whether it is ElevatedButton or anything else, does not need to know it is rendered in animation, and breaking down the build method to widgets that each have a single responsibility can be seen as one of the fundamental concepts in the Flutter framework. Let's look at the AnimatedBuilder class and then revisit our animation with our new knowledge.

## The AnimatedBuilder class

The AnimatedBuilder widget exists so that we can build complex widgets that wish to include animation as part of a larger build function. Just as with any other widget, it is included in the widget tree and has a child property. Let's check its constructor, as follows:

```
const AnimatedBuilder({
  Key,
  required Listenable animation,
  required TransitionBuilder builder,
  Widget child
})
```

As you can see, we have a few important properties here, besides the well-known key property. Let's have a look at these in more detail, as follows:

- animation: This is the proper animation as a Listenable object. Listenable is a type that holds a list of listeners and notifies them whenever the object changes. As you may already be thinking, AnimatedBuilder will listen for animation updates, so we do not need to do it manually with the addListener() method anymore.
- builder: This is where we modify the child widget based on the animation values.
- child: This is the widget that exists regardless of the animation object. So, we construct this widget as we would do without animation.

## Revisiting our animation

To break down our code, modify our animation, and make it more maintainable, we start separating what we need for each responsibility. Typically, the following three things are needed:

- The animation itself: Here, we do not need to change anything. Our AnimationController class will still be the same.
- Adding the AnimatedBuilder widget to our build() method: We will be extracting much of the code related to the animation of the button to make it clearer.
- The child widget: In our case, it is just ElevatedButton that changes according to the progress of the animation.

Now, let's update the translation animation code we created in the Rotate animation section to use the AnimatedBuilder concept. The first section that changes is the _createTranslateAnimation method, as illustrated in the following code snippet:

```
createBounceInRotationAnimation() {
  _controller = AnimationController(
    vsync: this,
    debugLabel: "animations demo",
    duration: Duration(seconds: 3),
  );
  _animation =_controller.drive(CurveTween(
    curve: Curves.bounceIn,
  ));
}
```

This method now creates a controller and animation but does not define a setState action. This is no longer the responsibility of the surrounding widget.

We still need the dispose method to clear up the animation when the parent widget is disposed, as illustrated in the following code snippet:

```
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
```

There is no change here, but it is worth noting that disposal is still required.

We still trigger the creation of an animation and its controller from the initState property and store the variables in two fields of our widget, as follows:

```
class _RotationAnimationsState extends State<RotationAnimations> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    super.initState();
    createBounceInRotationAnimation();
  }
```

Again, this is very similar to the previous examples. The key change occurs in the build method, as illustrated in the following code snippet:

```
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      child: ElevatedButton(
        child: Text("Rotated button"),
        onPressed: () {
          print("Rotating");
          print("${_animation.status}");
          if (_animation.isCompleted || 
          _animation.isDismissed) {
            _controller.reset();
            _controller.forward();
          }
        },
      ),
      builder: (context, child) {
        print("Building");
        return Transform.rotate(
          angle: _animation.value * 2.0 * pi,
          child: child,
        );
      },
    );
  }
```

As mentioned previously, the setState property is no longer in the parent widget—the AnimatedBuilder class takes care of that and constrains the redraw to just the children of the AnimatedBuilder class.

Two key things to notice in the code are outlined here:

- The _animation variable is now passed to the AnimatedBuilder class so that the setState property can be triggered within the widget's scope.
- The child widget is defined within the child parameter of the AnimatedBuilder class and the same child is returned as an argument to the builder method, allowing you to manipulate the same widget in both the child and builder methods.

Now, the redraw on the setState property is more efficient because potentially far fewer widgets are being re-evaluated on an animation update.

Now you've looked at the fundamentals of animation, let's briefly look at some widgets that hide all the complexity away and give you an easy way to set up animations that fit many situations.

# Implicitly animated widgets

Flutter has a whole set of widgets that have animation built directly into them. This is great, but these animated widgets also mirror lots of widgets we have already seen, allowing a very easy drop replacement in your widget tree to get some great animations.

These widgets work by animating any changes to their internal state. For example, if a widget has been drawn to the screen in one color, and then a setState property changes the widget's color, then the change in color is animated rather than a single frame color switch. Let's first take a look at the AnimatedContainer widget, and then we will explore the other implicitly animated widgets available.

## AnimatedContainer

The first widget to look at, and probably the most powerful, is the AnimatedContainer widget. This is very similar to the Container widget we first saw in Chapter 5, Widgets – Building Layouts in Flutter, but adds some key properties that allow it to animate changes.

Suppose in our widget tree we have an entry like this:

```
Container(
  width: _winner ? 50 : 400,
  child: Image.asset('assets/trophy.png'),
),
```

As you can imagine, if the _winner variable is initially set to false and then a setState call changes it to true, the trophy image will suddenly jump from 50px wide to 400px wide.

This would potentially be quite jarring to a user, and would not look like the action of a high-quality app. To solve this, adding an animation would make this image enlargement look much more professional.

We could animate the size change, as we saw in the previous Scale animation section, where we could use a controller, curved animation, and tween. However, this time, let's use AnimatedContainer to do the same thing, as follows:

```
AnimatedContainer(
  width: _winner ? 50 : 400,
  child: Image.asset('assets/trophy.png'),
  duration: Duration(seconds: 2),
),
```

Firstly, you'll see how similar the creation and constructor parameters are. The notable difference is the duration parameter. This parameter denotes how long any animations should take.

Now, when the setState property is called and _winner is changed from false to true, the trophy image will grow smoothly from 50px to 400px in width value over the course of 2 seconds. All interpolation (transitioning between the old and new width values) will be done by the widget itself.

However, it gets even better, because the AnimatedContainer widget can also take a curve parameter, allowing us to change the animation from a simple linear growth in width value to something much more interesting such as a bounceOut curve, which feels like the trophy image is dropping onto the screen and bouncing until it settles.

Once we add the curve to the code, it now looks like this:

```
AnimatedContainer(
  width: _winner ? 50 : 400,
  child: Image.asset('assets/trophy.png'),
  duration: Duration(seconds: 2),
  curve: Curves.bounceOut,
),
```

Adding the curve parameter allows you to set the animation curve to any of the curves supported by Flutter.

## AnimatedFoo

The implicitly animated widgets that come with Flutter are often referred to as AnimatedFoo, where Foo is the name of the non-animated version of the widget.

There are a vast number of them, but some key ones to use are listed here:

- AnimatedAlign: Animates changes in alignment, such as changing alignment of the widget from one position on the screen (for example, topRight) to another part of the screen (for example, bottomLeft).
- AnimatedOpacity: Animates the opacity of the widget. Great for fading in or out a child widget.
- AnimatedPadding: Animates how a widget sits within a parent widget.
- AnimatedPositioned: Can only be used within a stack, and allows a widget to be moved around and for the size of the widget to change.
- AnimatedSize: Animates the change in the size of a widget.

These widgets can be great fun to play around with, so try plugging some of them into the HelloWorld app and see how you can animate them. They are also a great way to prototype any designs that require animations. Ultimately, you may need to use more complex animation management, but you will at least be able to see whether a design will work without investing lots of time in its development.

# Summary

In this chapter, we got to know how to change our widgets' look by using the Transform class and its available transformations, such as scaling, translating, and rotating. We also saw how we can compound transformations by using the Matrix4 class directly.

We learned the fundamental concepts of animation and how to apply them to child widgets to make changes smooth and dynamic.

We saw the important AnimationController, CurvedAnimation, and Tween framework classes. We also revisited our Transformation examples and added animations to them by using the concepts learned in this chapter. Finally, we saw how to create our own custom Tween objects, and we looked at how to clean up our code through the use of the AnimatedBuilder widget.

Lastly, we saw the AnimatedFoo classes that have animation embedded inside them, allowing you to develop slick animations without complicated code.

In the next chapter, we will look at the app as a whole, complete program and at how we can test and debug it in preparation for user trials and finally release it to the world!

