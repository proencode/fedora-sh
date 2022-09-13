5,$s/　/ /g


2장에서는 Kotlin에서 사용할 수 있는 다양한 기능을 소개합니다. 1장에서도 소개했듯이 Kotlin은 간단하게 작성하기 위한 구문과 편리한 기능으로 개발 효율을 높일 수 있는 요소가 많이 있습니다. 이들은 Kotlin의 장점을 최대한 활용한 구현을 해 나가기 위해 필수 지식이기도 합니다. 이 장에서 Kotlin의 장점을 이해하면서, 보다 「Kotlin다운」쓰는 법을 알 수 있으면 좋겠습니다.

# 1. if, when 문을 식으로 취급 코드를 간단하게 할 수 있다

제1장의 「5. Kotlin의 기본 구문」에서, 분기 처리로서 if문과 when문에 대해 소개했습니다. Kotlin에서는 이 if 및 when 문을 식으로 취급하므로 결과 값을 반환할 수 있습니다. 예를 들어 Listing 2.1.1 과 같은 코드가 있다.

Listing 2.1.1
```
fun printOddOrEvenNumberText(num: Int) {
    var text = ""
    if (num % 2 == 1) {
        text = "홀수"
    } else {
        text = "짝수"
    }

    println(text)
}
```

공문자로 초기화한 text 라고 하는 변수를 준비해, 인수의 값에 의해 「홀수」 「짝수」라고 하는 캐릭터 라인으로 재기록, 출력하고 있습니다. 이것은 Listing 2.1.2 와 같이 구현될 수 있다.

Listing 2.1.2
```
fun printOddOrEvenNumberText(num: Int) {
    val text = if (num % 2 == 1) {
        "홀수"
    } else {
        "짝수"
    }

    println(text)
}
```

if 문을 식으로 취급하면 if 문 자체가 결과 값을 반환합니다. 여기에서는 if 에서의 조건 판정의 결과에 의해, 「홀수」 「짝수」라고 하는 캐릭터 라인이 반환되기 때문에, 그 값을 text 변수에 넣고 있습니다. 이렇게 하면 기술량이 줄어 심플해집니다. 또한 변수 text 에도 초기화 단계에서 결과의 값을 설정할 수 있고 val 로 정의할 수 있기 때문에 불필요한 재기록을 할 가능성을 줄일 수 있습니다.

Listing 2.1.3 과 같이 실행하면 다음과 같은 결과가 나온다.

Listing 2.1.3
```
printOddOrEvenNumberText(100)
printOddOrEvenNumberText(99)
```

-> 실행 결과
```
짝수
홀수
```

이 정도의 짧은 코드라면, if문을 1행으로 써 리스트 2.1.4 와 같이 보다 심플한 구현으로 할 수도 있습니다.

Listing 2.1.4
```
fun printOddOrEvenNumberText(num: Int) {
    val text = if (num % 2 == 1) "홀수" else "짝수"

    println(text)
}
```

또한 목록 2.1.5 와 같은 코드는 목록 2.1.6 과 같이 작성할 수 있습니다.

Listing 2.1.5
```
fun getOddOrEvenNumberText(num: Int): String {
    if (num % 2 == 1) {
        return "홀수"
    } else {
        return "짝수"
    }
}
```

Listing 2.1.6
```
fun getOddOrEvenNumberText(num: Int): String {
    return if(num % 2 == 1) {
        "홀수"
    } else {
        "짝수"
    }
}
```

getOddOrEvenNumberText 함수 는 인수 num 의 값이 홀수인지 짝수인지를 결정하고 각각 "홀수" "짝수"라는 문자열을 반환합니다. 이쪽도 if문을 식으로서 취급하는 것으로, if-else 각각의 블록에서 return문을 기술할 필요가 없어지기 때문에, 코드가 간단하게 됩니다.

when 문도 마찬가지로 식으로 취급 할 수 있습니다 ( 목록 2.1.7 ).

Listing 2.1.7
```
fun printNumText(num: Int) {
    val text = when (num) {
        100 -> {
            "Equal to 100"
        }
        200 -> {
            "Equal to 200"
        }
        else -> {
            "Undefined value"
        }
    }

    println(text)
}
```

이쪽도 when문의 각 블록으로 기술하고 있는 값이 text 변수에 들어가, 출력됩니다. Listing 2.1.8 과 같이 실행하면 다음과 같은 결과가 발생한다.

Listing 2.1.8
```
printNumText(100)
printNumText(200)
printNumText(300)
```

-> 실행 결과
```
Equal to 100
Equal to 200
Undefined value
```

# 2. 속성 정의에서 접근자 메서드(getter, setter)가 더 이상 필요하지 않음

데이터 객체 등을 작성할 때, 데이터의 값을 나타내는 필드(프로퍼티)와 액세서 메소드(소위 getter, setter)등을 정의한 클래스를 작성하는 일이 있습니다. Kotlin에서는 클래스에 프로퍼티가 되는 변수를 정의하는 것으로, 그 변수의 액세서 메소드가 내부적으로 생성되어 외부로부터 프로퍼티에 액세스 할 때도 액세서 메소드 경유로 불려 갑니다. 이것에 의해 코드의 기술량도 줄여, 구현이 간단하게 됩니다.

## 내부적으로 생성되는 접근자 메소드

예를 들어, Listing 2.2.1 과 같은 클래스가 있다.

Listing 2.2.1
```
class User1 {
    var name: String = ""
}
```

User1 클래스는 name 이라는 속성을 정의합니다. 이 속성에 대한 액세스는 Listing 2.2.2 와 같다.

Listing 2.2.2
```
val user = User1()
user.name = "BTS"
println(user.name)
```

-> 실행 결과
```
BTS
```

User1 클래스의 인스턴스를 생성하고 user.name = "Takehata" 형태로 name 에 값을 저장합니다. 이것은 외형은 name 이라는 프로퍼티에 직접 넣고 있는 것처럼 보입니다만, 내부적으로는 name 의 setter 를 경유해 name 에 값이 포함되고 있습니다.

프로퍼티의 값의 취득에 관해서는, user.name 의 형태로 호출할 수가 있습니다. 이쪽도 내부적으로는 name 의 getter 를 경유해 name 의 값을 취득하고 있습니다. Listing 2.2.2 의 예제는 getter 로 얻은 결과를 println 에 전달하고 표준 출력을 보여준다.

Listing 2.2.3 과 같이 접근자 메소드를 정의하면 이미 선언된 정의와 충돌한다는 컴파일 오류가 표시되므로 내부적으로 생성된 것을 알 수 있다.

Listing 2.2.3
```
class User1 {
    var name: String = ""

    fun getName(): String {
        return this.name
    }

    fun setName(name: String) {
        this.name = name
    }
}
```

-> 컴파일 오류
```
Platform declaration clash: The following declarations have the same JVM signature (getName()Ljava/lang/String;)
```

## val의 정의는 getter만 생성한다.

앞의 예에서는 속성 변수를 var 로 정의했으며 getter 와 setter 가 생성되었습니다. 이것을 val 로 정의하면 getter 만 생성됩니다.

Listing 2.2.4 의 User2 클래스에서 id 라는 속성은 val 로 정의된다. 이 프로퍼티는 setter 가 생성되지 않기 때문에, constructor 으로 건네진 값으로 초기화해, 그 후 변경할 수 없습니다 ( 리스트 2.2.5 ).

Listing 2.2.4
```
class User2(id: Int) {
    val id: Int = id
    var name: String = ""
}
```

Listing 2.2.5
```
val user = User2(1)
user.name = "Takehata"
user.id = 2 // コンパイルエラー
```

-> 컴파일 오류
```
Val cannot be reassigned
```

인스턴스의 생성시에 초기화해, 그 이후 변경시키고 싶지 않은 프로퍼티를 만들 때는, val 로 정의하는 쪽이 예기치 않은 변경을 할 수 없게 되어 안전합니다.

## lateinit에서 속성 초기화 지연

지금까지의 예에서는 프롭퍼티를 정의할 때에 반드시 초기치를 기술하고 있었습니다. 인스턴스를 생성한 후에 setter 가 불리지 않았던 경우는 이 초기치가 들어간 상태가 됩니다. 다만, 경우에 따라서는 초기치를 설정하지 않고, 처리중에 반드시 값을 넣게 하고 싶은 경우도 있다고 생각합니다. 이 경우 lateinit 을 사용하여 초기 값을 설정하지 않고 정의 할 수 있습니다 ( 목록 2.2.6 ).

Listing 2.2.6
```
class User3 {
    lateinit var name: String
}
```

이를 지연 초기화 속성이라고합니다. lateinit 은 나중에 속성 값을 다시 작성하므로 var 에서만 사용할 수 있습니다.

User3 클래스는 User1 과 거의 동일하지만 name 속성에서 초기값을 지우고 지연 초기화 대상으로 합니다. lateinit 을 사용하면 인스턴스 생성시 초기화가 필요하지 않지만 처리에서 getter 를 호출 할 때 항상 값이 저장되어 있지 않으면 런타임에 오류가 발생합니다 ( 목록 2.2.7 ).

Listing 2.2.7
```
val user = User3()
println(user.name)
```

-> 실행 결과
```
Exception in thread "main" kotlin.UninitializedPropertyAccessException: lateinit property name has not been initialized
```

이 에러는 컴파일에서는 검출할 수 없고, 런타임시에 에러로서 나가 버리기 때문에 보다 주의해 취급할 필요가 있습니다.

## 확장 속성으로 getter, setter 처리를 확장합니다.

지금까지 프로퍼티의 액세서 메소드가 내부적으로 생성되어 사용되고 있는 것을 설명해 왔습니다. 하지만 외형상은 직접 프로퍼티에 액세스하고 있는 것처럼 쓰여져 있기 때문에, 「액세서 메소드를 생성하고 있는 의미가 있는가?」라고 생각된 분도 있을지도 모릅니다. 그래서 확장 속성에 대해 설명합니다. 확장 프로퍼티는, 생성되고 있는 프로퍼티의 getter , setter 를 확장해, 단지 값의 격납과 취득 뿐만이 아니라, 독자적인 처리를 기술할 수가 있습니다.

Listing 2.2.8 을 보라.

Listing 2.2.8
```
class User4 {
    lateinit var name: String
    val isValidName: Boolean
       get() = name != ""
}
```

