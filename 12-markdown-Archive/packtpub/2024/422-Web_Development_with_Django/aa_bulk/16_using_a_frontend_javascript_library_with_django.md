
| ≪ [ 15 Django Third-Party Libraries ](/packtpub/2024/422-web_development_with_django_2ed/15_django_third-party_libraries) | 16 Using a Frontend JavaScript Library with Django | [ 17 Index ](/packtpub/2024/422-web_development_with_django_2ed/17_index) ≫ |
|:----:|:----:|:----:|

# 16 Using a Frontend JavaScript Library with Django

Packt Logo

Book image


Using a Frontend JavaScript Library with Django
Django is a great tool for building the backend of an application. You have seen how easy it is to set up the database, route URLs, and render templates. Without using JavaScript, though, when those pages are rendered to the browser, they are static and do not provide any form of interaction. By using JavaScript, your pages can be transformed into applications that are fully interactive in the browser.

This chapter will provide a brief introduction to JavaScript frameworks and how to use them with Django. While it won’t be a deep dive into how to build an entire JavaScript application from scratch (that would be a book in itself), we will give enough of an introduction so that you can add interactive components to your own Django application. In this chapter, we will primarily be working with the React framework. Even if you do not have any JavaScript experience, we will introduce enough about it so that you will be comfortable writing your own React components by the end of this chapter. In Chapter 12, Building a REST API, you built a REST API for Bookr. We will interact with that API using JavaScript to retrieve data. We will enhance Bookr by showing some review previews on the main page that are dynamically loaded and can be paged through.

Technical requirements
The code for the exercises and activities in this chapter can be found in this book’s GitHub repository at https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/Chapter16.

JavaScript frameworks
These days, real-time interactivity is a fundamental part of web applications. While simple interactions can be added without a framework (developing without a framework is often called Vanilla JS), as your web application grows, it can be much easier to manage with the use of a framework. Without a framework, you would need to do all these things yourself:

Manually define the database schema
Convert data from HTTP requests into native objects
Write form validation
Write SQL queries to save data
Construct HTML to show a response
Compare this to what Django provides. Its Object Relational Mapping (ORM), automatic form parsing and validation, and templating drastically reduce the amount of code you need to write. JavaScript frameworks bring similar time-saving enhancements to JavaScript development. Without them, you would have to manually update the HTML elements in the browser as your data changes. Let’s take a simple example: showing the count of the number of times a button has been clicked. Without a framework, you would have to do the following:

Assign a handler to the button click event.
Increment the variable that stores the count.
Locate the element containing the click count display.
Replace the element’s text with the new click count.
When using a framework, the button count variable is bound to the display (HTML), so the process you have to code is as follows:

Handle the button click.
Increment the variable.
The framework takes care of automatically re-rendering the number display. This is just a simple example, though; as your application grows, the disparity in complexity between the two approaches expands. Several JavaScript frameworks are available, each with different features, and some are supported and used by large companies. Some of the most popular are React (https://reactjs.org), Vue (http://vuejs.org), Angular (https://angularjs.org), Ember (https://emberjs.com), and Backbone.js (https://backbonejs.org).

In this chapter, we will use React, as it is easy to drop into an existing web application and allows progressive enhancement. This means that rather than having to build your application from scratch, targeting React, you can simply apply it to certain parts of the HTML that Django generates; for example, a single text field that automatically interprets Markdown and shows the result without reloading the page. We will also cover some of the features that Django offers that can help integrate several JavaScript frameworks.

Several different levels of JavaScript can be incorporated into a web application. Figure 16.1 shows our current stack with no JavaScript (note that the following diagrams do not show requests to the server):

Figure 16.1 – Current stack
Figure 16.1 – Current stack

You can base your entire application on JavaScript using Node.js (a server-side JavaScript interpreter), which would replace Python and Django in the stack. Figure 16.2 shows how this might look:

Figure 16.2 – Using Node.js to generate HTML
Figure 16.2 – Using Node.js to generate HTML

Or, you can have your frontend and templates entirely in JavaScript and just use Django to act as a REST API to provide data to render. Figure 16.3 shows this stack:

Figure 16.3 – Sending JSON from Django and rendering it in the browser
Figure 16.3 – Sending JSON from Django and rendering it in the browser

The final approach is progressive enhancement, which is (as mentioned) what we will be using. In this way, Django is still generating the HTML templates, and React sits on top of this to add interactivity:

Figure 16.4 – HTML generated with Django with React providing progressive enhancement
Figure 16.4 – HTML generated with Django with React providing progressive enhancement

Note that it is common to use multiple techniques together. For example, Django may generate the initial HTML to which React is applied in the browser. The browser can then query Django for JSON data to be rendered using React.

To gain an understanding of these approaches, we will first take a brief look at how we can use JavaScript in our web applications.

An introduction to JavaScript
In this section, we will briefly introduce some basic JavaScript concepts. This includes data structures such as variables, constants, arrays, and objects and callables such as functions, classes, and methods. Different operators will be covered as we introduce them.

This will give us the requisite knowledge to begin a brief overview of the React framework.

Loading JavaScript
JavaScript can either be inline in an HTML page or included in a separate JavaScript file. Both methods use the <script> tag. With inline JavaScript, the JavaScript code is written directly inside the <script> tags in an HTML file; for example, like this:

  <script>
  // comments in JavaScript can start with //
  /* Block comments are also supported. This comment is 
      multiple lines and doesn't end until we use a star then 
      slash:/
  let a = 5; // declare the variable a, and set its value to 5
  console.log(a); // print a (5) to the browser console
  </script>

Copy

Explain
Note that the console.log function prints out data to the browser console that is visible in Developer Tools of your browser:

Figure 16.5 – The result of the console.log(a) call – 5 is printed to the browser console
Figure 16.5 – The result of the console.log(a) call – 5 is printed to the browser console

We could also put the code into its own file (we would not include the <script> tags in the standalone file). We then load it into the page using the <script> tag’s src attribute, as we saw in Chapter 5, Serving Static Files:

<script src="{% static 'file.js' }"></script>

Copy

Explain
The source code, whether inline or included, will be executed as soon as the browser loads the <script> tag.

Variables and constants
Unlike in Python, variables in JavaScript must be declared using either the var, let, or const keywords:

  var a = 1; // variable a has the numeric value 1 
  let b = 'a'; // variable b has the string value 'a'
  const pi = 3.14; // assigned as a constant and can't be redefined

Copy

Explain
Just like in Python, though, a type for a variable does not need to be declared. You will notice that the lines end with semicolons. JavaScript does not require lines to be terminated with semicolons – they are optional. However, some style guides enforce their use. You should try to stick with a single convention for any project.

You should use the let keyword to declare a variable. Variable declarations are scoped. For example, a variable declared with let inside a for loop will not be defined outside the loop. In this example, we’ll loop through and sum the multiples of 10 to 90 and then print the result to console.log. You’ll notice we can access variables declared at the function level inside the for loop, but not the other way around:

  let total = 0;
  for (let i=0; i< 10; i++){ // variable i is scoped to the loop
      let toAdd = i * 10; // variable toAdd is also scoped
total += toAdd; /* we can access total since it's in
the outer scope */
}
console.log(total); // prints 450
console.log(toAdd);/* throws an exception as the variable is not   
                        declared in the outer scope */
