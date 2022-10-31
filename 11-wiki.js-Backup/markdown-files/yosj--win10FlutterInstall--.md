windows 10 에서 Flutter 설치

참고: https://docs.flutter.dev/get-started/install/windows

# Git bash 설치

1. https://git-scm.com/download/win 에서 >> `Click here to download` 를 클릭 >> 파일을 내려받고, 바로 실행해서 설치한다.
1. 윈도우키 눌러서 >> “최근 추가한 앱" 에서 >> Git Bash 오른쪽버튼 클릭 >> `시작 화면에 고정` 클릭.
아니면, `자세히` >> `작업 표시줄에 고정` 클릭.
1. Git Bash 처음 시작하면 >> 글자가 작으므로 제목 라인에서 오른쪽 버튼 클릭 >> Options… 선택.

> Looks > Cursor > (*) Block >> 선택
> Text > Font [Select] >> 14pt 또는 16pt 선택
> Locale [ko_KR] character set [UTF-8] 선택

# 폰트 설치

1. Git Bash 에서 폰트파일을 받으려면,
```
cd Downloads #-- Windows인 경우
#-- cd /media/sf_Downloads #-- VirtualBox인 경우

#-- d2codingfont 폴더의 모든 파일 받기
git clone https://github.com/naver/d2codingfont
```

2. 브라우저에서 폰트파일을 받으려면, 다음과 같이 입력해서 `D2Coding-Ver1.3.2-20180524.zip` 파일을 받고 그자리에 압축을 푼다.
```
https://github.com/naver/d2codingfont/releases
```

3. 윈도우의 파일 탐색기에서, D2Coding 폴더의 파일을 모두 선택하고, 오른쪽 버튼 >> 선택 클릭 + 설치 클릭
4. 이제 d2codingfont 폴더는 필요 없으므로 삭제한다.
5. Git Bash 를 실행하고, 제목 라인에서 오른쪽 버튼 클릭 >> Options… 선택해서, 폰트를 지정한다.

```
Text > Font [Select] D2coding 선택
```

# flutter 설치

1. Git Bash 에서 flutter설치 파일을 받으려면, Git Bash 로 들어가서, 다음과 같이 실행한다.
```
git clone https://github.com/flutter/flutter.git
```

2. 브라우저에서 flutter설치 파일을 받으려면, 
  - https://docs.flutter.dev/get-started/install/windows#get-the-flutter-sdk
  - flutter설치 파일을 받은 다음, `C:\Users\user` 폴더로 옮기고, 그곳에 압축을 푼다.

3. 환경변수 지정하기
- 윈도우 돋보기 ( [+]`S` ) >> `env` 엔터.
- `환경 변수` 창에서,
  - `User 에 대한 사용자 변수 (U)` 아래의 `변수` 중에서
  - `Path` 클릭하고 `[편집(E)]` 클릭.
    - 또는, `Path` 를 더블-클릭.
  - `환경 변수 편집` 창에서, `[새로만들기]` 클릭
  - `%USERPROFILE%\flutter\bin` 입력하고 >> `[확인]` >> `[확인]`
  - Git Bash 터미널을 닫았다가 다시 열고, 다음을 확인한다.
```
where flutter dart #--- flutter 와 dart 가 같은 bin 폴더에 있어야 한다.
flutter --version #--- 버전 확인
flutter doctor #--- 설정을 완료하는 데 필요한 플랫폼 종속성이 있는지 확인.
```

# Android Studio 설치

1. https://developer.android.com >> Download >> Android Studio >> Android 스튜디오 다운로드
1. Download Android Studio >> Next, Next, ... Installing, Installation Complete, Next, (v) Start Android Studio `[Finish]` 설치완료
1. Android Studio 다시 시작후 >> (o) Do not import settings `[ok]` >> Finding aviailable ... Data Sharing `[Dont send]` >> Welcome `[Next]` >> Install Type > (o) Standard `[Next]` >> Select UI Theme `[Next]` >> Verify Settings `[Next]` >> License Agreement > Licenses v제목 마다 (o) Accept 체크하고 `[Finish]` 클릭 >> `[Finish]` 클릭 >> Donwloading Components >> 끝나면 `[Finish]` 클릭
1. 새로 시작하면, `More Actions v` 을 클릭 >> `SDK Manager` 를 클릭 >> 왼쪽 메뉴에서 `System Settings` >> Android SDK >> 오른쪽 탭에서 `[SDK Tools]` >> Android SDK Command-line Tools 체크 >> `[OK]` >> Confirm Change `[OK]`
```
flutter doctor --android-licenses
```
1. 왼쪽 메뉴에서 `Plugins` >> `flutter` 찾기 >> Flutter `Install` 클릭 >> Third-Party Plugins Privacy Note `Accept` 클릭 >> requires "Dart" plugin `Install` 클릭 >> restart IDE `restart` 클릭 (Dart도 같이 설치)

# Android Studio 사용법

1. File >> Settings >> Appearance >> [v] Use custom font: [D2Coding] + [16]
1. File >> Settings >> Editor >> Font >> Font: [D2Coding] Size: [16]
1. File >> Project Structure >> 왼쪽 Module 클릭 >> 중간 Sources 트리에서 >> 만들고 싶은 폴더에서 우클릭 >> New Folder: 이름지정
1. 폴더이름 변경 >> `Shift + F6`

