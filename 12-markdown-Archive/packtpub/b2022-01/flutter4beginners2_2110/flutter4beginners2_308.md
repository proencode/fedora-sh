원본 제목: Chapter 8: Plugins – What Are They and How Do I Use Them?
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/308
Title:
308 Plugins – What Are They and How Do I Use Them?
Short Description:
Flutter for Beginners Second Edition 플러그인이란 무엇이며 어떻게 사용합니까?

![Figure 8.7 - Issues tab of the GitHub repository ](/flutter4beginners2_img/figure_8.7_-_issues_tab_of_the_github_repository.jpg)
- cut line


# Chapter 8: Plugins – What Are They and How Do I Use Them?
Flutter for Beginners Second Edition

Flutter is lucky to have an amazing community of developers who share code with each other via plugins. It is this kind of open source approach that allows frameworks such as Flutter to thrive and allows for innovation across the platform. It also means you generally don't need to re-invent the wheel, allowing you to focus on the unique aspects of your app, rather than spending a lot of time working on basic functionality.

This chapter will start by explaining what a plugin is and how you can add them to your app. There is a wide range of plugins available, from user interface widget libraries to low-level messaging tooling and music management classes, so the setup is somewhat bespoke for each plugin. However, there are general rules to follow and best practices for managing versions.

Finally, we will look at some common challenges with plugins and how to resolve them.

The following topics will be covered in this chapter:

- What is a plugin?
- Where can I find plugins?
- How do I add a plugin to my project?
- How do plugins work on iOS and Android?
- Common issues

By the end of the chapter, you will be able to add plugins to your app, allowing you to really explore some of the exciting capabilities of Flutter.

# Technical requirements

You will need your development environment again for this chapter as we will add a plugin to the hello world project. Look back at Chapter 1, An Introduction to Flutter, if you need to set up your IDE or refresh your knowledge of the development environment requirements.

You can find the source code for this chapter on GitHub at the following link: https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/lib/chapter_08.

# What is a plugin?

Many programming frameworks and software tools have the concept of plugins. They may go by another name, such as third-party libraries, extensions, or add-ons, but they are effectively the same thing – a self-contained, modular code deliverable that can be "plugged in" to your existing app code to provide extra functionality.

Within this chapter, you will see references to the term packages, a chunk of Dart code, and assets. A plugin is a special type of package that makes functionality available to your app and this is what we are looking at in this chapter.

There are many benefits as well as drawbacks to the plugin approach. So let's take a look and understand why Flutter would choose to use plugins within the framework and then we will move on to the drawbacks.

## Benefits

As you would expect, Flutter uses plugins because they bring many benefits. This is especially true of code reuse; creating a great Flutter app would be much harder if you had to create everything from scratch. Let's look at the benefits.

### Code reuse

As a developer, you will understand that nobody wants to recreate code if they can help it. Not only does it waste time, but it can also introduce bugs when the recreated code contains mistakes or doesn't take into account all the different execution flows that the original code considered. Additionally, the recreated code can cause maintenance headaches when fixes are required because you need to double fix your code.

Plugins alleviate this problem by solving a specific issue (for example, linking to the device calendar) and all your app code can reference that single plugin. If an issue is found, the plugin can be updated, and all users of the plugin will gain the benefit of the fix.

### Many eyes

One of the great things about plugins is that because many people use them and find issues with them, the plugins become very stable and feature-rich.

You may feel that in some cases it is easier just to write your own code, but it is almost impossible to test your code on all the different devices out there, all the different screen ratios, or used in all the weird and wonderful ways that users manage to find. Plugin code is effectively tested for free across devices, screen ratios, and usage patterns, so why not take advantage of that.

### Low-level integration

For some functionality, you will need to integrate with the base operating system (OS) of the device. This could require Java, Swift, JavaScript, or some other language that can interface with the OS, and unless you are proficient in those languages and also knowledgeable about the APIs available within the OS, this could be quite a challenge.

