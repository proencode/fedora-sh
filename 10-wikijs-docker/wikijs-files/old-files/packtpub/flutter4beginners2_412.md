원본 제목: Chapter 12: Releasing Your App to the World
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/412
Title:
412 Releasing Your App to the World
Short Description:
Flutter for Beginners Second Edition 전 세계에 앱 출시

![Figure 12.6 - Diving into further details on Google Analytics ](/flutter4beginners2_img/figure_12.6_-_diving_into_further_details_on_google_analytics.jpg)
- cut line


# Chapter 12: Releasing Your App to the World
Flutter for Beginners Second Edition

You've written the code, run some tests, debugged some issues, and you've reached a point where your app is ready for the big time! Ultimately, you want to release your app to the world – that's why you embarked on your Flutter journey in the first place.

This chapter explores how you will achieve that within the Apple App Store, Google Play Store, and the web. Each route to market brings its own challenges, so this chapter will act as a guide by pointing out the key steps in your release process and identifying any pain points you may need to overcome.

In Chapter 9, Popular Third-Party Plugins, we touched on how you can track the usage and issues users are seeing within your app. In this chapter, you will build on that knowledge with a deeper look at the Firebase tools for usage analysis and crash reporting.

The following topics will be covered in this chapter:

- Preparing your app for deployment
- Releasing your app on Android
- Releasing your app on iOS
- Releasing your app on the web
- Tracking app usage and crashes

# Technical requirements

You will need your development environment again for this chapter as we will add a plugin to the Hello World project. Look back at Chapter 1, An Introduction to Flutter, if you need to set up your Integrated Development Environment (IDE) or refresh your knowledge of the development environment requirements.

Preparing your app for deployment

At this point, you may be thinking that you've been successfully running your app on devices, so the job is done! From a Flutter point of view, you are virtually ready for production – but there is one piece we need to revisit as a refresher.

Let's remind ourselves of a couple of the Flutter aims. One key aim is to ensure that app development is optimized for developers as far as possible to ensure the following:

- Reduce the feedback loop so that developers can see how their changes have changed the app without a lengthy compile time. Hot reload is an example of this.
- Have great debugging tools allowing the developer to really understand what is going on within the app. The widget tree in DevTools is an example of this, allowing you to manipulate the widget tree in real-time and see exactly how it aligns with your code.

An app framework that can allow these features is likely to have very slow running apps because the code must be compiled just-in-time (JIT) to allow for code changes, and must be sharing lots of information with the outside world to allow the debugging and manipulation of widgets to take place.

On the flip side, Flutter has a key aim to be incredibly performant, rivaling the speed and responsiveness of native apps. You may remember from Chapter 2, An Introduction to Dart, that Dart has a killer feature that allows these two contradictory aims to make sense, and that is because Dart has two different ways in which it builds code.

When preparing an app for release, things such as on-the-fly compiling provided by Dart JIT do not make sense – instead, the best thing is to have a smaller, optimized, and performant app provided by the Dart ahead-of-time (AOT) compiler. In release mode, debugging information is stripped out from the app and the compilation is realized with performance in mind. Remember, in release mode, like in profile mode, the application can only be run on physical devices (for the same reasons too).

Interestingly, it is possible to run the app in release mode. We just need to add the --release flag to the flutter run command and have a physical device connected. Although we can do so, we typically do not use the flutter run command with the --release flag. Instead, we use this flag with the flutter build command to have a built app file in the target Android/iOS/web formats for distribution.

However, Flutter has optimized this step for each platform you are releasing to, so we will take a look through how to create a release build for the three platforms (iOS, Android, and web) in detail later in the chapter.

It's worth noting that it wasn't until this point that we had to start getting platform-specific.Flutter has done an incredible job of ensuring that 99% of what you work on is platform-agnostic, and even during the next step, there has been lots of work to minimize the amount of platform-specific work needed.

## Preparing the stores

Before you can release your app you may have to do a little bit of admin to ensure you are able to use each of the platforms.

The first step is to ensure you are a registered developer on the mobile app stores, as releasing an app on the Google Play Store and Apple App Store requires valid publisher accounts. Refer to the documentation of both platforms to learn how to publish to their stores after creating a release version of your app.

