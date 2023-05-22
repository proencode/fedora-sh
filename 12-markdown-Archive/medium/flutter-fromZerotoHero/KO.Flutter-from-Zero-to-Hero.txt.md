원본 링크: https://medium.com/@NALSengineering/flutter-from-zero-to-hero-part-1-build-your-first-project-88936b59dc7b
Path:
medium/FlutterFromZerotoHero/100
Title:
101 Introduction to Widgets
Short Description:
FlutterFromZerotoHero NALSengineering Apr 12 2022
작성: 2022-05-31 화 15:53:33

@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/rrqeEWQRQewreq^[
    마크다운 입력시 vi 커맨드 표시 ; (^{)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

Flutter From Zero to Hero.

101 Introduction to Widgets 위젯 소개
NALSengineering Apr 12 2022 Nguyễn Thành Minh (Android Developer)

# Introduction

Compared to Android(Kotlin) or iOS(Swift), Flutter is much easier to learn and use, it is also suitable for those who have little to no experience in programming.
Android (Kotlin) 또는 iOS (SWIFT)와 비교할 때 Flutter는 배우고 사용하기가 훨씬 쉽습니다. 프로그래밍 경험이 거의 없거나 전혀없는 사람들에게도 적합합니다.
If you are new to programming and find yourself interested in mobile app development, Flutter would be a great place to start.
프로그래밍을 처음 접하고 모바일 앱 개발에 관심이 있다면 Flutter는 시작하기에 좋은 곳이 될 것입니다.
I hope you’ll learn something useful from this series.
이 시리즈에서 유용한 것을 배우기를 바랍니다.

# Creating a new Flutter Project

I won’t dive deep into this section since there are already a lot of tutorials for it.
이미 많은 튜토리얼이 있기 때문에이 섹션에 깊이 빠져들지 않을 것입니다.
In general, you’ll go through 4 main steps:
일반적으로 4 가지 주요 단계를 거치게됩니다.

1. Download and install one of the following IDEs: Android Studio or VSCode.
   Android Studio 또는 VSCODE의 다음 IDE 중 하나를 다운로드하여 설치하십시오.
   I am using Android Studio for this series.
   이 시리즈에 Android Studio를 사용하고 있습니다.
2. Install Flutter.
   플러터를 설치하십시오.
3. Install Flutter and Dart plugins.
   플러터 및 다트 플러그인을 설치하십시오.
4. Creating a new project
   새로운 프로젝트 만들기

When you’ve successfully created a new project, it should look like this.
새로운 프로젝트를 성공적으로 만들었을 때는 다음과 같습니다.

Exploring the project
프로젝트 탐색


Flutter project structure
플러터 프로젝트 구조
This is how a Flutter project is structured.
이것이 플러터 프로젝트가 구성되는 방식입니다.

???줄을 잃어버림
???줄을 잃어버림
???줄을 잃어버림
값 위젯 : 일종의 데이터를 표시하는 데 사용되거나 인터넷에서 로컬 데이터 일 수 있거나 사용자가 입력 할 수 있습니다.
Some notable ones are Text, TextField, Icon, Image, TextButton, etc.
주목할만한 것은 텍스트, 텍스트 필드, 아이콘, 이미지, TextButton 등입니다.
Layout Widgets: they are used to align and arrange Value Widgets in a layout.
레이아웃 위젯 : 레이아웃에서 값 위젯을 정렬하고 정렬하는 데 사용됩니다.
For example: Row, Column, Align, Center, etc.
예 : 행, 열, 정렬, 중앙 등
Animation Widgets: they are used to create animations for your app.
애니메이션 위젯 : 앱의 애니메이션을 만드는 데 사용됩니다.
For example: Hero, SlideTransition, AnimatedContainer, etc.
예를 들어 : 영웅, 슬라이드 트랜 시션, 애니메이션 콘티너 등.
Navigation Widgets: they are used for navigation within the app, such as: BottomNavigationBar, TabBar, AlertDialog, etc.
내비게이션 위젯 : 바닥재 바, tabbar, AlertDialog 등과 같은 앱 내 탐색에 사용됩니다.
Interaction Widgets: they are used to simulate interactions with View, such as: Dismissible, Draggable, GestureDetector, etc.
상호 작용 위젯 : 다음과 같은 시야와의 상호 작용을 시뮬레이션하는 데 사용됩니다.
This is by no means a comprehensive list of widgets.
이것은 결코 포괄적 인 위젯 목록이 아닙니다.
If you are interested, you may learn more about the series Widget of the Week
관심이 있으시면 이번주의 시리즈 위젯에 대해 더 많이 배울 수 있습니다.

Conclusion
결론

In this part of the series, I’ve intentionally left out some terms that may confuse beginners.
이 시리즈 의이 부분에서 나는 의도적으로 초보자를 혼동 할 수있는 몇 가지 용어를 제외했습니다.
They are Key, BuildContext, build method, StatelessWidget, StatefulWidget, State.
핵심, BuildContext, Build Method, Statelesswidget, Statefulwidget, State입니다.
So what exactly are they? I’ll talk about them in the next part of the series.
그래서 그들은 정확히 무엇입니까?시리즈의 다음 부분에서 그들에 대해 이야기하겠습니다.
