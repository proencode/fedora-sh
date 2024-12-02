
| ≪ [ 211 Useful Third-Party Components for React ](/books/packtpub/2024/1202-Spring_Boot_3_React/211_Useful_Third-Party_Components_for_React) | 312 Setting Up the Frontend | [ 313 Adding CRUD Functionalities ](/books/packtpub/2024/1202-Spring_Boot_3_React/313_Adding_CRUD_Functionalities) ≫ |
|:----:|:----:|:----:|

# Full Stack Development

https://subscription.packtpub.com/book/web-development/9781805122463/14

# 312 Setting Up the Frontend for Our Spring Boot RESTful Web Service

This chapter explains the steps that are required to start the development of the frontend part of our car database application. We will first define the functionalities that we are developing. Then, we will do a mock-up of the UI. As a backend, we will use our Spring Boot application from Chapter 5, Securing Your Backend. We will begin development using the unsecured version of the backend. Finally, we will create the React app that we will use in our frontend development.

In this chapter, we will cover the following topics:

Mocking up the UI
Preparing the Spring Boot backend
Creating the React project for the frontend
Technical requirements
The Spring Boot application that we created in Chapter 5, Securing Your Backend, is required.

Node.js also has to be installed, and the code available at the following GitHub link will be required to follow along with the examples in this chapter: https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter12.

Mocking up the UI
In the first few chapters of this book, we created a car database backend that provides the RESTful API. Now, it is time to start building the frontend for our application.

We will create a frontend with the following specifications:

It lists cars from the database in a table and provides paging, sorting, and filtering.
There is a button that opens a modal form to add new cars to the database.
In each row of the car table, there is a button to edit the car or delete it from the database.
There is a link or button to export data from the table to a CSV file.
UI mock-ups are often created at the beginning of frontend development to provide customers with a visual representation of what the user interface will look like. Mock-ups are quite often done by designers and then provided to developers. There are lots of different applications for creating mock-ups, such as Figma, Balsamiq, and Adobe XD, or you can even use a pencil and paper. You can also create interactive mock-ups to demonstrate a number of functionalities.

If you have done a mock-up, it is much easier to discuss requirements with the client before you start to write any actual code. With the mock-up, it is also easier for the client to understand the idea of the frontend and suggest corrections for it. Changes to mock-ups are really easy and fast to implement, compared to modifications involving actual frontend source code.

The following screenshot shows the example mock-up of our car list frontend:

Figure 10.1 – The frontend mock-up 
Figure 12.1: The frontend mock-up

The modal form that is opened when the user presses the + CREATE button looks like the following:

Figure 10.2 – The frontend mock-up 
Figure 12.2: The modal form mock-up

Now that we have a mock-up of our UI ready, let’s look at how we can prepare our Spring Boot backend.

Preparing the Spring Boot backend
We will begin frontend development in this chapter with the unsecured version of our backend. Then:

In Chapter 13, Adding CRUD Functionalities, we will implement all the CRUD functionalities.
In Chapter 14, Styling the Frontend with MUI, we will continue to polish our UI using Material UI components.
Finally, in Chapter 16, Securing Your Application, we will enable security in our backend, make some modifications that are required, and implement authentication.
In Eclipse, open the Spring Boot application that we created in Chapter 5, Securing Your Backend. Open the SecurityConfig.java file that defines the Spring Security configuration. Temporarily comment out the current configuration and give everyone access to all endpoints. Refer to the following modifications:

@Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception
  {
    // Add this one
    http.csrf((csrf) -> csrf.disable()).cors(withDefaults())
        .authorizeHttpRequests((authorizeHttpRequests) -> 
             authorizeHttpRequests.anyRequest().permitAll());
    /* COMMENT THIS OUT
    http.csrf((csrf) -> csrf.disable()) 
        .cors(withDefaults())
        .sessionManagement((sessionManagement) ->
            sessionManagement.sessionCreationPolicy(\
                SessionCreationPolicy.STATELESS))
        .authorizeHttpRequests( (authorizeHttpRequests) -> 
            authorizeHttpRequests
        .requestMatchers(HttpMethod.POST, "/login").permitAll()
        .anyRequest().authenticated())
        .addFilterBefore(authenticationFilter, 
            UsernamePasswordAuthenticationFilter.class)
        .exceptionHandling((exceptionHandling) ->
            exceptionHandling.authenticationEntryPoint(
                exceptionHandler));
    */
    return http.build();
}

