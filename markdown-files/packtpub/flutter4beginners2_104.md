원본 제목: Chapter 4: Dart Classes and Constructs
원본 링크: https://www.packtpub.com/product/flutter-for-beginners-second-edition/9781800565999
Path:
packtpub/flutter4beginners2/104
Title:
104 Dart Classes and Constructs
Short Description:
Flutter for Beginners Second Edition 다트 클래스 및 구성

![Figure 4.1 - Two Isolates in parallel ](/flutter4beginners2/figure_4.1_-_two_isolates_in_parallel.jpg)
- cut line


# Chapter 4: Dart Classes and Constructs
Flutter for Beginners Second Edition

In this chapter, we will look at object-oriented programming (OOP) and how it is supported by the Dart language. We will start by looking at the core principles of OOP with relation to the Dart language, and then explore how to use OOP within Dart.

We will then take a deeper look at class definitions and how instances of a class are created, including an exploration of the constructor types available, which forms a key part of the way Flutter apps are coded. Additionally, we will look at how we store our code in files, and how to import code from other files.

Finally, we will look at some key Dart topics that are used throughout Flutter—generics and asynchronous programming. These will help with your understanding of the Flutter topics we will cover later in the book.

On completion of this chapter, you will have a solid foundational knowledge of Dart, which will set you in good stead as we move to a deeper exploration of Flutter.

We will cover the following topics in this chapter:

- Object orientation in Dart
- Understanding classes in Dart
- The enum type
- Using generics
- Asynchronous programming

# Technical requirements

In this chapter, we will explore the Dart classes and constructs. You can do this via DartPad or within your chosen integrated development environment (IDE), as discussed in the first chapter.

Either option will allow you to experiment with your code. If you choose to use your IDE, then you will need to ensure your system is configured correctly to run Dart programs. Please refer to Chapter 1, An Introduction to Flutter for details on how to ensure your system is ready to do this.

You can find the source code for this chapter on GitHub at https://github.com/PacktPublishing/Flutter-for-Beginners-Second-Edition/tree/main/hello_world/lib/chapter_04.

# Object orientation in Dart

As with most modern languages, Dart is designed to be object-oriented (OO). As initially mentioned in Chapter 2, An Introduction to Dart, OOP languages are based on the concept of objects that hold both data (called fields) and code (called methods). These objects are created from blueprints called classes that define the fields and methods an object will have.

For a deeper exploration of the fundamentals of OOP, it is worthwhile reading an excellent book named Learning Object-Oriented Programming by Gaston C. Hillar.

The terms discussed here may be new to you, but the key areas are covered in greater depth in the next sections of this chapter. Let's start with a brief overview of how Dart follows OOP principles.

## Objects and classes

The starting point of OOP—objects—are instances of defined classes. In Dart, everything is an object—that is, every value stored in a variable is an instance of a class. Additionally, all objects also extend the Object class, directly or indirectly. The following also applies:

- Dart classes can have both instance members (methods and fields) and class members (static methods and fields).
- Dart classes do not support constructor overloading, but you can use the flexible function argument specifications from the language (optional, positional, and named) to provide different ways to instantiate a class. Also, you can have named constructors to define alternatives. Giving names to your constructors allows you to have multiple constructors for a class, and also gives a clearer meaning to the reason why your class has multiple constructors.

## Other OOP artifacts

Besides class definitions, other important OOP artifacts are presented in the Dart language (we will delve deeper into each of these throughout this chapter), outlined as follows:

- Interface: This is a contract definition with a set of methods available on an object. Although there is no explicit interface type in Dart, we can achieve the interface purpose with abstract classes.
- Enumerated class: This is a special kind of class that defines a set of common constant values.
- Mixin: This is a way of reusing a class's code in multiple class hierarchies.

## Encapsulation

Dart does not have explicit access restrictions on fields and methods, unlike the famous keywords used in Java—protected, private, and public. In Dart, encapsulation occurs at the library level instead of at the class level (this will be discussed further in this following chapter). The following also applies:

- Dart creates implicit getters and setters for all fields in a class, so you can define how data is accessible to consumers and the way it changes.
- In Dart, if an identifier (ID) (that is, a class, class member, top-level function, or variable) starts with an underscore (_), it's private to its library where a library is normally the contents of a single file.

## Inheritance and composition

Inheritance allows us to extend a class definition to a more specialized type. In Dart, by simply declaring a class, we are implicitly extending the object type. The following also applies:

- Dart permits single direct inheritance. A class can only inherit from one other class, leading to a strict tree structure. This is similar in many other languages and can be very restrictive to class design, so Dart offers other options alongside inheritance, especially mixins.
- Dart has special support for mixins, which can be used to extend class functionalities without direct inheritance, simulating multiple inheritance and enabling easy reuse of code.
- Dart does not contain a final class directive, unlike other languages. This means that a class can always be extended.

