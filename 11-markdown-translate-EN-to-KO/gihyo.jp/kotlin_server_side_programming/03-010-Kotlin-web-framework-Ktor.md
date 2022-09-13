





## 제10장　Kotlin의 웹 프레임워크 Ktor

이 장에서는 Kotlin의 웹 애플리케이션 프레임 워크인 Ktor를 소개합니다. Ktor는 아직 채용 사례의 수는 많지 않지만, 언어의 개발원인 JetBrains사가 개발하고 있는 Kotlin제의 프레임워크라고 하는 일도 있어, 서버 측 개발의 기술 선정의 새로운 선택지로서 주목받고 있다 합니다. 실제로 도입하고 있는 제품도 서서히 늘어나고 있어, 서버 측 Kotlin을 하는데 있어서 꼭 알고 싶은 내용이 됩니다.

1　Ktor란?
Ktor는 2018년 11월에 정식 버전인 Ver1.0이 출시된 웹 애플리케이션 프레임워크입니다. 현재 서버 측 Kotlin의 개발에서는 Spring Boot가 프레임 워크의 최선의 선택으로 여겨지는 경우가 많지만 새로운 선택으로 기대할 수 있습니다. 언어의 개발원인 JetBrains사가 개발하고 있어, 게다가 Spring Boot와 달리 Kotlin제라고 하는 일도 있어, 기술 선정으로 이름을 들 수 있는 일도 최근에는 많습니다.

Spring Boot는 상당히 중후하고 복잡한 프레임워크가 되어 있어, 쭉 Java로 사용해 온 사람에게는 편리합니다만, 초보자에게는 조금 어려운 면도 있습니다. 그에 비해 Ktor는 경량으로 취급하기 쉬워지고 있어, 어플리케이션의 기동 시간등의 면에서도 유리하게 일합니다. 그래서 아래와 같은 웹 개발에 필요한 다양한 기능(발췌)을 제공하고 있습니다.

울인증, 인가
울HTTP 클라이언트
울웹소켓
울비동기 통신
울로깅
울템플릿
특히 비동기 처리를 특징으로 하며 프레임워크 내에서도 Kotlin Coroutines가 많이 사용되고 있습니다. 비동기 통신을 수행하는 HTTP 클라이언트도 제공됩니다. 자세한 내용은 Ktor 공식 페이지 주 1 을 참조하십시오.

2　Ktor 도입
Ktor에서 프로젝트를 만들고 기본 프로그램을 구현합니다.

Ktor 프로젝트 만들기
먼저 IntelliJ IDEA에 Ktor 플러그인을 설치합니다. 환경 설정에서 플러그인을 선택하고 Marketplace 탭에서 Ktor를 검색하여 표시된 Ktor 플러그인을 설치합니다 ( 그림 10.1 ).

그림 10.1
IntelliJ IDEA를 재시작하고 [File] → [New] → [Project...]를 선택합니다. 프로젝트 유형으로 "Ktor"를 선택할 수 있습니다. 프로젝트의 초기 설정으로 다음 항목을 설정할 수 있습니다.

울프로젝트 이름
울프로젝트 유형(빌드 도구 유형)
울애플리케이션 서버
울Ktor 버전
울필요한 기능(후술)
이 샘플에서는 그림 10.2 의 설정에서 만든 프로젝트를 사용합니다.

그림 10.2
Project는 Gradle의 Kotlin DSL을 사용하고 응용 프로그램 서버로 Netty를 선택합니다. Ktor는 앞서 언급했듯이 비동기 처리를 특징으로 하는 경우도 있어, 비동기 통신을 실시하는 어플리케이션의 프레임워크인 Netty를 사용하는 경우가 많습니다.

나머지는 그림 10.3 , 그림 10.4 와 같이 임의의 프로젝트 이름 등을 입력하고 완료해 주세요 합니다).

그림 10.3
그림 10.4
Ktor의 기능 추가가 가능한 「피쳐」
그림 10.2 의 화면 아래에 있는 Server, Client로 나뉘어 준비되어 있는 선택사항은 Ktor의 「피쳐」라고 하는 것이 됩니다. Ktor는 기본적으로 웹 애플리케이션으로 최소한의 기능만 포함하고 있으며, 이 기능을 추가하여 다양한 기능을 사용할 수 있습니다.

