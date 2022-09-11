

15:00:49 일 2022-09-11 yos@yscart ~/git-projects/fedora-sh/10-wikijs-docker-by-markdown/markdown-files/Kotlin_서버사이드_프로그래밍_실천개발-epub
Kotlin_서버사이드_프로그래밍_실천개발-epub $ sh ~/lib/lib-run-ibus.sh 
----> ibus exit
====> ibus-daemon &
----> press Enter:

(ibus-daemon:7253): GLib-WARNING **: 15:00:55.292: GChildWatchSource: Exit status of a child process was requested but ECHILD was received by waitpid(). See the documentation of g_child_watch_source_new() for possible causes.

(ibus-daemon:7253): GLib-WARNING **: 15:00:55.293: GChildWatchSource: Exit status of a child process was requested but ECHILD was received by waitpid(). See the documentation of g_child_watch_source_new() for possible causes.
^C
15:01:06 일 2022-09-11 yos@yscart ~/git-projects/fedora-sh/10-wikijs-docker-by-markdown/markdown-files/Kotlin_서버사이드_프로그래밍_실천개발-epub
Kotlin_서버사이드_프로그래밍_실천개발-epub $ sh ~/lib/lib-run-ibus.sh 
IBus에 연결 할 수 없습니다.
----> ibus exit
====> ibus-daemon &
----> press Enter:

15:01:41 일 2022-09-11 yos@yscart ~/git-projects/fedora-sh/10-wikijs-docker-by-markdown/markdown-files/Kotlin_서버사이드_프로그래밍_실천개발-epub
Kotlin_서버사이드_프로그래밍_실천개발-epub $ 







# 제2부 Kotline 서버사이드 개발

## 제4장　웹 애플리케이션 개발의 기반이 되는 Spring Boot 도입

이 장에서는 Spring Boot라는 프레임워크를 사용하여 웹 애플리케이션의 서버측 프로그램을 구현하는 방법을 설명합니다. Kotlin에서 웹 애플리케이션을 개발할 때 프레임워크를 사용하는 것이 필수적입니다. 다양한 프레임워크 중에서도 Spring Boot는 특히 메이저가 되고 있어, 제6장으로부터 개발하는 실천의 어플리케이션에서도 사용하고 있어, 아키텍쳐의 베이스가 되는 지식이 되어 옵니다. 여기까지의 장은 Kotlin이라고 하는 언어 자체에 대한 설명이었습니다만, 여기에서 드디어 「서버 측 Kotlin」의 개발을 체감해 주셨으면 합니다.

### 1　Spring Boot 소개

#### Spring Boot란?

Spring Boot Note 1 은 웹 애플리케이션 프레임워크 중 하나입니다. Java의 프레임워크로서 가장 주요한 것의 하나로, 많은 서버 어플리케이션으로 사용되고 있습니다.

Spring Framework 주2 라고 하는 프레임워크가 있어, 원래는 DI(Dependency Injection, 의존성 주입)나 AOP(Aspect Oriented Programming, 애스펙트 사고 프로그래밍)를 서포트하는 것이었습니다. 릴리스 후에 많은 기능이 만들어져, 웹 어플리케이션 개발을 위한 Spring MVC, 인증·인가를 구현하기 위한 Spring Security 등 다양한 프레임워크 주3 의 집합체가 되고 있습니다.

그 다양한 프레임워크를 개별적으로 사용하는 것이 아니라, 정리해 사용하기 쉬운 형태로 해 웹 어플리케이션 개발을 간단하게 할 수 있도록 한 것이 Spring Boot가 됩니다.

#### Spring Framework의 Kotlin 지원

