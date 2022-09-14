


# 3부 Kotlin에서 다양한 프레임워크를 사용해보기

## 제9장 고속 통신 프레임워크 gRPC

지금까지의 장에서는 Spring Boot나 MyBatis라고 하는, 원래 Java에서 메이저인 프레임워크로서 사용되고 있던 것을, Kotlin에 적용해 기본적인 웹 어플리케이션을 구현해 왔습니다. 본 장에서는 한 걸음 더 나아가 새로운 기술 스택이나 아직 앞으로 발전해 나가는 단계의 Kotlin제의 것 등 다양한 프레임워크를 조합한 사용법을 소개합니다.

우선 이 장에서는 마이크로서비스 아키텍처의 서비스간 통신 등에서 자주 사용되고 있는 gRPC를 사용한 구현을 소개합니다.

1　gRPC란?
gRPC 는 Google에서 개발 한 RPC (Remote Procedure Call) 프레임 워크입니다 . 통신 프로토콜로서 HTTP/2, 통신의 데이터 형식으로서 Protocol Buffers 주2 를 표준으로 지원해, 고성능의 통신을 실현합니다. 현재는 마이크로서비스 아키텍처에서의 서비스간 통신 등에서 자주 사용되고 있습니다.

Protocol Buffers에서 gRPC 통신에 대한 코드를 생성할 수 있습니다.
gRPC에서 사용하는 Protocol Buffers는 IDL(Interface Description Language, 인터페이스 정의 언어)을 사용하여 통신의 인터페이스를 정의하고, 그것을 바탕으로 통신으로 사용하는 데이터 모델이나 직렬화· deserialize 등의 처리가 구현 코드는 다양한 프로그래밍 언어로 생성할 수 있습니다. 또, 데이터의 통신은 바이너리로 행해져 그 바이너리를 교환하는 클라이언트, 서버의 처리를, 생성된 코드를 사용해 구현합니다.

IDL은 .proto라는 확장자로 작성되며, 예로서는 Listing 9.1.1 과 같은 설명이 된다.

목록 9.1.1

 service Greeter {
   rpc Hello (HelloRequest) returns (HelloResponse);
 }

 message HelloRequest {
   string name = 1;
 }

 message HelloResponse {
   string text = 1;
 }
service 의 블록으로 기술하고 있는 것이 통신의 인터페이스로, 무엇을 리퀘스트로서 받고, 무엇을 리스폰스로서 돌려줄까를 정의하고 있습니다. rpc 메소드 이름 (요청 유형) returns 응답 유형 의 형식입니다.

이 요청, 응답의 형태의 내용을 정의하고 있는 것이, 그 아래에 계속되는 message 의 블록으로 써 있는 부분입니다. 여기서 요청에는 name 이라는 문자열, 응답에는 text 라는 문자열의 매개 변수가 각각 정의됩니다.

이 파일을 사용하여 Kotlin, Java, Go, C#, Python 등 많은 종류의 언어 코드를 생성할 수 있습니다. 코드 생성에는 protoc이라는 도구를 사용합니다. 실제로 코드를 생성하고 구현하는 부분에 대해서는 후술합니다.

2　gRPC 도입
Kotlin에서 gRPC를 사용하려면 grpc-kotlin 참고 3 이라는 Google에서 제공하는 라이브러리가 있습니다. 2020년 4월에 첫 번째 버전이 출시되었고 같은 해 12월에 버전 1.0.0이 출시된 상당히 새로운 버전이 되었습니다.

grpc-kotlin이 만들어지기 전에는 Java에서 지원되는 grpc-java 주 4 를 사용하는 것이 주요 방법이었으므로 새로운 라이브러리를 도입하는 것이 불안한 경우 등은 그 곳을 사용하는 옵션도 있습니다. .

또한, grpc-kotlin의 이용 방법에 관해서는 Google의 공식 사이트에 Quick start 주5 가 준비되어 있습니다. 본서의 내용도 이쪽을 참고로 작성하고 있습니다.

프로젝트 만들기 및 build.gradle.kts 재작성
IntelliJ IDEA에서 임의의 Gradle 프로젝트를 만들고 build.gradle.kts를 Listing 9.2.1 과 같이 다시 작성한다.