User4 클래스에서는, isValidName 라고 하는 프로퍼티에 get() = name != "" 라고 하는 처리가 쓰여져 있습니다. 이것은 isValidName 이라는 프로퍼티에 대한 get() 함수의 처리를 재기록하고 있어 처리상에서 isValidName 를 취득할 때에는 이 처리가 불리게 됩니다. 여기에서는 이 프로퍼티에 값이 들어가는 것은 아니고, 이름이 유효한가 (빈 문자가 아닌가)라고 하는 오브젝트의 상태를 판정해 취득하는 처리가 되어 있습니다. 그 때문에 프로퍼티와 같이 취급할 수 있습니다만, isValidName 라고 하는 필드는 존재하고 있지 않습니다.

Listing 2.2.9 에서는 속성을 확장한 isValidName 을 호출하고 결과의 진위 값을 출력한다.

Listing 2.2.9
```
val user = User4()
user.name = "Takehata"
println(user.isValidName)
```

-> 실행 결과
```
true
```

또, 리스트 2.2.10 과 같이 set(value) 의 처리를 구현하는 것으로, setter 를 확장할 수도 있습니다. value 는 setter 에 전달되는 값을 나타냅니다. 일반적으로 value 라는 이름을 사용하는 경우가 많지만 다른 이름을 사용할 수도 있습니다.

Listing 2.2.10
```
class User5 {
    var name: String = ""
        set(value) {
            if (value == "") {
                field = "Kotlin"
            } else {
                field = value
            }
        }
}
```

지금까지 소개해 온 User 클래스와 같이 name 이라는 프로퍼티를 가지고 있습니다만, setter 를 확장해 값을 받은 시점에서 인수를 체크해, 공문자였을 경우는 Kotlin 이라고 하는 캐릭터 라인을 설정하고 있습니다. 실행하면 목록 2.2.11 과 같습니다.

목록 2.2.11
```
val user = User5()
user.name = ""
println(user.name)
user.name = "Takehata"
println(user.name)
```

-> 실행 결과
```
Kotlin
Takehata
```

빈 문자이면 Kotlin 이 표시되고 빈 문자가 아니면 인수로받은 값이 출력됩니다. 앞에서 설명한 getter 를 확장한 속성은 "필드가 존재하지 않는다"고 썼지만 이 이름 의 사용자 지정 setter 처럼 값을 유지해야 하는 경우 field 라는 식별자를 사용합니다. field 식별자를 사용해 커스텀 액세서가 처리를 했을 때, 값을 격납하는 배킹 필드 주 1 가 생성되어, 그 쪽을 개입시켜 값의 격납과 취득을 하고 있습니다.

# 3. 데이터 클래스에서 보일러 플레이트를 줄일 수 있습니다.

전항에서 프로퍼티에 대해 설명했지만, 데이터 객체 등을 만들 때는 액세서 메소드뿐만 아니라 객체 비교를 위한 equals 함수, hashCode 함수, 객체를 문자열 출력할 때 사용하는 toString 함수 등을 구현하는 것 있습니다. 이러한 속성을 기반으로 만들어진 보일러 플레이트는 Kotlin에서 데이터 클래스를 사용하여 줄일 수 있습니다.

## Kotlin 객체 비교

데이터 클래스를 구현하기 전에 Kotlin의 객체 비교를 설명합니다.

Kotlin의 클래스는 모두 반드시 Any 라는 클래스를 상속하여 만들어집니다. 이것은 명시적인 설명을 할 필요는 없고, 언어 스펙으로 자동적으로 상속되고 있습니다. 그 Any 클래스에는 다음의 3 개의 함수가 정의되고 있습니다.

- toString ... ... 객체를 문자열로 출력하는 변환 처리
- hashCode…… 오브젝트의 해시 코드를 취득하는 처리
- equals…… 오브젝트의 비교를 하는 처리

== 연산자로 오브젝트를 비교했을 때, 내부적으로는 이 equals 함수가 불려 갑니다. hashCode 는 HashSet 클래스에서의 비교 처리에 사용됩니다. HashSet 클래스의 contains 함수를 호출했을 때, 우선 hashCode 함수의 결과가 동일한지 어떤지를 판정을 하고, 그 후에 equals 함수로의 비교가 실행됩니다.

그러나 이러한 비교는 기본 상태에서는 작동하지 않습니다. 예를 들어 Listing 2.3.1 과 같이 속성을 정의한 클래스가 있다.

Listing 2.3.1
```
class User6 {
    val id: Int = 1
    val name = "Kotlin"
}
```

이 클래스에서 Listing 2.3.2 와 같이 두 개의 인스턴스를 생성하고 비교하면 다음과 같은 결과가 나온다.

Listing 2.3.2
```
val userA = User6()
val userB = User6()

// toString 함수의 비교
println(userA.toString())
println(userB.toString())

// hashCode 의 비교
println(userA.hashCode())
println(userB.hashCode())

// equals 함수에서의 비교
println(userA == userB)

// hashCode 함수, equals 함수에서의 비교
val set = hashSetOf(userA)
println(set.contains(userB))
```

-> 실행 결과
```
User6@2752f6e2
User6@e580929
659748578
240650537
false
false
```

userA , userB 모두 인스턴스를 생성한 상태이므로 속성에 설정된 값은 동일합니다. 그러나이 두 객체의 toString 과 hashCode 의 결과는 다른 값입니다. 또한 == 연산자에서 비교하거나 HashSet 클래스의 contains 함수를 실행하면 false가 반환됩니다.

toString 에서는 클래스명과 객체의 참조처의 해시값이 출력되고 있습니다. 이것은 오브젝트의 정보가 격납되고 있는 메모리상의 장소를 나타내고 있는 것이라고 생각해 주셔서 괜찮습니다.

또한 hashCode 의 결과도 각각 흩어져있는 값이 출력되고 userA 를 HashSet 에 넣고 contains 함수에 userB 를 전달하여 검색해도 false가 반환됩니다.

이와 같이 객체의 비교나 캐릭터 라인으로의 출력을 할 수 있도록 하려면 , 각 클래스에서 toString , hashCode , equals 를 오버라이드(override) 할 필요가 있습니다. 예를 들면 Listing 2.3.3 과 같은 형태이다.

Listing 2.3.3
```
class User6 {
    val id: Int = 1
    val name = "Kotlin"

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as User6

        if (id != other.id) return false
        if (name != other.name) return false

        return true
    }

    override fun hashCode(): Int {
        return 31 * name.hashCode() + id
    }

    override fun toString(): String {
        return "User6(id=$id, name=$name)"
    }
}
```

toString 은 클래스 이름과 속성 값을 표시하도록 다시 쓰고 hashCode 는 속성 값을 사용하여 계산하는 형식으로 다시 씁니다. 여기에서는 hashCode 의 처리는 name 프로퍼티의 hashCode ( String 클래스의 hashCode )의 결과에 31(숫자는 임의)을 곱해, id 의 수치를 더한 결과를 돌려주고 있습니다만, 객체를 일의에 나타낼 수 있는 값이 돌려주어 그렇다면 아무 문제가 없습니다.

그리고 equals 함수에서,

①  === 연산자로 객체의 참조원을 비교해 일치하면 true를 반환(같은 객체를 참조하고 있기 때문에)
②  각각의 오브젝트의 형태를 비교
③  인수로 받은 객체를 자신의 형태로 캐스트
④  각 속성의 값을 각각 비교하고 일치하지 않으면 false를 반환
⑤  모든 속성의 값이 일치하면 true를 반환
라고 하는 처리를 실행해, 같은 형태의 오브젝트로 같은 값을 가지고 있으면 같은 오브젝트, 라고 하는 판정으로 하고 있습니다.

각 함수를 재정의한 User6 클래스에 대해 Listing 2.3.2 의 처리를 실행하면 Listing 2.3.4 와 같은 결과가 된다.

Listing 2.3.4
-> 실행 결과
```
User6(id=1, name=Kotlin)
User6(id=1, name=Kotlin)
true
1131585280
1131585280
true
```

toString , hashCode 는 각각 같은 값을 출력하게 되고, == 연산자나 HashSet 의 contains 함수로의 비교도 true 를 반환하게 되어 있습니다.

그러나 이러한 처리는 속성 값을 기반으로 동일한 규칙으로 작성할 수 있으며 모든 클래스에서 작성하면 보일러 플레이트가됩니다. 그래서 데이터 클래스를 사용하면 간단한 설명이 될 수 있습니다.

## 데이터 클래스 정의

데이터 클래스는 Listing 2.3.5 와 같이 정의한다.

Listing 2.3.5
```
data class User7(val id: Int, var name: String)
```

클래스명 앞에 data class 라고 붙여 정의해, constructor 에 property를 기술합니다. 이것만으로 각각의 프로퍼티의 필드와, 그것에 대한 이하의 함수를 추론합니다.

- 액세서 메소드(val로 정의한 경우는 getter만)
- 같음
- 해시 코드
- 
- 구성요소N
- 복사

접근자 메서드는 속성 섹션에서 설명한 것과 같습니다. 데이터 클래스에서는, 프로퍼티의 값으로부터 equals , hashCode , toString 함수도 추론해 오버라이드(override) 해 줍니다. 게다가 componentN (N은 함수명에 수치가 들어간다), copy 라고 하는 편리한 함수도 생성해 줍니다.

여기에서 각 함수에 대해 설명합니다.

- 접근자 방법

액세서 메소드는 전항에서 설명한 프롭퍼티와 같이 val 로 정의하면 setter 만, var 로 정의하면 setter 와 getter 양쪽 모두가 생성되어 사용법으로서도 같게 됩니다( 리스트 2.3.6 ). 차이로는 데이터 클래스는 생성자를 정의해야 하므로 인스턴스 생성 시에도 값을 전달해야 합니다.

Listing 2.3.6
```
val user = User7(1, "Takehata")
user.name = "Kotlin"
println(user.name)
```
-> 실행 결과
```
Kotlin
```

- 같음

Listing 2.3.7 과 같이 동일한 속성 값을 가진 User7 클래스의 인스턴스 ( user , same )와 다른 값을 가진 인스턴스 ( other )를 생성하고 == 연산자로 비교한다.

Listing 2.3.7
```
val user = User7(1, "Takehata")
val same = User7(1, "Takehata")
val other = User7(2, "Takehata")

println(user == same)
println(user == other)
```
-> 실행 결과
```
true
false
```

같은 값을 가진 same 과의 비교는 true를 반환하고 다른 값을 가진 other 와의 비교에서는 false를 반환합니다.

- 해시 코드

hashCode 함수는 Listing 2.3.8 과 같이 실행되며 다음과 같은 결과가 된다.

Listing 2.3.8
```
val user = User7(1, "Takehata")
val same = User7(1, "Takehata")
val other = User7(2, "Takehata")

println("user=${user.hashCode()}")
println("same=${same.hashCode()}")
println("other=${other.hashCode()}")

val set = hashSetOf(user)
println(set.contains(same))
println(set.contains(other))
```

