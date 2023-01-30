원본 제목: Chapter 2: An Introduction to Dart
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/102
Title:
102 An Introduction to Dart
Short Description:
Flutter for Beginners Second Edition 다트 소개

![Figure 2.2 - Initial view of the DartPad tool ](/flutter4beginners2_img/figure_2.2_-_initial_view_of_the_dartpad_tool.jpg)
![Table_2.01_Literals ](/flutter4beginners2_img/table_2.01_literals.jpg)
- cut line


# Chapter 2: An Introduction to Dart
Flutter for Beginners Second Edition

The Dart language is at the core of the Flutter framework. A modern framework such as Flutter requires a high-level modern language so that it can provide the best experience to the developer, as well as make it possible to create awesome mobile applications. Understanding Dart is fundamental to working with Flutter; developers need to know the origins of the Dart language, how the community is working on it, its strengths, and why it is the chosen programming language for Flutter.

In this chapter, you will review the basics of the Dart language and identify resources that can help you on your Flutter journey. You will review Dart's built-in types and operators and how Dart works with object-oriented programming (OOP). By understanding what the Dart language has to offer, you will become comfortable experimenting with Dart yourself and expand your knowledge.

The following topics will be covered in this chapter:

- Getting started with Dart
- Variables and data types
- Control flows and looping
- Functions and methods

# Technical requirements

In this chapter, we will explore the Dart language. You can do this via DartPad, which will be explained later in the chapter, or within your chosen integrated development environment (IDE), as discussed in Chapter 1, An Introduction to Flutter.

Either option will allow you to experiment with your code. If you choose to use your IDE, then you will need to ensure your system has been configured correctly to run Dart programs. Please refer to Chapter 1, An Introduction to Flutter for details on how to ensure your system is ready to do this.

You can find the source code for this chapter on GitHub at the following link: https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/lib/chapter_02.

# Getting started with Dart

Dart aims to aggregate the benefits of most of the high-level languages with mature language features, including the following:

- Productive tooling: This includes tools to analyze code, IDE plugins, and big package ecosystems.
- Garbage collection: This manages or deals with memory deallocation (mainly memory occupied by objects that are no longer in use).
- Type annotations (optional): This is for those who want security and consistency to control all of the data in an application.
- Statically typed: Although type annotations are optional, Dart is type-safe and uses type inference to analyze types at runtime. This feature is important for finding bugs during code compilation.
- Portability: This is not only for the web (transpiled to JavaScript) but it can also be natively compiled to Advanced RISC Machines (ARM) and x86 code.

All Flutter development involves having intimate knowledge of the Dart language; your application code, plugin code, and management of dependencies all use the Dart language and its features. Having a strong base understanding of Dart will allow you to be more productive with Flutter and will enable you to enjoy Flutter development more. Let's take a look at the Dart language in more detail, starting with where Dart came from.

## The evolution of Dart

Unveiled in 2011, Dart has been evolving ever since. Dart saw its stable release in 2013, with major changes included in the release of Dart 2.0 toward the end of 2018, as outlined here:

- Initially focused on web development at its conception, with the main aim of replacing JavaScript, it is now focused on mobile development areas, as well as Flutter.
- It tried solving JavaScript's problems: JavaScript doesn't provide the robustness that many consolidated languages do, so Dart wanted to bring a mature successor to JavaScript.
- It offers the best performance and better tools for large-scale projects: Dart has modern and stable tooling provided by IDE plugins. It has been designed to get the best possible performance while keeping the feel of a dynamic language.
- It is molded to be robust and flexible: By keeping the type annotations optional and adding OOP features, Dart balances the two worlds of flexibility and robustness.

Dart is a great modern, cross-platform, general-purpose language that continually improves its features, making it more mature and flexible. That's why the Flutter framework team chose the Dart language to work with.

## How Dart works

To understand where the language's flexibility came from, we need to know how we can run Dart code. This is done in two ways, as outlined here:

- Dart virtual machines (VMs)
- JavaScript compilations

Have a look at the following diagram:

![Figure 2.1 - Alternative ways to run Dart applications ](/flutter4beginners2_img/figure_2.1_-_alternative_ways_to_run_dart_applications.jpg)

As you can see, at the root of the diagram is your Dart code. It's worth noting that your code and dependency choices are agnostic to the way you run your application; there are no changes required to your code to make different options available to you.

### Dart VM and JavaScript compilation

Dart code can be run in a Dart-capable environment. A Dart-capable environment provides essential features to an application, such as the following:

- Runtime systems
- Dart core libraries
- Garbage collectors

The execution of Dart code operates in two modes—Just-In-Time (JIT) compilation or Ahead-Of-Time (AOT) compilation. These are described in more detail here:

- A JIT compilation is where the source code is compiled as it is needed—just in time. The Dart VM loads and compiles the source code to native machine code on the fly. This approach is used to run code on the command line or during mobile application development to allow the use of features such as debugging and hot reload.
- An AOT compilation is where the Dart VM and your code are precompiled and the VM works more like a Dart runtime system, providing a garbage collector and various native methods from the Dart software development kit (SDK) to the application. This approach has huge performance benefits over JIT compilations, but other features such as debugging and hot reload are not available.Hot reloadDart contributes to Flutter's most famous feature, hot reload, which is based on the Dart JIT compiler. This allows developers to get very fast feedback on code changes, allowing them to iterate much quicker, leading to faster and higher-quality software development.

Before we start playing with Dart, let's understand a few fundamental aspects of the language.

## Introducing the structure of the Dart language

If you already know some programming languages inspired by the old C language or have some experience with JavaScript, much of the Dart syntax will be easy for you to understand. Dart provides most of the standard operators for manipulating variables; the built-in types are the most common ones found in high-level programming languages, and the control flows and functions are very similar to what you will have experienced elsewhere.

### Object orientation

As with most modern languages, Dart is designed to be object-oriented (OO). Briefly, OOP languages are based on the concept of objects that hold both data (called fields) and code (called methods). These objects are created from blueprints called classes that define the fields and methods an object will have.

Following OO principles ensures that Dart has the benefits of encapsulation, inheritance, composition, abstraction, and polymorphism. We will explore Dart classes in much more detail in Chapter 4, Dart Classes and Constructs, but suffice to say that if you have seen OO in other languages such as Java, then much of the Dart OO design will be very similar.

### Dart operators

In Dart, operators are nothing more than methods defined in classes with a special syntax.

So, when you use operators such as x == y, it is as though you are invoking the x.==(y) method to compare equality.

As you might have noted, we are invoking a method on x. For all data types, unlike languages such as Java that have primitives, x is always an instance of a class that has methods. This means that operators can be overridden so that you can write your own logic for them.

### Arithmetic operators

Dart comes with many typical operators that work like many languages; this includes the following:

- \+ for addition.
- \- for subtraction.
- \* for multiplication.
- / for division.
- ~/ for integer division. In Dart, any simple division with / results in a double value. To get only the integer part, you would need to make some kind of transformation (that is, typecast) in other programming languages; however, here, the integer division operator does this task.
- % for modulo operations (the remainder of integer division).
- -expression for negation (which reverses the sign of expression).

Some operators have different behavior depending on the left operand type; for example, the + operator can be used to sum variables of the num type, but also to concatenate strings. This is because the method they refer to is implemented differently in the different classes.

Dart also provides shortcut operators to combine an assignment to a variable after another operation. The arithmetic or assignment shortcut operators are +=, -=, *=, /=, and ~/=.

### Increment and decrement operators

The increment and decrement operators are also common operators and are implemented on numbers, as follows:

- ++var or var++ to increment the value of the variable var by 1
- --var or var-- to decrement the value of the variable var by 1

The Dart increment and decrement operators behave similarly to other languages. A good application of increment and decrement operators is for count operations on loops.

### Equality and relational operators

The equality Dart operators are described as follows:

- == checks whether operands are equal
- != checks whether operands are different

For relational tests, the following operators are used:

- \> checks whether the left operand is greater than the right one
- < checks whether the left operand is less than the right one
- \>= checks whether the left operand is greater than or equal to the right one
- <= checks whether the left operand is less than or equal to the right one

In Dart, unlike Java and many other languages, the == operator does not compare memory references but rather the content of the variable.

Also, unlike JavaScript, there is no === operator required because Dart type safety ensures that the == equality operator is only used on objects of the same type.

### Logical operators

Logical operators in Dart are operators applied to bool operands; they can be variables, expressions, or conditions. Additionally, they can be combined with complex expressions by combining the evaluated value of the expression. The provided logical operators are described here:

- !expression negates the result of an expression—that is, true to false and false to true.
- || applies a logical OR operation between two expressions.
- && applies a logical AND operation between two expressions.

Now we know the fundamentals of the Dart programming language, let's take a look at some real code!

## Hands-on with Dart

The way Flutter is designed is heavily influenced by the Dart language, so knowing this language is crucial for success in the framework. Let's start by writing some code to understand the basics of the syntax and the available tools for Dart development.

### DartPad

The easiest way to start coding is to use the DartPad tool, which you can access at the following link: https://dartpad.dartlang.org/.

This is a great online tool for learning and experimenting with Dart's language features. It supports Dart's core libraries, except for VM libraries such as dart:io.

This is what the tool looks like, although the code presented in the tool may be different:

![Figure 2.2 - Initial view of the DartPad tool ](/flutter4beginners2_img/figure_2.2_-_initial_view_of_the_dartpad_tool.jpg)

When you open DartPad, you are presented with an initial piece of code.

If it isn't already in the DartPad tool, replace the code in the tool with the following code so that you can run your first piece of Dart code:

```
void main() {
  for (int i = 0; i < 5; i++) {
    print('hello ${i + 1}');
  }
}
```

