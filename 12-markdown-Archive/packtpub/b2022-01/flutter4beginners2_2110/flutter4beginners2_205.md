원본 제목: Chapter 5: Widgets – Building Layouts in Flutter
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/205
Title:
205 Widgets – Building Layouts in Flutter
Short Description:
Flutter for Beginners Second Edition 레이아웃을 만드는 위젯

![Figure 5.5 - A widget tree with the title property inherited ](/flutter4beginners2_img/figure_5.5_-_a_widget_tree_with_the_title_property_inherited.jpg)
- cut line


# Chapter 5: Widgets – Building Layouts in Flutter
Flutter for Beginners Second Edition

In this chapter, you will learn what a widget is and the three different types of widgets: stateless, stateful, and inherited. You will explore some of the most common widgets in Flutter, view them in action, and learn how to add them to your application. Additionally, you will gain an understanding of how layout widgets can help you to structure your user interface (UI).

Widgets are classes and objects within the Dart language. Therefore, this chapter will use a lot of the knowledge that you gained in Chapter 4, Dart Classes and Constructs, regarding Dart classes and enums. Armed with this knowledge, we will explore Stateful and Stateless widgets, which are classes that inherit from specific superclasses and are key to how you manage the UI of your app.

Next, we will take a closer look at the built-in widgets that come as part of the Flutter framework and cover most of your UI needs. It is useful to be aware of what is already available, including the layout widgets that control the positioning of their nested child widgets, which, in turn, gives you greater control of how your app looks to the user.

Finally, we will look at the concept of streams, which allows your code to react to changes in the data or state outside of your widget.

The following topics will be covered in this chapter:

- Stateful/stateless widgets
- Built-in widgets
- Understanding built-in layout widgets
- Using streams

By the end of the chapter, you should have a good idea of how Flutter apps are put together and why widgets are such an important part of the Flutter framework.

# Technical requirements

You will need your development environment again for this chapter. Take a look back at Chapter 1, An Introduction to Flutter, if you require further information on how to set up your IDE or to refresh your knowledge regarding the development environment requirements.

You can find the source code for this chapter on GitHub at https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/lib/chapter_05.

# Stateful/stateless widgets

In Chapter 1, An Introduction to Flutter, we learned that widgets play an important role in Flutter application development. They are the pieces that form the UI; they are the code representation of what is visible to the user.

UIs are almost never static; they change frequently, as you will have experienced when you have used a web page or an application. Although immutable by definition, widgets are not meant to be final – after all, we are dealing with a UI, and a UI will certainly change during the life cycle of any application. That's why Flutter provides two types of widgets: stateless and stateful.

## Immutability

Most programming languages refer to the term "immutable." An immutable object is an object that never changes. That is, it cannot change itself, and it cannot be changed externally. Instead, if a change is needed, then the object is simply replaced. A stateless widget is immutable because it cannot change its properties or state, nor can something external change its properties or state. If the widget needs to change, then it is effectively replaced by a new widget that has different properties or state.

As you might expect, a stateless widget has no state, whereas a stateful widget holds state and adapts based on that state. This difference impacts the life cycle of the widget, how it is constructed, and how the code is structured. It's the developer's responsibility to choose what kind of widget to use in each situation. Generally speaking, a developer should look at stateless as the default option unless the widget needs to hold state. A stateful widget could be used for every scenario, but this will impact performance and code maintainability.

Additionally, Flutter uses the concept of inherited widgets (the InheritedWidget type), which is also a kind of widget, but it is slightly different from the other two types that we've mentioned.

## Stateless widgets

A typical UI will be composed of many widgets, and some of them will never change their properties after being instantiated. They do not have a state; that is, they do not change by themselves through an internal action or behavior. Instead, they are changed by external events on parent widgets in the widget tree. So, it's safe to say that stateless widgets give control regarding how they are built to a parent widget in the tree. The following diagram shows a representation of a stateless widget:

![Figure 5.1 - A stateless widget ](/flutter4beginners2_img/figure_5.1_-_a_stateless_widget.jpg)