console.log(i);/* this code is not executed since an
                    exception was thrown the line before, 
                    but it would also generate the same
                    exception */

Copy

Explain
const is for constant data and cannot be redefined. That does not mean that the object it points to cannot be changed, though. For example, you couldn’t do this:

  const pi = 3.1416;
  pi = 3.1; /* raises exception since const values can't be 
                reassigned */

Copy

Explain
The var keyword is required by older browsers that don’t support let or const. Only 1% of browsers these days don’t support those keywords, so throughout the rest of the chapter, we will only use let or const. Like let, variables declared with var can be reassigned; however, they are scoped at the function level only.

JavaScript supports several different types of variables, including strings, arrays, objects (which are like dictionaries), and numbers. We will cover arrays and objects in their own sections now.

Arrays
Arrays are defined similarly to how they are in Python, with square brackets. They can contain different types of data, just like with Python:

const myThings = [1, 'foo', 4.5];

Copy

Explain
Another thing to remember with the use of const is that it prevents reassigning the constant but does not prevent changing the variable or object being pointed to. For example, we would not be allowed to do this:

myThings = [1, 'foo', 4.5, 'another value'];

Copy

Explain
However, you could update the contents of the myThings array by using the push method (like Python’s list.append) to append a new item:

myThings.push('another value');

Copy

Explain
Objects
JavaScript objects are like Python dictionaries, providing a key-value store. The syntax to declare them is similar as well:

const o = {foo: 'bar', baz: 4};

Copy

Explain
Note that, unlike Python, JavaScript object/dictionary keys do not need to be quoted when creating them – unless they contain special characters (spaces, dashes, dots, and more).

The values from o can be accessed either with item access or attribute access:

o.foo; // 'bar'
o['baz']; // 4

Copy

Explain
Also note that since o was declared as a constant, we cannot reassign it, but we can alter the object’s attributes:

o.anotherKey = 'another value'  // this is allowed

Copy

Explain
Functions
There are a few different ways to define functions in JavaScript. We will look at three. You can define them using the function keyword:

function myFunc(a, b, c) {
  if (a == b)
    return c;
  else if (a > b)
    return 0;
  return 1;
}

Copy

Explain
All arguments to a function are optional in JavaScript; that is, you could call the preceding function like this: myFunc(), and no error would be raised (at least during call time). The a, b, and c variables would all be the undefined special type. This would cause issues in the logic of the function. The undefined special type is kind of like None in Python – although JavaScript also has null, which is more similar to None. Functions can also be defined by assigning them to a variable (or constant):

const myFunc = function(a, b, c) {
    // function body is implemented the same as above
}

Copy

Explain
We can also define functions using an arrow syntax. For example, we can also define myFunc like this:

const myFunc = (a, b, c) => {
    // function body as above
}

Copy

Explain
This is more common when defining functions as part of an object, for example:

const o = {
myFunc: (a, b, c) => {
    // function body
    }
}

Copy

Explain
In this case, it would be called like this:

o.myFunc(3, 4, 5);

Copy

Explain
We will return to the reasons for using arrow functions after introducing classes.

Classes and methods
Classes are defined with the class keyword. Inside a class definition, methods are defined without the function keyword. The JavaScript interpreter can recognize the syntax and tell that it is a method. Here is an example class, which takes a number to add (through toAdd) when instantiated. That number will be added to whatever is passed to the add method, and the result returned:

  class Adder {
      // A class to add a certain value to any number
     // this is like Python's  init  method 
     constructor (toAdd) {
         /* "this" is like "self" in Python
            it's implicit and not manually passed into every 
            method */
         this.toAdd = toAdd;
     }
    add (n) {
        // add our instance's value to the passed in number
        return this.toAdd + n;
    }
}

Copy

Explain
Classes are instantiated with the new keyword. Other than that, their usage is very similar to classes in Python:

const a = new Adder(5);
console.log(a.add(3)); // prints "8"

Copy

Explain
Arrow functions
Now that we’ve introduced the this keyword, we can return to the purpose of arrow functions. Not only are they shorter to write, but they also preserve the context of this. Unlike self in Python, which always refers to a specific object because it is passed into methods, the object that this refers to can change based on context. Usually, it is due to the nesting of functions, which is common in JavaScript. Let’s look at two examples. First, an object with a function called outer. This outer function contains an inner function. We refer to this in both the inner and outer functions:

  const o1 = {
      outer: function() {
          console.log(this);  // "this" refers to o1
          const inner = function() {
              console.log(this);  /* "this" refers to the
                                     "window" object */
          }
          inner();
      }
  }

Copy

Explain
Note

The preceding code example refers to the window object. In JavaScript, window is a special global variable that exists in each browser tab and represents information about that tab. It is an instance of the window class. Some examples of the attributes that window has are document (which stores the current HTML document), location (which is the current location shown in the tab’s address bar), and outerWidth and outerHeight (which represent the width and height of the browser window respectively). For example, to print the current tab’s location to the browser console, you would write console.log(window.location).

Inside the outer function, this refers to o1 itself, whereas inside the inner function, this refers to the window (an object containing information about the browser window).

Compare this to defining the inner function using arrow syntax:

  const o2 = {
      outer: function() {
          console.log(this);  // refers to o2 
          const inner = () => {
              console.log(this);  // also refers to o2
          }
          inner();
      }
  }

Copy

Explain
When we use arrow syntax, this is consistent and refers to o2 in both cases. Now that we have had a very brief introduction to JavaScript, let’s introduce React.

