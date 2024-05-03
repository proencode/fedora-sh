
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

> [ 04 P2 JavaScript on the Client-Side ](/packtpub/javascript_from_frontend_to_backend/04_p2_javascript_on_the_client-side) <---> [ 06 C4 Advanced Concepts of Vue.js ](/packtpub/javascript_from_frontend_to_backend/06_c4_advanced_concepts_of_vue_js)

# Chapter 3: Getting Started with Vue.js

The JavaScript world is constantly changing. In recent years, a new concept has emerged: that of developing applications by creating components.

New JavaScript libraries for developing component-based apps have emerged, the main ones being Angular, React, Svelte, and Vue.js. Among all these libraries, which are quite similar to each other, we have chosen to present Vue.js to you because it is widely used and quite simple to implement. The other libraries mentioned operate according to the same principles.

Why Use Vue.js?

The main advantage of Vue.js is the possibility of developing an application using components. We cut the web application into a set of components (actually JavaScript files) and then assemble them to form the final application. Vue.js can test each component independently of the others and can also reuse them in other applications.

In this chapter, we will study how to build our first application with Vue.js, by creating and using our first component.

In this chapter, we will cover the following main topics:

- Using Vue.js in an HTML page
- Creating our first Vue.js application
- Using reactivity
- Creating our first component
- Adding methods in components
- Using attributes in components
- Using directives

# 1. Technical requirements

You can find the code files for this chapter on GitHub at: https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend/blob/main/Chapter%203.zip.

# 2. Using Vue.js in an HTML page

To use Vue.js in an HTML page, simply insert the library file into it using the `<script>` tag.

To check that Vue.js is correctly integrated into the page, let’s display the version number of the library in the `Vue.version` variable:

Displaying Vue.js version number (index.html file)

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
  </head>
  <body>
  </body>
  
  <script>
    alert(`Vue.version = ${Vue.version}`);
  </script>
</html>
```

If Vue.js is accessible in the page, the `Vue` object provides access to the version number in its `version` property as we can see in the following figure:

![ 0400 3.1 Displaying the Vue.js version ](/packtpub/javascript_from_frontend_to_backend_img/0400_3.1_displaying_the_vue.js_version.webp)
Figure 3.1 – Displaying the Vue.js version number

Now that we have integrated Vue.js into our HTML page, let’s go about creating our first application.

# 3. Creating our first Vue.js application

Once Vue.js has been inserted into the HTML page, you must define the HTML elements of the page in which Vue.js will be used.

In general, you want to use Vue.js on the whole HTML page, but it is possible to use it only on certain elements of the page as well. This would allow us, for example, to manage an HTML page with jQuery, except for a particular `<div>` element, which would be managed with Vue.js.

To illustrate this, let us create an HTML page with two `<div>` elements, only the first of which will be managed by Vue.js:

Creating an HTML page partially managed by Vue.js

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
  </head>
  <body>
    <div id="app">First div</div>
    <div>The rest of the page is not managed by 
    Vue.js</div>
  </body>
  
  <script>
    var app = Vue.createApp({
      template : "This div is managed with Vue.js"
    });
    // mount the Vue.js application on the <div> having the 
    // id "app"
    var vm = app.mount("div#app");    
</script>
  
</html>
```

In the preceding code, we have used the `Vue.createApp(options)` method defined on the `Vue` object. The `options` object is used to set options for creating the Vue.js application. One of the options of `Vue.createApp(options)` is the `template` option, which allows us to define the view (that is to say the HTML display) that will be displayed on the page, thanks to the call of the `app.mount(element)` method:

- The `app` object is the one obtained as a result of the `Vue.createApp()` method call.
- The `element` parameter represents the HTML element on which Vue.js will act.

Let’s run the previous program; we should see the following output:

![ 0401 3.2 First Vue.js app ](/packtpub/javascript_from_frontend_to_backend_img/0401_3.2_first_vue.js_app.webp)
Figure 3.2 – First Vue.js app

