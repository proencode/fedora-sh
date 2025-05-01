
| ≪ [ 208 Getting Started with React ](/books/packtpub/2024/1202-Spring_Boot_3_React/208_Getting_Started_with_React) | 209 Introduction to TypeScript | [ 210 Consuming the REST API with React ](/books/packtpub/2024/1202-Spring_Boot_3_React/210_Consuming_the_REST_API_with_React) ≫ |
|:----:|:----:|:----:|

# 209 Introduction to TypeScript

This chapter introduces TypeScript. We will cover the basic skills that are required to use TypeScript with React and create our first React app with TypeScript.

In this chapter, we will look at the following topics:

Understanding TypeScript
Using TypeScript features with React
Creating a React app with TypeScript
Technical requirements
For our work, React version 18 or higher will be required.

You can find more resources at the GitHub link for this chapter: https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter09.

Understanding TypeScript
TypeScript (https://www.typescriptlang.org/) is a strongly typed superset of JavaScript, developed by Microsoft. TypeScript adoption has grown a lot in recent years and it is widely used in the industry. It has an active development community and is supported by most popular libraries. In the JetBrains 2022 Developer Ecosystem report, TypeScript was named the fastest-growing programming language (https://www.jetbrains.com/lp/devecosystem-2022/).

TypeScript offers several advantages compared to JavaScript, mostly due to strong typing:

TypeScript allows you to define types for variables, functions, and classes. This allows you to catch errors early in the development process.
TypeScript improves the scalability of your app, as well as making your code easier to maintain.
TypeScript improves code readability and makes your code more self-documenting.
Compared to JavaScript, the TypeScript learning curve can be steeper if you are not familiar with static typing.

The easiest way to try TypeScript is to use an online environment such as TypeScript Playground (https://www.typescriptlang.org/play). If you want to code TypeScript locally, you can install the TypeScript compiler on your computer using npm. This will not be needed for our React project because Vite comes with built-in TypeScript support. TypeScript is transpiled to plain JavaScript and can then be executed in a JavaScript engine.

The following npm command installs the latest version of TypeScript globally, allowing you to use TypeScript anywhere in your terminal:

npm install -g typescript

Copy

Explain
You can check the installation by checking the TypeScript version number:

tsc --version

Copy

Explain
If you are using Windows PowerShell, you might get an error stating that running scripts is disabled on this system. In this case, you have to change the execution policy to be able to run the installation command. You can read more at https://go.microsoft.com/fwlink/?LinkID=135170.

Like JavaScript, TypeScript has good IDE support that makes your coding more productive, with features like linting and code autocompletion – for example, IntelliSense in Visual Studio Code.

Common types
TypeScript will automatically define the type of a variable when you initialize it. This is called type inference. In the following example, we declare a message variable and assign it to a string value. If we try to reassign it with another type, we get an error, as shown in the following image:


Figure 9.1: Type inference

TypeScript has the following primitive types: string, number, and boolean. The number type represents both integer and floating-point numbers. You can also set an explicit type for a variable using the following syntax:

let variable_name: type;

Copy

Explain
The following code demonstrates explicit typing:

let email: string;
let age: number;
let isActive: boolean;

Copy

Explain
The variables’ types can be checked using the typeof keyword, which returns a string representing the type of the variable it is applied to:

// Check variable type
console.log(typeof email); // Output is "string"
typeof email === "string" // true
typeof age === "string" // false

Copy

Explain
If you don’t know the type of a variable, you can use the unknown type. It can be used when you get a value, for example, from some external source, and you don’t know its type:

let externalValue: unknown;

Copy

Explain
When a value is assigned to the unknown variable, you can check the type using the typeof keyword.

TypeScript also provides the any type. If you define a variable using the any type, TypeScript doesn’t perform a type check or inference on that variable. You should avoid using the any type whenever possible, since it negates the effectiveness of TypeScript.

Arrays can be declared in the same way as in JavaScript, but you have to define the type of the elements in the array:

let arrayOfNums: number[] = [1, 2, 3, 4];
let animals: string[] = ["Dog", "Cat", "Tiger"];

Copy

Explain
You can also use the Array generic type (Array<TypeOfElement>) in the following way:

let arrayOfNums: Array<number> = [1, 2, 3, 4];
let animals: Array<string> = ["Dog", "Cat", "Tiger"];

Copy

Explain
Type inference also works with objects. If you create the following object, TypeScript creates an object with these inferred types: id: number, name: string, and email: string:

const student = {
  id: 1,
  name: "Lisa Smith ",
  email: "lisa.s@mail.com ",
};

Copy

Explain
You can also define an object using the interface or type keyword, which describes the object’s shape. The type and interface are quite similar, and most of the time you are free to choose which one you use:

// Using interface
interface Student {
    id: number;
    name: string;
    email: string;
};
// Or using type
type Student = {
    id: number;
    name: string;
    email: string;
};

Copy

Explain
Then, you can declare an object that conforms to the Student interface or type:

const myStudent: Student = {
    id: 1,
    name: "Lisa Smith ",
    email: "lisa.s@mail.com ",
};

Copy

Explain
You can read more about the difference between type and interface in the TypeScript documentation: https://www.typescriptlang.org/docs/handbook/2/everyday-types.html#differences-between-type-aliases-and-interfaces.

Now, if you try to create an object that doesn’t match the interface or type, you will get an error. In the next image, we create an object where the id property value is string, but it is defined as number in the interface:


Figure 9.2: Interface

You can define optional properties by using the question mark (?) at the end of the property name. In the following example, we mark email to be optional. Now, you can create a student object without an email because it is an optional property:

type Student = {
    id: number;
    name: string;
    email?: string;
};
// Student object without email
const myStudent: Student = {
    id: 1,
    name: "Lisa Smith"
}

Copy

Explain
The optional chaining operator (?.) can be used to safely access object properties and methods that can be null or undefined without causing an error. It is really useful with optional properties. Let’s look at the following type, where address is optional:

type Person = {
    name: string,
    email: string;
    address?: {
        street: string;
        city: string;
    }
}

Copy

Explain
You can create an object based on the Person type that doesn’t have the address property defined:

const person: Person = { 
    name: "John Johnson",
    email: "j.j@mail.com"
}

Copy

Explain
Now, if you try to access the address property, an error is thrown:

// Error is thrown
console.log(person.address.street);

Copy

Explain
However, if you use optional chaining, the value undefined is printed to the console and an error is not thrown:

// Output is undefined
console.log(person.address?.street);

Copy

Explain
There are also many ways to compose types in TypeScript. You can use the | operator to create a union type, a type that handles different types. For example, the following example defines a type that can contain a string or number:

type InputType = string | number;
// Use your type
let name: InputType = "Hello";
let age: InputType = 12;

Copy

Explain
You can also use union types to define sets of strings or numbers, as shown in the following example:

type Fuel = "diesel" | "gasoline" | "electric ";
type NoOfGears = 5 | 6 | 7;

Copy

Explain
Now, we can use our union types in the following way:

type Car = {
  brand: string;
  fuel: Fuel;
  gears: NoOfGears;
}

Copy

Explain
If you create a new Car object and try to assign some other value than what is defined in the Fuel or NoOfGears union types, you will get an error.

Functions
When you define functions, you can set parameter types in the following way:

function sayHello(name: string) {
  console.log("Hello " + name);
}

Copy

Explain
If you now try to call the function using a different parameter type, you will get an error:


Figure 9.3: Function call

If a function parameter type is not defined, it implicitly has an any type. You can also use union types in function parameters:

function checkId(id: string | number) {
  if (typeof id === "string ")
    // do something
  else
    // do something else
}

Copy

Explain
A function’s return type can be declared in the following way:

function calcSum(x: number, y: number): number {
  return x + y;
}

Copy

Explain
Arrow functions work in the same way in TypeScript, for example:

const calcSum = (x:number, y:number): number => x + y;

Copy

Explain
If the arrow function returns nothing, you can use the void keyword:

const sayHello = (name: string): void => console.log("Hello " + name);

Copy

Explain
Now, you have encountered some TypeScript basics, and we will learn how to apply these new skills in our React apps.

Using TypeScript features with React
TypeScript is a valuable addition to your React projects, especially when they grow in complexity. In this section, we will learn how we can get prop and state type validation in our React components and detect potential errors early in development.

State and props
In React, you have to define the type of component props. We have already learned that component props are JavaScript objects, so we can use type or interface to define the prop type.

Let’s look at one example where a component receives a name (string) and age (number) prop:

function HelloComponent({ name, age }) {
  return(
    <>
      Hello {name}, you are {age} years old!
    </>
  );
}
export default HelloComponent;

Copy

Explain
Now, we can render our HelloComponent and pass props to it:

// imports...
function App() {
  return(
    <HelloComponent name="Mary" age={12} />
  )
}
export default App;

Copy

Explain
If we use TypeScript, we can first create a type that describes our props:

type HelloProps = {
  name: string;
  age: number;
};

Copy

Explain
Then, we can use our HelloProps type in the component props:

function HelloComponent({ name, age }: HelloProps) {
  return(
    <>
      Hello {name}, you are {age} years old!
    </>
  );
}
export default HelloComponent;

Copy

Explain
Now, if we pass props using the wrong type, we will get an error. This is great because, now, we can catch potential errors in the development phase:


Figure 9.4: Typing props

If we had used JavaScript instead, we wouldn’t have seen an error in this phase. In JavaScript, if we had passed a string as the age prop instead of a number, it would still have worked, but we might have encountered unexpected behavior or errors if we had tried to perform numerical operations on it later on.

If there are optional props, you can mark these using the question mark in your type where you define the props – for example, if age is optional:

type HelloProps = {
  name: string;
  age?: number;
};

Copy

Explain
Now, you can use your component with or without age props.

If you want to pass a function using the props, you can define it in your type using the following syntax:

// Function without parameters 
type HelloProps = {
  name: string;
  age: number;
  fn: () => void;
};
// Function with parameters
type HelloProps = {
  name: string;
  age: number;
  fn: (msg: string) => void;
};

Copy

Explain
Quite often, you will want to use the same type in multiple files in your app. In that case, it is a good practice to extract types into their own file and export them:

// types.ts file
export type HelloProps = {
  name: string;
  age: number;
};

Copy

Explain
Then, you can import the type into any component where you need it:

// Import type and use it in your component
import { HelloProps } from ./types;
function HelloComponent({ name, age }: HelloProps) {
  return(
    <>
      Hello {name}, you are {age} years old!
    </>
  );
}
export default HelloComponent;

Copy

Explain
As we touched on in Chapter 8, you can also use the arrow function to create a functional component. There is a standard React type, FC (function component), that we can use with arrow functions. This type takes a generic argument that specifies the prop type, which is HelloProps in our case:

import React from 'react';
import { HelloProps } from './types';
const HelloComponent: React.FC<HelloProps> = ({ name, age }) => {
  return (
    <>
      Hello {name}, you are {age} years old!
    </>
  );
};
export default HelloComponent;

Copy

Explain
Now, you have learned how to define prop types in your React app, so we will move on to states. When you create states using the useState hook we learned about in Chapter 8, type inference handles typing when you are using common primitive types. For example:

// boolean
const [isReady, setReady] = useState(false);
// string
const [message, setMessage] = useState("");
// number
const [count, setCount] = useState(0);

Copy

Explain
If you try to update the state using a different type, you will get an error:


Figure 9.5: Typing state

You can also explicitly define state types. You have to do this if you want to initialize your state to null or undefined. In this case, you can use the union operator, and the syntax is the following:

const [message, setMessage] = useState<string | undefined>(undefined);

Copy

Explain
If you have a complex state, you can use a type or interface. In the following example, we create a type that describes a user. Then, we create a state and initialize it with an empty User object. If you want to allow null values, you can use a union to allow either a User object or a null value:

type User = {
  id: number;
  name: string;
  email: number;
};
// Use type with state, the initial value is an empty User object
const [user, setUser] = useState<User>({} as User);
// If null values are accepted
const [user, setUser] = useState<User | null>(null);

Copy

Explain
Events
In Chapter 8, we learned how to read user input in a React app. We used the input element’s onChange event handler to save typed data to the state. When using TypeScript, we have to define the types of events. In the following screenshot, you can see that we get an error if types are not defined:


Figure 9.6: Typing events

Let’s see how we can handle an input element’s change event. Let’s see one example where the input element code in the return statement looks like the following:

<input 
  type="text" 
  onChange={handleChange} 
  value={name} 
/>

Copy

Explain
The event handler function is called when the user types something into the input element, and the code looks like this:

const handleChange = (event) => {
  setName(event.target.value);
}

Copy

Explain
Now, we have to define the type of the event. For this, we can use the predefined React.ChangeEvent type.

You can read the complete list of event types in the React TypeScript CheatSheet: https://react-typescript-cheatsheet.netlify.app/docs/basic/getting-started/forms_and_events/.

We want to handle a change event on an input element, so the type is the following:

const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
  setName(event.target.value);
} 

Copy

Explain
The form submission handler function handles the form submission. This function should take an event parameter of the type React.FormEvent<HTMLFormElement>:

const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
  event.preventDefault();
  alert(`Hello ${name}`);
}