목록 9.2.1
첫째, ①의 plugins 블록에 추가된 리스트 9.2.2 는 Gradle에서 Protocol Buffers를 다루는 플러그인이 된다.

Listing 9.2.2 (Listing 9.2.1의 ①을 발췌)

 id("com.google.protobuf") version "0.8.15"
후술하는 protoc를 사용한 코드 생성을 실행하는 태스크로 사용합니다.

Kotlin에서 구현할 때 필요한 종속성은 dependencies 블록에서 추가하는 ②의 부분입니다 ( 목록 9.2.3 ).

Listing 9.2.3 (Listing 9.2.1의 ②를 발췌)

 implementation("io.grpc:grpc-kotlin-stub:1.0.0")
 implementation("io.grpc:grpc-netty:1.35.0")
각각 다음과 같은 역할이 됩니다.

울grpc-kotlin-stub ...... gRPC에서 서버와 통신하는 클라이언트 부분을 구현하는 Kotlin 라이브러리
울grpc-netty… … Netty에서 서버에서 gRPC 애플리케이션을 시작하는 데 필요한 라이브러리
그리고 ③의 protobuf 블록에서 정의하고 있는 것이, protoc에서의 코드 생성을 실행하는 Gradle 태스크가 됩니다( 목록 9.2.4 ).

Listing 9.2.4 (Listing 9.2.1의 ③을 발췌)

 protobuf {
     protoc { artifact = "com.google.protobuf:protoc:3.15.1" }
     plugins {
         id("grpc") {
             artifact = "io.grpc:protoc-gen-grpc-java:1.36.0"
         }
         id("grpckt") {
             artifact = "io.grpc:protoc-gen-grpc-kotlin:1.0.0:jdk7@jar"
         }
     }
     generateProtoTasks {
         all().forEach {
             it.plugins {
                 id("grpc")
                 id("grpckt")
             }
         }
     }
 }
protoc 의 블록에서는 사용하는 protoc의 패키지, 버젼을 지정하고 있습니다.

플러그인 으로 지정하는 것은 protoc에서 코드를 생성할 때 사용할 플러그인입니다. grpc , grpckt (이름은 임의)라는 id 블록으로 각각 Java, Kotlin에서 gRPC에 관한 코드를 생성하기 위한 플러그인을 지정하고 있습니다.

조금 까다롭지만 Protocol Buffers는 gRPC의 독자적인 기능이 아니라 어디까지나 데이터의 포맷입니다. 그리고 gRPC는 "Protocol Buffers를 사용하는 RPC 프레임 워크"입니다. 전술한 데이터 모델이나, 바이너리로 통신한 데이터의 시리얼라이즈, 디시리얼라이즈의 처리등은 디폴트에서도 생성됩니다. 그러나 그것을 "gRPC에서 사용하기위한 코드"는 플러그인을 넣지 않으면 생성되지 않습니다 (자세한 내용은 나중에 설명 함).

Java에 관한 플러그인도 설정하고 있는 이유는 Kotlin에서 생성한 코드가 Java에서 생성한 코드에 의존하는 부분이 있기 때문입니다. 따라서 Kotlin의 코드 만 생성해도 사용할 수 없습니다.

generateProtoTasks 가 실제로 코드 생성을 수행하는 작업입니다. plugins 로 정의한 grpc , grpckt 의 id 를 호출해 실행하도록 지정하고 있습니다.

Protocol Buffers 구현의 주요 원점인 proto 파일
이 장의 시작 부분에서도 설명했지만 gRPC는 Protocol Buffers를 IDL로 사용합니다. 이 IDL의 인터페이스 정의는 .proto라는 확장명의 파일로 작성됩니다 (이후, proto 파일이라고 함). src / main 아래에 proto라는 디렉토리를 만들고 그 아래에 greeter.proto라는 이름으로 목록 9.2.5 의 내용 파일을 만듭니다.

목록 9.2.5
각 부분에 대해 아래에서 설명합니다.

통사론
Listing 9.2.5 의 ① 부분이다. syntax 에서 지정한 것은 Protocol Buffers의 버전입니다. 여기에서는 3계를 지정하고 있습니다만, 아무것도 기술하지 않으면 디폴트에서는 2계로 판단되어, 이 구문에서는 에러가 되어 버립니다.