Plugins take care of that need to understand low-level integration, so you can spend your time becoming an expert in Dart and Flutter.

There are, as you would expect, some downsides to using plugins, so let's take a quick look at those now, and then explore how to alleviate them later in the chapter.

## Drawbacks

As with any software decision, especially on such a huge scale as plugins, there will be drawbacks that you need to consider when using them. The benefits massively outweigh the drawbacks, but you should still be aware of them so that you can decide how to mitigate their impact.

### Version management

Like any good plugin system, all plugins in Flutter are versioned using the semantic versioning scheme. This means it is easy to manage which version of a plugin you are using, and ensure that you have the latest or best (not always the same) version of the plugin for your app.

However, with any versioning system, there is the potential for incompatibility, especially when you have a large number of inter-dependent plugins. This can cause problems, and in rare cases, block you from releasing your app.

Semantic versioning

Versioning software is generally required in any software project for lots of good reasons. Semantic versioning standardizes the way versioning is done.

It uses three digits separated by a dot, for example, 1.2.3.

These follow the major.minor.patch structure. The major number is incremented when there is a breaking change or big update to the software. The minor number is incremented when new code that is backward compatible is released, and the patch number is incremented when a fix is added that is low risk.

### Difficult to diagnose bugs

Some plugins can be quite complicated, and when something doesn't quite work as you would expect, it can be difficult to resolve the problem. Generally, plugin writers are happy to assist if you find an issue, but sometimes issues can be hard to recreate, or worse, only happen on release versions rather than debug versions, so you only have second-hand information about the problem.

In many ways, the issue isn't that the plugin has a bug, it's that it is hard to diagnose because you didn't write the code. On the flip side, if you did write the code, instead it would probably also contain the same bug and you would have a lot more code to maintain, so you may not have time to look at resolution.

### Breaking changes

Sometimes, a plugin developer will make a breaking change because they want to fundamentally change the way the plugin works, or they want to standardize their plugin with the approach of other plugins, or for one of many other reasons.

The plugin developer will create a new version of the plugin with the major version incremented and warn developers of the change. You don't have to take the new version of the plugin, but the developer is unlikely to maintain older versions, so it is preferable to stay on the latest version so that you can receive any bug fixes.

This can sometimes have a large impact on your code, especially if you rely heavily on that plugin.

So now you have a feel about what a plugin is and the pros and cons of using them, let's take a look at where you can find them and what they look like.

# Where can I find plugins?

Flutter has a very easy way to find the plugins that you may need via the https://pub.dev site that they maintain. This is where all plugins are registered and the primary way that developers find plugins.

This site not only allows you to search for plugins but also includes useful sections such as the following:

- Flutter favorites: Plugins that demonstrate the highest levels of quality.
- Most popular packages: The most downloaded plugins.
- Package of the week: This is a series of animated videos that introduce some of the plugins available. Flutter has been very successful in the use of short videos to introduce the widget of the week and has rolled out the concept of package of the week.

Let's now take a look at the individual entries for a plugin at pub.dev.

### Plugin entry

One of my personal favorite plugins is the one that introduces a new widget, the AutoSizeText widget. Just like the name suggests, this widget will resize the text it contains so that it fits within the bounds.

To find the plugin, simply type auto size text in the search bar and your results will look something like this:

![Figure 8.1 - Pub.dev search results ](/flutter4beginners2_img/figure_8.1_-_pub.dev_search_results.jpg)

The first thing you will notice is that there are lots of plugins that do similar things, so it used to be very tricky to work out which plugin was best maintained and most used. As you can imagine, accidentally using a plugin that is no longer maintained means that bug fixes are not actioned and upgrading transient dependencies (other plugins that this plugin depends on) does not happen. Additionally, choosing a plugin that nobody else uses means it may not have been tested as thoroughly as the other plugins that are available.

However, pub.dev now shows a series of metrics and other information so that you can make a more informed choice. It may feel like we are focusing a little too much on plugin searching, but making the right choice can make a huge difference to your project, and potentially make or break it.