We will explore this preceding piece of code in the next section, so don't worry if it looks a little complicated. However, try running it in the DartPad tool by pressing the Run button, and you should see console output similar to this:

```
hello 1
hello 2
hello 3
hello 4
hello 5
```

### Running locally

If you choose to run this code locally on your machine, then save the contents to a Dart file and run it with a Dart tool in a terminal—for example, save it to a file named hello_world.dart and then run the dart hello_world.dart command. This will execute the main function of the Dart script.

Let's look at the code you have in DartPad in more detail.

### Hello world Dart style

The code you are presented with in DartPad looks similar to this:

```
void main() {
  for (int i = 0; i < 5; i++) {
    print('hello ${i + 1}');
  }
}
```

This code contains some basic language features that need highlighting. In this chapter, we will explore the fundamentals of the Dart language that will allow someone already experienced in basic programming to apply that knowledge to Dart.

If you feel you need a deeper introduction to the basics of programming, then the perfect complementary book is Learning Dart, by Dzenan Ridjanovic.

### Main function

As with most modern languages, Dart uses functions and methods as a way to break up code. A function or a method is a chunk of code that (optionally) receives some data, runs the code, and then (optionally) returns some data.

The function from the hello world example looks like this:

```
void main() {
  …
}
```

The first line has several important pieces of information, outlined as follows:

- The data type that is returned from the method is defined first. In this case, void denotes that the method does not return any data when it has completed execution. void is a keyword in the Dart language that can only be used in specific circumstances to denote the absence of data. We will look at data types in the next section.
- The name of the function comes next—in this case, main. The name is used by other pieces of code to reference this method, and, in this specific case, main is the function name that the Dart VM searches for when it first starts running code. Every Dart application must have an entry point top-level function so that the Dart VM knows where to start code execution. The main function serves this purpose.
- The empty parentheses are where a function defines the data it expects to receive. This main function does not receive any data, hence the empty parentheses. We will look at the way a function can define the expected data later in the chapter.
- Finally, a curly bracket at the end of the first line specifies where the function code starts, and the closing curly bracket several lines later specifies where the function code ends. Unlike with some languages such as Python, the indentation or layout of the code is irrelevant to how the code is executed.Function versus method.
- Functions and methods have identical syntax (the rules about how they are structured), and often the terms function and method are used interchangeably, so what is the difference? Specifically, a function exists outside of a class (we will look at classes later in the chapter). The main function is an example of this. Conversely, a method is tied to an instance of a class and has an implicit reference to the class instance via the this keyword.

So, you now know that the code is executed because the Dart VM searches for a main function, finds the one written above it, and then calls that function. We've also learned about the void data type. Let's take a look at the other data types available in Dart.

# Variables and data types

Variables are key to any programming language, holding application state so that the correct execution flow can be followed, displaying the correct information to the user, and interacting with other systems through defined data structures.

Unstructured data can be dangerous, though, and may lead to bugs and difficult-to-maintain code. Therefore, a rich set of data types is required in a modern programming language. Let's explore this area of the Dart language, starting with the basics of declaring a variable.

## Variable declaration

Variables store references to data and are key to decision making within your application. Variables have to be declared before they can be used.

A variable declaration follows many of the rules of similar programming languages, but due to type inference, Dart variable declaration can be looser.

The structure of a variable declaration is shown here:

```
type identifier = value;
```

type defines the data type that the variable can hold, such as a number or piece of text. If the variable can hold any type of data then it can be declared with the dynamic type. The type can simply be set to var if the Dart analyzer can infer the variable's type from the assigned value or later code. If the Dart analyzer is unable to infer the type, then the variable becomes the dynamic type.

identifier is a name you give to the variable that describes the data it is holding. There are rules defining what an identifier must be, and these are outlined here:

- Cannot be a keyword such as new or class
- Must contain alphabetical characters and numbers
- Cannot contain spaces and special characters except the underscore (_) and dollar ($) characters
- Cannot begin with a number

value is an initial value that the variable holds from a declaration.

Variables can receive new values at any point. The type is already known, so a change in variable value is simply achieved with the following code:

```
identifier = value;
```

Let's look at some examples of variable declarations, as follows:

```
var inferredString = "Hello"; // Type inferred as String
String explicitString = "World";
```

In these variable declarations, we show the following:

- An inferred declaration of inferredString where the type is inferred from the assigned value, the "hello" string
- A variable declaration where we use the explicit type of String for the explicitString variable

Both declaration approaches are acceptable because the types of both variables are unambiguous.

## Null safety

Dart has support for a variable to have no value, called null. The use of the null value has been restricted in the latest releases of Dart; previously, you could assign any variable a null value at declaration or any later point. Now, you need to declare that a variable can accept the null value by specifying this on the variable's type when the variable is declared.

You may see older code that allows null without the explicit type declaration, simply because the change is very recent. In previous releases, this code would have been acceptable:

```
int newNumber; // newNumber is initialized to null
print(newNumber); // Prints null
newNumber = 42; // Update the value of newNumber
print(newNumber); // Prints 42
```

