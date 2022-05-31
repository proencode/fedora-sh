원본 제목: Chapter 9: Popular Third-Party Plugins
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/309
Title:
309 Popular Third-Party Plugins
Short Description:
Flutter for Beginners Second Edition 써드파티 플러그인

![Figure 9.1 - Crashlytics dashboard ](/flutter4beginners2_img/figure_9.1_-_crashlytics_dashboard.jpg)
- cut line


# Chapter 9: Popular Third-Party Plugins
Flutter for Beginners Second Edition

In the previous chapter, we learned about what a plugin is and how it is used, and we experimented with our first plugin.

Flutter has a rich set of Flutter plugins, and sometimes it can be hard to know where to start from; you don't know what you don't know! This chapter will highlight some of the most popular plugins and give an overview of their uses.

We will start this chapter by looking into the Firebase plugins. Firebase is a set of services available on Google Cloud that you can use to create apps with advanced features. This includes authenticating users, storing data, sending push notifications, and analyzing app usage, among many other features.

We will then look at how to use Google Places for map and location information. Many apps have address lookups or show locations on a map, and the Google Places plugins really help here.

Next, we will look at plugins that exercise the capabilities of the device the app is being used on, including the camera and the photo store.

Finally, we will look at plugins that allow you to create more mature and supportable apps, including the app version plugin that surfaces the app version so that users can report their current version when asking for support.

This chapter will cover the following topics:

- Exploring Firebase plugins
- Understanding Google Maps and Google Places
- Exploring mobile device features
- Plugins to help with your app support

By the end of this chapter, you will have a wide knowledge of the plugins available to you, and some good ideas about how you can use those plugins to make your app awesome.

# Technical requirements

You will need your development environment set up for this chapter as we will add a plugin to the Hello World project. Look back at Chapter 1, An Introduction to Flutter, if you need to set up your integrated development environment (IDE) or refresh your knowledge of the development environment requirements.

You can find the source code for this chapter on GitHub at https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/lib/chapter_09.

# Exploring Firebase plugins

In this section, we will look at one of the most common sets of plugins that are used by Flutter app developers and explain how they can be used within your apps. Firebase is a Google product that provides multiple technologies for multiple platforms. If you are a mobile or web developer, you may be familiar with this amazing platform.

Among its offered technologies, the important ones are listed here:

- Realtime Database: A NoSQL (non-relational) database on the cloud. With this, you can store and access data in real time.
- Cloud Firestore: A NoSQL database, with a focus on big and scalable applications that provide advanced query support compared to a real-time database.
- Cloud Functions: Functions triggered by many Firebase products, such as the previous ones, and also by the user (using the software development kit (SDK)). We can develop scripts to react to changes in a database, user authentication, and more.
- Performance Monitoring: Collect and analyze information about the applications from the user's perspective.
- Authentication: Facilitates the development of the authentication layer of an application, improving user experience (UX) and security.
- Firebase Cloud Messaging (FCM): Cloud messaging to exchange messages between applications and the server, available on Android, iOS, and the web.
- AdMob: Displays advertisements to monetize applications.
- Machine Learning Kit (ML Kit): Tools to implant advanced machine learning (ML) resources in any application.

One of the main benefits of using Firebase is that all the services work tightly together. For example, the databases use Firebase Authentication to manage access, the cloud functions are triggered by Firestore or Realtime Database updates, and callable cloud functions use Firebase Authentication to identify users.

Flutter contains a variety of plugins to work with Firebase. We will be using some of them in the next sections to make some updates to the Hello World application. However, your first step is to register for the Firebase services.

## Firebase registration

All of the Firebase services are managed from one dashboard or console, and you will need to set up your Firebase access and then register your app before you can use the services.

Firstly, head over to Firebase to set up your login and project: https://console.firebase.google.com/.

Immutable Firebase project settings

It is worth noting that some Firebase settings are immutable, such as the project Uniform Resource Locator (URL) and Realtime Database hosting location. Therefore, take your time to really understand what the settings will be, or assume in your planning that at some point down the line you may need to create a new project once you know which settings you will need.

Once you have a project created, you will then be able to register apps to the project.

## Connecting the Flutter app to Firebase

It is possible to configure multiple applications from multiple platforms to connect with a Firebase project. On the Firebase project page, we have an option to add apps for iOS, Android, and the web.

Let's go ahead and register the Hello World app for both Android and iOS, in preparation for some of the Firebase service tinkering we will be doing later.

Note that full documentation on Firebase configuration is available here: https://firebase.flutter.dev/docs/overview/

In the following sections, we will look at the Android- and iOS-specific configurations.

### Android

Here, the important setting is the package name that is checked in the Firebase SDK. The signing certificate is also important for authorization; we will cover that shortly.

You can find the package name of your Android app in the android/app/build.gradle file, within the applicationId property.

After completing registration, a google-services.json file is generated that has all the information your app will need to be able to access your project on Firebase. This should be added to your application project in the android/app directory.

There will be additional configuration settings needed. These are changing all the time, so view the preceding documentation link to understand the additional configuration changes you will need to make.

### iOS

For the iOS version, the process looks very similar, starting with the configuration in the Firebase console, where we set the package name, as we did for Android.

After that, we can download the generated GoogleService-Info.plist file (the iOS equivalent of the google-services.json file) and add it to the project's ios/Runner directory. Note that it is very important to do this in Xcode by opening the iOS project on it and dragging the file into Xcode so that it gets registered for inclusion during builds.