Spring Framework는 5계에서 공식적으로 Kotlin 대응을 시작하고 있습니다. Spring Boot에서 말하면 2계가 Spring Framework 5계에 대응한 버전입니다. 4계 이전의 버전에서도 사용할 수 있습니다만, 프레임워크측의 코어인 부분에서도 Kotlin에서의 이용을 상정해 대응해 주는 것으로, 보다 사용하기 쉬워집니다. 또, 향후의 Kotlin, Spring Framework 각각의 업데이트에 즈음해도, 동작의 보증이 보다 강해져 갈 것으로 기대됩니다.

#### Spring Initializr에서 프로젝트의 병아리 만들기

먼저 Kotlin을 사용한 Spring Boot 프로젝트를 만듭니다. Spring Boot에는 Spring Initializr 주 4 라는 사이트가 준비되어 있으며 여기에서 프로젝트병아리히나모양가타만들 수 있습니다. 다음 항목을 입력하고 [GENERATE] 버튼을 누르면 설정한 항목에 따른 프로젝트의 zip이 다운로드됩니다( 그림 4.1 ).

- Project -- 빌드 도구 선택 (Maven Project, Gradle Project)
- Language -- 언어 선택 (Java, Kotlin, Groovy)
- Spring Boot -- Spring Boot 버전
- Project Metadata -- 만들 프로젝트의 다양한 설정
- Dependencies -- 추가할 종속성

그림 4.1 Spring Initializr

이 설명서의 샘플에서는 다음 설정으로 설정했습니다.

- 프로젝트: Gradle
- 언어: 코틀린
- Spring Boot: 2.4.3(글쓰기 시 ​​기본값)
- Project Metadata: 모두 기본값
- 종속성: Spring Web、Thymeleaf

Spring Boot에서는 다른 라이브러리와 프레임워크를 함께 사용하기 위한 종속성을 추가해주는 starter라고 불리는 모듈이 준비되어 있습니다. Dependencies에서 선택하면 프로젝트를 만들 때 미리 종속성을 추가할 수 있습니다. 여기에서는 Spring MVC, Jackson과 같은 Web API 개발에 필요한 프레임워크를 사용하기 위한 Spring Web과 템플릿 엔진인 Thymeleaf를 선택하고 있습니다. 추가한 종속성에 대해서는 나중에 프로젝트 내용을 보면서 다시 설명합니다.

#### 만든 프로젝트 배포

Spring Initializr에서 demo.zip이라는 파일이 다운로드되었다고 생각합니다. 이 파일을 원하는 곳에 배포하십시오. 그런 다음 확장된 파일을 IntelliJ IDEA에서 엽니다. 메뉴에서 [File] → [Open]을 선택하고 확장 된 demo 디렉토리 바로 아래에있는 build.gradle.kts를 엽니 다 ( 그림 4.2 ).

그림 4.2 File-Open

그림 4.3 과 같은 팝업이 열리므로 [Open as Project]를 누르십시오. 이제 IntelliJ IDEA에서 Gradle 프로젝트로 demo가 열립니다.

그림 4.3 Open as Project

Project 보기에는 그림 4.4 와 같은 파일이 표시되어 있다고 생각합니다.

그림 4.4 프로젝트의 폴더 및 파일

#### build.gradle.kts──Kotlin으로 작성된 Gradle 구성 파일 확인

프로젝트 바로 아래에 있는 build.gradle.kts를 엽니다. 제1장의 「4.환경 구축과 최초의 프로그램의 실행」에서 조금 소개했습니다만, Kotlin으로 기술된 Gradle의 설정 파일입니다. 현재 Spring Initializr에서 Kotlin을 선택하여 만들어진 프로젝트는이 build.gradle.kts가 사용됩니다.

파일의 내용은 앞서 설명한 Spring Initializr에서 설정한 항목이 반영된 형태로 만들어집니다( 목록 4.1.1 ).

