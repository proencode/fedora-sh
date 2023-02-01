
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


@ Q -> # 붙이고 줄 띄우기 
0i## A
@ W -> 현 위치에서 Copy 까지 역따옴표 
j0i```/^Copy$ddk0C```
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(`) 붙이기 
i`/ i`/EEEEEEEEEE
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(`) 붙이기 
i`/\.i`/RRRRRRRRRR
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(`) 붙이기 
i`/,i`/TTTTTTTTTT
@ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(`) 붙이기 
i`/;i`/YYYYYYYYYY
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(`) 붙이기 
i`/)i`/UUUUUUUUU
@ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(`) 붙이기 
i`/:i`/CCCCCCCCCC

@ A -> 빈 줄에 블록 시작하기 
0C```k0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 
0i```-0i```0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 
0i```kk
@ F -> 이 줄을 타이틀로 만들기 
0i#### 
---------- cut line ----------

> [ 06 C4 Advanced Concepts of Vue.js ](/packtpub/javascript_from_frontend_to_backend/06_c4_advanced_concepts_of_vue_js) <---> [ 08 P3 JavaScript on the Server-Side ](/packtpub/javascript_from_frontend_to_backend/08_p3_javascript_on_the_server-side)

# Chapter 5: Managing a List with Vue.js

After going through the basic and advanced concepts of Vue.js, with this chapter, let’s finish our study of the Vue.js library by building an application to manage a list of elements.

Why make this type of application? Quite simply because it allows you to perform fairly standard operations on the HTML elements of a page, such as inserting an element, modifying it, and deleting it.

These are the basic operations that you need to know how to perform, for example, to manage the elements in a database. In this chapter, we will learn how to perform these operations on the elements displayed on the screen, and in the next part (where we study Node.js and MongoDB), we will see how to simultaneously update a database.

Here are the topics covered in this chapter:

- Splitting the application into components
- Adding an element to the list
- Removing an element from the list
- Modifying an element in the list

But let’s start by discovering the screens of the application that we want to create with Vue.js.

# Technical requirements

You can find the code files for this chapter on GitHub at: https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend/blob/main/Chapter%205.zip.

# Displaying application screens

As mentioned earlier, we’ll be building an application to manage a list of elements. Before writing the source code of our application, let’s show the different screens of the application by explaining their sequence.

Initially, the list is empty. The **Add Element** button allows, on each click, to insert a new element in the list.

![ 0700 5.1 Screen when launching the ](/packtpub/javascript_from_frontend_to_backend_img/0700_5.1_screen_when_launching_the.webp
)
Figure 5.1 – Screen when launching the application

Let’s click the **Add Element** button several times (here, three times):

![ 0701 5.2 After three clicks on the ](/packtpub/javascript_from_frontend_to_backend_img/0701_5.2_after_three_clicks_on_the.webp
)
Figure 5.2 – After three clicks on the Add Element button

Each element inserted has the index (starting from 1) of the element in the list. A **Remove** button and a **Modify** button are inserted after the item in the list.

Let’s click on the **Modify** button on the second line. The item text is replaced by an input field, in which the cursor flashes to allow editing.

![ 0702 5.3 The second item in the list ](/packtpub/javascript_from_frontend_to_backend_img/0702_5.3_the_second_item_in_the_list.webp
)
Figure 5.3 – The second item in the list can be changed

Let’s modify the text in the input field, by typing `New Element 2`.

![ 0703 5.4 Editing a list item ](/packtpub/javascript_from_frontend_to_backend_img/0703_5.4_editing_a_list_item.webp
)
Figure 5.4 – Editing a list item

For the modification of the element to be reflected, you must leave the input field, by clicking elsewhere on the page.

![ 0704 5.5 Taking into account the ](/packtpub/javascript_from_frontend_to_backend_img/0704_5.5_taking_into_account_the.webp
)
Figure 5.5 – Taking into account the modification of the element

Finally, to remove the first and third elements, click on their corresponding **Remove** buttons.

![ 0705 5.6 After deleting the first ](/packtpub/javascript_from_frontend_to_backend_img/0705_5.6_after_deleting_the_first.webp
)
Figure 5.6 – After deleting the first and last element

We have administered here a list of elements on which we have performed basic operations, namely, inserting a new element, modifying the element, and deleting it.