## Abstraction

Following inheritance, abstraction is a process whereby we define a type and its essential characteristics, moving to specialized types from parent ones. The following also applies:

- Dart contains abstract classes that allow a definition of what something does/provides, without caring about how this is implemented.
- Dart has the powerful implicit interface concept, which also makes every class an interface, allowing it to be implemented by others without extending it.

## Polymorphism

Polymorphism is achieved by inheritance and can be regarded as the ability of an object to behave like another; for example, the int type is also a num type. The following also applies:

- Dart allows overriding parent methods to change their original behavior.
- Dart does not allow overloading in the way you may be familiar with. You cannot define the same method twice with different arguments. If required, you can simulate overloading by using flexible parameter definitions through optional and positional parameters, as was seen in the Functions and methods section of Chapter 2, An Introduction to Dart.

## Functions as objects

Dart is called a true object-oriented language. In Dart, even functions are objects, which means that you can do the following:

- Assign a function as a value of a variable and pass it as an argument to another function
- Return it as a result of a function as you would do with any other type, such as String and int

This is known as having first-class functions because they're treated the same way as other types.

So, now we know some of the fundamental principles of Dart, let's look at the core structure of the language.

# Understanding classes in Dart

If you are an experienced programmer or are already familiar with Java or similar languages, you can skip some parts of this chapter as it has many similarities with the typical OOP concepts, such as inheritance and encapsulation. Some ideas, in particular, are important to verify, even if you are already familiar with the majority of OOP features, such as how Dart manages and structures constructors.

In this section, we will look at what makes a Dart class, how you construct an instance of one using a constructor, and how your class can inherit from other classes. We will also explore ways to use classes such as abstract classes, interfaces, and mixins, and finally, look at how we share class code across our code base using files and imports.

## Class structure

Dart classes are declared by using the class keyword, followed by the class name, ancestor classes, and implemented interfaces. Then, the class body is enclosed by a pair of curly braces, where you can add class members, which includes the following:

- Fields: These are variables used to define the data an object can hold.
- Accessors: Getters and setters, as the name suggests, are used to access the fields of a class, where get is used to retrieve a value, and the set accessor is used to modify the corresponding value.
- Constructor: This is the creator method of a class where the object instance fields are initialized.
- Methods: The behavior of an object is defined by the actions it can take. These are the object functions.

Refer to the following small class definition example:

```
class Person {
  String? firstName;
  String? lastName;
  String getFullName() => "$firstName $lastName";
}
main() {
  Person somePerson = Person();
  somePerson.firstName = "Clark";
  somePerson.lastName = "Kent";
  print(somePerson.getFullName()); // prints Clark Kent
}
```

Now, let's take a look at the Person class declared in the preceding code sample and make some observations, as follows:

- We have not defined a constructor for the class, but, as you may have guessed, there's a default empty constructor (no arguments) already provided for us.
- To instantiate a class, we call the constructor invocation. Unlike in many OOP languages, there is no need to use the new keyword (although it is a reserved word and will appear in older code).
- The class does not have an ancestor class explicitly declared, but it does implicitly inherit from Object, as do all classes in Dart.
- The class has two fields, firstName and lastName, and a getFullName() method that concatenates both by using string interpolation and returning the result.
- The class does not have any get or set accessor declared, so how did we access firstName and lastName to mutate it? A default get/set accessor is defined for every field in a class.
- The dot class.member notation is used to access a class member, whatever it is—a method or a field (get/set).

Note the use of arrow notation on the getFullName() method. This is equivalent to writing the following:

```
String getFullName() {
  return "$firstName $lastName";
}
```

However, the arrow notation is more succinct and probably easier to read. We can make this even more readable using field accessors.

### Field accessors – getters and setters

As mentioned previously, getters and setters allow us to access a field on a class, and every field has these accessors, even when we do not define them. In the preceding Person example, when we execute somePerson.firstName = "Clark", we are calling the firstName field's set accessor and sending "Clark" as a parameter to it. Also, in the following example, the get accessor is used when we call the getFullName() method on the person, and it concatenates both names.

For example, we can modify our Person class to replace the old getFullName() method and add it as a getter, as demonstrated in the following code block:

```
class Person {
  String? firstName;
  String? lastName;
  String get fullName => "$firstName $lastName";
  String get initials => "${firstName[0]}. 
  ${lastName[0]}.";
}
main() {
  Person somePerson = new Person();
  somePerson.firstName = "Clark";
  somePerson.lastName = "Kent";
  print(somePerson.fullName);     // prints Clark Kent
  print(somePerson.initials);     // prints C. K.
  somePerson.fullName = "peter parker";
  // we have not defined a setter fullName so it doesn't 
     compile
}
```

