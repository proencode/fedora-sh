
9,$s/　/ /g
0C```^[^Mk0 ------- @ Q
0i```^M-^[^M0i```^[0 ------- @ W
0^Mi```^M^M^[kk ------- @ E
0i#### ^[^M^[ ------- @ A


@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/rrqeEWQRQewreq^[
    마크다운 입력시 vi 커맨드 표시 ; (^{)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}
@ Q -> 빈 줄에 블록 시작하기 => 0C```^[^Mk0
@ W -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i```^M-^[^M0i```^[0
@ E -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi```^M^M^[kk
@ A -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[

---------- cut line ----------


> Path: gihyo/kotlin_server_side_programming/01-003_003_java_와_kotlin_의_상호_호환성
> Title: 01-003 003 Java 와 Kotlin 의 상호 호환성
> Short Description: By 다케하타 나오토 date: 210414 Publisher 기술평론사 전자판 ISBN978-4-297-11859-4
> Link: https://gihyo.jp/book/2021/978-4-297-11859-4
> tags: kotlin spring boot
> Images: / gihyo / kotlin_server_side_programming /
> create: 2022-09-19 월 15:03:35


========== start ==========


> 제3장 Java와 Kotlin 의 상호 호환성이 기존 자산을 활용

1장의 시작 부분에서도 설명했지만 Kotlin은 Java와 상호 호환되는 언어입니다. Kotlin에서 Java, Java에서 Kotlin을 호출할 수 있으며, 두 언어를 동일한 프로젝트에서 공존할 수 있습니다. 물론 Kotlin만으로 구현하는 것도 가능합니다만, Java를 사용하고 있던 조직이라면 오랫동안 개발해 온 자산을 활용할 수 있다는 것은 큰 이점입니다. 이 장에서는 주로 Kotlin에서 Java를 사용하는 방법을 중심으로 Java와의 상호 이용에 대해 설명합니다.

# 1. Java 코드 호출

먼저 Kotlin에서 Java 코드를 실행해 보겠습니다. 1장에서 작성한 프로젝트에서 src/main 아래에 java라는 디렉토리를 작성하십시오. src/main 디렉토리를 마우스 오른쪽 버튼으로 클릭하고 [New] → [Directory]를 선택하고 이름을 입력하여 만들 수 있습니다. 그리고 src/main/java 아래에 Java 클래스를 만듭니다. Java 파일은 IntelliJ IDEA에서 대상 디렉토리 (여기서는 src / main / java)를 마우스 오른쪽 버튼으로 클릭하고 [New] → [Java Class]를 선택하여 만들 수 있습니다 ( 그림 3.1 ).

![ 301 new Java Class ]( /gihyo/kotlin_server_side_programming_img/301_new_java_class.webp
)

원하는 이름 (여기서 HelloByJava)을 입력하면 ( 그림 3.2 ) 같은 이름의 클래스가있는 파일이 만들어집니다. 이 장의 모든 코드는 Java의 경우 src / main / java, Kotlin의 경우 src / main / kotlin 아래에 작성됩니다.

![ 302 input class name ]( /gihyo/kotlin_server_side_programming_img/302_input_class_name.webp
)

그리고 Listing 3.1.1 의 코드를 작성한다.

목록 3.1.1
```
// Java
public class HelloByJava {
    public void printHello() {
        System.out.println("Hello Java.");
    }
}
```

「Hello Java.」라고 하는 캐릭터 라인을 출력할 뿐의 printHello 라고 하는 메소드를 가진 클래스입니다 (Java 에서는 함수는 아니고 메소드라고 부릅니다). 그리고 이것을 Kotlin에서 목록 3.1.2 와 같이 호출 할 수 있습니다.

목록 3.1.2
```
// Kotlin
val hello = HelloByJava()
hello.printHello()
```
-> 실행 결과
```
Hello Java.
```

Kotlin 클래스는 인스턴스를 생성하고 실행하는 것과 같이 작성할 수 있습니다.

반대로 Kotlin에서 구현한 코드를 Java에서 호출할 수도 있습니다. 이제 src/main/kotlin 아래에 목록 3.1.3 의 Kotlin 클래스를 만듭니다.

Listing 3.1.3
```
// Kotlin
class HelloByKotlin {
    fun printHello() {
       println("Hello Kotlin.")
    }
}
```

그리고 src/main/java 아래에 Listing 3.1.4 의 클래스를 만들고 main 함수를 실행한다.

목록 3.1.4
```
// Java
public class JavaMain {
    public static void main(String[] args) {
        HelloByKotlin helloByKotlin = new HelloByKotlin();
        helloByKotlin.printHello();
    }
}
```

여기도 Java 클래스를 호출하는 것과 비슷한 방법으로 Kotlin의 코드를 호출 할 수 있습니다. Java는 처리를 구현할 때 반드시 클래스가 필요하기 때문에, main 메소드만을 구현한 클래스를 사용한 샘플이 되고 있습니다.

# 2. Java 라이브러리 호출

Kotlin에서 기존 Java 라이브러리를 호출하는 것도 물론 가능합니다. Listing 3.2.1 을 보라.

Listing 3.2.1
```
// Kotlin
val uuid: UUID = UUID.randomUUID()
println(uuid.toString())
```
-> 실행 결과(랜덤값이므로 참고)
```
044ec94f-54be-429f-bfeb-9eab50684216
```

UUID 라는 Java 표준 라이브러리를 사용하고 있습니다. UUID 는 문자 그대로 UUID를 취급하기 위한 라이브러리로, 여기서는 randomUUID 함수로 UUID가 되는 랜덤의 캐릭터 라인을 생성해, 그 결과를 출력하고 있습니다.

또, java.time.LocalDateTime 와 같은 Java 의 표준 라이브러리의 클래스를, 형태로서 사용할 수도 있습니다.

목록 3.2.2
```
// Kotlin
data class Time(val time: LocalDateTime)
fun main() {
    val now = Time(LocalDateTime.now())
    println(now.time)
}
```
-> 실행 결과(현재 시각을 위한 참고)
```
2021-02-20T17:06:12.184511
```

LocalDateTime 형의 프로퍼티를 가지는 데이터 클래스 Time 를 작성해, LocalDateTime.now 함수로 현재 일시를 설정한 인스턴스를 생성해, 출력하고 있습니다.

# 3. Java 클래스를 상속하고 Kotlin에서 구현

Kotlin과 Java의 상호 운용은 인스턴스의 생성이나 메소드의 호출 뿐만이 아니라, 기존의 Java의 클래스를 상속해 Kotlin로 구현할 수도 있습니다.

## 클래스 상속

우선, Listing 3.3.1 의 Java의 AnimalJava 클래스를 작성한다.

목록 3.3.1
```
// Java
public class AnimalJava {
    public void cry() {
        System.out.println("pien");
    }
}
```

그런 다음 목록 3.3.2 와 같이 Kotlin의 DogKotlin 클래스를 만듭니다.

목록 3.3.2
```
// Kotlin
class DogKotlin: AnimalJava() {
    override fun cry() {
        println("bowwow")
    }
}
```

Java로 만들어진 AnimalJava 클래스를 상속하고, cry 메소드를 오버라이드(override) 해 Kotlin로 구현하고 있습니다. 그리고 Listing 3.3.3 과 같이 실행한다.

목록 3.3.3
```
// Kotlin
val dog = DogKotlin()
dog.cry()
```
-> 실행 결과
```
bowwow
```

인터페이스도 마찬가지로 구현 가능
인터페이스는 클래스와 마찬가지로 Java로 만든 것을 Kotlin에서 구현할 수 있습니다. Listing 3.3.4 에서 Java의 GreeterJava 인터페이스를 생성한다.

Listing 3.3.4
```
// Java
public interface GreeterJava {
    void hello();
}
```

Listing 3.3.5 와 같이 Kotlin에서 구현한다.

Listing 3.3.5
```
// Kotlin
class GreeterImplKotlin: GreeterJava {
    override fun hello() {
        println("Hello.")
    }
}
```

여기도 Kotlin의 인터페이스를 사용했을 때와 비슷한 쓰기로 구현할 수 있습니다. 그리고 Listing 3.3.6 과 같이 실행한다.

Listing 3.3.6
```
// Kotlin
val greeter = GreeterImplKotlin()
greeter.hello()
```
-> 실행 결과
```
Hello.
```

# 4. Java와 상호 호출 할 때의 특별한 예

Java와 Kotlin에서 상호 호출을 할 때, 기본적으로는 각각의 언어로 쓰고 있을 때와 같은 글쓰기로 구현할 수 있습니다. 다만, 쓰는 방법이나 거동이 특수한 형태가 되는 케이스도 있습니다. 여기에서는 주로 Kotlin에서 Java를 호출하는 경우의 특별한 점에 대해 몇 가지 소개합니다.

## 게터, 세터

Listing 3.4.1 과 같은 Java 클래스가 있다고 가정한다.

목록 3.4.1
```
// Java
public class UserJava {
    private Integer id;
    private String name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```

본서에서는 제2장의 「2. 프로퍼티의 정의로 액세서 메소드(getter, setter)가 불필요하게 된다」의 섹션에서 설명해 온, 자주 있는 프로퍼티와 getter , setter 를 가지는 클래스입니다. 속성은 private 로 정의되고, 액세스하려면 아래에 정의되어 있는 각각의 액세서 메소드를 경유할 필요가 있습니다.

그러나 이것을 Kotlin에서 호출하면 목록 3.4.2 와 같이 작성할 수 있습니다.

목록 3.4.2
```
// Kotlin
val user = UserJava()
user.id = 100
user.name = "Takehata"
println(user.id)
println(user.name)
```
-> 실행 결과
```
100
Takehata
```

Kotlin 의 데이터 클래스 등 을 사용했을 때 와 마찬가지로 속성 에 직접 액세스 하는 것처럼 쓰고 있습니다 . 합니다.

이와 같이 Kotlin에서의 기법에 맞추어 쓸 수 있는(Java의 클래스만 getter , setter 를 부르는 등 하지 않아도 된다) 것도, 공존을 시키기 쉽게 하고 있습니다.

## SAM(Single Abstract Method) 변환

제2장에서는 함수형과 고층 함수에 대해서 설명했습니다만, Java에는 함수형이 존재하지 않습니다. 대신 "함수 인터페이스"라는 기능이 있습니다. 이것은 "단일 메소드가 있는 인터페이스(SAM 인터페이스)"를 정의하여 함수 유형처럼 취급할 수 있는 기능입니다.

예로서 Listing 3.4.3 을 살펴보자.

Listing 3.4.3
```
// Java
@FunctionalInterface
public interface CalcJava {
    Integer calc(Integer num1, Integer num2);
}
```

CalcJava 는, calc 라고 하는 1 개의 메소드만이 정의된 Java 의 인터페이스로, 이것을 「함수형 인터페이스」로서 취급할 수가 있습니다. @FunctionalInterface 어노테이션은 붙이지 않아도 작동하지만, 붙이는 것으로 다른 메소드를 추가했을 때 (단일 메소드가 아니게 되었을 때) 컴파일 오류를 내게 해주기 때문에 명시 적으로 붙여 하는 경우가 많습니다.

그리고 Kotlin에서 Listing 3.4.4 와 같이 호출할 수 있다.

Listing 3.4.4
```
// Kotlin
val function = CalcJava { num1, num2 -> num1 + num2 }
println(function.calc(1, 3))
```
-> 실행 결과
```
4
```

CalcJava 에 대해서, 인수로 calc 메소드의 시그니쳐와 같이 Int형의 인수를 2개 받아, Int형의 반환값을 돌려주는 람다식을 건네주고 있습니다. 그리고 calc 메소드를 실행하면, 람다 식으로 건네준 덧셈의 처리가 실행됩니다. 이와 같이 람다식을 건네주는 것으로 SAM 인터페이스로 변환해 주는 기능을, SAM 변환이라고 부릅니다. 이 기능을 사용하면 Kotlin에서 함수 유형을 사용할 때와 유사한 구현에서 Java 함수 유형 인터페이스를 사용할 수 있습니다.

기존 Java 자산을 사용하거나 Java 프레임워크나 라이브러리에서 함수형 인터페이스를 처리할 때 사용합니다.

또한 Listing 3.4.5 와 같이 함수 인수로 함수형 인터페이스를 사용할 수 있다.

Listing 3.4.5
```
// Kotlin
fun executeCalc(num1: Int, num2: Int, function: CalcJava) {
    println(function.calc(num1, num2))
}

fun main() {
    executeCalc(1, 3, CalcJava { num1, num2 -> num1 + num2 })
    val function = CalcJava { num1, num2 -> num1 + num2 }
}
```
-> 실행 결과
```
4
```

## 동반자 개체

Kotlin은 클래스에 정적 변수와 함수를 정의 할 때 Listing 3.4.6 과 같이 companion 객체 를 사용한다.

Listing 3.4.6
```
// Kotlin
class CompanyConstants {
    companion object {
        val maxEmployeeCount = 100
    }
}
```

이것은 Kotlin의 독특한 기능이므로 Java에서 여기에 정의한 변수에 액세스하는 경우 목록 3.4.7 과 같이 호출해야합니다.

목록 3.4.7
```
// Java
public static void main(String[] args) {
    System.out.println(CompanyConstants.Companion.getMaxEmployeeCount());
}
```
-> 실행 결과
```
100
```

CompanyConstants 뒤에 Companion 이라는 객체를 통해 maxEmployeeCount 의 getter 에 액세스합니다. 이것은 내부적으로 실제로 Companion 이라는 객체가 만들어지기 때문에 Kotlin에서는 의식할 필요가 없지만 Java로부터 액세스하는 경우는 경유할 필요가 있습니다.

그러나 매번 이것을 쓰는 것은 번거롭기 때문에 Kotlin 측에서 주석을 달아 Companion 을 작성하지 않고 액세스 할 수있는 방법이 준비되어 있습니다. Listing 3.4.8 을 보라.

Listing 3.4.8
```
// Kotlin
class CompanyConstants {
    companion object {
        @JvmStatic
        val maxEmployeeCount = 100
    }
}
```

변수 maxEmployeeCount 에 @JvmStatic 이라는 주석이 있습니다. 이렇게하면 Java에서도 CompanyConstants 에 포함 된 정적 변수 (Java에서 말하는 클래스 변수)처럼 액세스 할 수 있습니다 ( 목록 3.4.9 ).

Listing 3.4.9
```
// Java
public static void main(String[] args) {
    System.out.println(CompanyConstants.getMaxEmployeeCount());
}
```

# 5. Java 코드를 Kotlin 코드로 변환

IntelliJ IDEA에는 Java 코드를 Kotlin으로 변환하는 기능이 있습니다. Listing 3.5.1 과 같이 Java에서 Hello World 코드를 준비한다.

Listing 3.5.1
```
// Java
public class Hello {
    public static void main(String[] args) {
        System.out.println("Hello World.");
    }
}
```

그리고 그림 3.3 과 같이 대상 파일을 마우스 오른쪽 버튼으로 클릭하고 "Convert Java File to Kotlin File"을 선택하면 Kotlin 코드로 변환이 수행됩니다.

![ 303 Convert Java File to Kotlin File ]( /gihyo/kotlin_server_side_programming_img/303_convert_java_file_to_kotlin_file.webp
)


그림 3.4 와 같이 Hello가 Kotlin이되어 있음을 알 수 있습니다 (파일 이름 옆의 아이콘에 Kotlin 로고가있는 것은 Kotlin의 파일입니다).

![ 304 Kotlin Icon is Kotlin file ]( /gihyo/kotlin_server_side_programming_img/304_kotlin_icon_is_kotlin_file.webp
)


IntelliJ IDEA에서 확장자가 숨겨져 있기 때문에 이해하기 어렵지만 Mac의 Finder, Windows 탐색기 또는 터미널 응용 프로그램에서 보면 확장자가 .java에서 .kt로 변경되는 것을 볼 수 있습니다. 합니다. 열면 목록 3.5.2 와 같은 코드입니다.

Listing 3.5.2
```
// Kotlin
object Hello {
    @JvmStatic
    fun main(args: Array<String>) {
        println("Hello World.")
    }
}
```

Java의 코드를 바탕으로 하고 있기 때문에 Hello 라는 object 가 준비되어 있거나와, 간단한 형태로는 되어 있지 않습니다만, 같은 처리를 Kotlin로 쓴 형태로 변환되고 있습니다.

또한 목록 3.5.3 과 같은 속성과 접근자 메서드를 가진 클래스를 변환하면 목록 3.5.4 와 같이 접근자 메서드가 사라지고 Kotlin 속성을 작성하는 방식으로 변환됩니다.

Listing 3.5.3
```
// Java
public class User {
    private Integer id;
    private String name;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```

Listing 3.5.4
```
// Kotlin
class UserJava {
    var id: Int? = null
    var name: String? = null
}
```

이 정도의 심플한 코드라면 어느 정도 정확하게 변환해 줍니다만, 복잡한 코드가 되어 오면 잘못되어 컴파일 에러가 남은 코드가 되는 경우도 있습니다.

그러나, 예를 들면 Java의 코드를 Kotlin에 이행하고 싶을 때에 일단 변환해 일부 에러가 나오는 개소만 수정하면, 0으로부터 재작성하는 것보다는 상당히 편해집니다. 또, Java로 구현하고 있는 샘플을 우선 변환해 Kotlin의 구현을 보거나, 참고로 사용할 수도 있습니다. Java와의 상호 운용을 보조해 주는 기능으로서는, 특히 Kotlin에 익숙하지 않은 최초의 가운데는, 편리한 것이 아닐까 생각합니다.