In the preceding diagram, the parent widget instantiates the child stateless widget and passes a set of properties during the instantiation. The child widget can only receive these properties from the parent widget and will not change them by itself. In terms of code, this means that stateless widgets only have final properties defined during construction, and these properties can only be changed through the update of a parent widget with the changes then rippling down to the child widgets.

Let's take a look at an example of a stateless widget from the Hello World! app that we explored in previous chapters.

## Code example

The very first stateless widget inside the application is the application class itself:

```
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

As you can see, the MyApp class extends StatelessWidget and overrides the build(BuildContext) method. The build method is critical to all widgets and describes how the widget should appear on the screen. It does this by building a widget subtree below it. MyApp is the root of the widget tree; it is the top-level widget that is instantiated within the runApp method in the Dart main method. Therefore, it builds all the widgets down the tree. In this example, the direct child is MaterialApp. According to the documentation, MaterialApp can be defined as follows:

"A convenience widget that wraps a number of widgets that are commonly required for material design applications."

## Material Design

Material Design is a standard set of designs and digital experiences that were created by Google to help teams build high-quality UIs. Apple has an equivalent named Cupertino, and we will look at examples of both throughout the remainder of this book.

In this example, the stateless widget does not receive any properties from its parent because it doesn't have a parent. We will view examples of properties being passed later.

BuildContext is an argument provided to the build method as a useful way to interact with the widget tree. It allows you to access important ancestral information that helps to describe the widget that is being built. For example, the theme data defined in this widget can be accessed by all child widgets to ensure there is a consistent look and feel to your application.

In addition to other properties, MaterialApp contains the home property. This is the first widget that is displayed within your application. Here, home refers to the MyHomePage widget, which is not a built-in widget, but rather a stateful widget defined within the Hello World! application.

You should now be able to understand how Flutter composes widgets to create the display. Let's take a look at the partner of stateless widgets, that is, the stateful widget.

## Stateful widgets

Unlike stateless widgets, which receive properties from their parents that are constant throughout the widgets' lifetime, stateful widgets are meant to change their properties dynamically during their lifetimes. By definition, stateful widgets are also immutable, but they have a companion State class that represents the current state of the widget. This is shown in the following diagram:
![Figure 5.2 - A stateful widget ](/flutter4beginners2_img/figure_5.2_-_a_stateful_widget.jpg)

In the preceding diagram, a widget instantiates a child widget and, similar to the stateless widget example, passes properties to the child. These properties are, once again, final and cannot be changed within the widget. However, unlike the stateless widget example, a companion State object also has access to the widget properties and, additionally, is able to hold other properties that are not final.

By holding the state of the widget in a separate State object, the framework can rebuild the widget whenever necessary without losing its current associated state. The element in the elements tree holds a reference to the corresponding widget and also the State object associated with it. The State object will notify you when the widget needs to be rebuilt and then perform an update in the elements tree, too.

## Code example

MyHomePage is a stateful widget, and so, it is defined with a State object named _MyHomePageState, which contains properties that affect how the widget looks. First, let's take a look at the widget:

```
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
```

The first thing that you should pay attention to is that this extends the StatefulWidget, identifying, therefore, that this will have a State companion object. Stateful widgets must override the createState() method and return an instance of the companion object. In this example, it returns an instance of _MyHomePageState.

A valid widget state is a class that extends the framework State class, which is defined in the documentation as follows:

"The logic and internal state for a StatefulWidget."

Additionally, in this example, properties have been passed from a parent widget and these are surfaced in the widget constructor. Note that the title property has been passed in and is stored in the widget in the final field, which is named title. As discussed in Chapter 4, Dart Classes and Constructs, Dart has some clever shortcuts in the way it structures constructors, and by using this.title in this constructor body, we can automatically assign the value of the title property to the title field.

Normally, stateful widgets define their corresponding State classes in the same file. Additionally, state is typically private to the widget library, as external clients do not need to interact with it directly.

The following _MyHomePageState class represents the State object of the MyHomePage widget:

```
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for       build methods.
    );
  }
}
```

Let's go through this code section by section.

First, there is only one class field, which is named _counter, so you can infer that the state of the MyHomePage widget is defined by that single property. The _counter property records the number of presses of the button in the lower-right corner of the screen. How this _counter property changes will be defined in your business logic.

## What is business logic?

Business logic is the part of the code where you specify the business rules for your app. Unlike much of your app code, which is concerned with lower-level details, such as how to display widgets or connect to the database, the business logic determines how a user interacts with your app, and how that interaction impacts state data.

For example, where a widget is placed on the screen, what color it is, and how it reacts when pressed is not business logic. However, if, by pressing it, the user can modify information about themselves, such as their gender, home address, or how many cakes they want to buy, then that is business logic.

The first method we encounter is the _incrementCounter method. This takes no arguments and has a void return code specifying that it returns no value. However, it does do something crucial that we should explore in further detail:

```
    setState(() {
      _counter++;
    });
