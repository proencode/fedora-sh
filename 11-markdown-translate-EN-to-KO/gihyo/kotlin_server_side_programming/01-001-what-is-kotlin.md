
이 장에서는 Kotlin의 기초에 대해 설명합니다. 언어의 생생함이나 서버 측에서의 이용 의의, 특징적인 기능이나 기본적인 구문 등, 우선은 Kotlin이라고 하는 언어 그 자체에 대해 알 수 있으면 좋겠습니다.

# 1. 왜 Kotlin이 탄생했는가?

Kotlin은 IntelliJ IDEA와 같은 IDE(Integrated Development Environment, 통합 개발 환경)로 유명한 JetBrains가 개발한 프로그래밍 언어입니다. 정식 버전의 1.0 릴리스는 2016년 2월과 비교적 새로운 언어가 됩니다.

JVM상에서 움직이는, 이른바 JVM언어 주1 의 일종입니다. JetBrains사의 Kotlin 개발 멤버가 집필하고 있는 서적 「Kotlin 인 액션」주2 에서도 소개되고 있습니다만, 원래는 JetBrains사의 Java로 개발을 하고 있는 팀이, C#로 개발을 해 .NET 팀을 부러워하고 Java를 대신하는 현대적인 언어로 개발했다는 이야기가 있습니다. 그 때문에 Java와 비교해 심플한 구문이 되고 있거나, 함수형이나 코루틴 등 최근의 언어로 자주 볼 수 있는 기능도 제대로 들어가 있어, 개발 효율이나 시스템의 품질 담보의 면에서도 매우 뛰어난 것에 되어 있습니다.

또한 JetBrains는 IntelliJ IDEA를 비롯한 Java로 Java를 개발했으며 많은 Java 자산을 보유하고 있습니다. 따라서 자산을 잃는 것은 생산성 저하로 이어질 수 있다고 생각하고 자바와의 상호 운용이 가능하다는 것을 전제 조건으로 삼았다. 따라서 Kotlin은 Java와의 상호 호환성이 있으며 원래 Java를 사용하는 프로젝트에서는 특히 사용 가치가 높은 언어입니다.

# 2. Kotlin으로 무엇을 만들 수 있습니까? 서버 측에서의 이용 의의

## 다양한 플랫폼에서 사용할 수 있는 Kotlin

Kotlin의 사용 장면으로서 가장 유명한 것은 Android 앱의 개발이라고 생각합니다. 2017년에 진행된 Google I/O에서 Android의 공식 개발 언어로 지원한다고 Google이 발표했습니다. 게다가 2년 후의 Google I/O 2019에서는 추천 언어로서 Kotlin 퍼스트를 강하게 해 나가는 것이 발표되어, 향후도 일반적으로 사용되어 갈 것으로 생각됩니다.

또, iOS나 Mac, Windows의 앱에의 네이티브 바이너리를 생성할 수 있는 Kotlin/Native 주3 이나, JavaScript의 코드를 생성할 수 있는Kotlin/JS 주4 등을 사용해,Kotlin의 코드로부터 다양한 플랫폼에서 실행하는 프로그램을 만들 수 있습니다. JetBrains의 IntelliJ IDEA는 이러한 멀티 플랫폼 코드를 만들기위한 Kotlin Multiplatform Project 주 5 (통칭 Kotlin MPP)라는 프로젝트 구성도 제공합니다.

그 안에서 Android에서의 개발과 함께 일반적인 사용 지점으로 꼽히는 것이 서버 측 개발입니다.

## 서버측에서의 사용의의

전술의 서적 「Kotlin 인 액션」에서도,

Kotlin을 사용하는 가장 일반적인 장면은 다음 두 가지입니다.

- 서버측 구현(일반적으로 웹 애플리케이션 백엔드)
- Android 기기에서 실행되는 모바일 애플리케이션 구현
(Kotlin In Action에서)

라고 쓰여져 있으며, 서버측 개발에서의 이용이 베터인 방법의 하나인 것을 알 수 있습니다.

그 이유로서, 우선 Java나 C#를 비롯한, 정적 형 언어의 메리트가 그대로 Kotlin에도 적용됩니다. 예를 들면 다음과 같습니다.

- 인터프리터형 언어에 비해 높은 성능
- 대인원수, 대규모의 개발이나 장기 운용에서도 보수성이 높은 설계를 하기 쉬운 언어 사양

이러한 이점이 있는 언어 중에서도 비교적 새롭고 현대적인 구문과 기능이 준비되어 있어 개발 효율도 높은 언어라고 할 수 있습니다. 또, 후술하는 Null 안전한 언어 사양도 있어, 시스템의 품질이나 보수성의 면에서도 높일 수 있습니다.

게다가, Java와의 상호 호환성은 앞서 언급했지만, Java의 가장 주요한 프레임워크인 Spring Framework가 Kotlin을 지원하는 것도 들 수 있습니다. 새로운 언어를 사용할 때, 아무래도 프레임워크나 그 주변의 에코시스템은 발전 도상으로, 헤매어 버리는 경우도 많습니다. 그런 가운데 Spring Framework라는 검증된 프레임워크가 선택사항으로 존재하는 것은 매우 큰 일입니다. 물론 Kotlin제의 프레임워크도 개발되고 있어, 향후 그쪽도 발전해 한층 더 질 높은 개발을 할 수 있게 되어 가는 것에의 기대도 큽니다.

# 3. 코드의 안전성을 높이는 Kotlin의 형태와 Null 비허용/허용