It's worth noting at this point that there are other Android stores available, but only the Play Store has the Google client services that your app may depend on (such as Google Maps). Also, many of the plugins, such as in-app purchases, do not support other stores (such as the Amazon Appstore). Therefore, this guide focuses on the Google Play Store as most releases will follow that route.

### Registering as a developer

To register with the Play Store as a developer, and therefore be able to upload your app, Google requests a one-off $25 registration fee. You can register at the following link: https://play.google.com/apps/publish/signup.

Similarly, the Apple App Store requests a $99 membership fee per year, which you also need to pay before you can upload an app. You can find details and register at the following link: https://developer.apple.com/programs/enroll/.

There are generally no other direct costs associated with releasing your app on the two stores. Hosting your app in the stores is free because the stores make their money from sales fees.

### A business model

It is worth highlighting at this point that there are sales fees that both platforms impose. If you are building a business plan around the sales of your app, then it is important that you know up-front the kind of sales fees you will encounter on the two mobile platforms. These tend to fall into three areas:

- App purchase: If you require a one-off charge from the users of your app for them to either use the app or continue using it after a free trial period, then both stores will charge you a fee of 30% on the sale. So, if you sell your app for $1 on the store and make a sale, Apple or Google will take 30¢ of that sale as a sales fee, leaving you with 70¢.
- Subscriptions: Some apps follow a subscription model to take regular payments from users to use their app. This is generally for apps that constantly add new content (for example, a wellness app that regularly adds new meditation videos) or have an ongoing service that users can access (for example, a workout app with regular live workouts). Again, the stores will take 30% of a new subscription for the first year, and then 15% if you keep that customer for more than 12 months.
- In-app purchases: An in-app purchase is a sale made within the app that is designed around unlocking new content or new parts of the app. All in-app purchases are charged at 30%. You may think that you would just push the user to another purchase channel (for example, link to a website to make the in-app purchase), however, both app stores are very strict and will not allow alternative purchase routes to be advertised within the app. Any attempt to do so will lead to rejection at the app review stage.

There are some interesting changes developing in this space, as some commentators are suggesting monopolistic practices may be at play. Apple has already dropped its 30% sales fee to 15% for companies making less than $1 million revenue per year, and other changes may be likely in the future.

As a cautionary note, there are very strict guidelines around what your app can contain, especially on the app stores, and the documentation is long and difficult to read. The best advice is to try and look at the documentation as much as possible when your business model relies on a certain fundamental feature, but to also try and release prototypes as soon as possible so that you can go through the review process and identify issues early.

A cautionary tale

A feature of one of our apps is to allow parents to donate to a fundraising cause that a school has set up. We spent lots of time developing the feature by integrating a payment provider and making an intuitive and gamified flow for the parents. Proud of our work, we submitted it to the two stores for review and were mortified when it was rejected by Apple due to a hidden-away requirement that only apps from charities can allow fundraising within their apps. If we had made a quick prototype we would have encountered this issue in an early review, but we didn't even know it could be a reason for rejection, so didn't follow this advice!

## Preparing for web

Releasing your app to the web has quite different preparation requirements. There is no ubiquitous store that all web users will visit first, there is no overarching company that you register with, and there are no strict payment models or development guidelines to follow. Therefore, the guidance here will have to be more general, but some of the key things to think about are as follows:

- Hosting: Your app will need to live somewhere on the web, and generally this will require getting a third-party company to host your code in a way that other web users can access. One easy option is to use Firebase hosting, especially if you are using other Firebase services.
- Domain: For users to be able to find your app, you will need a web address, or domain, that users type into their web browser to access your site. There are plenty of companies willing to sell you a domain. Once you have one, link it up to your hosting supplier using DNS magic.
- Payments: In the mobile stores you have the simplicity of taking payments using the store services, such as in-app payments and subscriptions. These services are not so easily available on the web, but on the flip side, when you do find a payment solution, you are unlikely to incur such high sales fees. Options here include the large payment providers of Stripe and Square, which have plugins for Flutter.

So, let's assume you are registered for the stores (or have a web hosting solution ready), and you have a viable business plan to make some money – it's now time to release your app.

# Releasing your app on Android

