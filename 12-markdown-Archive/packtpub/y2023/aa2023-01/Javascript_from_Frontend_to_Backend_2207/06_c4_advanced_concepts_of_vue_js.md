
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

> [ 05 C3 Getting Started with Vue.js ](/packtpub/javascript_from_frontend_to_backend/05_c3_getting_started_with_vue_js) <---> [ 07 C5 Managing a List with Vue.js ](/packtpub/javascript_from_frontend_to_backend/07_c5_managing_a_list_with_vue_js)

# Chapter 4: Advanced Concepts of Vue.js

In this chapter, we look at advanced uses of Vue.js. We will study the handling of events in components, then the assembly of the various components in order to form a whole Vue.js application.

Why is it important to know how to handle events in components?

A Vue.js component is often a set of HTML elements, like building blocks, such as buttons, lists, and input fields. It is therefore essential to know how to manage the interaction of these elements with the possible actions of the user, such as clicking on a button, entering a value in an input field, or selecting an element from a list.

Similarly, why is it important to know how to assemble the components?

A web application brings together many elements, which in the end, will represent the application as a whole. The principle of Vue.js is to break down an application into components, then assemble them to form the complete application. We will have to learn how to divide an application into components, then assemble them by allowing them, for example, to share data.

We end this chapter by showing how we can easily produce visual effects on your pages thanks to Vue.js.

Here are the main topics we explain in the following pages:

- Managing events
- Assembling components
- Using visual effects

# Technical requirements

You can find the code files for this chapter on GitHub at: https://github.com/PacktPublishing/JavaScript-from-Frontend-to-Backend/blob/main/Chapter%204.zip.

# Managing events

Now let’s see how to handle events with Vue.js. To do this, use the `v-on` directive, followed by the character : and the name of the event to be handled. For example, if you want to perform a particular process when a button is clicked, we will use the `click` event on the button and we will write `v-on:click` to handle the `click` event. The value of the directive (which follows the = sign) corresponds to the JavaScript expression to be executed (either a statement or a function call).

Tip

Vue.js makes it easier to write `v-on:click` by writing `@click` more simply. This rule is valid for all events.

In this example, we will implement a button that increments a reactive variable `count` on each click. We will also define an `incr()` method in the `methods` section of the component that increments the `count` variable:

Increment counter count (counter.js file)

```
const Counter = {
  data() {
    return {
      count : 0
    }
  },
  template : `
    <button @click="count++">Increment counter by 
    count++</button> 
       &nbsp;&nbsp; count = {{count}} <br><br>
    <button @click="incr()">Increment counter by 
    incr()</button> 
      &nbsp;&nbsp; count = {{count}}
  `,
  methods : {
    incr() {
      this.count++;
    }
  }
}
export default Counter;
```

We have defined two buttons for which the value of `@click` is as follows:

- `@click="count++"` (first button)
- `@click="incr()"` (second button)

We thus show the equivalence of these forms of writing.

The counter is incremented by 1 with each click of the buttons.

![ 0500 4.1 Button click management ](/packtpub/javascript_from_frontend_to_backend_img/0500_4.1_button_click_management.webp
)
Figure 4.1 – Button click management

It is possible to write several method calls in a row during the processing to be performed (separated by a comma or a semicolon). It is enough that these methods are defined in the `methods` section of the component.

For example, `@click="incr();incr()"` allows the `incr()` method to be executed twice each time the button is clicked.

We have explained here how to catch an event and handle it in a method defined in the `methods` section of the component. Let’s go further by using the parameters transmitted in the received event, for example, knowing which key on the keyboard was pressed.

# Using the $event parameter

Vue.js provides access to the `Event` object associated with the event. This object can then be used to get additional information about the event. The information is different depending on the type of event:

- Mouse coordinates or buttons clicked on the mouse for a mouse-related event
- Keyboard key used, or the combination of keys pressed (Ctrl, Shift, Esc, and so on) for a keyboard-related event

The `Event` object can be accessed from the `$event` variable. It can be passed as a parameter to a processing method. This parameter will then be retrieved in the event processing function.

Let’s see two examples of how to use this parameter when entering characters in an edit control:

- By displaying an error message as soon as the numerical value entered equals or exceeds the value 100
- By prohibiting the entry of characters other than numeric characters if the edit control can only contain numbers (this is an improvement of the previous example)

## Checking that the entered value is less than 100

Let’s use the `$event` parameter to check that the content of the `counter` input field is less than 100. If so, the `count` variable is updated with the entered value; otherwise, an error message is displayed.

To achieve this, we use the `blur` event on the input field, and in the processing of the event, we retrieve the value of the input field. A reactive `message` variable is used to display an error message, if necessary:

Note

The `blur` event is triggered when leaving the input field, for example, by clicking outside the input field.

Display an error message if the counter is greater than 100 (counter.js file)

```
const Counter = {
  data() {
    return {
      count : 0,
      message : ""
    }
  },
  template : `
    count (less than 100): <input type="text" 
    :value="count" @blur="valid($event)" />
     &nbsp;&nbsp; count = {{count}} 
    <br><br>
    <span>{{message}}</span>
  `,
  methods : {
    valid(event) {
      this.message = "";  // reset of the error message 
                          // before each check
      if (event.target.value < 100) this.count = 
      event.target.value;
      else this.message = "Error: count must be less than 100";
    }
  }
}
export default Counter;
```

The `$event` parameter is passed to the `valid(event)` processing function. The `event.target` property provides direct access to the HTML element. Its `value` property contains the value of the field.

If you type a value less than 100 (here, 45), the counter is updated:

![ 0501 4.2 Entering an authorized value ](/packtpub/javascript_from_frontend_to_backend_img/0501_4.2_entering_an_authorized_value.webp
)
Figure 4.2 – Entering an authorized value

If you type a value greater than 100 (for example, `150`), an error is displayed and the old value of the counter (`45`) is restored.

![ 0502 4.3 Entering a prohibited value ](/packtpub/javascript_from_frontend_to_backend_img/0502_4.3_entering_a_prohibited_value.webp
)
Figure 4.3 – Entering a prohibited value

Then, we’ll look at another use of `$event` parameter-allowing only digits to be entered.

## Allowing only digits to be entered

Another use of the `$event` parameter can be to only allow numbers to be entered into the field. Other keyboard keys are prohibited (except the Backspace and Delete keys, the right and left arrow keys, and the Tab key).

For this, we use the `keydown` event, which is triggered each time a key on the keyboard is pressed:

Disallow input of non-numeric characters (counter.js file)

```
const Counter = {
  data() {
    return {
      count : 0,
      message : ""
    }
  },
  template : `
    count (less than 100):
    <input type="text" :value="count" @blur="valid($event)" 
    @keydown="verif($event)"/>
      &nbsp;&nbsp; count = {{count}} 
    <br><br>
    <span>{{message}}</span>
  `,
  methods : {
    valid(event) {
      this.message = "";  // reset of the error message 
                          // before each check
      if (event.target.value < 100) this.count = event.target.
      value;
      else this.message = "Error: count must be less than 100";
    },
    verif(event) {
      console.log(event.key);   // display in the console 
                                // the value of the key 
                                // pressed
      if (event.key != "Backspace" && event.key != "Delete" 
      && 
          event.key != "ArrowLeft" && event.key != 
          "ArrowRight" &&
          event.key != "Tab") {
        // forbid the key if it is not numeric
        if (event.key < "0" || event.key > "9") 
        event.preventDefault();  // forbidden key
      }
    }
  }
}
export default Counter;
```

The event used to filter the keys corresponds to `keydown` and gets activated when pressing a key on the keyboard. We therefore indicate to process each key press using the `verif()` method defined in the `methods` section.

Using event.key and event.preventDefault()

The `event.key` parameter contains the code of the key pressed. The key code is between “0” and “9” for a numeric value. To prohibit the other keys, we use the `event.preventDefault()` method (defined in JavaScript), which indicates not to take into account the event, therefore the pressing of the prohibited key.

We learned how to create a component in Chapter 3, Getting Started with Vue.js, and how to manage events in it (at the beginning of this chapter). A full application is composed of several components. Let’s now explain how to proceed to assemble several components to form a complete application.

# Assembling components

Vue.js divides an application into a set of components. These components are then assembled to form the final application.

Let’s study an example of how to create components and then assemble the created components. The goal is to use three counters (associated with three input fields) like the one in the previous example, then display the total of these counters. The total updates, as numbers are typed into each of the input fields.

We will create two components for this:

- The `<counter>` component is used to manage a counter.
- The `<counters>` component allows you to manage the three counters together and display the total.

The `index.html` file will display the `<counters>` component in its `template` section:

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
  
    import Counters from "./counters.js";
    
    var app = Vue.createApp({
      components : {
        Counters:Counters
      },
      template : `
        <counters />
      `,
    });
    
    var vm = app.mount("div#app");
    
  </script>
  