-> 실행 결과
```
user=-579486100
same=-579486100
other=-579486069
true
false
```

같은 프로퍼티의 값을 가지는 user 와 same 는 같은 값을 돌려주고, 다른 값을 가지는 other 는 다른 결과를 돌려줍니다.

toString 함수는 Listing 2.3.9 와 같이 실행하면 클래스 이름 (속성 이름 = 값, ...) 형식으로 출력됩니다.

Listing 2.3.9
```
val user = User7(1, "Takehata")
println(user.toString())
```
-> 실행 결과
```
User7(id=1, name=Takehata)
```

- 구성요소N

componentN 함수는, 순서를 지정해 프로퍼티의 값을 취득하고 싶은 경우에 사용합니다. N 부분에는 속성 순서의 숫자가 들어 있습니다. 예를 들면 Listing 2.3.10 과 같이 실행한다.

Listing 2.3.10

 val user = User7(1, "BTS")
 println(user.component1())
 println(user.component2())
```

-> 실행 결과
```
1
BTS
```

여기서는 component1 을 실행하여 첫 번째 속성인 id 값과 component2 에서 두 번째 속성인 name 값을 가져옵니다.

- 복사

마지막으로 copy 함수입니다. copy 함수는 data 클래스의 인스턴스에서 값을 복사하여 새 인스턴스를 만들 수 있습니다. 그 때, 임의의 프로퍼티의 값을 변경하는 것이 가능합니다. Listing 2.3.11 에서는 user 에서 name 을 Kotlin 으로 변경한 updated 를 생성한다.

Listing 2.3.11
```
val user = User7(1, "Takehata")
val updated = user.copy(1, "Kotlin")
println(updated.toString())
```

-> 실행 결과
```
User7(id=1, name=Kotlin)
```

## 데이터 클래스에서 확장 속성 사용

데이터 클래스에도 확장 속성을 가질 수 있습니다. Listing 2.3.12 는 위에서 설명한 User4 클래스에서 구현했던 것처럼 isValidName 이라는 확장 속성을 추가한다.

Listing 2.3.12
```
data class User7(val id: Int, var name: String) {
    val isValidName: Boolean
        get() = name != ""
}
```

# 4. 기본 인수와 명명된 인수로 함수 호출을 단순화할 수 있습니다.

## 기본 인수

Kotlin에서는 함수에 기본 인수를 설정할 수 있습니다. 디폴트 인수는, 호출시에 인수가 생략되었을 때에 디폴트로 사용되는 값입니다. Listing 2.4.1 을 보라.

Listing 2.4.1
```
fun printUserInfo(id: Int, name: String = "Default Name") {
    println("id=$id name=$name")
}
```

printUserInfo 함수의 인수 name 은 "Default Name" 이라는 기본 인수로 설정됩니다. 이 인수를 생략하고 Listing 2.4.2 와 같이 실행하면 다음과 같은 결과가 발생한다.

Listing 2.4.2
```
printUserInfo(1)
```

-> 실행 결과
```
id=1 name=Default Name
```

여기에서는 인수 id 의 수치만을 건네주어 실행하고 있습니다. 그리고 생략 된 name 에는 "Default Name" 이 들어가 출력됩니다. 목록 2.4.3 에서와 같이 두 인수를 모두 전달하면 name 도 전달된 값을 표시합니다.

Listing 2.4.3
```
printUserInfo(1, "BTS")
```

-> 실행 결과
```
id=1 name=BTS
```

또한 기본 인수는 생성자에도 설정할 수 있습니다. 예를 들어, Listing 2.4.4 와 같이 데이터 클래스에 기본 인수를 지정한다.

Listing 2.4.4
```
data class User8(val id: Int, val name: String = "Default Name")
```

그리고 함수의 호출과 같이, 디폴트 인수가 설정되어 있는 인수를 생략해, 데이터 클래스의 인스턴스를 생성할 수가 있습니다 ( 리스트 2.4.5 ).

Listing 2.4.5
```
val user = User8(1)
println(user.toString())
```

-> 실행 결과
```
User8(id=1, name=Default Name)
```

- 명명된 인수

명명된 인수를 사용하면 임의의 인수에만 값을 전달하여 함수와 생성자를 호출할 수 있습니다. 예를 들어, Listing 2.4.6 과 같은 데이터 클래스가 있다.

Listing 2.4.6
```
data class User9(val id: Int, val name: String = "Default Name", val age: Int)
```

이 데이터 클래스는 세 개의 인수 중 두 번째 name 에만 기본 인수가 설정됩니다. 이 name 만을 생략해 호출하고 싶을 때, Listing 2.4.7 과 같이 쓸 수가 있습니다.

Listing 2.4.7
```
val user = User9(id = 1, age = 30)
println(user.toString())
```

-> 실행 결과
```
User9(id=1, name=Default Name, age=30)
```

속성 이름 = 값 형식으로 지정하면 특정 인수에만 값을 전달할 수 있습니다. 이 예제에서는 id 와 age 에만 이름이 지정된 인수로 값을 전달하고 name 은 기본 인수를 사용합니다. 이 예에서는 결과를 알기 쉽게 디폴트 인수에 특정의 캐릭터 라인을 설정하고 있습니다만, 예를 들어 생략했을 경우는 null나 공문자, Int이면 0을 넣는 등, 상태에 의해 불필요하게 되는 프로퍼티를 갖게 하고 싶다 경우 등에서 사용하면 매우 편리합니다.

# 5. 함수형과 고층함수, 타입 별칭으로 로직을 재이용하기 쉽게 할 수 있다

Kotlin에는 함수형이 존재합니다. 여기에서는 기본적인 함수형의 기능과 사용법을 소개합니다.

## 함수형 정의 및 함수 리터럴

우선 함수형 변수를 정의해 보겠습니다. Listing 2.5.1 을 보라.

Listing 2.5.1
```
val calc: (Int, Int) -> Int = { num1: Int, num2: Int -> num1 + num2 }
```

변수 calc 에, 형태로서 (Int, Int) -> Int 를 지정하고 있습니다. 이것은 "Int형의 인수를 2개 받아 Int형의 반환값을 돌려준다"라고 하는 함수형 을 정의하고 있습니다. (인수...) -> 반환값의 형태 라고 하는 구문이 됩니다. 반환값이 없는 경우는 Unit 를 반환값의 형태로 지정합니다. 그리고 calc 에 대입하고 있는 값이 { num1: Int, num2: Int -> num1 + num2 } 가 됩니다. 변수의 형태에 있는 "Int의 인수를 2개 받아 Int의 반환값을 돌려준다" 처리의 구현을 나타내고 있습니다. 이와 같이 함수를 값으로 기술하는 것을 함수 리터럴 이라고 합니다.

함수 리터럴은 쓰는 방법이 2종류 있어, 이 {} 로 묶은 가운데 인수와 처리를 기술하는 방식을 「람다 식」이라고 합니다. 여기에서는 받은 2개의 Int형의 인수를 더한 결과를 반환하고 있습니다. 그리고이 calc 를 사용하면 목록 2.5.2 와 같은 구현이 가능합니다.

Listing 2.5.2
```
val calc: (Int, Int) -> Int = { num1: Int, num2: Int -> num1 + num2 }
println(calc(10, 5))
```

-> 실행 결과
```
15
```

정의한 변수 calc 에 2개의 수치를 건네주는 것으로, 더한 결과를 돌려주고 있는 것을 알 수 있습니다. 이것이 함수형의 기본적인 거동입니다. 또한 함수 리터럴에서는 형식 추론이 작동하고 Listing 2.5.3 과 같이 형식을 생략하고 쓸 수 있습니다.

Listing 2.5.3
```
val calc: (Int, Int) -> Int = { num1, num2 -> num1 + num2 }
```

또한 인수가 하나만 있으면 인수의 이름도 생략할 수 있습니다. 이 경우 인수는 암시 적으로 it 라는 이름으로 처리됩니다. Listing 2.5.4 에서는 하나의 Int 타입의 인수를 받고 it 라는 변수를 곱하여 제곱한 결과를 반환한다.

Listing 2.5.4
```
val squared: (Int) -> Int = { it * it }
```

또, 함수 리터럴의 또 다른 쓰는 방법으로서 「무명 함수」가 있습니다. Listing 2.5.5 와 같이, 일반 함수 정의에서 이름 부분만 지워진 형태로 쓸 수 있다.

Listing 2.5.5
```
val squared: (Int) -> Int = fun(num: Int): Int { return num * num }
```

기본적으로는 간단하게 기술할 수 있는 람다식을 사용하는 경우가 많습니다만, 반환값의 형태를 명시적으로 기술할 필요가 있는 경우 등은, 이쪽을 사용하는 일도 있습니다.

## 고층 함수

고층 함수는 함수형의 객체를 인수에 받는 함수입니다. Listing 2.5.6 을 보라.

Listing 2.5.6
```
fun printCalcResult(num1: Int, num2: Int, calc: (Int, Int) -> Int) {
    val result = calc(num1, num2)
    println(result)
}
```

printCalcResult 함수는 2개의 Int형, 그리고 전술한 calc 함수와 같이 「Int의 인수를 2개 받아 Int의 반환값을 돌려준다」함수형의 인수를 받고 있습니다. 그리고 받은 2개의 수치( num1 , num2 )를 함수형의 인수 calc 에 건네주어, 돌려주어진 결과를 출력하고 있습니다. 이 함수는 Listing 2.5.7 과 같이 실행된다.

Listing 2.5.7
```
printCalcResult(10, 20, { num1, num2 -> num1 + num2 })
printCalcResult(10, 20, { num1, num2 -> num1 * num2 })
```

-> 실행 결과
```
30
200
```

모두 10과 20이라는 수치를 건네주고 있습니다만, 1회째의 호출에서는 덧셈, 2번째의 호출에서는 곱셈의 결과를 돌려주는 함수 리터럴을 건네주어, 각각의 결과를 출력하고 있습니다. 이와 같이, 같은 함수중에서도 인수에 건네주는 함수 리터럴에 의해 일부의 처리를 바꿀 수가 있습니다. 통상이라면 printCalc 함수를 더해, 곱셈 각각으로 준비해야 하는 곳을, 1개의 함수를 재이용하는 것으로 구현할 수 있습니다.

Listing 2.5.8 과 같이 호출자의 함수에 의해 전달되는 함수 리터럴을 변경할 수도 있다.

Listing 2.5.8
```
fun printAddtionResult(x: Int, y: Int) {
    println("足し算の結果を表示します")
    printCalcResult(x, y, { num1, num2 -> num1 + num2 })
}

