원본 제목: Chapter 7: Routing – Navigating between Screens
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/207
Title:
207 Routing – Navigating between Screens
Short Description:
Flutter for Beginners Second Edition 라우팅 – 화면 간 탐색

- cut line


# Chapter 7: Routing – Navigating between Screens
Flutter for Beginners Second Edition

Mobile apps are typically organized into multiple screens or pages. You will have seen this when you use many mobile apps. For example, perhaps an app has an initial list view of items (such as groceries or films), and when you choose one of the items, you are taken to another screen or page where more details are shown about the item. When you do this, you have just navigated from one screen to another.

In Flutter, moving between screens is called a route and is managed by the Navigator widget of the application. The Navigator widget manages the navigation stack, pushing a new route onto the stack or popping a previous one off. In this chapter, you will learn how to use the Navigator widget to manage your app routes, how to add transition animations, and how to pass information (state) between screens.

The following topics will be covered in this chapter:

- Understanding the Navigator widget
- Understanding routes
- Screen transitions
- Passing data between screens

By the end of this chapter, you will be able to create an app with several screens and manage the routes between them. You will be well on the way to having the skills to create a useable Flutter app!

# Technical requirements

You will need your development environment again for this chapter. Look back at Chapter 1, An Introduction to Flutter, if you need to set up your IDE or refresh your knowledge of the development environment requirements.

You can find the source code for this chapter on GitHub at the following link: https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/lib/chapter_07.

# Understanding the Navigator widget

Mobile applications will often contain more than one screen. If you are an Android or iOS developer, you probably know about Activity or ViewController classes that represent screens on those platforms.

An important class for navigation between screens in Flutter is the Navigator widget, which is responsible for managing screen changes while maintaining a history of screens so that the user can move back through screens (if the app allows it).

A new screen in Flutter is just a new widget that is effectively placed on top of another. This is managed through the concept of routes, which define the possible navigable routes a user can follow through the app. As you may already have guessed, the Route class is a helper for Flutter to work on the navigation workflow.

The main classes in the navigation layer are as follows:

- Navigator: The Route manager.
- Overlay: Navigator uses this to specify the appearances of the routes.
- Route: A navigation endpoint.

We will explore these different classes in the next few sections, but first, we need to look at how the actual approach to navigation has changed as Flutter has evolved.

## Navigator 1.0 and 2.0

As Flutter has moved to the web, and generally evolved to be a more complete app development framework, the way that app navigation between screens is structured has changed, and now there are two different available ways to navigate.

Navigator 1.0 worked in an imperative style; the code flow instructed the framework to add or remove screens from the stack. This works nicely for most apps, especially within iOS or Android environments, and is a simple approach that is easy to understand and follow.

However, the web introduces new challenges around direct links deep within the app that are designated through specific URLs. In an iOS or Android app, you generally expect a user to enter through the first screen of the app and navigate from there. However, on the web, you may share a web URL that links to a specific screen within the web app. For example, suppose you are browsing a book-selling website and share a link for a single book. You would expect the person you shared it with to be able to go directly to that web page while still having the stack of expected screens that they would have followed to get to that page (in this case, the book list page) available to them.

This is not a web-specific scenario; the same is true for deep links within iOS or Android apps, but it becomes more obvious in web apps that the Navigator 1.0 approach is not as well suited to a world where people can enter your app on any screen.

Navigator 2.0 follows a declarative style that is similar to the approach used within a widget tree; the screens available are declared upfront and the state decides which ones are shown to the user.

We will explore both approaches as both are supported and entirely acceptable ways to build your app. Many in the community believe that the naming was unhelpful because it implies that Navigator 2.0 supersedes the original navigator approach. This is generally not true and, additionally, Navigator 2.0 can be a much more complicated way to start your Flutter development.

### Imperative versus declarative

Imperative and declarative are different ways of writing your code. There is no right or wrong choice, and different situations may suit a specific choice. In coding, you can specify code that becomes active based on the world state (declarative) or you can instruct code to run (imperative).

