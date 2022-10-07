
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

> [ 11 C8 Using MongoDB with Node.js ](/packtpub/javascript_from_frontend_to_backend/11_c8_using_mongodb_with_node.js) <---> [ 13 P4 Other Books You May Enjoy ](/packtpub/javascript_from_frontend_to_backend/13_p4_other_books_you_may_enjoy)

# Chapter 9: Integrating Vue.js with Node.js

In this chapter, we will learn how to integrate a Vue.js application into a Node.js server, using Express to structure the server code (according to the MVC model) and MongoDB to store the information.

For this, we will use the example of the list management application built in Chapter 5, Managing a List with Vue.js. But here, the server used will be a Node.js server, and the list items will be stored in the MongoDB database. This will allow them to be redisplayed later, if necessary.

In the end, we will obtain a client-server application entirely made in JavaScript (both on the client side and on the server side).

Here are the topics covered in this chapter:

Displaying application screens
Building the app with Express
MongoDB database structure
Installing the Axios library
Inserting a new element in the list
Displaying list elements
Modifying an element in the list
Removing an element from the...
Technical requirements
You can find the code files for this chapter on GitHub at: https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend/blob/main/Chapter%209.zip.

Displaying application screens
Here, we visualize the screens of the application, allowing the following:

Displaying the already existing list (empty at first)
Inserting a new element at the end of the list
Modifying an element of the list
Removing an item from the listNoteThe URL to access the list is http://localhost:3000. The server used here is a Node.js server running with the Express module. The database used is MongoDB.
Initially, the list is empty. Only the Add Element button is present on the page (see the following figure):

Figure 9.1 – Empty item list

Clicking the Add Element button multiple times creates multiple rows with the text Element X followed by Remove and Modify buttons (here, we clicked on the Add Element button three times):

Figure 9.2 – Adding three items to the list

Next, let’s modify the second element. An input field appears in place of the item text. Let’...

Building the app with Express
Let’s start by creating the application with Express. To do this, type the express list command, which creates the application named list. This application will be accessible using the URL http://localhost:3000, as seen in Chapter 7, Using Express with Node.js.

Let’s type the express list command in the current directory:

Figure 9.7 – Creating the application list with Express

The server is started by typing the indicated commands, namely: cd list, npm install, followed by npm start.

The application is started by typing the URL http://localhost:3000 in the browser.

We display the basic application created as standard by Express (see Figure 9.8).

If an error occurs while loading the Express modules, you can type the npm link express command in order to locate the Express module within the application. And if an error occurs while loading the mongoose module, you can type the npm link mongoose command...

MongoDB database structure
To build our application, we will have to perform data reads and updates on the server in the database. For example, each click on the Add Element button should insert a new line into the displayed HTML page but should also insert a new document into MongoDB’s elements collection. Indeed, each document of the elements collection will represent the text of the element displayed in the list on the screen.

Note

To access the MongoDB database, you start by installing the mongoose module (see the previous chapter), which allows you to manipulate database documents in JavaScript.

To do this, type the npm install mongoose command (from the main directory, list, of the Express application).

The elements collection will be the one that will store the list items in MongoDB. A document in the elements collection will consist of its text associated with the text property. Each document will also have the _id property, whose unique value is assigned...

Installing the Axios library
We see that, for now, we can manipulate the list items displayed on the HTML page, but we cannot yet update them in the database on the server.