The following important observations can be made regarding the preceding example:

- We could not have defined a getter or setter with the same field names firstName and lastName. This would give us a compile error, as the class member names cannot be repeated.
- We do not need to always define a get and set pair together, as you can see that we have only defined a fullName getter and not a setter, so we cannot modify fullName. (This results in a compilation error, as indicated previously.)

We could have also written a setter for fullName and defined the logic behind it to set firstName and lastName based on that, as illustrated in the following code snippet:

```
class Person {
  // ... class fields definition
  set fullName(String fullName) {
    var parts = fullName.split(" ");
    this.firstName = parts.first; this.lastName = 
      parts.last;
  }
}
```

This way, someone could initialize a person's name by setting fullName, and the result would be the same. (Of course, we have not carried out any checks to establish whether the value passed as fullName is valid—that is, not empty, with two or more values, and so on.)

### Static fields and methods

As you already know, fields are nothing more than variables that hold object values, and methods are simple functions that represent object actions. In some cases, you may want to share a value or method between all of the object instances of a class. For this use case, you can add the static modifier to them, as follows:

```
class Person {
  // ... class fields definition
  static String personLabel = "Person name:";
  String get fullName => "$personLabel $firstName 
    $lastName";
  // modified to print the new static field "personLabel"
}
```

Hence, we can change the static field value directly on the class, as follows:

```
main() {
  Person somePerson = Person();
  somePerson.firstName = "Clark";
  somePerson.lastName = "Kent";
  Person anotherPerson = Person();
  anotherPerson.firstName = "Peter";
  anotherPerson.lastName = "Parker";
  print(somePerson.fullName); // prints Person name: Clark 
    kent
  print(anotherPerson.fullName); // prints Person name: 
    Peter Parker
  Person.personLabel = "name:";
  print(somePerson.fullName); // prints name: Clark Kent
  print(anotherPerson.fullName); // prints name: Peter 
    Parker
}
```

The static fields are associated with the class, rather than any object instance. The same goes for the static method definitions. For example, we can add a static method to encapsulate the name printing, as demonstrated in the following code block:

```
class Person {
  // ... class fields definition
  static String personLabel = "Person name:";
  static void printsPerson(Person person) {
    print("$personLabel ${person.firstName} 
      ${person.lastName}");
  }
}
```

As you can see, static fields and methods allow us to add specific behaviors to classes in general.

So, now we've seen how to structure a class and how to use the default constructor, let's explore a bit deeper how to define and use class constructors.

## Constructors

To instantiate a class, we call the corresponding constructor with parameters, if required. Now, let's change the Person class and define a constructor with parameters on it, as follows:

```
class Person {
  late String firstName;
  late String lastName;
  Person(String firstName, String lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }
  String getFullName() => "$firstName $lastName";
}
void main() {
  // Person somePerson = Person(); No longer compiles
  Person somePerson = Person("Clark", "Kent");
  print(somePerson.getFullName());
}
```

The constructor is also a method in Dart, and its role is to initialize the instance of the class properly. As a method, it can have many of the characteristics of a common Dart method, such as arguments—required or optional, and named or positional. In the preceding example, the constructor has two mandatory arguments.

If you look in our constructor body, it uses the this keyword. Furthermore, the constructor parameter names are the same as the field ones, which could cause ambiguity. So, to avoid this, we prefix the object instance fields with the this keyword during the value assign step.

Notice that we have to use the late keyword because the fields have not been declared with an initial value, but we know that values of the fields will be set on instantiation of the class, so their values will not be accessed before they have a value set.

Dart provides another way to write a constructor—using a shortcut syntax, such as the one provided in the following example:

```
Person(this.firstName, this.lastName);
```

There is no need for the constructor body, as the field values are set directly in the constructor signature. It can take a little while to get used to this syntax, but it not only makes the constructor declaration more succinct but also removes a big opportunity for code errors. Additionally, you no longer require the late keyword because the compiler can see that the value of the fields will be set on class instantiation.

Have a look at the following code snippet:

```
class Person {
  String firstName;
  String lastName;
  Person(this.firstName, this.lastName);
  String getFullName() => "$firstName $lastName";
}
```

As you can see, this is a much cleaner way of defining a class constructor because it is succinct, less open to code errors, and removes the need to manage the null type on the fields.

### Named constructors

Unlike with Java and many other languages, Dart does not have overloading by redefinition, so to define alternative constructors for a class, you need to use the named constructors. For example, we could add the following constructor to the Person class that takes no parameters:

```
Person.anonymous();
```