A way to think about the difference is perhaps to think of a parent organizing lunch for a young child. The parent has effectively declared that at a set time of the day, they will make lunch. When the state of the world changes (that is, time passes), the parent assesses the state change and if it matches their declared intent, then they make lunch. Nothing has told the parent to make the lunch; it was a change in the world state that triggered their lunch-creating activity. On the flipside, the child is told to eat their lunch when it is ready, perhaps using a verb in the imperative form to instruct the child: "Eat your lunch."

To complete the example and show that either option is fine, imagine an alternative scenario where the adult has set an alarm to instruct them to make the lunch (imperative) and the child has declared that they will eat food whenever it is placed on the table (declarative). This is also an acceptable scenario.

## Navigator

The Navigator widget is the key to moving a user from one screen to another. Most of the time, the user will change screens and need their data to be passed along to the new screen. This is another important task for the Navigator widget.

Navigation in Flutter is conceptually a stack of screens:

- We have one element at the top of the stack. In Navigator, the topmost element on the stack is the currently visible screen of the app.
- The last element inserted is the first to be removed from the stack, commonly referred to as last in first out (LIFO). The last screen visible is the first that is removed.
- The Navigator widget has push() and pop() methods to add and remove screens from the stack. This is the imperative, Navigator 1.0 style; the navigator is being told to add or remove screens.
- The Navigator widget has a pages property where, much like a stack containing a list of widgets, the pages are listed and shown or removed based on the state of the containing widget. This is the declarative, Navigator 2.0 style; the screens listed in the pages property are shown or not based on state rather than being told to show or not.

Let's take a look at the Navigator 1.0 approach.

## Navigator 1.0

The Navigator 1.0 approach has been in use since Flutter was created, and the vast majority of code examples available use the Navigator 1.0 approach to navigate between screens. Therefore, it is important to know this approach to navigation, and in many cases, it will be the best fit for your app anyway due to its simplicity.

Let's look at how we would use this approach to navigation, first by understanding what a Route is.

### Route
The navigation stack elements are Routes, and there are multiple ways to define them in Flutter.

When we want to navigate to a new screen, we define a new Route widget to it, in addition to some parameters defined as a RouteSettings instance.

### RouteSettings

This is a simple class that contains information about the route relevant to the Navigator widget. The main properties it contains are as follows:

- name: Identifies the route uniquely. We will explore this in detail in the next section.
- arguments: With this, we can pass anything to the destination route.

### MaterialPageRoute and CupertinoPageRoute

The Route class is a high-level abstraction, but different platforms may expect screen changes to behave differently. In Flutter, there are two main alternative implementations that align with platform expectations: MaterialPageRoute and CupertinoPageRoute, which adapt to Android and iOS respectively.

So, you must decide when developing an application whether to use the Material Design or iOS Cupertino transitions, or both, depending on the context.

### Putting it all together

It is time to check out how to use the Navigator widget in practice. Let's extend the hello world! example to have a basic flow that navigates to a second screen and back.

Firstly, let's create a widget that we can use as the second screen. In your main.dart, add a new widget that looks something like this:

```
class AnotherScreen extends StatelessWidget {
  AnotherScreen({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text(title),
          onPressed: () {
            // To be added
          },
        ),
      ),
    );
  }
}
```

This is a simple Stateless widget that takes a single String parameter named title and has the build method defined. You should be starting to get familiar with widget trees, but let's step through this build method as a refresher.

The Scaffold widget is at the top level and can be used to specify the app bar at the top of the screen, the body of the screen, and other items such as floating action buttons. It also has the benefit of being a Material widget, which means that child widgets can also be Material widgets.

We then have a Center widget, which simply centers the child widget within the Center's parent widget, and finally, we have an ElevatedButton widget, which is where the magic will happen. It has a simple Text widget as a child (which takes the title parameter as the text to display), and the onPressed handler, which we will look at shortly.

Let's now add a route to this new page. Within the build method of the _MyHomePageState class, you will see the Column widget. Make a change to its children property to add an ElevatedButton, as shown here:

```
children: <Widget>[
  ... // Text widgets
  ElevatedButton(
    child: Text('Press this'),
    onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return AnotherScreen(title: "Go back");
        }),
      );
    },
  ),
],
```

Much like the ElevatedButton we looked at before, this ElevatedButton has a child Text widget and an onPressed handler. This time we have added code to the handler that will change the screen. Let's look at that line by line:

```
Navigator.of(context).push(
```

You may recognize this structure from Chapter 5, Widgets – Building Layouts in Flutter, where we explored InheritedWidgets. The Navigator widget is an inherited widget, which means you can find it by searching the context to retrieve it. There is an implicit Navigator created within the MaterialApp widget, so this is looking up the tree and finding the Navigator associated with the MaterialApp widget and returning it.

We then choose to push() an entry onto the Navigator. As you saw previously, the Navigator is like a stack, so we are pushing a new screen onto the stack so that it appears over the existing screen.

We pass the push method a MaterialPageRoute:

```
MaterialPageRoute(builder: (context) {
```

This holds the information about the new screen that we want to draw, and the contents of the new screen are returned as part of the builder property on the MaterialPageRoute.

Finally, we return the widget for the new screen:

```
return AnotherScreen(title: "Go back");
```

This specifies that when the route is drawn using the builder property, we want the AnotherScreen widget to be drawn.

With this all in place, you can try your first navigation to a new screen! Click the Press this button and you should navigate to a new screen with the Go back button showing. However, the Go back button has no code within its onPressed method, so let's go back and fix that. If you leave the code running, then you can take advantage of hot reloading.

Set the following code as the onPressed method on the ElevatedButton of the AnotherScreen class:

```
onPressed: () {
  Navigator.of(context).pop();
},
```

This looks similar to the use of Navigator above, but instead of the push method, we now use the pop() method to remove the current screen from the navigator stack and effectively go "back" to the previous screen.

Save this change, enjoy the wonder of hot reloading, and then check whether you can get back from the second screen to the first.

### Getting the Navigator

You may see code examples where the Navigator call looks slightly different. Instead of Navigator.of(context).pop(), you may see Navigator.pop(context). These are effectively equivalent because the first line of code in Navigator.pop(context) is to find the Navigator using Navigator.of(context). Use whichever approach feels more comfortable to you.

Well done – you've set up your first navigation. The world is now your oyster! Hopefully, you can now see how a multi-screen app can be built and that, although the syntax can seem a little intimidating at first, it actually all makes sense. Note that this is clearly an imperative approach to navigation; you are instructing the navigator to change pages through the use of push and pop.

There is another way to use the imperative approach, which uses named routes.

### Named routes

The route name is an important piece of navigation. It is the identification of the route with its manager, the Navigator widget.

We can define a series of routes with names associated with each of them. It provides a level of abstraction to the meaning of a route and a screen. In addition, they can be used in a path structure; in other words, they can be seen as subroutes in the same way a web URL is structured.

### Moving to named routes

Our previous example of navigating was very simple, but we can better organize the navigation structure through the use of named routes, allowing us to do the following:

- Organize the screens in a clear way
- Centralize the creation of screens
- Pass parameters to screens

Named routes are specified on the MaterialApp widget, so let's modify the hello world code to use named routes.

Firstly, update the MaterialApp widget so that it has a routes property that looks like this:

```
routes: {
  '/': (context) => MyHomePage(title: 'Flutter Demo Home   Page'),
  '/screen2': (context) => AnotherScreen(title: "Go back"),
},
```

In this code, we have specified that there are two routes available within the app. The '/' route, which will use the MyHomePage widget to draw the screen, and the '/screen2' route, which will use the AnotherScreen widget to draw the screen.

If you try to run the code as it is now, you will get an error because you now have both the '/' route and the home property set on the MaterialApp. The '/' route is a special route that is equivalent to the home of the app, so you are effectively defining home twice and Flutter doesn't know which one should be used.

