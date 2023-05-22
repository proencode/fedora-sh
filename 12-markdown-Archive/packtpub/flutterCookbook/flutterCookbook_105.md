원본 제목: 5 Mastering Layout and Taming the Widget Tree
원본 링크: https://subscription.packtpub.com/book/mobile/9781838823382/4
Path:
packtpub/flutterCookbook/105
Title:
105 Mastering Layout and Taming the Widget Tree
Short Description:
Flutter Cookbook 레이아웃 마스터하기 및 위젯 트리 길들이기

![Figure5.17-whats happening is that the app ](/flutter_cookbook_img/figure5.17-whats_happening_is_that_the_app.webp)
---------- cut line ----------


# Mastering Layout and Taming the Widget Tree

A tree data structure is a favorite of computer engineers (especially in job interviews!) Trees elegantly describe hierarchies with a parent-child relationship. You can find user interfaces (UIs) expressed as trees everywhere. HyperText Markup Language (HTML) and the Document Object Model (DOM) are trees. UIViews and their subviews are trees. The Android Extensible Markup Language (XML) layout is a tree. While developers are subconsciously aware of this data structure, it's not nearly as present in the foreground as it is with Flutter. If you do not live and breathe trees, at some point you will get lost among the leaves.

This is why managing your widget trees becomes more important as your app grows. You could, in theory, create one single widget that is tens of thousands of layers deep, but maintaining that code would be a nightmare! 

This chapter will cover various techniques that you can use to bring the widget tree to heel. We will explore layout techniques with columns and rows, as well as refactoring strategies that will be critical to keeping your widget tree pruned.

In this chapter, we will be covering the following recipes:

- Placing widgets one after another
- Proportional spacing with the Flexible and Expanded widgets
- Drawing shapes with CustomPaint
- Nesting complex widget trees
- Refactoring widget trees to improve legibility
- Applying global themes

# Placing widgets one after another

Writing layout code, especially when we are dealing with devices of all sorts of shapes and sizes, can get complicated. 

Thankfully Flutter makes writing layout code simple. As Flutter is a relatively young framework, it has the advantage of learning from previous layout solutions that have been used on the web, desktop, iOS, and Android. Armed with the knowledge of the past, the Flutter engineers were able to create a layout engine that is flexible, responsive, and simple to use.

In this recipe, we're going to create a prototype for a profile screen for dogs.

# Getting ready

Create a new Flutter project with your favorite editor or integrated development environment (IDE). 

You're going to need a picture for the profile image. You can choose any image you want, but you can also download this image of a dog from Unsplash: https://unsplash.com/photos/k1LNP6dnyAE. 

Rename the file as dog.jpg and add it to the assets folder (create assets in the root folder of your project).

We will also reuse the beach picture that we used in the previous chapter: you can download this at https://unsplash.com/photos/nXOB-wh4Oyc. Rename it as beach.jpg. 

Don't forget to add the assets folder to your pubspec.yaml file:
```
assets:
 - assets/
```

You are also going to need a new file for this page. Create a profile_screen.dart file in the lib folder.

Don't forget to have the app running while inputting this code to take advantage of hot reload.

# How to do it...

You are now going to use a Column widget and then a Stack widget to place elements on the screen:

1. In the profile_screen.dart file, import the material.dart library.
2. Type stless to create a new stateless widget, and call it  ProfileScreen:
```
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

3. In the main.dart  file, remove the MyHomePage class, and use the new ProfileScreen class as the home of MyApp: 
```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}
```

4. In the profile_screen.dart file, add this shell code. This won't do anything yet, but it gives us three places to add the elements for this screen:
```
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildProfileImage(context),
          _buildProfileDetails(context),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Container();
  }
  
  Widget _buildProfileDetails(BuildContext context) {
    return Container();
  }
  
  Widget _buildActions(BuildContext context) {
    return Container();
  }
}
```

5. Now, update the _buildProfileImage method to actually show the image of the dog:
```
Widget _buildProfileImage(BuildContext context) {
  return Container(
     width: 200,
     height: 200,
     child: ClipOval(
       child: Image.asset(
         'assets/dog.jpg',
         fit: BoxFit.fitWidth,
       ),
     ),
   );
}
```

6. The next section will add a Column widget to describe some of the dog's best features.  Replace the _buildProfileDetails() method with this code. This code also includes the Column widget's horizontal sibling, Row:
```
Widget _buildProfileDetails(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Wolfram Barkovich',
          style: TextStyle(fontSize: 35, fontWeight: 
          FontWeight.w600),
        ),
        _buildDetailsRow('Age', '4'),
        _buildDetailsRow('Status', 'Good Boy'),
      ],
    ),
  );
}

Widget _buildDetailsRow(String heading, String value) {
  return Row(
    children: <Widget>[
      Text(
        '$heading: ',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(value),
    ],
  );
}
```

7. Let's add some fake controls that simulate interactions with our pet. Replace the  _buildActions() method with this code block:
```
Widget _buildActions(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      _buildIcon(Icons.restaurant, 'Feed'),
      _buildIcon(Icons.favorite, 'Pet'),
      _buildIcon(Icons.directions_walk, 'Walk'),
    ],
  );
}

