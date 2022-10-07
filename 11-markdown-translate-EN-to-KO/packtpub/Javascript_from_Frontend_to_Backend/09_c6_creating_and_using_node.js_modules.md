
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

> [ 08 P3 JavaScript on the Server-Side ](/packtpub/javascript_from_frontend_to_backend/08_p3_javascript_on_the_server-side) <---> [ 10 C7 Using Express with Node.js ](/packtpub/javascript_from_frontend_to_backend/10_c7_using_express_with_node.js)

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
- Using internal Node.js...

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

test.js file

```
var mod1 = require("./module1.js");  
// or require("./module1...
```

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

Reading and displaying the contents of the file...

# Using downloaded modules with npm

In addition to the modules internal to Node.js, it is possible to import modules from the internet using the `npm` utility provided with Node.js.

For this, the `npm` command is used (in a command interpreter) by indicating arguments that allow you to perform the corresponding actions on the imported modules.

## Using the npm command

Here are some common uses of the `npm` command:

- `npm install moduleName`: Installs the indicated module in the local `node_modules` directory. The module will only be accessible for the current application and not for other applications (unless it is installed again).
- `npm install moduleName -g`: Installs the specified module in the global `node_modules` directory. The `-g` option allows you to indicate that this module can be accessed by other applications because it is installed in the `node_modules` directory of Node.js (globally).
- `npm link moduleName`: It is possible that a module installed globally (with the `-g`...

# Summary

We have seen in this chapter how to create and use modules with Node.js, which are the essential components of programs created with Node.js.

Whether the module is created by us, is an internal Node.js module, or is a module downloaded with `npm`, its use is the same in all cases. We use the `require(moduleName)` instruction and with the value returned in a variable, we access the functionality of the module.

Next, we are going to study the Express module, which is one of the main modules used with Node.js, allowing us to easily structure our applications according to the rules of the MVC model, currently widely used.



> [ 08 P3 JavaScript on the Server-Side ](/packtpub/javascript_from_frontend_to_backend/08_p3_javascript_on_the_server-side) <---> [ 10 C7 Using Express with Node.js ](/packtpub/javascript_from_frontend_to_backend/10_c7_using_express_with_node.js)
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

