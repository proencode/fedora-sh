








## 제12장　Kotlin의 테스팅 프레임워크 Kotest, MockK

마지막으로 소개하는 것은 Kotlin의 테스팅 프레임 워크인 Kotest와 함께 사용하는 모의 라이브러리의 MockK입니다. Kotlin 단위 테스트에서는 JUnit을 사용하는 경우가 많지만 Kotlin 테스팅 프레임워크도 몇 가지 있습니다. 그 중에서도 Kotest는 개발이 활발하게 행해지고 있어 다기능이 되어 있어 꽤 사용하기 좋은 것이 되고 있습니다. 필자도 실제의 제품으로 사용해 매우 좋았다고 느끼고 있는 프레임워크이므로, 꼭 그 매력을 느껴 주시면 좋겠습니다.

1　Kotest란?
Kotest Note 1 은 Kotlin의 테스트 프레임워크로 Kotlin에서 단위 테스트를 유연하게 구현할 수 있는 다양한 기능을 제공합니다. 이전에는 KotlinTest라는 이름이었지만 버전 4.0에서 Kotest로 변경되었습니다.

다양한 코딩 스타일 지원
Spec이라는 이하의 10종류의 코딩 스타일이 준비되어 있어, 여러가지 쓰는 방법이 서포트되고 있는 것을 하나의 특징으로서 들 수 있습니다.

울재미있는 사양
울사양 설명
울사양해야
울문자열 사양
울동작 사양
울무료 사양
울단어 사양
울기능 사양
울스펙 기대
울주석 사양
각각의 Spec에 대해서는 공식 사이트 주2 에 자세하게 쓰여져 있습니다만, 예를 들어 Fun Spec은 ScalaTest, Annotation Spec는 JUnit와, 다른 언어의 테스팅 프레임워크로부터 인스파이어 된 구문이 되어 있는 것도 많다 있습니다. 또한 String Spec이나 Should Spec과 같이 Kotest에서 원래의 사상으로 만들어진 구문도 있습니다. 따라서 프로젝트 정책이나 테스트 내용에 따라 장점이 많은 것을 사용하거나 다른 언어로 구현자가 익숙한 구문의 Spec을 사용하거나 상황에 따라 선택할 수 있습니다.

자세한 것은 후술합니다만, 테스트 코드로 상속하는 클래스를 변경하는 것으로, 각각의 코딩 스타일을 사용할 수가 있습니다.

2　Kotest 도입
프로젝트 만들기 및 build.gradle.kts 재작성
IntelliJ IDEA에서 프로젝트를 만들고 build.gradle.kts의 dependencies 에 Listing 12.2.1 종속성을 추가한다.

목록 12.2.1

 testImplementation("io.kotest:kotest-runner-junit5-jvm:4.4.3")
Kotest는 테스트의 Runner로 JUnit을 사용합니다. 이 kotest-runner-junit5-jvm 을 추가하면 JUnit 5의 Runner에서 Kotest에서 구현 한 테스트를 실행할 수 있습니다.

또한 tasks.test 블록을 Listing 12.2.2 와 같이 변경하십시오 (그렇지 않으면 추가하십시오).

목록 12.2.2

 tasks.test {
     useJUnitPlatform()
 }
여기도 테스트 Runner로 JUnit을 사용하기 때문에 필요한 설정입니다.

Kotest 플러그인 설치
IntelliJ IDEA에 Kotest 플러그인을 설치합니다. 이것은 IDE에서 Kotest 테스트 코드를 실행할 때 필요합니다. 환경 설정에서 플러그인을 선택하고 Marketplace 탭에서 Kotest를 검색하여 표시된 Kotest 플러그인을 설치합니다 ( 그림 12.1 ).

그림 12.1
설치가 완료되면 IntelliJ IDEA를 다시 시작합니다.

3　여러 코딩 스타일(Spec)로 단위 테스트 작성
앞서 언급한 10가지 Spec에서 몇 가지를 픽업하고 Kotest에서 단위 테스트 구현을 소개합니다.

사전 준비
테스트 대상 코드 작성
먼저 테스트할 코드를 작성합니다. src/main/kotlin 아래에 Listing 12.3.1 의 데이터 클래스를 생성한다.

목록 12.3.1

 data class Number(val value: Int) {
     fun isOdd(): Boolean {
         return value % 2 == 1
     }

     fun isRange(min: Int, max: Int): Boolean {
         return value in min..max
     }
 }