Copy

Explain
Now, we know how to handle events when using TypeScript in our React apps. Next, we will learn how to actually create a React app that uses TypeScript.

Creating a React app with TypeScript
Now, we will create a React app using Vite, and we will use TypeScript instead of JavaScript. We will use TypeScript later when we develop the frontend for our car backend. As we mentioned earlier, Vite comes with built-in TypeScript support:

Create a new React app using the following command:
npm create vite@latest

Copy

Explain
Next, name your project tsapp, and select the React framework and the TypeScript variant:

Figure 9.7: React TypeScript app

Then, move to your app folder, install dependencies, and run your app using the following commands:
cd tsapp
npm install
npm run dev

Copy

Explain
Open your app folder in VS Code, and you will see that the filename of our App component is App.tsx:

Figure 9.8: App.tsx

The file extension of TypeScript React files is .tsx (combining JSX with TypeScript). The regular file extension of TypeScript files is .ts.

Locate the tsconfig.json file in the root of your project. This is a configuration file used by TypeScript to specify compiler options, such as the target version of the compiled JavaScript output or the module system that is used. We can use the default settings defined by Vite.
Let’s create the React app that we used as an example in an earlier section, when we defined types for events. The user can enter a name, and when the button is pressed, a hello message is shown using an alert:

First, we will remove the code from the App.tsx file’s return statement and leave only fragments. After also removing all unused imports (except the useState import), your code should look like the following:
import { useState } from 'react';
import './App.css';
function App() {
  return (
    <>
    </>
  )
}
export default App;