On the preceding screen, we can see the result of using Vue.js on the page. The content of the first <div> is replaced by the template written in the `options` parameter of the `Vue.createApp(options)` method. The second `<div>` is not transformed.

Thus, to manage an entire HTML page with Vue.js, just indicate in the `<body>` part of the page a single `<div>` element, which will be the one on which Vue.js will be activated.

Now let’s see how to use an important concept of Vue.js, which is the correspondence between the variables defined in the program and their display on the HTML page. This concept is called reactivity.

# 4. Using reactivity

One of the objectives of Vue.js is to separate the management of the display (the **view**) and that of the data (the **model**). This is the concept that is frequently found in what is called the **Model View Controller (MVC)** model.

To illustrate, suppose we want to display a counter that increments from 0. A good separation of view and model would be for the view to constantly display the value of the counter, even if that value is changed elsewhere. This concept makes it possible not to link the display with the management of the data displayed. For this, we use the reactivity offered by Vue.js, by creating so-called **reactive variables**.

Reactive Variables

A variable will be said to be reactive if its modification in memory causes it to be modified automatically wherever the variable is displayed.

Reactive variables are defined in the `options` object of the `Vue.createApp(options)` method. For this, we add in the `options` object, and the definition of the `data()` method, which will have to return an object containing the so-called reactive variables of the application.

Let’s use a reactive variable named `count` in our Vue.js application:

Defining a count reactive variable

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
  </head>
  <body>
    <div id="app"></div>
  </body>
  
  <script>
    var app = Vue.createApp({
      template : "The counter is: {{count}}",
      data() {
        // return an object containing the reactive 
        // variables
        return {
          count : 0
        }
      }
    });
    var vm = app.mount("div#app");
</script>
  
</html>
```

In the preceding code, the `count` reactive variable is defined in the data() method, which returns the `{ count : 0 }` object containing the program’s reactive variable. Other variables can be defined afterward.

This reactive variable can then be used in the template by means of the notation with `{{` and `}}`. This notation is used to indicate a JavaScript expression, such as the value of a variable.

The definition of a so-called reactive variable makes it possible to link the display to the value of the variable. As soon as the variable is modified, the display is also modified. We can see the counter value in the following figure:

![ 0402 3.3 Displaying a reactive variable ](/packtpub/javascript_from_frontend_to_backend_img/0402_3.3_displaying_a_reactive_variable.webp
)
Figure 3.3 – Displaying a reactive variable

The counter remains positioned at its initial value: 0. Reactivity is only visible when the variable is modified. The display will therefore be modified as soon as the `count` variable is modified.

To do this, let’s increment the value of the variable every second as shown in the following code:

Incrementing count variable every second

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
  </head>
  <body>
    <div id="app"></div>
  </body>
  
  <script>
    var app = Vue.createApp({
      template : "The counter is: {{count}}",
      data() {
        // return an object containing the reactive 
        // variables
        return {
          count : 0
        }
      }
    });
    var vm = app.mount("div#app");
    
    setInterval(function() {
      vm.count += 1;
    }, 1000);
</script>
  
</html>
```

Using JavaScript’s `setInterval()` function, we increment the value of the `count` variable every second. Vue.js provides access to the `count` variable using `vm.count`, where `vm` is the object returned by the `app.mount()` method. Reactive variables become properties of this `vm` object. In the preceding code, we can see the separation of view and data processing, as advocated by the MVC pattern. The incrementation of the variable is done outside the view, which would not have been possible with a library such as jQuery.

We can see the incrementation and the automatic update of the display, thanks to the reactivity offered by Vue.js, as evident in the following figure

![ 0403 3.4 Incrementing a reactive variable ](/packtpub/javascript_from_frontend_to_backend_img/0403_3.4_incrementing_a_reactive_variable.webp
)
Figure 3.4 – Incrementing a reactive variable

