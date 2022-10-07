
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

> [ 09 C6 Creating and Using Node.js Modules ](/packtpub/javascript_from_frontend_to_backend/09_c6_creating_and_using_node.js_modules) <---> [ 11 C8 Using MongoDB with Node.js ](/packtpub/javascript_from_frontend_to_backend/11_c8_using_mongodb_with_node.js)

# Chapter 7: Using Express with Node.js

We saw in the previous chapter that a program for the Node.js server is an assembly of different modules. Many modules have been created by Node.js developers, which can be inserted into our programs using the npm utility (see Chapter 6, Creating and Using Node.js Modules). One of these modules is called Express. It is one of the most used modules with Node.js because it allows you to structure server programs according to the Model View Controller (MVC) model.

In this chapter, we’ll study how to create a Node.js application while respecting the characteristics of the MVC model by using the Express module.

Here are the topics we will cover:

Using the Node.js http module
Installing the Express module
The MVC pattern used by Express
Using routes with Express
Displaying views with Express
Node.js integrates into its internal modules the possibility to create a web server using the http module internal to Node.js. We first explain how to use this http module, and then we will see the contribution that the external Express module makes to more easily create a web application built according to the MVC model.

Technical requirements
You can find the code files for this chapter on GitHub at: https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend/blob/main/Chapter%207.zip.

Using the Node.js http module
The http module is an internal Node.js module. It is, therefore, directly accessible in our programs using the require("http") instruction. With this module you can create a web server based on the HTTP protocol and thus display web pages in an internet browser.

For creating a web server based on HTTP, we use the http.createServer(callback) method of the http module. The callback function indicated as a parameter is of the form callback(req, res), in which req corresponds to the request received, and res corresponds to the response to be sent to the browser. Depending on the request received, the corresponding response will be sent.

Note

In the req parameter, there is, among other things, the URL of the request received, thus making it possible to return, via the res parameter, the correct response to the browser according to this request.

Let’s see in the following program how to use the createServer() method:

Creating a web server using the http module (test.js file)

var http = require("http");
var server = http.createServer(function(req, res) {
  // display the received request in the console
  console.log("Request received:", req.url);
  // indicate that the response is HTML in utf-8
  res.setHeader("Content-type", "text/html; charset=utf-8");
  // we always send the same response, regardless of the 
  // request received
  res.write("<h1>")
  res.write("Good morning all");
  res.write("</h1>");
  res.end();
});
// make the server listen on port 3000 (for example)
server.listen(3000);
console.log("\nThe server was started on port 3000\n");
console.log("You can make a request on:");
console.log("http://localhost:3000");

Copy
The createServer() method returns an object, here used through the variable named server, on which we indicate to wait for requests coming from port 3000 (the one indicated in the server.listen(port) method). This means that each time URLs of the form http://localhost:3000 are accessed via the browser, the program previously launched (with the node test.js command) will be activated and will display the result in the browser.

Note

