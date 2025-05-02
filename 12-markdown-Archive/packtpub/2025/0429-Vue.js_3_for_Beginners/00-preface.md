
--------> @ Q -> # 붙이고 줄 띄우기 
--------> @ W -> 현 위치에서 Explain 까지 역따옴표 
--------> @ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(`) 붙이기 
--------> @ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(`) 붙이기 
--------> @ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(`) 붙이기 
--------> @ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(`) 붙이기 
--------> @ U -> 찾은 글자~닫은괄호앞뒤로 backtick(`) 붙이기 
--------> @ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(`) 붙이기 
--------> @ O -> 찾은 글자 ~   }   앞뒤로 backtick(`) 붙이기 
++++++++> @ A -> 빈 줄에 블록 시작하기 
++++++++> @ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 
++++++++> @ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 
++++++++> @ F -> 이 줄을 타이틀로 만들기 
++++++++> @ K -> 찾은 글자 ~ COLON 앞뒤로 긁은글자(**) 붙이기 
========> @ Z -> 현 위치에서 Copy 까지 역따옴표 

마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

| 🏁 2409 Vue.js 3 for Beginners | 00 Preface | [ 01 Pt1 Getting Started with Vue.js ](/packtpub/2024/2409_vue_js_3_for_beginners/01_pt1_getting_started_with_vue_js) ≫ |
|:----:|:----:|:----:|

# 00 Preface

The last decade has seen a surge of JavaScript frameworks aimed at improving client experiences with better **User Experience (UX)** and enhanced client interactivity. One of the most mature and popular frameworks is Vue.js.

Vue.js is a JavaScript framework for building user interfaces. It builds on top of standard HTML, CSS, and JavaScript and provides a declarative, component-based programming model that helps you efficiently develop user interfaces of any complexity.

Vue.js has become a favorite among developers of all levels for its vibrant ecosystem, delightful development experience, and focus on simplicity.

This book, `Vue.js 3 for Beginners`, is your comprehensive guide to mastering this framework. The aim of this book is to take you on a journey from the core concepts of Vue.js to building a real-world application, step by step.

There are many tutorials, articles, and documentation out there that share Vue.js features, but here is what sets this book apart:

- `Learning by doing`: Throughout the book, you’ll be building a Companion App alongside the theoretical concepts. This hands-on approach ensures you grasp the connections between different sections and how Vue.js components work together.
- `Beginner-friendly`: Whether you’re new to JavaScript frameworks or have some experience with others, this book provides a solid foundation in Vue.js. We start with the basics and gradually introduce more advanced techniques as you progress.
- `Real-world examples`: We’ll use clear and practical examples to illustrate key concepts, making Vue.js more accessible and engaging. In many cases, multiple methods will be covered with their individual advantages and disadvantages. The book also includes many callouts to help you gain further context.
- `Written from experience`: This book is the result of many successful projects and numerous trained mentees. The flow in which the topics are introduced and explained has gone through many iterations across the span of my career.

By the end of this book, you’ll not only have a strong understanding of Vue.js but also a fully functional application you can use or adapt for your own projects.

# Who this book is for

Aspiring web developers, students, hobbyists, and anyone who wants to learn Vue.js from scratch and is eager to delve into front-end development using a modern and popular framework will benefit from this book. The book requires a basic understanding of front-end technologies such as HTML, CSS, and JavaScript. The topics are introduced in a modular fashion by breaking down problems into small, easy-to-understand units.

The book covers many topics of the Vue.js framework and defines good standards that can also be beneficial for existing Vue.js developers that want to ensure they use the framework correctly.

# What this book covers

`Chapter 1`, Exploring the Book’s Layout and Companion App, covers the details of the Companion App and what it will include. This chapter defines the structure and methodology used throughout the book and includes important topics not related to the framework such as component-based architecture, atomic design, and core web development areas.

`Chapter 2`, The Foundation of Vue.js, focuses on providing vital information about the Vue.js framework. The chapter covers topics such as the reactivity system, component composition, and framework lifecycles.

`Chapter 3`, Making Our HTML Dynamic, is where we begin the work required to build our Companion App. We will learn how to initialize a Vue.js application and see the basic steps required to turn a static HTML file into a dynamic Vue.js component.

`Chapter 4`, Utilizing Vue’s Built-In Directives for Effortless Development, introduces one of the most important features of Vue.js: built-in directives. In this chapter, we will learn how to enhance the interactivity and dynamicity of our component by introducing the most important directives.

`Chapter 5`, Leveraging Computed Properties and Methods in Vue.js, teaches how to make our components concise and readable by introducing different techniques to handle data and logic within our components. This chapter introduces topics including Ref and Reactive data computed properties and methods that are the pillars of Vue.js logic.

`Chapter 6`, Event and Data Handling in Vue.js, expands our knowledge of the Vue.js framework by teaching us how to handle communication between components. We will also deepen our knowledge of props and introduce the notion of custom events.

`Chapter 7`, Handling API Data and Managing Async Components with Vue.js, teaches us how to deal with external asynchronous data. We will put into practice the notion of lifecycles and learn how to handle asynchronous data with `watch` and `<suspense>`.

`Chapter 8`, Testing Your App with Vitest and Cypress, will provide us with the tools necessary to ensure our code is well written by introducing testing. This chapter covers testing in general and then defines both unit tests using Vitest and E2E tests with Playwright for testing our existing Companion App components.

`Chapter 9`, Introduction to Advanced Vue.js Techniques – Slots, Lifecycle, and Template Refs, brings you back to the core of Vue.js and introduces advanced techniques. The chapters cover advanced topics such as slots, lifecycles, and Template Refs.

`Chapter 10`, Handling Routing with Vue Router, introduces the first external package: vue-router. In this chapter, we will add routing to our Companion App. We will learn how to define our router and how to navigate within our application.

`Chapter 11`, Managing Our Application’s State with Pinia, focuses on state management and introduces a new core package: Pinia. We will learn how state management can simplify our application and create multiple example stores within our Companion App to learn about the different features that Pinia has to offer.

`Chapter 12`, Achieving Client-Side Validation with VeeValidate, introduces the topics of form handling and validation. We will review the Vue.js native tools for handling forms such as v-model, and cover advanced cases by introducing VeeValidate.

`Chapter 13`, Unveiling Application Issues with the Vue Devtools, takes a step back from the development of our Companion App and focuses on the debugging techniques required to improve our skills and understanding of the Vue.js framework.

`Chapter 14`, Advanced Resources for Future Reading, concludes our journey with some further reading and materials that will help you continue your learning of the Vue.js framework.

# To get the most out of this book

The books cover in detail everything related to Vue.js and any additional package that is introduced, but it requires the reader to have a basic understanding of front-end development. Existing knowledge of HTML, CSS and JavaScript is required to make the most out of this book.

| Software/hardware covered in the book | Operating system requirements |
|----|----|
| Vue.js 3 | Windows, macOS, or Linux |
| Vite | Windows, macOS, or Linux |
| Crypress | Windows, macOS, or Linux |
| Vitest | Windows, macOS, or Linux |
| Vue DevTools | Windows, macOS, or Linux |
| Vue-router | Windows, macOS, or Linux |
| Pinia | Windows, macOS, or Linux |
| VeeValidate | Windows, macOS, or Linux |

The book includes all the information required to install and configure the software used during the course of our journey. There are some dependencies that are not introduced in the book but required. The first is Node.js. The application will work with any major version of Node, so you can install the latest stable. The next requirement is an IDE. I will be using Visual Studio Code, but you can use any other IDE.

If you are using the digital version of this book, we advise you to type the code yourself or access the code from the book’s GitHub repository (a link is available in the next section). Doing so will help you avoid any potential errors related to the copying and pasting of code.

The final chapter of the book provides you with guidance on how to continue your journey. I suggest you continue your learning journey to continue to improve your skills in Vue.js.

# Download the example code files

You can download the example code files for this book from GitHub at https://github.com/PacktPublishing/Vue.js-3-for-Beginners. If there’s an update to the code, it will be updated in the GitHub repository.

We also have other code bundles from our rich catalog of books and videos available at https://github.com/PacktPublishing/. Check them out!

# Conventions used

There are a number of text conventions used throughout this book.

**Code in text**: Indicates code words in text, database table names, folder names, filenames, file extensions, pathnames, dummy URLs, user input, and Twitter handles. Here is an example: Vue.js tries to render the app with the data it has, resulting in the missing data being set as `null`.”

A block of code is set as follows:

```
<template v-if="comments.length === 0"></template>
<template v-else></template>
```

When we wish to draw your attention to a particular part of a code block, the relevant lines or items are set in bold:

```
const posts = reactive([]);
const fetchPosts = () => {
   ...
}
fetchPosts();
```

Any command-line input or output is written as follows:

```
npm install
```

**Bold**: Indicates a new term, an important word, or words that you see onscreen. For instance, words in menus or dialog boxes appear in bold. Here is an example: “ Because About Page does not require the overriding of the footer, we are leaving that out of our instance so that the default value can be rendered.”

Tips or important notes

Appear like this.

# Get in touch

Feedback from our readers is always welcome.

**General feedback**: If you have questions about any aspect of this book, email us at customercare@packtpub.com and mention the book title in the subject of your message.

**Errata**: Although we have taken every care to ensure the accuracy of our content, mistakes do happen. If you have found a mistake in this book, we would be grateful if you would report this to us. Please visit www.packtpub.com/support/errata and fill in the form.

**Piracy**: If you come across any illegal copies of our works in any form on the internet, we would be grateful if you would provide us with the location address or website name. Please contact us at copyright@packt.com with a link to the material.

**If you are interested in becoming an author**: If there is a topic that you have expertise in and you are interested in either writing or contributing to a book, please visit authors.packtpub.com.

# Share Your Thoughts

Once you’ve read Vue.js 3 for Beginners, we’d love to hear your thoughts! Please `click here to go straight to the Amazon review page` for this book and share your feedback.

Your review is important to us and the tech community and will help us make sure we’re delivering excellent quality content.

# Download a free PDF copy of this book

Thanks for purchasing this book!

Do you like to read on the go but are unable to carry your print books everywhere?

Is your eBook purchase not compatible with the device of your choice?

Don’t worry, now with every Packt book you get a DRM-free PDF version of that book at no cost.

Read anywhere, any place, on any device. Search, copy, and paste code from your favorite technical books directly into your application.

The perks don’t stop there, you can get exclusive access to discounts, newsletters, and great free content in your inbox daily

Follow these simple steps to get the benefits:

1. Scan the QR code or visit the link below

https://packt.link/free-ebook/9781805126775

2. Submit your proof of purchase
3. That’s it! We’ll send your free PDF and other benefits to your email directly



| 🏁 2409 Vue.js 3 for Beginners | 00 Preface | [ 01 Pt1 Getting Started with Vue.js ](/packtpub/2024/2409_vue_js_3_for_beginners/01_pt1_getting_started_with_vue_js) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/2409_vue_js_3_for_beginners/00-preface
> (2) Markdown
> (3) Title: 00 Preface
> (4) Short Description: Sep 2024 302 pages Author Simone Cuomo
> (5) tags: vue.js
> Book Name: 2409 Vue.js 3 for Beginners
> Link: https://www.packtpub.com/en-kr/product/vuejs-3-for-beginners-9781805123293
> create: 2025-05-02 금 12:44:55
> Images: /packtpub/2024/2409_vue_js_3_for_beginners_img/
> .md Name: 00-preface.md