## Kotlin의 Null 안전이란?

앞서 언급했지만 Kotlin의 언어 사양의 주요 특징 중 하나는 Null 안전 을 포함합니다. Kotlin의 기능으로 큰 장점이되는 부분이므로 먼저 소개합니다. 목록 1.3.1 을 보라.

목록 1.3.1
```
val str1: String = null  // Null허용 안함, 컴파일 에러 발생
val str2: String? = null // Null허용
```
Kotlin에서는 변수를 선언할 때 형식(이 경우 String )에 아무것도 붙이지 않고 선언하면 Null이 허용되지 않으며 Null을 넣으면 컴파일 오류가 발생합니다. ? 를 붙이면 변수에 Null을 넣을 수 있습니다.

이와 같이 형태를 선언하는 단계에서 Null 비허용/허용을 명시해, 잘못된 부분에서 Null을 넣으려고 하면 컴파일의 시점에서 막아 주기 때문에, NullPointerException의 발생을 미연에 방지할 수 있습니다. 또, 형태의 디폴트가 Null 비허용이라고 하는 것도 되기 때문에, 통상은 Null 비허용으로 해, 필요하게 된 개소만 Null 허용으로 하면 의식할 수 있어, 불필요한 Null의 취급을 줄일 수도 있습니다.

그리고 Null 허용의 형태의 변수에도 한층 더 안전성을 유지하는 사양이 있습니다. Null 허용으로 했을 경우, 그 오브젝트의 함수등에 대해서, 단지 액세스하면 컴파일 에러가 됩니다. 목록 1.3.2 의 예에서는 인수가 Null 허용 String 유형인 message 라는 인수를 받고 length 에 액세스하려고 시도하지만 null이 포함되어 있지 않다는 보장이 없으므로 컴파일 오류가 발생합니다.

목록 1.3.2
```
fun printMessageLength(message: String?) {
    println(message.length) // 컴파일 에러
}
```
대처법은 몇 가지 있습니다만, 가장 알기 쉬운 것은 Null 체크의 if문을 넣는 것입니다. 목록 1.3.3 의 예에서는 if 문에서 message 가 Null이면 return 하고 값이 들어있는 경우에만 message.length 를 실행한다. 이렇게 해서 사전에 Null 체크를 하는 것으로, 변수에 Null 가 들어가 있지 않은 것이 보증되는 것으로 처음으로 액세스 할 수 있기 (위해)때문에, 기본적으로는 컴파일의 시점에서 NullPointerException 를 막습니다.

목록 1.3.3
```
fun printMessageLength2(message: String?) {
    if (message == null) {
        return
    }
    // 위의 처리로 Null이 아닌 것이 보증되고 있기 때문에 실행할 수 있다
    println(message.length)
}
```
또한 엘비스 연산자를 사용하여 구현할 수 있습니다. 목록 1.3.4 와 같이 message 뒤에 ? _

목록 1.3.4
```
fun printMessageLength3(message: String?) {
    message ?: return
    println(message.length)
}
```
이 ?: 를 엘비스 연산자라고 하며, 어느 값이 null이었을 경우에만 실행하는 처리를 쓰는 경우에 간단하게 기술할 수 있습니다.

## 인수의 널 허용, 비허용 불일치 방지

또, 예를 들어 같은 String형에서도, ? 가 붙지 않은 Null 비허용의 String는 String?의 서브 타입으로서 취급됩니다. 따라서 String 유형을 String 유형의 인수에 전달할 수 있지만 String 유형을 String 유형의 인수에 전달할 수는 없습니다. 이러한 형태는 함수의 인수나 반환값의 형태로서도 사용할 수 있어 인수나 함수의 실행 결과의 전달에서도 Null 허용, 비허용의 설정의 불일치를 막을 수 있습니다. 목록 1.3.5 의 코드를 보라.

목록 1.3.5
```
fun execute(userId: Int?) {
    createUser(userId) // 컴파일 에러
}

private fun createUser(userId: Int) {
    // 생략
}
```
execute 함수 의 인수 userId 는 Null 허용입니다. 그리고 처리 중 함수 createUser 에 인수의 userId 를 그대로 전달하여 실행하고 있습니다. 그러나 createUser 인수 userId 는 Null을 허용하지 않기 때문에 오류가 발생합니다. 그러므로 쓴 시점에서 문제를 깨닫고, 사양에 따라 리스트 1.3.6 과 같이 Null 체크 를 넣을수 있습니다.

목록 1.3.6
```
fun execute(userId: Int?) {
    if (userId != null) {
        createUser(userId)
    }
}
```

목록 1.3.7
```
fun execute(userId: Int) {
    createUser(userId)
}
```
이와 같이 Kotlin에서는, 타입 레벨에서 Null 비허용/허용을 명시해, 컴파일로 체크해 주기 때문에, 인수로 값을 건네줄 때의 Null 비허용/허용의 부정합도 실장시에 막아, 안전하게 유지해 합니다. 이로 인해 결함을 줄이는 것은 물론, 테스트 공수의 경감이나 엔지니어가 실장이나 리뷰시에 Null의 취급을 강하게 의식하지 않아도 되기 때문에 개발 효율의 향상에도 연결됩니다.

## 안전 호출, 강제 언랩으로 Null 체크 없이 실행하는 것도 가능

if 문을 작성하지 않고 Null 허용 유형의 변수를 처리하는 방법이 있습니다. 하나는 「안전 호출」이라고 하고, 리스트 1.3.8 과 같이 변수의 뒤에 ? 를 붙여 호출하는 방법입니다.

