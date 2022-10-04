
@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i\`\`\`^M^[/^Copy$^[ddk0C\`\`\`^M^[
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(\`) 붙이기 => i\`^[/ ^[i\`^[/EEaEEEEEEEE^[
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(\`) 붙이기 => i\`^[/\.^[i\`^[/RRaRRRRRRRR^[
i`/\.i`/RRRRRRRRRR
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(\`) 붙이기 => i\`^[/,^[i\`^[/TTaTTTTTTTT^[
@ Y -> 찾은 글자 ~ COLON 앞뒤로 backtick(\`) 붙이기 => i\`^[/;^[i\`^[/YYaYYYYYYYY^[
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(\`) 붙이기 => i\`^[/)^[i\`^[/UUaUUUUUUUU^[

@ A -> 빈 줄에 블록 시작하기 => 0C\`\`\`^[^Mk0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i\`\`\`^M-^[^M0i\`\`\`^[0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi\`\`\`^M^M^[kk
@ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
    마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------


> Title: 02 Exploring the Core Concepts of JavaScript
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/02_exploring_the_core_concepts_of_javascript
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-04 화 15:11:07
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 02_exploring_the_core_concepts_of_javascript.md

# Chapter 1: Exploring the Core Concepts of JavaScript

The JavaScript language was created (in the mid-1990s) to be executed in internet browsers, in order to make websites more fluid. It was originally used to control what was entered into input forms. For example, it was used to do the following:

- Allow the entry of numeric characters in a field – and only numeric ones. Other characters, for example, letters, had to be rejected in this case. This made it possible, thanks to the JavaScript language included in the browser, not to validate the entry of the form and avoid sending data to the server, which would have indicated an entry error in this case.
- Check that the mandatory fields of the form were all entered, by checking all the fields before sending the form fields to the server.

These two examples (among many others) show that it is desirable to have a language that checks the validity of the data entered by the user before sending this data to the server. This avoids data transfers from the browser to the server, in the event that the data entered is not correct. For more complex checks, such as checking that two people do not have the same identifier, this can continue to be done on the server because it has access to all existing identifiers.

The goal was, therefore, at the beginning of JavaScript, to have the browser check as many things as possible and then transmit the information entered to the server in order to process it.

For this, an internal browser language was created: the JavaScript language, whose name contained a very popular word at the time – “Java” (even though the two languages Java and JavaScript had nothing to do with each other).

Over the years, developers have had the idea of also associating it with the server side, to use the same language on the client side and on the server side. This allowed the creation of the Node.js server, which is widely used today.

Whether client-side or server-side, the JavaScript language uses a basic syntax that allows you to write your own programs. This is what we are going to discover in this chapter.

In this chapter, we will cover the following topics:

- Types of variables used in JavaScript
- Running a JavaScript program
- Declaring variables in JavaScript
- Writing conditions for conditional tests
- Creating processing loops
- Using functions

# Technical requirements

To develop in JavaScript, and write and then run the programs in this book, you will need the following:

- A text editor for computer programs, for example, Notepad++, Sublime Text, EditPlus, or Visual Studio.
- An internet browser, for example, Chrome, Firefox, Safari, or Edge.
- A PHP server, for example, XAMPP or WampServer. The PHP server will be used to execute JavaScript programs containing `import` statements in HTML pages because these `import` statements only work on an HTTP server.
- A Node.js server: The Node.js server will be created through Node.js installation. We will also install and use the MongoDB database to associate the Node.js server with a database.
- You can find the code files for this chapter on GitHub at: https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend/blob/main/Chapter%201.zip.

Let’s now begin our discovery of JavaScript, by studying the different types of variables it offers us.

# Types of variables used in JavaScript

Like any language, JavaScript allows you to create variables that will be used to manipulate data. JavaScript is a very simple language so, for example, data types are very basic. We will thus have the following as the main data types:

- Numerical values
- Boolean values
- Character strings
- Arrays
- Objects

Let’s take a quick look at these different types of data.

# Numerical values

Numerical values can be positive or negative and even in decimal form (for example, 0, -10, 10.45). All mathematical numbers called real numbers comprise numerical values or data points.

# Boolean values

These are of course the two Boolean values—true or false—that are found in most languages. These values are used to express conditions: if the condition is true, then we perform a particular process, otherwise, we perform an alternative one. The result of the condition is therefore a true or false value, which is symbolized by the two values `true` and `false`.

We will see how to express conditions in the Writing conditions section, later in this chapter.

# Character strings

Character strings refer to values such as `"a"`, `"abc"`, or `"Hello, how are you?"`. An empty character string will be represented by "" (consecutive quotes with nothing inside). Note that you can use double quotes (") or single quotes ('). Thus, the string "abc" can also be written as 'abc' (with single quotes).

Arrays
Arrays, such as [10, "abc", -36], can contain values of any type, like here where we have both numeric values and character strings. An empty array will be represented by [], which means that it contains no value.

The values stored in an array are accessed by means of an index, varying from 0 (to access the first element placed in the array) to the length of the array minus 1 (to access the last element of the array). So, if the array [10, "abc", -36] is represented, for example, by the variable tab, the following occurs:

tab[0] will allow access to the first element of the array: 10.
tab[1] will allow access to the second element of the array: "abc".
tab[2] will allow access to the third and last element of the array: -36.NoteNote that it is possible to add elements to an array, even if it is empty. So, if we access index 3 of the previous array tab, we can write tab[3] = "def". The array tab will therefore now be [10, "abc", -36, "def"].
Objects
Objects are similar to arrays. They are used to store arbitrary information, for example, the values 43, "Clinton", and "Bill". But unlike arrays that use indexes, you must specify a name to access each of these values. This name is called the key, which thus allows access to the value it represents.

Let’s suppose that the previous value 43 is that of a person’s age, while "Clinton" is their last name, and "Bill" is their first name. We would then write the object in the following form: { age: 43, lastname: "Clinton", firstname: "Bill" }. The definition of the object is done by means of braces, and what is indicated inside is pairs of data of the form key: value separated by commas. This writing format is also called JavaScript Object Notation (JSON) format.

So, if the previous object is associated with the variable person, we can access their age by writing person["age"] (which will therefore be 43 here), but we can also write person.age, which will also be 43. Similarly, we can also write person.lastname or person["lastname"] and person.firstname or person["firstname"] to access the person’s last name and first name, respectively.

The key is also called a property of the object. Thus, the age key is also called the age property. We can choose any name for the key; you just have to indicate the key and then use it under this name. So, if you specify age as a property in the person object, you must use the term age in the expressions person.age or person["age"]; otherwise it will not work.

Note that if you write person[age] instead of person["age"], JavaScript considers age to be a variable with a previously defined value, which it is not here and therefore cannot work in this case. You would have to set the age variable to have the value "age" for this to work.

The elements of an array are ordered according to their index (starting from 0, then 1, and so on), while the elements contained in an object are ordered according to the keys indicated for each element. But even though the lastname key is listed in the person object before the firstname key, this does not differentiate the object { age: 43, lastname: "Clinton", firstname: "Bill" } from the object { firstname: "Bill", lastname: "Clinton", age: 43 } because the order in which keys are written to an object is irrelevant.

Finally, there are empty objects, such as those containing no key (therefore no value). We write an empty object in the form { }, indicating nothing is inside. We can then add one or more keys to an object, even if it is initially empty.

Now that we have seen the main variable types used in JavaScript, let’s see how to use them to define variables in our programs.

Running a JavaScript program
JavaScript is a language that can be executed in a browser (Edge, Chrome, Firefox, Safari, and so on) or on a server with Node.js installed. Let’s see how to write JavaScript programs for these two types of configurations.

Running a JavaScript program in a browser
To run a JavaScript program in a browser, you must insert the JavaScript code into an HTML file. This HTML file will then be displayed in the browser, which will cause the execution of the JavaScript code included in the file.

JavaScript code can be specified in the HTML file in two different ways:

The first way is to write it between the <script> and </script> tags, directly in the HTML file. The <script> tag indicates the beginning of the JavaScript code, while the </script> tag indicates the end of it. Anything written between these two tags is considered JavaScript code.
The second way is to write the JavaScript code in an external file and then include this external file in the HTML file. The external file is included in the HTML file by means of a <script> tag in which the src attribute is indicated, the value of which is the name of the JavaScript file that will be included in the HTML page.
Let’s take a look at these two ways of writing the JavaScript code that will run in the browser.

Writing JavaScript code between the <script> and </script> tags
A file with an .html extension is used; for example, the index.html file. This file is a traditional HTML file, in which we have inserted the <script> and </script> tags, as shown in the following code snippet:

index.html file

<html>
  <head>
    <meta charset="utf-8" />
    <script>
      alert("This is a warning message displayed by 
      JavaScript");
    </script>
  </head>
  <body>
  </body>
</html>

Copy
We have inserted the <script> tag (and its ending </script>) in the <head> section of the HTML page. The <meta> tag is used to indicate the encoding characters to use. In the preceding code, we have used utf-8 so that accented characters can be displayed correctly.

The JavaScript code inserted here is rudimentary. We use the alert() function, which displays a dialog box on the browser screen, displaying the text of the message indicated in the first parameter of the function.

To run this HTML file, simply move it (by dragging and dropping) from the file manager to any browser; for example, Firefox. The following screen is then displayed:

Figure 1.1 – Displaying a message in the browser window
Figure 1.1 – Displaying a message in the browser window

The JavaScript code present in the <script> tag ran when the HTML page was loaded. The message indicated in the alert() function is therefore displayed. A click on the OK button validates the message displayed and continues the execution of the JavaScript code. As we can see, there is nothing more in the program; the program ends immediately by displaying a blank page on the screen (because no HTML code is inserted into the page).

Writing JavaScript code to an external file
Rather than integrating the JavaScript code directly into the HTML file, we can put it in an external file, then insert this file into our HTML file by indicating its name in the src attribute of the <script> tag.

Let’s first write the file that will contain the JavaScript code. This file has the file extension .js and will be named codejs.js, for example, and will be coded as follows:

codejs.js file (in the same directory as index.html)

alert("This is a warning message displayed by JavaScript");

Copy
The codejs.js file contains the JavaScript code that we had previously inserted between the <script> and </script> tags.

The index.html file is modified to include the codejs.js file using the src attribute of the <script> tag as follows:

index.html file

<html>
  <head>
    <meta charset="utf-8" />
    <script src="codejs.js"></script>
  </head>
  <body>
  </body>
</html>

Copy
Note

Notice the use of the <script> and </script> tags. They are contiguous (that is, they have no spaces or newlines between them), which is necessary for this code to work.

In the rest of our examples, we will mainly use the insertion of the JavaScript code directly in the code of the HTML file, but the use of an external file would produce the same results.

Let’s now explain another way to display messages, without blocking the program as before with the alert(message) function.

Using the console.log() method instead of the alert() function
The alert() function used earlier displays a window on the HTML page, and the JavaScript program hangs waiting for the user to click the OK button in the window. Thus, the function requires the intervention of the user to continue the execution of the program.

An alternative makes it possible to use a display without blocking the execution of the program. This is the display in the console, using the console.log() method.

Note

The console.log() form of writing means that we use the log() method, which is associated with the console object. This will be explained in detail in the following chapter.

Let’s write the program again using the console.log() method instead of the alert() function. The index.html file will be modified as follows:

index.html file using console.log() method

<html>
  <head>
    <meta charset="utf-8" />
    <script>
      // display a message in the console
      console.log("This is a warning message displayed by 
      JavaScript");
    </script>
  </head>
  <body>
  </body>
</html>

Copy
Note

The use of comments in the JavaScript program requires placing // before what needs to be commented out (on the same line). You can also comment out several lines by enclosing them with /* at the beginning and */ at the end.

Let’s run this program by pressing the F5 key on the keyboard to refresh the window. A white screen will appear, with no message.

Indeed, the message is only displayed in the console. The console is only visible if you press the F12 key (and can be removed by pressing F12 again).

Note

You can go to the site https://balsamiq.com/support/faqs/browserconsole/, which explains how to display the console in the event that the F12 key is inoperative.

The following is what you will see when the console is displayed:

Figure 1.2 – Message displayed in the console
Figure 1.2 – Message displayed in the console

The message is displayed in the lower part of the browser window.

Now that we have learned how to run a JavaScript program in a browser, let’s move on to learning how to run a JavaScript program on a Node.js server.

Running a JavaScript program on a Node.js server
To run a JavaScript program on a Node.js server, you must first install the Node.js server. To install, simply go to https://nodejs.org/ and download and install the server. Note that if you are using macOS, Node.js is already installed.

We can verify the correct installation of Node.js by just opening a shell and typing the command node -h in it. Node.js is correctly installed if the command help appears as follows:

Figure 1.3 – node -h command that displays help
Figure 1.3 – node -h command that displays help

Once Node.js is installed, it can run any JavaScript program you want. All you have to do is create a file containing JavaScript code, for example, testnode.js. The contents of this file will be executed by the server using the node testnode.js command.

Here is a very simple example of a JavaScript file that can be executed by Node.js: It displays a message in the server console. The server console here represents the command interpreter in which you type the command to execute the testnode.js file:

testnode.js file

console.log("This is a warning message displayed by JavaScript");

Copy
Let’s type the command node testnode.js in the preceding terminal window.

Figure 1.4 – Running a Node.js program
Figure 1.4 – Running a Node.js program

We see that the message is displayed directly in the command interpreter.

In the previous examples, we have written JavaScript code that runs both on the client side (the browser) and on the server side. The question that can be asked is: can the same code run in exactly the same way on the client side and on the server side?

Differences between JavaScript code written for the browser and the server
Although the two pieces of code are similar, we cannot say that they are the same, because the issues to be managed are different in the two cases. Indeed, on the client side, we will mainly want to manage the user interface with JavaScript, while on the server side, we will rather want to manage files or databases. So, the libraries to use in these two cases will not be the same.

On the other hand, we find in both cases the same basic language, which is the JavaScript language that we will be describing now.

Declaring variables in JavaScript
Variables of the types previously described under the Types of variables used in JavaScript section, as we know, consist of numerical values, Boolean values, character strings, arrays, and objects.

JavaScript is a weakly typed language, which means that you can change the type of a variable at any time. For example, a numeric variable can be transformed into a character string, or even become an array.

Of course, it is not advisable to make such voluntary changes in our programs, and it is prudent to maintain the type of a variable throughout the program, for comprehension. However, it is important to know that JavaScript allows changing variable types. A variant of JavaScript called TypeScript provides more security by preventing these type changes for variables.

Now let’s learn how to define a variable. We will do so using one of the following keywords: const, var, or let.

Using the const keyword
The const keyword is used to define a variable whose value will be constant. Any subsequent attempt to change the value will produce an error.

Let’s define the constant variable c1 having the value 12. Let’s try to modify the value by assigning it a new value: an error will be displayed in the console:

Note

To say that we are defining a constant variable is an abuse of language. We should rather say that we are defining a constant value.

Defining a constant value (index.html file)

<html>
  <head>
    <meta charset="utf-8" />
    <script>
      const c1 = 12;
      console.log(c1);
      c1 = 13;   // attempt to modify the value of a 
                 // constant: error
      console.log(c1);  // no display because an error 
                        // occurred above
    </script>
  </head>
  <body>
  </body>
</html>

Copy
After implementing the preceding code, we will also see the error displayed in the console (if the console is not visible, it can be displayed by pressing the F12 key) of the browser as follows:

Figure 1.5 – Error when modifying a constant value
Figure 1.5 – Error when modifying a constant value

As we can see from the preceding figure, the first display of the constant c1 displays the value 12, while the second display does not occur because an error occurred before (while trying to change the value of a constant). Therefore, a value defined by the const keyword should not be modified.

Using the var keyword
Another way to define a variable (whose value can be modified) is to use the var keyword. Let’s see how using the following code example:

Definitions of several variables

<html>
  <head>
    <meta charset="utf-8" />
    <script>
      var a = 12;
      var b = 56;
      var c = a + b;
      var s1 = "My name is ";
      var firstname = "Bill";
      console.log("a + b = " + a + b);
      console.log("c = " + c);
      console.log(s1 + firstname);    
    </script>
  </head>
  <body>
  </body>
</html>

Copy
We defined the variables a, b, s1, and firstname by preceding them with the keyword var and assigning them a default value. The variable c corresponds to the addition of the variables a and b.

Note

The name of a variable consists of alphanumeric characters but must start with an alphabetic character. Lowercase and uppercase are important in writing the variable name (variables’ names are case sensitive). Thus, the variable a is different from the variable A.

The result of the previous program is displayed in the browser console (if it is not visible, it must be displayed by pressing the F12 key):

Figure 1.6 – Using the var keyword
Figure 1.6 – Using the var keyword

In the preceding figure, we can see a result that may seem surprising. Indeed, the direct calculation of a + b produces the display of 1256 the first time, then 68 the second time.

Indeed, when we write console.log("a + b = " + a + b); the fact that we’ve started to display characters by writing "a + b = " means that JavaScript will interpret the rest of the display in the form of a character string; in particular, the values a and b, which follow on the line. So, the values a and b are no longer interpreted as numeric values, but as the character strings 12 and 56. When these character strings are connected by the + operator, this does not correspond to addition but to concatenation.

Conversely, the calculation of the variable c does not involve character strings, so the result of a + b here is equal to the sum of the values of the variables a and b, therefore 68.

Note that the same program can be run on the Node.js server. To do so, we would write it in our testnode.js file as follows:

testnode.js file

var a = 12;
var b = 56;
var c = a + b;
var s1 = "My name is ";
var firstname = "Bill";
console.log("a + b = " + a + b);
console.log("c = " + c);
console.log(s1 + firstname);

Copy
We can then execute the preceding code with the node testnode.js command. The result displayed under Node.js is similar to that displayed in the browser console:

Figure 1.7 – Running the program under Node.js
Figure 1.7 – Running the program under Node.js

We learned about the const and var keywords for defining variables; all that remains is for us to learn how to use the let keyword.

Using the let keyword
To understand the use of the let keyword and see the difference from the var keyword, we must use braces in our programs. Braces are used to create program blocks in which instructions are inserted, in particular after the conditional if and else instructions (which we will see in the Writing conditions section).

Let’s write a simple if(true) condition that is always true: the code included in the braces following the condition is therefore always executed:

index.html file including a condition

<html>
  <head>
    <meta charset="utf-8" />
    <script>
      var a = 12;
      if (true) {  // always executed (because always true)
        var b = 56;
        let c = 89;
        console.log("In the brace:");
        console.log("a = " + a);
        console.log("b = " + b);
        console.log("c = " + c);
      }
      console.log("After the brace:");
      console.log("a = " + a);
      console.log("b = " + b);
      console.log("c = " + c);
    </script>
  </head>
  <body>
  </body>
</html>

Copy
In the preceding code, we have defined the variable a outside of any braces. This variable will therefore be accessible everywhere (in and out of braces) as soon as it is defined.

The variables b and c are defined within braces following the condition. Variable b is defined using var, while variable c is defined using the let keyword. The difference between the two variables is visible as soon as you exit the block of braces. Indeed, the variable c (defined by let) is no longer known outside the block of braces where it is defined, unlike the variable b (defined by var), which is accessible even outside.

This can be checked by running the program in the browser as follows:

Figure 1.8 – The variable c defined by let is inaccessible outside the block where it is defined
Figure 1.8 – The variable c defined by let is inaccessible outside the block where it is defined

Note that the same program gives a similar result on the Node.js server, as can be seen in the following screen: the variable c defined by let in a block becomes unknown outside the block.

Figure 1.9 – The same results on the Node.js server
Figure 1.9 – The same results on the Node.js server

As we can see in the preceding screen, the variable c, defined by let in a block, becomes unknown outside the block.

What if we don’t use var or let to define a variable?
It is possible not to use the var or let keywords to define a variable. We can simply write the variable’s name followed by its value (separated by the sign =). Let’s see how using the following example:

Creating variables without specifying var or let

a = 12;
b = 56;
console.log("a = " + a);    // displays the value 12
console.log("b = " + b);    // displays the value 56

Copy
In the preceding example, where the variables are initialized without being preceded by var or let, these variables are global variables. As soon as they are initialized, they become accessible everywhere else in the program. This will become apparent when we study the functions in the Using functions section of this chapter.

Note

It is strongly advised to use as few global variables as possible in the programs, as this complicates the design and debugging of the programs that contain them.

What is an uninitialized variable worth?
Each of the preceding variables was declared by initializing its value, with the = sign, which is the assignment sign. Let’s see what happens if we don’t assign any value to the variable, but just declare it using var or let as follows:

Declaration of variables without initialization

<html>
  <head>
    <meta charset="utf-8" />
    <script>
      var a;
      let b;
      console.log("a = " + a);    // displays the value 
                                  // undefined
      console.log("b = " + b);    // displays the value 
                                  // undefined
    </script>
  </head>
  <body>
  </body>
</html>

Copy
In the preceding code, we have defined two variables, a and b – one using var, the other using let. Neither of the two variables has an initial value (that is, they’re not followed by an = sign).

The result displayed in this case for these uninitialized variables is a JavaScript value called undefined. This corresponds to the value of a variable that does not yet have a value. The undefined value is an important keyword in the JavaScript language.

Note

The variables a and b are not initialized, and it is necessary to declare them using var or let. Indeed, you cannot simply write a; or b; as this would cause a runtime error.

Let’s run the preceding program in the browser and observe the results displayed in the console:

Figure 1.10 – An uninitialized variable is undefined
Figure 1.10 – An uninitialized variable is undefined

Note

The undefined value is also associated with an uninitialized variable if using server-side JavaScript with Node.js.

We now know how to define variables in JavaScript. To create useful JavaScript programs, you have to write sequences of instructions. One of the most used instructions allows you to write conditional tests with the if statement, which we will talk about next.

Writing conditions for conditional tests
JavaScript obviously allows you to write conditions in programs. The condition is expressed through the if (condition) statement:

If the condition is true, the statement (or block in braces) that follows is executed.
If the condition is false, the statement (or block) following the else keyword (if present) will be executed.
Forms of writing instructions
We can use the following forms to express the conditions:

Forms of conditional expressions with if (condition)

// condition followed by a statement
if (condition) statement;   // statement executed if condition is true
// condition followed by a block
if (condition) {
  // block of statements executed if condition is true
  statement 1;   
  statement 2;   
  statement 3;   
}

Copy
Forms of conditional expressions with if (condition) … else …

// condition followed by a statement
if (condition) statement 1;   // statement 1 executed if 
                              // condition is true
else statement 2;             // statement 2 executed if 
                              // condition is false
// condition followed by a block
if (condition) {
  // block of statements executed if condition is true
  statement 1;   
  statement 2;   
  statement 3;   
}
else {
  // block of statements executed if condition is false
  statement 5;   
  statement 6;   
  statement 7;   
}

Copy
Note

If the process to be executed includes several instructions, these instructions are grouped together in a block surrounded by braces. A block can consist of only one statement, even if, as in this case, the block is optional (no need for braces).

Let’s write the following program in the testnode.js file, which we will execute using the node testnode.js command in a command interpreter, as follows:

testnode.js file

var a = 12;
console.log("a = " + a);
if (a == 12) console.log("a is 12");
else console.log("a is not 12");

Copy
In the preceding code, the condition is expressed in the form a == 12. Indeed, it is customary to test the equality between two values by means of the sign = repeated twice successively (hence ==).

Note

We use == for equality, != for difference, > or >= to check superiority, and < or <= to check inferiority.

In the preceding code, since the variable a is 12, the following result can be seen:

Figure 1.11 – Using conditional tests
Figure 1.11 – Using conditional tests

If we assign the value 13 to the variable a, the else part of the statement will be executed:

Figure 1.12 – Running the else part of the test
Figure 1.12 – Running the else part of the test

We have seen how to execute one part of the code or another depending on a condition. Let’s now study how to write more complex conditions than those written previously.

Expressions used to write conditions
The condition written previously is a simple test of equality between two values. But the test to write can sometimes be more complex. The goal is to have the final result of the condition, which is true or false, which will then make it possible for the system to decide the next course of action.

The condition is written in Boolean form with the OR keyword (written as ||) or with the AND keyword (written as &&). Parentheses between the different conditions may be necessary to express the final condition as follows:

Condition expressed with “or”

var a = 13;
var b = 56;
console.log("a = " + a);
console.log("b = " + b);
if (a == 12 || b > 50) console.log("condition a == 12 || b > 50 is true");
else console.log("condition a == 12 || b > 50 is false");

Copy
In the preceding code, since the variable b is greater than 50, the condition is true, as seen in Figure 1.13.

Note

In an OR condition, it suffices that one of the conditions is true for the final condition to be true.

In an AND condition, all the conditions must be true for the final condition to be true.

Figure 1.13 – Condition with or
Figure 1.13 – Condition with or

By default, the condition expressed in if(condition) is compared with the value true. We can sometimes prefer to compare with the value false. In this case, it suffices to precede the condition with the sign !, which corresponds to a negation of the following condition.

It is sometimes necessary to chain several tests in a row, depending on the results of the previous tests. We then have a succession of tests, called cascade tests.

Nested test suites
It is possible to chain tests in the processes to be performed. Here is an example:

Test nesting

var a = 13;
var b = 56;
console.log("a = " + a);
console.log("b = " + b);
if (a == 12) console.log("condition a == 12 is true");
else {
  console.log("condition a == 12 is false");
  if (b > 50) console.log("condition b > 50 is true");
  else console.log("condition b > 50 is false");
}

Copy
The else part is composed of several statements and is grouped in a block surrounded by braces:

Figure 1.14 – Test nesting
Figure 1.14 – Test nesting

We learned about writing conditions in JavaScript programs. We are now going to learn how to write processing loops, which make it possible to write the instructions in the program only once. These instructions can, however, be executed as many times as necessary.

Creating processing loops
It is sometimes necessary to repeat an instruction (or a block of instructions) several times. Rather than writing it several times in the program, we put it in a processing loop. These instructions will be repeated as many times as necessary.

Two types of processing loops are possible in JavaScript:

Loops with the while() statement
Loops with the for() statement
Let’s take a look at these two types of loops.

Loops with while()
The while(condition) instruction allows you to repeat the instruction (or the block of instructions) that follows. As long as the condition is true, the statement (or block) is executed. It stops when the condition becomes false.

Using this while() statement, let’s display the numbers from 0 to 5:

Displaying numbers from 0 to 5

var i = 0;
while (i <= 5) {
  console.log("i = " + i);
  i++;
}

Copy
The preceding console.log() instruction is written only once in the program, but as it is inserted in a loop (while() instruction), it will be repeated as many times as the condition is true.

The variable i allows you to manage the condition in the loop. The variable i is incremented by 1 (by i++) at each pass through the loop, and we stop when the value 5 is exceeded:

Figure 1.15 – Displaying numbers from 0 to 5
Figure 1.15 – Displaying numbers from 0 to 5

We can verify that this program works in a similar way on the client side, that is to say in a web browser, as follows:

Displaying digits 0–5 in a browser console

<html>
  <head>
    <meta charset="utf-8" />
    <script>
      var i = 0;
      while (i <= 5) {
        console.log("i = " + i);
        i++;
      }
    </script>
  </head>
  <body>
  </body>
</html>

Copy
The result is displayed similarly in the browser console:

Figure 1.16 – Displaying numbers from 0 to 5 in the browser console
Figure 1.16 – Displaying numbers from 0 to 5 in the browser console

Loops with for()
Another widely used form of loop is one with a for() statement. It simplifies the writing of the previous loop by reducing the number of instructions to write.

Let’s write the same program as before to display the numbers from 0 to 5 using a for() statement instead of the while() statement:

for (var i=0; i <= 5; i++) console.log("i = " + i);

Copy
As we can see in the preceding code, a single line replaces several lines as in the previous instance.

The for() statement has three parts, separated by a ;:

The first corresponds to the initialization instruction. Here, it is the declaration of the variable i initialized to 0 (which is the beginning of the loop).
The second corresponds to the condition: as long as this condition is true, the statement (or the block that follows) is executed. Here, the condition corresponds to the fact that the variable i has not exceeded the final value 5.
The third corresponds to an instruction executed after each pass through the loop. Here, we increment the variable i by 1. This ensures that at some point, the condition will be false, in order to exit the loop.
Let’s verify that it works identically to the while() statement:

Figure 1.17 – Loop with the for() statement
Figure 1.17 – Loop with the for() statement

In this section, we learned how to write sequences of statements that will be executed multiple times, using the while() and for() statements. Now let’s look at how to group statements together, using what are called functions.

Using functions
A function is used to give a name to a block of instructions so that it can be used in different places in the program. In general, in a function, we group a set of instructions that are used to carry out a particular task, for example:

Display the list of the first 10 integers.
Calculate the sum of the first 10 numbers (from 0 to 9).
Calculate the sum of the first N numbers (from 0 to N-1). In this case, N would be a parameter of the function because it can change with each call (or use) of the function.
The functions described above are very simple but show that the role of functions is to encapsulate any process by summarizing in one sentence what is expected of this process. The name given to the function symbolizes the action expected in return, which allows the developer to easily understand the sequence of instructions (including for an external developer who has not participated in the development). Let’s discuss the three functions we listed one by one.

Function displaying the list of the first 10 integers
Let’s write the first function, which displays the list of the first 10 integers. We will call this function display_10_first_integers(). The name must be as explicit as possible because a JavaScript program is composed of many functions whose names must be unique in the program (if two function names are the same, only the last one is taken into account because it overwrites the former).

A function is defined using the keyword function, followed by the name of the function, followed by parentheses. Then, we indicate in the braces that follow the instructions that make up the function. It is this instruction block that will be executed each time the function is called in the program.

Let’s write the function display_10_first_integers(), which displays the first 10 integers:

Display first 10 integers with a function (testnode.js file)

function display_10_first_integers() {
  for (var i=0; i <= 10; i++) console.log("i = " + i);
}

Copy
The function is defined using the function keyword, followed by the function name and parentheses.

The function statements are grouped in the block that follows between the braces. We find as instructions the previous for() loop, but it could also be the while() loop, which works in the same way.

Let’s run this program assuming it’s included in the testnode.js file:

Figure 1.18 – Using a function to display numbers from 1 to 10
Figure 1.18 – Using a function to display numbers from 1 to 10

As we can see in the preceding figure, the screen remains blank as no display is registered in the console.

Indeed, we have simply defined the function, but we must also use it, that is, call it in our program. You can call it as many times as you want – this is the purpose of functions: we should be able to call (or use) them at any time. But it must be done at least once; otherwise, it is useless, as seen in the preceding figure.

Let’s add the function call following the function definition:

Definition and call of the function

// function definition
function display_10_first_integers() {
  for (var i=0; i <= 10; i++) console.log("i = " + i);
}
// function call
display_10_first_integers();

Copy
The result of the preceding code can be seen in the following figure:

Figure 1.19 – Call of the display_10_first_integers() function
Figure 1.19 – Call of the display_10_first_integers() function

Interestingly, the function can be called in several places of the program. Let’s see how in the following example:

Successive calls to the display_10_first_integers() function

// function definition
function display_10_first_integers() {
  for (var i=0; i <= 10; i++) console.log("i = " + i);
}
// function call
console.log("*** 1st call *** ");
display_10_first_integers(); 
console.log("*** 2nd call *** ");
display_10_first_integers(); 
console.log("*** 3rd call *** ");
display_10_first_integers();  

Copy
In the preceding code, the function is called three times in succession, which displays the list of the first 10 integers as many times. The order of the calls is indicated before each list as follows:

Figure 1.20 – Successive calls to the display_10_first_integers() function
Figure 1.20 – Successive calls to the display_10_first_integers() function

Function calculating the sum of the first 10 integers
We now want to create a function that calculates the sum of the first 10 integers, that is, 1+2+3+4+5+6+7+8+9+10. The result is 55. This will allow us to show how a function can return a result to the outside (that is, to the program that uses it). Here, the function should return 55.

Let’s call the function add_10_first_integers(). This can be written as follows:

Function that adds the first 10 integers

// function definition
function add_10_first_integers() {
  var total = 0;
  for (var i = 0; i <= 10; i++) total += i;
  return total;
}
// function call
var total = add_10_first_integers();
console.log("Total = " + total);

Copy
We define the total variable in the function. This variable is a local variable to the function because it is defined using the var or let keyword. This allows this total variable to not be the same as the one defined outside the function, even if the names are the same.

Note

If the total variable in the function was not defined using the var or let keyword, it would create a so-called global variable that would be directly accessible even outside the function. This is not good programming because you want to use global variables as little as possible.

The function uses a for() loop to add the first 10 integers, then returns that total using the return keyword. This keyword makes it possible to make accessible, outside the function, the value of any variable, in our example, the total variable.

Let’s run the previous program. We should see the following output:

Figure 1.21 – Calculation of the sum of the first 10 integers
Figure 1.21 – Calculation of the sum of the first 10 integers

Function calculating the sum of the first N integers
The previous function is not very useful because it always returns the same result. A more useful function would be to calculate the sum of the first N integers, knowing that N can be different each time the function is called.

N would in this case be a parameter of the function. Its value is indicated in parentheses when using the function.

Let’s call the add_N_first_integers()function to calculate this sum. The N parameter would be indicated in parentheses following the function name. A function can use several parameters, and it suffices to indicate them in succession, separated by a comma. In our example, a single parameter is enough.

Let’s write the add_N_first_integers(n)function and use that to calculate the sum of the first 10, then 25, then 100 integers. The values 10, 25, and 100 will be used as parameters during successive calls to the function and will replace the parameter n indicated in the definition of the function:

Function that adds the first N integers

// function definition
function add_N_first_integers(n) {
  var total = 0;
  for (var i = 0; i <= n; i++) total += i;
  return total;
}
// calculation of the first 10 integers
var total_10 = add_N_first_integers(10);
console.log("Total of the first 10 integers = " + total_10);
// calculation of the first 25 integers
var total_25 = add_N_first_integers(25);
console.log("Total of the first 25 integers = " + total_25);
// calculation of the first 100 integers
var total_100 = add_N_first_integers(100);
console.log("Total of the first 100 integers = " + total_100);

Copy
The add_N_first_integers(n) function is very similar to the add_10_first_integers() function written earlier. It uses the parameter n indicated between the parentheses and does not loop from 0 to 10 as before, but from 0 to n. Depending on the value of n that will be used when calling the function, the loop will thus be different, and the result returned by the function as well.

When calling the function, it passes the parameters 10, 25, then 100 as desired. The result is returned by the function’s total variable, and then used by the total_10, total_25, and total_100 variables outside the function:

Figure 1.22 – Calculation of the sum of the first 10, then 25, then 100 integers
Figure 1.22 – Calculation of the sum of the first 10, then 25, then 100 integers

Summary
The basic features of JavaScript have been covered in this chapter: variables with different types, conditional tests, loops, and functions. They are used on the client side and on the server side.

In the next chapter, we’ll take a look at some more in-depth features of JavaScript, such as object-oriented programming with JavaScript.