In Android, appbundle is the format expected to be published in the Google Play Store. When we run the flutter build appbundle command, we generate the file ready for deployment.

You may have previously seen the Android APK (short for Android application package) option instead of the appbundle. Releasing your app as an APK has been deprecated by Google as an option on the Play Store, and will be fully withdrawn soon. Under the covers, an appbundle effectively generates APKs for devices but hides that complexity away.

Before we generate the file for deployment and publishing in any store, we need to make sure all of the information is correct (that is, the name and package), all needed assets are provided, and all platform-specific adjustments are made.

Let's start by preparing our HelloWorld app for release on Google Play so that we can review all of the final steps of publishing a Flutter app.

## AndroidManifest and build.gradle

For each platform, Flutter has a folder that holds all of the files needed to configure the build processes for that platform. You will see ios, android, and web folders in your project. Generally, you should ignore these folders unless you need to make configuration changes required for plugins.

In Android, the meta-information about the app is provided in the android folder in both the app/src/main/AndroidManifest.xml and app/build.gradle files, so we may need to review and make some adjustments in these ready for the app release build.

### Permissions

One important step we need to do is review the permissions requested in the app/src/main/AndroidManifest.xml file. Asking only for the permissions that your app will actually need is a good and recommended practice, as your app may be analyzed and your publication may be revoked if you request more than the required permissions.

In our HelloWorld app, our initial app/src/main/AndroidManifest.xml file didn't have any permissions required. If you have added plugins to it then you may have needed to add permissions. Here is an example file with some permissions requested:

```
<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.example.hello_world">
  <uses-permission
        android:name="android.permission.INTERNET"/>
  <uses-permission
        android:name="android.permission.READ_CONTACTS" />
  <uses-permission
        android:name="android.permission.WRITE_CONTACTS"/>
  <uses-permission
        android:name="android.permission.CAMERA" />
  <uses-feature
        android:name="android.hardware.camera"
        android:required="false" />
  ...
</manifest>
```

The permissions your app is requesting are listed within the uses-permission tags. The names of the permissions are defined by Android, and plugins will guide you to add the correct permissions as required.

Besides permissions, there is also the uses-feature tag, which can limit installation on devices with a specific feature available. The use of android:required here is critical if the camera is not required, allowing devices that do not have a camera to still install and use the app. When you go through the publishing process on the Play Store, there are warnings if one of your permissions is likely to restrict the devices the app can be installed on. You should review this because a slight change to your AndroidManifest.xml may make a huge change to your available market.

Some of the permissions are normal permissions, which means they are granted on the installation of the app, and some permissions are requested at runtime, so the user needs to choose to grant the permission to your app. You may have seen other apps requesting permission to view your photo album or access your camera. Your app will need to cope with users choosing not to enable that permission.

### Meta tags

Another very important step is to review the meta tags added to the app for working with services such as AdMob or Google Maps. You may have set up the app to use test configurations, so now is the time to review your settings and make sure they are set up for production use. Here is an example of the setting for AdMob:

```
<manifest xmlns:android="http://schemas.android.com/apk/res/android" package="com.example.handson">
  ...
  <application>
    ...
    <meta-data
      android:name="com.google.android.gms.ads.APP_ID" 
      android:value="ADMOB-KEY"/>
  </application>
</manifest>
```

Again, the plugin documentation will guide you to add the correct metadata tag within the AndroidManifest.xml file.

### Application icon and name

Until now, when we launch the application in our tests we've the app icon as a Flutter logo. For release, you need to create a unique icon to make sure your users can distinguish your app among the millions of other apps available. Also, you need to come up with an awesome name for your app. Now is the time to do both.

For setting your icon, there are two options available to you – an easy automated way, and a harder manual way. For completeness, let's first look at the harder manual way while also setting the app name.

Manually setting the icon and name
The icon and name are defined in the AndroidManifest.xml application tag. By default, the icon refers to the default Flutter icon, as you can see:

```
<manifest ...>
    <application
        android:label="hello_world"
        android:icon="@mipmap/ic_launcher">
     ...
    </application>
</manifest>
```

So, we need to make two changes:

- Change the label value to the final name of our app – that is, the name by which our users will recognize our app.
- Update the icon that is pointed to by the icon value.