So, go ahead and remove the home property and try running the app; it should work now. Note that the navigation still works without routes because ultimately you are still adding and removing screens to the navigation stack, whether you choose to use routes or not.

Finally, let's change the navigation so that it uses the route. In the ElevatedButton of _MyHomePageState, edit onPressed so that it looks like this:

```
onPressed: () {
  Navigator.of(context).pushNamed("/screen2");
},
```

Notice how much cleaner the code feels, and the intent of the navigation is clearer. The creation of a MaterialPageRoute is now implicit.

Save the update, let the hot reload work its magic, and then check that the navigation flow still works correctly. pop() continues to work as before; pushNamed still just adds a screen to the stack, so the pop will simply remove that screen as expected.

### Arguments

You may notice that now our title for AnotherScreen is always going to be the same. This often isn't the behavior you would want; you would expect the calling screen to be able to set the arguments of the screen that is being navigated to.

To solve this problem, the pushNamed method also accepts arguments that are passed to the route. Make the following change to your onPressed method in the ElevatedButton:

```
Navigator.of(context).pushNamed('/screen2', arguments: "Go back again");
```

However, life is not so simple now, and the routes parameter of MaterialApp can no longer be used. Instead, we need to use the onGenerateRoute parameter to pass the settings to the AnotherScreen widget.

On your MaterialApp widget, remove the routes parameter and add onGenerateRoute so it looks like this:

```
onGenerateRoute: (settings) {
  if (settings.name == '/') {
    return MaterialPageRoute(builder: (context) =>    MyHomePage(title: "Flutter Demo Home Page"));
  } else if (settings.name == '/screen2') {
    return MaterialPageRoute(builder: (context) =>    AnotherScreen(title: settings.arguments as String));
  }
},
```

The onGenerateRoute code looks at the settings.name to see which route was selected and then returns a MaterialPageRoute with the details required for that route. This looks very similar to the code that we had when we were using the push method instead of pushNamed, but has the obvious disadvantage that we've lost type safety on settings.arguments and have to hope the cast to String works correctly.

Should I use named routes?

Whether you choose to use named routes is your choice – there is no right answer because the choice will be based on personal opinion.

Personally, I prefer to use the push() method because it has strong type safety on the constructor parameters of the widget within the route. However, if you are not passing arguments to the routes, or you prefer the style of having central route management, then you may choose named routes.

So, we've seen how to move to a route using push and pushNamed, and how to pass arguments to those routes. However, there will be situations where we want to return a result to the calling screen during a pop(), so let's look at that next.

### Retrieving results from Route

When a route is pushed to the navigation, we may want to expect something back from it—for example, when we ask for something from the user in a new route, we can take the value returned via the pop() method's result parameter.

The push method and its variants return a Future. The Future resolves when the route is popped and the value of Future is the pop() method's result parameter.

We have seen that we can pass arguments to a new Route. As the inverse path is also possible, instead of sending a message to the second screen, we can take a message when it pops back.

Let's update AnotherScreen so that the user can make a choice. In the build method, update the Center widget so that the child is a Column holding two ElevatedButtons like this:

```
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text(title),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
          ElevatedButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
        ],
      ),
    ),
  );
}
```

You will notice that, apart from the slight widget tree change to accommodate the extra ElevatedButton, pop() now takes an argument. In this case, it is a bool, but any type can be returned via the pop method.

Now we need to update the code in onPressed of ElevatedButton in MyHomePage so that it can receive the returned value.

Let's look at how we could do that with this example code. Note that the example has moved back to use push rather than pushNamed for navigation. Feel free to revert your code back to the earlier example of routes using push:

```
ElevatedButton(
  child: Text('Press this'),
  onPressed: () async {
    bool? outcome = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AnotherScreen(title: "Go back");
      }),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$outcome")),
    );
  },
),
```

The result of push is a Future, so our code will need to wait for the result and it specifies this through the await keyword. That means we also need to update the method signature of the anonymous function we are supplying to onPressed to specify that it is an asynchronous function. We do this with the async keyword between the parameters list in the round brackets (which is empty) and the method body in the curly brackets.

