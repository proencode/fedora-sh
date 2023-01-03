
@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i\`\`\`^M^[/^Copy$^[ddk0C\`\`\`^M^[
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(\`) 붙이기 => i\`^[/ ^[i\`^[/EEEEEEEEEE^[
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(\`) 붙이기 => i\`^[/.^[i\`^[/RRRRRRRRRR^[
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(\`) 붙이기 => i\`^[/,^[i\`^[/TTTTTTTTTT^[
@ Y -> 찾은 글자 ~ COLON 앞뒤로 backtick(\`) 붙이기 => i\`^[/;^[i\`^[/YYYYYYYYYY^[
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(\`) 붙이기 => i\`^[/)^[i\`^[/UUUUUUUUUU^[

@ A -> 빈 줄에 블록 시작하기 => 0C\`\`\`^[^Mk0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i\`\`\`^M-^[^M0i\`\`\`^[0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi\`\`\`^M^M^[kk
@ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
    마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

> Begin <---> [ 01 P1 JavaScript Syntax ](/packtpub/javascript_from_frontend_to_backend/01_p1_javascript_syntax)

# Preface

JavaScript is the most widely used programming language in the world. It has numerous libraries and modules and a dizzying array of need-to-know topics. Picking a starting point can be difficult. This concise, practical guide will get you up to speed in next to no time.

# Who this book is for

This book is for JavaScript developers looking to strengthen their core JavaScript concepts and implement them in building full stack apps.

# What this book covers
[ Chapter 1 ](/packtpub/javascript_from_frontend_to_backend/02_c1_exploring_the_core_concepts_of_javascript), Exploring the Core Concepts of JavaScript, is where you discover how to use variables, conditions, and loops in JavaScript.

[ Chapter 2 ](/packtpub/javascript_from_frontend_to_backend/03_c2_exploring_the_advanced_concepts_of_javascript), Exploring the Advanced Concepts of JavaScript, is where you learn how to use object-oriented programming in JavaScript.

[ Chapter 3 ](/packtpub/javascript_from_frontend_to_backend/05_c3_getting_started_with_vue_js), Getting Started withVue.js, is where you learn the basics of Vue.js, with components and directives.

[ Chapter 4 ](/packtpub/javascript_from_frontend_to_backend/06_c4_advanced_concepts_of_vue_js), Advanced Concepts of Vue.js, is where you explore in-depth Vue.js with communication between components and visual effects.

[ Chapter 5 ](/packtpub/javascript_from_frontend_to_backend/07_c5_managing_a_list_with_vue_js), Managing a List with Vue.js, is where you learn how to build a full project with Vue.js.

[ Chapter 6 ](/packtpub/javascript_from_frontend_to_backend/09_c6_creating_and_using_node_js_modules), Creating and Using Node.js Modules, is where you learn the basics of Node.js programming with modules.

[ Chapter 7 ](/packtpub/javascript_from_frontend_to_backend/10_c7_using_express_with_node_js), Using Express with Node.js, is where you explore the main library used to build Node.js applications.

[ Chapter 8 ](/packtpub/javascript_from_frontend_to_backend/11_c8_using_mongodb_with_node_js), Using MongoDB with Node.js, is where you learn how to use the MongoDB database with Node.js using the Mongoose module.

[ Chapter 9 ](/packtpub/javascript_from_frontend_to_backend/12_c9_integrating_vue_js_with_node_js), Integrating Vue.js with Node.js, is where you learn how to build a full project integrating Vue.js and Node.js.

# To get the most out of this book

Prior knowledge of HTML and CSS is a must for this book.

![ 00-00 covered in the book ](/packtpub/javascript_from_frontend_to_backend_img/0000_covered_in_the_book.webp
)

If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book’s GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

# Download the example code files

You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend. If there’s an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Download the color images

We also provide a PDF file that has color images of the screenshots and diagrams used in this book. You can download it here: https://packt.link/xdibe

# Conventions used

There are a number of text conventions used throughout this book.

`Code in text`: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: “So `{ lastname: "Clinton" }` can also be written `{ "lastname": "Clinton" }` by surrounding the lastname property with single or double quotes.”

A block of code is set as follows:

```
var p = { lastname : "Clinton", firstname : "Bill" };
console.log("The person is", p);
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

```
class Person {
  firstname;
  lastname;
  age;
}
var p = new Person;
console.log(p);
```

**Bold**: Indicates a new term, an important word, or words that you see onscreen. For instance, words in menus or dialog boxes appear in bold. Here is an example: “This writing format is also called **JavaScript Object Notation (JSON)** format.”

Tips or Important Notes

Appear like this.

# Get in touch

Feedback from our readers is always welcome.

**General feedback**: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

**Errata**: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

**Piracy**: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

**If you are interested in becoming an author**: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

# Share Your Thoughts

Once you’ve read JavaScript from Frontend to Backend, we’d love to hear your thoughts! Please click here to go straight to the Amazon review page https://packt.link/QUTSC for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we’re delivering excellent quality content.



> Begin <---> [ 01 P1 JavaScript Syntax ](/packtpub/javascript_from_frontend_to_backend/01_p1_javascript_syntax)
>
> Title: 00 Preface
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/00_preface
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-04 화 14:32:37
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 00_preface.md