The only difference compared with a simple method is that constructors do not have a return statement, as the only thing they have to do is to initialize the object instance properly.

We will see named constructors throughout the rest of the book, as the framework uses these a lot to initialize widget definitions.

### Factory constructors

A factory constructor can be used when the constructor doesn't always create a new instance of the class it is defined on. This may be used when data is being cached and we want to return an instance from the cache rather than construct a new instance.

For example, suppose we are caching Person instances. We could create a factory constructor that checks if the Person instance is already in a cache and returns either a value from the cache or, if there is no cache entry, constructs a new Person instance. For the following example, imagine we have some cache service we can ask for an instance:

```
factory Person.fromCache(String firstName, String lastName) {
  if (_cacheService.containsPerson(firstName, lastName)) {
    return _cacheService.getPerson(firstName, lastName);
  } else {
    return Person(firstName, lastName);
  }
}
```

Note that a factory constructor has no access to the this keyword, so it needs to access another constructor to create a new instance of the class.

### Class inheritance

In addition to the implicit inheritance to the Object type, Dart allows us to extend defined classes using the extends keyword, where all of the members of the parent class are inherited, except the constructors.

Now, let's check out the following example, where we create a child class for the Person class:

```
class Student extends Person {
  String nickName;
  Student(
    String firstName,
    String lastName,
    this.nickName,
  ) : super(firstName, lastName);
  @override
  String toString() => "$fullName, aka $nickName";
}
main() {
  Student = Student("Clark", "Kent", "Kal-El");
  print(student);
}
```

There are some really interesting things going on here that will help us when we start to look at widgets.

Firstly, the Student class defines its own constructor. However, it passes some of the properties in the constructor up to the parent class. This is done with the super keyword, which is placed at the end of the constructor, following the : character.

Next, you see @override. This is an annotation and is metadata giving an additional description to the method definition. There's an overridden toString() method on the Student class. This is where inheritance makes sense—we change the behavior of a parent class (Object, in this case) on the child class.

Why bother with the @override annotation?

Annotations generally contribute to the readability of the code. In this instance, the @override annotation has been used to mark the toString() method as overriding the method from the parent class. You may think this is obvious and that any decent integrated development environment (IDE) could show this relationship perfectly easily. However, the main value of the annotation in this situation is for code checking. If you think you have overridden a method but have misspelled it, then by explicitly saying you wish to override the method, the compiler knows your intention and can validate it. Also, if someone changes the super class method and removes the method you are overriding, the compiler will complain that a subclass is no longer overriding the removed method.

Finally, the print(student) method is called in the main method. As you can see in the print(student) statement, we are not calling any method; the toString() method is called for us implicitly.

A common example of overriding parent behavior is the toString() method. The objective of this method is to return a String representation of the object and it is defined on the top-level Object class.

As you can see in the preceding code example, overriding the toString method makes the code cleaner, and we provide a good textual representation of the object that can aid in understanding logs, text formatting, and more.

## Abstract classes

In OOP, abstract classes are classes that cannot be instantiated. For example, our Person class could be abstract if we want to make sure that it only exists in the context of the program if it is a Student instance or another subtype, as illustrated in the following code snippet:

```
abstract class Person {
  // ... the body was hidden for brevity
}
```

The only thing we need to change here is the beginning of the class definition, marking it as abstract. We can still instantiate the subclass, as shown in the following code snippet:

```
main() {
  Person student = new Student("Clark", "Kent", "Kal-El");
  // Works because we are instantiating the subtype
  // Person p = new Person();
  // abstract classes cannot be instantiated
  print(student);
}
```

As you can see, we can no longer instantiate a Person class itself, only concrete subclasses.

An abstract class may have abstract members without an implementation, allowing it to be implemented by the child types that extend them, as illustrated in the following code snippet:

```
abstract class Person {
  String firstName;
  String lastName;
  Person(this.firstName, this.lastName);
  String get fullName;
}
```

The fullName getter from the preceding Person class is now abstract, as it does not have an implementation. It is the responsibility of the child to implement this member, as follows:

```
class Student extends Person {
  //... other class members
  @override
  String get fullName => "$firstName $lastName";
}
```

The Student class implements the fullName getter because, if it did not, the Student class would itself be abstract (and would need the abstract keyword to allow the code to compile) and therefore could not be instantiated.

## Interfaces

Dart does not have the interface keyword but does allow us to use interfaces in a subtly different way from what you may be used to. All class declarations are themselves interfaces, which means that when you are defining a class in Dart, you are also defining an interface that may be implemented and not only extended by other classes. This is called implicit interfaces in the Dart world.

On this basis, our previous Person class is also a Person interface that could be implemented, instead of extended, by the Student class, as illustrated in the following code block:

```
class Student implements Person {
  String nickName;
  @override
  String firstName;
  @override
  String lastName;
  Student(this.firstName, this.lastName, this.nickName);
  @override
  String get fullName => "$firstName $lastName";
  @override
  String toString() => "$fullName, also known as 
    $nickName";
}
```

Note that, in general, the code does not change too much, but the members are now defined in the Student class. The Person class is just a contract that the Student class adopted and must implement. You can probably see that a pure interface can be created by simply defining a fully abstract class.

## Mixins

In OOP, mixins are a way to include functionality on a class without an association between the parts, such as through inheritance.

Mixins are mainly used in places where multiple inheritance is needed, as this is an easy way for classes to use common functionality. One of the main examples of this in Flutter is when you want to create a widget that is animated. Defining a widget class requires inheritance, so to add animation capabilities to your class, a mixin is required.

As an example, let's look at using mixins for our Person class. People have a mix of specific skills, and mixins can be ideal for reflecting this because we can add skills to a person without the need to define a common superclass for each combination or interface definition, leading to code duplication. Here, we define two classes to be used as mixins, as follows:

```
class ProgrammingSkills {
  coding() {
    print("writing code...");
  }
}
class ManagementSkills {
  manage() {
    print("managing project...");
  }
}
```

We have created two skills classes, ProgrammingSkills and ManagementSkills. Now, we can use them by adding the with keyword to the class definition, as illustrated in the following code example:

```
class SeniorDeveloper extends Person with ProgrammingSkills, ManagementSkills {
  SeniorDeveloper(String firstName, String lastName) : 
    super(firstName, lastName);
}
class JuniorDeveloper extends Person with ProgrammingSkills {
  JuniorDeveloper(String firstName, String lastName) : 
    super(firstName, lastName);
}
```

Both classes will have the coding() method, without the need to implement it in each class, as it is already implemented in the ProgrammingSkills mixin. Additionally, the SeniorDeveloper class will have the manage() method.

## Files and imports

When you look at the project structure of the HelloWorld project, you will notice that there is a file named main.dart that contains a class named MyApp. Unlike with some other programming languages, the class name does not need to match the filename.

Additionally, it is normal to put multiple classes, enums, and functions into one file to form a library of constructs that are closely related. This can allow nice encapsulation through making some classes private to the library through the addition of an underscore at the start of their name (as with variables). Other classes in the file can access and instantiate the private class, but it is not visible outside of the file.

When we explore widgets, in the next chapter, you will see that it is quite common to have two classes within a file and they can both contribute to a single widget, one of which is private to the file.

However, you don't want all of your app's constructs in a single file as it would become harder to find the construct that you need, would hinder encapsulation, and would probably cause performance issues with your IDE. Therefore, you need a way to refer to constructs in other files, and you do this through import statements. As with virtually any other programming language, import statements allow you to reference code in other classes, packages, and plugins.

If you look at the main.dart file in the HelloWorld project, you will see the following import statement at the very top:

```
import 'package:flutter/material.dart';
```

In this example, the material.dart file is being imported, with all the classes and functions within that file being made available to your class. This file holds lots of the basic constructs needed to create Flutter widgets, so most files in a Flutter project will need this import.

In this section, we looked at the structure of a Dart class, including fields and methods. Then, we explored the different ways in which constructors can be used to instantiate a class. After that, we discussed some of the special ways to use classes, such as abstract classes, interfaces, and mixins. We finished off by learning how class code can be shared across your app through files and imports. Let's now look at a special type of construct called enums, which are used in very specific scenarios.

# The enum type

The enum type is a common data type used by most languages to represent a set of finite constant values. In Dart, it is no different. By using the enum keyword, followed by the constant values, you can define an enum type, as illustrated in the following code snippet:

```
enum PersonType { student, employee }
```

Note that you only define the value names. enum types are special types with a set of finite values that have an index property representing their value. Now, let's see how it all works.

First, we add a field to our previously defined Person class to store its type, as follows:

```
class Person {
  ...
  PersonType? type;
  ...
}
```

Then, we can use it just like any other field, as illustrated in the following code snippet:

```
main() {
  print(PersonType.values); 
  Person somePerson = Person();
  somePerson.type = PersonType.employee;
  print(somePerson.type);
  print(somePerson.type.index);
  print(describeEnum(PersonType.employee));
}
```

The first print statement prints [PersonType.student, PersonType.employee].You can see that we are calling the values getter on the PersonType enum directly. This is a static member of the enum type that simply returns a list with all of its values.

The second print statement prints PersonType.employee.

The next print statement prints 1. You can see that the index property is zero, based on the declaration position of the value. Generally, you should not rely on the index value because it can change if the enum values are reordered or a new value is added.

