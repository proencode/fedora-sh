원본 제목: Chapter 3: Flutter versus Other Frameworks
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/103
Title:
103 Flutter versus Other Frameworks
Short Description:
Flutter for Beginners Second Edition 플러터와 다른 프레임워크 비교

![Figure 3.6 - Example pub.dev search ](/flutter4beginners2_img/figure_3.6_-_example_pub.dev_search.jpg)
- cut line


# Chapter 3: Flutter versus Other Frameworks
Flutter for Beginners Second Edition

Making a technology choice is rarely simple, and generally requires understanding the pros and cons of the different options, and eventually a leap of faith. You may be at the point where you are deciding whether your next project is going to be Flutter based, you may have dabbled with Flutter and want to solidify your knowledge before pushing forward with it, or you may be experienced and want a knowledge refresher. Regardless of your experience, it is always useful to understand the technology landscape and understand the synergies between different frameworks.

In this chapter, you will see how Flutter compares to other frameworks: the similarities and differences, the pros and cons of the different options, and how existing knowledge of another framework can be applied to Flutter. Even if you are fully decided on using Flutter in the future, it is worth reviewing this chapter as it gives context to some of the design decisions that have been made.

The following topics will be covered in this chapter:

- Native development
- Cross-platform frameworks
- Flutter community
- Flutter strengths and weaknesses

# Native development

Often cited as the purest solution, native development refers to writing apps in the language common to the platform of the device. For iOS this is Swift (or previously, Objective-C), for Android it is Kotlin (or previously, Java), and for the web it is generally HTML/JavaScript:

![Figure 3.1 - Swift and Kotlin logos ](/flutter4beginners2_img/figure_3.1_-_swift_and_kotlin_logos.jpg)

Native is seen as the purest solution because there is no bridge between the app and the platform, or no transpilation of code. Therefore, the code that is developed is the code that is run and talks directly to the features available from the platform, be that iOS, Android, or the web browser. Once you move away from native development, you introduce certain risks, such as the following:

- The software bridge having slow performance or deep, difficult to diagnose, bugs
- The transpilation process having deep, difficult to diagnose, bugs
- A lack of access to key platform features

It is therefore critically important that the quality of alternatives is assessed when moving away from native programming as a fundamental problem in an alternative framework can block and even invalidate an app.

## Learning from experience 1

A real-world example of a framework problem invalidating an app happened to me a few years ago. We were using a cross-platform solution and were developing and testing on iOS. The framework effectively used a software bridge by embedding a web browser in the app, with the app running within the embedded web browser (we will see examples of this later). Once the app was nearing completion, we started testing on Android and found that the software bridge had serious performance issues that were fundamental and could not be worked around. After much heartache, the app was eventually only released on iOS, and an important lesson had been learned!

So, if native development is likely to have the best performance, the least chance of fundamental issues, and is the least likely to have deep bugs, why would you ever move away from native? There are many reasons, but like I said earlier, a technology decision is rarely clear-cut. Let's explore the many factors that can contribute to taking the decision to move away from native programming.

### Developers

Many software projects have their technology choices decided not by careful consideration of the different technology options, cross-referenced against expected development timelines, with performance benchmarks and UI studies brought to bear. Let's be honest, most technology choices are either based on the skillset available, or the skillset that developers would like to learn next.

Learning a new programming language and framework will delay a project, sometimes seriously, and the code developed early in the project will be rewritten many times as developers learn to structure their code better, encounter different design methodologies, and optimize the execution flows.

This initial delay has to be taken into account when assessing technology choices; the best technology choice may not be the best project choice. If you already have a pool of developers, then the benefits of a technology change may be more than consumed by the reduction in productivity.

On the flip side, native developers tend to be more expensive and in higher demand than developers for other technologies. Additionally, learning a new skillset may initially reduce productivity, but for longer-running projects you would expect productivity to recover.

### Project management

Unless you are developing for one platform, you will need several teams of developers to develop natively. This is because a Swift developer is generally not also a Kotlin developer, or if they are, the context switching between the two languages and development environments can seriously impact productivity.

Project managing several development teams where the resources are not fungible (that is,you cannot move a developer from one team to another) can lead to complications in ensuring feature parity and defect resolution.