Int 형의 값을 프로퍼티로서 가져, 홀수인지를 판정 하는 isOdd 함수와, 지정된 수치의 범위내에 들어가는 수치인지를 판정 하는 isRange 함수가 준비되어 있습니다.

가장 간단한 구문의 String Spec
먼저 가장 간단한 구문으로 구현할 수 있는 String Spec에서의 쓰기 방법을 소개합니다. src/test/kotlin 아래에 Listing 12.3.2 의 클래스를 생성한다. 만약 Number 클래스를, src/main/kotlin하에 패키지를 작성해 배치하고 있는 경우, 유사한 패키지를 src/test/kotlin하하에도 작성해, 그 아래에 NumberTestByStringSpec 클래스를 작성해 주세요.

목록 12.3.2

 class NumberTestByStringSpec : StringSpec() {
     init {
         "isOdd:: when value is odd number then return true" {
             val number = Number(1)
             number.isOdd() shouldBe true
         }
     }
 }
StringSpec 이라는 클래스를 상속함으로써, String Spec에서의 구현이 가능하게 됩니다. init 블록 안에 테스트 코드를 구현하면 테스트 대상으로 처리됩니다.

테스트 코드를 작성하는 것은 간단하며 문자열로 테스트 케이스 설명을 작성하고 {} 로 묶은 블록에서 테스트 처리를 설명합니다. Number 객체에 홀수 인 1을 설정하고 isOdd 를 실행하여 true가 반환되는지 확인합니다.

shouldBe 는 Kotest에 포함된 검증용 라이브러리입니다. 영문과 같은 형태로 스페이스 구분으로 결과와 기대치를 연결해 쓸 수 있으므로, 직관적으로 알기 쉬운 구문이 되고 있습니다. Listing 12.3.3 과 같이 일반 함수 호출로 작성하는 것도 가능하다.

목록 12.3.3

 number.isOdd().shouldBe(true)
마찬가지로 false의 경우 (짝수의 경우) 테스트 케이스는 Listing 12.3.4 와 같이 작성된다.

목록 12.3.4

 "isOdd:: when value is even number then return false" {
     val number = Number(2)
     number.isOdd() shouldBe false
 }
테스트 실행
테스트 실행은 그림 12.2 와 같이 클래스 정의 옆에 표시된 삼각형 아이콘을 누른 다음 Run 'NumberTestByStringSpec'을 선택합니다.

그림 12.2
그러면 Run 뷰에 그림 12.3 과 같이 테스트 결과가 표시됩니다.

그림 12.3
결과가 녹색이면 성공입니다.

만약 「TestResults」 이외의 행이 표시되어 있지 않은 경우는, 테스트 결과의 좌상단에 있는 체크 마크의 버튼을 눌러, 유효하게 해 주세요. 여기가 비활성 상태이면 정상적으로 종료된 테스트 케이스의 결과가 표시되지 않습니다.

BDD 프레임워크처럼 사용할 수 있는 Behavior Spec
Behavior Spec은 이름에서 알 수 있듯이 Behavior (작동)를 정의하는 테스트 케이스를 설명하는 스타일입니다. BDD(Behavior Driven Development, 동작 구동 개발) 프레임워크처럼 사용할 수도 있습니다. Listing 12.3.5 와 같이 구현한다.

목록 12.3.5

 class NumberTestByBehaviorSpec : BehaviorSpec() {
     init {
         given("isOdd") {
             `when`("num is odd number") {
                 val number = Number(1)
                 then("return true") {
                     number.isOdd() shouldBe true
                 }
             }

             `when`("num is even number") {
                 val number = Number(2)
                 then("return false") {
                     number.isOdd() shouldBe false
                 }
             }
         }
     }
 }
BehaviorSpec 클래스를 상속합니다.

테스트 케이스는 given , when , then 의 3개의 키워드를 사용해, 계층 구조로 기술할 수 있습니다. 각 블록은 다음과 같은 내용을 설명합니다.

울given……대상(함수명 등)
울when……조건(xxx의 경우)
울then…… 결과(반환값 등)
이와 같이 정의하는 것으로 테스트 케이스가 읽기 쉬워지거나, 구현자에 의한 쓰는 방법의 차분이 태어나기 어려워지는 것도 메리트입니다.