Additionally, Flutter supplies the describeEnum method, which returns just the value of the enum. In the final print method, the value printed will be employee.

The more you can add type safety to your code, the safer that code is. However, sometimes you also want to specify the type that a class can contain, and you do this with generics.

# Using generics

The <> syntax is used to specify the type supported by a class. If you look at the examples of lists and maps in Chapter 2, An Introduction to Dart, you will notice that we have not specified the type that they can contain. This is because this type of information is optional, and Dart can infer the type based on elements during the collection initialization.

## When and why to use generics

The use of generics can help a developer to maintain and keep collection behavior under control. When we use a collection without specifying the allowed element types, it is our responsibility to correctly insert elements of the expected type. This can lead to bugs when data of an incorrect type is placed in a collection or incorrect assumptions are made about the contents of a collection.

Consider the following code example, where we have named a List variable placeNames. We expect this to be a list of names and nothing else. Unfortunately, without generics, we can place anything into the list, including a number. This can lead to issues when retrieving values from the list:

```
main() {
  List placeNames = ["Middlesbrough", "New York"];
  placeNames.add(1);
  print("Place names: $placeNames");
}
// prints Place names: [Middlesbrough, New York, 1]
```

However, if we specify the string type for the list, then this code would not compile, therefore improving the robustness of the code, as illustrated in the following code snippet:

```
main() {
  List<String> placeNames = ["Middlesbrough", "New York"];
  placeNames.add(1);
  // add() expects a String so this doesn't compile
}
```

### Generics and Dart literals

In the list and map examples provided in Chapter 2, An Introduction to Dart, you will see we used the [] and {} literals to initialize them. With generics, as an alternative to the previous approach, we can specify a type during initialization, adding an <elementType>[] prefix for lists and <keyType, valueType>{} for maps.

Take a look at the following example:

```
main() {
  var placeNames = <String>["Middlesbrough", "New York"];
  var landmarks = <String, String>{
    "Middlesbrough": "Transporter bridge",
    "New York": "Statue of Liberty",
  };
}
```

Specifying the type of list seems to be redundant in this case as the Dart analyzer will infer the string type from the literals we have provided. However, in some cases, this is important, such as when we are initializing an empty collection, as in the following example:

```
var emptyStringArray = <String>[];
```

If we have not specified the type of the empty collection, it could have any data type on it as it would not infer the generic type to adopt.

### Nullability in generics

Just as we saw in the Null safety section in Chapter 2, An Introduction to Dart, if a variable can receive a null value, then that must be declared on the variable's type. This is also true in generics if the type of the collection can include null entries.

For example, suppose in our landmarks map we allowed some places to have no landmark. We would need to declare this so that when we access the map's entries, we would know that null was a possible value. Let's update the previous example to see what that might look like, as follows:

```
main() {
  var landmarks = <String, String?>{
    "Middlesbrough": "Transporter bridge",
    "New York": "Statue of Liberty",
    "Barnmouth": null,
  };
}
```

We have specified that the value of the map entry is String?, meaning that it holds either a String or a null value. We have then added a new entry to the map containing a null value.

We have now learned a lot about how to add type safety to our code, and we will finish the chapter with a slight change of focus. Sometimes, we want to call some code that will take a long time to complete, so how do we do this while maintaining a great user experience (UX) for our app? Let's look at asynchronous programming.

# Asynchronous programming

Dart is a single-threaded programming language, meaning that all of the application code runs in the same thread. Put simply, this means that any code may block thread execution by performing long-running operations such as input/output (I/O) or HyperText Transfer Protocol (HTTP) requests. This can obviously be an issue if your app is stuck waiting for something slow such as an HTTP request while the user is trying to interact with it. The app would effectively freeze and not respond to the user's input.

However, although Dart is single-threaded, it can perform asynchronous operations through the use of Futures. This allows your code to trigger an operation, continue doing other work, and then come back when the operation has been completed. To represent the result of these asynchronous operations, Dart uses the Future object combined with the async and await keywords. Let's look at these concepts now so that we can learn how to write a responsive application.

## Dart Futures

When our code calls a method that is a long-running task but we don't want to block execution of other parts of the app such as the user interface (UI), we can mark the method as asynchronous using the async keyword. This tells all code that calls that method that it may be long-running, so you shouldn't block thread execution while waiting for the result. We can then call the method and continue the execution of other code.

However, we may want to get a result from the long-running method, so we need to come back to the method call after the long-running method has returned. To do this, we specify that we want to return when there is a response, using the await keyword. A key distinction between async and await is that the method itself declares its asynchronicity using async, but it is the code calling the method that specifies it will return when there is a response through the use of await. We will see both of these keywords in use later in this section.

