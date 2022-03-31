원본 제목: 2 Getting Started with Flutter
원본 링크: https://subscription.packtpub.com/book/mobile/9781838823382/1
Path:
packtpub/flutterCookbook/102
Title:
102 Getting Started with Flutter
Short Description:
Flutter Cookbook 플러터 시작하기

![Figure2.27-HOT reload button ](/flutter_cookbook_img/figure2.27-hot_reload_button.webp)
---------- cut line ----------


# Getting Started with Flutter

Creating your development environment is the first task that every developer has to go through when starting with a new platform. In some ways, the ease in which you can go from nothing to building software can be seen as a litmus test for how your experience with the platform is going to be. If the environment is difficult and painful to set up, then it might be very likely that it will be difficult and painful to work with.

The Flutter engineers must have taken this to heart because getting started with Flutter is easier than with other frameworks. You can divide the process into three distinct sections. First, you have to install the Flutter software development kit (SDK). Then, you have to install at least one platform SDK—iOS or Android, or both if you are working on a Mac. Since Flutter 2.0, you can also install a desktop SDK to develop apps for Windows, macOS, or Linux. The final stage is choosing which editor, or integrated development environment (IDE), you want to use. To make this process even easier, Flutter has a tool called Flutter Doctor that will scan your environment and offer you step-by-step guides for what you need to do to successfully complete your environment setup. This means that the Flutter team has made every effort to help you successfully install and use Flutter to develop your projects.

By the end of this chapter, you will have Flutter fully installed and will have learned how to create an app and run code on a virtual device.

In this chapter, we'll be covering the following recipes:

- How to use Git to manage the Flutter SDK
- Setting up the command line and saving path variables 
- Using Flutter Doctor to diagnose your environment
- Configuring the iOS SDK
- Setting up CocoaPods (iOS only)
- Configuring the Android SDK setup
- Which IDE/editor should you choose?
- Picking the right channel
- How to choose the platform language for your app
- How to create a Flutter app
- How Flutter projects are structured
- How to run a Flutter app
- How to use Hot reload to refresh your app without recompiling

> While Flutter is compatible with Windows, macOS, and Linux, if you are interested in building applications for Apple's platforms (iOS and macOS), you will need a Mac to build your app.
{.is-info}


# Technical requirements

Building mobile applications can be a taxing task for your computer.  

Your computer should have the following:

- 8 GB of random-access memory (RAM) (16 gigabytes (GB) preferred)
- 50 GB of available hard drive space
- A solid-state drive (SSD) hard drive is recommended
- At least a 2 gigahertz (GHz) + processor

If you want to build for iOS, you will also need a Mac instead of a PC.  

These are not strict system requirements, but anything less than this may lead to you spending more time waiting rather than working.

## How to use Git to manage the Flutter SDK

Before you can build anything, you need to download the Flutter SDK. If you go to the main Flutter website at https://flutter.dev, they currently recommend that you download one of their prebuilt packages for macOS, Windows, or Linux. This is certainly OK, and if you feel comfortable with this approach, you can certainly follow it. However, we can do better. Since Flutter is completely open source and hosted on GitHub, if you just clone the main Flutter repository, you'll already have everything you'll need, and you can easily change to different versions of the Flutter SDK if needed.

The packages that are available to download on Flutter's website are snapshots from the Git repository. Flutter uses Git internally to manage its versions, channels, and upgrades, so why not go straight to the source?

## Installing Git 

First, you need to make sure you have Git installed on your computer. If you are developing on macOS, you can skip this step.

For Windows, you can download and install Git here: https://git-scm.com/download/win.