Again, there will be additional configuration settings needed. These are changing all the time, so view the preceding documentation link to understand the additional configuration changes you will need to make.

Now you have registered your app and added the configuration to connect to your Firebase project, the addition of Firebase services simply follows the Flutter plugin model we saw in the previous chapter.

## FlutterFire plugins

Note that, given the community-driven and open nature of Flutter, developers who are not directly involved in the creation of a service may choose to develop plugins that connect to a service such as Firebase. This may be because the "official" developers of a service have not yet chosen to engage with Flutter, there are limitations to the current "official" plugins (this can lead to a fork in the code base with new developers improving the existing code), or it may be that the design choices made on the "official" plugins are not to everybody's taste. Regardless, if you use the pub.dev scores, check the last published date, and view any plugin issues, you should be able to decide which plugin is suitable.

For Firebase, the official developers of the service have fully engaged with Flutter, and the plugins are excellent, both in quality, design, and documentation. Given that Flutter and Firebase are both Google products, you would expect that the Flutter and Firebase development teams would work closely together to create a good set of plugins. The plugins all support iOS and Android, and in most cases also support the web. The main plugin that does not support the web is the Realtime Database, and, although this may change, there are no obvious signs that web support will be coming to the Realtime Database. This is something to bear in mind if you plan to make your app available as a website, and you should consider using Firestore (which does have web support) instead.

Before we add any plugins, we need to add the firebase_core plugin, which all the other Firebase plugins depend on. As the name suggests, this plugin does all the core work, such as connecting to your project on Firebase. Here's the code you'll need to add this plugin:

```
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^1.2.0 #Check for the latest version
```

Once you have this, you are free to add the plugins that you need for your app. However, the key next step is to initialize Firebase within your app.

## Firebase initialization

For any of the Firebase plugins to work, you first need to initialize the Firebase instance. This is effectively the work that Firebase Core will do to set up your connection to your Firebase project that you configured on the website.

There is just one step to this process, which aims to trigger the initialization and wait for this to complete.

There are a few ways to achieve this, but probably the easiest way is to modify your main method so that it is asynchronous, and then add a wait for Firebase initialization to complete. The code to do this is illustrated in the following snippet:

```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}
```

As you can see, we have marked the main method as asynchronous using the async keyword and then added a line of code, as follows:

```
await Firebase.initializeApp();
```

The Firebase.initializeApp() method returns Future (that is, it is asynchronous, and you have to wait for the outcome of the method). We don't really care about any value returned, but what we do care about is that it has completed processing. Therefore, we have to use the await keyword to ensure our code execution waits here until the initialization has been completed. If we didn't include the await keyword, then code execution would continue immediately by running our app code. If we reached some Firebase service code before the initialization had been completed, then we could get some pretty nasty errors.

Note that there are more elegant ways to wait for initialization to complete (such as using the init method of a stateless widget), but for ease of understanding, this way seems as good as any other. Check out the online documentation for examples of other options.

Now you have Firebase initialized, let's look at the popular Firebase options available to you.

## Authentication

Firebase Authentication allows you to secure access to your application and other Firebase services through a login/register process. To make this as easy as possible for your users, Firebase Authentication enables the use of multiple authentication options, such as email/password, phone authentication, and federated identity providers (IdPs) such as Google, Apple, Twitter, and Facebook.

The Flutter plugin that is supported by the Firebase team is firebase_auth. You can see the author in pub.dev by viewing the publisher details. In this case, it is the firebase.google.com team.

### Setup

To set up the plugin, you would add the dependency to pubspec.yaml, as follows:

```
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^1.2.0
  firebase_auth: ^1.2.0
```

Voilà—you have authentication set up on your app. OK—it's not quite that easy, but you have managed to pull in the dependency, so next, you need to add code to your app to use the dependency in the correct way. Throughout this chapter, we will show snippets of the key pieces of code to give an idea of how you would use it. Additionally, we will include code samples in our GitHub source code so that you can see the plugins in action.

