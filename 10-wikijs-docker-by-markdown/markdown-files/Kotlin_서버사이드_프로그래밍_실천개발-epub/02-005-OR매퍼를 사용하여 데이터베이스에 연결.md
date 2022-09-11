

20,$s/省略/생략/g
20,$s/行のレコードを挿入しました/줄의 코드를 넣었습니다./g
20,$s/Listing/목록/g
20,$s/リクエスト/리퀘스트/g
20,$s/レスポンス/리스폰스/g
20,$s/注/주/g




## 5장 O/R 매퍼를 사용하여 데이터베이스에 연결

관계형 데이터베이스는 많은 웹 애플리케이션의 서버 측 개발에 사용되는 미들웨어입니다. 그것을 프로그램에서 취급하기 위한 프레임워크인 O/R 매퍼도 매우 중요한 요소가 되어 옵니다. 다음의 6장부터 작성하는 실천의 어플리케이션에서도 사용하고 있습니다. 이 장에서는 MySQL로 구축한 데이터베이스에 대해 O/R 매퍼의 MyBatis를 사용하여 Kotlin에서 액세스하는 코드를 구현하고 Kotlin에서의 데이터베이스 처리를 배워 주시면 좋겠습니다.

### 1　MyBatis란?

MyBatis는 Java로 만든 O / R 매퍼 중 하나입니다. 원래는 XML에 SQL을 작성하고 코드에서 정의한 함수와끈끈첨부즈하는 것으로 SQL의 발행이나, 데이타베이스의 조작을 실현하는 것이었습니다.

최근 버전(글쓰기 시점에서 최신 버전은 3.5.6)에서는 MyBatis Dynamic SQL이라는 코드상에서 쿼리를 구축할 수 있는 방식이 추가되어 있으며, 그 실행에 필요한 코드를 Kotlin에서 생성하는 Generator도 준비되어 있습니다. 있습니다. 그 때문에 원래 Java제입니다만, Kotlin으로부터도 취급하기 쉬운 O/R매퍼가 되고 있습니다.

### 2　Docker로 MySQL 환경 구축

MyBatis를 사용할 때 먼저 로컬 환경에서 데이터베이스를 사용할 수 있습니다. 이번에 사용하는 것은 MySQL입니다.

#### Docker Desktop 설치

로컬에 MySQL을 직접 설치하는 것이 아니라, Docker의 컨테이너를 시작하는 형태로 준비합니다. 따라서 먼저 Docker Desktop을 설치하십시오.

##### 설치 프로그램 다운로드

Docker 공식 사이트의 다운로드 페이지 주 1 로 가면 그림 5.1 과 같은 화면이 표시되므로 Mac의 경우 "Docker Desktop for Mac", Windows의 경우 "Docker Desktop for Windows"를 선택합니다.

그림 5.1 Docker 공식 사이트 다운로드 페이지

모두 그림 5.2 와 같은 화면이 표시되므로 [Download from Docker Hub]를 누릅니다.

그림 5.2 Download from DOcker Hub

그리고 그림 5.3 과 같은 화면이 표시되므로 [Get Docker]를 누르면 Mac에서는 dmg 파일, Windows에서는 설치 프로그램의 exe 파일이 다운로드됩니다.

그림 5.3 Get Docker

그림 5.2 , 5.3 은 Mac 화면을 사용하고 있지만 Windows의 경우 각각 "for Mac" 부분이 "for Windows"로되어 있습니다.

##### Mac에서 설치, 시작
다운로드한 dmg 파일을 열면 그림 5.4 의 화면이 표시되므로 Docker.app를 Applications 디렉토리로 드래그 앤 드롭합니다.

그림 5.4 Application 디렉토리로 드러그앤드롭

설치는 이것으로 완료됩니다.

응용 프로그램 디렉토리 아래의 Docker.app를 시작하고 화면 상단의 Docker 아이콘에서 메뉴를 열고 "Docker Desktop is running"이 녹색으로되어 있으면 시작 성공입니다 ( 그림 5.5 ).

그림 5.5 Docker Desktop is running

##### Windows에서 설치, 시작

다운로드한 exe 파일을 열면 그림 5.6 과 같은 화면이 나타납니다. Install required Windows components for WSL 2의 선택을 취소하고 [OK]를 누릅니다.

그림 5.6 Windows 에 설치

설치가 완료되면 그림 5.7 과 같은 화면이 표시되므로 [Close and restart]를 누릅니다.

그림 5.7 Close and restart

그림 5.8 과 같은 화면이 표시되고 왼쪽 하단에 'Docker running'과 녹색 마크로 표시되어 있으면 시작 성공입니다.

그림 5.8 Docker running

#### MySQL 컨테이너 시작

터미널 소프트웨어(Mac에서는 터미널, Windows에서는 명령 프롬프트 또는 PowerShell 등)에서 명령 5.2.1 의 명령을 실행합니다. 커멘드의 상세한 설명은 생략합니다만, root 유저의 패스워드를 「mysql」, 포트가 「3306」으로 「mysql」라고 하는 컨테이너를, MySQL의 Docker 이미지를 사용해 기동하고 있습니다.

명령 5.2.1
```
$ docker container run --rm -d -e MYSQL_ROOT_PASSWORD=mysql -p 3306:3306 --name mysql mysql
341f0b0bdcb2b61f853af9758dda15216b0739e7d38642a75cc5e925ad69e0b6
```

명령 아래에 표시되는 해시 값은 시작된 컨테이너의 ID입니다. 부팅이 성공하면 표시됩니다. 표시되면 명령어 docker container ls 를 실행합니다. 명령 5.2.2 와 같이 시작된 mysql 컨테이너가 표시됩니다.

명령 5.2.2
그리고 명령 5.2.3 의 명령으로 MySQL에 로그인하십시오. Docker의 컨테이너로 시작하기 때문에 로컬 MySQL에 연결하는 것과 달리 호스트와 포트도 지정해야합니다.

명령 5.2.3
```
$ mysql -h 127.0.0.1 --port 3306 -uroot -pmysql
```

#### 데이터베이스, 테이블 만들기

로그인에 성공하면 이 장에서 사용할 데이터베이스와 테이블을 만듭니다. 먼저 example이라는 이름으로 데이터베이스를 만들고 ( 명령 5.2.4 ) 전환합니다 ( 명령 5.2.5 ).