fun printMultiplicationResult(x: Int, y: Int) {
    println("掛け算の結果を表示します")
    printCalcResult(x, y, { num1, num2 -> num1 * num2 })
}
```

이 정도의 처리라면 각각 함수 안에서 계산 처리를 직접 써 버려도 좋을지도 모릅니다만, 함수 안에서 같은 인수를 취급하는 일부의 논리를 유연하게 취급할 수 있도록(듯이) 하고 싶을 때 등에 , 고층 함수는 힘을 발휘합니다.

또, 맨 뒤의 인수에 함수 리터럴을 건네주는 경우는, 리스트 2.5.9 와 같이 () 밖에 기술할 수가 있습니다.

Listing 2.5.9
```
printCalcResult(10, 20) { num1, num2 ->
    num1 + num2
}
```

특히 처리의 기술이 복수행에 건너는 경우 등은 읽기 쉬워지기 때문에, 이쪽의 쓰는 쪽이 추천되고 있습니다.

## 타입 별칭

변수나 인수에 함수형을 정의하는 쓰는 방법을 설명해 왔습니다만, (Int, Int) -> Int 라고 하는 함수형을 여러 개소에서 사용하고 싶어지는 경우가 있다고 생각합니다. 그럴 때는 타입 앨리어스를 사용해, 이름을 붙여 둘 수가 있습니다. Listing 2.5.10 과 같이 정의한다.

목록 2.5.10

 typealias Calc = (Int, Int) -> Int
typealias 이름 = 함수 형식 정의 형식으로 설명합니다. 여기에 붙인 이름을, 형태로서 취급할 수가 있습니다. 이것을 사용하면 위의 printCalcResult 함수를 목록 2.5.11 과 같이 작성할 수 있습니다.

Listing 2.5.11
```
fun printCalcResult(num1: Int, num2: Int, calc: Calc) {
    val result = calc(num1, num2)
    println(result)
}
```

이것으로 같은 함수형을 사용하고 싶었던 경우도 이 Calc 를 참조하면 사용할 수 있게 되었습니다. 또한 인수의 설명도 깔끔하게 만들 수있었습니다.

# 6. 확장 기능으로 유연하게 로직 추가

Kotlin에는 확장 함수의 기능이 있습니다. 이것은 기존의 클래스에 대해서, 함수를 추가한 것처럼 처리를 기술할 수 있는 기능입니다. 예를 들어 Int의 수치에 대해 제곱한 값을 반환하는 함수를 만들고 싶은 경우, 일반 함수로 구현하면 Listing 2.6.1 과 같이 된다.

Listing 2.6.1
```
fun square(num: Int): Int = num * num

fun main() {
    println(square(2))
}
```

-> 실행 결과
```
4
```
i```-```
이것을 확장 함수를 사용해, Int 클래스 자체에 자신을 제곱한 값을 반환하는 함수를 추가하는 형태로 할 수 있습니다. Listing 2.6.2 와 같이 쓰는 방법이 된다.

Listing 2.6.2
```
 fun Int.square(): Int = this * this

 fun main() {
     println(2.square())
 }
> 실행 결과
```
4
```

확장 함수의 정의는 fun 클래스의 형태 함수명 으로 기술해, 그 뒤의 쓰는 방법은 통상의 함수와 같습니다. this 를 사용하면 확장 함수를 실행하는 클래스 자체 ( 목록 2.6.2 의 경우 Int의 2)를 참조 할 수 있습니다. 그리고 함수의 호출측도, 값을 함수의 인수로서 건네주는 것이 아니라, Int 가 가지는 함수와 같이 호출할 수가 있습니다.

확장 함수의 스코프도 통상의 함수와 같기 때문에, 예를 들어 톱 레벨의 함수로서 기술해, 다른 패키지로부터 import 해 사용할 수도 있습니다. 또, 특정의 클래스내에서만 사용하고 싶은 확장 함수를 추가하는 경우 등은, private 등의 수식자를 붙이는 것으로 스코프를 좁힐 수도 있습니다.

# 7. 범위 함수를 사용하여 객체에 대한 처리를 단순화할 수 있습니다.

Kotlin은 "Scope Function"이라는 기능을 제공하며, 이것을 사용하면 객체에 대한 처리를 효율적으로 작성할 수 있습니다. 다음과 같은 종류가 있으므로 차례로 설명합니다.

- ~와 함께
- 운영
- 허락하다
- 적용하다
- 또한

## with - 복수의 처리를 정리해 실시한다

with는 한 객체에 대해 여러 작업을 함께 수행하려는 경우에 사용합니다. 예를 들어, Listing 2.7.1 과 같은 처리가 있다.

Listing 2.7.1
```
val list = mutableListOf<Int>()
for (i in 1..10) {
    if (i % 2 == 1) list.add(i)
}
val oddNumbers = list.joinToString(separator = " ")
println(oddNumbers)
```
-> 실행 결과
```
1 3 5 7 9
```

이 처리에서는, MutableList 의 인스턴스 list 를 생성해, 1~10의 사이에 포함되는 홀수의 수치를 for문안에서 add 함수로 추가해, 마지막에 joinToString 함수로 결합한 캐릭터 라인을 변수 oddNumbers 에 대입해 , 출력하고 있습니다. joinToString 함수는, List 등의 컬렉션의 요소를, 지정된 캐릭터 라인을 단락 문자로 한 캐릭터 라인으로 변환하는 함수입니다. 여기서는 separator = " " 로 반각 공백을 지정하고 list 의 요소 (홀수 값)를 반각 공백으로 구분 된 문자열로 변환합니다.

이것은 with 를 사용하여 Listing 2.7.2 와 같이 다시 쓸 수 있다.

Listing 2.7.2
```
 val oddNumbers = with(mutableListOf<Int>()) {
     for (i in 1..10) {
         if (i % 2 == 1) this.add(i)
     }
     this.joinToString(separator = " ")
 }
 println(oddNumbers)
```
-> 실행 결과
```
1 3 5 7 9
```

with 는 제 1 인수에 리시버가 되는 객체 주 2 , 제 2 인수로서 리시버의 객체를 처리해 임의의 형태를 돌려주는 함수를 건네줍니다. 이 예에서 말하면 MutableList 의 인스턴스가 리시버, 뒤에 오는 코드 블록이 리시버를 처리하는 함수입니다. 함수 내에서 수신기에 대해 this 로 액세스 할 수 있습니다. 이 with 함수 중에서는 MutableList 에 대해 add 의 처리를 실행해, 마지막 행의 joinToString 의 결과를 반환값으로서 돌려주고 있습니다.

또한 이 this 는 생략할 수 있으므로 Listing 2.7.3 과 같이 쓸 수 있다.

Listing 2.7.3
```
val oddNumbers = with(mutableListOf<Int>()) {
    for (i in 1..10) {
        if (i % 2 == 1) add(i)
    }
    joinToString(separator = " ")
}
println(oddNumbers)
```

## run - Nullable인 오브젝트에 복수의 처리를 정리해 실시한다

run 은 with 와 비슷하지만, 이것은 인수에 리시버 객체를 취하는 것이 아니라 리시버 객체에 대한 확장 함수로 처리를 구현합니다. Listing 2.7.4 를 보라.

Listing 2.7.4
```
val oddNumbers = mutableListOf<Int>().run {
    for (i in 1..10) {
        if (i % 2 == 1) this.add(i)
    }
    this.joinToString(separator = " ")
}
println(oddNumbers)
```

생성한 MutableList 인스턴스에 대해 .run {함수 처리} 형태로 구현하고 있습니다. with 와 마찬가지로 this 를 생략하는 것도 가능합니다. with 보다 편리한 점으로서, Nullable인 객체를 취급하는 경우의 쓰는 방법이 됩니다. Listing 2.7.5 와 같이 안전 호출과 함께 실행하면 수신기에 값이 들어있는 경우에만 처리를 수행하고, 그렇지 않으면 null을 반환하는 등의 처리가 가능합니다.

Listing 2.7.5
```
data class User(var name: String)
fun getUserString(user: User?, newName: String): String? {
    return user?.run {
        name = newName
        toString()
    }
}
```

## let2s - Nullable 객체에 이름을 붙여 처리를 실시한다\

let 은 run , with 와는 달리 리시버의 객체에 대해 this 가 아니라, 이름을 붙여 취급할 수 있습니다. 예를 들어, Listing 2.7.4 의 run 처리는 Listing 2.7.6 과 같이 다시 작성될 수 있다.

Listing 2.7.6
```
val oddNumbers = mutableListOf<Int>().let { list ->
    for (i in 1..10) {
        if (i % 2 == 1) list.add(i)
    }
    list.joinToString(separator = " ")
}
println(oddNumbers)
```

list -> 로 이름을 붙이고 함수 내의 처리에서는 list 라는 이름으로 리시버의 객체를 취급하고 있습니다. 다만, 이 쓰는 방법에서는 list. 라고 하는 중복의 기술이 늘어나 버리기 때문에, run 을 사용해 this 를 생략한 쓰는 쪽이 좋을 것입니다. let 에서 자주 사용하는 것은 Listing 2.7.7 과 같이 Nullable 객체에 대해 처리를 수행하는 패턴이다.

Listing 2.7.7
```
data class User(val name: String)

fun createUser(name: String?): User? {
    return name?.let { n -> User(n) }
}
```

createUser 함수는 인수의 이름 이 null이 아닌 경우에만 User 의 인스턴스를 생성하고 반환하는 프로세스입니다. Listing 2.7.8 과 같이 실행하면 다음과 같은 결과가 발생한다.

Listing 2.7.8
```
println(createUser("Takehata"))
println(createUser(null))
```
-> 실행 결과
```
User(name=Takehata)
null
```

이것을 스코프 함수를 사용하지 않고 기술하면, Listing 2.7.9 와 같은 if문을 사용한 기입이 됩니다.

Listing 2.7.9
```
fun createUser(name: String?): User? {
    return if (name != null)  User(name) else null
}
```

이 if (hoge != null)…… 라는 처리가 나온 곳은 let 의 자주 사용되는 장면입니다. 또한 let 은 이름을 생략하여 목록 2.7.10 과 같이 it 이라는 암시 적 이름으로 수신기를 처리 할 수 ​​있습니다.

목록 2.7.10
```
fun createUser(name: String?): User? {
    return name?.let { User(it) }
}
```

it 라는 이름은 이 후에도 유사한 암시적 이름으로 취급하는 처리시에 자주 나옵니다.