예를 들어 인증, 템플릿 엔진, HTTP 클라이언트, 로깅 등입니다. 이 장에서는 나중에 몇 가지 기능을 사용한 구현을 소개합니다. 이와 같이 프로젝트에 의해 필요한 기능만을 추가하여 사용할 수 있는 것도 경량의 프레임워크가 되고 있는 이유의 하나입니다.

프로젝트의 초기 상태 확인
프로젝트의 초기 상태에서 build.gradle.kts는 Listing 10.2.1 과 같은 설명을 한다.

목록 10.2.1

 import org.jetbrains.kotlin.gradle.dsl.Coroutines
 import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

 val ktor_version: String by project
 val kotlin_version: String by project
 val logback_version: String by project

 plugins {
     application
     kotlin("jvm") version "1.4.30"
 }

 group = "com.example"
 version = "0.0.1"

 application {
     mainClassName = "io.ktor.server.netty.EngineMain"
 }

 repositories {
     mavenLocal()
     jcenter()
 }

 dependencies {
     implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:$kotlin_version")
     implementation("io.ktor:ktor-server-netty:$ktor_version")
     implementation("ch.qos.logback:logback-classic:$logback_version")
     testImplementation("io.ktor:ktor-server-tests:$ktor_version")
 }

 kotlin.sourceSets["main"].kotlin.srcDirs("src")
 kotlin.sourceSets["test"].kotlin.srcDirs("test")

 sourceSets["main"].resources.srcDirs("resources")
 sourceSets["test"].resources.srcDirs("testresources")
Netty에서 Ktor 응용 프로그램을 실행하는 ktor-server-netty 등이 종속성으로 추가되었습니다.

그리고 src 아래에있는 Application.kt ( 목록 10.2.2 )가 응용 프로그램의 시작 프로그램이됩니다.

목록 10.2.2

 fun main(args: Array<String>): Unit = io.ktor.server.netty.EngineMain.main(args)

 @Suppress("unused") // Referenced in application.conf
 @kotlin.jvm.JvmOverloads
 fun Application.module(testing: Boolean = false) {
 }
main 함수를 실행하면 Ktor 애플리케이션이 시작됩니다. 성공하면 Listing 10.2.3 과 같이 8080 포트에서 응답을 수락한다는 로그가 출력됩니다.

목록 10.2.3

 [main] INFO  Application - Responding at http://0.0.0.0:8080
라우팅 추가
Spring Boot의 응용 프로그램과 마찬가지로 시작만으로는 아직 액세스 할 수있는 경로가 없으므로 아무 것도 할 수 없습니다. 라우팅을 추가하고 동작 확인을 해 나갑니다.

Application.kt를 Listing 10.2.4 와 같이 다시 작성한다.

목록 10.2.4

 fun main(args: Array<String>): Unit = io.ktor.server.netty.EngineMain.main(args)

 @Suppress("unused") // Referenced in application.conf
 @kotlin.jvm.JvmOverloads
 fun Application.module(testing: Boolean = false) {
     routing {
         get("/") {
             call.respondText("Hello Ktor!")
         }
     }
 }
라우팅 은 Application 클래스의 확장 함수로, 이 블록 내에서 라우팅을 정의할 수 있습니다. 여기에서는 get 을 사용해, GET 메소드로 루트 패스로 받아들이는 처리를 정의하고 있습니다. call.respondText 는 문자열을 응답으로 반환하는 처리입니다.

터미널에서 명령 10.2.5 의 curl 명령을 실행하거나 브라우저에서 http://localhost:8080에 액세스하여 "Hello Ktor!"가 표시되면 성공합니다.

명령 10.2.5

 $ curl http://localhost:8080
 Hello Ktor!
요청 매개변수 추가
그런 다음 GET 요청에 매개변수를 추가합니다.

경로 파라미터
경로 파라미터는 Listing 10.2.6 과 같이 기술한다. Listing 10.2.4 의 Application.kt의 라우팅 블록에 추가한다.

목록 10.2.6

 get("/hello/{name}") {
     val name = call.parameters["name"]
     call.respondText("Hello $name!")
 }
경로의 문자열 안에 {} 로 묶은 이름으로 정의하고 call.parameters 에 이름을 지정하여 값을 얻을 수 있습니다.

