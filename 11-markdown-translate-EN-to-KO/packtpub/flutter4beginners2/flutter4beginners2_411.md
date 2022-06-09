원본 제목: Chapter 11: Testing and Debugging
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/411
Title:
411 Testing and Debugging
Short Description:
Flutter for Beginners Second Edition 테스트와 디버깅

![Figure 11.8 - HelloWorld app with performance overlay ](/flutter4beginners2_img/figure_11.8_-_helloworld_app_with_performance_overlay.jpg)
- cut line


# Chapter 11: Testing and Debugging
Flutter for Beginners Second Edition

Flutter provides great tools to help the developer manage their app development and ensure that it is ready for production – from a test API to IDE tools and plugins. This is especially crucial in app development where, unlike in some scenarios such as web pages, a bug fix can take several days to be reviewed by the relevant store, and then be updated on user devices.

In this chapter, you will learn how to add tests to identify bugs within your app, use debugging tools to identify where an issue is within your code, profile your app performance to find bottlenecks, and inspect the UI widgets.

We will start the chapter with an exploration of how you can unit test your Dart code. This can be useful if you create a reusable library of functions that you are using across many apps and want to ensure that any changes to the library code continue to function as intended.

The following topics will be covered in this chapter:

- Unit testing
- Widget testing
- Debugging your app
- DevTools

# Technical requirements

You will need your development environment again for this chapter if you want to practice testing and debugging the Hello World project. Look back at Chapter 1, An Introduction to Flutter, if you need to set up your IDE or refresh your knowledge of the development environment requirements.

You can find the source code for this chapter on GitHub at the following links:

- https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/lib/chapter_11.
- https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/test/chapter_11

# Unit testing

It is generally agreed that writing bug-free software is impossible, especially when your code runs on third-party hardware, such as a mobile phone, and has to interact with users, who can (and will) do all kinds of unexpected things.

However, for some situations, such as reusable function libraries, the requirements can be well defined, and the data inputs known in advance. In these situations, not only is a strong set of tests a great way to ensure the library is as bug-free as possible, but it also allows you to make changes to the code (for example, performance improvements, memory optimizations), knowing that your changes have not affected the expected behavior of the library.

Unit tests are one of the things that can help us to write modular, efficient, and bug-free code. The unit test is not the only way of testing code, of course, but it's a crucial part of testing small pieces of software in a manner that isolates it from other parts, helping us to focus on specific things.

Covering all of the application code with unit tests does not guarantee that it's 100% bug-free; however, it helps us to achieve mature code progressively, and this is one of the steps to ensuring a good development cycle, with stable releases from time to time.

Dart also provides some useful tools to work with tests. Let's take a look at the starting point of unit testing Dart code: the Dart test package.

## The Dart test package

The Dart test package is not part of the Software Development Kit (SDK) so it has to be added as a dependency using the pubspec.yaml file as we saw done often in Chapter 8, Plugins – What Are They and How Do I Use Them?.

Unlike with the previous plugins that we depended on, this is a dependency that is required only during development and not at runtime. Therefore, it is added to another part of the pubspec.yaml file, specifically the area in dev_dependencies:

```
dev_dependencies:
  test: ^1.17.5
```

Just like the standard dependencies, these plugins are listed on the pub.dev site, and the installation section will advise you how to add the plugin to the correct part of the pubspec.yaml file.

Including this dependency enables us to use the test package's provided libraries to write unit tests.

## Writing unit tests

Now, let's suppose that we want to create a function that sums two numbers:

```
class Calculator {
  num sumTwoNumbers(num a, num b) {
    return 0; // TODO
  }
}
```

We would probably choose to put the file holding this function in a sub-folder, allowing us to manage our code structure. Let's say we put it in the location lib/maths/calculator.dart.

We can now write a unit test to evaluate this method implementation by using the test package:

```
import 'package:test/test.dart';
import 'package:hello_world/maths/calculator.dart';
void main() {
  late Calculator _calculator;
  setUp(() {
    _calculator = Calculator();
  });
  test(
    'calculator.sumTwoNumbers() sum both numbers',
    () => expect(_calculator.sumTwoNumbers(1, 2), 3),
  );
}
```