Using HTTP Protocol

This application uses a PHP server to work because the `import` of JavaScript modules with the JavaScript import statement only works under the HTTP protocol. We will see in the next part (Chapter 9, Integrating Vue.js with Node_js) how to use a Node.js server to also make it work, by coupling it in addition with a MongoDB database.

We have described the operation of the application, and the sequence of the various windows. Now let’s see how to build this application with Vue.js. We first explain how the application can be broken down into different components.

# Splitting the application into components

When you create an application with Vue.js, you have to start by asking yourself what components you will need to build it.

In our case, it would be the following:

A `<GlobalApp>` component that groups the whole application. It is this `<GlobalApp>` component that will be integrated into our `index.html` page. It will display the **Add Element** button as well as the list of elements below.
An `<Element>` component that displays a list element line, which will include the element’s text, the **Remove** button, and the **Modify** button.
The list of elements will be associated with a reactive variable named `elements`, which will be an array containing, for each element, the displayed text. This reactive variable will be registered in the `<GlobalApp>` component. It will be modified when adding a new element to the list or when deleting or modifying an element in the list.

So, the core files of our app are as follows:

- The `index.html` file, which is the main file
- The `global-app.js` file, which contains the `<GlobalApp>` component, and is imported into the `index.html` file
- The `element.js` file, which describes an element of the displayed list (the `<Element>` component), namely the text of the element, as well as the **Remove** and **Modify** buttons
Here is the content of these files:

index.html file

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
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

The `index.html` file displays the `<GlobalApp>` component, which corresponds to the main component of the application, which we’ll now describe:

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
    <button>Add Element</button>
    <ul></ul>
  `,
}
export default GlobalApp;
```

We find the reactive variable `elements`, as well as the **Add Element** button and the `<ul>` list of elements, empty for the moment.

The `<Element>` component is described below. It is empty for the moment and will be enriched in the following sections:

<Element> component (element.js file)

```
const Element = {
  data() {
    return {
    }
  },
  template : `
  `,
}
export default Element;
```

### Using HTTP Protocol


As the JavaScript code comprises module `import` instructions, it is necessary to use a web server accessible by HTTP to display the HTML page corresponding to `index.html`. The `file` protocol would not work here.

Let’s display the result of this temporary code on the screen:

![ 0706 5.7 Result displayed with our ](/packtpub/javascript_from_frontend_to_backend_img/0706_5.7_result_displayed_with_our.webp
)
Figure 5.7 – Result displayed with our startup code

In Figure 5.7, we see the rendering of the `<GlobalApp>` component, which currently only displays the **Add Element** button. Let’s see how to process a click on this button in order to insert a new element in the list.

# Adding an element to the list

We will start with the functionality to add an item to the list. The `global-app.js` file is modified to process a click on the **Add Element** button (this button is included in the `global-app.js` file).

Let’s add the code that should be run when the **Add Element** button is clicked:

Taking into account the click on the Add Element button (global-app.js file)

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
      <li v-for="(element, index) in elements" 
      :key="index">{{element}}</li>
    </ul>
  `,
  methods : {
    add() {
      var element = "Element " + (this.elements.length + 
      1);  // "Element X"
      this.elements.push(element);
    }
  }
}
export default GlobalApp;
```

A click on the **Add Element** button is handled by the `click` event, which calls the `add()` method defined in the `methods` section. The `add()` method adds a new element to the reactive variable `elements`.

The list of elements is updated in the component template. For the moment, we’ll use the `<li>` tag to define the list element to insert, but below, we will use the `<Element>` component, which will integrate the **Remove** and **Modify** buttons.

Now let’s verify that our modification of the `<GlobalApp>` component works. To do this, click several times on the **Add Element** button. List items are inserted with each click, as seen in the following figure.

![ 0707 5.8 Add Element button clicks ](/packtpub/javascript_from_frontend_to_backend_img/0707_5.8_add_element_button_clicks.webp
)
Figure 5.8 – Add Element button clicks

The element inserted here is an HTML `<li>` element. But it is interesting to replace the element `<li>` with a Vue.js component because it allows using the philosophy of Vue.js, which is the maximum use of components. Let’s name this new component `<Element>`, which will replace the `<li>` element..

## Using the <Element> component

Next, let’s use the `<Element>` component, instead of the previous `<li>` element.

