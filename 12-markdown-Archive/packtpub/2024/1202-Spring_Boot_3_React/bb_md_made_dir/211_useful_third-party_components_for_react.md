
| ≪ [ 210 Consuming the REST API with React ](/books/packtpub/2024/1202-Spring_Boot_3_React/210_Consuming_the_REST_API_with_React) | 211 Useful Third-Party Components for React | [ 312 Setting Up the Frontend ](/books/packtpub/2024/1202-Spring_Boot_3_React/312_Setting_Up_the_Frontend) ≫ |
|:----:|:----:|:----:|

# 211 Useful Third-Party Components for React

React is component-based, and we can find a lot of useful third-party components that we can use in our apps. In this chapter, we will look at several components that we are going to use in our frontend. We will examine how to find suitable components and how you can then use them in your own apps.

In this chapter, we will cover the following topics:

Installing third-party React components
Working with AG Grid
Using the Material UI component library
Managing routing with React Router
Technical requirements
Node.js must be installed. The following GitHub link for this chapter will also be required: https://github.com/PacktPublishing/Full-Stack-Development-with-Spring-Boot-3-and-React-Fourth-Edition/tree/main/Chapter11.

Installing third-party React components
There are lots of useful React components available for different purposes. You can save time by not doing everything from scratch. Well-known third-party components are also well tested, and there is good community support for them.

Our first task is to find a suitable component for our needs. One good site to search for components on is JS.coach (https://js.coach/). You just have to type in a keyword, search, and select React from the list of libraries.

In the following screenshot, you can see search results for table components for React:


Figure 11.1: JS.coach

Another good source for React components is awesome-react-components: https://github.com/brillout/awesome-react-components.

Components often have good documentation that helps you use them in your own React app. Let’s see how we can install a third-party component in our app and start to use it:

Navigate to the JS.coach site, type date in the search input field, and filter by React.
In the search results, you will see a list component called react-date-picker (with two hyphens). Click the component link to see more detailed information about the component.
You should find the installation instructions on the info page, and some simple examples of how to use the component. You should also check that the development of a component is still active. The info page often provides the address of a component’s website or GitHub repository, where you can find the full documentation. You can see the info page for react-date-picker in the following screenshot:

Figure 11.2: react-date-picker info page

As you can see from the component’s info page, components are installed using the npm package. The syntax of the command to install components looks like this:
npm install component_name

Copy

Explain
Or, if you use yarn, it looks like this:

yarn add component_name

Copy

Explain
The npm install and yarn add commands save the component’s dependency to the package.json file that is in the root folder of your React app.

Now, we will install the react-date-picker component to the myapp React app that we created in Chapter 7, Setting Up the Environment and Tools – Frontend. Move to your app root folder and type the following command:

npm install react-date-picker

Copy

Explain
If you open the package.json file from your app root folder, you can see that the component has now been added to the dependencies section, as illustrated in the following code snippet:
"dependencies": {
  "react": "^18.2.0",
  "react-dom": "^18.2.0"
  "react-date-picker": "^10.0.3",
},

Copy

Explain
As shown, you can find the installed version number from the package.json file.

If you want to install a specific version of a component, you can use the following command:

npm install component_name@version

Copy

Explain
And if you want to remove an installed component from your React app, you can use the following command:

npm uninstall component_name

Copy

Explain
Or, if you use yarn:

yarn remove component_name

Copy

Explain
You can see what components are outdated by using the following command in your project root directory. If the output is empty, all components are in the latest version:

npm outdated

Copy

Explain
You can update all outdated components by using the following command in your project root directory:

npm update

Copy

Explain
You should first ensure that there are no changes that might break your existing code. Proper components have a changelog or release notes available, where you can see what has changed in the new version.

Installed components are saved to the node_modules folder in your app. If you open that folder, you should find the react-date-picker folder, as illustrated in the following screenshot:

Figure 11.3: node_modules

You can get the list of your project dependencies by using the following npm command:

npm list

Copy

Explain
If you push your React app source code to GitHub, you should not include the node_modules folder because it contains a significant number of files. The Vite project contains a .gitignore file that excludes the node_modules folder from the repository. A section of the .gitignore file looks like this, and you can see that node_modules is found in the file:

# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
pnpm-debug.log*
lerna-debug.log*
node_modules
dist
dist-ssr
*.local

Copy

Explain
The idea is that when you clone a React app from the GitHub repository, you type the npm install command, which reads dependencies from the package.json file and downloads them to your app.

To start using your installed component, import it into the file(s) where you want to use it. The code to achieve this is illustrated in the following snippet:
import DatePicker from 'react-date-picker';

Copy

Explain
You have now learned how to install React components in your React app. Next, we will start to use a third-party component in our React app.

Working with AG Grid
AG Grid (https://www.ag-grid.com/) is a flexible data grid component for React apps. It is like a spreadsheet that you can use to present your data, and it can contain interactivity. It has many useful features, such as filtering, sorting, and pivoting. We will use the Community version, which is free (under an MIT license).

Let’s modify the GitHub REST API app that we created in Chapter 10, Consuming the REST API with React. Proceed as follows:

To install the ag-grid community component, open the command line or terminal and move to the restgithub folder, which is the root folder of the app. Install the component by typing the following command:
npm install ag-grid-community ag-grid-react

Copy

Explain
Open the App.tsx file with Visual Studio Code (VS Code) and remove the table element inside the return statement. The App.tsx file should now look like this:
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
      }>(`https ://api.github .com/search/repositories?q=${keyword}`)
    .then(response => setRepodata(response.data.items))
    .catch(err => console.error(err));
  }
  
  return (
    <>
      <input
        value={keyword}
        onChange={e => setKeyword(e.target.value)} />
      <button onClick={handleClick}>Fetch</button>
    </>
  );