For example, suppose that there is an iOS development team and an Android development team working on the same backlog of features for an app, aiming for a shared release date.

Imagine that the iOS development team encounters a defect that is complex to diagnose and fix, while the Android development team continues development at a high velocity. As the release deadline approaches, the Android team has many more features completed than the iOS team. At this point, the project manager has to earn their money by deciding whether to do the following:

- Release the apps without feature parity. This can be a confusing experience for users who have multiple devices.
- Delay release until the iOS team catches up. What do you do with the Android team during this time? They are likely to tidy up their code, fixing more minor bugs, and doing more extensive testing, leaving the Android code base in a much better state than the iOS code base, leading to further productivity differences going forward.
- Disable features on the Android version. Not necessarily an easy option if, as is normally the case, the features are not completely disconnected, and also likely to introduce bugs going forward unless disabling the feature is given time to be coded fully.

None of these options are optimal and are exacerbated if you are also developing for other platforms such as the web.

Contrast this with a single code base where one, or many, development teams are working in the same language, development environment, and backlog of features. If there are multiple teams, then the developers are much more fungible; if one team is struggling with a feature, then a developer can more easily switch teams and assist with the development.

### Defect reports

Similar to the project management considerations, having native apps will lead to disparities in defect reports. One development team may have done less testing than the other, so on release, one app may be inundated with defect reports, while the other app may be relatively free of defects.

Additionally, you now need to know which platform the user is using to know which app has the bug. In some circumstances, such as crash reporting, this isn't such an issue. However, the vaguer identification of defects, such as a comment on a forum or social media, will likely not reveal that information, leading to a more complex identification and resolution of the defect.

### Performance

Measuring performance is notoriously difficult. Do you look at benchmarks that only exercise certain parts of the framework or programming language, or higher-level performance, which can highly depend on the app structure, how the framework has been employed, and the kinds of tasks the app is doing? Therefore, in this chapter, generalities will be used simply as a guide.

However, it is generally accepted that native apps are the fastest and it is pretty clear why. The language and framework are optimized for the platform and vice versa.

Also, and equally importantly, there are no cross-platform compromises that need to be made. To make a framework completely cross-platform means that the app code may interact with the platform in a suboptimal way so that a single piece of code can work with all platforms.

For example, to use a feature, there may only need to be a single method call, but to use the same feature on Android may require several method calls. Depending on how this interaction is revealed to the developer, it may lead to suboptimal performance.

However, it is worth noting that in some situations, Flutter has been seen to be comparable with native apps in terms of performance, and it definitely doesn't appear to be an issue that is mentioned within the Flutter community.

### Platform features

Native apps have access to all the features of the platform, otherwise, by definition, they can't be a feature of the platform because they would never be used.

Cross-platform solutions such as Flutter generally expose platform features through plugins. We will explore Flutter plugins later in the book, but as a quick overview, many plugins will interact directly with platform features and expose them to the app developer in a platform-agnostic way. In Flutter, there is a vibrant community creating plugins and these can be viewed at the package repository at https://pub.dev.

### Plugin versus package


In Flutter, you can add plugins and packages to your project from the package repository. Both plugins and packages are simply a way to share code, but for clarity, a plugin is a special type of package that includes wrappers of native code. You will often use a mix of plugins and packages in your Flutter projects, but the terms "plugin" and "package" are somewhat interchangeable, so don't worry about the difference.

However, there will not necessarily be plugins created for every platform feature, or the plugins available may not support the platform that you require. This was true in the early days of Flutter, but is generally not an issue anymore. In this instance, you may need to write your own plugin.

Another consideration is that some platforms offer features that are not available on other platforms. In this case, a plugin may have been created, but will obviously not be platform agnostic. In this instance, you will need to include platform-specific code in your app.

### Hot reload

One of the most awesome features of Flutter is hot reload; the ability to make changes to the code and see it instantly update on the device without your state being changed. This is hugely beneficial in software development; anything that reduces the time between code and feedback allows the developer to achieve flow more easily.