Finally, we use a very useful Flutter feature, SnackBar, to pop the result to the screen. ScaffoldMessenger is an InheritedWidget, so we use the now-familiar <type>.of() syntax to find it, and then use it to show a snack bar (a notification that slides up from the bottom of the screen). The showSnackBar method simply takes a SnackBar widget as its parameter, which we have specified as having a child widget of the Text type containing the outcome value.

If you need to refresh your knowledge of working with Futures, take a look back at Chapter 4, Dart Classes and Constructs.

As you can see, Navigator 1.0 is a fully featured and intuitive navigation system that you can easily add to your app to allow users to navigate around easily. The use of the inherited Navigator widget, alongside routes, is simple to understand and implement. I'll be honest and say I have used Navigator 1.0 for all my apps and have only occasionally found a limitation. However, there are some situations when Navigator 1.0 doesn't quite fit the requirements, especially in the world of the web, so let's take a look at Navigator 2.0.

## Navigator 2.0

As mentioned previously, the Navigator 1.0 approach had some limitations around building screen stacks on deep linking, and this is most apparent on web-based apps. Therefore, Navigator 2.0 was created and takes a different, declarative, approach to navigation.

Let's start by looking at Pages, the key part of Navigator 2.0.

### Pages

The Navigator has a parameter called pages that takes a list of Page widgets. As this list changes, due to changes in state, the stack of routes is updated to match the pages list.

This is very similar to how other widgets that compose a list of children widgets work. For example, a Column widget will have children widgets that it composes into a column to display on the screen. If the state changes, and this means the children widgets in the Column change, then Flutter will redraw the column on the screen with the updated widgets.

The big advantage of this approach is that if you start with a pre-defined state that involves a stack of several screens (for example, a deep web URL link into your app), then this will work automatically by having several Page entries in the pages parameter right from the start. Previously, bespoke solutions , such as passing the initial state from parent to child widgets, would be needed with a potentially clunky startup as the app worked its way through the routes to the page that was requested.

### Navigator 2.0 in action

As it is generally considered a more complicated approach to app navigation, we will not go into too much depth on the Navigator 2.0 approach, but it is useful to know it exists and to get a general feel for it so that once you are more confident in your Flutter knowledge, you can investigate the approach more fully.

In this example, we will pick out how the hello world! app would be changed to suit a Navigator 2.0 approach. We will add some simple changes to allow someone to see a list of towns and to click a button to view further details on that town.

The first change will be to the MyApp widget. In the hello world! app, it is currently a stateless widget, but with Navigator 2.0, the navigation uses state to determine which pages should be on the stack, so we need to convert it to a stateful widget:

```
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  String? _selectedTown;
  …
}
```

We've also introduced a class field named _selectedTown. Note the underscore at the start of the name to ensure the field cannot be accessed outside of the class. This field will hold the name of the town selected, or null if no town is selected.

Next, we need to create a widget that will form the page shown when a town is selected. The widget is pretty standard; it has a title parameter and displays the title and a Close button within a column:

```
class TownScreen extends StatelessWidget {
  TownScreen({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            ElevatedButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
```

Additionally, it has a navigator pop() method, as you would expect in Navigator 1.0. What this does in the navigator is very different, as we will see next.

Next, because the state is on MyApp and not on MyHomePage, when a town is selected, the buttons on MyHomePage will need to have a way to update the state on MyApp, and specifically to set the _selectedTown field to the correct value.

To achieve this, we need to add a callback method within MyApp that can be passed to MyHomePage as a parameter:

```
void _setTownName(String townName) {
  this.setState(() {
    _selectedTown = townName;
  });
}
```

This method simply takes townName as a parameter and uses the value to set the state of the MyHomePage widget.

We then need to make use of this callback in MyHomePage by adding it as a parameter within the constructor and a field on the class:

```
MyHomePage({required this.title, required this.townNameCallback});
final void Function(String) townNameCallback;
```