In the preceding example, we started by importing the test package's main library that exposes functions, for example, setUp(), test(), and expect(). Each of the functions has specific roles, as follows:

- setUp() will execute the callback we pass to it before each of the tests in the test suite.
- test() is the test itself; it receives a description and a callback with the test implementation.
- expect() is used to make assertions about the test. In the preceding example, we are just asserting a sum of 1 + 2, which should result in the number 3.

Tests should be stored in their own test folder, separate from the lib folder. Let's say we put this file in test/calculator_test.dart.

To execute a test, we use the following command:

```
flutter pub run test <test_file>
```

In the preceding example, the command would be (from the root of the project) as follows:

```
flutter pub run test test/calculator_test.dart
```

Before we correctly implement the sumTwoNumbers() method, let's run the test to see what output we get:

```
PS C:\Flutter\hello_world> flutter pub run test test/calculator_tests.dart
00:00 +0: calculator.sumTwoNumbers() sum both numbers
00:00 +0 -1: calculator.sumTwoNumbers() sum both numbers [E]
  Expected: <3>
    Actual: <0>
  package:test_api                  expect
  test\calculator_tests.dart 11:61  main.<fn>
00:00 +0 -1: Some tests failed.
pub finished with exit code 1
```

A little intimidating, but there are four key pieces of information here:

- 00:00 +0 -1: Some tests failed: This is stating that the tests took 0 seconds to run, that 0 tests passed (+0), and that 1 test failed (-1). At this point, you know you have some investigating to do!
- The test that failed had the title calculator.sumTwoNumbers() sum both numbers because it has a -1 before its name.
- The test failed because the expect() statement was expecting a result of 3 but received a result of 0.
- The failure occurred in the calculator_tests.dart file on line 11, character 61. This is exactly where the expect() statement is defined.

With this information, you should be able to identify where your test is failing, and start to diagnose what bug you have uncovered (which could potentially be a bug in your test code rather than the code it is testing).

Let's change the implementation of the sumTwoNumbers() method, and then rerun the test to check it is all correct:

```
class Calculator {
  num sumTwoNumbers(num a, num b) {
    return a + b;
  }
}
```

Now we return the two numbers added together, and a rerun of the test gives the following:

```
PS C:\Flutter\hello_world> flutter pub run test test/calculator_tests.dart
00:00 +0: calculator.sumTwoNumbers() sum both numbers
00:00 +1: All tests passed!
```

The test name is shown, and this time there is no error, just an All tests passed! message.

Note that we could have made this test pass by simply returning 3 from the sumTwoNumbers() method, which shows that the creation of a range of tests is necessary to be confident of the quality of your function.

You can also create groups of tests so that it is easy to manage and report on specific parts of the code being tested. Let's suppose that we create a new file to hold a test suite with a group of tests, as follows:

```
import 'package:test/test.dart';
import 'package:hello_world/maths/calculator.dart';
void main() {
  late Calculator _calculator;
  setUp(() {
    _calculator = Calculator();
  });
  group("calculator tests", () {
    test(
      'sumTwoNumbers() sum both numbers',
      () => expect(_calculator.sumTwoNumbers(1, 2), 3),
    );
    test(
      'sumTwoNumbers() sum negative number',
      () => expect(_calculator.sumTwoNumbers(1, -1), 1),
    );
  });
}
```

The preceding code should look very similar to the single test example, with a main method containing a setup method. However, instead of also containing a test method, the main method contains a group method that itself will contain the tests.

In this example, we call the group method with two parameters: the name of the group of tests, and an anonymous function that will run the tests. The anonymous function simply calls the test() method twice with two tests.

Notice the output for the preceding tests:

```
PS C:\Flutter\hello_world> flutter pub run test test/calculator_group_tests.dart
00:00 +0: sum tests calculator.sumTwoNumbers() sum both numbers
00:00 +1: sum tests calculator.sumTwoNumbers() sum negative number
00:00 +1 -1: sum tests calculator.sumTwoNumbers() sum negative number [E]
  Expected: <1>
    Actual: <0>
  package:test_api                       expect
  test\calculator_group_tests.dart 15:7  main.<fn>.<fn>
00:00 +1 -1: Some tests failed.
pub finished with exit code 1
```