The previous program is very simple, but in reality, applications are of course more complex. As such, it is necessary to break down an application into small pieces, which will then be assembled. Now let’s learn how to write one of the small pieces of an application, called a component.

# 5. Creating our first component

Let’s see how to use Vue.js to create our own components.

A Vue.js component will be similar to a new HTML element. It will be used in the form of HTML tags to which new attributes can be associated if necessary. To use the component, all you have to do is use the corresponding tag.

The components are therefore a means of enriching the HTML code by creating our own tags.

How to Discover the Components to Use to Build Our Application

All you have to do is visually cut the HTML page you want to display into the simplest possible elements (which will be the basic components of your application), then group several elements together to form a component that will group them, and so on until you have the main component, which will be your complete application.

For example, if a list of elements is displayed on the HTML page, each element’s line of the list corresponds to a basic component, while the global list that groups these different components will be associated with another component. The set of all components of the HTML page corresponds to the main component, often named `<App>` or `<GlobalApp>`. Let’s see how to create and use the `<counter>` component corresponding to the previous counter by first learning how to insert the component.

You can create the component directly into the HTML page or include it from an external file. Let’s look at these two ways to do it.

## 5-1. Inserting a component in the application file

A component can simply be embedded in the main application Vue.js file. Just use the `app.component(name, options)` method to create it as follows. The variable `app` corresponds to the object returned by `Vue.createApp()`:

Creating the <counter> component directly in the application

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
  </head>
  <body>
    <div id="app"></div>
  </body>
  
  <script>
    var app = Vue.createApp({
      template : "<counter />"
    });
    
    app.component("counter", {
      template : "The counter is: {{count}}",
      data() {
        return {
          count : 0
        }
      }
    });
    var vm = app.mount("div#app");
    
</script>
  
</html>
```

In the preceding code, the variable app corresponds to the object returned by `Vue.createApp()`.

The `app.component(name, options)` method works on the same principle as `Vue.createApp(options)`:

- The `name` parameter corresponds to the name of the component, which will then be used as tags in HTML templates.
- The `options` parameter is similar in both cases. There is the `template` section, `data`, and so on.

The `<counter>` component can then be used in other templates, including the one defined for the application. When you run the preceding code, you will see the following screen:

![ 0404 3.5 The counter component ](/packtpub/javascript_from_frontend_to_backend_img/0404_3.5_the_counter_component.webp
)
Figure 3.5 – The <counter> component

As we can see in the preceding figure, for the moment, the counter remains at 0. To increment the reactive variable `count` in the component, it is necessary to be able to write the instruction of incrementation once the component is created. For this, Vue.js provides internal methods allowing access to the life cycle of each component created.

One of the methods of a component’s life cycle is the `created()` method. It is called when the component is created. You can use this method to write the increment of the variable count every second, using the `setInterval()` function.

Let’s use the component’s `created()` method as follows:

Using the component’s created() method

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
  </head>
  <body>
    <div id="app"></div>
  </body>
  
  <script>
    var app = Vue.createApp({
      template : "<counter />"
    });
    
    app.component("counter", {
      template : "The counter is: {{count}}",
      data() {
        return {
          count : 0
        }
      },
      created() {
        setInterval(()=>{  // do not use the function()
                           // form here,
                           // otherwise the "this" object
                           // would not be the same
          this.count++;
        }, 1000);
      }
    });
    var vm = app.mount("div#app");
    
  </script>
  
</html>
```

In the preceding code, we have used the notation `()=>` instead of `function()`. This notation (called a lambda function) was introduced in the latest versions of JavaScript in order to allow the value of this to be kept inside callback functions, which is necessary here. If you replace the lambda function ()=> with the `function()` keyword, the program won’t work, as the `this` value won’t be the same.

On running the preceding code, you will see the following output:

![ 0405 3.6 Incrementing the counter in the ](/packtpub/javascript_from_frontend_to_backend_img/0405_3.6_incrementing_the_counter_in_the.webp
)
Figure 3.6 – Incrementing the counter in the component

## 5-2. Inserting a component from an external file

Rather than defining the component directly in the HTML page, it is preferable to define it in an external file. The component can be used in the HTML page thanks to the inclusion of the external file in the HTML page. For this, we use the concept of modules provided by JavaScript.

The Advantage of Components Defined in an External File

The advantage of defining the component in an external file is to be able to include this file in several different HTML pages, and therefore to use the component in several different applications.

The `<counter>` component is defined in an external counter.js file as follows:

<counter> component definition (counter.js file)

```
const Counter = {
  data() {
    return {
      count: 0
    }
  },
  template : "The counter is: {{count}}",
  created() {
    setInterval(() => {
      this.count += 1;
    }, 1000)
  }
}
export default Counter;
```

The `<counter>` component is defined as an object, having `template`, `data`, and `created` properties. Its definition is similar to the one shown previously in the `app.component()` method.

The `export default Counter` instruction makes the component accessible in the other files where this module is imported.

The `<counter>` component can now be integrated into the main file of our application. We use the JavaScript `import` statement for this. The code will look as follows:

Importing the component into the program (index.html file)

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
  
    import Counter from "./counter.js";
    
    var app = Vue.createApp({
      components : {
        Counter:Counter
      },
      template : "<counter />"   // or "<Counter />"
    });
 
    var vm = app.mount("div#app");
    
  </script>
</html>
```

In the preceding code, to import the `counter.js` file and use the corresponding component, the following takes place:

- The type="module" attribute is indicated in the `<script>` tag. This allows the use of the import statement in the JavaScript statements of the `<script>` tag.
- We use the import statement to import the corresponding module.
- We declare the imported components in the new components section. Components are declared as an object. The names of the properties in this object correspond to the name used by the component in the templates (<counter> or <Counter>), while the values correspond to the name of the imported component (Counter).

## 5-3. Using HTTP Instead of the FILE Protocol

However, as we use the import of JavaScript modules, it is necessary to run our application on an HTTP server, and no longer with a simple drag and drop as before. Hence the use of the URL that begins with `http://localhost`. If you need to know how to install an HTTP server, you can, for example, use the documentation here: https://developer.mozilla.org/en-US/docs/Learn/Common_questions/set_up_a_local_testing_server.

In the following figure, we can see that creating a component directly in the HTML page or in an external file produces the same result:

![ 0406 3.7 Execution of the HTML file on ](/packtpub/javascript_from_frontend_to_backend_img/0406_3.7_execution_of_the_html_file_on.webp
)
Figure 3.7 – Execution of the HTML file on an HTTP server (here, localhost)

The current component only has a simple reactive variable. It is possible, in a component, to add methods to it that will be used in the component. Now let’s take a look at how to do it.

# 6. Adding methods in components

We have seen how to create reactive variables in a component, using the `data` section of the component. It is also possible to create methods in a component that can be used in the component template.

There are two ways to add methods to a component:

- The first is to define the method in the `methods` section of the component.
- The second is to create a so-called `computed` property that will be defined in the computed section of the component.

Let’s look at these two ways to do it.

## 6-1. Defining methods in the methods section

For each incrementation of the counter, it should be necessary to display the time at which it occurs. A `time()` function would be very useful in the component, allowing us to display the time in the form HH:MM:SS. This `time()` function will be defined in the `methods` section of the component.

The `<counter>` component is modified to integrate the display of the time at the beginning of the line. We can achieve all this using the following code:

<counter> component displaying time (counter.js file)