In Dart 2.12.0 and later, this code would no longer be allowed, showing errors within your IDE. There are two options available to declare the nullability of a variable. Let's look at both options.

### ? declaration

To specify that a variable can be set to the null value, you can add a ? character to the type of the variable. Therefore, to fix the preceding code example, we only need to add one character and the errors will be removed, as illustrated in the following code snippet:

```
int? newNumber; // newNumber type allows nullability
print(newNumber); // Prints null
newNumber = 42; // Update the value of newNumber
print(newNumber); // Prints 42
```

If you didn't spot it, we added a ? character after the int type. Now, the newNumber variable can either take an int or a null value.

### Late variables

There are times when you know a variable will have a value set before that value is accessed, but the variable's value cannot be initialized immediately at variable declaration. An example of this in Flutter is where a variable is declared with no value, but immediately at widget initialization, it is given a value. If we were forced to do null checks every time we accessed the variable, our code would be harder to read and maintain.

To solve this problem, Dart has the late type modifier. This tells Dart that you are completely confident that at the point the variable's value is accessed, the variable will have already been set to a value.

Let's update the example to show that in action, as follows:

```
late int newNumber; // newNumber type allows nullability
// Do some initialisation stuff
newNumber = 42; // Update the value of newNumber
print(newNumber); // Prints 42
```

In the updated example, we declare newNumber with no value, but this is allowed because we have said, using the late modifier, that the value will be set before it is accessed. Later, we do set the value as we promised, and then the value access (within the print method) happens after the value is set.

### Accessing nullable variables

As you would expect, if a variable can have a null value, then you will need to check if it is null before you use it. For example, suppose we have a variable that stores how many goals a team has scored, but before the match starts, it is set to null. The following code would show errors:

```
int? goals;
// Other code
print(goals + 2);
```

The goals variable is still potentially null at the point of the print statement, so adding 2 to null is not a valid operation—hence the errors from the Dart compiler.

To solve this problem, you can explicitly check if the variable is null and only access the value if it is not null. If it is not null, then Dart remembers this and will treat the variable as if it is no longer nullable. For example, the following code is allowed:

```
int? goals;
// Other code
If (goals != null) {
  print(goals + 2);
}
```

During the if statement, you have checked that the goals variable is not null. Dart then remembers that this check has taken place and allows for the print statement to show goals with 2 added to it.

### Null-aware methods

Sometimes, you will need to call a method on a variable where the variable's type specifies that it can be null. The same approach of checking whether the variable is null will allow you to call the method without the compiler giving an error, as shown here:

```
String? goalScorer;
// Other code
if (goalScorer != null) {
  print(goalScorer.length);
}
```

In this code sample, we're checking if goalScorer is null, and only if it isn't null do we call the length method on it.

Another option that's available to you is to use the ?. null-aware method operator. This will only call the method if the variable is not null; otherwise, it will simply return null.

We can then rewrite the previous code sample so that it looks like this:

```
String? goalScorer;
// Other code
print(goalScorer?.length);
```

If this code sample runs and the goalScorer value is null, then the length method doesn't get called, and the print statement prints "null." However, if the goalScorer value is not null, then the length method does get called, and the length of String is printed.

### Null-assertion operator

As we saw previously, if we can prove to the compiler that a variable is not null, then we can use the value of the variable or call methods on it. However, there are some situations where the business logic denotes that a variable is not null, but the compiler does not know that.

For example, take a look at this code:

```
int? goalTime;
String? goalScorer;
bool goalScored = false;
// Other code
if (goalScored) {
  goalTime = 21;
  goalScorer = "Bobby";
}
// More code
if (goalTime != null) {
  print(goalScorer.length);
}
```

In this (somewhat convoluted) example, the goalScorer value always gets set at the same time as the goalTime value. Therefore, we know that if goalTime is not null then goalScorer is not null. However, we haven't proved that to the compiler; we only know this is the case because our business logic determines that if there is time for a goal, then someone must have scored it.

To cope with these situations, we can use the ! (exclamation point) null assertion operator, which tells the compiler that we are confident that the variable is not null, so go ahead and use it. Note that if we are wrong, it will cause an exception, so use the ! operator carefully.

Let's look at it in action by modifying the final print statement so that it's compile safe:

```
if (goalTime != null) {
  print(goalScorer!.length);
}
```

In this example, we have added! to say that we are confident that the goalScorer variable is not null. The compiler trusts that we are right about this.

When Dart moved to null safety, it was interesting that the team behind Dart decided to change the language's default behavior. Instead of allowing existing code to work without changes (backward compatibility), they decided that forcing all code developers to re-evaluate their code with regard to null safety was important enough that it should be forced upon them. Although at the time this was a relatively painful process, many bugs and code improvements have happened throughout the Flutter ecosystem (applications, plugins, tooling), meaning Flutter is in an even better position after the switch to null safety.

## Built-in types