Copy

Explain
Now, if you start the MariaDB database, run the backend, and send the GET request to the http:/localhost:8080/api/cars endpoint, you should get all the cars in the response, as shown in the following screenshot:


Figure 12.3: The GET request

Now, we are ready to create our React project for the frontend.

Creating the React project for the frontend
Before we start coding the frontend, we have to create a new React app. We will use TypeScript in our React frontend:

Open PowerShell, or any other suitable terminal. Create a new React app by typing the following command:
npm create vite@4 

Copy

Explain
In this book, we are using Vite version 4.4. You can also use the latest version, but then you have to check for changes in the Vite documentation.

Name your project carfront, and select the React framework and TypeScript variant:

Figure 12.4: Frontend project

Move to the project folder and install dependencies by typing the following commands:
cd carfront
npm install

Copy

Explain
Install the MUI component library by typing the following command, which installs the Material UI core library and two Emotion libraries. Emotion is a library designed for writing CSS with JavaScript (https://emotion.sh/docs/introduction):
npm install @mui/material @emotion/react @emotion/styled

Copy

Explain
Also, install React Query v4 and Axios, which we will use for networking in our frontend:
npm install @tanstack/react-query@4
npm install axios

Copy

Explain
Run the app by typing the following command in the project’s root folder:
npm run dev

Copy

Explain
Open the src folder with Visual Studio Code and remove any superfluous code from the App.tsx file. The file extension is now .tsx because we are using TypeScript. Also, remove the App.css style sheet file import. We will use the MUI AppBar component in the App.tsx file to create the toolbar for our app.
We have already looked at the MUI AppBar in Chapter 11, Useful Third-Party Components for React, if you would like a reminder.

As shown in the code below, wrap the AppBar component inside the MUI Container component, which is a basic layout component that centers your app content horizontally. We can use the position prop to define the positioning behavior of the app bar. The value static means that the app bar is not fixed to the top when the user scrolls. If you use position= "fixed", it will fix the app bar at the top of the page. You also have to import all the MUI components that we are using:

import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import Container from '@mui/material/Container';
import CssBaseline from '@mui/material/CssBaseline';
function App() {
  return (
    <Container maxWidth="xl">
    <CssBaseline />
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6">
            Car Shop
          </Typography>
        </Toolbar>
      </AppBar>
    </Container>
  );
}
export default App;

Copy

Explain
The maxWidth prop defines the maximum width of our app, and we have used the largest value. We have also used the MUI CssBaseline component, which is used to fix inconsistencies across browsers, ensuring that the React app’s appearance is uniform across different browsers. It is typically included at the top level of your application to ensure that its styles are applied globally.

We will remove all predefined styling. Therefore, remove the index.css style sheet import from the main.tsx file. The code should look like the following:
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.tsx'
ReactDOM.createRoot(document.getElementById('root') as HTMLElement).
  render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)

Copy

Explain
Now, your frontend starting point should look like this:


Figure 12.5: Car Shop

We have now created the React project for our frontend and can continue with further development.

Summary
In this chapter, we started the development of our frontend using the backend that we created in Chapter 5, Securing Your Backend. We defined the functionalities of the frontend and created a mock-up of the UI. We started frontend development with an unsecured version of the backend and, therefore, made some modifications to our Spring Security configuration class. We also created the React app that we will use during development.

In the next chapter, we will add create, read, update, and delete (CRUD) functionalities to our frontend.

Questions
Why should you do a mock-up of the UI?
How do you disable Spring Security from the backend?
Further reading
There are many other good resources available for learning about UI design and MUI. A few are listed here:

Don’t Make Me Think, Revisited: A Common Sense Approach to Web Usability (3rd Edition), by Steve Krug (https://sensible.com/dont-make-me-think/)
MUI blog – the latest about MUI (https://mui.com/blog/)
Material UI GitHub repository (https://github.com/mui/material-ui)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e



| ≪ [ 211 Useful Third-Party Components for React ](/books/packtpub/2024/1202-Spring_Boot_3_React/211_Useful_Third-Party_Components_for_React) | 312 Setting Up the Frontend | [ 313 Adding CRUD Functionalities ](/books/packtpub/2024/1202-Spring_Boot_3_React/313_Adding_CRUD_Functionalities) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 312 Setting Up the Frontend
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/312_Setting_Up_the_Frontend
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:22
> .md Name: 312_setting_up_the_frontend.md