So, we've declared that the method should be called asynchronously using async, and we may have specified that we want to come back to the method call when there is a result using await, but what does the method actually return? The Future<T> object in Dart represents a value that will be provided sometime in the future. It can be used to mark a method, for example, with a future result; that is, a method returning a Future<T> object will not have the proper result value immediately but, instead, after some computation at a later point in time.

It is easiest to understand this when you look at code examples that initially are not asynchronous but are long-running. Consider the following code:

```
import 'dart:io';
void longRunningOperation() {
  for (int i = 0; i < 5; i++) {
    sleep(Duration(seconds: 1));
    print("index: $i");
  }
}
main() {
  print("start of long running operation");
  longRunningOperation();
  print("continuing main body");
  for (int i = 10; i < 15; i++) {
    sleep(Duration(seconds: 1));
    print("index from main: $i");
  }
  print("end of main");
}
```

Here, we have the main function, which calls a long-running operation. We have used the sleep() function, which pauses code execution. This function is available in the dart:io package, so we have added an import statement to give us access to the function.

If you execute the preceding code, the output looks like this:

```
start of long running operation
index: 0
index: 1
index: 2
index: 3
index: 4
continuing main body
index from main: 10
index from main: 11
index from main: 12
index from main: 13
index from main: 14
end of main
```

You will notice that it stops the main function execution while the longRunningOperation() function is running, printing out the index: statements before continuing the main() execution and printing out the index from main statements. This is synchronous execution of all of the code and it will likely not fit well in all use cases. If this were an app, then the UI would be unresponsive, leading to a bad UX, because the thread is stuck waiting for the longRunningOperation() function to complete, rather than looking after all the many other activities needed to keep an app responsive.

Now, let's say we change this example so that the longRunningOperation() function is an asynchronous function and main() can continue executing without waiting for it to complete, as follows:

```
import 'dart:io';
import 'dart:async';
Future<void> longRunningOperation() async {
  for (int i = 0; i < 5; i++) {
    sleep(Duration(seconds: 1));
    print("index: $i");
  }
}
main() { ... } // main function is the same
```

We have made one key difference to our code—the longRunningOperation() function now has the async modifier to indicate that this is an asynchronous function and will return a Future. Notice that we have marked that the return type of the function is a Future. To access these modifiers, we have also added a new import statement for dart:async. Specifically, we have marked it as Future<void> because there is no returned object when the function completes.

If you now execute the preceding code, you may notice something strange; the output is shown here:

```
start of long running operation
index: 0
index: 1
index: 2
index: 3
index: 4
continuing main body
index from main: 10
index from main: 11
index from main: 12
index from main: 13
index from main: 14
end of main
```

Nothing has changed—we are still waiting for the longRunningOperation() function to complete. The reason for this is the sleep() function. The sleep() function is synchronous yet it is also long-running, so the thread is actually getting stuck there and not being released to perform other duties. Thankfully, there is an alternative to the synchronous sleep() function, called Future.delayed(). This method is asynchronous and will allow us to release the thread.

Let's update our example to become properly asynchronous, as follows:

```
import 'dart:io';
import 'dart:async';
Future<void> longRunningOperation() async {
  for (int i = 0; i < 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    print("index: $i");
  }
}
void main() { ... } // main function is the same 
```

We are now calling the Future.delayed() function, which is asynchronous. We want our code execution to continue from that point when the function completes, so we have specified this by adding the await keyword. Now, the thread will be released to do what it needs to, but when the function completes, our code execution will continue from the await point.

Let's run the code and see if this works, as follows:

```
start of long running operation
continuing main body
index from main: 10
index from main: 11
index from main: 12
index from main: 13
index from main: 14
end of main
index: 0
index: 1
index: 2
index: 3
index: 4
```

We no longer have purely synchronous code where one piece of code strictly executes after another, as we did before; here, what changes is the order. In the preceding example, the change occurs when the longRunningOperation() function calls await in another async function. The function is suspended and will be resumed only after a delay of 1 second. After the delay, however, the main() function is already running again; it did not wait for the longRunningOperation() function to complete because we didn't specify await, so the longRunningOperation() code will be executed only after the main() function has finished.

If we make the main() function an async function and await the execution of longRunningOperation(), then the main() function will be suspended right when we call await longRunningOperation() and will only be resumed after its execution. This would then behave just like the first output we saw.

One other experiment to try is to stop thread blocking in the main() method by replacing the sleep() function with Future.delayed(). This will then release the thread to move back to the longRunningOperation() function and create an interlaced pattern. To do this, change the code as follows:

```
main() async {
  print("start of long running operation");
  longRunningOperation();
  print("continuing main body");
  for (int i = 10; i < 15; i++) {
    await Future.delayed(Duration(seconds: 1));
    print("index from main: $i");
  }
  print("end of main");
}
```