For this, the Vue.js program must be able to communicate with the Node.js server. This is possible using a JavaScript library such as Axios (see https://github.com/axios/axios). All you have to do is include the library in the HTML page (here, it will be in the index.html file) in order to be able to use its features.

Note

The Axios library is a library allowing communication between a browser and a server using Ajax technology. This technology allows a browser and a server to exchange information while remaining on the same HTML page, which is what we want here. This is called a single-page application (SPA) (when the application consists of a single HTML page).

Let’s include the Axios library in the index.html file (using the <script> tag), and display the value of the axios.VERSION variable...

Inserting a new element in the list
Let’s see how to store a new element in the list, following a click on the Add Element button.

The text associated with this element must be transmitted to the server, which will be of the form Element X. We will see later how to modify this text after clicking on the Modify button.

The add() method defined in the <GlobalApp> component is used to insert a new element into the displayed list. It will be necessary to add instructions that use the Axios library in order to also insert this new element in the MongoDB elements collection.

Before starting to use Axios, it is useful to slightly modify the JavaScript program written with Vue.js. To do this, we will use a new attribute when creating the <Element> component, replacing the text and index attributes with the element attribute.

Replacing the text and index attributes with the element attribute
When creating an element, we currently use the element’s text...

Displaying list elements
In this section, we deal with the first display of the page. Insertion has been seen previously, and modification and deletion are covered in the following sections.

Note

To display the list when the application starts, you must use the created() method or the mounted() method of the component, which are called in each Vue.js component when the component is created.

To retrieve the list of elements, we are going to use an HTTP GET request.

Using Axios with a GET type request (client side)
Here, we are going to make a GET type request with the /list URL to the server. The axios.get("/list") instruction is used to perform this request. We can use this instruction in the created() or mounted() method. Here, we choose to use it in the created() method:

Retrieving list of items, client side (global-app.js file)

import Element from "./element.js";
const GlobalApp = {
  data() {
    return {
 ...

Copy
Modifying an element in the list
Here we show how to modify an element of the list, keeping this modification in the database. A PUT type request will be used for this.

Using Axios with a PUT type request (client side)
The axios.put("/list", options) method is used to perform a PUT type request to the server. We transmit to the server in the options parameter the new text of the modified element and its identifier in the database. The identifier and the new text will allow the item to be updated on the server:

Modifying an element, client side (global-app.js file)

import Element from "./element.js";
const GlobalApp = {
  data() {
    return {
      elements : []  // array of object { text, _id } 
                     // (_id = document id in MongoDB) 
    }
 ...

Copy
Removing an element from the list
Finally, we will learn how to remove an element from the list. A DELETE type request will be used for this.

Using Axios with a DELETE type request (client side)
The axios.delete("/list", options) method is used to trigger a DELETE type request on the server. The options parameter must indicate the identifier of the element to be deleted from the collection.

However, unlike the previous axios.get(), axios.put(), and axios.post() calls, the axios.delete("/list", options) call requires that the options parameter be written in the data property (thus written as { data : options }). If you don’t follow this convention, it won’t work.

Here are the instructions for performing a DELETE request with the Axios library:

Deleting an element, client side (global-app.js file)

import Element from "./element.js";
const GlobalApp = {
  data() {
    return {
   &...

Copy
Summary
Through this complete example, we have seen how to use JavaScript on both the client side (here, with Vue.js) and the server side (with Node.js and MongoDB).

The use of a single language to carry out all development simplifies learning and ensures great consistency throughout the application.

In addition, tools such as Vue.js, allowing the creation of reusable components, and modules such as Express and mongoose based on the MVC model, make it possible to properly architect JavaScript code, both on the client side and on the server side.

We also saw how the Axios library made it possible to communicate between the client and the server.

You now have everything you need to create reliable, robust, and well-structured client and server applications entirely in JavaScript.

Thanks
Thank you, dear reader, for purchasing and reading this book. It was written for the sole purpose of helping and guiding you. We hope it has been of great help to you.

If so, we ask you for a very small but extremely important contribution – to make our book knownto others by means at your disposal, in the hope that it can keep helping people like you. Thanks very much!

Why subscribe?
Spend less time learning and more time coding with practical eBooks and Videos from over 4,000 industry professionals
Improve your learning with Skill Plans built especially for you
Get a free eBook or video every month
Fully searchable for easy access to vital information
Copy and paste, print, and bookmark content
Did you know that Packt offers eBook versions of every book published, with PDF and ePub files available? You can upgrade to the eBook version at packt.com and as a print book customer, you are entitled to a discount on the eBook copy. Get in touch with us at customercare@packtpub.com for more details.

At www.packt.com, you can also read a collection of free technical articles, sign up for a range of free newsletters, and receive exclusive discounts and offers on Packt books and eBooks.



> [ 11 C8 Using MongoDB with Node.js ](/packtpub/javascript_from_frontend_to_backend/11_c8_using_mongodb_with_node.js) <---> [ 13 P4 Other Books You May Enjoy ](/packtpub/javascript_from_frontend_to_backend/13_p4_other_books_you_may_enjoy)
>
> Title: 12 C9 Integrating Vue.js with Node.js
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/12_c9_integrating_vue.js_with_node.js
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 13:20:55
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 12_c9_integrating_vue.js_with_node.js.md