</html>
```

The included `counters.js` file describes the `<counters>` component. It partly repeats what has been explained in the previous sections, adding new concepts that we’ll now describe.

These new concepts will explain how a parent component communicates with its child components (thanks to attributes, called `props`) and how a child component communicates with its parent component (thanks to events and the `$emit()` method).

These two concepts make it possible to assemble the components between them by allowing them to communicate between a child component and a parent component.

## Using $emit() to communicate with a parent component

Let’s first look at the `<counter>` component file, which describes a counter associated with an input field:

<counter> component (counter.js file)

```
const Counter = {
  data() {
    return {
      count : 0,
      old_value : 0
    }
  },
  template : `
    <input type="text" v-model="count" 
       @keydown="verif($event)" 
       @input="calcul()" 
       @focus="focus()" 
       @blur="blur()" />
  `,
  methods : {
    verif(event) {
      if (event.key != "Backspace" && event.key != "Delete" && 
          event.key != "ArrowLeft" && event.key != 
          "ArrowRight" &&
          event.key != "Tab") {
        // forbid the key if it is not numeric
        if (event.key < "0" || event.key > "9") 
        event.preventDefault();  // key forbidden
      }
      this.old_value = event.target.value;
    },
    calcul() {
      this.$emit("sub", this.old_value || 0);  // subtract 
                                               // old value
      this.$emit("add", this.count || 0);      // add new value
    },
    focus() {
      if (this.old_value == "0") this.count = "";
    },
    blur() {
      if (!parseInt(this.count)) {
        this.old_value = 0; 
        this.count = 0;
      }
    }
  },
  emits : ["sub", "add"]    // declare events emitted to 
                            // the parent
}
export default Counter;
```

The `<counter>` component has been enriched with new methods, linked to new events to be taken into account during input. Also, a new reactive variable, `old_value`, has been created:

- The `old_value` variable contains the value that was entered in the field before pressing the key on the keyboard.
- The `count` variable contains the value that was entered in the field after pressing the key on the keyboard.

Why make this distinction? Because to calculate the total of all the counters, it will be necessary, with each typed key, to remove the previous value from the field (before pressing the key) and add the new value (after pressing the key).

Each keypress is handled by the `input` event, which here calls the `calcul()` method. As the calculation associated with the total of the three counters is performed at the higher level (in the `<counters>` component, which is the parent component), you must indicate to this parent component the sum to subtract (`old_value`) and the sum to add (`count`). This is done by sending `"sub"` and `"add"` events, using the `$emit(eventName, value)` method.

### About the $emit(eventName, value) Method

The `$emit(eventName, value)` method, executed from a component, sends the `eventName` event to the parent component, which can process it using the `@eventName` directive. The `value` parameter corresponds to the value to be transmitted if necessary.

In addition, we indicate in the `emits` section of the component the list of events that this component can emit to its parent.

This way of communicating between a child component (here, the `<counter>` component) and its parent (here, the `<counters>` component), using events, is the one recommended by Vue.js.

Now let’s see the description of the `<counters>` component, which encompasses the three counters and the calculation of the total counters as you type in each one:

<counters> component (counters.js file)

```
import Counter from "./counter.js";
const Counters = {
  data() {
    return {
      total : 0
    }
  },
  components : {
    Counter:Counter
  },
  template : `
      Counter 1 : <counter @add="add($event)" 
      @sub="sub($event)" /> <br>
      Counter 2 : <counter @add="add($event)" 
      @sub="sub($event)" /> <br>
      Counter 3 : <counter @add="add($event)" 
      @sub="sub($event)" /> <br><br>
      Total : {{total}} <br>
  `,
  methods : {
    add(value) {
      this.total += parseInt(value);
    },
    sub(value) {
      this.total -= parseInt(value);
    }
  },
}
export default Counters;
```

The `"add"` and `"sub"` events emitted in the `<counter>` child component are processed in the attributes of the `<counter>` component when used. The `add(value)` and `sub(value)` processing methods are registered in the parent component, which allows the value of the total to be changed each time a numeric key is pressed on the keyboard.

As you type in the fields, **Total** updates:

![ 0503 4.4 Calculation of the sum of ](/packtpub/javascript_from_frontend_to_backend_img/0503_4.4_calculation_of_the_sum_of.webp
)
Figure 4.4 – Calculation of the sum of the three counters

We have seen how to communicate from a component to its parent using events. Now let’s look at how to communicate in the other direction, from a component to its child. For this, we use attributes called props here.

## Using props to communicate with children

We have seen that the communication of information from a child component to its parent is done with events. Communication in the reverse direction, from parent to child, is done through attributes called `props.` We have already seen the use of these attributes in the previous chapter, in the Using attributes in components section.

In this example, we will improve the `<counters>` component so that we tell it the number of counters we want to display. For this, we use the `nb` attribute in the component. For example, we will write `<counters nb="5" />` to display 5 counters on the page. Each counter is displayed as in the previous form, namely `Counter` followed by its index starting from 1 (see Figure 4.5).

First, we will modify the `index.html` file to write the `<counters>` component using the `nb` attribute. Let’s modify the `index.html` file previously used:

Using <counters nb=”5” /> (index.html file)

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
  
    import Counters from "./counters.js";
    
    var app = Vue.createApp({
      components : {
        Counters:Counters
      },
      template : `
        <counters nb="5" />
      `,
    });
    
    var vm = app.mount("div#app");
    
  </script>
  
</html>
```