명령 5.2.4
```
mysql> create database example;
```

명령 5.2.5
```
mysql> use example;
Database changed
```

그리고 목록 5.2.6 의 Create 문으로 테이블을 생성한다.

목록 5.2.6
```
CREATE TABLE user (
  id int(10) NOT NULL,
  name varchar(16) NOT NULL,
  age int(10) NOT NULL,
  profile varchar(64) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

show tables 명령을 사용하여 테이블이 만들어졌는지 확인합니다 ( 명령 5.2.7 ).

명령 5.2.7
```
mysql> show tables;
+-------------------+
| Tables_in_example |
+-------------------+
| user              |
+-------------------+
```

마지막으로 목록 5.2.8 의 쿼리에서 샘플 데이터를 등록한다.

목록 5.2.8
```
insert into user values (100, "gilfong", 30, "Hello"), (101, "dully", 25, "Hello"), (102, "ddochi", 20, "Hello");
```

Select 문으로 데이터가 들어 있는지 확인하고 데이터베이스 준비가 완료되었습니다 ( 명령 5.2.9 ).

명령 5.2.9
```
mysql> select * from user;
+-----+---------+-----+---------+
| id  | name    | age | profile |
+-----+---------+-----+---------+
| 100 | gildong |  30 | Hello   |
| 101 | dully   |  25 | Hello   |
| 102 | ddochi  |  20 | Hello   |
+-----+---------+-----+---------+
3 rows in set (0.00 sec)
```

이후의 설명에 관해서는, Mac의 환경을 사용해 진행해 갑니다.

### 3　MyBatis 도입

그런 다음 MyBatis를 사용하여 프로젝트를 만듭니다. 1장에서 소개한 절차에 따라 IntelliJ IDEA에서 Kotlin 프로젝트를 만듭니다. 반대로 몇 가지 설정을 추가합니다.

#### build.gradle.kts에 종속성 추가

build.gradle.kts에 몇 가지 설명을 추가합니다. 먼저 plugins 블록에 목록 5.3.1 의 행을 추가한다.

목록 5.3.1
```
id("com.arenagod.gradle.MybatisGenerator") version "1.4"
```

이것은 나중에 설명하는 MyBatis의 코드 생성에 사용되는 Gradle 플러그인을 추가합니다. 그런 다음 dependencies 블록에 목록 5.3.2 의 4행을 추가한다.

목록 5.3.2
```
implementation("org.mybatis:mybatis:3.5.6")
implementation("org.mybatis.dynamic-sql:mybatis-dynamic-sql:1.2.1")
implementation("mysql:mysql-connector-java:8.0.23")
mybatisGenerator("org.mybatis.generator:mybatis-generator-core:1.4.0")
```

mybatis , mysql-connector-java 는 MyBatis와 MySQL에서 DB 연결에 사용되는 커넥터 라이브러리의 종속성을 추가합니다. mybatis-dynamic-sql 은 여기에서도 아래에서 설명하는 자동 생성 코드에서 사용되는 라이브러리입니다. mybatis-generator-core 는 코드 생성을 수행하는 라이브러리입니다.

그리고 파일 끝에 목록 5.3.3 의 블록을 추가한다.

목록 5.3.3
```
mybatisGenerator {
    verbose = true
    configFile = "${projectDir}/src/main/resources/generatorConfig.xml"
}
```

이것은 여기까지 추가한 플러그인, 라이브러리를 사용해 코드 생성을 실행하는 Gradle의 태스크를 정의하고 있습니다. configFile 로 설정하고 있는 패스는 후술하는 설정 파일의 패스가 됩니다.

build.gradle.kts의 전체 파일은 목록 5.3.4 와 같다.

목록 5.3.4
```
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

plugins {
    id("com.arenagod.gradle.MybatisGenerator") version "1.4"
    kotlin("jvm") version "1.4.30"
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
    implementation("org.mybatis:mybatis:3.5.6")
    implementation("org.mybatis.dynamic-sql:mybatis-dynamic-sql:1.2.1")
    implementation("mysql:mysql-connector-java:8.0.23")
    mybatisGenerator("org.mybatis.generator:mybatis-generator-core:1.4.0")
    testImplementation(kotlin("test-junit"))
}

tasks.withType<KotlinCompile>() {
    kotlinOptions.jvmTarget = "11"
}

mybatisGenerator {
    verbose = true
    configFile = "${projectDir}/src/main/resources/generatorConfig.xml"
}
```

#### MyBatis Generator를 사용한 코드 생성

MyBatis에서는 데이터베이스의 테이블 구조와 함께 여러 파일을 만들어야합니다. 이러한 코드를 만들기 위해 위의 build.gradle.kts 설명에서도 작성한 MyBatis Generator를 사용합니다.

##### 구성 파일 추가

프로젝트의 src/main/resources 아래에 generatorConfig.xml이라는 이름으로 목록 5.3.5 의 내용을 가진 파일을 생성한다.

목록 5.3.5
```
  1: <?xml version="1.0" encoding="UTF-8" ?>
  2: <!DOCTYPE generatorConfiguration PUBLIC "-//mybatis.org//DTD
  3:   MyBatis Generator Configuration 1.0//EN"
  4:         "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd" >
  5: <generatorConfiguration>
  6:     <!-- mysql-connector-javaのパスは各自の環境に合わせて変更 -->
  7:     <classPathEntry
  8:             location="/Users/takehata/.gradle/caches/modules-2/files-2.1/mysql/mysql-connector-    java/8.0.23/d8d388e71c823570662a45dd33f4284141921280/mysql-connector-java-8.0.23.jar"/>
  9:     <context id="MySQLTables" targetRuntime="MyBatis3Kotlin">
 10:         <plugin type="org.mybatis.generator.plugins.MapperAnnotationPlugin"/>
 11:         <commentGenerator>
 12:             <property name="suppressDate" value="true"/>
 13:         </commentGenerator>
 14:         <jdbcConnection
 15:                 driverClass="com.mysql.jdbc.Driver"
 16:                 connectionURL="jdbc:mysql://127.0.0.1:3306/example"
 17:                 userId="root"
 18:                 password="mysql">
 19:             <property name="nullCatalogMeansCurrent" value="true" />
 20:         </jdbcConnection>
 21:         <javaModelGenerator
 22:                 targetPackage="database"
 23:                 targetProject="src/main/kotlin">
 24:         </javaModelGenerator>
 25:         <javaClientGenerator
 26:                 targetPackage="database"
 27:                 targetProject="src/main/kotlin">
 28:         </javaClientGenerator>
 29:         <table tableName="user"/>
 30:     </context>
 31: </generatorConfiguration>