Widget _buildIcon(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Column(
      children: <Widget>[
        Icon(icon, size: 40),
        Text(text)
      ],
    ),
  );
}
```

8. Run the app—your device screen should now look similar to this: 

![Figure5.1-now look similar to this ](/flutter_cookbook_img/figure5.1-now_look_similar_to_this.png)

9. In order to place widgets on top of each other, you can use a Stack widget. Replace the code in the build method to add a billboard behind the dog photo:
```
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: <Widget>[
        Image.asset('assets/beach.jpg'),
        Transform.translate(
          offset: Offset(0, 100),
          child: Column(
            children: <Widget>[
              _buildProfileImage(context),
              _buildProfileDetails(context),
              _buildActions(context),
            ],
          ),
        ),
      ],
    ),
  );
}
```

The final screen will look like this:

![Figure5.2-final screen will look like this ](/flutter_cookbook_img/figure5.2-final_screen_will_look_like_this.png)

# How it works...

The only real difference between a Row widget and a Column widget is the axis in which they lay out their children. It's interesting that you can insert a Row widget into a Column widget and vice versa.

There are also two properties on Column and Row widgets that can modify how Flutter lays out your widgets:

- CrossAxisAlignment
- MainAxisAlignment

These are abstractions on the x and y axis. They are also referring to different axes depending on whether you are using a Row widget or a Column widget, as shown in the following diagram:

![Figure5.3-shown in the following diagram ](/flutter_cookbook_img/figure5.3-shown_in_the_following_diagram.png)

With these properties, you can adjust whether the Column widget or Row widget is centered, evenly spaced, or aligned to the start or end of the widget. It will take a bit of experimentation to get the perfect look, but you are equipped with hot reload, so you can experiment at your will to see how they impact the layout.

The Stack widget is different. It expects you to provide your own layout widgets using Align,  Transform, and Positioned widgets.

The Flutter tools also have a setting called Debug Paint, which you can activate from the Flutter tools in your editor or from the command line:

![Figure5.4-have a setting called Debug Paint ](/flutter_cookbook_img/figure5.4-have_a_setting_called_debug_paint.png)

This feature will draw lines around your widgets so that you can see in more detail how they are being rendered, which can be useful to catch layout errors.

## Proportional spacing with the Flexible and Expanded widgets

Today, almost every device has a different height and width. Some devices also have a notch at the top of the screen that insets into the available screen space.  In short, you cannot assume that your app will look the same on every screen—you have to be flexible.

Column and Row widgets do not just position widgets one after another—they also implement a variable on the FlexBox algorithm, allowing you to write UIs that should always look correct, regardless of the screen size.

In this recipe, we will demonstrate two ways to develop proportional widgets: Flexible and Expanded widgets.

# Getting ready

Create a new Dart file called flex_screen.dart and create the requisite StatelessWidget subclass called FlexScreen. Also, just like the last recipe, replace the home property in main.dart with FlexScreen.

# How to do it...

Before we can show off Expanded and Flexible, we need to create a simple helper widget.  

1. Create a new file, called labeled_container.dart, and import material.dart. 

2. Add the following code in the labeled_container.dart file:
```
import 'package:flutter/material.dart';

class LabeledContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String text;
  final Color textColor;

  const LabeledContainer({
    Key key,
    this.width,
    this.height = double.infinity,
    this.color,
    @required this.text,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
```

3. In the flex_screen.dart file, add this code: 
```
import 'package:flutter/material.dart';
import 'labeled_container.dart';

class FlexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flexible and Expanded'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ..._header(context, 'Expanded'),
          _buildExpanded(context),
          ..._header(context, 'Flexible'),
          _buildFlexible(context),
        ],
      ),
    );
  }

  Iterable<Widget> _header(BuildContext context, String text) {
    return [
      SizedBox(height: 20),
      Text(
        text,
        style: Theme.of(context).textTheme.headline,
      ),
    ];
  }

  Widget _buildExpanded(BuildContext context) {
    return Container();
  }

  Widget _buildFlexible(BuildContext context) {
    return Container();
  }

  Widget _buildFooter(BuildContext context) {
    return Container();
  }
}
```

4. Now, fill in the _buildExpanded method:
```
Widget _buildExpanded(BuildContext context) {
  return SizedBox(
    height: 100,
    child: Row(
      children: <Widget>[
        LabeledContainer(
          width: 100,
          color: Colors.green,
          text: '100',
        ),
        Expanded(
          child: LabeledContainer(
            color: Colors.purple,
            text: 'The Remainder',
            textColor: Colors.white,
          ),
        ),
        LabeledContainer(
          width: 40,
          color: Colors.green,
          text: '40',
        )
      ],
    ),
  );
}
```

5. Fill in the Flexible section. Don't forget to hot reload while writing this code:
```
Widget _buildFlexible(BuildContext context) {
  return SizedBox(
    height: 100,
    child: Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: LabeledContainer(
            color: Colors.orange,
            text: '25%',
          ),
        ),
        Flexible(
          flex: 1,
          child: LabeledContainer(
            color: Colors.deepOrange,
            text: '25%',
          ),
        ),
        Flexible(
          flex: 2,
          child: LabeledContainer(
            color: Colors.blue,
            text: '50%',
          ),
        )
      ],
    ),
  );
}
```

6. Update the buildFooter method to create a rounded banner:
```
Widget _buildFooter(BuildContext context) {
  return Center(
     child: Container(
       decoration: BoxDecoration(
         color: Colors.yellow,
         borderRadius: BorderRadius.circular(40),
       ),
       child: Padding(
         padding: const EdgeInsets.symmetric(
           vertical: 15.0,
           horizontal: 30,
         ),
         child: Text(
           'Pinned to the Bottom',
           style: Theme.of(context).textTheme.subtitle,
         ),
       ),
     ),
 );
}
```

7. In order to push this widget to the bottom of the screen, we have to add an Expanded widget to the root Column widget to eat up all the remaining space. Insert this line in the main build method after  the _buildFlexible method: 
```
_buildFlexible(context),
Expanded(
 child: Container(),
),
_buildFooter(context)
```

8. When running the app, you should see a screen similar to this:

![Figure5.5-When running the app ](/flutter_cookbook_img/figure5.5-when_running_the_app.webp)

9. On some devices, the header or footer covers up some software or hardware features (such as the notch or the Home button). To fix this, just wrap the Scaffold in a SafeArea widget:
...
return SafeArea(
      child: Scaffold(
...

10. Perform a hot reload and everything should now render correctly, as shown here:

![Figure5.6-everything should now render correctly ](/flutter_cookbook_img/figure5.6-everything_should_now_render_correctly.webp)

# How it works...

When you break them down, the Flexible and Expanded widgets are quite beautiful in their simplicity.

The Expanded widget will take up all the remaining unconstrained space from a Row or a Column. In the preceding example, we placed three containers in the first row. The container was given a width of 100 units. The last container was given a width of 40 units. The middle container is wrapped in an Expanded widget, so it consumes all the remaining space in the row. These explicit values are referred to as constrained spacing.

The width calculation for the middle container would look like this:

![Figure5.7-width calculation for the middle container ](/flutter_cookbook_img/figure5.7-width_calculation_for_the_middle_container.webp)

These types of widgets can be very useful when you need to push widgets to the other edges of the screen, such as when you pushed the footer banner to the bottom of the screen:
...
Expanded(
  child: Container(),
),
...

It is very common to create an Expanded widget with an empty container that will simply consume the remaining space in a Row or Column.

> Another widget you can use as a space-filler is the Spacer widget. Have a look at https://api.flutter.dev/flutter/widgets/Spacer-class.html for more information on this.
{.is-success}

The Flexible widget behaves similarly to the Expanded widget, but it also has the ability to set a flex value, which can be used to help calculate how much space it should use.

When Flutter lays out Flexible widgets, it takes the sum of the flex values to calculate the percentage of the proportional space that needs to be applied to each widget. In our example, we gave the first two flexible widgets a value of 1 and the second one a value of 2. The sum of our flex values is 4. This means that the first two widgets will get 1/4 of the available width and the last widget will get 1/2 of the available width.  

> It's usually a good idea to keep your flex values small so that you don't have to do any complicated arithmetic to figure out how much space your widget is going to take.  
{.is-success}

Now, just for fun, let's look at the code for how Expanded widgets are implemented:
...
class Expanded extends Flexible {
  const Expanded({
    Key key,
    int flex = 1,
    @required Widget child,
  }) : super(key: key, flex: flex, fit: FlexFit.tight, child: child);
}
...

That's it! An Expanded widget is actually just a Flexible widget with a flex value of 1. We could, in theory, replace all references to Expanded to Flexible and the app would be unchanged.

> Flexible and Expanded widgets have to be a child of the Flex subclass; otherwise, you will get an error. This means they can be a child of a Column or a Row widget. But if you place one of these widgets as a child of a Container widget, expect to see a red error screen. If you want to know more about handling these kinds of errors, skip ahead to Chapter 6, Basic State Management, which is dedicated to solving what happens when code fails.
{.is-info}

# See also

Box constraints are a very important topic when dealing with space in Flutter. Have a look at  https://flutter.dev/docs/development/ui/layout/box-constraints for more information on these. 

## Drawing shapes with CustomPaint

So far, we've been limiting ourselves to very boxy shapes. Rows, Columns, Stacks, and even Containers are just boxes. Boxes will cover the majority of UIs that you would want to create, but sometimes you may need to break free from the tyranny of the quadrilateral.  

Enter CustomPaint. Flutter has a fully featured vector drawing engine that allows you to draw pretty much whatever you want. You can then reuse these shapes in your widget tree to make your app stand out from the crowd.

In this recipe, we will be creating a star rating widget to see what CustomPaint is capable of.

# Getting ready

This recipe will update the ProfileScreen widget that was created in the Placing widgets one after another recipe in this chapter. Make sure that in main.dart, ProfileScreen() is set in the home property.

Also, create a new file called star.dart in the lib directory and set up a StatelessWidget subclass called Star.

# How to do it...

We need to start this recipe by first creating a shell that that will hold the CustomPainter  subclass:

1. Update the Star class to use a CustomPaint widget:
...
import 'package:flutter/material.dart';

class Star extends StatelessWidget {
  final Color color;
  final double size;

  const Star({
    Key key,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _StarPainter(color),
      ),
    );
  }
}
...

2. This code will throw an error because the _StarPainter class doesn't exist yet. Create it now and make sure to override the required methods of CustomPainter:
...
class _StarPainter extends CustomPainter {
 final Color color;

 _StarPainter(this.color);

 @override
 void paint(Canvas canvas, Size size) {
 }

 @override
 bool shouldRepaint(CustomPainter oldDelegate) {
 return false;
 }
}
...

3. Update the paint method to include this code to draw a five-pointed star:
...
@override
void paint(Canvas canvas, Size size) {
 final paint = Paint()..color = color;

 final path = Path();
 path.moveTo(size.width * 0.5, 0);
 path.lineTo(size.width * 0.618, size.height * 0.382);
 path.lineTo(size.width, size.height * 0.382);
 path.lineTo(size.width * 0.691, size.height * 0.618);
 path.lineTo(size.width * 0.809, size.height);
 path.lineTo(size.width * 0.5, size.height * 0.7639);
 path.lineTo(size.width * 0.191, size.height);
 path.lineTo(size.width * 0.309, size.height * 0.618);
 path.lineTo(size.width * 0.309, size.height * 0.618);
 path.lineTo(0, size.height * 0.382);
 path.lineTo(size.width * 0.382, size.height * 0.382);

 path.close();

 canvas.drawPath(path, paint);
}
...

4. Create another class that uses these stars to create a rating. For the sake of brevity, we can include this new widget in the same file, as shown here:
...
class StarRating extends StatelessWidget {
  final Color color;
  final int value;
  final double starSize;

  const StarRating({
    Key key,
    @required this.value,
    this.color = Colors.deepOrange,
    this.starSize = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        value,
        (_) => Padding(
          padding: const EdgeInsets.all(2.0),
          child: Star(
            color: color,
            size: starSize,
          ),
        ),
      ),
    );
  }
}
...

5. That should wrap up the stars. In profile_screen.dart, update the _buildProfileDetails method to add the StarRating widget:
...
Text(
  'Wolfram Barkovich',
  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
),
StarRating(
 value: 5,
),
_buildDetailsRow('Age', '4'),
...

The final app, as shown, should now have five stars under the dog's name:

![Figure5.8-have five stars under the dogs name ](/flutter_cookbook_img/figure5.8-have_five_stars_under_the_dogs_name.webp)


# How it works...
This recipe is composed of quite a few small pieces that work together to create the custom star. Let's break this down into small pieces. Here's the first part of the code:
...
const Star({
  Key key,
  this.color,
  this.size,
}) : super(key: key);
...

This custom constructor is asking for a color and a size, which will then be passed down to the painter. This widget doesn't impose any size restrictions on the star. Let's look at the next part:
...
return SizedBox(
  width: size,
  height: size,
  child: CustomPaint(
    painter: _StarPainter(color),
  ),
);
...

This build method returns a SizedBox that is constrained by this size property and then uses CustomPaint as its child.  You can also pass the size directly into the constructor of  CustomPaint if you want, but this method has been found to be more reliable.

The real work is now done in the CustomPainter subclass, which is not a widget. CustomPainter is an abstract class, meaning you cannot instantiate it directly, as it can only be used through inheritance. There are two methods that you have to override in the subclass: paint and shouldRepaint.

The second method, shouldRepaint, is there for optimization purposes. Flutter will call this method when the widget is redrawn and provide information about the old custom painter that was used to draw the image. In most cases, you can just return false unless you need to change the drawing, to allow Flutter to cache your image.

The paint method is where the shape is actually drawn. You are given a Canvas object. From there, you can use the Path application programming interface (API) to draw the star as a vector shape. Since we want the star to look good at any size, instead of typing explicit coordinates for each vector point, we performed a simple calculation to draw on the percentage of the canvas instead of absolute values.

That is why we wrote this:
...
path.lineTo(size.width * 0.309, size.height * 0.618);
...

We wrote the preceding code instead of the following:
...
path.lineTo(20, 15);
...

If you only provide absolute coordinates, the shape would only be usable at a specific size. Now, this star can be infinitely large or infinitely small, and it will still look good.

Determining these coordinates can be virtually impossible without the aid of a graphics program. These numbers are not just guessed out of thin air. You will probably want to look in a program such as Sketch, Figma, or Adobe Illustrator to draw your image first and then transcribe it to code. There are even some tools that will automatically generate drawing code that you can copy into your project.

> If you are familiar with other vector graphics engines such as Scalable Vector Graphics (SVG) or Canvas2D on the web, this API should seem familiar. In fact, both Flutter and Google Chrome are powered by the same C++ drawing framework: Skia. These drawing commands that we write in Dart are eventually passed down to Skia, which in turn will use the graphics processing unit (GPU) to draw your image.
{.is-info}

Finally, after we have our shape completed, we commit to the canvas with the drawpath method:
...
canvas.drawPath(path, paint);
...

This will take the vector shape and rasterize it (convert it to pixels) using a Paint object to describe how it should be filled.

It may seem like a lot of work just to draw a star, and that would not be an entirely incorrect assumption. If you can accomplish your desired look using a simpler API such a BoxDecoration API, then you don't need a CustomPaint widget. But once you bump up against the limits of the higher-level APIs, there is more flexibility (and more complexity) waiting for you with a CustomPainter. 

# There's more...

There is one more Dart language feature that we used in this recipe that we should quickly explain:
...
List.generate(
  value,
  (_) => Padding(...)
),
...

This is the expected syntax for the generator closure:
...
E generator(int index)
...

Every time this closure is called, the framework will be passing an index value that can be used to build the element. However, in this case, the index is not important. It's so unimportant that we don't need it at all and will never reference it in the generator closure.  

In these cases, you can replace the name of the index with an underscore and that will tell Dart that we are ignoring this value, while still complying with the required API.

We could explicitly reference the index value with this code:
...
(index) => Padding(...)
...

If we did that, however, the compiler might give a warning that the index value is unused. It's usually considered a faux pas to declare variables and not use them. By replacing the index symbol with _, you can sidestep this issue.

# See also

For more information about the CustomPaint class, see https://api.flutter.dev/flutter/widgets/CustomPaint-class.html.

The Flutter Canvas class is a powerful tool: see the official guide at https://api.flutter.dev/flutter/dart-ui/Canvas-class.html.

## Nesting complex widget trees

Your effectiveness with any given platform is measured by how fast you can make changes. Hot reload helps with this exponentially. Being able to quickly edit properties on a widget, hit Save, and almost instantly see your results without losing state is wonderful. This feature enables you to experiment. It also allows you to make mistakes and quickly undo them without wasting precious compile time.

But there is one area where Flutter's nested syntax can slow your progress. Throughout this chapter, we have used the phrase wrap in a widget frequently. This implies that you are going to take an existing widget and make it the child of a new widget, essentially pushing it one level down the tree. This can be error-prone if done manually, but thankfully the Flutter tools help you manipulate your widget trees with speed and effectiveness.

In this recipe, you are going to explore the IDE's tools that will allow you to build deep trees without worrying about mismatching your parentheses.

# Getting ready

For this recipe, you should have completed the first recipe in this chapter: Placing widgets one after another (and/or any other recipes in this chapter).

Let's create a new file called deep_tree.dart, import the material.dart library, and make a StatelessWidget subclass called DeepTree. Call an instance of this widget in the home property of  MaterialApp, in the main.dart file. 

# How to do it...

Let's start by running the app. You should see a blank canvas to play with:

1. Add some text to the DeepTree class:
...
class DeepTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
 body: Text('Its all widgets!'),
 );
  }
}
...

2. Compile and run the code. You'll get the following result:

![Figure5.9-get the following result ](/flutter_cookbook_img/figure5.9-get_the_following_result.webp)

3. We can see that in the preceding screenshot, the text is in the top corner and it can barely be seen. How about we wrap it in a Center widget?  
4. Move your cursor over the Text constructor and type the following:
	-  In Android Studio: Ctrl + Enter (or Command + Enter on a Mac) 
	-  In Visual Studio Code (VS Code): Ctrl + . (or Command + . on a Mac)
	to bring up the intentions dialog. Then, select Center widget / Wrap with Center.
5. Perform a hot reload, and the text will move to the center of the screen:

![Figure5.10-move to the center of the screen ](/flutter_cookbook_img/figure5.10-move_to_the_center_of_the_screen.webp)

6. That looks slightly better, but how about we change that single widget to a Column widget and add some more text? Once again, move your cursor over the text constructor and type the editor shortcut to get the helper methods.  

> You will be using these shortcuts a lot during this recipe: to bring in the intentions methods, you use Ctrl/Command + . in VS Code and Ctrl/Command + Enter in Android Studio. This time, select Wrap with Column.
{.is-info}

7. You can now remove the Center widget.
8. Put your cursor on the Center widget and call the intentions methods, then select Remove this widget.
9. Add two more Text widgets, as shown here:
...
class DeepTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          Text('Its all widgets!'),
          Text('Flutter is amazing.'),
          Text('Let\'s find out how deep the rabbit hole goes.'),
        ],
      )),
    );
  }
}
...

10. Uh oh! The text has moved to the top again. We can fix that by setting the main axis on the column back to the center:
...
Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Text('Its all widgets!'),
...

11. Keep building up the tree by wrapping the middle text widget with a Row widget and adding a FlutterLogo widget:
...
Text('Its all widgets!'),
Row(
 mainAxisAlignment: MainAxisAlignment.center,
 children: <Widget>[
 FlutterLogo(),
 Text('Flutter is amazing.'),
 ],
),
Text('Let\'s find out how deep the rabbit hole goes.'),
...

12. That middle row might look better if it were the first row. We could just cut it place it first in the Column widget's list, but that could lead to errors if we didn't copy the whole row. Instead, let's see what the Flutter tools offer. Bring up the intentions dialog and select Move widget up: 

![Figure5.11-select Move widget up ](/flutter_cookbook_img/figure5.11-select_move_widget_up.webp)

13. Add a purple container between the row and the 'It's all widgets!'  Text widget:
...
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    FlutterLogo(),
    Text('Flutter is amazing.'),
  ],
),
Expanded(
  child: Container(
    color: Colors.purple,
  ),
),
Text('It's all widgets!'),
...

	This will push everything to the edges of the screen, making the text almost impossible to read again. We can use the SafeArea widget to bring back some legibility.

14. Bring up the intentions methods and select Wrap with (a new) widget. A placeholder will appear.
15. Replace the word widget with the SafeArea widget:

![Figure5.12-Replace the word widget ](/flutter_cookbook_img/figure5.12-replace_the_word_widget.webp)

# How it works...

Mastering this tool is critical to getting into a flow state when developing your UIs. A common criticism of Flutter is that deeply nested widget trees can make code very hard to edit. This is the reason why tools such as the intentions dialog exist.

As your Flutter knowledge grows, you should strive to become more reliant on these tools to improve your efficiency and accuracy. If you want, try running through this recipe again, but this time, don't use the helper tools—just edit the code manually. Notice how hard it is, and how easy it is to mismatch your parentheses, breaking the whole tree? 

For the curious, the intentions dialog feature is powered by a separate program called the Dart Analysis Server. This is a background process that isn't tightly coupled to your IDE. Both Android Studio and VS Code talk to the same server. When you open the intentions dialog, your IDE sends the token you are currently highlighting to the server, which analyzes your code and returns the appropriate options. This server is constantly running while you are editing your code. It checks for syntax errors, helps with code autocomplete, and provides syntax highlighting and other features.  

It is unlikely that you will ever interact with the Dart Analysis Server directly, since that's the IDE's job, not yours. But you can rest peacefully knowing that it has your back.

# See also

Dart Analysis Server, the engine that is powering this feature, is described at https://github.com/dart-lang/sdk/tree/master/pkg/analysis_server.

## Refactoring widget trees to improve legibility

There is a delightfully sardonic anti-pattern in coding known as the pyramid of doom. This pattern describes code that is excessively nested (such as 10+ nested if statements and control flow loops). You end up getting code that, when you look at it from a distance, resembles a pyramid. Pyramid-like code is highly bug-prone. It is hard to read and, more importantly, hard to maintain.

Widget trees are not immune to this deadly pyramid. In this chapter, we've tried to keep our widget trees fairly shallow, but none of the examples so far is really indicative of production code—they are simplified scenarios to explain the fundamentals of Flutter. The tree only grows deeper from here.

To fight the pyramid of doom, we're going to use a weapon known as refactoring. This is a process of taking code that is not written ideally and updating the code without changing its functionality. We can take our n-layer deep widget trees and refactor them toward something easier to read and maintain.

In this recipe, we're going to take a large and complicated widget tree and refactor it toward something cleaner.

# Getting ready

Download the sample code that comes with this book and look for the  e_commerce_screen_before.dart file. Copy that file and the woman_shopping.jpg and textiles.jpg images to your assets folder in the project. Update main.dart to set the home property to ECommerceScreen().

# How to do it...

This recipe is going to focus on taking some existing code and updating it to something more manageable. Open e_commerce_screen_before.dart and notice that the whole class is one single unbroken build method:

1. The first thing we're going to do with this file is divide it up using a refactoring tool called extract method.
Move your cursor over AppBar, right-click and select Refactor | Extract Method on VS Code or Refactor | Extract | Extract Method on Android Studio to open the extract dialog. Call the method _buildAppBar and press Enter:

![Figure5.13-divide it up using a refactoring tool ](/flutter_cookbook_img/figure5.13-divide_it_up_using_a_refactoring_tool.webp)

2. Perform an extract of the first Row widget in the Column widget using the same technique. Call this method _buildToggleBar().
3. The next step is going to be a bit more tricky. Collapse the code for the two next rows by tapping the collapse icon just to the right of the line numbers: 

![Figure5.14-going to be a bit more tricky ](/flutter_cookbook_img/figure5.14-going_to_be_a_bit_more_tricky.webp)

4. With both rows collapsed, highlight the three SizedBox instances and the two rows and call the intentions dialog. Select Wrap with Column:

![Figure5.15-call the intentions dialog ](/flutter_cookbook_img/figure5.15-call_the_intentions_dialog.webp)

	The whole group of widgets can now be extracted. This time, extract the Column widget to a Flutter widget by right-clicking and selecting Refactor | Extract | Flutter Widget.  Call the new widget DealButtons.  

5. Finally, extract the last Container widget into a method called _buildProductTile. After all, this is done, the build method should be short enough to fit on the screen:
...
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildToggleBar(context),
              Image.asset('assets/woman_shopping.jpg'),
              DealButtons(),
              _buildProductTile(context),
            ],
          ),
        ),
      ),
    );
  }
...

6. Extracting is only one aspect of refactoring. There is also some redundant code that can be reduced. Scroll down to the newly created DealButtons widget.
7. Extract the third Expanded widget, the one that says must buy in summer into another Flutter widget called DealButton. 
8. Add two properties at the top of the DealButton class and update the widget as shown in the following code snippet:
...
class DealButton extends StatelessWidget {
  final String text;
  final Color color;

  const DealButton({
    Key key,
    this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
...

9. The build method for the DetailButtons widget can now be significantly simplified. Replace that verbose repetitive method with this more efficient one:
...
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            DealButton(
              text: 'Best Sellers',
              color: Colors.orangeAccent,
            ),
            SizedBox(width: 10),
            DealButton(
              text: 'Daily Deals',
              color: Colors.blue,
            )
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: <Widget>[
            DealButton(
              text: 'Must buy in summer',
              color: Colors.lightGreen,
            ),
            SizedBox(width: 10),
            DealButton(
              text: 'Last Chance',
              color: Colors.redAccent,
            )
          ],
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
...

If you run the app, you should not see any visual difference, but the code is now much easier to read.

# How it works...

There are two extraction techniques that we highlighted in this recipe that bear delving deeper into:

- Extract method
- Extract widget

The first technique should be relatively straightforward. The Dart Analysis Server will inspect all the elements of your highlighted code and simply pull it out into a new method in the same class.

You have code like this:
...
class RefactoringExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('Widget A'),
            Text('Widget B'),
          ],
        ),
        Row(
          children: <Widget>[
            Text('Widget C'),
            Text('Widget D'),
          ],
        ),
      ],
    );
  }
}
...

You can go one step further beyond extracting and also simplify the code as well. Both of these rows have the same widget structure, but their text is different. You can update the widget to use a configurable build method, as shown here:
...
class RefactoringExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        buildRow('Widget A', 'Widget B'),
        buildRow('Widget C', 'Widget D'),
      ],
    );
  }

  Widget buildRow(String textA, String textB) {
    return Row(
      children: <Widget>[
        Text(textA),
        Text(textB),
      ],
    );
  }
}
...

Not only is this code easier to read, but it's also reusable. You can add as many rows as you want with a different text. As an added bonus, you can update the buildRow method to add some padding around the text or change the text style, and these changes will automatically be applied every time you invoke the buildRow method.

One of the main rules for refactoring is: Don't repeat yourself.

If you have widget trees or statements that are repeated throughout your code, you should refactor your code. If you can accomplish the same result with less code, then you will have fewer bugs and be able to change your code faster. 

> When you invoke the extract method, your IDE will set the return to whatever top-level widget you are extracting. If you are extracting a Row widget, the return type of your method will be a row.  It's usually considered best practice to change the return type to the widget superclass instead of something more specific. The benefit is that if you ever update the root widget in your build method to some other widget, you don't have to change the method signature. A Row is a widget. A Column is a widget. A Padding is a widget. Ensuring that your return type is always Widget will remove any blocks as your app grows.
{.is-success}

Extracting widget trees into Flutter widgets is similar to extracting methods. Instead of generating a method, the IDE will generate a whole new StatelessWidget subclass that is then instantiated instead of invoked.

There are cases where both extraction methods make sense, but there aren't any hard rules for which one you should pick. Typically, if the widget tree that you are extracting is relatively simple and will not be reused, then a build method is fine. After the tree gets past a threshold of complexity, whatever that threshold may be, extracting to a widget instead of a method will become ideal.

# See also

If you want to learn more about the pyramid of doom, see https://en.wikipedia.org/wiki/Pyramid_of_doom_(programming).

See Refactoring by Martin Fowler, the quintessential book on this subject: https://martinfowler.com/books/refactoring.html

## Applying global themes

Consistency is at the heart of any good design. Every screen in your app should look as if it were designed as a single unit. Your font selections, color palettes, and even text padding are all part of your app's identity. When users look at your app, branding consistency is critical for recognition. Apple products look like Apple products, with their white backgrounds and sleek curves. Google's Material Design is a colorful splash of primary shapes and shadows.

To make all their products look like they belong to the same design system, these companies use detailed documents that explicitly describe the schematics of how UIs should be designed. On a programmatic side, we have themes. These are widgets that live at the top of the tree and influence all of their children. You don't need to declare styling for every single widget.  You just need to make sure that it respects the theme.

In this recipe, we will take the e-commerce mock-up screen and simplify it even more by using themes to express the text and color styling.

# Getting ready

Make sure that you have completed all the refactoring tasks from the previous recipe before beginning. If not, you can use the e_commerce_screen_after.dart file as your base.

# How to do it...

Open your IDE and run the app. Let's start theming the e-commerce screen by adding a theme to your MaterialApp widget:

1. Open main.dart and add the following code:
...
class StaticApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.green,
      ),
      home: ECommerceScreen(),
    );
  }
}
...

2. Now that the Theme has been declared, the rest of the recipe will about deleting code so that the theme traverses down to the appropriate widgets.  
3. In the Scaffold of the EcommerceScreen class, delete the property and value for backgroundColor. In the _buildAppBar method, also delete these two lines:
...
backgroundColor: Colors.purpleAccent,
elevation: 0, 
...

	When you hot reload, the AppBar will be green, respecting the primaryColor property of the app's theme.

4. The toggle bar could use a bit more refactoring, along with removing more styling information.  
5. Extract one of the Padding widgets in _buildToggleBar to a method called _buildToggleItem.

6. Then, update the code so that the extracted method is parametrized:
...
Widget _buildToggleBar() {
  return Row(
    children: <Widget>[
      _buildToggleItem(context, 'Recommended', selected: true),
      _buildToggleItem(context, 'Formal Wear'),
      _buildToggleItem(context, 'Casual Wear'),
    ],
  );
}

Widget _buildToggleItem(BuildContext context, String text,
    {bool selected = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 17,
        color: selected
            ? null
            : Theme.of(context).textTheme.title.color
              .withOpacity(0.5),
            fontWeight: selected ? FontWeight.bold : null,
      ),
    ),
  );
}
...

7. The theme needs access to BuildContext to work correctly, but the original _buildToggleBar method doesn't have access to it.  
8. The context has to be passed down from the root build method. Update the signature of _buildToggleBar to accept a context. 

> In a widget class, BuildContext is automatically available, so you don't need to pass it to the method. 
{.is-success}

...
Widget _buildToggleBar(BuildContext context) { ... }
...

9. Change the build method to pass down the context:
...
Column(
  children: <Widget>[
    _buildToggleBar(context),
    Image.asset('assets/woman_shopping.jpg'),
    DealButtons(),
    _buildProductTile(context),
  ],
),
...

10. If you hot-reload the app, you'll notice that all the text in the product tile has disappeared. That's a bit of an illusion because the theme we selected is rendering white text on a white background.  
11. Update _buildProductTile to make the text visible:
...
Widget _buildProductTile(BuildContext context) {
  return Container(
    height: 200,
    color: Theme.of(context).cardColor,
...

12. The screen should be fully responding to the app theme. But we can take it further.  
13. Update the theme in main.dart to assign a global style for every AppBar:
...
ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.green,
  appBarTheme: AppBarTheme(
    elevation: 10,
    textTheme: TextTheme(
      headline6: TextStyle(
        fontFamily: 'LeckerliOne',
        fontSize: 24,
      ),
    ),
  ),
),
...

14. In order to use the leckerlyOne font, download it from https://fonts.google.com/specimen/Leckerli+One, add it to your assets folder and in your pubspec.yaml file, enable it with the following instructions:
...
fonts:
    - family: LeckerliOne
      fonts:
        - asset: assets/LeckerliOne-Regular.ttf
...

15. Everything in the app is very dark, not so becoming of an e-commerce app. Quickly adjust the theme's brightness to light:
...
brightness: Brightness.light,
...

16. Perform a hot reload and feast your eyes on the final themed product:

![Figure5.16-hot reload and feast your eyes ](/flutter_cookbook_img/figure5.16-hot_reload_and_feast_your_eyes.webp)

# How it works...

MaterialApp widgets (and CupertinoApp widgets) are not a just a single widget; they compose a widget tree that contain many elements that build the UI for your app.

If you Ctrl + click  (or Command + click on a Mac) into the MaterialApp source code and find the Theme class, you'll see that it is also just a Stateless widget: 
...
class Theme extends StatelessWidget {
  /// Applies the given theme [data] to [child].
  ///
  /// The [data] and [child] arguments must not be null.
  const Theme({
    Key key,
    @required this.data,
    this.isMaterialAppTheme = false,
    @required this.child,
  }) : assert(child != null),
       assert(data != null),
       super(key: key);
...

The ThemeData class is just a plain old Dart object that stores properties and sub-themes, such as a TextTheme and AppBarTheme sub-theme. These sub-themes are also just models that store values.

The interesting part happens with this line:
...
Theme.of(context)
...

We've already briefly covered this pattern: in short, what's happening is that the app is traveling up the widget tree to find the Theme widget and return its ThemeData widget:

![Figure5.17-whats happening is that the app ](/flutter_cookbook_img/figure5.17-whats_happening_is_that_the_app.webp)

BuildContext is the key to unlock this tree traversal. It is the only object that is aware of the underlying widget tree and the node's parent/child relationships. This might seem very expensive to do, but after the of method is called once, a reference to the requested data is stored in the widget so that it can be retrieved instantly on subsequent calls.

Most widgets in the Material and Cupertino libraries are already theme-aware. The AppBar class references the theme's primary color to use for its background. The Text widget applies the body style of the default text theme by default. When you design your own widgets, you should strive for this same level of flexibility. It is perfectly acceptable to add properties to your widget's constructor to style your widget, but in the absence of data, fall back to the theme.

# There's more...

Another interesting property when dealing with themes is the brightness property. Light and dark apps now getting common. Apple introduced a toggle dark mode in iOS 13, and Google made it available in Android 10.

The lightness enum is how Flutter supports this feature. By toggling lightness, you have seen the background and text colors automatically get dark/light.

There is also a darkTheme property in MaterialApp where you can design the dark version of your app. These properties are platform-aware and will automatically toggle the themes based on the phone's settings.

Including this feature now in your app will future-proof your apps, as we are entering a world where both light and dark support is expected.

# See also

Check out these resources to learn more about the design specifications for iOS and Android:

- Material Design spec: https://material.io/design/
- iOS Human Interface Guidelines: https://developer.apple.com/design/human-interface-guidelines/ios/overview/themes/
