
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

> [ 06 C4 Flutter Web under the Hood ](/packtpub/taking_flutter_to_the_web/06_c4_flutter_web_under_the_hood) <---> [ 08 C6 Architecting and Organizing ](/packtpub/taking_flutter_to_the_web/08_c6_architecting_and_organizing)

# 07 C5 Understanding Routes and Navigation

In the previous chapter, we learned how Flutter works under the hood to produce applications for different platforms, especially for the web. We also learned about different renderers available to build web apps, and how and when to use them. In this chapter, we will start learning about routing and navigation. We will also implement navigation in our Flutter Academy application.

By the end of this chapter, you will understand how to use routes and how to navigate between different screens. You will also learn how to use these principles to add navigation to our application. You will learn about the Navigator 2.0 API and how it’s useful for web applications. We will then change our application to use Navigator 2.0, allowing us to use navigation effectively, which will include parsing URLs received from the web browser and updating the navigation stack based on the URL.

In this chapter, we will cover the following main topics:

- The basics of navigation in Flutter
- An introduction to Navigator 2.0
- Implementing Navigator 2.0 in our app

# Technical requirements

The technical requirements for this chapter are as follows:

- Flutter version 3.0 or later installed and running
- Visual Studio Code or Android Studio
- Google Chrome browser

You can download the code samples for this chapter and other chapters from the book’s official GitHub repository at https://github.com/PacktPublishing/Taking-Flutter-to-the-Web. The starter code for this chapter can be found inside the `chapter5_start` folder.

# The basics of navigation in Flutter

Any production-level application requires multiple pages on which to display information. In order to manage multiple pages, we need to provide proper navigation support for users. Flutter provides different APIs for navigation. In this section, we will look at the imperative navigation API provided by an early version of Flutter, which is still effectively used. There are some shortcomings of this type of navigation, which is why the new declarative navigation API was introduced. We will look into these shortcomings, and in the next section, we will look at the new declarative navigation API.

To use Flutter’s imperative navigation, we need to understand two terms:

- **Navigator**: `Navigator` is a widget that manages a stack of `Route` objects.
- **Route**: Route is an object managed by `Navigator` that represents a screen. This is typically implemented by classes such as `MaterialPageRoute`.

When using imperative navigation, we use various static methods provided by `Navigator` to push and pop routes in Navigator’s stack. The routes can be anonymous or named. Anonymous routes, which are still the most suitable for mobile applications, can display screens on top of each other like a stack, and can easily be achieved using Navigator.

`MaterialApp` and `CupertinoApp` already use Navigator under the hood. Navigator can be accessed using `Navigator.of()` or a new screen can be displayed usin`g Navigator.push()`, and by using `Navigator.pop()`, we can return to the previous screen.

As we are using `MaterialApp`, we can easily use this Navigator API. Let’s see how to navigate to the **About** page using simple anonymous route:

1. Open `lib/widgets/top_nav.dart` and in `TextButton` with the **About** text, update the `onPressed` action as follows:
```
onPressed() {
     Navigator.of(context).push(
       MaterialPageRoute(builder: (context) => 
         AboutPage()));
}
```

2. Make sure to import `lib/pages/about.dart`.
If you run the project and tap on the **About** link on the top navigation, you should see the following page:

![ 0700 Figure 5.1 – About page ](/packtpub/taking_flutter_to_the_web_img/0700_figure_5.1_–_about_page.webp
)
Figure 5.1 – About page

However, you will notice that the URL in the address bar has not changed. When `push()` is called, `AboutPage` is placed at the top of the `HomePage` widget. So, this route, which we thought very suitable for mobile applications, is not suitable for the web for displaying new pages. This is because on the web, we tend to associate pages with specific URLs. Next, we will implement this same route with named routes. Let’s see how:

1. First, open `lib/main.dart` and update `MaterialApp`, as follows:
```
return MaterialApp(
  title: 'Flutter Demo',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  routes: {
    '/': (_) => HomePage(),
    '/about': (_) => AboutPage(),
  },
);
```

Here, we are adding the route’s properties with a list of named routes and associated pages.

2. Now, let us update the navigation code we wrote in `lib/widgets/top_nav.dart`, as follows:
```
OnPressed() {
  Navigator.of(context).pushNamed("about");
}
```

This will also navigate to `about` as in the previous code, but if you look at the URL now, you can see that it has changed.