목록 4.1.1
```
  1: import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
  2:
  3: plugins {
  4:     id("org.springframework.boot") version "2.4.3"
  5:     id("io.spring.dependency-management") version "1.0.11.RELEASE"
  6:     kotlin("jvm") version "1.4.30"
  7:     kotlin("plugin.spring") version "1.4.30"
  8: }
  9:
 10: group = "com.example"
 11: version = "0.0.1-SNAPSHOT"
 12: java.sourceCompatibility = JavaVersion.VERSION_11
 13:
 14: repositories {
 15:     mavenCentral()
 16: }
 17:
 18: dependencies {
 19:     implementation("org.springframework.boot:spring-boot-starter-thymeleaf")
 20:     implementation("org.springframework.boot:spring-boot-starter-web")
 21:     implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
 22:     implementation("org.jetbrains.kotlin:kotlin-reflect")
 23:     implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
 24:     testImplementation("org.springframework.boot:spring-boot-starter-test")
 25: }
 26:
 27: tasks.withType<KotlinCompile> {
 28:     kotlinOptions {
 29:         freeCompilerArgs = listOf("-Xjsr305=strict")
 30:         jvmTarget = "11"
 31:     }
 32: }
 33:
 34: tasks.withType<Test> {
 35:     useJUnitPlatform()
 36: }
```

4~7행의 Kotlin, Spring Boot 등의 버전은, 작성시의 지정이나, 그 시점에서의 최신 버전의 상황에 따라 바뀝니다. 주요 사항에 대해 몇 가지 설명합니다.

- plugins──Gradle 작업에 사용할 플러그인

Listing 4.1.1 의 3-8 행의 plugins 블록은 사용할 Gradle 플러그인을 정의한다.

첫째, 다음 두 가지는 Spring Boot 관련 플러그인입니다.

- 아이디("org.springframework.boot")
- id("io.spring.dependency-management")

org.springframework.boot 는 Spring Boot 애플리케이션을 Gradle에서 실행하는 데 필요합니다. 아래에 설명하는 bootRun이라는 부팅 작업을 제공합니다.

io.spring.dependency-management 는 종속성 관리를 지원하는 플러그인입니다. Spring Boot의 starter 관련 종속성을 추가할 때 org.springframework.boot 의 정의에서 지정한 버전에 맞는 것을 가져옵니다. 따라서 아래에 설명된 dependencies 블록에서 지정한 일부 starter에서도 버전 지정을 생략합니다.

둘째, 다음 두 가지는 Kotlin 관련 플러그인입니다.

- 코틀린("jvm")
- kotlin("플러그인.스프링")

id 가 아닌 kotlin 이라는 함수로 묶는 것은 Kotlin DSL의 독자적인 설명입니다. Kotlin 관련 플러그인의 설명을 단순화하기위한 것이며 실제로는 목록 4.1.2 와 비슷한 의미입니다.

목록 4.1.2
```
id("org.jetbrains.kotlin.jvm") version "1.4.30"
id(""org.jetbrains.kotlin.plugin.spring") version "1.4.30"
```

Gradle에서 Kotlin 프로젝트를 빌드하고 Kotlin에서 Spring Boot를 사용하는 데 필요합니다.

##### dependencies - 애플리케이션에서 사용하는 종속성

Listing 4.1.1 의 18-25 행의 dependencies 블록은 애플리케이션에 필요한 종속성을 추가한다. Spring Initializr에서 생성 할 때 두 개의 종속성을 추가했으므로 여기에 반영됩니다. 19, 20행째가 그 해당 개소입니다. 각각 다음과 같은 역할이 됩니다.

- spring-boot- starter -thymeleaf …
- spring-boot-starter-web…… 라우팅 등 웹 애플리케이션의 서버측 프로그램에서 필요한 기능을 제공하는 starter

이와 같이 사용하고 싶은 starter를 설정해 두면 종속성에 추가한 상태의 Gradle 파일이 만들어집니다.

jackson-module-kotlin 은 JSON을 직렬화하고 deserialize하는 Jackson 주 6 이라는 라이브러리를 사용하기위한 모듈입니다. 나중에 설명하는 API 요청, 응답을 JSON에서 상호 작용할 때 사용됩니다.