Key information to take from this page is obviously the metrics on the right (which we will look at soon), but also the following:

- The updated date: Is the code still being maintained?
- The list of supported platforms: For auto_size_text, the supported platforms are Android, iOS, Linux, macOS, Web, and Windows.
- Tags: When Flutter has a big change, plugins are tagged to show whether they have completed the change. In this example, the move to Null safety is very important, and only the second result has been tagged as having made the transition to Null safety. However, note that auto_size_text actually has two versions available, the second of which is named nullsafety.0, suggesting that the work is ongoing to move to a null safe release.

If we click on auto_size_text, we can see further details about the plugin:

![Figure 8.2 - The auto_size_text details page ](/flutter4beginners2_img/figure_8.2_-_the_auto_size_text_details_page.jpg)

Much of the details from the search page are replicated, including the metrics:

- Likes: As you would expect, if people like the plugin, then they can "like" it.
- Pub points: The plugin is analyzed and assigned points (out of 110) on code maintainability, documentation, platform support, up-to-date dependencies, and so on.
- Popularity: A measure of how many apps rely on the plugin.

Used together, these are a very powerful way to assess the maturity of the plugin and how likely it is to be maintained in the future.

Other useful information on the page includes the following:

- Readme: This is where the information about the plugin is kept, often including installation and project configuration instructions.
- Changelog: This is where you can look at why a plugin version has been increased. This is especially useful when you need to upgrade a major version and want to know what breaking changes there were.
- Example: Most plugins come with a small example app so you can see how the plugin is used.
- Installing: A high-level guide to how to install this plugin. Generally, you wouldn't need to look closely at this section as all plugins are installed in the same way.
- Repository (GitHub): Most plugins are developed via a GitHub repository and link to it from this page. If you want to see how the plugin works, then this is the place to look.
- View/report issues: A hugely important link because you can see what issues other people have reported and how the resolution is progressing, and also raise your own issues. Note that most plugin maintainers volunteer to maintain their plugin and therefore have other jobs, so please be understanding if they are unable to respond to any issues immediately.

Due to the huge size of the Flutter community, there are also many video and text tutorials available for plugins across the web, on publications such as Medium and YouTube, that can give additional guidance.

So now that we've seen how to access key information about a plugin, let's try adding the auto_size_text plugin to our hello world project.

# How do I add a plugin to my project?

Adding a plugin to your project is generally surprisingly easy. However, it is crucially important that you read the readme fully because for some plugins, there can be platform-specific configuration that you need to set up before the plugin will run. In some extreme cases (such as google_mobile_ads), your app will completely fail to start unless the plugin setup has been completed correctly.

We will use the example of auto_size_text as a plugin we wish to add. We saw above the readme for this plugin, but let's look at the Installing section now. The following screenshot shows the instructions for installation:

![Figure 8.3 - The auto_size_text installation instructions ](/flutter4beginners2_img/figure_8.3_-_the_auto_size_text_installation_instructions.jpg)

There are two ways to add a plugin to your project, but the outcome is the same.

The first option is to run a flutter command on the command line to do all the work for you:

```
flutter pub add auto_size_text
```

The other option is to replicate what that command does under the covers. I suggest that you follow the steps in the next section to begin with so that you understand what is happening.

## The pubspec.yaml file

The pubspec.yaml file is where dependencies and assets are configured. There is a specific section called dependencies that holds information about plugins that your project depends on.

It will look something like this:

```
dependencies:
  flutter:
    sdk: flutter
  # The following adds the Cupertino Icons font to your   application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.1
```

The indentation is crucial here and is what YAML files rely on to understand the contents. Note that cupertino_icons: ^1.0.1 is indented by two spaces. This denotes that it is under the dependencies header and therefore is a dependency of the project.

Under cupertino_icons, add another line, indented by two spaces, which says the following:

```
  auto_size_text: ^2.1.0
```