Android has a feature that appears similar, called Instant Run. However, under the covers, it works in a quite different way. Instead of using the JIT approach of Flutter, Android studio will compile the changes and then try to update as little as possible on the device. Often this leads to large changes and sometimes a full rebuild of the whole app.

iOS development with Swift does not currently have an equivalent to Flutter hot reload. There are ways to preview in XCode without running the full app, but this is obviously much more limited than the Flutter approach.

### User experience

There are certain expectations of design that differ between users of different platforms. For example, many apps have design differences between iOS, Android, and the web. Developing native apps allows you to design your code around these considerations, whereas in cross-platform development, you may need to have platform-specific code.

Flutter caters for this to some degree by having platform considerations embedded in the built-in widgets. For example, the back button on the AppBar (the top bar on the app) changes styling depending on the platform.

However, if you want the actual user experience to be different on different platforms (that is, the flow and interactions), then platform-specific code will need to be added. This is relatively pain-free on Flutter (we will see this in later chapters) but can lead to platform-specific bugs, so this must be a consideration.

### App size

A very basic native app can often be less than 1 MB.

A minimal Flutter app has to hold the core engine (circa 3 MB), framework + app code (circa 1 MB), and other files (circa 1 MB), meaning a basic Flutter app starts at 5 MB.

For larger apps, this is unlikely to be an issue because the relative size of the core engine and framework will be relatively smaller, but for very lightweight apps, it should be a consideration.

### New platforms

There have been and will probably continue to be attempts to enter the mobile devices market with new platforms. An example of this is Huawei (a prolific mobile device seller), who are attempting to move from the Android platform to their own Harmony platform. Additionally, they are planning to share this platform with other device makers.

Creating a development team to develop apps for a new platform can be a hugely expensive risk because the platform may not get much traction and it may be a development dead-end. However, the benefits of getting onto a platform early can be huge because there is likely to be a lack of competition.

With a cross-platform framework, if the solution is updated to support the new platform, then it can be incredibly easy to release on the new platform with very little development needed. It hugely reduces the risk of moving to the new platform while keeping the potential upside.

Unfortunately though, if the framework is not updated to support the new platform, then you have no path to move your cross-platform app to the new platform. Note though that in this situation, you are not in a worse position than having native apps; in both scenarios, you would need to create a new app natively for the new platform.

### Retired platforms

On the flip side, platforms can look promising and then fail. The most notable of these was the Windows Phone by Microsoft, which struggled to get market share due to a lack of apps on its store and was eventually retired when Microsoft changed its priorities.

Being locked into a platform as it begins to fail not only impacts the success of the app on that platform, but also leads to complicated political discussions:

- Should we continue to develop on that platform to keep feature parity?
- Will the platform recover? Constant analysis of the platform sales and market share distracts from product creation.
- Should we retire the app from the platform? Will that lose us customers who will eventually move to a platform that we still support?

With a cross-platform solution, these discussion points become relatively redundant. You can continue to release new versions of your app on the failing platform for a much longer period of time because the features developed will be used for all platforms. There is a requirement to test on the platform, but again this is somewhat alleviated because a lot of the testing will be carried out on other platforms anyway.

## Learning from experience 2

When Windows Phone first arrived, I was keen to release a football (soccer) app into what I believed to be a fast-growing market. I used the native Microsoft framework XNA for the app development and produced SoccerTime. As mentioned previously, there was initially a lack of competitors, so the app grew quickly. Sadly, as we all know, the platform failed, and the lock-in meant I couldn't port to iOS and Android. SoccerTime was no more! Interestingly, it looks like the community converted XNA into a cross-platform solution called Monogame, an interesting twist on the native versus cross-platform debate.

### Overview

Let's take a quick recap of the pros and cons of using native over cross-platform.

Pros:

- Performance
- Full platform feature access
- Closer alignment with expected user experience

Cons:

- Multiple code bases
- Multiple development teams
- Lack of fungibility
- Disparate defect reports
- Feature parity complexities and alignment on product vision
- Expense to move to a new platform
- Complexities of moving off a failing platform
- Different platforms having different features

Hopefully, you are sold on the idea of developing cross-platform but now understand the considerations. So what alternatives are there to Flutter?

# Cross-platform frameworks