```

MyBatis Generator를 실행하기 위한 설정 파일이 됩니다. 몇 가지 포인트를 설명합니다.

우선, 7~8행째의 classPathEntry 의 요소로 지정하고 있는 mysql-connector-java 의 패스입니다. 이것은 코드 생성 태스크의 실행시에 MySQL에 접속해 테이블 ​​정보를 참조하기 (위해)때문에, 그 접속에 사용하기 위한 커넥터의 라이브러리를 지정하고 있습니다. Gradle의 종속성으로 추가했기 때문에 $HOME/.gradle하하를 따라가면 다운로드된 jar 파일이 있으므로 그것을 지정합니다.

다음으로, 9행째의 targetRuntime="MyBatis3Kotlin" 로 생성에 사용하는 Generator를 지정하고 있습니다. 이 MyBatis3Kotlin을 사용하면 Kotlin 코드를 생성 할 수 있습니다.

14~20행의 jdbcConnection 으로 지정하고 있는 것이, 코드 생성하고 싶은 대상의 테이블이 포함되는 데이타베이스의 정보입니다. 연결할 URL(호스트, 포트, 데이터베이스 이름), 사용자 ID 및 비밀번호를 지정합니다. 또, 19행째로 <property name="nullCatalogMeansCurrent" value="true" /> 라고 하는 프로퍼티을 지정하고 있습니다만, MySQL 8계를 사용하고 있는 경우, 이 기술이 없으면 information_schema 나 performance_schema 가 대상에 포함되어 불필요한 코드가 생성됩니다.

그리고 21~28행째의 javaModelGenerator , javaClientGenerator 로 지정하고 있는 것이 코드의 출력처의 정보입니다. targetPackage 는 출력 대상 패키지를 지정하고 targetProject 는 프로젝트의 출력 대상 경로를 지정합니다. 여기서는 src/main/kotlin 아래의 database 패키지에 출력되도록 설정하고 있습니다.

마지막으로 29행 <table tableName="user"/> 에서 대상 테이블 이름을 지정했습니다. 테이블을 추가하는 경우 이 테이블 요소를 추가하여 대응할 수 있습니다. 또한 <table tableName="%"/> 및 와일드카드를 지정하여 대상 데이터베이스의 모든 테이블에 대해 실행할 수 있습니다.

##### 코드 생성 수행

터미널에서 명령 5.3.6 의 명령을 실행하거나 IntelliJ IDEA의 Gradle 뷰에서 [Tasks] → [other] → [mbGenerator]로 "MyBatisGenerator"의 태스크를 실행합니다.

명령 5.3.6
```
$ ./gradlew mbGenerator
```

src/main/kotlin 아래에 database라는 패키지가 만들어져 그 아래에 다음 4개의 파일이 생성되어 있다고 생각합니다.

- 사용자 기록.kt
- UserDynamicSqlSupport.kt
- UserMapper.kt
- UserMapperExtensions.kt

각각을 간단히 설명합니다.

첫째, UserRecord.kt는 테이블 구조에 해당하는 데이터 클래스입니다. 열 이름, 형식에 따라 속성으로 생성됩니다 ( 목록 5.3.7 ). 각 레코드의 데이터를 이 오브젝트에 넣어 취급합니다.

목록 5.3.7
```
data class UserRecord(
    var id: Int? = null,
    var name: String? = null,
    var age: Int? = null,
    var profile: String? = null
)
```

UserDynamicSqlSupport.kt는 아래에 설명 된 Mapper를 사용하여 쿼리를 실행할 때 열 지정 매개 변수로 사용할 필드를 정의합니다 ( 목록 5.3.8 ). 여기도 컬럼의 이름, 형식을 사용하여 컬럼마다 SqlColumn 이라는 클래스를 사용하여 만들어집니다.

목록 5.3.8
```
object UserDynamicSqlSupport {
    object User : SqlTable("user") {
        val id = column<Int>("id", JDBCType.INTEGER)

        val name = column<String>("name", JDBCType.VARCHAR)

        val age = column<Int>("age", JDBCType.INTEGER)

        val profile = column<String>("profile", JDBCType.VARCHAR)
    }
}
```

UserMapper.kt는 기본 쿼리 발행 함수가 정의 된 인터페이스입니다 ( 목록 5.3.9 ). Select 및 Insert와 같은 기본 DML(Data Manipulation Language, 데이터 조작 언어)에서 사용하는 함수가 포함되어 있습니다.

목록 5.3.9
```
@Mapper
interface UserMapper {
    @SelectProvider(type=SqlProviderAdapter::class, method="select")
    fun count(selectStatement: SelectStatementProvider): Long

    @DeleteProvider(type=SqlProviderAdapter::class, method="delete")
    fun delete(deleteStatement: DeleteStatementProvider): Int

    @InsertProvider(type=SqlProviderAdapter::class, method="insert")
    fun insert(insertStatement: InsertStatementProvider<UserRecord>): Int

    @InsertProvider(type=SqlProviderAdapter::class, method="insertMultiple")
    fun insertMultiple(multipleInsertStatement: MultiRowInsertStatementProvider<UserRecord>): Int

    @SelectProvider(type=SqlProviderAdapter::class, method="select")
    @ResultMap("UserRecordResult")
    fun selectOne(selectStatement: SelectStatementProvider): UserRecord?

    @SelectProvider(type=SqlProviderAdapter::class, method="select")
    @Results(id="UserRecordResult", value = [
        Result(column="id", property="id", jdbcType=JdbcType.INTEGER, id=true),
        Result(column="name", property="name", jdbcType=JdbcType.VARCHAR),
        Result(column="age", property="age", jdbcType=JdbcType.INTEGER),
        Result(column="profile", property="profile", jdbcType=JdbcType.VARCHAR)
    ])
    fun selectMany(selectStatement: SelectStatementProvider): List<UserRecord>

