
| ≪ [ 207 Setting Up the Environment and Tools ](/books/packtpub/2024/1202-Spring_Boot_3_React/207_Setting_Up_the_Environment_and_Tools) | 208 Getting Started with React | [ 209 Introduction to TypeScript ](/books/packtpub/2024/1202-Spring_Boot_3_React/209_Introduction_to_TypeScript) ≫ |
|:----:|:----:|:----:|

# 208 Getting Started with React
a
This chapter describes the basics of React programming. We will cover the skills that are required to create basic functionalities for our React frontend. In JavaScript, ­we use the ECMAScript 2015 (ES6) syntax because it provides many features that make coding cleaner.

In this chapter, we will look at the following topics:

Creating React components
Useful ES6 features
JSX and styling
Props and state
Conditional rendering
React hooks
The Context API
Handling lists, events, and forms with React
Technical requirements
For our work, React version 18 or higher will be required. We set up our environment correctly in Chapter 7.

You can find more resources at the GitHub link for this chapter: https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter08.

Creating React components
React is a JavaScript library for user interfaces (UIs). Since version 15, React has been developed under the MIT license. React is component-based, and the components are independent and reusable. Components are the basic building blocks of React. When you start to develop a UI with React, it is good to start by creating mock interfaces. That way, it will be easy to identify what kinds of components you have to create and how they interact.

From the following mock UI, we can see how the UI can be split into components. In this case, there will be an application root component, a search bar component, a table component, and a table row component:


Figure 8.1: React components

The components can then be arranged in a tree hierarchy, as shown in the following screenshot:

Figure 7.2 – Component tree 
Figure 8.2: Component tree

The root component has two child components: the search component and the table component. The table component has one child component: the table row component. The important thing to understand with React is that the data flow goes from a parent component to a child component. We will learn later how data can be passed from a parent component to a child component using props.

React uses the virtual document object model (VDOM) for selective re-rendering of the UI, which makes it more cost-effective. The document object model (DOM) is a programming interface for web documents that represents the web page as a structured tree of objects. Each object in a tree corresponds to a part of the document. Using the DOM, programmers can create documents, navigate their structure, and add, modify, or delete elements and content. The VDOM is a lightweight copy of the DOM, and manipulation of the VDOM is much faster than it is with the real DOM. After the VDOM is updated, React compares it to a snapshot that was taken of the VDOM before updates were run. After the comparison, React will know which parts have been changed, and only these parts will be updated to the real DOM.

A React component can be defined either by using a JavaScript function – a functional component – or the ES6 JavaScript class – a class component. We will go more deeply into ES6 in the next section.

Here is some simple component source code that renders the Hello World text. This first code block uses a JavaScript function:

// Using JavaScript function
function App() {
  return <h1>Hello World</h1>;
}

Copy

Explain
The mandatory return statement in the React function component defines what the component looks like.

Alternatively, the following code uses the ES6 class to create a component:

// Using ES6 class
class App extends React.Component {
  render() {
    return <h1>Hello World</h1>;
  }
}

Copy

Explain
The class component contains the required render() method, which shows and updates the rendered output of the component. If you compare the functional and class App components, you can see that the render() method is not needed in the functional component. Before React version 16.8, you had to use class components to be able to use states. Now, you can use hooks to create states with functional components as well. We will learn about states and hooks later in this chapter.

In this book, we will create components using functions, which means we have to write less code. Functional components are a modern way to write React components, and we recommend avoiding using classes.

The name of the React component should start with a capital letter. It is also recommended to use the PascalCase naming convention, whereby each word starts with a capital letter.

Imagine we are making changes to our example component’s return statement and adding a new <h2> element to it, as follows:

function App() {
  return (
    <h1>Hello World</h1>
    <h2>This is my first React component</h2>
  );
}

Copy

Explain
Now, if the app is run, we will see an Adjacent JSX elements must be wrapped in an enclosing tag error, as indicated in the following screenshot:


Figure 8.3: Adjacent JSX elements error

If your component returns multiple elements, you have to wrap these inside one parent element. To fix this error, we have to wrap the header elements in one element, such as a div, as illustrated in the following code snippet:

// Wrap elements inside the div
function App() {
  return (
    <div>
      <h1>Hello World</h1>
      <h2>This is my first React component</h2>
    </div>
  );
}

Copy

Explain
We can also use a React fragment, as shown in the following code snippet. Fragments don’t add any extra nodes to the DOM tree:

// Using fragments
function App() {
  return (
    <React.Fragment>
      <h1>Hello World</h1>
      <h2>This is my first React component</h2>
    </React.Fragment>
  );
}

Copy

Explain
There is also shorter syntax for fragments, which looks like empty JSX tags. This is shown in the following code snippet:

// Using fragments short syntax
function App() {
  return (
    <>
      <h1>Hello World</h1>
      <h2>This is my first React component</h2>
    </>
  );
}

Copy

Explain
Examining our first React app
Let’s look more carefully at the first React app we created in Chapter 7, Setting Up the Environment and Tools – Frontend, using Vite.

The source code of the main.jsx file in the root folder looks like this:

import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './index.css'
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)

Copy

Explain
At the beginning of the file, there are import statements that load components and assets to our file. For example, the second line imports the react-dom package from the node_modules folder, and the third line imports the App component (the App.jsx file in the src folder). The fourth line imports the index.css style sheet that is in the same folder as the main.jsx file.