Let's look at a few alternative frameworks. There are quite a few options, but many are based around three core approaches: React Native, Cordova, and Xamarin.

## React Native
The most common cross-platform framework before Flutter was released was React Native. Like Flutter, React Native is open source, and like Flutter, it is backed by a big software development company in the form of Facebook:

![Figure 3.2 - React Native logo ](/flutter4beginners2_img/figure_3.2_-_react_native_logo.jpg)

It is a popular framework mainly because it reuses the technologies and methodologies of the React web framework. There is a very healthy React Native community that takes the framework forward and produces plugins for the different platforms. Also, given the greater maturity of the framework, there is likely to be a greater wealth of plugin support and documentation available.

Technology wise, React Native uses JavaScript for the general app look and feel, and then Java or Swift to write native modules for the more complex features such as image editing. The motto of the framework is "Learn once, write anywhere," unlike the Flutter vision of writing once and running everywhere. This is because the native modules are not reusable across the platforms, leading to different code bases.

Like Flutter, React Native has hot reloading, allowing fast development and iterations of app code.

Performance wise, the general view seems to be that React Native is slower than Flutter. There are many reasons for this, but the fact that Flutter is compiled to native libraries whereas React Native has a JavaScript layer seems to be a key contributor. However, with such a variety of app designs, it is hard to make anything other than generalizations.

Interestingly, in the 2020 Stack Overflow survey, React Native was noted as the 10th most dreaded framework, yet Flutter was noted as the third most loved framework. Enjoyment of coding is a huge aspect of productivity, so this is an important aspect to take into account.

### Moving to Flutter from React Native

Flutter uses reactive-style views, with widgets being comparable to React components. This similarity makes it relatively easy for a React Native (or general web React) developer to understand the state, build, and setState aspects of Flutter.

Some key language differences between JavaScript and Dart, the programming language used by Flutter, are the following:

Variables: Unlike JavaScript, Dart is a type-safe language, so variables must be declared with a type or the type system can infer the type.
Dart has no concept of undefined. Either a variable has a value or it is null.
Dart has no concept of truthy. Only the Boolean value of true is treated as a true value.
The JavaScript Promise is represented by the Dart Future object. The async and await operators act on Futures like they do on Promises in JavaScript.
Printing to the console uses the print() method instead of console.log().
For more details, the Flutter documentation gives a great overview of transitioning from React Native to Flutter: https://flutter.dev/docs/get-started/flutter-for/react-native-devs.

## Xamarin

Much like React and Flutter, Xamarin is open source and backed by a big technology company, in this case Microsoft:

![Figure 3.3 - Xamarin logo ](/flutter4beginners2_img/figure_3.3_-_xamarin_logo.jpg)

Xamarin uses .NET technologies and the C# programming language. When using Xamarin Native, you get all the performance benefits of native apps, but the user interface code is platform specific, so roughly 75% of the code base is shared. This means knowledge of native languages is required in addition to Xamarin.

With Xamarin.Forms, a separate product that replaces the platform-specific user interface code, code sharing can be increased. However, note that Xamarin.Forms is being retired soon and replaced with the Multi-platform App UI (MAUI).

Like React Native and Flutter, Xamarin supports hot reloading to allow faster rebuild and testing.

Considerations for the Xamarin approach are that the licenses can be expensive, especially for an enterprise. Additionally, the Xamarin community is much smaller than the React Native and Flutter communities, which can restrict available developers and also community support.

### Moving to Flutter from Xamarin.Forms

The Xamarin.Forms Page concept is similar to the Route concept in Flutter. So a Route will lead from one Page to another Page.

However, the key difference is that everything is a widget in Flutter. So, whereas a ContentPage will contain elements such as Entry or Button, in Flutter, the page is a widget that contains nested widgets. One of the nested widgets may draw an input field or a button.

Again, the Flutter documentation does a great job of explaining how to migrate to Flutter: https://flutter.dev/docs/get-started/flutter-for/xamarin-forms-devs.

## Cordova

Apache Cordova takes the web technologies of HTML, CSS, and JavaScript and allows them to run on mobile apps. Formerly PhoneGap, Cordova is itself more of a platform that allows frameworks to run within it, such as Ionic:

![Figure 3.4 - Apache Cordova logo ](/flutter4beginners2_img/figure_3.4_-_apache_cordova_logo.jpg)

Effectively, the Cordova app runs within a WebView, which is like a built-in browser for each platform. This means that, unlike React Native and Xamarin, all the code is cross-platform. However, a major issue is that the WebView implementations for different platforms can be subtly different, leading to inconsistencies and bugs in the user interface.

Additionally, depending on WebView performance, the app can run slowly, especially on graphic-intense apps. As an added complication, the WebView can be different on different versions of the platform, so performance and user interfaces can be different on different versions of the platform. This can be especially true on the Android platform.

### Moving to Flutter from Cordova

One key difference you will notice immediately is that Flutter styling is embedded within the widget, rather than declared in a separate style document like CSS.

This has many benefits, a main one being the mental load that is put on the developer is hugely reduced as there is one less language to contend with.

The layout of widgets does not quite match the expectations of web developers. The number of times I've caused overflows because I've reverted to the web layout way of thinking is painful.

Again, there is excellent documentation on the Flutter site to guide you through the differences: https://flutter.dev/docs/get-started/flutter-for/web-devs.

## Popularity

When choosing a framework, it is important to know the popularity so that you can assess whether the framework will have long-term support.

A common way to assess popularity is to look at the Stack Overflow trends report. This shows how many Stack Overflow questions were asked about a specific framework:

![Figure 3.5 - Stack Overflow trend report ](/flutter4beginners2_img/figure_3.5_-_stack_overflow_trend_report.jpg)

A simple comparison of the frameworks mentioned previously shows the following:

- Questions about the older frameworks of Cordova and Xamarin are reducing slowly.
- React Native and Flutter are seeing fast growth in questions asked.
- Flutter has become the most popular framework to ask about, especially since Flutter 1.0 was released in 2018.

It can be argued that fewer questions need to be asked about the older frameworks because they have already been asked, so feel free to interpret the chart as you wish, but it clearly shows that there is currently a lot of interest in Flutter.

Stack Overflow is a great resource, but a framework not only needs a healthy set of Stack Overflow questions for it to grow and develop; it also needs a strong community.

# Flutter community

Flutter has a vibrant community, which is key to the long-term success of any software project that relies on community contributions. Google is very active in this, involving Flutter in conferences and organizing Flutter events.

## Events

Flutter Engage is an event dedicated to the Flutter framework. It shares best practices, new developments, feature overviews, and the chance to interact with Flutter experts.

The first Flutter Engage took place on March 3, 2021 and introduced a whole raft of new Flutter features, including Flutter 2.0, dual-display widgets from Microsoft, first-class Google AdMob integration, and tooling to help with Flutter migration to newer versions, among many other features and bug fixes. Flutter 2.0 also introduced full support for the web platform, which was previously a beta release. In addition, stability on all desktop platforms was announced, which led to an announcement from Canonical, publisher of Linux distribution Ubuntu, that "Flutter is the default choice for future mobile and desktop apps created by Canonical."

Google I/O, a general Google event for developers, often features Flutter talks. It is useful to attend these as not only can you learn about the new features being developed, you can also get a feel for the strategic direction of the project. It was at Google I/O that an early preview of project Hummingbird, the move of Flutter to the web, was shown.

There are regular meetups around the world where groups will discuss the latest Flutter technology, share their learning, and help newcomers join the Flutter bandwagon. It is worth noting that Flutter communities are not just English speaking, with great communities such as Flutterando in Brazil (with over 8,000 members) allowing you to have Flutter meetups in your native tongue. Check out the https://meetup.com site to find a meetup near you.

## News and discussion

The Flutter Google group is a great place to raise questions and discuss issues. It is a very active group, generally with answers given within hours of questions being asked: https://groups.google.com/g/flutter-dev.

An alternative when having issues is to head to Stack Overflow for assistance. Many of the issues you encounter will have already been answered on there, and if not then it is very easy to ask your own question.

Two excellent email subscriptions will give you a weekly update on all things Flutter:

- Flutter Weekly provides links to useful libraries, code examples, and highlights future events. Subscribe at https://flutterweekly.net/.
- Flutter Tap gives more general news and event updates, alongside tutorial videos and useful packages. Subscribe at https://fluttertap.com/.