The first piece of code required is to initialize the FirebaseAuth instance (you'll notice a bit of a pattern forming for Firebase plugins), as follows:

```
FirebaseAuth auth = FirebaseAuth.instance;
```

Next, we need our code to listen on a stream that will let our code know of any changes in the authentication status of our app user.

If you need to refresh your knowledge of streams, refer back to Chapter 5, Widgets –Building Layouts with Flutter, where the concept of streams was first introduced.

Throughout the Firebase plugins and other plugins, you will see the regular use of streams so that the plugins can effectively be called back into your code to tell you that something has changed. They are very similar in concept to a callback method you supply that can be called regularly by the source of the stream.

### authStateChanges stream

The specific stream we want to listen on is the authStateChanges stream, as illustrated in the following code snippet:

```
FirebaseAuth.instance
  .authStateChanges()
  .listen((User user) {
    if (user == null) {
      // User signed-out
    } else {
      // User signed-in
    }
  });
```

In the preceding example, we get the instance (that we have already initialized), ask for the authStateChanges stream, and then specify what should happen when there is an update to the stream by supplying a callback function as an argument to the listen function. Whenever new data is added to the stream, our callback function will be called so that we can take action such as showing the login page (if the user is signed out) or accessing and displaying user-specific data (if the user is signed in).

### Sign-in

Finally, we need to give the user an option to sign in to our app. To do this, you would either show email/password input fields or add a plugin for a federated IdP and receive their credentials that way. Ultimately, you will need to pass their credentials to Firebase, and in the email/password option, it would look something like this:

```
try {
  UserCredential = await 
  FirebaseAuth.instance.signInWithEmailAndPassword(
    email: "tom.bailey@example.com",
    password: "WeLoveFlutter!"
  );
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    // User not found by Firebase
  } else if (e.code == 'wrong-password') {
    // Incorrect password
  }
}
```

In this example code, we try to sign in the user with their supplied credentials. In this case, we have hardcoded them, but you would use a couple of TextFormField instances and access their data, as described previously. The signInWithEmailAndPassword method will, unsurprisingly, sign in the user with their email and password.

Two obvious possible failures are that the email or the password might be incorrect, so adding a catch statement that deals with those failures completes the example.

Firebase Authentication can also deal with email validation, phone number registration, and password reset to give you a fully featured authentication solution. For example, after a user has signed in, you can do something like this:

```
User = FirebaseAuth.instance.currentUser;
if (!user.emailVerified) {
  await user.sendEmailVerification();
}
```

This will first get the current user's details as a User instance, upon which you can get information such as whether their email is verified. If it isn't, then you can send them another verification email so that they can verify their account.

As you can see, in very little code you can trigger the authentication flows and let the Firebase service take care of all the complications, which is why Firebase is so popular among Flutter developers.

Another key area of Firebase is the cloud databases. Let's take a look at those next.

## Realtime Database

The Firebase Realtime Database started life as the database for a chat client. It is probably the oldest part of Firebase and, although it has some unique features, you often get the feeling that the Firebase team would prefer new developers to use Firestore (which we look at next) in preference to the Realtime Database. This view is highlighted by a lack of web support for the plugin and was also evident in the delayed move to null safety, long after the other Firebase plugin updates had been completed.

At its core, the Realtime Database is effectively an online store of a massive JavaScript Object Notation (JSON) data structure, and it is through JSON that you interact with the database, by adding, updating, and deleting data. It is also through JSON paths that you identify the area of the database you want to manipulate. Note that this is very different from a traditional relational database and is part of the NoSQL style of databases that are now becoming prevalent since massive scalability and cloud-based redundancy have become more important factors than the normality of data.

NoSQL versus SQL databases

There are two types of databases: Structured Query Language (SQL)-based relational databases and NoSQL databases. In relational databases, it is important that data is not duplicated, but instead normalized.

A big advantage is that there is no chance of data inconsistency if the data is only stored in one place. A big disadvantage in a cloud world is that ensuring data consistency across multiple servers running the same database instances can cause bottlenecks. This was fine when there was only one server running an instance of the database or multiple servers co-located with fast network connections, but when cloud computing came along, the requirement to copy every update to many other instances of a database over long distances became a huge burden.

NoSQL databases aim to resolve this problem by allowing data duplication and eventual consistency. Retrieving and updating data becomes very quick and scalable. On the flip side, there is a risk that the duplicated data in the database becomes inconsistent.

This is a huge topic and worth exploring more about before you decide on your database solution.

One of the biggest advantages of the Realtime Database is, as the name would suggest, the ability to interact with it in real time. This includes setting up listeners on specific paths within the database so that your code is notified if anything changes at that path's location. This can be incredibly useful, giving your app a very dynamic and responsive feel.

It is also very useful to be able to manage very specific parts of the JSON tree through the use of paths. This allows you to manipulate very precise pieces of the JSON structure, reducing exposure to bugs and also reducing costs. The costing model is important to consider, and for the Realtime Database it is based on egress, and— specifically—how much data you retrieve from the database.

A big drawback of the Realtime Database is a lack of good transaction support. There is a limited ability to transact on a path within the JSON tree, but you cannot make changes to two places in the JSON tree within the same transaction, which leads to complex timestamping solutions to ensure consistency.

Another drawback is the querying support of the Realtime Database. You can only query on a single field (yes—one field) when retrieving data. This can be hugely restrictive to your data structure design, pushing you to create some kind of amalgamated field for querying on.

Also, it is worth noting that the Realtime Database has a limitation of 100,000 concurrent users, whereas Firestore has unlimited scalability. You can work around this by having multiple Realtime Database instances set up, but this does add complexity to your setup.

### Setup

As with authentication before, the plugin works alongside firebase_core as another dependency, as illustrated in the following code snippet:

```
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^1.2.0
  firebase_database: ^7.0.0-dev.3
```

Once you have the dependency, you will want to get a reference to the database. You can do this with the following code:

```
final _reference = FirebaseDatabase.instance.reference();
```

This _reference variable is what you will use to access and update the database data.

### Data manipulation

As mentioned previously, the data stored is in a massive JSON structure. For example, suppose our data store looked like this:

```
messages: {
  a3bdj2: {
    text: "Hello friends",
    viewedBy: [
      "tim@example.com",
      "jane@example.com"
    ],
    sentAt: 1621835683907,
    sentBy: "tom@example.com"
  },
  4bajfasdf: {…}
}
```

In the preceding JSON structure, we have a top-level map named messages that holds mappings from message identifiers (IDs) to message objects. Within the message object is the text of the message, a list of who has viewed it, when it was sent as a timestamp, and who sent it.

Suppose we wanted to mark that message as deleted. There are many ways to do that, depending on how you want to structure your client and your queries, but one way is to add a deleted flag to the object data. An example of doing that is shown here:

```
_reference.child('messages/a3bdj2/deleted').set(true);
```

In the preceding code snippet, we are asking the database to follow the path to the messages map, and then to the message with reference a3bdj2, and finally to the deleted entry. At this point, we set the value to true. Even though there isn't currently a path that includes deleted because the property doesn't exist yet, the Realtime Database is clever enough to fill in the gap and complete the set operation, giving a structure like this:

```
messages: {
  a3bdj2: {
    text: "Hello friends",
    deleted: true,
    …
  },
  4bajfasdf: {…}
}
```

You can similarly make updates (where only parts of the data are changed rather than replaced) or removals in the same way.

### Security

The Realtime Database has a security model based around the authentication we used earlier. This is a real strength of the database because security becomes easy to set up and understand. When you set up a database, you are given access to a security configuration file that you can manage.

This security configuration file is also based on paths within the JSON. So, for example, suppose I only want the author of a message to be able to mark it as deleted. In that case, I could add a security rule that looks something like this:

```
"messages": {
  "$messageId": {
    "deleted": {
      ".write": "auth.token.email_verified == true &&
       auth.token.email == root.child("messages/" + 
         $messageId + "/sentBy").val() "
    }
  }
}
```

In this example, we have defined a path (through nested map entries) of messages/$messageId/deleted. The messageId property has a $ (dollar) sign in front to show that this is a dynamic part of the path that will change depending on the messageId property.

We have then specified that we have a rule for any changes to data, using the ".write" entry. Within that, we have said changes are only allowed if the user has a verified email address and if their email address matches the email address specified in the database at the path location of messages/$messageId/sentBy.

If they match, then the change is allowed. If there is no match (that is, the user updating the deleted flag is not the one who wrote the message), then the change is rejected and an exception is thrown in your application.

As you can see, it is relatively easy to get up and running with the Realtime Database. Let's now look at Firestore and compare the features and functionalities of the two services.

## Firestore

The Firestore database is also a NoSQL database but takes a very different approach to the storage and retrieval of data. Unlike the Realtime Database, Firestore stores data in files, much like the filesystem on your computer. So instead of a big JSON object, Firestore follows something like a folder and file structure.

However, there are many similarities between the two databases, outlined as follows:

- Both databases store data in JSON. The files in Firestore contain JSON, so the same object data can be stored in either database.
- Both databases use paths to identify changes. In Firestore, the path is split into two parts—the file path, and then the data path within the file.
- Both databases use similar access control. Firestore access control has more capabilities but can also be more limited in how it uses data from other files to control access.

The costing model is different from the Realtime Database, where costs are based on the numbers of files read, written, and deleted. This model can really impact applications that use small pieces of data. A prime example of this is a chat app where not only does a small snippet of data get placed in each file, but also every other member of the chat group will need to read that file. In this situation, the Realtime Database is a much better fit.

Additionally, Firestore does not respond as quickly to updates, so for anything real-time, such as live multiplayer games, the Realtime Database is a better fit. It's definitely not shabby in its update speed, though, but you are talking seconds rather than sub-seconds to get updates.

Unlike the Realtime Database, Firestore has much better querying capabilities, allowing you to query across many fields. There are a couple of gotchas, though, that are worth being aware of. These are described here:

- You can only query on fields that are present in all the files, so in the example for Realtime where we added the deleted field, in Firestore you should already have the deleted field set with either a null or a false value.
- If you query for more than one field, then Firestore needs to prepare an index for every combination of fields. For example, if you want to search for messages that were a) sent after midnight and b) haven't been read by the user, then you need to create an index for those two fields. If you then decide to update that query to include a third restriction that the message wasn't sent by the user, then you will need to create a new index on the three fields. Generally, this isn't an issue but does mean you need to check every combination of your queries if they are dynamic.