패키지
리스트 9.2.5 의 ②의 부분입니다. package 로 지정하는 것은 생성되는 파일의 클래스가 배치되는 패키지입니다. 출력되는 언어(본서에서는 Java, Kotlin)의 패키지로서 그대로 사용됩니다.

옵션
목록 9.2.5 의 ③ 부분입니다. option 에서는 Protocol Buffers에 관한 다양한 옵션을 설정할 수 있으며, 여기에서는 java_multiple_files 라는 항목을 지정하고 있습니다. 이것은 Java 혹은 Kotlin의 코드를 생성할 때, 일부의 파일을 분할해 출력할지 어떨지를 지정하는 옵션이 됩니다. true 를 지정했을 경우, 후술하는 message 의 내용을 바탕으로 작성되는 클래스가, 다른 파일로 출력됩니다 (다음 항의 출력되는 파일의 설명에서 별도 해설합니다).

또 본서에서는 설명을 생략합니다만, option 에서는 그 밖에도 지정할 수 있는 항목이 여러가지 있으므로, 흥미가 있는 분은 공식 사이트 주 6 쪽도 봐 주세요.

서비스
Listing 9.2.5 의 ④ 부분이다. 통신을 허용하는 인터페이스를 정의합니다. 제4장에서 해설한 Spring Boot에서의 REST API에서 말하는 Controller와 같은 부분입니다. 메소드명과 함께, 받는 리퀘스트, 반환하는 리스폰스의 형태를 기술합니다. 여기에서는 「Greeter」라는 이름으로 정의해, 리퀘스트, 리스폰스에 각각 후술의 message 로 정의한 형태를 지정하고 있습니다.

메시지
Listing 9.2.5 의 ⑤ 부분이다. 통신시의 데이터의 교환에 사용하는 데이터의 정의가 됩니다. 일반 REST 통신에서도 자주 발생하는 요청, 응답 인터페이스, 그리고 그 안에서 속성으로 사용할 필드 등을 정의할 수 있습니다. 이 예제에서는 간단하게 요청의 객체 ( HelloRequest )에 "name", 응답의 객체 ( HelloResponse )에 "text"를 모두 string형으로 정의하고 있을 뿐입니다.

필드 이름 뒤에 " = 1 "을 쓰고 있지만 proto 파일은 필드 순서를 지정해야하며 숫자입니다. 이번에는 하나씩 밖에 없기 때문에 모두 「1」이 지정되고 있습니다만, 2개 이상 존재하는 경우는 리스트 9.2.6 과 같이 일련번호로 수치를 지정합니다.

Listing 9.2.6

 message HelloRequest {
   string first_name = 1;
   string last_name = 2;
 }
여기에서는 string형 밖에 사용하고 있지 않습니다만, 각 언어로 사용하는 기본적인 형태에 대응하는 것은 일대로 Protocol Buffers에서도 준비되어 있습니다. 자세한 내용은 공식 사이트 주 7 을 참조하십시오.

Protocol Buffers로 코드 생성
방금 만든 Gradle 작업을 사용하여 코드를 생성합니다. 프로젝트의 루트 디렉토리에서 명령 9.2.7 의 명령을 실행하거나 IntelliJ IDEA의 Gradle 뷰에서 [Tasks] → [other] → [generateProto]를 실행하십시오.

명령 9.2.7

 $ ./gradlew generateProto
build/generated/source/proto/main 아래에 gprc, grpckt, java라는 디렉토리와 다음과 같은 파일이 생성됩니다.

울grpc 부하(Java 파일)
・인사말
울grpckt 부하(Kotlin 파일)
・GrpcKt 인사말
울java 부하(Java 파일)
・GreeterOuterClass
・헬로리퀘스트
・HelloRequestOrBuilder
・헬로리스폰스
・HelloResponseOrBuilder
java 부하에 있는 것이 Protocol Buffers가 디폴트로 생성하는 코드가 됩니다. HelloRequest, HelloRequestOrBuilder 및 HelloResponse, HelloResponseOrBuilder는 각각 요청 및 응답 데이터 모델과 해당 빌더입니다. 그리고 GreeterOuterClass에는, 교환하는 바이너리 데이터의 시리얼라이즈, 디시리얼라이즈를 하는 처리등이 실장되고 있습니다.