Copy

Explain
Next, create a state to store the value that the user enters into the input element:
function App() {
  const [name, setName] = useState("");
  return (
    <>
    </>
  )
}

Copy

Explain
After that, add two input elements to the return statement, one that collects user input and another that submits the form:
// App.tsx return statement
return (
  <>
    <form onSubmit={handleSubmit}>
      <input
        type="text"
        value={name}
        onChange={handleChange}
      />
      <input type="submit" value="Submit"/>
    </form>
  </>
)

Copy

Explain
Next, create the event handler functions, handleSubmit and handleChange. Now, we also have to define the types of the events:
// imports
function App() {
  const [name, setName] = useState("");
  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    setName(event.target.value);
  }
  const handleSubmit = (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    alert(`Hello ${name}`);
  }
// continue...

Copy

Explain
Run the app using the npm run dev command.
Try typing your name into the input element and pressing the Submit button. You should see the hello message showing your name:

Figure 9.9: React TypeScript app

Vite and TypeScript
Vite transpiles TypeScript files to JavaScript, but it doesn’t perform type checking. Vite uses esbuild to transpile TypeScript files because that is much faster than the TypeScript compiler (tsc).

The VS Code IDE handles type checking for us, and you should fix all errors that are shown in the IDE. You can also use a Vite plugin called vite-plugin-checker (https://github.com/fi3ework/vite-plugin-checker). Type checking is done when we build a Vite app to production, and all errors should be fixed before the production build. We will build our Vite app later in this book.

Summary
In this chapter, we started to learn TypeScript and how to use it in our React apps. Now, we know how to use common types in TypeScript and how to define types for React component props and states. We also learned to define types for events, and created our first React app with TypeScript using Vite.

In the next chapter, we will focus on networking with React. We will also use the GitHub REST API to learn how to consume a RESTful web service with React.

Questions
What is TypeScript?
How do we define variable types?
How do we define types in functions?
How do we define types for React props and states?
How do we define types for events?
How do we create a React TypeScript app using Vite?
Further reading
Here are some other useful resources for learning about React with TypeScript:

React TypeScript Cheatsheets (https://react-typescript-cheatsheet.netlify.app/)
Learn React with TypeScript, Second Edition, by Carl Rippon (https://www.packtpub.com/product/learn-react-with-typescript-second-edition/9781804614204)
Mastering TypeScript, by Nathan Rozentals (https://www.packtpub.com/product/mastering-typescript-fourth-edition/9781800564732)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e



| ≪ [ 208 Getting Started with React ](/books/packtpub/2024/1202-Spring_Boot_3_React/208_Getting_Started_with_React) | 209 Introduction to TypeScript | [ 210 Consuming the REST API with React ](/books/packtpub/2024/1202-Spring_Boot_3_React/210_Consuming_the_REST_API_with_React) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 209 Introduction to TypeScript
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/209_Introduction_to_TypeScript
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:22
> .md Name: 209_introduction_to_typescript.md

