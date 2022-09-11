

0C```^[^Mk0 ------- @ Q
0i```^M-^[^M0i```^[0 ------- @ W
0^Mi```^M^M^[kk ------- @ E
0i#### ^[^M^[ ------- @ A
0i##### ^[^M^[ ------- @ S




## 제6장　Spring Boot와 MyBatis에서 도서 관리 시스템 웹 애플리케이션 개발

제 5 장까지, 서버 측 Kotlin에서 개발에 필요한 주요 기술 요소에 대한 설명이 끝났습니다. 이 장에서는 지금까지 설명한 요소를 사용하여 실용적인 응용 프로그램을 만듭니다. 제6장에서 Spring Boot와 MyBatis를 사용한 웹 애플리케이션을 작성하고, 제7장에서 인증·인가, 제8장에서 단위 테스트의 구현을 하고, 보다 실제의 제품과 같은 형태에 접근해 갑니다.

그 베이스가 되는 부분을 작성하는 것이 본장입니다. 우선은 여기까지의 장에서 얻은 지식을 사용해 실천적인 아키텍쳐의 어플리케이션을 작성해, 한층 더 이해를 깊게 해 주셨으면 합니다.


### 1　책 관리 시스템 사양

이 장에서는 서버 측 Kotlin의 실용적인 구현 방법을 배우기 위해 책 관리 시스템을 사용하는 샘플 응용 프로그램을 작성합니다. 이는 조직에서 소유한 도서 정보와 대출 및 반환 상태를 관리하는 애플리케이션의 이미지입니다.

먼저 시스템의 기능과 사양을 설명합니다.

#### 구현할 기능

기능으로서, 이하의 것을 구현해 갑니다.

- 로그인, 세션 관리
- 권한 관리
- 책의 일람 취득
- 책 세부정보 획득
- 도서 정보 등록
- 책 정보 업데이트
- 책 정보 삭제
- 대출
- 반환

##### 로그인, 세션 관리, 권한 관리

사용하는 사용자의 로그인, 세션 관리 및 권한 관리 기능입니다. ID, 비밀번호를 입력한 로그인과 로그인한 사용자의 권한에 따라 기능 제한을 구현합니다.

##### 책의 일람 취득, 상세 취득

책의 일람, 상세 정보를 취득하는 기능입니다. 리스트에서 모든 책의 리스트를 표시하고, 책명을 선택하면 상세 표시의 화면으로 천이합니다. 이것은 모든 사용자가 수행할 수 있는 기능입니다.

##### 도서 정보 등록, 업데이트, 삭제

서적 정보를 등록, 갱신, 삭제하는 기능입니다. 여기는 관리자 권한의 사용자만 실행할 수 있는 기능입니다.

##### 대출, 반환
책의 대출, 반환을 하는 기능입니다. 책에끈끈생성하는 대출 정보의 등록, 삭제를 실행합니다. 이것은 모든 사용자가 수행할 수 있는 기능입니다.

### 2　애플리케이션 구성

다음으로 이 애플리케이션에서 사용하는 기술 스택, 아키텍처 등에 대해 설명합니다.

#### 사용하는 기술 스택

주요 기술 스택으로 다음을 채용하고 있습니다.

- 코틀린
- 스프링 부트
- 마이바티스
- MySQL
- 레디스
- 도커

여기까지 소개해 온 Kotlin, Spring Boot, MyBatis를 중심으로 한 구현입니다. 데이터베이스는 Docker 이미지에서 생성하고 시작한 MySQL을 사용합니다. 또한 7장에서 작성하는 인증 처리에서 사용하기 때문에 Redis도 마찬가지로 Docker 이미지를 사용하여 작성, 기동합니다.

#### 양파 아키텍처를 기반으로 한 설계

이 응용 프로그램은 양파 아키텍처를 기반으로 설계되었습니다.

양파 아키텍처는 프로젝트를 여러 계층으로 나누어 역할을 정의하고 각 계층의 종속성을 제어하여 코드 간의 관계를 느슨하게 결합하고 유지 보수성을 높일 수있는 아키텍처입니다. 특히 대규모 시스템이나 장기간에 걸쳐 보수 운용에서의 개수 등이 요구되는 시스템에서 유효하게 됩니다. 계층 간의 관계는 그림 6.1 과 같이 양파와 같은 계층화 된 원형으로 표현되기 때문에 양파 아키텍처로 명명됩니다. DDD(domain-driven design, 도메인 구동 설계)를 실천할 때의 아키텍처의 하나로서도 자주 들 수 있습니다.

그림 6.1 (출처: Jeffrey Palermo 『The Onion Architecture : part 1』 July 29, 2008, https://jeffreypalermo.com/2008/07/the-onion-architecture-part-1/)

그림 6.1 양파 아키텍쳐
 Kotlin_서버사이드_프로그래밍_실천개발-epub_img

（https://jeffreypalermo.com/2008/07/the-onion-architecture-part-1/）
그림 6.1 의 화살표로 표시된 것처럼 그림의 외부 계층에서 내부 계층에만 의존하는 형태가 되며 역방향 및 가로 계층(예: User Interface에서 Infrastructure)에 대한 액세스를 금지합니다.

[예]

울User Interface 계층의 코드에서 Application Service 계층의 코드 호출 → ○
울Domain Service 계층 코드에서 Application Service 계층 코드 호출 → ×
울User Interface 계층 코드에서 Infrastructure 계층 코드 호출 → ×
각 계층 구조의 개요는 표 6.1 과 같습니다.

표 6.1
자세한 것은 이 아키텍처를 제창한 Jeffrey Palermo씨의 블로그 주1 등을 참고해 주세요.

이 계층 구조를 참고로 본 장의 샘플에서는 표 6.2 와 같은 형태로 계층을 정의하고 있습니다.

표 6.2
패키지를 나누는 형태로 각 계층을 표현하고 있습니다. Domain Service 계층과 Domain Model 계층은 담당하는 역할이 가까우며 본 샘플의 규모가 작기 때문에 Domain 계층이라는 형태로 정리하고 있습니다. UI 계층에 관해서는, 서버측의 개발에서는 Presentation 계층이라고 하는 경우가 많기 때문에, 그쪽을 이름으로 하고 있습니다. 패키지는 임의입니다만, 제7장에서 소개하는 AOP(Aspect Oriented Programming, 애스펙트 지향 프로그래밍)로 패키지를 지정한 설정이 있기 때문에, 표와 같이 나누어 두는 편이 만들기 쉬워집니다.

또, 본래의 DDD나 양파 아키텍쳐의 구조에서는 생략하고 있는 부분도 있습니다. 원래 DDD를 사용하고 있는 분에게는 위화감이 있는 부분도 있을지도 모릅니다만, 어디까지나 Kotlin에서의 실천적인 구현의 참고예로서의 아키텍쳐로, 간략화하고 있는 것으로 인식해 주세요.

각 계층의 관계나, 각각의 클래스의 역할등은 구현의 설명을 하면서 보충해 갑니다.

프런트 엔드 기술에 Vue.js 채택
프런트 엔드 기술에는 Vue.js를 사용하여 SPA(Single Page Application)를 실현하고 있습니다. 서버 측 Kotlin의 이야기에서 벗어나기 때문에, 후술하는 환경 구축의 부분 이외는 설명을 생략합니다. 본서에서 공개하는 샘플 프로젝트상에는 한가지의 구현이 들어가 있으므로, 화면과의 연결에는 그쪽을 이용해 주세요. 샘플 프로젝트를 시작하는 방법은 나중에 설명합니다.

Vue.js에서는 SPA를 프런트 엔드 서버로 시작하고 각 페이지로의 라우팅도 정의할 수 있습니다. 프런트 엔드 및 서버측 구성 이미지는 그림 6.2 와 같습니다.

그림 6.2
Vue.js 서버는 8081 포트이고 Spring Boot 서버는 8080 포트에서 시작됩니다.

브라우저에서 먼저 Vue.js 서버에 액세스하여 해당 페이지의 HTML을 검색합니다. 그리고 렌더링시 HTML로 작성된 JavaScript에서 Spring Boot 서버의 API를 실행하고 검색된 JSON 정보를 사용하여 페이지를 작성합니다.

나중에 프런트 엔드 샘플 코드로 시작하는 것은이 Vue.js 서버의 일부입니다.

3　프로젝트 환경 구축
응용 프로그램 프로젝트를 만듭니다. 이 섹션에서는 Spring Boot 응용 프로그램을 만들고 종속성을 추가하고 다양한 코드를 생성합니다.

애플리케이션 프로젝트 생성
먼저 Spring Boot 응용 프로그램의 프로젝트를 만듭니다. 지금까지 소개 한 것과 마찬가지로 Spring Initializr를 사용합니다 ( 그림 6.3 ).

그림 6.3
프로젝트에서 설정한 항목은 다음과 같습니다.

울프로젝트: Gradle
울언어: 코틀린
울스프링 부트: 2.4.3
울프로젝트 메타데이터:
・그룹: com.book.manager
・아티팩트: 북매니저
・이름 : 북매니저
・설명: Spring Boot용 Book Manager 프로젝트
・패키지명 : com.book.manager
・포장: 항아리
・자바: 11
울종속성: Spring Web、MyBatis 프레임워크
4장에서 Spring Initializr를 사용했을 때는 Project Metadata를 모두 디폴트값으로 작성했지만, 프로젝트에 관한 이름의 정보등을 설정하고 있습니다.

주로 말하면 Package name에서 프로젝트의 베이스가 되는 패키지명을 지정하고 있어, main 함수가 들어간 클래스 파일(○○Application.kt)도 이 패키지 아래에 배치됩니다. 또, Java는 사용하는 JDK의 버젼으로, 11(글쓰기 시점에서의 안정판)을 지정하고 있습니다.

build.gradle.kts에 종속성 추가
방금 만든 프로젝트를 다운로드하고 확장하고 Gradle에 몇 가지 종속성을 추가합니다. 추가한 build.gradle.kts 전체 코드는 Listing 6.3.1 이다.

Listing 6.3.1
기본적으로 제4장, 제5장에서도 설명한 내용입니다만, 주된 내용을 간단하게 해설합니다.

plugins──Gradle 작업에 사용할 플러그인
플러그인 블록에서 필요한 플러그인을 추가합니다.

Listing 6.3.2 (Listing 6.3.1의 ①을 발췌)

 plugins {
     id("org.springframework.boot") version "2.4.3"
     id("io.spring.dependency-management") version "1.0.11.RELEASE"
     id("com.arenagod.gradle.MybatisGenerator") version "1.4" // 追加
     kotlin("jvm") version "1.4.30"
     kotlin("plugin.spring") version "1.4.30"
 }
4장에서 설명한 Spring Boot 애플리케이션에 필요한 두 개의 플러그인과 Kotlin 관련 플러그인 2개, 5장에서 설명한 MyBatisGenerator 플러그인입니다. com.arenagod.gradle.MybatisGenerator 는 Spring Initializr에서 생성한 프로젝트의 파일에 추가해야 합니다.

dependencies── 애플리케이션에서 사용하는 종속성
dependencies 블록의 내용입니다. 먼저 Listing 6.3.3 이 4장에서 설명한 Kotlin, Spring Boot와 관련된 종속성이다.

Listing 6.3.3 (Listing 6.3.1의 ②를 발췌)

 implementation("org.jetbrains.kotlin:kotlin-reflect")
 implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
 implementation("org.springframework.boot:spring-boot-starter-web")
 implementation("com.fasterxml.jackson.module:jackson-module-kotlin")
이들은 Spring Initializr에서 생성된 내용에 포함되어 있습니다.

그리고 Listing 6.3.4 는 5장에서 설명한 MyBatis와 관련된 종속성이다.

Listing 6.3.4 (Listing 6.3.1의 ③을 발췌)

 implementation("org.mybatis.spring.boot:mybatis-spring-boot-starter:2.1.4")
 implementation("org.mybatis.dynamic-sql:mybatis-dynamic-sql:1.2.1") // 追加
 implementation("mysql:mysql-connector-java:8.0.23") // 追加
 mybatisGenerator("org.mybatis.generator:mybatis-generator-core:1.4.0") // 追加
mybatis-dynamic-sql , mysql-connector-java , mybatis-generator-core 를 추가하고 있습니다. 각각 MyBatis Dynamic SQL과 MySQL Connector/J, MyBatis Generator를 사용하기 위해 필요합니다.

mybatisGenerator──MyBatis Generator에서 코드 생성하는 태스크의 설정
마지막으로 mybatisGenerator 블록에서 MyBatis Generator에서 코드 생성 태스크에 관한 설정을하고 있습니다 ( 목록 6.3.5 ).

Listing 6.3.5 (Listing 6.3.1의 ④ 발췌)

 // 追加
 mybatisGenerator {
     verbose = true
     configFile = "${projectDir}/src/main/resources/generatorConfig.xml"
 }
5장에서 설명한 것처럼 generatorConfig.xml이라는 파일을 구성 파일로 지정합니다.

MySQL 환경 구축
다음으로, MySQL의 환경 구축을 합니다. MySQL의 기동, 데이타베이스의 작성, 테스트 데이터의 투입을 해 개발에 필요한 데이타베이스 관련의 준비를 합니다.

Docker로 시작한 MySQL 지속성
지금까지도 Docker 이미지를 사용하여 시작한 MySQL을 사용해 왔습니다만, Docker의 컨테이너를 재기동하면 데이터가 사라져 버렸습니다. 그래서 이 장에서는 데이터의 지속성을 한 컨테이너를 사용하여 개발해 나갈 것입니다.

Docker Compose라는 도구를 사용합니다. 이것은 구성 파일을 작성하고 여러 Docker 컨테이너를 동시에 시작할 수 있는 도구입니다. Listing 6.3.6 에서 docker-compose.yml이라는 파일을 생성한다. Spring Boot의 응용 프로그램과 직접 관련이 없기 때문에 파일을 만드는 위치는 프로젝트 외부의 모든 위치에서 문제가되지 않습니다. 샘플 프로젝트는 프로젝트 바로 아래의 docker 디렉토리에 있습니다.

Listing 6.3.6

 version: '3'
 services:
   # MySQL
   db:
     image: mysql:8.0.23
     ports:
       - "3306:3306"
     container_name: mysql_host
     environment:
       MYSQL_ROOT_PASSWORD: mysql
     command: mysqld --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci
     volumes:
       - ./db/data:/var/lib/mysql
       - ./db/my.cnf:/etc/mysql/conf.d/my.cnf
       - ./db/sql:/docker-entrypoint-initdb.d
그런 다음 파일을 만든 디렉토리로 이동하여 명령 6.3.7 의 명령을 실행합니다.

명령 6.3.7

 $ docker-compose up -d
이제 MySQL 컨테이너가 시작됩니다. 이 컨테이너를 삭제하고 다시 시작해도 데이터를 남길 수 있습니다. 이 문서의 본문에서 벗어나므로 파일에 대한 자세한 설명은 생략하지만 volumes 에서 지정한 경로의 디렉토리에 컨테이너에서 만든 데이터가 저장됩니다. 이 예에서는 docker-compose.yml이 있는 디렉토리 아래에 db라는 디렉토리가 만들어지고 데이터를 저장하기 위한 파일이 작성됩니다.

응용 프로그램에서 사용할 데이터베이스 만들기
기동한 MySQL에, 어플리케이션에 필요한 데이타베이스와 테스트 데이터를 작성해 갑니다.

터미널에서 명령 6.3.8 명령으로 MySQL에 로그인하고 book_manager라는 데이터베이스를 만들고 선택합니다 ( 명령 6.3.9 , 명령 6.3.10 ).

명령 6.3.8

 $ mysql -h 127.0.0.1 --port 3306 -uroot -pmysql
명령 6.3.9

 mysql> create database book_manager;
명령 6.3.10

 mysql> use book_manager;
 Database changed
그런 다음 Listing 6.3.11 의 쿼리로 테이블을 생성한다.

Listing 6.3.11

 CREATE TABLE user (
   id bigint NOT NULL,
   email varchar(256) UNIQUE NOT NULL,
   password varchar(128) NOT NULL,
   name varchar(32) NOT NULL,
   role_type enum('ADMIN', 'USER'),
   PRIMARY KEY (id)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

 CREATE TABLE book (
   id bigint NOT NULL,
   title varchar(128) NOT NULL,
   author varchar(32) NOT NULL,
   release_date date NOT NULL,
   PRIMARY KEY (id)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

 CREATE TABLE rental (
   book_id bigint NOT NULL,
   user_id bigint NOT NULL,
   rental_datetime datetime NOT NULL,
   return_deadline datetime NOT NULL,
   PRIMARY KEY (book_id)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
그리고 Listing 6.3.12 의 쿼리에서 각 테이블에 테스트 데이터를 생성한다.

Listing 6.3.12

 insert into book values(100, 'Kotlin入門', 'コトリン太郎', '1950-10-01'), (200, 'Java入門', 'ジャヴァ太郎', '2005-08-29');

 insert into user values(1, 'admin@test.com', '$2a$10$.kLvZAQfzNvFFlXzaQmwdeUoq2ypwaN.A/GNy32', '管理者', 'ADMIN'), (2, 'user@test.com', '$2a$10$dtB.bySf.ZcbOPOp3Q7ZgedqofClN56rQ6JboxBuiW02twNMcAoZS', 'ユーザー', 'USER');
user 테이블에 패스워드로서 등록하고 있는 값은, bcrypt 의 알고리즘으로 해시화된 것이 되어 있습니다. 제 7 장의 로그인 기능의 구현에 대해 설명합니다만, 시큐리티상의 관점에서 패스워드는 모두 해시화된 형태로 취급합니다. 테스트 데이터를 추가하는 경우 마찬가지로 해시된 암호를 설정해야 합니다. 작성 방법은 샘플 프로젝트 주 2 의 README에 기재되어 있으므로 그쪽을 참조하십시오.

MyBatis의 코드 생성
작성한 테이블에 대해 MyBatis Generator에서 코드 생성을 합니다. 앞의 build.gradle.kts에서 설정했듯이 /src/main/resources 아래에 generatorConfig.xml이라는 구성 파일을 만듭니다 ( Listing 6.3.13 ).

Listing 6.3.13
제5장에서 소개한 것과 거의 같습니다만, 참조하는 데이타베이스명이나 출력처의 패키지명등을 프로젝트에 맞추어 변경하고 있습니다. 여기서도 classPathEntry 로 지정하고 있는 mysql-connector-java 의 패스는, 각자의 환경에 맞추어 변경해 주세요 주3 .

또한 ①의 테이블 태그에서 columnOverride 라는 태그를 사용하고 있습니다. 이것은 특정의 컬럼을 지정해, 자동 생성하는 코드를 재기입할 수가 있습니다. 여기서는 typeHandler 속성에 EnumTypeHandler 를 지정하여 role_type 이라는 열의 값을 Enum 과 연결할 수 있도록 합니다. 연결할 Enum 으로 com.book.manager.domain 아래에 enum 패키지를 만들고 그 아래에 목록 6.3.14 의 Enum 클래스 RoleType 을 만듭니다.

Listing 6.3.14

 enum class RoleType { ADMIN, USER }
그리고 파일의 출력처 패키지(여기에서는 com.book.manager.infrastructure.database)를 작성해, 커멘드 6.3.15 의 커멘드를 실행, 혹은 IntelliJ IDEA의 Gradle 뷰로부터 [Tasks]→[other]→[mbGenerator] 를 실행하여 생성합니다.

명령 6.3.15

 $ ./gradlew mbGenerator
지정된 패키지 아래에 생성된 UserRecord 클래스를 보면 Listing 6.3.16 과 같다.

Listing 6.3.16

 data class UserRecord(
     var id: Long? = null,
     var email: String? = null,
     var password: String? = null,
     var name: String? = null,
     var roleType: RoleType? = null
 )
user 테이블의 컬럼 role_type 에 첨부하는 프로퍼티 roleType 가, RoleType 형으로서 정의되고 있습니다 (전술의 columnOverride 의 설정을 넣지 않았던 경우는 String 형이 됩니다). 이제 데이터베이스에서 user 테이블의 데이터를 가져올 때 role_type 값은 비슷한 Enum 값(여기서는 ADMIN 또는 USER )으로 받을 수 있습니다.

5장에서는 하나의 테이블만 사용했지만 이 장에서는 세 개의 테이블을 작성했으므로 다음과 같이 각 테이블에 해당하는 파일을 작성합니다.

울com.book.manager.infrastructure.database.mapper
・BookDynamicSqlSupport.kt
・북매퍼.kt
・BookMapperExtensions.kt
・RentalDynamicSqlSupport.kt
・렌탈매퍼.kt
・RentalMapperExtensions.kt
・UserDynamicSqlSupport.kt
・UserMapper.kt
・UserMapperExtensions.kt
울com.book.manager.infrastructure.database.record
북레코드.kt
・렌탈레코드.kt
・UserRecord.kt
테이블 이름이 있는 xxxxDynamicSqlSupport.kt, xxxxMapper.kt, xxxxMapperExtensions.kt, xxxxRecord.kt입니다. 각 역할은 5장에서 설명한 것과 동일합니다.

application.yml에서 데이터베이스 및 Jackson 설정
src/main/resources 아래에 또 하나, 이쪽도 제5장의 「5. Spring Boot에서 MyBatis 사용하기」에서 해설한, application.yml를 작성해 데이타베이스에의 접속 정보등을 기술합니다 ( Listing 6.3.17 ).

Listing 6.3.17

 spring:
   datasource:
     url: jdbc:mysql://127.0.0.1:3306/book_manager?characterEncoding=utf8
     username: root
     password: mysql
     driverClassName: com.mysql.jdbc.Driver
   jackson:
     property-naming-strategy: SNAKE_CASE
datasource 에서 데이터베이스 연결 정보를 설정하는 것 외에도 jackson 에서 Jackson에 대한 설정을 포함합니다. property-naming-strategy 에서 변환 소스, 변환 대상 JSON 속성의 명명 규칙을 지정합니다. 여기에서는 SNAKE_CASE 를 지정하고 있기 때문에, 요청, 응답으로 취급하는 JSON의 프로퍼티은 스네이크 케이스가 됩니다. 예를 들어 Kotlin의 코드 측면에서 bookId 라는 이름으로 정의한 경우 JSON에서 book_id 로 처리됩니다. 또한 여기에서도 5장의 설명과 마찬가지로 application.properties가 작성된 경우 삭제하십시오.

프런트 엔드 환경 구축
프런트 엔드 Vue.js 환경을 구축합니다. 먼저 다음 리포지토리를 Clone하고 터미널에서 디렉토리 아래 part2 / front / book-manager로 이동하십시오 ( 명령 6.3.18 ).

https://github.com/n-takehata/kotlin-server-side-programming-practice

명령 6.3.18

 $ git clone git@github.com:n-takehata/kotlin-server-side-programming-practice.git
 // 出力は省略

 $ cd kotlin-server-side-programming-practice/part6/front/book-manager
npm install 이라는 명령을 실행합니다 ( 명령 6.3.19 ).

명령 6.3.19

 $ npm install
npm은 Node Package Manager이며, 여기서는 응용 프로그램에서 사용하는 Node.js와 관련된 종속성을 설치합니다.

그런 다음 명령 6.3.20 의 명령으로 Vue.js 응용 프로그램을 시작합니다.

명령 6.3.20

 $ npm run dev
이제 프런트 엔드 Vue 애플리케이션이 시작되었습니다. 시작시 로그에 출력되었지만 8081 포트를 사용하고 있습니다. http://localhost:8081에 액세스하고 그림 6.4 와 같은 화면이 표시되면 성공합니다.

그림 6.4
동작 확인용의 샘플 때문에, 레이아웃이나 화면 천이등은 상당히 간략화하고 있습니다. 작성한 API를 프런트 엔드에서 실행하여 쉽게 움직이고 싶은 분은 이용하십시오. 후술하는 각 기능의 항목에서 소통의 순서도 설명합니다.

그러면 이후 각 API의 구현을 소개합니다.

4　검색계 기능(일람 취득, 상세 취득)의 API 구현
여기에서는 검색계 기능의 API를 구현해 갑니다. 검색 시스템 기능은 모든 권한의 사용자가 실행할 수 있습니다.

목록 취득 기능 구현
우선은 일람 취득 기능의 구현입니다. 기능의 구현과 아울러, 이 어플리케이션의 아키텍쳐에서의 구현 방법에 대해서도 소개해 갑니다.

여기에서 구현해 가는 각 기능은, 주로 이하의 클래스나 인터페이스로 구성된 것이 됩니다.

울Mapper(검색계 기능만)
울Repository 인터페이스, RepositoryImpl 클래스
울서비스 클래스
울Controller 클래스
Repository 인터페이스, RepositoryImpl 클래스는 데이터베이스 관련 처리, Service 클래스는 비즈니스 로직, Controller 클래스는 라우팅이나 파라미터의 전달 등의 역할을 담당합니다. 각각의 세세한 역할이나 의미는 후술의 구현에 해설합니다.

화면 이미지
목록 획득 API를 사용하는 화면 이미지는 그림 6.5 입니다.

그림 6.5
이 화면에서,

울서적명(제목)
울저자
울대출 상황
울업데이트, 삭제 기능에 대한 링크
를 표시합니다. 또한 책 이름을 클릭하면 해당 책의 상세 화면으로 이동하므로,

울책 ID
도 필요합니다.

여러 테이블을 JOIN하는 Mapper 만들기
이 API에서는 앞서 설명한 책의 정보와 함께 대출 상황을 취득할 필요가 있기 때문에, 책의 마스터 정보인 book 테이블과 대출 상황을 관리하고 있는 rental 테이블을 JOIN하여 데이터를 취득하는 쿼리 필요합니다. 지금까지 쿼리의 실행은 MyBatis Generator에서 생성한 Mapper의 함수를 사용해 왔습니다만, JOIN 등, 생성된 함수에서는 실현할 수 없는 쿼리를 사용하는 경우, 스스로 커스터마이즈한 Mapper를 작성할 필요가 있습니다.

먼저 Listing 6.4.1 의 BookWithRentalRecord 클래스를 생성한다.

Listing 6.4.1

 data class BookWithRentalRecord(
     var id: Long? = null,
     var title: String? = null,
     var author: String? = null,
     var releaseDate: LocalDate? = null,
     var userId: Long? = null,
     var rentalDatetime: LocalDateTime? = null,
     var returnDeadline: LocalDateTime? = null
 )
이것은 book 테이블과 rental 테이블을 JOIN한 결과를 저장하기 위한 클래스입니다. BookRecord의 정보에 가세해, rental 테이블로부터 취득하는 대출중의 유저 ID, 대출 일시와 반환 예정 일시를 보관 유지하고 있습니다.

그런 다음 Listing 6.4.2 의 BookWithRentalMapper 인터페이스를 생성한다. 여기까지 MyBatis Generator에서 생성한 것을 그대로 사용해 왔기 때문에 설명을 생략하고 있었습니다만, Mapper의 쓰는 방법에 대해서도 여기에서 간단하게 소개합니다. 덧붙여 사용하고 있는 클래스나 함수 중(안)에서 IDE의 보완으로는 잘 할 수 없는 것이 몇가지 있기 때문에, 예외적으로 import문도 포함해 기재하고 있습니다.

Listing 6.4.2

 import com.book.manager.infrastructure.database.record.BookWithRentalRecord
 import org.apache.ibatis.annotations.Mapper
 import org.apache.ibatis.annotations.Result
 import org.apache.ibatis.annotations.Results
 import org.apache.ibatis.annotations.SelectProvider
 import org.apache.ibatis.type.JdbcType
 import org.mybatis.dynamic.sql.select.render.SelectStatementProvider
 import org.mybatis.dynamic.sql.util.SqlProviderAdapter

 @Mapper
 interface BookWithRentalMapper {
     @SelectProvider(type = SqlProviderAdapter::class, method = "select")
     @Results(
         id = "BookWithRentalRecordResult", value = [
             Result(column = "id", property = "id", jdbcType = JdbcType.BIGINT, id = true),
             Result(column = "title", property = "title", jdbcType = JdbcType.VARCHAR),
             Result(column = "author", property = "author", jdbcType = JdbcType.VARCHAR),
             Result(column = "release_date", property = "releaseDate", jdbcType = JdbcType.DATE),
             Result(column = "user_id", property = "userId", jdbcType = JdbcType.BIGINT),
             Result(column = "rental_datetime", property = "rentalDatetime", jdbcType = JdbcType.TIMESTAMP),
             Result(column = "return_deadline", property = "returnDeadline", jdbcType = JdbcType.TIMESTAMP)
         ]
     )
     fun selectMany(selectStatement: SelectStatementProvider): List<BookWithRentalRecord>
 }
여기서는 selectMany 함수만 정의합니다. 함수명은 임의입니다만, 자동 생성의 Mapper와 아울러 이 이름으로 하고 있습니다. 인수에 전달하는 SelectStatementProvider 형식의 값은 MyBatis Dynamic SQL을 사용하여 조립한 쿼리에 대한 정보를 보유하는 개체입니다. 여기에서는 후술하는 selectMany 함수의 호출 처리에서 구체적인 설명을 합니다. 여러 레코드를 검색하는 쿼리를 실행하는 처리가 되므로 반환 값은 BookWithRentalRecord 의 List가 됩니다.

@SelectProvider 어노테이션은 인수로 전달하는 selectStatement 에서 실행되는 쿼리를 생성하기위한 설정을합니다. type 속성으로 지정하는 SqlProviderAdapter 클래스의 select 메서드( method 속성으로 지정한 이름의 메서드)를 사용하여 쿼리를 생성합니다.

그리고 @Results 어노테이션은 쿼리 결과를 받는 객체와 매핑합니다. id 속성에는 임의의 캐릭터 라인을 지정해, value 속성에서는 Result 어노테이션을 사용해 이하의 지정을 하고 있습니다.

울column…… 테이블의 컬럼명
울property… … 반환값의 객체(여기에서는 BookWithRentalRecord)의 프로퍼티명
울jdbcType…… MyBatis상에서 취급할 때의 JDBC 타입
울id ...... 기본 키의 경우 true
이제 쿼리 결과에서 column 에서 지정한 열의 값을 property 로 설정한 속성으로 설정한 개체를 가져올 수 있습니다.

그리고 BookWithRentalMapperExtentions.kt라는 이름으로 파일을 만들고 (파일 이름은 선택 사항) 목록 6.4.3 의 내용을 설명합니다. 여기도 목록 6.4.2 와 같은 이유로 import 문을 포함하여 기재하고 있습니다.

Listing 6.4.3

 import com.book.manager.infrastructure.database.mapper.BookDynamicSqlSupport.Book
 import com.book.manager.infrastructure.database.mapper.BookDynamicSqlSupport.Book.author
 import com.book.manager.infrastructure.database.mapper.BookDynamicSqlSupport.Book.id
 import com.book.manager.infrastructure.database.mapper.BookDynamicSqlSupport.Book.releaseDate
 import com.book.manager.infrastructure.database.mapper.BookDynamicSqlSupport.Book.title
 import com.book.manager.infrastructure.database.mapper.RentalDynamicSqlSupport.Rental
 import com.book.manager.infrastructure.database.mapper.RentalDynamicSqlSupport.Rental.rentalDatetime
 import com.book.manager.infrastructure.database.mapper.RentalDynamicSqlSupport.Rental.returnDeadline
 import com.book.manager.infrastructure.database.mapper.RentalDynamicSqlSupport.Rental.userId
 import com.book.manager.infrastructure.database.record.BookWithRentalRecord
 import org.mybatis.dynamic.sql.SqlBuilder.equalTo
 import org.mybatis.dynamic.sql.SqlBuilder.select
 import org.mybatis.dynamic.sql.util.kotlin.mybatis3.from

 private val columnList = listOf(
     id,
     title,
     author,
     releaseDate,
     userId,
     rentalDatetime,
     returnDeadline
 )

 fun BookWithRentalMapper.select(): List<BookWithRentalRecord> {
     val selectStatement = select(columnList).from(Book, "b") {
         leftJoin(Rental, "r") {
             on(Book.id, equalTo(Rental.bookId))
         }
     }
     return selectMany(selectStatement)
 }
여기는 BookWithRentalMapper 함수를 사용하여 쿼리를 생성하고 실행하는 확장 함수를 정의한 파일입니다. 파일명은 임의입니다만, 이쪽도 MyBatis Generator로 생성되는 이름에 맞추고 있습니다. book 및 rental 테이블을 JOIN하여 데이터를 검색하는 쿼리를 생성하는 프로세스를 정의합니다. 이 프로세스에서 실행되는 쿼리는 Listing 6.4.4 와 동일하다.

Listing 6.4.4

 select b.id, b.title, b.author, b.release_date, r.user_id, r.rental_datetime, r.return_deadline from book b left join rental r on b.id = r.book_id
처리와 함께 살펴보면, 우선 최초의 select(columnList) 로 SELECT구를 지정하고 있습니다. columnList 는 테이블별로 생성되는 열 정보의 정의로, BookDynamicSqlSupport 와 RentalDynamicSqlSupport 의 object에 정의되고 있는 필드를 참조해 List로 하고 있습니다.

from , leftJoin 은 각각 FROM 절과 JOIN 절을 지정합니다. 각각 테이블에 해당하는 SqlTable 의 object와 별칭을 지정하고 있습니다.

그리고 on 으로 ON 절의 조건을 지정합니다. 첫 번째 인수는 왼쪽의 id (book 테이블)이고 두 번째 인수는 등가 조건을 나타내는 equalTo 함수를 사용하고 오른쪽의 book_id (rental 테이블)를 지정합니다.

MyBatis Dynamic SQL을 사용하면 함수를 체인하고 중첩하여 JOIN과 같은 복잡한 쿼리를 실행할 수 있습니다. 지금까지는 MyBatis Generator에서 생성된 함수에서의 쿼리만을 사용해 왔지만, 스스로 쿼리를 작성하는 경우도 매우 직관적입니다.

Repository 구현
먼저 Repository 구현입니다. Repository는 디자인 패턴의 일종으로 데이터베이스 조작의 논리를 추상화하는 역할을 담당합니다. 먼저 Listing 6.4.5 , Listing 6.4.6 의 Book 클래스, Rental 클래스와 두 개의 데이터 클래스를 속성으로 가진 Listing 6.4.7 의 BookWithRental 클래스를 생성한다.

Listing 6.4.5

 data class Book(
     val id: Long,
     val title: String,
     val author: String,
     val releaseDate: LocalDate
 )
Listing 6.4.6

 data class Rental(
     val bookId: Long,
     val userId: Long,
     val rentalDatetime: LocalDateTime,
     val returnDeadline: LocalDateTime
 )
Listing 6.4.7

 data class BookWithRental(
     val book: Book,
     val rental: Rental?
 ) {
     val isRental: Boolean
         get() = rental != null
 }
책 은 책을 나타내는 도메인 객체로 책 정보를 다루는 과정에서 사용합니다. Rental 클래스는 대출 정보를 처리하는 도메인 객체입니다. 그 2개의 클래스를 프로퍼티로서 가지는 BookWithRental 클래스를, 일람 기능으로 필요한 서적과 대출의 정보를 묶은 데이터를 취득하기 위해서 사용합니다. rental 프로퍼티는 Null 허용이 되고 있어 데이터가 없는 경우 (대출되어 있지 않은 경우)는 null 가 들어가는 가정입니다. 또한 isRental 이라는 확장 속성을 정의합니다. 이것은 rental 의 값을 체크해, 대출중인가 어떤가를 Boolean 형의 값으로 돌려줍니다.

그런 다음 Listing 6.4.8 의 Repository 인터페이스를 작성한다. BookWithRental 클래스의 List를 반환 값으로 반환하는 findAllWithRental 함수를 정의합니다.

Listing 6.4.8

 interface BookRepository {
     fun findAllWithRental(): List<BookWithRental>
 }
그리고 Listing 6.4.9 의 Repository 구현 클래스를 생성한다.

Listing 6.4.9

 @Suppress("SpringJavaInjectionPointsAutowiringInspection")
 @Repository
 class BookRepositoryImpl(
     private val bookWithRentalMapper: BookWithRentalMapper
 ) : BookRepository {
     override fun findAllWithRental(): List<BookWithRental> {
         return bookWithRentalMapper.select().map { toModel(it) }
     }

     private fun toModel(record: BookWithRentalRecord): BookWithRental {
         val book = Book(
             record.id!!,
             record.title!!,
             record.author!!,
             record.releaseDate!!
         )
         val rental = record.userId?.let {
             Rental(
                 record.id!!,
                 record.userId!!,
                 record.rentalDatetime!!,
                 record.returnDeadline!!
             )
         }
         return BookWithRental(book, rental)
     }
 }
방금 만든 BookWithRentalMapper 에서 데이터를 가져오고 Record 클래스를 map 으로 BookWithRental 클래스로 변환한 값을 반환합니다.

Interface를 사용하여 구현하면 데이터베이스 관련 구현을 BookRepositoryImpl 에 갇히고 호출 계층에서 의식 할 필요가 없습니다. 예를 들어 RDB나 O/R매퍼로 사양 변경이 있었을 때나, 다른 미들웨어나 프레임워크로 바꾸고 싶었을 때의 영향 범위를 BookRepositoryImpl 에만 둘 수 있습니다.

반환값을 BookWithRental 클래스로 변환해 돌려주고 있는 것도, Record 클래스가 프레임워크(MyBatis)측의 사양에 의존하는 것이므로, Mapper에서의 파라미터의 교환으로만 사용되는 역할에 그치고, 호출측의 층 에서 다루지 않게 하기 위해서입니다.

또, @Repository 라고 하는 어노테이션을 부여하고 있습니다만, 이쪽은 제4장에서 해설한 @Component 와 같이 DI의 대상인 것을 나타내는 어노테이션입니다. BookRepositoryImpl 클래스와 같이 데이터베이스 액세스 처리를 담당하는 클래스에 사용합니다. 본서에서의 사용법에서는 @Component 를 사용한 경우와 거동은 변하지 않습니다만, 후술하는 @Service 도 포함한 클래스의 역할 마다 주석을 나누어 두는 것으로, 제7장에서 소개하는 AOP를 사용할 때 등 에 대상 클래스를 분류하기 쉬워지고 유연성이 높아집니다.

서비스 구현
다음 으로 Service 클래스의 구현입니다. Listing 6.4.10 의 클래스를 생성한다.

Listing 6.4.10

 @Service
 class BookService(
     private val bookRepository: BookRepository
 ) {
     fun getList(): List<BookWithRental> {
         return bookRepository.findAllWithRental()
     }
 }
Service는 Repository에서 데이터 조작 처리 등을 사용하여 비즈니스 로직을 구현하는 계층이 됩니다. 여기에서는 BookRepository 의 검색 처리를 호출해, 반환하는 것만의 처리가 되어 있습니다.

@Service 어노테이션은 @Repository 와 마찬가지로 DI 대상으로 하기 위한 것으로, BookService 클래스와 같이 비즈니스 로직의 처리를 담당하는 클래스에 사용합니다.

컨트롤러 구현
마지막으로 Controller의 구현입니다. 여기는 API의 라우팅이나 클라이언트로부터의 파라미터를 받아서 Service의 로직을 실행하는 계층이 됩니다.

먼저 BookForm.kt(이름은 임의)라는 파일을 만들고 목록 6.4.11 의 데이터 클래스를 만듭니다.

Listing 6.4.11

 data class GetBookListResponse(val bookList: List<BookInfo>)

 data class BookInfo(
     val id: Long,
     val title: String,
     val author: String,
     val isRental: Boolean
 ) {
     constructor(model: BookWithRental) : this(model.book.id, model.book.title, model.book.author, model.isRental)
 }
여기에는 각 API의 요청, 응답의 파라미터가 되는 객체를 데이터 클래스로 정의합니다. 리스트 취득의 처리에 관해서는 리퀘스트 파라미터가 없기 때문에, 응답의 GetBookListResponse 클래스만 만들고 있습니다.

BookInfo 는 도메인 객체의 Book 클래스와 유사하지만 화면 표시에 필요한 isRental 의 진위 값을 가지고 있습니다.

도메인 오브젝트는 그 도메인( Book 의 경우는 책)의 행동을 나타내는 처리가 들어갑니다만, 리퀘스트, 응답의 오브젝트는 어디까지나 파라미터로서 취급할 뿐입니다. 그 때문에 기능에 따라서는 거의 같은 구현이 되는 경우도 있습니다만, 반드시 도메인 오브젝트와는 다른 클래스로서 정의하도록 하고 있습니다.

그리고 Listing 6.4.12 의 Controller 클래스를 만든다.

Listing 6.4.12

 @RestController
 @RequestMapping("book")
 @CrossOrigin
 class BookController(
     private val bookService: BookService
 ) {
     @GetMapping("/list")
     fun getList(): GetBookListResponse {
         val bookList = bookService.getList().map {
             BookInfo(it)
         }
         return GetBookListResponse(bookList)
     }
 }
컨트롤러 의 경로 경로로 책 을 정의합니다. 이 클래스 내에서 라우팅되는 경로에는 반드시 book 이 붙는 형태가 됩니다. 그리고 /list 라는 경로의 GET 메소드로 요청을 받아들이고, BookService 의 처리를 실행해, 결과를 map 에서 GetBookListResponse 로 변환해 반환하고 있습니다.

이것으로 리스트 취득 기능의 API가 완성되었습니다.

동작 확인
응용 프로그램 시작은 bootRun 작업을 수행합니다. 터미널에서 명령 6.4.13 의 명령을 실행하거나 IntelliJ IDEA의 Gradle 뷰에서 [Tasks] → [application] → [bootRun]을 선택하여 실행하십시오.

명령 6.4.13

 $ ./gradlew bootRun
그런 다음 6.4.14 명령 의 curl 명령을 실행합니다.

명령 6.4.14

 $ curl http://localhost:8080/book/list
Listing 6.4.15 와 같이 책 정보의 배열을 가진 JSON이 반환되면 성공한다.

Listing 6.4.15

 {"book_list":[{"id":100,"title":"Kotlin入門","author":"コトリン太郎","is_rental":false},{"id":200,"title":"Java入門","author":"ジャヴァ太郎","is_rental":false}]}
아직 대출중인 정보가 없기 때문에 is_rental 에는 false가 들어 있습니다.

프런트 엔드와의 소통
완성된 API를 프런트 엔드와 소통합니다. 서버와 프런트 엔드 응용 프로그램이 모두 실행되면 브라우저에서 http://localhost:8081/book/list로 이동합니다. 책 목록 페이지에 액세스하고 그 중 Ajax에서 방금 만든 목록 획득 API가 호출됩니다.

그림 6.6 과 같은 화면이 표시되면 성공입니다.

그림 6.6
상세 취득 기능의 구현
이어서 상세 취득 기능의 구현입니다. 책의 ID를 요청 매개변수로 받고 책에 대한 자세한 정보를 반환합니다.

화면 이미지
상세 검색 API를 사용하는 화면 이미지는 그림 6.7 입니다.

그림 6.7
책의 정보로서,

울책 이름
울저자
울발매일
를 표시합니다. 또, 리스트 화면과 같은 갱신, 삭제의 링크에 가세해, 대출의 링크(대출 가능의 경우만 표시)도 배치되고 있습니다.

Mapper 구현
먼저 BookWithRentalMapper 인터페이스에 Listing 6.4.16 의 selectOne 함수를 추가한다.

Listing 6.4.16

 @SelectProvider(type = SqlProviderAdapter::class, method = "select")
 @ResultMap("BookWithRentalRecordResult")
 fun selectOne(selectStatement: SelectStatementProvider): BookWithRentalRecord?
Listing 6.4.2 의 selectMany 는 여러 레코드를 얻는 Select를 정의하는 함수였지만, 이것은 단일 레코드를 얻는 함수이다. 따라서 반환 값도 단일 BookWithRentalRecord 입니다.

그리고 BookWithRentalMapperExtentions.kt에 Listing 6.4.17 의 함수를 추가한다.

Listing 6.4.17

 fun BookWithRentalMapper.selectByPrimaryKey(id_: Long): BookWithRentalRecord? {
     val selectStatement = select(columnList).from(Book, "b") {
         leftJoin(Rental, "r") {
             on(Book.id, equalTo(Rental.bookId))
         }
         where(id, isEqualTo(id_))
     }
     return selectOne(selectStatement)
 }
select 함수와 마찬가지로 book 테이블과 rental 테이블을 JOIN 한 쿼리를 발행하고 있지만, where 에서 id 를 지정하고 있습니다. 그리고 방금 추가한 selectOne 함수를 호출하여 단일 레코드의 결과를 반환합니다.

Repository 구현
다음 Repository 구현입니다. BookRepository 인터페이스에 Listing 6.4.18 , BookRepositoryImpl 클래스에 Listing 6.4.19 의 함수를 추가한다.

Listing 6.4.18

 fun findWithRental(id: Long): BookWithRental?
Listing 6.4.19

 override fun findWithRental(id: Long): BookWithRental? {
     return bookWithRentalMapper.selectByPrimaryKey(id)?.let { toModel(it) }
 }
Mapper에 추가한 selectByPrimaryKey 함수를 호출하고 데이터를 검색할 수 있으면 Book 으로 변환하여 반환합니다.

안전 호출과 let 을 결합하여 데이터를 얻을 수 없으면 null을 반환합니다. 이 데이터 취득의 가부(null인가 아닌가)에 의해 반환하는 값을 바꾸는 것은, let 의 흔한 사용법의 하나입니다.

서비스 구현
BookService 클래스에 Listing 6.4.20 의 함수를 추가한다.

Listing 6.4.20

 fun getDetail(bookId: Long): BookWithRental {
     return bookRepository.findWithRental(bookId) ?: throw IllegalArgumentException("存在しない書籍ID: $bookId")
 }
BookRepository 의 findWithRental 함수를 호출하여 도서 정보를 가져오고, 존재하지 않으면 예외를 던지고 있습니다. 여기서 엘비스 연산자를 사용하고 있습니다만, 이러한 「결과가 null이었을 경우에 예외를 던진다」라고 하는 처리는 사용지중의 하나입니다.

Kotlin에서는, if (hoge != null) …… 로 기술하는 처리는 전술의 안전 호출과 let 의 조합, if (hoge == null) … .

컨트롤러 구현
응답 매개변수 유형으로 BookForm.kt에 Listing 6.4.21 의 데이터 클래스를 추가한다. 도서 정보 외에 대여중인 사용자 ID, 대여 날짜 및 시간, 반환 예정 날짜 및 시간 정보를 보유하고 있습니다.

Listing 6.4.21

 data class GetBookDetailResponse(
     val id: Long,
     val title: String,
     val author: String,
     val releaseDate: LocalDate,
     val rentalInfo: RentalInfo?
 ) {
     constructor(model: BookWithRental) : this(
         model.book.id,
         model.book.title,
         model.book.author,
         model.book.releaseDate,
         model.rental?.let { RentalInfo(model.rental) })
 }

 data class RentalInfo(
     val userId: Long,
     val rentalDatetime: LocalDateTime,
     val returnDeadline: LocalDateTime,
 ) {
     constructor(rental: Rental) : this(rental.userId, rental.rentalDatetime, rental.returnDeadline)
 }
그리고 BookController 클래스에 Listing 6.4.22 의 함수를 추가한다.

Listing 6.4.22

 @GetMapping("/detail/{book_id}")
 fun getDetail(@PathVariable("book_id") bookId: Long): GetBookDetailResponse {
     val book = bookService.getDetail(bookId)
     return GetBookDetailResponse(book)
 }
/detail 이라는 경로에서 book_id 를 경로 매개 변수로 받고 서비스 처리를 호출하고 결과를 GetBookDetailResponse 로 변환하고 반환합니다.

동작 확인
터미널에서 명령 6.4.23 의 curl 명령을 실행합니다.

명령 6.4.23

 $ curl http://localhost:8080/book/detail/200
 {"id":200,"title":"Java入門","author":"ジャヴァ太郎","release_date":"2005-08-29","rental_info":null}
도서 상세 정보를 가진 JSON이 반환되면 성공합니다. 대여되지 않은 책의 경우 rental_info 는 null입니다.

프런트 엔드와의 소통
완성된 API를 프런트 엔드와 소통합니다. 서버와 프런트 엔드 응용 프로그램이 모두 실행되면 브라우저에서 http://localhost:8081/book/detail/200에 액세스하십시오. 도서 목록의 페이지로 이동하여 고급 검색 API가 호출됩니다.

그림 6.8 과 같은 화면이 표시되면 성공입니다.

그림 6.8
5　갱신계 기능(등록, 갱신, 삭제)의 API 구현
여기에서 업데이트 시스템 기능의 API를 구현합니다. 업데이트 시스템 기능은 관리자 권한만 실행할 수 있습니다. 그 때문에, 같은 서적 데이터에 대한 조작입니다만, 검색계 기능이란 Controller나 Service의 클래스를 나누어 구현합니다.

또한, 권한에 의한 액세스의 제한에 대해서는 제7장에서 구현하기 때문에, 이 장의 시점에서는 모든 유저가 실행할 수 있는 것이 됩니다.

등록 기능 구현
우선 등록 기능의 구현입니다.

화면 이미지
등록 API를 사용하는 화면 이미지는 그림 6.9 입니다.

그림 6.9
책의 마스터 정보인,

울책 ID(ID)
울서적명(제목)
울저자
울발매일
를 입력하고 [등록] 버튼을 누르면 실행됩니다.

Repository 구현
BookRepository 인터페이스에 Listing 6.5.1 의 함수를 추가한다.

Listing 6.5.1

 fun register(book: Book)
BookRepositoryImpl 클래스에 목록 6.5.2 의 import 문, 목록 6.5.3 의 생성자에서 BookMapper 의 DI, 목록 6.5.4 의 함수를 추가합니다.

Listing 6.5.2

 import com.book.manager.infrastructure.database.mapper.insert
Listing 6.5.3

 class BookRepositoryImpl(
     private val bookWithRentalMapper: BookWithRentalMapper,
     private val bookMapper: BookMapper // 追加
 ) : BookRepository {
     // 省略
Listing 6.5.4

 override fun register(book: Book) {
     bookMapper.insert(toRecord(book))
 }

 private fun toRecord(model: Book): BookRecord {
     return BookRecord(model.id, model.title, model.author, model.releaseDate)
 }
Book 클래스를 인수로 받아 MyBatis의 Record 클래스로 변환한 객체를 BookWithRentalMapperExtentions.kt에 정의된 Mapper의 확장 함수인 insert 함수에 건네주어 실행하고 있습니다. 일람, 상세의 취득 처리에서는 BookRecord 클래스의 값을 Book 클래스로 변환하는 toModel 함수를 사용하고 있었습니다만, 여기에서는 반대로 Book 클래스로부터 BookRecord 클래스로 변환하는 toRecord 함수를 정의하고 있습니다.

import문을 추가하고 있는 이유는 insert 함수가 BookMapper 클래스와 BookWithRentalMapperExtentions.kt 둘 다에 존재하며, import 문을 쓰지 않으면 BookMapper 클래스의 함수가 호출되어 컴파일 오류가 되기 때문입니다.

서비스 구현
앞서 언급했듯이 검색 시스템 기능과는 별도의 Service 클래스에서 구현합니다. Listing 6.5.5 와 같이 AdminBookService 라는 클래스를 만들고 register 함수를 추가한다.

Listing 6.5.5

 @Service
 class AdminBookService(
     private val bookRepository: BookRepository
 ) {
     @Transactional
     fun register(book: Book) {
         bookRepository.findWithRental(book.id)?.let { throw IllegalArgumentException("既に存在する書籍ID: ${book.id}") }
         bookRepository.register(book)
     }
 }
등록 대상의 데이터가 설정된 Book 클래스의 오브젝트를 인수로서 받아, BookRepository 의 함수를 호출 등록 처리를 실시합니다. 등록하기 전에 findWithRental 함수를 호출하고 등록하려는 ID의 데이터가 이미 존재하는 경우 예외를 던지고 있습니다. 데이터가 없으면 register 함수에 book 을 그대로 전달하고 실행합니다.

@Transactional 어노테이션은 Spring Framework에서 제공하는 트랜잭션 관리 기능을 활성화합니다. 부여한 함수내의 처리에 대해서 트랜잭션(transaction)를 붙여, 처리가 정상적으로 끝나면 커밋, 예외가 발생했을 경우는 롤백합니다.

컨트롤러 구현
Controller의 구현입니다. 요청 매개변수 유형으로 BookForm.kt에 Listing 6.5.6 의 데이터 클래스를 추가한다.

Listing 6.5.6

 data class RegisterBookRequest(
     val id: Long,
     val title: String,
     val author: String,
     val releaseDate: LocalDate
 )
그리고 여기도 AdminBookController 라는 새로운 클래스를 만듭니다 ( 목록 6.5.7 ). 클래스에 대한 @RequestMapping 어노테이션에서 경로의 루트로 admin/book 을 지정합니다.

Listing 6.5.7

 @RestController
 @RequestMapping("admin/book")
 @CrossOrigin
 class AdminBookController(
     private val adminBookService: AdminBookService
 ) {
     @PostMapping("/register")
     fun register(@RequestBody request: RegisterBookRequest) {
         adminBookService.register(
             Book(
                 request.id,
                 request.title,
                 request.author,
                 request.releaseDate
             )
         )
     }
 }
register 함수는 /register 라는 경로에서 RegisterBookRequest 유형에 해당하는 JSON을 매개 변수로 사용하고 Book 클래스의 인스턴스를 생성하여 Service 처리를 호출합니다.

동작 확인
터미널에서 명령 6.5.8 의 curl 명령을 실행합니다.

명령 6.5.8

 $ curl -H 'Content-Type:application/json' -X POST -d '{"id":300,"title":"Spring入門","author":"スプリング太郎","release_date":"2001-03-21"}' http://localhost:8080/admin/book/register
그리고 커맨드 6.5.9 와 같이 일람 취득의 API를 실행해, 등록한 내용의 반영된 결과가 돌려주면 성공입니다.

명령 6.5.9

 $ curl http://localhost:8080/book/list
 {"book_list":[{"id":100,"title":"Kotlin入門","author":"コトリン太郎","is_rental":false},{"id":200,"title":"Java入門","author":"ジャヴァ太郎","is_rental":false},{"id":300,"title":"Spring入門","author":"スプリング太郎","is_rental":false}]}
프런트 엔드와의 소통
완성된 API를 프런트 엔드와 소통합니다. 서버와 프런트 엔드 응용 프로그램이 모두 실행되면 브라우저에서 http://localhost:8081/admin/book/register로 이동합니다. 그림 6.10 과 같은 등록 페이지가 표시됩니다.

그림 6.10
그리고 내용을 입력하고 [등록] 버튼을 눌러 그림 6.11 과 같은 화면이 표시되면 성공합니다.

그림 6.11
업데이트 기능 구현
다음은 업데이트 기능의 구현입니다. 이쪽은 등록 처리와 닮아 있어 심플한 것이 되어 있습니다.

화면 이미지
업데이트 API를 사용하는 화면 이미지는 그림 6.12 입니다.

그림 6.12
업데이트할 책 정보가 표시됩니다. 변경하려는 항목의 값을 수정하고 [갱신] 버튼을 누르면 실행됩니다. 등록 화면과 비슷한 형태이지만 책 ID는 변경할 수 없게 되어 있습니다.

Repository 구현
BookRepository 인터페이스에 Listing 6.5.10 , BookRepositoryImpl 클래스에 Listing 6.5.11 함수를 추가한다.

Listing 6.5.10

 fun update(id: Long, title: String?, author: String?, releaseDate: LocalDate?)
Listing 6.5.11

 override fun update(id: Long, title: String?, author: String?, releaseDate: LocalDate?) {
     bookMapper.updateByPrimaryKeySelective(BookRecord(id, title, author, releaseDate))
 }
book 테이블의 각 열의 업데이트 후 값을 인수로 받고 기본 키를 사용하여 업데이트합니다. id 이외의 인수가 Null 허용이 되는 것은, 갱신이 필요한 컬럼만 값이 설정되기 때문입니다. null가 들어온 컬럼은 갱신되지 않습니다.

서비스 구현
AdminBookService 클래스에 목록 6.5.12 의 함수를 추가합니다.

Listing 6.5.12

 @Transactional
 fun update(bookId: Long, title: String?, author: String?, releaseDate: LocalDate?) {
     bookRepository.findWithRental(bookId) ?: throw IllegalArgumentException("存在しない書籍ID: $bookId")
     bookRepository.update(bookId, title, author, releaseDate)
 }
findWithRental 함수에서 도서 정보를 검색하고, 존재하지 않으면 예외를 던지고, 존재하는 경우 bookRepository 의 update 함수를 호출하여 업데이트합니다.

컨트롤러 구현
요청 매개변수 유형으로 BookForm.kt에 Listing 6.5.13 의 데이터 클래스를 추가한다.

Listing 6.5.13

 data class UpdateBookRequest(
     val id: Long,
     val title: String?,
     val author: String?,
     val releaseDate: LocalDate?
 )
이쪽도 갱신하고 싶은 컬럼의 값만 받기 때문에, 주키가 되는 ID 이외는 Null 허용이 되어 있습니다. 그리고 AdminBookController 클래스에 Listing 6.5.14 의 함수를 추가한다.

Listing 6.5.14

 @PutMapping("/update")
 fun update(@RequestBody request: UpdateBookRequest) {
     adminBookService.update(request.id, request.title, request.author, request.releaseDate)
 }
/update 라는 경로에서 UpdateBookRequest 형식에 해당하는 JSON을 매개 변수로 받아서 서비스 처리를 호출합니다.

동작 확인
터미널에서 명령 6.5.15 의 curl 명령을 실행합니다. 여기에서는 방금 등록한 id 가 300인 책의 타이틀을 변경하고 있습니다.

명령 6.5.15

 $ curl -H 'Content-Type:application/json' -X PUT -d '{"id":300,"title":"Spring Boot入門"}' http://localhost:8080/admin/book/update
그리고 상세 취득 API로 id 가 300을 파라미터로 해 실행해, 커멘드 6.5.16 과 같이 갱신한 내용의 반영된 결과가 돌려주면 성공입니다.

명령 6.5.16

 $ curl http://localhost:8080/book/detail/300
 {"id":300,"title":"Spring Boot入門","author":"スプリング太郎","release_date":"2001-03-21","rental_info":null}
프런트 엔드와의 소통
완성된 API를 프런트 엔드와 소통합니다. 서버와 프런트 엔드 응용 프로그램이 모두 시작된 상태에서 브라우저에서 http://localhost:8081/admin/book/update/400으로 이동하십시오 (400 부분은 업데이트 할 레코드의 ID이므로 필요합니다. 따라서 업데이트하려는 대상 값으로 변경하십시오.) 그림 6.13 과 같은 도서 업데이트 페이지가 표시됩니다.

그림 6.13
그리고 갱신하고 싶은 항목의 내용을 변경하고 [갱신] 버튼을 눌러 그림 6.14 와 같은 화면이 표시되면 성공입니다.

그림 6.14
삭제 기능 구현
다음은 삭제 기능입니다. 이제 책 데이터에 대한 기능은 마지막입니다.

화면 이미지
삭제 API를 사용하는 화면 이미지는 그림 6.15 , 그림 6.16 입니다.

그림 6.15
그림 6.16
도서 목록 화면, 도서 상세 화면에서 [삭제] 링크를 누르면 확인 팝업이 표시되고 [OK] 버튼을 누르면 실행됩니다.

Repository 구현
BookRepository 인터페이스에 Listing 6.5.17 , BookRepositoryImpl 클래스에 Listing 6.5.18 의 함수를 추가한다.

Listing 6.5.17

 fun delete(id: Long)
Listing 6.5.18

 override fun delete(id: Long) {
     bookMapper.deleteByPrimaryKey(id)
 }
삭제하려는 레코드의 ID 를 받고 기본 키를 사용하여 삭제합니다. 삭제하려면 Mapper의 deleteByPrimaryKey 함수를 사용합니다.

서비스 구현
AdminBookService 클래스에 목록 6.5.19 의 함수를 추가합니다.

Listing 6.5.19

 @Transactional
 fun delete(bookId: Long) {
     bookRepository.findWithRental(bookId) ?: throw IllegalArgumentException("存在しない書籍ID: $bookId")
     bookRepository.delete(bookId)
 }
업데이트 기능과 마찬가지로 findWithRental 함수에서 도서 정보를 검색하고 존재하지 않으면 예외를 던지고 있습니다. 존재하는 경우 bookRepository 의 delete 함수를 호출하여 삭제합니다.

컨트롤러 구현
AdminBookController 클래스에 목록 6.5.20 의 함수를 추가합니다.

Listing 6.5.20

 @DeleteMapping("/delete/{book_id}")
 fun delete(@PathVariable("book_id") bookId: Long) {
     adminBookService.delete(bookId)
 }
/delete 라는 경로에서 삭제할 레코드의 id 를 경로 매개 변수로 받아서 서비스 처리를 호출합니다. id 만을 요청 매개변수로 수신하고 응답이 없으므로 BookForm.kt에 클래스 추가가 없습니다.

동작 확인
터미널에서 명령 6.5.21 의 curl 명령을 실행합니다. ID 가 300인 책의 데이터를 삭제 중입니다.

명령 6.5.21

 $ curl -X DELETE http://localhost:8080/admin/book/delete/300
그리고 리스트 취득의 API를 실행해, 커멘드 6.5.22 와 같이 대상의 데이터의 삭제가 반영된 결과가 돌려주면 성공입니다.

명령 6.5.22

 $ curl http://localhost:8080/book/list
 {"book_list":[{"id":100,"title":"Kotlin入門","author":"コトリン太郎","is_rental":false},{"id":200,"title":"Java入門","author":"ジャヴァ太郎","is_rental":false}]}
이제 책 데이터에 대한 각종 조작을 하는 API를 구현할 수 있었습니다.

프런트 엔드와의 소통
완성된 API를 프런트 엔드와 소통합니다. 서버와 프런트 엔드 응용 프로그램이 모두 실행된 상태에서 브라우저에서 http://localhost:8081/book/list로 이동하여 책 중 하나에서 삭제 링크를 누르십시오. 그림 6.17 과 같이 삭제 확인 팝업이 나타납니다.

그림 6.17
[OK]를 눌러 그림 6.18 과 같은 화면이 표시되면 성공합니다.

그림 6.18
注1 　 https://jeffreypalermo.com/2008/07/the-onion-architecture-part-1/

( 본문으로 돌아가기 )

注2 　 https://github.com/n-takehata/kotlin-server-side-programming-practice

( 본문으로 돌아가기 )

주3　 제5장의 「3.MyBatis의 도입」을 참조.

( 본문으로 돌아가기 )