## Resources

All of the Flutter code is on GitHub. You can view code here, track defects, and follow new releases. The main repository is at https://github.com/flutter/flutter, but all plugins will have their own repositories and issue tracking as well.

All of the plugins/packages created for Flutter and Dart are listed on the https://pub.dev/ site. The site includes a powerful search that will list all the plugins and packages that are relevant. Importantly, the vitality of plugins and packages is reported through a series of metrics, allowing you to find the best plugin or package for your project:

![Figure 3.6 - Example pub.dev search ](/flutter4beginners2_img/figure_3.6_-_example_pub.dev_search.jpg)

As you can see in the example, a search for apple sign in returns at least three options. Deciding between them used to be complicated, but now the likes, pub points (how well the project adheres to the standards such as documentation, code style, and platform support), and popularity help you get a feel for which plugin might have the best longevity and support.

The main Flutter website holds huge amounts of documentation, including the latest links to the community and news of events. I strongly suggest you take a look around the site to see what is available: https://flutter.dev/.

So, Flutter has a vibrant community that is helping drive the framework forward and make it even better. Let's bring together the key parts of this chapter from the point of view of Flutter itself.

# Flutter strengths and weaknesses

So, we've had a look at the other options available to you for your mobile project, and looked at the vitality of the Flutter community. This book is not designed to brainwash you into thinking Flutter is the best option (though it probably is), but given the context of the technology landscape, let's recap the strengths and weaknesses of Flutter so that you can make an informed decision.

## Strengths

The following are some of the strengths of Flutter:

- Hot reload: Flutter has the best hot reload functionality (equal to React Native and Xamarin), and this is a huge productivity benefit.
- Single code base: Of all the options available, only a couple (Flutter and Cordova) truly have a single code base that will work across platforms. As discussed, this helps hugely with project management, defect resolution, and new platforms becoming relevant or old platforms being retired.
- Project vitality: Flutter has a very active community with a huge range of community plugins, easy ways to ask questions, and the most activity on Stack Overflow. If this was a concern, it should have been mitigated somewhat by our exploration of the community.

- Performance: Dart compiling to native and the lack of a software bridge ensure that Flutter, if not as performant as native, is more than sufficient for apps.
- Documentation: The documentation on Flutter is excellent. Compared to some other cross-platform frameworks, the Google team, and the plugin writers, have worked hard to ensure that Flutter is very well documented.

## Weaknesses

The following are some of the weaknesses of Flutter:

- New framework: Flutter is relatively new and although that means it can learn from what has come before, it also means that there are lots of changes that can impact backward compatibility. This means developers often need to migrate their code to cope with the changes, sometimes holding up new releases.Flutter migration examplesA big Flutter change was the introduction of null safety to the language. Null safety had to be introduced to Dart and Flutter carefully as it required migration of code, and it made sense to work on dependencies, such as plugins, before developers migrated their app code. Another example is that Flutter widgets regularly get deprecated and replaced to improve consistency in the framework; for example, FlatButton became TextButton and RaisedButton became ElevatedButton.
- App size: As mentioned in the native discussion, a minimal Flutter app is already 5 MB. This is comparable with other cross-platform frameworks, but significantly bigger than native apps.

# Summary

In this chapter, we looked at how Flutter compares to other mobile app development options. Initially, we explored native development options and using them versus general cross-platform solutions. We saw many of the advantages and disadvantages of the native approach.

We then looked at some common cross-platform frameworks and how they compare to Flutter. We saw that although they are trying to solve the same problem, they are doing so in different ways, leading to different trade-offs against the other options.

Next we explored the Flutter community and highlighted some useful resources. This helped us to understand that the Flutter community is very active, which is a huge positive for the future of Flutter.

One of the key aspects of the community is the plugins that are created. We will explore these further in later chapters.

You should now start to see why Flutter is so awesome, and why it is fast becoming one of the main development options for new app projects.

In the next chapter, you will have a proper play with Flutter, building on the Hello World! app you started in Chapter 2, An Introduction to Dart. We will particularly focus on widgets and how to use them to create your user interface.