```
const Counter = {
  data() {
    return {
      count: 0
    }
  },
  template : `{{time()}} &nbsp;&nbsp; The counter is: 
  {{count}}`,
  created() {
    setInterval(() => {
      this.count += 1;
    }, 1000)
  },
  methods : {
    time() {
     // return time as HH:MM:SS
     var date = new Date();
     var hour = date.getHours();
     var min = date.getMinutes();
     var sec = date.getSeconds();
     if (hour < 10) hour = "0" + hour;
     if (min < 10) min = "0" + min;
     if (sec < 10) sec = "0" + sec;
     return "" + hour + ":" + min + ":" + sec + " ";
    }
  }
}
export default Counter;
```

In the preceding code, the `time()` method is defined in the `methods` section and is then directly used in the component template within the double braces `{{` and `}}`.

A method defined in the `methods` section can use the other methods of this section or the reactive variables of the `data` section by prefixing them with the `this` keyword.

The result is displayed in the following figure:

![ 0407 3.8 Time display in the component ](/packtpub/javascript_from_frontend_to_backend_img/0407_3.8_time_display_in_the_component.webp
)
Figure 3.8 – Time display in the component

Vue.js allows you to define, in the form of methods, new variables that will be reactive. They are called computed properties. Let’s see how to create and use them.

## 6-2. Defining computed properties in the computed section

A computed property is similar to a reactive variable. It is the result of the calculation performed on one or more reactive variables, and it will also be reactive. Any modification to one of the reactive variables associated with this computed property will cause it to be modified immediately.

Let’s create a `countX2` property that calculates double the `count` variable as follows:

Defining a computed property countX2 in the component (counter.js file)

```
const Counter = {
  data() {
    return {
      count: 0
    }
  },
  template : `{{time()}} &nbsp;&nbsp; The counter is: 
  {{count}}, double is: {{countX2}}`,
  created() {
    setInterval(() => {
      this.count += 1;
    }, 1000)
  },
  methods : {
    time() {
     // return time as HH:MM:SS
     var date = new Date();
     var hour = date.getHours();
     var min = date.getMinutes();
     var sec = date.getSeconds();
     if (hour < 10) hour = "0" + hour;
     if (min < 10) min = "0" + min;
     if (sec < 10) sec = "0" + sec;
     return "" + hour + ":" + min + ":" + sec + " ";
    }
  },
  computed : {
    countX2() {
      return 2 * this.count;
    }
  }
}
export default Counter;
```

The output of the preceding code will look as follows:

![ 0408 3.9 Using a computed property ](/packtpub/javascript_from_frontend_to_backend_img/0408_3.9_using_a_computed_property.webp
)
Figure 3.9 – Using a computed property

In the preceding figure, we can see the modification of the `count` variable. Every second leads to the automatic modification of the `countX2` variable thanks to its definition in the `computed` section.

We have seen how to define methods and reactive variables in a component. Now let’s see how to pass parameters to a component, using the component’s attributes for this.

# 7. Using attributes in components

Attributes in a component allow it to pass parameters for its use. For example, we could use in the `<counter>` component a `start` attribute indicating at what value we start counting. If this attribute is not indicated, it is considered to be 0 (that is, counting starts at 0 as in the preceding code example).

For a component to be able to employ attributes during its use, it suffices to indicate the name of the attributes in the `props` section of the component. The component can access the attribute value using the `this` keyword (for example, `this.start` to access the `start` attribute in the component). We can see this in action in the following code:

Using the start attribute in the component (index.html file)

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
  
    import Counter from "./counter.js";
    
    var app = Vue.createApp({
      components : {
        Counter:Counter
      },
      template : "<counter start='10' />"
    });
    
    var vm = app.mount("div#app");
    
  </script>
  