```

A stateful widget is meant to change its appearance during its lifetime – that is, it defines what will change – and so it needs to be rebuilt to reflect such changes. In the StatefulWidget diagram (Figure 5.2), we saw that the framework rebuilds the StatefulWidget to reflect a new state. However, how does the framework know when something in the widget changes and that a rebuild is required?

The answer is the setState method. This method receives a function as a parameter that updates the widget's corresponding State. In this case, we have created an anonymous function, and in the function body, we have specified that the _counter variable should be incremented. By calling setState, the framework is notified that it needs to rebuild the widget. Once called, the widget will be redrawn with the new _counter value already set.

Finally, we reach the widget's build method. The method signature and intended function are identical to the build method of StatelessWidget that we discussed earlier. However, unlike StatelessWidget, we now have a state that will affect how we draw the widget, which could lead to far more complex code involving even more conditional statements.

The build method can look intimidating, and we will look at the individual widgets in more detail later in the chapter. However, at this point, try to get a feel for the composition structure shown. The method returns a Scaffold widget at the top level and is composed of three child widgets via three constructor arguments:

- appBar: This holds a widget of the AppBar type, which itself has one constructor argument named title. As you can guess, this describes the widget that will appear at the top of the screen as an app bar.
- body: This can hold any widget and appears in the main body of the application (that is, between the top app bar and any bottom menu bar). In this case, it holds a Center widget (which centers the child content). This, in turn, holds a Column widget (which creates a vertical column of widgets). Finally, this holds two Text widgets (which display a string of text).
- floatingActionButton: This holds a widget of the FloatingActionButton type, which is a button that floats above the app body in the lower-right corner (as the default configuration) and acts as a button.

Note that one of the arguments for the FloatingActionButton constructor is onPressed, and that the value is the _incrementCounter method. This ties the whole flow together:

1. The MyHomePage widget calls the build method of the companion state to display the app bar, body, and action button.
1. The user presses the action button.
1. The onPressed argument value is triggered, which calls the _incrementCounter method.
1. The _incrementCounter method calls the setState method with the anonymous function, specifying that the _counter variable should be incremented.
1. The framework calls the anonymous function, thereby incrementing the _counter variable.
1. The framework redraws the widget by calling the build method of the companion state again to display the updated app bar, body, and action button:

![Figure 5.3 - The home page ](/flutter4beginners2_img/figure_5.3_-_the_home_page.jpg)

As the preceding diagram shows, the setState method is crucial to this whole flow, and understanding this redrawn flow is central to how the Flutter framework works.

Let's complete this section by looking at a less well-known widget type, that is, the InheritedWidget type.

## Inherited widgets

Besides StatelessWidget and StatefulWidget, there is one more type of widget in the Flutter framework, InheritedWidget. Sometimes, one widget might require access to data further up the widget tree. In such scenarios, one solution is to replicate the information down to the interested widget by passing it through all of the intermediate widgets. Let's view an example widget composition structure so that we can examine this in more detail:

![Figure 5.4 - A widget tree with a title property ](/flutter4beginners2_img/figure_5.4_-_a_widget_tree_with_a_title_property.jpg)

In this scenario, let's suppose that one of the widgets down the tree requires access to the title property from the root widget. For this to happen in a world where there are only stateful and stateless widgets, we would need to pass the title property to every child widget via the constructors so that the child widget could, in turn, pass the title property to its child widgets. This can lead to lots of boilerplate code, can be error-prone if one of the widgets isn't coded quite right, and can be really painful if it is decided that the child widget needs another property, which means that all of the intermediate widgets need to be updated.

To address this problem, Flutter provides the InheritedWidget class. This is an auxiliary kind of widget that helps to propagate information down the tree, as shown in the following diagram:

![Figure 5.5 - A widget tree with the title property inherited ](/flutter4beginners2_img/figure_5.5_-_a_widget_tree_with_the_title_property_inherited.jpg)

By adding an InheritedWidget to the tree, any widget below it can access the data it exposes by using the of(InheritedWidget) method of the BuildContext class that receives an InheritedWidget type as a parameter and uses the tree to find the first ancestral widget of the requested type.

There are some very common uses of InheritedWidget in Flutter. One of the most common uses is from the Theme class, which helps to describe colors for a whole application. We will explore this in Chapter 6, Handling User Input and Gestures.

Now, let's investigate something that you might have spotted in some of the previous code examples, that is, a constructor property with the name of key.

## The widget key property

If you take a look at the constructors of the StatelessWidget and StatefulWidget classes, you will notice a parameter named key. This is an important property for widgets in Flutter.

The key property allows you to preserve the state of a widget between rebuilds. You might remember that the framework takes the widget tree and renders it to an element tree. The element tree is a very simple representation of the widget tree that only holds the widget's type and the references to its children widgets. When a change or rebuild occurs, the framework uses the widget's type and children references to determine whether a redraw is needed. In situations where there are many widgets of the same type as children of the same widget (for example, rows or columns), there can be situations where the ordering changes but doesn't invalidate the element tree. In this situation, the behavior of Flutter can be unexpected.

Without keys, the element tree would not know which state corresponds to which widget, as they would all have the same type. When a widget has a state, it needs the corresponding state to be moved around with it. Put simply, that is what a key helps the framework to do. By holding the key value, the element in question will know the corresponding widget state that needs to be with it.

In most situations, a key is not needed (and should not be used); however, if you see some strange behavior where you are sure your widget is changing state but this is not being correctly reflected on the UI, then it is worth checking whether the framework is misunderstanding the element tree and whether a key might be a suitable remedy for the situation. If you need more information regarding how a key affects the widget and the available types of keys, please check out the official documentation's introduction to keys: https://flutter.dev/docs/development/ui/widgets-intro#keys.

We have now explored the fundamental building blocks of Flutter: widgets. Specifically, we have looked at three types of widgets, stateless, stateful, and inherited, along with the situations that you would use them in. Now you have a basic knowledge of the fundamentals of widgets, let's take a look at some widgets you get for free when you start your UI.

---

## Built-in widgets

Flutter has a big focus on the UI, and because of this, it contains a large catalog of widgets that allow you to get started with a high-quality UI relatively easily.

The available widgets of Flutter range from simple ones, such as the Text widget in the Flutter counter application example, to complex widgets that enable you to design dynamic UI with animations and multiple gesture handling.

In this section, we will go through these built-in widgets in more detail. We will start with the basic widgets of text and images, move on to more advanced widgets involving user interaction, such as buttons, and finish with a look at layout widgets, which control how other widgets are positioned on the UI.

## Basic widgets

The basic widgets in Flutter are a good starting point, not simply because of their ease of use, but because they also demonstrate the power and flexibility of the framework, even in simple scenarios.

In this section, we will explore the most common widgets that you are likely to use as you get started with Flutter. However, there are many more widgets available that you can explore in the Widget catalog at https://flutter.dev/docs/development/ui/widgets.

## The Text widget

The Text widget displays a string of text that can be styled as follows:

```
Text(
  "Some exciting text",
  style: TextStyle(color: Colors.red, fontSize: 14),
  textAlign: TextAlign.center
)
```

Pay attention to the structure of the Text constructor. The first parameter, that is, the string of text, is a positional parameter. It is then followed by a series of named parameters. Flutter leans heavily on the named parameter approach to keep widget trees readable, but where a parameter is fundamental to the widget, such as the text for a Text widget, this is often the first positional parameter.

The most common properties of the Text widget are as follows:

- style: This holds a TextStyle instance that controls how the text should be styled. The TextStyle constructor has properties that allow you to set the text color, background, font family (including the use of a custom font from the assets; please refer to Chapter 1, An Introduction to Flutter), line height, font size, and more.
- textAlign: This holds a value from the TextAlign enum describing how the text should be aligned. Options include center alignment and justified alignment.
- maxLines: This holds an integer specifying the maximum number of lines that the text can be wrapped over before it is truncated.
- overflow: This holds a value from the TextOverflow enum describing how the text should be shown that exceeds the available space. Options include fading, ellipsis, or clipping.
- To view all of the available Text widget properties, please refer to the official Text widget documentation page at https://docs.flutter.io/flutter/widgets/Text-class.html.

## The Image widget

The Image widget displays an image from different sources and formats. Currently, the supported image formats are JPEG, PNG, GIF, animated GIF, WebP, animated WebP, BMP, and WBMP:

```
Image(
  image: AssetImage(
    "assets/dart_logo.jpg"
  ),
)
```

The Image widget is not quite as simple to construct as the Text widget because it needs to know the source of the image file. This could be from the internet, from a file on the device, or from within the app as defined in the assets. To manage this, the widget has an image constructor property that specifies an ImageProvider type.

In this example, the image comes from an asset within the app. This is denoted by using an AssetImage provider that takes the location of the asset as a positional constructor parameter. To retrieve an image from the internet, instead of AssetImage, you should use the NetworkImage provider, which works in a similar way. To retrieve an image from a file on the device, you should use the FileImage provider.

The Image class contains convenience constructors to help you with the loading of images, such as the following:

- Image.asset: This creates an AssetImage provider, which is used to obtain an image from your assets using the asset key. For example, take a look at the following:
```
Image.asset(
  'assets/dart_logo.jpg',
)
```

- Image.network: This creates a NetworkImage provider to obtain an image from a URL. For example, take a look at the following:
```
Image.network(
  'https://picsum.photos/250?image=9',
) 
```

- Image.file: This creates a FileImage provider to obtain an image from a file:
```
Image.file(
  File(file_path)
)
```

Note that this uses a File object to refer to the location of the file.

Now that we have explored the Text and Image widgets, you have the tools to display information to the user. However, your app will need to allow users to input data, so let's take a look at some of the built-in widgets that will allow this interaction.

## Material Design and iOS Cupertino widgets

Many of the widgets in Flutter are descended, in some way, from a platform-specific guideline: Material Design or iOS Cupertino. This enables the developer to follow platform-specific guidelines in the easiest possible way.

For example, Flutter does not have a Button widget; instead, it provides alternative button implementations for Google Material Design and iOS Cupertino guidelines. However, you can quite easily just choose one set of implementations to use in the development of your app and use that for all releases (such as the Play Store, the App Store, or the web). There is definitely no need to switch between Material and Cupertino depending on whether the app is running on Android or iOS.

## Buttons

Buttons are widgets that automatically accept a user interaction (such as a tap or a click) and call the relevant code or method supplied to them in their constructor.

On the Material Design side, Flutter implements the following button widgets:

- ElevatedButton: The ElevatedButton widget was previously named RaisedButton, but this name was deprecated for clarity. However, you might notice the use of the RaisedButton widget in old code examples, which is effectively the same widget. The ElevatedButton widget is a button that appears to hover slightly above the page.
- FloatingActionButton: As we mentioned earlier, a floating action button is circular, shows an icon, and hovers over the page, generally, in the lower-right corner, although the position can be configured. It is used to enact a primary action for the page it is shown on. For example, on a page showing email messages, the action button could have a plus icon on it denoting the ability to create a new email when it is pressed.
- TextButton: A text button is a string of text printed on a Material widget that will react to touch by showing the standard Material splash or ripple. Unlike an ElevatedButton widget, the TextButton widget does not appear to hover or looks raised above the page.
- IconButton: An icon button is a picture printed on a Material widget that, like the TextButton widget, will react to touch by showing a splash or ripple effect.
- DropDownButton: The DropDownButton widget is very similar to the drop-down buttons that you view on web pages. It shows a currently selected item alongside an arrow. Pressing the button will drop down a menu that allows the user to select another item.
- PopUpMenuButton: The PopUpMenuButton widget will pop up a menu of options to the user, allowing the user to take an action on the app.

For the iOS Cupertino style, Flutter provides the CupertinoButton class.

## Scaﬀold

Scaffold implements the basic structure of a Material Design or iOS Cupertino visual layout. Generally, you would use this as the root widget of your page because it allows you to lay out your whole page in a somewhat standard format.

For Material Design, the Scaffold widget can contain multiple Material Design components, such as the following:

- AppBar: The AppBar sits at the top of the device screen. Generally, it will hold a child widget containing text (the title of the page), which appears on the left, and then some action widgets, generally buttons, which appear on the right.
- body: The body is the main chunk of the page. It will appear below the AppBar (if you have one) and cover the whole screen.
- TabBar: Generally, the TabBar is just below the AppBar and allows the user to switch horizontally between several sub-pages of your page. For example, you might have a chat client and want the user to be able to switch between live messages and pinned messages. The TabBar will allow this to happen with a horizontal swipe.
- TabBarView: To work with a TabBar, you will need to define the views that appear as the user moves between the tabs. TabBarView fits that need and will need to match.
- BottomNavigationBar: BottomNavigationBar sits at the base of the device screen, allowing the user to switch between the top-level app views via a single tap.
- Drawer: Drawer is a panel that slides in from the side of the screen, allowing the user to quickly navigate around the app. Generally, you would use a bottom navigation bar for the main context changes (for example, to switch from email to the calendar), and then possibly use Drawer to navigate within that context (for example, to choose the inbox or spam folder within the email section). However, Flutter is not opinionated in terms of how you should lay out your app, so you are free to choose how to use these widgets yourself.

In iOS Cupertino, the structure is different with some specific transitions and behaviors.

The available iOS Cupertino classes are CupertinoPageScaffold and CupertinoTabScaffold, which are typically composed of the following:

- CupertinoNavigationBar: A top navigation bar, which is typically used with CupertinoPageScaffold
- CupertinoTabBar: A bottom tab bar, which is typically used with CupertinoTabScaffold

As you can see, the Cupertino Scaffold is far more limited in terms of its structure and features than the Material Scaffold. Generally, a good starting point to get a page of your app up and running is to use the Material Scaffold because it covers most of the needs of a page right from the start.

## Dialogs

A dialog pops over the top of the currently displayed UI as a modal window, and the display behind it is masked with a translucent gray mask. They are useful for popping short snippets of information, warnings, or errors.

Both Material Design and Cupertino dialogs are implemented by Flutter. On the Material Design side, they are SimpleDialog and AlertDialog; on the Cupertino side, there is CupertinoAlertDialog.

## Text ﬁelds

Text fields allow a user of your app to enter text using their device's keyboard.

Text fields are implemented in both guidelines by the TextField widget in Material Design and by the CupertinoTextField widget in iOS Cupertino. Both of them display the keyboard for user input. Some of their common properties are as follows:

- autofocus: This indicates whether the TextField should be focused automatically when it is shown (if nothing else is already focused on).
- enabled: This sets the field as editable or not.
- keyboardType: This changes the type of keyboard that is displayed to the user when editing. For example, if you only want the user to enter numbers, then the number pad is shown, or if you want the user to enter a password, then autocorrect is disabled.

We will look at TextField widgets in much more detail in Chapter 6, Handling User Input and Gestures, especially their use within an input format.

## Selection widgets

Selection widgets allow a user to select one or more answers to a question.

The available control widgets for selection in Material Design are as follows:

- Checkbox allows the selection of multiple options in a list.
- Radio allows a single selection in a list of options.
- Switch allows the toggle (on/off) of a single option.
- Slider allows the selection of a value in a range by moving the slider thumb.

On the iOS Cupertino side, some of these widget functionalities do not exist. However, there are some alternatives available, as follows:

- CupertinoActionSheet: This is an iOS-style modal bottom action sheet that enables you to choose one option among many.
- CupertinoPicker: This is a picker control that is used to select an item in a short list.
- CupertinoSegmentedControl: This behaves like a radio button, where the selection is a single item from an options list.
- CupertinoSlider: This is similar to Slider in Material Design.
- CupertinoSwitch: This is also similar to Material Design's Switch.

It is worth noting that there is no issue with mixing and matching widgets. If you decide that a Cupertino widget looks better than a Material widget, then feel free to use it within your app.

## Date and time pickers

For Material Design, Flutter provides date and time pickers through the showDatePicker and showTimePicker functions, which build and display the Material Design dialog for the corresponding actions via a dialog.

On the iOS Cupertino side, the CupertinoDatePicker and CupertinoTimerPicker widgets are provided, following the previous CupertinoPicker style.

## Other components

There are also design-specific widgets that are unique to each platform. Material Design, for example, has the concept of cards, which are defined in the documentation as follows:

"A sheet of Material used to represent some related information."

On the other side of things, Cupertino-specific widgets could have unique transitions present in the iOS world.

It is worth exploring further and then deciding on a design standard for your app. Consistency is probably more important for an app so that the user feels comfortable interacting with your app, so take the time to decide on your approach.

Now that you have an idea of the vast number of built-in widgets available in Flutter, the next natural question is to ask how you should control where they appear on the screen. We've seen a tiny glimpse of this through the Scaffold widget, but most of the content of the Scaffold is held in the body parameter, and that doesn't manage where its child widgets are shown on the screen. It seems we might need another type of widget, that is, a type that can manage the position of other widgets. So, let's take a look at those next.

## Layouts

Some widgets initially do not appear to have an effect on how the UI appears to the user. However, if they are in the widget tree, then they will be there somewhere, which affects how a child widget appears (such as how it is positioned or styled).

For example, to position a button in the bottom corner of the screen, we could specify a positioning that is relative to the screen. However, as you might have noticed, buttons and other widgets do not have a position property.

So, you might be asking yourself, "How are widgets organized on the screen?" Well, the answer is more widgets! Flutter provides widgets that allow you to compose the layout itself, with positioning, sizing, styling, and more.

Displaying a single widget on the screen is not a good way to organize a UI. Usually, we will lay out a list of widgets that are organized in a specific way; to do so, we use container widgets.

Let's take a look at the most common built-in layout types.

## Container

The simplest way to manage the layout of a widget is to place it as the child of a Container widget. Take a look at the following example:

```
Container(
  decoration: BoxDecoration(
    border: Border.all(),
  ),
  padding: EdgeInsets.all(14),
  child: Text(
    'Beautiful Teesside',
  ),
)
```

In this example, the Container widget will put 14 pixels of padding around itself, then place a border on all 4 sides, and then, finally, place the text of 'Beautiful Teesside' within the border.

The Container widget holds useful attributes, such as the following:

- padding: This indicates how much space should be placed around the container when laying it within the widget tree.
- margin: This indicates the amount of space to place around the child widget.
- decoration: This allows you to choose whether the Container widget should have a background image or color, whether it should have borders around it, whether the borders should have sharp or curved corners, and much more.
- height/width: This allows you to decide how much space the Container widget should take up on the screen.

Note that there are more specialized widgets that build on the generality of the Container widget.

## Styling and positioning

The task of positioning a child widget within a parent widget, such as a Stack widget, is done through other widgets. We've discussed the generic Container widget, but Flutter also provides widgets for very specific tasks.

Centering a widget inside a parent widget is achieved by wrapping the child inside a Center widget. Aligning a child widget relative to a parent can be done with the Align widget, where you specify the desired position through its alignment property. Another useful widget is Padding, which allows you to specify the amount of space around the given child.

The functionalities of these widgets are aggregated in the Container widget, which combines those common positioning and styling widgets to apply them to a child directly, making the code much cleaner and shorter.

## Row and Column

The most common containers in Flutter are the Row and Column widgets. They have a children property that expects a list of widgets to display in some kind of direction (that is, a horizontal list for Row or a vertical list for Column). You viewed a Column widget in the Hello World! app, so let's take a look at a Row example:

```
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text("Staithes"),
    Text("Saltburn"),
    Text("Whitby"),
  ],
)
```

In this example, a row of three pieces of text will be placed on the screen with an equal amount of space between them. Note that Row isn't great at managing overruns of space, so on a smaller device, you would need to add additional widgets or properties to ensure that the text is displayed correctly.

## What is with that trailing comma?

You might have noticed that when declaring lists, or passing arguments to constructors, we often have a trailing comma. Dart doesn't care whether your list has a trailing comma: [item1, item2] versus [item1, item2,]. However, there are a few reasons why you might choose to include a trailing comma. Firstly, adding items to a list is easier if there is already a comma present. Secondly, copying and pasting become much easier because every entry in the list has the same syntax. Thirdly, the Dart formatter automatically places each list entry onto its own line if there is a trailing comma at the end of the list.

## Stack

Another widely used widget is the Stack widget, which organizes children widgets in layers, where one child can overlap another child either partially or totally.

This appears similar to a Row or Column widget in that it takes a list of children widgets and layers them in the order they are defined. So, the first widget is effectively at the bottom of the stack, and the last widget is at the top, potentially covering the lower widgets.

## ListView and GridView

If you have developed some kind of mobile application before, then you might have already used lists and grids. Flutter provides classes for both of them, namely, the ListView and GridView widgets.

ListView is very similar to a Column widget; however, it is designed to be scrollable and also draw widgets on demand. For example, if you have a list of more than 10 widgets, such as a list of songs or films, then for performance reasons, you might not want to draw all of the widgets to the screen. ListView allows you to draw these widgets as they arrive on the screen due to scrolling or orientation changes, using the ListView.builder constructor. We will look at this in more detail in later chapters.

GridView is also very similar but creates grids of widgets rather than simple lists. It also has the on-demand ability of ListView.

In addition to this, other less typical, but nonetheless important, container widgets are available, such as Table, which organizes children in a tabular layout.

## Other widgets (gestures, animations, and transformations)

Flutter provides widgets for anything related to the UI. For example, gestures such as scroll or touch will all be related to a widget that manages gestures. Animations and transformations, such as scaling and rotation, are also all managed by specific widgets. We will be examining some of them in more detail in the following chapters.

Now that we've learned how to display a UI and interact with the user, there is another key concept to understand that allows your app to better react to other external changes, that is, streams.

# Streams

As its name suggests, a Stream is simply a stream of data that your app can react to. For example, a stream is used to allow your app to respond to user authentication changes, which we will explore, in further detail, in Chapter 9, Popular Third-Party Plugins. That stream shares updates to a user's authentication status. To use the stream, you register to listen to the Stream instance and supply a function that will be called when there is new data added to the stream.

Throughout third-party plugins, especially Firebase plugins, you will see the regular use of streams so that the plugins can effectively call back into your code to tell you something has changed. They are very similar in concept to the use of a callback method, which is passed to the data source and called on data changes.

As a very brief example to give context to this idea, let's take a look at an example of a stream that gives updates when the weather forecast changes. Let's suppose a plugin supplies us with a WeatherService class. We might write some code like this:

```
WeatherService.onForecastChange().listen((Forecast fct) {
    if (fct.sunny) {
      print("Yay, beach weather!");
    } else {
      print("Time to get the board games out!");
    }
  });