    @UpdateProvider(type=SqlProviderAdapter::class, method="update")
    fun update(updateStatement: UpdateStatementProvider): Int
}
```

그리고 UserMapperExtensions.kt는 UserMapper 의 함수를 사용하여 쿼리를 실행하는 확장 함수를 정의합니다 ( 목록 5.3.10 ). 실제 쿼리의 실행 처리는 이쪽의 확장 함수를 사용하는 경우가 많습니다.

목록 5.3.10
```
fun UserMapper.count(completer: CountCompleter) =
    countFrom(this::count, User, completer)

fun UserMapper.delete(completer: DeleteCompleter) =
    deleteFrom(this::delete, User, completer)

fun UserMapper.deleteByPrimaryKey(id_: Int) =
    delete {
        where(id, isEqualTo(id_))
    }

fun UserMapper.insert(record: UserRecord) =
    insert(this::insert, record, User) {
        map(id).toProperty("id")
        map(name).toProperty("name")
        map(age).toProperty("age")
        map(profile).toProperty("profile")
    }

    // 생략
```

이러한 자동 생성 파일은 기본적으로 손을 넣지 않습니다. 이 안에 있는 인터페이스나 함수를 호출해 쿼리의 실행 처리를 구현하는 형태가 됩니다. 다음은 그 호출측의 처리의 구현을 소개합니다.

### 4　MyBatis에서 CRUD 만들기

사전 준비가 길어졌습니다만, 드디어 MyBatis를 사용한 데이터베이스에 액세스하는 CRUD(Create=Insert, Read=Select, Update, Delete)를 구현합니다. 그 전에는 다른 구성 파일이 필요하고 src/main/resources 아래에 mybatis-config.xml이라는 이름으로 목록 5.4.1 의 내용을 가진 파일을 생성한다.

목록 5.4.1
```
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC"/>
            <dataSource type="POOLED">
                <property name="driver" value="com.mysql.jdbc.Driver"/>
                <property name="url" value="jdbc:mysql://127.0.0.1:3306/example"/>
                <property name="username" value="root"/>
                <property name="password" value="mysql"/>
            </dataSource>
        </environment>
    </environments>
    <mappers>
        <mapper class="database.UserMapper"/>
    </mappers>
</configuration>
```

앞에서 설명한 generatorConfig.xml은 MyBatis Generator를 실행할 때 사용하는 설정이었지만 이 프로그램은 MyBatis를 프로그램에서 사용할 때 필요한 설정입니다. 이 파일에는 데이터베이스에 대한 연결 정보도 포함되어 있습니다. 또한 mappers 라는 요소 중 MyBatis Generator에서 생성한 UserMapper 를 등록하고 있습니다. 테이블을 추가하고 새로 xxxxMapper 를 생성한 경우 여기에도 설정을 추가해야 합니다.

그리고 모든 Kotlin 파일을 만들고 목록 5.4.2 의 함수를 작성한다.

목록 5.4.2
```
fun createSessionFactory(): SqlSessionFactory {
    val resource = "mybatis-config.xml"
    val inputStream = Resources.getResourceAsStream(resource)
    return SqlSessionFactoryBuilder().build(inputStream)
}
```

mybatis-config.xml 파일을 읽고 SqlSessionFactory 라는 인터페이스 객체를 만듭니다. 이것은 데이터베이스에 연결하는 세션을 만드는 객체입니다. 이 함수는 여기에서 소개하는 각 쿼리의 실행 처리에서 매번 사용합니다.

파일을 읽는 데 사용하는 Resources 클래스는 같은 이름의 여러 개가 존재하기 때문에 혼동 스럽습니다.이 프로세스에서는 org.apache.ibatis.io.Resources 를 가져옵니다.

#### Select 구현 방법

이제 쿼리 실행 처리에 대한 설명으로 들어갑니다. 우선은 Select 문입니다.

##### 기본 키 검색

Select 문을 실행하는 프로세스는 몇 가지 패턴이 있지만, 우선은 가장 간단한 기본 키 검색 처리부터입니다. 목록 5.4.3 을 보라.

목록 5.4.3
```
createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val user = mapper.selectByPrimaryKey(100)
    println(user)
}
```
-> 실행 결과
```
UserRecord(id=100, name=Ichiro, age=30, profile=Hello)
```

위의 createSessionFactory 함수 호출 SqlSessionFactory 를 만들고 openSession 이라는 함수를 호출합니다. 이제 데이터베이스에 대한 연결을 설정합니다. 뒤에 오는 use 는 Loan 패턴 주2 를 실현하는 함수로, 파일이나 세션 등 자원계의 오브젝트를 취급할 때, 이 블록내에서의 처리가 종료하면 자원을 닫아 줍니다. 자세한 설명은 생략하지만 리소스 시스템의 객체에서 Java Closeable 이라는 인터페이스의 구현 클래스에 대한 확장 함수로 정의됩니다.

use 블록의 처리에서 쿼리를 실행하고 있습니다. openSession 에 의해 생성된 session 을 사용해 getMapper(UserMapper::class.java) 로 user 테이블에 대한 Mapper 객체( UserMapper )를 취득하고 있습니다. 그리고 mapper 의 selectByPrimaryKey 함수를 사용하여 user 테이블에 대한 기본 키 검색을 수행합니다. 이 selectByPrimaryKey 함수는 UserMapperExtensions.kt에 정의된 확장 함수입니다. 인수로 100 을 전달하므로 id 가 100인 레코드의 정보가 UserRecord 형식의 개체로 검색됩니다.

이렇게 openSession 에서 세션을 시작하고 필요한 테이블의 Mapper 객체를 가져오고 쿼리를 실행하는 함수를 호출하는 것이 MyBatis를 사용한 데이터베이스 연결 처리의 일련의 흐름입니다.

##### Where 절에서 검색

다음은 기본 키 이외의 열을 조건으로 지정한 검색입니다. 목록 5.4.4 와 같이 구현하면 where 절에서 검색 조건을 지정할 수 있다.

목록 5.4.4
```
createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val userList = mapper.select {
        where(name, isEqualTo("Jiro"))
    }
    println(userList)
}
```
-> 실행 결과
```
[UserRecord(id=101, name=Jiro, age=25, profile=Hello)]
```

세션의 시작부터 Mapper 객체의 취득까지는 기본 키 검색의 경우와 같습니다. 이번에는 select 함수를 호출합니다. select 함수는 where 절에서 조건 지정 등을 람다 식으로 전달할 수 있습니다. 여기서는 where 함수를 사용하여 대상 열과 조건을 지정합니다.

where 함수의 첫 번째 인수로 전달되는 name 은 UserDynamicSqlSupport.kt에 정의된 name 열의 개체입니다. 다른 열을 지정할 때도 마찬가지로 여기에 정의된 개체를 사용합니다. 두 번째 인수는 isEqualTo 라는 함수의 실행 결과를 전달합니다. 이것은 Gradle 종속성으로 추가된 mybatis-dynamic-sql 에 포함된 SqlBuilder 인터페이스에 정의된 함수로, 다양한 조건식에 따른 함수를 제공합니다. 여기서 name 열의 값이 Jiro 의 레코드를 검색합니다. select 의 경우는 프라이머리 키 검색이 아니고, 복수건의 레코드를 취득할 가능성이 있기 때문에, UserRecord 의 List 형의 오브젝트로서 결과가 돌려주어집니다.

실행 쿼리는 목록 5.4.5 와 동일하다.

목록 5.4.5
```
select id, name, age, profile from user where name = "Jiro";
```

다른 조건 지정도 시도합니다. 목록 5.4.6 을 보라.

목록 5.4.6
```
createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val userList = mapper.select {
        where(age, isGreaterThanOrEqualTo(25))
    }
    println(userList)
}
```
-> 실행 결과
```
[UserRecord(id=100, name=Ichiro, age=30, profile=Hello), UserRecord(id=101, name=Jiro, age=25, profile=Hello)]
```

이것은 열에 age , 조건으로 isGreaterThanOrEqualTo 라는 함수를 사용합니다. 이것은 age 가 25개 이상의 열을 조건으로 합니다. 해당하는 2개의 레코드의 오브젝트를 포함한 리스트를 취득할 수 있는 것을 알 수 있습니다.

쿼리에서는 목록 5.4.7 이 동일하다.

목록 5.4.7
```
select id, name, age, profile from user where age >= 25;
```

##### count 사용

Select 문에서 또 하나 count 를 소개합니다. SQL의 count 함수에 해당하는 처리가 됩니다. 목록 5.4.8 을 보라.

목록 5.4.8
```
createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val count = mapper.count {
        where(age, isGreaterThanOrEqualTo(25))
    }
    println(count)
}
```
-> 실행 결과
```
2
```

Mapper 객체의 count 함수를 호출합니다. 이것은 인수의 람다 식으로 지정한 조건에 해당하는 레코드의 건수를, Long 형의 수치로서 돌려줍니다.

여기에서도 age 가 25 이상이라는 조건을 where 로 지정하고 있기 때문에, 해당하는 레코드수의 2가 결과로서 되돌아오고 있습니다.

또한 where 의 조건으로 목록 5.4.9 와 같이 allRows 라는 함수를 사용하면 모든 레코드를 대상으로 할 수 있습니다.

목록 5.4.9
```
createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val count = mapper.count { allRows() }
    println(count)
}
```
-> 실행 결과
```
3
```

모든 레코드의 수인 3이 결과로 돌아왔습니다.

#### Insert 구현 방법

다음은 Insert입니다. 단일 레코드, 복수 레코드로 다른 함수가 준비되어 있으므로 각각 소개합니다.

##### 단일 레코드 Insert

목록 5.4.10 을 보라.

목록 5.4.10
```
import database.insert
// 생략