Now, we will modify the `counters.js` file to integrate the new `"nb"` props into the component:

Integration of the nb props in the <counters> component (counters.js file)

```
import Counter from "./counter.js";
const Counters = {
  data() {
    return {
      total : 0
    }
  },
  components : {
    Counter:Counter
  },
  props : ["nb"],
  computed : {
    NB() {
      var tab = [];
      for(var i = 0; i < this.nb; i++) tab.push(i+1);
      return tab;
    }
  },
  template : `
    <div v-for="i in NB">
      Counter {{i}} : <counter @add="add($event)" 
      @sub="sub($event)" />
    </div>
    <br>
    Total : {{total}} <br>
  `,
  methods : {
    add(value) {
      this.total += parseInt(value);
    },
    sub(value) {
      this.total -= parseInt(value);
    }
  },
}
export default Counters;
```

The `"nb"` props are listed in the component’s `props` section. To display a list of counters, use the `v-for` directive on a `<div>` element.

### How to Use the v-for Directive

For the value of the `v-for` directive, you must specify an array to browse. To do this, we transform the value of the `"nb"` props into an array `[1, 2, 3, …, nb]`. This is done using a computed property named `NB`, which returns the desired array.

The number of counters indicated when using the `<counters nb="5">` component is now displayed.

![ 0504 4.5 Displaying five counters ](/packtpub/javascript_from_frontend_to_backend_img/0504_4.5_displaying_five_counters.webp
)
Figure 4.5 – Displaying five counters

We end the study of the Vue.js components here, which come together to form a full application.

Now, let’s examine an aspect of Vue.js that helps you produce visual effects, allowing, for example, making HTML elements displayed on the HTML page appear or disappear using a visual effect.

# Using visual effects

Visual effects make it possible to make HTML pages more dynamic by bringing visual animations to them. For example, to delete an item in a list, you can make it gradually disappear using an opacity effect rather than deleting it directly without using a visual effect.

It is possible to use visual effects with Vue.js, in particular, to make elements appear or disappear from the page. Visual effects that do not make HTML elements appear or disappear from the page (for example, making an element move by clicking on it) are also possible with Vue.js. You can refer to https://vuejs.org/guide/extras/animation.html for more details on these types of animations. We do not explain these effects here because the available documentation is clear enough to use them.

Going forward in this chapter, we will learn about the visual effects that are related to the appearance or disappearance of one or more elements on the page.

The element we want to help appear or disappear (using the visual effect) must be inserted in a component named `<transition>`. This component is used by Vue.js to produce the effect.

Moreover, Vue.js uses the definition of CSS classes in which the CSS properties of the effect are described. Simply define the contents of the CSS classes (described in the following section), and Vue.js uses them at the appropriate times to achieve the effect.

The CSS classes used by Vue.js on an element depend on the state of the element: should it appear or disappear? Depending on its state (visible or not), the CSS classes differ.

## When the element appears

When the HTML element should appear, the names of the CSS classes used by Vue.js begin with the character string `"v-enter"`. The class name then contains the suffix `"-from"` or `"-to"`, which will be used to describe the CSS properties of the element at the start of the effect (with `"-from"`) or at the end of the effect (with `"-to"`).

### CSS classes used by Vue.js

So, we will have the following two CSS classes:

- `v-enter-from`: This CSS class describes the CSS properties at the start of the element’s appear effect.
- `v-enter-to`: This CSS class describes the CSS properties at the end of the element’s appear effect.

Note

Note that at the start of the appear effect, the element is not visible, but the CSS properties described in the `v-enter-from` class are applied to it immediately. If, for example, we enter the CSS `opacity` property equal to `1` in the CSS properties of the `v-enter-from` class, the element becomes immediately visible as soon as the appearance effect starts.

Since the `v-enter-to` class describes the CSS properties of the element at the end of the effect, when the effect completes, Vue.js removes that CSS class from the element.

We thus see that the CSS classes `v-enter-from` and `v-enter-to` are used to describe the CSS properties of an element during the effect but are no longer used afterward on the element (i.e., outside the duration of the effect).

The appearance effect progresses the CSS properties described in `v-enter-from` to those described in `v-enter-to`. For this, Vue.js uses the `v-enter-active` class, which describes how each of the CSS properties evolves.