Further reading

Covering all the concepts of JavaScript is beyond the scope of this book. For a complete, hands-on course on JavaScript, you can always refer to The JavaScript Workshop book: https://courses.packtpub.com/courses/javascript.

With this brief review of core JavaScript programming concepts complete, we will commence a brief overview of React programming.

Working with React
React allows you to build applications using components. Each component can render itself by generating HTML to be inserted on the page.

A component may also keep track of its own state. If it does track its own state, when the state changes, the component will automatically re-render itself. This means if you have an action method that updates a state variable on a component, you don’t need to then figure out whether the component needs to be redrawn; React will do this for you. A web app should track its own state so that it doesn’t need to query the server to find out how it needs to update to display data.

Data is passed between components using properties, or props for short. The method of passing properties looks kind of like HTML attributes, but there are some differences, which we will cover later in the chapter. Properties are received by a component in a single props object.

To illustrate with an example, you might build a shopping list app with React. You would have a component for the list container (ListContainer), and a component for a list item (ListItem). ListItem would be instantiated multiple times, once for each item on the shopping list. The container would hold a state containing a list of the items’ names. Each item name would be passed to the ListItem instances as a prop. Each ListItem would then store the item’s name and an isBought flag in its own state. As you click an item to mark it off the list, isBought would be set to true. Then, React would automatically call render on ListItem to update the display.

There are a few different methods of using React with your application. If you want to build a deep and complex React application, you should use npm (Node Package Manager, a tool for managing Node.js applications) to set up a React project. Since we will use React to enhance some of our pages, we can just include the React framework code using a <script> tag:

  <script crossorigin 
  src="https://unpkg.com/react@16/umd/react.development.js">
  </script>
  <script crossorigin 
  src="https://unpkg.com/react-dom@16/umd/react-dom.development.js">
  </script>

Copy

Explain
Note

The crossorigin attribute is for security and means cookies or other data cannot be sent to the remote server. This is necessary when using a public content delivery network (CDN) such as unpkg.com in case a malicious script has been hosted there by someone.

These should be placed on a page that you want to add React to just before the closing </body> tag. The reason for putting the tags here instead of in <head> of the page is that the script might want to refer to HTML elements on the page. If we put the script tag in the head, it will be executed before the page elements are available (as they come after).

Note

The links to the latest React versions can be found at https://legacy.reactjs.org/docs/cdn-links.html.

Components
There are two ways to build a component in React: with functions or with classes. Regardless of the approach, to get displayed on a page, the component must return some HTML elements to display. A functional component is a single function that returns elements, whereas a class-based component will return elements from its render method. Functional components cannot keep track of their own state.

React is like Django in that it automatically escapes HTML in strings that are returned from render. To generate HTML elements, you must construct them using their tag, the attributes/properties they should have, and their content. This is done with the React.createElement function. A component will return a React element, which may contain sub-elements.

Let us look at two implementations of the same component, first as a function and then as a class. The functional component takes props as an argument. This is an object containing the properties that are passed to it. The following function returns an h1 element:

function HelloWorld(props) {
return React.createElement('h1', null, 'Hello, ' + 
  props.name + '!');
}

Copy

Explain
Note that it is conventional for the function to have an uppercase first character.

While a functional component is a single function that generates HTML, a class-based component must implement a render method to do this. The code in the render method is the same as in the functional component, with one difference: the class-based component accepts the props object in its constructor, and then the render (or other) methods can refer to props using this.props. Here is the same HelloWorld component implemented as a class:

class HelloWorld extends React.Component {
render() {
return React.createElement('h1', null, 'Hello, ' + 
  this.props.name + '!');
  }
}

Copy

Explain
When using classes, all components extend from the React.Component class. Class-based components have an advantage over functional components; they encapsulate the handling actions/event and their own state. For simple components, using the functional style means less code. For more information on components and properties, see https://reactjs.org/docs/components-and-props.html.

Whichever method you choose to define a component, it is used in the same way. In this chapter, we will only be using class-based components.

We first need to add a place for React to render this component onto an HTML page. Normally, this is done using <div> with an id attribute. The following is an example of this:

<div id="react_container"></div>

Copy

Explain
Note that id does not have to be react_container; it just needs to be unique for the page. Then, in the JavaScript code, after defining all your components, they are rendered on the page using the ReactDOM.render function. This takes two arguments: the root React element (not the component) and the HTML element in which it should be rendered.

We would use it like this:

  const container = document.getElementById('react_container');
  const componentElement = React.createElement(HelloWorld, 
      {name: 'Ben'});
  ReactDOM.render(componentElement, container);

Copy

Explain
Note that the HelloWorld component (class/function) itself is not being passed to the render function; it is wrapped in a React.createElement call to instantiate it and transform it into an element.

As you might have guessed from its name, the document.getElementById function locates an HTML element in the document and returns a reference to it.

The final output in the browser when the component is rendered is like this:

<h1>Hello, Ben!</h1>

Copy

Explain
Let’s look at a more advanced example component. Note that since React.createElement is such a commonly used function, it’s common to alias to a shorter name, such as e: that’s what the first line of this example does.

This component displays a button and has an internal state that keeps track of how many times the button was clicked. First, let’s look at the component class in its entirety:

const e = React.createElement;
class ClickCounter extends React.Component {
  constructor(props) {
    super(props);
    this.state = { clickCount: 0 };
  }
  render() {
    return e(
      'button',  // the element name
      {onClick: () => this.setState({ 
       clickCount: this.state.clickCount + 1 }) },//element 
                                                    props
       this.state.clickCount  // element content
    );
  }
}

Copy

Explain
Some things to note about the ClickCounter class are as follows:

The props argument is an object (dictionary) of attribute values that have been passed to the component when it is used in HTML, as shown here:
<ClickCounter foo="bar" rex="baz"/>

Copy

Explain
The props dictionary would contain the foo key with a bar value and the rex key with the baz value.

super(props) calls the super class’s constructor method and passes the props variable. This is analogous to the super() method in Python.
Each React class has a state variable, which is an object. constructor can initialize it. The state should be changed using the setState method rather than being manipulated directly. When it is changed, the render method will be automatically called to redraw the component.
The render method returns a new HTML element using the React.createElement function (remember, the e variable was aliased to this function). In this case, the arguments to React.createElement will return a <button> element with a click handler and with the this.state.clickCount text content. Essentially, it will return an element like this (when clickCount is 0):