val user = UserRecord(103, "Hidong", 18, "Hello")
createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val count = mapper.insert(user)
    session.commit()
    println("${count}줄의 코드를 넣었습니다.")
}
```
-> 실행 결과
```
 1줄의 코드를 넣었습니다.
```

Select와 마찬가지로 Mapper 객체를 가져 와서 UserMapperExtensions.kt의 insert 함수를 실행하고 있습니다. insert 의 인수는 대상 테이블의 xxxxRecord 형 (여기에서는 UserRecord 형)의 오브젝트로, 등록하고 싶은 데이터의 내용을 설정한 인스턴스를 생성해, 인수에 건네줍니다. 그리고 반환값에는, 등록한 건수가 돌아오기 때문에, 실행 결과에 출력하고 있습니다. 목록 5.4.10 에는 import 문이 포함되어 있지만, 이 import 문을 쓰지 않으면 UserMapper 인터페이스의 insert 함수가 호출되어 오류가 발생하기 때문에 필요하다. 이 장에서는 마찬가지로 import문을 기재한 샘플이 몇 가지 나오므로, 마찬가지로 import문을 수동으로 추기해 주세요.

insert 함수를 실행한 후 커밋을 실행하고 있습니다. SqlSession 의 commit 함수를 호출하면 Insert 결과가 커밋됩니다.

터미널에서 SQL을 실행하고 결과를 확인하면 id 가 103 인 데이터가 등록됩니다 ( 명령 5.4.11 ).

명령 5.4.11
```
mysql > select * from user;
+-----+---------+-----+---------+
| id  | name    | age | profile |
+-----+---------+-----+---------+
| 100 | gildong |  30 | Hello   |
| 101 | dully   |  25 | Hello   |
| 102 | ddochi  |  20 | Hello   |
| 103 | Hidong  |  18 | Hello   |
+-----+---------+-----+---------+
4 rows in set (0.00 sec)
```

##### 다중 레코드 Insert

목록 5.4.12 와 같이 insertMultiple 을 사용하여 여러 레코드를 함께 Insert할 수 있다.

목록 5.4.12
```
import database.insertMultiple
// 생략