You might also want to get a Git client to make working with repositories a bit easier. Tools such as Sourcetree (https://www.sourcetreeapp.com) or GitHub Desktop (https://desktop.github.com) can greatly simplify working with Git. They are optional, however, and this book will stick to the command line when referencing Git.

To confirm that Git is installed on Linux and macOS, if you open your Terminal and type which git, you should see a /usr/bin/git path returned. If you see nothing, then Git is not installed correctly.

# How to do it...

Follow these steps to clone and configure the Flutter SDK:

1. First, choose a directory where Flutter is going to be installed. The location does not explicitly matter, but it will be simpler to install the SDK closer to the root of your hard drive.
1. On macOS, type in the following command:

```
cd $HOME
```

	This ensures that the terminal is pointing to your home directory. It might be redundant since most terminal windows automatically open to the home directory when they are opened.

1. We can now install Flutter with this command:

```
git clone https://github.com/flutter/flutter.git
```

This will download Flutter and all of its associated tools, including the Dart SDK.

# See also

If you do not feel comfortable using Git, you can certainly install your Flutter SDK by following the instructions at https://flutter.dev/docs/get-started/install. 

# Setting up the command line and saving path variables

Now that you have cloned the Flutter repository, there are few more steps needed to make the software accessible on your computer. Unlike apps with user interfaces (UIs), Flutter is primarily a command-line tool. Let's quickly learn how to set up the command line on macOS, Linux, and Windows in the following sections.

# macOS command-line setup

To actually use Flutter, we need to save the location of the Flutter executable to your system's environment variables.


> Newer Macs use the Z shell (also known as zsh). This is basically an improved version of the older Bash, with several additional features.
{.is-info}

When using zsh, you can add a line to your zshrc file, which is a text file that contains the zsh configuration. If the file does not exist yet, you can create a new file, as follows: 

1. Open the zshrc file with the following command:

```
nano $HOME/.zshrc
```

	This will open a basic text editor called nano in your terminal window. There are other popular tools, such as vim and emacs, that will also work.

1. Type the following command at the bottom of the file:

```
export PATH="$PATH:$HOME/flutter/bin"
```

1. If you chose to install Flutter at a different location, then replace $HOME with the appropriate directory. 
1. Exit nano by typing Ctrl + X. Don't forget to save your file when prompted.
1. Reload your terminal session by typing the following command:

```
source ~/.zshrc
```

1. Finally, confirm that everything is configured correctly by typing the following:

```
which flutter
```

You should see the directory where you cloned (or installed) the Flutter SDK printed on the screen.

# Windows command-line setup

> These instructions assume you are using Windows 10.
{.is-info}

You will now set up your environment variables for Flutter on Windows:

1. In the search bar at the bottom of the desktop, type env. You should see an Edit the system environment variables option appear. Select the icon to open the System Properties window, and at the bottom of the screen click the Environment Variables... button:

![Figure2.1-System Properties Settings ](/flutter_cookbook_img/figure2.1-system_properties_settings.png)

1. In the next dialog, select the Path variable in the User variables for User section and click the Edit... button:

![Figure2.2-Environment Variables Edit ](/flutter_cookbook_img/figure2.2-environment_variables_vdit.webp)

1. Finally, add the location where you installed Flutter to your path:

![Figure2.3-Add the Location Path ](/flutter_cookbook_img/figure2.3-add_the_location_path.webp)


1. Type C:\Users\{YOUR_USER_NAME}\flutter\bin, then select OK. Flutter should now be added to your path.
1. Restart your system.
1. Type flutter in the command line. You should see a message with some Flutter command-line interface (CLI) instructions. Flutter might optionally download more Windows-specific tools at this time.

# Confirming your environment is correct with Flutter Doctor

Flutter comes with a tool called Flutter Doctor that will be your new best friend when setting up the SDK. Flutter Doctor will give you a list of everything that needs to be done to make sure that Flutter can run correctly. You are going to use Flutter Doctor as a guide during the installation process. This tool is also invaluable to check whether your system is up to date.

In your terminal window, type the following command:

```
flutter doctor
```

Flutter Doctor will tell you if your platform SDKs are configured properly and whether Flutter can see any devices, including the web browser.

# Configuring the iOS SDK

The iOS SDK is mostly provided in a single application, Xcode. Xcode is one behemoth of an application and it controls all the official ways in which you will interact with Apple's platforms. As large as Xcode is, there are a few pieces of software that are missing. Two of these are community tools: CocoaPods and Homebrew. These are package managers or programs that install other programs. Flutter uses both of these tools in its build system.  

# Downloading Xcode

The iOS SDK comes bundled with Apple's IDE, Xcode. The best place to get Xcode is through the Apple App Store: 

1. Press Command + Space to open Spotlight and then type in app store:

![Figure2.4-Open Spotlight appstore ](/flutter_cookbook_img/figure2.4-open_spotlight_appstore.webp)

	As an alternative, you can just click on the menu in the top-left corner of your screen and select App Store, but keyboard shortcuts are much more fun.

1. After the App Store opens, search for Xcode and select Download:

![Figure2.5-Xcode Download ](/flutter_cookbook_img/figure2.5-xcode_download.webp)

Xcode is a rather large application, so it may take a while to download. While Xcode is installing, you can get some of the smaller tools that you'll need for development. Let's take a look at how to install these tools in the following sections.

# CocoaPods

CocoaPods is a popular community lead dependency manager for iOS development. It is essentially the equivalent of npm for the web community. Flutter requires CocoaPods in its build process to link any libraries you have added to your project:

1. To install cocoapods, type this command:

```
sudo gem install cocoapods
```

1. Since this command requires administrator privileges, you will likely be prompted to enter your password before continuing. This should be the same password that you use to log in to your computer.
1. After cocoapods has finished installing, type this command:

```
pod setup
```

This will configure your local version of the cocoapods repository, which can take some time.

# Xcode command-line tools

Command-line tools are used by Flutter to build your apps without needing to open Xcode. They are an extra add-on that requires your primary installation of Xcode to be complete:

1. Verify that Xcode has finished downloading and has been installed correctly. After it is done, open the application to allow Xcode to fully configure itself. Once you see the Welcome to Xcode screen appear, you can close the application:

![Figure2.6-Welcome to Xcode ](/flutter_cookbook_img/figure2.6-welcome_to_xcode.webp)

1. Type this command in the Terminal window to install the command-line tools:
```
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

1. You may also need to accept the Xcode license agreement. Flutter Doctor will let you know if this step is required. You can either open Xcode and will be prompted to accept the agreement on the first launch or you can accept it via the command line, with the following command:
```
sudo xcodebuild -license accept
```

# Homebrew

Homebrew is a package manager used to install and manage applications on macOS. If CocoaPods manages packages that are specific to your project, then Homebrew manages packages that are global to your computer. 

Homebrew can be installed with this command in your terminal window:
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

We will be using Homebrew primarily as a mechanism to get other, smaller tools. 

You can also get more information about Homebrew from it's website: https://brew.sh. 

# Checking in with the Doctor

Now that we have all the platform tools for iOS, let's run Flutter Doctor one more time to make sure everything is installed correctly.

You may end up seeing this as a result:

![Figure2.7-Flutter Doctor Result ](/flutter_cookbook_img/figure2.7-flutter_doctor_result.webp)

Remember how earlier you installed Homebrew? It's now going to come in handy. You now have two options to solve this problem: you can either copy/paste each one of these brew commands one by one into a terminal window or you can automate this with a single shell script.

Hopefully, you prefer option 2. 

1. Select and copy all the brew commands in Step 2, then enter nano again with this command:
```
nano update_ios_toolchain.sh
```

1. Add the following commands in the file and then exit and save nano:
```
brew update
brew uninstall --ignore-dependencies libimobiledevice
brew uninstall --ignore-dependencies usbmuxd
brew install --HEAD usbmuxd
brew unlink usbmuxd
brew link usbmuxd
brew install --HEAD libimobiledevice
brew install ideviceinstaller
```

1. Run this script with the following command:
```
sh update_ios_toolchain.sh
```

When the script finishes, run flutter doctor one more time. Everything for the iOS side should now be green.

# Configuring the Android SDK setup

Just like with Xcode, Android Studio and the Android SDK come hand in hand, which should make this process fairly easy. But also like iOS, Android Studio is just the starting point. There are a bunch of tiny tools that you'll need to get everything up and running. 

# Installing Android Studio

Follow these steps to install Android Studio:

1. You can download Android Studio at https://developer.android.com/studio. The website will autodetect your operating system and only show the appropriate download link:

![Figure2.8-Android Studio Download ](/flutter_cookbook_img/figure2.8-android_studio_download.webp)

1. After Android Studio is installed, you'll need to download at least one Android SDK. From the Android Studio menu, select Preferences and then type android into the search field:

![Figure2.9-Android SDK Setting ](/flutter_cookbook_img/figure2.9-android_sdk_setting.png)

	While it may be tempting to grab the most recent version of the Android SDK, you might want to choose the second most recent version, because the Flutter SDK is sometimes a bit behind Android. In most cases, it shouldn't matter, but Android is notorious for breaking compatibility, so be aware of this.

	If you ever need to change your version of the Android SDK, you can always uninstall and reinstall it from this screen.

1. You will also need to download the latest build tools, emulator, SDK platform tools, SDK tools, the Hardware Accelerated Execution Manager (HAXM) installer, and the support library.  

1. Select the SDK Tools tab and make sure the required components are checked. When you click the Apply or OK buttons, the tools will begin downloading:

![Figure2.10-Select SDK Tools ](/flutter_cookbook_img/figure2.10-select_sdk_tools.png)

	After everything finishes installing, run flutter doctor to check that everything is working as expected.

# Creating an Android emulator

In order to run your app, you are going to need some kind of device to run it on. When it comes to Android, nothing beats the real thing. If you have access to a real Android device, it is recommended that you try to use that device for development as much as possible. 

However, there are advantages to using an Android emulator (and an iOS simulator). It is often simpler to have a virtual device next to your code rather than having to carry around real devices with the required cables.

Follow these steps to set up your first emulator:

1. Select the Android Virtual Device Manager (AVD Manager) from the toolbar in Android Studio:

![Figure2.11-Select AVD Manager ](/flutter_cookbook_img/figure2.11-select_avd_manager.png)

1. The first time you open the AVD Manager, you'll get a splash screen. Select the Create Virtual Device... button in the middle to start building your virtual device:

![Figure2.12-Select the Create Virtual Device ](/flutter_cookbook_img/figure2.12-select_the_create_virtual_device.png)

1. The next text screen allows you to configure which Android hardware you want to emulate. I recommend using a Pixel device:

![Figure2.13-Select Hardware ](/flutter_cookbook_img/figure2.13-select_hardware.png)

1. In the next screen, you will have to pull down an Android runtime. For the most part, the most recent image will be sufficient. Each one of these images is several gigabytes (GB) in size, so only download what you need:

![Figure2.14-Select System Image ](/flutter_cookbook_img/figure2.14-select_system_image.png)

1. Click Next to create your emulator. You can launch the emulator if you want, but this is not necessary.
1. Once again, run flutter doctor to check your environment. 
1. One final thing that you may have to do is accept all the Android license agreements. You can do this quickly from the terminal line with this command: 
```
flutter doctor –-android-licenses
```

Keep typing y when prompted to accept all the licenses (nobody really reads them, right?). Run flutter doctor one more time just for good measure. The Android SDK should now be fully configured.

Congratulations! The Flutter SDK should now be fully set up for both iOS and Android. In the next recipes in this chapter, we are going to explore some optional choices to customize your environment to fit your needs.

# Which IDE/editor should you choose?

A developer's IDE is a very personal choice. In the olden days, developers would wage proverbial wars over the choice between Emacs or Vim. Today, we are apparently more cool-headed (at least some of us). Ultimately, the choice is dependent on which tool you are most productive in. If you find yourself fighting with the tool rather than just writing code, then it might not be the right choice. As with most things, it's more important to make choices based on what best fits your personal and unique style, rather than follow any prescribed doctrine.

Flutter provides official plugins for three popular IDEs:

- Android Studio
- Visual Studio Code (VS Code)
- IntelliJ IDEA

Let's compare and configure all three and find out which one might be right for you.

# Android Studio

Android Studio is a mature and stable IDE. Since 2014, Android Studio has been promoted as the default tool for developing Android applications. Before that, you would have had to use a variety of plugins for legacy tools such as Eclipse. The biggest argument in favor of using Android Studio is that you already have it installed. In order to get the Android SDK, you have to download Android Studio.

To add the Flutter plugin, select the Android Studio menu, then select Preferences. Click on the Plugins tab to open the plugins marketplace. Search for Flutter and install the plugin. You will then be prompted to restart Android Studio:

![Figure2.15-Add the Flutter Plugin ](/flutter_cookbook_img/figure2.15-add_the_flutter_plugin.png)

Android Studio is a very powerful tool. At the same time, the program can seem intimidating at first, with all the panels, windows, and too many options to enumerate. You will need to spend a few weeks with the program before it starts to feel natural and intuitive. 

With all this power comes consequence: Android Studio is a very demanding application. On a laptop, the IDE can drain your battery very quickly, so be prepared to keep your power cable nearby. You should also make sure you have a relatively powerful computer; otherwise, you might spend more time waiting than writing code. 

# VS Code

VS Code is a lightweight, highly extensible tool from Microsoft that can be configured for almost any programming language, including Flutter.    

You can download VS Code from https://code.visualstudio.com.

After you've installed the application, click on the fifth button in the left sidebar to open the Extensions Marketplace. Search for flutter and then install the extension:

![Figure2.16-open the Extensions Marketplace ](/flutter_cookbook_img/figure2.16-open_the_extensions_marketplace.png)

VS Code is much kinder on your hardware than Android Studio and has a wide array of community-written extensions. You will also notice that the UI is simpler than Android Studio, and your screen is not covered with panels and menus. This means that most of the features that you would see out in the open in Android Studio are accessible through keyboard shortcuts in VS Code.

Unlike Android Studio, most of the Flutter tools in VS Code are accessible through the Command Palette.

Type Ctrl + Shift + P on Windows or Shift + Command + P on a Mac to open the Command Palette and type >Flutter to see the available options. You can also access the Command Palette through the View menu:

![Figure2.17-open the Command Palette ](/flutter_cookbook_img/figure2.17-open_the_command_palette.png)

If you want a lightweight but complete environment that you can customize to your needs, then VS Code is the right tool for you. 

# IntelliJ IDEA

IntelliJ IDEA is another extremely powerful and flexible IDE. You can download the tool from this website: https://www.jetbrains.com/idea/.

If you look carefully, you'll probably notice that IntelliJ iDEA looks very similar to Android Studio, and that is no coincidence. Android Studio is really just a modified version of IntelliJ IDEA. This also means that all the Flutter tools we installed for Android Studio are the exact same tools that are available for IntelliJ IDEA.

So, why would you ever want to use IntelliJ IDEA if you already have Android Studio? Android Studio has removed many of the features in IntelliJ IDEA that aren't related to Android development. This means that if you are interested in web or server development, you are going to have to use IntelliJ IDEA to get the same experience. With Flutter now supporting the web as one of its targets, this might just be enough of a reason to reach for IntelliJ IDEA over Android Studio.

# Picking the right channel

One final item we need to cover before diving into building apps is the concept of channels. Flutter segments its development streams into channels, which is really just a fancy name for Git branches. Each channel represents a different level of stability for the Flutter framework. Flutter developers will release the latest features to the master channel first. As these features stabilize, they will first get promoted to the dev channel, then to beta, and finally to the stable channel.

When learning Flutter, you will probably want to stick to the stable channel. This will make sure that your code should mostly run without any issues.

If you were interested in cutting-edge features that may not be completely finished, you'd probably be more interested in the master, dev, or beta channels.

In your terminal window, type in the following command:
```
flutter channel
```

You'll probably see output that looks like this:

![Figure2.18-flutter channel Output ](/flutter_cookbook_img/figure2.18-flutter_channel_output.png)

When you clone the Flutter repository, it defaults to the master channel, which is normally fine, but for training purposes, let's stick to something more reliable.

Type in these commands:
```
flutter channel stable
flutter upgrade
```

This will switch the Flutter SDK to the stable channel and then make sure that we are running the most recent version.

> You may have noticed references to Git when switching channels. This is because, under the hood, Flutter channels are just fancy names for Git branches. If you were so inclined, you could switch channels using the Git command line, but you might also desynchronize your Flutter tool. Make sure to always run flutter upgrade after switching channels/branches.
{.is-info}

# How to create a Flutter app

There are two main ways to create a Flutter app: either via the command line or in your preferred IDE. We're going to start by using the command line to get a clear understanding of what is going on when you create a new app. For subsequent apps, it's perfectly fine to use your IDE, but just be aware that all it is doing is calling the command line under the hood.

Before you begin, it's helpful to have an organized place on your computer to save your projects. This could be anywhere you like, as long as it's consistent.

So, before creating your apps, make sure you have created a directory where your projects will be saved. 

# How to do it...

Flutter provides a tool called flutter create that will be used to generate projects. There are a whole bunch of flags that we can use to configure the app, but for this recipe, we're going to stick to the basics:

> If you are curious about what's available for any Flutter command-line tool, simply type flutter <command> --help. In this case, it would be flutter create --help. This will print a list of all the available options and examples on how to use them.
{.is-info}

1. Let's type this command to generate our first project:
```
flutter create hello_flutter
```

	This command assumes you have an internet connection since it will automatically reach out to the public website to download the project's dependencies.

	If you don't currently have an internet connection, type the following instead:
```
flutter create --offline hello_flutter
```

>You will eventually need an internet connection to synchronize your packages, so it is recommended to check your network connection before creating a new Flutter project.
{.is-info}

1. Now that a project has been created, let's run it and take a look. You'll need to either connect a device to your computer or spin up an emulator. Type this command to see the emulators currently available on your computer:
```
flutter emulators
```

1. You should see a list of available emulators. You will find at least one emulator if you followed the instructions in the previous recipe. Now, type the commands outlined next to run your app.

On Windows/Linux:
```
flutter emulators --launch [your device name, like: Nexus_5X_API_28]
cd hello_flutter
flutter run
```

	On a Mac:
```
flutter emulators --launch apple_ios_simulator
cd hello_flutter
flutter run
```

1. For physical devices, in order to see all the connected devices, run the following command:
```
flutter devices
```

1. To run your app on one of the available devices, type the following command:
```
flutter run -d [your_device_name]
```

1. After your app has finished building, you should see a demo flutter project running in your emulator:

![Figure2.19-Flutter Demo Home Page ](/flutter_cookbook_img/figure2.19-flutter_demo_home_page.png)

1. Go ahead and play around with it! When you are done, type q in the terminal to close your app.

# How to choose a platform language for your app

Both iOS and Android are currently in the middle of a revolution of sorts. When both platforms started over 10 years ago, they used the Objective-C programming language for iOS, and Java for Android. These are great languages, but sometimes can be a little long and complex to work with.

To solve this, Apple has introduced Swift for iOS, and Google has adopted Kotlin for Android. To select these newer languages when creating an app, enter this command into your terminal:
```
flutter create \
  --ios-language swift \
  --android-language kotlin \
  hello_modern_languages
```

Flutter will now create platform shells that use Swift and Kotlin. If you don't specify anything, Objective-C and Java will be chosen. You are also never locked into this decision. If later down the road you want to add some Kotlin or Swift code, there is nothing stopping you from doing so.

It's important to keep in mind that the majority of your time will be spent writing Dart code. Whether you choose Objective-C or Kotlin, this won't change much. 

# Where do you place your code?

The files that Flutter generates when you build a project should look something like this:

![Figure2.20-files that Flutter generates ](/flutter_cookbook_img/figure2.20-files_that_flutter_generates.png)

The main folders in your projects are listed here:

- android
- build
- ios
- lib
- test

The android and ios folders contain the platform shell projects that host our Flutter code. You can open the Runner.xcworkspace file in Xcode or the android folder in Android Studio, and they should run just like normal native apps. Any platform-specific code or configurations should be placed in these folders.

The build folder calls all the artifacts that are generated when you compile your app. The contents of this folder should be treated as temporary files since they constantly change every time you run a build.  You should even add this folder to your gitignore file so that it won't bloat your repository.

The lib folder is the heart and soul of your Flutter app. This is where you will put all your Dart code. When a project is created for the first time, there is only one file in this directory: main.dart. Since this is the main folder for the project, you should keep it organized. We'll be creating plenty of subfolders and recommending a few different architectural styles throughout this book.

The next file, pubspec.yaml, holds the configuration for your app. This configuration file uses a markup language called YAML Ain't Markup Language (YAML), which you can read more about at https://yaml.org. In the pubspec.yaml file, you'll declare your app's name, version number, dependencies, and assets. pubspec.lock is a file that gets generated based on the results of your pubspec.yaml file. It can be added to your Git repository, but it shouldn't be edited.

Finally, the last folder is test. Here, you can put your unit and widget tests, which are also just Dart code. As your app expands, automated testing will become an increasingly important technique to ensure the stability of your project. Unit testing is an advanced topic and outside the scope of this book, but you can find more information on testing in Flutter here: https://flutter.dev/docs/testing. 

# Hot reload – refresh your app without recompiling

Probably one of the most important features in Flutter is stateful hot reload. Flutter has the ability to inject new code into your app while it's running, without losing your position in the app. The time it takes to update code and see the results in an app programmed in a platform language could take several minutes. In Flutter, this edit/update cycle is down to seconds. This feature alone gives Flutter developers a competitive edge.

The best way to use Hot Reload and its cousin, Hot Restart, is through your IDE. You can configure your Flutter plugin to execute a hot reload every time you save your code, causing the whole feature to become almost invisible.

In Android Studio/Intellij IDEA, open the Preferences window and type hot into the search field.  This should quickly jump you to the correct setting:

![Figure2.21-Perform hot reload on save ](/flutter_cookbook_img/figure2.21-perform_hot_reload_on_save.png)

Verify that the Perform hot reload on save setting is checked. While you are there, double-check that Format code on save and Organize imports on save are also checked.

In VS Code, this setting is enabled by default. If this setting ever disappears, you can check it by opening up VS Code's Command Palette with Shift + Command + P and then typing >Open Keyboard Shortcuts. You can filter to Flutter-specific shortcuts by typing flutter in the search field:

![Figure2.22-VSCode Command Palette ](/flutter_cookbook_img/figure2.22-vscode_command_palette.png)

Let's see this in action:

1. In Android Studio, open the Flutter project you created earlier by selecting File > Open. Then, select the hello_flutter folder.
1. After the project loads, you should see a toolbar in the top-right corner of the screen with a green Play button. Press that button to run your project:

![Figure2.23-Toolbar with a green Play button ](/flutter_cookbook_img/figure2.23-toolbar_with_a_green_play_button.png)

1. When the build finishes, you should see the app running in the emulator/simulator. For the best effect, adjust the windows on your computer so you can see both, side by side:

![Figure2.24-app running in the emulator ](/flutter_cookbook_img/figure2.24-app_running_in_the_emulator.png)

1. Update the primary swatch to green, as shown in the following code snippet, and hit Save:
```
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

5. When you save the file, Flutter will repaint the screen:

![Figure2.25-repaint the screen ](/flutter_cookbook_img/figure2.25-repaint_the_screen.webp)

In VS Code, the pattern is very similar:

1. Click on the triangle on the left of the screen, then on the Run and Debug button:

![Figure2.26-on the Run and Debug button ](/flutter_cookbook_img/figure2.26-on_the_run_and_debug_button.webp)

1. Update the primary swatch to green, as shown in the following code snippet, and hit the Save button: 
```
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
```

1. Only if your app does not update, click on the Hot reload button from the debug tools or press F5. This will update the color of your app to green. The Hot reload button is denoted by a lightning bolt:

![Figure2.27-HOT reload button ](/flutter_cookbook_img/figure2.27-hot_reload_button.webp)

It may seem simple now, but this small feature will save you hours of development time in the future!

# Summary

By now, you should have a working Flutter environment set up. It is recommended that from time to time you rerun Flutter Doctor to check the status of your environment. The doctor will also let you know when a new version of Flutter is available, which—depending on your channel—happens every few weeks or months. Flutter is still a young framework that is growing fast, so you should always keep your environment up to date.

The same can be said for your iOS and Android SDKs. Mobile development is in a constant state of growth and change. Things sometimes break when they change. With the techniques we covered in this chapter and Flutter Doctor at your side, there should be no challenge you cannot overcome.

The Flutter team is also very receptive to helping you with any technical issues you might encounter. If you run into an issue that hasn't been documented yet, you can always reach out to the Flutter team directly on GitHub at https://github.com/flutter/flutter/issues.

Learning the command line will become an invaluable skill. This can range from setting up and configuring your environment to writing build scripts, which we will do later in this book when we automate building and publishing the apps to the stores.

Packt Publishing offers several books and courses on command-line tools. Make sure to check them out at https://www.packtpub.com/application-development/command-line-fundamentals.

In the next chapter, we will go through recipes to understand the Dart programming language.