The use of the server.listen(port) method is mandatory because it is not enough to create a server with the http.createServer() method. This server must also be listening (with server.listen(port )) to HTTP requests addressed to it by browsers connecting to this server (here using a URL such as http://localhost:3000). Port 3000 is used here, but another port number could be used (provided that this port is not already used by another server, which would cause an access conflict to know to which server the request on the port is addressed).

We send the response to the browser using res.write(string) instructions. You must finish sending the response with the res.end() instruction, which means that the browser has received all the elements to display (the server waits to receive the res.end() instruction to display all the elements sent).

Note

The res.setHeader() method is used to set HTTP header fields. Here, "Content-type" is set to the value "text/html; charset=utf-8".

Let’s launch the previous program by typing the command node test.js. The program displays a message, then waits for HTTP requests on port 3000:

Figure 7.1 – HTTP server waiting on port 3000
Figure 7.1 – HTTP server waiting on port 3000

To test the program, display the URL beginning with http://localhost:3000 in a browser. When an HTTP request uses port 3000 (the port on which the server is listening), the callback function indicated in the createServer(callback) method is activated and then the response is sent to the browser.

Let’s type the URL http://localhost:3000 in the browser (see the following figure):

Figure 7.2 – Viewing URL http://localhost:3000 in the browser
Figure 7.2 – Viewing URL http://localhost:3000 in the browser

Regardless of the URL specified in the browser ( which uses port 3000), the display in the browser remains the same. For the display to be different for different URLs, it must be considered in the callback function by using the value of req.url, which contains the URL typed and returns different strings according to the request received.

Using the Express module makes it easy to manage the different requests received and display different results depending on the URL entered.

Installing the Express module
Since the Express module is installed using npm, we type the npm install express command to install it.

Figure 7.3 – Installing the Express module with npm
.

Figure 7.3 – Installing the Express module with npm

The Express module is now installed.

Note

A utility related to Express is also useful for creating the architecture of our web applications. This is the "express-generator" module (this module was previously included with Express but is now separate from it, hence it’s uploaded here).

Let’s also install the "express-generator" module using the npm install express-generator -g command. We use the -g option so that the express command defined in this module is accessible from any directory.

Figure 7.4 – Installing the "express-generator" module with npm
Figure 7.4 – Installing the “express-generator” module with npm

Note

You can verify that the installation is correct by typing the command express -h. If the installation of the module is correct, help for the express command is displayed in the window (otherwise an error is displayed).

Once these two modules are installed, you can create a first web application based on Express.

To do this, type the express apptest command to create the application named apptest. You should see the following result:

Figure 7.5 – Creating the apptest application with Express
Figure 7.5 – Creating the apptest application with Express

This command creates an apptest directory containing the basic files to run the application. You must then type the three commands indicated at the end of the display: cd apptest, npm install, and npm start.

Once these commands are typed, open a browser and display the URL http://localhost:3000.

This is what you will see:

Figure 7.6 – Default app home page created with Express
Figure 7.6 – Default app home page created with Express

If we look at the source files of the application created in the apptest directory, we see the app.js and package.json files, as well as the bin, node_modules, public, routes, and views directories. These directories are those that describe the MVC architecture used by Express, which we explain below.

The MVC pattern used by Express
The MVC model is an application architecture model allowing an application to be broken down into different parts: models, views, and the controller:

Models correspond to the data manipulated by the application. In general, this is data from databases. Node.js is closely tied to the MongoDB database, which is explored in the next chapter.
Views correspond to the visualization of data, for example, input forms and displayed lists. Each display corresponds to a view that will be in the views directory of the application.
The controller allows navigation between the different views, depending on the data. For this, we use routes (in fact, URLs) that indicate the processing to be performed. The routes directory describes the routes used by the application (and the processing performed for each of them).
We can therefore see that the MVC model makes it possible to separate the processing, the display, and the data. This split is widely used in web projects and is the one proposed by Express.

Let’s first look at how routing works in Express. This corresponds to the controller part of the MVC model.

Using routes with Express
Routes indicate the processing to be performed based on the requested URL. Compared to what we wrote when using the http module of Node.js with the createServer(callback) method, this consists of writing the content of the callback(req, res) function according to the req request received.

The routes are described in the app.js file, which is the main file created by Express. Let’s examine its content.

The initial content of the app.js file
To understand how routes work in Express, open the app.js file located in the main application directory, and you will see the content of this file, like this:

app.js file

var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
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

Copy
This file describes how the application built with Express works. It uses the app variable, which is the return from the express() function call and symbolizes the application. On this app object, the use() method is used many times, which makes it possible to add processing to be performed for each request received on the server.

For example, app.use(logger("dev")) triggers the logger() function for each request received on the server. This is why the server console displays the URL that was requested in the browser during each request to the server.

By having displayed in the browser the URLs http://localhost:3000 and http://localhost:3000/users, we obtain the following in the server console.

Figure 7.7 – Display of URLs in the server console
Figure 7.7 – Display of URLs in the server console

Now, let’s look at the meaning of the lines displayed in the server console.

Different types of routes possible
In the previous figure, you’ll notice that the word GET is displayed in front of each URL: GET /, GET /users.

The word GET means that the URL / or /users is accessed by an HTTP request of the GET type. The GET type is the one used when the accessed URL is displayed in the address bar of the browser, for example, when you type it directly or when you click on a link on a page.

Note

Other types of HTTP requests exist. They make it possible not to display the corresponding URL in the address bar of the browser, and thus to hide it from users. For example, if the URL for deleting records from the database was visible in the browser’s address bar, it would suffice to refresh the page to continue deleting records from the database. Hence the interest in other types of HTTP requests that allow the current URL to be hidden.

The other types of HTTP requests (in addition to GET) are mainly PUT, POST, and DELETE type requests. These types of requests are used in programs to signify an action to be performed on one or more pieces of data (called resources):

GET means reading a resource.
POST means creating a resource.
PUT means updating a resource.
DELETE means deleting a resource.
Although multiple types of HTTP requests exist, these are the main ones. They are used to manipulate resources, allowing them to be created (POST), updated (PUT), deleted (DELETE), and read (GET).

Note

A route is the association of an HTTP request with a URL. For example, the GET /users route associates the /users URL with the HTTP GET request, while the DELETE /users route associates the same /users URL with the HTTP DELETE request. Although these routes use the same URL, they are different routes because the HTTP requests are different.

Now that we’ve seen the different types of HTTP requests used, let’s look at how Express uses them internally.

Analyzing routes defined in the app.js file
The app.use() method is also used to define new routes, that is, to define the processing that will be performed for each new URL used (with the associated request type).

The app.use(url, callback) method is used to define the processing to be performed when the specified URL is activated. As the type of request is not indicated here, all types of requests will activate the treatment indicated in the callback function. To indicate the type of request, you must use methods similar to app.use(). These are the app.get(), app.put(), app.post(), and app.delete() methods.

Note

The callback function of the form callback(req, res, next) returns the response to the browser. The next() parameter corresponds to a function to be called at the end of the callback if the processing must continue in the next callback function (if the processing to be performed is handled by multiple callback functions).

The routes already defined in app.js are / and /users, thus making it possible to run the processes associated with these routes. These routes are examples to show how to implement routes in the app.js file. The processing instructions are defined in the indexRouter and usersRouter functions. These functions are the variables used in return for the instructions require('./routes/index') and require('./routes/users'). The processing of routes is therefore done here in the index.js and users.js files defined in the routes directory.

Let’s open these two files and analyze their contents:

index.js file (routes directory)

var express = require('express');
var router = express.Router();
/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});
module.exports = router;

