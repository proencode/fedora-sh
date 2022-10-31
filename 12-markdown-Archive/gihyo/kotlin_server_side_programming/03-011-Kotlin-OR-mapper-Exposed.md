







## 제11장　Kotlin제 O/R매퍼 Exposed

제10장에서는 Spring Boot를 대신하는 웹 어플리케이션 프레임워크로서 Ktor에 대해서 해설했습니다만, 본장에서는 Ktor와 같이 JetBrains사가 개발하고 있는 Kotlin제 프레임워크인, O/R매퍼의 Exposed를 소개합니다. Kotlin에서 O/R매퍼를 사용할 때, 본서에서 소개하고 있는 MyBatis도 포함해 Java제의 것이 사용되는 것이 현재는 많습니다. 그 중 몇 안되는 Kotlin제의 것으로, Kotlin 엔지니어들 사이에서는 전부터 알려진 존재입니다. 이쪽도 아직 채용 사례는 적습니다만, 서버 측 개발에 필수적인 O/R 매퍼의 선택사항의 하나가 될 수 있으므로, 기억해 두어 주셨으면 합니다.

1　Exposed란?
Exposed는 Kotlin의 개발원인 JetBrains사가 개발하고 있는 Kotlin제의 O/R매퍼 입니다 . SQL 라이크에 구현할 수 있는 DSL(Domain Specific Language), 경량인 DAO(Data Access Object)라는 2개의 액세스 방법이 준비되어 있는 것이 특징으로 말해집니다.

쓰기 시점에서 최신 버전이 0.29.1이기 때문에 아직 프로토 타입 단계이지만, Ktor와 마찬가지로 Kotlin 제의 프레임 워크로 유명한 것 중 하나입니다.

2　Exposed 도입
IntelliJ IDEA에서 임의의 Gradle 프로젝트를 만들고 build.gradle.kts에 설정을 추가합니다.

먼저 Listing 11.2.1 과 같이 repositories 를 변경하고 jcenter() 를 추가한다.

목록 11.2.1

 repositories {
     mavenCentral()
     jcenter()
 }
이것은 의존성으로 설정한 라이브러리를 취득해 오는 대상의 리포지터리를 설정하고 있습니다만, 본장에서 추가하는 Exposed에 관련하는 것은 이 jcenter() 라고 하는 장소로부터 취득할 필요가 있기 (위해)때문에, 추가 하고 있습니다.

그리고 dependencies 에 Listing 11.2.2 의 종속성을 추가한다.

목록 11.2.2

 implementation("org.jetbrains.exposed:exposed-core:0.29.1")
 implementation("org.jetbrains.exposed:exposed-dao:0.29.1")
 implementation("org.jetbrains.exposed:exposed-jdbc:0.29.1")
 implementation("mysql:mysql-connector-java:8.0.23")
exposed-core 는 Exposed의 베이스가 되는 라이브러리군으로, exposed-dao 는 전술의 DAO의 구현을 할 때에 필요한 라이브러리군, exporsed-jdbc 에는 데이터베이스와의 커넥션 주위에 필요한 라이브러리군이 들어가 있습니다 . 또한 데이터베이스에는 MySQL을 사용하기 때문에 mysql-connector-java 도 추가합니다.

테스트 테이블 및 데이터 작성
데이터베이스는 MySQL을 로컬로 설치하고 시작하거나 5장, 6장에서 소개한 Docker에서 시작하여 사용하십시오. 그런 다음 명령 11.2.3 에서 데이터베이스를 작성하고 선택하고 목록 11.2.4 의 쿼리로 테이블을 작성하십시오.

명령 11.2.3

 mysql> create database exposed_example;
 Query OK, 1 row affected (0.02 sec)
 mysql> use exposed_example;
 Database changed