export default App;

Copy

Explain
Import the ag-grid component and stylesheets by adding the following lines of code at the beginning of the App.tsx file:
import { AgGridReact } from 'ag-grid-react';
import 'ag-grid-community/styles/ag-grid.css';
import 'ag-grid-community/styles/ag-theme-material.css';

Copy

Explain
ag-grid provides different predefined styles. We are using a Material Design style.

Next, we will add the imported AgGridReact component to the return statement. To fill the ag-grid component with data, you have to pass the rowData prop to the component. Data can be an array of objects, so we can use our state, repodata. The ag-grid component should be wrapped inside the div element that defines the style. The code is illustrated in the following snippet:
return (
    <div className="App">
      <input value={keyword}
        onChange={e => setKeyword(e.target.value)} />
      <button onClick={fetchData}>Fetch</button>
      <div className="ag-theme-material"
        style={{height: 500, width: 850}}>
        <AgGridReact
          rowData={repodata}
        />
      </div>
    </div>
  );

Copy

Explain
Next, we will define columns for the ag-grid. We will define a state called columnDefs, which is an array of column definition objects. ag-grid provides a ColDef type that we can use here. In a column object, you have to define the data accessor by using the required field props. The field value is the property name in the REST API response data that the column should display:
// Import ColDef type
import { ColDef } from 'ag-grid-community';
// Define columns
const [columnDefs] = useState<ColDef[]>([
    {field: 'id'},
    {field: 'full_name'},
    {field: 'html_url'},
]);

Copy

Explain
Finally, we will use the AG Grid columnDefs prop to define these columns, as follows:
<AgGridReact
  rowData={data}
  columnDefs={columnDefs}
/>

Copy

Explain
Run the app and open it in a web browser. The table looks quite nice by default, as shown in the following screenshot:

Figure 11.4: ag-grid component

Sorting and filtering are disabled by default, but you can enable them using the sortable and filter props in ag-grid columns, as follows:
const [columnDefs] = useState<ColDef[]>([
  {field: 'id', sortable: true, filter: true},
  {field: 'full_name', sortable: true, filter: true},
  {field: 'html_url', sortable: true, filter: true}
]);

Copy