## apply - 객체를 변경하고 반환

apply 는 여기까지 소개해 온 with , run , let 과는 달리, 반환값으로서 리시버 객체 자체를 반환합니다. 무슨 일이 일어나는지, 예를 들어, Listing 2.7.4 의 처리를 run 에서 apply 로 바꾸면, Listing 2.7.11 과 같은 결과가 발생한다.

Listing 2.7.11
```
val oddNumbers = mutableListOf<Int>().apply {
    for (i in 1..10) {
        if (i % 2 == 1) this.add(i)
    }
    this.joinToString(separator = " ")
}
println(oddNumbers)
```
-> 실행 결과
```
[1, 3, 5, 7, 9]
```

with , run , let 에서는 마지막으로 실행한 joinToString 의 결과가 돌려주어졌습니다만, apply 의 경우는 리시버 오브젝트인 MutableList 의 인스턴스 그 자체가 반환됩니다. 변수 oddNumbers 는 반각 공백으로 구분된 문자열이 아니라 MutableList 의 객체이므로 [] 로 둘러싸인 쉼표로 구분된 요소 값이 출력됩니다. 이것은, 리시버 오브젝트 자신에 대해서 값의 변경등의 처리를 실시해, 처리후의 상태로 반환하고 싶을 때에 사용합니다. Listing 2.7.12 를 보라.

Listing 2.7.12
```
data class User(val id: Int, var name: String, var address: String)

fun getUser(id: Int): User {
    return User(id, "Takehata", "Tokyo")
}
fun updateUser(id: Int, newName: String, newAddress: String) {
    val user = getUser(id).apply {
        this.name = newName
        this.address = newAddress
    }
    println(user)
}
```

kgetUser 함수는 인수로 받은 id 와 고정값의 name , address 를 반환할 뿐의 함수입니다 제발).

updateUser 함수 중에서는, getUser 의 반환값의 User 객체에 대해서 apply 로 처리를 기술하고 있습니다. apply 는 with 와 run 과 마찬가지로 this 로 수신기 객체에 액세스 할 수 있습니다. 여기에서는 getUser 반환값의 User 객체의 name , address 를 인수로 받은 값으로 갱신하고 있습니다. 그리고 앞서 언급했듯이 apply 는 수신기 객체 자체를 반환합니다. 이 처리로 말하면, getUser 의 반환값에 인수의 newName , newAddress 의 값을 반영한 User 객체가 반환됩니다. Listing 2.7.13 과 같이 실행하면 다음과 같은 결과를 얻을 수 있다.

Listing 2.7.13
```
updateUser(100, "Kotlin", "Nagoya")
```
-> 실행 결과
```
User(id=100, name=Kotlin, address=Nagoya)
```

이와 같이, data 클래스와 같은 프로퍼티을 가지는 오브젝트에 대해서 변경을 더해 반환하는, 라고 하는 처리를 쓸 때에 도움이 됩니다. 또한 with 와 run 과 마찬가지로 this 를 생략하여 기술하는 것도 가능합니다 ( 목록 2.7.14 ).

Listing 2.7.14
```
fun updateUser(id: Int, newName: String, newAddress: String) {
    val user = getUser(id).apply {
        name = newName
        address = newAddress
    }
    println(user)
}
```

그러나 이 경우에는 주의가 필요합니다. 만약 리스트 2.7.15 와 같이, 프로퍼티와 같은 이름의 로컬 변수가 정의되었을 경우, 리시버 오브젝트에의 값의 변경이 없어져 버립니다.

Listing 2.7.15
```
fun updateUser(id: Int, newName: String, newAddress: String) {
    var name = ""
    val user = getUser(id).apply {
        name = newName
        address = newAddress
    }
    println(user)
}
```

여기에서는 apply 안에서 액세스하고 있는 name 이 로컬 변수로 정의되고 있는 name 을 취급해 버려, 값의 대입도 그쪽에 되어 버리기 때문입니다. Listing 2.7.16 과 같이 실행하면 다음과 같은 결과를 얻을 수 있다.

Listing 2.7.16
```
updateUser(100, "Kotlin", "Nagoya")
```
-> 실행 결과
```
User(id=100, name=Takehata, address=Nagoya)
```

address 의 값은 변경되었지만 name 은 getUser 함수로 초기화된 값으로 유지됩니다. 반드시 this 를 붙이면 발생하지 않습니다만, 이 위험성이 있기 때문에, 이러한 처리에는 다음에 소개하는 also 를 사용하는 일도 많습니다.

also──오브젝트에 변경을 가해 돌려준다(다른 이름으로 취급한다)
also 는 apply 와 마찬가지로 수신기 객체 자체를 반환하는 범위 함수이지만 let 과 마찬가지로 이름을 지정하고 처리 할 수 ​​있습니다. apply 로 기술하고 있던 리스트 2.7.14 를, also 를 사용해 재기록하면 리스트 2.7.17 과 같이 됩니다.

Listing 2.7.17
```
fun updateUser(id: Int, newName: String, newAddress: String) {
    val user = getUser(id).also { u ->
        u.name = newName
        u.address = newAddress
    }
    println(user)
}
```

리시버 객체인 User 클래스의 인스턴스를 이름 u 로 지정합니다. 또한 also 도 이름을 생략하여 목록 2.7.18 과 같이 it 이라는 암시 적 이름으로 처리 할 수 ​​있습니다.

Listing 2.7.18
```
fun updateUser(id: Int, newName: String, newAddress: String) {
    val user = getUser(id).also {
        it.name = newName
        it.address = newAddress
    }
    println(user)
}
```

apply 에서의 this 와 달리 생략은 할 수 없기 때문에, 확실하게 리시버 오브젝트내의 프로퍼티을 취급할 수 있어, 전술한 같은 이름의 로컬 변수가 정의되었을 경우의 문제도 발생하지 않습니다.

# 8. 연산자 오버로드로 클래스에 대한 연산자 처리를 구현할 수 있습니다.

Kotlin에서는 연산자 오버로드라는 기능에 의해 연산자 ( + , - , <> 등)를 사용했을 때의 처리를 구현할 수 있으며, 독자적으로 작성한 클래스에 대해서도 연산자를 사용한 처리를 할 수 있습니다. Listing 2.8.1 을 보라. value 라고 하는 Int형의 값을 보관 유지한 클래스에 대해서, + 연산자의 처리를 구현하고 있습니다.

Listing 2.8.1
```
data class Num(val value: Int) {
    operator fun plus(num: Num): Num {
        return Num(value + num.value)
    }
}
```

연산자 오버로드는 operator 라는 한정자를 붙여 연산자에 대응하는 이름, 인수로 함수를 기술하는 것으로 구현할 수 있습니다. + 연산자 오버로드는 plus 라는 자신과 동일한 유형의 값을 인수에 취하는 함수를 정의합니다. 여기에서는 인수로 받은 Num 의 value 와 자신의 value 를 더한 결과가 들어간, Num형의 객체를 반환하고 있습니다.

이 구현을 하는 것으로, 리스트 2.8.2 와 같은 호출이 가능하게 됩니다.

Listing 2.8.2
```
 val num = Num(5) + Num(1)
 println(num)
```
-> 실행 결과
```
Num(value=6)
```

Num 형의 오브젝트끼리를 + 로 더해 하는 것으로, value 의 property를 더한 Num 를 결과로서 받을 수가 있습니다. 다른 사칙 연산의 오버로드도 다음 함수를 구현하여 수행할 수 있습니다.

- `-` 빼기
- `\*` 몇배
- `/` 나누기

또한 사칙 연산뿐만 아니라 비교 연산자 등 다양한 연산자를 오버로드할 수 있습니다. Listing 2.8.3 에서는 compareTo 를 정의하고 <> 에 의한 대소 비교 처리를 구현한다. Listing 2.8.1 의 Num 클래스에 추가한다.

Listing 2.8.3
```
operator fun compareTo(num: Num): Int {
    return value.compareTo(num.value)
}
```

compareTo 는 비교에 사용되는 함수로, 자신 (여기에서는 value )보다 인수의 값 (여기에서는 num.value )이 큰 경우는 양의 정수, 작았을 경우는 부의 정수, 같은 경우는 0을 돌려줍니다. 합니다. + 때와 같이, Num 의 value 를 사용해 이 compareTo 의 처리를 호출하는 것으로, Num 클래스의 객체끼리의 비교를 실현하고 있습니다.

호출은 Listing 2.8.4 와 같다.

Listing 2.8.4
```
val greaterThan = Num(5) > Num(1)
val lessThan = Num(5) < Num(1)
println(greaterThan)
println(lessThan)
```
-> 실행 결과
```
true
false
```

Num 끼리 <> 를 사용해, value 의 값으로 비교한 결과가 돌아오고 있는 것을 알 수 있습니다. 또한 compareTo 의 구현에서 <= , >= 에서의 비교도 마찬가지로 할 수 있습니다.

## 속성의 getter, setter도 operator에 정의되어 있습니다.

연산자와는 조금 다릅니다만, 프로퍼티의 섹션으로 소개한 getter , setter 의 생략도 operator 수식자를 사용해 정의되고 있습니다. Listing 2.8.5 와 같다.

Listing 2.8.5
```
operator fun <V> KProperty0<V>.getValue(
    thisRef: Any?,
    property: KProperty<*>
): V
```

operator 한정자를 사용하여 KProperty0<V> 의 확장 함수로 getValue 를 정의합니다. KProperty0 은 속성을 나타내는 인터페이스라고 생각합니다. <V> 부분은 타입 파라미터라고 하며 클래스에서 사용하는 타입을 호출측에서 파라미터로 지정할 수 있게 됩니다. 예를 들어 String 형의 프로퍼티를 정의했을 경우는 KProperty0<String> 이 되어, 그 확장 함수로서의 getValue 가, 프로퍼티의 getter 를 호출할 때에 사용되고 있습니다. 자세한 내용은 공식 문서 주 3 을 참조하십시오.

# 9. 대리자로 중복 처리를 위임할 수 있습니다.

Kotlin에서는 처리의 위양을 간단하게 기술할 수 있는, 대리자라고 하는 기능이 준비되어 있습니다.

## 수업 위임

우선 클래스의 위양에 대해 설명합니다. 예를 들어, Listing 2.9.1 과 같은 인터페이스와 구현 클래스가 있다고 가정한다.

Listing 2.9.1
```
interface CalculationExecutor {
    val message: String
    fun calc(num1: Int, num2: Int): Int
    fun printStartMessage()
}

class CommonCalculationExecutor(override val message: String = "calc") : CalculationExecutor {
    override fun calc(num1: Int, num2: Int): Int {
        throw IllegalStateException("Not implements calc")
    }

    override fun printStartMessage() {
        println("start $message")
    }
}
```