목록 11.2.4

 CREATE TABLE member(
   id int NOT NULL AUTO_INCREMENT,
   name varchar(32) NOT NULL,
   PRIMARY KEY (id)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
3　DSL과 DAO 각각의 구현 방법
앞에서 언급했듯이 Exposed는 DSL과 DAO라는 두 가지 구현 방법을 제공합니다.

DSL로 데이터 조작 구현
우선 DSL의 예입니다. DSL은 Kotlin의 코드 내에서 쿼리를 구축하도록 구현하고 SQL을 작성하는 것과 비슷한 감각으로 작성할 수있는 방법으로되어 있습니다.

임의의 파일을 만들고 Listing 11.3.1 과 같이 구현한다.

목록 11.3.1
DAO와 공통이 되는 부분도 있습니다만, 차례로 설명해 갑니다.

Table 객체
먼저 Table 이라는 클래스를 상속하고 테이블 구조에 따라 속성을 가진 객체를 만듭니다 ( 목록 11.3.2 ).

Listing 11.3.2 (Listing 11.3.1의 ①을 발췌)

 object Member : Table("member") {
     val id = integer("id").autoIncrement()
     val name = varchar("name", 32)
 }
Table 의 생성자에 건네주고 있는 캐릭터 라인은 대상의 테이블명입니다.

테스트 데이터로서 작성한 멤버 테이블에 대응해, id 와 name 를 보관 유지하고 있습니다. 초기화의 값으로서 설정하고 있는 것은 컬럼의 정보입니다. int 형의 id 는 integer , varchar 형의 name 은 varchar 로, 각각 컬럼명을 인수에 건네줍니다 ( varchar 에는 컬럼 길이도 제 2 인수로서 건네줍니다). id 는 AUTO_INCREMENT 에 정의되어 있으므로 체인하고 autoIncrement 함수를 호출합니다.

이 객체를 테이블에의 쿼리 실행 등으로 사용해 갑니다.

데이터베이스에 연결
Listing 11.3.3 의 Database.connect 함수를 사용하여 데이터베이스에 연결한다.

Listing 11.3.3 (Listing 11.3.1의 ②를 발췌)

 Database.connect(
     "jdbc:mysql://127.0.0.1:3306/exposed_example",
     driver = "com.mysql.jdbc.Driver",
     user = "root",
     password = "mysql"
 )
인수로 전달하는 것은 다음 네 가지입니다.

울대상 데이터베이스의 URL
울사용할 드라이버 클래스 (여기에서는 MySQL JDBC 드라이버)
울사용자 이름
울비밀번호
트랜잭션 정의
다음으로 트랜잭션 정의입니다. Listing 11.3.4 와 같이 transaction{} 의 블록으로 묶인 단위로 트랜잭션이 발생한다.

Listing 11.3.4 (Listing 11.3.1의 ③ 블록)

 transaction {
     // 省略
 }
이 중 쿼리 처리를 구현합니다.

표준 로그 출력 사용
Listing 11.3.5 의 addLogger 함수는 필요한 로그 출력을 활성화한다.

Listing 11.3.5 (Listing 11.3.1의 ④ 발췌)

 addLogger(StdOutSqlLogger)
여기에서는 StdOutSqlLogger 의 객체를 전달하고 표준 로깅을 추가합니다. 추가된 대상에 대해 Exposed에서 실행한 쿼리의 로그가 출력됩니다.

필수는 아니지만 런타임 설명을 위해 활성화되었습니다.

INSERT 문 실행
Listing 11.3.6 에서 INSERT 문을 쿼리한다.

Listing 11.3.6 (Listing 11.3.1의 ⑤ 발췌)

 val id = Member.insert {
     it[name] = "Kotlin"
 } get Member.id
 println("Inserted id: $id")
앞의 Table 클래스를 상속한 개체는 해당 테이블에 대한 다양한 쿼리를 실행하는 함수를 제공합니다. 여기에서는 insert 함수를 실행해, 람다 식으로 등록하는 값을 설정합니다. 람다 식은 Table 의 객체 (여기서는 Member )를 취하고 [] 에 열 속성을 지정하여 설정하려는 열을 지정할 수 있습니다. id 는 AUTO_INCREMENT 이므로 생략할 수 있습니다.

그리고 get 컬럼의 프로퍼티 라고 기술하는 것으로, 등록 결과로부터 지정의 컬럼의 값을 취득할 수 있습니다. 여기에서는 id 를 지정하고 있기 때문에, 등록시에 AUTO_INCREMENT 에서 자동 번호 매겨진 id 의 값을 취득해, 출력하고 있습니다.

SELECT 문 실행
Listing 11.3.7 에서 SELECT 문을 실행하고있다.

Listing 11.3.7 (Listing 11.3.1의 ⑥ 발췌)

 val member = Member.select { Member.id eq id }.single()
 println("id: ${member[Member.id]}")
 println("name: ${member[Member.name]}")
select 함수를 호출하고 람다 식에서 Table 클래스의 열을 사용하여 검색 조건 (SQL의 WHERE 절에 해당하는 부분)을 설명합니다. 여기에서는 기본 키인 id 에 앞서 설명한 insert 의 결과로서 취득한 id 를 지정하고 있습니다. single 은 쿼리의 단일 결과 집합을 가져옵니다(여러 레코드가 있으면 오류가 발생함).

그리고 결과는 ResultRow 라는 클래스의 형태로 취득되어 member[Member.id] 와 Map와 같은 형식으로 Table 객체의 프로퍼티을 key에 건네주면, 그 프로퍼티에 대응하는 컬럼의 값을 취득할 수 있습니다.

동작 확인
IntelliJ IDEA에서 main 함수를 실행합니다.

실행 결과로서 Listing 11.3.8 과 같은 내용이 콘솔에 표시된다.

목록 11.3.8

 SQL: INSERT INTO `member` (`name`) VALUES ('Kotlin')
 Inserted id: 1
 SQL: SELECT `member`.id, `member`.`name` FROM `member` WHERE `member`.id = 1
 id: 1
 name: Kotlin
SQL: 뒤에 출력되는 쿼리는 앞에서 설명한 addLogger 함수로 활성화된 표준 출력의 내용입니다. Exposed로부터 실행된 INSERT문, SELECT문이 각각 출력되고 있습니다. 그리고 INSERT문의 뒤에는 등록시에 생성된 id 가, SELECT문의 뒤에는 취득한 레코드의 각 컬럼의 값을 출력하고 있습니다.

이상으로 DSL에서의 구현이 가능했습니다. 이와 같이 insert 나 select 와 같은 SQL의 키워드가 함수명이 되어 있거나, WHERE구를 쓰도록(듯이) 람다 식으로 조건을 지정하는 등, SQL과 같은 감각으로 직관적으로 구현할 수가 있습니다.

DAO에서 데이터 조작 구현
다음은 DAO에서의 구현을 소개한다. DAO는 DSL과 달리 SQL 생성 등이 래핑된 함수를 사용하여 데이터베이스 조작을 할 수 있는 액세스 방법입니다.

구현은 Listing 11.3.9 와 같다.

목록 11.3.9
DSL과 공통의 부분은 생략해, 차분이 있는 개소를 설명해 갑니다.

Table 객체와 Entity 클래스
DAO는 Table 객체 외에도 Entity 클래스를 만듭니다 ( Listing 11.3.10 ).

Listing 11.3.10 (Listing 11.3.9의 ①을 발췌)

 object MemberTable : IntIdTable("member") {
     val name = varchar("name", 32)
 }

 class MemberEntity(id: EntityID<Int>) : IntEntity(id) {
     companion object : IntEntityClass<MemberEntity>(MemberTable)

     var name by MemberTable.name
 }
Entity 는 전술의 「SQL의 생성등이 랩핑 된 함수」를 가지고 있어, Entity 클래스를 상속합니다. 여기서 상속하는 IntEntity 클래스는 Entity 의 하위 클래스이며 int 형식의 기본 키가 있는 테이블에서 사용됩니다. 아울러 Table 객체 쪽에서도, Table 클래스의 자식 클래스인 IntIdTable 를 상속하고 있습니다.

필드로서는 IntEntityClass 에 이 Entity 클래스를 형태 파라미터, Table 클래스를 생성자의 인수에 건네주어 정의합니다.

또한 기본 키의 id 이외의 열 (여기서는 name )의 필드도 추가합니다. 이 필드는 Table 클래스의 해당 열의 필드로 위임합니다.

INSERT 문 실행
INSERT문의 실행은 Listing 11.3.11 과 같이 구현된다.

Listing 11.3.11 (Listing 11.3.9의 ②를 발췌)

 val member = MemberEntity.new {
     name = "Kotlin"
 }
 println("Inserted id: ${member.id}")
Entity 클래스의 new 함수를 사용합니다. new 함수는 람다 식으로 Entity 클래스를 취해, 필드에 값을 대입하는 것으로 등록하는 컬럼의 데이터를 지정할 수 있습니다. 여기서도 id 는 AUTO_INCREMENT 이므로 생략합니다.

그리고 반환값으로서 등록 후의 값이 설정된 Entity 클래스가 돌아오기 때문에, id 의 값을 취득해 출력하고 있습니다.

SELECT 문 실행
SELECT문의 실행은 Listing 11.3.12 와 같이 구현된다.

목록 11.3.12 (목록 11.3.9의 ③을 발췌)

 MemberEntity.findById(member.id)?.let {
     println("id: ${it.id}")
     println("name: ${it.name}")
 }
Entity 클래스에서 기본 키를 검색하는 경우 findById 라는 함수가 제공되며, 이에 인수로 기본 키의 값을 전달하면 얻을 수 있습니다. 그리고 Null 허용의 Entity 클래스가 돌아오기 때문에, 안전 호출과 let 로 각 컬럼의 값을 출력하고 있습니다.

DSL의 select 함수와 달리, 기본 키 검색을 위한 함수로서 준비되어 있어, 간단하게 구현할 수 있는 것을 알 수 있습니다.

동작 확인
이쪽도 동작 확인은 main 함수를 실행하면 할 수 있습니다. Listing 11.3.13 과 같은 내용이 콘솔에 출력되면 성공이다.

목록 11.3.13

 SQL: INSERT INTO `member` (`name`) VALUES ('Kotlin')
 Inserted id: 1
 id: 1
 name: Kotlin
4　DAO에서 CRUD 만들기
제3절에서는 DSL과 DAO 각각의 기본적인 구현 방법을 소개했지만, 여기에서는 DAO를 사용하여 CRUD를 작성해 나갑니다. Listing 11.4.1 의 쿼리를 실행하고 테스트 데이터를 등록한다.

목록 11.4.1

 INSERT INTO member(name) VALUES('Ichiro'), ('Jiro'), ('Saburo');
id 의 값은 AUTO_INCREMENT 에 맡기기 때문에, 등록전에 데이터가 들어가 있는 경우는 이후의 샘플의 실행 결과와는 다른 값이 됩니다. 만약 같은 실행 결과로 확인하고 싶은 경우는, 일단 member 테이블의 데이터를 TRUNCATE문으로 삭제하고 나서, Listing 11.4.1 의 INSERT문을 실행해 주세요.

그런 다음 임의의 파일을 작성하고 Listing 11.4.2 의 함수를 구현한다.

목록 11.4.2

 fun createSessionFactory() {
     Database.connect(
         url = "jdbc:mysql://127.0.0.1:3306/exposed_example",
         driver = "com.mysql.jdbc.Driver",
         user = "root",
         password = "mysql"
     )
 }
데이터베이스에 대한 연결을 설정하는 프로세스를 함수화했습니다. 이 후 소개하는 CRUD의 샘플에서도 여기를 호출합니다. 또한 Listing 11.4.3 의 데이터 클래스를 생성한다.

목록 11.4.3

 data class MemberModel(val id: Int, val name: String) {
     constructor(entity: MemberEntity) : this(entity.id.value, entity.name)
 }
출력 결과를 알기 쉽게 하기 위해, Entity 클래스를 건네주는 생성자를 정의해, 테이블 구조와 같은 프로퍼티을 가지는 데이터 클래스로 변환할 수 있도록 하고 있습니다.

Select 구현 방법
모든 검색
전체 검색은 Listing 11.4.4 와 같이 구현된다.

목록 11.4.4

 createSessionFactory()
 transaction {
     val list = MemberEntity.all().map { MemberModel(it) }
     list.forEach {
         println(it)
     }
 }
> 실행 결과

 MemberModel(id=1, name=Ichiro)
 MemberModel(id=2, name=Jiro)
 MemberModel(id=3, name=Saburo)
위의 createSessionFactory 함수를 사용하여 데이터베이스에 연결하고 all ​​함수로 실행합니다. 결과는 Entity 클래스의 SizedIterable이라는 Iterable 형식으로 반환되므로 map 에서 MemberModel 의 List로 변환하여 출력합니다.

기본 키 검색
기본 키 검색은 3절에 설명되어 있지만, 이 절에서의 구현 예제는 Listing 11.4.5 이다.

목록 11.4.5

 createSessionFactory()
 transaction {
     val entity = MemberEntity.findById(2)
     entity?.let { println(MemberModel(it)) }
 }
> 실행 결과

 MemberModel(id=2, name=Jiro)
findById 로 취득한 Entity 클래스에 대해서, 안전 호출과 let 로 MemberModel 로 변환해 출력하고 있습니다.

기본 키 이외의 검색
기본 키 이외의 열을 검색 조건으로 만들려면 Listing 11.4.6 과 같이 find 함수를 사용한다.

목록 11.4.6

 createSessionFactory()
 transaction {
     val entity = MemberEntity.find { MemberTable.name eq "Saburo" }.map { MemberModel(it) }
     entity?.let { println(it) }
 }
> 실행 결과

 [MemberModel(id=3, name=Saburo)]
DSL select 함수와 유사한 방식으로 Table 클래스의 속성을 사용하여 WHERE 절의 값을 지정합니다. 기본 키 검색이 아니기 때문에 all 함수와 마찬가지로 SizedIterable 형의 값이 반환되므로 map 에서 MemberModel 의 List로 변환하여 출력하고 있습니다.

UNIQUE 키 제약이 있는 경우 등 일의에 레코드를 취득할 수 있는 경우는, first , firstOrNull 등의 콜렉션 라이브러리의 함수를 사용해 꺼낼 수도 있습니다.

Insert 구현 방법
등록도 제3절에서 소개하고 있습니다만, 본절에서의 샘플은 리스트 11.4.7 이 됩니다.

목록 11.4.7

 createSessionFactory()
 transaction {
     val entity = MemberEntity.new {
         name = "Shiro"
     }
     println(MemberModel(entity))
 }
> 실행 결과

 MemberModel(id=4, name=Shiro)
new 함수로 등록하고 결과를 MemberModel 로 변환하여 출력합니다.

Update 구현 방법
업데이트는 Listing 11.4.8 과 같이 구현된다.

목록 11.4.8

 createSessionFactory()
 transaction {
     val entity = MemberEntity.findById(4)
     entity?.let { it.name = "Yonro" }
 }
업데이트할 레코드를 검색하고 검색된 결과의 Entity 클래스에서 속성 값을 업데이트하면 데이터가 업데이트됩니다.

명령 11.4.9 의 SQL에서 검색하면 id 가 4인 레코드의 이름 이 "Yonro"로 업데이트됩니다.

명령 11.4.9
Delete 구현 방법
마지막은 삭제입니다. Listing 11.4.10 과 같이 구현한다.

목록 11.4.10

 createSessionFactory()
 transaction {
     val entity = MemberEntity.findById(4)
     entity?.let { it.delete() }
 }
업데이트할 레코드를 검색하고 검색된 결과의 Entity 클래스의 delete 함수를 실행하면 해당 레코드가 삭제됩니다.

여기도 다시 목록 11.4.9 의 SQL에서 검색하면 id 가 4의 레코드가 사라지고 있음을 알 수 있습니다 ( 명령 11.4.11 ).

명령 11.4.11

 mysql> SELECT * FROM member WHERE id = 4;
 Empty set (0.00 sec)
注1 　 https://github.com/JetBrains/Exposed

( 본문으로 돌아가기 )