Finally, Firestore is infinitely scalable—there is no restriction on the number of concurrent users like there is on the Realtime Database.

### Setup

Again, the plugin works alongside firebase_core as another dependency, as illustrated here:

```
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^1.2.0
  cloud_firestore: ^2.2.0
```

Once you have the dependency, you will want to get a reference to the database, as follows:

```
FirebaseFirestore _firestore = FirebaseFirestore.instance;
```

This _firestore variable is what you will use to access and update the database data.

### Data manipulation

As mentioned previously, the data stored is in a folder and file structure. Recreating the Realtime Database example, suppose you have a single message in a file, like this:

```
text: "Hello friends",
viewedBy: [
  "tim@example.com",
  "jane@example.com"
],
deleted: null,
sentAt: 1621835683907,
sentBy: "tom@example.com"
```

Again, the message object contains the text of the message, a list of who has viewed it, when it was sent as a timestamp, and who sent it. However, note that we don't have a messages map holding references to each message. This is now held in the folder—or collection, as it is named in Firestore. Also, note that we added the deleted flag with a null value to allow us to query for messages that are not deleted.

To make the same update to set the deleted flag, we would do something like this:

```
DocumentReference messageRef = FirebaseFirestore.instance
  .doc('messages/a3bdj2')
  .update({deleted: true});
```

As you can see, the process is very similar to that for the Realtime Database; find the file—or document, as it is known in Firestore—using a path, and then update the contents of the file.

### Security

The security configuration is slightly different from the Realtime Database setup, but is conceptually the same.

To restrict the ability to delete messages to the sender of the message, your configuration would look something like this:

```
match /messages/{document=**} {
  allow update: if request.auth.token.email ==
                   resource.data.sentBy
                && request.auth.token.email ==
                   request.resource.data.sentBy;
}
```