The `<GlobalApp>` component is modified to integrate the `<Element>` component:

Using <Element> component in list (global-app.js file)

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
      :key="index" :text="element" />
    </ul>
  `,
  methods : {
    add() {
      var element = "Element " + (this.elements.length + 
      1);
      this.elements.push(element);
    }
  }
}
export default GlobalApp; 
```

The text to display in the list item is passed as an attribute (via `props`) to the `<Element>` component, which will display it in its template. We use the `text` attribute (or any other attribute name) for this.

The `<Element>` component is modified to consider the `text` attribute passed and display the list element. The two buttons **Remove** and **Modify** are inserted after the text:

Using the text attribute and buttons (element.js file)

```
const Element = {
  data() {
    return {
    }
  },
  template : `
    <li> 
      <span> {{text}} </span>
      <button> Remove </button> 
      <button> Modify </button>
    </li>
  `,
  props : ["text"],
}
export default Element;
```

Let’s check that the result is equivalent to the previous one (with the addition of the **Remove** and **Modify** buttons).

![ 0708 5.9 Using the Element component ](/packtpub/javascript_from_frontend_to_backend_img/0708_5.9_using_the_element_component.webp
)
Figure 5.9 – Using the <Element> component in the list

Clicking on the **Remove** and **Modify** buttons in the list does not work yet but will soon, in the following sections.

The **Remove** and **Modify** buttons are placed side by side, with no spacing. Let’s add some CSS code to better lay them out on the screen.

## Changing the appearance of the list using CSS code

Before handling button clicks in the list, let’s use some CSS to display the list items in a nicer way.

The CSS code is indicated directly in the `index.html` file:

Using CSS code to display the list (index.html file)

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

We can see that the appearance of the list is now more pleasant.

![ 0709 5.10 List of elements improved ](/packtpub/javascript_from_frontend_to_backend_img/0709_5.10_list_of_elements_improved.webp
)
Figure 5.10 – List of elements improved with CSS code

The displayed list now has a look that suits us! We must now manage clicks on the **Remove** and **Modify** buttons. Let’s start with the **Remove** button.

# Removing an element from the list

Now let’s deal with a click on the **Remove** button for a list item. Removing an item from the list will be done by removing the element from the reactive variable `elements`.

Note

Indeed, the variable `elements` being reactive, any modification of this variable will lead to the re-display of the list.

To do this, a click on the **Remove** button is managed by associating it with a process during the click. We therefore call the `remove()` method defined in the `<Element>` component on each click:

Taking into account the click on the Remove button (element.js file)

```
const Element = {
  data() {
    return {
    }
  },
  template : `
    <li> 
      <span> {{text}} </span>
      <button @click="remove()"> Remove </button> 
      <button> Modify </button>
    </li>
  `,
  props : ["text"],
  methods : {
    remove() {
      // process the click on the Remove button
    },
  },
}
export default Element;.
```

The process involved in clicking on the **Remove** button is discussed later in the chapter.

Note

To process the click on the **Remove** button, we must update the reactive variable `elements`, but since this is located in the parent component `<GlobalApp>`, we must send an event to this parent component to ask it to remove the element in the variable `elements`.

To indicate the element to be deleted, it must be referenced by its index. For this, we need to indicate the index of the element when creating the `<Element>` component. We, therefore, create a new attribute (named `"index"`) in this component. Thus the `remove()` method sends a `"remove"` event to the `<GlobalApp>` parent component, indicating in the parameters the index of the element to be removed from the list.

The `<Element>` component becomes as follows:

Handling the click on the Remove button (element.js file)

```
const Element = {
  data() {
    return {
    }
  },
  template : `
    <li> 
      <span> {{text}} </span>
      <button @click="remove()"> Remove </button> 
      <button> Modify </button>
    </li>
  `,
  props : ["text", "index"],
  methods : {
    remove() {
      // process the click on the Remove button
      this.$emit("remove", { index : this.index });
    },
  },
  emits : ["remove"]
}
export default Element;
```

The `<GlobalApp>` component is modified to process the reception of the `"remove"` event sent when clicking on the **Remove** button:

Handling the reception of the “remove” event (global-app.js file)

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
      :key="index" :text="element" 
           :index="index"
               @remove="remove($event)"
      />
    </ul>
  `,
  methods : {
    add() {
      var element = "Element " + (this.elements.length + 
      1);
      this.elements.push(element);
    },
    remove(params) {
      var index = params.index;
      this.elements.splice(index, 1);  // delete element in 
                                       // array
    }
  }
}
export default GlobalApp;
```

We have indicated in the `<Element>` component the new attribute `index`, which will allow knowing the index of the element in the list.

Let’s add three items to the list (see Figure 5.11), then click the **Remove** button for the item on the second line (see Figure 5.12):

![ 0710 5.11 Adding three elements ](/packtpub/javascript_from_frontend_to_backend_img/0710_5.11_adding_three_elements.webp
)
Figure 5.11 – Adding three elements to the list

Here’s what we will see after clicking the **Remove** button:

![ 0711 5.12 Deleting item Element ](/packtpub/javascript_from_frontend_to_backend_img/0711_5.12_deleting_item_element.webp
)
Figure 5.12 – Deleting item Element 2 from the list

By clicking on the **Remove** button, **Element 2** has been removed from the list. Let’s now see how to manage the modification of an element, following a click on the **Modify** button.

# Modifying an element in the list

Modifying a list element is done in several steps:

1. Following a click on the **Modify** button, we transform the text of the list element (currently a `<span>` element) into an HTML `<input>` element initialized with the text of the element.
1. Then we manage the exit of the input field, by retrieving the value entered in the field, then by replacing the input field with a `<span>` element with the new content.
1. Finally, we improve the input by allowing the input control to automatically have the focus after clicking on the **Modify** button.

Let’s see these different steps in depth.

## Transforming the <span> element into an <input> element

The first step is to transform the `<span>` element into an `<input>` element, which will allow the text of the element to be modified. To do this, we will add a new reactive variable (named `"input"`) in the `<Element>` component. It indicates whether to display a text as a `<span>` element (if `input` is `false`) or whether to display an `<input>` input field (if `input` is `true`). By default, the `input` variable is set to `false` (the text is displayed). It will change to `true` when clicking on the **Modify** button:

Turning a <span> element into an <input> element (element.js file)

```
const Element = {
  data() {
    return {
      input : false   // display element text by default
    }
  },
  template : `
    <li> 
      <span v-if="!input"> {{text}} </span>
      <input v-else type="text" :value="text" />
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
  },
  emits : ["remove"]
}
export default Element;
```

Note

The `v-if` and `v-else` directives are used to display the text of the element as a `<span>` element or as an `<input>` element.

After inserting three items into the list, let’s edit the second item:

![ 0712 5.13 Editing the second item ](/packtpub/javascript_from_frontend_to_backend_img/0712_5.13_editing_the_second_item.webp
)
Figure 5.13 – Editing the second item in the list

We now need to show how to leave the input field and redisplay the text as a list element.

## Exiting from the input field

Once the edit control has been modified, you must retrieve the value entered to display it instead of the edit control. To do this, in the `<Element>` component, we use the `blur` event, which indicates that we have left the input field.

During the processing of this event, the value of the input field is retrieved, which is transmitted to the parent `<GlobalApp>` component by means of an event named `"modify"`, for example. The `<GlobalApp>` component modifies the element value in the `elements` variable when processing the received `modify` event.

Note

The modification of a reactive variable located in a parent component must be done by sending an event to the parent component, which will have to process it.

Finally, the transformation of the input field into text is done by modifying the reactive variable `input` defined in the `<Element>` component by positioning it again to `false`.

The `<Element>` component is modified as shown here:

Taking into account the output of the input field (element.js file)

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
       @blur="modify($event)" />
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
      var value = event.target.value;    // value entered 
                                         // in the field
      this.input = false;                // delete input field
      this.$emit("modify", { index : this.index, value : 
      value });   // update element in list
    }
  },
  emits : ["remove", "modify"]
}
export default Element;
```

The `<GlobalApp>` component is also modified to process the reception of the `"modify"` event and thus modify the list displayed:

Processing the modify event (global-app.js file)

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
      :key="index" :text="element" 
        :index="index"
        @remove="remove($event)" @modify="modify($event)"
      />
    </ul>
  `,
  methods : {
    add() {
      var element = "Element " + (this.elements.length + 
      1);
      this.elements.push(element);
    },
    remove(params) {
      var index = params.index;
      this.elements.splice(index, 1);
    },
    modify(params) {
      var index = params.index;
      var value = params.value;
      this.elements[index] = value;  // new element value
    }
  }
}
export default GlobalApp;
```

