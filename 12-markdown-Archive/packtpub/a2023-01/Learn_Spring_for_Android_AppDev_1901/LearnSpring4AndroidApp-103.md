원본 링크: https://subscription.packtpub.com/book/application-development/9781789349252/2
Path:
packtpub/learnSpring4AndroidApp/103
Title:
103 Overview of Kotlin
Short Description:
Learn Spring for Android Application Development 코틀린 개요

마크다운 입력시 vi 커맨드 ; ^{=Ctrl+[ ; ^M=Ctrl+M
@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 앞뒤로 ` 붙이기 => i`^[/ ^[i`^[/rrqeEWQRQewreq^[
인용구 작성시, 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 다음과 같이 종류별 구분을 표시한다.
	https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
	blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

![Figure3.8-
](/learnspring4androidapp_img/
.png)

---------- cut line ----------


# Overview of Kotlin

Kotlin is the official Android programming language and is statically typed. It is fully interoperable with Java, meaning that any Kotlin user can use the Java framework and mix commands from both Kotlin and Java without any limitations. In this chapter, we will cover the basics of Kotlin and will look at how to set up the environment. We will also look at its flow structures, such as `if { ... } else { ... }` expressions and loops. In addition to this, we will look into object-oriented programming for Kotlin, and we will cover classes, interfaces, and objects. Functions will also be covered, along with parameters, constructors, and syntax.

This chapter will cover the following topics:

- Setting up the environment
- Build tools
- Basic syntax
- Object-oriented programming
- Functions
- Control flow
- Ranges
- String templates
- Null safety, reflection, and annotations

# Technical requirements

To run the code in this chapter, you will just need Android Studio and Git installed. This chapter won't require any additional installations.

You can find examples from this chapter on GitHub, at the following link: https://github.com/PacktPublishing/Learn-Spring-for-Android-Application-Development/tree/master/app/src/main/java/com/packt/learn_spring_for_android_application_development/chapter2.

# Introduction to Kotlin

The 3.0 version of Android Studio was released by Google, and it promoted Kotlin as a first class language for Android development. Kotlin is developed by JetBrains in the same way as the Intellij IDEA platform, which is the basis of Android Studio. This language was released in February 2016, it was in development for five years before it was released. It's easy to gradually convert the code base of a project from Java to Kotlin, and a developer that is familiar with Java can learn Kotlin in a few weeks. Kotlin became popular before its release, because this language is full of features and is designed to interoperate with Java. The following diagram shows how Kotlin and Java code are compiled to the same bytecode:

![Figure3.1-How code are compiled ](/learnspring4androidapp_img/figure3.1-how_code_are_compiled.png)

As you can see, part of our application can be written in Java and another part in Kotlin. The **kotlinc** compiler compiles Kotlin source code to the same bytecode as the **javac** compiler.

# Setting up the environment

To get started with Android development, you will need to download and install the **Java Development Kit (JDK)** from http://www.oracle.com/technetwork/java/javase/downloads/index.html. You will also need to download and install the Android Studio **Integrated Development Environment (IDE)**, from https://developer.android.com/studio/.

To create a new project, launch Android Studio and press **Start a new Android Studio project**. Then, you should type a project name and your unique application ID, as shown in the following screenshot:

![Figure3.2-To create a new project ](/learnspring4androidapp_img/figure3.2-to_create_a_new_project.png)

In the preceding screenshot, the **Application name** field is filled according to the name of this book, and the **Company domain** field is `packt.com` . Android Studio concatenates these two values and creates the **Package name** identifier that is equal to the application ID identifier. In our case, the application ID is as follows:

```
com.packt.learn_spring_for_android_application_development
```

# Build tools

Android Studio is an official IDE for Android development, and it is based on the Intellij IDEA platform and uses the Gradle build tool system. A typical project structure looks as follows:

![Figure3.3-A typical project structure ](/learnspring4androidapp_img/figure3.3-a_typical_project_structure.png)

The `build.gradle` file contains the project configuration and manages the library dependencies. To add a dependency to the Spring for Android extension, we should add the following lines:

```
repositories {
    maven {
        url 'https://repo.spring.io/libs-milestone'
    }
}

dependencies {
    //.......
    implementation 'org.springframework.android:spring-android-rest-template:2.0.0.M3'
}
```

# Basic syntax

Syntax is a significant part of the programming language, defining a set of rules that must be applied to combinations of symbols. Otherwise, a program can't be compiled, and will be considered incorrect.

This section will describe the basic syntax of Kotlin, covering the following topics:

- Defining packages
- Defining variables
- Defining functions
- Defining classes

# Defining packages

Packaging is a mechanism that allows us to group classes, interfaces, and sub-packages. In our case, a declaration of a package in a file may look as follows:

```
package com.packt.learn_spring_for_android_application_development
```

All citizens of the file belong to this package and must be located in the appropriate folder.

# Defining variables

In Kotlin, we can define a read-only variable using the `val` keyword, and we can use the `var` keyword for mutable variables. In Kotlin, a **variable** can be defined as a first class citizen, meaning that we don't have to create a class of a function to hold variables. Instead, we can declare them directly in a file.

The following example shows how to define read-only and mutable variables:

```
val readOnly = 3
var mutable = 3
```

# Defining functions

To define a function, we have to use the `fun` keyword; this also can be declared as a first class citizen. This means that a function can only be defined in a file. We will touch on functions in greater detail in the Functions section, but for now, let's look at a simple example that changes the value of the `mutable` variable:

```
fun changeMutable() {
    mutable = 4
}
```

In the previous snippet, we can see that the `changeMutable` function can be declared as a first class citizen in the same file as the `mutable` variable, or in any other place.

# Defining classes

To define a class, we have to use the `class` keyword. All of the classes in Kotlin are final by default, and if we want to extend a class, we should declare it with the `open` keyword. A class that holds the `readOnly` and `mutable` variables, as well as the `changeMutable` method, may look like this:

```
class Foo {
    val readOnly = 3
    var mutable = 3

    fun changeMutable() {
        mutable = 4
    }
}
```

It is worth mentioning that a function that is a class member is called a **method**. In this way, we can explicitly specify that a function belongs to a class.

# Object-oriented programming

**Object-oriented programming** is a model of programming language that is based on objects that can represent data. Kotlin supports object-oriented programming in the same way that Java does, but even more strictly. This is because Kotlin doesn't have primitive types and static members. Instead, it provides a `companion object` :

```
class Bar {
    companion object {
        const val NAME = "Igor"

        fun printName() = println(NAME)
    }
}
```

The `companion object` is an object that is created once, during class initialization. In Kotlin, we can refer to members of `companion object` in the same way as `static` in Java:

```
fun test() {
    Bar.NAME
    Bar.printName()
}
```

However, under the hood, the nested `Companion` class is created, and we actually use an instance of this class, as follows:

```
Bar.Companion.printName();
```

Moreover, Kotlin supports the following concepts, which make the type system stronger:

- Nullable types
- Read-only and mutable collections
- No raw type of collections

The last point means that we can't compile code, as shown in the following screenshot:

![Figure3.4-The last point means that ](/learnspring4androidapp_img/figure3.4-the_last_point_means_that.png)

This message means that we have to provide a generic to specify a certain type of this collection.

From the object-oriented programming viewpoint, Kotlin supports the same features as Java. These include encapsulation, inheritance, polymorphism, composition, and delegation. It even provides a language-level construction that helps to implement these concepts.

# Functions

To define a function in Kotlin, you have to use the `fun` keyword, as follows:

```
fun firstClass() {
    println("First class function")
}
```

The preceding snippet demonstrates that we can declare functions as first class citizens. We can also define functions as class members, as follows:

```
class A {
    fun classMember() {
        println("Class member")
    }
}
```

A `local` function is a function that is declared in another one, as follows:

```
fun outer() {
    fun local() {
        println("Local")
    }
    
    local()
}
```

In the preceding snippet, the `local` function is declared inside of the `outer` function. The `local` functions are only available in the scope of a function where they were declared. This approach can be useful if we want to avoid duplicate code inside of a function.

This section will cover the following topics:

- Functional programming
- Higher-order functions
- Lambdas

# Functional programming

Kotlin particularly supports a functional style that allows us to operate functions in the same way as variables. This approach brings many features to Kotlin, as well as new ways to describe the flow of a program more concisely.

This subsection will cover the following topics:

- Declarative and imperative styles
- Extension functions
- Collections in Kotlin

# Declarative and imperative styles

We used to use the imperative style of programming when writing object-oriented programming, but for functional programming, a more natural style is declarative. The declarative style assumes that our code describes what to do, instead of how to do it, as is usual with imperative programming.

The following example demonstrates how functional programming can be useful in certain cases. Let's imagine that we have a list of numbers, and we want to find the number that is greater than 4. In the imperative style, this may look as follows:

```
fun imperative() {
val numbers = listOf(1, 4, 6, 2, 9)
for (i in 0 until numbers.lastIndex) {
if (numbers[i] > 4) {
println(numbers)
        }
    }
}
```

As you can see, we have to use a lot of control flow statements to implement this simple logic. In the declarative style, it may look as follows:

```
fun declarative() {
    println(listOf(1, 4, 6, 2, 9).find { it > 4 })
}
```

The preceding snippet demonstrates the power of functional programming. This code looks concise and readable. The Kotlin standard library contains a lot of extension functions that extend the functionality of the list type.

# Extension functions

The extension functions feature of Kotlin doesn't relate to functional programming, but it's better to explain this concept before moving forward. This feature allows us to extend a class or type with a new functionality, without using inheritance or any software design patterns, such as decorators.

> In object-oriented programming, a decorator is a design pattern that allows us to add a behavior to an object dynamically, without affecting other objects from the same class.

In the following code snippet, the `extension` function is added to the functionality of the A class:

```
fun A.extension() {
    println("Extension")
}
```

As you can see, it's easy to use this feature. We just need to specify a class name and declare a function name after the dot. Now, we can invoke the extension function as usual:

```
fun testExtension() {
    A().extension()
}
```

# Collections in Kotlin

The `find` function that we've seen is contained in the `Collections.kt` file from the Kotlin standard library. This file contains a lot of extension functions that bring a functional approach to Kotlin and extend the functionality of Java's collection, in order to simplify work with them.

> A collections is a hierarchy of classes and interfaces that are used to store and manipulate a group of objects.

The most common functions from the `Collections.kt` file are as follows:

- `filter` : This returns a new list that contains elements that only matched a passed predicate
- `find` : This returns an element that matched a passed predicate
- `forEach` : This performs an approved action on each element
- `map` : This returns a new list, where each element was transformed according to the passed function

All of these are referred to as higher-order functions.

# Higher-order functions

A function is called **higher-order** if it can take or return another function. The following diagrams show the different cases of higher-order functions.

The first diagram demonstrates a case in which the `f` function takes the lambda and returns a simple object:

![Figure3.5-function takes the lambda ](/learnspring4androidapp_img/figure3.5-function_takes_the_lambda.png)

The second diagram demonstrates a case in which the f function takes an object and returns a function:

![Figure3.6-function takes an object ](/learnspring4androidapp_img/figure3.6-function_takes_an_object.png)

Finally, the third diagram demonstrates a case in which the f function takes and returns lambdas:

![Figure3.7-function takes and returns lambdas ](/learnspring4androidapp_img/figure3.7-function_takes_and_returns_lambdas.png)

Let's look at the implementation of the `firstOrNull` function, as follows:

```
public inline fun <T> Iterable<T>.firstOrNull(predicate: (T) -> Boolean): T? {
    for (element in this) if (predicate(element)) return element
    return null
}
```

The `firstOrNull` function is an extension that takes a lambda as a parameter and invokes it as the usual function—`predicate(element)` . This returns the first element that matches the `predicate` in a collection; it is `null` if there is no other element that meets a condition.

# Lambdas

A lambda is a function that is not declared. This is useful when we need to invoke an action, but we don't need to define a function for it, because we will use it only once, or only in one scope. A lambda is an expression, meaning that it returns a value. All of the functions in Kotlin are expressions, and even a scope of a function doesn't contain the `return` keyword; it returns a value that is evaluated at the end.

The following lambda expression returns an object of the `Unit` type, implicitly:

```
{x: Int -> println(x)}
```

A declaration of the `Unit` object looks as follows:

```
public object Unit {
    override fun toString() = "kotlin.Unit"
}
```

A reference to a lambda can be saved to a variable:

```
val predicate: (Int) -> Unit = { println(it) }
```

We can use this variable to invoke the saved lambda:

```
predicate(3)
```

# Control flow elements

In Kotlin, control flow elements are expressions. This is different from Java, in which they are statements. Statements just specify the flow of a program, and don't return any values. This section will cover the following control flow elements:

- The `if { ... } else { ... }` expression
- The `when { ... }` expression

# The if { ... } else { ... } expression

In Kotlin, the `if` control flow element can be used in the same way as it is used in Java. The following example demonstrates the use of `if` as a usual statement:

```
fun ifStatement() {
    val a = 4
    if (a < 5) {
        println(a)
    }
}
```

If you are using the `if { ... } else { ... }` control flow element as an expression, you have to declare the `else` block, as follows:

```
fun ifExpression() {
    val a = 5
    val b = 4
    val max = if (a > b) a else b
}
```

The preceding example shows that `if { ... } else { ... }` returns a value.

# The when { ... } expression

The `switch { ... }` control flow element is replaced by `when { ... }` . The when `{ ... }` element of Kotlin is much more flexible than the `switch { ... }` element in Java, because it can take a value of any type. A branch only has to contain a matched condition.

The following example demonstrates how to use `when { ... }` as a statement:

```
fun whenStatement() {
    val x = 1
    when (x) {
        1 -> println("1")
        2 -> println("2")
        else -> {
            println("else")
        }
    }
}
```

The preceding code snippet contains the `else` branch, which is optional for a case with a statement. The `else` branch is invoked if all other branches don't have a matching condition. The `else` branch is mandatory if you use `when { ... }` as an expression and the compiler can't be sure that all possible cases are covered. The following expression returns `Unit` :

```
fun whenExpression(x: Int) = when (x) {
    1 -> println("1")
    2 -> println("2")
    else -> {
        println(x)
    }
}
```

As you can see, expressions provide a much more concise way to write code. To be sure that your branches cover all of the possible cases, you can use enums or sealed classes.

> An enum is a special kind of class that is used to define a set of constants. A sealed class is a parent class that has a restricted hierarchy of subclasses. All of the subclasses can only be defined in the same file as a sealed class.

In Kotlin, enums work similarly to how they work in Java. Sealed classes can be used if we want to restrict a class hierarchy. This works in the following way:

- You should declare a class using the `sealed` keyword
- All inheritors of your sealed class must be declared in the same file as their parent

The following example demonstrates how this can be implemented:

```
sealed class Method
class POST: Method()
class GET: Method()
```

With the `when { ... }` expression, we can use classes of the `Method` type, in the following way:

```
fun handleRequest(method: Method): String = when(method) {
    is POST -> TODO("Handle POST")
    is GET -> TODO("Handle GET")
}
```

As you can see, using this approach, we don't have to use the `else` branch.

# Loops

A loop is a special statement that allows us to execute code repeatedly. Kotlin supports two types of loops, as follows:

- for
- while

# for loops

A `for` loop statement allows us to iterate anything that contains the `iterate()` method. In turn, this provides an instance that matches the iterator interface through the principle of duck typing.

> The duck typing principle means that an interface is implemented implicitly if all of the methods that it contains are implemented.

The `Iterator` interface looks as follows:

```
public interface Iterator<E> {
    
    boolean hasNext();

    E next();
}
```

If we want to provide the `iterator()` , `hasNext()` , and `next()` methods as class members, we have to declare them with the operator keyword. The following example demonstrates a case of this:

```
class Numbers(val numbers: Array<Int>) {

    private var currentIndex: Int = 0

    operator fun iterator(): Numbers = Numbers(numbers)

    operator fun hasNext(): Boolean = currentIndex < numbers.lastIndex

    operator fun next(): Int = numbers[currentIndex ++]
}
```

The `Numbers` class can be used as follows:

```
fun testForLoop() {
    val numbers = Numbers(arrayOf(1, 2, 3))
    for (item in numbers) {
        //......
    }
}
```

An implementation using extension functions is as follows:

```
class Numbers(val numbers: Array<Int>)

private var currentIndex = 0
operator fun Numbers.iterator(): Numbers {
    currentIndex = 0
    return this
}
operator fun Numbers.hasNext(): Boolean = currentIndex < numbers.lastIndex
operator fun Numbers.next(): Int = numbers[currentIndex ++]
```

As you can see, extension functions allow us to make preexisting classes iterable.

# while loops

The `while() { ... }` and `do { ... } while()` statements work in the same way that they work in Java. The `while` statement takes a condition, and `do` specifies a block of code that should be invoked while the condition is `true` . The following example demonstrates how `do { ... } while()` looks in Kotlin:

```
fun testWhileLoop() {
    val array = arrayOf(1, 2, 3)
    do {
        var index = 0
        println(array[index++])
    } while (index < array.lastIndex)
}
```

As you can see, the `do { ... } while` construction works in the same way that it does in other C-like languages.

# Ranges

Kotlin supports the concept of ranges, which represent sequences of comparable types. To create a range, we can use the `rangeTo` methods that are implemented in classes, such as `Int` , in the following way:

```
public operator fun rangeTo(other: Byte): LongRange = LongRange(this, other)

public operator fun rangeTo(other: Short): LongRange = LongRange(this, other)

public operator fun rangeTo(other: Int): LongRange = LongRange(this, other)

public operator fun rangeTo(other: Long): LongRange = LongRange(this, other)
```

So, we have two options for creating a range, as follows:

- Using the `rangeTo` method. This may look as follows—`1.rangeTo(100)` .
- Using the `..` operator. This may look as follows—`1..100` .

Ranges are extremely useful when we work with loops:

```
for (i in 0..100) {
    // .....
}
```

The `0..100` range is equal to the `1 <= i && i <= 100` statement.

If you want to exclude the last value, you can use the `until` function, in the following way:

```
0 until 100
```

We can also use the `step` function, as follows:

```
1..100 step 2
```

The preceding snippet represents a range like the following:

```
[1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, ... 99]
```

It's worth mentioning that ranges support a lot of `until` functions, such as `filter` or `map` :

```
(0..100)
        .filter { it > 50 }
        .map { it * 2 }
```

# String templates

Kotlin supports one more powerful feature—string templates. Strings can contain code expressions that can be executed, and their results concatenated to the string. The syntax of the string template assumes that we use the `$` symbol at the start of an expression. If the expression contains some evaluation, it has to be surrounded by curly braces.
The simplest use of string templates looks like the following:

```
var number = 1
val string = "number is $number" 
```

A more advanced example that contains an expression is as follows:

```
val name = "Igor"
val lengthOfName = "length is ${name.length}"
```

As you can see, the string templates feature allows us to write code in a more concise way than the usual concatenation or the `StringBuilder` class.

# Null safety, reflection, and annotations

Although we have already covered the most common topics that relate to a basic overview of Kotlin, there are a few more topics that have to be touched upon.

This section will introduce the following topics:

- Null safety
- Reflection
- Annotations

# Null safety

Kotlin supports a more strict type system when compared to Java, and divides all types into two groups, as follows:

- Nullable
- No-nullable

One of the most popular causes of an app crashing is the `NullPointerException` . This happens as a result of accessing a member of a `null` reference. Kotlin provides a mechanism that helps us to avoid this error by using a type system.

The following diagram shows what the class hierarchy looks like in Kotlin:

![Figure3.8-shows what the class hierarchy ](/learnspring4androidapp_img/figure3.8-shows_what_the_class_hierarchy.png)

In Kotlin, nullable types have the same names as no-nullable types, except with the `?` character at the end.

If we use a no-nullable variable, we can't assign `null` to it, and the following code can't be compiled:

```
var name = "Igor"
name = null
```

To be able to compile this code, we have to explicitly declare the `name` variable as nullable:

```
var name: String? = "Igor"
name = null
```

After doing this, we cannot compile the following code:

```
name.length
```

To access members of nullable types, we have to use the `?.` operator, like in the following example:

```
name?.length
```

One expression can contain the `?.` operator as many times as needed:

```
name?.length?.compareTo(4)
```

If a member in this chain is `null` , the next member can't be invoked.

To provide an alternative program flow, if `null` is encountered, we can use the Elvis operator ( `?:` ). This can be used in the following way:

```
name?.length?.compareTo(4) ?: { println("name is null") }()
```

The preceding snippet demonstrates that the Elvis operator can be used if we want invoke a block of code if an expression returns as `null` .

# Reflection

Reflection allows us to introspect code at runtime; this is implemented by a set of languages and standard library features. The Kotlin standard library contains the `kotlin.reflect` package that, in turn, contains classes that represent references to elements, such as classes, functions, or properties.

To obtain a reference to an element, we should use the `::` operator. The following example demonstrates how to obtain a reference to a class:

```
val reference: KClass<String> = String::class
```

As you can see, references to classes are represented by the `KClass` class.

References to functions can also be passed to high-order functions. The following example shows how this may look:

```
fun isOdd(number: Int): Boolean = number % 2 == 0
val odds = listOf(1, 2, 3, 4, 5).filter(::isOdd)
```

A reference to a property is represented by the `KProperty` class, and this can be obtained in the following way:

```
val referenceToOddsPreperty = ::odds
```

`KProperty` is a class that represents a property of a class, and it can be used to retrieve metadata, such as names or types.

# Annotations

Annotations are used to attach metadata to code. This is created using the `annotation` keyword:

```
public annotation class JvmStatic
```

In the most common cases, annotations are used by annotation processing tools to generate or modify code. Let's look at the following example:

```
class Example1 {
    companion object {
        fun companionClassMember() {}
    }
}
```

The Kotlin bytecode viewer shows the following code:

```
public final class Example1 {
   public static final Example1.Companion Companion = new Example1.Companion((DefaultConstructorMarker)null);

   public static final class Companion {
      public final void companionClassMember() {
      }

      private Companion() {
      }

      // $FF: synthetic method
      public Companion(DefaultConstructorMarker $constructor_marker) {
         this();
      }
   }
}
```

As you can see, the `Example1` class contains the nested `Companion` class that contains the `companionClassMember` method. We can mark the `companionClassMember` method when the `@JvmStatic` annotation and the decompiled code to Java code version looks as follows:

```
public final class Example1 {
   public static final Example1.Companion Companion = new Example1.Companion((DefaultConstructorMarker)null);

   @JvmStatic
   public static final void companionClassMember() {
      Companion.companionClassMember();
   }

   public static final class Companion {
      @JvmStatic
      public final void companionClassMember() {}

      private Companion() {}

      // $FF: synthetic method
      public Companion(DefaultConstructorMarker $constructor_marker) {
         this();
      }
   }
}
```

The preceding snippet contains the additional static `companionClassMember` function in the `Example1` class that invokes the method of the `Companion` class. Using the `@JvmStatic` annotation, we tell the compiler to generate an additional method that can be used from the Java side.

# Summary

In this chapter, we took a close look at the basic syntax of Kotlin. We also introduced and looked at examples of some features, such as lambdas, string templates, and ranges. Furthermore, you learned that control flow elements, such as `if { ... } else { ... }` and `when { ... }` , can be used as expressions that can make our code more concise and readable.

In the next chapter, we will take a look at an overview of the Spring framework.

# Questions

1. What is Kotlin?
1. How does Kotlin support object-oriented programming?
1. How does Kotlin support functional programming?
1. How do we define variables in Kotlin?
1. How do we define functions in Kotlin?

# Further reading

Kotlin Quick Start Guide (https://www.packtpub.com/application-development/kotlin-quick-start-guide) by Marko Devcic, published by Packt.