목록 1.3.8
```
fun printMessageLength(message: String?) {
    println(message?.length)
}
```
이것은 변수의 값이 null이면 null을 반환하고, null이 아니면 후속 처리 (여기서는 length )를 수행합니다. 호출하면 목록 1.3.9 와 같은 결과가 된다.

목록 1.3.9
```
printMessageLength("Kotlin")
printMessageLength(null)
```
-> 실행 결과
```
 6
 null
```

다른 하나는 "강제 언랩"이라는 방법으로 변수의 값이 무엇이든 질문 대답없이 실행합니다. 목록 1.3.10 과 같이 변수 뒤에 !! 를 붙여 호출한다.

목록 1.3.10
```
fun printMessageLength(message: String?) {
    println(message!!.length)
}
```

다만, 이 방법은 null가 들어갔을 경우에는 런타임에 에러가 되기 때문에, 별로 바람직하지 않습니다. 사양상 확실히 null이 들어오지 않는 경우에만 사용할 수 있습니다.

# 4. 환경 구축 및 첫 프로그램 실행

여기에서 실제로 Kotlin을 실행해 나가기 위한 환경 구축을 합니다. 이 문서에서는 기본적으로 JetBrains의 IDE 인 IntelliJ IDEA를 사용하여 코드를 구현합니다.

## IntelliJ IDEA 설치

- 설치(Mac)

공식 사이트 주 6 에서 최신 버전의 dmg 파일을 다운로드합니다. 그림 1.1 의 화면에서 [다운로드] 버튼을 누릅니다. 무료 버전인 '커뮤니티'로 문제 없습니다.

![ 01-001 IntelliJ IDEA Download ]![ 01-001_intellij_idea_download.webp ]( /gihyo/kotlin_server_side_programming_img/01-001_intellij_idea_download.webp )


다운로드한 dmg 파일을 실행하여 원하는 위치에 설치합니다.

- 설치(Windows)

공식 사이트 주 7 에서 최신 버전의 exe 파일을 다운로드합니다. 그림 1.2 의 화면에서 [다운로드] 버튼을 누릅니다. 무료 버전인 '커뮤니티'로 문제 없습니다.

![ 01-002 select community version ]( /gihyo/kotlin_server_side_programming_img/01-002_select_community_version.webp )

다운로드한 exe 파일을 실행합니다. 몇 가지 설정이 표시되지만 모두 기본 상태에서 [Next]로 진행하여 문제가 없습니다 ( 그림 1.3 ~ 그림 1.5 ).

![ 01-003 start Setup.webp ]( /gihyo/kotlin_server_side_programming_img/01-003_start_setup.webp
)

![ 01-004 Destination Folder.webp ]( /gihyo/kotlin_server_side_programming_img/01-004_destination_folder.webp
)

![ 01-005 Configure.webp ]( /gihyo/kotlin_server_side_programming_img/01-005_configure.webp
)

![ 01-006 start Install.webp ]( /gihyo/kotlin_server_side_programming_img/01-006_start_install.webp
)

설치 중에는 그림 1.7 의 화면이 표시되므로 조금 기다립니다.

![ 01-007 Extract.webp ]( /gihyo/kotlin_server_side_programming_img/01-007_extract.webp
)

완료되면 그림 1.8 의 화면이 표시되므로 "Run IntelliJ IDEA Community Edition"을 체크하고 [Finish]를 누르면 설치한 IntelliJ IDEA가 시작됩니다.

![ 01-008 to Finish.webp ]( /gihyo/kotlin_server_side_programming_img/01-008_to_finish.webp
)

- IntelliJ IDEA 시작

이후는, Mac판에서 해설합니다. Windows 판의 분은 적절히 읽어 주세요.

설치한 IntelliJ IDEA CE.app를 시작합니다. 테마나 플러그인 등 일부 설정 화면( 그림 1.9~그림 1.12 )이 표시되므로 필요에 따라 설정해 주십시오. Kotlin은 기본 상태로 사용할 수 있으므로 모두 그대로 상태로 진행해도 문제 없습니다.

![ 01-009 Set UI theme.webp ]( /gihyo/kotlin_server_side_programming_img/01-009_set_ui_theme.webp
)

![ 01-010 Create Launcher Scripts.webp ]( /gihyo/kotlin_server_side_programming_img/01-010_create_launcher_scripts.webp
)

![ 01-011 Tune IDEA to your tasks.webp ]( /gihyo/kotlin_server_side_programming_img/01-011_tune_idea_to_your_tasks.webp
)

![ 01-012 Download featured plugins.webp ]( /gihyo/kotlin_server_side_programming_img/01-012_download_featured_plugins.webp
)

## Kotlin 프로젝트 만들기

모든 설정이 끝나면 그림 1.13 의 화면이 표시되므로 New Project를 선택하여 프로젝트를 만듭니다.

![ 01-013 start New Project.webp ]( /gihyo/kotlin_server_side_programming_img/01-013_start_new_project.webp
)

그림 1.14 의 화면에서 왼쪽 프로젝트 유형 목록에서 "Kotlin"을 선택하고 다음 설정을 지정하십시오.

- 이름: 모든 프로젝트 이름(그림의 KotlinExample)
- Location: 배치하려는 디렉토리(그림에서는 홈 디렉토리 아래의 IdeaProject/KotlinExample)
- 프로젝트 템플릿: 애플리케이션
- 빌드 시스템: Gradle Kotlin
- 프로젝트 JDK: corretto-11