<button onClick="this.setState(…)">
  0
</button>

Copy

Explain
The onClick function is set as an anonymous function with arrow syntax. This is similar to having a function as follows (although not quite the same since it’s in a different context):

  const onClick = () => {
      this.setState({clickCount: this.state.clickCount + 1})
  }

Copy

Explain
Since the function is only one line, we can also remove one set of wrapping braces, and we end up with this:

  { onClick: () => this.setState({
      clickCount: this.state.clickCount + 1}) }

Copy

Explain
We covered how to place ClickCounter onto a page earlier in this section, something like this:

  ReactDOM.render(e(ClickCounter),
       document.getElementById ('react_container'));

Copy

Explain
The following screenshot shows the counter in the button when the page loads:

Furthermore, DjDt refers to the debug toolbar that we learned about in the Django Debug Toolbar section in Chapter 15, Django Third-Party Libraries:

Figure 16.6 – Button with 0 for the count
Figure 16.6 – Button with 0 for the count

After clicking the button a few times, the button looks as shown in Figure 16.7:

Figure 16.7 – Button after clicking seven times
Figure 16.7 – Button after clicking seven times

Now, just to demonstrate how not to write the render function, we’ll look at what happens if we just return HTML as a string, like this:

render() {
    return '<button>' + this.state.clickCount + '</button>'
}

Copy

Explain
Now the rendered page looks as shown in Figure 16.8:

Figure 16.8 – Returned HTML rendered as a string
Figure 16.8 – Returned HTML rendered as a string

This shows React’s automatic escaping of HTML in action. Now that we have had a brief intro to JavaScript and React, let’s add an example page to Bookr so you can see it in action.

Exercise 16.01 – setting up a React example
In this exercise, we will create an example view and template to use with React. Then we will implement the ClickCounter component. At the end of the exercise, you will be able to interact with it with the ClickCounter button:

In PyCharm, go to New | File inside the project’s static directory. Name the new file react-example.js.
Putting this code inside it will define the React component, then render it into the react_container <div> that we will be creating:
const e = React.createElement;
class ClickCounter extends React.Component {
  constructor(props) {
    super(props);
    this.state = { clickCount: 0 };
  }
  render() {
    return e(
      'button', { onClick: () => this.setState({ 
          clickCount: this.state.clickCount + 1 
          }) 
      },
      this.state.clickCount
    );
  }
}
ReactDOM.render(e(ClickCounter),
    document.getElementById('react_container'));

Copy

Explain
You can now save react-example.js.

Go to New | HTML File inside the project’s templates directory:
Figure 16.9 – Create a new HTML file
Figure 16.9 – Create a new HTML file

Name the new file react-example.html:
Figure 16.10 – Name the file react-example.html
Figure 16.10 – Name the file react-example.html

You can change the title inside the <title> element to React Example, but that is not necessary for this exercise.

react-example.html is created with some HTML boilerplate as we have seen before. Add the following <script> tags to include React just before the closing </body> tag:
<script crossorigin 
src="https://unpkg.com/react@16/umd/react.development.js">
</script>
<script crossorigin src="https://unpkg.com/
react-dom@16/umd/react-dom.development.js"></script>

Copy

Explain
The react-example.js file will be included using a <script> tag, and we need to generate the script path using the static template tag. First, load the static template library at the start of the file by adding the following on the second line:
{% load static %}

Copy

Explain
The first few lines of your file will look like Figure 16.11:

Figure 16.11 – The load static template tag included
Figure 16.11 – The load static template tag included

Then, just before the closing </body> tag, but after the <script> tags that were added in step 5, add this script tag to include react-example.js:

<script src="{% static 'react-example.js' %}"></script>

Copy

Explain
We now need to add the containing <div> that React will render into. Add this element after the opening <body> tag:
<div id="react_container"></div>

Copy

Explain
You can save react-example.html.

Now we’ll add a view to render the template. Open the reviews app’s views.py file and add a react_example view at the end of the file:
def react_example(request):
    return render(request, "react-example.html")

Copy

Explain
In this simple view, we just render the react-example.html template with no context data.

Finally, we need to map a URL to the new view. Open the bookr package’s urls.py file. Add this map to the urlpatterns variable:
    path('react-example/', 
          reviews.views.react_example)

Copy

Explain
You can save and close urls.py.

Start the Django dev server if it’s not already running, then go to http://127.0.0.1:8000/ react-example/. You should see the ClickCount button rendered as in Figure 16.12:
Figure 16.12 – The ClickCount button
Figure 16.12 – The ClickCount button

Try clicking the button a few times and watch the counter increment.

In this example, we created our first React component, then added a template and view to render it. We included the React framework source from a CDN. In the next section, we will introduce JavaScript XML (JSX), which combines templates and code into a single file that can simplify our code.

JSX – a JavaScript syntax extension
It can be quite verbose to define each element using the React.createElement function – even when we alias to a shorter variable name. The verbosity is exacerbated when we start building larger components.

When using React, we can use JSX to build the HTML elements instead. JSX stands for JavaScript XML since both JavaScript and XML are written in the same file. For example, consider the following code in which we are creating a button using the render method:

return React.createElement('button', { onClick: … }, 
  'Button Text')

Copy

Explain
Instead of this, we can return its HTML directly, as follows:

return <button onClick={…}>Button Text</button>;

Copy

Explain
Note that the HTML is not quoted and returned as a string. That is, we are not doing this:

return '<button onClick={…}>Button Text</button>';

Copy