grpc와 grpckt의 아래에 있는 것이 앞서 설명한 Protocol Buffers를 "gRPC에서 사용하기 위한 코드"가 됩니다. GreeterGrpc는 GreeterOuterClass의 메소드 등을 사용하여 Protocol Buffers의 바이너리 데이터로 gRPC 통신을 실현하기 위한 인터페이스를 제공합니다. GreeterGrpcKt는 GreeterGrpc를 사용하고 Kotlin에서 구현하는 인터페이스를 제공합니다. Gradle 작업에서 앞에서 설명한 gRPC에 대한 플러그인을 지정하지 않으면 이 두 가지가 생성되지 않습니다.

gRPC 서버 구현
생성된 코드를 사용하여 gRPC 서버를 구현합니다. src/main/kotlin 아래에 Listing 9.2.8 의 클래스를 생성한다.

목록 9.2.8

 class GreeterService : GreeterGrpcKt.GreeterCoroutineImplBase() {
     override suspend fun hello(request: HelloRequest) = HelloResponse.newBuilder()
         .setText("Hello ${request.name}")
         .build()
 }
Protocol Buffers에서 생성한 GreeterGrpcKt의 GreeterCoroutineImplBase 라는 클래스를 상속합니다. 이 GreeterCoroutineImplBase 와 재정의 된 hello 함수는 목록 9.2.5 의 proto 파일에 정의 된 서비스 및 메서드 ( 목록 9.2.9 )를 기반으로 생성 된 코드입니다.

Listing 9.2.9 (Listing 9.2.5의 ④ 발췌)

 service Greeter {
   rpc Hello (HelloRequest) returns (HelloResponse);
 }
Listing 9.2.8 의 hello 함수는 인수의 형태로 요청을 받을 수 있고, 반환값의 형태의 오브젝트를 돌려주는 로직을 기술하는 것으로 gRPC 통신에서의 처리를 구현할 수 있다. Spring Boot의 어플리케이션에서 말하는 Controller 클래스와 같은 서 위치가 됩니다.

그리고 임의의 이름의 파일(여기서는 GreeterServer.kt라고 한다)을 작성해, 리스트 9.2.10 의 처리를 구현합니다.

목록 9.2.10

 private const val PORT = 50051

 fun main() {
     val server = ServerBuilder
         .forPort(PORT)
         .addService(GreeterService())
         .build()

     server.start()
     println("Started. port:$PORT")

     server.awaitTermination()
 }
ServerBuilder 라는 클래스를 사용하여 gRPC 서버의 개체를 생성하고 시작합니다. forPort 에서 부팅에 사용할 포트를 지정하고 addService 에서 위에서 설명한 GreeterService 를 부팅 대상 서비스로 설정합니다.

start 메소드로 서버가 기동해, awaitTermination 메소드를 호출하는 것으로, 어플리케이션을 정지할 때까지 서버가 요구를 받아들이는 상태가 됩니다.

gRPC 클라이언트 구현
gRPC는 일반 HTTP 통신과 다르므로 curl 명령이나 브라우저에서 URL을 지정하여 액세스 할 수 없습니다. 프로그램에서도 각종 REST의 클라이언트 라이브러리로 URL을 지정해의 실행등도 할 수 없습니다. Protocol Buffers에서 생성한 코드를 호출하여 클라이언트를 만들어야 합니다.

여기도 임의의 이름의 파일(여기서는 GreeterClient.kt라고 한다)을 작성해, 리스트 9.2.11 의 처리를 구현합니다.

목록 9.2.11

 private const val HOST = "localhost"
 private const val PORT = 50051

 fun main() = runBlocking {
     val channel = ManagedChannelBuilder.forAddress(HOST, PORT)
         .usePlaintext()
         .build()

     try {
         val stub = GreeterGrpcKt.GreeterCoroutineStub(channel)

         val name = "Kotlin"
         val request = HelloRequest.newBuilder().setName(name).build()
         val response = async { stub.hello(request) }

         println("Response Text: ${response.await().text}")
     } finally {
         channel.shutdown().awaitTermination(5, TimeUnit.SECONDS)
     }
 }