val userList = listOf(UserRecord(104, "miCol", 15, "Hello"), UserRecord(105, "doner", 13, "Hello"))
createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val count = mapper.insertMultiple(userList)
    session.commit()
    println("${count}줄의 코드를 넣었습니다.")
}
```
-> 실행 결과
```
2줄의 코드를 넣었습니다.
```

인수는 객체의 List를 전달합니다. 여기에서는 2 레코드의 데이터를 포함한 List 를 건네주고 있기 (위해)때문에, 반환값으로서도 2 가 돌아오고 있습니다. 여기도 터미널에서 추가되었음을 확인할 수 있습니다 ( 명령 5.4.13 ).

명령 5.4.13
```
mysql > select * from user;
+-----+---------+-----+---------+
| id  | name    | age | profile |
+-----+---------+-----+---------+
| 100 | gildong |  30 | Hello   |
| 101 | dully   |  25 | Hello   |
| 102 | ddochi  |  20 | Hello   |
| 103 | Hidong  |  18 | Hello   |
| 104 | miCol   |  15 | Hello   |
| 105 | doner   |  13 | Hello   |
+-----+---------+-----+---------+
6 rows in set (0.00 sec)
```

#### Update 구현 방법

다음은 Update입니다. 여기도 여러 종류 있기 때문에 각각 설명합니다.

##### 기본 키를 검색 조건으로 레코드 업데이트

목록 5.4.14 를 보라.

목록 5.4.14
```
val user = UserRecord(id = 105, profile = "Bye")
createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val count = mapper.updateByPrimaryKeySelective(user)
    session.commit()
    println("${count}行のレコードを更新しました")
}
```
-> 실행 결과
```
1行のレコードを更新しました
```

updateByPrimaryKeySelective 함수는 테이블의 Record 객체를 인수로 받고 기본 키에 해당하는 열( UserRecord 에서는 id )에 설정된 값과 일치하는 레코드를 대상으로 객체에 설정된 값으로 데이터를 업데이트합니다. . Insert와 마찬가지로 업데이트된 레코드 수를 반환 값으로 반환합니다.

갱신되는 것은 값이 설정되어 있는 컬럼만으로, null 의 설정된 컬럼은 갱신되지 않습니다. 따라서 여기서는 profile 만 인수 값으로 업데이트됩니다 ( 명령 5.4.15 ).

명령 5.4.15
```
mysql > select * from user;
+-----+---------+-----+---------+
| id  | name    | age | profile |
+-----+---------+-----+---------+
| 100 | gildong |  30 | Hello   |
| 101 | dully   |  25 | Hello   |
| 102 | ddochi  |  20 | Hello   |
| 103 | Hidong  |  18 | Hello   |
| 104 | miCol   |  15 | Hello   |
| 105 | doner   |  13 | Bye     |
+-----+---------+-----+---------+
6 rows in set (0.00 sec)
```

Selective 가 붙지 않는 updateByPrimaryKey 라는 함수도 있고, 그 쪽을 사용하면 모든 열을 인수의 Record 객체의 값으로 갱신합니다 (값이 설정되어 있지 않은 열은 null로 갱신하려고합니다).

##### 기본 키 이외의 열을 검색 조건으로 레코드 업데이트 (Record 개체를 사용하지 않는 경우)

Record 객체를 사용하지 않고 목록 5.4.16 과 같이 업데이트할 수도 있다.

목록 5.4.16
```
import database.update
// 생략

createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val count = mapper.update {
        set(profile).equalTo("Hey")
        where(id, isEqualTo(104))
    }
    session.commit()
    println("${count}行のレコードを更新しました")
}
```
-> 실행 결과
```
1行のレコードを更新しました
```

set(profile).equalTo("Hey") 로 profile 를 「Hey」라고 하는 캐릭터 라인으로 갱신하는 것을 지정하고 있습니다. SQL Update 문의 Set 절에 해당하는 것입니다. 그리고 Select와 마찬가지로 where 로 조건을 지정하고 있습니다. 여기서 id 가 104 인 레코드가 업데이트됩니다 ( 명령 5.4.17 ).

명령 5.4.17
```
mysql > select * from user;
+-----+---------+-----+---------+
| id  | name    | age | profile |
+-----+---------+-----+---------+
| 100 | gildong |  30 | Hello   |
| 101 | dully   |  25 | Hello   |
| 102 | ddochi  |  20 | Hello   |
| 103 | Hidong  |  18 | Hello   |
| 104 | miCol   |  15 | Hey     |
| 105 | doner   |  13 | Bye     |
+-----+---------+-----+---------+
6 rows in set (0.00 sec)
```

##### 기본 키 이외의 열을 검색 조건으로 레코드 업데이트 (Record 개체 사용)

기본 키 이외의 열을 조건으로 한 업데이트에서도 Record 객체를 사용할 수 있습니다. 목록 5.4.18 을 보라.

목록 5.4.18
```
val user = UserRecord(profile = "Good Morning")
createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val count = mapper.update {
        updateSelectiveColumns(user)
        where(name, isEqualTo("Shiro"))
    }
    session.commit()
    println("${count}行のレコードを更新しました")
}
```
-> 실행 결과
```
1行のレコードを更新しました
```

updateSelectiveColumns 함수에 Record 객체를 전달하고 where 함수에서 조건을 지정합니다. 조건에 해당하는 레코드의 경우 Record 객체에 값이 설정된 열 (여기서는 profile ) 만 업데이트합니다 ( 명령 5.4.19 ).

명령 5.4.19
```
mysql > select * from user;
+-----+---------+-----+--------------+
| id  | name    | age | profile      |
+-----+---------+-----+--------------+
| 100 | gildong |  30 | Hello        |
| 101 | dully   |  25 | Hello        |
| 102 | ddochi  |  20 | Hello        |
| 103 | Hidong  |  18 | Good Morning |
| 104 | miCol   |  15 | Hey          |
| 105 | doner   |  13 | Bye          |
+-----+---------+-----+--------------+
6 rows in set (0.00 sec)
```

updateSelectiveColumns 대신 updateAllColumns 라는 함수를 사용하여 모든 열을 Record 객체의 값으로 업데이트할 수 있습니다.

#### Delete 구현 방법

마지막으로 Delete입니다. 이쪽도 기본 키와 그 이외를 조건으로 한 경우의 구현을 소개합니다.

##### 기본 키를 검색 조건으로 레코드 삭제

목록 5.4.20 을 보라.

목록 5.4.20
```
createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val count = mapper.deleteByPrimaryKey(102)
    session.commit()
    println("${count}行のレコードを削除しました")
}
```
-> 실행 결과
```
1行のレコードを削除しました
```

Delete는 간단하며 deleteByPrimaryKey 함수에 삭제할 레코드의 기본 키 값을 전달하여 실행할 수 있습니다. 반환값은 삭제한 건수를 돌려줍니다.

삭제 후 테이블의 상태는 명령 5.4.21 입니다.

명령 5.4.21
```
mysql > select * from user;
+-----+---------+-----+--------------+
| id  | name    | age | profile      |
+-----+---------+-----+--------------+
| 100 | gildong |  30 | Hello        |
| 101 | dully   |  25 | Hello        |
| 103 | Hidong  |  18 | Good Morning |
| 104 | miCol   |  15 | Hey          |
| 105 | doner   |  13 | Bye          |
+-----+---------+-----+--------------+
5 rows in set (0.00 sec)
```

##### 기본 키 이외의 열을 검색 조건으로 레코드 삭제

기본 키 이외의 열을 조건으로 하는 경우도 Delete는 간단하고, delete 함수에 where 함수로 조건을 지정한 람다 식을 건네줄 뿐입니다 ( 목록 5.4.22 ).

목록 5.4.22
```
import database.delete
// 생략