There was one successful test (+1) and one failure (-1) – with the details of the failure noted as an incorrect expectation. With this in mind, we can investigate the location of the failure and realize that our expect() statement is incorrect. We were expecting 1 + -1 = 1, which is clearly incorrect. Modifying the test to expect 0 and then rerunning the test group gives the following output:

```
PS C:\Flutter\hello_world> flutter pub run test test/calculator_group_tests.dart
00:00 +0: sum tests sumTwoNumbers() sum both numbers
00:00 +1: sum tests sumTwoNumbers() sum negative number
00:00 +2: All tests passed!
```

In this output, we can see +1 as the first test passes, then +2 as the second test passes.

Unit tests can help us prevent logical errors in our functional libraries from occurring in production. Of course, tests generally can't be exhaustive, but using techniques such as boundary value analysis and equivalence partitioning can allow us to test most of the possible scenarios, which our library function will have to deal with. These topics are outside of the scope of the book, but a search on the internet for these terms will give further explanation and help you to write a strong set of tests for a function.

## Unit test mocking

Sometimes our unit tests may rely on accessing a service or reading live data from a database. This can be troublesome in a unit test because the service may not be available from the test environment, you don't want to be manipulating live data from a test, and the test may not be repeatable if the service or database returns unexpected results.

To solve this problem, unit testing generally replaces, or mocks, these services or databases so the dependency is removed. You can either choose to write these mocks yourself, by replacing a live service class with your custom mock class, or you can use a framework such as Mockito.

Mockito is available as a plugin, so adding it to your project is as easy as updating your pubspec.yaml file to include the dev dependency. Exploring the use of mocks is beyond the scope of this book, but a great place to start your investigation is on the pub.dev page at https://pub.dev/packages/mockito.

As mentioned at the start of this section, unit testing is great for testing a library function that has well-defined inputs, outputs, and requirements. As we start to involve outside actors such as users, networks, and devices, we need to look at other testing options. Let's start that exploration with a look at testing widgets.

# Widget testing

Getting the right mix of tests is important so that you can test your app optimally without reducing iteration and development velocity. Writing unit tests for well-defined library functions makes sense, but when it comes to user interactions, you often want to iterate and understand user interactions before settling on a design, which then may change as fashion or best practices change. Therefore, your test itself should be more high-level, looking at components rather than specific functions. One example of this is widget tests, and Flutter helps us to write widget tests to test that widgets work as expected.

Widget tests are used to validate widgets in an isolated way. They look very similar to unit tests but focus on widgets. The main goal is to check widget interactions and whether widgets visually match expectations. As widgets live in the widget tree inside the Flutter context, widget tests require the framework environment to be executed. That is why Flutter provides tools for writing widget tests through the flutter_test package.

## The flutter_test package

The flutter_test package is shipped with the Flutter SDK. It is built on top of the test package, and provides a set of tools for helping us to write and run widget tests.

As said in the previous section, widget tests need to be executed in the widget environment and Flutter helps with this task with the WidgetTester class. This class encapsulates the logic for us to build and interact with the widget being tested and the Flutter environment.

We do not need to instantiate this class by ourselves as the framework provides the testWidgets() function. The testWidgets() function is similar to the Dart test() function that we saw in the Unit testing section. The difference is the Flutter context – this function sets up a WidgetTester instance to interact with the environment.

### The testWidgets function

The testWidgets() function is the entry point of any widget test in Flutter:

```
void testWidgets(
  String description,
  WidgetTesterCallback callback,
  { bool skip: false, Timeout? timeout },
)
```

The method takes two required and two optional parameters:

- description: This required parameter helps to document the test; that is, it describes what widget features are being tested.
- callback: This required parameter is WidgetTesterCallback. This callback receives a WidgetTester instance so that we can interact with the widget and make our validations. This is the body of the test, where we write our test logic.
- skip: We can skip the test when running multiple tests by setting this optional flag. The default value is false.
- timeout: This optional parameter is the maximum time the test callback can run. The default value is to have no limitation.

Let's look at an example of how we could use this method.

## Widget test example

When we generate a Flutter project, we have the flutter_test package dependency added for us automatically and a sample test is generated in the test/ directory.

First, in the pubspec.yaml file, we can see the flutter_test package dependency was added to our HelloWorld project when it was created:

```
dev_dependencies:
  flutter_test:
    sdk: flutter
```

Note that the package version is not specified. This is because the origin is configured as the Flutter SDK, so it matches whatever version of Flutter we have installed on our system.

Next, let's take a look at the basic widget test in the test/widget_test.dart file:

```
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hello_world/main.dart';
void main() {
  testWidgets(
    'Counter increments smoke test',
    (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());
      // Verify that our counter starts at 0.
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);
      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      // Verify that our counter has incremented.
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
  });
}
```

This sample widget test validates the behavior of the famous Flutter counter app. The test goes as follows:

1. The test is defined with a description and the WidgetTesterCallback property as we saw in the The flutter_test package section earlier. Also, note the callback has the async modifier, as it returns a Future type.
1. We want to test a widget, so the test fires up the widget we want – in this case, MyApp – by running await tester.pumpWidget(MyApp());. This renders the widget ready for us to test it.
1. If we need to rebuild the widget at any point, we can use the tester.pump() method. This is needed because, although the code may initiate setState(), Flutter will not automatically rebuild the widget in a test environment.
1. In widget tests, three additional pieces are important and very common: expect(), find, and Matcher.
The expect() method is used in conjunction with finder and Matcher to make assertions on widgets found – just like the expect() function that we looked at in the Unit testing section.

The Finder class is what allows us to search specific widgets in the tree. The find constant provides Finders that search the widget tree for specific widgets.

The Matcher class helps to validate the found widget characteristic with an expected value.

Important note

Check all available Finders provided by find: https://api.flutter.dev/flutter/flutter_driver/CommonFinders-class.html.

Let's step through the test code that is run, after the widget is pumped via WidgetTester, so that we can better understand the test.

The first assertions check for the presence of a single widget with the text '0' and none with the text '1'. This is done by using the find function find.text(), to find a widget with specific text, and then using the two Matchers, findsOneWidget and findsNothing, to specify the expectation of how many widgets should be found, as shown here:

```
expect(find.text('0'), findsOneWidget);
expect(find.text('1'), findsNothing);
```

Then, tap() is executed on WidgetTester, followed by a pump() request to refresh the widget. The tap occurs on a widget that contains the Icons.add icon by using the find.byIcon() function to find the correct widget:

```
await tester.tap(find.byIcon(Icons.add));
await tester.pump()
```

The final step is to verify the correct text is shown again. But this time, the findsOneWidget constant is used to verify that only the text, '1', is visible and that there are no widgets that now have the text '0':

```
expect(find.text('0'), findsNothing);
expect(find.text('1'), findsOneWidget);
```

Like the find constant, which has multiple find functions, there are multiple Matchers in addition to findsNothing and findsOneWidget. Check all available Matchers in the flutter_test library documentation:

https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html

## Running a widget test

To run a widget test, use this command:

```
flutter test <testFile>
```

So, in our example, we would run this command:

```
flutter test test/widget_test.dart
```

Let's just change the test so that it will fail. In this case, we will change the final assertion to see if the widget has the text "2" instead of "1". If we run the test, the output is the following:

```
PS C:\Flutter\hello_world> flutter test test/widget_test.dart
00:05 +0: Counter increments smoke test
══╡ EXCEPTION CAUGHT BY FLUTTER TEST FRAMEWORK ╞═══
The following TestFailure object was thrown running a test:
  Expected: exactly one matching node in the widget tree
  Actual: _TextFinder:<zero widgets with text "2" (ignoring offstage widgets)>
   Which: means none were found but one was expected
When the exception was thrown, this was the stack:
<Stack trace here>
...
This was caught by the test expectation on the following line:
  file:///C:/Users/geeky/Documents/Apps/Flutter/hello_world/test/widget_test.dart line 28
The test description was:
  Counter increments smoke test
════════════════════════════════
00:05 +0 -1: Counter increments smoke test [E]
  Test failed. See exception logs above.
  The test description was: Counter increments smoke test
00:05 +0 -1: Some tests failed.
```

As you can see from the output, the test runner wasn't very happy. Although there is a lot of information, the format is very similar to what we saw in the Unit testing section. We can see the difference in expectation from what actually happened, the name of the test, and the line that the test failed on.

Let's run the test again with the correct expectation:

```
PS C:\Flutter\hello_world> flutter test test/widget_test.dart
00:11 +1: All tests passed!
```

When the tests passed, the output was very minimal, just reporting that All tests passed!.

Even with lots of testing, apps will fail or exhibit incorrect behavior. In these cases, you will need to inspect the execution of the app code to find the issues. This activity, known as debugging, is our next topic.

## Debugging your app

Debugging is an important part of software development. Small mistakes, strange behaviors, and complex bugs can be solved with the help of debugging. With this, we can do the following:

- Make logic assertions
- Determine required improvements
- Find memory leaks
- Perform flow analysis

Flutter provides multiple tools to help you debug your app. Specifically, Flutter IDEscan assists with debugging. However, the Dart tooling also allows debugging without the IDE, which we will see in the following sections.

## Observatory

Flutter debugging is based on the Dart Observatory tool. Dart Observatory is present in the Dart SDK and helps with profiling and debugging Dart applications such as Flutter apps.

You can explore the Observatory by running Dart specific code using the dart run --observe command where you will receive an address:port part of the output. This address is the Observatory UI address; you can access it through standard web browsers:

![Figure 11.1 - The Dart Observatory ](/flutter4beginners2_img/figure_11.1_-_the_dart_observatory.jpg)

The Observatory shares information about the app that's running, such as the current and peak memory, class hierarchy, and logs. Also, amongst the many sections of the Observatory is an important additional tool, the debug tool:

![Figure 11.2 - Debug tool ](/flutter4beginners2_img/figure_11.2_-_debug_tool.jpg)

On this page, as you can see, we have access to all of the debugging functionalities, such as the following:

- Adding and removing breakpoints
- Running step by step and line by line
- Switching and managing isolates

Check all available Observatory UI functionalities and a full usage tutorial at the following link:

https://dart.dev/tools/dart-devtools

When you use an IDE such as Visual Studio Code or Android Studio/IntelliJ, you will not be using tools such as the Observatory UI directly. IDEs use Dart Observatory under the hood to expose its functionalities through the IDE interface.

## Additional debugging features

Dart provides additional features to help with advanced debugging through variants of the common tools that can make the debugging process even more useful. These are as follows:

- The debugger() statement: Also called programmatic breakpoints, this is where we can add a breakpoint only if an expected condition is true:

```
void login(String username, String password) {
  debugger(when: password == null);
  ...
}
```

In this example, a breakpoint will occur only if the condition specified in the when parameter is true, that is, only if the password argument is null. Let's say this is an unexpected value: pausing the execution at this point may help to see why it occurs and how to react to it. This is very useful for tracing unexpected states and logic fails.
- debugPrint() and print(): print() is a method to log information into the Flutter log console. When we use the flutter run command, its log output is redirected to the console and we can see anything that comes from print() and debugPrint() calls. The only difference between these calls is that the debugPrint() version throttles the rate of message creation to avoid data loss on Android.
- Asserts: assert() is used to break app execution when some condition is not satisfied. It is similar to the debugger() method, but instead of pausing execution, it interrupts the execution by throwing an AssertionError. If you look at plugin or built-in widget code, you will often see assert statements on the constructors to ensure the widgets are being constructed correctly.

It's worth noting that debugger() and assert() function calls are ignored in production code.

The tools you have seen so far are pretty raw. You generally wouldn't debug your code by adding debugging statements or accessing the Observatory, but it serves as a useful baseline for your knowledge. Let's look at how you can do debugging directly within the IDE.

## Debugging in the IDE

To be able to debug within your IDE, you first need to run your app from within your IDE. If you are running Visual Studio Code, then you will see a RUN AND DEBUG button on the left side of the IDE. Click this, and then at the top of the section, you will see a Run debugging button beside the name of the Flutter project hello_world:

![Figure 11.3 - Running Flutter from Visual Studio Code ](/flutter4beginners2_img/figure_11.3_-_running_flutter_from_visual_studio_code.jpg)

If you are using Android Studio/IntelliJ, then make sure you run in debug mode so that you have access to all the tooling.

Once you have the app running in the IDE, you can add breakpoints. Try adding a breakpoint in the _MyHomePageState class within the main.dart file. Specifically, add a breakpoint within an onPressed function of a button. To do this in Visual Studio code, simply click to the left of the line number of the line you want as the breakpoint. A red dot will then appear to show that a breakpoint is set, and on the left pane at the bottom, you will see the list of breakpoints that are set.