Dart is a type-safe programming language, which means that when the code is written and compiled, each variable must have a defined type. This is in contrast to languages such as JavaScript where the variable's type is not defined and can change while the code is running. This can lead to issues at runtime, where the expected type of a variable doesn't match the actual type.

Although types are mandatory, type annotations are optional, which means that you don't need to specify the type of a variable when you declare it, as long as Dart can infer the type.

First, let's look at how a variable is declared, and then we can look at the types a variable can take.

Here are the built-in data types in Dart:

- Numbers (such as num, int, and double)
- Booleans (such as bool)
- Collections (such as lists, arrays, and maps)
- Strings and runes (for expressing Unicode characters in a string)

Let's explore each built-in data type in detail, starting with numbers.

### Numbers

Dart represents numbers in two ways, outlined as follows:

- int: 64-bit signed non-fractional integer values such as -263 to 263-1.
- double: Dart represents fractional numeric values with a 64-bit double-precision floating-point number.

Both of them extend the num type. Additionally, we have many handy functions in the dart:math library to help with calculations, such as the following ones:

- Random to generate a random bool or number
- Min or Max to find the larger or lesser of two numbers
- Trigonometric functions (sine, cosine, tangent)

In JavaScript, numbers are compiled to JavaScript numbers and allow the values -253 to 253-1.

### BigInt


Dart also has the BigInt type for representing arbitrary precision integers, which means that the size is only limited by your computer's random-access memory (RAM). This type can be very useful depending on the context; however, it does not have the same performance as num types, so you should carefully consider when to use it.

### Booleans

Dart provides two well-known literal values for the bool type: true and false.

Boolean types are simple truth values that can be useful for any logic. Unlike in JavaScript where everything with a value is true and everything without a value is false, Dart is strict about Boolean types and does not follow the same truthy and falsy approach.

### Lists

In Dart, lists bring together the functionality of array and List types present in other programming languages, with some handy methods to manipulate elements. These types are outlined here:

- The [index] operator allows convenient access to the elements at a given index.
- The + operator can be used to concatenate two lists by returning a new list with the left operand followed by the right one.

Note that Dart lists are not naturally length-constrained, as arrays in some languages can be. Lists grow and shrink as needed through the use of the add and remove methods.

Note that a list should be created using the square brackets literal. In fact, creation of a list using the List type name is now deprecated. Here are some examples of the creation of a List:

```
List dynamicList = [];
print(dynamicList.length); // Prints 0
dynamicList.add("Hello");
print(dynamicList[0]); // Prints "World"
print(dynamicList.length); // Prints 1
List preFilledDynamicList = [1, 2, 3];
print(preFilledDynamicList[0]); // Prints 1
print(preFilledDynamicList.length); // Prints 3
```

### Semicolon

In the preceding example, each line of code ends with a semicolon. This is required in Dart to show the end of a statement. Statements can be written across multiple lines but must terminate with a semicolon.

During list creation, a length can be set to enforce a fixed size. Lists with a fixed size cannot be expanded, so you need to ensure it is clear that a List has been created with a fixed size. The code to accomplish this is illustrated in the following snippet:

```
List fixedList = List.filled(3, "World");
fixedList.add("Hello"); // Error
fixedList[0] = "Hello";
print(fixedList[0]); // Prints "Hello";
print(fixedList[1]); // Prints "World";
```

### The new keyword

In many OO languages, instances of classes such as Lists are created using the new keyword. This was also true in the Dart language but is now no longer used. However, note that it is still a reserved keyword, so you cannot name variables new.

### Maps

Dart Maps are dynamic collections for storing key-value pairs, where the retrieval and modification of a value are always performed through its associated key. Both the key and value can have any type. You can see an example of this here:

```
Map nameAgeMap = {};
nameAgeMap["Alice"] = 23;
print(nameAgeMap["Alice"]); // Prints 23
```

### Strings

In Dart, strings are a sequence of characters (Unicode Transformation Format-16 (UTF-16) code) that are mainly used to represent text. Dart strings can be single or multiple lines and use matching single or double quotes to wrap the text. You can see an example here:

```
String singleQuoteString = 'Here is a single quote string';
String doubleQuoteString = "Here is a double quote string";
```

Additionally, multiline strings can be created using matching triple single quotes or triple double quotes, as illustrated in the following code snippet:

```
String multiLineString = '''Here is a multi-line single
  quote string''';
```

Note that the indentation on the second line will be included in the created string.

Strings can be concatenated (stuck together) using the plus (+) operator, as illustrated in the following code snippet. In addition, the multiplier (*) operator is used where the string gets repeated a specified number of times, and the [index] operator retrieves the character at the specified index position:

```
String str1 = 'Here is a ';
String str2 = str1 + 'concatenated string';
print(str2); // Prints Here is a concatenated string
```

### String interpolation

String interpolation (or, as I prefer, variable expansion) is the action of evaluating placeholders within a string and then concatenating the results. Dart has a simple syntax for string interpolation: ${}.