![ 01-014 select Kotlin.webp ]( /gihyo/kotlin_server_side_programming_img/01-014_select_kotlin.webp
)

Kotlin에서는 개발 시 JDK(Java Development Kit)가 필요하며 이 프로젝트에서 사용하는 버전을 Project JDK에서 지정합니다. 이 책에서는 corretto-11(Amazon Corretto 버전 11 참고 8 참조)을 사용합니다. 만약 표시되지 않는 경우는 그림 1.15 와 같이 「Download JDK...」를 선택하면 그림 1.16 의 다이얼로그가 표시되므로, 아래와 같이 선택해 주세요.

- 버전: 11
- Vendor: Amazon Corretto(그림 1.16에 표시된 내용은 작성 시점의 최신 버전)

![ 01-015 Download JDK.webp ]( /gihyo/kotlin_server_side_programming_img/01-015_download_jdk.webp
)

![ 01-016 select and Download.webp ]( /gihyo/kotlin_server_side_programming_img/01-016_select_and_download.webp
)

[Next]를 눌러 다음으로 진행하면 그림 1.17 과 같은 화면이 표시되므로 [Finish]를 눌러 프로젝트 작성을 완료합니다.

![ 01-017 Finish to Project ok.webp ]( /gihyo/kotlin_server_side_programming_img/01-017_finish_to_project_ok.webp
)

## 첫 프로그램 실행

프로젝트가 생성되면 그림 1.18 과 같이 왼쪽에 프로젝트 뷰가 표시됩니다. 열 때 표시되지 않으면 화면 왼쪽의 "1:Project"를 누르십시오.

![ 01-018 Project View.webp ]( /gihyo/kotlin_server_side_programming_img/01-018_project_view.webp
)

그런 다음 src / main / kotlin 디렉토리를 마우스 오른쪽 버튼으로 클릭하고 [New] → [Kotlin Class / File]을 선택하고 ( 그림 1.19 ), 그림 1.20 의 대화 상자에 임의의 이름 (그림에서는 Example)을 입력하여 파일 작성하십시오. Class, Interface 등도 선택할 수 있습니다만, 여기에서는 「File」을 선택합니다. Kotlin 파일은 기본적으로이 src / main / kotlin 아래에 생성됩니다.

![ 01-019 New Kortlin Files.webp ]( /gihyo/kotlin_server_side_programming_img/01-019_new_kortlin_files.webp
)

![ 01-020 select File.webp ]( /gihyo/kotlin_server_side_programming_img/01-020_select_file.webp
)

작성한 파일에 목록 1.4.1 의 코드를 작성하십시오.

Listing 1.4.1
```
fun main() {
    println("Hello Kotlin.")
}
```
그리고 IntelliJ IDEA로 1행째의 왼쪽에 표시되어 있는 재생 버튼의 아이콘을 누르고, 「Run 'ExampleKt'」를 선택하면 main 함수가 실행됩니다( 그림 1.21 ).

![ 01-021 run ExampleKt.webp ]( /gihyo/kotlin_server_side_programming_img/01-021_run_examplekt.webp
)

성공적으로 실행되면 화면 하단의 Run 보기에 "Hello Kotlin."이 표시됩니다. 이것으로 Kotlin 실행 환경의 준비가 완료됩니다.

## build.gradle.kts 정보

작성한 프로젝트를 보면 바로 아래 디렉토리에 build.gradle.kts라는 파일이 있다고 생각합니다. 이것은 Gradle 주 9 라는 도구의 구성 파일입니다. Gradle은 Kotlin 및 Java와 같은 응용 프로그램의 빌드 도구로 빌드에 필요한 라이브러리를 설정하고 작업을 정의할 수 있습니다. 원래는 Groovy로 작성하는 도구이었지만 Kotlin DSL이라는 Kotlin으로 작성할 수있는 방법이 있습니다 (Groovy의 경우 .kts 확장명이 없음).

기술 방법은 사용시에 수시로 해설합니다만, 여기에서는 파일의 말미에 리스트 1.4.2 의 내용을 추가해 주세요.

Listing 1.4.2
```
dependencies {
    // 여기에 라이브러리 및 프레임워크 종속성을 추가합니다.
}
```

dependencies 라는 블록을 추가하고 있습니다. 이것은 사용하는 프레임워크나 라이브러리의 종속성을 기술하는 블록으로, 이후의 해설 중에서 필요한 것을 수시로 추가해 갑니다.

## 이 문서에서 샘플 코드 실행 정보

이 문서의 샘플 코드는 기본적으로 main 함수의 처리를 다시 작성하여 실행할 수 있습니다. 또한 앞서 언급했듯이 파일은 기본적으로 src / main / kotlin 디렉토리 아래에 생성됩니다. 단지 몇 가지 패턴이 있으므로 여기에서 먼저 해설하겠습니다. 이러한 패턴과는 다른 형태로 실행하는 예외적인 것에 관해서는, 매번 본문안에서 기술의 방법을 설명합니다.

또, 프로젝트 자체를 새롭게 작성하는 지시가 있는 장도 있으므로, 특별히 작성 방법이 기술되어 있지 않은 경우는, 이하에서 설명하는 순서로, 임의의 이름으로 작성해 주세요.

- 함수 정의가 없고 처리만 작성된 경우

Listing 1.4.3 과 같이 함수 정의(다음 섹션에서 설명함)가 없는 처리 전용 코드의 경우, main 함수를 Listing 1.4.4 와 같이 재작성한다.

Listing 1.4.3
```
val text = "Hello Kotlin."
println(text)
```