In this example, we are specifying that this rule applies to all documents that are in the messages collection. It is specifically a rule that governs updates to the document that restricts all updates to the user who sent the message. Note that because we are controlling access to the whole file rather than one specific field, as we did with the Realtime Database, we have also decided to ensure that the update doesn't change the sentBy property, effectively making it read-only.

## Analytics and Crashlytics

Understanding how your app is being used is crucial in deciding where to focus new development to improve your app. Google Analytics allows you to see how users move around your app, and Google Crashlytics allows you to receive stack traces when they are thrown within your app.

Add them using standard dependency entries, as follows:

```
dependencies:
  flutter:
    sdk: flutter
  firebase_core: "^1.2.0"
  firebase_crashlytics: "^2.0.4"
  firebase_analytics: "^8.1.0"
```

Ensure that you check the latest versions of the plugins on pub.dev.

### Crashes

To record a crash using Crashlytics, you would insert code like this:

```
await FirebaseCrashlytics.instance.recordError(
  error, 
  stackTrace,
  reason: 'bad times',
  fatal: true // or false for non-fatal crashes
);
```

In the preceding code snippet, we have called the recordError method on the Crashlytics instance to send crash information back to the Firebase server so that it can be reviewed there.

The Crashlytics dashboard is shown in the following screenshot:

![Figure 9.1 - Crashlytics dashboard ](/flutter4beginners2_img/figure_9.1_-_crashlytics_dashboard.jpg)

Unfortunately, more extreme crashes can occur that we might not be able to catch within our code. To report these crashes, simply add an entry in the app's main method, as follows:

```
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
```

This, unfortunately, still does not catch all errors, but there are options to use Zones (an advanced Flutter topic) to catch errors. Check the Crashlytics documentation for further information, at https://firebase.flutter.dev/docs/crashlytics/overview/.

### Analytics

Much as with reporting crashes, as just discussed, analytics is the reporting of all the other events that happen in the app. For example, to log that someone has opened the app, you would run the following code:

```
Analytics.observer.analytics.logAppOpen();
```

This would then be sent to the Firebase server so that you can analyze how many times your app has been opened.

Additionally, for general navigation around the app, this can be added to the Navigator so that the analytics are automatically uploaded.

In the widget where you create MaterialApp, simply define a new observer, as follows:

```
static FirebaseAnalytics analytics = FirebaseAnalytics();
static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
```

Then, attach the observer to the MaterialApp through the navigatorObservers constructor parameter, as illustrated in the following code snippet:

```
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: <NavigatorObserver>[observer],
      ...
    );
  }
```

Every time the user moves pages through the use of the Navigator, the move will be logged on Google Analytics.

## Cloud Storage

As you have seen, the Realtime and Firestore databases are designed around storing JSON data. What if you need to store something else, such as a text document or an image? This is where Cloud Storage comes into play. Files are stored in a folder structure, and some basic security controls are available that are similar to Firestore and Realtime Database access control. Additionally, some metadata can be attached to the file to assist with access control.

The plugin to add to your dependencies is firebase_storage.

## AdMob

When you play apps and see adverts on part of the screen, or sometimes have to watch a fullscreen video advert, then you are interacting with something such as Google AdMob. App developers need a way to monetize their apps, and one of the options is to add advertising.

There are several types of adverts available, outlined as follows:

- Banner: This is a rectangular advert that appears on part of the screen and refreshes after a set period of time.
- Interstitial: A full-page advert that appears at a natural break in the game, perhaps on completion of a level.
- Rewarded: An advert that a user chooses to view in exchange for benefits within the app such as additional coins, points, or lives.

The Flutter AdMob plugin supports all of these types. The plugin to add to your dependencies is google_mobile_ads. You will need to register for an adUnitId variable from Google AdMob so that you can request adverts. You can get this via the Firebase console.

Showing an advert requires several steps. The first step is requesting an advert from Google in preparation of showing it. Here's the code you'll need to do this:

```
RewardedAd.load(
  adUnitId: _adUnitId,
  request: AdRequest(),
  rewardedAdLoadCallback: RewardedAdLoadCallback(
    onAdFailedToLoad: (LoadAdError error) async {
      print("Failed to load ad ${error.message}");
    },
    onAdLoaded: (RewardedAd ad) {
      myRewarded = ad;
    },
  ),
);
```

In this example, we request a rewarded advert using our adUnitId variable and specify a callback when the advert is loaded. We store the loaded advert in a variable named myRewarded.

Next, we set up callbacks in preparation of a user interacting with the advert, as follows:

```
myRewarded!.fullScreenContentCallback = FullScreenContentCallback(
  onAdShowedFullScreenContent: (RewardedAd ad) {
    print('$ad onAdShowedFullScreenContent');
  },
  onAdDismissedFullScreenContent: (RewardedAd ad) async {
    print('$ad onAdDismissedFullScreenContent');
    await ad.dispose();
  },
  onAdFailedToShowFullScreenContent: (RewardedAd ad, 
  AdError error) async {
    print('$ad onAdFailedToShowFullScreenContent: $error');
    await ad.dispose();
  },
);
```

In the preceding code snippet, we set up callbacks for when the advert is shown, dismissed, or failed to show. These are important so that your app can take the necessary steps to move on to the UX after the advert flow has been completed.

Finally, we actually show the advert to the user, as follows:

```
myRewarded.show(
  onUserEarnedReward: (RewardedAd ad, RewardItem 
  rewardItem) {
    print('$ad onUserEarnedReward $rewardItem');
  },
);
```

In the preceding code, we request that the rewarded advert is shown, and specify a callback when the user has earned their reward.