spring-boot-starter-test 는 테스트 모듈입니다. Spring Boot 애플리케이션의 테스트 코드를 구현할 수 있습니다 (이 장에서는 사용하지 않음).

#### 생성된 Spring Boot 애플리케이션 시작

이 프로젝트의 Spring Boot 응용 프로그램을 시작합니다. DemoApplication.kt라는 파일을 열면 Listing 4.1.3 의 내용의 코드가 된다.

목록 4.1.3
```
@SpringBootApplication
class DemoApplication

fun main(args: Array<String>) {
runApplication<DemoApplication>(*args)
}
```

이 @SpringBootApplication 이라는 주석이 달린 클래스가 응용 프로그램을 시작하는 클래스입니다. 이 클래스의 main 함수를 실행 합니다 .

Listing 4.1.4 와 같은 로그가 출력되면 시작 성공이다.

목록 4.1.4
```
INFO 60701 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat started on port(s): 8080 (http) with context path ''
INFO 60701 --- [           main] com.example.demo.DemoApplicationKt       : Started DemoApplicationKt in 3.701 seconds (JVM running for 4.792)
```

응용 프로그램은 bootRun이라는 Gradle 태스크를 실행하여 실행할 수 있습니다. 커맨드 라인에서 프로젝트 바로 아래에서 명령 4.1.5 와 같이 실행하거나 IntelliJ IDEA의 Gradle 뷰에서 [Tasks] → [application] → [bootRun]을 선택 ( 그림 4.5 )하여 실행합니다.

명령 4.1.5
```
$ ./gradlew bootRun
```

그림 4.5 application-bootRun 선택

IntelliJ IDEA에서 시작하면 응용 프로그램이 중지되면 오른쪽 상단에 표시된 사각형 정지 버튼 (시작 중에 빨간색으로 표시됨)을 누릅니다 ( 그림 4.6 ).

그림 4.6 사각형 정지 버튼

명령으로 시작한 경우 Mac에서는 control + C , Windows에서는 Ctrl + C 를 시작하는 터미널에서 입력하면 중지 할 수 있습니다.

#### 테스트 페이지 작성 및 동작 확인

응용 프로그램이 시작되었지만 라우팅이 아무 것도 구성되지 않았기 때문에 어디에도 액세스할 수 없습니다. 테스트 페이지를 표시하는 프로그램을 작성합니다. 프로젝트의 src/main/kotlin 디렉토리의 com.example.demo 패키지 아래에 Listing 4.1.6 의 HelloController 클래스를 생성한다.

목록 4.1.6
```
@Controller
class HelloController {
    @GetMapping("/")
    fun index(model: Model): String {
        model.addAttribute("message", "Hello World!")
        return "index"
    }
}
```

@Controller 라는 주석이 달린 클래스에서 라우팅을 할 수 있습니다. @GetMapping 에 인수로 전달하는 값이 라우팅 경로이며 여기에서 / (루트)를 지정합니다. 이제 HTTP 메소드가 GET에서 루트 경로에 액세스되면 index 함수가 호출됩니다. 나중에 나오는데 HTTP 메소드마다 @PostMapping , @DeleteMapping 같은 주석이 있습니다.

그리고 여기에서는 위의 종속성으로 추가했던 Thymeleaf라는 템플릿 엔진을 사용하고 있습니다. 인수에서 사용하는 Model 이라는 클래스는 템플릿의 HTML에 값을 전달하는 데 사용됩니다. message 라는 속성에 " Hello World! "문자열을 전달하고 있습니다. 반환 값으로 반환하는 문자열은 HTML 파일 이름입니다. 이에 따라 index.html이라는 파일을 프로젝트의 src/main/resources/templates 아래에 작성하고 Listing 4.1.7 의 내용을 작성한다.

목록 4.1.7
```
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>Hello World!</title>
</head>
<body>
<p th:text="${message}"></p>
</body>
</html>
```