```

In this example, we call the onForecastChange() method on WeatherService, which returns a stream. Then, we call the listen() method on the returned stream and pass in an anonymous function as an argument to the listen() method. The anonymous function accepts a Forecast instance as a parameter.

Now, every time the forecast changes, WeatherService will put a new Forecast instance onto the stream, and the anonymous function will be triggered, printing out the "sunny" or "not sunny" message.

The use of streams is very powerful because it allows you to create a very reactive app. Your app will not only react to user inputs, but it will also react to other external changes such as database updates, authentication changes, third-party service updates (such as the Weather Forecast service), or device sensor updates (such as orientation), among many other things.

# Summary

In this chapter, you looked at the different types of widgets, such as stateless, stateful, and inherited, which are classes that inherit from the built-in widget type of classes. You examined the differences between the types, when to use each type, and how to make use of the features of each type.

Next, you explored the built-in widgets that are available as part of the Flutter framework, including layout widgets that help structure the UI.

One of the key aspects of the Flutter community is the plugins and packages that are created. As part of this, we explored streams to demonstrate one of the ways that updates can be shared with your app. We will explore plugins and packages, in further detail, in later chapters.

You should now have a better understanding of how Flutter apps are put together; however, as you can imagine, there's still a lot to explore. In the next chapter, we will take a further look at how users interact with Flutter apps.