The react-dom package provides DOM-specific methods for us. To render the React component to the DOM, we can use the render method from the react-dom package. React.StrictMode is used to find potential problems in your React app and these are printed in the browser console. Strict Mode only runs in development mode and renders your components extra time, so it has time to find bugs.

The root API is used to render React components inside a browser DOM node. In the following example, we first create a root by passing the DOM element to the createRoot method. The root calls the render method to render an element to the root:

import ReactDOM from 'react-dom/client';
import App from './App';
const container = document.getElementById('root');
// Create a root
const root = ReactDOM.createRoot(container);
// Render an element to the root
root.render(<App />);

Copy

Explain
The container in the root API is the <div id="root"></div> element, which can be found in the index.html file inside the project root folder. Look at the following index.html file:

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Vite + React</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.jsx"></script>
  </body>
</html>

Copy

Explain
The following source code shows the App.jsx component from our first React app. You can see that import also applies to assets, such as images and style sheets. At the end of the source code, there is an export default statement that exports the component, and it can be made available to other components by using the import statement:

import { useState } from 'react'
import reactLogo from './assets/react.svg'
import viteLogo from '/vite.svg'
import './App.css'
function App() {
  const [count, setCount] = useState(0)
  return (
    <div className="App">
      <div>
        <a href="https://vitejs.dev" target="_blank">
          <img src={viteLogo} className="logo" alt="Vite logo" />
        </a>
        <a href="https://reactjs.org" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      <h1>Hello React</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
        <p>
          Edit <code>src/App.jsx</code> and save to test HMR
        </p>
      </div>
      <p className="read-the-docs">
        Click on the Vite and React logos to learn more
      </p>
    </div>
  )
}
export default App

Copy

Explain
You can see that in the App component that Vite has created, we don’t have semicolons at the end of statements. It is optional in JavaScript but, in this book, we will use semicolons to terminate statements when we start to create our own React components.

There can only be one export default statement per file, but there can be multiple named export statements. Default exports are commonly used to export React components. Named exports are commonly used to export specific functions or objects from a module.

The following example shows how to import default and named exports:

import React from 'react' // Import default value
import { name } from … //  Import named value

Copy

Explain
The exports look like this:

export default React // Default export
export { name }  //  Named export

Copy

Explain
Now that we have covered the basics of React components, let’s take a look at the basic features of ES6.

Useful ES6 features
ES6 was released in 2015, and it introduced a lot of new features. ECMAScript is a standardized scripting language, and JavaScript is one implementation of it. In this section, we will go through the most important features released in ES6 that we will be using in the following sections.

Constants and variables
Constants, or immutable variables, can be defined by using a const keyword, as shown in the following code snippet. When using the const keyword, the variable content cannot be reassigned:

const PI = 3.14159;

Copy

Explain
Now, you will get an error if you try to reassign the PI value, as indicated in the following screenshot:

Figure 7.4 – Assignment to constant variable 
Figure 8.4: Assignment to constant variable

The const is block-scoped. This means that the const variable can only be used inside the block in which it is defined. In practice, the block is the area between curly brackets {}. If const is defined outside of any function or block, it becomes a global variable, and you should try to avoid this situation. Global variables make code harder to understand, maintain, and debug. The following sample code shows how the scope works:

let count = 10;
if (count > 5) {
  const total = count * 2;
  console.log(total); // Prints 20 to console
}
console.log(total); // Error, outside the scope

Copy

Explain
The second console.log statement gives an error because we are trying to use the total variable outside its scope.

The following example demonstrates what happens when const is an object or array:

const myObj = {foo:  3};
myObj.foo = 5; // This is ok

Copy

Explain
When const is an object or array, its properties or elements can be updated.

The let keyword allows you to declare mutable block-scoped variables. The variable declared using let can be used inside the block in which it is declared (it can also be used inside sub-blocks).

Arrow functions
The traditional way of defining a function in JavaScript is by using a function keyword. The following function takes one argument and returns the argument value multiplied by 2:

function(x) {
  return x * 2;
}

Copy

Explain
When we use the ES6 arrow function, the function looks like this:

x => x * 2

Copy

Explain
As we can see, by using the arrow function, we have made the declaration of the same function more compact. The function is a so-called anonymous function, and we can’t call it. Anonymous functions are often used as an argument for other functions. In JavaScript, functions are first-class citizens and you can store functions in variables, as illustrated here:

const calc = x => x * 2

Copy

Explain
Now, you can use the variable name to call the function, like this:

calc(5); // returns 10

Copy

Explain
When you have more than one argument, you have to wrap the arguments in parentheses and separate the arguments with a comma to use the arrow function effectively. For example, the following function takes two parameters and returns their sum:

const calcSum = (x, y) => x + y
// function call
calcSum(2, 3); // returns 5

Copy

Explain
If the function body is an expression, then you don’t need to use the return keyword. The expression is always implicitly returned from the function. When you have multiple lines in the function body, you have to use curly brackets and a return statement, as follows:

const calcSum = (x, y) => {
  console.log('Calculating sum');
  return x + y;
}

Copy

Explain
If the function doesn’t have any arguments, then you should use empty parentheses, like so:

const sayHello = () => "Hello"

Copy

Explain
We are going to use lots of arrow functions later in our frontend implementation.

