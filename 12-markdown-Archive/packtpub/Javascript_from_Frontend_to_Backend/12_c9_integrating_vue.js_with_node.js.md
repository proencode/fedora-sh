
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

- Displaying application screens
- Building the app with Express
- MongoDB database structure
- Installing the Axios library
- Inserting a new element in the list
- Displaying list elements
- Modifying an element in the list
- Removing an element from the list

The application uses the same screens as those already used in Chapter 5, Managing a List with Vue.js. We repeat them below to make them easier for you to understand.

# Technical requirements

You can find the code files for this chapter on GitHub at: https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend/blob/main/Chapter%209.zip.

# Displaying application screens

Here, we visualize the screens of the application, allowing the following:

- Displaying the already existing list (empty at first)
- Inserting a new element at the end of the list
- Modifying an element of the list
- Removing an item from the listNote

The URL to access the list is http://localhost:3000. The server used here is a Node.js server running with the **Express** module. The database used is **MongoDB**.

Initially, the list is empty. Only the [`Add Element`] button is present on the page (see the following figure):

![ 1200 9.1 Empty item list ](/packtpub/javascript_from_frontend_to_backend_img/1200_9.1_empty_item_list.webp
)
Figure 9.1 – Empty item list

Clicking the [`Add Element`] button multiple times creates multiple rows with the text **Element X** followed by [`Remove`] and [`Modify`] buttons (here, we clicked on the [`Add Element`] button three times):

![ 1201 9.2 Adding three items ](/packtpub/javascript_from_frontend_to_backend_img/1201_9.2_adding_three_items.webp
)
Figure 9.2 – Adding three items to the list

Next, let’s modify the second element. An input field appears in place of the item text. Let’s type `New Element 2` in place of the text displayed in the input field:

![ 1202 9.3 Editing the second item ](/packtpub/javascript_from_frontend_to_backend_img/1202_9.3_editing_the_second_item.webp
)
Figure 9.3 – Editing the second item in the list

By clicking outside the input field, the input field disappears, and the text of the element appears modified:

![ 1203 9.4 Second list item changed ](/packtpub/javascript_from_frontend_to_backend_img/1203_9.4_second_list_item_changed.webp
)
Figure 9.4 – Second list item changed

Finally, let’s remove the first and third items from the list:

![ 1204 9.5 First and third list items ](/packtpub/javascript_from_frontend_to_backend_img/1204_9.5_first_and_third_list_items.webp
)
Figure 9.5 – First and third list items removed

Now, when we refresh the previous window, we see that the list is re-displayed with `New Element 2`, thus indicating that the modifications made are indeed stored in a database. This was not the case when we made this application in Chapter 5, Managing a List with Vue.js, with only Vue.js, because the elements of the list were not saved in a database:

![ 1205 9.6 New list display ](/packtpub/javascript_from_frontend_to_backend_img/1205_9.6_new_list_display.webp
)
Figure 9.6 – New list display: the list is preserved

To create this application, we will, of course, use the Vue.js program that we have already written in Chapter 5, Managing a List with Vue.js. But it will have to be modified so that this application works on a Node.js server with the Express module and that the data displayed is stored in the MongoDB database.

We’ll indicate here the files of the `<GlobalApp>` and `<Element>` components, written previously, in Chapter 5, Managing a List with Vue.js, to explain the modifications that will be made to them hereafter.

Here’s the `<GlobalApp>` component:

<GlobalApp> component (global-app.js file)

```
import Element from "./element.js";
const GlobalApp = {
  data() {
    return {
      elements : []
    }
  },
  components : {
    Element:Element
  },
  template : `
    <button @click="add()">Add Element</button>
    <ul>
      <Element v-for="(element, index) in elements" 
       :key="index" 
        :text="element" :index="index"
        @remove="remove($event)" @modify="modify($event)"
      />
    </ul>
  `,
  methods : {
    add() {
      var element = "Element " + (this.elements.length + 1);
      this.elements.push(element);
    },
    remove(params) {
      var index = params.index;
      this.elements.splice(index, 1);
    },
    modify(params) {
      var index = params.index;
      var value = params.value;
      this.elements[index] = value;
    }
  }
}
export default GlobalApp;
```

Here’s the `<Element>` component:

<Element> component (element.js file)

```
const Element = {
  data() {
    return {
      input : false
    }
  },
  template : `
    <li> 
      <span v-if="!input"> {{text}} </span>
      <input v-else type="text" :value="text" 
       @blur="modify($event)" ref="refInput" />
      <button @click="remove()"> Remove </button> 
      <button @click="input=true"> Modify </button>
    </li>
  `,
  props : ["text", "index"],
  methods : {
    remove() {
      // process the click on the Remove button
      this.$emit("remove", { index : this.index });
    },
    modify(event) {
      var value = event.target.value;
      this.input = false;
      this.$emit("modify", { index : this.index, value : 
      value });
    }
  },
  emits : ["remove", "modify"],
  updated() {
    // check that refInput exists, and if so, give focus to 
    // the input field
    if (this.$refs.refInput) this.$refs.refInput.focus();  
  }
}
export default Element;
```