${message} 로 작성하면 HelloController 에서 설정한 message 속성의 값을 사용할 수 있습니다.

응용 프로그램을 다시 시작하고 http://localhost:8080에 액세스하면 그림 4.7 의 화면이 표시됩니다.

그림 4.7 응용 프로그램 시작

라우팅에서 설정한 루트 경로에 액세스하고 message 속성에 설정한 Hello World! 가 표시됩니다. 이제 Spring Boot 애플리케이션의 동작을 확인할 수 있었습니다.

또한 라우팅은 @RequestMapping 이라는 주석을 사용하여 클래스에 대해서도 설정할 수 있습니다 ( 목록 4.1.8 ).

목록 4.1.8
```
@Controller
@RequestMapping("hello")
class HelloController {
    @GetMapping("/world")
    fun index(model: Model): String {
        model.addAttribute("message", "Hello World!")
        return "index"
    }
}
```

이제 이 클래스에 정의된 라우팅에 대한 액세스는 반드시 /hello 가 붙는 형태가 됩니다. index 는 @GetMapping 에서 /world 를 지정하므로 경로는 /hello/world입니다. 이제 경로를 클래스와 함수의 계층 구조로 정의하고 공통화할 수 있습니다.

### 2　Spring Boot에서 REST API 구현

JSON에서 요청, 응답을 교환하는 소위 REST API를 만듭니다.

#### 쿼리 문자열로 요청 받기

먼저 Listing 4.2.1 의 클래스를 작성한다.

목록 4.2.1
```
@RestController
@RequestMapping("greeter")
class GreeterController {
    @GetMapping("/hello")
    fun hello(@RequestParam("name") name: String): HelloResponse {
        return HelloResponse("Hello ${name}")
    }
}
```

여기에서는 @RestController 의 주석을 붙입니다. 이제 반환 값의 객체를 JSON으로 직렬화하고 응답으로 반환합니다. 또한 요청은 함수의 인수로 @RequestParam 을 사용하여 지정합니다. 이 어노테이션의 인수로 전달한 이름의 파라미터를 쿼리 스트링으로 받아, 뒤의 변수에 들어갑니다.

리스폰스의 형태로서 지정하고 있는 HelloResponse 클래스를, 리스트 4.2.2 와 같이 데이터 클래스로 만듭니다.

목록 4.2.2
```
data class HelloResponse(val message: String)
```

응용 프로그램을 시작하고 터미널에서 명령 4.2.3 과 같이 실행할 수 있습니다.

명령 4.2.3
```
$ curl http://localhost:8080/greeter/hello?name=Naoto
{"message":"Hello Naoto"}
```

데이터 클래스의 속성 이름과 값을 사용하여 JSON으로 반환되는 것을 볼 수 있습니다.

#### 경로 매개변수로 요청 수신

GreeterController 클래스에 Listing 4.2.4 의 함수를 추가한다.

목록 4.2.4
```
@GetMapping("/hello/{name}")
fun helloPathValue(@PathVariable("name") name: String): HelloResponse {
    return HelloResponse("Hello $name")
}
```

경로의 매개 변수를 넣고 싶은 곳에 {} 로 묶어 이름을 정의하고, 그 이름을 @PathVariable 어노테이션의 인수에 건네주는 것으로 지정하고 있습니다. @RequestParam 과 마찬가지로 뒤의 인수는 매개 변수로받은 값을 포함합니다.

그런 다음 명령 4.2.5 와 같이 실행합니다.

명령 4.2.5
```
$ curl http://localhost:8080/greeter/hello/Kotlin
{"message":"Hello Kotlin"}
```

#### JSON으로 요청 받기

요청도 JSON에서 수신하려면 Listing 4.2.6 과 같이 구현한다. 여기도 GreeterController 클래스에 함수를 추가하십시오.

목록 4.2.6
```
@PostMapping("/hello")
fun helloByPost(@RequestBody request: HelloRequest): HelloResponse {
    return HelloResponse("Hello ${request.name}")
}
```