![ 0702 Figure 5.2 – Named URL route ](/packtpub/taking_flutter_to_the_web_img/0702_figure_5.2_–_named_url_route.webp
)
Figure 5.2 – Named URL route

In a similar way, we can add named routes for other pages of our application.

3. Let’s update the route properties of `MaterialApp` as follows in `lib/main.dart`:
```
routes: {
  '/': (_) => HomePage(),
  '/about': (_) => AboutPage(),
  '/contact': (_) => ContactPage(),
  '/courses': (_) => CoursesPage(),
},
```

We have added routes for new pages. We can also update the top navigation to add navigation to each link.

4. Update the top navigation actions, as follows:
```
actions: (MediaQuery.of(context).size.width <= ScreenSizes.md)
  ? null
  : [
      TextButton(
        child: Text("Home"),
        //...
        onPressed: ()  => Navigator.pushNamed(context,
                                               '/');
      ),
      TextButton(
        child: Text("Courses"),
        //...
        onPressed: () => Navigator.pushNamed(context,
          '/courses');
      ),
      TextButton(
        child: Text("About"),
        //...
        onPressed: () => Navigator.pushNamed(context,
          '/about');
      ),
      TextButton(
        child: Text("Contact"),
        //...
        onPressed: () => Navigator.pushNamed(context,
          '/contact');
      ),
    ],
```

5. Similarly, update the `onTap` action for each `ListTile` widget on the drawer navigation, adding the relevant navigation as we did with our top navigation.

Now, if you run the application, you can navigate to each page and the URL also gets updated. Also, if you directly update the URL on the address bar to a specific page, that page will be displayed as the initial page. This is great. We can use static values in the URLs to navigate to a specific page. Now, what happens when you want to add dynamic parameters to URLs? Right now, you can get to the `Courses` page and tap on an individual course, and you can navigate to the `Course details` page. However, say you want to navigate to a different course by passing the ID in the URL, like so: `details/:id`. The current named route doesn’t allow us to parse those parameters. Next, we will look into how we can implement an advanced named route using `onGenerateRoute`, which will allow us to parse the URL parameters.

Let’s remove the `routes` parameter from the `MaterialApp` widget and instead use the `onGenerateRoute` parameter. Update the `MaterialApp` widget in `lib/main.dart`, as follows:

```
return MaterialApp(
  title: 'Flutter Demo',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  onGenerateRoute: (settings) {
    return MaterialPageRoute(
        builder: (_) {
          switch (settings.name) {
            case '/':
              return HomePage();
            case '/about':
              return AboutPage();
            case '/contact':
              return ContactPage();
            case '/courses':
              return CoursesPage();
            default:
              final pathSegments = 
                Uri.parse(settings.name!).pathSegments;
              print(pathSegments);
              if (pathSegments.length == 2 &&
                  pathSegments[0] == 'courses') {
                final courseId = 
                  int.parse(pathSegments[1]);
                return CourseDetailsPage(courseId: 
                  courseId);
              }
              return Error404Page();
          }
        },
      settings: settings,
    );
  },
);
```

As you can see, we get `name` as the `RouteSettings name` parameter, and we can manipulate and test `name` as we like. So, using the preceding code, we are handling simple named routes as well as advanced routes by parsing the route name.

We are parsing the `name` parameter using `Uri.parse`. Then, we are getting the path segments from the parsed URI. By testing different parameters received in the path segments, we set the page for the route. Now, if you run the application and directly type the URL with a course ID in the URL segment in your address bar, you will be navigated to that specific course’s details page.

However, this imperative navigation style has some limitations. We are not able to update the navigation stack as we please. Updating the navigation stack dynamically based on application state (which is required for applications on the web) is not possible with this method. Also, there is no proper way to handle the navigation received from a native platform and build a proper navigation stack based on that. To learn more about this style of navigation in Flutter, you can find more resources in the official documentation at https://docs.flutter.dev/cookbook/navigation. Navigator 2.0, which is a declarative navigation API, was introduced to tackle these issues. We will learn more about Navigator 2.0 in the next section.

# An introduction to Navigator 2.0

Navigator 2.0 is a declarative navigation API that allows us complete control over our application’s navigation stack. This also allows us to control routes much like any other state of our application.