The `index.html` file that allows you to include the `<GlobalApp>` component is the following:

index.html file

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
    
    <style type="text/css">
      li {
        margin-top:10px;
      }
      ul button {
        margin-left:10px;
      }
    </style>
  </head>
  <body>
    <div id="app"></div>
  </body>
  
  <script type="module">
  
    import GlobalApp from "./global-app.js";
    
    var app = Vue.createApp({
      components : {
        GlobalApp:GlobalApp
      },
      template : "<GlobalApp />"
    });
    
    var vm = app.mount("div#app");
    
  </script>
  
</html>
```

To create this application, we start by creating the Node.js application, which will host the JavaScript code written with Vue.js. To do this, the application is created using the `express` command. The application will be named list (for example), so we will have to type the `express list` command to create this application, as is explained in the following section.

# Building the app with Express

Let’s start by creating the application with Express. To do this, type the `express list` command, which creates the application named list. This application will be accessible using the URL http://localhost:3000, as seen in Chapter 7, Using Express with Node.js.

Let’s type the `express list` command in the current directory:

![ 1206 9.7 Creating the application list ](/packtpub/javascript_from_frontend_to_backend_img/1206_9.7_creating_the_application_list.webp
)
Figure 9.7 – Creating the application list with Express

The server is started by typing the indicated commands, namely: `cd list`, `npm install`, followed by `npm start`.

The application is started by typing the URL http://localhost:3000 in the browser.

We display the basic application created as standard by Express (see Figure 9.8).

If an error occurs while loading the Express modules, you can type the `npm link express` command in order to locate the Express module within the application. And if an error occurs while loading the mongoose module, you can type the `npm link mongoose` command.

If all is okay, you obtain the following:

![ 1207 9.8 Standard application created ](/packtpub/javascript_from_frontend_to_backend_img/1207_9.8_standard_application_created.webp
)
Figure 9.8 – Standard application created with Express

The goal now is to visualize our list management application, created with Vue.js. It consists of three files:

- The `index.html` file, which is the file to view at startup
- The `global-app.js` file, which describes the main `<GlobalApp>` component of the application
- The `element.js` file, which describes the `<Element>` component corresponding to a displayed element line

The main directory of the Express application (the `list` directory) includes a `public` subdirectory containing the `images`, `javascripts`, and `stylesheets` subdirectories.

Let’s drop the three files `index.html`, `global-app.js`, and `element.js` in the `public` directory, directly under the root.

Note

Modifying files in the `public` directory does not require a server restart. On the other hand, modifying the `app.js` file of the Express application requires restarting the server with `npm start`.

Let’s view the URL http://localhost:3000 again in the browser. The Vue.js application we built in Chapter 5, Managing a List with Vue.js, will now appear. Button clicks will also start working.

The only difference is that our Vue.js application runs on a Node.js server instead of running on another application server like in Chapter 5, Managing a List with Vue.js.

![ 1208 9.9 Application running on ](/packtpub/javascript_from_frontend_to_backend_img/1208_9.9_application_running_on.webp
)
Figure 9.9 – Application running on a Node.js server

However, if the page displayed is refreshed, the list previously displayed is deleted because there is currently no persistence of the information displayed in the database.

We will now see how our application can interact with the Node.js server and the MongoDB database.

# MongoDB database structure

To build our application, we will have to perform data reads and updates on the server in the database. For example, each click on the Add Element button should insert a new line into the displayed HTML page but should also insert a new document into MongoDB’s `elements` collection. Indeed, each document of the `elements` collection will represent the text of the element displayed in the list on the screen.

Note

To access the MongoDB database, you start by installing the mongoose module (see the previous chapter), which allows you to manipulate database documents in JavaScript.

To do this, type the `npm install mongoose` command (from the main directory, `list`, of the Express application).

The `elements` collection will be the one that will store the list items in MongoDB. A document in the `elements` collection will consist of its text associated with the `text` property. Each document will also have the `_id` property, whose unique value is assigned by MongoDB for each document inserted into the collection.

Note

The structure of the database is described using the `listSchema` schema, which will be associated with the `List` model used to create the documents of the `elements` collection.

Express’s `app.js` file is modified to include these definitions:

Adding List model to use MongoDB’s elements collection (app.js file)

```
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test"); // we 
                                                   // connect 
                                                   // to 
                                                   // mydb_test