In Android, image resources such as the icon are located in the android/app/src/main/res/ directory. Under this directory, there are many folders with variants of a resource, tailored for specific regions, screen sizes, system versions, and so on.

We need to replace the ic_launcher.png file in each of the mipmap-xxxdpi folders to make a full replacement of the app icon.

Check the Material Design guidelines on icons to make sure you create an awesome icon for your app: https://material.io/design/iconography/.

### Setting the icon using a plugin

You have a lovely icon for your app and you don't want to spend ages resizing it for all the different device types and the two different platforms. This is where the awesome flutter_launcher_icons plugin comes in handy.

To use the plugin, first, modify your pubspec.yaml file to add the plugin to the dev_dependencies section:

```
dev_dependencies:
  flutter_launcher_icons: "^0.8.0"
```

And then further down add details of the icon you want to use in the app:

```
flutter_icons:
  android: true
  ios: true
  image_path: "assets/icon/icon.png"
```

The true value beside the android and ios properties specifies that the plugin can override the existing launcher icon for those platforms.

The image_path tells the plugin where the icon image file is. Note that this is placed in your assets folder within your app.

Make sure you get this dependency downloaded and ready to go by running the following command:

```
flutter pub get
```

Then run the plugin itself to generate all the icons:

```
flutter pub run flutter_launcher_icons:main
```

Magically, all of your icons are generated in the right sizes for each platform.

After changing the name and replacing the icon, we can review the app/build.gradle file to make the final adjustments for the deployment.

### Application ID and versions

The applicationID value is what makes an app unique in Play Store and the Android system. A good practice is to use the organization domain as the package and have the app name following it:

```
com.companyname.appname
```

In our HelloWorld app we are using com.example.hello_world as the application ID. Make sure to review your application ID because it cannot be changed after you upload the app to the store.

You can find this code in the app/build.gradle file, inside the defaultConfig section:

```
    defaultConfig {
        applicationId "com.example.hello_world"
        minSdkVersion 20
        targetSdkVersion 30
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
```

As you can see, we can change more settings than just applicationId.

The minSdkVersion setting denotes the minimum version of the Android API level that our app will be supported on. In Flutter, the minSdkVersion setting is typically changed in two cases:

- If the Flutter framework requirements change
- If we use a plugin that requires a higher minimum Software Development Kit (SDK) version

The targetSdkVersion setting denotes the Android API level that our app is designed to run on. This is used to manage what manifest elements and behaviors are available. Generally, this can simply be set to the latest Android API level.

The versionCode and versionName settings are automatically drawn from our pubspec.yaml file. So, suppose our pubspec.yaml file contains:

```
version: 1.0.0+1
```

This value will be split into a versionCode of 1 and a versionName of 1.0.0. The beauty of deriving this from the pubspec.yaml file is that it ensures our versioning is consistent across platforms.

### Signing the app

The signing step is the final but most important step before releasing an app to the public, even if you do not want to publish it in the Google Play Store. It is the signing that confirms the ownership of the application – in short, whoever has the signature owns the app. You need this so you can publish updates to your app, for example.

Start by taking a look at the buildTypes section of the app/build.gradle file:

```
    buildTypes {
        release {
            signingConfig signingConfigs.debug
        }
    }
```

It contains the signingConfig property, pointing to a default signing configuration. We need to change this to our own signing configuration for the reasons mentioned before. We do this by performing the steps below.

### 1. Generate a keystore file

We generate our developer keystore file (you can use the same keystore for multiple apps). This is done with the following command:

```
keytool -genkey -v -keystore DESTINATION_FILEPATH -keyalg RSA - keysize 2048 -validity 10000 -alias key
```

Follow the prompts and this will generate a keystore in the DESTINATION_FILEPATH path. You should reference this file in the app/build.gradle file now.

### 2. Create a key.properties file

Create a key.properties file in the android folder with the following content:

```
storePassword=<password used for generating key>
keyPassword=<password used for generating key>
keyAlias=key
storeFile=<key store file path>
```

### 3. Load the key.properties file