It is worth noting that there is risk in issuing any rewards to the user from your app code because someone malicious can write code to emulate your app and issue themselves lots of rewards. Therefore, Google also supports a server-to-server approach for rewards. The Google AdMob server will contact your server and tell you that the user has received a reward, removing the risk of an attack.

## Cloud Functions

Throughout this book, we have looked at client technologies, the technology that will run on the client device: a phone, tablet, web page, or computer. However, most apps also need to run some code on a server. There are many reasons for this, including the following ones:

- Trusted integration code: Code that runs on a server can include security secrets such as integration with payment providers or email servers. These secrets cannot be included in an app because malicious users could decompile your app code and take the secrets, allowing them to impersonate your company.
- Elevated privileges: There may be something that needs to run with elevated privileges—for example, accessing parts of your database that you do not want to give general access to.
- Batch processing: Perhaps you need to do some intense work to update your database (for example, hourly leaderboards) that would not make sense on a per-user basis.

And there are many other reasons, especially around security and performance, that mean you will need to have a server for many app designs.

If you are using Firebase services, then the Firebase Cloud Functions framework makes a lot of sense to use for executing your server code. These functions directly link to your databases, including allowing you to trigger server code when certain database updates happen. They also work directly with Firebase Authentication, allowing you to control who has access to the functions.

Cloud Functions are currently written in JavaScript (or TypeScript), so we will not look at examples here. There appear to be options to use Dart for Cloud Functions, but it is not a supported route to take yet.

You can directly call Cloud Functions from your Flutter app and would use the cloud_functions plugin to do this.

Let's look at an example of making a call to a cloud function to record the reward from our rewarded advert, as follows:

```
final HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('storeReward', options: HttpsCallableOptions(timeout: Duration(seconds: 30)));
try {
  await callable.call({
    "email": email,
    "reward": 30,
  });
} catch (errorMessage) {
  print(errorMessage);
}
```

In the preceding example, the first line defines the name of the cloud function we wish to call, and the timeout we will allow for the call (30 seconds).

Then, within a try/catch block, we attempt the call to the cloud function with our parameters—in this case, an email address and the reward value. If the call fails, then we can mitigate the issue in the catch block.

## ML with Firebase ML Kit

Firebase ML Kit helps to add ML features to our app without the need for an ML experience. There's no need to have deep knowledge of neural networks or model optimization to get started.

Firebase ML Kit provides multiple tools, which are outlined as follows:

- Text recognition/optical character recognition (OCR): Recognize text in photos. Available as an on-device and cloud-based functionality.
- Face detection: Detect faces in an image, identify key facial features, and get the contours of detected faces. Available as an on-device functionality.
- Barcode scanning: Scan multiple types of barcodes. Available as an on-device functionality.
- Image labeling: Recognize entities in an image. Available as an on-device and cloud-based functionality.
- Landmark recognition: Recognize well-known landmarks in an image. Available as a cloud-based functionality.
- Language identification: Determine the language of a string of text. Available as an on-device functionality.
- Custom model inference: Use a custom TensorFlow Lite (https://www.tensorflow.org/lite) model with ML Kit. Available as an on-device functionality.

The on-device tools are application programming interfaces (APIs) that run offline and process data quickly. Cloud-based APIs, on the other hand, rely on Google Cloud Platform (GCP) to provide results with high accuracy. To do this on a device, you would use the firebase_ml_vision plugin.

## Messaging

Firebase also has the ability to manage push notifications. You would use a server or the Firebase dashboard to push out push notifications, but you may want to allow your app to take certain actions when they receive a push notification or if they are opened through an action on a notification.

Push notifications can be hard to get right, mainly because a lot of the configuration is server side, and if a message fails to be received, it is often a configuration issue with the failure being hidden in the Firebase or App/Play Store servers. You will see lots of documentation on the web where other developers have had issues and resolved them. The best answer is to be really diligent when configuring this section. Ultimately, you will be able to get push notifications to work, but only if you really pay attention to the details. Again, the documentation from the Firebase team is excellent.

If you want to take actions in your app based on push notifications, then the plugin you will need is firebase_messaging.

Let's take a look at an example of responding to a push notification, as follows:

```
FirebaseMessaging.onMessage.listen((RemoteMessage msg) {
  print('on message $msg');
});
```

In the preceding code example, you register to receive updates from the onMessage stream. Whenever there is an update placed on the stream, the callback code in the argument is called—in this case, a simple function that prints the message.

This section on Firebase will hopefully give you a taste of both the power of Firebase and the way it seamlessly integrates with Flutter. We have explored the two databases, authentication, analytics, storage, advertising, cloud functions, messaging, and have seen a glimpse of the power of ML Kit.

Let's continue our exploration of plugins by moving to some more popular plugins, starting with everyone's favorite, Google Maps.

# Understanding Google Maps and Places

You will have likely used Google Maps for navigation, but the use of Google Places is not so obvious. This is generally used when you enter an address into a textbox, and while you are entering it, there are suggestions for the full address.

Simply put, Google Places is where you find an address, and Google Maps is where you display that address. There are many plugins that support Google Maps and Places, so when choosing, make sure you look at the pub.dev scores.

A very good Google Maps plugin is google_maps_flutter, which is created by the Flutter development team. In pub.dev, you can click on the author—in this case, flutter.dev—and view all the plugins that the development team has created. Looking through the flutter.dev team's plugins is a great way to get a feel for all the different plugins available.

There are plugins for Google Places, but an alternative is the google_maps_webservice plugin, which is a wrapper on the Google Maps web services and allows access to the Places API and many other APIs such as Directions, Time Zone, and Distance Matrix.

Note that when using Google Maps in any of its forms, you will need to request an API key. Unfortunately, Google Places is a paid-for service, so your API key will link to how much you are charged for the service.

To register for an API key, follow this link: https://developers.google.com/maps/documentation/places/web-service/get-api-key.

Once you have an API key, you will need to include that in any calls you make to the APIs so that Google can identify who you are.

Let's look at an example of displaying a map from a place ID, as follows:

```
final places = GoogleMapsPlaces(apiKey: "__API_KEY__");
PlacesDetailsResponse placeDetailsResponse = await places.getDetailsByPlaceId(_placeId);
Widget mapWidget = GoogleMap(
  mapType: MapType.hybrid,
  markers: Set.from([
    Marker(
      position: LatLng(
                        _placeDetails.geometry?
                        .location.lat ?? 0,
                        _placeDetails.geometry?
                        .location.lng ?? 0,
      ),
      markerId: MarkerId(_placeDetails.placeId))
  ]),
  initialCameraPosition: CameraPosition(
    zoom: 15,
    target: LatLng(
      placeDetails.geometry?.location.lat ?? 0,
      placeDetails.geometry?.location.lng ?? 0,
    ),
  )
);
```

In this example, we use a placeId property to retrieve information about the place. We then use a GoogleMap widget to display the place marked on the map, using the geometry details about the place.

Additionally, we are able to specify information about a map such as the type—in this case, hybrid, meaning it has satellite images and a road overlay—and the zoom level. This means we can really tailor the map so that it fits the needs of our app.

Let's next look at some plugins that give us access to the features and functionality of the device the user is viewing our app on.

# Exploring mobile device features

There are a lot of features in devices, especially mobile phones or tablets, that your app can use to make the UX better. Normally, you would need to write device-specific code to access these features, but in Flutter, access to the features is generally available within a plugin. In this section, we will take a whistle-stop tour of some of these features, including the camera, web browser, local storage, and video playback, so that you can enhance the usability of the apps you create using the plugins that are already available to you.

## Camera and QR codes

A key feature that mobile phones and tablets have is the camera. This can obviously be used for photos, but it can also be used for other functionality such as Quick Response (QR) scanning.

A couple of plugins to check out are camera (built by the Flutter.dev team) and qr_code_scanner.

The qr_code_scanner plugin contains the following two key things:

1. A QRView widget that you place in your widget tree and will show the view from the camera
1. A QRViewController controller that you attach to the QRView widget and that supplies a stream of ScanData you can listen on to receive details of any QR codes that are identified

Note that if you are using the QR code scanner or the camera plugin, you will need to specify the reason why your app will need access to the camera. You do this by updating info.plist and adding the entry, as follows:

```
<key>NSCameraUsageDescription</key>
<string>Why my app needs to use the camera</string>
```

This will pop up for the user when the app tries to access the camera so that the user can make an informed decision on whether they will give the app access to their camera.

Let's see an example of the QRView widget and the QRViewController controller in action, as follows:

```
// Widget fields
final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
QRViewController? _qrController;
// Widget tree in build method
...
  QRView(
    key: _qrKey,
    onQRViewCreated: _onQRViewCreated,
  )
...
// Widget method
  void _onQRViewCreated(QRViewController controller) {
    this._qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        _controller.text = scanData.code;
        _showingScanner = false;
      });
    });
  }
// Widget dispose
  @override
  void dispose() {
    _qrController?.dispose();
    super.dispose();
  }
```

There are a few parts to this example, so let's explore each part in turn, as follows:

- Two fields are defined—the first to hold a global key so that on a rebuild of the widget a new QRView widget is not created, and the second to hold a reference to the QRViewController controller when it is created.
- A QRView widget is created in the widget tree. When it is first created, it will call the method specified in the onQRViewCreated parameter.
- A method is defined to be called when the QRView widget is created. This method, onQRViewCreated, receives a controller, which it stores in the qrController field, and then sets up a stream listener to receive updates on scanned data.
- Finally, in the dispose section, we clean up the _qrController variable so that we are not still scanning for QR codes after we have left this screen.

If you are scanning QR codes, then you probably also need a way to generate them. The qr_flutter plugin does an excellent job at this. Simply give it the data you want to embed in the QR code as part of the QrImage widget construction and your app will show a QR code, as illustrated in the following code snippet:

```
QrImage(
  data: "Whitby",
  version: QrVersions.auto,
  size: 200.0,
)
```

In this example, the "Whitby" data will be embedded in the QR code displayed.

## Opening web pages

Sometimes, you need to open a web page from within your app. This might be for license agreements, further information, advertising links, and many other possible reasons. Devices will generally have a web browser available, so all that is required is to pop open the web browser at a specified URL.

A plugin that allows you to do this very easily is the url_launcher plugin. To pop open the web browser, create a method that's something like this:

```
void _launchURL(url) async =>
    await canLaunch(url) ? await launch(url) : 
    print('Failed to launch $_url');
```

This method will take any URL, check whether the device can launch the URL, and if it can, it launches it.

You would then call this method from any button or InkWell within the onPressed or onTap methods, and the browser will be popped open. Note that the app will not be closed, just moved to the background while the user browses the website.

## Local storage

Sometimes, you don't want to—or cannot—use online storage such as the Firebase databases. Another option is to use local storage on the device, and there are many plugins that will facilitate that, including the shared_preferences plugin.

Generally, these plugins will allow you to save data to the local device storage in a map structure. For example, storing a name to a device using the shared_preferences plugin would look something like this:

```
SharedPreferences prefs = await
                          SharedPreferences.getInstance();
await prefs.setString('name', name);
```

If you want to store more data on the local device, then you may want to use a database to allow you to structure the data. One plugin that is very popular is sqflite. This plugin uses the SQLite database and has full support for insert, query, update, and delete operations. It also has powerful features such as transaction and batch support.

## Video

Devices generally have the ability to play back video, and embedding videos in your app can increase engagement. The video_player plugin is simple to set up and allows you to play videos that you have included in your assets folder or that are stored as a file on the network.

If you want to stream videos, especially from YouTube, then you will need to use a dedicated YouTube plugin. The most popular is youtube_player_flutter, which allows you to manage which controls are shown to the users, whether the video auto-plays, the colors of the controls, and many other things.

## Payment providers
If you want to take payments in your app, then you will need to use one of the payment providers that have support for Flutter. The two most prominent of these are Stripe and Square. Both will need you to set up server processing for payments, so it is a non-trivial setup process.

Both providers support integration with Apple and Google Pay, allowing you to create a very smooth customer payment flow.

## In-app purchases

If you are planning to have in-app purchases in your app, then you have a couple of options. You can go for the in_app_purchases plugin, which is well suited to one-off purchases where renewal and cancellation of subscriptions are not an issue. If you were to do subscriptions, you would need some server-side coding to cope with the renewal and cancellation flows from Apple and Google.

Alternatively, if you want to have a more complex purchase process, perhaps including subscriptions, and purchases outside of the App or Play Stores (which helps you avoid the 15% or 30% in-app payment charges), then you may want to look at RevenueCat. This service takes care of all the management of your purchases, including subscription renewal and cancellation, and has Stripe integration, giving you the option to sell your purchases on the web. Their plugin is purchases_flutter and requires that you have registered for the RevenueCat service in advance.

## Opening files

Unlike on the web, where file opening is generally done on computers that have great support for a range of file types, on an app users are generally on more restricted devices and need a way to open files. The open_file plugin can manage this flow for you. Add a button or InkWell that a user can tap to open the file, and then in the onPressed or onTap methods, add the following code:

```
OpenFile.open("fileLocation");
```

Check out the open_file plugin page on pub.dev to see all the different file types that are supported.

# Plugins to help with your app support

Finally, in this chapter, I wanted to make a special mention of plugins that help you support your app once it is in the wild. We saw the Crashlytics plugin earlier, and it cannot be said strongly enough that any live app must have a way to report crashes. On Android, there are so many different devices by so many different manufacturers that it is impossible to test across all of them.

Let's look at some other plugins that will make your life easier.

## App version

Although most people have auto-update set on their device's settings, some people choose to manually install updates. If someone has an issue and sends you details, you really want an easy way to see which version of the app they are running.

The package_info_plus plugin is perfect for this. It will read the information from your pubspec.yaml file and make it available for you to surface in a widget. Adding this information to your app's settings page is a must, but it is also worth showing this information before any login screens in case the user is unable to log in to the app.

The PackageInfo class needs to be initialized first, so you will probably want to create a version string asynchronously and then refresh the display using setState to display the version string. The code to do this is illustrated in the following snippet:

```
_initialiseVersionInfo() async {
  PackageInfo info = await PackageInfo.fromPlatform();
  String version = "${_packageInfo.version}-
  ${_packageInfo.buildNumber}";
  setState(() {
    _version = version;
  });
}
```

In this example, we build a version string from the app version and build number.

## Device information

Another piece of key information when trying to diagnose issues is to know about the device they are on. Often, users will know their device's make and model but not the software version that is running.

The device_info_plus plugin is able to get that information for your app so that you can again surface that information in a place that will help you diagnose any issues. If you can get a user to send you a screenshot of a page that holds the app and device information on it, then you will be in a much better place to start diagnosing any issues.

Suppose we want to print the name of the device to show on screen. As with the app version just before, we need to get the data asynchronously using code like this:

```
_initialiseDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (defaultTargetPlatform == TargetPlatform.windows) {
    WindowsDeviceInfo info = await deviceInfo.windowsInfo;
    print("Computer name ${info.computerName}");
  } // and other platforms... 
}
```

For each platform, you choose the information you want to surface.

# Summary

In this chapter, we have explored a wealth of Flutter plugins and have hopefully given you a taste of all the options available to you as you develop your Flutter apps.

We started by looking at the Firebase service and all the plugins available within that. Firebase is certainly an easy way to get up and running with features that can often take months to develop, and if created bespoke will probably cost more and be less secure. These plugins included all the core capabilities that are needed within an app, including authentication, data and document storage, push notifications, analytics, and server-side functions. Additionally, we looked at how we can monetize our app through the AdMob plugin.

Next, we looked at some plugins that exercise the features of the device they are running on. This is certainly an area that could be explored a lot further via the pub.dev site. These plugins allow you to create a great UX, from using media such as videos, cameras, documents, and the web browser, to simplifying the user's interactions with the app via QR code scanners, local storage, payments, and in-app purchases.

Finally, we saw a couple of plugins that will help with supporting your app once you have released it. If there are issues, you are able to respond quickly using crash reports, often before users even report the problem, using analytics to identify areas of the app that receive higher or lower usage.

In the next chapter, we will move back into coding mode and look at adding some animations to our Hello World application.