var listSchema = mongoose.Schema({
 text : String     // text associated with the list item
});
// association of the List model with the elements collection
var List = mongoose.model("elements", listSchema);
var app = express();
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/', indexRouter);
app.use('/users', usersRouter);
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});
// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? 
  err : {};
  // render the error page
  res.status(err.status || 500);
  res.render('error');
});
module.exports = app;
```

The `app.js` file will then be enriched to define the new routes that will update the database. These routes will be created by using the `app.use()` method (as explained in Chapter 7, Using Express with Node.js). The creation of these routes will be described in the following sections.

Note

Thanks to the `List` model that we have created, we will have access to the methods `List.create()`, `List.find()`, and so on for manipulating documents in the `elements` collection of the MongoDB database.

To create interactions between the client (here, the browser) and the server (here, the Node.js server) in order to update the database containing the list of elements, we use the Axios JavaScript library here.

# Installing the Axios library

We see that, for now, we can manipulate the list items displayed on the HTML page, but we cannot yet update them in the database on the server.

For this, the Vue.js program must be able to communicate with the Node.js server. This is possible using a JavaScript library such as Axios (see https://github.com/axios/axios). All you have to do is include the library in the HTML page (here, it will be in the `index.html` file) in order to be able to use its features.

Note

The Axios library is a library allowing communication between a browser and a server using **Ajax technology**. This technology allows a browser and a server to exchange information while remaining on the same HTML page, which is what we want here. This is called a **single-page application (SPA)** (when the application consists of a single HTML page).

Let’s include the Axios library in the `index.html` file (using the `<script>` tag), and display the value of the `axios.VERSION` variable, which contains the version number of the library. This verifies that the Axios library is accessible:

Including Axios library and displaying version number (index.html file)

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
    <script src="https://unpkg.com/axios/dist/
    axios.min.js"></script>
    
    <style type="text/css">
      li {
        margin-top:10px;
      }
      ul button {
        margin-left:10px;
      }
    </style>
  </head>
  <body>
    <div id="app"></div>
  </body>
  
  <script type="module">
  
    console.log("axios.VERSION = " + axios.VERSION); 
    // display Axios version number
    
    import GlobalApp from "./global-app.js";
    
    var app = Vue.createApp({
      components : {
        GlobalApp:GlobalApp
      },
      template : "<GlobalApp />"
    });
    
    var vm = app.mount("div#app");
    
  </script>
  
</html>
```

We simply added in the `index.html` file the Axios library (using the `<script>` tag) and the instruction to display the version number of the Axios library in the console, which allows us to check that the Axios library is accessible afterward.