If you run the preceding code, you will get the following output:

```
start of long running operation
continuing main body
index: 0
index from main: 10
index: 1
index from main: 11
index: 2
index from main: 12
index: 3
index from main: 13
index: 4
index from main: 14
end of main
```

To understand this pattern of output produced, you need to appreciate that Dart executes both asynchronous methods in the same thread. Both functions run asynchronously in this case, but this does not mean that they are executed in parallel. Dart actually executes one operation at a time; as long as one operation is executing, it cannot be interrupted by any other Dart code. This execution is controlled by the Dart event loop, which acts as a manager for Dart Futures and asynchronous code.

So, in our example, the longRunningOperation() function is executed, and when it reaches the Future.delayed() call, it relinquishes control of the thread. The thread can then continue execution of the main() function until it reaches its own Future.delayed() call when it relinquishes control of the thread. After a second, thread execution continues from the await point in the longRunningOperation() function, printing the index and looping until it relinquishes control of the thread again, ready for the thread to continue execution from the main() function's await point. This continues until both loops complete.

You can refer to Dart's official documentation on event loops to understand how this works, at https://dart.dev/articles/archive/event-loop.

There is a way to truly execute Dart code in parallel (that is, at the same time). To do this, we use Dart Isolates.

## Dart Isolates

So, you may have been wondering, how can you execute truly parallel code and improve the performance and responsiveness of your app? Dart Isolates are designed exactly for this purpose. Every Dart application is composed at least of one Isolate instance—the main Isolate instance where all of the application code runs. So, to create parallel execution code, we must create a new Isolate instance that can run in parallel with the main Isolate instance, as illustrated in the following diagram:

![Figure 4.1 - Two Isolates in parallel ](/flutter4beginners2/figure_4.1_-_two_isolates_in_parallel.jpg)

Isolates can be considered to be a sort of thread, but they do not share anything with each other, as the name suggests. This means that they do not share memory, so we do not need to use locks and other thread synchronization techniques here.

To communicate between isolates—that is, to send and receive data between them—we need to exchange messages. Dart provides a way of accomplishing this.

Let's change the previous implementation to use an Isolate instance instead, as follows:

```
import 'dart:io';
import 'dart:isolate';
Future<void> longRunningOperation(String message) async {
  for (int i = 0; i < 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    print("$message: $i");
  }
}
void main() async {
  print("start of long running operation");
  Isolate.spawn(longRunningOperation, "Hello");
  print("continuing main body");
  for (int i = 10; i < 15; i++) {
    await Future.delayed(Duration(seconds: 1));
    print("index from main: $i");
  }
  print("end of main");
}
```

As you can see, there are some minor changes to the code, as outlined here:

The longRunningOperation() function is almost identical, but we've added a message parameter to show how arguments can be passed on Isolate creation.
To initiate the Isolate process to be executed, we use the spawn() method from the Isolate class. This takes two arguments—the function to be spawned and a parameter to be passed to the function.
We have added the import 'dart:isolate' statement to gain access to the Isolate class.
Running the preceding code, you will note a very similar output to before, as illustrated here:

```
start of long running operation
continuing main body
index from main: 10
Hello: 0
index from main: 11
Hello: 1
index from main: 12
Hello: 2
index from main: 13
Hello: 3
index from main: 14
end of main
Hello: 4
```

Again, both functions run interleaved, but this time, the main function runs ahead of the longRunningOperation() function. This is because unlike the previous example where the thread did not relinquish control until it reached await Future.delayed(), the spawn operation creates an isolate asynchronously, allowing the main() function thread to immediately move to its await Future.delayed() function. Note additionally that there is not the dance we had in the previous example where each function relinquished thread control to the other at the await point. These are effectively two separate threads running independently.

# Summary

In this chapter, we looked at how Dart fits with the OOP basics, which led to an exploration of Dart classes, including inheritance, abstraction, and mixins.

We took a deeper look at class constructors and the different types of constructors available in Flutter, including named and factor constructors.

We then explored enums and examples of how and when they would be used.

Finally, we looked at some more advanced Dart topics that are relevant to Flutter development. The first topic was generics, which allow you to specify type information for a class such as a collection or a Future. The second topic was asynchronous programming, the use of Futures, async, and await, and then a look at Isolates and how they can be used to allow parallel processing.

This chapter will have given you a strong foundational knowledge of Dart and the programming concepts that will be used throughout Flutter development. You may want to refer back to this chapter as we start to look at more advanced Flutter concepts that are built on these foundational principles.

In the next chapter, we will look at Flutter widgets, which will immediately make use of your new Dart knowledge!