Template literals
Template literals can be used to concatenate strings. The traditional way to concatenate strings is to use the + operator, as follows:

let person = {firstName: 'John', lastName: 'Johnson'};
let greeting = "Hello " + ${person.firstName} + " " + ${person.lastName};

Copy

Explain
With template literals, the syntax looks like this. You have to use backticks (``) instead of single or double quotes:

let person = {firstName: 'John', lastName: 'Johnson'};
let greeting = `Hello ${person.firstName} ${person.lastName}`;

Copy

Explain
Next, we will learn how to use object destructuring.

Object destructuring
The object destructuring feature allows you to extract values from an object and assign them to a variable. You can use a single statement to assign multiple properties of an object to individual variables. For example, if you have this object:

const person = {
  firstName: 'John',
  lastName: 'Johnson',
  email: 'j.johnson@mail.com'
};

Copy

Explain
You can destructure it using the following statement:

const { firstName, lastName, email } = person;

Copy

Explain
It creates three variables, firstName, lastName, and email, which get their values from the person object.

Without object destructuring, you have to access each property individually, as shown in the following code snippet:

const firstName = person.firstName;
const lastName = person.lastName;
const email = person.email;

Copy

Explain
Next, we will learn how to create classes using JavaScript ES6 syntax.

Classes and inheritance
Class definition in ES6 is similar to other object-oriented languages such as Java or C#. We saw an ES6 class when we looked at how to create React class components earlier. But, as we said earlier, classes are no longer recommended for creating React components.

The keyword for defining classes is class. A class can have fields, constructors, and class methods. The following sample code shows an ES6 class:

class Person {
  constructor(firstName, lastName) {
    this.firstName = firstName;
    this.lastName = lastName;
  }
}

Copy

Explain
Inheritance is performed with an extends keyword. The following sample code shows an Employee class that inherits a Person class. This means that it inherits all fields from the parent class and can have its own fields that are specific to Employee. In the constructor, we first call the parent class constructor by using the super keyword. That call is required by the rest of the code, and you will get an error if it is missing:

class Employee extends Person {
  constructor(firstName, lastName, title, salary) {
    super(firstName, lastName);
    this.title = title;
    this.salary = salary;
  }
}

Copy