여기서는 경로 지정에 @PostMapping 을 사용하고 있지만, 이것을 사용하면 HTTP 메소드가 POST에서 받아들이게 됩니다. 그리고 인수는 @RequestBody 어노테이션을 붙이고 타입으로서 응답처럼 데이터 클래스의 객체를 지정한다. HelloRequest 클래스는 Listing 4.2.7 과 같이 만든다.

목록 4.2.7
```
data class HelloRequest(val name: String)
```

실행은 Content-Type 으로 application / json 을 지정하고 요청 본문에 HelloRequest 클래스와 동일한 구성의 JSON을 전달하여 호출합니다 ( 명령 4.2.8 ).

명령 4.2.8
```
$ curl -H 'Content-Type:application/json' -X POST -d '{"name":"Kotlin"}' http://localhost:8080/greeter/hello
{"message":"Hello Kotlin"}
```

### 3　Spring Framework DI 사용

이 장의 시작 부분에서 조금 썼지만 Spring Framework의 주요 기능으로 DI가 있습니다. Spring Framework를 사용하면 반드시 말해도 좋을 정도로 사용하는 기능으로, 그 구현 방법에 대해서도 몇 가지 패턴이 있으므로, 여기에서 설명해 갑니다.

#### DI란?

DI는 Dependency Injection(의존성 주입)의 약자입니다. 말이 어렵기 때문에 조금 이해하기 어렵지만, 간단히 말하면 각 클래스에서 사용하는 객체의 생성을 자동화해주는 것입니다. 예를 들어, Listing 4.3.1 과 같은 코드가 있다고 가정한다.

목록 4.3.1
```
class Executor {
    fun execute() {
        val greeter = Greeter()
        greeter.hello()
    }
}
```

Greeter 라는 클래스의 인스턴스를 생성하고 hello 함수를 실행하고 있습니다. DI를 사용하면 Listing 4.3.2 와 같은 쓰기 방식으로 이것을 구현할 수 있다.

목록 4.3.2
```
class Executor(private val greeter: Greeter) {
    fun execute() {
        greeter.hello()
    }
}
```

자세한 내용은 후술합니다만, 생성자에 Greeter형의 인수를 정의해 두면, 프레임워크측에서 인스턴스의 생성을 해, 이 인수 greeter 에 넣어 줍니다. 「의존성의 주입」이라고 하는 것은, 이와 같이 인스턴스를 생성해 「주입」해 주는 것을 가리키고 있습니다. 이 예만으로는 조금 알기 어려울지도 모릅니다만, 예를 들어 같은 클래스내의 복수 개소에서 오브젝트를 사용 돌리는 경우 등, 매번 인스턴스의 생성을 할 필요가 없어집니다.

또한 Spring Framework에서 DI 한 객체는 싱글 톤이됩니다. 응용 프로그램이 시작될 때 생성되며 DI 컨테이너라는 영역에 등록되어 사용됩니다. 처리가 실행될 때마다 인스턴스가 생성되는 일이 없어져, 메모리 효율의 면 등에서도 유효하게 됩니다.

#### DI 대상 클래스 만들기

우선, DI의 대상이 되는 인터페이스, 클래스를 작성합니다. Listing 4.3.3 의 인터페이스와 그것을 구현한 Listing 4.3.4 의 클래스를 생성한다.

목록 4.3.3
```
interface Greeter {
    fun sayHello(name: String): String
}
```

목록 4.3.4
```
@Component
class GreeterImpl : Greeter {
    override fun sayHello(name: String) = "Hello $name"
}
```

Spring Framework를 사용한 구현에서는, 인터페이스에 대한 구현 클래스에 「인터페이스명＋Impl」라고 하는 명명 규칙으로 이름을 붙이는 것이 많습니다(Implement=구현한다, 의 약어).