코드의 내용은 아래에서 설명합니다.

채널에서 통신 설정
gRPC에서의 통신에는 Channel 이라는 클래스의 객체를 사용하여 통신을 확립합니다. 이것은 연결과 같은 것이라고 생각하면 괜찮습니다.

ManagedChannelBuilder 는 Channel 을 생성하는 Builder이며, 여기서는 forAddress 메소드를 사용하여 연결할 호스트와 포트를 지정합니다. 체인하는 usePlaintext 메서드는 SSL(Secure Socket Layer)을 비활성화합니다. 실제 제품의 환경 등에서 SSL이 필요한 경우는, 이 메소드의 체인을 삭제하면 유효하게 됩니다.

Stub에서 gRPC 서비스 실행
그리고 생성된 코드 안에 포함된 GreeterCoroutineStub 가 서버에 요청을 보내는 클라이언트의 클래스가 됩니다. Coroutine이라고 이름이 붙은 것처럼 내부에서 Kotlin Coroutines를 사용하여 비동기 통신을 가능하게 합니다.

매개 변수는 여기도 생성 된 코드의 HelloRequest 를 사용합니다. Listing 9.2.5 의 proto 파일에서 message 로 정의한 부분에 해당하는 클래스입니다. 여기도 Builder가 준비되어 있으므로 필요한 매개 변수를 설정하고 build 하고 있습니다.

여기서 실행하는 Stub의 hello 함수는 앞서 설명한 서버에서 구현했던 GreeterService 의 hello 함수를 호출합니다. gRPC는 이렇게 proto 파일을 바탕으로 클라이언트가 Stub, 서버가 Service에 각각 송수신의 함수가 생성되도록 되어 있습니다.

async를 사용하여 비동기로 실행
hello 는 suspend 함수로 정의되므로 suspend 함수 또는 코루틴 범위 내에서 호출해야 합니다. 여기서는 runBlocking 내에서 정의하고 async 를 사용하여 비동기 적으로 실행합니다.

동작 확인
먼저 서버를 시작합니다. IntelliJ IDEA에서 Listing 9.2.10 에서 구현한 서버 프로그램 파일(여기서는 GreeterServer.kt)을 열고 main 함수를 실행한다. Run 뷰에 Listing 9.2.12 와 같은 메시지가 출력되면 시작된다.

목록 9.2.12

 Started. port:50051
그리고 클라이언트 프로그램을 실행합니다. 여기도 IntelliJ IDEA에서 Listing 9.2.11 에서 구현 한 클라이언트 프로그램 파일 (여기서는 GreeterClient.kt)을 열고 main 함수를 실행합니다.

Listing 9.2.13 의 텍스트가 Run 뷰에 나타나면 성공한다.

목록 9.2.13

 Response Text: Hello Kotlin
프로그램 내에서 요청으로 전달한 문자열이 포함된 메시지가 표시됩니다. 클라이언트 프로그램에서 서버로 gRPC로 액세스하고 GreeterService 의 실행 결과를 받아 출력됩니다.

3　Spring Boot에서 gRPC Kotlin 서버 측 프로그램 구현
제2절의 샘플에서는 grpc-kotlin 의 라이브러리를 그대로 사용해 서버, 클라이언트의 프로그램을 구현했습니다만, 이번에는 Spring Boot와 조합한 형태로의 구현을 소개합니다. Spring Boot에서 gRPC를 사용하는 것은 grpc-spring-boot-starter 를 사용하여 쉽게 구현할 수 있습니다.

Spring Boot 애플리케이션 내에 서버와 클라이언트를 모두 구현
이 섹션에서 소개하는 샘플에서는 다음 두 가지가 포함된 응용 프로그램을 만듭니다.

울gRPC 서버
울gRPC 서버에 액세스한 결과를 반환하는 REST API(gRPC 클라이언트)
나중에 설명하지만 Spring Boot는 grpc-spring-boot-starter 를 사용하여 gRPC와 일반 HTTP 통신을 각각 별도의 포트로 수신 할 수 있습니다. 따라서 REST API에 액세스하고 거기에서 gRPC 서버에 대한 통신이 이루어지고 수신 된 결과를 반환하는 형태의 샘플이됩니다 ( 그림 9.1 ).