Explain
Although ES6 is already quite old, some of its features are still only partially supported by modern web browsers. Babel is a JavaScript compiler that is used to compile ES6 (or newer versions) to an older version that is compatible with all browsers. You can test the compiler on the Babel website (https://babeljs.io). The following screenshot shows the arrow function compiling back to the older JavaScript syntax:

Figure 7.5 – Babel 
Figure 8.5: Babel

Now that we have learned about the basics of ES6, let’s take a look at what JSX and styling are all about.

JSX and styling
JavaScript XML (JSX) is the syntax extension for JavaScript. It is not mandatory to use JSX with React, but there are some benefits that make development easier. For example, JSX prevents injection attacks because all values are escaped in JSX before they are rendered. The most useful feature is that you can embed JavaScript expressions in JSX by wrapping them with curly brackets; this technique will be used a lot in the following chapters. JSX is compiled into regular JavaScript by Babel.

In the following example, we can access a component’s props when using JSX:

function App(props) {
  return <h1>Hello World {props.user}</h1>;
}

Copy

Explain
Component props are covered in the next section.

You can also pass a JavaScript expression as props, as shown in the following code snippet:

<Hello count={2+2} />

Copy

Explain
You can use both inline and external styling with React JSX elements. Here are two examples of inline styling. This first one defines the style inside the div element:

<div style={{ height: 20, width: 200 }}>
  Hello
</div>

Copy

Explain
The second example creates a style object first, which is then used in the div element. The object name should use the camelCase naming convention:

const divStyle = { color: 'red', height: 30 };
const MyComponent = () => (
  <div style={divStyle}>Hello</div>
);

Copy

Explain
As shown in a previous section, you can import a style sheet into a React component. To reference classes from an external CSS file, you should use a className attribute, as shown in the following code snippet:

import './App.js';
...
<div className="App-header"> This is my app</div>

Copy

Explain
In the next section, we will learn about React props and state.

Props and state
Props and state are the input data for rendering a component. The component is re-rendered when the props or state change.

Props
Props are inputs to components, and they are a mechanism to pass data from a parent component to its child component. Props are JavaScript objects, so they can contain multiple key-value pairs.

Props are immutable, so a component cannot change its props. Props are received from the parent component. A component can access props through the props object that is passed to the function component as a parameter. For example, let’s take a look at the following component:

function Hello() {
  return <h1>Hello John</h1>;
}

Copy

Explain
The component just renders a static message, and it is not reusable. Instead of using a hardcoded name, we can pass a name to the Hello component by using props, like this:

function Hello(props) {
  return <h1>Hello {props.user}</h1>;
}

Copy

Explain
The parent component can send props to the Hello component in the following way:

<Hello user="John" />

Copy

Explain
Now, when the Hello component is rendered, it shows the Hello John text.

You can also pass multiple props to a component, as shown here:

<Hello firstName="John" lastName="Johnson" />

Copy

Explain
Now, you can access both props in the component using the props object, as follows:

function Hello(props) {
  return <h1>Hello {props.firstName} {props.lastName}</h1>;
}

Copy

Explain
Now, the component output is Hello John Johnson.

You can also use object destructuring to destructure a props object in the following way:

function Hello({ firstName, lastName }) {
  return <h1>Hello {firstName} {lastName}</h1>;
}

Copy

Explain
State
In React, the component state is an internal data store that holds information that can change over time. The state also affects the rendering of the component. When the state is updated, React schedules a re-render of the component. When the component re-renders, the state retains its latest values. State allows components to be dynamic and responsive to user interactions or other events.

It’s generally a good practice to avoid introducing unnecessary states in your React components. Unnecessary states increase the complexity of your components and can cause unwanted side effects. Sometimes, a local variable can be a better option. But you have to understand that changes to local variables won’t trigger re-rendering. Each time a component re-renders, local variables are reinitialized, and their values don’t persist between renders.

The state is created using the useState hook function. It takes one argument, which is the initial value of the state, and returns an array of two elements. The first element is the name of the state, and the second element is a function that is used to update the state value. The syntax of the useState function is shown in the following code snippet:

const [state, setState] = React.useState(initialValue);

Copy

Explain
The next code example creates a state variable called name, and the initial value is Jim:

const [name, setName] = React.useState('Jim');

Copy

Explain
You can also import the useState function from React, like so:

import React, { useState } from 'react';

Copy

Explain
Then, you don’t need to type the React keyword, as indicated here:

const [name, setName] = useState('Jim');

Copy

Explain
The value of the state can now be updated by using the setName function, as illustrated in the following code snippet. This is the only way to modify the state value:

// Update name state value
setName('John');

Copy

Explain
You should never update the state value directly using the = operator. If you update the state directly, as shown next, React won’t re-render the component and you will also get an error because you cannot reassign the const variable:

// Don't do this, UI won't re-render
name = 'John';

Copy

Explain
If you have multiple states, you can call the useState function multiple times, as shown in the following code snippet:

// Create two states: firstName and lastName
const [firstName, setFirstName] = useState('John');
const [lastName, setLastName] = useState('Johnson');

Copy

Explain
Now, you can update states using the setFirstName and setLastName functions, as shown in the following code snippet:

// Update state values
setFirstName('Jim');
setLastName('Palmer');

Copy

Explain
You can also define state using an object, as follows:

const [name, setName] = useState({
  firstName: 'John',  
  lastName: 'Johnson'
});

Copy

Explain
Now, you can update both the firstName and lastName state object parameters using the setName function, as follows:

setName({ firstName: 'Jim', lastName: 'Palmer' })

Copy

Explain
If you want to do a partial update of the object, you can use the spread operator. In the following example, we use the object spread syntax (...) that was introduced in ES2018. It clones the name state object and updates the firstName value to be Jim:

setName({ ...name, firstName: 'Jim' })

Copy

Explain
A state can be accessed by using the state name, as shown in the next example. The scope of the state is the component, so it cannot be used outside the component in which it is defined:

// Renders Hello John
import React, { useState } from 'react';
function MyComponent() {
  const [firstName, setFirstName] = useState('John');
  return <div>Hello {firstName}</div>;
}

Copy

Explain
If your state is an object, then you can access it in the following way:

const [name, setName] = useState({
  firstName: 'John',  
  lastName: 'Johnson'
});
return <div>Hello {name.firstName}</div>;

Copy

Explain
We have now learned the basics of state and props, and we will learn more about states later in this chapter.

Stateless components
The React stateless component is just a pure JavaScript function that takes props as an argument and returns a React element. Here’s an example of a stateless component:

function HeaderText(props) {
  return (
    <h1>
      {props.text}
    </h1>
  )
}
export default HeaderText;

Copy

Explain
Our HeaderText example component is also called a pure component. A component is said to be pure if its return value is consistently the same given the same input values. React provides React.memo(), which optimizes the performance of pure functional components. In the following code snippet, we wrap our component using memo():

import React, { memo } from 'react';
function HeaderText(props) {
  return (
    <h1>
      {props.text}
    </h1>
  )
}
export default memo(HeaderText);

Copy

Explain
Now, the component is rendered and memoized. In the next render, React renders a memoized result if the props are not changed. The React.memo() phrase also has a second argument, arePropsEqual(), which you can use to customize rendering conditions, but we will not cover that here. The one benefit of using functional components is unit testing, which is straightforward because their return values are always the same for the same input values.

Conditional rendering
You can use a conditional statement to render different UIs if a condition is true or false. This feature can be used, for example, to show or hide some elements, handle authentication, and so on.

In the following example, we will check if props.isLoggedin is true. If so, we will render the <Logout /> component; otherwise, we render the <Login /> component. This is now implemented using two separate return statements:

function MyComponent(props) {
  const isLoggedin = props.isLoggedin;
  if (isLoggedin) {
    return (
      <Logout />
    )
  }
  return (
    <Login />
  )
}

Copy

Explain
You can also implement this by using condition ? true : false logical operators, and then you need only one return statement, as illustrated here:

function MyComponent(props) {
  const isLoggedin = props.isLoggedin;
  return (
    <>
      { isLoggedin ? <Logout /> : <Login /> }
    </>
  );
}

Copy

Explain
React hooks
Hooks were introduced in React version 16.8. Hooks allow you to use state and some other React features in functional components. Before hooks, you had to write class components if states or complex component logic were needed.

There are certain important rules for using hooks in React. You should always call hooks at the top level in your React function component. You shouldn’t call hooks inside loops, conditional statements, or nested functions. Hook names begin with the word use, followed by the purpose they serve.

useState
We are already familiar with the useState hook function that is used to declare states. Let’s look at one more example of using the useState hook. We will create an example counter that contains a button, and when it is pressed, the counter is increased by 1, as illustrated in the following screenshot:


Figure 8.6: Counter component

First, we create a Counter component and declare a state called count with the initial value 0. The value of the counter state can be updated using the setCount function. The code is illustrated in the following snippet:
import { useState } from 'react';
function Counter() {
  // count state with initial value 0
  const [count, setCount] = useState(0);
  return <div></div>;
};
export default Counter;

Copy

Explain
Next, we render a button element that increments the state by 1. We use the onClick event attribute to call the setCount function, and the new value is the current value plus 1. We will also render the counter state value. The code is illustrated in the following snippet:
import { useState }  from 'react';
function Counter() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <p>Counter = {count}</p>
      <button onClick={() => setCount(count + 1)}>
        Increment
      </button>
    </div>
  );
};
export default Counter;