when 이 따옴표로 묶여있는 이유는 Kotlin의 예약어로 존재하므로 판별하기 때문입니다. 이것을 피하고 싶다면 제목 케이스 (이니셜을 대문자)로 정의 할 수 있습니다 ( Listing 12.3.6 ).

목록 12.3.6

 When("num is odd number")
테스트 결과도 계층 구조가 된다
Behavior Spec을 사용하면 테스트 실행 결과도 그림 12.4 와 같이 계층 구조로 표시됩니다.

그림 12.4
이쪽도 코드의 계층 구조와 같이 되어, 보기 쉬워집니다.

JUnit 라이크에 쓸 수 있는 Annotation Spec
Annotation Spec은 @Test 어노테이션을 사용하고 JUnit과 유사한 방식으로 작성할 수있는 스타일입니다. Listing 12.3.7 과 같이 구현한다.

목록 12.3.7

 class NumberTestByAnnotationSpec : AnnotationSpec() {
     @Test
     fun `isOdd when value is odd number then return true`() {
         val number = Number(1)
         number.isOdd() shouldBe true
     }

     @Test
     fun `isOdd when value is even number then return false`() {
         val number = Number(2)
         number.isOdd() shouldBe false
     }
 }
AnnotationSpec 클래스를 상속합니다.

테스트 케이스의 정의는 함수로 구현하고 @Test 어노테이션을 부여함으로써 가능합니다. 검증 처리는 Kotest의 라이브러리를 사용하고 있습니다만, 그 이외는 거의 JUnit와 같은 코드가 됩니다. JUnit에 익숙하고 가능한 한 동일한 구현 방법으로 Kotest를 사용하려는 경우에 유용합니다.

4　데이터 구동 테스트 사용
Kotest에는 강력한 기능 중 하나로 데이터 구동 테스트가 있습니다. 이것은 다양한 테스트 데이터의 조합을 파라미터로서 건네주어 실행할 수 있는 기능으로, 테스트의 코드량을 줄여 간단하게 기술할 수 있습니다.

forAll을 사용하여 여러 매개변수 테스트
앞의 String Spec을 설명할 때 사용한 NumberTestByStringSpec 에 Listing 12.4.1 의 테스트 케이스를 추가한다.

목록 12.4.1

 "isRange:: when value in range then return true" {
     forAll(
         table(
             headers("value"),
             row(1),
             row(10)
         )
     ) { value ->
         val number = Number(value)
         number.isRange(1, 10) shouldBe true
     }
 }
forAll 의 인수에 여러 종류의 파라미터를 건네주는 것으로, 각각의 파라미터로 테스트 케이스를 실행해 줍니다. 매개 변수는 테이블 과 행 을 사용하여 전달하고 람다 식에서 참조하는 변수 이름을 정의합니다.

이 예에서는 1, 10이라는 모두 결과가 true가 되는 2종류의 파라미터로 각각 실행해, value 라는 이름으로 참조해 Number 로 설정해, isRange 를 검증하고 있습니다. 이와 같이 동일한 결과를 얻는 테스트 케이스에서 경계값의 상한, 하한을 테스트하고 싶은 경우 등에 데이터 구동 테스트는 매우 편리합니다.

headers 로 건네주는 것은 row 의 각 데이터에 대한 이름으로, 여기서는 value 라는 이름을 부여하고 있습니다. 테스트가 실패하면 Listing 12.4.2 와 같이 어떤 값의 패턴에서 실패했는지를 표시하는 데 사용됩니다. 이 예에서는 value 가 1이면 true가 예상되었지만 false가 반환되었음을 나타냅니다.

목록 12.4.2

 Test failed for (value, 1) with error expected:<true> but was:<false>
마찬가지로 false를 반환하는 경우 (범위를 벗어난 숫자를 매개 변수에 전달하는 경우)도 Listing 12.4.3 과 같이 구현할 수 있습니다.

목록 12.4.3

 "isRange:: when value not in range then return false" {
     forAll(
         table(
             headers("value"),
             row(0),
             row(11)
         )
     ) { value ->
         val number = Number(value)
         number.isRange(1, 10) shouldBe false
     }
 }
일반 테스트로 작성한 경우 Listing 12.4.1 은 Listing 12.4.4 와 같이 두 개의 테스트 코드로 구분되어 중복 코드를 작성해야하므로 테스트 코드를 단순화 할 수 있습니다.