Then, use this parameter within the new town buttons to correctly set the state. These two buttons have been added to the column within MyHomePage:

```
ElevatedButton(
  child: Text('Whitby'),
  onPressed: () {
    widget.townNameCallback("Whitby");
  },
),
ElevatedButton(
  child: Text('Scarborough'),
  onPressed: () async {
    widget.townNameCallback("Scarborough");
  },
),
```

They both call the callback method and specify the name of the town that has been selected, therefore setting the state on MyHomePage.

Finally, we need to update MaterialApp to use two new parameters – pages and onPopPage:

```
MaterialApp(
  title: 'Flutter Demo',      
  home: Navigator(
    pages: [
      MaterialPage(
        child: MyHomePage(
          title: "Press this",
          townNameCallback: _setTownName,
        )),
      if (_selectedTown != null)
        MaterialPage(
          child: BookScreen(title: _selectedTown!),
        ),
     ],
     onPopPage: (route, result) {
       if (!route.didPop(result)) {
        return false;
       }
       setState(() {
         _selectedTown = null;
       });
       return true;
     },
  ),
  ...
);
```

Let's look at the pages parameter first. As you can see, it holds a list of two pages: one containing the MyHomePage widget, which takes in the callback as a parameter, and one containing the BookScreen widget, which takes in the _selectedTown value as a parameter.

What is important to note here is that the page containing BookScreen is only added to the pages list if the _selectedTown value is not null. Therefore, when the _setTownName callback is called and a town name is set, the flow is very much like the build flow within a widget where the pages list is re-evaluated and the BookScreen page is added to the list.

Now let's look at onPopPage. In this method, we tell the navigator what to do when a page is popped. The first action has to be to check whether the pop was successful. Assuming that is the case, then we can assume the pop came from BookScreen and by nulling the _selectedTown value, the BookScreen page will be removed from the pages list and MyHomePage will be visible again.

Further Navigator 2.0 learning

The example shared here is incomplete because the use of the back button and changes to the route from the underlying platform are not handled. If you want to complete the example, then good documentation can be found here: https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade.

There are plugins that can simplify the Navigator 2.0 approach and we will look at those in Chapter 9, Popular Third-Party Plugins.

For the examples within the rest of the book, we will focus on Navigator 1.0 as it is simpler and will allow us to focus on the area being explored without being confused by Navigator 2.0 boilerplate code.

Now that we have explored moving users between screens at the code level, let's next explore the move between screens at the user interface level.

# Screen transitions

Changing screens needs to look smooth for the user. You want the user to enjoy their experience within your app, and jarring screen transitions can impact their enjoyment and flow.

As we have seen, MaterialPageRoute and CupertinoPageRoute are classes that add a route to the navigator and you may have noticed as we experimented with the example app that they add a transition between the old and new Route. These transitions align with the platform defaults but can be customized as well.

On Android, for example, the entrance transition for the page slides the page upward and fades it in. The exit transition does the same in reverse. On iOS, the page slides in from the right and exits in reverse.

Flutter lets us customize this behavior by adding our own transitions between screens. To do this, we need to look a little deeper at routes.

## PageRouteBuilder

PageRouteBuilder is a helper class that can be used for custom Route creation, instead of using the pre-built route subclasses of MaterialPageRoute and CupertinoPageRoute.

- PageRouteBuilder contains multiple callbacks and properties to help in the PageRoute definition. Here are its key parameters:
- transitionsBuilder: This is where we specify the callback for the transition animation. Specifically, a builder function that returns a widget.
- pageBuilder: This is where we specify the callback that draws the page we are transitioning to, specifically, a builder function that returns a widget.
- transitionDuration: The duration of the transition.
- barrierColor and barrierDismissible: These define partially covered routes of the model and not for the fullscreen of the app.

Using these parameters, you can create your own route instance with your own custom transitions.

## Custom transitions in practice

Let's first modify ElevatedButton on _MyHomePageState so that instead of creating a MaterialPageRoute, we use PageRouteBuilder.

As a reminder, this is what the button looks like with a standard MaterialPageRoute:

```
ElevatedButton(
  child: Text('Press this'),
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return AnotherScreen(title: "Go back");
      }),
    );
  },
),
```

Within the onPressed parameter, we passed an anonymous function that returned a MaterialPageRoute. Within the MaterialPageRoute, we returned the base widget of the next screen – in this case, the AnotherScreen widget.

Let's change the onPressed argument so that it creates a custom route:

```
ElevatedButton(
  child: Text('Press this'),
  onPressed: () async {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation)        => AnotherScreen(title: "Go back"),
        transitionsBuilder: (context, animation,        secondaryAnimation, child) {
          return child;
        },
      ),
    );
  },
),
```

Instead of simply pushing a MaterialPageRoute onto the navigator stack, we have now pushed the PageRouteBuilder onto the stack, which extends Route.

We have added the AnotherScreen widget as the return value from the pageBuilder anonymous function, and simply return the child widget from the transitionsBuilder anonymous function.

If you run this code, you will see that there is no transition between pages because our transitionBuilder anonymous function doesn't do anything. So, let's change the default transition to use a slide transition. To do this, we need to change the transitionsBuilder anonymous function:

```
PageRouteBuilder(
  pageBuilder: (context, animation, secondaryAnimation) =>  AnotherScreen(title: "Go back"),
  transitionsBuilder: (context, animation, secondaryAnimation,  child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  },
)
```
Here, instead of simply returning the child widget, we return a SlideTransition widget that encapsulates the animation logic for us: a transition from left to right, until it becomes fully visible. The child widget is nested inside SlideTransition, so the contents of your new page slide over the previous screen because it is contained within the SlideTransition widget. Note that when you go back to the previous screen (by popping the top route off the navigator stack), the animation runs in reverse.

You will see a little complication around the Tween and Offset classes. We have not checked out animations in detail yet, so they will look new to you. We will explore this in more detail in Chapter 10, Using Widget Manipulations and Animations.

If you are planning to use the same transition for every page, then a useful approach would be to extend the PageRouteBuilder class and create a reusable transition that you could add to the code as easily as a MaterialPageRoute or CupertinoPageRoute. This will allow you to avoid duplicated code, and make app-wide changes to transitions if you need to.

For example, suppose you wanted to use SlideTransition throughout your app. Then, you could make your custom MySlideTransition class and extend PageRouteBuilder:

```
class MySlideTransition extends PageRouteBuilder {
  final Widget transitionPage;
  MySlideTransition({required this.transitionPage})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) => transitionPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}
```

In this class, we have a single constructor parameter named transitionPage, which is the widget of the page we are transitioning to. As part of the constructor, the class sets the argument of the parent PageRouteBuilder parameter, pageBuilder,to simply return transitionPage and sets the transitionsBuilder argument as the SlideTransition we experimented with before.

Therefore, whenever an instance of MySlideTransition is created, it will automatically call the superclass constructor of PageRouteBuilder and set the two parameters to the anonymous functions we were previously specifying on each individual transition.

Now, within our ElevatedButton code, we can very easily specify the onPressed function to be the following:

```
ElevatedButton(
  child: Text('Press this'),
  onPressed: () {
    Navigator.of(context).push(
      MySlideTransition(
        transitionPage: AnotherScreen(title: "Go back"),
      ),
    );
  },
),
```

We just need to add our own custom route widget to the navigator stack and we automatically get SlideTransition.

There are many different transitions you can try that have built-in classes, such as the following:

- ScaleTransition: The new screen enlarges over the previous screen.
- RotationTransition: The new screen spins as it overlaps the previous screen.
- FadeTransition: The new screen fades in over the previous screen.

You would simply replace the SlideTransition widget with one of these other widgets to get the desired effect.

Now we have looked a lot at how we move between screens, we also need to explore how we take application state with us.

# Passing data between screens

In almost all apps, there is the concept of application state. This is larger than the state within one widget as it travels with the user throughout the app. If you have worked with other frameworks, you will have seen varying ways to hold application state, and Flutter doesn't have a single way to hold and share state.