### Example content of CSS classes

Let’s look at some sample content from each of the three CSS classes mentioned above, `v-enter-from`, `v-enter-to`, and `v-enter-active`:

v-enter-from class example

```
.v-enter-from {
  opacity: 0;
  background-color:#FFCCCC;
}
```

Here, we indicate that the element will be invisible at the start of the effect (`opacity:0`) and will have a background color (`background-color:#FFCCCC`):

v-enter-to class example

```
.v-enter-to {
  opacity: 0.5;
  background-color:black;
}
```

Here, we indicate that the element will be half visible at the end of the effect (`opacity:0.5`) and will have a black background (`background-color:black`):

v-enter-active class example

```
.v-enter-active {
  transition: opacity 2s, background-color 2s;
}
```

Here, we indicate that the CSS `opacity` and `background-color` properties must evolve, each for two seconds. As all the specified CSS properties evolve for the same amount of time, we can simplify the code by writing it in shortened form. Here’s how:

v-enter-active class example (simplified form)

```
.v-enter-active {
  transition: all 2s;
}
```

The `all` keyword overrides all specified CSS properties.

### Using CSS classes

Now let’s show how to use these CSS classes in a program using a button that displays a paragraph with effect. The role of the button will be to hide or display, alternatively, a paragraph on which the effect will occur when the paragraph appears.

This shows how the `v-enter-from`, `v-enter-to`, and `v-enter-active` CSS classes are used by Vue.js to produce an effect when an element appears on the page:

Use a button to produce the appearance effect (index.html file)

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
    
    <style type="text/css">
      .v-enter-from {
        opacity: 0;
        background-color:#FFCCCC;
      }
      .v-enter-to {
        opacity: 0.5;
        background-color:black;
      }
      .v-enter-active {
        transition: opacity 2s, background-color 2s;
      }
    </style>
  </head>
  <body>
    <div id="app"></div>
  </body>
  
  <script>
  
    var app = Vue.createApp({
      data() {
        return {
          show: false    // initially hidden
        }
      },
      template : `
        <button @click="show=!show">Produce the 
        effect</button>
        <transition>
          <p v-if="show">
            Paragraph 1
          </p>
        </transition>   
      `,
    });
    
    var vm = app.mount("div#app");
    
  </script>
  
</html>
```

We have described the contents of the `v-enter-from`, `v-enter-to`, and `v-enter-active` CSS classes, which will be used by Vue.js to produce the effect. Then we inserted the **Produce an effect** button in the page so that when the button is clicked, the paragraph on which the effect is set to occur will alternately be hidden or displayed. To do this, the paragraph was inserted in an HTML `<transition>` element, thus allowing Vue.js to know the element on which to apply the effect.

The paragraph is hidden at startup (because the reactive variable `show` is set to `false`). Clicking the **Produce the effect** button changes the value of the `show` variable to `true`, which starts the effect.

Note

The effect is started on the paragraph thanks to the `<transition>` component, which includes the paragraph to be displayed. It is thanks to this `<transition>` component that Vue.js knows the element on which to produce the effect.

Notice that the effect lasts two seconds as indicated in the CSS `transition` property, and when the effect is finished, the CSS classes are removed from the `<p>` element, which then becomes a normal paragraph (without background color and with an opacity of 1). So, you see that the paragraph has an opacity of 0.5 at the end of the effect (the one indicated in `v-enter-to`), then suddenly changes to an opacity of 1 when the `v-enter-to` class is removed by Vue.js at the end of the effect.

Note

It is therefore preferable to indicate in the `v-enter-to` class the CSS values of the element when it no longer produces an effect, in order to make the effect more harmonious.

Let’s run the previous program. When the program is launched, the paragraph is hidden:

![ 0505 4.6 The paragraph is hidden when ](/packtpub/javascript_from_frontend_to_backend_img/0505_4.6_the_paragraph_is_hidden_when.webp
)
Figure 4.6 – The paragraph is hidden when the program is launched

After clicking the **Produce the effect** button, the paragraph begins to appear, according to the CSS properties indicated in the `v-enter-from`, `v-enter-to`, and `v-enter-active` classes.

![ 0506 4.7 After clicking on the Produce ](/packtpub/javascript_from_frontend_to_backend_img/0506_4.7_after_clicking_on_the_produce.webp
)
Figure 4.7 – After clicking on the Produce the effect button, the paragraph appears progressively

Just before the effect ends, the paragraph has the CSS properties set in the `v-enter-to` class, so its background color is black, but with an opacity of 0.5, the background color remains gray, and the paragraph text is not visible.

![ 0507 4.8 Paragraph just before the end ](/packtpub/javascript_from_frontend_to_backend_img/0507_4.8_paragraph_just_before_the_end.webp
)
Figure 4.8 – Paragraph just before the end of the effect

At the end of the effect, the CSS classes are removed so that the paragraph appears in a normal way, in black and without a background color.

![ 0508 4.9 Paragraph at the end of the ](/packtpub/javascript_from_frontend_to_backend_img/0508_4.9_paragraph_at_the_end_of_the.webp
)
Figure 4.9 – Paragraph at the end of the appear effect

Once the paragraph has appeared, clicking on the **Produce the effect** button makes it disappear immediately (without producing any effect). This is due to the reactive variable `show` being set to `false` when the button is clicked.

We have seen the different classes and stages when an element appears on the page. Now let’s see what happens when an element disappears from the page. We will see that there are many similarities between the appearance and disappearance of the element.

## When the element disappears

When the element should disappear, Vue.js uses CSS classes similar to the previous ones, replacing the string `"enter"` with the string `"leave"`.

### CSS classes used by Vue.js

So, we will have the following two CSS classes:

- `v-leave-from`: This CSS class describes the CSS properties at the start of the element’s disappearing effect.
- `v-leave-to`: This CSS class describes the CSS properties at the end of the element’s disappearing effect.

The disappearing effect is going to be to progress the CSS properties described in `v-leave-from` to those described in `v-leave-to`. After the effect is complete, the `v-leave-to` class is removed from the element’s CSS classes.

To progress CSS properties between the values shown in these two classes, Vue.js uses the `v-leave-active` CSS class, which describes the progression of CSS properties.

### Example content of CSS classes

Let’s look at some example content from each of the three CSS classes mentioned above: `v-leave-from`, `v-leave-to`, and `v-leave-active`:

v-leave-from class example

```
.v-leave-from {
  opacity: 1;
  background-color:#FFCCCC;
}
```

Here, we indicate that the element will be fully visible at the start of the effect (`opacity:1`) and will have a background color (`background-color:#FFCCCC`):