목록 12.4.4

 "isRange:: when value is minimum then return true" {
     val number = Number(1)
     number.isRange(1, 10) shouldBe true
 }

 "isRange:: when value is maximum then return true" {
     val number = Number(10)
     number.isRange(1, 10) shouldBe true
 }
또, 여기에서는 수치를 1개 건네주고 있을 뿐이었지만, 리스트 12.4.5 와 같이 1개의 파라미터세트에 복수의 값을 설정할 수도 있습니다.

목록 12.4.5

 forAll(
     table(
         headers("value", "description"),
         row(1, "Minimum"),
         row(10, "Maximum")
     )
 ) { value, description ->
     // 省略
5　MockK를 사용하여 모형화
마지막으로 MockK를 사용한 모의화를 소개합니다. MockK는 Kotlin의 모의 라이브러리입니다.

사전 준비
테스트 대상 코드 작성
테스트할 코드를 작성합니다. src/main/kotlin 아래에 Listing 12.5.1 , Listing 12.5.2 의 클래스를 생성한다.

목록 12.5.1

 class UserService(private val userRepository: UserRepository) {
     fun createMessage(id: Int): String? {
         if (id < 0) return null ──②
         return userRepository.findName(id)?.let { "Hello $it" } ──①
     }
 }
목록 12.5.2

 class UserRepository {
     fun findName(id: Int): String? {
         // Dummy logic
         return "Kotlin"
     }
 }
UserService 는 생성자에 의해 UserRepository 를 받습니다. createMessage 함수는 id 를 인수에 취해, 정수치였을 경우에 UserRepository 의 findName 함수를 실행하는 처리가 되어 있습니다. findName 함수는 "Kotlin"이라는 문자열을 반환하는 데 더미 처리입니다.

여기에서는 UserRepository 를 모형화하고 UserService 의 함수를 테스트하는 코드를 소개합니다.

build.gradle.kts에 종속성 추가
build.gradle.kts의 dependencies 에 Listing 12.5.3 의 종속성을 추가한다.

목록 12.5.3

 testImplementation("io.mockk:mockk:1.10.6")
테스트 코드 구현
MockK를 사용한 테스트 코드 구현을 소개합니다. src/test/kotlin 아래에 Listing 12.5.4 의 테스트 클래스를 생성한다.

목록 12.5.4
조롱 된 UserRepository 를 생성자에 전달하여 UserService 의 인스턴스를 생성하고 테스트합니다. 포인트를 순서대로 설명합니다.

모의 객체 생성
먼저 Listing 12.5.5 에서 모의 ​​객체를 생성하고 테스트 대상 클래스 ( UserService )의 인스턴스 생성시 생성자에 전달합니다.

Listing 12.5.5 (Listing 12.5.4의 ①을 발췌)

 val userRepository = mockk<UserRepository>()
 val target = UserService(userRepository)
mockk 라는 함수에 형 파라미터로 대상의 형태를 건네주는 것으로, 그 형태의 모의 객체가 생성됩니다. 그리고 UserService 에 constructor 으로 건네주어 인스턴스를 생성하는 것으로, 이 인스턴스의 처리내에서는 UserRepository 의 처리가 모의 객체로 불려 가게 됩니다.

모의 객체의 함수 거동 정의
Listing 12.5.6 은 모의 객체의 findName 거동을 정의한다.

Listing 12.5.6 (Listing 12.5.4의 ②를 발췌)

 every { userRepository.findName(any()) } returns "Kotest"
every 블록 내에서 호출 정의를 쓰고 returns 뒤에 반환 값을 씁니다. every 의 정의로 쓴 것과 같은 값이 인수로 findName 함수가 실행되었을 때, returns 의 뒤에서 정의한 값이 반환된다는 의미가 됩니다.

여기에서는 any() 라는 함수의 결과를 인수로서 건네주고 있습니다만, 이것은 MockK 로 준비된 함수로, 모든 값에 대한 반환값을 정의할 수 있습니다. 즉, 이 모의 객체를 사용한 처리내에서는, 어느 값을 인수로서 건네 주어도 findName 함수는 반드시 「Kotest」의 캐릭터 라인을 반환하게 됩니다.

Listing 12.5.7 과 같이 두 줄을 작성하고 100이 전달되면 "Kotest"를 정의하고 200이 전달되면 "MockK"를 반환하도록 정의 할 수 있습니다.

목록 12.5.7

 every { userRepository.findName(100) } returns "Kotest"
 every { userRepository.findName(200) } returns "MockK"
반환 값 확인
createMessage 함수는 findName 함수가 반환한 값을 포함한 메시지를 반환하는 처리입니다. 앞에서 언급했듯이 모의 객체에서 findName 함수가 항상 "Kotest"를 반환하도록되어 있기 때문에 "Hello Kotest"문자열이 반환되는 유효성 검사가됩니다 ( 목록 12.5.8 ).

Listing 12.5.8 (Listing 12.5.4의 ③을 발췌)

 val result = target.createMessage(id)

 result shouldBe "Hello Kotest"
모의 객체의 함수 호출 검증
모의 객체의 findName 함수가 호출되는지 확인합니다. Listing 12.5.9 와 같이 verify 함수를 사용한다.

Listing 12.5.9 (Listing 12.5.4의 ④ 발췌)

 verify { userRepository.findName(id) }
이것은 변수 id 의 값 (여기서는 100)을 전달하여 findName 함수가 실행되었는지 확인합니다. 어떤 이유로 호출되지 않았거나 다른 값이 인수로 전달되면 실패합니다.

모의 거동을 변경 한 패턴
목록 12.5.4 의 테스트 클래스에 모의 동작을 변경한 목록 12.5.10 의 테스트 케이스를 추가한다.

목록 12.5.10

 "createMessage:: when user name is not exist then return null" {
     val userRepository = mockk<UserRepository>()
     val target = UserService(userRepository)

     val id = 100

     every { userRepository.findName(any()) } returns null

     val result = target.createMessage(id)

     result shouldBe null
     verify { userRepository.findName(id) }
 }
이번에는 findName 함수가 null을 반환하도록 정의합니다. createMessage 함수는 findName 함수의 결과가 null이었을 경우, 안전 호출로 null를 반환하는 처리가 되어 있기 때문에( 리스트 12.5.11 ), 실행 결과도 null로 검증하고 있습니다.

Listing 12.5.11 (Listing 12.5.1의 ①을 발췌)

 return userRepository.findName(id)?.let { "Hello $it" }
모의 객체의 함수가 호출되지 않았는지 확인
마지막으로 모의 객체의 함수가 불려 가지 않았던 것을 검증하는 방법입니다. UserServiceTest 클래스에 Listing 12.5.12 의 테스트 케이스를 추가한다.

목록 12.5.12

 "createMessage:: when id less than 0 then return null" {
     val userRepository = mockk<UserRepository>()
     val target = UserService(userRepository)

     val id = -1

     every { userRepository.findName(any()) } returns null

     val result = target.createMessage(id)

     result shouldBe null
     verify(exactly = 0) { userRepository.findName(any()) } ──①
 }
id 에 부수(-1)를 건네주어 실행하는 패턴입니다. createMessage 함수는 인수로 음수를 받았을 경우는 그 시점에서 null를 돌려주는 처리가 되어 있어( 리스트 12.5.13 ), findName 함수는 실행되지 않습니다. 그러므로 "불리지 않음"의 검증이 필요합니다.

Listing 12.5.13 (Listing 12.5.1의 ②를 발췌)

 if (id < 0) return null
verify 는 exactly 라는 인수를 사용하여 뒤의 {} 내에서 지정하는 함수의 호출 횟수를 지정할 수 있습니다. 지정하지 않는 경우는 디폴트로 -1이 건네받아, 1회 이상 불리면 성공이라고 하는 설정이 됩니다.

여기에서는 "불리지 않음"의 검증을 위해 0을 지정하고 있습니다 ( 목록 12.5.14 ). 이제 findName 함수가 호출되지 않으면 성공하고, 호출되면 이 테스트가 실패합니다.

Listing 12.5.14 (Listing 12.5.12의 ①을 발췌)

 verify(exactly = 0) { userRepository.findName(any()) }
본서의 예에서는 0회, 혹은 1회의 호출만이었습니다만, 1개의 처리중에서 복수회 불리는 것 같은 패턴이 있으면 2 이상의 수치를 지정하는 것도 가능합니다.

참고 1 　 https://kotest.io/

( 본문으로 돌아가기 )

注2 　 https://kotest.io/docs/framework/testing-styles.html

( 본문으로 돌아가기 )