When you are running your app and press the button that has a breakpoint set on it, your IDE will pause execution of the code and show something like this:

![Figure 11.4 - Visual Studio Code pausing execution at a breakpoint ](/flutter4beginners2_img/figure_11.4_-_visual_studio_code_pausing_execution_at_a_breakpoint.jpg)

There is a lot going on here, so let's take it a piece at a time:

- The main pane highlights the line in yellow where the code execution is paused.
- The top-left pane shows the VARIABLES that are currently set.
- The CALL STACK pane shows the current call stack (that is, all the method calls that allowed the code to reach this point).
- The bottom-right pane shows the DEBUG CONSOLE and any log statements that have come from the app.

The next step is to use the debug controls (top left) to either step the execution to the next line, step into a method/function call, step out of a method/function, or continue the execution of the code.

As you can imagine, this gives you a great ability to see exactly what is happening within the code and understand where there may be issues.

One warning is that when you reach an asynchronous section of code, you may need to set another breakpoint to allow you to catch the execution again after the asynchronous work is done. Also, asynchronous sections can lead to an incomplete call stack, potentially making it difficult to understand how a piece of code was reached. However, generally, the debugger is a lifesaver and should be used as much as possible!

Debugging your app is incredibly important, so ensure you revisit this section whenever you have issues with your app code so that you can get adept at the use of the debugger. However, there are also other tools available that will help you investigate how your app is running from both a layout and performance perspective, so let's look at those next.

# DevTools

Dart DevTools is defined in the documentation as follows:

"A suite of performance tools for Dart and Flutter."

DevTools can also be accessed via the web browser. You may have seen the URL alongside the Observatory URL when you did a flutter run. However, most people will use DevTools from within their IDE, so let's explore that option further.

If you still have the Hello World app running, then you will see a magnifying glass on the debug controls. Click this button to open up the wonderful world of DevTools.

## The widget inspector

We are currently in debug mode, so the widget inspector will be opened for us, allowing us to inspect the layout of our app. The widget inspector allows us to check whether our widget tree is taking more space than needed, whether it has more widgets than needed, or whether a widget is being created at the right time/level.

Open up the widget inspector and you will have a view similar to this:

![Figure 11.5 - Widget inspector in Visual Studio Code ](/flutter4beginners2_img/figure_11.5_-_widget_inspector_in_visual_studio_code.jpg)

As you can see, the widget tree is presented and we can access all details about each widget. For web developers, this will look very similar to element explorers in web developer tools, such as the one in Chrome, for instance.

You can also manipulate the widgets by changing properties such as flex and fit to experiment with layout changes. Whenever you click on a widget in the tree, Visual Studio Code will show you the relevant code that created the widget in the code pane, allowing quick identification of why the tree is structured as it is.

Two amazing features are the Show debug paint and Select widget mode buttons.

The Show debug paint button will draw all of the layout rules directly onto the screen so that you can see why a widget is positioned the way it is:

![Figure 11.6 - Hello World app with Show debug paint enabled ](/flutter4beginners2_img/figure_11.6_-_hello_world_app_with_show_debug_paint_enabled.jpg)

As you can see, Show debug paint shows arrows explaining how the layout is defined, and boxes to show the boundaries of the widgets. In this example, the buttons column has been centered, as shown by the two arrows on the side pushing in the column. You can also see that the textbox is the widest widget in the column and is the width it is, therefore the column width is defined by the width of the text widget because the column widget resizes to match the size of its children.

The Select Widget Mode button allows you to tap a widget on your app and instantly see where that widget is in the widget tree. And vice versa, you can click a widget in the widget tree and instantly see the widget highlighted on the app.

## Profile mode

When we execute our Flutter application in default debug mode, we cannot expect the same performance as the release mode. As we already know, Flutter executes in debug mode using the JIT Dart compiler as the app runs, unlike the release and profile modes, where the app code is pre-compiled using the AOT Dart compiler.

To make performance evaluations, we need to make sure the app is running at its maximum capability; that's why Flutter provides different execution methods: debug, profile, and release.