그림 9.1
프로젝트 만들기 및 build.gradle.kts 재작성
Spring Initializr 등을 사용하여 모든 Spring Boot 프로젝트를 만듭니다. 그리고 build.gradle.kts를 Listing 9.3.1 과 같이 다시 작성한다.

목록 9.3.1

 import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
 import com.google.protobuf.gradle.generateProtoTasks
 import com.google.protobuf.gradle.id
 import com.google.protobuf.gradle.plugins
 import com.google.protobuf.gradle.protobuf
 import com.google.protobuf.gradle.protoc

 plugins {
     kotlin("jvm") version "1.4.30"
     kotlin("plugin.spring") version "1.4.30"
     id("org.springframework.boot") version "2.4.3"
     id("io.spring.dependency-management") version "1.0.11.RELEASE"
     id("com.google.protobuf") version "0.8.15"
     id("idea")
 }

 group = "com.example.grpc.kotlin"
 version = "0.0.1-SNAPSHOT"
 java.sourceCompatibility = JavaVersion.VERSION_11

 repositories {
     mavenCentral()
 }

 dependencies {
     implementation("org.springframework.boot:spring-boot-starter-web")
     implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
     implementation("org.jetbrains.kotlin:kotlin-reflect")
     implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
     implementation("io.grpc:grpc-kotlin-stub:1.0.0")
     implementation("io.grpc:grpc-netty:1.35.0")
     implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.4.2")
     implementation("org.jetbrains.kotlinx:kotlinx-coroutines-reactor:1.4.2")
     implementation("io.github.lognet:grpc-spring-boot-starter:4.4.4") ─────①
     testImplementation("org.springframework.boot:spring-boot-starter-test")
 }

 tasks.withType<KotlinCompile> {
     kotlinOptions {
         freeCompilerArgs = listOf("-Xjsr305=strict")
         jvmTarget = "11"
     }
 }

 protobuf {
     protoc {
         artifact = "com.google.protobuf:protoc:3.15.1"
     }
     plugins {
         id("grpc") {
             artifact = "io.grpc:protoc-gen-grpc-java:1.36.0"
         }
         id("grpckt") {
             artifact = "io.grpc:protoc-gen-grpc-kotlin:1.0.0:jdk7@jar"
         }
     }
     generateProtoTasks {
         all().forEach {
             it.plugins {
                 id("grpc")
                 id("grpckt")
             }
         }
     }
 }
지금까지 만들어 온 Spring Boot 프로젝트에 grpc-kotlin 종속성을 추가한 것처럼 보입니다. 다른 점은 grpc-spring-boot-starter 종속성을 추가합니다 ( 목록 9.3.2 ).

Listing 9.3.2 (Listing 9.3.1의 ①을 발췌)

 implementation("io.github.lognet:grpc-spring-boot-starter:4.4.4")
여기에는 Spring Boot에서 gRPC를 사용하기 위한 다양한 라이브러리가 포함되어 있으며, 후술하는 @GRpcService 어노테이션 등, gRPC에서의 서버 구현을 간단하게 하기 위한 구조를 제공하고 있다.

Protocol Buffers에서 코드 생성
proto 파일을 만들고 코드를 생성합니다. 2 절에서 설명한 것과 같은 파일을 사용한다 ( 목록 9.2.5 ) ( 목록 9.3.3 ). 여기도 src / main 아래에 proto 디렉토리를 만들고 그 아래에 proto 파일을 작성하십시오.

목록 9.3.3 (목록 9.2.5 재게재)

 syntax = "proto3";

 package example.greeter;

 option java_multiple_files = true;

 service Greeter {
   rpc Hello (HelloRequest) returns (HelloResponse);
 }

 message HelloRequest {
   string name = 1;
 }

 message HelloResponse {
   string text = 1;
 }
그런 다음 터미널에서 명령 ( 명령 9.3.4 ) 또는 IntelliJ IDEA Gradle 뷰에서 generateProto 작업을 실행합니다.

명령 9.3.4

 $ ./gradlew generateProto
