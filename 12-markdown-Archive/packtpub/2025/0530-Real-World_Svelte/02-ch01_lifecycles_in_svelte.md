
| ≪ [ 01 Pt1 Writing Svelte Components ](/packtpub/2025/2505_real-world_svelte/01_pt1_writing_svelte_components) | 02 Ch01 Lifecycles in Svelte | [ 03 Ch02 Implementing Styling and Theming ](/packtpub/2025/2505_real-world_svelte/03_ch02_implementing_styling_and_theming) ≫ |
|:----:|:----:|:----:|

# 02 Ch01 Lifecycles in Svelte

Svelte is a frontend framework. You can use Svelte to build websites and web applications. A Svelte application is made up of components. You write a Svelte component within a file with `.svelte` extension. Each `.svelte` file is one Svelte component.

When you create and use a Svelte component, the component goes through various stages of the component lifecycle. Svelte provides lifecycle functions, allowing you to hook into the different stages of the component.

In this chapter, we will start by talking about the various lifecycles and the lifecycle functions in Svelte. With a clear idea of lifecycles in mind, you will then learn the basic rule of using the lifecycle functions. This is essential, as you will see that this understanding will allow us to use the lifecycle functions in a lot of creative ways.

This chapter contains sections on the following topics:

- What are Svelte lifecycle functions?
- The rule of calling lifecycle functions
- How to reuse and compose lifecycle functions

# Technical requirements

Writing Svelte applications is very easy and does not require any paid tools. Despite the added value of most paid tools, we decided to use only free tools to make the content of this book available to you without any limitations.

You will require the following:

- Visual Studio Code as the integrated development environment (https://code.visualstudio.com/)
- A decent web browser (Chrome, Firefox, or Edge, for instance)
- Node.js as the JavaScript runtime environment (https://nodejs.org/)

All the code examples for this chapter can be found on GitHub at: https://github.com/PacktPublishing/Real-World-Svelte/tree/main/Chapter01

Code for all chapters can be found at https://github.com/PacktPublishing/Real-World-Svelte.

# Understanding the Svelte lifecycle functions

When using a Svelte component, it goes through different stages throughout its lifetime: mounting, updating, and destroying. This is similar to a human being. We go through various stages in our lifetime, such as birth, growth, old age, and death, throughout our lifetime. We call the different stages lifecycles.

Before we talk about lifecycles in Svelte, let’s look at a Svelte component.

```
<script>
  import { onMount, beforeUpdate, afterUpdate, onDestroy } from 'svelte';
  let count = 0;
  onMount(() => { console.log('onMount!'); });
  beforeUpdate(() => { console.log('beforeUpdate!'); });
  afterUpdate(() => { console.log('afterUpdate!'); });
  onDestroy(() => { console.log('onDestroy!'); });
</script>
<button on:click={() => { count ++; }}>
  Counter: {count}
</button>
```

Can you tell me when each part of the code is executed?

Not every part of the code is executed at once; different parts of the code are executed at different stages of the component lifecycle.

A Svelte component has four different lifecycle stages: initializing, mounting, updating, and destroying.

Initializing the component
When you create a component, the component first goes through the initialization phase. You can think of this as the setup phase, where the component sets up its internal state.

This is where lines 2–7 are being executed.

The count variable is declared and initialized. The onMount, beforeUpdate, afterUpdate, and onDestroy lifecycle functions are called, with callback functions passed in, to register them at the specific stages of the component lifecycles.

After the component is initialized, Svelte starts to create elements in the template, in this case, a <button> element and text elements for "Counter: " and {count}.

Mounting the component
After all the elements are created, Svelte will insert them in order into the Document Object Model (DOM). This is called the mounting phase, where elements are mounted onto the DOM.

If you add Svelte actions to an element, then the actions are called with the element:

<script>
  function action(node) {}
</script>
<div use:action>

Copy

Explain
We will explore Svelte actions in more depth in Chapter 5 to 7.

If and when you add event listeners to the element, this is when Svelte will attach the event listeners to the element.

In the case of the preceding example, Svelte attaches the click event listener onto the button after it is inserted into the DOM.

When we add bindings to an element, the bound variable gets updated with values from the element:

<script>
  let element;
</script>
<div bind:this={element} />

Copy

Explain
This is when the element variable gets updated with the reference to the <div> element created by Svelte.

If and when you add transitions to an element, this is when the transitions are initialized and start playing.

The following snippet is an example of adding a transition to an element. You can add a transition to an element using the transition:, in:, and out: directives. We will explore more about Svelte transitions in Chapter 13 to 15:

<div in:fade />

Copy

Explain
After all the directives, use: (actions), on: (event listeners), bind: bindings, in:, transition: (transitions), are processed, the mounting phase comes to an end by calling all the functions registered in the onMount lifecycle functions.

This is when the function on line 4 is executed, and you will see "onMount!" printed in the logs.

Updating the component
When you click on the button, the click event listener is called. The function on line 9 is executed. The count variable is incremented.

Right before Svelte modifies the DOM based on the latest value of the count variable, the functions registered in the beforeUpdate lifecycle function are called.

The function on line 5 is executed, and you will see the text "beforeUpdate!" printed in the logs.

At this point, if you attempt to retrieve the text content within the button, it would still be "Counter: 0".

Svelte then proceeds to modify the DOM, updating the text content of the button to "Counter: 1".

After updating all the elements within the component, Svelte calls all the functions registered in the afterUpdate lifecycle function.

The function on line 6 is executed, and you will see the text "afterUpdate!" printed in the logs.

If you click on the button again, Svelte will go through another cycle of beforeUpdate, and then update the DOM elements, and then afterUpdate.

Destroying the component
A component that is conditionally shown to a user will remain while the condition holds; when the condition no longer holds, Svelte will proceed to destroy the component.

Let’s say the component in our example now enters the destroy stage.

Svelte calls all the functions registered in the onDestroy lifecycle function. The function on line 7 is executed, and you will see the text "onDestroy!" printed in the logs.

After that, Svelte removes the elements from the DOM.

Svelte then cleans up the directives if necessary, such as removing the event listeners and calling the destroy method from the action.

And that’s it! If you try to recreate the component again, a new cycle starts again.

The Svelte component lifecycle starts with initializing, mounting, updating, and destroying. Svelte provides lifecycle methods, allowing you to run functions at different stages of the component.

Since the component lifecycle functions are just functions exported from 'svelte', can you import and use them anywhere? Are there any rules or constraints when importing and using them?

Let’s find out.

The one rule for calling lifecycle functions
The only rule for calling component lifecycle functions is that you should call them during component initialization. If no component is being initialized, Svelte will complain by throwing an error.

Let’s look at the following example:

<script>
  import { onMount } from 'svelte';
  function buttonClicked() {
    onMount(() => console.log('onMount!'));
  }
</script>
<button on:click={buttonClicked} />

Copy

Explain
When you click on the button, it will call buttonClicked, which will call onMount. As no component is being initialized when onMount is being called, (the component above has initialized and mounted by the time you click on the button), Svelte throws an error:

Error: Function called outside component initialization

Copy

Explain
Yes, Svelte does not allow lifecycle functions to be called outside of the component initialization phase. This rule dictates when you can call the lifecycle functions. What it does not dictate is where or how you call the lifecycle functions. This allows us to refactor lifecycle functions and call them in other ways.

Refactoring lifecycle functions
If you look carefully at the rule for calling lifecycle functions, you will notice that it is about when you call them, and not where you call them.

It is not necessary to call lifecycle functions at the top level within the <script> tag.

In the following example, the setup function is called during component initialization, and in turn calls the onMount function:

<script>
  import { onMount } from 'svelte';
  setup();
  function setup() {
    onMount(() => console.log('onMount!'));
  }
</script>

Copy

Explain
Since the component is still initializing, this is perfectly fine.

It is also not necessary to import the onMount function within the component. As you see in the following example, you can import it in another file; as long as the onMount function is called during component initialization, it is perfectly fine:

// file-a.js
import { onMount } from 'svelte';
export function setup() {
  onMount(() => console.log('onMount!'));
}

Copy

Explain
In the preceding code snippet, we’ve moved the setup function we defined previously to a new module called file-a.js. Then, in the original Svelte component, rather than defining the setup function, we import it from file-a.js, shown in the following code snippet:

<script>
  import { setup } from './file-a.js';
  setup();
</script>

Copy

Explain
Since the setup function calls the onMount function, the same rule applies to the setup function too! You can no longer call the setup function outside component initialization.

Which component to register?
Looking at just the setup function, you may be wondering, when you call the onMount function, how does Svelte know which component’s lifecycle you are referring to?

Internally, Svelte keeps track of which component is initializing. When you call the lifecycle functions, it will register your function to the lifecycle of the component that is being initialized.

So, the same setup function can be called within different components and registers the onMount function for different components.

This unlocks the first pattern in this chapter: reusing lifecycle functions.

Reusing lifecycle functions in Svelte components
In the previous section, we learned that we can extract the calling of lifecycle functions into a function and reuse the function in other components.

Let’s look at an example. In this example, after the component is added to the screen for 5 seconds, it will call the showPopup function. I want to reuse this logic of calling showPopup in other components:

<script>
  import { onMount } from 'svelte';
  import { showPopup } from './popup';
  onMount(() => {
    const timeoutId = setTimeout(() => {
      showPopup();
    }, 5000);
    return () => clearTimeout(timeoutId);
  });
</script>

Copy

Explain
Here, I can extract the logic into a function, showPopupOnMount:

// popup-on-mount.js
import { onMount } from 'svelte';
import { showPopup } from './popup';
export function showPopupOnMount() {
  onMount(() => {
    const timeoutId = setTimeout(() => {
      showPopup();
    }, 5000);
    return () => clearTimeout(timeoutId);
  });
}

Copy

Explain
And now, I can import this function and reuse it in any component:

<script>
  import { showPopupOnMount } from './popup-on-mount';
  showPopupOnMount();
</script>

Copy

Explain
You may be wondering, why not only extract the callback function and reuse that instead?

// popup-on-mount.js
import { showPopup } from './popup';
export function showPopupOnMount() {
  const timeoutId = setTimeout(() => {
    showPopup();
  }, 5000);
  return () => clearTimeout(timeoutId);
}

Copy

Explain
Over here, we extract only setTimeout and clearTimeout logic into showPopupOnMount, and pass the function into onMount:

<script>
  import { onMount } from 'svelte';
  import { showPopupOnMount } from './popup-on-mount';
  onMount(showPopupOnMount);
</script>

Copy

Explain
In my opinion, the second approach of refactoring and reusing is not as good as the first approach. There are a few pros in extracting the entire calling of the lifecycle functions into a function, as it allows you to do much more than you can otherwise:

You can pass in different input parameters to your lifecycle functions.Let’s say you wish to allow different components to customize the duration before showing the popup. It is much easier to pass that in this way:
<script>
  import { showPopupOnMount } from './popup-on-mount';
  showPopupOnMount(2000); // change it to 2s
</script>

Copy

Explain
You can return values from the function.Let’s say you want to return the timeoutId used in the onMount function so that you can cancel it if the user clicks on any button within the component.It is near impossible to do so if you just reuse the callback function, as the value returned from the callback function will be used to register for the onDestroy lifecycle function:
<script>
  import { showPopupOnMount } from './popup-on-mount';
  const timeoutId = showPopupOnMount(2000);
</script>
<button on:click={() => clearTimeout(timeoutId)} />

Copy

Explain
See how easy it is to implement it to return anything if we write it this way:
// popup-on-mount.js
export function showPopupOnMount(duration) {
  let timeoutId;
  onMount(() => {
    timeoutId = setTimeout(() => {
      showPopup();
    }, duration ?? 5000);
    return () => clearTimeout(timeoutId);
  });
  return timeoutId;
}

Copy

Explain
You can encapsulate more logic along with the lifecycle functions.Sometimes, the code in your lifecycle functions callback function does not work in a silo; it interacts with and modifies other variables. To reuse lifecycle functions like this, you must encapsulate those variables and logic into a reusable function.To illustrate this, let’s look at a new example.Here, I have a counter that starts counting when a component is added to the screen:
<script>
  import { onMount } from 'svelte';
  let counter = 0;
  onMount(() => {
    const intervalId = setInterval(() => counter++, 1000);
    return () => clearInterval(intervalId);
  });
</script>
<span>{counter}</span>

Copy

Explain
The counter variable is coupled with the onMount lifecycle functions; to reuse this logic, the counter variable and the onMount function should be extracted together into a reusable function:
import { writable } from 'svelte/store';
import { onMount } from 'svelte';
export function startCounterOnMount() {
  const counter = writable(0);
  onMount(() => {
    const intervalId = setInterval(() => counter.update($counter => $counter + 1), 1000);
    return () => clearInterval(intervalId);
  });
  return counter;
}

Copy

Explain
In this example, we use a writable Svelte store to make the counter variable reactive. We will delve more into Svelte stores in Part 3 of this book.For now, all you need to understand is that a Svelte store allows Svelte to track changes in a variable across modules, and you can subscribe to and retrieve the value of the store by prefixing a $ in front of a Svelte store variable. For example, if you have a Svelte store named counter, then to get the value of the Svelte store, you would need to use the $counter variable.Now, we can use the startCounterOnMount function in any Svelte component:
<script>
  import { startCounterOnMount } from './counter';
  const counter = startCounterOnMount();
</script>
<span>{$counter}</span>

Copy

Explain
I hope I’ve convinced you about the pros of extracting the calling of lifecycle functions into a function. Let’s try it out in an example.

Exercise 1 – Update counter
In the following example code, I want to know how many times the component has gone through the update cycle.

Using the fact that every time the component goes through the update cycle, the afterUpdate callback function will be called, I created a counter that will be incremented every time the afterUpdate callback function is called.

To help us measure only the update count of a certain user operation, we have functions to start measuring and stop measuring, so the update counter is only incremented when we are measuring:

<script>
  import { afterUpdate } from 'svelte';
  let updateCount = 0;
  let measuring = false;
  afterUpdate(() => {
    if (measuring) {
      updateCount ++;
    }
  });
  function startMeasuring() {
    updateCount = 0;
    measuring = true;
  }
  function stopMeasuring() {
    measuring = false;
  }
</script>
<button on:click={startMeasuring}>Measure</button>
<button on:click={stopMeasuring}>Stop</button>
<span>Updated {updateCount} times</span>

Copy

Explain
To reuse all the logic of the counter: – the counting of update cycles and the starting and stopping of the measurement – we should move all of it into a function, which ends up looking like this:

<script>
  import { createUpdateCounter } from './update-counter';
  const { updateCount, startMeasuring, stopMeasuring } = createUpdateCounter();
</script>
<button on:click={startMeasuring}>Measure</button>
<button on:click={stopMeasuring}>Stop</button>
<span>Updated {$updateCount} times</span>

Copy

Explain
The update counter returns an object that contains the updateCount variable and the startMeasuring and stopMeasuring functions.

The implementation of the createUpdateCounter function is left as an exercise to you, and you can check the answer at https://github.com/PacktPublishing/Real-World-Svelte/tree/main/Chapter01/01-update-counter.

We’ve learned how to extract a lifecycle function and reuse it, so let’s take it up a notch and reuse multiple lifecycle functions in the next pattern: composing lifecycle functions.

Composing lifecycle functions into reusable hooks
So far, we’ve mainly talked about reusing one lifecycle function. However, there’s nothing stopping us from grouping multiple lifecycle functions to perform a function.

Here’s an excerpt from the example at https://svelte.dev/examples/update. The example shows a list of messages. When new messages are added to the list, the container will automatically scroll to the bottom to show the new message. In the code snippet, we see that this automatic scrolling behavior is achieved by using a combination of beforeUpdate and afterUpdate:

<script>
  import { beforeUpdate, afterUpdate } from 'svelte';
  let div;
  let autoscroll;
  beforeUpdate(() => {
    autoscroll = div && (div.offsetHeight + div.scrollTop) > (div.scrollHeight - 20);
  });
  afterUpdate(() => {
    if (autoscroll) div.scrollTo(0, div.scrollHeight);
  });
</script>
<div bind:this={div} />

Copy

Explain
To reuse this autoscroll logic in other components, we can extract the beforeUpdate and afterUpdate logic together into a new function:

export function setupAutoscroll() {
  let div;
  let autoscroll;
  beforeUpdate(() => {
    autoscroll = div && (div.offsetHeight + div.scrollTop) > (div.scrollHeight - 20);
  });
  afterUpdate(() => {
    if (autoscroll) div.scrollTo(0, div.scrollHeight);
  });
  return {
  setDiv(_div) {
  div = _div;
    },
  };
}

Copy

Explain
We can then use the extracted function, setupAutoScroll, in any component:

<script>
  import { setupAutoscroll } from './autoscroll';
  const { setDiv } = setupAutoscroll();
  let div;
  $: setDiv(div);
</script>
<div bind:this={div} />

Copy

Explain
In the refactored setupAutoscroll function, we return a setDiv function to allow us to update the reference of the div used within the setupAutoscroll function.

As you’ve seen, by adhering to the one rule of calling lifecycle functions during component initialization, you can compose multiple lifecycle functions into reusable hooks. What you’ve learned so far is sufficient for composing lifecycle functions, but there are more alternatives on the horizon. In the upcoming chapters, you’ll explore Svelte actions in Chapter 5 and the Svelte store in Chapter 8, expanding your options further. Here’s a sneak peek at some of these alternatives.

An alternative implementation could be to make div a writable store and return it from the setupAutoscroll function. This way, we could bind to the div writable store directly instead of having to call setDiv manually.

Alternatively, we could return a function that follows the Svelte action contract and use the action on the div:

export function setupAutoscroll() {
  let div;
  // ...
  return function (node) {
    div = node;
    return {
      destroy() {
        div = undefined;
      },
    };
  };
}

Copy

Explain
setupAutoscroll now returns an action, and we use the action on our div container:

<script>
  import { setupAutoscroll } from './autoscroll';
  const autoscroll = setupAutoscroll();
</script>
<div use:autoscroll />

Copy

Explain
We will discuss the Svelte action contract in more detail later in the book.

We’ve seen how we can extract lifecycle functions into a separate file and reuse it in multiple Svelte components. Currently, the components call the lifecycle functions independently and function as standalone units. Is it possible to synchronize or coordinate actions across components that uses the same lifecycle functions? Let’s find out.

Coordinating lifecycle functions across components
As we reuse the same function across components, we can keep track globally of the components that use the same lifecycle function.

Let me show you an example. Here, I would like to keep track of how many components on the screen are using our lifecycle function.

To count the number of components, we can define a module-level variable and update it within our lifecycle function:

import { onMount, onDestroy } from 'svelte';
import { writable } from 'svelte/store';
let counter = writable(0);
export function setupGlobalCounter() {
  onMount(() => counter.update($counter => $counter + 1));
  onDestroy(() => counter.update($counter => $counter - 1));
  return counter;
}

Copy

Explain
As the counter variable is declared outside the setupGlobalCounter function, the same counter variable instance is used and shared across all the components.

When any component is mounted, it will increment the counter, and any component that is referring to the counter will get updated with the latest counter value.

This pattern is extremely useful when you want to set up a shared communication channel between components and tear it down in onDestroy when the component is being destroyed.

Let’s try to use this technique in our next exercise.

Exercise 2 – Scroll blocker
Usually, when you add a pop-up component onto the screen, you want the document to not be scrollable so that the user focuses on the popup and only scrolls within the popup.

This can be done by setting the overflow CSS property of the body to "hidden".

Write a reusable function used by pop-up components that disables scrolling when the pop-up component is mounted. Restore the initial overflow property value when the pop-up component is destroyed.

Do note that it is possible to have more than one pop-up component mounted on the screen at once, so you should only restore the overflow property value when all the popups are destroyed.

You can check the answer at https://github.com/PacktPublishing/Real-World-Svelte/tree/main/Chapter01/02-scroll-blocker.

Summary
In this chapter, we went through the lifecycles of a Svelte component. We saw the different stages of a component lifecycle and learned when the lifecycle function callbacks will be called.

We also covered the rule of calling lifecycle functions. This helps us to realize the different patterns of reusing and composing lifecycle functions.

In the next chapter, we will start to look at the different patterns for styling and theming a Svelte component.





| ≪ [ 01 Pt1 Writing Svelte Components ](/packtpub/2025/2505_real-world_svelte/01_pt1_writing_svelte_components) | 02 Ch01 Lifecycles in Svelte | [ 03 Ch02 Implementing Styling and Theming ](/packtpub/2025/2505_real-world_svelte/03_ch02_implementing_styling_and_theming) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2025/2505_real-world_svelte/02-ch01_lifecycles_in_svelte
> (2) Markdown
> (3) Title: 02 Ch01 Lifecycles in Svelte
> (4) Short Description: Hau Dec 2023 282 pages
> (5) tags: Svelte
> Book Name: 2505 Real-World Svelte
> Link: https://subscription.packtpub.com/book/web-development/9781804616031/pref
> create: 2025-05-30 금 13:55:48
> Images: /packtpub/2025/2505_real-world_svelte_img/
> .md Name: 02-ch01_lifecycles_in_svelte.md