Copy

Explain
Now, our Counter component is ready, and the counter is incremented by 1 each time the button is pressed. When the state is updated, React re-renders the component and we can see the new count value.
In React, events are named using camelCase, for example, onClick.

Note that the function must be passed to an event handler, and then React will call the function only when the user clicks the button. We use an arrow function in the following example because it is more compact to write and improves code readability. If you call the function in the event handler, then the function is called when the component is rendered, which can cause an infinite loop:

// Correct -> Function is called when button is pressed
<button onClick={() => setCount(count + 1)}>
// Wrong -> Function is called in render -> Infinite loop
<button onClick={setCount(count + 1)}>

Copy

Explain
State updates are asynchronous, so you have to be careful when a new state value depends on the current state value. To be sure that the latest value is used, you can pass a function to the update function. You can see an example of this here:

setCount(prevCount => prevCount + 1)

Copy

Explain
Now, the previous value is passed to the function, and the updated value is returned and saved to the count state.

There is also a hook function called useReducer that is recommended when you have a complex state, but we won’t cover that in this book.

Batching
React uses batching in state updates to reduce re-renders. Before React version 18, batching only worked in states updated during browser events – for example, a button click. The following example demonstrates the idea of batch updates:

import { useState } from 'react';
function App() {
  const [count, setCount] = useState(0);
  const [count2, setCount2] = useState(0);
  const increment = () => {
    setCount(count + 1); // No re-rendering yet
    setCount2(count2 + 1);
    // Component re-renders after all state updates
  }
  return (
    <>
      <p>Counters: {count} {count2}</p>
      <button onClick={increment}>Increment</button>
    </>
  );
};
export default App;

Copy

Explain
From React version 18 onward, all state updates will be batched. If you don’t want to use batch updates in some cases, you can use the react-dom library’s flushSync API to avoid batching. For example, you might have a case where you want to update some state before updating the next one. It can be useful when incorporating third-party code, such as browser APIs.

Here’s the code you’d need to do this:

import { flushSync } from "react-dom";
const increment = () => {
  flushSync( () => {
    setCount(count + 1); // No batch update
  });
}

Copy

Explain
You should use flushSync only if it is needed, because it can affect the performance of your React app.

useEffect
The useEffect hook function can be used to perform side effects in the React function component. The side effect can be, for example, a fetch request. The useEffect hook takes two arguments, as shown here:

useEffect(callback, [dependencies])

Copy

Explain
The callback function contains side-effect logic, and [dependencies] is an optional array of dependencies.

The following code snippet shows the previous counter example, but we have added the useEffect hook. Now, when the button is pressed, the count state value increases, and the component is re-rendered. After each render, the useEffect callback function is invoked and we can see Hello from useEffect in the console, as illustrated in the following code snippet:

import { useState, useEffect } from 'react';
function Counter() {
  const [count, setCount] = useState(0);
  // Called after every render
  useEffect(() => {
    console.log('Hello from useEffect')
  });
  return (
    <>
      <p>{count}</p>
      <button onClick={() => setCount(count + 1)}>Increment
      </button>
    </>
  );
};
export default Counter;

Copy

Explain
In the following screenshot, we can see what the console now looks like, and we can see that the useEffect callback is invoked after each render. The first log row is printed after the initial render, and the rest are printed after the button is pressed two times and the component is re-rendered due to state updates:


Figure 8.7: useEffect

The useEffect hook has a second optional argument (a dependency array) that you can use to prevent it from running in every render. In the following code snippet, we define that if the count state value is changed (meaning that the previous and current values differ), the useEffect callback function will be invoked. We can also define multiple states in the second argument. If any of these state values are changed, the useEffect hook will be invoked:

// Runs when count value is changed and component is re-rendered
useEffect(() => {
  console.log('Counter value is now ' + count);
}, [count]);

Copy

Explain
If you pass an empty array as the second argument, the useEffect callback function runs only after the first render, as shown in the following code snippet:

// Runs only after the first render
useEffect(() => {
  console.log('Hello from useEffect')
}, []);

Copy

Explain
Now, you can see that Hello from useEffect is printed only once after the initial render, and if you press the button, the text is not printed. The message is printed twice after the first render due to React Strict Mode. Strict Mode renders your component twice in development mode to find bugs and does not impact the production build:


Figure 8.8: useEffect with an empty array

The useEffect function can also return a cleanup function that will run before every effect, as shown in the following code snippet. With this mechanism, you can clean up each effect from the previous render before running the effect next time. It is useful when you are setting up subscriptions, timers, or any resource that needs to be cleaned up to prevent unexpected behavior. The cleanup function is also executed after your component is removed from the page (or unmounted):

useEffect(() => {
  console.log('Hello from useEffect');
  return () => {
    console.log('Clean up function');
  });
}, [count]);

Copy

Explain
If you run the counter app with these changes, you can see what happens in the console, as shown in the following screenshot. The component is rendered twice at the beginning due to Strict Mode. After the initial render, the component is unmounted (removed from the DOM), and therefore, the cleanup function is called:


Figure 8.9: Cleanup function

useRef
The useRef hook returns a mutable ref object that can be used, for example, to access DOM nodes. You can see it in action here:

const ref = useRef(initialValue)

Copy

Explain
The ref object returned has a current property that is initialized with the argument passed (initialValue). In the next example, we create a ref object called inputRef and initialize it to null. Then, we use the JSX element’s ref property and pass our ref object to it. Now, it contains our input element, and we can use the current property to execute the input element’s focus function. Now, when the button is pressed, the input element is focused:

import { useRef } from 'react';
import './App.css';
function App() {
  const inputRef = useRef(null);
  return (
    <>
      <input ref={inputRef} />
      <button onClick={() => inputRef.current.focus()}>
        Focus input
      </button>
    </>
  );
}
export default App;

Copy

Explain
In this section, we have learned the basics of React hooks, and we will use them in practice when we start to implement our frontend. There are other useful hook functions available in React, and next you will learn how to create your own hooks.

Custom hooks
You can build your own hooks in React. As we have seen already, hooks’ names should start with the use word, and they are JavaScript functions. Custom hooks can also call other hooks. With custom hooks, you can reduce your component code complexity.

Let’s go through a simple example of creating a custom hook:

We will create a useTitle hook that can be used to update a document title. We will define it in its own file called useTitle.js. First, we define a function, and it gets one argument named title. The code is illustrated in the following snippet:
// useTitle.js
function useTitle(title) {
}

Copy

Explain
Next, we will use a useEffect hook to update the document title each time the title argument is changed, as follows:
import { useEffect } from 'react';
function useTitle(title) {
  useEffect(() => {
    document.title = title;
  }, [title]);
}
export default useTitle;

Copy

Explain
Now, we can start to use our custom hook. Let’s use it in our counter example and print the current counter value into the document title. First, we have to import the useTitle hook into our Counter component, like this:
import useTitle from './useTitle';
function Counter() {
  return (
    <>
    </>
  );
};
export default Counter;

Copy

Explain
Then, we will use the useTitle hook to print the count state value into the document title. We can call our hook function in the top level of the Counter component function, and every time the component is rendered, the useTitle hook function is called and we can see the current count value in the document title. The code is illustrated in the following snippet:
import React, { useState } from 'react';
import useTitle from './useTitle';
function App() {
  const [count, setCount] = useState(0);
  useTitle(`You clicked ${count} times`);
  return (
    <>
      <p>Counter = {count}</p>
      <button onClick={ () => setCount(count + 1) }>
        Increment
      </button>
    </>
  );
};
export default App;

Copy

Explain
Now, if you click the button, the count state value is also shown in the document title using our custom hook, as illustrated in the following screenshot:

Figure 8.10: Custom hook

You now have basic knowledge of React hooks and how you can create your own custom hooks.

The Context API
Passing data using props can be cumbersome if your component tree is deep and complex. You have to pass data through all components down the component tree. The Context API solves this problem, and it is recommended for use with global data that you might need in multiple components throughout your component tree – for example, a theme or authenticated user.

Context is created using the createContext method, which takes an argument that defines the default value. You can create your own file for the context, and the code looks like this:

import React from 'react';
const AuthContext = React.createContext('');
export default AuthContext;

Copy

Explain
Next, we will use a context provider component, which makes our context available for other components. The context provider component has a value prop that will be passed to consuming components. In the following example, we have wrapped <MyComponent /> using the context provider component, so the userName value is available in our component tree under <MyComponent />:

import React from 'react';
import AuthContext from './AuthContext';
import MyComponent from './MyComponent';
function App() {
  // User is authenticated and we get the username
  const userName = 'john';
  return (
    <AuthContext.Provider value={userName}>
      <MyComponent />
    </AuthContext.Provider>
  );
};
export default App;

Copy

Explain
Now, we can access the value provided in any component in the component tree by using the useContext() hook, as follows:

import React from 'react';
import AuthContext from './AuthContext';
function MyComponent() {
  const authContext = React.useContext(AuthContext);
  return(
    <>
      Welcome {authContext}
    </>
  );
}
export default MyComponent;

Copy

Explain
The component now renders the Welcome john text.

Handling lists with React
For list handling, we will learn about the JavaScript map() method, which is useful when you have to manipulate a list. The map() method creates a new array containing the results of calling a function on each element in the original array. In the following example, each array element is multiplied by 2:

const arr = [1, 2, 3, 4];
const resArr = arr.map(x => x * 2); // resArr = [2, 4, 6, 8]