Listing 1.4.4
```
fun main() {
    val text = "Hello Kotlin."
    println(text)
}
```

- 함수의 정의와, 호출하는 처리가 쓰여져 있는 경우

Listing 1.4.5 , Listing 1.4.6 과 같이 함수 정의와 호출 예제가 있다면, Listing 1.4.7 과 같이 함수를 만들고 main 함수에 호출 코드를 작성한다.

Listing 1.4.5
```
fun printText() {
    val text = "Hello Kotlin."
    println(text)
}
```

Listing 1.4.6
```
printText()
```

-> 실행 결과
```
Hello Kotlin.
```

Listing 1.4.7
```
fun printText() {
    val text = "Hello Kotlin."
    println(text)
}

fun main() {
    printText()
}
```

- 클래스, 인터페이스가 작성된 경우

Listing 1.4.8 , Listing 1.4.9 와 같이 클래스 또는 인터페이스 (다음 섹션에서 설명 함)가 작성된 경우, 특별한 주석이 없으면 클래스 이름, 인터페이스 이름과 동일한 이름의 파일을 만들고 설명합니다.

Listing 1.4.8
```
class User {
    var name: String = ""
}
```

Listing 1.4.9
```
interface Greeter {
    fun hello()
}
```

일부 예외적으로 1파일에 복수의 클래스나 인터페이스를 쓰고 있는 것도 있습니다만, 본서에서는 기본적으로 1파일에 1클래스 혹은 1인터페이스의 상정으로 기술하고 있습니다.

- 패키지 정보

Kotlin에는 패키지라는 개념이 있습니다. 코드를 분류하기 위한 구조로, 각 클래스나 함수등을 패키지를 나누어 배치해 관리합니다. IntelliJ IDEA에서는 src/main/kotlin 디렉토리를 마우스 오른쪽 버튼으로 클릭하고 새로 만들기 → 패키지로 만들 수 있습니다.

패키지는 필수는 아니며, 이 장에서 작성한 것처럼 src/main/kotlin하에 파일을 작성해도 동작상은 문제 없습니다. 이 문서의 샘플에서는 패키지의 위치에 대한 지시사항은 특별히 작성하지 않았으므로 샘플 코드는 임의의 패키지에 작성해도 괜찮습니다. 공개된 샘플 프로젝트 쪽에서는, 적당히 패키지를 작성하고 있으므로, 참고가 되는 것이 원하는 분은 그쪽도 봐 주세요.

- import 문에 대하여

Kotlin은 다른 패키지의 코드와 외부 라이브러리를 사용할 때 목록 1.4.10 과 같이 파일의 시작 부분에 import 문을 작성하고 읽어야합니다.

목록 1.4.10
```
import com.example.Example
import io.ktor.application.call
```

다만, 필요한 import문을 모두 기재하면 꽤 길어져 버리기 때문에, 본서의 각 샘플 코드에서는 기본적으로 생략하고 있습니다. 따라서 각각 필요에 따라 import 문을 추가해야합니다.