서버 프로그램 구현
서버 프로그램의 구현에는, 제2절과 같이 이쪽에서도 생성한 Service 클래스를 사용합니다. Listing 9.3.5 와 같이 구현한다.

목록 9.3.5

 @GRpcService
 class GreeterService : GreeterGrpcKt.GreeterCoroutineImplBase() {
     override suspend fun hello(request: HelloRequest) = HelloResponse.newBuilder()
         .setText("Hello ${request.name}")
         .build()
 }
제2절의 샘플과 같이 GreeterGrpcKt의 GreeterCoroutineImplBase 를 상속해 구현하고 있습니다만, grpc-spring-boot-starter 를 사용하는 경우는 이 클래스만으로 구현 완료입니다. @GRpcService 에 주석을 달면 Spring Boot 응용 프로그램이 시작될 때 gRPC의 Service로 로드되어 요청을 수락한 상태가 됩니다. 제2절의 리스트 9.2.10 에서 구현하고 있던 부분을 Spring Boot가 흡수해 줍니다.

클라이언트 프로그램 구현
클라이언트 프로그램은 일반 REST API의 Controller로 구현됩니다. Listing 9.3.6 과 같다.

목록 9.3.6

 private const val HOST = "localhost"
 private const val PORT = 6565

 @RestController
 class GreeterClientController {
     @GetMapping("/greeter/hello/{name}")
     fun hello(@PathVariable name: String): String = runBlocking {
         val channel = ManagedChannelBuilder.forAddress(HOST, PORT)
             .usePlaintext()
             .build()

         val request = HelloRequest.newBuilder().setName(name).build()
         val stub = GreeterGrpcKt.GreeterCoroutineStub(channel)

         val response = async { stub.hello(request) }
         response.await().text
     }
 }
Channel의 생성부터 Stub의 실행까지, 제2절에서 해설한 것과 같습니다. 요청에 경로 매개 변수로 받은 값을 설정하고 실행한 결과를 응답으로 그대로 반환합니다.

동작 확인
응용 프로그램을 시작합니다. 여기도 일반 Spring Boot 응용 프로그램과 마찬가지로 터미널이나 IntelliJ IDEA에서 bootRun 작업을 실행합니다. 시작시 Listing 9.3.7 과 같은 로그가 출력됩니다.

목록 9.3.7

 INFO 60711 --- [           main] o.s.b.w.embedded.tomcat.TomcatWebServer  : Tomcat initialized with port(s): 8080 (http)

 （省略）

 INFO 60711 --- [           main] o.l.springboot.grpc.GRpcServerRunner     : Starting gRPC Server ...
 INFO 60711 --- [           main] o.l.springboot.grpc.GRpcServerRunner     : 'com.example.grpc.springboot.server.GreeterService' service has been registered.
 INFO 60711 --- [           main] o.l.springboot.grpc.GRpcServerRunner     : gRPC Server started, listening on port 6565.
8080 포트에서 Tomcat이 시작된 후 gRPC 서버가 6565 포트에서 시작됩니다. 이제 Controller에서 구현했던 일반 HTTP 요청은 8080 포트이고 gRPC 서버에 대한 요청은 6565 포트에서 허용됩니다.

그리고 명령 9.3.8 의 curl 명령으로 localhost : 8080에 요청을 보내면 클라이언트 프로그램이 실행됩니다.

명령 9.3.8

 $ curl http://localhost:8080/greeter/hello/Kotlin
 Hello Kotlin
패스 파라미터로 건네준 값을 포함한 메세지가 돌려주면 성공입니다.

注1 　 https://grpc.io/

( 본문으로 돌아가기 )

注2 　 https://developers.google.com/protocol-buffers

( 본문으로 돌아가기 )

注3 　 https://github.com/grpc/grpc-kotlin

( 본문으로 돌아가기 )

注4 　 https://github.com/grpc/grpc-java

( 본문으로 돌아가기 )

注5 　 https://grpc.io/docs/languages/kotlin/quickstart/

( 본문으로 돌아가기 )

注6 　 https://developers.google.com/protocol-buffers/docs/proto3#options

( 본문으로 돌아가기 )

注7 　 https://developers.google.com/protocol-buffers/docs/proto3#scalar

( 본문으로 돌아가기 )