createSessionFactory().openSession().use { session ->
    val mapper = session.getMapper(UserMapper::class.java)
    val count = mapper.delete {
        where(name, isEqualTo("dully"))
    }
    session.commit()
    println("${count}行のレコードを削除しました")
}
```
-> 실행 결과
```
1行のレコードを削除しました
```

삭제 후 테이블의 상태는 명령 5.4.23 입니다.

명령 5.4.23
```
mysql > select * from user;
+-----+---------+-----+--------------+
| id  | name    | age | profile      |
+-----+---------+-----+--------------+
| 100 | gildong |  30 | Hello        |
| 103 | Hidong  |  18 | Good Morning |
| 104 | miCol   |  15 | Hey          |
| 105 | doner   |  13 | Bye          |
+-----+---------+-----+--------------+
4 rows in set (0.00 sec)
```

이제 이른바 CRUD를 만들기 위해 각 쿼리를 실행하는 방법을 한 가지 소개했습니다. 다음은 MyBatis를 Spring Boot와 함께 사용하는 방법을 보여줍니다.

### 5　Spring Boot에서 MyBatis 사용

4장에서 만든 demo 프로젝트의 Spring Boot 애플리케이션에 MyBatis를 추가하는 형태로 소개합니다.

#### 설정 파일 작성, 코드 생성

##### build.gradle.kts에 종속성 추가

프로젝트 build.gradle.kts에 몇 가지 설정을 추가합니다. 위의 MyBatis에서 CRUD를 만들 때와 비슷한 설명을 추가합니다. 먼저 plugins 블록에 목록 5.5.1 을, 파일 끝에 목록 5.5.2 를 추가하십시오. MyBatis Generator에 관한 설명입니다.

목록 5.5.1
```
id("com.arenagod.gradle.MybatisGenerator") version "1.4"
```

목록 5.5.2
```
mybatisGenerator {
    verbose = true
    configFile = "${projectDir}/src/main/resources/generatorConfig.xml"
}
```

dependencies 블록에 목록 5.5.3 종속성을 추가한다.

목록 5.5.3
```
implementation("org.mybatis.spring.boot:mybatis-spring-boot-starter:2.1.4")
implementation("org.mybatis.dynamic-sql:mybatis-dynamic-sql:1.2.1")
implementation("mysql:mysql-connector-java:8.0.23")
mybatisGenerator("org.mybatis.generator:mybatis-generator-core:1.4.0")
```

포인트로서는 mybatis-spring-boot-starter 를 추가하고 있는 점입니다. 제4장에서 Spring Boot에는 다른 라이브러리나 프레임워크를 함께 사용하기 위한 의존관계를 추가해 주는 starter가 준비되어 있다고 설명했습니다만, 이쪽도 그 일종으로 MyBatis에 대응한 starter에 되어 있습니다. MyBatis에 대한 라이브러리도 여기에 포함되어 있으며 목록 5.3.4 에서 추가하고 있던 org.mybatis : mybatis 는 필요하지 않습니다. Spring Initializr에서 프로젝트를 만들 때 추가하는 Dependencies에서도 선택할 수 있습니다.

##### 구성 파일 추가

데이터베이스의 접속처 정보 등을 쓴 설정 파일도 마찬가지로 추가합니다. src/main/resources 아래에 목록 5.5.4 의 내용으로 generatorConfig.xml을 생성한다.

목록 5.5.4
```
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE generatorConfiguration PUBLIC "-//mybatis.org//DTD
    MyBatis Generator Configuration 1.0//EN"
        "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd" >
<generatorConfiguration>
    <classPathEntry
            location="/Users/takehata/.gradle/caches/modules-2/files-2.1/mysql/mysql-connector-java/8.0.23/d8d388e71c823570662a45dd33f4284141921280/mysql-connector-java-8.0.23.jar"/>
    <context id="MySQLTables" targetRuntime="MyBatis3Kotlin">
        <plugin type="org.mybatis.generator.plugins.MapperAnnotationPlugin" />
        <commentGenerator>
            <property name="suppressDate" value="true" />
        </commentGenerator>
        <jdbcConnection
                driverClass="com.mysql.jdbc.Driver"
                connectionURL="jdbc:mysql://127.0.0.1:3306/example"
                userId="root"
                password="mysql">
            <property name="nullCatalogMeansCurrent" value="true" />
        </jdbcConnection>
        <javaModelGenerator
                targetPackage="com.example.demo.database"
                targetProject="src/main/kotlin">
        </javaModelGenerator>
        <javaClientGenerator
                targetPackage="com.example.demo.database"
                targetProject="src/main/kotlin">
        </javaClientGenerator>
        <table tableName="%" />
    </context>
</generatorConfiguration>
```

기본적으로 위의 목록 5.3.5 와 비슷하지만 targetPackage 에 설정된 패키지를 demo 프로젝트의 것으로 변경했습니다. 그리고 응용 프로그램에서 사용하는 연결 정보이지만 mybatis-spring-boot-starter 를 사용하는 경우 src / main / resources 아래에 application.yml이라는 파일을 만들고 목록 5.5.5 와 같이 YAML 형식으로 작성 합니다.

목록 5.5.5
```
spring:
  datasource:
    url: jdbc:mysql://127.0.0.1:3306/example?characterEncoding=utf8
    username: root
    password: mysql
    driverClassName: com.mysql.jdbc.Driver