</html>
```

In the following code, the attribute is passed when using the component, as is traditionally done in HTML. The value of the attribute here will be a character string `"10"` and not the value `10`:

Setting the start attribute in the <counter> component (counter.js file)

```
const Counter = {
  data() {
    return {
      count : parseInt(this.start),  // we initialize the
                                     // count to the value
                                     // of start
    }
  },
  template : `{{time()}} &nbsp;&nbsp; The counter is: 
  {{count}}, double is: {{countX2}}`,
  created() {
    var timer = setInterval(() => {
      this.count += 1;
    }, 1000)
  },
  methods : {
    time() {
     // return time as HH:MM:SS
     var date = new Date();
     var hour = date.getHours();
     var min = date.getMinutes();
     var sec = date.getSeconds();
     if (hour < 10) hour = "0" + hour;
     if (min < 10) min = "0" + min;
     if (sec < 10) sec = "0" + sec;
     return "" + hour + ":" + min + ":" + sec + " ";
    }
  },
  computed : {
    countX2() {
      return 2 * this.count;
    }
  },
  props : [
    "start"
  ]
}
export default Counter;
```

In the preceding code, notice the use of the `parseInt()` function (defined as standard in JavaScript) to retrieve the value of `this.start` in integer form. Indeed, the attributes are transmitted in the form of character strings, hence the need to transform `this.start` into an integer value.

It is possible to avoid transforming the attribute value into an integer value. All you have to do is indicate when using the attribute that you want to keep the JavaScript value and not the character string. We prefix the name of the attribute with the character :, for example, `:start='10'`. In this case, the value `10` will be transmitted and not the string `"10"`.

This makes it possible to be able to transmit in the attributes any types of values: numeric values, character strings, arrays, or objects.

In the following figure we can see the counter has started from the value indicated in the `start` attribute:

![ 0409 3.10 Using the start attribute in ](/packtpub/javascript_from_frontend_to_backend_img/0409_3.10_using_the_start_attribute_in.webp
)
Figure 3.10 – Using the start attribute in the component

We have therefore seen how to create new attributes in a component. Vue.js has specific attributes as standard, which can be used in all components. These specific attributes, created by Vue.js, are called directives. We will study them now.

# 8. Using directives

Vue.js improves the writing of HTML code by offering to write its own components, as we have seen in the preceding section. The framework also makes it easier to write basic HTML code by adding new attributes to the HTML elements or to the components created. These new attributes are called directives.

Note

Directives are used exclusively in HTML elements or created components, that is, in the `template` section of components.

Their name begins with v-, so as not to be confused with other existing HTML attributes. The main directives are `v-if`, `v-else`, `v-show`, `v-for`, and `v-model`. They will be explained now.

## 8-1. The v-if and v-else directives

The `v-if` directive is used to specify a condition. If true, the HTML element (or component) will be inserted into the HTML page. Otherwise, it will not be present.

Let’s use the `v-if` directive to indicate that we want to display the value of the counter only for values less than or equal to 20. As soon as the value 20 is exceeded, the counter is no longer displayed.

In the following snippet, we have only indicated the code of the `template` section of the component, knowing that the rest is not modified:

Using the v-if directive

```
template : `
  {{time()}} &nbsp;&nbsp;
  <span v-if='count<=20'>The counter is: {{count}}</span>
`,
```

Using backticks `'` and `'` to define the template avoids having to manage the concatenation of character strings on several lines.

The `<span>` element on which the `v-if` directive is applied will be included in the HTML page only if the following condition is true: if `count<=20`. Beyond 20, only the time will be displayed without the counter value.

As long as the counter is less than or equal to 20, it is displayed as follows:

![ 0410 3.11 Display of the counter whose ](/packtpub/javascript_from_frontend_to_backend_img/0410_3.11_display_of_the_counter_whose.webp
)
Figure 3.11 – Display of the counter whose value is less than 20

When the counter exceeds the value 20, it is no longer displayed:

![ 0411 3.12 Display as soon as the counter ](/packtpub/javascript_from_frontend_to_backend_img/0411_3.12_display_as_soon_as_the_counter.webp
)
Figure 3.12 – Display as soon as the counter exceeds the value 20

The `v-else` directive is used to indicate an alternative when the condition expressed in `v-if` is `false`. The element on which the `v-else` directive is used will be inserted into the HTML page if the condition expressed in `v-if` is `false`.

Let’s use the `v-else` directive to display another message when the counter exceeds the value 20:

Using the v-else directive

```
template : `
  {{time()}} &nbsp;&nbsp;
  <span v-if='count<=20'>The counter is: {{count}}</span>
  <span v-else>The counter has exceeded 20, it is: 
  {{count}}</span>
`,
```

When the counter exceeds the value 20, we now get the following:

![ 0412 3.13 Counter having exceeded the ](/packtpub/javascript_from_frontend_to_backend_img/0412_3.13_counter_having_exceeded_the.webp
)
Figure 3.13 – Counter having exceeded the value 20

## 8-2. The v-show directive

The `v-show` directive is similar to the `v-if` directive. A condition is given next. If the condition is `true`, the element that uses the directive is displayed; otherwise, it is not.

The difference from the `v-if` directive is that the element, if not displayed, is only hidden, but it is still inserted into the page. Whereas with the `v-if` directive, the element is not inserted (if the condition is `false`).

## 8-3. The v-for directive

The `v-for` directive allows you to loop over a set of elements or over the properties of an object. For each iteration of the loop, it inserts the HTML element on which the directive is positioned.

Let us assume the `<counter>` component is a set of counters associated with the variable `counts`, which is a JavaScript array. Each counter is, in our example, a character string (for example, `"Counter 1"`), and we want to display the whole in the form of a list (see the following code snippets).

Let’s look at the two possible forms of the `v-for` directive.

### (83-1) Using the directive v-for=”count in counts”

Let’s use the first form of the `v-for` directive. It allows access to each element of the array indicated in the directive (in our example, the JavaScript `counts` array):

Displaying counters as a list (counter.js file)

```
const Counter = {
  data() {
    return {
      counts : ["Counter 1", "Counter 2", "Counter 3", 
      "Counter 4", "Counter 5"]
    }
  },
  template : `
    <ul>
      <li v-for="count in counts">
        <span>{{count}}</span>
      </li>
    </ul>
  `,
}
export default Counter;
```

In the preceding code, we have positioned the `v-for` directive on the element that we want to repeat (in this case, the `<li>` element). The value associated with the `v-for` directive is a character string of the form `"count in counts"`, knowing that `counts` is the variable on which we are iterating. The `count` variable thus corresponds to each of the elements of the `counts` array:

![ 0413 3.14 Using the v-for directive ](/packtpub/javascript_from_frontend_to_backend_img/0413_3.14_using_the_v-for_directive.webp
)
Figure 3.14 – Using the v-for directive

### (83-2) Using the directive v-for=”(count, index) in counts”

A second form of the v-for directive gives access to each element of the array as before, but also to its index (starting from 0):

Displaying counters and their index (counter.js file)

```
const Counter = {
  data() {
    return {
      counts : ["Counter 1", "Counter 2", "Counter 3", 
      "Counter 4", "Counter 5"]
    }
  },
  template : `
    <ul>
      <li v-for="(count, index) in counts">
        <span>Index {{index}} : {{count}}</span>
      </li>
    </ul>
  `,
}
export default Counter;
```

On running the preceding code, the following is displayed:

![ 0414 3.15 Using index in the v-for directive ](/packtpub/javascript_from_frontend_to_backend_img/0414_3.15_using_index_in_the_v-for_directive.webp
)
Figure 3.15 – Using index in the v-for directive

### (83-3) Using the key attribute with the v-for directive

The `v-for` directive can also be used to display large lists, for which reactivity must be maintained. That is, changing the reactive variable specified in the `v-for` directive should update the corresponding displayed list.

To perform the update as quickly as possible, Vue.js uses a special attribute (to be used only for this specific case) named `key`. This attribute can be positioned after the `v-for` directive. Its value must be unique for each item in the list. For example, the value of the index being unique for each list element can be used as a value in the `key` attribute:

Using the key attribute with the v-for directive

```
<li v-for="(count, index) in counts" :key="index">
```

In the preceding code, the value of the attribute is a JavaScript expression (the variable `index`). We use `:key` and not just `key`; otherwise, the attribute would constantly have the string `"index"` as its value (instead of the value of the variable `index`).

Of course, adding the `key` attribute does not produce any display changes, but the performance will be visible on subsequent changes to the displayed list (it helps Vue.js to keep track of the element and prevent unnecessary re-rendering).

## 8-4. The v-model directive

The `v-model` directive is used to manage form elements during an interaction (input in a field, a click on a checkbox or radio button, the choice of an element in a list).

The `v-model` directive is used to immediately retrieve the result of input or selection in a reactive variable without having to perform any particular processing. It’s the `v-model` directive that performs this update (of the reactive variable) for us.

We use the `v-model` directive in the form `v-model="varname"`, where `varname` is the name of a reactive variable that will be updated on input or selection.

Let’s use the `v-model` directive in a form input field. To clearly see what happens with or without its use, we display two input fields: one managed without `v-model`, the other with:

Using the v-model directive in an input field (counter.js file)

```
const Counter = {
  data() {
    return {
      count : 10
    }
  },
  template : `
    Without v-model:
      <input type="text" :value="count" /> &nbsp;&nbsp; 
      count = {{count}} <br><br>
    With v-model:
      <input type="text" v-model="count" /> &nbsp;&nbsp; 
      count = {{count}}
  `,
}
export default Counter;
```

Here are some notes on the preceding program:

- The first `<input>` field does not use `v-model`, but only uses the `value` attribute, which will be updated based on the `count` variable.
- The second `<input>` field uses the `v-model` directive associated with the same `count` variable.
- The value of the `count` variable is displayed after the two input fields.

When the program is launched, the value of the reactive variable `count` is transferred to the `value` attribute of the first input field, as well as to the second. This produces the initialization of the contents of the two input fields as seen here:

![ 0415 3.16 Display when starting the program ](/packtpub/javascript_from_frontend_to_backend_img/0415_3.16_display_when_starting_the_program.webp
)
Figure 3.16 – Display when starting the program

If we change the contents of the first input field (which is not used with `v-model`), we will see something like this:

![ 0416 3.17 Editing an input field without v-model ](/packtpub/javascript_from_frontend_to_backend_img/0416_3.17_editing_an_input_field_without_v-model.webp
)
Figure 3.17 – Editing an input field without v-model

Note that modifying the input field (without `v-model`) has no effect on the reactive variable associated with it.

Now let’s modify the contents of the second input field, managed by `v-model`:

![ 0417 3.18 Editing an input field with v-model ](/packtpub/javascript_from_frontend_to_backend_img/0417_3.18_editing_an_input_field_with_v-model.webp
)
Figure 3.18 – Editing an input field with v-model

We now see that the use of `v-model` causes the immediate modification of the reactive variable to which it is associated, which then causes the modification of the `value` attribute of the first input field (because it is linked to the reactive variable).

# 9. Summary

In this chapter, we have mainly studied how to create a component and methods or attributes associated with it.

It is now necessary to study how to manage the actions of the user in a component, then how to assemble the components to form an application.



> [ 04 P2 JavaScript on the Client-Side ](/packtpub/javascript_from_frontend_to_backend/04_p2_javascript_on_the_client-side) <---> [ 06 C4 Advanced Concepts of Vue.js ](/packtpub/javascript_from_frontend_to_backend/06_c4_advanced_concepts_of_vue_js)
>
> Title: 05 C3 Getting Started with Vue.js
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/05_c3_getting_started_with_vue_js
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-06 목 13:09:22
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 05_c3_getting_started_with_vue.js.md