The dollar ($) symbol identifies the placeholders to be evaluated. If this evaluation is a single variable, then the curly brackets can be omitted (and if not omitted, then a warning is shown). For a placeholder that involves more than the evaluation of a single variable, the curly brackets denote the boundary of evaluation.

Here are some examples to explain this concept further:

```
String someString = "Happy string";
print("The string is: $someString");
// prints The string is: Happy string
// No curly brackets were required
print("The string length is: ${someString.length}");
// prints The string length is: 16
// Curly brackets were required
print("The string length is: $someString.length");
// prints The string length is: Happy string.length
// Omitting the curly brackets meant only the variable was evaluated, not the method on the variable.
```

Dart also has the runes concept to represent UTF-32 bits. For more details, check out the Dart language tour at https://dart.dev/guides/language/language-tour.

### Literals

A literal is a notation to represent a fixed value. You have likely already used some of these before. Here is a quick recap of literal examples for the common types:

![Table_2.01_Literals ](/flutter4beginners2_img/table_2.01_literals.jpg)

### Const and final

If you have a variable that will not change in value then you can define it as a constant. If the value of the variable can be defined at compile time, for example, if it has a literal value, then you would use the const modifier to specify the variable as a constant. For example:

```
const String someString = "Happy string";
```

However, if the value will be set once, but that value is not known as compile time, then use the final modifier instead. For example:

```
final String someString = DateTime.now().toString();
```

Although, you do not need to use these modifiers, when we look at widgets in future chapters, and specifically stateless widgets, you should set your variables as final because a stateless widget should not, by definition, be able to mutate its state. Using final variables ensures this cannot happen.

With that, you have learned how to store data in a type-safe and null-safe way. Now, let's see how we can use that data within our code.

# Control flows and looping

Before we can finish exploring the main method in DartPad, we need to know how to control the flow of code execution. This is done through a series of control flow statements. These are very similar to other programming languages, so let's see what they look like in Dart.

## If/else

Dart supports the standard if, else if, else decision structure. It also supports if statements without curly brackets, which are especially useful during Flutter widget definitions. In these if statements, the next expression is evaluated if the condition is true. You can see an example of this in the following code snippet:

```
String test = "test2";
if (test == "test1") {
  print("Test1");
} else if (test == "test2") {
  print("Test2");
} else {
  print("Something else");
}
// Prints Test2
If (test == "test2")
  print("Test2 again"); // Prints Test 2
```

In the first example, we have initialized a variable called test and assigned it the String value "test2". We then use an if/else statement to compare the value against the String literal "test1", which will fail the comparison.

The code execution then moves to the first else statement because the first comparison evaluated to the false Boolean value and will evaluate the if statement defined in that else statement to check against the String literal "test2". This combination of else followed by if is called an else-if statement, and you can have as many of these in an if-else statement as you require.

The test == "test2" condition evaluates to the true Boolean value, so code execution enters that branch of the code and prints "Test2" and then ends execution of the if/else statement, moving execution below the final else statement.

However, if this comparison had also been evaluated as the false Boolean value, then we would finally have had a catch-all else statement that would have been executed regardless of the variable's value.

In the second if statement, we evaluate the test == "test2" condition again, but this time we do not wrap the code branch in curly brackets. The line immediately after the if statement is run, printing "Test2 again".

These if/else structures should be familiar to you if you have worked with other programming languages.

As mentioned previously, Dart does not deal with truthy and falsy concepts, unlike JavaScript. All conditions must evaluate to Boolean values, as illustrated in the following code snippet:

```
String test = "true";
if (test) { // Creates a compilation error
  print("Truthy");
}
```

The example will not compile because test is not a Boolean, so the condition does not evaluate to a Boolean value.

### Equality checking and type coercion

In languages such as JavaScript, the equality of two variables can be checked either with the double equals or the triple equals operator, where the former checks whether the values match after attempting to coerce them to a similar type and the latter checks whether both the values and their type match. For example, in JavaScript, "7" == 7 evaluates to true, but "7" === 7 evaluates to false. This can lead to unexpected bugs and is not an approach that many programming languages follow because of this. Dart only has the double equals operator and does not do type coercion.

## While and do-while loops
While and do-while control flows loop on a specific piece of code while their condition evaluates to true, and then when their condition evaluates to false, the loop is exited and code execution continues after the loop.

A do-while loop differs from a while loop by having the condition evaluate at the end of the first loop, therefore ensuring at least one execution of the code contained inside.

Let's look at some examples, as follows:

```
int counter = 0;
while (counter < 2) {
  print(counter);
  counter++;
}
// Prints 0, 1
do {
  print(counter);
  counter++;
} while (counter < 2);
// Prints 2
```

The counter variable is initialized as an int type and is assigned the value of 0. The code flow then enters the while loop and the condition is evaluated. At this point, the counter variable has a value less than 2, so the flow enters the loop, printing the counter value and incrementing the counter variable.