IntelliJ IDEA에서는 import가 필요한 코드의 해당 부분이 컴파일 에러로 적자로 표시되고 커서를 맞추면 그림 1.22 와 같이 "Unresolved reference" 라는 에러가 표시됩니다. 여기서 Mac의 경우 [`option'] + [`Enter'] , Windows의 경우 [`Alt'] + [`Enter'] 를 누르면 그림 1.23 과 같이 솔루션의 액션 후보가 나오므로 "Import"를 선택하면 필요한 import 문 추가 해줍니다.

![ 01-022 Unresolved 01-023 Import.webp ]( /gihyo/kotlin_server_side_programming_img/01-022_unresolved_01-023_import.webp
)

여기에서는 Example 클래스의 import 문을 추가하고 있습니다.

일부 이 기능만으로는 보완할 수 없는 것이 있어, 그 경우는 각 샘플 코드안에 import문도 포함해 기재해, 해설 중에서도 그 취지를 기술하고 있습니다.

# 5. Kotlin의 기본 구문

여기에서는 Kotlin의 기본 구문에 대해 소개합니다. 이 책은 프로그래밍 경험자를 대상으로 하기 때문에 프로그래밍 언어의 기본 구문과 크게 다르지 않은 것에 대해서는 간략한 설명을 한다. Kotlin의 특징적인 구문, 기능에 대해서는 다음 장에서 별도로 소개합니다.

## 변수

Kotlin의 변수 정의는 Listing 1.5.1 과 같이 선두에 val , var 중 하나를 붙여 선언한다.

Listing 1.5.1
```
val id = 100
var name = "Takehata"
```

val 은 변경 불가, var 는 변경 가능을 나타내, val 로 정의한 변수의 값을 변경하려고 하면 컴파일 에러가 됩니다( 리스트 1.5.2 ).

Listing 1.5.2
```
val id = 100
id = 200 // 컴파일 에러
```

값이 변경되는 가정이 없는 변수는, val 로 정의하는 것으로 의도하지 않은 재기록을 막을 수 있어, 결함의 경감으로 이어집니다.

또한 Kotlin에는 유형 추론의 기능이 있습니다. 변수를 정의할 때 형을 선언하고 있지 않아도, 대입된 값으로부터 형태를 추론해 줍니다. Listing 1.5.1 에서 id 는 숫자(Int)로, name 은 문자열(String)로 정의된다. 명시적으로 타입을 정의하고 싶다면 Listing 1.5.3 과 같이 된다.

Listing 1.5.3
```
val id: Int = 100
var name: String = "Takehata"
```

## 기능

Kotlin의 함수는 Listing 1.5.4 와 같이 작성한다.

Listing 1.5.4
```
fun countLength(str: String): Int {
    return str.length
}
```

fun 함수명(인수): 반환값의 형태 라고 하는 구문이 됩니다. 반환값이 존재하지 않는 경우는, Listing 1.5.5 와 같이 반환값의 형태의 기술을 생략 할 수 있습니다.

목록 1.5.5
```
fun displayMessage(message: String) {
    println(message)
}
```

또한 Kotlin에는 Unit 이라는 아무것도 없다는 것을 나타내는 유형이 있습니다. 여기를 사용하여 목록 1.5.6 과 같이 명시 적으로 반환 값으로 작성할 수도 있지만 기본적으로 필요하지 않습니다.

Listing 1.5.6
```
fun displayMessage(message: String): Unit {
    println(message)
}
```

### 분기

- 문자라면

Kotlin의 분기 처리에는 if 문과 when 문이 있습니다. 첫째, 기본 if 문은 Listing 1.5.7 과 같다.

Listing 1.5.7
```
fun ifExample(num: Int) {
    if (num == 100) {
        println("num is 100")
    }
}
```

많은 언어의 if 문과 같이 Boolean 형의 결과를 돌려주는 식을 조건식으로서 건네주어, 필요에 따라서 else if , else 를 기술합니다 ( 리스트 1.5.8 ).

Listing 1.5.8
```
if (num < 100) {
    println("Less than 100")
} else if (num == 100) {
    println("Equal to 100")
} else {
    println("Greater than 100")
}
```

- when 문

when문은 다른 언어로 말하는 switch문, case문 등에 해당하는 구문으로, 조건식에 대한 복수의 분기를 실현합니다. Listing 1.5.9 와 같이 기술한다.

목록 1.5.9
```
fun whenExample(num: Int) {
    when (num) {
        100 -> {
            println("Equal to 100")
        }
        200 -> {
            println("Equal to 200")
        }
        else -> {
            println("Undefined value")
        }
    }
}
```

when 에 인수로서 그 값에 따라 처리를 기술하고 있습니다. 어떤 조건에도 적용되지 않는 값의 경우 else 처리가 수행됩니다.

또한 값이 일치하는지 뿐만 아니라, 리스트 1.5.8 의 if문의 코드를 when문으로 옮겨놓은, 리스트 1.5.10 과 같은 구현도 가능하게 됩니다.

목록 1.5.10
```
when {
    num < 100 -> {
        println("Less than 100")
    }
    num == 100 -> {
        println("Equal to 100")
    }
    else -> {
        println("Greater than 100")
    }
}
```

## 반복

반복 처리도 다른 언어와 마찬가지로 while 문, for 문, do while 문 등이 있습니다. 여기에서는 while 문, for 문에 대해 소개합니다.

- while 문

while 문은 Listing 1.5.11 과 같다. 다른 언어와 큰 차이는 없고, while(조건식) 로 쓴 조건식을 채울 때까지 반복 처리를 계속합니다.

Listing 1.5.11
```
var i = 1
while (i < 10) {
    println("i is $i")
    i++
}
```
-> 실행 결과
```
i is 1
i is 2
i is 3
i is 4
i is 5
i is 6
i is 7
i is 8
i is 9
```

- for 문

for 문에는 몇 가지 쓰기가 있습니다. 예를 들어 , Listing 1.5.12 는 숫자의 범위를 1..10 으로 지정하고 그 횟수만큼 처리를 수행한다. 여기서 정의하고 있는 변수 i 에는 1~10의 값이 차례로 들어갑니다.

목록 1.5.12
```
for (i in 1..10) {
    println("i is $i")
}
```

-> 실행 결과
```
i is 1
i is 2
i is 3
i is 4
i is 5
i is 6
i is 7
i is 8
i is 9
i is 10
```

또한 Listing 1.5.13 과 같이 작성할 수 있다. Listing 1.5.12 와 유사하지만 (변수 이름 in 시작 값 until 종료 값 step 증가 값) 으로 설정하면 증가 값에 지정된 각 수에 대해 숫자를 늘릴 수 있습니다. 여기에서는, 1~10까지의 값을 2씩 증가시켜 i에 대입해, 표시하고 있습니다.

목록 1.5.13
```
for (i in 1 until 10 step 2) {
    println("i is $i")
}
```

-> 실행 결과
```
i is 1
i is 3
i is 5
i is 7
i is 9
```

그 밖에도 후술하는 컬렉션과의 편성으로 사용하는 방법도 있습니다. (`변수명 in 콜렉션의 값`) 이라고 지정하는 것으로, 콜렉션의 값을 차례로 꺼내, 변수에 대입해 요소를 취급할 수가 있습니다. Listing 1.5.14 에서는 list 의 요소를 순서대로 꺼내 i 에 대입해 표시하고 있다.

목록 1.5.14
```
val list = listOf(1,2,5,6,10)
for (i in list) {
    println("i is $i")
}
```

-> 실행 결과
```
i is 1
i is 2
i is 5
i is 6
i is 10
```

## 클래스

Kotlin 클래스의 정의와 상속의 사용법에 관한 것입니다. 상속시 몇 가지 한정자를 사용할 수 있으므로 그쪽도 함께 소개합니다.

- 클래스 정의

클래스 정의는 Listing 1.5.15 와 같이 작성한다.

목록 1.5.15
```
class Human {
    fun showName(name: String) {
        println(name)
    }
}
```

`class 클래스명` 으로 정의해, 중첩(중첩) 된 중에 함수나 변수를 정의해 갑니다. Listing 1.5.16 과 같은 형태로 이 클래스의 인스턴스를 생성하고 함수를 실행할 수 있다.

목록 1.5.16
```
val human = Human()
human.showName("BTS !")
```

-> 실행 결과
```
BTS !
```

Kotlin은 `클래스이름 ()` 으로 인스턴스를 생성합니다. 다른 언어로 보이는 new 와 같은 키워드는 필요하지 않으며 간단하게 작성할 수 있습니다.

또한 생성자를 정의하는 경우 Listing 1.5.17 과 같이 클래스 이름 뒤에 씁니다.

목록 1.5.17
```
class Human(val name: String) {
    fun showName() {
        println(name)
    }
}
```
인스턴스 생성도 Listing 1.5.18 과 같다.

목록 1.5.18
```
val human = Human("Takehata")
human.showName()
```

## 상속

클래스의 상속에 관한 것입니다. 아울러 상속을 제한하는 기능인, 실드 클래스에 대해서도 설명합니다.

- 클래스를 상속하여 자식 클래스 만들기

먼저 부모 클래스를 Listing 1.5.19 와 같이 정의한다.

Listing 1.5.19
```
open class Animal(val name: String) {
    fun showName() = println("name is $name")
    open fun cries() = println("")
}
```

Kotlin에서는 상속하고 싶은 클래스에는 open 이라는 한정자를 붙여 둘 필요가 있습니다. 이것이 붙어 있지 않은 경우는, 아이 클래스로 상속하려고 했을 때에 컴파일 에러가 됩니다. 또, 함수에 대해서도 오버라이드(override) 시키고 싶은 함수에 대해서는, open 를 붙여 둘 필요가 있습니다. Animal 클래스에서는, cries() 함수만 아이 클래스로 오버라이드(override) 할 수 있도록(듯이) 하고 있습니다.

그리고 Listing 1.5.20 은 open 에서 정의한 Animal 클래스를 상속받은 Dog 클래스이다.

목록 1.5.20
```
class Dog(name: String) : Animal(name) {
    override fun cries() = println("bowwow")
}
```

Kotlin의 상속은 `클래스 이름` 뒤에 : 클래스 이름 의 형태로 부모 클래스를 설명합니다. 부모 클래스에 생성자가 있는 경우도 여기서 설명합니다. 또한 자식 클래스에서 생성자 속성을 추가하려면 Listing 1.5.21 과 같이 작성한다.

목록 1.5.21
```
class Dog(name: String, age: Int) : Animal(name) {
    // 생략
}
```

클래스의 생성자 에 부모 클래스 ( Animal )의 인수인 name 과, 추가하는 age 를 기술해, 상속처 클래스의 정의로 name 를 Animal 의 인수에 건네주고 있습니다.

- 실드 클래스에서 상속 제한

실드 클래스는 상속 대상이 제한된 클래스입니다. Listing 1.5.22 와 같이 클래스 이름에 seald 를 붙이면, 이 클래스는 다른 파일의 클래스로부터 상속할 수 없게 된다.

목록 1.5.22
```
sealed class Platform {
    abstract fun showName()
}
```

Listing 1.5.23 과 같이, 같은 파일내에서 정의된 클래스에서는 상속하는 것이 가능해진다.

목록 1.5.23
```
sealed class Platform {
    abstract fun showName()
}

class AndroidPlatform: Platform() {
    override fun showName() {
        println("Android.")
    }
}

class IosPlatform: Platform() {
    override fun showName() {
        println("iOS.")
    }
}
```

## 인터페이스

인터페이스 정의는 클래스와 비슷하지만 Listing 1.5.24 와 같이 interface 를 사용하여 인터페이스 이름을 선언하고 그 안의 블록에서 함수를 정의한다.

Listing 1.5.24
```
interface Greeter {
    fun hello()
}
```

그리고 Listing 1.5.25 와 같이 기술함으로써 인터페이스를 구현할 수 있다. 클래스의 상속과 같이, 클래스명의 뒤에 : 인터페이스명의 형태로 기술합니다.

목록 1.5.25
```
class GreeterImpl: Greeter {
    override fun hello() {
        println("Hello.")
    }
}
```

## 컬렉션

Kotlin에는 List, Map, Set 등의 컬렉션이 있습니다. 이 3개의 컬렉션에 대해서, 간단하게 사용법을 소개합니다.

- 목록

우선은 List입니다. Listing 1.5.26 과 같이 listOf 라는 함수에 타입을 지정하여 List 타입의 인스턴스를 생성할 수 있다. 그리고 요소의 값을 얻으려면 변수 이름에 [] 로 인덱스 번호를 지정하십시오.

목록 1.5.26
```
val intList: List<Int> = listOf<Int>(1, 2, 3)
println(intList)
println(intList[1])

val stringList: List<String> = listOf<String>("one", "two", "three")
println(stringList)
println(stringList[1])
```

-> 실행 결과
```
[1, 2, 3]
2
[one, two, three]
two
```

인덱스 번호는 0부터 시작합니다. 여기서 1을 지정하므로 두 번째 요소가 검색됩니다.

또한 listOf 함수는 형식 추론이 효과가 있으므로 목록 1.5.27 과 같이 <> 를 생략할 수 있습니다.

목록 1.5.27
```
val intList = listOf(1, 2, 3)
val stringList = listOf("one", "two", "three")
```

인스턴스를 생성한 후 요소를 추가하려면 mutableListOf 함수를 사용하여 MutableList 유형의 인스턴스를 생성하고 add 함수를 실행합니다. List 형은 변경 불가의 List 이며, add 함수가 존재하지 않습니다 ( 리스트 1.5.28 ).

목록 1.5.28
```
val immutableList: List<Int> = listOf(1, 2, 3)
immutableList.add(4) // コンパイルエラー
val mutableList: MutableList<Int> = mutableListOf(1, 2, 3)
mutableList.add(4)
```

-> 컴파일 오류
```
Unresolved reference: add
```

- Map

Map은 Listing 1.5.29 와 같이 mapOf 함수를 사용하여 key to value 형식으로 지정하여 Map 유형의 인스턴스를 생성할 수 있다. listOf 와 마찬가지로 <> 에서 형식 지정이 필요하지만 형식 추론이 효과가 있으므로 생략 할 수 있습니다. 그리고 map 의 값은, 변수명에 [ ] 로 Map의 key를 지정하는 것으로 취득할 수 있습니다.

Listing 1.5.29
```
val map: Map<Int, String> = mapOf(1 to "one", 2 to "two", 3 to "three")
println(map)
println(map[2])
```

-> 실행 결과
```
{1=one, 2=two, 3=three}
two
```

여기에서는 2를 지정하고 있으므로, 해당 요소의 value인 two가 취득되고 있습니다.

또한 자주 사용하는 함수로 containsKey 가 있습니다. Listing 1.5.30 과 같이 key의 값을 인수로 지정하면, 그 key에 해당하는 요소가 존재하는지를 판정해, Boolean형의 값을 돌려줍니다.

목록 1.5.30
```
val map = mapOf(1 to "one", 2 to "two", 3 to "three")
println(map.containsKey(3))
println(map.containsKey(4))
```
-> 실행 결과
```
true
false
```

여기에서는 key가 존재하지 않는 4를 지정했을 때에, false를 반환하고 있습니다.

그리고 Map도 List와 같이, 변경 불가의 오브젝트가 되고 있습니다. 요소를 추가하려면 Listing 1.5.31 과 같이 mutableMapOf 함수를 사용하여 MutableMap 유형의 인스턴스를 생성하고 변수 이름에 [] 로 key를 지정하고 값을 할당하면 됩니다.

목록 1.5.31
```
val immutableMap: Map<Int, String> = mapOf(1 to "one", 2 to "two", 3 to "three")
immutableMap[4] = "four" // コンパイルエラー
val mutableMap: MutableMap<Int, String> = mutableMapOf(1 to "one", 2 to "two", 3 to "three")
mutableMap[4] = "four"
```

-> 컴파일 오류
```
Unresolved reference. None of the following candidates is applicable because of receiver type mismatch:
```

여기에서는 4라는 key로, four라는 value를 가진 요소를 추가하고 있습니다.

- Set

Set는 Listing 1.5.32 와 같이 setOf 함수를 사용하여 Set 타입의 인스턴스를 생성할 수 있다. 이쪽도 listOf 와 같이 형태 추론을 사용해, 형태의 지정은 생략하고 있습니다.

목록 1.5.32
```
val set = setOf("one", "two", "three")
println(set)
```

-> 실행 결과
```
[one, two, three]
```

Set에서는 자주 사용하는 함수로서 contains 가 있습니다. 인수로 건네받은 값이 요소에 존재하는지를 판정해, Boolean 형의 값을 돌려줍니다 ( 리스트 1.5.33 ).

목록 1.5.33
```
val set = setOf("one", "two", "three")
println(set.contains("three"))
println(set.contains("four"))
```

-> 실행 결과
```
true
false
```

여기서는 존재하지 않는 four를 전달했을 때 false를 반환합니다.

또 List나 Map와 같이, 변경 불가의 오브젝트가 되고 있습니다. 요소를 추가하려면 Listing 1.5.34 와 같이 mutableSetOf 함수를 사용하여 MutableSet 유형의 인스턴스를 생성하고 add 함수를 호출하여 값을 지정할 수 있습니다.

목록 1.5.34
```
val immutableSet = setOf("one", "two", "three")
immutableSet.add("four") // コンパイルエラー
val mutableSet = mutableSetOf("one", "two", "three")
mutableSet.add("four")
```

-> 컴파일 오류
```
Unresolved reference: add
```




참고 1　 다른 JVM 언어로는 Scala, Groovy 등이 있습니다.

( 본문으로 돌아가기 )

주 2　 Dmitry Jemerov, Svetlana Isakova, 나가사와 타로, 후지와라 세이, 야마모토 준헤이, yy_yank 감역, 마이 네비게이션 출판, 2017년

( 본문으로 돌아가기 )

注3 　 https://kotlinlang.org/docs/native-overview.html

( 본문으로 돌아가기 )

주 4 　 https://kotlinlang.org/docs/js-overview.html

( 본문으로 돌아가기 )

注5 　 https://kotlinlang.org/docs/multiplatform.html

( 본문으로 돌아가기 )

注6 　 https://www.jetbrains.com/ja-jp/idea/download/#section=mac

( 본문으로 돌아가기 )

注7 　 https://www.jetbrains.com/ja-jp/idea/download/#section=windows

( 본문으로 돌아가기 )

注8 　 https://aws.amazon.com/jp/corretto/

( 본문으로 돌아가기 )

注9 　 https://gradle.org/

( 본문으로 돌아가기 )