Copy
users.js file (routes directory)

var express = require('express');
var router = express.Router();
/* GET users listing. */
router.get('/', function(req, res, next) {
  res.send('respond with a resource');
});
module.exports = router;

Copy
Each of these files uses the router.get(url, callback) method, meaning that the route is associated with the GET type request. The URL given is / (it will be concatenated with the URL given in the app.js file), followed by the callback function of the form callback(req, res, next). The next parameter corresponds to a function to call if the processing must continue in the callback function that follows (if such a function exists, which is not the case here).

The processing performed in each of the callback functions consists of sending the response, which will be displayed in the browser. Here, we use the res.send() and res.render() methods, which allow the response to be sent:

The res.send() method is similar to res.end() (defined in the "http" module of Node.js), but also allows you to indicate that you are using HTML and utf-8 characters. Only one call to the res.send() method must be made in the processing, otherwise, an error occurs.
The res.render() method allows an external file (called a view) to be displayed. Views are written in a special language that depends on the format of the view. By default, the views used by Express are JADE files, but it is possible to use other formats.
Here, the view displayed by the res.render() method corresponds to the index.jade file located in the views directory. Its contents are as follows:

index.jade file (views directory)

extends layout
block content
  h1= title
  p Welcome to #{title}

Copy
This file is written using a particular syntax, called JADE. The file will be transformed into HTML code by Express before being sent to the browser (which can only interpret HTML).

