
# Exploring the Book’s Layout and Companion App
Vue.js is an enormously popular framework in the JavaScript (JS) ecosystem. In recent years, it has gained lots of popularity thanks to its simplicity, its great documentation, and, finally, its fantastic community. If you are starting web development now, or are transitioning from a different framework or language, Vue.js is a great choice.

Before we can jump into the main content of the book, it is important to learn how the book is structured and what methods will be used to explain the different topics of this fantastic framework.

To simplify the learning of Vue.js and make the book more interesting and interactive, the book has been built around the creation and enhancement of a Companion App.

Vue.js 3 for Beginners is going to focus mainly on the framework and its core libraries, and it will not cover basic development knowledge such as HTML, CSS, JS, and Git. To understand the content of this book, basic knowledge of these four topics is required.

The first part of this book is going to cover an important aspect of our learning journey and will provide you with important theoretical information that is needed for you to make the most of the book’s content; we will then jump into the specifics of Vue by introducing the framework and its core concepts in Chapter 2. Finally, from Chapter 3 onward, we will start to work on our application, one component at a time.

In this chapter, we’ll cover the following topics:

- The Companion App
- The core areas of a web application
- Component-based architecture

By the end of this chapter, you will learn about what we are going to build during the course of the book, and cover some theoretical aspects required for us to make the most of the Vue.js framework, such as component-based architecture and the architectural decisions behind the Companion App.

# Technical requirements
The application that accompanies the book has been built using free software and APIs and will not require you to purchase anything. However, there are some specific technical requirements needed for you to follow along:

- Visual Studio Code or another equivalent IDE (integrated development Environment)
- Volar Visual Studio code extension
- A browser updated to the latest version (I suggest Chrome or Firefox)
- Node 16+
- GIT or a Git GUI (Graphic user interface) such as GitKraken installed on your machine

# The companion app
Learning a new language or framework is not an easy task. There are plenty of free resources, such as documentation, blogs, and YouTube videos on the internet, but I believe learning a new tech requires practice, and there is no better way to achieve this than by building a production-ready, performant, scalable social media application together.

The application is going to be very similar to the social media platform X (formerly Twitter). We will start from a clean canvas and slowly add more features and functionality until the app is fully working and ready to be added to your portfolio and showcased at your next job interview.

Each chapter will have a set of sections that will help you navigate the book. This will not only ensure that you can always follow along and have a clear understanding of the scope of the chapter, but it also allows you to use the book as a reference after you have read it all and allows you to jump to a specific chapter if you need to do so.

Each chapter includes the following sections:

- Starting branch for the chapter
- The current state of the Companion App
- Definition of what will be added and achieved within the current chapter
- Multiple sections of explanation and coding
- Summary of what Vue.js topics we have learned in this chapter with a glossary

## The Companion App features
As mentioned previously, the application that we are about to build will be very similar to an existing social media application. To make sure we cover most of the Vue.js features and its ecosystem, we may at times over-architect a specific component or feature, but when this happens, it will be called out so that you will have full knowledge of whether it is a good practice to follow in the future and what would be the correct implementation.

By following the book, you will learn the following:

- How to structure a web application using a component-based architecture
- How to create simple and complex HTML using Vue.js
- How to make the right decision to make your app performant and scalable
- How to communicate between components
- How to use external APIs to load dynamic data
- How to use state management using Pinia
- How to implement multiple pages (routing) using vue-router
- How to test your application using Vitest and Cypress
- How to create forms effectively using Vue.js
- How to debug your application using the Vue debugger

The preceding list is just an overview of what we will be achieving in the book, and we are going to make this learning fun and interactive by building using the Companion App together.

## The application code
The code for the application can be found in this repository: https://github.com/PacktPublishing/Vue.js-3-for-Beginners. If you do not know what a repository is or how to use it, I suggest you learn the basics, even if all the information and commands you require to use the code will be provided in each chapter.

The repository has multiple branches for each chapter. This will be the starting point for each chapter and will be specified at the start of each chapter, as mentioned before.

The main branch of the repository is the latest commit, and it includes the complete application. If you have some time, I suggest you run the full application to try and browse it to see what we will achieve in the course of the book.