After completing the loop code, the loop condition is re-evaluated, and again the counter variable has a value less than 2, so the flow enters the loop again.

Finally, the value of the counter variable is 2, so the loop condition evaluates to false and the code flow moves to after the end of the loop.

The flow then enters the do/while loop. There is no conditional check at the start of the do/while loop, so the code in the loop is executed. At the end of the loop, the condition is checked and evaluates to false, meaning the loop is exited.

## For loops

For loops follow this standard structure:

```
for (initialize; loop_condition; modify) {}
```

This is broken down into the following:

- initialize, where variables are initialized to manage the iteration
- loop_condition, where looping continues only if the condition evaluates to true
- modify, where variables can be modified on each loop to track progression

The following example will help make this clearer:

```
for (int index = 0; index < 2; index++) {
    print(index);
}
// Prints 0, 1
```

In the preceding example, the index variable is initialized to 0, and the loop_ condition is evaluated to true. On each subsequent iteration, the index variable is incremented by 1 and then the loop_ condition is re-evaluated, first to true and then to false when index reaches 2.

## break and continue

Sometimes, it can be tricky to break out of a loop or start the next iteration of a loop without creating confusing code to manipulate the condition.

Adding a break statement to a loop allows you to jump out of the loop immediately, and adding a continue statement allows you to start the next iteration of the loop immediately.

Here is an example to help clarify this:

```
int counter = 0;
while (counter < 10) {
  counter++;
  if (counter == 4) {
    break;
  } else if (counter == 2) {
    continue;
  }
  print(counter);
}
// Prints 1, 3
```

In the preceding example, on the first iteration, the counter variable is incremented to 1; neither of the if conditions evaluate to true, so the value is printed.

On the second iteration, the counter variable is incremented to 2, so the continue statement is called before the print statement.

On the third iteration, the counter is incremented to 3; neither of the if conditions evaluate to true, so the value is printed.

On the fourth iteration, the counter variable is incremented to 4 and the break statement is called, breaking out of the loop and ending the code.

### Hands-on continued

Let's look back at the DartPad main method. More of that should make sense to us now. You can see a representation of this here:

```
void main() {
  for (int i = 0; i < 5; i++) {
    print('hello ${i + 1}');
  }
}
```

We have explored the surrounding main function, but the code inside the function should now also be familiar.

We have learned about for loops, and in this code snippet, the for loop initializes the i variable to 0 and then loops until i reaches the value of 5, incrementing the value of i on each iteration.

Within the for loop, we have a print function. This function simply prints text to the terminal. As a print statement argument, we can see some string interpolation. This evaluates the value of i + 1 and then concatenates it on the end of hello to make a String for printing to the screen.

We briefly looked at the main function and how that is structured. We've now encountered the print function as well, so now is a good point to look at functions and their parameters.

# Functions and methods

As we discussed previously, functions and methods are self-contained chunks of code that work on a specific task. Note that the syntax of methods and functions is identical, so where I refer to functions in this section, I am also referring to methods. Let's look at another example of a function, as follows:

```
String sayHello() { 
  return "Hello world!";
}
```

This sayHello function structure is very similar to the main function we explored previously but also includes a return type of String, so the function must have a return statement at the end that returns a value of the expected type. In this example, the function returns a String literal of "Hello world!". If the function could return a String literal or null then, as we saw in the Null safety section, we would mark the function's return type as String?.

Note that the function return type can be omitted because the Dart analyzer can infer the return type from the return statement. If no return statement is provided, it assumes the function returns a dynamic type. If you want to tell the analyzer that the function will never return anything, you should mark it as void, as we saw in the main method earlier. Note that it is preferable to include the return type on the function signature to ensure that the code is easily understood and maintainable long term.

Try adding the sayHello function in DartPad, and then, in the main method, replace the for loop with a call to the sayHello function so that it looks something like this:

```
void main() {
  String helloMessage = sayHello();
  print(helloMessage);
}
String sayHello() { 
  return "Hello world!";
}
```

In this example, the sayHello function is a top-level function—in other words, it does not need a class to exist. Although Dart is an OO language, it is not necessary to write classes to encapsulate functions.

Run this in DartPad and you should see the output "Hello world!". Congratulations—you just wrote your first Dart code and ran it successfully!

In Dart, Function is a type, like String or num. This means that it can also be assigned to fields or local variables or passed as parameters to other functions. Consider the following change to the main method:

```
void main() {
  var helloFunction = sayHello();
  String helloMessage = helloFunction();
  print(helloMessage);
}
```

It feels as though we've been saying hello to the world a lot in this chapter, but we've learned a lot about the Dart language. However, we still haven't explored what can go in those brackets defining the input data for the function. Let's take a look at that now.

## Function parameters

A function can have two types of parameters: optional and required. Additionally, these parameters can be named instead of positional to make the code more readable. This is especially true in Flutter where widgets can have lots of optional parameters, so identifying which argument is for which parameter is critical to understanding the code and diagnosing issues.