We will look at options for how to store application state long term in Chapter 9, Popular Third-Party Plugins, but once the state has been retrieved from storage, how should you share that state among your many different application screens?

It's worth noting that there is no right or wrong answer for state management, but every approach has benefits and weaknesses and you will need to decide which approach suits you from a maintenance, code readability, and app usage perspective.

## Passing state in widget parameters

The simplest way to share state around your app, and probably the way most developers start managing state with Flutter, is simply to pass it to each screen within the constructor parameter.

For example, suppose that when a user logs in to your app, you create an instance of your own User class that holds important information. You can then simply pass that instance to any screen through a constructor parameter.

The obvious benefit of this approach is that it is very simple to get up and running a prototype of an app. When you want to try out a new framework or try out an app idea, then this approach is fine.

There are, however, many drawbacks with this approach:

- If you decide a screen needs some extra state information that is currently not available to it, then all intermediate screens will need to be updated to pass that state to the screen.
- You cannot naturally listen for changes to the state and make the pages (including those already on the stack but not active) automatically update and reflect the changes.
- Long-running asynchronous activities such as listening on database updates do not have a natural place to live and may get bundled into the state classes.

For the examples within this book, we will follow this approach as it keeps the code simple and clear, but as you create a more complex app and become more comfortable with Flutter and Dart, here are a few recommendations on where to look next for state management.

## InheritedWidget

We've seen the use of InheritedWidgets several times within this chapter and previous chapters. Specific examples have been for finding the Navigator and ScaffoldMessenger. You achieve this using the <type>.of(context) syntax, which searches the context for the first instance of the specified type.

This approach can be used with state, allowing you to search the context for the state information you require. This specifically alleviates one of the drawbacks of the parameter-based approach previously mentioned because intermediate screens that have no interest in specific state information do not need to accept it in their parameters just so they can pass it to a child widget.

## BLoC

The BLoC (Business Logic Components) approach uses a streams approach to sharing state information. Your widgets listen to their chosen state information streams and are told when the state has changed so that they can choose how to deal with that state change when it happens.

This fits very nicely with the Flutter declarative approach because when the app state changes, the widget is notified and can choose to update its own internal state if the app state change is relevant. By updating its internal state, it will then trigger a build call and render any changes to the user.

Personally, I use the BLoC pattern for all my apps that have gone beyond proof of concept. Additionally, the BLoC pattern works really well for listening on external systems such as databases or network requests because the listener logic sits within the BLoC and manages updates to the app state as needed.

## Redux

The key difference between Redux and BLoC is that Redux has one state object that manages all the app states, whereas BLoC has a set of BLoCs that deal with different areas of the app state.

There are three main concepts in Redux:

- Store – This is where the app state is stored.
- Action – Information about an intention to change the state.
- Reducer – Calculates the next app state based on an action.

## Other options

As you can see, there are already many app state management solutions available, but for completeness, here are some other key ones if you don't prefer to use the ones listed previously:

- Binder
- Flutter commands
- GetIt
- MobX
- Riverpod

The latest options available are listed on the Flutter site at the following link:

https://flutter.dev/docs/development/data-and-backend/state-mgmt/options

# Summary

In this chapter, we have explored the concept of screens within an app and seen how to add navigation between them. First, we got to know the Navigator widget, the main player when it comes to navigation in Flutter. We have seen how it composes the navigation stack or history by using the Overlay class.

We have also seen another important piece of navigation, Route, and how to define it for use in our applications. We checked out different approaches to implement the navigation, with the most typical way being with the MaterialPageRoute widget.

We also explored the new Navigator 2.0 approach to get a feel for how this declarative approach to screen management contrasts with the Navigator 1.0 imperative approach.

Finally, we briefly explored app state management and some of the common approaches. This is a rich area that you should explore when you become more confident with Dart and Flutter.

In the next chapter, we start to look at another part of the framework that allows Flutter developers to get an app up and running quickly – the wonderful world of Flutter plugins.