To run the application, you can simply follow the instructions available in the `README.md` file that is available at the root of the project.

As it is the first time that we are running the application, I will also provide the information required here to get the application up and running:

1. First, we need to get a copy of the remote repository on our machine. To do so, run the following command in the terminal:
```
git clone https://github.com/PacktPublishing/Vue.js-3-for-Beginners
```
2. Then, we need to navigate into our newly created project folder:
```
cd vue-for-beginners
```

3. Before we can run the project, we need to install all its dependencies using a package manager. A package manager is a piece of software that is used to install and manage the packages, in our case Node.js and JS, for which the project depends. The application shared in the repository supports all major package managers, such as npm, yarn, and pnpm. In the following example, we are going to use npm:
```
npm install
```

4. Finally, it is time to run the project. The following command will run a development version of the project:
```
npm run serve
```

After a few seconds, the local instance of the application will start, and you should be able to access it by opening the browser at HTTP://localhost:5173. The application should look like this.

Figure 1.1: Screenshot of the Companion App dashboard
Figure 1.1: Screenshot of the Companion App dashboard

Spend some time navigating the application, both in the browser and within the code base, to see what we will build in the course of the book.

In this section, we have learned about the Companion Application, how it is going to be used to support our learning, its core features, and finally, the commands required to run the application locally. In the next section, we will spend a few moments on the core areas of web applications and explain which technologies/libraries we are going to use in our application.

# The core areas of a web application
The JS ecosystem is not shy of frameworks and libraries, but even with this extensive choice, they mostly share the same core values and areas. These are the core parts of a web application and no matter which framework you use to write your application, you will have to know this and have a basic understanding of what they mean.

The pillars of a web application are as follows:

- `User interface (UI)`: This refers to the elements displayed on the screen from which a user can interact. In simple words, anything you can see or interact with on the internet is part of the UI. This core area of web development is usually achieved with basic HTML/CSS, vanilla JS (that is a different way to say plain JS), or a framework such as React, Vue, or Angular. In our case, this will be achieved using Vue.js 3.
- `Data fetching`: Data fetching is at the core of any web application. No matter how small your site is, it is going to require you to fetch some data. This technique is called data fetching and can either be achieved using a REST API or GraphQL. Data handling is not supported by any of the official libraries offered by Vue.js and we are going to handle it using plain JS with the `fetch` method.
- `State management`: Unless your website is a static blog post, you will need to handle some data. This could be the current state of a form or information about a logged-in user. Small applications can easily achieve this directly with the existing tool that a framework provides, but at times, this needs to be expanded to use full-blown “state management.” In Vue.js, two main libraries help you handle your data. Vuex the state management of choice for Vue 2 and Pinia, which is the suggested library to be used for Vue 3 (Pinia is just a newer version of Vuex, but it was renamed due to the fact that it went through a full rewrite with many breaking changes).Because we will be writing our Companion App in Vue 3, we will use Pinia.
- `Routing`: Even if by definition most of today’s websites are called `single-page applications (SPAs)`, in reality, they make use of more than one page. The definition of “single page” is just used because the application does not fully reload during navigation, but it does not imply that the application will not have more than one route. For this reason, most web applications will require a way to handle routing between multiple pages. For the scope of this book, we will be using vue-router, which is the official routing library.
- `Forms and validation`: Forms are probably one of the main reasons why JS frameworks and SPAs have become so successful. The possibility of handling complex forms and client interaction without the need to refresh the page has improved `user experience (UX)` massively. Even if Vue.js is more than capable of handling forms and their validation, we will be using an external library called VeeValidate for client-side validation.
- `Debugging`: Building is not always straightforward and debugging an application is a must-have skill. Even if this is not really a real part of the application (as it is more a skill than an actual part of the application itself), I still want to include it as part of a web application core area, as debugging helps us make the application secure and performant. In our case, we will be using plain JS techniques and a browser extension called Vue.js devtools to help us analyze, study, and improve our application.

In this section, we explained the different areas that make a web application. We also explained the architectural decision behind the technology stack that is going to be used within our Companion App. It is now time to learn about a fundamental methodology called `component-based architecture`. This is the foundation for most frontend frameworks.

