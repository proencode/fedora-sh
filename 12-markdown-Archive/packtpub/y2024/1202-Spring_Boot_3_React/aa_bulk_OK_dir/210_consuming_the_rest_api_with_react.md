
| ≪ [ 209 Introduction to TypeScript ](/books/packtpub/2024/1202-Spring_Boot_3_React/209_Introduction_to_TypeScript) | 210 Consuming the REST API with React | [ 211 Useful Third-Party Components for React ](/books/packtpub/2024/1202-Spring_Boot_3_React/211_Useful_Third-Party_Components_for_React) ≫ |
|:----:|:----:|:----:|

# 210 Consuming the REST API with React

This chapter explains networking with React. This is a really important skill that we need in most React apps. We will learn about promises, which make asynchronous code cleaner and more readable. For networking, we will use the fetch and Axios libraries. As an example, we will use the OpenWeather and GitHub REST APIs to demonstrate how to consume RESTful web services with React. We will also see the React Query library in action.

In this chapter, we will cover the following topics:

Promises
Using the fetch API
Using the Axios library
Practical examples
Handling race conditions
Using the React Query library
Technical requirements
The following GitHub link will be required: https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter10.

Promises
The traditional way to handle an asynchronous operation is to use callback functions for the success or failure of the operation. If the operation succeeds, the success function is ­called; otherwise, the failure function is called. The following (abstract) example shows the idea of using a callback function:

function doAsyncCall(success,  failure) {
  // Do some API call
  if (SUCCEED)
    success(resp);
  else
    failure(err);
}
success(response) {
  // Do something with response
}
failure(error) {
  // Handle error
}
doAsyncCall(success, failure);

Copy

Explain
Nowadays, promises are a fundamental part of asynchronous programming in JavaScript. A promise is an object that represents the result of an asynchronous operation. The use of promises simplifies the code when you’re executing asynchronous calls. Promises are non-blocking. If you are using an older library for asynchronous operations that doesn’t support promises, the code becomes much more difficult to read and maintain. In that case, you will end up with multiple nested callbacks that are really hard to read. Error handling will also be hard because you will have to check for errors in each callback.

With promises, we can execute asynchronous calls if the API or library we are using to send requests supports promises. In the following example, an asynchronous call is made. When the response is returned, the callback function inside the then method is executed, taking the response as an argument:

doAsyncCall()
.then(response => // Do something with the response)

Copy

Explain
The then method returns a promise. A promise can be in one of three states:

Pending: Initial state
Fulfilled (or Resolved): Successful operation
Rejected: Failed operation
The following code demonstrates a simple promise object, where setTimeout simulates an asynchronous operation:

const myPromise = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("Hello");
  }, 500);
});

Copy

Explain
The promise is in the pending state when the promise object is created and while the timer is running. After 500 milliseconds, the resolve function is called with the value "Hello" and the promise enters the fulfilled state. If there is an error, the promise state changes to rejected, and that can be handled using the catch() function, which we’ll show later.

You can chain many instances of then together, which means that you can run multiple asynchronous operations one after another:

doAsyncCall()
.then(response => // Get some data from the response)
.then(data => // Do something with the data

Copy

Explain
You can also add error handling to promises by using catch(). The catch() is executed if any error occurs in the preceding then chain:

doAsyncCall()
.then(response => // Get some data from the response)
.then(data => // Do something with data)
.catch(error => console.error(error))

Copy

Explain
async and await
There is a more modern way to handle asynchronous calls that involves async/await, which was introduced in ECMAScript 2017. The async/await method is based on promises. To use async/await, you must define an async() function that can contain await expressions.

The following is an example of an asynchronous call containing async/await. As you can see, you can write the code in a similar way to synchronous code:

const doAsyncCall = async () => {
  const response = await fetch('http ://someapi .com');
  const data = await response.json();
  // Do something with the data
}

Copy

Explain
The fetch() function returns a promise, but now it is handled using await instead of the then method.

For error handling, you can use try...catch with async/await, as shown in the following example:

const doAsyncCall = async () => {
  try {
    const response = await fetch('http ://someapi .com');
    const data = await response.json();
    // Do something with the data
  }
  catch(err) {
    console.error(err);
  }
}

Copy

Explain
Now that we understand promises, we can start learning about the fetch API, which we can use to make requests in our React apps.

Using the fetch API
With the fetch API, you can make web requests. The idea of the fetch API is similar to the traditional XMLHttpRequest or jQuery Ajax API, but the fetch API also supports promises, which makes it more straightforward to use. You don’t have to install any libraries if you are using fetch and it is supported by modern browsers natively.

The fetch API provides a fetch() method that has one mandatory argument: the path of the resource you are calling. In the case of a web request, it will be the URL of the service. For a simple GET method call, which returns a response, the syntax is as follows:

fetch('http ://someapi .com')
.then(response => response.json())
.then(data => console.log(data))
.catch(error => console.error(error))

Copy

Explain
The fetch() method returns a promise that contains the response. You can use the json() method to extract the JSON data from a response, and this method also returns a promise.

The response that is passed to the first then statement is an object that contains the properties ok and status, which we can use to check whether the request was successful. The ok property value is true if the response status is in the form 2XX:

fetch('http ://someapi .com')
.then(response => { 
  if (response.ok)
    // Successful request -> Status 2XX
  else
    // Something went wrong -> Error response
})
.then(data => console.log(data))
.catch(error => console.error(error))

Copy

Explain
To use another HTTP method, such as POST, you must define it in the second argument of the fetch() method. The second argument is an object where you can define multiple request settings. The following source code makes the request using the POST method:

fetch('http ://someapi .com', {method: 'POST'})
.then(response => response.json())
.then(data => console.log(data))
.catch(error => console.error(error))

Copy

Explain
You can also add headers inside the second argument. The following fetch() call contains the 'Content-Type':'application/json' header. It is recommended that you add the 'Content-Type' header because then the server can interpret the request body correctly:

fetch('http ://someapi .com',
  {
    method: 'POST',
    headers: {'Content-Type':'application/json'}
  }
.then(response => response.json())
.then(data => console.log(data))
.catch(error => console.error(error))

Copy

Explain
If you have to send JSON-encoded data inside the request body, the syntax to do so is as follows:

fetch('http ://someapi. com',
{
  method: 'POST',
  headers: {'Content-Type':'application/json'},
  body: JSON.stringify(data)
}
.then(response => response.json())
.then(data => console.log(data))
.catch(error => console.error(error))

Copy

Explain
The fetch API is not the only way to execute requests in the React app. There are other libraries that you can use as well. In the next section, we will learn how to use one such popular library: axios.

Using the Axios library
You can also use other libraries for network calls. One very popular library is axios (https://github.com/axios/axios), which you can install in your React app with npm:

npm install axios

Copy

Explain
You must add the following import statement to your React component before using it:

import axios from 'axios';

Copy

Explain
The axios library has some benefits, such as automatic transformation of the JSON data, so you don’t need the json() function when using axios. The following code shows an example call being made using axios:

axios.get('http ://someapi .com')
.then(response => console.log(response))
.catch(error => console.log(error))

Copy

Explain
The axios library has its own call methods for the different HTTP methods. For example, if you want to make a POST request and send an object in the body, axios provides the axios.post() method:

axios.post('http ://someapi .com', { newObject })
.then(response => console.log(response))
.catch(error => console.log(error))

Copy

Explain
You can also use the axios() function and pass a configuration object that specifies the request details, such as the method, header, data, and URL:

const response = await axios({
  method: 'POST',
  url: 'https ://myapi .com/api/cars',
  headers: { 'Content-Type': 'application/json' },
  data: { brand: 'Ford', model: 'Ranger' },
});

Copy

Explain
The example code above sends a POST request to the https ://myapi .com/api/cars endpoint. The request body contains an object and Axios automatically stringifies the data.

Now, we are ready to look at a few practical examples involving networking with React.

Practical examples
In this section, we will go through two examples of using public REST APIs in your React apps. In the first example, we use the OpenWeather API to fetch the current weather for London and render it in the component. In the second example, we use the GitHub API and allow the user to fetch repositories by keyword.

OpenWeather API
First, we will make a React app that shows the current weather in London. We will show the temperature, description, and weather icon in our app. This weather data will be fetched from OpenWeather (https://openweathermap.org/).

You need to register with OpenWeather to get an API key. A free account will be sufficient for our needs. Once you have registered, navigate to your account information to find the API keys tab. There, you’ll see the API key that you need for your React weather app:


Figure 10.1: The OpenWeather API key

Your API key will be activated automatically, up to 2 hours after your successful registration, so you may have to wait a while before you can use it in this section.

Let’s create a new React app with Vite:

Open a terminal in Windows or Terminal in macOS/Linux, and type the following command:
npm create vite@latest

Copy

Explain
Name your app weatherapp and select the React framework and JavaScript variant.
Navigate to the weatherapp folder and install dependencies:
cd weatherapp
npm install

Copy

Explain
Start your app with the following command:
npm run dev

Copy

Explain
Open your project folder with VS Code and open the App.jsx file in the editor view. Remove all the code inside the fragment (<></>)and remove unused imports. Now, your source code should look as follows:
import './App.css'
function App() {
  return (
    <>
    </>
  );
}
export default App;

Copy

Explain
First, we must add the states that are needed to store response data. We will show the temperature, description, and weather icon in our app. We have three related values, so it is better to create one state that is an object instead of creating multiple individual states:
import { useState } from 'react';
import './App.css';
function App() {
  const [weather, setWeather] = useState({
      temp: '', desc: '', icon: ''
  });
  return (
    <>
    </>
  );
}
export default App;

Copy

Explain
When you are using a REST API, you should inspect the response so you can see the format of the JSON data. Here is the address that returns the current weather for London: https://api.openweathermap.org/data/2.5/weather?q=London&units=Metric&APIkey=YOUR_KEY.
If you copy the URL into a browser, you can view the JSON response data:


Figure 10.2: Get weather by city

From the response, you can see that temp can be accessed using main.temp. You can also see that description and icon are inside the weather array, which has only one element, and that we can access it using weather[0].description and weather[0].icon.

We will implement the fetch call in the next few steps, inside the useEffect hook function. Import useEffect from React:
import { useState, useEffect } from 'react';

Copy

Explain
The REST API call is executed using fetch in the useEffect hook function, using an empty array as the second argument. Therefore, the fetch is done once, after the first render. After a successful response, we save the weather data to the states. Once the state values have been changed, the component will be re-rendered. The following is the source code for the useEffect hook function. It will execute the fetch() function once after the first render (Note! Use your own API key in the code.):
useEffect(() => {   
  fetch('https://api.openweathermap.org/data/2.5/
         weather?q=London&APIKey=YOUR_API_KEY&units=metric')
  .then(response => response.json())
  .then(result => {
    setWeather({
      temp: result.main.temp, 
      desc: result.weather[0].main, 
      icon: result.weather[0].icon
    });
  })
  .catch(err => console.error(err))
}, [])

Copy

Explain
Once you have added the useEffect function, the request is executed after the first render. We can check that everything has been done correctly using React Developer Tools. Open your app in a browser and open your React Developer Tools Components tab. Now, you can see that the states have been updated with the values from the response:

Figure 10.3: Weather component

You can also check that the request status is 200 OK from the Network tab.

Finally, we will implement the return statement to show the weather values. We will use conditional rendering here; otherwise, we will get an error because we don’t have image code in the first render call and the image upload won’t succeed.
To show the weather icon, we must add https://openweathermap.org/img/wn/ before the icon code, and @2x.png after the icon code.

You can find information about icons in the OpenWeather documentation: https://openweathermap.org/weather-conditions.

Then, we can set the concatenated image URL as the img element’s src attribute. Temperature and description are shown in the paragraph element. °C is the degrees Celsius symbol:

if (weather.icon) {
  return (
    <>
      <p>Temperature: {weather.temp} °C</p>
      <p>Description: {weather.desc}</p>
      <img src={`http://openweathermap.org/img/wn/${weather.                 icon}@2x.png`}
        alt="Weather icon" />
    </>
  );
}
else {
  return <div>Loading...</div>
}

Copy

Explain
Now, your app should be ready. When you open it in a browser, it should look as follows:

Figure 10.4: WeatherApp

The source code for the entire App.jsx file is as follows:

import { useState, useEffect } from 'react';
import './App.css'
function App() {
  const [weather, setWeather] = useState({temp: '', desc: '', icon: ''});
 
  useEffect(() => { 
    fetch('https://api.openweathermap.org/data/2.5/weather?q=\
          London&APIKey=YOUR_API_KEY&units=metric')
    .then(response => response.json())
    .then(result => {
      setWeather({
        temp: result.main.temp, 
        desc: result.weather[0].main, 
        icon: result.weather[0].icon
      });
    })
    .catch(err => console.error(err))
  }, [])
  if (weather.icon) {
    return (
      <>
        <p>Temperature: {weather.temp} °C</p>
        <p>Description: {weather.desc}</p>
        <img src={
            `https ://openweathermap .org/img/wn/${weather.icon}@2x.png`
        }
        alt="Weather icon" />
      </>
    );
  }
  else {
    return <>Loading...</>
  }
}
export default App

Copy

Explain
In our example, we checked that the weather icon was loaded to check if the fetch was completed. This is not the optimal solution because if the fetch ends in an error, our component still renders a loading message. The boolean state is used a lot in scenarios like this, but it doesn’t solve the problem either. The best solution would be a status that indicates the exact state of the request (pending, resolved, rejected). You can read more about this in Kent C. Dodds’ blog post, Stop using isLoading Booleans: https://kentcdodds.com/blog/stop-using-isloading-booleans. This problem is solved by the React Query library, which we will use later in this chapter.

GitHub API
In the second example, we are going to create an app that uses the GitHub API to fetch repositories by keyword. The user enters a keyword, and we fetch repositories that contain that keyword. We will use the axios library for web requests, and we will also practice using TypeScript in this example.

Let’s first see how you can send a GET request using axios with TypeScript. You can make a GET request and specify the expected data type using TypeScript generics, as shown in the following example:

import axios from 'axios';
type MyDataType = {
  id: number;
  name: string;
}
axios.get<MyDataType>(apiUrl)
.then(response => console.log(response.data))
.catch(err => console.error(err));

Copy

Explain
If you try to access some field that is not present in the expected data type, you will get an error early in the development phase. At this point, it is important to understand that TypeScript is compiled to JavaScript and all type information is removed. Therefore, TypeScript doesn’t have a direct impact on runtime behavior. If a REST API returns data of a different type than expected, TypeScript won’t catch this as a runtime error.

Now, we can start to develop our GitHub app:

Create a new React app called restgithub using Vite, selecting the React framework and TypeScript variant.
Install dependencies, start the app, and open the project folder with VS Code.
Install axios using the following npm command in your project folder:
npm install axios

Copy

Explain
Remove the extra code inside the fragment <></> from the App.tsx file. Your App.tsx code should look as follows:
import './App.css';
function App() {
  return (
    <>
    </>
  );
}
export default App;

Copy

Explain
The URL of the GitHub REST API to search repositories is as follows: https://api.github.com/search/repositories?q={KEYWORD}.

You can find the GitHub REST API documentation at https://docs.github.com/en/rest.

Let’s inspect the JSON response by typing the URL into a browser and using the react keyword:


Figure 10.5: GitHub REST API

From the response, we can see that repositories are returned as a JSON array called items. From the individual repositories, we will show the full_name and html_url values.

We will present the data in the table and use the map() function to transform the values into table rows, as shown in Chapter 8. The id can be used as a key for a table row.
We are going to make the REST API call with the keyword from the user input. One way to implement this is to create an input field and button. The user types the keyword into the input field, and the REST API call is made when the button is pressed.

We can’t make the REST API call in the useEffect() hook function because, in that phase, the user input isn’t available when the component is rendered the first time.

We will create two states, one for the user input and one for the data from the JSON response. When we are using TypeScript, we have to define a type for the repository, as shown in the following code. The repodata state is an array of Repository type because repositories are returned as JSON arrays in the response. We only need to access three fields; therefore, only these fields are defined in the type. We will also import axios, which we’ll use later when sending a request:

import { useState } from 'react';
import axios from 'axios';
import './App.css';
type Repository = {
  id: number;
  full_name: string;
  html_url: string;
};
function App() {
  const [keyword, setKeyword] = useState('');
  const [repodata, setRepodata] = useState<Repository[]>([]);
  return (
    <>
    </>
  );
}
export default App;

Copy

Explain
Next, we will implement the input field and the button in the return statement. We also have to add a change listener to our input field to be able to save the input value to a state called keyword. The button has a click listener, which invokes the function that will make the REST API call with the given keyword:
const handleClick = () => {
  // REST API call
}
return (
  <>
    <input
      value={keyword}
      onChange={e => setKeyword(e.target.value)} 
    />
    <button onClick={handleClick}>Fetch</button>
  </>
);

Copy

Explain
In the handleClick() function, we will concatenate the url and keyword states using template literals (Note! Use backticks ``). We will use the axios.get() method to send a request. As we learned earlier, Axios does not require the .json() method to be called on the response. Axios automatically parses the response data, and then we save the items array from the response data to the repodata state. We also use catch() to handle errors. Since we are using TypeScript, we will define the expected data type in the GET request. We have seen that the response is an object that contains an item property. The content of the item property is an array of repository objects; therefore, the data type is <{ items: Repository[] }>:
const handleClick = () => {
  axios.get<{ items: Repository[] }> (`https://api.github.com/
              search/repositories?q=${keyword}`)
  .then(response => setRepodata(response.data.items))
  .catch(err => console.error(err))
}

Copy

Explain
In the return statement, we will use the map() function to transform the data state into table rows. The url property of a repository will be the href value of the <a> element. Each repository has a unique id property, which we can use as a key for a table row. We use conditional rendering to handle cases where the response doesn’t return any repositories:
return (
  <>
    <input
      value={keyword}
      onChange={e => setKeyword(e.target.value)} 
    />
    <button onClick={handleClick}>Fetch</button>
    {repodata.length === 0 ? (
      <p>No data available</p>
    ) : (
      <table>
        <tbody>
          {repodata.map(repo => (
            <tr key={repo.id}>
              <td>{repo.full_name}</td>
              <td>
                <a href={repo.html_url}>{repo.html_url}</a>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    )} 
  </>
);

Copy

Explain
The following screenshot shows the final app upon using the react keyword in the REST API call:

Figure 10.6: GitHub REST API

The source code for the App.jsx file looks as follows:

import { useState } from 'react';
import axios from 'axios';
import './App.css';
type Repository = {
  id: number;
  full_name: string;
  html_url: string;
};
function App() {
  const [keyword, setKeyword] = useState('');
  const [repodata, setRepodata] = useState<Repository[]>([]);
  const handleClick = () => {
    axios.get<{ items: Repository[] 
      }>(`https://api.github.com/search/repositories?q=${keyword}`)
    .then(response => setRepodata(response.data.items))
    .catch(err => console.error(err));
  }
  
  return (
    <>
      <input
        value={keyword}
        onChange={e => setKeyword(e.target.value)} 
      />
      <button onClick={handleClick}>Fetch</button>
      {repodata.length === 0 ? (
        <p>No data available</p>
      ) : (
        <table>
          <tbody>
            {repodata.map((repo) => (
              <tr key={repo.id}>
                <td>{repo.full_name}</td>
                <td>
                  <a href={repo.html_url}>{repo.html_url}</a>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </>
  );
}
export default App;

Copy

Explain
There is an API rate limit (number of daily requests without authentication) for the GitHub API, so if your code stops working, the reason might be here. The search endpoint that we are using has a limit of 10 requests per minute. If you exceed the limit, you have to wait one minute.

Handling race conditions
If your component makes several requests quickly, it can lead to a race condition that can create unpredictable or incorrect results. Network requests are asynchronous; therefore, requests don’t necessarily finish in the same order as they were sent.

The following example code sends a network request when the props.carid value changes:

import { useEffect, useState } from 'react';
function CarData(props) {
  const [data, setData] = useState({});
  useEffect(() => {
    fetch(`https ://carapi .com/car/${props.carid}`)    .then(response => response.json())
    .then(cardata => setData(cardata))
  }, [props.carid]);
  
  if (data) {
    return <div>{data.car.brand}</div>;
  } else {
    return null;
  }
continue...

Copy

Explain
Now, if carid changes quickly multiple times, the data that is rendered might not be from the last request that was sent.

We can use the useEffect cleanup function to avoid race conditions. First, we create a boolean variable named ignore inside the useEffect(), with an initial value of false. Then, we update the ignore variable value to true in the cleanup function. In the state update, we check the value of the ignore variable, and the state is updated only if the value is false, which means that no new value has replaced props.carid and the effect is not cleaned up:

import { useEffect, useState } from 'react';
function CarData(props) {
  const [data, setData] = useState({});
  useEffect(() => {
    let ignore = false;
    fetch(`https ://carapi .com/car/${props.carid}`)
    .then(response => response.json())
    .then(cardata => { 
      if (!ignore) {
        setData(cardata)
      }
  });
    return () => {
      ignore = true;
    };
  }, [props.carid]);
  if (data) {
    return <div>{data.car.brand}</div>;
  } else {
    return null;
  }
continue...

Copy

Explain
Now, each time a component is re-rendered, the cleanup function is called and ignore is updated to true, and the effect is cleaned up. Only the result from the last request is rendered, and we can avoid race conditions.

React Query, which we will start to use next, provides some mechanisms for handling race conditions, such as concurrency control. It takes care that only one request is sent at a time for a given query key.

Using the React Query library
In proper React apps where you make a lot of network calls, the use of third-party networking libraries is recommended. The two most popular libraries are React Query (https://tanstack.com/query), also known as Tanstack Query, and SWR (https://swr.vercel.app/). These libraries provide a lot of useful features, such as data caching and performance optimization.

In this section, we will learn how you can use React Query to fetch data in your React app. We will create a React app that fetches repositories from the GitHub REST API using the react keyword:

First, create a React app called gitapi using Vite and select the React framework and JavaScript variant. Install dependencies and move to your project folder.
Next, install React Query and axios using the following commands in your project folder (Note! In this book, we are using Tanstack Query v4):
// install v4
npm install @tanstack/react-query@4
npm install axios

Copy

Explain
Remove the extra code inside the fragment <></> from the App.jsx file. Your App.jsx code should look as follows:
import './App.css';
function App() {
  return (
    <>
    </>
  );
}
export default App;

Copy

Explain
React Query provides the QueryClientProvider and QueryClient components, which handle data caching. Import these components into your App component. Then, create an instance of QueryClient and render QueryClientProvider in our App component:
import './App.css';
import { QueryClient, QueryClientProvider } from 
  '@tanstack/react-query';
const queryClient = new QueryClient();
function App() {
  return (
    <>
      <QueryClientProvider client={queryClient}>
      </QueryClientProvider>
    </>
  )
}
export default App;

Copy

Explain
React Query provides the useQuery hook function, which is used to invoke network requests. The syntax is the following:

const query = useQuery({ queryKey: ['repositories'], queryFn:
  getRepositories })

Copy

Explain
Note that:

queryKey is a unique key for a query and it is used for caching and refetching data.
queryFn is a function to fetch data, and it should return a promise.
The query object that the useQuery hook returns contains important properties, such as the status of the query:

const { isLoading, isError, isSuccess } = useQuery({ queryKey:
  ['repositories'], queryFn: getRepositories })

Copy

Explain
The possible status values are the following:

isLoading: The data is not yet available.
isError: The query ended with an error.
isSuccess: The query ended successfully and query data is available.
The query object’s data property contains the data that the response returns.

With this information, we can continue our GitHub example using useQuery.

We will create a new component for fetching data. Create a new file called Repositories.jsx in the src folder, and fill it with the following starter code:
function Repositories() {
  return (
    <> </>
  )
}
export default Repositories;

Copy

Explain
Import the useQuery hook and create a function called getRepositories() that invokes axios.get() on the GitHub REST API. Here, we use async/await with Axios. Call the useQuery hook function and make the value of the queryFn property our fetch function, getRepositories:
import { useQuery } from '@tanstack/react-query';
import axios from 'axios';
function Repositories() {
  const getRepositories = async () => {
    const response = await axios.get("https://api.github\
      .com/search/repositories?q=react");
    return response.data.items;
  }
  const { isLoading, isError, data } = useQuery({
    queryKey: ['repositories'],
    queryFn: getRepositories,
  })
  return (
    <></>
  )
}
export default Repositories;

Copy

Explain
Next, implement the conditional rendering. The repositories are rendered when the data is available. We also render a message if the REST API call ends with an error:
// Repositories.jsx
if (isLoading) {
  return <p>Loading...</p>
}
if (isError) {
  return <p>Error...</p>
}
else {
  return (
    <table>
      <tbody>
      {
      data.map(repo =>
        <tr key={repo.id}>
          <td>{repo.full_name}</td>
          <td>
            <a href={repo.html_url}>{repo.html_url}</a>
          </td>
        </tr>)
      }
    </tbody>
    </table>
  )
}

Copy

Explain
In the final step, import our Repositories component into the App component and render it inside the QueryClientProvider component:
// App.jsx
import './App.css'
import Repositories from './Repositories'
import { QueryClient, QueryClientProvider } from '@tanstack/react-
  query'
const queryClient = new QueryClient()
function App() {
  return (
    <>
      <QueryClientProvider client={queryClient}>
        <Repositories />
      </QueryClientProvider>
    </>
  )
}
export default App

Copy

Explain
Now, your app should look like the following, and repositories are fetched using the React Query library. We also managed to handle request status easily using its built-in features. We don’t need any states to store response data because React Query handles data management and caching:

Figure 10.7: Tanstack Query

You should also see that refetching is done automatically by React Query when the browser is refocused (when the user returns to the application’s window or tab). This is a good feature; you can see the updated data each time you refocus the browser. You can change this default behavior globally or per query.

Refetching is also done automatically when the network is reconnected, or a new instance of the query is mounted (component is inserted into the DOM).

React Query has an important property called staleTime that defines how long data is considered fresh before it becomes stale and triggers a re-fetch in the background. By default, staleTime is 0, which means that data becomes stale immediately after a successful query. By setting the staleTime value, you can avoid unnecessary re-fetches if your data is not changing so often. The following example shows how you can set staleTime in your query:

const { isLoading, isError, data } = useQuery({
  queryKey: ['repositories'],
  queryFn: getRepositories,
  staleTime: 60 * 1000, // in milliseconds -> 1 minute
})

Copy

Explain
There is also a cacheTime property that defines when inactive queries are garbage collected, and the default time is 5 minutes.

React Query simplifies handling data mutations by providing a useMutation hook for creating, updating, and deleting data, along with built-in error handling and cache invalidation. Below is an example of useMutation that adds a new car. Now, because we want to add a new car, we use the axios.post() method:

// import useMutation
import { useMutation } from '@tanstack/react-query'
// usage
const mutation = useMutation({
  mutationFn: (newCar) => {
    return axios.post('api/cars', newCar);
  },
  onError: (error, variables, context) => {
    // Error in mutation
  },
  onSuccess: (data, variables, context) => {
    // Successful mutation
  },
})

Copy

Explain
In the case of updating or deleting, you can use the axios.put(), axios.patch(), or axios.delete() methods.

The mutationFn property value is a function that sends a POST request to the server and returns a promise. React Query mutation also provides side effects, such as onSuccess and onError, that can be used in mutations. onSuccess is used to define a callback function that can perform any necessary actions, such as updating the UI or displaying a success message, based on a successful mutation response. onError is used to specify a callback function that will be executed if the mutation operation encounters an error.

Then, we can execute mutation in the following way:

mutation.mutate(newCar);

Copy

Explain
QueryClient provides an invalidateQueries() method that can be used to invalidate queries in the cache. If the query is invalidated in the cache, it will be fetched again. In the previous example, we used useMutation to add a new car to the server. If we have a query that fetches all cars and the query ID is cars, we can invalidate it in the following way after the new car has been added successfully:

import { useQuery, useMutation, useQueryClient } from
  '@tanstack/react-query'
const queryClient = useQueryClient();
// Fetch all cars
const { data } = useQuery({ 
  queryKey: ['cars'], queryFn: fetchCars 
})
// Add a new car
const mutation = useMutation({
  mutationFn: (newCar) => {
    return axios.post('api/cars', newCar);
  },
  onError: (error, variables, context) => {
    // Error in mutation
  },
  onSuccess: (data, variables, context) => {
    // Invalidate cars query -> refetch
    queryClient.invalidateQueries({ queryKey: ['cars'] });
  },
})

Copy

Explain
This means that the cars will be fetched again after a new car has been added to the server.

By using React Query, we have to write less code to get proper error handling, data caching, and so on, due to the built-in functionalities that it provides. Now that we have learned about networking with React, we can utilize these skills in our frontend implementation.

Summary
In this chapter, we focused on networking with React. We started with promises, which make asynchronous network calls easier to implement. This is a cleaner way to handle calls, and it’s much better than using traditional callback functions.

In this book, we are using the Axios and React Query libraries for networking in our frontend. We went through the basics of using these libraries. We implemented two React example apps using the fetch API and Axios to call REST APIs, and we presented the response data in the browser. We learned about race conditions and looked at how to fetch data using the React Query library.

In the next chapter, we will look at some useful React components that we are going to use in our frontend.

Questions
What is a promise?
What are fetch and axios?
What is React Query?
What are the benefits of using a networking library?
Further reading
There are other good resources available for learning about promises and asynchronous operations. A couple are as follows:

Using promises, by MDN web docs (https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Using_promises)
Fetch Standard (https://fetch.spec.whatwg.org/)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e



| ≪ [ 209 Introduction to TypeScript ](/books/packtpub/2024/1202-Spring_Boot_3_React/209_Introduction_to_TypeScript) | 210 Consuming the REST API with React | [ 211 Useful Third-Party Components for React ](/books/packtpub/2024/1202-Spring_Boot_3_React/211_Useful_Third-Party_Components_for_React) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 210 Consuming the REST API with React
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/210_Consuming_the_REST_API_with_React
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:22
> .md Name: 210_consuming_the_rest_api_with_react.md