Note

Express allows files associated with views to be written using a variety of syntaxes. The most common are JADE and EJS.

We will explore the JADE syntax in the Displaying views with Express section in this chapter.

Note that the app.js file allows you to configure the directory associated with the views and the syntax used in the views. Here are the corresponding instructions from the app.js file:

Configuring views (app.js file)

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

Copy
We have described the routes already listed in the app.js file. Let’s see how to create new routes in this file.

Adding a new route in the app.js file
Adding a new route in the app.js file can be done either by writing the processing directly in the app.js file or by creating an external file that will be in the routes directory.

Warning

Any modification of the app.js file requires restarting the server by performing the npm start command; otherwise, the modifications are not taken into account.

Let’s look at these two ways to create a new route.

Adding route processing directly in the app.js file
Let’s add the /clients route activated following a GET type request. It displays the list of clients. We use the app.get() method to define the route:

Add the GET /clients route

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.get("/clients", function(req, res, next) {
  res.send("<h1>Client list</h1>");
});

Copy
The result is displayed in the following figure (Figure 7.8).

Creating an external file to define route processing
We use the same principle as that used for the GET / and GET /users routes defined in the app.js file. We create the clients.js file in the routes directory, which will be included in the app.js file by means of the statement clientsRouter = require("./routes/clients). The route is defined in app.js with the statement app.use("/clients", clientsRouter).

The clients.js file describing the processing performed on the route is as follows:

clients.js file (routes directory)

var express = require('express');
var router = express.Router();
router.get('/', function(req, res, next) {
  res.send("<h1>Client list</h1>");
});
module.exports = router;

Copy
In both cases, the result is the same, as seen in the following figure.

Figure 7.8 – Displaying the GET /clients route
Figure 7.8 – Displaying the GET /clients route

We studied the controller part of the MVC model using the route system defined in Express. Now let’s see how Express allows us to manage the view part of the MVC model.

Displaying views with Express
A view is an external file used to describe the display that you want to view. Specific syntaxes have been created to program the view, for example, JADE or EJS syntaxes.

The res.render(name, obj) method is used to display the name view using any properties provided in the obj object. The view is a file defined in the views directory using JADE syntax or another.

One of the features of Express is to allow you to create views using the desired syntax. The JADE syntax is offered as standard by Express, but other syntax support libraries can be added with npm.

The JADE syntax is, therefore, the one used by default in Express. It makes it possible to replace HTML tags with their tag (for example <h1> simply becomes h1), and the indentation of tags in the code makes it possible to specify their nesting. It is also no longer necessary to close the tag previously opened because the indentation allows you to see the nesting of the tags.

Note

Full JADE documentation can be found at https://jade-lang.com/.

Let’s use JADE to display the previous client list. We create the clients.jade view in the views directory, and we indicate in clients.js that we display this view when accessing the GET /clients route:

clients.js file (routes directory)

var express = require('express');
var router = express.Router();
router.get('/', function(req, res, next) {
  res.render("clients");   // display clients.jade view 
                           // (.jade extension is enabled by 
                           // default)
});
module.exports = router;

Copy
Note that if you do not indicate the file extension of the view (for example, by writing res.render("clients")), the extension used will be the one indicated in the instruction app.set('view engine' , 'jade') from app.js.

If, on the other hand, you specify an extension to the view file, it will be the one used to display the view even if it is different from the one configured in app.js. The view clients.jade is as follows:

clients.jade file (views directory)

h1 Client list
ul
  li Bill Clinton
  li Barack Obama
  li Joe Biden

Copy
Notice the indentation of the tags. The ul tag is at the same level as the h1 tag, otherwise, it would be seen as included in the h1 tag. The li tags are shifted to the right to show their inclusion in the preceding ul tag. The offset must be at least one character. Because of the offsets, we do not use a closing tag as in HTML.

Let’s restart the server with npm start because one of the routing files has been modified.

Note

Editing files associated with views does not require a server restart, unlike the app.js file and files associated with routes (in the routes directory).

Once the server restarts, let’s display the URL http://localhost:3000 again:

Figure 7.9 – View displayed using JADE syntax
Figure 7.9 – View displayed using JADE syntax

The list of clients is, in this example, entered directly into the JADE view. It is better to pass it as parameters using the second parameter of the res.render(name, obj) method. The clients.js file then becomes the following:

clients.js file (routes directory)

var express = require('express');
var router = express.Router();
router.get('/', function(req, res, next) {
  res.render("clients", { 
    clients : [
      { firstname : "Bill", lastname : "Clinton" },
      { firstname : "Barack", lastname : "Obama" },
      { firstname : "Joe", lastname : "Biden" },
    ]
  });
});
module.exports = router;

Copy
The obj parameter of the res.render("clients", obj) method is an object containing the list of clients.

The clients.jade view uses this passed object as follows:

clients.jade file (views directory)

h1 Client list
ul
  li #{clients[0].lastname + " " + clients[0].firstname}
  li #{clients[1].lastname + " " + clients[1].firstname}
  li #{clients[2].lastname + " " + clients[2].firstname}

Copy
The obj object passed in parameters is used in the JADE view, by using its clients property here.

JADE Syntax

JavaScript statements can be used in the JADE view by surrounding them with #{ and }. Anything between these two markers will be considered JavaScript code.

You can also use a syntax simplification allowed by JADE, by writing the = sign directly after each li tag. This means that everything following on the line must be interpreted in JavaScript. We can use this simplification of writing here.

Let’s write the clients.jade view as follows:

clients.jade file (views directory)

h1 Client list
ul
  li= clients[0].lastname + " " + clients[0].firstname
  li= clients[1].lastname + " " + clients[1].firstname
  li= clients[2].lastname + " " + clients[2].firstname

Copy
Rather than listing each element of the clients array in the view, you can also perform a loop using the each statement of the JADE syntax to iterate over a JavaScript array.

The clients.jade view therefore becomes the following:

clients.jade file (views directory)

h1 Client list
ul
  each client in clients
    li= client.lastname + " " + client.firstname

Copy
The writing of the view is simplified, but you really have to take into account the indentations of the lines otherwise the view will not be displayed.

Figure 7.10 – List of clients displayed by the each statement
Figure 7.10 – List of clients displayed by the each statement

We see in this example that the JADE syntax makes it easy to display lists of data in the views of the application.

With this, we come to the end of this chapter.

Summary
The Express module makes it possible to structure your application efficiently by allowing (thanks to the MVC model it uses) you to separate the management of routes, the views displayed, and the management of data.

We have explained how to write the views of the application using the JADE syntax provided by default by Express. Other syntaxes, for example, the EJS syntax, are also available by downloading them via npm.

We have also seen the importance of the app.js file created by Express, and the use of HTTP requests such as GET, POST, PUT, and DELETE. We will see in Chapter 9, Integrating Vue.js with Node.js, the importance of these HTTP requests to build a MEVN application (short for MongoDB, Express, Vue.js, Node.js) that manipulates the MongoDB database.

Indeed, data management is often done using the MongoDB database, the use of which we will explore in the next chapter.



> [ 09 C6 Creating and Using Node.js Modules ](/packtpub/javascript_from_frontend_to_backend/09_c6_creating_and_using_node.js_modules) <---> [ 11 C8 Using MongoDB with Node.js ](/packtpub/javascript_from_frontend_to_backend/11_c8_using_mongodb_with_node.js)
>
> Title: 10 C7 Using Express with Node.js
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/10_c7_using_express_with_node.js
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 13:20:55
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 10_c7_using_express_with_node.js.md