The Navigator 2.0 API adds new classes to the framework in order to make the app’s screens a function of the app state. This also provides the ability to parse routes from the underlying platform (such as web URLs). Navigator 2.0 is provided alongside the existing navigator. That means Navigator 2.0 is not a replacement for the existing imperative navigation API; it’s just another way of handling our app’s navigation. It was introduced because with Flutter being a cross-platform framework, the imperative navigation API (which is more suitable for mobile-only applications) was limiting the progress of Flutter on the web. Navigator 2.0 is more suitable for platforms such as applications on the web, where underlying platform routes are more frequent and should be handled properly. Alongside the existing navigation API, the following resources were added to the framework to support the new navigation API:

- **Page**: `Page` is an immutable object used to set the navigator’s stack. The navigator’s stack is just a list of `Page` objects.
- **Router**: `Router` configures the list of pages in the navigator’s stack. This list of pages typically varies when the app’s state or the underlying platform changes, and it is this list that controls what is presented on the screen.
- `RouteInformationParser`: In order to manage the navigation state, the route information parser accepts `RouteInformation` from `RouteInformationProvider` and parses it into a user-defined data type.
- 'RouterDelegate`: The app-specific behavior of how `Router` obtains information about the app’s state and how it manages it is defined by the router delegate. It listens to `RouteInformationParser` and the app state before constructing Navigator with the current stack of pages.
- `BackButtonDispatcher`: The back button dispatcher reports back button presses to Router.

The following diagram shows how `RouterDelegate` interacts with Router, `RouteInformationParser`, and the app’s state:

![ 0703 Figure 5.3 – Navigator 2.0 ](/packtpub/taking_flutter_to_the_web_img/0703_figure_5.3_–_navigator_2.0.webp
)
Figure 5.3 – Navigator 2.0 (source: https://docs.google.com/document/d/1Q0jx0l4-xymph9O6zLaOY4d_f7YFpNWX_eGbzYxr9wY)

Here’s an example of how these components work together.

`RouteInformationParser` translates a new route (for example, `courses/flutter-beginners`) that the platform emits into an abstract data type that you create in your app (for example, `Uri`).

When this data type is sent to the `setNewRoutePath` method of `RouterDelegate`, it must update the application state to reflect the change (for example, by adding a course details page to the pages list and calling `notifyListeners`).

`RouterDelegate` rebuilds using its `build()` method when `notifyListeners` is called.

The `Navigator` widget with updated pages is returned by `RouterDelegate.build()`. The pages returned reflect the change to the app state (for example, a new page that shows course details is added to the pages list).

This is how Navigator 2.0 works under the hood. You can also learn more about Navigator 2.0 at https://medium.com/flutter/learning-flutters-new-navigation-and-routing-system-7c9068155ade. In order to implement Navigator 2.0 in our application, we will have to implement these abstract classes in our application and handle the navigation state. We will do that in our Flutter Academy application in the next section.

# Implementing Navigator 2.0 in our app

Let’s start. As we are using Material Design and `MaterialApp`, for simplicity, we will not be implementing our own `Page` object, we will instead use `MaterialPage` provided by Flutter’s material library. If you wish, you can implement `Page` yourself by creating a new class that extends `Page` and implementing the required functionality. So, we will start by implementing `RouterDelegate`. `RouterDelegate` requires a generic type that defines our route. Here, we will be using a **Uniform Resource Identifier (URI)** as it is powerful as well as simple. With a URI, we can provide advanced paths, as well as manipulate them easily. This is even more suitable for the web, as in the browser, we are always dealing with URIs. Inside `lib/`, create a folder named `routes`, and inside that folder, create a file called `router_delegate.dart`. First, we will create our class by extending `RouterDelegate`, setting URI as the generic type, like so:

```
class AppRouterDelegate extends RouterDelegate<Uri> {}
```

If we look at the source code of `RouterDelegate` by pressing Ctrl/Cmd and clicking on the class, we can see that it’s an abstract class and has a bunch of functions that we must implement. Among them, we must implement `build` and `setNewRoutePath`. There are three other methods that we must implement, `popRoute`, `addListener`, and `removeListener`, for which we will be using existing mixins already provided by Flutter. Let’s go through these methods and implement them one by one.

First, let’s start by implementing the `build` method. The `build` method of `RouterDelegate` should return a `Navigator` widget, which provides a list of pages defining the application’s route stack:

```
@override
Widget build(BuildContext context) {
  final pages = _getRoutes(_path);
  return Navigator(
    pages: pages,
  );
}
```

In order to get the list of pages, we are calling `_getRoutes`, which we will implement in a bit. Before that, we also need to implement `onPopPage`. This method is called when `pop` is invoked and receives `route` and `result`. `Route` corresponds to a page found in the pages list we have. `result` argument is a boolean value with which the route is to complete. We should call `Route.didPop` and return whether this pop is successful from this method. The `Navigator` widget should rebuild, and as a result, the new `pages` list should not contain the page for the given route. Update the `Navigator` widget by adding the `onPopPage` method, as follows:

```
onPopPage: (route, result) {
  if (!route.didPop(result)) {
    return false;
  }
  if (pages.isNotEmpty) {
    _path = _path.replace(
        pathSegments: _path.pathSegments
            .getRange(0, _path.pathSegments.length - 1));
    notifyListeners();
    return true;
  }
  return false;
},
```

The next method we need to implement is `popRoute`, and for this, we will be using `PopNavigatorRouterDelegateMixin`, so update the class definition for our router delegate, as follows:

```
class AppRouterDelegate extends RouterDelegate<Uri>
    with PopNavigatorRouterDelegateMixin<Uri> {
```

This mixin provides an implementation for `popRoute` so we don’t have to handle it ourselves. Next, in order to implement `addListeners` and `removeListeners`, we will use the `ChangeNotifier` mixin, so update the class definition, as follows:

```
class AppRouterDelegate extends RouterDelegate<Uri>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Uri> {
```

The only method we need to implement next is `setNewRoutePath`. But before doing that, we will implement a `go` method, which will allow us to navigate to different pages from our application by passing a path as a string. Let’s do that as shown in the following code:

```
go(String path) {
  this._path = Uri.parse(path);
  notifyListeners();
}
```

With this, we should also add `Uri` `_path` as a class property, as follows:

```
Uri _path = Uri.parse('/');
```

Let us now implement the `setNewRoutePath` method. This method is called by the router whenever our router information provider reports that a new route has been pushed to the application by the operating system. For web applications, whenever a new URL is entered in the address bar, the following method is called:

```
@override
Future<void> setNewRoutePath(Uri configuration) async =>
    go(configuration.toString());
```

Here, we are calling the `go` method we implemented previously in order to update the `path` property so that our navigation stack is then updated according to the path. Finally, we will implement the most important method that parses the path and then provides the list of pages for the `Navigator` widget. We will implement the `_getRoutes` method that we are calling in the `build` method. Add the `_getRoutes` method, as shown in the following code:

```
List<Page> _getRoutes(Uri path) {
  final pages = [
    MaterialPage(child: HomePage(), key: ValueKey('home')),
  ];
  if (path.pathSegments.length == 0) {
    return pages;
  }
  switch (path.pathSegments[0]) {
    case 'contact':
      pages.add(MaterialPage(
        key: ValueKey('/contacts'),
        child: ContactPage(),
      ));
      break;
    case 'about':
      pages.add(MaterialPage(
        key: ValueKey('/about'),
        child: AboutPage(),
      ));
      break;
    case 'courses':
      pages.add(MaterialPage(
        key: ValueKey('/courses'),
        child: CoursesPage(),
      ));
      break;
    default:
      pages.add(MaterialPage(child: Error404Page(), 
        key: ValueKey('error')));
      break;
  }
  if (path.pathSegments.length == 2) {
    if (path.pathSegments[0] == 'courses') {
      pages.add(
        MaterialPage(
          key: ValueKey('course.${path.pathSegments[1]}'),
          child: CourseDetailsPage(
            courseId: path.pathSegments[1],
          ),
        ),
      );
    } else {
      pages.add(MaterialPage(child: Error404Page(), 
        key: ValueKey('error')));
    }
  }
  return pages;
}
```

This is the method that we are using in our preceding `build` method, that is, parsing the path and returning the appropriate list of pages required by the `Navigator` widget. This is the method where we manipulate pages and routes based on the navigation path.

Now, one final thing we need to implement is the `currentConfiguration` getter. This is called when our app’s route information is changed. This method is responsible for Flutter web apps updating the URL in the navigation bar when the route changes. Our router delegate is now complete. You can find the complete code at https://github.com/PacktPublishing/Taking-Flutter-to-the-Web/blob/main/Chapter05/chapter5_final/lib/routes/router_delegate.dart.

Next, we will implement the parser for the routes. The route parser has to implement `RouteInformationParser`, which is a delegate that is used by `Router` to parse the route information into the configuration type defined by us. In our case, we are simply using a URI, so this should parse the available route information into a URI. This is the class used when the router is first built and any subsequent times when new route information is provided by `routeInformationProvider`. Create a new file named `app_route_parser.dart` inside `lib/routes/` and update it, as follows:

```
import 'package:flutter/material.dart';
class AppRouteInformationParser extends RouteInformationParser<Uri> {
  @override
  Future<Uri> parseRouteInformation(RouteInformation 
    routeInformation) async =>
      Uri.parse(routeInformation.location!);
  @override
  RouteInformation restoreRouteInformation(
    Uri configuration) => 
      RouteInformation(location: configuration.toString());
}
```

Now that we have our router delegate and route information parser implemented, we should update `MaterialApp` to use the new navigator instead. We should keep in mind that we can still use old navigation together with this; however, in our case, we will replace the old navigation with the new one. Let’s get started:

1. First, open `lib/main.dart` and create instances of our router delegate and route information parser before the `MyApp` widget starts, as shown in the following code:
```
final routerDelegate = AppRouterDelegate();
final _routeParser = AppRouteInformationParser();
```

Here, we are making the instance of the router delegate public and the route information parser private, as we will require the router delegate to perform navigations from our code.

2. Now, update `MaterialApp`, as follows:
```
return MaterialApp.router(
  title: 'Flutter Demo',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  routerDelegate: routerDelegate,
  routeInformationParser: _routeParser,
)
```

Here, we have made three changes:

- For `MaterialApp`, we are now using the `MaterialApp.router` constructor.
- We are passing the `routerDelegate` and `routeInformationParser` parameters as the instances we created earlier.
- We removed the `routes` and `onGenerateRoute` parameters as we are now handling our navigations through the new navigator.

Now that our `MaterialApp` knows how to handle routes using the delegates we just provided, we can use the `routerDelegate` instance we created in this chapter to navigate, instead of the existing imperative navigation. So, wherever we are calling the imperative navigator’s `pushNamed` function, we can replace it with `routerDelegate.go()`. We pass the same path to the `routerDelegate.go()` method as we were passing to the `pushNamed` method.

For example, open `lib/widgets/top_nav.dart` and in the courses button’s `onPressed` function, replace `Navigator.pushNamed(context, '/courses')` with `routerDelegate.go('/courses')`. Similarly, replace all the navigation with `routerDelegate.go()`. Remember to import `routerDelegate` from `main.dart`. You can similarly replace the navigation code in `lib/widgets/drawer.dart` as well.

With this change, we should now be able to build and run the application as we did previously, while using named routes. We should be able to access the URL directly or navigate by clicking on the navigation provided on the page. If you have any issues, compare your code against the code in https://github.com/PacktPublishing/Taking-Flutter-to-the-Web/tree/main/Chapter05/chapter5_final.

# Summary

In this chapter, we looked at the different ways of implementing navigation in our application. We also learned about the benefits and shortcomings of each method. We also learned how to implement both types of navigation (imperative and declarative) in our application.

In the next chapter, we will learn about architecting and organizing our Flutter application. We will learn about the need for proper architecture and implement a scalable architecture in our Flutter application.



> [ 06 C4 Flutter Web under the Hood ](/packtpub/taking_flutter_to_the_web/06_c4_flutter_web_under_the_hood) <---> [ 08 C6 Architecting and Organizing ](/packtpub/taking_flutter_to_the_web/08_c6_architecting_and_organizing)
>
> (1) Path: packtpub/taking_flutter_to_the_web/07_c5_understanding_routes_and_navigation
> (2) Markdown
> (3) Title: 07 C5 Understanding Routes and Navigation
> (4) Short Description: Publication date: 10월 2022 Publisher Packt Pages 206 ISBN 9781801817714
> (5) tags: flutter web
> Book Name: Taking Flutter to the Web
> Link: https://subscription.packtpub.com/book/web-development/9781801817714/pref/
> create: 2023-01-19 목 14:36:09
> Images: /packtpub/taking_flutter_to_the_web_img/
> .md Name: 07_c5_understanding_routes_and_navigation.md

