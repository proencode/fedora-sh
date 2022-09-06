# 차례

| 101 |1. 플러터 시작 |2. 다트 |3. 내부구조 |
|:---:|:---|:---|:---|
| 핵심기능 |4. 위젯 사용법 |5. 탭바, 리스트 |6. iOS 스타일 |
|  |7. 네트워크 통신 |8. 내비게이션 |  |
| 고급기능 |9. 내부 저장소 |10. 데이터베이스 |11. 애니메이션 |
|  |12. 네이티브 API |13. 파이어베이스 |  |
| 출시 |14. 오픈 API |15. 여행정보앱 |  |

### 소스 파일
1. 이지스퍼블리싱 홈페이지: http://www.easyspub.co.kr/Main/PUB
2. 저자 깃허브: https://github.com/rollcake86/DoitFlutter2.0

# 1. 플러터 15p

## 플러터 소개

### 배경

| 출시년도 | 업체명 | 폰이름 | 판매처 | 프로그램 언어 | 앱의 종류 |
|:---:|:---:|:---:|:---:|:---:|:---:|
| 2007 | 애플 | 아이폰 | 앱스토어 | Objective-C | 아이폰 앱 |
| 2008 | 구글 | 안드로이드폰 | 안드로이드 마켓<br>2012 구글 플레이로 변경 | java | 안드로이드 앱 |

### 주목 이유 19p