CommonCalculationExecutor 클래스는, CalculationExecutor 의 구현 클래스의 공통 처리를 보관 유지하고 있습니다. 다른 구현 클래스로 Listing 2.9.2 가 있다고 가정한다.

Listing 2.9.2
```
class AddCalculationExecutor(private val calculationExecutor: CalculationExecutor) : CalculationExecutor {
    override val message: String
        get() = calculationExecutor.message

    override fun calc(num1: Int, num2: Int): Int {
        return num1 + num2
    }

    override fun printStartMessage() {
        calculationExecutor.printStartMessage()
    }
}
```

이 클래스에서는, 다른 CalculationExecutor 의 구현 클래스를 constructor 으로 받아들여, printStartMessage 의 구현에서는 받은 calculationExecutor 의 printStartMessage 를 호출하고 있을 뿐입니다. 또, message property에 대해서도, 오버라이드(override) 해 CalculationExecutor 의 message 를 호출하고 있을 뿐입니다. 이것은 message property와 printStartMessage 함수의 구현을 constructor 으로 받은 클래스에 「위양하고 있다」라고 하는 것이 됩니다.

호출 방법은 Listing 2.9.3 과 같다.

Listing 2.9.3
```
val executor = AddCalculationExecutor(CommonCalculationExecutor())
executor.printStartMessage()
println(executor.calc(8, 11))
```
-> 실행 결과
```
start calc
19
```

여기에서는 공통 처리를 가지고 있는 CommonCalculationExecutor 를 생성자에 건네주는 것으로, message property와 printStartMessage 함수가 공통 처리의 구현을 호출하는 형태를 실현하고 있습니다. 하지만 같은 이름의 속성과 함수를 호출하는 것만 하는 처리를 작성하는 것은 기술량도 많아, 중복이 됩니다. 따라서 Kotlin에서는 대리자의 기능을 사용하여 목록 2.9.4 와 같이 작성할 수 있습니다.

Listing 2.9.4
```
class AddCalculationExecutorDelegate(private val calculationExecutor: CalculationExecutor) : CalculationExecutor by calculationExecutor {
    override fun calc(num1: Int, num2: Int): Int {
        return num1 + num2
    }
}
```

AddCalculationExecutorDelegate 클래스와 같이, 인터페이스의 형태의 뒤에 by 위양처 라고 쓰는 것으로 위양처의 오브젝트가 가지는 같은 이름의 프로퍼티, 함수에 처리가 위양 되게 됩니다. 그 때문에, 이 클래스로 처리를 구현할 필요가 있는 calc 함수만 오버라이드(override) 해, message 프롭퍼티와 printStartMessage 함수는 아무것도 쓰지 않아도 calculationExecutor 의 처리를 호출해 주게 되어, 기술량을 상당히 줄일 수 있습니다 했다. 생성자는 CalculationExecutor 인터페이스의 형태로 정의하고 있습니다만, 호출할 때는 양도하고 싶은 구현 클래스(여기에서는 CommonCalculationExecutor 클래스)의 인스턴스를 건네줍니다. Listing 2.9.5 와 같이 실행하면 Listing 2.9.3 과 유사한 결과를 얻을 수 있다.

Listing 2.9.5
```
val executorDelegate = AddCalculationExecutorDelegate(CommonCalculationExecutor())
executorDelegate.printStartMessage()
println(executorDelegate.calc(8, 11))
```
-> 실행 결과
```
start calc
19
```

## 위양 속성

다음으로 위양 속성에 대해 설명합니다. 위양 프로퍼티는 이름대로 프로퍼티의 구현을 외부에 잘라 위임하는 기능입니다. 먼저 Listing 2.9.6 을 살펴보자.

Listing 2.9.6
```
class Person {
    var name: String = ""
        get() {
            println("nameを取得します")
            return field
        }
        set(value) {
            println("nameを更新します")
            field = value
        }

    var address: String = ""
        get() {
            println("addressを取得します")
            return field
        }
        set(value) {
            println("addressを更新します")
            field = value
        }
}
```

이 Person 클래스에서는, name , address 프로퍼티의 getter , setter 각각의 처리로 런타임시 메세지를 출력하고 있습니다. 호출하는 구현은 Listing 2.9.7 과 같다.

Listing 2.9.7
```
val person = Person()
person.name = "Takehata"
person.address = "Tokyo"
println(person.name)
println(person.address)
```
-> 실행 결과
```
nameを更新します
addressを更新します
nameを取得します
Takehata
addressを取得します
Tokyo
```

그러나, 이러한 처리를 복수의 프로퍼티 마다 기술하고 있는 것은 중복이며, 다른 클래스에서도 같은 처리를 넣으려고 하면 한층 더 기술량이 늘어나 버립니다. 거기서, 이 메세지를 출력해 get , set 하는 처리를 외부에 잘라, 그쪽에 위양시키는 형태를 취할 수가 있습니다. 먼저 Listing 2.9.8 의 클래스를 작성한다.

Listing 2.9.8
```
class DelegateWithMessage<T> {
    private var value: T? = null

    operator fun getValue(thisRef: Any?, property: KProperty<*>): T {
        println("${property.name}を取得します")
        return value!!
    }
    operator fun setValue(thisRef: Any?, property: KProperty<*>, value: T) {
        println("${property.name}を更新します")
        this.value = value
    }
}
```

DelegateWithMessage 클래스는, 전술의 메세지를 출력하는 처리를 가지는 위양처의 클래스입니다. 연산자 오버로드 섹션의 끝에 쓴 것처럼 getter 와 setter 함수는 operator 에 정의되어 있습니다. 그 때문에 위양처가 되는 클래스에도 getValue , setValue 에 operator 수식자를 붙여 정의할 필요가 있습니다.

KProperty<*> 형의 property 는, 위양원의 프로퍼티의 정보를 가지고 있어, 여기에서는 프로퍼티명을 취득하기 위해서 name 를 사용하고 있습니다. setValue 에만 인수로 가지고 있는 value 는, setter 로 설정되는 인수의 값입니다. 또, 이 예에서는 사용하고 있지 않습니다만, thisRef 에는 위양원의 오브젝트 (여기에서는 리스트 DelegatePerson 형의 오브젝트)에의 참조가 들어갑니다.

그리고 Listing 2.9.9 가 DelegateWithMessage 에 위임되는 예입니다.

Listing 2.9.9
```
class DelegatePerson {
    var name: String by DelegateWithMessage()
    var address: String by DelegateWithMessage()
}
```

클래스의 이양과 같이, 프로퍼티 정의의 뒤에 by 위양처 라고 기술하는 것으로 구현할 수 있습니다. 실행 결과는 Listing 2.9.7 과 유사하다 ( Listing 2.9.10 ).

Listing 2.9.10
```
val delegatePerson = DelegatePerson()
delegatePerson.name = "Takehata"
delegatePerson.address = "Tokyo"
println(delegatePerson.name)
println(delegatePerson.address)
```
-> 실행 결과
```
nameを更新します
addressを更新します
nameを取得します
Takehata
addressを取得します
Tokyo
```

덧붙여서 이 예에서는 어느 형태에도 대응할 수 있도록, 위양처의 클래스에 형태 파라미터를 사용하고 있습니다. String 형의 name 와 address 로부터 이양해 호출하는 것으로, String 가 형태 파라미터로서 사용되고 있습니다.

또, 형태 파라미터를 사용하지 않고 리스트 2.9.11 과 같이 String형 전제의 클래스를 만들 수도 있습니다.

Listing 2.9.11
```
class DelegateWithMessageString {
    private var value: String? = null

    operator fun getValue(thisRef: Any?, property: KProperty<*>): String {
        println("${property.name}を取得します")
        return value!!
    }
    operator fun setValue(thisRef: Any?, property: KProperty<*>, value: String) {
        println("${property.name}を更新します")
        this.value = value
    }
}
```

# 10 충실한 컬렉션 라이브러리로 컬렉션에 대한 처리를 간단하게 할 수 있다

Kotlin은 List, Map, Set 등의 컬렉션을 다루는 라이브러리가 매우 충실합니다. 상당한 수가 있기 때문에 일부로 짜내게 됩니다만, 소개합니다. 여기에서 소개하는 것 이외의 컬렉션 라이브러리에 대해서도, 흥미가 있는 분은 공식 페이지 주4 를 읽어 보세요.

또한 이 절에서는 Listing 2.10.1 의 데이터 클래스를 사용한다. 각 샘플 코드 안에서는 이 클래스의 설명은 쓰여져 있지 않으므로, 인식 위에서 봐 주세요.

Listing 2.10.1
```
data class User(val id: Int, val teamId: Int, val name: String)
```

## forEach - 컬렉션의 요소를 순서대로 처리

우선 forEach 입니다. 다른 언어에서도 자주 있는 기능입니다만, 컬렉션의 선두로부터 차례로 요소를 꺼내 취급할 수 있습니다. Listing 2.10.2 와 같이 작성한다.

Listing 2.10.2
```
val list = listOf(1, 2, 3)
list.forEach { num -> println(num) }
```
-> 실행 결과
```
1
2
3
```

콜렉션 오브젝트 .forEach 뒤에, 꺼낸 요소를 넣는 변수명, 실행하고 싶은 처리를 기술합니다. 여기서는 꺼낸 요소를 num 이라는 변수로 취급하여 출력하고 있습니다. 위의 범위 함수와 마찬가지로 컬렉션 라이브러리에서도 이름을 생략하고 it 이라는 암시 적 이름으로 처리 할 수 ​​있습니다 ( 목록 2.10.3 ).

Listing 2.10.3
```
val list = listOf(1, 2, 3)
list.forEach { println(it) }
```

덧붙여 이 뒤 나오는 컬렉션 라이브러리에 대해서는, 일부를 제외해 이 it 를 사용하는 형태로 소개합니다만, 이름을 붙여 취급하고 싶은 경우는 기본적으로는 forEach 와 같은 형식으로 붙일 수가 있습니다.

## map - 요소를 다른 형태로 변환한 List를 생성한다

map 은 컬렉션의 요소를 다른 형태로 변환한 List를 생성할 수 있습니다. 예를 들면 Listing 2.10.4 와 같이 작성한다.

Listing 2.10.4
```
val list = listOf(1, 2, 3)
val idList = list.map { it * 10 }
idList.forEach { println(it) }
```
-> 실행 결과
```
10
20
30
```

