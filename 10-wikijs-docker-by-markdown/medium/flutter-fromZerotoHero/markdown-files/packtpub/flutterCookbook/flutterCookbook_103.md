원본 제목: 3 Dart: A Language You Already Know
원본 링크: https://subscription.packtpub.com/book/mobile/9781838823382/2
Path:
packtpub/flutterCookbook/103
Title:
103 Dart: A Language You Already Know
Short Description:
Flutter Cookbook 다트: 이미 알려진 언어

![Figure3.4-null error in the console ](/flutter_cookbook_img/figure3.4-null_error_in_the_console.png)
---------- cut line ----------


# Dart: A Language You Already Know

At its heart, Dart is a conservative programming language. It was not designed to champion bold new ideas, but rather to create a predictable and stable programming environment. The language was created at Google in 2011, with the goal of unseating JavaScript as the language of the web.

JavaScript is a very flexible language, but its lack of a type system and misleadingly simple grammar can make projects very difficult to manage as they grow. Dart aimed to fix this by finding a halfway point between the dynamic nature of JavaScript and the class-based designs of Java and other object-oriented languages. The language uses a syntax that will be immediately familiar to any developer who already knows a C-style language.

This chapter also assumes that Dart is not your first programming language. Consequently, we will be skipping the parts of the Dart language where the syntax is the same as any other C-style language. You will not find anything in this chapter about loops, if statements, and switch statements; they aren't any different here from how they are treated in other languages you already know. Instead, we will focus on the aspects of the Dart language that make it unique.

In this chapter, we will cover the following recipes, all of which will function as a primer on Dart:

- Declaring variables – var versus final versus const
- Strings and string interpolation
- How to write functions
- How to use functions as variables with closures
- Creating classes and using the class constructor shorthand
- Defining abstract classes
- Implementing generics
- How to group and manipulate data with collections
- Writing less code with higher-order functions
- Using the cascade operator to implement the builder pattern
- Understanding Dart Null Safety

> If you are already aware of how to develop in Dart, feel free to skip this chapter. We will be focusing exclusively on the language here and will then cover Flutter in detail in the next chapter.
{.is-info}

# Technical requirements

This chapter will focus purely on Dart instead of Flutter. There are two primary options for executing these samples:

- DartPad (https://dartpad.dartlang.org): DartPad is a simple web app where you can execute Dart code. It's a great playground for trying out new ideas and sharing code.
- IDEs: If you wish to try out these samples locally with complete code support, then you can use either Visual Studio Code or IntelliJ.

## Declaring variables – var versus final versus const

Variables are user-defined symbols that hold a reference to some value. They can range from a single number to large object graphs. It is virtually impossible to write a useful program without at least one variable. You can probably argue that almost every program ever written can be boiled down to taking in some input, storing that data in a variable, manipulating the data in some way, and then returning an output. All of this would be impossible without variables.

Recently, a new trend has appeared in programming that emphasizes immutability. This means that once the values are stored in a variable, that's it – they cannot change. Immutable variables are safer, produce no side effects, and lead to fewer bugs as a consequence.

In this recipe, we will create a small toy program that will declare variables in the three different ways that Dart allows – var, final, and const. 

# Getting ready

Install the following before you get started with this recipe:

- DartPad:
1. In your browser, navigate to https://dartpad.dartlang.org.

- Visual Studio Code:
1. Double-check that the DartCode plugin has been installed. If you followed the steps in the previous chapter, you should be good to go.
1. Press Command + N to create a new file and save it as main.dart.

- IntelliJ:
1. Double-check that you have the Dart plugin installed.
1. Select Create new project. The following dialog will appear, asking what language and configuration you want to use: 

![Figure3.1-Dart and Console Application ](/flutter_cookbook_img/figure3.1-dart_and_console_application.png)

3. Pick Dart as your language and then select Console Application. This effectively runs the same commands as the command-line instructions but wraps everything in a nice GUI.

> When working with the code samples in this book, it is strongly discouraged that you copy and paste them into your IDE. Instead, you should transcribe the samples manually. The act of writing code, not copying/pasting, will allow your brain to absorb the code and see how tools such as code completion and DartFmt make it easier for you to type code. If you copy and paste, you'll get a working program, but you will also learn nothing.
{.is-success}

# How to do it...

Let's get started with our first Dart project. We will start from a blank canvas:

1. Open main.dart and delete everything. At this point, the file should be completely empty. Now, let's add the main function, which is the entry point for every Dart program:
```
main() {
 variablePlayground();
}
```

2. This code won't compile yet because we haven't defined that variablePlayground function. This function will be a hub for all the different examples in this recipe:
```
void variablePlayground() {
 basicTypes();
 untypedVariables();
 typeInterpolation();
 immutableVariables();
}
```

	We added the void keyword in front of this function, which is the same as saying that this function returns nothing.

3. Now, let's implement the first example. In this method, all these variables are mutable; they can change once they've been defined:
```
void basicTypes() {
 int four = 4;
 double pi = 3.14;
 num someNumber = 24601;
 bool yes = true;
 bool no = false;
 int nothing; 

 print(four);
 print(pi);
 print(someNumber);
 print(yes);
 print(no);
 print(nothing == null);
}
```

	The syntax for declaring a mutable variable should look very similar to other programming languages. First, you declare the type and then the name of the variable. You can optionally supply a value for the variable after the assignment operator. If you don't supply a value, that variable will be set to null.

4. Dart has a special type called dynamic, which is a sort of "get out of jail free" card from the type system. You can annotate your variables with this keyword to imply that the variable can be anything. It is useful in some cases, but for the most part, it should be avoided:
```
void untypedVariables() {
 dynamic something = 14.2;
 print(something.runtimeType); //outputs 'double'
}
```

5. Dart can also infer types with the var keyword. var is not the same as dynamic. Once a value has been assigned to the variable, Dart will remember the type and it cannot be changed later. The values, however, are still mutable:
```
void typeInterpolation() {
 var anInteger = 15;
 var aDouble = 27.6;
 var aBoolean = false;

 print(anInteger.runtimeType);
 print(anInteger);

 print(aDouble.runtimeType);
 print(aDouble);

 print(aBoolean.runtimeType);
 print(aBoolean);
}
```

6. Finally, we have our immutable variables. Dart has two keywords that can be used to indicate immutability – final and const. 

> The main difference between final and const is that const must be determined at compile time; for example, you cannot have const containing DateTime.now() since the current date and time can only be determined at runtime, not at compile time. See the How it works... section of this recipe for more details.
{.is-info}

7. Add the following function to the main.dart file:
```
void immutableVariables() {
 final int immutableInteger = 5;
 final double immutableDouble = 0.015;
 
 // Type annotation is optional
 final interpolatedInteger = 10;
 final interpolatedDouble = 72.8;

 print(interpolatedInteger);
 print(interpolatedDouble);

 const aFullySealedVariable = true;
 print(aFullySealedVariable);
}
```

# How it works...

An assignment statement in Dart follows the same grammar as other languages in the C language family:
```
// (optional modifier) (optional type) variableName = value;
final String name = 'Donald'; //final modifier, String type
```

First, you can optionally declare a variable as either var, final, or const, like so:
```
var animal = 'Duck';
final numValue = 42;
const isBoring = true;
```

These modifiers indicate whether the variable is mutable. var is completely mutable as its value can be reassigned at any point. final variables can only be assigned once, but by using objects, you can change the value of its fields. const variables are compile-time constants and are fully immutable; nothing about these variables can be changed once they've been assigned.

Please note that you can only specify a type when you're using the final modifier, as follows:
```
final int numValue = 42; // this is ok
// NOT OK: const int or var int.
```

After the final modifier, you can optionally declare the variable type, from simple built-in types such as int, double, and bool, to your own more complex custom types. This notation is standard for languages such as Java, C, C++, Objective-C, and C#.

Explicitly annotating the type of a variable is the traditional way of declaring variables in languages such as Java and C, but Dart can also interpolate the type based on its assignment. In the typeInterpolation example, we decorated the types with the var keyword; Dart was able to figure out the type based on the value that was assigned to the variable. For example, 15 is an integer, while 27.6 is a double. In most cases, there is no need to explicitly reference the type; the compiler is smart enough to figure this out. This allows us, as developers, to write succinct, script-like code and still take advantage of inherent gains that we get from a type-safe language.

The difference between final and const is subtle but important. A final variable must have a value assigned to it in the same statement where it was declared, and that variable cannot be reassigned to a different value:
```
final meaningOfLife = 42;
meaningOfLife = 64; // This will throw an error
```

While the top-level value of a final variable cannot change, its internal contents can. In a list of numbers that have been assigned to a final variable, you can change the internal values of that list, but you cannot assign a completely new list.

const takes this one step further. const values must be determined at compile time, new values are blocked from being assigned to const variables, and the internal contents of that variable must also be completely sealed. Typically, this is indicated by having the object have a const constructor, which only allows immutable values to be used. Since their value is already determined at compile time, const values also tend to be faster than variables.

# There's more...

In recent years, there has been a trend in development that favors immutable values over mutable ones. Immutable data cannot change. Once it has been assigned, that's it. There are two primary benefits to preferring immutable data, as follows:

- It's faster. When you declare a const value, the compiler has less work to do. It only has to allocate memory for that variable once and doesn't need to worry about reallocating if the variable is reassigned. This may seem like an infinitesimal gain, but as your programs grow, your performance gain grows as well.
- Immutable data does not have side effects. One of the most common sources of bugs in programming is where value is changed in one place, and it causes an unexpected cascade of changes. If the data cannot change, then there will be no cascade. And in practice, most variables tend to only be assigned once anyway, so why not take advantage of immutability?

# See also

Have a look at the following resources:

- The Dart website provides a great tour of all its language features and provides a deeper explanation of every built-in variable type: https://dart.dev/guides/language/language-tour.
- The Dart Essentials book from Packt covers more aspects of the Dart language and how it can be used to write web and server applications: https://www.packtpub.com/web-development/dart-essentials.

## Strings and string interpolation

A String is simply a variable that holds human-readable text. The reason why they're called strings instead of text has more to do with history than practicality. From a computer's perspective, a String is actually a list of integers. Each integer represents a character.

For example, the number U+0041 (Unicode notation, 65 in decimal notation) is the letter A. These numbers are stringed together to create text.

In this recipe, we will continue with the toy console application in order to define and work with strings.

# Getting ready

To follow along with this recipe, you should write the code in DartPad or add the code to the existing project you created in the previous recipe, both in a new file or in the main.dart file. 

## How to do it...

Just like in the previous project, you are going to create a playground function where every sub-function will demonstrate a different aspect of the strings:

1. Type in the following code and use it as the hub for all the other string examples:
```
void stringPlayground() {
 basicStringDeclaration();
 multiLineStrings();
 combiningStrings();
}
```

2. The first section demonstrates the ways in which you can declare string literals. Write the following function into your code, just under the stringPlayground function:
```
void basicStringDeclaration() {
  // With Single Quotes
  print('Single quotes');
  final aBoldStatement = 'Dart isn\'t loosely typed.';
  print(aBoldStatement);

  // With Double Quotes
  print("Hello, World");
  final aMoreMildOpinion = "Dart's popularity has skyrocketed with
  Flutter!";
  print(aMoreMildOpinion);
  // Combining single and double quotes
  final mixAndMatch =
      'Every programmer should write "Hello, World" when learning
       a new language.';
  print(mixAndMatch);
}
```

3. Dart also supports multi-line strings for cases where you have a text block that you want to print to the screen. The following example gets a little Shakespearean:
```
void multiLineStrings() {
  final withEscaping = 'One Fish\nTwo Fish\nRed Fish\nBlue Fish';
  print(withEscaping);

  final hamlet = '''
  To be, or not to be, that is the question:
  Whether 'tis nobler in the mind to suffer
  The slings and arrows of outrageous fortune,
  Or to take arms against a sea of troubles
  And by opposing end them.
  ''';

  print(hamlet);
}
```

4. Finally, one of the most common tasks programmers perform with strings is composing them to make more complex strings. Dart supports both the traditional method of concatenation, as well as a more modern method called string interpolation. Type in the following blocks of code to get a feel for both techniques:
```
void combiningStrings() {
 traditionalConcatenation();
 modernInterpolation();
}

void traditionalConcatenation() {
 final hello = 'Hello';
 final world = "world";

 final combined = hello + ' ' + world;
 print(combined);
}

void modernInterpolation() {
 final year = 2011;
 final interpolated = 'Dart was announced in $year.';
 print(interpolated);

 final age = 35;
 final howOld = 'I am $age ${age == 1 ? 'year' : 'years'} old.';
 print(howOld);
}
```

5. Now, all we have to do to run this code is update main.dart so that it points this file to a new file. Replace the top of main.dart with the following code:
```
main() {
 variablePlayground();
 stringPlayground();
}
```

# How it works...

Just like JavaScript, there are two ways of declaring string literals in Dart – using a single quote or double quotes. It doesn't matter which one you use, as long as both begin and end a string with the same character. Depending on which character you chose, you would have escaped that character if you wanted to insert it in your string.

For example, to write a string stating Dart isn't loosely typed with single quotes, you would have to write the following:
```
// With Single Quotes
final aBoldStatement = 'Dart isn\'t loosely typed.';

// With Double Quotes
final aMoreMildOpinion = "Dart's popularity has skyrocketed with Flutter!";
```

Notice how we had to write a backslash in the first example but not in the second. That backslash is called an escape character. Here, we are telling the compiler that even though it sees an apostrophe, this is not the end of the string, and the apostrophe should actually be included as part of the string.

The two ways in which you can write a string are helpful when you're writing strings that contain single quotes/apostrophes or quotation marks. If you declare your string with the symbol that is not in your string, then you will not have to add any unnecessary characters to your code, which ultimately improves legibility.

It has become a convention to prefer single quote strings over doubles in Dart, which is what we will follow in this book, except if that choice forces us to add escape characters.

One other interesting feature of strings in Dart is multi-line strings.

If you ever had a larger block of text that you didn't want to put into a single line, you would have to insert the newline character, \n, as you saw in this recipe's code:
```
final withEscaping = 'One Fish\nTwo Fish\nRed Fish\nBlue Fish';
```

The newline character has served us well for many years, but more recently, another option has emerged. If you write three quotation marks (single or double), Dart will allow you to write free-form text without having to inject any non-rendering control characters, as shown in the following code block:
```
final hamlet = '''
  To be, or not to be, that is the question:
  Whether 'tis nobler in the mind to suffer
  The slings and arrows of outrageous fortune,
  Or to take arms against a sea of troubles
  And by opposing end them.
  ''';
```

In this example, every time you press Enter on the keyboard, it is the equivalent of typing the control character, \n, in your string.

# There's more...

On top of simply declaring strings, the more common use of this data type is to concatenate multiple values to build complex statements. Dart supports the traditional way of concatenating strings; that is, by simply using the addition (+) symbol between multiple strings, like so:
```
final sum = 1 + 1; // 2
final concatenate = 'one plus one is ' + sum; 
```

While Dart fully supports this method of constructing strings, the language also supports interpolation syntax. The second statement can be updated to look like this:
```
final sum = 1 + 1;
final interpolate = 'one plus one is $sum'
```

The dollar sign notation only works for single values, such as the integer in the preceding snippet. If you need anything more complex, you can add curly brackets after the dollar sign and write any Dart expression. This can range from something simple, such as accessing a member of a class, to a complex ternary operator.

Let's break down the following example:
```
  final age = 35;
  final howOld = 'I am $age ${age == 1 ? 'year' : 'years'} old.';
  print(howOld);
```

The first line declares an integer called age and sets its value to 35. The second line contains both types of string interpolation. First, the value is just inserted with $age, but after that, there is a ternary operator inside the string to determine whether the word year or years should be used:
```
age == 1 ? 'year' : 'years'
```

This statement means that if the value of age is 1, then use the singular word year; otherwise, use the plural word years. When you run this code, you'll see the following output:
```
I am 35 years old.
```

Over time, this will become natural. Just remember that legible code is usually better than shorter code, even if it takes up more space.

It's probably worth mentioning another way to perform concatenation tasks, which is using the StringBuffer object. Consider the following code:
```
List fruits = ['Strawberry', 'Coconut', 'Orange', 'Mango', 'Apple'];
StringBuffer buffer = StringBuffer();
for (String fruit in fruits) {
  buffer.write(fruit);
  buffer.write(' ');
}
print (buffer.toString()); // prints: Strawberry Coconut Orange Mango Apple
```

You can use a StringBuffer to incrementally build a string. This is better than using string concatenation as it performs better. You add content to a StringBuffer by calling its write method. Then, once it's been created, you can transform it into a String with the toString method.

# See also

Check out the following resources for more details on strings in Dart:

- The Dart Language's guide entry to strings: https://dart.dev/guides/language/language-tour#strings
- Effective Dart suggestions on the proper usage of strings: https://dart.dev/guides/language/effective-dart/usage#strings
- Official documentation on the String class: https://api.flutter.dev/flutter/dart-core/String-class.html

# How to write functions

Functions are the basic building blocks of any programming language and Dart is no different. The basic structure of a function is as follows:
```
optionalReturnType functionName(optionalType parameter1, optionalType parameter2...) {
  // code
} 
```

You have already written a few functions in previous recipes. In fact, you really can't write a functioning Dart application without them.

Dart also has some variations of this classical syntax and provides full support for optional parameters, optionally named parameters, default parameter values, annotations, closures, generators, and asynchronicity decorators. This may seem like a lot to cover in one recipe, but with Dart, most of this complexity will disappear.

Let's explore how to write functions and closures in this recipe. 

# Getting ready

To follow along with this recipe, you can write the code in DartPad, or add the code to the existing project you created in the previous recipe, either in a new file or in the main.dart file. 

# How to do it...

We'll continue with the same pattern from the previous recipe:

1. Start by creating the hub function for the different features we are going to cover:
```
void functionPlayground() {
  classicalFunctions();
  optionalParameters();
}
```

2. Now, add some functions that take parameters and return values:
```
void printMyName(String name) {
  print('Hello $name');
}

int add(int a, int b) {
  return a + b;
}

int factorial(int number) {
  if (number <= 0) {
    return 1;
  }

  return number * factorial(number - 1);
}

void classicalFunctions() {
  printMyName('Anna');
  printMyName('Michael');

  final sum = add(5, 3);
  print(sum);

  print('10 Factorial is ${factorial(10)}');
}
```

3. One of the new features that Dart has added is optional parameters. If you wrap your function's parameter list in square brackets, then those parameters can be omitted without the compiler throwing errors. 

> The question mark after a parameter, such as in String? name, tells the Dart compiler that the parameter itself can be null. 
{.is-info}

4. Write this code immediately after the previous example:
```
void unnamed([String? name, int? age]) {
  final actualName = name ?? 'Unknown';
  final actualAge = age ?? 0;
  print('$actualName is $actualAge years old.');
}
```

	Dart also supports named optional parameters, with curly brackets.

> When calling a function with named parameters, you need to specify the parameter name. You can call the parameters in any order; for example, named(greeting: 'hello!');.
{.is-info}

5. Add this function right after the unnamed optional function:
```
void named({String? greeting, String? name}) {
  final actualGreeting = greeting ?? 'Hello';
  final actualName = name ?? 'Mystery Person';
  print('$actualGreeting, $actualName!');
}
```

6. Optional parameters and optional named parameters also support default values. If the parameter is omitted when the function is called, the default value will be used instead of null. You can also place a set of required parameters first, followed by a list of optionals. Add the following code to see how this can be accomplished:
```
String duplicate(String name, {int times = 1}) {
  String merged = '';
  for (int i = 0; i < times; i++) {
    merged += name;
    if (i != times - 1) {
      merged += ' ';
    }
  }

  return merged;
}
```

7. Now, implement the playground function to show all these pieces in action:
```
void optionalParameters() {
  unnamed('Huxley', 3);
  unnamed();

  // Notice how named parameters can be in any order
  named(greeting: 'Greetings and Salutations');
  named(name: 'Sonia');
  named(name: 'Alex', greeting: 'Bonjour');

  final multiply = duplicate('Mikey', times: 3);
  print(multiply);
}
```

8. Finally, update the main method so that these functions can be executed:
```
main() {
  variablePlayground();
  stringPlayground();
  functionPlayground();
}
```

# How it works...

With Dart, you can write functions with unnamed (the old way), named, and unnamed optional parameters. In Flutter, unnamed optional parameters are the most common style you will be using, especially with widgets (more on this in the following chapters).

Named parameters can also remove ambiguity from what each parameter is supposed to do. Take a look at the following line from the preceding code example:
```
unnamed('Huxley', 3);
```

Now, compare it with this line:
```
duplicate('Mikey', times: 3);
```

In the first example, it isn't immediately clear what the purpose of each parameter is. In the second example, the times parameter immediately tells you that the text Mikey will be duplicated three times. This can go a long way with functions that have rather long parameter lists, where it can be difficult to remember the expected order of the parameters. Take a look at how this syntax is put to work in the Flutter framework:
```
Container(
  margin: const EdgeInsets.all(10.0), 
  color: Colors.red, 
  height: 48.0,
  child: Text('Named parameters are great!'),
)
```

This isn't even all the properties that are available for containers – it can get much longer. Without named parameters, this sort of syntax could be almost impossible to read.

> Type annotation for Dart functions is optional.
{.is-success}
 

You can completely omit it if you are so inclined. However, for any parameter or even function name that does not have type annotation, Dart will assume that it is of the dynamic type. Since we would like to exploit Dart's type system for all it's worth, dynamic types should be avoided. That is why we always strive to add the void keyword in front of any function that doesn't return a value.

# How to use functions as variables with closures

Closures, also known as first-class functions, are an interesting language feature that emerged from lambda calculus in the 1930s. The basic idea is that a function is also a value that can be passed around to other functions as a parameter. These types of functions are called closures, but there is really no difference between a function and a closure.

Closures can be saved to variables and used as parameters for other functions. They are even written inline when consuming a function that expects a closure as a property.

# Getting ready

To follow along with this recipe, you can write the code in DartPad, or add the code to the existing project you created in the previous recipe, both in a new file or in the main.dart file. 

# How to do it...

To implement a closure in Dart, follow these steps:

1. To add a closure to a function, you have to essentially define another function signature inside a function:
```
void callbackExample(void callback(String value)) {
  callback('Hello Callback');
}
```

2. Defining closures inline can get quite verbose. To simplify this, Dart uses the typedef keyword to create a custom type alias that will represent the closure. Let's create a typedef called NumberGetter, which will be a function that returns an integer:
```
typedef NumberGetter = int Function();

```

3. The following function will take in a NumberGetter as its parameter and invoke it in its function:
```
int powerOfTwo(NumberGetter getter) {
 return getter() * getter();
}
```

4. Let's put this all together with a function that will use all these closure examples:
```
void consumeClosure() {
 final getFour = () => 4;
 final squared = powerOfTwo(getFour);
 print(squared);

 callbackExample((result) {
 print(result);
 });
}
```

5. Finally, add an invocation to consumeClosure at the top of the playground method or in your main method:
```
  consumeClosure();
```

# How it works...

A modern programming language wouldn't be complete without closures, and Dart is no exception. To oversimplify this, a closure is a function that is saved to a variable that can be called later. They are often used for callbacks, such as when the user taps a button or when the app receives data from a network call.

We showed two ways to define closures in this recipe:

- Function prototypes
- typedefs

The easiest and most maintainable way to work with closures is with the typedef keyword. This is especially true if you are planning on reusing the same closure type multiple times; then, using typedefs will make your code more succinct:
```
typedef NumberGetter = int Function();
```

This defines a closure type called NumberGetter, which is a function that is expected to return an integer:
```
int powerOfTwo(NumberGetter getter) {
  return getter() * getter();
}
```

The closure type is then used in this function, which will call the closure twice and then multiply the result:
```
final getFour = () => 4;
final squared = powerOfTwo(getFour);
```

In this line, we call the function and provide our closure, which returns the number 4. This code also uses the fat arrow syntax, which allows you to write any function that takes up a single line without braces. For single-line functions, you can use the arrow syntax, =>, instead of brackets. 

The getFour line without the arrow is equivalent to writing the following:
```
final getFour = () {
  return 4;
};
// this is the same as: final getFour = () => 4;
```

Arrow functions are very helpful for removing unneeded syntax, but they should only be used for simple statements. For complex functions, you should use the block function syntax.

Closures are probably one of the most cognitively difficult programming concepts. It may seem awkward to use them at first, but the only way for it to become natural is to practice using them several times. 

## Creating classes and using the class constructor shorthand

Classes in Dart are not dramatically different from what you would find in other object-oriented programming (OOP) languages. The main differences have more to do with what is missing rather than what has been added. Dart can fully support most OOP paradigms, but it can also do so without a large number of keywords. Here are a few examples of some common keywords that are generally associated with OOP that are not available in Dart:

- private
- protected
- public
- struct
- interface
- protocol

It may take a while to let go of using these, especially for longtime adherents of OOP, but you don't need any of these keywords and you can still write type-safe encapsulated, object-oriented code.

In this recipe, we're going to define a class hierarchy around formal and informal names.

# Getting ready

As with the other recipes in this chapter, create a new file in your existing project or add your code in DartPad.

# How to do it...

Let's start building our own custom types in Dart:

1. First, define a class called Name, which is an object that stores a person's first and last names:
```
class Name {
 final String first;
 final String last;

 Name(this.first, this.last);


 @override
 String toString() {
 return '$first $last';
 }
}
```

2. Now, let's define a subclass called OfficialName. This will be just like the Name class, but it will also have a title:
```
class OfficialName extends Name {
 // Private properties begin with an underscore
 final String _title;
 
 // You can add colons after constructor
 // to parse data or delegate to super
 OfficialName(this._title, String first, String last)
 : super(first, last);

 @override
 String toString() {
   return '$_title. ${super.toString()}';
 }
}
```

3. Now, we can see all these concepts in action by using the playground method:
```
void classPlayground() {
  final name = OfficialName('Mr', 'Francois', 'Rabelais');
  final message = name.toString();
  print(message);
}
```

4. Finally, add a call to classPlayground in the main method:
```
main() {
  ...
  classPlayground();
}
```

# How it works...

Just like functions, Dart implements the expected behavior for classical object-oriented programming.

In this recipe, you used inheritance, which is a building block of OOP. Consider the following class declaration:
```
class OfficialName extends Name {
...
```

This means that OfficialName inherits all the properties and methods that are available in the Name class, and may add more or override existing ones.

One of the more interesting syntactical features in Dart is the constructor shorthand. This allows you to automatically assign members in constructors by simply adding the this keyword, which is demonstrated in the Name class, as shown in the following code block:
```
const Name(this.first, this.last);
```

The Dart plugin for Android Studio and Visual Studio Code also has a handy shortcut for generating constructors, so you can make this process go even faster. Try deleting the constructors from the Name class. You should see red underlines underneath the first and last properties. Move your cursor to one of those properties (it doesn't matter which one) and press Option + Enter:

![Figure3.2-Create constructor for final fields ](/flutter_cookbook_img/figure3.2-create_constructor_for_final_fields.webp)

You should see a popup appear that generates constructions for final fields. If you hit Enter, your constructor will appear without you having to type anything. It's convenient.

# The building blocks of OOP

Where Dart does deviate from other OOP languages, such as Java, C#, Kotlin, and Swift, is its lack of explicit keywords for interfaces and abstract classes. In Dart, objects are more defined by how they are used rather than how they are defined.

There are three keywords for building relationships among classes:

| extends	| Class Inheritance Use this keyword with any class where you want to extend the superclass's functionality. A class can only extend one class. Dart does not support multiple inheritance. |
|:---:|:---:|
| implements	| Interface Conformance You can use implements when you want to create your own implementation of another class, as all classes are implicit interfaces. When the FullName class implements the Name class, all the functions that were defined in the Name class must be implemented. This means that when you implement a class, you do not inherit any code, just the type.  Classes can implement any number of interfaces, but be reasonable and don't make that list too long. |
| with	| Apply Mixin In Dart, a class can only extend another class. Mixins allow you to reuse a class's code in multiple class hierarchies. This means that mixins allow you to get blocks of code without needing to create subclasses. |

> Dart 2.1 added the mixin keyword to the language. Previously, mixins were also just abstract classes, and they can still be used in that manner if desired.
{.is-info}

# See also

This recipe touched on a bunch of topics that warrant more detail:

- Design Patterns: Elements of Reusable Object-Oriented Software: Affectionately referred to as the "Gang of Four." This is the quintessential book about design patterns: https://www.pearson.com/us/higher-education/program/Gamma-Design-Patterns-Elements-of-Reusable-Object-Oriented-Software/PGM14333.html.
- Mastering Dart: https://subscription.packtpub.com/book/web_development/9781783989560.

# How to group and manipulate data with collections

All programming languages possess some mechanism to organize data. We've already covered the most common way – objects. These class-based structures allow you, the programmer, to define how you want to model your data and manipulate it with methods.

If you want to model groups of similar data, collections are your solution. A collection contains a group of elements. There are many types of collections in Dart, but we are going to focus on the three most popular ones: List, Map, and Set.

- Lists are linear collections where the order of the elements is maintained. 
- Maps are a non-linear collection of values that can be accessed by a unique key.
- Sets are a non-linear collection of unique values where the order is not maintained.

These three main types of collections can be found in almost every programming language, but sometimes by a different name. If Dart is not your first programming language, then this matrix should help you correlate collections to equivalent concepts in other languages:

| Dart	| Java	| Swift	| JavaScript |
|:---|:---|:---|:---|
| List	| ArrayList	| Array	| Array |
| Map	| HashMap	| Dictionary	| Object |
| Set	| HashSet	| Set	| Set |

# Getting ready

Create a new file in your project or type this code in Dartpad. 

# How to do it...

Follow these steps to understand and use Dart collections:

1. Create the playground function that will call the examples for each collection type we're going to cover:
```
void collectionPlayground() {
  listPlayground();
  mapPlayground();
  setPlayground();
  collectionControlFlow();
}
```

2. First up is Lists, more commonly known as arrays in other languages. This function shows how to declare, add, and remove data from a list:
```
void listPlayground() {
  // Creating with list literal syntax
  final List<int> numbers = [1, 2, 3, 5, 7];

  numbers.add(10);
  numbers.addAll([4, 1, 35]);

  // Assigning via subscript
  numbers[1] = 15;

  print('The second number is ${numbers[1]}');

  // enumerating a list
  for (int number in numbers) {
    print(number);
  }
}
```

3. Maps store two points of data per element – a key and a value. Keys are used to write and retrieve the values stored in the list. Add this function to see Map in action:
```
void mapPlayground() {
 // Map Literal syntax
 final MapString, int ages = {
 'Mike': 18,
 'Peter': 35,
 'Jennifer': 26,
 };

 // Subscript syntax uses the key type.
 // A String in this case
 ages['Tom'] = 48;

 final ageOfPeter = ages['Peter'];
 print('Peter is $ageOfPeter years old.');

 ages.remove('Peter');

 ages.forEach((String name, int age) {
 print('$name is $age years old');
 });
}
```

4. Sets are the least common collection type, but still very useful. They are used to store values where the order is not important, but all the values in the collection must be unique. The following function shows how to use sets:
```
void setPlayground() {
 // Set literal, similar to Map, but no keys
 final final Set<String> ministers = {'Justin', 'Stephen', 'Paul', 'Jean',  'Kim', 'Brian'};
 ministers.addAll({'John', 'Pierre', 'Joe', 'Pierre'}); //Pierre is a  duplicate, which is not allowed in a set.

 final isJustinAMinister = ministers.contains('Justin');
 print(isJustinAMinister);

 // 'Pierre' will only be printed once
 // Duplicates are automatically rejected
 for (String primeMinister in ministers) {
   print('$primeMinister is a Prime Minister.');
 }
}
```

5. Another Dart feature is the ability to include control flow statements directly in your collection. This feature is also one of the few examples where Flutter directly influences the direction of the language. You can include if statements, for loops, and spread operators directly inside your collection declarations. We will be using this style of syntax extensively when we get to Flutter in the next chapter. Add this function to get a feel for how control flows work on more simplistic data:
```
void collectionControlFlow() {
  final addMore = false;
  final randomNumbers = [
    34,
    232,
    54,
    32,
    if (addMore) ...[
      534343,
      4423,
      3432432,
    ],
  ];

  final duplicated = [
    for (int number in randomNumbers) number * 2,
  ];

  print(duplicated);
}
```

# How it works...

Each of these examples shows elements in collections that can be added, removed, and enumerated. When choosing which collection type to use, there are three questions you need to answer:

- Does the order matter? Choose a List.
- Should all the elements be unique? Choose a Set.
- Do you need to access elements from a dataset quickly? Choose a Map.

Of these three types, Set is probably the most underused collection, but you should not dismiss it so easily. Since sets require elements to be unique and they don't have to maintain an explicit order, they can also be significantly faster than lists. For relatively small collections (~100 elements), you will not notice any difference between the two, but once the collections grow (~10,000 elements), the power of a set will start to shine. You can explore this further by looking into big-O notation, a method of measuring the speed of a computer algorithm.

# Subscript syntax

One thing these collections have in common is subscript syntax. Subscripts are a way to quickly access elements in a collection, and they tend to work identically from language to language:
```
numbers[1] = 15;
```

The preceding line assigns the second value in the numbers list to 15. Lists in Dart use a zero offset to access the element. If the list is 10 elements long, then element 0 is the first element and element 9 is the last. If you were to try and access element 10, then your app would throw an out of bounds exception because element 10 does not exist.

Sometimes, it is safer to use the first and last accessors on the list instead of accessing the element directly:
```
final firstElement = numbers.first;
final lastElement = numbers.last;
```

Note that if your set is empty, first and last will throw an exception as well:
```
final List mySet = [];
print (mySet.first); //this will throw a Bad state: No element error
```

For maps, you can access the values with strings instead of integers:
```
ages['Tom'] = 48;
final myAge = ages['Brian']; //This will be null 
```

However, unlike arrays, if you try to access a value with a key that is not on the map, then it will just gracefully fail and return null. It will not throw an exception.

# There's more...

One exciting language feature that was added to Dart in version 2.3 is the ability to put control flows inside collections. This will be of particular importance when we start digging into Flutter build methods.

These operators work mostly like their normal control flow counterparts, except you do not add brackets and you only get a single line to yield a new value in the collection:
```
  final duplicated = [
    for (int number in randomNumbers) number * 2,
  ];
```

In this example, we are iterating through the randomNumbers list and yielding double the value. Notice that there is no return statement; the value is immediately added to the list.

However, the single line requirement can be very restrictive. To remedy this, Dart has also borrowed the spread operator from JavaScript:
```
final randomNumbers = [
  34,
  232,
  54,
  32,
  if (addMore) ...[
    534343,
    4423,
    3432432,
  ],
];
```

By putting the three dots before the sublist, Dart will unbox the second list and flatten all these numbers into a single list. You can use this technique to add more than one value inside a collection-if or collection-for statement. Spread operators can also be used anywhere you wish to merge lists; they are not limited to collection-if and collection-for.

# See also

Refer to these resources for a more in-depth explanation of collections:

- Collection library: https://api.dartlang.org/stable/2.4.0/dart-collection/dart-collection-library.html
- Big-O notation: https://en.wikipedia.org/wiki/Big_O_notation
- Article on Dart 2.3: https://medium.com/dartlang/announcing-dart-2-3-optimized-for-building-user-interfaces-e84919ca1dff

## Writing less code with higher-order functions

If there was a different name we could give programmers, it would be Data Massager. Essentially, that is all we do. Our apps receive data from a source, be it a web service or some local database, and then we transform that data into user interfaces where we can collect more information and then send it back to the source. There is even an acronym for this – Create, Read, Update, and Delete (CRUD).

Throughout your life as a programmer, you will spend most of your time writing CRUD code. It doesn't matter if you are working with 3D graphics or training machine learning models – CRUD will consume the majority of your life.

Being able to manipulate mass quantities of data quickly, your standard control flows, along with your repertoire of do, while, and for loops isn't going to cut it. Instead, we should use higher-order functions, one of the primary aspects of functional programming, to help us get to the fun stuff faster.

# Getting ready

Create a new file in your project or type this code in Dartpad.

# How to do it...

Higher-order functions can be divided into categories. This recipe will explore all their different facets. Let's get started:

1. Define the playground function that will define all the other types of higher-order functions that this recipe will cover:
```
import 'package:introduction_to_dart/04-classes.dart';

void higherOrderFunctions() {
 final names = mapping();
 names.forEach(print);

 sorting();
 filtering();
 reducing();
 flattening();
}
```

2. Create a global variable called data that contains all the content that we will manipulate. 

> You can create a global variable by adding it to the top of the file where you are working. In DartPad, just add it to the top of the screen, before the main method. If you are in a project, you can also add it to the top of the main.dart file.
{.is-success}

	The data in the following code block is random. You can replace this with whatever content you want:
```
List<Map> data = [
 {'first': 'Nada', 'last': 'Mueller', 'age': 10},
 {'first': 'Kurt', 'last': 'Gibbons', 'age': 9},
 {'first': 'Natalya', 'last': 'Compton', 'age': 15},
 {'first': 'Kaycee', 'last': 'Grant', 'age': 20},
 {'first': 'Kody', 'last': 'Ali', 'age': 17},
 {'first': 'Rhodri', 'last': 'Marshall', 'age': 30},
 {'first': 'Kali', 'last': 'Fleming', 'age': 9},
 {'first': 'Steve', 'last': 'Goulding', 'age': 32},
 {'first': 'Ivie', 'last': 'Haworth', 'age': 14},
 {'first': 'Anisha', 'last': 'Bourne', 'age': 40},
 {'first': 'Dominique', 'last': 'Madden', 'age': 31},
 {'first': 'Kornelia', 'last': 'Bass', 'age': 20},
 {'first': 'Saad', 'last': 'Feeney', 'age': 2},
 {'first': 'Eric', 'last': 'Lindsey', 'age': 51},
 {'first': 'Anushka', 'last': 'Harding', 'age': 23},
 {'first': 'Samiya', 'last': 'Allen', 'age': 18},
 {'first': 'Rabia', 'last': 'Merrill', 'age': 6},
 {'first': 'Safwan', 'last': 'Schaefer', 'age': 41},
 {'first': 'Celeste', 'last': 'Aldred', 'age': 34},
 {'first': 'Taio', 'last': 'Mathews', 'age': 17},
];
```

3. For this example, we will use the Name class, which we implemented in a previous section of this chapter:
```
class Name {
 final String first;
 final String last;

 Name(this.first, this.last);


 @override
 String toString() {
 return '$first $last';
 }
}
```

4. The first higher-order function is map. Its purpose is taking data in one format and quickly outputting it in another format. In this example, we're going to use the map function to transform the raw Map of key-value pairs into a list of strongly typed names:
```
List<Name> mapping() {
 // Transform the data from raw maps to a strongly typed model
 final names = data.map<Name>((Map rawName) {
 final first = rawName['first'];
 final last = rawName['last'];
 return Name(first, last);
 }).toList();

 return names;
}
```

5. Now that the data is strongly typed, we can take advantage of the known schema to sort the list of names. Add the following function to use the sort function in order to alphabetize the names with just a single line of code:
```
void sorting() {
 final names = mapping();

 // Alphabetize the list by last name
 names.sort((a, b) => a.last.compareTo(b.last));

 print('');
 print('Alphabetical List of Names');
 names.forEach(print);
}
```

6. You will often run into scenarios where you need to pull out a subset of your data. The following higher-order function will return a new list of names that only begin with the letter M:
```
void filtering() {
 final names = mapping();
 final onlyMs = names.where((name) => name.last.startsWith('M'));

 print('');
 print('Filters name list by M');
 onlyMs.forEach(print);
}
```

7. Reducing a list is the act of deriving a single value from the entire collection. In the following example, we're going to reduce to help calculate the average age of all the people on the list:
```
void reducing() {
  // Merge an element of the data together
  final allAges = data.map<int>((person) => person['age']);
  final total = allAges.reduce((total, age) => total + age);
  final average = total / allAges.length;

  print('The average age is $average');
}
```

8. The final tool solves the problem you may encounter when you have collections nested within collections and need to remove some of that nesting. This function shows how we can take a 2D matrix and flatten it into a single linear list:
```
void flattening() {
  final matrix = [
    [1, 0, 0],
    [0, 0, -1],
    [0, 1, 0],
  ];

  final linear = matrix.expand<int>((row) => row);
  print(linear);
}
```

# How it works...

Each of these functions operates on a list of data and executes a function on each element in this list. You can achieve the exact same result with for loops, but you will have to write a lot more code.

# Mapping

In the first example, we used the map function. map expects you to take the data element as the input of your function and then transform it into something else. It is very common to map some JSON data that your app received from an API to a strongly typed Dart object:
```
// Without the map function, we would usually write
// code like this
final names = <Name>[];
for (Map rawName in data) {
  final first = rawName['first'];
  final last = rawName['last'];
  final name = Name(first, last);
  names.add(name);
}

// But instead it can be simplified and it can
// actually be more performant on more complex data
final names = data.map<Name>((Map rawName) {
  final first = rawName['first'];
  final last = rawName['last'];
  return Name(first, last);
}).toList();
```

Both samples achieve the same result. In the first option, you create a list that will hold the names. Then, you iterate through each entry in the data list, extract the elements from Map, initialize a named object, and then add it to the list.

The second option is certainly easier for the developer. Iterating and adding are delegated to the map function. All you need to do is tell the map function how you want to transform the element. In this case, the transformation was extracting the values and returning a Name object. map is also a generic function. Consequently, you can add some typing information – in this case, <Name> – to tell Dart that you want to save a list of names, not a list of dynamics.

This example is also purposefully verbose, although you could simplify it even more:
```
final names = data.map<Name>(
  (raw) => Name(raw['first'], raw['last']),
).toList();
```

This may not seem like a big deal for this simple example, but when you need to parse complex graphs of data, these techniques can save you a lot of work and time.

# Sorting

The second higher-order function you saw in action is sort. Unlike the other functions in this recipe, sort in Dart is a mutable function, which is to say, it alters the original data. Pure functions are supposed to simply return new data, so this one is an exception.

A sort function follows this signature:
```
int sortPredicate<T>(T elementA, T elementB);
```

The function will get two elements in the collection and it is expected to return an integer to help Dart figure out the correct order:

| -1	| Less Than |
|:---|:---|
| 0	| Same |
| 1	| Greater Than |

In our example, we delegated to the string's compareTo function, which will return the correct integer. All this can be accomplished with a single line:
```
names.sort((a, b) => a.last.compareTo(b.last));
```

# Filtering

Another common task that can be succinctly solved with higher-order functions is filtering. There are several cases where you or your users are only interested in a subset of your data. In these cases, you can use the where() function to filter your data:
```
final onlyMs = names.where((name) => name.last.startsWith('M'));
```

This line iterates through every element in the list and returns true or false if the last name starts with an "M." The result of this instruction will be a new list of names that only contains the filtered items.

For higher-order functions that expect a function that returns a Boolean, you can refer to the provided function as either a test or a predicate.

where() is not the only function that filters data. There are a few others, such as firstWhere(), lastWhere(), singleWhere(), indexWhere(), and removeWhere(), which all accept the same sort of predicate function.

# Reducing

Reducing is the act of taking a collection and simplifying it down to a single value. For a list of numbers, you might want to use the reduce function to quickly calculate the sum of those numbers. For a list of strings, you can use reduce to concatenate all the values.

A reduce function will provide two parameters, the previous result, and the current elements: 
```
final total = allAges.reduce((total, age) => total + age);
```

The first time this function runs, the total value will be 0. The function will return 0 plus the first age value, 10. In the second iteration, the total value will 10. That function will then return 10 + 9. This process will continue until all the elements have been added to the total value.

Since higher-order functions are mostly abstractions on top of loops, we could write this code without the reduce function, like so:
```
int sum = 0;
for (int age in allAges) {
  sum += age;
}
```

Just like with where(), Dart also provides alternative implementations of reduce that you may want to use. The fold() function allows you to provide an initial value for the reducer. This is helpful for non-numeric types such as strings or if you do not want your code to start reducing from 0:
```
final oddTotal = allAges.fold<int>(-1000, (total, age) => total + age);
```

# Flattening

The purpose of the expand() function is to look for nested collections inside your collection and flatten them into a single list. This is useful when you need to start manipulating nested data structures, such as a matrix or a tree. There, you will often need to flatten the collection as a data preparation step, before you can extract useful insights from the values:
```
final matrix = [
  [1, 0, 0],
  [0, 0, -1],
  [0, 1, 0],

];

final linear = matrix.expand<int>((row) => row);
```

In this example, every element in the matrix list is another list. The expand function will loop through every element, and if the function returns a collection, it will destructure that collection into a linear list of values.

# There's more...

There are two interesting lines in this recipe that we should pay attention to on top of explaining the higher-order functions:
```
// What is going on here?
names.forEach(print);

// Why do we have to do this?
.toList();
```

# First-class functions

names.forEach(print); implements a pattern called first-class functions. This pattern dictates that functions can be treated just like any other variable. They can be stored as closures or even passed around to different functions.

The forEach() function expects a function with the following signature: 
```
void Function<T>(T element)
```

The print() function has the following signature: 
```
void Function(Object object)
```

Since both of these expect a function parameter and the print function has the same signature, we can just provide the print function as the parameter! 
```
// Instead of doing this
data.forEach((value) {
  print(value);
});

// We can do this
data.forEach(print);
```

This language feature can make your code more readable. 

# Iterables and chaining higher-order functions

If you inspected the source code of the map and where functions, you probably noticed that the return type of these functions is not a List, but another type called Iterable. This abstract class represents an intermediary state before you decide what concrete data type you want to store. It doesn't necessarily have to be a List. You can also convert your iterable into a Set if you want.

The advantage of using iterables is that they are lazy. Programming is one of the only professions where laziness is a virtue. In this context, laziness means that the function will only be executed when it's needed, not earlier. This means that we can take multiple higher-order functions and chain them together, without stressing the processor with unnecessary cycles.

We could reduce the sample code even further and add more functions for good measure:
```
final names = data
    .map<Name>((raw) => Name(raw['first'], raw['last']))
    .where((name) => name.last.startsWith('M'))
    .where((name) => name.first.length > 5)
    .toList(growable: false);
```

Each of these functions is cached in our Iterable and only runs when you make the call to toList(). Here, you are serializing the data in a model, checking whether the last name starts with M, and then checking whether the first name is longer than five letters. This is executed in a single iteration through the list!

# See also

Check out these resources for more information on higher-order functions:

- Iterable documentation: https://api.dart.dev/stable/2.4.0/dart-core/Iterable-class.html
- Top 10 Array Utility Methods, by Jermaine Oppong: https://codeburst.io/top-10-array-utility-methods-you-should-know-dart-feb2648ee3a2

# How to take advantage of the cascade operator

So far, we've covered how Dart follows many of the same patterns of other modern languages. Dart, in some ways, is the culmination of the best ideas from multiple languages – you have the expressiveness of JavaScript and the type safety of Java. Dart can be interpreted as JIT, but it can also be compiled.

However, there are some features that are unique to Dart. One of those features is the cascade (..) operator.

# Getting ready

Before we dive into the code, let's diverge briefly to the builder pattern. Builders are a type of class whose only purpose is to build other classes. They are often used for complex objects with many properties. It can get to a point where standard constructors become impractical and unwieldy because they are too large. This is the problem the builder pattern solves. It is a special kind of class whose only job is to configure and create other classes.

This is how we would accomplish the builder pattern without the cascade operator:
```
class UrlBuilder {
  String _scheme;
  String _host;
  String _path;

  UrlBuilder setScheme(String value) {
    _scheme = value;
    return this;
  }

  UrlBuilder setHost(String value) {
    _host = value;
    return this;
  }

  UrlBuilder setPath(String value) {
    _path = value;
    return this;
  }

  String build() {
    assert(_scheme != null);
    assert(_host != null);
    assert(_path != null);

    return '$_scheme://$_host/$_path';
  }
}

void main() {
  final url = UrlBuilder()
      .setScheme('https')
      .setHost('dart.dev')
      .setPath('/guides/language/language-tour#cascade-notation-')
      .build();
  
  print(url);
}
```

This is very verbose. Dart can implement this pattern without any setup.

Create a new file in your project or type the code of this recipe in Dartpad.

# How to do it...

Let's continue with the aforementioned, less than optimal code and reimplement it with cascades:

1. Recreate the UrlBuilder class, but without any of the extra methods that are usually required to implement this pattern. This new class will not look that different from a mutable Dart object:
```
class UrlBuilder {
  String scheme;
  String host;
  List<String> routes;

  @override
  String toString() {
    assert(scheme != null);
    assert(host != null);
    final paths = [host, if (routes != null) ...routes];
    final path = paths.join('/');

    return '$scheme://$path';
  }
}
```

2. Next, you are going to use the cascade operator to get the builder pattern for free. Write this function just after the declaration of the UrlBuilder class:
```
void cascadePlayground() {
  final url = UrlBuilder()
    ..scheme = 'https'
    ..host = 'dart.dev'
    ..routes = [
      'guides',
      'language',
      'language-tour#cascade-notation-',
    ];

  print(url);
}
```

3. The cascade operator is not exclusively used for the builder pattern. It can also be used to, well, cascade similar operations on the same object. Add the following code inside the cascadePlayground function:
```
final numbers = [342, 23423, 53, 232, 534]
    ..insert(0, 10)
    ..sort((a, b) => a.compareTo(b));
  
  print('The largest number in the list is ${numbers.last}');
```

# How it works...

Cascades are pretty elegant. They allow you to chain methods together that were never intended to be chained. Dart is smart enough to know that all these consecutive lines of code are operating on the same object. Let's pick apart the numbers example:
```
final numbers = [342, 23423, 53, 232, 534]
    ..insert(0, 10)
    ..sort((a, b) => a.compareTo(b));
```

Both the insert and sort methods are void functions. Declaring these objects with cascades simply allows you to remove the call to the numbers object:
```
final numbers = [342, 23423, 53, 232, 534];
numbers.insert(0, 10);
numbers.sort((a, b) => a.compareTo(b));
```

With the cascade operator, you can merge unrelated statements in a simple fluent chain of function calls.

In our example, UrlBuilder is just a plain old Dart object. 

Without the cascade operator, we would have to write the same builder code like this:
```
final url = UrlBuilder();
url.scheme = 'https';
url.host = 'dart.dev';
url.routes = ['guides', 'language', 'language-tour#cascade-notation-'];
```

But with cascades, that code can now be simplified, like so:
```
final url = UrlBuilder()
    ..scheme = 'https'
    ..host = 'dart.dev'
    ..routes = ['guides', 'language', 'language-tour#cascade-notation-']; 
```

Notice that this was accomplished without changing a single line in our class. 

# See also

The following resources will help you to understand cascades and the builder pattern:

- Builder pattern: https://en.wikipedia.org/wiki/Builder_pattern
- Method cascades in Dart: https://news.dartlang.org/2012/02/method-cascades-in-dart-posted-by-gilad.html

# Understanding Dart Null Safety

When Dart 2.12 was shipped in Flutter 2 in March 2021, an important language feature was added that impacts how you should view null values for your variables, parameters and fields: this is the sound null safety.

Generally speaking, variables that have no value are null, and this may lead to errors in your code. If you have been programming for any length of time, you are probably already familiar with null exceptions in your code. The goal of null safety is to help you prevent execution errors raised by the improper use of null.

With null safety, by default, your variables cannot be assigned a null value.

There are obviously cases when you want to use null, but you have to explicitly allow null values in your apps. In this recipe, you will see how to use null safety to your advantage, and how to avoid null safety errors in your code.

# Getting ready

Create a new pad in Dartpad. This is required to easily turn null safety on and off.

# How to do it...

Let's see an example of null unsafe code, and then fix it. To do that, follow these steps: 

1. In DartPad, make sure Null Safety is disabled. You can toggle Null Safety with the control at the bottom of the screen:

![Figure3.3-Null Safety is disabled ](/flutter_cookbook_img/figure3.3-null_safety_is_disabled.png)

2. Remove the default code in the main method, and add the following instructions:
```
void main() {
 int someNumber;
 increaseValue(someNumber);
}
```

3. Create a new method under main that takes an integer and prints the value that was passed, incremented by 1:
```
void increaseValue(int value) {
 value++;
 print (value);
}

```

4. Run your code. You should see a null error in the console, as shown in the following screenshot:

![Figure3.4-null error in the console ](/flutter_cookbook_img/figure3.4-null_error_in_the_console.png)

5. Enable Null Safety with the switch at the bottom of the screen, and note that someNumber at line 3 raises a compile error before execution on someNumber: "The non-nullable local variable 'someNumber' must be assigned before it can be used." 
6. Add a question mark after the two int delcarations:
```
void main() {
 int? someNumber;
 increaseValue(someNumber);
}

void increaseValue(int? value) {
 value++;
 print (value);
}
```

7. Note that the error has changed to: "The method '+' can't be unconditionally invoked because the receiver can be 'null'."
8. Edit the increaseValue method, so that you check whether the value is null before incrementing it, otherwise you just return 1:
```
void increaseValue(int? value) {
 if (value != null) {
   value++; 
 } else {
   value = 1;
 }
 print (value);
} 
```

9. Run the app and note that you find the value 1 in the console. 
10. Edit the increaseValue method again. This time, use the null-check operator:
```
void increaseValue(int? value) {
 value = value ?? 0;
 value++; 
 print (value);
} 
```

11. Run the app, and note that in the console you still find the value 1.
12. Remove the question mark from the value parameter, and force the call to increaseValue with an exclamation mark: 
```
void main() {
 int? someNumber;
 increaseValue(someNumber!);
}

void increaseValue(int value) {
 value++; 
 print (value);
}
```

13. Run the app, and note that you get an execution null exception.
14. Finally, fix the code by initializing someNumber with an integer value:
```
void main() {
 int someNumber = 0;
 increaseValue(someNumber);
}

void increaseValue(int value) {
 value++; 
 print (value);
}
```

15. Now you should see the value 1 in the console again.

# How it works...

The main reason behind the addition of null safety in Dart is that errors caused by unexpected null values are frequent and not always easy to debug.

> At the time of writing, not all parts of the Flutter SDK are null safe yet. Some packages are also null safe.
{.is-success}

You can still implement null safety in your apps while using null unsafe packages. 

In the first code snippet, which you run without null safety, the code raised a runtime error at the following instruction:
```
value++ 
```

This is because you cannot increment a null value. 

Simply put, when you enable null safety, by default you cannot assign a null value to any variable, field, or parameter. For instance, in the following code snippet, the second line will prevent your app from compiling:
```
int someNumber = 42; //this is ok
int someOtherNumber = null; //compile error
```

In most cases, this should not impact your code. Actually, consider the last code snippet that you wrote for this recipe, which is as follows: 
```
void main() {
 int someNumber = 0;
 increaseValue(someNumber);
}

void increaseValue(int value) {
 value++; 
 print (value);
}
```

This is null safe code that should cover most of the scenarios. Here you make sure that a variable actually has a value as follows:
```
int someNumber = 0; 
```

So when you pass someNumber to the function, you (and the compiler) can be sure that the value parameter will contain a valid integer, and not null.

There are cases though where you may need to use null values and, of course, Dart and Flutter allow you to do that. Only, you must be explicit about it. In order to make a variable, field, or parameter nullable, you can use a question mark after the type:
```
int? someNumber;
```

With the preceding code, someNumber becomes nullable, and therefore you can assign a null value to it. 

Dart will still not compile the following code though:
```
void main() {
 int? someNumber;
 increaseValue(someNumber);
}

void increaseValue(int? value) {
 value++;
 print (value);
}
```

This is probably the most interesting part of this recipe: someNumber is explicitly nullable, and so is the value parameter, but still this code will not compile. The Dart parser is smart enough to note that when you write value++, you risk an error, as value can be null, and therefore you are required to check whether value is null before incrementing it. The most obvious way to do this is with an if statement:
```
if (value != null) {
   value++; 
 } else {
   value = 1;
 }
```

But this may add several lines of code to your projects.

Another more concise way to achieve the same result is to use the null-coalescing operator, which you write with a double question mark:
```
value = value ?? 0;
```

In the preceding instruction, value takes 0 only if value itself is null, otherwise it keeps its own value.

Another very interesting code snippet we used in this recipe is the following:
```
void main() {
 int? someNumber;
 increaseValue(someNumber!);
}

void increaseValue(int value) {
 value++; 
 print (value);
}
```

In the preceding code, someNumber may be null (int? someNumber), but the value parameter cannot (int value). The exclamation mark (someNumber!) will explicitly force the value parameter to accept someNumber. Basically, here you are telling the compiler, "Don't worry, I will make sure someNumber is valid, so do not raise any error." And after running the code, you get a runtime error. 

Implementing null safety is a good way to write code. The main issue with this new (at the time of writing) feature is that not all libraries have been migrated to null safety yet, so you might still get unexpected null values in your code when you use them. Once this transition period is over though, we might expect Flutter apps to be more solid and secure.

# See also

A thorough and complete resource to understanding null safety in Dart and Flutter is available at https://flutter.dev/docs/null-safety.