v-leave-to class example

```
.v-leave-to {
  opacity: 0;
  background-color:black;
}
```

Here, we indicate that the element will be invisible at the end of the effect (`opacity:0`) and will have a black background color (`background-color:black`):

v-leave-active class example

```
.v-leave-active {
  transition: opacity 2s, background-color 2s;
}
```

Here, we indicate that the CSS `opacity` and `background-color` properties must evolve, each for two seconds. As all the specified CSS properties evolve for the same amount of time, you can simplify the code by writing it in shortened form:

v-leave-active class example

```
.v-leave-active {
  transition: all 2s;
}
```

The `all` keyword overrides all specified CSS properties.

### Using CSS classes

Now let’s show how to use these CSS classes in a program, using a button that hides a paragraph with an effect. It’s almost the same program as before, but here we produce an effect when the paragraph disappears:

Using a button to produce the disappearing effect (index.html file)

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
    
    <style type="text/css">
      .v-leave-from {
        opacity: 1;
        background-color:#FFCCCC;
      }
      .v-leave-to {
        opacity: 0;
        background-color:black;
      }
      .v-leave-active {
        transition: all 2s;
      }
    </style>
  </head>
  <body>
    <div id="app"></div>
  </body>
  
  <script>
  
    var app = Vue.createApp({
      data() {
        return {
          show: true   // visible at start
        }
      },
      template : `
        <button @click="show=!show">Produce the effect</button>
        <transition>
          <p v-if="show">
            Paragraph 1
          </p>
        </transition>   
      `,
    });
    
    var vm = app.mount("div#app");
    
  </script>
  
</html>
```

The `v-leave-from` class is applied at the beginning of the effect. It indicates that the element is visible (`opacity` at 1) and has a background color `#FFCCCC` (salmon).

The `v-leave-to` class indicates the values of CSS properties when the effect ends. The paragraph becomes invisible (`opacity` at 0) and has a black background color. But as the element becomes more and more invisible (`opacity` tends toward 0), the black background color also becomes less and less visible.

If we write the `enter` and `leave` classes in the CSS part in the same program, with each click on the button, we obtain an effect of appearing or disappearing for the paragraph concerned.

The CSS classes used here have fixed names, regardless of the effect used. This does not allow using multiple effects, as the visual effects would all use the same CSS class names.

For this, Vue.js allows you to give a name to each effect, and thus be able to use different CSS class names.

# Using a name for the effect

Classes of type `"v-enter-xxx"` or `"v-leave-xxx"` can be renamed to symbolize the effect with which they are associated. We just need to replace the character string `"v-"` with the name of the effect followed by `"-"`.