The following figure shows the result after editing the second list item.

![ 0713 5.14 Editing a list item ](/packtpub/javascript_from_frontend_to_backend_img/0713_5.14_editing_a_list_item.webp
)
Figure 5.14 – Editing a list item

A final improvement that we can make to our program is to give focus to the input field directly after clicking on the **Modify** button. Let’s see how to proceed.

## Giving focus to the input field

Giving focus to the input field requires using the `focus()` method, which is defined in the **Document Object Model (DOM)**. The DOM is an internal API (in the JavaScript language) implemented in browsers.

Vue.js makes it possible to make a relationship between the components defined in Vue.js and the HTML elements used by the DOM. For this, we use the `ref` attribute, which makes it possible to make a correspondence between the two systems.

Note

This `ref`` attribute can be used for each HTML element defined in our component templates. But it should be used only for necessary cases, such as here, to use the `focus()` method defined in the DOM, which otherwise would be inaccessible.

Once the `ref` attribute has been positioned (here, on the `<input>` element allowing input), all that remains is to use it to give focus to the input field. The question then is: in which method of our component should we call the `focus()` method?

We must use a method in which we are sure that the input field is created. The template written in the component must be transformed into HTML code and integrated into the memory of the browser (in the DOM), which can then display it. So, we see that a transformation process takes place, which takes some time to execute.

Vue.js has defined a number of methods that are called automatically when using components. In the previous chapter, we saw a method called `created()`. There are other methods, in particular, the `mounted()` and `updated()` methods.

Here are the specifics of these three methods:

- The `created()` method is called when creating the component. This is the first method called.
- The `mounted()` method is called when the component is transformed into HTML elements and integrated into the DOM. We can therefore have access, in this method, to HTML elements with the DOM API.
- The `updated()` method is called when a modification is made in the component. For example, when a `<span>` element is replaced by an `<input>` element following a click on the **Modify** button. Or when, conversely, the `<input>` element turns back into a `<span>` element (when leaving the input field).

We see that the `updated()` method is the method in which we can do the processing giving focus to the input field. But as this method is called both when transforming into an input field or simple text, it will be necessary to check that the `<input>` element associated with the reference indicated in the `ref` attribute exists. Otherwise, an error visible in the console will occur:

Giving focus to the input field as soon as it appears (element.js file)

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
    // check that the ref="refInput" attribute exists, and 
    // if so, give focus to the input field
    if (this.$refs.refInput) this.$refs.refInput.focus();  
  }
}
export default Element;
```

When using the `ref` attribute in a template, Vue.js stores it in the component’s internal `$refs` variable. We can therefore access the corresponding HTML element using `this.$refs.refInput` if we wrote `ref="refInput"` in the component template.

Let’s check (see the following figure) that the edit control gets the focus directly when clicking on the **Modify** button.

![ 0714 5.15 The input field gets the ](/packtpub/javascript_from_frontend_to_backend_img/0714_5.15_the_input_field_gets_the.webp
)
Figure 5.15 – The input field gets the focus directly

This brings us to the end of the chapter.

# Summary

This chapter and the example discussed in it shows that it is very easy to manage the elements of an HTML page interactively without leaving the page.

Here, we first decomposed the application into different components, then we assembled them, making them communicate through events and `props` attributes. We have learned, thanks to this complete example, how to manage a list of elements to carry out the main operations, which are the insertion, the modification, and the deletion of an element.

In the next few chapters, we will see how to use Node.js to connect our application to a MongoDB database and thus be able to store the elements of the list in a database. We will begin by learning how to work with node.js modules in the next chapter.



> [ 06 C4 Advanced Concepts of Vue.js ](/packtpub/javascript_from_frontend_to_backend/06_c4_advanced_concepts_of_vue_js) <---> [ 08 P3 JavaScript on the Server-Side ](/packtpub/javascript_from_frontend_to_backend/08_p3_javascript_on_the_server-side)
>
> Title: 07 C5 Managing a List with Vue.js
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/07_c5_managing_a_list_with_vue.js
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 13:20:55
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 07_c5_managing_a_list_with_vue.js.md