- 높은 개발효율, 유연한 사용자 인터페이스, 빠른 속도 [Apple iOS 앱 개발 언어 Swift](https://m.blog.naver.com/jdusans/222080069092)

| 업체명 | 앱 개발 언어 | 현재의 네이티브 앱 개발 언어 |
|:---:|:---:|:---:|
| 애플 | 1984 Objective-C | 2014 Swift |
| 구글 | 1995 java | 2016 Kotlin |


### 개발환경 22p

- 윈도우10 + 안드로이드 앱

## 실습1-1: 안드로이드 스튜디오 설치 22p

1. https://developer.android.com/studio >> **Download Android Studio** 클릭 >>
  **[v] I have read...** 약관 동의히고, 
  **(Download Android Studio Bumblebee 2021.1.1patch3)** 오른쪽 버튼으로 '완료되면 열기' 체크, 내려받기
  a. 설치파일 실행.
  b. Welcome to Android Studio Setup **Next**
  c. Choose Components **Next**
  d. Configuration Settings **Next**
  e. Choose Start Menu Folder **Install**
  f. Installing >> Installation Complete **Next**
  g. Completing Android Studio Setup [v] Start Android Studio **Finish**
1. Import Android Studio Settings  >> (o) Do not import settings **OK**
  a. Data Sharing 필요 없으므로 **Dont Send**
  b. Welcome **Next**
  c. Install Type (o) Standard **Next**
  d. Select UI Theme (o) Darcula **Next**
  e. Verify Settings **Next**
  f. License Agreement 각 주제별 (Intel-andr... android-sdk... android-sdk...) 클릭하고 (o) Accept 한 다음 **Finish** 버튼 활성화 되면 클릭.
  g. Downloading Components 끝나고 **Finish** 버튼 활성화 되면 클릭.
  새로 부팅됨.
1. 설치가 끝나면, 윈도우 키를 눌러서 > “최근 추가한 앱" 에서 > Android Studio 오른쪽 마우스 바튼 클릭 > 시작 표시줄에 고정 클릭

## 실습1-2: 플러터 SDK 설치 25p

### 1. 플러터 SDK 다운로드

#### (1-A) Windows 에서 다운로드 (또는)
1. https://flutter.dev/docs/get-started/install >> [Windows] 선택
1. **Get the Flutter SDK** 에서 압축파일 내려받는 버튼 클릭
1. 내려받은 압축파일을 사용자의 홈 폴더 (C\Users\user\) 에 압축해제
1. 다음 명령으로 플러터 SDK 의 bin 폴더 (C:\Users\%username%\flutter\) 로 가서, 플러터 개발환경을 확인.
```
cd ~/flutter/bin
./flutter doctor
```

#### (1-B) Git-Bash (설치후) 다운로드 [추가]

#### (1-B)-1. Git-Bash 설치

1. https://git-scm.com/download/win 에서 **Click here to download** 를 클릭해서 다운로드하고, 바로 실행.
1. 설치가 끝나면, 윈도우 키를 눌러서 > “최근 추가한 앱" 에서 > Git Bash 오른쪽 마우스 클릭 > 자세히 > 작업 표시줄에 고정 클릭
1. 글자가 작으므로, 제목 라인에서 > 오른쪽 마우스 클릭 > Options… 선택
Looks > Cursor > (o) Block
Text > Font [Select] D2coding 16pt
Locale [ko_KR] character set [UTF-8]

#### (1-B)-2. 폰트 설치

1-a. https://github.com/naver/d2codingfont/releases >> D2Coding-**Ver1.3.2-20180524**.zip >> 받아서 압축을 푼다. (또는)

1-b. 나눔폰트나 제주, 서울폰트를 추가로 쓰기 위해서, 폰트를 압축한 파일을 Git-Bash 안에서 다음과 같이 다운받아도 된다.
```
scp -P 888 user@proen.duckdns.org:888/Font*z .
```
2. 윈도우의 파일 탐색기 >> D2Coding 폴더의 파일 모두 선택 후 오른쪽 마우스 버튼 클릭 >> 선택 클릭 + 설치 클릭

#### (1-B)-3. git 명령으로 flutter 다운로드

```
cd ~/
git clone https://github.com/flutter/flutter.git -b stable
```

### 2. Windows 에서 플러터 SDK 환경변수 지정하기

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

## 실습1-3: (플러터와 다트) 플러그인 설치 27p

안드로이드 스튜디오 설치완료 >> 플러터 SDK 설치완료 >> 다음작업

1. 안드로이드 스튜디오 실행 >> 왼쪽 메뉴에서 **[Plugins]** 클릭.
  메뉴에서는 [**F**ile >> **S**etting >> **P**lugins]
1. 츨러그인 창에서 검색창에 'flutter' 검색 >> 플러터 플러그인에서 **[Install]** 클릭.
1. 다트 플러그인이 필요하다는 창이 나오면 같이 [Install] 클릭.
1. 설치후 플러그인 창에 [Restart IDE] 클릭해서 재실행.

## 프로젝트 시작 29p

첫번째 플러터 프로젝트 시작.

## 실습1-4: 플러터 프로젝트 만들기 29p

1. 안드로이드 스튜디오 >> **New Flutter Project** 선택
  Flutter App **Next** >> Flutter SDK Path: C:\Users\ 사용자 아이디 \ flutter **OK** >> **Next**
1. Name: **My Application** >> **Finish** 클릭
1. 잠시후 프로젝트 생성 완료.

## 실습1-5: 안드로이드 에뮬레이터로 앱 실행 30p

에뮬레이터 사용과 스마트폰을 USB 케이블로 연결해서 직접 사용.

1. 안드로이드 스튜디오 오른쪽 위 `Device Manager` 클릭
  새로운 장치 생성위해, 중앙의 'Create Virtual Device' 클릭.
1. Select Hardware >> Choose a device definition > 
  Phone 선택.
  오른쪽 목록에서 기종 (Pixel 3)...(Pixel 4 XL) 선택.
  [Next] 클릭.
1. AVD 에 설치할 시스템 이미지 = 안드로이드 SDK 버전 (R) 선택해서 다운로드 한뒤 설치 >> [Next] 클릭
1. AVD 최종설정 확인후 [Finish] 클릭.
1. AVD 관리자에서 Action 에 있는 실행버튼 클릭 >> 에뮬레이터 실행.
1. 안드로이드 스튜디오에서 >> 앱을 실행할 장치를 선택하는 곳이 `no devices` 라고 나오면
  이 단추 클릭 >> 에뮬레이터 또는 실제 스마트폰 선택 >> Pixel 3 API 선택

장치 선택후 녹색 실행버튼 클릭 >> 플러터 데모 앱 실행.

## 실습1-6: 실제 스마트폰에서 앱 실행하기 35p

개발한 앱을 실제 스마트폰에서 실행

1. 안드로이드 스마트폰 준비


# 2. 다트 37p

## 다트의 특징

1. **main()** 함수로 시작한다.
1. 변수 선언 어디에서나 가능하다.
1. 모든 변수가 객체다.
1. 자료형이 엄격하다.
1. 제네릭 타입을 쓴다.
1. public, protected 키워드가 없다. 노출 안하려면 변수, 함수 이름앞에 “_” 표시한다.
1. 변수, 함수 이름은 _ 또는 문자열로 시작하고, 그 뒤에라야 숫자를 넣을 수 있다.
1. 삼항 연산자를 쓸 수 있다.
1. Null Safety 를 지원한다.

### 간단한 코드 39p

```
// printSutza 라는 이름의 함수를 정의한다.
printSutza(Int aNumber) {
	print("The number is $aNumber."); // 콘솔에 출력한다.
}

// 메인 함수에서 시작한다.
main() {
	var numb = 42; // 동적인 타입의 변수를 지정한다.
  printSutza(numb); // 저 함수를 부른다.
}
```

실행한 결과.
```
The number is 42.
```

- 다트가 제공하는 주요 자료형
| 구분 | 자료형 | 설명 |
|:---:|:---:|:---|
| 숫자 | int | 정수형 숫자 (소숫점이 없는것) |
| | double | 싱수형 숫자 (3.14 -12.25 등 소숫점 부호 등이 있는것)
| | num | 정수형 또는 실수형 숫자 |
| 문자열 | String | 텍스트 기반 문자 |
| 부울리언 | bool | True, False |
| 자료형 추론 | var | 입력한 값에 따라 자료형이 결정되고, 한번 결정한 자료형은 변경되지 않는다 |
| | dynamic | 입력한 값에 따라 자료형이 결정되는데, 다른형의 값을 넣으면 그 자료형으로 바뀐다 |

### Null Safety 40p

pubspec.yaml 파일에서 SDK 의 환경을 2.12.0 버전 이상으로 지정해줘야 한다.

```
environment:
	sdk: ">=2.12.0 <3.0.0"
```

자료형의 뒤에 `?` 를 붙이면, 그 변수에 Null 을 담을 수 있고, 이게 없으면 Null 을 담을 수 없다.

```
int? couldReturnNullButDoesnt() => -3; // Null 을 담을수도 있는 변수를 선언했다.

void main() {
	int couldBeNullButIsnt = 1; // Null 담을수 있는 변수 선언
  List<int?> listThatCouldHoldNulls = [2, null, 4]; // List 의 int 에 null 을 넣을수 있게 선언한것.
  List<int>? nullsList; // List 자체가 Null 일수 있도록 변수 선언.
  int a = couldBeNullButIsnt; // Null 이 들어있다면 a 변수에 오류가 생긴다.
  int b = listThatCouldHoldNulls.first; // b 에는 ? 가 없어서 오류.
  int b = listThatCouldHoldNulls.first!; // Null 이 아님을 ! 로 직접 표시함.
  int c = couldReturnNullButDoesnt().abs(); // Null 일수도 있으므로 abs() 에서 오류.
  int c = couldReturnNullButDoesnt().abs()!; // Null 이 아님을 ! 로 직접 표시함.

print('a is $a.')
print('b is $b.')
print('c is $c.')
```

프로그램이 실행중일때 Null 예외가 발생하면 프로그램 자체가 중단됨.
프로그램 실행전 컴파일 단계에서 Null 예외 발생하는지 체크하기 위한것.

### 다트 키워드 41p

| abstract | dynamic | implements | show |
|:---:|:---:|:---:|:---:|
| as | else | import | static |
| assert | enum | import | static |
| async | export | interface | switch |
| await | extends | is | sync |
| break | external | library | this |
| case | factory | mixin | throw |
| catch | false | new | true |
| class | final | null | try |
| const | finally | on | typedef |
| continue | for | operator | var |
| covarient | function | part | void |
| default | get | rethrow | while |
| deferred | hid | return | with |
| do | if | set | yield |

## 비동기처리 방식 43p

- 동기 처리 방식

| | 전체작업시간 | | |
|--|--|--|--|
| (= = 1 = =) | | | |
| | (= = = = = = 2 = = = = = =) | | |
| | | (= 3 =) | |
| | | | (= = = 4 = = =) |

- 비동기 처리 방식

| 전체작업시간 |
|--|
| (= = 1 = =) |
| (= = = = = = 2 = = = = = =) |
| (= 3 =) |
| (= = = 4 = = =) |

### 비동기 프로세스의 작동 방식 43p

1. 함수이름 뒤, 본문 중괄호 앞, `async` 키워드 붙여서 비동기로 만든다.

```dart
void main() {
	checkVersion();
  print('end process.');
}

Future checkVersion() async {
	var version = await lookUpVersion();
  print(version);
}

int lookUpVersion() {
	return 12;
}
```

1. 이 함수 안에서, 언제 끝날지 모르는 작업 앞에  `await` (대기) 키워드를 붙여서, 여기서 작업이 끝날때까지 기다릴테니 기다리지 말고 이 함수를 부른 쪽으로 가서 나머지 작업을 진행하라는 싸인을 보낸다.
이 작업이 끝나면, 이 함수의 나머지 작업도 진행하고, 다 끝나면 결과를 Future 클래스를 통해 전달한다.

실행 결과
```
end process.
12
```

### 비동기 함수가 반환하는 값 사용하기 45p

```dart
void main() async {
	aqait getVersionName().then((value) => {
  	print(value)
  });
  print('end process');
}

Future<String> getVersionName() async {
	var versionName = await lookUpVersionName();
  print(versionName);
}

String lookUpVersionName() {
	return 'Android Q.';
}
```

실행 결과
```
Android Q.
end process
```

### 다트와 스레드 46p

```
void main() {
	printOne();
	printTwo();
	printThree();
}

void printOne() {
	print('One');
}

void printThree() {
	print('Three');
}

void printTwo() async {
	Future.delayed(Duration(seconds: 1), () {
  	print('Future!!');
  });
  print("two");
}
```

Future.delayed() 함수는 Duration 만큼 기다리고 나서 함수 내용을 실행한다.

실행 결과
```
One
Two
Three
Future!!
```

printTwo() 함수 수정

```
...
void printTwo() async {
	await Future.delayed(Duration(seconds: 2), () {
		print('Future Method');
  });
  print("two");
}
...
```

Future.delayed() 앞에 await 키워드를 붙였으므로, 여기서 대기하면서 printTwo() 함수를 벗어나 main() 함수의 나머지를 실행한다.

실행 결과
```
One
Three
Future Method
Two
```

## JSON 데이터 주고받기 48p

JSON 디코딩 보기

```dart
import 'dart:convert';

void main() {
	var jsonString = '''
		[
			{"score": 40},
			{"score": 80}
		]
  	}
	''';
	var scores = jsonDecode(jsonString);
	print(scores is List); // true 출력
	var firstScore = scores[0];
	print(firstScore is Map); // true 출력
	print(firstScore['score'] == 40); // true 출력
}
```

```dart
import 'dart:convert';

void main() {
	var scores = [
		{'score': 40},
		{'score': 80},
		{'score': 100, 'overtime': true, 'special_guest': null}
	];
	var jsonText = jsonEncode(scores);
	print(jsonText ==
		'{"score":40,"score":80},'
		'{"score":100,"overtime":true,'
		'"special_guest":null}]'); // true 출력
}
```

`{"score": 40}` 큰 따옴표 = JSON 데이터
`{'score': 40}` 작은 따옴표 = 변수

## 스트림 통신 50p

순서를 보장받고 싶을때 = 스트림 Stream 을 쓴다.

스트림 통신의 예

```dart
import 'dart:async';

Future<int> sumStream(Stream<int> stream) async {
	var sum = 0;
	await for (var value in stream) {
		print('sumStream: $value');
		sum += value;
	}
	return sum;
}

Stream<int> countStream(int to) async* {
	for (int i = 1; i <= to; i++) {
		print('countStream : $i');
		yield i;
	}
}

main async {
	var stream = countStream(10);
	var sum = await sumStream(stream);
	print(sum); // 55
}		
```

### then() 함수를 이용한 스트림 함수

```dart
main() {
	var stream = Stream.fromIterable([1,2,3,4,5]);
	// 가장 앞의 데이터 결과 = 1
	stream.first.then((value) => print('first: $value'));
	// 가장 마지막 데이터 결과 = 5
	stream.last.then((value) => print('last: $value'));
	// 현재 스트림이 비어 있는지 확인: false
	stream.isEmpty.then((value) => print('isEmpty: $value'));
	// 전체 길이: 5
	stream.length.then((value) => print('length: $value'));
}
```

스트림을 통해 데이터를 사용하면 데이터는 사라지기 때문에 오류가 발생한다.
따라서, 다음처럼 한번만 실행하도록 바꿔야 한다.

```dart
main() {
	var stream = Stream.fromIterable([1,2,3,4,5]);
	// 가장 마지막 데이터 결과 = 5
	stream.last.then((value) => print('last: $value'));
```

## 다트 프로그램

간단한 프로그램 구현.

## 실습2-1: 간단한 구구단 프로그램 53p

```
void main() {
	int i;
  int k;
  
  for (i = 2; i <= 9; i++) {
  	for (k = 2; k <= 9; k++) {
    	print('$i x $k = ${i * k}');
    }
  }
}
```

실행 결과
```
2 x 2 = 4
2 x 3 = 6
...
9 x 8 = 72
9 x 9 = 81
```

## 실습 2-2: 자동차 클래스 구현하기 54p

Car 클래스의 속성 Attribute: 

| 이름 Attribute | 자료형 | 의미 |
|:---:|:---:|:---:|
| maxSpeed | int | 최고 속도 |
| price | num | 가격 |
| name | String | 이름 |

Car 객체의 속성값 Argument:

| maxSpeed | price | name |
|:---:|:---:|:---:|
| 320 | 100,000 | BMW |
| 250 | 70,000 | BENZ |
| 200 | 80,000 | FORD |

문제: 10% 씩 세일해 주는 함수를 만들고, 그 함수를 세번 불러낸 다음, 차량가격을 출력해 보라.

프로그램:

```
void main() {
	Car bmw = Car(320, 100000, 'BMW');
	Car benz = Car(250, 70000, 'BENZ');
	Car ford = Car(200, 80000, 'FORD');
  
	bmw.saleCar();
	bmw.saleCar();
	bmw.saleCar();
	print(bmw.price);
}

class Car {
	int maxSpeed;
	num price;
	String name;

	Car(int maxSpeed, num price, String name) {
		this.maxSpeed = maxSpeed;
		this.price = price;
		this.name = name;
	}

	num saleCar() {
		price = price * 0.9;
		return price;
	}
}
```

실행 결과:

```
 72900.0
```

## 실습2-3: 로또번호 생성기 만들기 55p

무작위 수를 생성하는 랜덤 함수:

```
import 'dart:math' as math;
```

as math 란, dart:math 라이브러리를 math 라는 이름으로 쓰겠다는 뜻.

프로그램:

```
import 'dart:collection'; // HashSet을 위한 라이브러리
import 'dart:math' as math;

void main() {
	var rand = math.Random();
	HashSet<int> lotteryNumber = HashSet(); // 중복을 허용하지 않는 리스트

	while(lotteryNumber.length < 6) {
		lotteryNumber.add(rand.nextInt(45));
	}
	print(lotteryNumber);
}
```

실행 결과:

```
{9, 11, 23, 24, 29, 42}
```




# 3. 내부구조 58p

## 플러터 프로젝트 구조

### 플러터 프로젝트의 폴더 구성

손이 많이 가는 폴더들

- android 폴더 = android 에서 프로젝트를 시작할때 필요한 파일
- ios 폴더 = ios 에서 프로젝트를 시작할때 필요한 파일
- `lib 폴더` - 플러터 앱의 소스가 작성된 main.dart 파일이 있다.
- test 폴더

직접 관리해야 하는 파일들

- pubspec.yaml = 패키지, 이미지, 폰트 설정
- README.md = 프로젝트 소개
- .gitignore = git 작업시 필요없는 파일 이름을 기록

자동 관리되는 파일들

- .metadata = 플러터 SDK 정보
- .packages = 플러터 SDK 에 쓰는 기본 패키지 경로
- first_flutter_app.iml = 파일이 자동으로 만들어질때 생기는 폴더 위치
- pubspec.lock = ubspec.yaml 파일에 적용된 패키지의 위치

### lib 폴더의 main.dart 파일 (플러터 메인 소스) 59p

- 플러터 프로젝트를 만들면, 자동으로 만들어지는 파일.
- 다트 앱을 실행하면, 이 파일안에 있는 main() 함수가 시작된다.

#### import 구문

- 소스 파일에서 쓰려는 패키지를 불러올때 사용하는 문장.
- 다른 다트 클래스나 pubspec.yaml 파일에서 내려받은 패키지를 불러올때도 사용함.

#### main() 함수
- 플러터 앱은 main() 함수에서 시작함.

```
void main() {
	runApp(MyApp());
}
```

- binding.dart 에 정의돼 있는 runApp() 함수는 플러터 앱을 시작하는 역할.
- 플러터 앱을 시작하면서 화면에 표시할 위젯을 runApp() 함수에게 전달함.
- 위에서는 MyApp() 함수를 runApp() 함수에게 전달하는 것임.
- 위젯 = 부품

#### MyApp 클래스

```
class MyApp extends StatelessWidget {
	#override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Flutter Demo',
			theme: ThemeData(
				primarySwatch: Colors.blue,
				visualDensity: VisualDensity.adaptivePlatformDensity,
			),
			home: MyHomePage(title: 'Flutter Demo Home Page'),
		);
	}
}
```

- @override 애너테이션 사용 해서, build() 함수를 재정의함.
- 처음 RunApp() 함수로 클래스를 실행할때는 MaterialApp() 함수를 시스템에 리턴시켜줘야 한다.
- MaterialApp() 함수에는, 그림 그리는 도구: title, theme, home 등이 정의돼 있음.
- primarySwatch = 메인 색상 지정.
- home = 첫 화면에 보여줄 내용. 여기서는 MyHomePage() 클래스를 지정함.

실행 결과:

#### 상태 연결에 따른 위젯 구분

플러터 앱을 구성하는 위젯

- 스테이트리스 stateless 와 스테이트풀 statefull 두가지 위젯.
- 스테이트리스 위젯 = 내용을 바꿀 필요가 없는 위젯
  - 화면에 보여주기 전에 모든 로딩을 완료.
  - 앱이 위젯의 상태를 감시할 필요가 없다.
  - StatelessWidget 클래스를 상속.
- 스테이트풀 위젯 = 계산기 처럼 필요에 따라 화면을 수정해야 하는 위젯
  - 위젯의 상태를 감시하고, 변경시 적절한 조치를 해줘야 한다.
  - StatefulWidget 클래스를 상속.

## 실습3-1: 데모 앱 수정 64p

1. main.dart 에서, MyApp 클래스의 build() 함수에서 home 정의한 부분 수정.

- lib/main.dart
```dart
...
class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			...
			home: Text('hello\nFlutter'),
		);
	}
}
```

2. 안드로이드 스튜디오에서 실행버튼 클릭.

- home 에 Text() 를 바로 넣었기 때문에, 기본테마가 적용되지 않고,
  - 바탕색이 검은색으로 바뀌고 택스트에 노란 밑줄이 생김.

3. 택스트를 가운데 정렬.

- lib/main.dart
```dart
...
home: Text('hello\nFlutter', textAlign.center),
...
```

4. 소스 수정후 다시 실행.

- 안드로이드 스튜디오 실행버튼 누르면 >> 소스를 다시 빌드해서 시간 걸림.
- 플러터의 핫 리로드 기능: Ctrl+\
- Ctrl+S 저장하면 핫 리로드 자동 실행됨.

5. 텍스트를 화면 한가운데 놓으려면,

- lib/main.dart
```dart
...
home: Center(
  child: Text('hello\nFlutter', textAlign: TextAlign.center),
));
...
```

- 위젯을 하나 넣을때는 child: 두개 이상 넣을때는 children:

6. 배경을 바꾸려면 Container

- lib/main.dart
```dart
...
home: Container(
  child: Center(
    child: Text('hello\nFlutter', textAlign: TextAlign.center),
)));
...
```

- 공간만 만들어 주었으므로, 색상을 추가.

- lib/main.dart
```dart
...
home: Container(
  color: Colors.white,
  child: Center(
...
```

7. 글자색 변경

- lib/main.dart
```dart
...
    child: Text(
      'hello\nFlutter',
      textAlign: TextAlign.center
      style: TextStyle(color: Colors.blue, fontSize: 20),
),
...
```

## 실습3-2: 스위치를 달아서 화면을 갱신 60p

- 앱에 머티어리얼 디자인 적용시 Scaffold 클래스 이용.

1. main.dart 파일을 열고 MyApp 클래스 수정.

- lib/main.dart
```dart
...
class MyApp extends StatelessWidget {
  var switchValue = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.light(),
      home: Scaffold(
        body: Center(
          child: Switch(
            value: switchValue,
            onChanged: (value) {
              switchValue = value;
            }),
        ),
    ));
  }
}
...
```
코드 입력후 Ctrl + Alt + L 키를 누르면 코드가 새로 정렬됩니다.

- MyApp 클래스는 StatelessWidget 클래스를 상속받았기 때문에, 위젯의 상태가 바뀌어도 값을 화면에 반영할 수 없다.

2. 스테이트리스 위젯 -> 스테이트 위젯 ?

- lib/main.dart
```dart
...
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  ...
      home: Scaffold(
        body: Center(
          child: Switch(
            value: switchValue,
            onChanged: (value) {
              switchValue = value;
            }),
  ...
```

- 스테이트풀 위젯은 State 클래스를 써야 한다.
- State 클래스를 상속받은 _MyApp 클래스를 만들고, 그 안에 챂의 위젯을 담는다.
- 스테이트풀 위젯 클래스를 상속받은 MyApp 에서는 createState() 함수를 재정의해서 _MyApp() 함수를 걸어 놓는다.
  - MyApp 클래스가 화면을 감시하다가 상태가 변경되면 createState() 를 재정의 한대로, _MyApp() 함수를 호출해서 화면을 갱신한다.
  - 언더스코어 (_) 는 그 변수나 함수가 현재 파일 main.dart 내에서만 사용할 수 있다는 표지.
- print() 함수가 출력하는 내용은 안드로이드 스튜디오 실행창에서 확인한다.

3. 플러터에서는 변수의 값이 바뀌면 이걸 앱에 알려서 화면을 갱신해 주어야 한다.
이때 사용하는 함수 setState()

- lib/main.dart
```dart
...
child: Switch(
  value: switchValue,
  onChanged: (value) {
    setState(() {
      print(value);
      switchValue = value;
    });
  }),
...
```

실행결과:

## 실습3-3: 버튼을 눌러 텍스트를 바꾸기 74p

1. 버튼에 표시할 텍스트 저장 변수를 선언, 플러터에서 버튼위젯 -> ElevatedButton

- lib/main.dart
```dart
...
class _MyApp extends State<MyApp> {
  var switchValue = false;
  String test = 'hello'; // 버튼에 들어갈 텍스트
  @override
  Widget build(BuildContext context) {
  ...
    home: Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('$test'),
          onPressed: () {})),
  ...
```

2. 버튼 누르면 텍스트가 바뀌는 로직 추가.

- lib/main.dart
```dart
...
child: ElevatedButton(
  child: Text('$test');
  onPressed: () {
    if (test == 'hello') {
      setState(() {
        test = 'flutter';
      });
    } else {
      setState(() {
        test = 'hello';
      });
    }
  })),
...
```

실행 결과:


3. 버튼을 누르면 버튼 색 바꾸기.

- lib/main.dart
```dart
...
class _MyApp extends State<MyApp> {
  var switchValue = false;
  String test = 'hello'; // 버튼에 들어갈 텍스트
  Color _color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    ...
    child: ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(_color)),
    onPressed: () {
      if (_color == Colors.blue) {
        setState(() {
          test = 'flutter';
          _color = Colors.amber;
        });
      } else {
        setState(() {
          test = 'flutter';
          _color = Colors.blue;
        });
      }
    ...
```

실행 결과:


## 위젯의 생명주기란 78p

### 스테이트풀 위젯의 생명주기

10 단계로 구분하는 생명주기

1. 상태를 생성하는 createState() 함수

- StatefulWidget >> 반드시 >> createState() 함수 호출해야 한다.

```dart
...
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
```

2. 위젯을 화면에 장착하면 mounted = true

- createState() 호출 = 상태 생성 => mounted=true 됨. >> 위젯 제어하는 buildContext + setState() 가능.

```
if (mounted) {
  setState()
}
```

3. 위젯을 초기화하는 initState() 함수

- 위젯 초기화할때 initState() 함수 한번만 호출.

```
@override
initState() {
  super.initState();
  _getJsonData();
}
```

4. 의존성이 변경되면 호출하는 didChangeDependencies() 함수

- initState() 위젯 초기화 함수 호출후 바로 호출하는 함수 = didChangeDependencies() 함수.
- 데이터에 의존하는 위젯이라면, 화면 표시전에 꼭 didChangeDependencies() 함수를 호출해야 한다.

5. 화면에 표시하는 build() 함수

- Widget 을 반환하는 함수 = 위젯을 화면에 렌더링 = build() 함수에서 위젯을 만들고 반환 -> 화면에 표시.

```
#override
Widget build(BuildContext context) {
	return MaterialApp(
  	title: 'Flutter Demo',
    theme: ThemeData(
    	primarySwatch: Colors.amber,
    ),
    home: MyHomePage(title: 'Flutter Demo Home Page'),
  );
}
```

6. 위젯을 갱신하는 didUpdateWidget() 함수

- (부모 위젯 or 부모 데이터) 변경 = 위젯 갱신해야 함.
- initState() (위젯 초기화시 1번 호출됨) -> @@ event 발생 -> 위젯 변경해야 하므로, didUpdateWidget() 호출

```
@override
void didUpdateWidget(Widget oldWidget) {
	if(oldWidget.importantproperty != widget.importantproperty) {
  	_init();
  }
}
```

7. 위젯의 상태를 갱신하는 setState() 함수

- 데이터 변경 신호, 변경된 데이터로 화면 UI 변경 지시. 

```
void updateProfile(String name) {
	setState(() => this.name = name);
}
```

8. 위젯의 상태관리 중지하는 deactivate() 함수

- 플러터 구성 트리에서 State 객체를 제거할때 호출.
- 메모리 내용은 안지우므로 제거한 State 객체를 다시 사용할 수 있다.

9. 위젯의 상태관리를 롼전히 끝내는 dispose() 함수

- State 객체를 영구적으로 삭제.

10. 위젯을 화면에서 제거하면 mounted == false

- State 객체가 소멸하면 mounted 속성이 false 로 돠면서 생명주기가 끝난다.

표 3-3. 위젯의 생명주기 요약

| 호출 순서 | 생명주기 | 요약
|:---:|:---|:---|
| 1 | createState() | 처음 스테이트풀을 시작할때 호출 |
| 2 | mounted == true | createState() 함수가 호출되면 mounted 는 true 가 된다 |
| 3 | initState() | State 객체 생성후 제일 먼저 한번만 실행하는 함수 |
| 4 | didChangeDependencies() | initState() 호출후 호출하는 함수 |
| 5 | build() | 위젯을 렌더링하는 함수. 위젯을 반환한다. |
| 6 | didUpdateWidget() | 위젯을 변경할때 호출하는 함수 |
| 7 | setState() | 데이터가 변경됐음을 알리는 함수. 변경된 데이터를 UI 에 적용하기 위해 필요하다. |
| 8 | deactivate() | State 객체를 제거할때 호출 |
| 9 | dispose() | State 객체가 완전히 제거됐을때 호출 |
| 10 | mounted == false | 모든 프로세스가 종료된 뒤에 mounted 가 false 로 된다. |

## 실습3-4: 생명주기 순서 출력하기

# 4. 위젯 사용법 86p
## 스캐폴드로 머티어리얼 디자인적용 87p
## 이미지,폰트 추가 97p
## 상호작용 앱 105p

# 5. 탭바, 리스트 115p

## 탭바로 화면이동 116p
## 목록 리스트뷰 123p

# 6. iOS 스타일 144p

## 쿠퍼티노 위젯 동물소개앱 145p
## 동물 추가화면 154p
## 쿠퍼티노 위젯 163p

# 7. 네트워크 통신 169p

## 카카오API 로 책정보받기 170p
## 이미지파일 내려받기 190p

# 8. 내비게이션 201p

## 내비게이션이란 202p
## 할일기록앱 209p

# 9. 내부 저장소 이용 224p

## 공유환경설정에 저장 225p
## 파일에 저장 230p

# 10. 데이터베이스 이용 249p

## 데이터베이스 만들기 250p
## 데이터 처리 257p
## 쿼리로 추가 272p

# 11. 애니메이션 283p

## 구현 284p
## 인트로 화면 296p
## 역동적인 앱바 스크롤 309p

# 12. 네이티브 API 통신 319p

## 안드로이드 네이티브와 통신 320p
## 데이터 주고받기 331p

# 13. 파이어베이스 343p

## 파이어베이스 설정 344p
## 애널리틱스 351p
## 메모장 앱 363p

# 14. 오픈 API로 여행정보앱 402p

## 오픈 API 이용 403p
## 여행정보 앱 스케치 409p
## 앱 프로젝트 시작 412p

# 15. 완성 및 출시 427p

## 메인화면 428p
## 상세보기 443p
## 즐겨찾기 464p
## 실행화면 472p
## 구글 플레이 앱 출시 483p

easyspub.co.kr/main/pub
github.com/rollcake86/DoitFlutter2.0
buk.io/@ca3024
buk.io/@pa5240