For example, `"v-enter-from"` will be replaced by `"fade-enter-from"` to give the name `"fade"` to the effect. We then add the `name="fade"` attribute to the `<transition>` component, indicating `<transition name="fade">`.

This allows us to integrate several effects into our application, by defining the CSS classes corresponding to each effect.

The previous program, integrating the effect named `"fade"` in the paragraph, is then written as follows:

Fade effect (index.html file)

```
<html>
  <head>
    <meta charset="utf-8" />
    <script src="https://unpkg.com/vue@next"></script>
    
    <style type="text/css">
      .fade-leave-from {
        opacity: 1;
        background-color:#FFCCCC;
      }
      .fade-leave-to {
        opacity: 0;
        background-color:black;
      }
      .fade-leave-active {
        transition: all 2s;
      }
      
      .fade-enter-from {
        opacity: 0;
        background-color:#FFCCCC;
      }
      .fade-enter-to {
        opacity: 1;
        background-color:black;
      }
      .fade-enter-active {
        transition: opacity 2s, background-color 2s;
      }      
    </style>
  </head>
  <body>
    <div id="app"></div>
  </body>
  
  <script>
  
    var app = Vue.createApp({
      data() {
        return {
          show: true
        }
      },
      template : `
        <button @click="show=!show">Produce the 
        effect</button>
        <transition name="fade">
          <p v-if="show">
            Paragraph 1
          </p>
        </transition>   
      `,
    });
    
    var vm = app.mount("div#app");
    
  </script>
  
</html>
```

The `<transition>` component can only have one element, which will be the one on which the effect will occur. To include multiple elements, you must use the `<transition-group>` component, which we explain below.

# Producing an effect on several elements

The `<transition>` component can contain only one element. When the effect must be applied to several elements, it is necessary to create several `<transition>` components or group the elements in a `<transition-group>` component. In this example, let’s look at using the `<transition-group>` component:

Using the <transition-group> component

```
<transition-group name="fade">
  <p v-if="show">
    Paragraph 1
  </p>
  <p v-if="show">
    Paragraph 2
  </p>
</transition-group>   
```

The elements on which the effect occurs (here, the two paragraphs) are grouped in a `<transition-group>` element instead of the `<transition>` element that was used previously when there was a single paragraph on which the effect was produced.

Now, we will take a look at how to write the CSS classes associated with some classic effects.

# Examples of commonly used effects

Below are some descriptions of effects. With a few lines of CSS code, you can easily produce classic effects such as the shrinking/enlargement of a paragraph (shrink effect), its gradual disappearance/appearance (opacity effect), and its vertical displacement (`ymove` effect). You are free to choose the names given to these effects and symbolize the effect produced.

## The shrink effect

To use the shrink effect (here called `"shrink"`), we use the CSS `font-size` property.

At the beginning of the effect, the paragraph is of normal size:

![ 0509 4.10 The paragraph is normal size ](/packtpub/javascript_from_frontend_to_backend_img/0509_4.10_the_paragraph_is_normal_size.webp
)
Figure 4.10 – The paragraph is normal size at the beginning of the disappearing effect

Once the effect has started following a click on the button, the paragraph decreases in size until it disappears.

![ 0510 4.11 The paragraph decreases in ](/packtpub/javascript_from_frontend_to_backend_img/0510_4.11_the_paragraph_decreases_in.webp
)
Figure 4.11 – The paragraph decreases in size until it disappears

Once the paragraph has disappeared, it can reappear after another click on the button. The paragraph size will increase until it reaches its normal size:

CSS classes to handle shrink effect

```
.shrink-leave-from {
}
.shrink-leave-to {
  font-size: 0px;
}
.shrink-leave-active {
  transition: all 2s;
}
.shrink-enter-from {
  font-size: 0px;
}
.shrink-enter-to {
}
.shrink-enter-active {
  transition: all 2s;
}
```

The CSS class `shrink-leave-to` indicates, for the disappearance effect, to go to a font size of 0px, that is, a reduction to 0 of the font size for the paragraph, which makes the paragraph invisible.

The `shrink-enter-from` CSS class tells the effect to start with a font size of 0px, gradually growing to the normal paragraph size when visible.

If CSS properties are not indicated in a starting class (for example, the `shrink-leave-from` class does not contain the `font-size` property), this means that the current value of this CSS property is used in the element.

Similarly, if CSS properties are not indicated in an arrival class (for example, the `shrink-enter-to` class does not contain the `font-size` property), this means that we are progressing toward the value of this CSS property of the element when it will be visible at the end of the effect.

## The opacity effect

The effect named `"fade"` uses the CSS `opacity` property. This effect consists of varying the CSS `opacity` property from 0 to 1 (to gradually make an element appear) or from 1 to 0 (to make it disappear).