### Parameter versus argument

The term parameter refers to the entries in the function signature defining the input data types and names. An argument is the data passed to the function when it is called from another point in the code. The argument types when calling the function must match the parameter types on the function definition, either directly or through polymorphism.

A parameter's type doesn't need to be specified; in this case, the parameter assumes the dynamic type. Again, for long-term code readability and maintainability, adding parameter types is highly preferable.

### Required positional parameters

This simplest function definition is achieved by defining positional parameters. This is the most common approach in other programming languages, so you will probably already be confident with this approach. The parameters are listed in order, and the arguments supplied when calling the function simply match the same ordering.

In the following function, both name and age are required positional parameters, so the caller must specify matching arguments in the same order when calling it:

```
sayHappyBirthday(String name, int age) {
  return "$name is ${age.toString()} years old";
}
```

To call this function, you would have something similar to this:

```
sayHappyBirthday("Laura", 21);
```

### Optional positional parameters

Sometimes, not all parameters need to be mandatory for a function, so you can specify optional parameters on the function signature as well. The optional positional parameter definition is specified using the [ ] syntax. Optional positional parameters must go after all of the required positional parameters, as follows:

```
sayHappyBirthday(String name, [int? age]) {
  return "$name is $age years old";
}
```

If you run the preceding code without passing a value for age, you will see null in the returned string. When an optional parameter is not specified, the default value is null, hence the type definition needs to include a ? character to show it could be null. To help with this, you can specify default values for optional positional parameters.

To define a default value for a parameter, simply initialize the parameter value directly in the parameter definition, as illustrated in the following code snippet. This will be overwritten if the caller supplies an argument for that parameter:

```
sayHappyBirthday(String name, [int age = 21]) {
  return "Happy birthday $name! You are $age years old.";
}
```

Not specifying the parameter results in printing the default message, as follows:

```
void main() {
  var hello = sayHello('Robert');
  print(hello);
}
// Prints Happy birthday Robert! You are 21 years old.
```

### Named parameters

Named parameter definitions are specified using the {} syntax. These definitions must also go after all the required parameters. As with optional positioned parameters, named parameters can have a default value, as illustrated in the following code snippet:

```
sayHappyBirthday(String name, {int age = 7}) {
  return "Happy birthday $name! You are $age years old.";
}
```

To specify a value for age, the caller must include the name of the optional named parameter, as follows:

```
sayHappyBirthday("Laura", age: 21);
```

By default, named parameters are optional; the calling function does not need to include an argument to match the parameter. However, named parameters can be specified as required by marking them with required, as illustrated in the following code snippet:

```
sayHappyBirthday(String name, {required int age}) {
  return "Happy birthday $name! You are $age years old.";
}
```

If the caller does not include the age named parameter in its arguments, then the Dart analyzer will show an error against the calling code.

### Anonymous functions

Dart functions are objects and they can be passed as parameters to other functions, as we saw previously.

An anonymous function is a function that doesn't have a name; it is also called a lambda or closure. The forEach() function on a List is a good example of this; we need to pass a function to it that will be executed with each of the list collection elements, as follows:

```
void main() {
  List = [1, 2, 3, 4];
  list.forEach((number) => print('hello $number'));
}
```

Our anonymous function receives an item but does not specify a type; then, it just prints the value received by the parameter.

### Lexical scope

Dart is lexically scoped, meaning that the layout of the code determines the scope for variables. So, inner functions can access variables all the way up to the global level, as illustrated in the following code snippet:

```
globalFunction() {
  print("Top-level globalFunction");
}
simpleFunction() { 
  print("SimpleFunction"); 
  globalFunction() {
    print("Nested globalFunction");
  }
  globalFunction();
}
main() {
  simpleFunction();
  globalFunction();
}
```

When main calls simpleFunction, then the nested globalFunction function is defined, blocking access to the top-level globalFunction function. When globalFunction is called, it is the nested version that is called.

In contrast, when the main function calls the globalFunction function, the top-level globalFunction function is called because, in this scope, the nested globalFunction function from simpleFunction is not defined.

Hence, the output from calling the main method is this:

```
simpleFunction
Nested globalFunction
Top-level globalFunction
```

# Summary

In this second chapter, we presented the available tools to start your Dart language studies, discovered what a basic Dart program looks like, and learned about the basic Dart code structure.

We demonstrated how the Dart SDK works and the tools it provides that help with Flutter application development and making the Flutter framework succeed in its objectives.

We reviewed some important concepts of the Dart language, introduced Dart OOP, looked at the data types available, saw how null safety is a key part of variable data types, investigated functions and their range of parameter specifications such as named/positional and optional/required, and explored how to control code execution flow.

There are still areas of the Dart language that we haven't yet explored, and these will be introduced as we progress through the book. However, you now have sufficient knowledge of Dart to get up and running and build your first Flutter application—exciting, isn't it?

In the next chapter, we will look at how Flutter compares to the other frameworks available to application developers.