```

application.yml은 Spring Framework에서 사용하는 설정을 설명하는 파일입니다. mybatis-spring-boot-starter 를 사용하고 있기 때문에 목록 5.4.1 에서 작성한 데이터 소스 관련 설정도 여기에 쓸 수 있습니다.

또한 프로젝트를 만들 때 application.properties라는 파일이 있으면 해당 파일을 삭제하고 application.yml을 만듭니다. Spring Boot는 Properties, YAML 어느 형식에서도 설정을 정의할 수 있습니다만, 현재는 YAML을 사용하는 경우가 많기 때문에 본서에서도 이쪽을 사용하고 있습니다.

##### 코드 생성

모든 설정을 작성했으면 mbGenerator 태스크(이 장, 3. "MyBatis 소개"의 "코드 생성 실행" 참조)를 사용하여 코드를 생성합니다. com.example.demo 아래에 database 패키지가 만들어지고 그 아래에 user 테이블에 대한 각 파일이 생성됩니다.

#### MySQL 데이터를 조작하는 API 생성

##### Mapper 객체를 DI로 사용하여 Select API 구현

com.example.demo 패키지 아래에 목록 5.5.6 의 Controller 클래스를 생성한다.

목록 5.5.6
```
@Suppress("SpringJavaInjectionPointsAutowiringInspection")
@RestController
@RequestMapping("user")
class UserController(
    val userMapper: UserMapper
) {
    @GetMapping("/select/{id}")
    fun select(@PathVariable("id") id: Int): UserRecord? {
        return userMapper.selectByPrimaryKey(id)
    }
}
```

패스 파라미터로 id 를 받아, user 테이블에의 Select를 실행한 결과를 응답으로서 반환하고 있습니다.

생성자는 UserMapper 유형의 인수를 정의하지만, 이것은 생성자 주입을 사용하여 Mapper 객체를 DI하고 있습니다. mybatis-spring-boot-starter 를 통해 사용함으로써 세션의 시작과 종료, Mapper 객체의 취득 등을 Spring 측에서 실시해 주므로 이렇게 간단하게 기술할 수 있게 됩니다.

클래스에 부여된 @Suppress 어노테이션은 경고를 무시하는 데 사용하는 어노테이션입니다. IntelliJ IDEA가 Mapper 객체의 DI를 해결할 수 없어 표시상은 에러를 내 버리기 때문에, 이쪽에서 회피하고 있습니다. 다만, 붙이지 않아도 컴파일은 대로, 프로그램의 동작상도 문제 없습니다.

그런 다음 bootRun 작업에서 응용 프로그램을 시작하고 5.5.7 명령 의 curl 명령을 실행합니다.

명령 5.5.7
```
$ curl http://localhost:8080/user/select/100
{"id":100,"name":"Ichiro","age":30,"profile":"Hello"}
```

ID100에 해당하는 레코드의 객체가 JSON에서 반환되었음을 알 수 있습니다.

##### Insert API 추가

또 다른 API를 만들어 보겠습니다. 이번에는 user 테이블에 Insert를 실행하는 API입니다. 등록 처리이므로 POST 메소드의 API를 작성합니다. 요청, 응답 클래스는 목록 5.5.8 과 같이 생성된다.

목록 5.5.8
```
// 리퀘스트
data class InsertRequest(val id: Int, val name: String, val age: Int, val profile: String)
// 리스폰스
data class InsertResponse(val count: Int)
```

테이블의 각 열 값을 요청으로 받고 등록한 건수를 응답으로 반환합니다.

그리고 UserController 클래스에 목록 5.5.9 의 함수를 추가한다.

목록 5.5.9
```
import com.example.demo.database.insert
// 생략

@PostMapping("/insert")
fun insert(@RequestBody request: InsertRequest): InsertResponse {
    val record = UserRecord(request.id, request.name, request.age, request.profile)
    return InsertResponse(userMapper.insert(record))
}
```

여기도 DI 한 Mapper 객체를 사용하여 Insert를 실행하는 처리를 작성하고 있습니다.

요청에서 받은 user 테이블의 각 열의 값을 사용하여 UserRecord 의 인스턴스를 생성하고 insert 함수를 실행하고 있습니다. 트랜잭션 관리도 Spring Framework 측에서 해주기 때문에, commit 의 실행도 불필요하게 되어 있습니다. 응답에는 Mapper 객체의 insert 함수가 반환하는 등록 레코드 수를 그대로 설정하고 있습니다.

응용 프로그램을 다시 시작하고 5.5.10 명령 의 curl 명령을 실행합니다.

명령 5.5.10
```
$ curl -H 'Content-Type:application/json' -X POST -d '{"id":106, "name":"Nanako", "age":7, "profile":"Good Night"}' http://localhost:8080/user/insert
{"count":1}
```

등록 건수의 1이라는 수치가 count 로 설정되어 응답으로 돌아오고 있습니다. 방금 만든 Select의 API를 사용하여 ID106을 지정하여 검색해 보면 등록되어 있음을 알 수 있습니다 ( 명령 5.5.11 ).

명령 5.5.11
```
$ curl http://localhost:8080/user/select/106
{"id":106,"name":"Nanako","age":7,"profile":"Good Night"}
```

이제 Insert API도 가능했습니다. Spring Boot와 함께 사용에 관해서는 Select와 Insert만의 소개에 그치지만, 다른 쿼리도 기본적으로 똑같이 Mapper 객체를 DI해서 사용하는 형태로 실행할 수 있습니다. 공개하고 있는 샘플 코드안에는 Update, Delete의 API를 더한 코드가 들어 있으므로, 좋으면 그쪽도 참조해 보세요.

다음 장에서는 Spring Boot와 MyBatis를 사용하여 실용적인 애플리케이션을 만들 것입니다.

주1 　 https://docs.docker.com/get-docker/

( 본문으로 돌아가기 )

주2　 리소스(파일이나 커넥션 등)의 오브젝트를 사용한 후 반자동으로 해제하는 디자인 패턴.

( 본문으로 돌아가기 )