이 예에서는, 수치의 List에 대해서 map 으로 각각의 값을 10배한 값을 가지는 List를 생성하고 있습니다. map 도 forEach 와 마찬가지로 컬렉션의 요소를 처음부터 하나씩 꺼내 it 로 취급하고 있습니다. 그리고 변환 후의 요소의 값을 만드는 처리(여기서는 값을 10배한다)를 쓰고 있습니다.

또한 다른 형식의 List로 변환할 수도 있습니다. Listing 2.10.5 를 보라.

Listing 2.10.5
```
val list = listOf(User(1, 100, "Takehata"), User(2, 200, "Kotlin"))
val idList = list.map { it.id }
idList.forEach { println(it) }
```
-> 실행 결과
```
1
2
```

User 클래스의 객체를 가진 List에 대해 map 을 사용하여 User 의 id 목록으로 변환하고 있습니다. 이와 같이 데이터 클래스의 일부의 프로퍼티만을 가지는 List를 생성하거나, 숫자 캐릭터 라인의 List를 수치의 List로 변환하는 등, 여러가지 사용법이 가능합니다.

## filter - 조건에 해당하는 요소를 추출한다.

filter 는 이름대로, 컬렉션내에서 임의의 조건에 해당하는 요소만 필터링한 List 를 생성합니다. Listing 2.10.6 을 보라.

Listing 2.10.6
```
val list = listOf(User(1, 100, "Takehata"), User(2, 200, "Kotlin"), User(3, 100, "Java"))
val filteredList = list.filter { it.teamId == 100 }
filteredList.forEach { println(it) }
```
-> 실행 결과
```
User(id=1, teamId=100, name=Takehata)
User(id=3, teamId=100, name=Java)
```

여기에서는 User 클래스의 List에서 teamId 가 100인 요소만 추출한 List를 생성하고 있습니다. 람다 식은 요소를 사용하여 추출하고자 하는 조건식이 되는 처리를 기술하고, true가 반환된 요소만 추출됩니다.

## first, last - 조건에 해당하는 선두, 말미의 요소를 추출한다

first 는, 컬렉션중에서 선두의 요소, 혹은 지정한 조건에 해당하는 안에서 선두의 요소를 취득합니다. 마찬가지로 last 는, 컬렉션중에서 말미의 요소, 혹은 지정한 조건에 해당하는 안에서 말미의 요소를 취득합니다. 먼저 Listing 2.10.7 을 보라.

Listing 2.10.7
```
val list = listOf(User(1, 100, "Takehata"), User(2, 200, "Kotlin"), User(3, 100, "Java"), User(4, 200, "Groovy"))
println(list.first())
println(list.last())
```
-> 실행 결과
```
User(id=1, teamId=100, name=Takehata)
User(id=4, teamId=200, name=Groovy)
```

User 의 List에 대해 first , last 를 인수 없이 실행하면, 각각 리스트내의 선두, 말미의 요소를 꺼내 출력됩니다. 인수에 조건식을 쓴 람다 식을 건네주는 것으로, 해당하는 요소중에서 선두, 말미의 요소를 취득할 수도 있습니다. Listing 2.10.8 에서는 teamId 가 200에 해당하는 가운데 선두 요소, 100에 해당하는 가운데 후미 요소를 얻는다.

Listing 2.10.8
```
println(list.first { it.teamId == 200 })
println(list.last { it.teamId == 100 })
```
-> 실행 결과
```
User(id=2, teamId=200, name=Kotlin)
User(id=3, teamId=100, name=Java)
```

람다 식을 작성하는 방법은 filter 와 비슷하며 표현식이 true를 반환하는 요소 중 첫 번째와 끝 부분을 가져옵니다.

## firstOrNull, lastOrNull - 조건에 해당하는 선두, 말미의 요소를 추출한다(해당되지 않는 경우는 null를 돌려준다)

firstOrNull , lastOrNull 은 first , last 와 같이 조건식에 해당하는 가운데 선두, 말미의 요소를 취득합니다만, 이쪽은 해당하는 요소가 없었을 경우에 null 를 반환합니다. Listing 2.10.9 를 보라.

Listing 2.10.9
```
val list = listOf(User(1, 100, "Takehata"), User(2, 200, "Kotlin"), User(3, 100, "Java"), User(4, 200, "Groovy"))
println(list.firstOrNull { it.teamId == 200 })
println(list.lastOrNull { it.teamId == 100 })
println(list.firstOrNull { it.teamId == 1000 })
println(list.lastOrNull { it.teamId == 1000 })
```
-> 실행 결과
```
User(id=2, teamId=200, name=Kotlin)
User(id=3, teamId=100, name=Java)
null
null
```

teamId == 1000 에 해당하는 요소가 없으므로 각각 null을 반환합니다.

## distinct - 중복을 제거한 List를 생성한다

distinct 는 컬렉션에 대해 중복을 제거한 List를 생성합니다. Listing 2.10.10 을 보라.

Listing 2.10.10
```
val list = listOf(1, 1, 2, 3, 4, 4, 5)
val distinctList = list.distinct()
distinctList.forEach { println(it) }
```
-> 실행 결과
```
1
2
3
4
5
```

distinctList 는 2개씩 요소를 가지고 있던 1, 4의 중복이 배제된 List가 되어 있습니다.

## associateBy, associateWith - 컬렉션에서 Map 생성

associateBy 는 컬렉션에 임의의 값을 key로, 컬렉션의 요소를 value로 한 Map을 생성할 수 있습니다. Listing 2.10.11 을 보라.

Listing 2.10.11
```
val list = listOf(User(1, 100, "Takehata"), User(2, 200, "Kotlin"), User(3, 100, "Java"))
val map = list.associateBy { it.id }
println(map)
// map의 각 요소를 id를 키에 취득해 출력
list.forEach { println(map[it.id]) }
```
-> 실행 결과
```
{1=User(id=1, teamId=100, name=Takehata), 2=User(id=2, teamId=200, name=Kotlin), 3=User(id=3, teamId=100, name=Java)}
User(id=1, teamId=100, name=Takehata)
User(id=2, teamId=200, name=Kotlin)
User(id=3, teamId=100, name=Java)
```

람다 식 중에는 key로 하고 싶은 값을 생성하는 처리를 기술합니다. 여기에서는 User 클래스의 List에 대해 id 를 key, User 객체를 value로 한 Map을 생성하기 때문에 id 를 반환하는 처리를 기술하고 있습니다. key에 대응하는 value는, 그 요소 자신( it 로 액세스 하고 있는 객체)이 됩니다. id 의 형태는 Int이므로, 이 처리의 변수 map 의 형태는 Map<Int, User> 가 됩니다.

associateWith 는 associateBy 와 비슷하며 컬렉션에 요소를 key로, 임의의 값을 value로 한 Map을 생성할 수 있습니다. Listing 2.10.12 를 보라.

Listing 2.10.12
```
val list = listOf("Takehata", "Kotlin", "Java")
val map = list.associateWith { it.length }
println(map)
// mapの各要素を文字列をキーに取得し出力
list.forEach { println(map[it]) }
```
-> 실행 결과
```
{Takehata=8, Kotlin=6, Java=4}
8
6
4
```

람다 식 중에는 value로 하고 싶은 값을 생성하는 처리를 기술합니다. 여기에서는 캐릭터 라인의 List에 대해서, 그 캐릭터 라인 자신을 key, length 로 취득한 캐릭터 라인 길이의 수치를 value로 한 Map를 생성하기 위해, length 의 값을 취득하는 처리를 기술하고 있습니다. 이 처리의 변수 map 의 형태는 Map<String, Int> 가 됩니다.

## groupBy - key 마다 요소를 정리한 Map 생성

groupBy 는 동일한 key마다 정리한 요소의 List를 value로 한 Map을 생성할 수 있습니다. Listing 2.10.13 을 보라.

Listing 2.10.13
```
val list = listOf(User(1, 100, "Takehata"), User(2, 200, "Kotlin"), User(3, 100, "Java"), User(4, 200, "Groovy"))
val map = list.groupBy { it.teamId }
println(map)
println(map[100])
println(map[200])
```
-> 실행 결과
```
{100=[User(id=1, teamId=100, name=Takehata), User(id=3, teamId=100, name=Java)], 200=[User(id=2, teamId=200, name=Kotlin), User(id=4, teamId=200, name=Groovy)]}
[User(id=1, teamId=100, name=Takehata), User(id=3, teamId=100, name=Java)]
[User(id=2, teamId=200, name=Kotlin), User(id=4, teamId=200, name=Groovy)]
```

associateBy 와 마찬가지로, key로 하고 싶은 값을 취득하는 처리를 람다 식에 기술합니다. 그리고 groupBy 는 같은 key가 되는 요소를 정리한 List가 value에 들어갑니다. 여기에서는 teamId 를 key로 하고 있기 때문에, 100, 200이라는 teamId 각각에 해당하는 요소의 List가 value가 되고 있습니다. 변수 map 의 형태는 Map<Int, List<User>> 가 됩니다.

## count - 조건에 해당하는 요소의 건수를 취득한다

count 는 조건을 지정하고 해당 요소의 수를 검색할 수 있습니다. Listing 2.10.14 를 보라.

Listing 2.10.14
```
val list = listOf(1, 2, 3, 4, 5)
val oddNumberCount = list.count { it % 2 == 1 }
println(oddNumberCount)
```
-> 실행 결과
```
3
```

람다 식에서 요소가 홀수인 경우 true가 되는 조건식을 지정합니다. 조건식을 쓰는 방법은 위의 filter 와 같으며 filter 에서 생성한 List의 요소 수를 반환해주는 것과 같은 결과가 됩니다.

## chunked - 지정된 요소수마다 분할한 List를 생성한다

chunked 는 지정된 요소수마다 분할한 List를 요소로 한 List를 생성할 수 있습니다. Listing 2.10.15 를 보라.

Listing 2.10.15
```
val list = listOf("Takehata", "Kotlin", "Java", "Groovy", "Scala")
val chunkedList = list.chunked(2)
println(chunkedList)
chunkedList.forEach { println(it) }
```
-> 실행 결과
```
[[Takehata, Kotlin], [Java, Groovy], [Scala]]
[Takehata, Kotlin]
[Java, Groovy]
[Scala]
```

5개의 요소를 가지는 List에 대해서, 2라고 하는 수치를 파라미터로서 chunked 를 실행합니다. 결과의 생성된 List를 출력하면, 원의 List의 요소를 2개씩 넣은 List를 요소로 한 List가 되어 있는 것을 알 수 있습니다. 끝의 요소는 숫자가 충족되지 않기 때문에 하나의 요소의 목록이됩니다.

