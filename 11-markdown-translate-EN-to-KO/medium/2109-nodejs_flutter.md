Thiago Evoá Sep 15, 2021 Creating an end-to-end project, from Node.js backend to Flutter app.
https://thiagoevoa.medium.com/creating-an-end-to-end-project-from-node-js-backend-to-flutter-app-a8df8ffdde5b

Hello dev, sometimes I read some posts in different social media groups asking if is possible to use a [Flutter](https://flutter.dev/) project with any other technology as back-end besides [Firebase](https://firebase.google.com/), and I still get surprised because as far as I know, a front-end or an app does not depend from a single back-end technology.

So, because of that I’ll create two different projects using these two technologies mentioned on the title, and connect each other via HTTP protocol. And just to clarify I wont implement a difficult project, instead I’ll show the concept that you can pretty much use and adapt to your project.

# Node.js Back-end server

As a back-end we could use any other technology as I mentioned above, however I’ll use [Node.js](https://nodejs.org/en/) because I know a little about it and it’s easy to setup the environment and implement the solution.

In my case I’m using a MacOS so I’ll install the Node.js using Homebrew, and if you are using Linux you can do the same, but if you are using Windows take a look how to install using Chocolatey. And one more thing, download the vsCode to help writing the code and make sure to install these plugging marked as red in the image bellow.

![ Figure.11 to install these plugging marked as red ](/medium/2109/nodejs_flutter/figure.11_to_install_these_plugging_marked_as_red.png)

After setup the development environment, open the terminal and create a folder with you project name, in my case I called it as “test_http”, and to do that I just run the command “mkdir test_http”.

Then go inside this folder using the command “cd test_http”, and run the command “npm init -y” to create the Node.js project, and then open the project in the vsCode, and now you probably have something like this.

![ Figure.12 Node.js project creation ](/medium/2109/nodejs_flutter/figure.12_node.js_project_creation.png)

To give a quickly explanation, this package.json file is responsible for to have all the meta-data project configuration and also manage the dependencies that we may need to install.

And talking about dependencies, let’s install the one that’s going to help create the back-end server. So to do that, on the vsCode open the terminal and run the command “npm install express”, and then change the “script” property like the image bellow, because this “script” property is responsible for executing the project.

![ Figure.13 package.json ](/medium/2109/nodejs_flutter/figure.13_package.json.png)
s
Now is time to code, and as you can see I created the “server.js” file, and you should to the same, and copy this code like the image bellow.

Here we are defining the express application and saying that we are going to use the json format when send and receive data, then I’m creating a http GET method which just send the messageJson object, and last we are making this server listen on port 3000.

![ Figure.14 server.js ](/medium/2109/nodejs_flutter/figure.14_server.js.png)

Easy right? To test if everything is working, open the terminal in vsCode and run the command “npm start”, and you will see the console saying the message “running…”. Now if you have a tool like Postman, open it and try to call the server as the image bellow.

![ Figure.15 Postman ](/medium/2109/nodejs_flutter/figure.15_postman.png)

And that is it, we have a back-end server up and running, now it’s time to create the app and communicate them.

# Flutter app

Now this is the Flutter time, but if you don’t have it installed on your machine go to the Flutter Installation guide web page and follow the steps they provide.

And when you finish installing the Flutter, to create a project use the command “flutter create app_test_http”, where “app_test_http” is the name of the project, but you can use anything else, and after run this command you will have something like this.

![ Figure.16 Flutter project ](/medium/2109/nodejs_flutter/figure.16_flutter_project.png)

Now the first thing you are going to do, is install all the packages which will help to implement the project. To do that use the keys shift+cmd+P on MacOS or the respective on Linux or Windows, then type “Add Dependency” and install these bellow:

1. flutter_riverpod
2. dio
3. freezed_annotation
4. retrofit
5. pretty_dio_logger
6. json_annotation

Latter use the keys shift+cmd+P again, type “Add Dev Dependency” and install these bellow:

1. build_runner
2. freezed
3. json_serializable
4. retrofit_generator

Ok, after doing that you probably have something like this.

![ Figure.17 pubspec.yaml ](/medium/2109/nodejs_flutter/figure.17_pubspec.yaml.png)

Now go to the “lib” folder then open the “main.dart” file and copy the code as the image bellow. Here we are basically creating the ProviderScope in line 6, which is going to hold all the providers classes, in order to make them useful in all application.

![ Figure.18 main.dart ](/medium/2109/nodejs_flutter/figure.18_main.dart.png)

Now let’s create the class responsible for representing the json that we are going to receive from back-end, inside the “libs” folder create the file “message_dto.dart” like the image below.

Basically I’m defining a class with a property called “message” representing the property of the json, then I’m creating a function to convert from and to json and to do that I’m using the freezed annotation.

Don’t worry with the red lines saying that you have errors, because we are going to make it disappear soon.

![ Figure.19 message_dto.dart ](/medium/2109/nodejs_flutter/figure.19_message_dto.dart.png)

Moving forward, next class you need to create is the one responsible for making the http calls, so inside the “lib” folder create the file “api.dart” like the image below.

This time I’m using the “RestApi” annotation provided by the retrofit package to help creating this, and I repeat don’t worry with the errors because we are going to get ride of then right now.

First let me explain why these errors are happening, I don’t know if you had noticed but for these two class I’m using an abstract class, and it means that I’m creating a blueprint which defines what the build_runner package is going to generate in the code.

And to generate the code, open the terminal in vsCode and run the command “flutter build pub run build_runner build”, and now you may have noticed that you have some files with “g.dart” and “freezed.dart” and this is the build_runner generating these files with the annotation on top of the class, based on the blueprint you created.

![ Figure.20 api.dart ](/medium/2109/nodejs_flutter/figure.20_api.dart.png)

Now I’m going to create a file called “dio_provider.dart” which will hold the dio configuration in order to use in entire application, and to do that I’m creating a provider using the flutter_riverpod package and as return of the function I’m creating the dio with these configurations below, and in this case I’m adding a logger to see whats going on when I send and receive something, and also an group of interceptors in case I want to do something with these informations.

![ Figure.21 dio_provider.dart ](/medium/2109/nodejs_flutter/figure.21_dio_provider.dart.png)

Next step is use the repository pattern because I want to abstract the usage of the class that will provide the requested information, and with that we are going to depend on the abstraction and not the implementation of that.

So, first create the “irepository.dart” like the image bellow and just define this ”retrieveMessage” function.

![ Figure.22 irepository.dart ](/medium/2109/nodejs_flutter/figure.22_irepository.dart.png)

Then create the “repository.dart” and implement this previous abstract class, and this implementation will call the api defined in the constructor.

![ Figure.23 repository.dart ](/medium/2109/nodejs_flutter/figure.23_repository.dart.png)

Now let’s connect the view with all the rest, and to do that let’s create the “viewmodel.dart” file, which will hold all that logic instead of having this in the view.

As you can see, for this viewmodel I’m using the flutter_riverpod package to help creating this state management solution and also providing this to the view which is going to be created in a second.

Note that the “viewmodel.dart” in this case only have a definition of the repository in the constructor and with that is possible to have the function provided by it and a logic to change between a progress indicator and the final data when finish receiving the information by the back-end.

![ Figure.24 viewmodel.dart ](/medium/2109/nodejs_flutter/figure.24_viewmodel.dart.png)

Before we move forward, have you noticed that we are using a dependency injection providing the needed classes in the constructor? If you don’t know what I’m talking about, go ahead and read about what this is.

Last implementation step is in the view, so to use the “viewmodel.dart”, I’m using this Consumer widget, and inside it I’m using this when function because I know that I’ll receive a Future as an answer, and it’s going to be easier to walk through all the conditions exposed by default.

One thing to notice is that I’m triggering the call to update the UI on the initState function, because I want to execute it at the beginning of the view execution.

![ Figure.25 main_screen.dart ](/medium/2109/nodejs_flutter/figure.25_main_screen.dart.png)

And now, to test everything you just need to run both projects and you will have something like the image below.

![ Figure.26 to test everything ](/medium/2109/nodejs_flutter/figure.26_to_test_everything.png)

I hope that you understand that you don’t need to be locked on using a unique back-end solution to hold the information that is going to be used by your Flutter app, because the same way you can use Firebase for example you can also use Node.js, PHP, .NetCore, GO, Dart and so on… Because you will basically use a json to pass the information to each project via http protocol.

박수 108 토크 1

More from Thiago Evoá Follow
A simple Flutter dev learning everyday.

Aug 2, 2021
Basic roadmap to learn Flutter

Hello dev, start learning a new technology can be difficult if you don’t know how to start or where can you find good materials, and sometimes I still hear questions sort of, “Where can I find a good material to start learning Flutter?” or “Should I learn Dart first?”. …

Dart
3 min read

Basic roadmap to learn Flutter
Share your ideas with millions of readers.

Write on Medium
Jul 26, 2021

Structuring Flutter project by packages
Hello dev, these days I was wondering about having the best structure in my project in order to scale as much as I need and I came with a conclusion. Separate the code by feature is a good approach, however it’s not enough… So I found something interesting and I…

Dart
3 min read

Structuring Flutter project by packages
Jul 19, 2021

Does Flutter Version Management (FVM) worth?
Hello dev, sometimes you have to work in different Flutter projects and at the same time with different SDK versions, however change between the versions installed in your pc is not a simple process to deal every time. …

Dart
3 min read

Jul 12, 2021

Flutter Riverpod state management
Hello dev, this is one of the most complicated topic to talk in the Flutter world, because many people take it personal when it comes to state management solution. …

Dart
5 min read

Flutter Riverpod state management
Jul 5, 2021

Change Flutter app theme according to the system theme mode
Hello dev, now a days I guess every OS has the option to change the theme between light or dark but not every app follow this and some users complain about it. What do you think about implement such thing with out an extreme effort on you app? …

Dart
3 min read

Change Flutter app theme according to the system theme mode
Love podcasts or audiobooks? Learn on the go with our new app.

Try Knowable
Recommended from Medium
Yu Wang
Yu Wang

Build your own image hosting website using React/Spring Boot/Vsftpd on AWS EC2

Armen Galstyan
Armen Galstyan

Kotlin Data classes

Shashivardhan M
Shashivardhan M

Authenticate endpoints using a JSON web token (passport-jwt)
Matt Eland
Matt Eland

Monitoring Application Quality with Raygun

Michelle Lau
Michelle Lau

Using a Dictionary with a Medium Level LeetCode: Find the Duplicate Number

Callum Beckford
Callum Beckford

How to use React and Tone.js to make a simple web audio application
Modular Synth
Mario Vega
Mario Vega

in

ITNEXT

Escaping the Twilight Zone: Building Forms The Easy Way With Vue Components

Duy Nguyễn Phương
Duy Nguyễn Phương

MongoDB and Mongoose - Thực hiện update bằng cách Find, Edit và Save