Explain
Since JSX is an unusual syntax (a combination of HTML and JavaScript in a single file), we need to include another JavaScript library before it can be used: Babel (https://babeljs.io). This is a library that can transpile code between different versions of JavaScript. You can write code using the latest syntax and have it transpiled (a combination of translate and compile) into a version of code that older browsers can understand.

Babel can be included with a <script> tag like this:

  <script crossorigin 
  src="https://unpkg.com/babel-standalone@6/babel. min.js"></script>

Copy

Explain
This should be included on the page after your other React-related script tags but before you include any files containing JSX.

Any JavaScript source code that includes JSX must have the type="text/babel" attribute added:

<script src="path/to/file.js" type="text/babel"></script>

Copy

Explain
This is so Babel knows to parse the file rather than just treat it as plain JavaScript.

Note

Note that using Babel in this way can be slow for large projects. It is designed to be used as part of the build process in an npm project and to have your JSX files transpiled ahead of time (rather than in real time, as we are doing here). The npm project setup is beyond the scope of this book. For our purposes and with the small amount of JSX we are using, using Babel will be fine.

JSX uses braces to include JavaScript data inside HTML, similar to Django’s double braces in templates. JavaScript inside braces will be executed. We’ll now look at how to convert our button creation example to JSX. Our render method can be changed to this:

render() {
    return <button onClick={() =>this.setState({ 
        clickCount: this.state.clickCount + 1 
        })
    }>
    {this.state.clickCount}
</button>;
  }

Copy

Explain
Note that the onClick attribute has no quotes around its value; instead, it is wrapped in braces. This is passing the JavaScript function that is defined inline to the component. It will be available in that component’s props dictionary that is passed to the constructor method. For example, imagine that we had passed it like this:

onClick="() =>this.setState…"

Copy

Explain
In such a case, it would be passed to the component as a string value and thus would not work.

We are also rendering the current value of clickCount as the content of the button. JavaScript could be executed inside these braces too. To show the click count plus one, we could do this:

{this.state.clickCount + 1}

Copy

Explain
In the next exercise, we will include Babel in our template and then convert our component to use JSX.

Exercise 16.02 – JSX and Babel
In this exercise, we will implement JSX in our component to simplify our code. To do this, we need to make a couple of changes to the react-example.js and react-example.html files to switch to JSX to render ClickCounter:

In PyCharm, open react-example.js and change the render method to use JSX instead by replacing it with the following code. You can refer to step 2 from Exercise 16.01 – setting up a React example, where we defined this method:
  render() {
    return <button onClick={() => this.setState({
        clickCount: this.state.clickCount + 1
        })
      }>
      {this.state.clickCount}
    </button>;
  }

Copy

Explain
We can now treat ClickCounter as an element itself. In the ReactDOM.render call at the end of the file, you can replace the first argument, e(ClickCounter), with a <ClickCounter/> element, like this:
ReactDOM.render(<ClickCounter/>,
    document.getElementById('react_container'));

Copy

Explain
Since we’re no longer using the React.create function that we created in step 2 of Exercise 16.01 – setting up a React example, we can remove the alias we created by deleting the first line:
const e = React.createElement;

Copy

Explain
You can save and close the file.

Open the react-example.html template. You need to include the Babel library JavaScript. Add this code between the React script elements and the react-example.js element:
<script crossorigin
src="https://unpkg.com/babelstandalone@6/babel.min.js">
</script>

Copy

Explain
Add a type="text/babel" attribute to the react-example.html <script> tag:
<script src="{% static 'react-example.js' %}" 
type="text/babel"></script>

Copy

Explain
Save react-example.html.

Start the Django dev server if it is not already running and go to http://127.0.0.1:8000/react-example/. You should see the same button as we had before (Figure 16.12). When clicking the button, you should see the count increment as well.
In this exercise, we did not change the behavior of the ClickCounter React component. Instead, we refactored it to use JSX. This makes it easier to write the component’s output directly as HTML and cut down on the amount of code we need to write. In the next section, we will look at passing properties to a JSX React component.

JSX properties
Properties on JSX-based React components are set in the same way as attributes on a standard HTML element. The important thing to remember is whether you are setting them as a string or a JavaScript value.

Let’s look at some examples using the ClickCounter component. Say that we want to extend ClickCounter so that a target number can be specified. When the target is reached, the button should be replaced with the Well done, <name>! text. These values should be passed into ClickCounter as properties.

When using variables, we have to pass them as JSX values:

  let name = 'Ben' 
  let target = 5;
  ReactDOM.render(
    <ClickCounter name={name} target={target}/>,
      document.getElementById('react_container'));

Copy

Explain
We can mix and match the method of passing the values too. This is also valid:

ReactDOM.render(<ClickCounter name="Ben" target={5}/>, 
    document.getElementById('react_container'));

Copy

Explain
In the next exercise, we will update ClickCounter to read these values from properties and change its behavior when the target is reached. We will pass these values in from the Django template.

Exercise 16.03 – React component properties
In this exercise, we will modify ClickCounter to read the values of target and name from its props. We will pass these in from the Django view and use the escapejs filter to make the name value safe for use in a JavaScript string. When you are finished, you will be able to click on the button until it reaches a target, and then see a Well done message. Let’s get started with the steps:

In PyCharm, open the reviews app’s views.py. We will modify the react_example view’s render call to pass through a context containing name and target, like this:
    return render(request, "react-example.html",
                  {"name": "Ben", "target": 5})

Copy

Explain
You can use your own name and pick a different target value if you like. Save views.py.

Open the react-example.js file. We will update the state setting in the constructor method to set the name and target from props, like this:
  constructor(props) {
    super(props);
    this.state = { clickCount: 0, name: props.name,
                   target: props.target};
  }

Copy

Explain
Change the behavior of the render method to return Well done, <name>! once target has been reached. Add this if statement inside the render method:
if (this.state.clickCount === this.state.target) {
    return <span>Well done, {this.state.name}!</span>;
}

Copy

Explain
To pass the values in, move the ReactDOM.render call into the template so that Django can render that piece of code. Cut this ReactDOM.render line from the end of react-example.js:
ReactDOM.render(<ClickCounter/>,
    document.getElementById('react_container'));

Copy

Explain
We will paste it into the template file in step 6. react-example.js should now only contain the ClickCounter class. Save and close the file.

Open react-example.html. After all the existing <script> tags (but before the closing </body> tag), add opening and closing <script> tags with the type="text/babel" attribute. Inside them, we need to assign the Django context values that were passed to the template as JavaScript variables. Altogether, you should be adding this code:
<script type="text/babel">
    let name = "{{ name | escapejs }}";
    let target = {{ target }};
</script>

Copy

Explain
The first assigns the name variable with the name context variable. We use the escapejs template filter; otherwise, we could generate invalid JavaScript code if our name had a double quote in it. The second value, target, is assigned from target. This is a number, so it does not need to be escaped.

Note

Due to the way Django escapes the values for JavaScript, name cannot be passed directly to the component property like this:

<ClickCounter name="{{ name|escapejs }}"/>

The JSX will not unescape the values correctly and you will end up with escape sequences.

However, you could pass the numerical value target in like this:

<ClickCounter target="{ {{ target }} }"/>

Also, be aware of the spacing between the Django braces and JSX braces. In this book, we will first assign all properties to variables, then pass them to the component for consistency.

Underneath these variable declarations, paste in the ReactDOM.render call that you copied from react-example.js. Then, add the target={ target } and name={ name } properties to ClickCounter. Remember, these are the JavaScript variables being passed in, not the Django context variables – they just happen to have the same name. The <script> block should now look like this:
<script type="text/babel">
    let name = "{{ name|escapejs }}";
    let target = {{ target }};
    ReactDOM.render(
      <ClickCounter name={ name } target={ target }/>,
      document.getElementById('react_container'));
</script>

Copy

Explain
You can save react-example.html.

Start the Django dev server if it is not already running, then go to http://127.0.0.1:8000/react-example/. Try clicking the button a few times – it should increment until you click it the target number of times. Then, it will be replaced with the Well done, <name>! text. See Figure 16.13 for how it should look after you’ve clicked it enough times:
Figure 16.13 – The Well done message
Figure 16.13 – The Well done message

In this exercise, we passed data to a React component using props. We escaped the data when assigning it to a JavaScript variable using the escapejs template filter. In the next section, we will cover how to fetch data over HTTP using JavaScript.

Further reading

For a more detailed, hands-on course on React, you can always refer to The React Workshop: https://courses.packtpub.com/courses/react.

JavaScript promises
Many JavaScript functions are implemented asynchronously to prevent blocking on long-running operations. They work by returning immediately but then invoking a callback function when a result is available. The object these types of functions return is a Promise object. Callback functions are provided to the Promise object by calling its then method. When the function finishes running, it will either resolve the Promise (call the success function) or reject it (call the failure function).

We will illustrate the wrong and right ways of using promises. Consider a hypothetical long-running function that performs a big calculation called getResult. Instead of returning the result, it returns Promise. You would not use it like this:

const result = getResult();
console.log(result);  // incorrect, this is a Promise

Copy

Explain
Instead, it should be invoked like this, with a callback function passed to then on the returned Promise. We will assume that getResult can never fail, so we only provide it with a success function for the resolve case:

const promise = getResult();
promise.then((result) => {
    console.log(result);  /* this is called when the 
                             Promise resolves*/
});

Copy

Explain
Normally, you wouldn’t assign the returned Promise to a variable. Instead, you’d chain the then call to the function call. We’ll show this in the next example, along with a failure callback (assume getResult can now fail). We’ll also add some comments illustrating the order in which the code executes:

getResult().then( 
    (result) => {
        // success function
        console.log(result);  
        // this is called 2nd, but only on success
    }, 
    () => {
        // failure function
        console.log("getResult failed");
        // this is called 2nd, but only on failure
    })
// this will be called 1st, before either of the callbacks
console.log("Waiting for callback");

Copy

Explain
Now that we’ve introduced promises, we can look at the fetch function, which makes HTTP requests. It is asynchronous and works by returning promises.

The fetch function
Most browsers (95%) support a function called fetch, which allows you to make HTTP requests. It uses an asynchronous callback interface with promises.

The fetch function takes two arguments. The first is the URL to make the request from, and the second is an object (dictionary) with settings for the request. For example, consider this:

const promise = fetch("http://www.google.com", {…settings});

Copy

Explain
The settings are things such as the following:

method: The request HTTP method (GET, POST, and more).
headers: Another object (dictionary) of HTTP headers to send.
body: The HTTP body to send (for the POST/PUT requests).
credentials: By default, fetch does not send any cookies. This means your requests will act like you are not authenticated. To have it set cookies in its requests, this should be set to the same-origin or include values.
Let’s look at it in action with a simple request:

fetch('/api/books/', {
    method: 'GET',
    headers: {
        Accept: 'application/json'
    }
}).then((resp) => {
    console.log(resp)
})

Copy

Explain
The preceding code will fetch from /api/book-list/, and then call a function that logs the request to the browser’s console using console.log.

Figure 16.14 shows the console output in Firefox for the preceding response:

Figure 16.14 – Response output in the console
Figure 16.14 – Response output in the console

As you can see, the console contains little useful information as it stands. We need to decode the response before we can work with it. We can use the json method on the response object to decode the response body to a JSON object. This also returns Promise, so we will ask to get the JSON, then work with the data in our callback. The full code block to do that looks like this:

  fetch('/api/books/', { 
      method: 'GET', 
      headers: {
          Accept: 'application/json'
      }
  }).then((resp) => {
      return resp.json(); /* doesn't return JSON, returns a 
                             Promise */
  }).then((data) => { 
      console.log(data);
  });

Copy

Explain
This will log the decoded object that was in JSON format to the browser console. In Firefox, the output looks like Figure 16.15:

Figure 16.15 – The decoded book list output to the console
Figure 16.15 – The decoded book list output to the console

In Exercise 16.04 – fetching and rendering books, we will write a new React component that will fetch a list of books and then render each one as a list item (<li>). Before that, we need to learn about the JavaScript map method and how to use it to build HTML in React.

The JavaScript map method
Sometimes, we want to execute the same piece of code (JavaScript or JSX) multiple times for different input data. In this chapter, it will be most useful to generate JSX elements with the same HTML tags but different content. In JavaScript, the map method iterates over the target array and then executes a callback function for each element in the array. Each of these elements is then added to a new array, which is then returned. For example, this short snippet uses map to double each number in the numbers array:

const numbers = [1, 2, 3];
const doubled = numbers.map((n) => {
    return n * 2;
});

Copy

Explain
The doubled array now contains the [2, 4, 6] values.

We can also create a list of JSX values using this method. The only thing to note is that each item in the list must have a unique key property set. In this next short example, we are transforming an array of numbers into <li> elements. We can then use them inside <ul>. Here is an example render function to do this:

render() {
    const numbers = [1, 2, 3];
    const listItems = numbers.map((n) => {
        return <li key={n}>{n}</li>;
        });
    return <ul>{listItems}</ul>
}

Copy

Explain
When rendered, this will generate the following HTML:

<ul>
  <li>1</li>
  <li>2</li>
  <li>3</li>
</ul>

Copy

Explain
In the next exercise, we will build a React component with a button that will fetch the list of books from the API when it is clicked. The list of books will then be displayed.

Exercise 16.04 – fetching and rendering books
In this exercise, we will create a new component named BookDisplay that renders an array of books inside <ul>. The books will be retrieved using fetch. To do this, we add the React component to the react-example.js file. Then we pass the URL of the book list to the component inside the Django template:

In PyCharm, open react-example.js, which you previously used in step 9 of Exercise 16.03 – React component properties. You can delete the entire ClickCounter class.
Create a new class called BookDisplay that uses extends to extend from React.Component.
Then, add a constructor method that takes props as an argument. It should call super(props) and then set its state like this:
  this.state = { books: [], url: props.url,
                 fetchInProgress: false};

Copy

Explain
This will initialize books as an empty array, read the API URL from the passed-in url property, and set a fetchInProgress flag to false. The code of your constructor method should be like this:

constructor(props) {
  super(props);
  this.state = { books: [], url: props.url,
                 fetchInProgress: false };
}

Copy

Explain
Next, add a doFetch method. You can copy and paste this code to create it:
doFetch() {
  if (this.state.fetchInProgress)
      return;
  this.setState({ fetchInProgress: true })
  fetch(this.state.url, {
      method: 'GET',
      headers: {
          Accept: 'application/json'
      }
  }
  ).then((response) => {
      return response.json();
     }).then((data) => {
         this.setState({ fetchInProgress: false, 
                          books: data })
     })
}

Copy

Explain
First, with the if statement, we check whether fetch has already been started. If so, we return from the function. Then, we use setState to update the state, setting fetchInProgress to true. This will both update our button display text and stop multiple requests from being run at once. We then use fetch to fetch this.state.url (which we will pass in through the template later in the exercise). The response is retrieved with the GET method, and we only want to use Accept to accept a JSON response. After we get a response, we then return its JSON using the json method. This returns Promise, so we use another then to handle the callback when the JSON is parsed. In that final callback, we set the state of the component, with fetchInProgress going back to false and the books array being set to the decoded JSON data.

Next, create the render method. You can copy and paste this code too:
render() {
  const bookListItems = this.state.books.map((book) => 
  {
      return <li key={ book.pk }>{ book.title }</li>;
  })
  const buttonText = this.state.fetchInProgress  ? 
      'Fetch in Progress' : 'Fetch';
  return <div>
<ul>{ bookListItems }</ul>
<button onClick={ () =>this.doFetch() } 
  disabled={ this.state.fetchInProgress }>{buttonText}
</button>
</div>;
}

Copy

Explain
This uses the map method to iterate over the array of books in state. We generate <li> for each book, using the book’s pk as the key instance for the list item. The content of <li> is the book’s title. We define a buttonText variable to store (and update) the text that the button will display. If we currently have a fetch operation running, then this will be Fetch in Progress. Otherwise, it will be Fetch. Finally, we return <div> that contains all the data we want. The content of <ul> is the bookListItems variable (the array of <li> instances). It also contains a <button> instance added in a similar way to the previous exercises. The onClick method calls the doFetch method of the class. We can use disabled to make the button disabled (that is, the user can’t click the button) if there is a fetch in progress. We set the button text to the buttonText variable we created earlier. You can now save and close react-example.js.

Open react-example.html. We need to replace the ClickCounter render (from Exercise 16.03 – React component properties) with a BookDisplay render. Delete the name and target variable definitions. We will instead render <BookDisplay>. Set the url property as a string and pass in the URL to the book list API, using the {% url %} template tag to generate it. The ReactDOM.render call should then look like this:
   ReactDOM.render
     (<BookDisplay url="{% url 'api:book- list' %}" />,
       document.getElementById('react_container'));

Copy

Explain
You can now save and close react-example.html.

Start the Django dev server if it’s not already running, then visit http://127.0.0.1:8000/react-example/. You should see a single Fetch button on the page (Figure 16.16):
Figure 16.16 – The book Fetch button
Figure 16.16 – The book Fetch button

After clicking the Fetch button, it should become disabled and have its text changed to Fetch in Progress, as we can see here:

Figure 16.17 – Fetch in Progress
Figure 16.17 – Fetch in Progress

Once the fetch is complete, you should see the list of books rendered as follows:

Figure 16.18 – The book fetch complete
Figure 16.18 – The book fetch complete

This exercise was a chance to integrate React with the Django REST API you built in Chapter 12, Building a REST API. We built a new component (BookDisplay) with a call to fetch to get a list of books. We used the JavaScript map method to transform the book array to some <li> elements. As we had seen before, we used button to trigger fetch when it was clicked. We then provided the book list API URL to the React component in the Django template. Later, we saw a list of books in Bookr that were loaded dynamically using the REST API.

Before we move on to the activity for this chapter, we will talk about some considerations for other JavaScript frameworks when working with Django.

The verbatim template tag
We have seen that when using React, we can use JSX interpolation values in Django templates. This is because JSX uses single braces to interpolate values, and Django uses double braces. It should work fine as long as there are spaces between the JSX and Django braces.

Other frameworks, such as Vue, also use double braces for variable interpolation. What that means is if you had a Vue component’s HTML in your template, you might try to interpolate a value like this:

<h1>Hello, {{ name }}!</h1>

Copy

Explain
Of course, when Django renders the template, it will interpolate the name value before the Vue framework gets a chance to render.

We can use the verbatim template tag to have Django output the data exactly as it appears in the template without performing any rendering or variable interpolation. Using it with the previous example is simple, as shown here:

{% verbatim %}
<h1>Hello, {{ name }}!</h1>
{% endverbatim %}

Copy

Explain
Now when Django renders the template, the HTML between the template tags will be output exactly as it is written, allowing Vue (or another framework) to take over and interpolate the variables itself. Many other frameworks separate their templates into their own files, which should not conflict with Django’s templates.

Many JavaScript frameworks are available, and which one you ultimately decide to use will depend on your own opinion or what your company/team uses. If you do run into conflicts, the solution will depend on your particular framework. The examples in this section should help lead you in the right direction.

We have now covered most things you will need to integrate React (or other JavaScript frameworks) with Django. In the next activity, you will implement these learnings to fetch the most recent reviews on Bookr.

Activity 16.01 – reviews preview
In this activity, we will update the Bookr main page to fetch the six most recent reviews and display them. The user will be able to click buttons to go forward to the next six reviews and then back to the previous ones.

These steps will help you complete the activity:

First, we can clean up some code from previous exercises. If you like, you can take backups of these files to preserve them for later reference. Alternatively, you can use the GitHub versions too, for future reference. Delete the react_example view, the react-example URL, the react-example.html template, and the react-example.js file.
Create a recent-reviews.js static file.
Create two components, a ReviewDisplay component that displays the data for a single review and a RecentReviews component that handles fetching the review data and displaying a list of the ReviewDisplay components.
First, create the ReviewDisplay class. In its constructor, you should read review being passed in through props and assign it to the state.

The render method of ReviewDisplay should return JSX HTML like this:
<div className="col mb-4">
<div className="card">
<div className="card-body">
  <h5 className="card-title">{ BOOK_TITLE }
  <strong>({ REVIEW_RATING })</strong>
  </h5>
  <h6 className="card-subtitle mb-2 text-muted">
    CREATOR_EMAIL</h6>
  <p className="card-text">REVIEW_CONTENT</p>
</div>
<div className="card-footer">
<a href={'/books/' + BOOK_ID` + '/' } className="card-
link">View Book</a>
</div>
</div>
</div>

Copy

Explain
However, you should replace the BOOK_TITLE, REVIEW_RATING, CREATOR_EMAIL, REVIEW_CONTENT, and BOOK_ID placeholders with their proper values from the review that the component has fetched.

Note

Note that when working with JSX and React, class of an element is set with the className attribute, not class. When it’s rendered as HTML, it becomes class.

Create another React component called RecentReviews. Its constructor method should set up state with the following keys/values:
reviews: [] (empty list)
currentUrl: props.url
nextUrl: null
previousUrl: null
loading: false
Implement a method to download the reviews from the REST API. Call it fetchReviews. It should return immediately if state.loading is true. Then, it should set the loading property of state to true.
Implement fetch in the same way as you did in Exercise 16.04 – fetching and rendering books. It should follow the same pattern of requesting state.currentUrl and then getting the JSON data from the response. Then, set the following values in state:
loading: false
reviews: data.results
nextUrl: data.next
previousUrl: data.previous
Implement a componentDidMount method. This is a method that is called when React has loaded the component onto the page. It should call the fetchReviews method.
Create a loadNext method. If nextUrl in state is null, it should return immediately. Otherwise, it should set state.currentUrl to state.nextUrl, then call fetchReviews.
Similarly, create a loadPrevious method; however, this should set state.currentUrl to state.previousUrl.
Implement the render method. If the state is loading, then it should return the Loading… text inside an <h5> element.
Create two variables to store the previousButton and nextButton HTML. They should both have the btn btn-secondary class, and the next button should also have the float-right class. They should have the onClick attributes set to call the loadPrevious or loadNext methods. They should have their disabled attributes set to true if the respective previousUrl or nextUrl attributes are null. The button text should be Previous or Next.
Iterate over the reviews using the map method and store the result in a variable. Each review should be represented by a ReviewDisplay component with the key attribute set to the pk review and review set to the Review class. If there are no reviews (reviews.length === 0), then the variable instead should be an <h5> element with the No reviews to display content.
Finally, return all the content wrapped in the <div> elements, like this:
<div>
<div className="row row-cols-1 row-cols-sm-2 row-cols-
md-3">
    { reviewItems }
</div>
<div>
    {previousButton}
    {nextButton}
</div>
</div>

Copy

Explain
The className we are using here will display each review preview in one, two, or three columns depending on the screen size.

Next, edit base.html. You will add all the new content inside the content block so that it will not be displayed on the non-main pages that override this block. Add an <h4> element with the Recent Reviews content.
Add a <div> element for React to render into. Make sure you give it a unique id.
Include the <script> tags to include React, React DOM, Babel, and the recent-reviews.js file. These four tags should be similar to what you had in Exercise 16.04 – fetching and rendering books.
The last thing to add is another <script> tag containing the ReactDOM.render call code. The root component being rendered is RecentReviews. It should have a url attribute set to the url="{% url value 'api:review-list' %}?limit=6". This does a URL lookup for ReviewViewSet and then appends a page size argument of 6, limiting the number of reviews that are retrieved to a maximum of 6.
Once you have completed these steps, you should be able to navigate to http://127.0.0.1:8000/ (the main Bookr page) and see a page like this:

Figure 16.19 – Completed reviews preview
Figure 16.19 – Completed reviews preview

In the screenshot, the page has been scrolled to show the Previous/Next buttons. Notice the Previous button is disabled because we are on the first page.

If you click Next, you should see the next page of reviews. If you click Next enough times (depending on how many reviews you have), you will eventually reach the last page, and then the Next button will be disabled:

Figure 16.20 – The Next button is disabled
Figure 16.20 – The Next button is disabled

If you have no reviews, then you should see the No reviews to display message:

Figure 16.21 – The No reviews to display text
Figure 16.21 – The No reviews to display text

While the page is loading the reviews, you should see the Loading… text; however, it will probably only display for a split second since the data is being loaded from your own computer:

Figure 16.22 – The Loading… text
Figure 16.22 – The Loading… text

Note

The solution for this activity can be found on https://github.com/PacktPublishing/Web-Development-with-Django-Second-Edition/tree/main/ActivitySolutions.

Summary
In this chapter, we introduced JavaScript frameworks and described how they work with Django to enhance templates and add interactivity. We introduced the JavaScript language and covered some of its main features, variable types, and classes. We then introduced the concepts behind React and how it builds HTML by using components. We built a React component using just JavaScript and the React.createElement function. After that, we introduced JSX and saw how it made the development of components easier by letting you directly write HTML in your React components. The concepts of promises and the fetch function were introduced, and we saw how to get data from a REST API using fetch. The chapter finished with an exercise that retrieved reviews from Bookr using the REST API and rendered them to the page in an interactive component.

In the next chapter, we will look at how to deploy our Django project to a production web server.



| ≪ [ 15 Django Third-Party Libraries ](/packtpub/2024/422-web_development_with_django_2ed/15_django_third-party_libraries) | 16 Using a Frontend JavaScript Library with Django | [ 17 Index ](/packtpub/2024/422-web_development_with_django_2ed/17_index) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422-web_development_with_django_2ed/16_using_a_frontend_javascript_library_with_django
> (2) Markdown
> (3) Title: 16 Using a Frontend JavaScript Library with Django
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Title: 422-Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-05-08 수 14:11:53
> Images: /packtpub/2024/422-web_development_with_django_2ed_img/16/
> .md Name: 16_using_a_frontend_javascript_library_with_django.md