또, 구현 클래스에는 @Component 어노테이션이 붙어 있습니다. 이것은 DI의 대상인 것을 나타내는 어노테이션으로, 후술하는 각종 인젝션의 처리로 대상 클래스로 하기 위한 것이 됩니다. 이 설명뿐이라고 잘 모르겠다고 생각하기 때문에, 실제의 DI를 사용한 구현과 아울러 설명해 갑니다.

#### 생성자 주입

Spring Framework는 여러 가지 DI 방법을 제공합니다. 우선은 가장 자주(잘) 사용되는 생성자 인젝션으로부터입니다. 이것은 Spring Framework로 추천하는 방법입니다.

GreeterController 의 경우 Listing 4.3.5 와 같이 생성자에서 위에서 설명한 Greeter 유형의 인수를 정의한다.

목록 4.3.5
```
class GreeterController(
    private val greeter: Greeter
) {
    // 생략
}
```

이것만으로 DI에 필요한 정의는 끝입니다. 어플리케이션 기동시에 생성자 에 정의되고 있는 인수의 형태로부터, Spring Framework 가 특정의 구현 클래스를 인젝션 해 줍니다. 이 때에 대상이 되는 것이, 전술의 @Component 어노테이션을 붙인 클래스입니다. 여기에서는 Greeter 형의 인수가 생성자 에 정의되어 있으므로, Greeter 의 구현 클래스에서 @Component 어노테이션이 붙은 클래스, 즉 GreeterImpl 가 인젝션 됩니다.

인젝션한 greeter 의 함수를 호출해 봅니다. GreeterController 클래스에 Listing 4.3.6 의 함수를 추가한다.

목록 4.3.6
```
@GetMapping("/hello/byservice/{name}")
fun helloByService(@PathVariable("name") name: String): HelloResponse {
    val message = greeter.sayHello(name)
    return HelloResponse(message)
}
```

그리고 명령 4.3.7 과 같이 실행하면 GreeterImpl 로 구현한 처리 결과를 사용한 응답이 반환되고 있음을 알 수 있습니다.

명령 4.3.7
```
$ curl http://localhost:8080/greeter/hello/byservice/Spring
{"message":"Hello Spring"}
```

#### 필드 주입

다음은 필드 주입입니다. Listing 4.3.5 에서는 생성자에 작성된 greeter 의 정의를 Listing 4.3.8 과 같이 클래스의 필드로 정의하도록 작성한다.

목록 4.3.8
```
@RestController
@RequestMapping("greeter")
class GreeterController {
    @Autowired
    private lateinit var greeter: Greeter

    // 생략
}
```

여기 @Autowired 주석을 사용합니다. 이것을 붙이는 것으로 DI의 대상이 되는 필드인 것을 나타냅니다. constructor 인젝션과 같이, 이 필드의 형태에 응해 구현 클래스를 인젝션해 줍니다.

또 다른 포인트는 lateinit var 로 정의하는 것입니다. 이 필드에의 인젝션은, 변수의 로드와 동시에 초기화되는 것이 아니고, 나중에 인젝션되기 때문에 var 로서 정의해 둘 필요가 있기 (위해)때문에입니다.

#### 세터 인젝션

또 하나, 세터 인젝션이라는 방법도 있습니다. 이것은 주입 대상 필드와 그에 대한 세터를 정의하여 주입하는 방법입니다. Kotlin의 경우는 필드를 var 로 정의하는 것과 동시에 세터도 만들어지므로, Listing 4.3.9 와 같이 쓰는 방법이 됩니다.

목록 4.3.9
```
@RestController
@RequestMapping("greeter")
class GreeterController {
    var greeter: Greeter? = null
        @Autowired
        set(value) {
            field = value
        }

    // 생략
}
```

확장 속성에서 사용자 지정 세터를 정의하고 이에 @Autowired 어노테이션을 추가합니다. 그러나 사용자 정의 setter를 정의하면 lateinit 한정자를 사용할 수 없으므로 초기화가 필요합니다. 그 때문에 필드의 형태도 Null 허가로 정의하고 있어 호출시도 Null 체크등의 대응이 필요하게 됩니다.