curl 명령 ( 명령 10.2.7 ) 또는 브라우저에서 "http://localhost:8080/hello/ 이름"과 매개 변수를 제공하여 액세스하면 전달 된 값이 포함 된 메시지가 반환됩니다.

명령 10.2.7

 $ curl http://localhost:8080/hello/Takehata
 Hello Takehata!
쿼리 문자열
쿼리 문자열은 Listing 10.2.8 과 같이 구현된다.

목록 10.2.8

 get("/hello") {
     val name = call.parameters["name"]
     call.respondText("Hello $name!")
 }
받는 방법은 경로 매개 변수와 유사하며 call.parameters 를 사용합니다. 지정한 이름으로 쿼리 문자열을 부여하고 요청하면 값을 검색할 수 있습니다.

여기도 curl 명령( 명령 10.2.9 ), 혹은 브라우저로부터 「http://localhost:8080/hello?name=이름」이라고 쿼리 스트링을 주어 요구하면, 건네준 값이 들어간 메세지가 반환됩니다.

명령 10.2.9

 $ curl http://localhost:8080/hello?name=Takehata
 Hello Takehata!
라우팅 정의 잘라내기
앞의 예에서는 라우팅 블록에 정의를 추가했지만 다른 위치로 함께 잘라낼 수도 있습니다. 임의의 파일을 작성하고 Listing 10.2.10 과 같이 정의한다 (Application.kt 파일에서 최상위 레벨에서 정의해도 괜찮다).

목록 10.2.10

 fun Routing.greetingRoute() {
     get("/") {
         call.respondText("Hello Ktor!")
     }
 }
Routing 클래스의 확장 함수로서 greetingRoute 함수(이름은 임의)를 작성해, 그 안에 라우팅을 정의합니다. 그리고 Application.kt에서 Listing 10.2.11 과 같이 호출한다.