이런 식으로 컬렉션을 요소 수별 목록으로 나누고 싶을 때 사용할 수 있습니다.

## reduce - 요소 컨벌루션

reduce 는 컬렉션의 요소의 "컨벌루션"이라고 불리는 처리를 실현합니다. 컨벌루션은 간단히 말하면, 어느 처리를 요소의 값에 누적적으로 적용해 가고, 하나의 값으로 정리하는 것입니다. 예를 들어 수치의 List에 대해, 모든 요소의 값을 쌓아 가고, 합산한 값으로 하는 것입니다. Listing 2.10.16 을 보라.

Listing 2.10.16
```
val list = listOf(1, 2, 3, 4, 5)
val result = list.reduce { sum, value ->
    println("$sum + $value")
    sum + value
}
println(result)
```
-> 실행 결과
```
1 + 2
3 + 3
6 + 4
10 + 5
15
```

수치의 List에 대해서, reduce 로 차례로 처리해 값을 컨벌루고 있습니다. 람다 식에서 인수로 받아들이고 있는 sum , value (이름은 임의)의 값은 각각 다음의 의미가 됩니다.

- sum -- 현재까지 처리된 합산 결과 값
- value -- 순서로 꺼내고 있는 현재의 요소의 값

여기에서는 순서대로 요소의 값을 더해 가는 처리를 기술하고 있기 때문에, sum 에는 현시점에서의 합계치가 들어간 상태가 되어, 최종적으로 모든 값을 더한 합계치가 반환됩니다 . 람다 식 중에서 println 으로 계산식의 내용을 출력하고 있으므로, 그쪽을 보면 값의 변화를 알 수 있다고 생각합니다.

모든 요소의 값을 합산하는 등의 사용법이 가장 많다고 생각합니다만, 리스트 2.10.17 과 같이 곱셈으로 하기도 할 수 있습니다.

Listing 2.10.17
```
val list = listOf(1, 2, 3, 4, 5)
val result = list.reduce { sum, value -> sum * value }
println(result)
```
-> 실행 결과
```
120
```

또한 수치뿐만 아니라 Listing 2.10.18 과 같이 문자열을 결합하는 것도 가능하다.

Listing 2.10.18
```
val list = listOf("a", "b", "c", "d", "e")
val result = list.reduce { line, str -> line + str }
println(result)
```
-> 실행 결과
```
abcde
```

# 11 코루틴으로 비동기 처리를 구현할 수 있습니다.

코루틴은 Kotlin 1.3부터 공식적으로 도입된 비동기 처리를 구현하는 기능입니다. 특징으로서 「중단 가능하고 비블로킹인 비동기 처리」를 실현할 수 있는 것을 들 수 있어, 실행하고 있는 thread를 정지하는 일 없이 효율의 좋은 처리를 구현할 수 있습니다.

코루틴을 사용할 때는 1장에서 설명한 build.gradle.kts에 종속성을 추가해야 합니다. dependencies 블록에 Listing 2.11.1 의 한 줄을 추가한다.

Listing 2.11.1
```
implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.4.2")
```

## 코루틴의 기본

우선은 가장 기본적인 코루틴을 작성하는 방법입니다. Listing 2.11.2 를 보라.

Listing 2.11.2
```
GlobalScope.launch {
    delay(1000L)
    println("Naoto.")
}
println("My name is")
Thread.sleep(2000L)
```
-> 실행 결과
```
My name is
Naoto.
```

GlobalScope.launch 블록 내에서 작성된 처리는 비동기 처리의 일부가 됩니다. delay 는 인수로 전달한 시간(단위는 밀리초) 처리를 중단하는 함수로, 여기에서는 1초 중단한 뒤에 println 로 이름을 출력하고 있습니다. 실행하면 launch 뒤에 쓰여진 " My name is "가 먼저 출력되고 약 1 초 후에 " Naoto. "가 출력됩니다.

마지막으로 Thread.sleep 에서 2초의 대기를 넣고 있는 것은, thread의 종료를 막기 위해서입니다. 이 행을 벗으면 delay 로 중단하고 있는 동안에 「My name is」의 출력만 되어 thread가 종료해 버려, launch 내의 출력 처리가 되지 않고 끝나 버립니다.

## 코루틴 스코프, 코루틴 빌더

코루틴을 사용한 처리는 코루틴 범위 내에서 코루틴 빌더를 사용하여 구현해야 합니다. 코루틴 범위는 코루틴이 실행되는 가상 영역과 같아야 합니다. Listing 2.11.2 에서 GlobalScope 가 적용된다.

코루틴 빌더는 이름대로 코루틴을 구축하기 위한 것으로, launch 가 해당합니다. launch 를 비롯한 모든 코루틴 빌더는 CoroutineScope 라는 인터페이스의 확장 함수로 구현되며, 실행하려면 반드시 CoroutineScope 가 필요합니다. GlobalScope 도 CoroutineScope 인터페이스를 구현한 객체입니다.

## 코루틴 스코프 빌더

코루틴 스코프는 코루틴 스코프 빌더를 사용하여 빌드할 수도 있습니다. Listing 2.11.3 을 보라.

Listing 2.11.3
```
runBlocking {
    launch {
        delay(1000L)
        println("Naoto.")
    }
    println("My name is")
}
```
-> 실행 결과
```
My name is
Naoto.
```

runBlocking 이라는 코루틴 빌더에 해당하는 함수를 사용하여 코루틴 스코프를 구축하고 있습니다. 이 runBlocking 은 스코프내의 코루틴의 처리가 모두 끝날 때까지 종료하지 않게 thread를 블록 합니다. 따라서 Listing 2.11.2 에서 호출하고 있던 Thread.sleep 을 삭제하고 있지만, 코루틴의 처리에서 이름이 출력되고 나서 종료합니다.

## 일시 중단 함수

여기까지 소개해 온 샘플 코드내에서 delay 라고 하는 함수를 사용해 중단하는 처리를 구현하고 있었습니다만, 이러한 코루틴의 처리를 「중단할 수 있는 함수」를 서스펜드 함수라고 합니다. 이 일시 중단 함수는 코 루틴 또는 다른 일시 중단 함수에서만 호출 할 수 있습니다.

- 일시 중단 함수 정의

예를 들어 , Listing 2.11.3 의 launch 에서 구현 된 처리를 함수로 잘라내는 경우, Listing 2.11.4 와 같이 일반 함수에서 delay 를 호출하면 컴파일 오류가 발생합니다.

Listing 2.11.4
```
fun printName() {
    delay(1000L) // コンパイルエラー
    println("Naoto.")
}
```
-> 컴파일 오류
```
Suspend function 'delay' should be called only from a coroutine or another suspend function
```

따라서 일시 중단 함수로 정의해야합니다. 일시 중단 함수를 구현하는 것은 간단하며 목록 2.11.5 와 같이 suspend 라는 한정자를 사용하여 정의합니다.

Listing 2.11.5
```
suspend fun printName() {
    delay(1000L)
    println("Naoto.")
}
```

그리고 이 printName 함수를 코루틴에서 호출하면 Listing 2.11.6 과 같다.

Listing 2.11.6
```
runBlocking {
    launch { printName() }
    println("My name is")
}
```
-> 실행 결과
```
My name is
Naoto.
```

- 일시 중단 함수는 "중단 함수"가 아닙니다.

앞에서 언급했지만 일시 중단 함수는 "중단 할 수있는 함수"입니다. 일시 중단 함수에서도 중단 처리를 작성하지 않으면 중단이 발생하지 않습니다. 이 문서에서는 설명에서 생략하지만 suspendCoroutine 주 5 등의 처리를 중단하는 함수를 호출하여 호출하는 코루틴의 처리를 중단할 수 있습니다. 그건 그렇고,이 suspendCoroutine 도 일시 중단 함수로 정의됩니다.

## async로 병렬 처리 구현

또 하나, async 라는 코루틴 빌더의 함수를 소개합니다. Listing 2.11.7 을 보라.

Listing 2.11.7
```
runBlocking {
    val result = async {
        delay(2000L)
        var sum = 0
        for (i in 1..10) {
            sum += i
        }
        sum
    }
    println("계산중")
    println("sum=${result.await()}")
}
```
-> 실행 결과
```
계산중
sum=55
```

launch 와 마찬가지로 CoroutineScope 를 리시버로 한 리시버 첨부 람다를 인수에 취합니다. 쓰는 방법은 launch 와 비슷하지만 async 는 람다 식으로 작성된 처리 결과의 값을받을 수 있습니다. 여기에서는 2초의 delay 후, for문으로 1~10의 수치를 더해, 합계치(변수 sum 의 값)를 결과로서 돌려주고 있습니다.

그리고 결과의 대입된 result 라고 하는 변수에 대해서, await 라고 하는 함수를 호출하는 것으로 결과를 취득할 수 있습니다. 이 await 함수는 async 의 처리를 기다리고 종료하면 결과를 가져옵니다. 실행해 보면, 「계산중」이라고 출력된 뒤에 조금 기다리고 나서 계산 결과가 출력되는 것을 알 수 있다고 생각합니다.

이 특성을 사용하여 async 에서 병렬 처리를 구현할 수도 있습니다. Listing 2.11.8 을 보라.

Listing 2.11.8
```
runBlocking {
    val num1 = async {
        delay(2000L)
        1 + 2
    }
    val num2 = async {
        delay(1000L)
        3 + 4
    }
    println("sum=${num1.await() + num2.await()}")
}
```
-> 실행 결과
```
sum=10
```

2개의 async 로 각각 수치의 계산을 해, num1 , num2 라고 하는 변수에 결과를 대입하고 있습니다. 그리고 마지막으로 각각의 변수로부터 await 로 취득한 수치를 더한 결과를 출력하고 있습니다.

이때 num1 의 async 는 2초, num2 의 async 는 1초의 delay 를 넣고 있기 때문에 실행 시간에 차이가 나오므로, 양쪽 처리가 끝난 타이밍에서 마지막 계산, 출력 처리가 실행되고 있는 것 알아요.



참고 1  외부에서 보이지 않는 속성 값을 유지하는 필드입니다.

( 본문으로 돌아가기 )

주 2  스코프 함수를 실행하는 대상의 오브젝트를 리시버 오브젝트라고 합니다.

( 본문으로 돌아가기 )

注3   https://kotlinlang.org/api/latest/jvm/stdlib/kotlin/get-value.html

( 본문으로 돌아가기 )

注4   https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.collections/

( 본문으로 돌아가기 )

注5   https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.coroutines/suspend-coroutine.html

( 본문으로 돌아가기 )