#### 하나의 인터페이스에 대해 여러 클래스가 있는 경우

여기까지 소개한 예는 인터페이스에 대해 하나의 구현 클래스만 있었지만, 여러 구현 클래스가 있는 경우 Spring Framework 측에서 어떤 클래스를 주입할지 판별할 수 없습니다. 따라서 어떤 클래스를 주입할 것인지 명시적으로 정의해야 합니다.

예를 들어 , Listing 4.3.10 의 MessageService 를 구현하는 JapaneseMessageService , EnglishMessageService 가 있다고 가정한다 ( Listing 4.3.11 , 4.3.12 ). 이 두 구현 클래스는 @Component 어노테이션에 매개 변수로 이름을 부여합니다.

목록 4.3.10
```
interface MessageService {
    // 생략
}
```

목록 4.3.11
```
@Component("JapaneseMessageService")
class JapaneseMessageService : MessageService {
    // 생략
}
```

목록 4.3.12
```
@Component("EnglishMessageService")
class EnglishMessageService : MessageService {
    // 생략
}
```

알기 쉽게 클래스명과 동일하게 하고 있습니다만, 임의의 이름으로 문제 없습니다. 그리고 호출자의 클래스에서 주입하려면 Listing 4.3.13 과 같이 작성한다.

목록 4.3.13
```
@RestController
@RequestMapping("greeter")
class GreeterController(
    @Qualifier("EnglishMessageService")
    private val messageService: MessageService
) {
    // 생략
}
```

인젝션 대상의 생성자 인수에 @Qualifier 라는 주석을 사용하여 인젝션 대상의 이름을 지정합니다. 여기서 지정하는 것은 위의 @Component 어노테이션에서 지정한 이름입니다 (클래스 이름이 아님). 이제 messageService 는 EnglishMessageService 클래스의 인스턴스를 주입합니다.

여기에서는 생성자 인젝션을 사용하여 설명했지만, 필드 인젝션, 세터 인젝션을 사용하는 경우도 마찬가지입니다.

#### 기본적으로 생성자 주입 사용

현재 Spring Framework에서는 기본적으로 생성자 주입을 사용하는 것이 좋습니다. 주로 다음과 같은 이유가 됩니다.

- 주입 대상 객체를 변경할 수 있음
- 의존하는 대상이 생성자에 늘어서 있기 때문에, 클래스의 책무가 많아졌을 때에 알기 쉽다
- 순환 의존을 막을 수 있다
- 테스트 코드로 Spring Framework에 의존하지 않는 (컨테이너를 사용하지 않는) 형태로 주입하는 객체를 바꿀 수 있습니다.

만약 의존하는 컴퍼넌트를 런타임에 바꾸고 싶은 경우 등은 필드 인젝션을 사용할 수 있을지도 모릅니다만, 가능한 장면은 그다지 많지 않습니다.

6장부터 연습의 응용 프로그램 개발에서도 모든 생성자 주입을 사용합니다. 많은 코드로 본장에서 소개한 기술이 나오므로, 확실히 기억해 두어 주셨으면 합니다.


주1 　 https://spring.io/projects/spring-boot

( 본문으로 돌아가기 )

주2 　 https://spring.io/projects/spring-framework

( 본문으로 돌아가기 )

주3 　 https://spring.io/projects

( 본문으로 돌아가기 )

주4 　 https://start.spring.io/

( 본문으로 돌아가기 )

주5 　 https://www.thymeleaf.org/

( 본문으로 돌아가기 )

주6 　 https://github.com/FasterXML/jackson

( 본문으로 돌아가기 )

주7　 main 함수의 실행 방법은 제1장의 「4. 환경 구축과 최초의 프로그램의 실행」을 참조.

( 본문으로 돌아가기 )

