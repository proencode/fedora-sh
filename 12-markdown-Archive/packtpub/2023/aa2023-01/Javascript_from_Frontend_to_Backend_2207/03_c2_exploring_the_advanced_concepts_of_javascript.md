
@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/EEEEEEEEEE^[
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(`) 붙이기 => i`^[/.^[i`^[/RRRRRRRRRR^[
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(`) 붙이기 => i`^[/,^[i`^[/TTTTTTTTTT^[
@ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(`) 붙이기 => i`^[/;^[i`^[/YYYYYYYYYY^[
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(`) 붙이기 => i`^[/)^[i`^[/UUUUUUUUUU^[
@ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(`) 붙이기 => i`^[/:^[i`^[/YYYYYYYYYY^[

@ A -> 빈 줄에 블록 시작하기 => 0C```^[^Mk0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i```^M-^[^M0i```^[0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi```^M^M^[kk
@ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
    마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

> [ 02 C1 Exploring the Core Concepts of JavaScript ](/packtpub/javascript_from_frontend_to_backend/02_c1_exploring_the_core_concepts_of_javascript) <---> [ 04 P2 JavaScript on the Client-Side ](/packtpub/javascript_from_frontend_to_backend/04_p2_javascript_on_the_client-side)

# Chapter 2: Exploring the Advanced Concepts of JavaScript

In this chapter, we will explore the advanced features of JavaScript, such as object-oriented programming. We will also study two types of objects that are widely used in JavaScript: arrays and strings. Finally, we will see how JavaScript allows you to trigger deferred processing, using so-called callback functions.

In this chapter, we’ll be covering the following topics:

- Classes and objects
- Arrays
- Character strings
- Multitasking
- Using promises

All these topics are fundamental to building JavaScript applications. Let’s start now!

# 1. Technical requirements

You can find the code files for this chapter on GitHub at: https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend/blob/main/Chapter%202.zip.

# 2. Classes and objects

The notion of classes and objects is fundamental to programming languages. JavaScript allows them to be used as well.

A class is used to represent any type of data. For example, people, customers, cars, and so on. We can define a class to represent each of these types of elements, for example, a `Person` class to represent people, a `Client` class to represent customers, and a `Car` class to represent cars.

Note

Note that the class name traditionally begins with an uppercase letter.

An object, on the other hand, will be a particular element of a class (this element will be also called an instance). For example, among all the people of the class `Person`, the person identified by his name “Clinton” and his first name “Bill” represents a particular object of the class `Person`. This object can be associated, for example, with the variable `p` in the program. We can thus create variables to identify each object associated with the class.

## 2-1. Defining a class

The question to ask yourself when creating a class is what actions you want to perform on the type of data it represents.

For example, if we create the `Person` class, we should ask what characterizes a person and what action can we perform on this class. We could, for example, say that the `Person` class is characterized by the last name, first name, and age of the person. You can also add an address, phone number, email, and so on.

As for the possible actions on people, we can imagine, for example, the action of getting married to another person, the action of moving to another city, the action of changing employers, and so on.

Note

Characteristics such as last name, first name, age, and so on are called properties of the class, while actions such as getting married, moving, and so on are called methods of the class. A class will therefore group together a set of properties and a set of methods.

A JavaScript class is created using the keyword `class` followed by the name of the class, followed by braces describing the content. For example, the `Person` class will be created as follows:

Person class

```
class Person {
}
```

This definition of the `Person` class will not be very useful for now, because no properties or methods are defined inside it. We will see later how to improve it.

## 2-2. Creating an object by using a class

Once the class is defined, we can create objects associated with this class. For this, we use the keyword `new` followed by the name of the class. This creates a variable that represents an object of that class:

Creating an object p of class Person

```
// define the Person class
class Person {
}
// create an object of class Person
var p = new Person;  // object p of class Person
console.log(p);
```

This is what you will see:

![ 0300 2.1 Creating a Person class object ](/packtpub/javascript_from_frontend_to_backend_img/0300_2.1_creating_a_person_class_object.webp
)
Figure 2.1 – Creating a Person class object

The `p` object is displayed in the console. We are told that it is a `Person` class object and that it is empty `{}`. The representation of an object in the form of braces is traditional in JavaScript, as we saw in the Type of variables used in JavaScript section of the previous chapter.

We can verify that it also works on the client side, in a browser. The HTML file is as follows:

index.html file

```
<html>
  <head>
    <meta charset="utf-8" />
    <script>
      class Person {
      }
      var p = new Person;
      console.log(p);
    </script>
  </head>
  <body>
  </body>
</html>
```

![ 0301 2.2 Creating an object in the browser ](/packtpub/javascript_from_frontend_to_backend_img/0301_2.2_creating_an_object_in_the_browser.webp
)
Figure 2.2 – Creating an object in the browser

We find the display of braces, which symbolizes the display of a JavaScript object.

## 2-3. Creating an object without using a class

It is possible to create an object without having created a class first. All you have to do is use the notation with the braces { and }.

For example, we can write the following:

Creating an object using the braces notation

```
var p = { lastname : "Clinton", firstname : "Bill" };
console.log("The person is", p);
```

This will create the object `p` with the `lastname` and `firstname` properties. Note that you can indicate the names of the properties by enclosing them in quotation marks, or not. So `{ lastname: "Clinton" }` can also be written `{ "lastname": "Clinton" }` by surrounding the `lastname` property with single or double quotes.

Now let’s see how to improve the `Person` class previously created by adding properties and methods to it.

## 2-4. Adding properties to a class

A person has, in our example, a last name, a first name, and an age. We will create these three properties for people of the `Person` class.

All you have to do is indicate each of these properties, by name, in the body of the `Person` class. Above all, do not use the `var` or `let` keywords to define them:

Adding firstname, lastname, and age properties in Person class

```
class Person {
  firstname;
  lastname;
  age;
}
var p = new Person;
console.log(p);
```

![ 0302 2.3 Creation of lastname firstname and ](/packtpub/javascript_from_frontend_to_backend_img/0302_2.3_creation_of_lastname_firstname_and.webp
)
Figure 2.3 – Creation of lastname, firstname, and age properties in the Person class

The `Person` class object `p` now has the properties added in the class. Any other object of this class will also have them.

Note that the values of the added properties are `undefined`. This is normal because no values have been specified for these properties in the `p` object or the `Person` class.

Let’s modify the Person class so that the properties have default values, rather than `undefined`:

Properties with default values

```
class Person {
  firstname = "";
  lastname = "";
  age = 0;
}
var p = new Person;
console.log(p);
```

Each property is initialized with its default value. The `lastname` and `firstname` properties are initialized with an empty string `""`, while `age` is initialized by default to `0`.

![ 0303 2.4 Properties with default values ](/packtpub/javascript_from_frontend_to_backend_img/0303_2.4_properties_with_default_values.webp
)
Figure 2.4 – Properties with default values

A class has properties, but also methods. Now let’s see how to add methods to a class.

## 2-5. Adding methods to a class

You can add methods to a class. Objects created from the class (with `new`) will be able to use these methods directly.

For example, let’s create the `display()` method, which displays a line of text containing the person’s first and last name. The instruction `p.display()` (assuming that `p` is a `Person` class object) is used to display the last name and first name of the person related to the object `p`:

Creating the display() method in the Person class

```
class Person {
  // class properties
  firstname = "";
  lastname = "";
  age = 0;
  
  // class methods
  display() {
    console.log("The person's lastname is = " + 
                this.lastname +
                ", firstname = " + this.firstname);
  }
}
var p = new Person;
console.log("Variable p = ", p);
p.display();  // use of the display() method on the p object
```

The properties of the class are accessible in the methods of the class by prefixing them with the keyword `this`. For example, `this.lastname` provides access to the `lastname` property of the class.

The `this` keyword refers to the object itself that uses the `display()` method, so here, the `p` object.

If you omit the `this` keyword and use the `lastname` property directly, you will get a syntax error because the property is only accessible with the `this` keyword.

The output of the preceding code snippet is displayed here:

![ 0304 2.5 Using the display method ](/packtpub/javascript_from_frontend_to_backend_img/0304_2.5_using_the_display_method.webp
)
Figure 2.5 – Using the display() method

The `display()` method displays `firstname` and `lastname` of the person associated with the variable `p`, but since `lastname` and `firstname` have been initialized to an empty string, no last name or first name is displayed. Let’s look at how to modify the value of a property.

## 2-6. Changing an object’s property values

You can modify the value of the properties of an object by using these properties directly, for example, `p.lastname` allows you to read or modify the value of the `lastname` property for the object `p`:

Initialization of the lastname and firstname of the person

```
class Person {
  // class properties
  lastname = "";
  firstname = "";
  age = 0;
  
  // class methods
  display() {
    console.log(" The person's lastname = " + this.lastname +
                ", firstname = " + this.firstname);
  }
}
var p = new Person;
p.lastname = "Clinton";  // initialization of the lastname 
                         // property of the object p
p.firstname = "Bill";    // initialization of the firstname 
                         // property of the object p
console.log("Variable p = ", p);
p.display();
```

This is what you will see:

![ 0305 2.6 The lastname and firstname properties ](/packtpub/javascript_from_frontend_to_backend_img/0305_2.6_the_lastname_and_firstname_properties.webp
)
Figure 2.6 – The lastname and firstname properties are initialized

Once the object `p` has been created by the `new` operator, we initialize its `lastname` and `firstname` properties to the values indicated. The `age` property is not modified here, and will therefore remain equal to the value 0.

We modified the value of the `lastname` and `firstname` properties of the object `p` created using `p.lastname` and `p.firstname`.

This modification of property values is done after the object `p` is created. It is possible to do this modification during the very creation of the object, in the `new` instruction. This requires defining a method called `constructor()`, which allows this initialization.

## 2-7. Using the class constructor

The `constructor()` method is called the constructor of the class. It is automatically called during each `new` statement if the `constructor()` method exists in the class. We define it in a class if we want to perform a specific process each time an object is created in this class.

The `constructor()` method can have any number of parameters or none at all. The parameters indicated here will be used to initialize the `lastname` and `firstname` properties of the person:

Using a constructor for the Person class

```
class Person {
  // class properties
  lastname = "";
  firstname = "";
  age = 0;
  
  // class methods
  constructor(lastname, firstname, age) {
    this.lastname = lastname;
    this.firstname = firstname;
    this.age = age;
  }
  display() {
    console.log(" The person's lastname = " + this.lastname +
                ", firstname = " + this.firstname);
  }
}
var p = new Person("Clinton", "Bill");
console.log("Variable p = ", p);
p.display();
```

The `constructor()` method is defined by giving it the three parameters `lastname`, `firstname`, and `age`. They are transferred into the properties of the object by means of `this.lastname`, `this.firstname`, and `this.age`.

Finally, the object `p` is now created by passing as parameters the values of `lastname`, `firstname`, and `age` of the person created with `new`. Here, `age` is not specified in parameters in the `new` instruction; it will therefore be an `undefined` value that will be transmitted to the constructor.

![ 0306 2.7 Using a constructor ](/packtpub/javascript_from_frontend_to_backend_img/0306_2.7_using_a_constructor.webp
)
Figure 2.7 – Using a constructor

We find the `lastname` and `firstname` properties initialized, but the `age` property is now initialized to the value `undefined` instead of `0`. To assign it another value, simply pass an additional value when creating the object with `new`. This additional value will represent the person’s age, for example:

Using age when creating Person class object

```
class Person {
  // class properties
  lastname = "";
  firstname = "";
  age = 0;
  
  // class methods
  constructor(lastname, firstname, age) {
    this.lastname = lastname;
    this.firstname = firstname;
    this.age = age;
  }
  display() {
    // the age of the person is also displayed
    console.log("The person's lastname = " + this.lastname +
                ", firstname = " + this.firstname + 
                ", age = " + this.age);         
  }
}
var p = new Person("Clinton", "Bill", 33);    // age is now 
                                              // transmitted
console.log("Variable p = ", p);
p.display();
```

![ 0307 2.8 The person’s age is now transmitted ](/packtpub/javascript_from_frontend_to_backend_img/0307_2.8_the_person’s_age_is_now_transmitted.webp
)
Figure 2.8 – The person’s age is now transmitted

We have seen how to create an object, by directly defining its properties and methods using a class. However, we can also create an object from another object. Let’s see how to do it.

## 2-8. Merging one object with another

There may be cases when you want to create a new object from an old object. Let’s see how to do this.

If the object `p` contains a value, the statement `var p2 = p` does not create a new object `p2` distinct from the object `p`, but only a reference `p2` that points to the same value as the reference `p`. So any modification of the properties of the object `p` will also be visible in the object `p2` because both point to the same memory location.

This can be verified using the following example:

Modifying an object in memory

```
var p = { lastname : "Clinton", firstname : "Bill" };
console.log("p (before modification of p2) =", p);  
       // p = { lastname : "Clinton", firstname : "Bill" }
var p2 = p;
p2.city = "Washington";
console.log("p (after modification of p2) =", p);  
       // p = { lastname : "Clinton", firstname : "Bill", 
       // city : "Washington"}
console.log("p2 =", p2);  
       // p2 = { lastname : "Clinton", firstname : "Bill", 
       // city : "Washington"}
```

Even if only the `p2` object is modified, the `p` object is also modified because they are memory references that point to the same location. If the contents of the memory location are changed, both references see the same change.

To avoid this situation, it would not be necessary to write `p2 = p`, but rather to copy the properties of the object `p` into those of the object `p2`, thus creating a new memory location. For this, JavaScript offers the spread operator, used in the form …, which allows it:

Using the spread operator ...

```
var p = { lastname : "Clinton", firstname : "Bill" }
console.log("p (before modification of p2) =", p);
var p2 = { ...p};   // copy the properties of object p into 
                    // object p2
p2.city = "Washington";
console.log("p (after modification of p2) =", p);
console.log("p2 =", p2);
```

The spread operator is used by surrounding the original object with braces `{` and `}`, and preceding the object with the spread operator (for example, `{...p}`).

![ 0308 2.9 Using the spread operator ](/packtpub/javascript_from_frontend_to_backend_img/0308_2.9_using_the_spread_operator.webp
)
Figure 2.9 – Using the spread operator...

Object `p` is no longer modified when object p2 is modified.

It is also possible to write it in shortened form:

Creating object p2 from object p, adding the city

```
// to avoid writing p2.city = "Washington"
var p2 = { ...p, city : "Washington" };  
```

Now that we have looked at classes and objects and how to work with them, let’s take a look at an important class object: the Array class.

# 3. Arrays

Arrays store a collection of data, ordered according to their index. The index is also called the index of the array. It starts at 0 and scales up to the total number of elements in the array, minus 1 (0 to n-1).

Let’s learn how to create an array first.

## 3-1. Creating an array

An array corresponds in JavaScript to an `Array` class object. We therefore create an array using the `new Array` instruction.

However, since arrays are widely used in JavaScript programs, it is also possible to create them using a bracket notation `[` and `]`. This is an easier way to use them without going through the `Array` class.

Let’s take a detailed look at these two ways to create an array (with brackets and with the `Array` class).

### (31-1) Creating an array using square brackets [ and ]

The easiest and fastest way to create an array is to use the bracket notation:

Creating an array using square brackets

```
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
console.log(tab);
```

The array begins with an opening square bracket `[` and ends with a closing square bracket `]`. The elements of the array are separated by a comma. We have inserted elements here as strings, but in fact, any type of element can be inserted into an array.

![ 0309 2.10 Elements inserted into an array ](/packtpub/javascript_from_frontend_to_backend_img/0309_2.10_elements_inserted_into_an_array.webp
)
Figure 2.10 – Elements inserted into an array

Note that it is possible to create an empty array (without any elements). We write this as `[]`, without indicating any element inside the square brackets. It will then be possible to add elements to this array.

### (31-2) Creating an array using the Array class

You can also use the `Array` class to create an array. The `Array` class includes a constructor in which we indicate the list of array elements, each separated from the next by a comma.

The same array as before can be created by the `new Array` statement by writing the following:

Creating an array using new Array

```
var tab = new Array("Element 1", "Element 2", "Element 3", "Element 4", "Element 5");
console.log(tab);
```

![ 0310 2.11 Creation of the array using new Array ](/packtpub/javascript_from_frontend_to_backend_img/0310_2.11_creation_of_the_array_using_new_array.webp
)
Figure 2.11 – Creation of the array using new Array

The array created is the same as before.

To create an empty array, simply pass no parameters to the constructor by writing the following:

Creating an empty array using new Array()

```
var tab = new Array();    // or new Array;
console.log(tab);
```

![ 0311 2.12 Creating an empty array ](/packtpub/javascript_from_frontend_to_backend_img/0311_2.12_creating_an_empty_array.webp
)
Figure 2.12 – Creating an empty array [ ]

Now that we’ve seen how to create an array, let’s see how to access each of its elements.

## 3-2. Accessing array elements

In previous programs, we displayed the entire array, using the `console.log(tab)` statement. It is possible to access each element of the array separately. Each element can be accessed as follows:

- By its index
- With a `for()` loop
- With the `forEach()` method

Let’s take a look at each of these three ways.

### (32-1) Accessing an element by index

Let’s take the previous array of five elements, that is, `tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"]`:

- The first element can be accessed by its index 0, that is, tab[0].
- The next one, with index 1, will be accessed by tab[1].
- The last one, with index 4, will be accessed by tab[4].

This is how you will display each element:

Displaying each element of the array by its index

```
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
console.log("tab =", tab);
console.log("tab[0] =", tab[0]);
console.log("tab[1] =", tab[1]);
console.log("tab[2] =", tab[2]);
console.log("tab[3] =", tab[3]);
console.log("tab[4] =", tab[4]);
console.log("tab[5] =", tab[5]);
```

The result is displayed in the following figure:

![ 0312 2.13 Displaying each element by its index ](/packtpub/javascript_from_frontend_to_backend_img/0312_2.13_displaying_each_element_by_its_index.webp
)
Figure 2.13 – Displaying each element by its index

The array contains five elements, which means the indices go from 0 to 4. However, to do a test, we also access the element with index 5. It is possible to access an index of an element that does not exist in the array. The result in this case is the JavaScript value `undefined`, which means that the value of this element has not yet been assigned.

Note that it is possible with this access method to modify the value of an array element – just give it a new value:

Modifying the value of the elements in indexes 2 and 3 of the array

```
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
console.log("Array before modification");
console.log("tab =", tab);
// modification of elements, index 2 and 3
tab[2] = "New element 3";
tab[3] = "New element 4";
console.log("Array after modification");
console.log("tab =", tab);
```

This is the result:

![ 0313 2.14 Modifying array elements ](/packtpub/javascript_from_frontend_to_backend_img/0313_2.14_modifying_array_elements.webp
)
Figure 2.14 – Modifying array elements

Next, we will look at accessing an element with a `for()` or `while()` loop.

### (32-2) Accessing an element with a for() or while() loop

The `for()` and `while()` loops already studied in the previous chapter allow you to browse all the elements of an array. The index of the loop starts at 0 (to access the first element of the array, the one with index 0) and ends at the last index of the array.

To know this last index, JavaScript provides the `length` property in the `Array` class, which allows us to know the total number of elements of an array. The last index will be the one with the value `length – 1`:

Accessing array elements with a for() loop

```
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
console.log("tab =", tab);
console.log("Access to each element by a for() loop");
for (var i = 0; i < tab.length; i++) console.log("tab[" + i + "]=", tab[i]);
```

Note that the end of the loop is written by testing the value `i < tab.length`. This is equivalent to writing `i <= tab.length – 1`.

![ 0314 2.15 Accessing array elements with ](/packtpub/javascript_from_frontend_to_backend_img/0314_2.15_accessing_array_elements_with.webp
)
Figure 2.15 – Accessing array elements with a for() loop

Next, we will look at accessing an element with the `forEach(callback)` method.

### (32-3) Accessing an element with the forEach(callback) method

The `forEach(callback)` method is a method defined by JavaScript on the `Array` class. It is used to browse the elements of an array by transmitting each of the elements of the array to a function passed as a parameter. The function indicated as a parameter therefore has access to each element of the array (and to its index if necessary).

### (32-4) Callback Function

The principle of indicating a function in the parameters of a method is very common in JavaScript. The function in the parameters is known as a callback function, which means that the actual processing to be executed is that indicated in the callback function.

We show here how to use a callback function indicated in parameters of the `forEach(callback)` method.

We use the `tab` array of five elements seen previously, to which we apply the `forEach()` method:

Accessing array elements using the forEach() method

```
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
console.log("tab =", tab);
console.log("Access to each element by the forEach() method");
tab.forEach(function(elem, i) {
  console.log("tab[" + i + "]=", elem);
});
```

We indicate a function as a parameter of the `forEach()` method. This so-called callback function will be called automatically by JavaScript for each element of the `tab` array (which uses the `forEach()` method).

The callback function takes as its first parameter the element of the array for which the function is called (parameter `elem`), and its index (parameter `i`).

![ 0315 2.16 Accessing array elements using ](/packtpub/javascript_from_frontend_to_backend_img/0315_2.16_accessing_array_elements_using.webp
)
Figure 2.16 – Accessing array elements using the forEach() method

The result is the same as that obtained by the `for()` loop. However, there is a (small) difference that we discover right away.

The difference between the `for()` loop and the `forEach()` method
The previous program did not show any difference between the for() loop and forEach() method results to access array elements.

To show the difference between these two approaches, let’s introduce a new element in the array, at index 10, knowing that the last index used during the creation of the array was 4. We thus create a new element that is much further away than the current last element of the array. How will the array react to this enlargement?

Addition of an element at index 10

```
// original array
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
// adding a new element in the array, at index 10
tab[10] = "Element 9";
console.log("tab =", tab);
// display the array with a for() loop
console.log("Access to each element by a for() loop");
for (var i = 0; i < tab.length; i++) console.log("tab[" + i + "]=", tab[i]);
// display the array by the forEach() method
console.log("Access to each element by the forEach() method");
tab.forEach(function(elem, i) {
  console.log("tab[" + i + "]=", elem);
});
```

We add an element to the array using `tab[10] = "Element 9"`, then display the contents of the array using the `for()` loop and then the `forEach()` method.

The result is displayed in the following figure:

![ 0316 2.17 Adding an element at index 10 of ](/packtpub/javascript_from_frontend_to_backend_img/0316_2.17_adding_an_element_at_index_10_of.webp
)
Figure 2.17 – Adding an element at index 10 of the array

The display of the `for()` loop shows that the elements with indices 5 to 9 exist but are of value `undefined`, because effectively, no values have been inserted for these indices of the array. However, the indices 5 to 9 with their `undefined` values are displayed by the `for()` loop.

Conversely, the `forEach()` method provides the callback function indicated in parameters with only the array elements that have actually been affected in the array. This therefore avoids the elements at indices 5 to 9, which have not been assigned in the program.

We have seen how to create an array, then how to access each of its elements. Let’s look at how to add new elements to the array.

## 3-3. Adding items to the array

Once the array has been created (empty or not), it is possible to add elements to it. We will mainly use one of the two following techniques:

- Adding an element by its index in the array
- Adding an item using the `push()` method

Now let’s take a look at these two techniques.

### (33-1) Adding an element by index

This corresponds to the assignment `tab[i] = value`. We used it in the previous section by writing `tab[10] = "Element 9"`.

Note simply that if the index used is greater than the current number of elements in the array, this enlarges the array by creating elements initialized to the value `undefined`. And if the index used is less than the number of elements in the array, it modifies the current value of the targeted element.

### (33-2) Adding an element using the push() method

The `push()` method is defined in the `Array` class. It allows you to add a new element to an array without worrying about the insertion index because it automatically inserts the element at the end of the array:

Inserting an element using the push() method

```
// original array
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
// insert an element using the push() method
tab.push("Element 6");
console.log("tab =", tab);
// display the array with a for() loop
console.log("Access to each element by a for() loop");
for (var i = 0; i < tab.length; i++) console.log("tab[" + i + "]=", tab[i]);
// display the array by the forEach() method
console.log("Access to each element by the forEach() method");
tab.forEach(function(elem, i) {
  console.log("tab[" + i + "]=", elem);
});
```

The instruction `tab.push("Element 6")` inserts this element at the end of the array. The array is then displayed using the various methods seen previously.

![ 0317 2.18 Adding an element using the push ](/packtpub/javascript_from_frontend_to_backend_img/0317_2.18_adding_an_element_using_the_push.webp
)
Figure 2.18 – Adding an element using the push() method

We know how to add and modify elements in an array. All that remains is to know how to delete elements from an array.

## 3-4. Deleting array elements

JavaScript allows us to delete array elements in two ways:

- Deleting the value of the element in the array, while retaining the element in the array with an `undefined` value
- Removing the element itself from the array

Let’s examine these two possibilities now.

### (34-1) Deleting an element value (without deleting the element from the array)

We use the `delete` keyword to delete the value of an element in an array. For example, `delete tab[0]` deletes the value of the element with index 0 in the array `tab`, by assigning it the value `undefined`. The element is not removed from the array, which still has the same number of elements as before:

Deleting the value of the element with index 0

```
// original array
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
// delete the value of the element with index 0
delete tab[0];
console.log("tab =", tab);
// display the array with a for() loop
console.log("Access to each element by a for() loop");
for (var i = 0; i < tab.length; i++) console.log("tab[" + i + "]=", tab[i]);
// display the array by the forEach() method
console.log("Access to each element by the forEach() method");
tab.forEach(function(elem, i) {
  console.log("tab[" + i + "]=", elem);
});
```

![ 0318 2.19 Deleting the value of the element ](/packtpub/javascript_from_frontend_to_backend_img/0318_2.19_deleting_the_value_of_the_element.webp
)
Figure 2.19 – Deleting the value of the element with index 0

We see that the `for()` loop displays the `undefined` value of the element, while the `forEach()` method no longer displays the element because its value has been deleted.

Note

Note that if instead of using `delete tab[0]`, we use `tab[0] = undefined`, the `forEach()` method displays the element at index 0 as the first element of the array, because the value of the element has not actually been deleted but rather assigned to a new value, which here is `undefined`.

Now let’s look at the second method for removing the element from the array.

### (34-2) Deleting an element from an array

Using the `delete` keyword does not delete the element from the array, which retains the same number of elements.

The `splice(begin, count)` method defined in the `Array` class allows you to physically remove the element from the array, which will therefore have at least one element less after its use.

The `splice(begin, count)` method includes the `begin` and `count` parameters, which allow you to indicate from which index you want to delete (`begin` parameter) the elements and the number of consecutive elements you want to delete (`count` parameter).

So, to remove the element with index 0 from the array `tab`, just write `tab.splice (0, 1)`:

Removing element with index 0 in array with splice() method

```
// original array
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
// remove 1 element from index 0
tab.splice(0, 1);
console.log("tab =", tab);
// display the array with a for() loop
console.log("Access to each element by a for() loop");
for (var i = 0; i < tab.length; i++) console.log("tab[" + i + "]=", tab[i]);
// display the array by the forEach() method
console.log("Access to each element by the forEach() method");
tab.forEach(function(elem, i) {
  console.log("tab[" + i + "]=", elem);
});
```

This is what you will see:

![ 0319 2.20 Deletion of element with index 0 ](/packtpub/javascript_from_frontend_to_backend_img/0319_2.20_deletion_of_element_with_index_0.webp
)
Figure 2.20 – Deletion of element with index 0

We have seen how to add and delete elements in an array. Now let’s see how to extract a new array from the elements present in the current array.

## 3-5. Filtering elements in an array

It is common to filter the elements of an array, for example, to keep only certain elements or to return new ones. The `Array` class has two methods - `filter(callback)` and `map(callback)` - that allow us to return a new array according to our conditions.

### (35-1) Using the filter(callback) method

The `tab.filter(callback)` method returns a new array while keeping only the desired elements of the `tab` array.

The callback function of the form `callback(element, index)` is called for each of the elements of the array `tab`. It must return `true` if we decide to keep the element; otherwise, the element is excluded. A new array is returned as a result by the `tab.filter()` method, but the original `tab` array is not modified (unless it is assigned in return from the method, as in the following example).

Let’s use the `filter()` method to keep only the elements of the array whose index is greater than or equal to 2:

Using the filter() method

```
// original array
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
console.log("initial tab =", tab);
// keep only items with index >= 2
tab = tab.filter(function(element, index) {
  if (index >= 2) return true;   // keep this element
});
console.log("\nfinal tab =", tab);
```

If the callback function returns `true`, the element is kept; otherwise, it is excluded. The callback function can also return `false`, or even return nothing, like here, and in this case, the element is excluded:

![ 0320 2.21 Using the filter method ](/packtpub/javascript_from_frontend_to_backend_img/0320_2.21_using_the_filter_method.webp
)
Figure 2.21 – Using the filter() method

This brings us to the end of the filter() method.

### (35-2) Using the map(callback) method

The `tab.map(callback)` method is used to return a new array from the elements of the initial `tab` array. Each element of the initial array is passed to the callback function of the form `callback(element, index)`, which must return for each element a new element that will replace the original element.

Let’s use the `map(callback)` method to return a new array in which all elements have been capitalized:

Using the map() method

```
// original array
var tab = ["Element 1", "Element 2", "Element 3", "Element 4", "Element 5"];
console.log("initial tab =", tab);
// capitalize all elements
tab = tab.map(function(element, index) {
  return element.toUpperCase();
});
console.log("\nfinal tab =", tab);
```

The `toUpperCase()` method is a method defined on the String class (following screenshot), allowing you to capitalize the character string that uses the method.

The result is displayed in the following figure:

![ 0321 2.22 Using the map method ](/packtpub/javascript_from_frontend_to_backend_img/0321_2.22_using_the_map_method.webp
)
Figure 2.22 – Using the map() method

We have studied in this section the use of objects of the `Array` class. Another class of objects is also widely used with JavaScript: character strings, which are represented by the `String` class. Now let’s see how to use objects of the `String` class.

# 4. Character strings

Strings are widely used in programming languages. They are used to represent text entered by a user or text that will be displayed to a user.

## 4-1. Creating a character string

A character string is represented by an object of class `String`. But since character strings are widely used in JavaScript, the language allows them to be used by surrounding them with double quotes `"` and `"` or single quotes `'` and `'`. It is also possible, for certain uses, to use backticks (reverse quotation marks `'` and `'`).

Note

The string literal must in this case begin and end with the same type of quotes.

Now let’s see how to create a string using these various methods.

### (41-1) Creating a string literal using double or single quotes

The easiest way to create a string literal is to use the single or double quote notation:

Creating a string literal with double quotes

```
var s = "String 1";
console.log("s =", s);
```

Or, with single quotes:

Creating a string literal with single quotes

```
var s = 'String 1';
console.log("s =", s);
```

In both cases, the character string displayed is the same.

![ 0322 2.23 Creating a character string ](/packtpub/javascript_from_frontend_to_backend_img/0322_2.23_creating_a_character_string.webp
)
Figure 2.23 – Creating a character string

Advantage of Having the Option to Use Single/Double Quotation Marks

The advantage of having the possibility of using single or double quotes is visible if the string itself contains quotes. For example, if the string is `"I'll love JavaScript"`, using single quotes to create the string will produce an error because the string will be assumed to end with the apostrophe in the word `I'll`. In this case, you must use double quotes to avoid the error.

### (41-2) Creating a string literal using backticks

You can also use backticks. This is useful in special cases where you want to use the value of variables in character strings in a simpler way.

For example, suppose you want to display a string that uses a person’s first and last name. The last name and first name are in variables named `lastname` and `firstname`:

Concatenating strings and variables

```
var lastname = "Clinton";
var firstname = "Bill";
// old way of concatenating strings and variables
var s1 = "lastname is " + lastname + ", firstname is " + firstname;
// new way of concatenating strings and variables
var s2 = `lastname is ${lastname}, firstname is ${firstname}`;
console.log("s1 =", s1);
console.log("s2 =", s2);
```

When using reverse quotes, the + symbol is no longer used to concatenate strings and variables. Everything is written in a single string, and the variables are identified by the “symbols” `${variable}`.

What is written between the braces `{` and `}` can be a simple variable (like here), but also a more complex JavaScript expression that can be calculated (for example, `{a+b}`).

We can see that the two result strings are identical.

![ 0323 2.24 Sequence of character strings ](/packtpub/javascript_from_frontend_to_backend_img/0323_2.24_sequence_of_character_strings.webp
)
Figure 2.24 – Sequence of character strings and variables creating a string using the String class

Finally, it is possible to use the `String` class to create the character string. The `String` class has a constructor in which the string to be constructed is indicated as a parameter:

Using the String class

```
var s = new String("I'll love JavaScript");
console.log("s =", s);
```

The following figure displays the result:

![ 0324 2.25 Using the String class ](/packtpub/javascript_from_frontend_to_backend_img/0324_2.25_using_the_string_class.webp
)
Figure 2.25 – Using the String class

The `String` class has properties and methods. For example, the `length` property lets you know the number of characters in the string, and thus lets you compare, for example, the length of two character strings.

Let’s use the `length` property to display the length of the two strings created using quotes and the `String` class:

Using the length property of the String class

```
var s1 = new String("I'll love JavaScript");
var s2 = "I'll love JavaScript";
console.log("s1 =", s1);
console.log("s2 =", s2);
console.log("s1.length =", s1.length);
console.log("s2.length =", s2.length);
```

This is the result:

![ 0325 2.26 Using the length property of ](/packtpub/javascript_from_frontend_to_backend_img/0325_2.26_using_the_length_property_of.webp
)
Figure 2.26 – Using the length property of the String class

Regardless of how the string is created, its length is the same (here, 20 characters). We have seen how to create a character string, now let’s see how to access the characters that compose it.

## 4-2. Accessing characters in a string

The `String` class defines methods for accessing characters in the string. These are, in particular, the `charAt(index)` and `slice(start, end)` methods. `charAt(index)` is used to retrieve the character located at the index indicated in the string, starting from index 0. The maximum index is that associated with the value of the `length` property, reduced by 1. `slice(start, end)` breaks the string into a substring, by extracting the characters that go from the `start` index (included) to the `end` index (excluded).

### (42-1) Using the charAt(index) method

Let’s use the `charAt(index)` method to display the characters of a string, one by one:

Displaying characters from a string

```
var s = "Hello";
console.log("s =", s);
for (var i = 0; i <s.length; i++) console.log(`s.charAt(${i}) = ${s.charAt(i)}`);
```

Notice the use of reverse quotes to display the result string.

The result is displayed in the following figure:

![ 0326 2.27 Using the charAt method ](/packtpub/javascript_from_frontend_to_backend_img/0326_2.27_using_the_charat_method.webp
)
Figure 2.27 – Using the charAt() method

Now, let’s look at the `slice(start, end)` method.

### (42-2) Using the slice(start, end) method

The preceding `charAt(index)` method retrieves a single character from the string, while the `slice(start, end)` method can retrieve several consecutive ones:

Note

Note that the `slice(start, end)` method does not modify the string on which the method applies, but rather returns a new string. The original string is not modified, allowing it to remain intact.

Using slice() on the “Hello” string

```
var s = "Hello";
console.log("s =", s);
console.log(`s.slice(0,2) = ${s.slice(0,2)}`);
console.log(`s.slice(0,3) = ${s.slice(0,3)}`);
console.log(`s.slice(1,3) = ${s.slice(1,3)}`);
console.log(`s.slice(0,-1) = ${s.slice(0,-1)}`);
console.log(`s.slice(0,-2) = ${s.slice(0,-2)}`);
console.log(`s.slice(1,-2) = ${s.slice(1,-2)}`);
```

If the `end` index (second parameter) of the `slice(start, end)` method is negative, it means counting starts from the end of the string (instead of the beginning if it is positive).

We then obtain the following result:

![ 0327 2.28 Using the slice method ](/packtpub/javascript_from_frontend_to_backend_img/0327_2.28_using_the_slice_method.webp
)
Figure 2.28 – Using the slice() method

Now that we have seen how to get the characters that make up the string, let’s look at how to modify the string.

## 4-3. Modifying a character string

To modify a string, there is only one possibility: you have to construct a new one from it. The original string cannot be changed directly.

For this, we will use the previous `slice()` and `charAt()` methods, which will make it possible to extract parts of the original string, in order to build the resulting string.

But to search or modify parts of character strings, it is better to use regular expressions. We study them below.

## 4-4. Using regular expressions

`Regular expressions` Regular expressions are related to strings. They are used to check whether a string has a certain format (for example, the format of an email, of a telephone number, and so on), or to replace the characters that are in this format with others.

For this, the `String` class has the `match(regexp)` method to check whether a character string has a given format and the `replace(regexp, str)` method to replace the part of the string in this format with the new string `str`.

In both methods, the `regexp` parameter corresponds to a regular expression, the meaning of which we will study next.

### (44-1) Checking whether a string has a given format

The `match(regexp)` method is used to check whether the character string on which the method is used is in the format indicated in `regexp`. The `regexp` parameter is called a regular expression.

### (44-2) Regular Expressions

A regular expression is a sequence of characters surrounded by `/` and `/`, for example, `/abc/`. The regular expression `/abc/` means that we are looking for the sequence of characters `abc` in the character string. If the string contains the sequence `abc`, the `match(/abc/)` method returns this sequence of characters as a result, otherwise it returns the value `null`.

A full description of regular expressions can be found at https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Global_Objects/RegExp.

Here are some examples of regular expressions with the values returned when using the `match()` method on the string `"Hello"`:

Using match(regexp)

```
var s = "Hello";
console.log("s =", s);
// search for "Hel"
console.log(`s.match(/Hel/) = ${s.match(/Hel/)}`);
// search for "hel"
console.log(`s.match(/hel/) = ${s.match(/hel/)}`);  
// search for "hel" ignoring upper/lower case
console.log(`s.match(/hel/i) = ${s.match(/hel/i)}`);
// search for H followed by a or b or e followed by l
console.log(`s.match(/H[abe]l/) = ${s.match(/H[abe]l/)}`);
// search for He followed by 0 or 1 a followed by l
console.log(`s.match(/Hea?l/) = ${s.match(/Hea?l/)}`);
// search for He followed by 0 (min) to 1 (max) followed by l
console.log(`s.match(/Hea{0,1}l/) = ${s.match(/Hea{0,1}l/)}`);
// search for He followed 1 (min) to 2 (max) followed by l
console.log(`s.match(/Hea{1,2}l/) = ${s.match(/Hea{1,2}l/)}`);
```

When the regular expression is found in the `"Hello"` string, the part of the string found is returned by the `match()` method, otherwise it returns `null`.

The i sign at the end of the regular expression indicates that uppercase or lowercase letters must be ignored.

The square brackets `[` and `]` around a series of letters mean that only one of these letters is required.

The question mark `?` means that the preceding character is optional (it can be present or not).

The braces `{min,max}` mean that the preceding character must be present at least `min` times and at most `max` times.

The result of the previous program is as follows:

![ 0328 2.29 Using regular expressions ](/packtpub/javascript_from_frontend_to_backend_img/0328_2.29_using_regular_expressions.webp
)
Figure 2.29 – Using regular expressions

Note

Writing a regular expression can sometimes be complex to formulate. The site https://regex101.com/ allows you to test the regular expressions you want.

A regular expression can also modify parts of character strings, using the `replace()` method.

### (44-3) Replacing a part of a string with a given format

The `replace(regexp, str)` method is used to replace the part of the string having the format of the regular expression `regexp` with the string `str`. It returns a new string, and the original one is not modified. If the format indicated by the regular expression is not found, the original string is returned with no modifications.

Let’s take the regular expressions from the previous example and replace the string found with the string “abc”, thanks to the regular expressions:

Using the replace() method

```
var s = "Hello";
console.log("s =", s);
// search for "Hel" and replace with "abc"
console.log(`s.replace(/Hel/, "abc") => ${s.replace(/Hel/, "abc")}`);
// search for "hel" and replace with "abc"
console.log(`s.replace(/hel/, "abc") => ${s.replace(/hel/, "abc")}`);  
// search for hel ignoring upper/lower case and replacing with 
// "abc"
console.log(`s.replace(/hel/i, "abc") => ${s.replace(/hel/i, "abc")}`);
// search for H followed by a or b or e followed by l and 
// replace with "abc"
console.log(`s.replace(/H[abe]l/, "abc") => ${s.replace(/H[abe]l/, "abc")}`);
// search for He followed by 0 or 1 a followed by l and 
// replaced by "abc"
console.log(`s.replace(/Hea?l/, "abc") => ${s.replace(/Hea?l/, 
"abc")}`);
// search for He followed by 0 (min) to 1 (max) followed by l 
// and replaced by "abc"
console.log(`s.replace(/Hea{0,1}l/, "abc") => ${s.replace(/Hea{0,1}l/, "abc")}`);
// search for He followed by 1 (min) to 2 (max) followed by l 
// and replaced by "abc"
console.log(`s.replace(/Hea{1,2}l/, "abc") => ${s.replace(/Hea{1,2}l/, "abc")}`);
```

The output is shown here:

![ 0329 2.30 Using the replace method ](/packtpub/javascript_from_frontend_to_backend_img/0329_2.30_using_the_replace_method.webp
)
Figure 2.30 – Using the replace() method

All executions of previous programs were executed immediately. We are now going to study how to perform deferred processing over time.

# 5. Multitasking in JavaScript

When you start coding in JavaScript, a question often comes up: is it possible to perform several processes simultaneously (what is called multitasking in computing)? This would be useful if a process to be executed will take a long time, so as not to block other equally urgent processes.

JavaScript does not allow several processing operations to be carried out simultaneously. On the other hand, it is possible not to block the program (both on the client side in the browser, and on the server side with Node.js) by using the callback function (which we have already talked about when studying the `forEach()` method in the **Accessing an element with the forEach(callback) method** section).

## 5-1. Callback Function

A callback function corresponds to a processing function used as parameters of a JavaScript method or function. The callback function will be executed at the desired time by the method or function that uses it.

Node.js makes extensive use of this feature. For example, when reading a file, the `readFile(callback)` method calls the callback function as a parameter when the file has been read, which allows the program not to block the pending processing of the file to be read.

JavaScript defines as standard two main functions that use this callback function concept: the `setTimeout()` and `setInterval()` functions. Both these use a callback function as a parameter. We’ll describe these two functions next.

## 5-2. Using the setTimeout() function

The `setTimeout(callback, timeout)` function is used to position a processing function (the `callback` function) that will be executed when the time period expressed by `timeout` (in milliseconds) has elapsed.

This allows you, for example, to perform processing after 5 seconds (that is, 5,000 milliseconds). You can execute other instructions while waiting for this delay, so the program is not blocked during this time:

Processing instructions after a delay of 5 seconds

```
console.log("Before setTimeout()");
setTimeout(
  function() {
    console.log("In the callback function");
  }
  ,
  5000
); // 5000 milliseconds, or 5 seconds
console.log("After setTimeout()");
```

We display a message (`"Before setTimeout()"`) in the console at the start of the program. We program a delay of 5 seconds, after which a callback function is triggered, which displays another message in the console (`"In the callback function"`). Finally, we end the program by displaying a new message (`"After setTimeout()"`).

Let’s run this program with the `node testnode.js` command, for example. To test this program in a browser, simply place the preceding JavaScript code between the `<script>` and `</script>` tags of the `index.html` file.

The following screenshot shows the display after 1 second:

![ 0330 2.31 Using setTimeout ](/packtpub/javascript_from_frontend_to_backend_img/0330_2.31_using_settimeout.webp
)
Figure 2.31 – Using setTimeout()

Note that the display message of the start and that of the end follow each other, even though the 5-second time limit has not elapsed. This shows that the program is not blocked, waiting for the timeout to expire.

The following screenshot shows the display after at least 5 seconds (when the delay used in the `setTimeout()` method has elapsed).

![ 0331 2.32 Display when the 5-second delay ](/packtpub/javascript_from_frontend_to_backend_img/0331_2.32_display_when_the_5-second_delay.webp
)
Figure 2.32 – Display when the 5-second delay has elapsed

We see that when the 5-second delay has elapsed, the callback function registered in the `setTimeout()` function is called automatically by the `setTimeout()` function.

Let’s improve the program by displaying the time when the messages are displayed. This makes it possible to verify that the 5-second time limit is respected:

Displaying the time when messages are posted

```
console.log(time(), "Before setTimeout()");
setTimeout(
  function() {
    console.log(time(), "In the callback function");
  },
  5000
); // 5000 = 5 seconds
console.log(time(), "After setTimeout()");
function time() {
 // return time as HH:MM:SS
 var date = new Date();
 var hour = date.getHours();
 var min = date.getMinutes();
 var sec = date.getSeconds();
 if (hour < 10) hour = "0" + hour;
 if (min < 10) min = "0" + min;
 if (sec < 10) sec = "0" + sec;
 return "" + hour + ":" + min + ":" + sec + " ";
}
```

The `time()` function is used to generate a character string that contains the time in the form HH:MM:SS. This time is displayed at the beginning of each message displayed in the console.

The `Date` class used here is a JavaScript class that allows you to manage dates and to extract hours, minutes, and seconds.

We now get the following:

![ 0332 2.33 Displaying the time when messages ](/packtpub/javascript_from_frontend_to_backend_img/0332_2.33_displaying_the_time_when_messages.webp
)
Figure 2.33 – Displaying the time when messages are displayed in the console

We can clearly see that the callback function is executed at the end of the 5-second period indicated in the parameter of the `setTimeout()` function.

### (52-1) Example of adding a date.

`$ cat ~/tt.js`
```
console.log(time(), "Before setTimeout()");

setTimeout(function() {
        console.log(time(), "In the callback function");
    }, 5000); // 5000 = 5 seconds

console.log(time(), "After setTimeout()");

function time() {
 // return time as HH:MM:SS
 var date = new Date();
 var y4 = date.getFullYear();
 var mm = date.getMonth() + 1;
 var dd = date.getDate();
 if (mm < 10) mm = "0" + mm;
 if (dd < 10) dd = "0" + dd;
 var hour = date.getHours();
 var min = date.getMinutes();
 var sec = date.getSeconds();
 if (hour < 10) hour = "0" + hour;
 if (min < 10) min = "0" + min;
 if (sec < 10) sec = "0" + sec;
 return "" + y4 + "-" + mm + "-" + dd + " " + hour + ":" + min + ":" + sec + " ";
}
```
`$ node ~/tt.js`
```
2022-10-11 16:47:42  Before setTimeout()
2022-10-11 16:47:42  After setTimeout()
2022-10-11 16:47:47  In the callback function
```

## 5-3. Using the setInterval() function

The `setInterval(callback, timeout)` function is similar to the `setTimeout()` function seen previously. But instead of executing the callback function only once at the end of the delay (as the `setTimeout()` function does), the `setInterval()` function executes the callback function repeatedly by setting a new delay at the end of it. The callback function is therefore executed at regular intervals. The only way to stop this cycle is to use the `clearInterval()` function.

The `setInterval()` function is very useful for running processes at regular intervals.

Let’s use the `setInterval()` function to display, every second, the value of a counter initialized to 1. The counter is incremented every second:

Incrementing a counter every second

```
console.log(time(), "Start of timer");
var count = 1;
setInterval(function() {
  console.log(time(), `count = ${count}`);
  count++;
}, 1000);    // 1000 = 1 second
function time() {
 // return time as HH:MM:SS
 var date = new Date();
 var hour = date.getHours();
 var min = date.getMinutes();
 var sec = date.getSeconds();
 if (hour < 10) hour = "0" + hour;
 if (min < 10) min = "0" + min;
 if (sec < 10) sec = "0" + sec;
 return "" + hour + ":" + min + ":" + sec + " ";
}
```

This is what you will see:

![ 0333 2.34 Incrementing a counter every second ](/packtpub/javascript_from_frontend_to_backend_img/0333_2.34_incrementing_a_counter_every_second.webp
)
Figure 2.34 – Incrementing a counter every second

The counter increments every second, indefinitely. To stop this endless cycle, you have to use a new JavaScript function, which is clearInterval().

## 5-4. Using the clearInterval() function

The `clearInterval(timer)` function is used to stop the cycle started during the `setInterval()` instruction.

Note

Note that multiple timers can be started by multiple calls to the `setInterval()` function. So the `clearInterval(timer)` function must specify which timer it wants to stop: the `timer` parameter is used to tell it.

To do this, the `setInterval()` function returns the `timer` parameter that will be used when calling the `clearInterval(timer)` function.

Let’s use the `clearInterval()` function to stop the timer when the `count` counter has reached the value 5:

Using the clearInterval() function to stop the timer

```
console.log(time(), "Start of timer");
var count = 1;
var timer = setInterval(function() {
  console.log(time(), `count = ${count}`);
  if (count == 5) {
    clearInterval(timer);  // timer stop
    console.log(time(), "End of timer");
  } else count++;
}, 1000);
function time() {
 // return time as HH:MM:SS
 var date = new Date();
 var hour = date.getHours();
 var min = date.getMinutes();
 var sec = date.getSeconds();
 if (hour < 10) hour = "0" + hour;
 if (min < 10) min = "0" + min;
 if (sec < 10) sec = "0" + sec;
 return "" + hour + ":" + min + ":" + sec + " ";
}
```

The program of the callback function is modified: as soon as the counter reaches `5`, the timer is stopped. Otherwise, the counter is incremented by 1.

Check that the count stops after 5 times:

![ 0334 2.35 Timer stops after 5 counts ](/packtpub/javascript_from_frontend_to_backend_img/0334_2.35_timer_stops_after_5_counts.webp
)
Figure 2.35 – Timer stops after 5 counts

The callback function that is used in the `setTimeout()` or `setInterval()` functions is included directly in the parameters of each function. JavaScript makes it easier to write callback functions by using a new type of object called a promise.

# 6. Using promises

Promises are another way to use callback functions. Rather than integrating the callback function into the method call (as a parameter), we use it as a parameter of the new `then(callback)` method. This simplifies the reading of JavaScript code in case it uses callback functions.

For an object to use the `then(callback)` method, it must be a `Promise` class object. The `Promise` class is a class defined in JavaScript language.

## 6-1. The Promise Class

A `Promise` class object uses a callback function of the form `callback(resolve, reject)` as a parameter of its constructor.

The `resolve` and `reject` parameters are functions, which will be called from the promise’s callback:

- When the `resolve()` function is called, it triggers the `then(callback)` method.
- When the `reject()` function is called, it triggers the `catch(callback)` method.

The `resolve()` function must be called, otherwise the `then(callback)` method cannot be executed. On the other hand, calling the `reject()` function is optional, and if it is not used, the `catch(callback)` method will not be called (and therefore does not have to be present in the program).

Thanks to the `resolve` and `reject` parameters, we therefore have the possibility of executing the cases of success (with the `then(callback)` method) and the cases of failure (with the `catch(callback)` method). This way of writing ensures more readability of the JavaScript code.

To illustrate this, let’s take the example of the `setTimeout(callback, timeout)` function seen previously. The callback function is included in the method call here, which we want to avoid with promises. Let’s write the new `wait(timeout)` method that can be used in the form `wait(timeout).then(callback)`. The callback function is now externalized from the `wait()` method.

The callback function registered in the `then(callback)` method will be called when the timeout expires.

This form of writing is more readable than the previous one with `setTimeout()`, because it thus shows the delay before a process is executed.

To achieve this, the `wait(timeout)` method must return a `Promise` object:

Creating the Promise object, then using the then() method

```
function time() {
 // return time as HH:MM:SS
 var date = new Date();
 var hour = date.getHours();
 var min = date.getMinutes();
 var sec = date.getSeconds();
 if (hour < 10) hour = "0" + hour;
 if (min < 10) min = "0" + min;
 if (sec < 10) sec = "0" + sec;
 return "" + hour + ":" + min + ":" + sec + " ";
}
function wait(sec) {
  return new Promise(function(resolve, reject) {
    setTimeout(function() {
      resolve(sec);  // triggers the then() method
    }, sec*1000);
  });
}
console.log(time(), "Start of timer");
wait(2).then(function(sec) {
  console.log(time(), `End of timer of ${sec} seconds`);
});
```

The `wait()` method returns a `Promise` object thanks to the `return new Promise()` statement. In the `callback(resolve, reject)` function, we call the `resolve()` function when we consider that the `then()` method can execute, here at the end of the timeout.

It is possible to specify arguments for the `resolve()` and `reject()` methods. These arguments will be used in the callback functions used in the `then(callback)` or `catch(callback)` methods. For example, here, we call the `resolve(sec)` method, which allows us to use the sec parameter in the callback function of the `then()` method.

Note

Notice that the `reject()` function is not used in our example because no error cases can occur here. The `resolve()` function must, however, be called; otherwise, the `then()` method will never be executed.

The `time()` function is used to display the times of each process to check that the execution is correct.

![ 0335 2.36 Using the then method ](/packtpub/javascript_from_frontend_to_backend_img/0335_2.36_using_the_then_method.webp
)
Figure 2.36 – Using the then() method

This brings us to the end of the chapter.

# 7. Summary

In this chapter, we went through advanced concepts related to JavaScript.

We learned how to use classes and objects, particularly the `Array` and `String` classes. We also saw how to delay the execution of instructions.

In the rest of the book, we will discover the use of the Vue.js JavaScript library associated with the client side of application development.

We will see how the knowledge obtained here will allow us to use this language in aspects of client-side and then server-side programming.



> [ 02 C1 Exploring the Core Concepts of JavaScript ](/packtpub/javascript_from_frontend_to_backend/02_c1_exploring_the_core_concepts_of_javascript) <---> [ 04 P2 JavaScript on the Client-Side ](/packtpub/javascript_from_frontend_to_backend/04_p2_javascript_on_the_client-side)
>
> Title: 03 C2 Exploring the Advanced Concepts of JavaScript
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/03_c2_exploring_the_advanced_concepts_of_javascript
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-05 수 14:00:42
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 03_c2_exploring_the_advanced_concepts_of_javascript.md