# Component-based architecture
We have reached the final section of our introductory discussion and we are almost ready to start coding. This section is going to introduce the concept of component-based architecture. Even if you are already familiar with this topic, I suggest you continue reading this chapter as it will support some of the decisions we will make later in the course of the book.

In this section, we are going to cover how web development worked before this concept was introduced and we will then discuss how component-based architecture has shaped the web development industry as we know it.

## One page at a time
If you have been a developer for as long as I have been, you have probably worked with languages and frameworks that were not flexible in the way the pages were defined and developed. Using .NET and PHP a few years ago would have meant that each web page was created using a single file (disclaimer: some languages had the definition of “partials”.

This worked well until JS started to be used in the frontend and shook the ecosystem. JS changed sites from static pages to very dynamic entities and in doing so pushed for something more dynamic that would not work with the previous development tools.

Let’s take into consideration a standard website homepage, such as the following one:

Figure 1.2: Wireframe of a standard homepage
Figure 1.2: Wireframe of a standard homepage

This site follows a standard layout with a header and a footer, a banner, some featured content, and a Contact Us form. Imagine having all this in one single HTML file. Back in the day, this was probably all held in one single HTML file with a shared stylesheet, for example a CSS (Cascading Style Sheet) file. As mentioned previously, things started to change in the industry and JS started to be used more and more.

In the preceding scenario, JS was probably just used to add some basic interactivity like slideshow animation in the banner, some fancy scrolling i products list or to handle form submission in the Contact Us form.

Long story short, this change slowly shaped the industry toward frontend libraries and frameworks. These libraries and frameworks aimed to help manage and simplify the hundreds of lines of code produced in JS and they did so by introducing component-based architecture.

Breaking things down into small units was not something new in the industry, as the backend framework already had this notion with the use of object-oriented programming, but it was an innovation in the frontend side of the industry.

## From one page to many components
The term component-based development (CBD) is a pattern in which the UI of a given application is broken down into multiple “components.” Breaking down big pages into small individual units reduces the complexity of the application and helps the developer focus on the individual scope and responsibility of each section.

All of today’s frontend frameworks are built on top of this pattern and today’s frontend development is driven by architecture based on CBD.

Let’s look at the previous example of the home page and see how we could split this into small isolated components.

The home page would be broken down into the following components:

- `Header`: A component that will include the logo and the logic used to display account information such as the avatar
- `The slideshow`: A reusable component used to display slideshow images
- `Featured`: A component used to display featured articles
- `Contact Us`: A component including all the logic required to validate and submit our form
- `Footer`: A static component that will include some copy and social links

Figure 1.3: Wireframe of a dashboard divided into different sections, such as header, slideshow, featured, Contact Us, and footer
Figure 1.3: Wireframe of a dashboard divided into different sections, such as header, slideshow, featured, Contact Us, and footer

As we will see in a few minutes, the components displayed in Figure 1.3 are just an example, as a fully defined CBD will actually break things even further all the way to the single HTML element. What this means is that not only the page is made of components, but components are made up of smaller components too.

Breaking down things into smaller units has many benefits. Let’s analyze some of these characteristics:

- `Reusability`: CBD provides you with the possibility to create components that can be reused within your application. (In our example we could reuse the header, footer, slideshow, and even the featured component.)
- `Encapsulation`: Encapsulation is defined as the ability for each component to be “self-contained.” All styles, HTML, and JS logic are “encapsulated” within the scope of a given component.
- `Independence`: Due to encapsulation, each component is independent and does not share (or is not supposed to share) responsibility with other components. This allows components to be used in different contexts (for example, the ability to use the feature component on a different page of the site).
- `Extensibility`: Due to the component being “self-contained” and independent, we are able to extend it with limited risk.
- `Replaceability`: The component can easily be swapped out with other components or be removed without risk.

It is clear from the preceding list that using `CBD` brings many benefits to the hands of a frontend developer. As we will experience in the course of this book, the ability to break an application down into small units is extremely beneficial for new developers as it allows the individual topics to be broken down and really focuses our attention on what matters the most.

Vue.js implements component-based architecture with the use of a `Single-File Component (SFC)`. These files are denoted by the `.vue` extension and encapsulate styles, HTML, and logic (JS or Typescript) in the same file. SFC will be clearly introduced later in the book.

## Atomic design
In this last section, we are going to understand how we will structure our components during the course of the book.

The folder structure of components is something that has not been standardized yet around the industry and this can differ from developer to developer.

In our case, we are going to follow what is known in the industry as “atomic design.” This is described as:

_The Atomic Design methodology created by Brad Frost (https://bradfrost.com/) is a design methodology for crafting robust design systems with an explicit order and hierarchy - blog.kamathrohan.com._

The atomic design pattern follows the same concept described in chemistry and the composition of matter. If you want to go into more detail on this subject, I suggest you read the following article: https://blog.kamathrohan.com/atomic-design-methodology-for-building-design-systems-f912cf714f53.

In this book, we are going to follow the hierarchy proposed in this methodology by breaking down our applications into “sub-atomic,” atoms, molecules, organisms, templates and pages.

Figure 1.4: Visual explanation of the different levels offered by atomic design (source: https://blog.kamathrohan.com/atomic-design-methodology-for-building-design-systems-f912cf714f53)
Figure 1.4: Visual explanation of the different levels offered by atomic design (source: https://blog.kamathrohan.com/atomic-design-methodology-for-building-design-systems-f912cf714f53)

Atomic design layers are as follows:

- `Sub-atomic`: The sub-atomic layers include all the variables and settings that will be used within the application. These are not going to be “components,” but just CSS variables that will be shared globally within our application. In the sub-atomic layer, we find colors, typography, and spacing.
- `Atoms`: These are components that will define individual HTML elements, so, for example, a button, an icon, and an input text are all part of atoms.
- `Molecules`: Molecules are made up of two or more atoms or plain HTML elements. For example, an input field with a label and an error is a molecule.
- `Organism`: There are UI components that make up a standalone section that can be used on the site. For example, a login form is an organism, a slideshow is an organism, and so is a footer.
- `Templates`: These are commonly called layouts within the frontend ecosystem and are used to define a reusable structure used by multiple pages. An example could be a template with a hero image, a sidebar, main content area and a footer. This template would be used by many pages within the application and abstracting it into its own template reduces duplication.
- `Pages`: Lastly, we have pages. These are used to define our web application page or subpage. A page is going to be the place in which our data is loaded, and it will include HTML elements, organisms, molecules, and atoms.

Even if this separation may seem complicated to understand from the preceding description, we will touch base on this topic multiple times during the book and this will help you understand the main difference between the layers available.

Spend some time going through the folder structure of the application and read the components’ names to try and understand how we will break up our application.

## Separation of concern
So far, we have learned that the modern framework offers the ability to break up the application into small chunks called components and that there is a hierarchy within the component itself.

In this section, we are going to quickly touch base on why this hierarchy was introduced in the first place and understand how this is going to help our development.

Atomic design not only supports us in breaking up components by their visual complexity, but it also helps us to break up the application logic to create highly performance and scalable applications.

As the component definitions get more complex, so does the logic expected to be attached to it.

Figure 1.5: Illustration of the level of UI and Logic complexity for each layer
Figure 1.5: Illustration of the level of UI and Logic complexity for each layer

What do we mean by logic complexity? Logic complexity can be described as the amount of JS required for the component to function correctly.

For example, a component with low logic complexity such as a button will have very limited JS, while a more complex component such as an input field will need to handle field validation and error placement; furthermore, a page will have to take ownership of loading the data from the API, format the data to ensure that it is in the right format, and handle the visibility of its children.

In this section, we have introduced how an application is structured using the component-based architecture. We introduced the different layers that make up a component library and finally defined the advantages that this methodology when used in conjunction with a frontend framework such as Vue.js. Let’s now recap the chapter in the Summary section.

# Summary
It is now the end of the chapter and at this stage, you should have gained some knowledge of what we will achieve in this book and the methods that we will be using.

We have learned about our Companion App and what that will include. We have quickly touched upon the chapters’ structure and how they will support you in your learning journey, and we have finally introduced important topics such as component-based architecture, atomic design, and the core areas of web development that are the foundation of any frontend project.

In the next chapter, we will start to learn about the foundation of Vue.js and its core fundamentals and start to give life to our Companion Application.