Explain
Now, you can sort and filter any columns in the grid by clicking the column header, as illustrated in the following screenshot:


Figure 11.5: ag-grid filtering and sorting

You can also enable paging and set the page size in ag-grid by using the pagination and paginationPageSize props, as follows:
<AgGridReact
  rowData={data}
  columnDefs={columnDefs}
  pagination={true}
  paginationPageSize={8}
/>

Copy

Explain
Now, you should see pagination in your table, as illustrated in the following screenshot:


Figure 11.6: ag-grid pagination

You can find documentation for different grid and column props from the AG Grid website: https://www.ag-grid.com/react-data-grid/column-properties/.

The cellRenderer prop can be used to customize the content of a table cell. The following example shows how you can render a button in a grid cell:
// Import ICellRendererParams
import { ICellRendererParams } from 'ag-grid-community';
// Modify columnDefs
const columnDefs = useState<ColDef[]>([
  {field: 'id', sortable: true, filter: true},
  {field: 'full_name', sortable: true, filter: true},
  {field: 'html_url', sortable: true, filter: true},
  {
    field: 'full_name',
    cellRenderer: (params: ICellRendererParams) => (
      <button
        onClick={() => alert(params.value)}>
        Press me
      </button>
    ),
  },
]);

Copy

Explain
The function in the cell renderer accepts params as an argument. The type of params is ICellRendererParams, which we have to import. The params.value will be the value of the full_name cell, which is defined in the field property of the column definition. If you need access to all values in a row, you can use params.row, which is the whole row object. This is useful if you need to pass a whole row of data to some other component. When the button is pressed, it will open an alert that shows the value of the full_name cell.

Here is a screenshot of the table with buttons:


Figure 11.7: Grid with buttons

If you press any button, you should see an alert that shows the value of the full_name cell.

The button column has a Full_name header because, by default, the field name is used as the header name. If you want to use something else, you can use the headerName prop in the column definition, as shown in the following code:
const columnDefs: ColDef[] = [
  { field: 'id', sortable: true, filter: true },
  { field: 'full_name', sortable: true, filter: true },
  { field: 'html_url', sortable: true, filter: true },
  {
    headerName: 'Actions',
    field: 'full_name',
    cellRenderer: (params: ICellRendererParams) => (
      <button
        onClick={() => alert(params.value)}>
        Press me
      </button>
    ),
  },
];

Copy

Explain
In the next section, we will start to use the Material UI component library, which is one of the most popular React component libraries.