Copy

Explain
The following example code demonstrates a component that transforms an array of integers into an array of list items and renders these inside the ul element:

import React from 'react';
function MyList() {
  const data = [1, 2, 3, 4, 5];
  
  return (
    <>
      <ul>
        {
        data.map((number) =>
          <li>Listitem {number}</li>)
        }
      </ul>
    </>
  );
};
export default MyList;

Copy

Explain
The following screenshot shows what the component looks like when it is rendered. If you open the console, you can see a warning (Each child in a list should have a unique "key" prop):


Figure 8.11: React list component

List items in React need a unique key that is used to detect rows that have been updated, added, or deleted. The map() method also has index as a second argument, which we use to handle the warning:

function MyList() {
  const data = [1, 2, 3, 4, 5];
  return (
    <>
      <ul>
        {
        data.map((number, index) =>
          <li key={index}>Listitem {number}</li>)
        }
      </ul>
    </>
  );
};
export default MyList;

Copy

Explain
Now, after adding the key, there is no warning in the console.

The usage of index is not recommended because it can cause bugs if the list is reordered or if you add or delete list items. Instead of that, you should use a unique key from the data if that exists. There are also libraries available that you can use to generate unique IDs, like uuid (https://github.com/uuidjs/uuid).

If the data is an array of objects, it would be nicer to present it in table format. We do this in roughly the same way as we did with the list, but now we just map the array to table rows (tr elements) and render these inside the table element, as shown in the following component code. Now we have a unique ID in the data so we can use it as a key:

function MyTable() {
  const data = [
    {id: 1, brand: 'Ford', model: 'Mustang'},
    {id: 2, brand: 'VW', model: 'Beetle'},
    {id: 3, brand: 'Tesla', model: 'Model S'}];
  return (
    <>
      <table>
        <tbody>
        {
        data.map((item) =>
          <tr key={item.id}>
            <td>{item.brand}</td><td>{item.model}</td>
          </tr>)
        }
        </tbody>
      </table>
    </>
  );
};
export default MyTable;

Copy

Explain
The following screenshot shows what the component looks like when it is rendered. You should see the data in the HTML table:


Figure 8.12: React table

Now, we have learned how to handle list data using the map() method and how to render it using, for example, an HTML table element.

Handling events with React
Event handling in React is similar to handling DOM element events. The difference compared to HTML event handling is that event naming uses camelCase in React. The following sample component code adds an event listener to a button and shows an alert message when the button is pressed:

function MyComponent() {
  // This is called when the button is pressed
  const handleClick = () => {
    alert('Button pressed');
  }
  return (
    <>
      <button onClick={handleClick}>Press Me</button>
    </>
  );
};
export default MyComponent;

Copy

Explain
As we learned earlier in the counter example, you have to pass a function to the event handler instead of calling it. Now, the handleClick function is defined outside the return statement, and we can refer to it using the function name:

// Correct
<button onClick={handleClick}>Press Me</button>
// Wrong
<button onClick={handleClick()}>Press Me</button>

Copy

Explain
In React, you cannot return false from the event handler to prevent the default behavior. Instead, you should call the event object’s preventDefault() method. In the following example, we are using a form element, and we want to prevent form submission:

function MyForm() {
  // This is called when the form is submitted
  const handleSubmit = (event) => {
    event.preventDefault(); // Prevents default behavior
    alert('Form submit');
  }
  return (
    <form onSubmit={handleSubmit}>
      <input type="submit" value="Submit" />
    </form>
  );
};
export default MyForm;

Copy

Explain
Now, when you press the Submit button, you can see the alert and the form will not be submitted.

Handling forms with React
Form handling is a little bit different with React. An HTML form will navigate to the next page when it is submitted. In React, often, we want to invoke a JavaScript function that has access to form data after submission, and avoid navigating to the next page. We already covered how to avoid submission in the previous section using preventDefault().

Let’s first create a minimalistic form with one input field and a Submit button. In order to get the value of the input field, we use the onChange event handler. We use the useState hook to create a state variable called text. When the value of the input field is changed, the new value will be saved to the state. This component is called a controlled component because form data is handled by React. In an uncontrolled component, the form data is handled only by the DOM.

The setText(event.target.value) statement gets the value from the input field and saves it to the state. Finally, we will show the typed value when a user presses the Submit button. Here is the source code for our first form:

import { useState } from 'react';
function MyForm() {
  const [text, setText] = useState('');
  // Save input element value to state when it has been changed
  const handleChange = (event) => {
    setText(event.target.value);
  }
  const handleSubmit = (event) => {
    alert(`You typed: ${text}`);
    event.preventDefault();
  }
  return (
    <form onSubmit={handleSubmit}>
      <input type="text" onChange={handleChange}
          value={text}/>
      <input type="submit" value="Press me"/>
    </form>
  );
};
export default MyForm;

Copy

Explain
Here is a screenshot of our form component after the Submit button has been pressed:


Figure 8.13: Form component

You can also write an inline onChange handler function using JSX, as shown in the following example. This is quite common practice if you have a simple event handler function, and it makes your code more readable:

return (
  <form onSubmit={handleSubmit}>
    <input
      type="text"
      onChange={event => setText(event.target.value)}
      value={text}/
    >
    <input type="submit" value="Press me"/>
  </form>
);

Copy

Explain
Now is a good time to look at React Developer Tools, which are useful for debugging React apps.

If you haven’t installed React Developer Tools yet, you can find the instructions in Chapter 7, Setting Up the Environment and Tools – Frontend.

If we open the React Developer Tools Components tab with our React form app and type something into the input field, we can see how the value of the state changes, and we can inspect the current value of both the props and the state.

The following screenshot shows how the state changes when we type something into the input field:


Figure 8.14: React Developer Tools

Typically, we have more than one input field in the form. Let’s look at how we can handle that using an object state. First, we introduce a state called user using the useState hook, as shown in the following code snippet. The user state is an object with three attributes: firstName, lastName, and email:

const [user, setUser] = useState({
  firstName: '',
  lastName: '',
  email: ''
});

Copy

Explain
One way to handle multiple input fields is to add as many change handlers as we have input fields, but this creates a lot of boilerplate code, which we want to avoid. Therefore, we add name attributes to our input fields. We can utilize these in the change handler to identify which input field triggers the change handler. The name attribute value of the input element must be the same as the name of the state object property in which we want to save the value, and the value attribute should be object.property, for example, in the last name input element. The code is illustrated here:

<input type="text" name="lastName" onChange={handleChange}
  value={user.lastName}/>

Copy

Explain
Now, if the input field that triggers the handler is the last name field, then event.target.name is lastName, and the typed value will be saved to the state object’s lastName field. Here, we will also use the object spread notation that was introduced in the Props and state section. In this way, we can handle all input fields with the one change handler:

const handleChange = (event) => {
  setUser({...user, [event.target.name]:
      event.target.value});
}

Copy

Explain
Here is the full source code for the component:

import { useState } from 'react';
function MyForm() {
  const [user, setUser] = useState({
    firstName: '',
    lastName: '',
    email: ''
  });
  // Save input box value to state when it has been changed
  const handleChange = (event) => {
    setUser({...user, [event.target.name]:
        event.target.value});
  }
  const handleSubmit = (event) => {
    alert(`Hello ${user.firstName} ${user.lastName}`);
    event.preventDefault();
  }
  return (
    <form onSubmit={handleSubmit}>
      <label>First name </label>
      <input type="text" name="firstName" onChange=
          {handleChange}
        value={user.firstName}/><br/>
      <label>Last name </label>
      <input type="text" name="lastName" onChange=
          {handleChange}
        value={user.lastName}/><br/>
      <label>Email </label>
      <input type="email" name="email" onChange=
          {handleChange}
        value={user.email}/><br/>
      <input type="submit" value="Submit"/>
    </form>
  );
};
export default MyForm;

Copy

Explain
Here is a screenshot of our form component after the Submit button has been pressed:


Figure 8.15: React form component

In the previous example, it is better to create one object state because all three values belong to one user. It could also be implemented using separate states instead of one state and object. The following code snippet demonstrates this. Now, we have three states, and in the input element’s onChange event handler, we call the correct update function to save values into the states. In this case, we don’t need the name input element’s name attribute:

import { useState } from 'react';
function MyForm() {
  const [firstName, setFirstName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const handleSubmit = (event) => {
    alert('Hello ${firstName} ${lastName}');
    event.preventDefault();
  }
  return (
    <form onSubmit={handleSubmit}>
      <label>First name </label>
      <input
        onChange={e => setFirstName(e.target.value)}
        value={firstName}/><br/>
      <label>Last name </label>
      <input
        onChange={e => setLastName(e.target.value)}
        value={lastName}/><br/>
      <label>Email </label>
      <input
        onChange={e => setEmail(e.target.value)}
        value={email}/><br/>
      <input type="submit" value="Press me"/>
    </form>
  );
};
export default MyForm;

Copy

Explain
We now know how to handle forms with React, and we will use these skills later when we implement our frontend.

Summary
In this chapter, we started to learn about React, which we will be using to build our frontend. In our frontend development, we will use ES6, which makes our code cleaner, as we saw in the chapter. Before starting to develop with React, we covered the basics, such as the React component, JSX, props, state, and hooks. We then went through the features we need for further development. We learned about conditional rendering and context, as well as how to handle lists, forms, and events with React.

In the next chapter, we will focus on TypeScript with React. We will learn the basics of TypeScript and how to use it in our React projects.

Questions
What is a React component?
What are states and props?
How does data flow in a React app?
What is the difference between stateless and stateful components?
What is JSX?
How are React hooks named?
How does context work?
Further reading
Here are some other good resources for learning about React:

React – The Complete Guide, by Maximilian Schwarzmüller (https://www.packtpub.com/product/react-the-complete-guide-includes-hooks-react-router-and-redux-2021-updated-second-edition-video/9781801812603)
The Ultimate React Course 2023, by Jonas Schmedtmann (https://www.udemy.com/course/the-ultimate-react-course/)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e



| ≪ [ 207 Setting Up the Environment and Tools ](/books/packtpub/2024/1202-Spring_Boot_3_React/207_Setting_Up_the_Environment_and_Tools) | 208 Getting Started with React | [ 209 Introduction to TypeScript ](/books/packtpub/2024/1202-Spring_Boot_3_React/209_Introduction_to_TypeScript) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 208 Getting Started with React
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/208_Getting_Started_with_React
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:22
> .md Name: 208_getting_started_with_react.md