Listing 10.2.11 (Application.kt의 일부를 발췌)

 @Suppress("unused")
 @kotlin.jvm.JvmOverloads
 fun Application.module(testing: Boolean = false) {
     routing {
         greetingRoute()

         // 省略
routing 은 Listing 10.2.12 와 같이 정의되어 있으며 Routing 클래스의 확장 함수를 인수에 취한다. 지금까지 사용해 온 get 함수도 Routing 의 부모 클래스인 Route 클래스의 확장 함수입니다.

목록 10.2.12

 @ContextDsl
 public fun Application.routing(configuration: Routing.() -> Unit): Routing =
     featureOrNull(Routing)?.apply(configuration) ?: install(Routing, configuration)
따라서 Routing 의 확장 함수로 정의한 greetingRoute 도 호출할 수 있습니다.

이와 같이 구현함으로써, 기능의 분류별 등으로 라우팅을 정리해 정의할 수 있습니다.

경로 공통화
동일한 경로 아래에 여러 경로를 정의하는 경우 등에 공통화도 가능합니다. Listing 10.2.13 과 같이 구현한다.

목록 10.2.13

 fun Routing.greetingRoute() {
     route("greeting") {
         get("/hello") {
             call.respondText("Hello!")
         }

         get("/goodmorning") {
             call.respondText("Good morning!")
         }
     }
 }
route 함수에 경로를 정의하고 그 아래에 각 경로를 지정합니다. 여기서는 ' greeting ' 아래에 ' hello '와 ' goodmorning '을 정의하므로 다음 두 경로로 라우팅이 구현됩니다.

울/인사/안녕하세요
울/인사말/굿모닝
Location을 사용하여 유형 안전한 매개 변수 검색
여기까지 call.parameters 로 요청의 파라미터의 값을 취득하고 있었습니다만, String?형으로서 취득되기 때문에, 캐릭터 라인 이외의 값의 경우는 캐스트 해 형태를 변환할 필요가 있습니다. 또한 null이 들어올 가능성도 막지 않습니다. 따라서 Location을 사용하면 형식 안전하게 매개 변수를 얻을 수 있습니다.

Location 기능 추가
Location을 사용하려면 이 장의 "2.Ktor 소개"에서 소개한 "기능"을 추가해야 합니다. 기능을 추가하는 단계는 먼저 build.gradle.kts에 종속성을 추가합니다. dependencies 에 Listing 10.2.14 를 추가한다.

목록 10.2.14

 implementation("io.ktor:ktor-locations:$ktor_version")
그런 다음 Application.kt의 Application.module 에 Listing 10.2.15 와 같이 install 함수의 실행을 추가한다.

목록 10.2.15

 @Suppress("unused")
 @kotlin.jvm.JvmOverloads
 fun Application.module(testing: Boolean = false) {
     install(Locations)

 // 省略
기능은 기본적으로 build.gradle.kts에 종속성을 추가 한 다음이 install 함수에서 호출을 구현하여 사용할 수 있습니다.

라우팅 및 파라미터 정의
이제 Location에서 라우팅과 매개 변수를 정의합니다. Listing 10.2.16 과 같이 구현한다. 데이터 클래스의 부분도 포함해, 임의의 파일을 작성 혹은 Application.kt의 톱 레벨에 쓰는 형태로 문제 없습니다.

목록 10.2.16

 @Location("/user/{id}")
 data class GetUserLocation(val id: Long)

 fun Routing.userRoute() {
     get<GetUserLocation> { param ->
         val id = param.id
         call.respondText("id=$id")
     }
 }
먼저 매개 변수를 정의하려면 데이터 클래스를 사용합니다. 파라미터명을 변수명으로 해, 상정하는 형태로 constructor 에 정의합니다 (여기에서는 Long 형의 id 라고 하는 파라미터). 그리고 매개 변수의 데이터 클래스에 @Location 이라는 주석을 부여하고 라우팅 경로를 설명합니다. 패스 파라미터로서 id 를 건네주고 있습니다만, 쓰는 방법은 routing 내에서 정의할 때와 같이 {} 로 묶습니다.

그리고 아래에 있는 userRoute 안에서 정의하고 있는 get 함수에, 파라미터를 정의한 데이터 클래스를 형태 파라미터로서 건네주어, 람다 식안에서 변수 param 으로서 받아들여 값을 취득합니다. 만약 수치 이외의 값이 건네받았을 경우는, 리퀘스트를 접수했을 때에 에러가 되어, 이 처리로 취급할 때에는 Long형의 값인 것이 보증되고 있습니다.

이와 같이 Location 을 사용해 정의하는 것으로, 형태 안전하게 요구 파라미터를 취급할 수가 있습니다.

경로 공통화
Location을 사용하는 경우에도 경로를 공통화할 수 있습니다. Listing 10.2.17 과 같이 클래스를 중첩하여 정의한다.

목록 10.2.17

 @Location("/user")
 class UserLocation {
     @Location("/{id}")
     data class GetLocation(val id: Long)

     @Location("/detail/{id}")
     data class GetDetailLocation(val id: Long)
 }
호출측으로부터도, 리스트 10.2.18 과 같이 부모 계층의 클래스. 아이 계층의 클래스 의 형태로 형태 파라미터를 설정하는 것으로 사용할 수 있습니다.

목록 10.2.18

 get<UserLocation.GetLocation> { param ->
     val id = param.id
     call.respondText("get id=$id")
 }

 get<UserLocation.GetDetailLocation> { param ->
     val id = param.id
     call.respondText("getDetail id=$id")
 }
3　REST API 구현
이어 REST API를 구현하여 JSON에서 요청, 응답을 교환하는 방법을 소개합니다.

Jackson의 기능 추가
요청 및 응답 JSON 직렬화, deserialize에 Jackson 주 2 를 사용합니다. Ktor는 Jackson의 기능도 제공하므로 추가합니다.

build.gradle.kts의 dependencies 에 Listing 10.3.1 의 종속성을 추가한다.

목록 10.3.1

 implementation("io.ktor:ktor-jackson:$ktor_version")
그리고 Application.kt의 Application.module 에 Listing 10.3.2 의 install 을 추가한다.

목록 10.3.2

 install(ContentNegotiation) {
     jackson()
 }
ContentNegotiation 은 JSON과 같은 Contents를 다루는 기능을 사용하는 클래스입니다. install 블록 내에서 ContentNegotiation 의 확장 함수로 정의된 잭슨 을 호출하여 잭슨의 기능을 사용할 수 있습니다.

여기에서는 디폴트 상태로 사용합니다만, Listing 10.3.3 과 같이 람다 식으로 커스터마이즈의 처리를 기술할 수도 있습니다.

목록 10.3.3

 install(ContentNegotiation) {
     jackson {
         // カスタマイズする場合は処理を記述
         // 省略
     }
 }
JSON으로 응답 반환
GET의 경로 매개 변수로 요청을 받고 JSON 객체를 응답으로 반환하는 API를 구현합니다. Listing 10.3.4 의 라우팅과 데이터 클래스를 정의한다.

목록 10.3.4

 fun Routing.bookRoute() {
     route("/book") {
         @Location("/detail/{bookId}")
         data class BookLocation(val bookId: Long)
         get<BookLocation> { request ->
             val response = BookResponse(request.bookId, "Kotlin入門", "Kotlin太郎")
             call.respond(response)
         }
     }
 }

 data class BookResponse(
     val id: Long,
     val title: String,
     val author: String
 )
응답의 객체로 BookResponse 라는 데이터 클래스를 사용합니다.

그리고 라우팅 쪽에서는 BookResponse 의 인스턴스를 생성하여 call.respond 함수에 전달합니다. call.respondText 는 문자열만 반환했지만 call.respond 는 전달된 객체를 피처에 추가한 디시리얼라이저(여기서는 Jackson)를 사용하여 디시리얼라이즈하고 반환합니다.

이 라우팅을 Application.module 에 추가합니다 ( 목록 10.3.5 ).

목록 10.3.5

 bookRoute()
그런 다음 curl 명령 ( 명령 10.3.6 ) 또는 브라우저에서 http://localhost:8080/book/detail/100을 실행하면 데이터 클래스와 동일한 구조의 JSON이 반환됩니다.

명령 10.3.6

 $ curl http://localhost:8080/book/detail/100
 {"id":100,"title":"Kotlin入門","author":"Kotlin太郎"}
JSON에서 POST 요청 보내기
다음은 요청을 JSON으로 보내는 구현입니다. 요청 파라미터의 클래스로서 Listing 10.3.7 의 데이터 클래스를 생성한다.

목록 10.3.7

 data class RegisterRequest(
     val id: Long,
     val title: String,
     val author: String
 )
그리고 위의 bookRoute ( Listing 10.3.4 )의 route("/book") 블록에 Listing 10.3.8 의 라우팅을 추가한다.

목록 10.3.8

 post("/register") {
     val request = call.receive<RegisterRequest>()

     // 登録処理
     // 省略

     call.respondText("registered. id=${request.id} title=${request.title} author=${request.author}")
 }
POST 요청을 사용하기 위해 post 함수에 정의되어 있습니다. 요청을 받으면 call.receive 함수에 형식 매개 변수로 데이터 클래스를 전달합니다. 이제 요청의 JSON 객체를 기능으로 추가한 serializer(여기서는 Jackson)에서 데이터 클래스 유형으로 직렬화한 값을 가져올 수 있습니다. 실제로는 이 안에서 등록 처리등이 구현된다고 생각합니다만, 여기에서는 할애합니다.

명령 10.3.9 의 curl 명령을 실행하면 요청에서 받은 값을 포함하는 텍스트가 반환됩니다.

명령 10.3.9

 $ curl -H 'Content-Type:application/json' -X POST -d '{"id":200,"title":"Spring入門","author":"スプリング太郎"}' http://localhost:8080/book/register
 registered. id=200 title=Spring入門 author=スプリング太郎
4　인증 메커니즘 구현
마지막으로 Ktor의 기능을 사용하여 인증 메커니즘을 구현합니다. Spring에서도 7장에서 소개한 Spring Security라는 인증·인가의 프레임워크가 있었지만, Ktor에서도 마찬가지로 피쳐를 추가하는 것으로 다양한 방식의 인증을 구현할 수 있습니다.

다음과 같은 방식을 사용할 수 있습니다만, 이번은 가장 간단한 Basic 인증으로의 구현을 소개합니다.

울기본 인증
울양식 인증
울Digest 인증
울JWT 인증 · JWK 인증
울LDAP 인증
울OAuth 인증
인증 기능 추가
먼저 build.gradle.kts의 dependencies 에 Listing 10.4.1 의 종속성을 추가한다.

목록 10.4.1

 implementation("io.ktor:ktor-auth:$ktor_version")
그리고 Application.kt의 Application.module 에 Listing 10.4.2 의 install 을 추가한다.

목록 10.4.2

 install(Authentication) {
     basic {
         validate { credentials ->
             if (credentials.name == "user" && credentials.password == "password") {
                 UserIdPrincipal(credentials.name)
             } else {
                 null
             }
         }
     }
 }
Authentication 을 추가하고 기본 인증을 사용하기 위해 기본 을 정의합니다. validate 는 인증시의 검증 처리입니다. 람다 식에서 credentials 라는 이름으로 지정하는 매개 변수는 UserPasswordCredential 이라는 클래스 형식으로 입력된 사용자 이름( name )과 암호( password )를 보유합니다.

실제로는 여기서 데이터베이스 등으로부터 유저의 정보를 취득해 검증 처리를 한다고 생각합니다만, 여기에서는 「user」 「password」라고 하는 고정의 캐릭터 라인과 비교해 일치하면 인증이 통과하도록(듯이) 하고 있습니다. 일치하는 경우 UserIdPrincipal 이라는 클래스에 name 을 설정하여 반환합니다. else 로 쓰고 있는 것은 통과하지 않았을 경우의 처리입니다만, 여기에서는 아무것도 하지 않고 null 를 돌려주고 있습니다.

인증 대상 경로를 라우팅에 추가
인증을 통해 세션 정보를 얻는 과정은 Listing 10.4.3 이다. Application.module 의 라우팅 에 추가하십시오.

목록 10.4.3

 authenticate {
     get("/authenticated") {
         val user = call.authentication.principal<UserIdPrincipal>()
         call.respondText("authenticated id=${user?.name}")
     }
 }
라우팅에서 인증의 대상이 되는 경로는 authenticate 블록 내에 정의되어야 합니다. 이 안에 포함되는 패스만이, 전술한 인증 처리를 통과합니다.

중의 처리에서는 세션 정보의 취득을 하고 있습니다. call.authentication.principal 에 타입 파라미터로서 세션에 등록하고 있는 정보의 형태 (여기에서는 UserIdPrincipal)를 건네주면, 취득할 수 있습니다. 이것은 Listing 10.4.2 에서 인증이 성공했을 때 반환한 객체가 된다. 그리고 취득한 오브젝트로부터, name 의 값을 취득해 포함한 텍스트를 반환하고 있습니다.

여기에서는 routing 내에 직접 패스를 추가했습니다만, 다른 라우팅과 같이, 다른 파일에 잘라 authenticate 로부터 호출하는 것도 가능합니다( 리스트 10.4.4 , 리스트 10.4.5 ).

목록 10.4.4

 fun Route.authenticatedUserRoute() {
     get("/authenticated") {
         val user = call.authentication.principal<UserIdPrincipal>()
         call.respondText("authenticated id=${user?.name}")
     }
 }
목록 10.4.5

 authenticate {
     authenticatedUserRoute()
 }
동작 확인
기본 인증이 있으므로 브라우저에서 액세스하고 테스트합니다. http://localhost:8080/authenticated에 액세스하면 기본 인증 대화 상자가 표시됩니다 ( 그림 10.5 ).

그림 10.5
사용자 이름에 "user", 암호에 "password"를 입력하고 [로그인] 버튼을 누르면 인증을 통해 "authenticated id = user"라는 메시지가 화면에 표시됩니다 ( 그림 10.6 ).

그림 10.6
세션 정보의 항목 변경
세션 정보에 대해 여기에서는 UserIdPrincipal 을 사용했지만, Principal 인터페이스를 구현한 클래스라면 무엇이든 사용할 수 있습니다. 실제로는 스스로 작성한 클래스를 사용하는 것이 대부분이라고 생각합니다.

예를 들면 Listing 10.4.6 과 같은 데이터 클래스이다.

목록 10.4.6

 data class MyUserPrincipal(val id: Long, val name: String, val profile: String) : Principal
인증이 성공하면 데이터베이스에서 사용자 정보를 검색하고 값을 설정하는 등 모든 정보를 세션에 보관할 수 있습니다.

그리고 목록 10.4.2 의 validate 블록의 처리를 목록 10.4.7 과 같이 MyUserPrincipal 을 반환하도록 구현하여 사용할 수 있습니다.

목록 10.4.7

 validate { credentials ->
     if (credentials.name == "user" && credentials.password == "password") {
         // 認証処理
         // 省略

         MyUserPrincipal(id, name, profile)
     } else {
         null
     }
 }
注1 　 https://ktor.io/

( 본문으로 돌아가기 )

注2 　 https://github.com/FasterXML/jackson

( 본문으로 돌아가기 )