Using the Material UI component library
Material UI (https://mui.com/), or MUI, is the React component library that implements Google’s Material Design language (https://m2.material.io/design). Material Design is one of the most popular design systems today. MUI contains a lot of different components – such as buttons, lists, tables, and cards – that you can use to achieve a nice and uniform user interface (UI).

In this book, we will use MUI version 5. If you want to use another version, you should follow the official documentation (https://mui.com/material-ui/getting-started/). MUI version 5 supports Material Design version 2.

In this section, we will create a small shopping list app and style the UI using MUI components. In our app, a user can enter shopping items that contain two fields: product and amount. Entered shopping items are displayed in the application as a list. The final UI looks like the following screenshot. The ADD ITEM button opens a modal form, where the user can enter a new shopping item:


Figure 11.8: Shopping List UI

Now, we are ready to start the implementation:

Create a new React app called shoppinglist (select the React framework and TypeScript variant) and install dependencies by running the following commands:
npm create vite@latest
cd shoppinglist
npm install

Copy

Explain
Open the shopping list app with VS Code. Install MUI by typing the following command in the project root folder in PowerShell or any suitable terminal:
npm install @mui/material @emotion/react @emotion/styled

Copy

Explain
MUI uses the Roboto font by default, but it is not provided out of the box. The easiest way to install Roboto fonts is by using Google Fonts. To use Roboto fonts, add the following line inside the head element of your index.html file:
<link
  rel="stylesheet"
  href="https://fonts.googleapis.com/css?family=\
        Roboto:300,400,500,700&display=swap"
/>

Copy

Explain
Open the App.tsx file and remove all the code inside the fragment (<></>). Also, remove unused code and imports. Now, your App.tsx file should look like this:
// App.tsx
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
You should also see an empty page in the browser.

MUI provides different layout components, and the basic layout component is the Container. This is used to center your content horizontally. You can specify the maximum width of a container using the maxWidth prop; the default value is lg (large), which is suitable for us. Let’s use the Container component in our App.tsx file, as follows:
import Container from '@mui/material/Container';
import './App.css';
function App() {
  return (
    <Container>
    </Container>
  );
}
export default App;

Copy

Explain
Remove the index.css file import from the main.tsx file so that we get full screen for our app. We also don’t want to use predefined styles from Vite:
// main.tsx
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './index.css' // REMOVE THIS LINE
ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)

Copy

Explain
Next, we will use the MUI AppBar component to create the toolbar in our app. Import the AppBar, ToolBar, and Typography components into your App.tsx file. Also, import useState from React, which we will need later. The code is illustrated in the following snippet:
import { useState } from 'react';
import Container from '@mui/material/Container';
import AppBar from '@mui/material/AppBar';
import Toolbar from '@mui/material/Toolbar';
import Typography from '@mui/material/Typography';
import './App.css'

Copy

Explain
Render the AppBar by adding the following code to your App component’s return statement. The Typography component provides predefined text sizes, and we will use this in our toolbar text. variant props can be used to define text size:
function App() {
  return (
    <Container>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6">
            Shopping List
          </Typography>
        </Toolbar>
      </AppBar>
    </Container>
  );
}

Copy

Explain
Start your app. It should now look like this:

Figure 11.9: AppBar component

In the App component, we need one array state to save the shopping list items. One shopping list item contains two fields: product and amount. We have to create a type for the shopping items, Item, which we will also export because we need it in other components later:
// App.tsx
export type Item = {
  product: string;
  amount: string;
}

Copy

Explain
Next, we will create the state where we save our shopping items. Create a state called items, whose type is an array of Item types:
const [items, setItems] = useState<Item[]>([]);

Copy

Explain
Then, create a function that adds a new item to the items state. In the addItem function, we will use spread notation (...) to add a new item at the beginning of an existing array:
const addItem = (item: Item) => {
  setItems([item, ...items]);
}

Copy

Explain
We need to add a new component for adding shopping items. Create a new file called AddItem.tsx in the root folder of the app, and add the following code to your AddItem.tsx file. The AddItem component function receives props from its parent component. The code is illustrated in the following snippet. We will define the props type later:
function AddItem(props) {
  return(
    <></>
  );
}
export default AddItem;

Copy

Explain
The AddItem component will use the MUI modal dialog to collect data. In the form, we will add two input fields, product and amount, and a button that calls the App component’s addItem function. To be able to call the addItem function, which is in the App component, we have to pass it in props when rendering the AddItem component. Outside the modal Dialog component, we will add a button that opens the modal form where the user can enter a new shopping item. This button is the only visible element when the component is rendered initially.

The following steps describe the implementation of the modal form.

We have to import the following MUI components for the modal form: Dialog, DialogActions, DialogContent, and DialogTitle. For the UI of the modal form, we require the following components: Button and TextField. Add the following imports to your AddItem.tsx file:
import Button from '@mui/material/Button';
import TextField from '@mui/material/TextField';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogTitle from '@mui/material/DialogTitle';

Copy

Explain
The Dialog component has one prop called open, and if the value is true, the dialog is visible. The default value of open props is false, and the dialog is hidden. We will declare one state called open and two functions to open and close the modal dialog. The default value of the open state is false. The handleOpen function sets the open state to true, and the handleClose function sets it to false. The code is illustrated in the following snippet:
// AddItem.tsx
// Import useState
import { useState } from 'react';
// Add state, handleOpen and handleClose functions
const [open, setOpen] = useState(false);
const handleOpen = () => {
  setOpen(true);
}
    
const handleClose = () => {
  setOpen(false);
}

Copy

Explain
We will add Dialog and Button components inside the return statement. We have one button outside the dialog that will be visible when the component is rendered for the first time. When the button is pressed, it calls the handleOpen function, which opens the dialog. Inside the dialog, we have two buttons: one for canceling and one for adding a new item. The Add button calls the addItem function, which we will implement later. The code is illustrated in the following snippet:
return(
    <>
      <Button onClick={handleOpen}>
        Add Item
      </Button>
      <Dialog open={open} onClose={handleClose}>
        <DialogTitle>New Item</DialogTitle>
        <DialogContent>
        </DialogContent>
        <DialogActions>
          <Button onClick={handleClose}>
            Cancel
          </Button>
          <Button onClick={addItem}>
            Add
          </Button>
        </DialogActions>
      </Dialog>
    </>
);

Copy

Explain
To collect data from a user, we have to declare one more state. This state is used to store a shopping item that the user enters, and its type is Item. We can import the Item type from the App component:
// Add the following import to AddItem.tsx
import { Item } from './App';

Copy

Explain
Add the following state to the AddItem component. The type of the state is Item, and we initialize it to an empty item object:
// item state
const [item, setItem] = useState<Item>({
  product: '',
  amount: '',
});

Copy

Explain
Inside the DialogContent component, we will add two inputs to collect data from a user. There, we will use the TextField MUI component that we have already imported. The margin prop is used to set the vertical spacing of text fields, and the fullwidth prop is used to make input take up the full width of its container. You can find all the props in the MUI documentation. The value props of the text fields must be the same as the state where we want to save the typed value. The onChange event listener saves the typed value to the item state when the user types something into the text fields. In the product field, the value is saved to the item.product property, and in the amount field, the value is saved to the item.amount property. The code is illustrated in the following snippet:
<DialogContent>
  <TextField value={item.product} margin="dense"
    onChange={ e => setItem({...item,
      product: e.target.value}) } 
    label="Product" fullWidth />
  <TextField value={item.amount} margin="dense"
    onChange={ e => setItem({...item,
      amount: e.target.value}) }
    label="Amount" fullWidth />
</DialogContent>

Copy

Explain
Finally, we have to create a function that calls the addItem function that we receive in the props. The function takes a new shopping item as an argument. First, we define a type for the props. The addItem function that is passed from the App component accepts one argument of type Item, and the function doesn’t return anything. The type definition and prop typing look like the following:
// AddItem.tsx
type AddItemProps = {
  addItem: (item: Item) => void;
}
function AddItem(props: AddItemProps) {
  const [open, setOpen] = useState(false);
  // Continues...

Copy

Explain
The new shopping item is now stored in the item state and contains the values that the user typed in. Because we get the addItem function from the props, we can call it using the props keyword. We will also call the handleClose function, which closes the modal dialog. The code is illustrated in the following snippet:
// Calls addItem function and passes item state into it
const addItem = () => {
  props.addItem(item);
  // Clear text fields and close modal dialog
  setItem({ product: '', amount: '' }); 
  handleClose();
}

Copy

Explain
Our AddItem component is now ready, and we have to import it into our App.tsx file and render it there. Add the following import statement to your App.tsx file:
import AddItem from './AddItem';

Copy

Explain
Add the AddItem component to the return statement in the App.tsx file. Pass the addItem function in a prop to the AddItem component, as follows:
// App.tsx
return (
  <Container>
    <AppBar position="static">
      <Toolbar>
        <Typography variant="h6">
          Shopping List
        </Typography>
      </Toolbar>
    </AppBar>
    <AddItem addItem={addItem}/>
  </Container>
);

Copy

Explain
Now, open your app in the browser and press the ADD ITEM button. You will see the modal form opening, and you can type in a new item, as illustrated in the following screenshot. The modal form is closed when you press the ADD button:

Figure 11.10: Modal dialog

Next, we will add a list to the App component that shows our shopping items. For that, we will use the MUI List, ListItem, and ListItemText components. Import the components into the App.tsx file:
// App.tsx
import List from '@mui/material/List';
import ListItem from '@mui/material/ListItem';
import ListItemText from '@mui/material/ListItemText';

Copy

Explain
Then, we will render the List component. Inside that, we will use the map function to generate ListItem components. Each ListItem component should have a unique key prop, and we use a divider prop to get a divider at the end of each list item. We will display the product in the primary text and the amount in the secondary text of the ListItemText component. The code is illustrated in the following snippet:
// App.tsx
return (
    <Container>
      <AppBar position="static">
        <Toolbar>
          <Typography variant="h6">
            Shopping List
          </Typography>
        </Toolbar>
      </AppBar>
      <AddItem addItem={addItem} />
      <List>
        {
          items.map((item, index) =>
            <ListItem key={index} divider>
              <ListItemText
                primary={item.product}
                secondary={item.amount}/>
            </ListItem>
          )
        }
      </List>
    </Container>
  );

Copy

Explain
Now, the UI looks like this:

Figure 11.11: Shopping List

The MUI Button component has three variants: text, contained, and outlined. The text variant is the default, and you can change it using the variant prop. For example, if we wanted to have an outlined ADD ITEM button, we could change the button’s variant prop in the AddItem.ts file, like this:

<Button variant="outlined" onClick={handleOpen}>
    Add Item
</Button>

Copy

Explain
In this section, we learned how to get a consistent design in our React app by using the Material UI library. You can easily get a polished and professional look to your apps with MUI. Next, we will learn how to use React Router, a popular routing library.

Managing routing with React Router
There are a few good libraries available for routing in React. React frameworks such as Next.js and Remix provide built-in routing solutions. The most popular library, which we are using, is React Router (https://github.com/ReactTraining/react-router). For web applications, React Router provides a package called react-router-dom. React Router uses URL-based routing, which means that we can define which component is rendered based on the URL.

To start using React Router, we have to install dependencies using the following command. In this book, we will use React Router version 6:

npm install react-router-dom@6

Copy

Explain
The react-router-dom library provides components that are used to implement routing. BrowserRouter is the router for web-based applications. The Route component renders the defined component if the given locations match.

The following code snippet provides an example of the Route component. The element prop defines a rendered component when the user navigates to the contact endpoint that is defined in the path prop. The path is relative to the current location:

<Route path="contact" element={<Contact />} />

Copy

Explain
You can use a * wildcard at the end of the path prop, like this:

<Route path="/contact/*" element={<Contact />} />

Copy

Explain
Now, it will match all endpoints under the contact – for example, contact/mike, contact/john, and so on.

The Routes component wraps multiple Route components. The Link component provides navigation to your application. The following example shows the Contact link and navigates to the /contact endpoint when the link is clicked:

<Link to="/contact">Contact</Link>

Copy

Explain
Let’s see how we can use these components in practice:

Create a new React app called routerapp using Vite, selecting the React framework and the TypeScript variant. Move to your project folder and install dependencies. Also install the react-router-dom library:
npm create vite@latest
cd routerapp
npm install
npm install react-router-dom@6

Copy

Explain
Open the src folder with VS Code and open the App.tsx file in the editor view. Import components from the react-router-dom package and remove extra code from the return statement, along with unused imports. After these modifications, your App.tsx source code should look like this:
import { BrowserRouter, Routes, Route, Link } from 'react-
  router-dom';
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
Let’s first create two simple components that we can use in routing. Create two new files, Home.tsx and Contact.tsx, in the application src folder. Then, add headers to the return statements to show the name of the component. The code of the components looks like this:
// Home.tsx
function Home() {
  return <h3>Home component</h3>;
}
export default Home;
// Contact.tsx
function Contact() {
  return <h3>Contact component</h3>;
}
export default Contact;

Copy

Explain
Open the App.tsx file, and then add a router that allows us to navigate between the components, as follows:
import { BrowserRouter, Routes, Route, Link } from 'react-
  router-dom’;
import Home from './Home';
import Contact from './Contact';
import './App.css';
function App() {
  return (
    <>
      <BrowserRouter>
        <nav>
          <Link to="/">Home</Link>{' | '}
          <Link to="/contact">Contact</Link>
        </nav>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="contact" element={<Contact />} />
       </Routes>
      </BrowserRouter>
    </>
  );
}
export default App;

Copy

Explain
Now, when you start the app, you will see the links and the Home component, which is shown in the root endpoint (localhost:5173), as defined in the first Route component. You can see a representation of this in the following screenshot:

Figure 11.12: React Router

When you click the Contact link, the Contact component is rendered, as illustrated here:

Figure 11.13: React Router (continued)

You can create a PageNotFound route by using a * wildcard at the path prop. In the following example, if any other route doesn’t match, the last one is used. First, create a component to show when a page is not found:
// Create PageNotFound component
function PageNotFound() {
  return <h1>Page not found</h1>;
}
export default PageNotFound;

Copy

Explain
Then, import the PageNotFound component into the App component, and create a new route:
// Import PageNotFound component into App.tsx
import PageNotFound from './PageNotFound';
// Add new page not found route 
<Routes>
  <Route path="/" element={<Home />} />
  <Route path="contact" element={<Contact />} />
  <Route path="*" element={<PageNotFound />} />
</Routes>

Copy

Explain
You can also have nested routes, such as the ones shown in the next example. Nested routing means that different parts of the app can have their own routing configuration. In the following example, Contact is the parent route, and it has two child routes:
<Routes>
  <Route path="contact" element={<Contact />}>
      <Route path="london" element={<ContactLondon />} />
      <Route path="paris" element={<ContactParis />} />
  </Route>
</Routes>

Copy

Explain
You can use a useRoutes() hook to declare routes using JavaScript objects instead of React elements, but we will not cover that in this book. You can find more information about hooks in the React Router documentation:https://reactrouter.com/en/main/start/overview.

So far, you have learned how to install and use a variety of third-party components with React. These skills will be required in the following chapters when we start to build our frontend.

Summary
In this chapter, we learned how to use third-party React components. We familiarized ourselves with several components that we will use in our frontend. ag-grid is a data grid component with built-in features like sorting, paging, and filtering. MUI is a component library that provides multiple UI components that implement Google’s Material Design language. We also learned how to use React Router for routing in React applications.

In the next chapter, we will create an environment to develop the frontend for our existing car backend.

Questions
How can you find components for React?
How should you install components?
How can you use the ag-grid component?
How can you use the MUI component library?
How can you implement routing in a React application?
Further reading
Here are some resources for learning about React:

Awesome React, a great resource for finding React libraries and components (https://github.com/enaqx/awesome-react)
The Top React Component Libraries that are Worth Trying, by Technostacks (https://technostacks.com/blog/react-component-libraries/)
Learn more on Discord
To join the Discord community for this book – where you can share feedback, ask the author questions, and learn about new releases – follow the QR code below:

https://packt.link/FullStackSpringBootReact4e





| ≪ [ 210 Consuming the REST API with React ](/books/packtpub/2024/1202-Spring_Boot_3_React/210_Consuming_the_REST_API_with_React) | 211 Useful Third-Party Components for React | [ 312 Setting Up the Frontend ](/books/packtpub/2024/1202-Spring_Boot_3_React/312_Setting_Up_the_Frontend) ≫ |
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: 211 Useful Third-Party Components for React
> (2) Short Description: Spring Boot 3 React
> (3) Path: books/packtpub/2024/1202-Spring_Boot_3_React/211_Useful_Third-Party_Components_for_React
> Book Jemok: Full Stack Development with Spring Boot 3 and React 4Ed
> AuthorDate: Juha Hinkula / Oct 2023 / 454 pages 4Ed
> Link: https://subscription.packtpub.com/book/web-development/9781805122463/pref
> create: 2024-12-02 월 14:31:22
> .md Name: 211_useful_third-party_components_for_react.md