In profile mode, the application is compiled in a very similar way to release mode, and this is clearly understandable, as we need to know how the app will perform in real scenarios. The only overhead added to the app is the required ones to make the profiling enabled (that is, the Observatory can connect to the application process).

Another important aspect of profiling is the necessity of a physical device. Simulators and emulators do not reflect the real performance of real devices. As the hardware is different, app metrics can be influenced, and the analysis might be correct.

To run an app in profile mode, we should add the --profile flag to the run command (remember, it's only available on real devices):

```
flutter run --profile
```

Running in this mode, we have all of the required information to inspect the app performance in general. Another useful tool the profile mode enables is the performance overlay.

To achieve this in Visual Studio Code, click the settings cog to the right of where you would run the app in debug mode, to open the launch.json file. Alternatively, find the launch.json file in the explorer pane, within the .vscode folder.

You will see configurations like this:

```
    "configurations": [
        {
            "name": "hello_world",
            "request": "launch",
            "type": "dart"
        }
    ]
```

This will run flutterMode, which is debug. To add another option, update the configurations list to include a profile option like this:

```
    "configurations": [
      {
        "name": "hello_world",
        "request": "launch",
        "type": "dart"
      },
      {
        "name": "hello_world_profile",
        "request": "launch",
        "type": "dart",
        "flutterMode": "profile"
      }
    ]
```

Once you save this file, you will see an additional option in the dropdown of run targets. This time, run the profile version, hello_world_profile.

When the app is running, you will notice that the magnifying glass for DevTools is now a wave. Click on this to open the Performance page. Flutter aims to provide high-performance apps with a high frame rate and smoothness. Like debugging can help to find bugs, profiling is a useful tool that helps developers to find performance bottlenecks in their application, prevent memory leaks, or improve app performance.

When you open the performance page, you will see a display similar to this:

![Figure 11.7 - Performance page in Visual Studio Code ](/flutter4beginners2_img/figure_11.7_-_performance_page_in_visual_studio_code.jpg)

Memory, CPU usage, and other information are available through the monitor so that we can evaluate different aspects of the application.

One very useful button is the Show performance overlay button.

### Performance overlay

When you use the Show performance overlay button, the performance overlay is shown on the app. The visual feedback displayed provides multiple helpful performance statistics. Specifically, it displays information about rendering time. Here is an example of performance overlay being displayed:

![Figure 11.8 - HelloWorld app with performance overlay ](/flutter4beginners2_img/figure_11.8_-_helloworld_app_with_performance_overlay.jpg)

Two graphs are displayed representing the time to render frames taken by the two threads, UI and Raster. The current frame is displayed by a full-height vertical green bar, seen on the image about a quarter of the width of the screen from the left overlaying the two performance graphs. Additionally, we can see the last 300 frames and have an idea about critical rendering stages.

Flutter uses multiple threads to do its job. UI and Raster contain the display work of the framework, and that's why both are shown in the performance overlay.

### UI thread

The UI thread is where your Dart code is executed, and any Flutter framework code required to execute on behalf of your app. Any user interface requirements you specify in your code are converted into a layer tree, a set of painting commands, which are sent to the raster thread.

### The raster thread

This thread is where the graphics are brought to life. It does this by taking the layer tree and working with the Graphics Processing Unit (GPU) to draw the painting commands on the screen. The thread also includes a graphics library named Skia. You will never directly interact with this thread, but if it is running slowly, then it will be because of something that is happening in the UI thread.

### Other threads

In addition to those threads, Flutter also contains the platform thread, where the plugin code runs, and the I/O thread, where expensive I/O tasks are run. Neither of these threads appear on the platform overlay.

# Summary

In this chapter, we learned about unit testing Dart so that we can be confident that our library functions are following the requirements under a range of data inputs.

We saw an introduction to Flutter widget tests and how they can be used to test widgets individually. We looked at how they are structured with the WidgetTester class in the testWidgets function.

We also saw how to debug our app, first by looking at the Dart Observatory and the method calls of debugging and assertions, and then by using the debugging facilities of the IDE.

Finally, we investigated how we can use Flutter DevTools to explore the widget tree in debug mode and application performance in profile mode.

In the next chapter, we will finish the journey of our app by looking at how we can release it into the world for everyone to use!

