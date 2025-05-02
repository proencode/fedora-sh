
--------> @ Q -> # 붙이고 줄 띄우기 
--------> @ W -> 현 위치에서 Explain 까지 역따옴표 
--------> @ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(`) 붙이기 
--------> @ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(`) 붙이기 
--------> @ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(`) 붙이기 
--------> @ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(`) 붙이기 
--------> @ U -> 찾은 글자~닫은괄호앞뒤로 backtick(`) 붙이기 
--------> @ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(`) 붙이기 
--------> @ O -> 찾은 글자 ~   }   앞뒤로 backtick(`) 붙이기 
++++++++> @ A -> 빈 줄에 블록 시작하기 
++++++++> @ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 
++++++++> @ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 
++++++++> @ F -> 이 줄을 타이틀로 만들기 
++++++++> @ K -> 찾은 글자 ~ COLON 앞뒤로 긁은글자(**) 붙이기 
========> @ Z -> 현 위치에서 Copy 까지 역따옴표 

마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

| ≪ [ 02 Ch01 Exploring the Books Layout and Companion App ](/packtpub/2024/2409_vue_js_3_for_beginners/02_ch01_exploring_the_books_layout_and_companion_app) | 03 Ch02 The Foundation of Vue.js | [ 04 Pt2 Understanding the Core Features of Vue.js ](/packtpub/2024/2409_vue_js_3_for_beginners/04_pt2_understanding_the_core_features_of_vue_js) ≫ |
|:----:|:----:|:----:|

# 03 Ch02 The Foundation of Vue.js

If you are reading this book, chances are that you have decided to use Vue.js as your framework of choice and there is very little reason to try to convince you not to use it. We are going to use this chapter to begin sharing details of what makes Vue.js unique and why it has become so successful.

We are first going to learn what makes Vue.js different from other frameworks; we will then move on to study Vue.js’ reactivity and its lifecycles. Finally, we will learn about the component structure of Vue.js.

In this chapter, we will learn the following:

- Vue.js’ reactivity fundamentals
- Understanding the Vue.js lifecycle and hooks
- Vue.js’ component structure

The goal of this chapter is to provide you with information regarding Vue.js that will become the foundation of your future learning. Understanding Vue.js’ reactivity will help differentiate Vue.js from other frontend frameworks and libraries, and you will learn the complete lifecycle of a Vue.js component to help you make the correct technical decisions. Finally, understanding the different ways to define a Vue.js component will prepare you for the chapters to come.

# Vue.js reactivity fundamentals

Vue.js has been around for some time; the framework’s first release dates back to 2014, when its creator, Evan You, a former Google developer, informed the world of its creation.

Evan’s previous experience with Angular at Google gave him the knowledge necessary to build a great framework. In an interview for Between the Wires shortly after making the framework public, Evan said the following:

I figured, what if I could just extract the part that I really liked about Angular and build something really lightweight.

Evan did not just create a lightweight framework, but he also managed to build an amazing community around it, making it one of the most loved frameworks by developers.

Vue.js has had just three major releases until now, with the latest one being a full rewrite that made Vue.js faster, smaller, and even easier to use.

Two main aspects made Vue.js so successful. The first is that its growth and adoption are driven by the community for the community. Vue.js is one of the few major frameworks not to be backed by a big company. It is fully funded by people’s donations to the core team and its development is mainly driven by the community. This is shown by the focus on the development experience that is always present within the Vue.js ecosystem.

The second aspect that makes it unique is its reactivity system. The Vue.js core engine has been built to be reactive behind the scenes, making handling states with Vue.js simple and intuitive.

When we talk about reactivity in development, we refer to the ability of certain variables to automatically update when a change occurs. A simple example of reactivity outside of the developing world is offered by Excel and Google Sheets. Setting up a calculation, such as a sum of a column, will result in the total number being “reactive” to any chance that happens in the summed cells:

Figure 2.1: Google Sheet example showing how the value of cells updates automatically

Like Excel, reactivity in web development, particularly in Vue.js, allows your variables to be dynamic and automatically change when a value it depends on changes.

Let’s see a real example to understand how reactivity plays a big part in the UI framework. Let’s start by seeing the behavior of vanilla JS and then see how this translates into Vue.js.

In the following code, we are going to create two variables, `firstName` and lastName, and then we will try to create a reactive variable called `fullName`:

```
let firstName = "Simone";
let secondName = "Cuomo";
const fullName = `${firstName} ${secondname}`;
console.log(fullName);
// output: Simone Cuomo
```

In the preceding code snippets, the full name that is printed in the console is equal to the `firstName` and `secondName` variables that we have created. What would happen if we now change the `firstName` variable to a different value? What would the value of `fullName` be?

```
let firstName = "Simone";
let secondName = "Cuomo";
const fullName = `${firstName} ${secondname}`;
console.log(fullName);
// output: Simone Cuomo
firstName = "John";
Console.log(fullName);
// output: Simone Cuomo
```

As you can see from the preceding code, the variable that is supposed to print the full name has output the incorrect value, as it has not “reacted” to the change in the `firstName` variable.

This is perfectly normal behavior; you do not want all variables to automatically react in JavaScript, as this will complicate its usage, but when it comes to the UI, having values that are updated is the expected behavior.

Say, for example, you are filling up a basket and you want the total number of items to change if you add one more item to your basket, or you would like the word count to update if you type in a limited textbox, and so on.

Let’s replicate the preceding example using Vue.js:

```
let firstName = ref("Simone");
let secondName = ref("Cuomo");
const fullName = computed( () => `${firstName.value} ${secondName.value}`);
console.log(fullName);
// output: Simone Cuomo
firstName.value = "John";
Console.log(fullName);
// output: John Cuomo
```

At this stage, your understanding of Vue.js is still limited to what experience you had before reading this book, so you are not expected to understand the preceding code yet. What we need to focus our attention on is the output that the code produces when compared to the one produced by plain JavaScript.

As the preceding code shows, the `fullName` variable changes automatically as soon as any of its dependent variables (`firstName` and `secondName`) change.

Understanding how the reactivity system works behind the scenes is out of the scope of this book, but this does not prevent us from understanding the technicalities that take place behind the scenes.

The following diagram shows what happens behind the scenes and how the reactivity actually takes place:

Figure 2.2: Diagram explaining the Vue.js reactivity system

This illustration is a simplified version of what happens within the Vue.js reactivity core system to make our variables dynamic. Let’s break down what is happening:

1. We defined reactive variables, such as `FirstName`. Vue.js watches this variable for any change event.
1. We declared a complex variable that is dependent on other reactive variables (e.g., `fullName`).
1. Vue.js tracks a dependency tree. It creates a list of what depends on what.
1. When a change takes place in a reactive variable, the reactivity engine will trigger `onDependenciesChange`.
1. Vue.js evaluates which values depend on the value that was just changed and triggers an update only if the value is part of their dependencies.

While reading the preceding process, you probably thought that it sounded quite familiar, and you would be correct, as the reactivity system follows the same principles offered by HTML elements such as input fields. Elements such as `<input>`, `<select>`, and many more have the ability to hold values and react when they are changed by triggering an `onChange` or similar event.

As shown in the preceding example, listening to a change event to handle data reactivity is not something unique. So, what makes the Vue.js reactivity system special? Vue.js reactivity stands out for the way it handles the dependencies tree and automatically updates variables behind the scenes. The reactivity system of Vue.js is non-obstructive and it is completely unseen by developers. Vue.js manages all the dependencies behind the scenes as part of its `lifecycles` and acts upon changes with speed and high performance.

This section introduced you to the Vue.js reactivity system, explaining how it plays a vital role in the success of the framework. We then explained, with the help of some examples, how the engine works behind the scenes. It is now time to understand how the Vue.js core engine works by taking a closer look at its lifecycles and understanding how they can be used within our application development.

# Understanding the Vue.js lifecycle and hooks

As we progress into the book, our knowledge of Vue.js continues to expand. In this section, we are going to discuss the Vue.js `lifecycle`.

When we use Vue.js, the application goes through a defined list of steps, from creating the component HTML to gathering all the dynamic values, as well as displaying these values in the DOM. Each of these is part of what we call the lifecycle, and in this section, we are going to define them all and learn when and how to use them during the course of our development careers.

If you have ever tried to learn Vue.js in the past, you have probably already been exposed to the following diagram, which is available in the main Vue.js documentation:

Figure 2.3: Vue.js lifecycle diagram (from www.vuejs.org)

No matter how long you have been using Vue.js, the preceding diagram will repeatedly appear in your browser history, and it will slowly be imprinted in your memory, as it is the foundation of Vue.js and a must-know in order to write clean and performant code.

As you progress in the course of this book, you will be asked to revisit different parts of the lifecycle, and you will be asked to revisit the diagram.

In the next section, we are going to review the diagram step by step and understand what it means and how this knowledge can be applied during development.

We are going to start explaining it from the top down, but we will be starting with `beforeCreate`. We are purposely leaving `setup` for later, as it is easier to understand after all the lifecycles have been introduced, even if it is the first part of the list.

The following lifecycles are progressive; this means that the end state of one of them is the beginning of the next.

### beforeCreate

This lifecycle is created as soon as a component is initialized. At this stage, our component does not exist at all. The Vue.js framework has just been instructed to create it and it is triggering this hook to inform us that the component is on its way.

At this stage, nothing of the component is available, no HTML is being created, and no internal variables are set yet.

Usually, this lifecycle is used to trigger analytics logs or long async tasks.

### created

At this stage, Vue.js knows about your component, and it has loaded its JavaScript logic, but it has not yet rendered or mounted any HTML.

This is the perfect stage to trigger async calls to gather some data. Triggering a slow request now will help us save some time, as this request will continue behind the scenes while our component is being rendered.

### beforeMount

This lifecycle is triggered right before the HTML is appended to the DOM. There are very limited use cases for this lifecycle, as most of the pre-render actions are triggered within the created lifecycle.

### mounted

At this stage, the component has been fully rendered, and its HTML has been attached to the DOM. If you need to complete any operation that requires you to access the DOM, this is the correct lifecycle, as the HTML is ready to be read and modified.

If you come from a non-framework background, you may think that most of the logic of your component will probably be included in this lifecycle, but you will quickly learn that due to the way Vue.js components are specified, you will rarely need access to the DOM.

### beforeUpdate and update

`beforeUpdate` and `update` form a recursive circle that happens any time the component data or dependencies change. We already introduced this step in the previous section when we spoke about the reactivity system.

`beforeUpdate` is triggered as soon as Vue.js realizes that a reactive value on which the component depends has changed.

On the other hand, `update` is triggered when the value has been fully changed, and its value has been assigned to the correct DOM node and is ready in the DOM.

You will very rarely have to use these two lifecycles directly, as Vue.js provides other features, such as computed properties and watchers, to be able to handle individual changes within the component data.

### beforeUnmount and unmount

At this stage, our component is no longer needed, and Vue.js is ready to remove it from the DOM. This could be due to the user navigating to a different page or any other event that would require the component to be removed from the UI.

There is very little difference in usage between `beforeUnmount` and `unmount`. This lifecycle is very useful for unsubscribing to events, such as “click” and “observers,” that will result in a drop in performance if left active.

### setup

As promised at the start of this section, we left `setup` for last, as it is easier to explain it after all lifecycles were covered. `setup` is not a lifecycle in itself, but it is the entry point used by the CompositionAPI (something that you will learn about a bit later in this chapter). When using `setup`, you have the ability to call and access all the lifecycles (`mounted`, `updated`, `unmounted`, and so on). You can think of `setup` as a wrapper for the Vue.js lifecycle, a single method that includes all lifecycle hooks. Composition API is going to be what we use in this book, and we are going to explain the `setup` function in much more detail at a later stage.

In this section, we have learned the basic flow of Vue.js, introducing all its lifecycles. At this stage, we should know when Vue.js component is rendered, updated, or destroyed. This knowledge will drive our development and allow us to make the correct choices to make our application performant. In the next section, we are going to see how to introduce Vue.js component syntax, and we will also learn how to make use of the preceding lifecycles.

# Vue.js component structure

Components are the basis of the Vue.js framework. They are the building blocks required to create an application using this framework. As was previously explained, a component can be as small as a simple button or as large as a full page.

No matter their size, all components are built using the same syntax and structure. In this section, we are going to learn the different forms of syntax available to write components and learn about the different sections that make up a Vue.js `single-file component (SFC)`.

## Single-file components

SFCs are specific to Vue.js and can be found in Vue.js projects with the extension `.vue`. These files are composed of three main sections: `template`, `script`, and `style`:

```
<template></template>
<script></script>
<style></style>
```

The Vue.js compiler takes the preceding three sections and splits them up into individual chunks during build time. We are now going to explain each of them in this section. We will cover the SFC section in the following order:

1. Template
1. Style
1. Script

### The <template> tag

The first section is `<template>`. This section includes the HTML hosted by our component. So, if we take an example of an extremely simple button, the template will look like this:

```
<template>
    <button>My button</button>
</template>
```

In contrast to React, the HTML of a Vue.js component is plain `HTML` and not `JSX`. As we will learn in the course of the book, Vue.js provides some handy tools to simplify the content of our HTML.

### Important note

As for template writing styles, it is possible to write your HTML with different methods, such as render functions, or by writing it in JSX (with the correct loader), but these two methods are for specific uses and are not expected within the Vue.js ecosystem.

### The <style> tag

The next section available is `<style>`. This section will include the styles associated with our component using plain `CSS`. If you are not completely new to Vue.js, you may have realized that what I just said is not fully true, as using a `<style>` tag in a component does not scope the style to that specific component.

Before we move on, let’s explain what it actually means for styles to be scoped and how to achieve this in our Vue.js application.

When we use a simple `<style>` tag, as shown in the preceding example, our style will leak to the rest of the application. Anything we declare in the tag will be global unless we scope it with CSS:

```
<style>
p {
  color: red;
}
</style>
```

Writing the preceding style in Vue.js is permitted and is even suggested for performance and maintainability reasons. The problem is that the preceding declaration will change the color of our paragraph to red in the whole application and not just in the component in which it has been written.

Luckily for us, Vue.js has a handy tool to use in the case where we would like our component to be fully scoped, making sure that no style bleeds and breaks the rest of the app. To do so, we need to add an attribute called `scoped` to our `<style>` tag:

```
<style scoped>
p {
  color: red;
}
</style>
```

With this new attribute, our styles will be locked to the component in which they are defined, and they will not affect the rest of the application. We are going to learn more about when it is best to use these two methods when building our Companion App.

### The <script> tag

The next section available within an SFC is the `<script>` tag. This tag will include the component JavaScript logic, from the properties that are accepted for the component to the private data used to define the component logic, all the way to the actual methods needed for the component to function properly.

Just a few years ago, when Vue.js’ major version was still 2, components were mostly defined using a syntax called `Options API`. Even though other methodologies were available, this was the main way to write a Vue.js component.

With the release of Vue.js 3, a new method of writing components was created. This is offered alongside the existing Options API, and it offers better TypeScript support, improved techniques to reuse logic, and flexible code organization. This method is called `Composition API`.

### Important note

Composition API is also referred to as `Script Setup`.

At this moment in time, neither of the two methods is officially preferred over the other; this is also emphasized by the Vue.js official documentation, which currently showcases all its tutorials and examples using both methodologies, offering the option to switch between the methods:

Figure 2.4: Vue.js official documentation for API preference switch

The content of this book and its Companion App are going to be written using Composition API. This decision was made for two main reasons:

- Due to Vue.js 2’s history, the web is full of resources that focus on Options API but less so on the new Composition API syntax
- Evan You (the creator of Vue.js) has predicted (more than once) that, in the long run, Composition API will take over and become the standard

Because I am a strong believer that extra knowledge does no harm, in this section, we are going to learn how to define the component in both syntaxes, including Options API. Knowing both methods can help you build a strong foundation to support your learning of the Vue.js framework.

## Options API versus Composition API – Two sides of the same coin

Under the hood, both methods are actually going to produce a very similar output, with Composition API producing slightly more performant code. Nevertheless, the syntax differences and benefits that these methods bring are quite different and can make a big change depending on your habits.

The first and main difference between Composition API and Options API is in the way the `<script>` section of your code is broken down. As I mentioned before, both syntaxes will offer the same features, so this means that we can declare props data, compute, and methods, as well as access all the lifecycles in both methods, but the way we do so differs.

The differences are as follows:

- `Composition API`: Code broken down by functionality
- `Options API`: Code broken down by Vue.js options

Let’s look at an example to clearly define the difference between both methods.

Figure 2.5: Comparison between Composition API and Options API for breaking down code

As shown in the preceding diagram, in Options API, the code does not take into consideration the actual component requirements and logic, but it is sliced vertically using Vue.js options: `Props`, `Data`, `Methods`, `Computed`, `mounted`, and so on.

On the other hand, Composition API takes a different approach by breaking down the component by its technical output. This allows us to create a section for Feature 1, a section for Feature 2, and so on.

The second difference is associated with TypeScript support. This is the main reason that led the Vue.js core team to decide to create The Composition API during the Vue.js 3 rewrite. Options API offers very basic TypeScript support, and this has prevented many developers from joining the Vue.js ecosystem.

We have reached the end of this section, and it is time to clearly say which method is better, but, unfortunately, the answer is that it depends.

Because both syntactic sugars compile in the same code, the decision really goes back to coding preferences. Options API provides more structure, and it can, therefore, be more helpful at the start of your career when your experience in creating a component is still limited, while Composition API, with the added TypeScript support and greater flexibility in code partitioning, can be a very strong tool to improve code readability in big applications.

## Sample components

At this stage, we have learned enough about the foundations of Vue.js to be ready to introduce some sample components and see the framework in action.

We are going to look at an example of an Atom. In our case, it is a simple icon component. This sample component is going to exhibit the following features:

- It is going to accept a couple of properties (`size` and `name`)
- It is going to include some style
- It is going to dynamically load the icon

The component will be called using the following HTML:

```
<vfb-icon name="clog" size="small" @click="doSomething" /> #-- qqq quotation" 빠짐
```

As previously mentioned, in this section, I am going to show the components utilizing both writing methods; however, later in the book, we will just write components using Script Setup (Composition API).

### Important note

Please note that we will cover all of this again in more detail later in the book. This is just a quick introduction to Vue.js components.

### An Atom component using Options API

Let’s first see how this component looks as a Vue.js component using Options API:

```
<template>
  <img
    :src="iconPath"
    :class="sizeClass"
  />
</template>
<script>
  export default {
    name: 'vfb-icon',
    props: {
      size: String,
      name: String
    },
    computed: {
      iconPath() {
        return `/assets/${this.name}.svg`;
      },
      sizeClass() {
        return `${this.size}-icon`
      }
    }
};
</script>
<style scoped>
.small-icon {
    width: 16px;
    height: 16px;
}
.medium-icon {
  width: 32px;
  height: 32px;
}
.large-icon {
  width: 48px;
  height: 48px;
}
</style>
```

Now let’s break down all the sections, starting with `<template>`, which hosts the HTML for our component; in this case, this is a native `<img>` element. This component has a few attributes being passed to it. The first two are native attributes: `src` and `class`:

```
:src="iconPath"
:class="sizeClass"
```

These attributes are declared a little bit differently than you are used to in HTML, as they are preceded by :. When an attribute has this syntax, it means that its value is dynamic and that the values (in our case, `iconPath` and `sizeClass`) are going to be evaluated as a JavaScript variable and not actual strings.

#### Important note

Please note that you can write plain HTML in Vue.js, and using the dynamic variables is not a requirement for the framework but just a feature to make the attributes dynamic.

Next up, let’s move to the logical part of the application, the `<script>` section. Here, we start by declaring the name of our component:

```
name: 'vfb-icon',
```

### Important note

It is good practice for all Vue.js components to be formed of two words. This will ensure that the component does not clash with native HTML elements.

Next, it is time to declare the properties. Properties are values that are accepted by our component when it is initialized. This is an existing concept in development, as all HTML elements accept attributes such as `class`, `id`, and `value`. These properties make our components reusable and flexible. In our example, we declared two different properties: `name` and `size`. These will be passed down when the component is called, just as if they were native HTML attributes:

```
props: {
  size: String,
  name: String
},
```

This example shows a basic configuration for a property, in which we just define its type, but, as we will later see in the course of the book, `props` can have different configurations, such as validation, default values, and requirements rules, to state whether they are required or not.

The next piece of code is where we declare our dynamic properties. For our component to function correctly, we need a path and a class defined as `iconPath` and `sizeClass`. These values are going to be dynamic due to the fact that they include the dynamic properties and will be declared using something called computed properties:

```
computed: {
  iconPath() { return `/assets/${this.name}.svg`; },
  sizeClass() { return `${this.size}-icon` }
},
```

The computed properties allow us to declare values that are reactive (remember the reactivity chapter earlier on in the book) and can make use of our entire component logic; in this case, we just used the props, but we could have used a collection of values and external logic to create a new value.

### Important note

Please note that when using Options API, you have to use the `this` keyword to be able to access variables within the component, such as `props` and `computed`. In our example, we used it to access properties by using `this.name` and `this.size`;.

Our last section is `<style>`:

```
<style scoped>
  .small-icon {
    width: 16px;
    height: 16px;
  }
  .medium-icon {
    width: 32px;
    height: 32px;
  }
  .large-icon {
    width: 48px;
    height: 48px;
  }
</style>
```

This is quite simple because this example does not include anything different than you would normally see in plain CSS. As mentioned in a previous chapter, we can add the attribute scoped to our style to ensure that their style does not bleed from our component.

In the preceding example, you can see (in practice) how Options API divides our component into sections. In our case, we have `props`, `name`, `computed`, and `methods`:

```
export default {
  name: '',
  props: {},
  computed: { },
  methods: { }
}
```

### An Atom component using Script Setup

It is now time to look at the same component but written using the <script setup> syntax:

<template>...</template>
<script setup>
  import { computed } from 'vue';
  const props = defineProps({
    size: String,
    name: String
  });
  const iconPath = computed( () => {
    return `/assets/${props.name}.svg`;
  });
  const sizeClass = computed( () => {
    return `${props.size}-icon`;
  });
</script>
<style scoped>...</style>

Copy

Explain
As you can clearly see, the preceding example omits the `<template>` and `<style>` tags. These have been omitted because they are identical to the Options API counterpart. In fact, as we have already mentioned, the difference between these two methods only affects the logical part of the component, which is `<script>`.

The first line of our component is `import`:

```
import { computed } from 'vue';
```

In contrast to Options API, where all the options were already available to us when using `<script setup>`, we have to import each individual Vue.js method from `'vue'`, just as we did in the previous code for `computed`.

Next up, we are going to see how properties are defined in Composition API:

```
const props = defineProps({
  size: String,
  name: String
})
```

Properties are one of the few options to have a verbose declaration while using `<script setup>`. In fact, to be able to declare them, we need to make use of a compiler macro called `defineProps`. Macros do not need to be imported, as they are just going to be used by the compiler and removed from the code. If you have ever used TypeScript, you will be familiar with this approach.

Next up, we have `computed`:

```
const iconPath = computed( () => {
    return `/assets/${props.name}.svg`;
  });
  const sizeClass = computed( () => {
    return `${props.size}-icon`;
  });
```

Declaring the properties of `computed` is very similar to Options API but with two small differences:

- The logic of the properties of `computed` need to be passed as a callback to the computed method imported from `'vue'`
- The `this` keyword is not available anymore, and we can access variables directly
This is as far as we will go in terms of explaining the differences between Options API and Composition API for now. We will cover Script Setup (Composition API) in more detail later in the book. If you are extremely new to Vue.js, this section probably included lots of new syntax, and it was a little hard to grasp, but as soon as we start to build our Companion App, as you gain knowledge with Vue.js and its syntax, things will quickly make more sense to you.

In this section, we have started to learn how Vue.js components are defined and the different sections that form an SFC. We then concluded the section by covering a sample component in both syntactic sugars in detail.

# Summary

We have now reached the end of this fairly theory-heavy chapter, and this was required for us to get started with our app-building process. In this chapter, we have learned what makes Vue.js different from the other frameworks by analyzing its reactivity system. We then broke down the composition of a Vue.js SFC, also known as a `.vue` file, and we walked through a Vue.js component’s lifecycle by analyzing all the different lifecycle hooks available within the framework.

In the middle of the chapter, we learned the main differences between Composition API and Options API by exploring them using sample components.

In the next chapter, we will start to learn Vue.js by starting to build our Companion App. This will be the beginning of your long journey from being a complete beginner to an experienced Vue.js developer.



| ≪ [ 02 Ch01 Exploring the Books Layout and Companion App ](/packtpub/2024/2409_vue_js_3_for_beginners/02_ch01_exploring_the_books_layout_and_companion_app) | 03 Ch02 The Foundation of Vue.js | [ 04 Pt2 Understanding the Core Features of Vue.js ](/packtpub/2024/2409_vue_js_3_for_beginners/04_pt2_understanding_the_core_features_of_vue_js) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/2409_vue_js_3_for_beginners/03-ch02_the_foundation_of_vue_js
> (2) Markdown
> (3) Title: 03 Ch02 The Foundation of Vue.js
> (4) Short Description: Sep 2024 302 pages Author Simone Cuomo
> (5) tags: vue.js
> Book Name: 2409 Vue.js 3 for Beginners
> Link: https://www.packtpub.com/en-kr/product/vuejs-3-for-beginners-9781805123293
> create: 2025-05-02 금 12:44:56
> Images: /packtpub/2024/2409_vue_js_3_for_beginners_img/
> .md Name: 03-ch02_the_foundation_of_vue_js.md

