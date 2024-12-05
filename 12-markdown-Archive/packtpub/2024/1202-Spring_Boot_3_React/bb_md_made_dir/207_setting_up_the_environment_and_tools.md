
| ≪ [ 106 Testing Your Backend ](/books/packtpub/2024/1202-Spring_Boot_3_React/106) | 207 Setting Up the Environment and Tools | [ 208 Getting Started with React ](/books/packtpub/2024/1202-Spring_Boot_3_React/208) ≫ |
|:----:|:----:|:----:|

# Part 2: Frontend Programming with React

https://subscription.packtpub.com/book/web-development/9781805122463/8

# 207 Setting Up the Environment and Tools - Frontend

This chapter describes the development environment and tools that are needed for React so that you can start frontend development. In this chapter, we will create a simple starter React app by using the Vite frontend tooling.

In this chapter, we will cover the following topics:

Installing Node.js
Installing Visual Studio Code
Creating and running a React app
Debugging a React app
Technical requirements
The following GitHub link will be required: https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter07.

Installing Node.js
Node.js is an open-source, JavaScript-based, server-side environment. It is available for multiple operating systems, such as Windows, macOS, and Linux, and is required to develop React apps.

The Node.js installation package can be found at https://nodejs.org/en/download/. Download the latest Long-Term Support (LTS) version for your operating system. In this book, we are using the Windows 10 operating system, and you can get the Node.js MSI installer for it, which makes installation really straightforward.

When you execute the installer, you will go through the installation wizard, and you can do so using the default settings:


Figure 7.1: Node.js installation

Once the installation is complete, we can check that everything proceeded correctly. Open PowerShell, or whatever terminal you are using, and type the following commands:

node --version
npm --version

Copy

Explain
These commands should show you the installed versions of Node.js and npm:


Figure 7.2: Node.js and npm versions

npm comes with the Node.js installation and is a package manager for JavaScript. We will use this a lot in the following chapters when we install different Node.js modules in our React app.

There is another package manager called Yarn that you can use as well, but we will use npm because it comes with the Node.js installation. Yarn has some advantages, such as better overall performance due to its caching mechanism.

Next, we will install a code editor.

Installing Visual Studio Code
Visual Studio Code (VS Code) is an open-source code editor for multiple programming languages. It was developed by Microsoft. There are many different code editors available, such as Atom and Sublime, and you can use something other than VS Code if you are familiar with it.

Eclipse, which we used for backend development, is optimized for Java development. VS Code can also be used for Java and Spring Boot development, so it is possible to use only one editor for both backend and frontend development if you prefer.

VS Code is available for Windows, macOS, and Linux, and you can download it from https://code.visualstudio.com/. Installation for Windows is done with the MSI installer, and you can execute the installation with default settings.

The following screenshot shows the workbench for VS Code. On the left-hand side is the activity bar, which you can use to navigate between different views. Next to the activity bar is a sidebar that contains different views, such as the project file explorer. The editor takes up the rest of the workbench:

Figure 6.3 – VS Code workbench 
Figure 7.3: VS Code workbench

VS Code provides an integrated terminal that you can use to create and run React apps. The terminal can be found in the View | Terminal menu. You can use this in later chapters when we create more React apps.

VS Code extensions
There are a lot of extensions available for different programming languages and frameworks. If you open Extensions from the activity bar, you can search for different ones.

One really useful extension for React development is Reactjs code snippets, which we recommend installing. It has multiple code snippets available for React.js apps, which makes the development process faster. VS Code code snippet extensions can significantly enhance your workflow by saving time, promoting consistency, and reducing errors.

The following screenshot shows the Reactjs code snippets installation page:


Figure 7.4: React js code snippets

The ESLint extension helps you find typos and syntax errors quickly and makes formatting source code easier:


Figure 7.5: ESLint extension