You have now declared that your project depends on the auto_size_text plugin. If you are sharing your project with other developers, then they will instantly see the dependency and be able to update the project accordingly.

You have also specified the version of the plugin using the plugin's semantic version. This locks your app to a specific version of the plugin, allowing you to test and release without dependency changes sneaking in. You may have noticed the ^ character before the version number. This specifies that you are happy to receive any patch version updates to the plugin.

For example, if you specify version 2.1.0, then only version 2.1.0 will be used by you and any other developers that are using this source code. If you specify version ^2.1.0, then any version 2.1.x where x >= 0 can be used. This means you will automatically receive patch updates (when you download the plugin). There is a risk that you may have a slightly different version of the plugin to your colleagues, but there will only be disparities at the patch level.

The plugin isn't yet downloaded and available to your project. To do this, we will use a very useful command called flutter pub, which is used to manage plugins.

## flutter pub

Within the flutter command, there is a pub command that is specifically used for plugin management. There are several ways you can use it, so let's look at some of the most used ones.

### flutter pub get

The flutter pub get command will read through all the dependencies in pubspec.yaml, retrieve the relevant plugins from pub.dev, and download them to a central repository on your computer, ready for your project to access it.

We need to use the following command at this point to download the auto_size_text plugin that our project depends on:

```
PS C:\Flutter\hello_world> flutter pub get
Running "flutter pub get" in hello_world...        2,142ms
```

Occasionally, flutter pub get will fail due to inconsistent dependencies and we will look at how to resolve that in the Common issues section later in the chapter.

At this point, the plugin dependency has been declared and downloaded to your computer.You are ready to go, but let's just look at some other useful flutter pub commands.

### flutter pub outdated

This command will check whether any of your dependencies have newer versions that you may want to upgrade to. Running this command will give you output like the following:

```
PS C:\Flutter\hello_world> flutter pub outdated
Showing outdated packages.
[*] indicates versions that are not the latest available.
Package Name  Current   Upgradable  Resolvable  Latest  
direct dependencies: all up-to-date.
transitive dev_dependencies:
crypto        *3.0.0    *3.0.0      *3.0.0      3.0.1
vm_service    *6.1.0+1  *6.1.0+1    *6.1.0+1    6.2.0
You are already using the newest resolvable versions listed in the 'Resolvable' column.
Newer versions, listed in 'Latest', may not be mutually compatible.
```

Although this looks quite intimidating, the key part to note is that your direct dependencies are all up to date, so you don't need to do anything further.

If the command shows that there are newer dependencies, then you will first need to understand what the changes are, by going to pub.dev and reading the changelog. Then, you can update pubspec.yaml to specify the new version, and finally run flutter pub get to download the latest version to your computer.

### flutter pub upgrade

It was mentioned earlier that the version can include the ^ symbol to specify that you are happy to receive patch updates.

These patch updates do not magically appear on your computer; you still need to tell Flutter to retrieve the updates. You can do this with the flutter pub update command. It is much like flutter pub get, but you give it permission to get the latest plugins within the constraints of the versions specified in pubspec.yaml.

So now that you understand a bit more about Flutter plugin management, we can explore how you would use the plugin within your code next.

## Using a plugin in your code

Now that the plugin code has been downloaded to your computer, and you have specified that your project depends on that plugin, the next step is to import the code into the classes where you need it.

### Import statements

If you look at the main.dart file, you will see the following import statement at the very top:

```
import 'package:flutter/material.dart';
```

Like virtually any other programming language, import statements allow you to reference code in other classes, packages, and plugins. In this example, the material.dart file is being imported, with all the classes and functions within that file being made available to your class. We will use an import statement to access the plugin code, but first, let's create a new file to hold a new stateless widget.

### Adding Dart files

In your IDE, create a new file within the lib folder named red_text_widget.dart and open it up. It will initially be empty, so let's put some code in there.

You may have a shortcut in your IDE that allows you to generate the stateless widget code. Try typing stless and see if the IDE gives you any hints. If it does, set the widget name to RedTextWidget. If not, simply copy the following code into the file:

```
class RedTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

You may notice that there are errors on the page. This is because you need to add an import statement. In isolation, the class name StatelessWidget doesn't exist, it isn't within the same Dart file, so the compiler has no idea what it is.

We need to add the same import that we saw on the main.dart file to import all the standard Flutter framework classes, so at the very top, add the following:

```
import 'package:flutter/material.dart';
```

Ta da! The errors disappeared. You now have a stateless widget that returns an empty Container widget from the build method.

Let's add a constructor parameter that takes a String named text. We will pass the contents of this parameter down to the AutoSizeText widget when we add it.

Your widget will look like this:

```
import 'package:flutter/material.dart';
class RedTextWidget extends StatelessWidget {
  final String text;
  RedTextWidget({required this.text});
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

In this example, we have used a named parameter, text, used a shortcut assignment within the constructor using this.text, and specified that it is a required parameter using the required keyword.

### Using the plugin

Now let's use the AutoSizeText widget in our shiny new widget. Firstly, we need to tell the compiler that we want to access the AutoSizeText widget classes, so add the following import statement to the top of your file:

```
import 'package:auto_size_text/auto_size_text.dart';
```

Now that the code is available, we can use the widget within our build method. Let's simply return AutoSizeText with the String value from our text parameter, which will look like this:

```
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: TextStyle(color: Colors.red),
    );
  }
```

You'll notice that the AutoSizeText widget looks just like any other built-in widget because it is just like any of the built-in widgets. The widget takes one required positional constructor parameter (text) and one optional named constructor parameter (style). It has many other optional named constructor parameters so that you can further control the look of the widget.

### Putting it all together

Finally, let's add our new widget to the MyHomePage widget so that it is visible. We need to add the import statement for our new file so that, just like how we imported the AutoSizeText widget code, the code of our RedTextWidget is available to this class:

```
import 'package:hello_world/red_text_widget.dart';
```

We can then change the first Text widget in our column to be RedTextWidget:

```
RedTextWidget(
  text: 'You have pushed the button this many times:',
),
```

You will see that a Text widget has a required positional constructor parameter for the text, but our widget has a required named constructor parameter called text. If a parameter is fundamental to the widget, then having it as a positional parameter makes sense. However, many of the built-in widgets were created before the required named constructor parameters were an available feature in Dart. In general, named parameters are preferable because they help with readability and maintainability, and definitely reduce the chance of introducing bugs due to incorrect parameter ordering.

Let's run our app and check that it all works correctly. The app should appear and look like this:

![Figure 8.4 - RedTextWidget incorporating the AutoSizeText plugin ](/flutter4beginners2_img/figure_8.4_-_redtextwidget_incorporating_the_autosizetext_plugin.jpg)

We can see the text is now red as we hoped. Congratulations, you just used your first plugin!

You should now be starting to see the power of Flutter plugins and how they can boost the awesomeness of your app. In this section, we explored the pubspec.yaml file and learned about its purpose, we learned how to add plugins and ensure they are up to date, and we then experimented with adding a plugin to our app code. Using this same process, you can add whichever plugins you want to your app – the plugin world is your oyster.

The AutoSizeText plugin has no platform-specific code; it is purely presentational in its purpose. However, some plugins have deeper dependencies on the platform they run on. Let's explore that now.

# How do plugins work on iOS and Android?

Many plugins will work with the different underlying platforms to use operating system functionality. This dependency changes the way your project is built and run because there is native code within your project that interfaces with the underlying platform. Let's look at how that interfacing works.

## MethodChannel

Flutter communication between the client (Flutter) and the host (native) application occurs through platform channels. The MethodChannel class is responsible for sending messages (method invocations) to the platform side. On the platform side, MethodChannel on Android (API) and FlutterMethodChannel on iOS (API) enable receiving method calls and sending a result back. The structure of this relationship is shown in the following diagram.

![Figure 8.5 - Interface between Flutter and native ](/flutter4beginners2_img/figure_8.5_-_interface_between_flutter_and_native.jpg)

The platform channel technique allows for the decoupling of the UI code from the platform-specific native code. The host listens on the platform channel and receives a message request. It can use platform APIs to enact the request and then sends back a response to the client, the Flutter portion of the app.

In this way, the Flutter part of the app is agnostic to the host allowing you to write code that will work across all platforms.

Having this base understanding of plugins will allow you to better diagnose issues and assess plugin suitability for your app.

Let's explore a little further by adding a plugin to our project that uses native code. An example of such a plugin is the device_info_plus plugin. It retrieves information about your device from the underlying platform, such as the model and device name.

So, add the latest device_info to your pubspec.yaml file using the following command:

```
flutter pub add device_info_plus
```

If you want further information on the plugin, then head over to the pub.dev site and search for device_info_plus.

Take a look at the pubspec.yaml file and you will see that the device_info_plus plugin has been added within the dependencies section. Also, the flutter pub get has automatically been run to pull the Flutter code into your project. However, you do not yet have the native code available.

If you run (or build) the project, Flutter will automatically retrieve the native code dependencies. These are managed by CocoaPods in iOS and Gradle in Android.

## CocoaPods

For iOS native code libraries, Flutter uses the CocoaPods dependency manager. Flutter plugins that need iOS native code will specify a dependency on a CocoaPods library and the CocoaPods dependency manager will download the relevant library at the correct version and include it in your iOS build.

After you have run your project on an iOS emulator or device, you may notice that there is a file that has appeared within the iOS folder within your project files. This is called PodFile and manages your CocoaPods dependencies.

When you run or build your project, the CocoaPods dependency manager is invoked by calling the pod install command within the ios folder. All the dependencies are retrieved at the correct versions for your project.

Sometimes plugins will ask you to manage your app permissions. This can be done in the ios/Runner/Info.plist file.

This part of the build process can often cause issues when you are changing your dependencies, so in the Common issues section of this chapter, we explore some solutions.

## Gradle

Building and running Flutter apps on Android uses the Gradle build automation tool. You can explore some of the files in the android folder, but the ones that you will occasionally need to change to configure plugins will be the following:

- android/build.gradle
- android/app/build.gradle

These files manage the build process and dependencies that your project needs, and occasionally some manipulation of versions or build flow is needed for a plugin to work correctly.

Additionally, like iOS, some plugins will require updates to app permissions. This can be done in the android/app/src/main/AndroidManifest.xml file.

Now you have a basic idea of the plugin process, let's see some common issues you may encounter and how to solve them in the next section.

# Common issues

Sometimes your Flutter run or build will fail, and often this is related to plugin issues. In this section, we will look at some of the common issues and give some hints for how to resolve them.

## Plugin breaking change

When a plugin changes its major or minor version number, it can mean that there has been a breaking change and that you will need to make some changes to keep the plugin working correctly.

There are generally two reasons for breaking changes:

- A change in the way you use the plugin at a programming level. For example, the constructor parameters for a widget have changed, or the flow of method calls to the plugin needs to be modified. These are often simply notified via compilation errors and deprecation warnings.
- A required change in the configuration of your project. These can be less obvious and checking the plugin readme on pub.dev is often the best way to assess whether you need to change your project configuration.

On the pub.dev page, there is a section specifically dedicated to explaining why version changes have happened called Changelog:

![Figure 8.6 - Changelog section of the device_info plugin ](/flutter4beginners2_img/figure_8.6_-_changelog_section_of_the_device_info_plugin.jpg)

In this section, plugin developers will often display the different types of updates that have happened during each version increment, including breaking changes, so that app developers can easily see what changes they need to make.

Additionally, plugin developers will make a mistake and release a breaking change without the correct version change. Plugin developers often give their time voluntarily to plugin development, so may make a mistake due to a lack of time or experience. Again, it is worth checking the readme and changelog at pub.dev if you are having any issues, just to check no sneaky breaking changes made their way into an update.

## Plugin not working

There will be times when you believe that a plugin is not working in the way you expect it to. There is an easy way to report issues via the View/report issues link on the pub.dev page for the plugin. Generally, this link will take you to the Issues tab of the plugin's GitHub repository where you can check if the issue has already been raised and whether a fix is in progress:

![Figure 8.7 - Issues tab of the GitHub repository ](/flutter4beginners2_img/figure_8.7_-_issues_tab_of_the_github_repository.jpg)

It is worth noting that because plugins are generally community-created, there are often other developers that will attempt fixes for the plugin and share the pull request (PR) with the plugin developers to help them. When you are confident with Flutter, feel free to try to help the plugin developers if you identify an issue and think you know the solution.

## PR not merged

Sometimes you will notice an issue with a plugin that someone in the community has fixed and they have issued a PR that has not yet been merged into the plugin's master code branch. This can happen often with less popular plugins where the number of contributors is low, and the main contributors have perhaps moved on from the plugin.

However, even without the PR being merged, you can still use it in your project as a dependency. This can be very useful if you need a fix, and a developer has already fixed it but it hasn't been merged. Sometimes, you can't wait for that merge to happen because the issue is blocking your next app release.

Therefore, to take advantage of the PR before it is merged, add a new section to your pubspec.yaml called dependency_overrides and add a link to the git entry. Here is an example for the device_calendar plugin that was required when Flutter moved to null safety and the device_calendar plugin PR for null safety had not yet been merged into the plugin's master branch:

```
dependency_overrides:
  device_calendar:
    git:
      url: https://github.com/thomassth/device_calendar_null.      git
```

As you can see, you specify the plugin name and then the location of the override repository.

## Inconsistent dependencies

As with any dependency management system, there are times when one plugin depends on a specific dependency that clashes with the version another plugin depends on.

Often the resolution is to make sure that all of your plugins are at the latest version. However, if this does not resolve the problem, then you may need to raise an issue with the plugin developer, and then move back to older plugin versions where the dependencies play more nicely together.

You may also have this issue when you are running a build on iOS. The CocoaPods dependencies sometimes clash unexpectedly. You can often resolve this by manually tidying up your CocoaPods repository.

If you open a terminal in the ios folder of your project, there are a few commands you can try to clean up the data. The first is to manually run the pod install and see what error messages you get:

```
pod install
```

You can try removing the ios/Pods directory (all the downloaded dependencies) and the Podfile.lock file and then rerun pod install on a fresh directory.

Additionally, you will sometimes need to update the CocoaPods repository. This lists all of the pods and versions of libraries that are available to CocoaPods and can become stale. To do this, run the following command:

```
pod repo update
```

If none of these resolve the problem, then a trip to the Issues section on GitHub is probably your answer.

## MissingPluginException

There are many other issues, including the infamous MissingPluginException, that are often solved with a little cleanup of the Flutter folders.

Cleaning up is pretty easy. Firstly, run the following command:

```
flutter clean
```

This will clean up dependencies and build folders.

Then run the following command:

```
flutter pub get
```

This will retrieve all the dependencies again.

There are many other errors that you can get, most of which people have encountered many times and an internet search will often find you the answer, with StackOverflow being a great resource for identifying solutions.

# Summary

In this chapter, we have explored the concept of plugins and what they are. We have explored the benefits of using plugins, and also some of the drawbacks that you need to be aware of.

We have investigated how you can find plugins and what to look for when choosing a plugin from the many that may be available. Specifically, we looked at pub.dev and all the information available on there to make using plugins easy.

We looked at how to add a plugin to your project, how to manage versions within the pubspec.yaml file, and how to use the plugin within your code.

Finally, we saw some of the common issues that can be encountered when using plugins and some suggestions for how to resolve them.

In the next chapter, we will look at some of the common plugins that are used in projects. This will give you an idea of the different areas of your project where plugins can be useful and highlight the most popular plugins with Flutter.