In app/build.gradle, we load this new key.properties file and create a new signingConfig class for it. Just before the android { line, add the configuration:

```
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new 
    FileInputStream(keystorePropertiesFile))
}
android{
  ...
```

This configuration defines a new keystoreProperties variable of type Properties, then defines a variable of type File that points to our new key.properties file, and finally, if the file exists, we load the contents of the file into our keystoreProperties variable.

### 4. Use keystoreProperties

We now need to use keystoreProperties, which we read in from the key.properties file, to create a new signing configuration named release that we can refer to later in the build process:

```
   signingConfigs {
     release {
       keyAlias keystoreProperties['keyAlias']
       keyPassword keystoreProperties['keyPassword']
       storeFile keystoreProperties['storeFile'] ? 
       file(keystoreProperties['storeFile']) : null
       storePassword keystoreProperties['storePassword']
     }
   }
```

This configuration simply links the build variables of keyAlias, keyPassword, storeFile, and storePassword to the properties we read in from key.properties.

### 5. Use the new signing configuration

Finally, replace the signingConfig property in the release option in the previous buildTypes section with the new one:

```
  buildTypes {
    release {
      signingConfig signingConfigs.release
    }
  }
```

Now, when we build the release appbundle, the app will be signed with our own key.

## Build and upload your appbundle

With all the configuration ready, it's time to build the appbundle. You do this by running the following command:

```
flutter build appbundle
```

This will generate an appbundle file at the following location:

```
<project location>/build/app/outputs/bundle/release/app.aab
```

In the Google Play Console, you will be able to create a new release and upload your appbundle as part of that.

There are several types of release available in the Google Play Console:

- Internal testing: The app is only available to a small subset of specified testers. New versions are made available to testers within a few minutes.
- Closed testing: Similar to internal testing, but with a slightly larger audience, and there may be a review delay for the release.
- Open testing: A wider audience again, and anyone can join an open test and then submit private feedback.
- Production: Your release to the world (or specific geographies if you so choose). This may have a lengthy review before being available on the Play Store.

As soon as you upload to the Play Store you should aim to do an internal test so that you can check there are no surprise gotchas before you share the app more widely. For all types of testing or production, testers simply need to go to the Play Store and the correct version of the app will be available for them to install.

You will also need to set up your store presence with images, screenshots, descriptions, links to your privacy and terms-of-service documents, and contact details, among other things like content ratings. It can take a long time to set up the store presence, so don't leave this to the last moment assuming it will only take a few minutes.

And there you have it – you are good to go on Android. Let's now look at the Apple iOS release process.

# Releasing your app on iOS

Releasing on Apple iOS is more complex when compared to Android. Although you can test on your own device when developing, making an app public requires you to have a valid Apple Developer account with the ability to publish on the App Store, as it's the only supported app publishing channel.

Like Android and the configuration we had to make in AndroidManifest.xml, iOS has a similar configuration file that is used by the iOS build tool Xcode.

What is Xcode?

Xcode is an IDE that is only available on macOS and is used for the development of native iOS apps. You can download it from the Apple App Store for free. It is used by Flutter to package your app code ready for release on the App Store.

iOS apps can only be built on a Mac computer, so if you are a Windows or Linux user you will either need to invest in a Mac or get a virtual machine you can use.

## App Store Connect

In Android, we did not need to configure anything in the Play Store Console before we created appbundle ready for publishing. In iOS, the process is different. The upload and publishing are managed inside Xcode, and to upload the app we first create a record on App Store Connect. Then, on Xcode, we build and upload our iOS app using the App Store Connect bundle identifier. To register the app, perform these steps:

### 1. Register the bundle ID

All iOS applications are associated with a bundle ID. This is a unique identifier that is registered with Apple.

To register your app bundle ID, head over to your developer account web page at https://developer.apple.com/account/ios/identifier/bundle:.

1. Select the Identifiers section.
1. Click the + and select App Ids.
1. Select the type as App (not App clip, which is like a very lightweight app).
1. Enter your new bundle ID as an Explicit Bundle ID. This ID can be (and for simplicity should be) the same as the one you set on your applicationId for the Android build – so something like:

```
com.companyname.appname
```

5. To finish setting up your bundle ID, complete the registration, including adding any required capabilities.

### 2. Create your app entry

Next, create an app in the App Store Connect portal at https://appstoreconnect.apple.com:.

1. Open the My Apps section.
1. Click the + to create a new app.
1. Enter your app details, ensuring that the iOS platform is selected, and click Create.
1. Open the App Store tab for your app, and then the App Information option from the side menu.
1. Select the bundle ID we registered in the previous step.

After completing these steps in App Store Connect, let's look at configuring the app in Xcode.

## Xcode

In Xcode, we need to make a few changes to get the app ready for release. We need to change the application icon, public name, and bundle ID. This is very similar to what we did in Android.

So, open Xcode on your Mac (or virtual machine), and you will get a popup asking for the project location. A workspace file has been created in your project, so point Xcode to the location:

```
<project location>/ios/Runner.xcworkspace
```

Note that there is also a file in that folder called Runner.xcodeproj. Do not use that file, as it will not set up Xcode correctly for your project.

Xcode will then pop open and show you your app details:

![Figure 12.1 - The Xcode tool ](/flutter4beginners2_img/figure_12.1_-_the_xcode_tool.jpg)

Ensure you have the Project Navigator view open and the top-level Runner folder is selected.

### Application details and bundle ID

In the General tab of the Runner project, you can edit the application's Display Name, which is the name of your app.

Set the Bundle Identifier to the same value as you specified in the Application ID and versions section earlier in this chapter. Keeping the application ID consistent across platforms will make it much easier to maintain your app in the future, and will reduce the chance of configuration issues as you add new plugins and services to your app.

In Deployment Target, you can set the minimum required iOS version, which is 8.0 by default (the minimum version Flutter supports). As discussed in the Android section, this minimum version will likely be modified based on the plugins that are being used by your app. For example, the flutter_stripe plugin requires a minimum iOS level of 11.

If you do need to change the Deployment Target setting, then you will also need to update the ios/Flutter/AppframeworkInfo.plist file and set the MinimumOSVersion value to match the value you set in Xcode.

Note also the Version and Build values – they are similar to version name and version code in Android respectively. For each upload to the App Store, we need to ensure we have increased the version value in the pubspec.yaml file, otherwise the build will be rejected by App Store Connect.

### App icon

We saw in the Android section how we can use a plugin to generate the app icon. I would strongly recommend following that approach, but for completeness here is the process for manually updating the iOS app icon.

Firstly, it is useful to review the iOS app icon guidelines to ensure your icon adheres to their constraints. One gotcha is that icons with any transparency are rejected, so ensure your icon is fully opaque. The guidelines can be viewed here: https://developer.apple.com/ios/human-interface-guidelines/icons-and-images/app-icon/.

Once you have an icon you are happy with, in Xcode, select Assets.xcassets in the Runner folder and add your icons in all the various sizes and resolutions.

### Signing the app

Like on Android, we need a way to assert the ownership of the application. In this case, Xcode manages it for us, and we do not need to touch any file directly. When we register as an Apple Developer and enroll in the Apple Developer Program, we have all of this ready.

If you move to the Signing & Capabilities tab, you will see that Automatically manage signing is selected. If you decide to have complex functionality, like Apple Pay, then you will probably need to manage signing more closely. But generally, this setting is sufficient.

Ensure that your Team has correctly been set. If you cannot select it from the drop-down menu, then select Add Account… and update the values.

After these settings have been made, we can build an iOS version of the app.

## Build and upload

Much like the Android process, there is a build step and then an upload step. To build the code, run the following command:

```
flutter build ipa
```

This will build an ipa file which, a bit like appbundle, contains the iOS app bundles within it, as well as some other configuration files.

The first step of this build process is where CocoaPods is installed, as discussed in Chapter 8, Plugins – What Are They and How Do I Use Them?, and you may want to review the Common issues section of that chapter if you have any issues at this stage.

When you have successfully built the ipa file, you will need to open Xcode and choose to open it at the following location:

```
build/ios/archive/MyApp.xcarchive
```

This will pop up a window showing all of your uploads of the app. Select Distribute App to start the upload. You will need to review some build settings before the upload commences, but the default selections should be fine.

Once the upload has been completed, there are some automated reviews that Apple runs on its servers to ensure the app is configured correctly. If there are any issues, then you will receive emails from their review system detailing the suggested corrections.

After about 30 minutes, the automated reviews should be complete, and you are free to use your app for testing or put it forward for production review. Testing on iOS is a little different from Android. There is only really one testing stage, but you can choose whether testing has an internal and/or external audience. In the case where you choose an external audience, then a short review is needed before the app is made available.

Testers have to install the TestFlight app to be able to install pre-release versions of your app. This is relatively painless, and in many ways preferable to the Android approach, because it is very easy to switch between test and production versions of an app.

![Figure 12.2 - TestFlight app App Store page ](/flutter4beginners2_img/figure_12.2_-_testflight_app_app_store_page.jpg)

Again, like Android, before the production release, you will also need to set up your store presence with images, screenshots, descriptions, links to your privacy and terms-of-service documents, and contact details, among other things like content ratings. It can take a long time to set up the store presence, so don't leave this until last, assuming it will only take a few minutes.

Once you put an app version forward for production review, you will have to wait a couple of days for your app to be reviewed before it is released. There are some great controls on iOS to manage the release process after review completion. In addition to automatically releasing on review completion, you can choose to manually release or schedule the release at a specific date and time. On Android, the same control is not available, and you are not even alerted when the review and release are completed!

Make sure you install the App Connect app on your phone so that you can get push alerts as your app moves through the review stages. If you notice your app is stuck in the In review state for a long time, there are a few possible reasons for this which I've experienced during our app releases:

- The app is failing to install on the reviewer's device.
- The reviewer is having issues logging into your app, or following your specific guidance if you have supplied some.
- There is something that the reviewer thinks may contravene an app guideline, and has asked for assistance from another reviewer. This one sometimes happens if the review is happening outside of USA working hours and the reviewer wants guidance from a USA team member.

Ultimately, there are many reasons why your app may get stuck in the review state, but getting stuck there suggests something isn't quite right, and it is worth starting to investigate possible issues early so that you can diagnose the problem quickly and restart the review.

I'll be honest with you – releasing on iOS is definitely the hardest platform to release on. The App Store review process is infamously difficult to traverse. However, I've generally found that any review violations are clearly explained and, on the odd occasion we feel the need to appeal a decision, our appeal has been upheld. In contrast, the web release process has literally no review to go through. Let's now look at the web release process.

# Releasing your app on the web

Compared to the configuration headaches of Android and iOS, the web release process can be much simpler. You only need to run the following command:

```
flutter build web
```

This will generate the app and all required assets and place them into the following folder:

```
/build/web
```

The trickiest part is to decide how to host your web app. As mentioned previously, Firebase hosting is a great choice for this. Not only is the setup very easy, but it's also cheap until you start to really scale up.

## Firebase hosting

To set up Firebase hosting, set up a Firebase account (as discussed in Chapter 8, Plugins –What Are They and How Do I Use Them?). Then, on your local machine, install the Firebase CLI (explained at the following link): https://firebase.google.com/docs/cli.

This will give you the ability to run firebase commands from your command line.

Next, run the Firebase initialization command on your project:

```
firebase init
```

This will connect your Flutter project to your Firebase project.

Finally, deploy your app to the hosting by running the following command:

```
firebase deploy
```

And your web app will be uploaded and made available publicly.

However, as discussed in the Android and iOS instructions, it is useful to have a testing option before you go live. In Firebase hosting, there is also a way to run testing in advance of a production release. To do this, run the following command:

```
firebase hosting:channel:deploy <test_name>
```

This will create a temporary deployment channel with an obscure URL that you can share with testers and get feedback. If you use the same test_name value on future deployments when you act on the feedback from testers, then you will have to update the same test version at the same URL, and testers will automatically see your updates.

## PWA support

Flutter web apps include support for the core features of an installable, offline-capable progressive web app (PWA). This is currently a work-in-progress, but quite well advanced, so if this is an area that is important to you then take a look and engage with the Flutter development team, who are keen for feedback.

Now your app is on its way to production, let's see how we can keep track of it out in the wild.

# Tracking app usage and crashes

When your app is in production use, it can be very hard to know how the app is being used and whether your users are encountering issues. Knowing when there are issues with app usage or crashes at the earliest opportunity is especially important when your app is released on mobile stores because the update cycle can take days.

There are two Firebase tools that are great for tracking this information, such as Crashlytics and Google Analytics, and we looked at how to set them up in Chapter 9, Popular Third-Party Plugins. In this chapter, let's take a look at some of the output that is generated and how that can help us as we improve our app.

## Crashlytics

Every time your app has an unexpected crash, or you specifically send a crash report from within your code, Crashlytics will receive that information and display it on the dashboard.

This can be especially useful if you have an asynchronous operation that doesn't directly impact the running of the app but stops some underlying service from functioning within your app. For example, a database listener may fail and Crashlytics would report this. The user of the app may not actually know that the failure has occurred, so wouldn't report it to you, but you can see from the dashboard that the issue has occurred and you are able to start investigating a fix.

![Figure 12.3 - Crashlytics dashboard ](/flutter4beginners2_img/figure_12.3_-_crashlytics_dashboard.jpg)

The Crashlytics dashboard is relatively easy to navigate. It shows the number of issues impacting users, the versions of the app the crash was on, whether the crash was fatal (that is, the app closed and had to be restarted), details about the device the crash was recorded on (such as operating system version and manufacturer/model), and, most usefully, the stack trace when the crash occurred.

When you build your app for release, if you have Crashlytics configured, then the Android mapping file or iOS debug symbol (dSYM) file is uploaded to the Crashlytics server. This means that when a stack trace is created by the app, this can be mapped to your code and specifically the files and line numbers, allowing you to find the failing code quickly and easily.

![Figure 12.4 - Example of a crash report ](/flutter4beginners2_img/figure_12.4_-_example_of_a_crash_report.jpg)

Crashlytics will group issues when they are similar and allow you to manage whether an issue is resolved, and also alert you when a resolved issue reappears.

## Google Analytics

If you want to track how your app is used, there are few tools as well known as Google Analytics. Initially used by many people for tracking traffic through a website, it is now also available for mobile apps.

Google Analytics is especially useful if you are trying to convert users. Perhaps there is a page to unlock features or to make an in-app purchase, and you want to see how many users you are converting.

To do this, within your app you will record events that denote either an action or a navigation by the user. These are reported back to Google Analytics, allowing you to get a view of how users are traversing your app.

![Figure 12.5 - Google Analytics events ](/flutter4beginners2_img/figure_12.5_-_google_analytics_events.jpg)

Additionally, Google Analytics adds useful data such as demographics and user location, allowing you to see what your audience is like.

![Figure 12.6 - Diving into further details on Google Analytics ](/flutter4beginners2_img/figure_12.6_-_diving_into_further_details_on_google_analytics.jpg)

In this example, we've dived into one event type, screen_view, and can see the breakdown of the pages within the app that users are accessing, where those users are located, and demographic data.

# Summary

In this chapter, we explored the steps required to make our app ready for deployment.

Firstly, we looked at some admin to get the app ready for the production build, including registering for a developer account and preparing your hosting provider for the web.

We then looked at releasing an app on the Google Play Store, including configuring the AndroidManifest.xml and build.gradle files, looking at the build process, and exploring the testing options on Google Play.

Next, we did the same for the App Store, including registering our app bundle ID, using Xcode, looking at the build process, and exploring the different test processes.

We then dug into the release process of our app on the web, and finally covered how to use Crashlytics and Google Analytics for tracking app usage and crashes.

And that's all folks. In this book, I have tried to show you the basic but fundamental concepts of this incredible framework. I hope you enjoyed the book, learned something new, and are excited about using Flutter in the future!

# Why subscribe?

- Spend less time learning and more time coding with practical eBooks and Videos from over 4,000 industry professionals
- Improve your learning with Skill Plans built especially for you
- Get a free eBook or video every month
- Fully searchable for easy access to vital information
- Copy and paste, print, and bookmark content

Did you know that Packt offers eBook versions of every book published, with PDF and ePub files available? You can upgrade to the eBook version at packt.com and as a print book customer, you are entitled to a discount on the eBook copy. Get in touch with us at customercare@packtpub.com for more details.

At www.packt.com, you can also read a collection of free technical articles, sign up for a range of free newsletters, and receive exclusive discounts and offers on Packt books and eBooks.