Let’s display the page again in the browser (with the URL http://localhost:3000).

We get a message in the console indicating the version number of Axios used (see the following figure), thus showing that we have access to the functionalities of the Axios library:

![ 1209 9.10 Displaying the Axio ](/packtpub/javascript_from_frontend_to_backend_img/1209_9.10_displaying_the_axio.webp
)
Figure 9.10 – Displaying the Axios version number

Now let’s see how to use Axios to interact with the server and update the database documents.

The goal is, of course, to make maximum use of the Vue.js code that we have already written by modifying it to use the Axios library and thus perform communication with the Node.js server.

Subsequently, we will therefore modify the following files (in addition to the `index.html` file previously modified to include the Axios library):

- The `global-app.js` file, to make calls to the Axios library
- The `element.js` file, to adapt it to the structure of the database
- The `app.js` file (created by Express), to perform database queries

We have seen how to install and use Axios in our program. Now let’s see how to use it to insert an element into the database.

# Inserting a new element in the list

Let’s see how to store a new element in the list, following a click on the **Add Element** button.

The text associated with this element must be transmitted to the server, which will be of the form **Element X**. We will see later how to modify this text after clicking on the **Modify** button.

The `add()` method defined in the `<GlobalApp>` component is used to insert a new element into the displayed list. It will be necessary to add instructions that use the Axios library in order to also insert this new element in the MongoDB `elements` collection.

Before starting to use Axios, it is useful to slightly modify the JavaScript program written with Vue.js. To do this, we will use a new attribute when creating the `<Element>` component, replacing the `text` and `index` attributes with the `element` attribute.

## Replacing the text and index attributes with the element attribute

When creating an element, we currently use the element’s text and index, which are then used in the `<Element>` component, to display it (with its text) or to modify or delete it (with its index).

The use of the index to identify the element in the list displayed on the screen was relevant before, but this is no longer the case if we want to modify or delete the element in the database. This is because the documents of a MongoDB collection are not identified by their index but rather by their identifier `_id`.

Rather than passing the `text` and `index` parameters in the `<Element>` component, we simplify by passing only the `element` parameter, which is a `{ text, _id }` object. The `element.text` field allows you to retrieve the text to be displayed, while the `element._id` field allows you to access the unique identifier of the element (such as the index, which was unique for each element).

We modify the `global-app.js` and `element.js` files to take this into account.

These files are modified below but will be modified again to take into account the connection with the database:

global-app.js file

```
import Element from "./element.js";
const GlobalApp = {
  data() {
    return {
      elements : []  // array of object { text, _id }
                     // (_id = document id in MongoDB)
    }
  },
  components : {
    Element:Element
  },
  template : `
    <button @click="add()">Add Element</button>
    <ul>
      <Element v-for="(element, index) in elements" 
       :key="index" :element="element"
        @remove="remove($event)" @modify="modify($event)"
      />
    </ul>
  `,
  methods : {
    add() {
      var text = "Element " + (this.elements.length + 1);
      this.elements.push({text:text, 
      _id:this.elements.length});  
                         // to modify to retrieve the real 
                         // _id provided by MongoDB
    },
    remove(params) {
      var id = params.id;
      // remove the element with this id from the elements 
      // array
      this.elements = this.elements.filter(
      function(element) {
        if (element._id == id) return false;
        else return true;
      });
    },
    modify(params) {
      var id = params.id;
      var value = params.value;
      // modify the text of the element with this id in the 
      // elements array
      this.elements = this.elements.map(function(element) {
        if (element._id == id) {
          element.text = value;
          return element;
        }
        else return element;
      });
    }
  }
}
export default GlobalApp;
```

The following remarks can be made about the preceding code:

- The reactive `elements` variable now becomes an array of `{ text, _id }` objects. To do this, we write in the `add()` method the instruction `this.elements.push({text:text, _id:this.elements.length})` by inserting an object of the form `{text, _id}` into the `elements` array.
- The value of the `_id` property is temporary here: in fact, you must then retrieve the identifier provided by MongoDB when the document has been saved in the database.
- Each `<Element>` component is constructed (in the template) by passing it an `element` attribute that represents a `{ text, _id }` object.
- The `remove()` method must remove from the list the element having the passed identifier. To do this, we use the JavaScript `filter()` method to keep all the elements except the one with this identifier.
- Similarly, the `modify()` method must modify the value of the element of the list having this identifier. We use the JavaScript `map()` method to return a new array of elements, for which the element with this identifier has its value modified.

The `element.js` file becomes the following:

element.js file

```
const Element = {
  data() {
    return {
      input : false
    }
  },
  template : `
    <li> 
      <span v-if="!input"> {{element.text}} </span>
      <input v-else type="text" :value="element.text" 
       @blur="modify($event)" 
                    ref="refInput" />
      <button @click="remove()"> Remove </button> 
      <button @click="input=true"> Modify </button>
    </li>
  `,
  props : ["element"],
  methods : {
    remove() {
      // process the click on the Remove button
      this.$emit("remove", { id : this.element._id });
    },
    modify(event) {
      var value = event.target.value;
      this.input = false;
      this.$emit("modify", { id : this.element._id, value : 
      value });
    }
  },
  emits : ["remove", "modify"],
  updated() {
    // check that refInput exists, and if so, give focus to 
    // the input field
    if (this.$refs.refInput) this.$refs.refInput.focus();  
  }
}
export default Element;
```

As the attribute transmitted for the creation of the `<Element>` component is named `element` and corresponds to an object `{ text, _id }`, we use `element.text` and `element._id` to display the text and use the identifier of the element (instead of the index).

You can check that the program still works, even if the connection with the server for insertion into the database has not yet been made.

Note

We have modified the code of the Vue.js program in order to adapt it to the use of the MongoDB database.

Let’s now explain how the Axios library will allow the client and the server to communicate with each other, in order to update the MongoDB database.

## Description of the Axios library for communicating between the client and the server

Now let’s use Axios to insert the element into the database.

Axios offers four main methods for communicating between the browser and the server, with the JavaScript language. The server we are using here is a Node.js server, but Axios allows you to interact with any type of server. The four methods are those related to the types of HTTP requests one can make: `GET`, `POST`, `PUT`, and `DELETE`:

- `axios.get(url, options)`: This allows you to perform a `GET` type request.
- `axios.post(url, options)`: This allows you to perform a `POST` type request.
- `axios.put(url, options)`: This allows you to perform a `PUT` type request.
- `axios.delete(url, options)`: This allows you to perform a `DELETE` type request.

The `options` parameter allows you to specify additional parameters that will allow the server to perform its processing. For example, in the case of our application, we will indicate in this parameter the text of the list element that we want to store in the database.

Note

All these methods return a `Promise` object, which then allows you to continue with the `then(callback)` method. The `callback(response)` function is used to retrieve and analyze the server’s response following the request being made.

`Promise` objects were studied at the end of Chapter 2, Exploring the Advanced Concepts of JavaScript.

In each case, we will have to process the Axios request sent on the client side (in the `global-app.js` file associated with the `<GlobalApp>` component), then take it into account on the server side (in the `app.js` file, which receives the queries issued by Axios).

Now let’s see how the `POST` request will allow us to insert elements into the database.

## Using Axios with a POST type request (client side)

Now let’s see how to use the `axios.post()` method to insert a new element into the `elements` collection, following the creation of a new element in the list.

Note

We are using the `POST` request here to insert the item, but other types of requests would work the same. However, using the `POST` request makes sense here because it follows the official recommendations for using **REpresentational State Transfer (REST)** requests.

Although only a few lines are added to each file, the full code is shown below each time, so you can see where the changes are located:

Adding a new element in the database, client side (global-app.js file)

```
import Element from "./element.js";
const GlobalApp = {
  data() {
    return {
      elements : []  // array of object { text, _id }
                     // (_id = document id in MongoDB)
    }
  },
  components : {
    Element:Element
  },
  template : `
    <button @click="add()">Add Element</button>
    <ul>
      <Element v-for="(element, index) in elements" 
       :key="index" :element="element"
        @remove="remove($event)" @modify="modify($event)"
      />
    </ul>
  `,
  methods : {
    add() {
      var text = "Element " + (this.elements.length + 1);
      axios.post("/list", {text:text})     // pass object 
                                           // {text:text} to 
                                           // server
      .then((response) => {
        this.elements.push({text:text, 
        _id:response.data.id});
      });
    },
    remove(params) {
      var id = params.id;
      // remove the element with this id from the elements 
      // array
      this.elements = this.elements.filter(
      function(element) {
        if (element._id == id) return false;
        else return true;
      });
    },
    modify(params) {
      var id = params.id;
      var value = params.value;
      // modify the text of the element with this id in the 
      // elements array
      this.elements = this.elements.map(function(element) {
        if (element._id == id) {
          element.text = value;
          return element;
        }
        else return element;
      });
    }
  }
}
export default GlobalApp;
```

The `axios.post("/list", {text:text})` method activates the `/list` URL on the server, using a `POST` type request. The `text` parameter is passed to the server so that it stores it in the `elements` collection.

In return for the call to the server, the latter returns a `response` object containing in `data.id` the identifier of the document created in MongoDB. This identifier and the element text are then stored in the `elements` array. Because the `elements` array is a reactive variable of Vue.js, its update causes the list to be re-displayed in the browser.

Note

Notice how the callback function is written in the `then(callback)` method. We use the form with `=>` (that is without using the `function` keyword) in order to preserve the value of `this` in the callback function. If you use the `function` keyword instead, the value of `this` is `undefined` and you can no longer access the `elements` variable through `this.elements`, which will cause an error.

The `POST` request was issued by the client (the browser), so it must now be processed by the server to insert a new element into the collection. Let’s study how to proceed.

## POST type request processing (server side)

Now let’s see how the server handles the receipt of the `POST` request. It must create a new document in the `elements` collection of the database. The server’s `app.js` file is modified to take into account the `POST` request on the `/list` URL:

Adding a new element in the database, server side (app.js file)

```
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var listSchema = mongoose.Schema({
 text : String
});
var List = mongoose.model("elements", listSchema);
var app = express();
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/', indexRouter);
app.use('/users', usersRouter);
// creating a new element in the list
app.post("/list", function(req, res) {
  var text = req.body.text;
  List.create({text:text}, function(err, doc) {
    res.json({id:doc._id});  // send the MongoDB identifier 
                             // in the response
  });
});
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});
// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? 
  err : {};
  // render the error page
  res.status(err.status || 500);
  res.render('error');
});
module.exports = app;
```

The `app.post("/list", callback)` method is used to receive and process the request to insert the new element into the `elements` collection.

The text sent in the Axios `text` parameter is received on the server in the `req.body.text` variable. The update of the `elements` collection is performed by the `List.create()` class method, to which we pass the `text` parameter. In the callback function associated with the `create()` method, we retrieve the identifier of the document created in `doc._id`.

We return this identifier in the response sent to the browser as a JSON object `{ id : doc._id }`. We use the `res.json()` method for this. This server return is processed in the `then(callback)` method when calling the `axios.post()` method previously seen (the `global-app.js` file).

If you run the preceding program, you’ll see that the lines containing **Element X** are inserted one under the other on the page. But nothing says that the database has been updated. Let’s verify the correct insertion using the tools available in MongoDB.

## Verifying the correct operation of the insertion in the database

To verify the insertion in the database, just use the `mongo` utility, then type the command `db.elements.find()` to see the inserted documents displayed (assuming we have already connected the `mydb_test` database with the `db=connect("mydb_test")` command).

Assuming that three list items have been inserted, we get the following:

![ 1210 9.11 Using the mongo utility ](/packtpub/javascript_from_frontend_to_backend_img/1210_9.11_using_the_mongo_utility.webp
)
Figure 9.11 – Using the mongo utility to view the contents of the elements collection

The next step is to retrieve the information stored in the database to display the items in the list. The list should be viewed when the page is displayed at the start and will be updated as insertions, modifications, or deletions are made.

# Displaying list elements

In this section, we deal with the first display of the page. Insertion has been seen previously, and modification and deletion are covered in the following sections.

Note

To display the list when the application starts, you must use the `created()` method or the `mounted()` method of the component, which are called in each Vue.js component when the component is created.

To retrieve the list of elements, we are going to use an HTTP `GET` request.

## Using Axios with a GET type request (client side)

Here, we are going to make a `GET` type request with the `/list` URL to the server. The `axios.get("/list")` instruction is used to perform this request. We can use this instruction in the `created()` or `mounted()` method. Here, we choose to use it in the `created()` method:

Retrieving list of items, client side (global-app.js file)

```
import Element from "./element.js";
const GlobalApp = {
  data() {
    return {
      elements : []  // array of object { text, _id }
                     // (_id = document id in MongoDB)
    }
  },
  components : {
    Element:Element
  },
  template : `
    <button @click="add()">Add Element</button>
    <ul>
      <Element v-for="(element, index) in elements" 
       :key="index" :element="element"
        @remove="remove($event)" @modify="modify($event)"
      />
    </ul>
  `,
  methods : {
    add() {
      var text = "Element " + (this.elements.length + 1);
      axios.post("/list", {text:text})
      .then((response) => {
        console.log(this.elements);
        this.elements.push({text:text, 
        _id:response.data.id});
      });
    },
    remove(params) {
      var id = params.id;
      // remove the element with this id from the elements 
      // array
      this.elements = this.elements.filter(
      function(element) {
        if (element._id == id) return false;
        else return true;
      });
    },
    modify(params) {
      var id = params.id;
      var value = params.value;
      // modify the text of the element with this id in the 
      // elements array
      this.elements = this.elements.map(function(element) {
        if (element._id == id) {
          element.text = value;
          return element;
        }
        else return element;
      });
    }
  },
  created() {
    axios.get("/list")
    .then((response) => {
      this.elements = response.data.elements.map(
       function(element) {
         return {_id : element._id, text : element.text }
      });
    });
  }
}
export default GlobalApp;
```

The `axios.get("/list")` method makes the request to the server, then processes the response received in the `then(callback)` method. As before, the received `response` object contains the `data` property, which contains the response returned by the server (the `elements` field – see below).

As the server sends all the document fields of the `elements` collection, we filter the list received by the `map()` method in order to keep only the `_id` and `text` fields (we thus remove the `__v` field associated with the version number, which is unnecessary here).

Now let’s see how to process the `GET` request on the Node.js server side.

## GET type request processing (server side)

The `GET /list` request is received by the Node.js server through the `app.get("/list")` method defined in the `app.js` file. The processing will consist of reading the content of the `elements` collection and returning it in JSON form to the browser in the `elements` property. Each item in the returned collection has `_id`, `text`, and `__v` (for the version number of the document) fields:

Retrieving list of items, server side (app.js file)

```
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var listSchema = mongoose.Schema({
 text : String
});
var List = mongoose.model("elements", listSchema);
var app = express();
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/', indexRouter);
app.use('/users', usersRouter);
// creating a new element in the list
app.post("/list", function(req, res) {
  var text = req.body.text;
  console.log(text);
  List.create({text:text}, function(err, doc) {
    res.json({id:doc._id});
  });
});
// retrieving list of elements
app.get("/list", function(req, res) {
  List.find(function(err, elements) {
    res.json({elements:elements});
  });
});
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});
// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? 
  err : {};
  // render the error page
  res.status(err.status || 500);
  res.render('error');
});
module.exports = app;
```

The `elements` collection is read using the `List.find()` class method. We return the `{ elements : elements }` object in response to the browser, the use of which we saw earlier.

The list of items is now displayed each time the application is started. Just restart the server with `npm start`, then re-display the URL of the page, http://localhost:3000.

![ 1211 9.12 The list of elements is ](/packtpub/javascript_from_frontend_to_backend_img/1211_9.12_the_list_of_elements_is.webp
)
Figure 9.12 – The list of elements is displayed when the application starts

We have seen how to insert an element and retrieve the list of elements. Next, let’s see how to modify an element in the list.

# Modifying an element in the list

Here we show how to modify an element of the list, keeping this modification in the database. A `PUT` type request will be used for this.

## Using Axios with a PUT type request (client side)

The `axios.put("/list", options)` method is used to perform a `PUT` type request to the server. We transmit to the server in the `options` parameter the new text of the modified element and its identifier in the database. The identifier and the new text will allow the item to be updated on the server:

Modifying an element, client side (global-app.js file)

```
import Element from "./element.js";
const GlobalApp = {
  data() {
    return {
      elements : []  // array of object { text, _id } 
                     // (_id = document id in MongoDB) 
    }
  },
  components : {
    Element:Element
  },
  template : `
    <button @click="add()">Add Element</button>
    <ul>
      <Element v-for="(element, index) in elements" 
      :key="index" :element="element"
        @remove="remove($event)" @modify="modify($event)"
      />
    </ul>
  `,
  methods : {
    add() {
      var text = "Element " + (this.elements.length + 1);
      axios.post("/list", {text:text})
      .then((response) => {
        console.log(this.elements);
        this.elements.push({text:text, 
        _id:response.data.id});
      });
    },
    remove(params) {
      var id = params.id;
      // remove the element with this id from the elements 
      // array
      this.elements = this.elements.filter(
      function(element) {
        if (element._id == id) return false;
        else return true;
      });
    },
    modify(params) {
      var id = params.id;
      var value = params.value;
      // modify the text of the element with this id in the 
      // elements array
      this.elements = this.elements.map(function(element) {
        if (element._id == id) {
          element.text = value;
          return element;
        }
        else return element;
      });
      // modify the text of the element having this 
      // identifier
      axios.put("/list", {text:value, id:id});       
    }
  },
  created() {
    axios.get("/list")
    .then((response) => {
      this.elements = response.data.elements.map(
      function(element) {
        return {_id : element._id, text : element.text }
      });
    });
  }
}
export default GlobalApp;
```

The `then(callback)` method should not be used here because the server does not return any information for the browser.

Let’s now see the management of the `PUT` request on the server side.

## PUT type request processing (server side)

The server processes the `PUT /list` request in the `app.js` file. The processing consists of carrying out an update of the document of the collection having this identifier, with the text received from the browser:

Modifying an element, server side (app.js file)

```
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var listSchema = mongoose.Schema({
 text : String
});
var List = mongoose.model("elements", listSchema);
var app = express();
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/', indexRouter);
app.use('/users', usersRouter);
// creating a new element in the list
app.post("/list", function(req, res) {
  var text = req.body.text;
  console.log(text);
  List.create({text:text}, function(err, doc) {
    res.json({id:doc._id});
  });
});
// retrieving list of elements
app.get("/list", function(req, res) {
  List.find(function(err, elements) {
    res.json({elements:elements});
  });
});
// modifying an element in the list
app.put("/list", function(req, res) {
  var id = req.body.id;
  var text = req.body.text;
  List.updateOne({_id:id}, {text:text}).exec();
  // don't forget exec()!
  res.send();  // close the connection to the browser
});
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});
// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? 
  err : {};
  // render the error page
  res.status(err.status || 500);
  res.render('error');
});
module.exports = app;
```

The text and the identifier are retrieved from the server in the `req.body.text` and `req.body.id` variables. The document with this identifier is updated in the database with the new text. The `List.updateOne()` class method allows this document to be modified, but since it does not use a callback function afterward, the `exec()` method must be used afterward for the update to be carried out in the database.

Also notice the `res.send()` instruction at the end of the processing. It closes the connection between the browser and the server. If the connection is not closed, the browser waits for the server’s response, which would never come if the server sends nothing back to the browser.

Let’s finish by explaining how to remove an item from the list.

# Removing an element from the list

Finally, we will learn how to remove an element from the list. A `DELETE` type request will be used for this.

## Using Axios with a DELETE type request (client side)

The `axios.delete("/list", options)` method is used to trigger a `DELETE` type request on the server. The `options` parameter must indicate the identifier of the element to be deleted from the collection.

However, unlike the previous `axios.get()`, `axios.put()`, and `axios.post()` calls, the `axios.delete("/list", options)` call requires that the `options` parameter be written in the `data` property (thus written as `{ data : options }`). If you don’t follow this convention, it won’t work.

Here are the instructions for performing a `DELETE` request with the Axios library:

Deleting an element, client side (global-app.js file)

```
import Element from "./element.js";
const GlobalApp = {
  data() {
    return {
      elements : []  // array of object { text, _id } 
                     // (_id = document id in MongoDB)
    }
  },
  components : {
    Element:Element
  },
  template : `
    <button @click="add()">Add Element</button>
    <ul>
      <Element v-for="(element, index) in elements" 
      :key="index" :element="element"
        @remove="remove($event)" @modify="modify($event)"
      />
    </ul>
  `,
  methods : {
    add() {
      var text = "Element " + (this.elements.length + 1);
      axios.post("/list", {text:text})
      .then((response) => {
        console.log(this.elements);
        this.elements.push({text:text, 
        _id:response.data.id});
      });
    },
    remove(params) {
      var id = params.id;
      // remove the element with this id from the elements 
      // array
      this.elements = this.elements.filter(
      function(element) {
        if (element._id == id) return false;
        else return true;
      });
      axios.delete("/list", { data : {id:id} });    
            // the options must be written in the data 
            // property
    },
    modify(params) {
      var id = params.id;
      var value = params.value;
      // modify the text of the element with this id in the 
      // elements array
      this.elements = this.elements.map(function(element) {
        if (element._id == id) {
          element.text = value;
          return element;
        }
        else return element;
      });
      axios.put("/list", {text:value, id:id});   
            // modify the text of the element having this 
            // identifier
    }
  },
  created() {
    axios.get("/list")
    .then((response) => {
      this.elements = response.data.elements.map(
      function(element) {
        return {_id : element._id, text : element.text }
      });
    });
  }
}
export default GlobalApp;
```

As mentioned before, we use the `options` parameter of the `axios.delete(/list", options)` method in the form `{ data : options }` so that the options are correctly passed by the `DELETE` method.

Let’s now examine the processing performed by the server when receiving the `DELETE` request.

## DELETE type request processing (server side)

The server receives the `DELETE /list` request using the `app.delete("/list, callback)` method. The callback function uses the identifier passed in the request to delete the corresponding document from the `elements` collection:

Deleting an element, server side (app.js file)

```
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var mongoose = require("mongoose");
mongoose.connect("mongodb://localhost/mydb_test");
var listSchema = mongoose.Schema({
 text : String
});
var List = mongoose.model("elements", listSchema);
var app = express();
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/', indexRouter);
app.use('/users', usersRouter);
// creating a new element in the list
app.post("/list", function(req, res) {
  var text = req.body.text;
  console.log(text);
  List.create({text:text}, function(err, doc) {
    res.json({id:doc._id});
  });
});
// retrieving list of elements
app.get("/list", function(req, res) {
  List.find(function(err, elements) {
    res.json({elements:elements});
  });
});
// modifying an element in the list
app.put("/list", function(req, res) {
  var id = req.body.id;
  var text = req.body.text;
  List.updateOne({_id:id}, {text:text}).exec();
  res.send();  // close the connection to the browser
});
// remove an element from the list
app.delete("/list", function(req, res) {
  var id = req.body.id;
  console.log(req.body.id);
  List.deleteOne({_id:id}).exec();   // don't forget exec()!
  res.send();  // close the connection to the browser
});
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});
// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? 
  err : {};
  // render the error page
  res.status(err.status || 500);
  res.render('error');
});
module.exports = app;
```

The `List.deleteOne({_id:id})` method is used to delete the document having this identifier in the collection. As we do not use a callback function in the `List.deleteOne()` method, we call the `exec()` method so that the deletion is performed in the database.

Also, notice the `res.send()` instruction at the end of the processing. It closes the connection between the browser and the server. If the connection is not closed, the browser waits for the server’s response, which would never come if the server sends nothing back to the browser. In this case, you would see unexpected results by clicking several times on the **Delete** buttons in the list and reloading the list.

We have seen how to use MongoDB to insert, modify, and delete elements in a list, using a library such as Axios, allowing communication between the JavaScript code of the browser and the JavaScript code written for the server. And now, this brings us to the end of this chapter and the book.

# Summary

Through this complete example, we have seen how to use JavaScript on both the client side (here, with Vue.js) and the server side (with Node.js and MongoDB).

The use of a single language to carry out all development simplifies learning and ensures great consistency throughout the application.

In addition, tools such as Vue.js, allowing the creation of reusable components, and modules such as Express and mongoose based on the MVC model, make it possible to properly architect JavaScript code, both on the client side and on the server side.

We also saw how the Axios library made it possible to communicate between the client and the server.

You now have everything you need to create reliable, robust, and well-structured client and server applications entirely in JavaScript.

# Thanks

Thank you, dear reader, for purchasing and reading this book. It was written for the sole purpose of helping and guiding you. We hope it has been of great help to you.

If so, we ask you for a very small but extremely important contribution – to make our book knownto others by means at your disposal, in the hope that it can keep helping people like you. Thanks very much!

# Why subscribe?

- Spend less time learning and more time coding with practical eBooks and Videos from over 4,000 industry professionals
- Improve your learning with Skill Plans built especially for you
- Get a free eBook or video every month
- Fully searchable for easy access to vital information
- Copy and paste, print, and bookmark content

Did you know that Packt offers eBook versions of every book published, with PDF and ePub files available? You can upgrade to the eBook version at packt.com and as a print book customer, you are entitled to a discount on the eBook copy. Get in touch with us at customercare@packtpub.com for more details.

At www.packt.com, you can also read a collection of free technical articles, sign up for a range of free newsletters, and receive exclusive discounts and offers on Packt books and eBooks.



> [ 11 C8 Using MongoDB with Node.js ](/packtpub/javascript_from_frontend_to_backend/11_c8_using_mongodb_with_node.js) <---> [ 13 P4 Other Books You May Enjoy ](/packtpub/javascript_from_frontend_to_backend/13_p4_other_books_you_may_enjoy)
>
> (1) Path: packtpub/javascript_from_frontend_to_backend/12_c9_integrating_vuejs_with_nodejs
> (2) Markdown
> (3) Title: 12 C9 Integrating Vue.js with Node.js
> (4) Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> (5) tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 13:20:55
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 12_c9_integrating_vue.js_with_node.js.md