ESLint (https://eslint.org/) is an open-source linter for JavaScript, and it helps you to find and fix problems in your source code. ESLint can highlight errors and warnings directly within the VS Code editor to help you identify and fix issues as you write code. Errors and warnings are shown in red or yellow underlines, and if you hover over these lines, you can see information about the specific error or warning. VS Code also provides a Problems panel that shows all ESLint errors and warnings. ESLint is flexible, and it can be configured using the .eslintrc file. You can define which rules are enabled and at what error level.

Prettier is a code formatter. With the Prettier extension, you can get automatic code formatting:


Figure 7.6: Prettier extension

You can set it in VS Code so that code is formatted automatically after you save it, by going to Settings from the File | Preferences menu and then searching for Format On Save.

These are just a few examples of the great extensions you can get for VS Code. We recommend you install all of them and test them out yourself.

In the next section, we will create our first React app and learn how to run and modify it.

Creating and running a React app
Now that we have Node.js and our code editor installed, we are ready to create our first React.js app. We will use the Vite frontend tool (https://vitejs.dev/) for this. There are excellent React frameworks available, like Next.js or Remix, that can be used as well, but Vite is a good option to learn React basics. Vite provides a really fast development server, and you don’t have to do any complex configuration to start coding.

In the past, Create React App (CRA) was the most popular tool for creating React projects, but its usage has decreased, and it is no longer recommended by official documentation. Vite offers many advantages over CRA (such as its faster development server).

We are using Vite version 4.3 in this book. You should verify the commands against the Vite documentation if you are using some other version. Also, check the Node.js version requirements, and upgrade your Node.js installation if your package manager warns you about it.

Here are the steps you need to follow to make your first React project using Vite:

Open PowerShell, or another terminal that you are using, and move to a folder where you want to create your project.
Type the following npm command, which uses the latest version of Vite:
npm create vite@latest

Copy

Explain
To use the same Vite major version that we are using in this book, you can also specify the Vite version in the command:

npm create vite@4.3

Copy

Explain
The command starts the project creation wizard. If this is the first time you are creating a Vite project, you will get a message prompting you to install the create-vite package. Press y to proceed.

In the first phase, type your project name – in this case, myapp:

Figure 7.7: Project name

Then, you will select a framework. In this phase, select the React framework. Note that Vite isn’t tied to React and can be used to bootstrap projects in lots of different frontend frameworks:

Figure 7.8: Framework selection

In the final step, you will select a variant. We’ll first learn the basics of React with JavaScript and later move on to TypeScript. So, in this phase, we will select JavaScript:

Figure 7.9: Project variant
SWC (Speedy Web Compiler) is a fast JavaScript and TypeScript compiler written in Rust. It is a faster alternative to Babel, which is normally used.

Once the app has been created, move into your app folder:
cd myapp

Copy

Explain
Then, install dependencies using the following command:
npm install

Copy

Explain
Finally, run your app using the following command, which starts the app in development mode:
npm run dev

Copy

Explain
Now, you should see the following message in your terminal:


Figure 7.10: Run your project

Open your browser and navigate to the URL that is shown in your terminal after the Local: text (in the example, it is http://localhost:5173/, but it might be different in your case):

Figure 7.11: React app

You can stop the development server by pressing q in your terminal.
To build a minified version of your app for production, you can use the npm run build command, which builds your app in the build folder. We will look more closely at deployment in Chapter 17, Deploying Your Application.

Modifying a React app
Now, we will learn how to modify the React app that we created using Vite. We will use VS Code, which we installed earlier:

Open your React project folder with VS Code by selecting File | Open folder. You should see the app’s structure in the file explorer. The most important folder in this phase is the src folder, which contains the JavaScript source code:

Figure 7.12: Project structure

You can also open VS Code by typing the code . command into the terminal. This command opens VS Code and the folder where you are located.

Open the App.jsx file from the src folder in the code editor. Modify the text inside the `<h1>` element to Hello React and save the file. You don’t need to know anything else about this file at the moment. We will go deeper into this topic in Chapter 8, Getting Started with React:

Figure 7.13: App.js code

Now, if you look at the browser, you should immediately see that the header text has changed. Vite provides the Hot Module Replacement (HMR) feature, which updates a React component automatically when you modify its source code or styles in your React project, without the need for manual page refreshing:

Figure 7.14: Modified React app

Debugging a React app
To debug React apps, we should also install React Developer Tools, which is available for Chrome, Firefox, and Edge browsers. Chrome plugins can be installed from the Chrome Web Store (https://chrome.google.com/webstore/category/extensions), while Firefox add-ons can be installed from the Firefox add-ons site (https://addons.mozilla.org). After you have installed React Developer Tools, you should see a new Components tab in your browser’s developer tools once you navigate to your React app.

You can open the developer tools by pressing Ctrl + Shift + I (or F12) in the Chrome browser. The following screenshot shows the developer tools in the browser. The Components tab shows a visual representation of the React component tree, and you can use the search bar to find components. If you select a component in the component tree, you will see more specific information about it in the right-hand panel:


Figure 7.15: React Developer Tools

We will see that the browser’s developer tools are really important, and it is useful to open them during development so that you can see errors and warnings immediately. The Console in developer tools is where you can log messages, warnings, and errors from your JavaScript or TypeScript code. The Network tab shows all the requests made by a web page, including their status codes, response times, and content. This is good for optimizing the performance of your web app and diagnosing network-related issues.

Summary
In this chapter, we installed everything that is needed to start our frontend development with React. First, we installed Node.js and the VS Code editor. Then, we used Vite to create our first React app. Finally, we ran the app, demonstrated how to modify it, and introduced debugging tools. We will continue to use Vite in the following chapters.

In the next chapter, we will familiarize ourselves with the basics of React programming.

Questions
What are Node.js and npm?
How do you install Node.js?
What is VS Code?
How do you install VS Code?
How do you create a React app with Vite?
How do you run a React app?
How do you make basic modifications to your app?
Further reading
Here are some useful resources that will extend the knowledge we have learned in this chapter:

React 18 Design Patterns and Best Practices, by Carlos Santana Roldán (https://www.packtpub.com/product/react-18-design-patterns-and-best-practices-fourth-edition/9781803233109)
JavaScript in Visual Studio Code, by Microsoft (https://code.visualstudio.com/docs/languages/javascript)
TypeScript in Visual Studio Code, by Microsoft (https://code.visualstudio.com/docs/languages/typescript)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e



| ≪ [ 106 Testing Your Backend ](/books/packtpub/2024/1202-Spring_Boot_3_React/106) | 207 Setting Up the Environment and Tools | [ 208 Getting Started with React ](/books/packtpub/2024/1202-Spring_Boot_3_React/208) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 207 Setting Up the Environment and Tools
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/207
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:22
> .md Name: 207_setting_up_the_environment_and_tools.md