Here is, for example, the effect of disappearance. The paragraph is disappearing with an opacity that tends toward 0. When the opacity is at 0, the element will be completely invisible on the screen.

![ 0511 4.12 The paragraph has an opacity ](/packtpub/javascript_from_frontend_to_backend_img/0511_4.12_the_paragraph_has_an_opacity.webp
)
Figure 4.12 – The paragraph has an opacity that decreases toward 0

Once the paragraph is invisible, just click again on the **Produce the effect** button to make it reappear gradually:

CSS classes to manage opacity

```
.fade-leave-from {
}
.fade-leave-to {
  opacity : 0;
}
.fade-leave-active {
  transition: all 0.5s;
}
.fade-enter-from {
  opacity : 0;
}
.fade-enter-to {
}
.fade-enter-active {
  transition: all 1s;
}
```

The `fade-leave-to` CSS class indicates to go to an opacity of 0. The current opacity (of value 1) is the starting one. Since the initial value of the opacity is not defined in `fade-leave-from`, it will use the value defined by the CSS of the element (i.e., 1).

Similarly, the `fade-enter-from` class indicates the current opacity at the start of the element’s appearance effect. The destination value of the opacity does not need to be specified as it will use the default value from the element CSS, that is, 1.

## The move-down effect

To manage this effect (here, called `"ymove"`), we use the CSS properties `transform` (set to `translateY(100px)`) and `opacity` (set to 0). This gradually moves the element 100px horizontally downward, gradually decreasing its opacity to 0. The element disappears as it moves down the page.

For example, here is what is displayed when the element has started to slide down by decreasing its opacity, which makes it less visible:

![ 0512 4.13 The paragraph moves down the ](/packtpub/javascript_from_frontend_to_backend_img/0512_4.13_the_paragraph_moves_down_the.webp
)
Figure 4.13 – The paragraph moves down the page by decreasing its opacity

As the effect continues, the paragraph moves down the page, until it reaches the distance of 100 pixels specified in the effect. The closer you get to this distance, the more the paragraph decreases in opacity, until it becomes invisible (opacity of 0).

![ 0513 4.14 The paragraph becomes almost ](/packtpub/javascript_from_frontend_to_backend_img/0513_4.14_the_paragraph_becomes_almost.webp
)
Figure 4.14 – The paragraph becomes almost invisible toward the end of the effect

Once the paragraph has disappeared, clicking on the Produce the effect button makes it reappear gradually from the bottom of the screen:

CSS classes to handle moving down

```
.ymove-leave-from {
}
.ymove-leave-to {
  transform: translateY(100px);
  opacity : 0;
}
.ymove-leave-active {
  transition: all 0.5s;
}
.ymove-enter-from {
  transform: translateY(100px);
  opacity : 0;
}
.ymove-enter-to {
}
.ymove-enter-active {
  transition: all 0.5s;
}
```

The `ymove-leave-to` CSS class indicates the values of the CSS properties toward which we want to vary the indicated CSS properties. The `transform` property can contain the `translateY(100px)` value, indicating to perform a vertical translation (Y) of 100 pixels. Adding an opacity of 0 makes the element disappear by moving it vertically.

The `ymove-enter-from` CSS class allows you to indicate the values of CSS properties at the beginning of the appearance effect. The element is located at 100 pixels vertical distance, with an opacity of 0. The CSS properties will evolve to those specified in the `ymove-enter-to` class, and if nothing is specified in this class, the CSS properties usually used for an element (opacity of 1 and vertical distance of 0, i.e., the normal location) are those toward which we will evolve during the appearance effect.

The CSS `transform` property is very useful for producing visual effects, for example, rotation, enlargement, and displacement.

This brings us to the end of the chapter.

# Summary

After learning how to handle events and act when an external event (e.g., a click) occurs, we saw in this chapter how components created with Vue.js can be assembled to form complete applications. We learned the following:

- To communicate from a component to its parent, we use events.
- To communicate from a component to its child, we use the attributes in the component’s `props` section.

Finally, to produce visual effects, all you have to do is write the CSS classes managed by Vue.js.

In the next chapter, we will see an example of an application that allows us to put into practice the elements studied in the previous chapters.


> [ 05 C3 Getting Started with Vue.js ](/packtpub/javascript_from_frontend_to_backend/05_c3_getting_started_with_vue_js) <---> [ 07 C5 Managing a List with Vue.js ](/packtpub/javascript_from_frontend_to_backend/07_c5_managing_a_list_with_vue_js)
>
> Title: 06 C4 Advanced Concepts of Vue.js
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/06_c4_advanced_concepts_of_vue.js
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 13:20:55
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 06_c4_advanced_concepts_of_vue.js.md

