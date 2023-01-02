
@ Q -> # 붙이고 줄 띄우기 => 0i### ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i```^M^[/^Copy$^[ddk0C```^M^[
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(`) 붙이기 => i`^[/ ^[i`^[/EEEEEEEEEE^[
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(`) 붙이기 => i`^[/\.^[i`^[/RRRRRRRRRR^[
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(`) 붙이기 => i`^[/,^[i`^[/TTTTTTTTTT^[
@ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(`) 붙이기 => i`^[/;^[i`^[/YYYYYYYYYY^[
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(`) 붙이기 => i`^[/)^[i`^[/UUUUUUUUUU^[
@ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(`) 붙이기 => i`^[/:^[i`^[/CCCCCCCCCC^[

@ A -> 빈 줄에 블록 시작하기 => 0C```^[^Mk0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i```^M-^[^M0i```^[0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi```^M^M^[kk
@ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
    마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

> [ 08 P3 JavaScript on the Server-Side ](/packtpub/javascript_from_frontend_to_backend/08_p3_javascript_on_the_server-side) <---> [ 10 C7 Using Express with Node.js ](/packtpub/javascript_from_frontend_to_backend/10_c7_using_express_with_node_js)

# Chapter 6: Creating and Using Node.js Modules

Modules are at the heart of Node.js. They correspond to JavaScript files and can be used in our applications. A program for the Node.js server will consist of a set of modules, that is, JavaScript files.

There are three kinds of modules:

- Modules that we write ourselves for our applications.
- Modules internal to Node.js and usable directly.
- Modules that can be downloaded from the internet using a utility called `npm` (npm stands for Node.js package manager). This `npm` utility is installed with Node.js itself.

In this chapter, we will learn how to create and use these different types of modules.

Regardless of the type of modules used, the `require(moduleName)` instruction (see below) allows the module called `moduleName` to be included in the current file. The functionalities of the module will then be accessible.

Here are the topics covered in this chapter:

- Using our own modules
- Using internal Node.js modules
- Using downloaded modules with npm

Let’s first see how to create and use our own modules with Node.js.

# Technical requirements

You can find the code files for this chapter on GitHub at: https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend/blob/main/Chapter%206.zip.

# Creating and using our own modules

In this example, we use two modules, each corresponding to a JavaScript file:

- The first module (here named `test.js`) will be the main file of our application, the one we execute using the `node test.js` command in a command window.
- The second module (here named `module1.js`) will be the one we want to use in our main `test.js` module. The `module1.js` module will then be enriched to show how its functionalities are accessible outside the module (and will therefore be used in the main `test.js` module).

Let’s go ahead and create these two modules.

## Creating a module

Here is the content of the two files, `module1.js` and `test.js`:

module1.js file

```
console.log("module1.js is loaded");
```

The module currently has a simple `console.log()` statement. The module will then be enriched. The main module test.js is the following:

```
test.js file

var mod1 = require("./module1.js");  
// or require("./module1") without specifying the .js extension
console.log("mod1 =", mod1);
```

Here, we use the `require(moduleName)` instruction, which allows us to load in memory the `moduleName` module. Any use of the functionalities of the `moduleName` module requires the `require(moduleName)` instruction beforehand.

The `require(moduleName)` instruction returns a reference to the module loaded in memory. This reference is stored in a variable (here, `mod1`), which will then allow access to the functionalities described in the module (here, none for the moment).

The `test.js` file is the main file that loads the other modules. It is therefore this `test.js` file that is executed using the `node test.js` instruction in a command window.

![ 0600 6.1 – Using a module with ](/packtpub/javascript_from_frontend_to_backend_img/0600_6.1_–_using_a_module_with.webp)
Figure 6.1 – Using a module with require(module)

We can see here that the execution of the main `test.js` module invokes the call of the `require("./module1.js")` instruction, which executes the content of the `module1.js` file, hence the display text specified in the `console.log()` statement in the `module1.js` module.

After loading `module1.js`, the `mod1` variable is initialized and we will be able to access functionalities that the module exports later on.

Before adding functionalities to the `module1.js` module, let’s see how to manage the location of modules using the `node_modules` directory. The `node_modules` directory is used by Node.js to locate modules for which it does not have a path. Using this directory simplifies the writing of module names when loading them into memory with the `require(moduleName)` instruction.

## Using the node_modules directory

Note that the previous `require(moduleName)` statement requires indicating the access path to the module, for example, `"./"` to indicate the current directory.

However, if the module is in the `node_modules` directory, it is not necessary to indicate the path because we are sure that the module is inside the `node_modules` directory (and moreover, it should **not** be specified). The `node_modules` directory can be in the main application directory (called the **local** `node_modules` directory) or in a dedicated directory created by Node.js (called the **global** `node_modules` directory: in this case, it is automatically created during the installation of Node.js).

Note

If the module is not found in the `node_modules` directory (local or global) and if the access path to the module is not indicated, an error occurs when loading the module with the `require(moduleName)` instruction.

Now, we will create a `node_modules` directory in the current directory where the main file, `test.js`, is located. Let’s transfer the `module1.js` file to this directory and use the `require("module1.js")` statement without specifying the path to the module. You can also write `require("module1")` without indicating the extension of the JavaScript file:

Include module1 located in node_modules directory (test.js file)

```
var mod1 = require("module1.js");  // or require("module1")
console.log("mod1 =", mod1);
```

The `module1.js` file must be in the locally created `node_modules` directory, while the `test.js` file remains in the current directory, as described here:

root/
|— node_modules/
│ |— module1.js
|— test.js

![ 0601 6.2 – The module is loaded from ](/packtpub/javascript_from_frontend_to_backend_img/0601_6.2_–_the_module_is_loaded_from.webp)
Figure 6.2 – The module is loaded from the node_modules directory

We can see that the module is indeed found by Node.js, because Node.js looks for it in the `node_modules` directory, which was created in the current directory.

Now let’s see how to allow a module’s files to be grouped in a directory, using the `package.json` file associated with the module.

## Using the package.json file

The `node_modules` directory (whether located in the application directory or the Node.js installation directory) can contain a lot of files and sometimes a module can consist of many files and directories. It would be easier to associate a module with a directory in the `node_modules` directory.

Let’s create the `module1` directory inside the `node_modules` directory. The `module1` directory contains the `module1.js` file but may also contain other files and directories related to this module.

The file system is displayed here:

root/
|— node_modules/
| |— module1/
│ |— module1.js
|— test.js

Note

The `moduleName` indicated in the `require(moduleName)` statement represents, in this case, the name of the directory that contains the module files.

But as it is necessary to know which file of the directory we must use first when loading the module (as there can be many files in this directory), we indicate this correspondence in the `package.json` file in the `"main"` key.

The `package.json` file is a text file in JSON format, located in the directory of each Node.js module.

Now, we will create the `package.json` file in the `module1` module directory and indicate in this file the `"main"` key with the value `"module1.js"`.

The file system is as follows:

root/
|— node_modules/
| |— module1/
│ |— module1.js
│ |— package.json
|— test.js

package.json file in the node_modules/module1 directory (package.json file)

```
{
  "main" : "module1.js"
}
```

We indicate in the `"main"` key that we must load the `module1.js` file during the `require("module1")` instruction:

Including module1 located in node_modules/module1 directory (test.js file)

```
var mod1 = require("module1"); //"module1" is the directory name
console.log("mod1 =", mod1);
```

Note

Please note that the module name in the `require("module1")` statement in this case is the name of the directory that contains the module in the `node_modules` directory. So, we cannot write the instruction here in the form `require("module1.js"),` which would cause an error.

We now visualize the execution of the `test.js` file:

![ 0602 6.3 – Module loaded with the ](/packtpub/javascript_from_frontend_to_backend_img/0602_6.3_–_module_loaded_with_the.webp)
Figure 6.3 – Module loaded with the package.json file

The `"main"` key in the `package.json` file is optional if the main module file is named `index.js`. In all other cases, the `"main"` key must be indicated in `package.json`.

We know how to run a module, but for now, the module contains a simple `console.log()` statement. Let’s see how to add features to the module and then use them.

## Adding functionalities to the module

The newly created `module1.js` module is accessible but does not currently offer any functionality. Let’s see how to add some.

### Exporting multiple functions in the module

For example, let’s create the function `add(a, b)`, which returns the sum of `a` and `b`:

add(a, b) function defined in module1.js (module1.js file)

```
console.log("module1 is loaded");
function add(a, b) {
  return a+b;
}
module.exports = { 
  add : add     // make the add() function accessible 
                // outside the module
}; 
```

To export a function outside of a module (and make it accessible to users of the module), you can just embed it in the `module.exports` object defined by Node.js in each module. Each key defined in the `module.exports` object will be a function accessible outside the module.

We can thus define several functions in the module that will be accessible thanks to the `module.exports` object.

The usage of the `add(a, b)` function in the `test.js` file is as follows:

Using add() function in test.js file (test.js file)

```
var mod1 = require("module1");
console.log("mod1 =", mod1);
var total = mod1.add(2, 3);      // call of the add() function 
                                 // defined in module1
console.log("mod1.add(2, 3) = ", total);  // displays 5
```

The following display is obtained:

![ 0603 6.4 – The add() function added to ](/packtpub/javascript_from_frontend_to_backend_img/0603_6.4_–_the_add()_function_added_to.webp)
Figure 6.4 – The add() function added to the module

Let’s add a second function in the module. For example, the function `mult(a, b)`, which returns `a\*b`.

If we add the `mult(a, b)` function in the module, it is written as follows:

Adding the mult(a, b) function to the module (module1.js file)

```
console.log("module1 is loaded");
function add(a, b) {
  return a+b;
}
function mult(a, b) {
  return a*b;
}
module.exports = {
  add : add,
  mult : mult
}
```

Now, we will use the two functions `add()` and `mult()` in the `test.js` file. This verifies that a module can provide several functionalities to other modules that use it:

Using the module’s add() and mult() functions (test.js file)

```
var mod1 = require("module1");
console.log("mod1 =", mod1);
var total = mod1.add(2, 3);
console.log("mod1.add(2, 3) = ", total);      // 2 + 3 = 5
var total = mod1.mult(2, 3);
console.log("mod1.mult(2, 3) = ", total);     // 2 * 3 = 6
```

The following display is obtained:

![ 0604 6.5 – Using the two functions of ](/packtpub/javascript_from_frontend_to_backend_img/0604_6.5_–_using_the_two_functions_of.webp)
Figure 6.5 – Using the two functions of the module

Now let’s see how to improve the module concept by using a so-called main function in the module.

### Allowing a function to be the main function of the module

Often, the module wishes to make a function its main function (the other functions defined in the module are secondary functions). This allows access to this main function in a simplified form.

Suppose (as before) that `module1` makes available the `add(a, b)` function and the `mult(a, b) `function. We want the `add()` function to be the main function of the module, which means that we can use it outside the module as `mod1(2, 3)` instead of `mod1.add(2, 3)`. The `mult(a, b)` function will remain accessible in the form `mod1.mult(2, 3)`.

Note

Note that only one function can be defined as the main function in a module.

In this case, just specify it in the `module.exports` object like so:

Making the add() function accessible as a main module function (module1.js file)

```
console.log("module1 is loaded");
function add(a, b) {
  return a+b;
}
function mult(a, b) {
  return a*b;
}
// first define the main function
module.exports = add;  // the add() function defined outside 
                       // the module, is made main
// then define the secondary functions
module.exports.mult = mult;   // and the mult() function 
                              // becomes usable as well
```

Note

It is important to assign the values in this order in the `module.exports` object (define the main function first, then the secondary functions). If you make the assignment in the other direction (`module.exports.mult` first, then `module.exports`), the assignment of `module.exports` last will erase the value already positioned in `module.exports.mult`.

Also, we can no longer assign `module.exports` as an object, because that would remove the previously assigned value if we wrote `module.exports = { mult : mult }`.

We now use the module as follows:

Using the module1.js module that has a main function (test.js file)

```
var mod1 = require("module1");
console.log("mod1 =", mod1);
var total = mod1(2, 3);          // instead of mod1.add(2, 3)
console.log("mod1(2, 3) = ", total);
var total = mod1.mult(2, 3);
console.log("mod1.mult(2, 3) = ", total);
```

The following display is obtained:

![ 0605 6.6 – Using the module with the main ](/packtpub/javascript_from_frontend_to_backend_img/0605_6.6_–_using_the_module_with_the_main.webp)
Figure 6.6 – Using the module with the main function

Note

Notice that instead of using the `mod1` variable as an object, we now use it as a function. In the call to `mod1(a, b)` causes the addition of a and b, so it is preferable that the variable be named `"add"` rather than `"mod1"` in the instruction `require(moduleName)`.

We saw how to create and use our own module. Now let’s take a look at how to use internal Node.js modules.

# Using internal Node.js modules

Node.js already has internal modules. They can also be used with the `require(moduleName)` instruction seen previously.

Let’s look at an example of an internal module. There is, for example, the `"fs"` module in the Node.js system. The name `"fs"` is short for file system. This module allows you to interact with the internal file system of Node.js.

Now, we will use the `"fs"` module to read the contents of a file.

## Reading the contents of a file

Let’s use the `"fs"` module to read the file named `file1.txt` located in the current directory (where the `test.js` file is located). Here are the contents of this file:

file1.txt file (in the directory where test.js is located)

```
This is the content
of the file file1.txt
located in
the current directory.
```

The program that uses the `"fs"` module and displays the contents of the file is as follows:

Reading and displaying the contents of the file (test.js file)

```
var fs = require("fs");
var data = fs.readFileSync("file1.txt");
console.log("File content:");
console.log(data);
```

We use the `readFileSync()` method defined in the `"fs"` module. It returns the contents of the file in the corresponding variable, which is then displayed.

![ 0606 6.7 – Displaying file contents using ](/packtpub/javascript_from_frontend_to_backend_img/0606_6.7_–_displaying_file_contents_using.webp)
Figure 6.7 – Displaying file contents using the “fs” module

The contents of the file are displayed but as hexadecimal characters. Next, let’s display the contents of the file as strings.

## Displaying file contents as strings

The contents of the file are displayed in the form of a buffer of bytes (see Figure 6.7). Node.js makes it easy to manipulate byte streams. It is also possible to view the contents of the file directly as strings by specifying the `{encoding: "utf-8"}` option in the second parameter (`options`) of the `readFileSync(name, options)` method:

Displaying file contents as strings (test.js file)

```
var fs = require("fs");
var data = fs.readFileSync("file1.txt", { encoding : "utf-8" });
console.log("File content:");
console.log(data);
```

The result is now displayed as strings (see the following figure):

![ 0607 6.8 – Displaying file contents as strings ](/packtpub/javascript_from_frontend_to_backend_img/0607_6.8_–_displaying_file_contents_as_strings.webp)
Figure 6.8 – Displaying file contents as strings

The contents of the file are displayed. However, the program waits for the contents of the file to be retrieved in order to display them. By using the `readFile()` method instead of the `readFileSync()` method, it is possible to not block the program while waiting for the file.

## Using non-blocking file reading

If you observe the previous `readFileSync()` method, you will see that the contents of the file are rendered in return for the method call. This means that the Node.js program is blocked while the file is being read (even if only for a few milliseconds). Within our small program, this is not noticeable, but in a case where the reading of the file is carried out by thousands of simultaneous users (for example, on a server), this will slow down access to the server.

For this, Node.js has provided, for all blocking features such as this one, a non-blocking version of the method. Rather than returning the return result of the method (as before), we use a callback function indicated as a parameter of the method. In the case of reading the file, we will therefore use the `readFile(name, options, callback)` method, also defined in the `"fs"` module. The result of reading the file will be passed as a parameter in the callback function.

Let’s use the non-blocking form of reading the file, using the `readFile()` method instead of the `readFileSync()` method:

Using readFile() method to read the file (test.js file)

```
var fs = require("fs");
console.log("File content:");
fs.readFile("file1.txt", { encoding : "utf-8" }, function(error, data) {
  console.log(data);
});
console.log("The readFile() method was called");
```

Note

The callback function uses the `error` and `data` parameters (in that order), which respectively correspond to a possible error message (`null` if none), and to the contents of the file if the latter has been read. The `options` parameter indicated as the second parameter of `readFile()` is similar to that of the `readFileSync(name, options)` method.

The result is displayed here:

![ 0608 6.9 – Displaying file contents using the ](/packtpub/javascript_from_frontend_to_backend_img/0608_6.9_–_displaying_file_contents_using_the.webp)
Figure 6.9 – Displaying file contents using the non-blocking readFile() method

We can check in the result displayed above that the `readFile()` method is really non-blocking. Indeed, the text indicated following the call to the `readFile()` method is displayed in the console even though the file has not yet been read and displayed, which would have been impossible using the blocking method `readFileSync()`.

Note

We can therefore see that the use of modules internal to Node.js is done very simply by using the `require(moduleName)` instruction, and then by calling methods on the object returned by this instruction.

We have seen how to create and use your own modules, and how to use internal Node.js modules.

Now let’s see how to use modules available on the internet using the npm command.

# Using downloaded modules with npm

In addition to the modules internal to Node.js, it is possible to import modules from the internet using the `npm` utility provided with Node.js.

For this, the `npm` command is used (in a command interpreter) by indicating arguments that allow you to perform the corresponding actions on the imported modules.

## Using the npm command

Here are some common uses of the `npm` command:

- `npm install moduleName`: Installs the indicated module in the **local** `node_modules` directory. The module will only be accessible for the current application and not for other applications (unless it is installed again).
- `npm install moduleName -g`: Installs the specified module in the global `node_modules` directory. The `-g` option allows you to indicate that this module can be accessed by other applications because it is installed in the `node_modules` directory of Node.js (globally).
- `npm link moduleName`: It is possible that a module installed globally (with the `-g` option) is inaccessible (you get a module loading error during the `require(moduleName)` statement). In this case, it is necessary to run the `npm link moduleName` command.
- `npm ll`: Lists modules already present in the local `node_modules` directory.
- `npm ll -g`: Lists modules already present in the global `node_modules` directory.
- `npm start`: Starts the Node.js application according to the command indicated in the `"scripts"` key, then the `"start"` key of the `package.json` file. For example, if you specify `"scripts": { "start": "node test.js" }` in the `package.json` file, you can type `npm start` instead of `node test.js` to run the `test.js` file. It is common to use `npm start` to start a Node.js application. This will be used to start an application under **Express** (see the next chapter).

Note

If you want to remove an npm-installed module, use the same commands as before, specifying `uninstall` instead of `install`.
As an example, let’s create the following `package.json` file in the directory of the `test.js` file:

package.json file (in the same directory as test.js)

```
{
  "scripts" : {
    "start" : "node test.js"
  }
}
```

Then use the `npm start` command to start the program:

![ 0609 6.10 – Starting the Node.js ](/packtpub/javascript_from_frontend_to_backend_img/0609_6.10_–_starting_the_node.js.webp)
Figure 6.10 – Starting the Node.js application with npm start

We can see that the `npm start` command thus makes it possible to execute the `test.js` program. The `npm start` command is often used to start a Node.js program, thanks to the mechanism explained above.

Now let’s see how to use modules written by other developers by downloading them using `npm`.

## Using a downloaded module with npm

Let’s look at an example of using `npm`. Here, we will use `npm` to install the module named `colors`. It allows you to display colored text in the console.

### Installing the colors module in the node_modules local directory

We use the command `npm install colors`. The result of the installation of the `"colors"` module is displayed in the following figure.

![ 0610 6.11 – Installing the colors ](/packtpub/javascript_from_frontend_to_backend_img/0610_6.11_–_installing_the_colors.webp)
Figure 6.11 – Installing the colors module with npm

Once the module has been installed by `npm`, you can see that the `colors` directory of the module has inserted itself into the `node_modules` local directory of the application.

### Using the features of the colors module

One of the ways to have an overview of the functionalities offered by a module is to display the content of the object returned by the `require(moduleName)` instruction:

Displaying contents of colors object returned by require(“colors”) (test.js file)

```
var colors = require("colors");
console.log("colors = ", colors);
```

![ 0611 6.12 – Displaying contents of ](/packtpub/javascript_from_frontend_to_backend_img/0611_6.12_–_displaying_contents_of.webp)
Figure 6.12 – Displaying contents of the colors module

For example, let’s use the last method listed in the module, namely the `random()` method. It allows you to transform a character string into a string with random colors for each character:

Using the random() method of the colors module (test.js file)

```
var colors = require("colors");
console.log(colors.random("First text in random colors"));
console.log(colors.random("Second text in random colors"));
```

Note

The `random()` method is used by prefixing its name with the name of the variable returned by `require("colors")`, that is, with the name of the module.

The display of the following figure is obtained, in which each character displayed is a random color:

![ 0612 6.13 – Using the colors module ](/packtpub/javascript_from_frontend_to_backend_img/0612_6.13_–_using_the_colors_module.webp)
Figure 6.13 – Using the colors module

We have seen here the three types of modules used with Node.js:

- Modules written by ourselves, for our own needs
- Existing internal modules in Node.js, such as the `fs` module allowing access to the internal file system of Node.js
- Modules downloadable using the `npm` command, such as the colors module used above

All that remains is to use these different types of modules in our programs. We will discuss that later on.

This brings us to the end of the chapter.

# Summary

We have seen in this chapter how to create and use modules with Node.js, which are the essential components of programs created with Node.js.

Whether the module is created by us, is an internal Node.js module, or is a module downloaded with `npm`, its use is the same in all cases. We use the `require(moduleName)` instruction and with the value returned in a variable, we access the functionality of the module.

Next, we are going to study the Express module, which is one of the main modules used with Node.js, allowing us to easily structure our applications according to the rules of the MVC model, currently widely used.


> [ 08 P3 JavaScript on the Server-Side ](/packtpub/javascript_from_frontend_to_backend/08_p3_javascript_on_the_server-side) <---> [ 10 C7 Using Express with Node.js ](/packtpub/javascript_from_frontend_to_backend/10_c7_using_express_with_node_js)
>
> Title: 09 C6 Creating and Using Node.js Modules
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/09_c6_creating_and_using_node.js_modules
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 13:20:55
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 09_c6_creating_and_using_node.js_modules.md

