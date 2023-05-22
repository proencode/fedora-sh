원본 링크: https://subscription.packtpub.com/book/virtualization-and-cloud/9781789538830/pref
Path:
packtpub/bashQuickStartGuide/100
Title:
100 Preface
Short Description:
Bash Quick Start Guide 머리말
작성: 2022-05-31 화 17:41:44

@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/rrqeEWQRQewreq^[
    마크다운 입력시 vi 커맨드 표시 ; (^{)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------


원본 링크: https://medium.com/@NALSengineering/flutter-from-zero-to-hero-part-1-build-your-first-project-88936b59dc7b
원본 링크: https://medium.com/@NALSengineering/flutter-from-zero-to-hero-part-1-build-your-first-project-88936b59dc7b

Path:
길:

medium/FlutterFromZerotoHero/100
중간/flutterfromzerotohero/100

Title:
제목:

101 Introduction to Widgets
101 위젯 소개

Short Description:
간단한 설명:

medium/FlutterFromZerotoHero NALSengineering Apr 12 2022
중간/flutterfromzerotohero nalsengineering 4 월 1222 년
















Flutter From Zero to Hero.
0에서 영웅으로 플러터.

![ Figure1.1 Flutter From Zero to Hero LOGO ](/flutter-zero-to-hero/figure1.1_flutter_from_zero_to_hero_logo.png)
! [그림 1.1 0에서 영웅 로고로 플러터] (/flutter-Zero-to-hero/figure1.1_flutter_from_zero_to_hero_logo.png)




# 101 Introduction to Widgets
# 101 위젯 소개

NALSengineering Apr 12 2022 Nguyễn Thành Minh (Android Developer)
Nalsengineering 4 월 12 일 2022 년 Nguyen Thanh Minh (Android 개발자)




## Introduction
## 소개




Compared to Android(Kotlin) or iOS(Swift), Flutter is much easier to learn and use, it is also suitable for those who have little to no experience in programming. If you are new to programming and find yourself interested in mobile app development, Flutter would be a great place to start. I hope you’ll learn something useful from this series.
Android (Kotlin) 또는 iOS (SWIFT)와 비교할 때 Flutter는 배우고 사용하기가 훨씬 쉽습니다. 프로그래밍 경험이 거의 없거나 전혀없는 사람들에게도 적합합니다.프로그래밍을 처음 접하고 모바일 앱 개발에 관심이 있다면 Flutter는 시작하기에 좋은 곳이 될 것입니다.이 시리즈에서 유용한 것을 배우기를 바랍니다.




## Creating a new Flutter Project
## 새로운 플러터 프로젝트 만들기




I won’t dive deep into this section since there are already a lot of tutorials for it. In general, you’ll go through 4 main steps:
이미 많은 튜토리얼이 있기 때문에이 섹션에 깊이 빠져들지 않을 것입니다.일반적으로 4 가지 주요 단계를 거치게됩니다.




1. Download and install one of the following IDEs: Android Studio or VSCode. I am using Android Studio for this series.
1. Android Studio 또는 VSCODE의 다음 IDE 중 하나를 다운로드하여 설치하십시오.이 시리즈에 Android Studio를 사용하고 있습니다.

2. Install Flutter. https://docs.flutter.dev/get-started/install
2. 플러터를 설치하십시오.https://docs.flutter.dev/get-started/install

3. Install Flutter and Dart plugins. https://docs.flutter.dev/get-started/editor#:~:text=Install%20the%20Flutter%20and%20Dart%20plugins
3. 플러터 및 다트 플러그인을 설치하십시오.https://docs.flutter.dev/get-started/editor#:~:text=install%20the%20flutter%20and%20dart%20plugins

4. Creating a new project https://docs.flutter.dev/development/tools/android-studio#creating-a-new-project
4. 새로운 프로젝트 만들기 https://docs.flutter.dev/development/tools/android-studio#creating-a-new-project




When you’ve successfully created a new project, it should look like this.
새로운 프로젝트를 성공적으로 만들었을 때는 다음과 같습니다.




## Exploring the project
## 프로젝트 탐색




![ Figure1.2 Flutter project structure ](/flutter-zero-to-hero/figure1.2_flutter_project_structure.png)
! [그림 1.2 플러터 프로젝트 구조] (/Flutter-Zero-hero/그림 1.2_flutter_project_structure.png)




This is how a Flutter project is structured.
이것이 플러터 프로젝트가 구성되는 방식입니다.




1. The most important folder is named “lib” in which Flutter has already created a file named “main.dart”. This is also where we’ll create “.dart” files and write our code.
1. 가장 중요한 폴더는 "lib"로 이름이 붙어 있는데, Flutter는 이미 "main.dart"라는 파일을 만들었습니다.또한“.dart”파일을 작성하고 코드를 작성하는 곳이기도합니다.

2. There are two more folders named “android” and “ios”. They are the source folders of their respective platforms, Android and iOS. Most of the time, you won’t be touching them at all. However, when there are features that Flutter does not support, you’ll need to work around it by writing ‘native code’ in these folders. Does that mean you’ll have to learn Java/Kotlin or Objective-C/Swift? Not really. Most features are already supported by Flutter, and even for those that aren’t, you can always check on the “pub.dev” library repository.
2. "Android"와 "iOS"라는 폴더가 두 개 더 있습니다.이들은 각 플랫폼, Android 및 iOS의 소스 폴더입니다.대부분의 경우, 당신은 그들을 전혀 만지지 않을 것입니다.그러나 Flutter가 지원하지 않는 기능이 있으면이 폴더에 '기본 코드'를 작성하여 작업해야합니다.그것은 당신이 Java/Kotlin 또는 Objective-C/Swift를 배워야한다는 것을 의미합니까?설마.대부분의 기능은 이미 Flutter에서 지원되며, 그렇지 않은 기능을 위해서도 항상 "Pub.dev"라이브러리 저장소를 확인할 수 있습니다.

3. “Pubspec.yaml”: This is where you give the project a name, a description, and list out the libraries that you’ll use along with assets such as icons, images, or fonts also used within the project.
3.“pubspec.yaml”: 프로젝트에 이름, 설명을 제공하고 프로젝트 내에서 사용하는 아이콘, 이미지 또는 글꼴과 같은 자산과 함께 사용할 라이브러리를 나열하는 곳입니다.

4. We will go through the other files later.
4. 나중에 다른 파일을 살펴 보겠습니다.




In short, we only need to focus on “lib”, “ios”, “android”, “pubspec.yaml”. For today, we’re only focusing on the folder “lib” and the file “main.dart”.
요컨대, 우리는 "lib", "ios", "android", "pubspec.yaml"에만 집중하면됩니다.오늘날 우리는 폴더 "lib"와 "main.dart"파일에만 초점을 맞추고 있습니다.




## Going through each line of code
## 각 코드 줄을 통과합니다




Let’s have a look at file “main.dart” inside folder “lib”. Hmm, it seems like a lot of code. Don’t fret. Delete all that code, as we’ll begin with a much simpler example. Complete the following 4 steps:
"main.dart"내부 폴더 "lib"파일을 살펴 보겠습니다.흠, 많은 코드처럼 보입니다.걱정하지 마십시오.훨씬 간단한 예로 시작하므로 모든 코드를 삭제하십시오.다음 4 단계를 완료하십시오.




```
```

// Step 1
// 1 단계

import 'package:flutter/material.dart';
가져 오기 '패키지 : Flutter/Reaserent.dart';

// Step 2
// 2 단계

void main() {
void main () {

  // Step 3
// 3 단계

  runApp(
runapp (

    MaterialApp(
재료 (

      // Step 4
// 4 단계

      home: Text('Hello Flutter!'),
홈 : Text ( 'Hello Flutter!'),

    ),
),,

  );
);

}
}

```
```




Now I’ll explain the 4 steps:
이제 4 단계를 설명하겠습니다.




Step 1: Import the library flutter/material.dart. This library provides access to the classes Text, MaterialAppand the function runApp. It has more things to offer but we’ll talk about that later on.
1 단계 : 라이브러리 플러터/재료를 가져옵니다.이 라이브러리는 클래스 텍스트에 대한 액세스를 제공합니다.더 많은 것을 제공 할 것이 있지만 나중에 그것에 대해 이야기 할 것입니다.




Step 2: Declare the main function, this is where the code will be executed first.
2 단계 : 기본 기능을 선언하면 코드가 먼저 실행되는 곳입니다.




Step 3: Call the runApp function where a MaterialApp object is passed as an argument. This will help us run the app on the device.
3 단계 : MaterialApp 객체가 인수로 전달되는 경우 runapp 함수를 호출하십시오.이것은 장치에서 앱을 실행하는 데 도움이됩니다.




Step 4: Create a new object Text and pass it as the property home for the object MaterialApp.
4 단계 : 새 객체 텍스트를 만들고 객체 자료의 속성 홈으로 전달하십시오.




MaterialApp and Text are called Widgets. Widgets are crucial to learning because they will help you conquer Flutter. As you dive deeper into Flutter, you’ll see that Widgets are everywhere. As the saying goes, “In Flutter, Everything is Widgets.”
MaterialApp과 텍스트를 위젯이라고합니다.위젯은 플러터를 정복하는 데 도움이되기 때문에 학습에 중요합니다.더 깊이 펄럭이는 위젯이 어디에나 있음을 알 수 있습니다.“플러터에서는 모든 것이 위젯입니다.”




## What is a Widget?
## 위젯이란 무엇입니까?




Basically, Widgets are Dart classes. They could be a piece of text on the screen, an icon, a button, or a text input. They are not simply a view like Text, Icon, or a group of views (GroupView) but they can be a class to help show/hide views and align views in a GroupView. Even the app itself is a widget (MaterialApp). We continue to explore a few more Widgets to understand them better.
기본적으로 위젯은 다트 클래스입니다.화면의 텍스트, 아이콘, 버튼 또는 텍스트 입력이 될 수 있습니다.그것들은 단순히 텍스트, 아이콘 또는보기 그룹 (GroupView)과 같은보기가 아니라 GroupView에서보기를 보여주고 숨기는 데 도움이되는 클래스가 될 수 있습니다.앱 자체조차도 위젯 (MaterialApp)입니다.우리는 그것들을 더 잘 이해하기 위해 몇 가지 더 많은 위젯을 계속 탐색하고 있습니다.




So, let’s try running the project we have just created. Here’s what we get.
방금 만든 프로젝트를 실행해 보겠습니다.우리가 얻는 것이 있습니다.




![ Figure1.3 just created ](/flutter-zero-to-hero//figure1.3_just_created.png)
!!




Hmm, it looks quite terrible. That’s because we didn’t use the widget called Scaffold. That being said, we should insert a Scaffold right after MaterialApp and then finally Text.
흠, 그것은 꽤 끔찍해 보인다.스캐 폴드라는 위젯을 사용하지 않았기 때문입니다.즉, 우리는 MaterialApp 직후에 발판을 삽입 한 다음 마지막으로 텍스트를 삽입해야합니다.




To quickly create a Widget that will wrap the widget Text, we move the cursor to the widget Text and click on the Light bulb icon and this dialog should appear:
위젯 텍스트를 감싸는 위젯을 신속하게 만들려면 커서를 위젯 텍스트로 이동하고 전구 아이콘을 클릭하면이 대화 상자가 나타납니다.







Wrap with Widget
위젯으로 감싸십시오

Choose the option: “Wrap with widget” and hit ‘Enter’. Then enter ‘Scaffold’ and hit ‘Tab’. Finally, replace the property child with body since there is no child property in the constructor of Scaffold. When you’re done, it should look like this:
옵션을 선택하십시오 : "위젯으로 랩"하고‘Enter’를 누르십시오.그런 다음‘스캐 폴드’를 입력하고‘탭’을 누르십시오.마지막으로, 스캐 폴드 생성자에 자식 속성이 없기 때문에 속성 자식을 신체로 교체하십시오.완료되면 다음과 같아야합니다.




runApp(
runapp (

  MaterialApp(
재료 (

    home: Scaffold(
홈 : 스캐 폴드 (

      body: Text('Hello Flutter!'),
바디 : Text ( 'Hello Flutter!'),

    ),
),,

  ),
),,

);
);

Let’s run it again:
다시 실행합시다 :







Scaffold — Text
스캐 폴드 - 텍스트

Hmm, still rather awful. The reason is because Scaffold took the whole screen as its area, including the status bar. If we want the text to display below the status bar, we need to wrap the widget Text with another widget called SafeArea:
흠, 여전히 다소 끔찍합니다.그 이유는 스캐 폴드가 상태 표시 줄을 포함하여 전체 화면을 영역으로 가져 갔기 때문입니다.텍스트가 상태 표시 줄 아래에 표시되도록하려면 위젯 텍스트를 SafeArea라는 다른 위젯으로 래핑해야합니다.




runApp(
runapp (

  MaterialApp(
재료 (

    home: Scaffold(
홈 : 스캐 폴드 (

      body: SafeArea(
바디 : SafeArea (

        child: Text('Hello Flutter!'),
어린이 : Text ( 'Hello Flutter!'),

      ),
),,

    ),
),,

  ),
),,

);
);

Let’s run it again.
다시 실행합시다.







Scaffold — SafeArea — Text
스캐 폴드 - Safearea - 텍스트

Fixed it. But what if we wanted the text to align in the center? We could again wrap the widget Text with another widget called Center.
고쳤다.그러나 텍스트가 중앙에 정렬되기를 원한다면 어떻게해야합니까?위젯 텍스트를 중앙이라는 다른 위젯으로 다시 감싸 수있었습니다.




runApp(
runapp (

  MaterialApp(
재료 (

    home: Scaffold(
홈 : 스캐 폴드 (

      body: SafeArea(
바디 : SafeArea (

        child: Center(
어린이 : 센터 (

          child: Text('Hello Flutter!'),
어린이 : Text ( 'Hello Flutter!'),

        ),
),,

      ),
),,

    ),
),,

  ),
),,

);
);

Let’s run it again.
다시 실행합시다.







Scaffold — SafeArea — Center — Text
스캐 폴드 - Safearea - 센터 - 텍스트

A simple example that utilizes 5 widgets: MaterialApp, Scaffold, SafeArea, Center, Text. That is how a User Interface (UI) is created in Flutter.
MaterialApp, Scaffold, SafeArea, Center, Text의 5 가지 위젯을 사용하는 간단한 예.이것이 Flutter에서 사용자 인터페이스 (UI)가 생성되는 방식입니다.




As you can see, widgets are used even for simple tasks like aligning items (widget Center). Just as the saying goes (again):
보시다시피, 위젯은 항목 정렬 (위젯 센터)과 같은 간단한 작업에도 사용됩니다.(다시) 말하는 것처럼 :




Flutter: Everything is Widgets.
플러터 : 모든 것이 위젯입니다.




To conclude, if you want to conquer Flutter, it’s a good idea to learn as many widgets as you can, as well as their important properties such as ‘child’ or ‘color’. You can pretty much create any UIs you want from all of these.
결론적으로, 플러터를 정복하려면 '자식'또는 '색상'과 같은 중요한 속성뿐만 아니라 가능한 한 많은 위젯을 배우는 것이 좋습니다.이 모든 것들로부터 원하는 UI를 거의 만들 수 있습니다.




Widgets are vast in quantity and they are all fully documented by Google at here.
위젯은 수량이 크며 모두 Google에서 완전히 문서화되어 있습니다.




We can divide them into 5 main groups:
우리는 그것들을 5 개의 주요 그룹으로 나눌 수 있습니다.




Value Widgets: they are used to display a kind of data, it could be local data, from the Internet, or inputted by the user. Some notable ones are Text, TextField, Icon, Image, TextButton, etc.
값 위젯 : 일종의 데이터를 표시하는 데 사용되거나 인터넷에서 로컬 데이터 일 수 있거나 사용자가 입력 할 수 있습니다.주목할만한 것은 텍스트, 텍스트 필드, 아이콘, 이미지, TextButton 등입니다.

Layout Widgets: they are used to align and arrange Value Widgets in a layout. For example: Row, Column, Align, Center, etc.
레이아웃 위젯 : 레이아웃에서 값 위젯을 정렬하고 정렬하는 데 사용됩니다.예 : 행, 열, 정렬, 중앙 등

Animation Widgets: they are used to create animations for your app. For example: Hero, SlideTransition, AnimatedContainer, etc.
애니메이션 위젯 : 앱의 애니메이션을 만드는 데 사용됩니다.예를 들어 : 영웅, 슬라이드 트랜 시션, 애니메이션 콘티너 등.

Navigation Widgets: they are used for navigation within the app, such as: BottomNavigationBar, TabBar, AlertDialog, etc.
내비게이션 위젯 : 바닥재 바, tabbar, AlertDialog 등과 같은 앱 내 탐색에 사용됩니다.

Interaction Widgets: they are used to simulate interactions with View, such as: Dismissible, Draggable, GestureDetector, etc.
상호 작용 위젯 : 다음과 같은 시야와의 상호 작용을 시뮬레이션하는 데 사용됩니다.

This is by no means a comprehensive list of widgets. If you are interested, you may learn more about the series Widget of the Week
이것은 결코 포괄적 인 위젯 목록이 아닙니다.관심이 있으시면 이번주의 시리즈 위젯에 대해 더 많이 배울 수 있습니다.




Conclusion
결론




In this part of the series, I’ve intentionally left out some terms that may confuse beginners. They are Key, BuildContext, build method, StatelessWidget, StatefulWidget, State. So what exactly are they? I’ll talk about them in the next part of the series.
이 시리즈 의이 부분에서 나는 의도적으로 초보자를 혼동 할 수있는 몇 가지 용어를 제외했습니다.핵심, BuildContext, Build Method, Statelesswidget, Statefulwidget, State입니다.그래서 그들은 정확히 무엇입니까?시리즈의 다음 부분에서 그들에 대해 이야기하겠습니다.

