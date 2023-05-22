원본 제목: Dimuthu Wickramanayake Jun 6, 2021 Flutter series — Creating the first Flutter application
원본 링크: https://medium.com/nerd-for-tech/flutter-series-creating-the-first-flutter-application-793e5816f816
Path:
medium/flutter_diwi/101
Title:
101 Creating the first Flutter application
Short Description:
Dimuthu Wickramanayake 210606 첫 플러터 앱 만들기

![Figure 1.1 – vsCode main.dart](/flutter_diwi_img/101-01-vscode_main.dart.png)
![Figure 1.2 – chrome browser localhost:8000](/flutter_diwi_img/101-02-localhost_8000.png)
![Figure 1.3 – result hellow world](/flutter_diwi_img/101-03-hellow_world.png)
- cut line


Hi Guys. So in our tutorial series, we have created a spring boot application with an endpoint to get stock market data for a set of symbols. Now we are going to display those data in a watch list. This watch list will be created using Flutter. I’m not going to teach you basics of Flutter here. I’m simply guiding you to make an awesome app of your own. So here are the things you need.

- Microsoft Visual Studio Code (VS Code)

Using VS code IDE we are going to install flutter. For that, Navigate to extensions in VS code (or simply ctrl + shift + x). Now in the search bar search for Flutter and install it to VS code. Now go to the View in the menu bar and click on it. Now click on the command palette (or you can take it using ctrl + shift + a). In the search box type Flutter, now you will see there is a suggestion named “Flutter: New Application Project”. Click on that and give a name and create the project. Now VS code will download the necessary libraries and after a successful creation you will get a project like this.

![Figure 1.1 – vsCode main.dart](/flutter_diwi_img/101-01-vscode_main.dart.png)

So this main.dart file is the file which is loaded first. Now lets quickly run the application and then we will change the code to understand this. To run the code open a terminal in the VS code and type.

```
flutter run -d chrome --web-port 8000
```

Here i have specified the web port if not it will run in a random port. So now you will get a chrome browser like this.

![Figure 1.2 – chrome browser localhost:8000](/flutter_diwi_img/101-02-localhost_8000.png)

Its a simple application where it will display the number of times you press the plus button in the app. If we look at the code its really messy because so many classes are included in a single file. So in the first tutorial will make an app which print “Hello World” in the center of the app and lets try to maintain a pleasant code. Now i will remove most of the code and keep only these lines in the main.dart file.

```
import 'package:flutter/material.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
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

Now there is an obvious issue because we haven’t define the MyHomePage class. For that i will create another file named home_page.dart.

```
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        throw UnimplementedError();
    }

}
```

So here we have extended the StatelessWidget class so we have to implement the build method there. Now i will import this file to main.dart and our main.dart file would look like this.

```
import 'package:flutter/material.dart';
import 'package:stock_ui/home_page.dart';

void main() {
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
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

Now we can see that we are initializing the MyHomePage constructor with a parameter called title. So we have to add it to home_page.dart file. And now lets implement the build method in MyHomePage class. We need to add a text “Hello World” in the middle of the screen. For that i will be using a wrapper called center and add the Text inside it. Now our file would look like this.

```
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
    final title;

    MyHomePage({this.title});

    @override
    Widget build(BuildContext context) {
        return Center(
            child: Text(
                "Hello World"
            ),
        );
    }
}
```

Now run again using the command,

```
flutter run -d chrome --web-port 8000
```

Now you can see we get the result we needed.

![Figure 1.3 – result hellow world](/flutter_diwi_img/101-03-hellow_world.png)

Happy coding guys. In the next tutorial we will modify this project to create the ultimate market watch list app.
