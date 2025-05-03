
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

| ≪ [ 04 Pt2 Understanding the Core Features of Vue.js ](/packtpub/2024/2409_vue_js_3_for_beginners/04_pt2_understanding_the_core_features_of_vue_js) | 05 Ch03 Making Our HTML Dynamic | [ 06 Ch04 Utilizing Vues Built-In Directives for Effortless Development ](/packtpub/2024/2409_vue_js_3_for_beginners/06_ch04_utilizing_vues_built-in_directives_for_effortless_development) ≫ |
|:----:|:----:|:----:|

# 05 Ch03 Making Our HTML Dynamic

The theoretical chapters have now come to an end. It is time to start building our Companion App and learn about Vue.js. As we build our application, one step at a time, we will also learn about Vue.js. The idea of this approach of learning by doing is most effective when you follow along and build the application alongside me.

To help you grasp complicated topics and ensure that you have learned the basics of Vue.js, you will also be asked to complete some extra tasks that can either be applied to the Companion App or used as a standalone project.

In this chapter, we’ll cover the following topics:

- Building your first Vue project
- Creating our first components
- Introducing properties
- Learning about Vue.js reactive data with Refs and Reactive

The goal of this chapter is to introduce you to the basics of Vue.js. You will learn how to create a project from scratch to understand how a Vue component is structured. At the end of the chapter, you will be able to create Vue components, define attributes using props, and handle private state with Refs and Reactive.

# Technical requirements

From this point onward, all chapters will require you to check out a specific version of the code from our repository. We installed our repository back in `Chapter 1`, when we downloaded the application and ran it for the first time.

Using that same repository, which is available at https://github.com/PacktPublishing/Vue.js-3-for-Beginners, we can jump between chapters using the various branches. Having one individual branch per chapter ensures that our starting point matches, preventing possible code issues or missing parts that would make the learning complicated.

In this chapter, the branch is called CH03. To pull this branch, run the following command or use the GUI of choice to support you in this operation:

```
git switch CH03.
```

Do not forget that to run the application after switching the branch, you have to ensure all dependencies are installed and run the dev server. This can be achieved with the following two commands:

```
npm install
npm run dev
```

Please note that we won’t need the repository until the Creating our first component section.

# Building your first Vue.js project

The time has come to start and build our companion application. If you are already familiar with Vue.js and how you create a new project using it, you can skip this section, pull the code from our repository, and start building the application in the next chapter.

When we create a new project using the `vue create` command, which we will see soon, we use the Vite build tool behind the scenes. Until recently, the best build tool was Webpack, and all frameworks, including Vue 2, used it to build their applications. But things have now changed, and Vite has taken over due to its no-config approach and extremely fast development server.

On its official site, Vite is described as follows:

“Vite (French word for “quick”, pronounced /vit/, like “veet”) is a build tool that aims to provide a faster and leaner development experience for modern web”

Vite was created by Evan You (yes, the author of Vue) in an attempt to improve the development experience. Vite has been around for just a few years, but it has quickly gained popularity due to its low configuration and fast development server.

Vite, like Vue.js, is fully open source, and it also supports all major frameworks out of the box. Creating a project with Vite is quite simple, all you need is an IDE and a terminal.

### Vue CLI GUI

You have probably heard that Vue CLI offered a visual tool that helped you manage the Vue application. Unfortunately, that project was linked to Webpack and has yet to be imported to Vue 3 and Vite.

### Create Vue command

Because it is not possible to create a project in an existing folder, we are not able to re-use our previously downloaded application. We are going to complete this step in a different folder to ensure that you are able to get a project started from scratch. In the next chapter, we will pull the code directly from the companion application repository.

To create a new project with Vue, we first need to access the folder in which the project will be created. Please be assured that the CLI will create a new folder for your project, so you do not need to create a folder manually now, but just access the main folder in which the project should live. For example, I like to create all my projects in the `Document` folder, so I am going to access it like this:

```
// Mac users
cd ~/Documents/
// Windows users
cd %USERPROFILE%/documents
```

Now that we are in the correct folder, we can call the Terminal command required to create a new Vite project:

```
npm create vue@latest
```

Running the preceding command will generate a request to install the create-vue package:


Figure 3.1: The installation message triggered by the create vue command

To successfully install the project, we need to press y and proceed with the installation.

After a few seconds, the CLI will start and ask us questions that will help it scaffold the project to align with our needs:

Figure 3.2: The Vue CLI questions

As you can see, Vue projects come with a nice set of presets that help it to create a strong foundation for your next Vue project. Vue CLI provides options for the following settings:

- Project Name
- Typescript
- JSX support
- Router
- State Management
- Unit tests
- End to End tests
- Code quality
- Code formatting

The choices for these settings are completely up to you, and you should follow your personal needs and requirements. The ones that you see in Figure 3.2 are the settings that I have used to create the Companion App that we will use in the next chapter.

After pressing Enter and waiting for a few seconds, we should get some information about how to run our project. This requires us to access the folder, install the required packages, and run the development server.

First, let’s navigate to the folder that was created as part of our Vue project initialization, that is equal to your project name:

```
cd "vue-for-beginners"
```

Then, install all the packages required for the project to function. I have used npm in this instance, but you can use Yarn or PNPM:

```
npm install
```

Last, we just need to run this command to run the development server:

```
npm run dev
```

After these two commands, in less than a second you should see the following message displayed in your console:

Figure 3.3: Vite output of a successful run of the Vue development environment

Vite projects act differently from the previous Webpack projects that were run on port 3000 and run on port 5173. The local URL will be displayed in the console, as shown in Figure 3.3.

In our case, accessing the browser on `localhost:5173` will show the following website:

Figure 3.4: Welcome page of a newly built Vue project

Congratulations on creating your first Vue project. This is going to be the first of many projects.

### Vue project folder structure

In this section, we are going to quickly cover the structure of a new Vue project.

When a new project is created, it comes with a well-defined structure that can be used as a strong foundation for future development:

Figure 3.5: Folder structure of a newly created Vue project

We are going to explain the different folders and files to help you find anything you need from your new Vue project. We are going to do this in no particular order.

### Root folder

The root folder of a Vue project includes a few configuration files. These are preset and pre-generated by the Vue creation package and do not need any further attention for the application to run smoothly. During the course of this book and your career, you will slowly be exposed to each of these configuration files and learn about their various options.

### No touch zones

There are a couple of folders, such as `.vscode`, `node_modules`, and `dist`, that are what I call “no touch” folders. You may already be aware of these folders as they are created and managed by tools and software that you may have already used, such as Visual Studio Code, npm, or Vite, and should not be modified manually.

@@@ Public

The content of the public folder is going to be copied directly into the output folder after the project is built. This folder is very rarely touched by a developer but is very useful when there are files that are needed in the build output and not part of the Vue compilation. Example files for this folder are favicon and service worker.

### Cypress

As shown in the installation guide, the newly created project comes with a preset end-to-end (E2E) testing framework using the tool of your choice. In our case, I selected Cypress and the CLI has created a folder and a sample test for me ready to be used.

### SRC

This is where your source code lives. This is the main content of our application, and it is where you will spend most of your day-to-day work. Due to the importance of the folder, we are going to see its content and make sure we know how its files are structured:

Figure 3.6: Content of the SRC folder from a newly created Vue project

As before, let’s start from the root of the folder. This includes two files, `main.js` and `App.vue`. `Main.js` is the entry file of our application. This file is used to add new packages to our Vue instance and to load and set up global plugins, composable (function that leverages Vue’s Composition API to encapsulate and reuse stateful logic that we will introduce later in the book) and components. Next, we have App.vue. This is the first Vue entry point and is the component that will load and handle the rest of the Vue application.

Next up, we have the `assets` folder. This folder is used to load any assets, such as images, PDFs, and videos. The content of this folder is also copied in the output artifact of our build.

Further down the list, we have the `components` folder. This folder contains not only the set of components already available within the app, but also the `__tests__` folder, which includes our unit tests.

The next two folders are `router` and `stores`. As the name suggests, they include the `vue-router` and the `Pinia` store code respectively. These are two core packages provided by the Vue.js core team and will be covered in detail in `Chapter 10` and `Chapter 11`. Vue-router will be used to create navigation routes for our clients and help us manage our growing application, while Pinia will be used to create and manage data within the application.

Last but not least we have `views`. If you have had time to investigate this folder, you would have noticed that it contains simple Vue components. The reason for this folder is to separate simple component units (the ones stored in the `components` folder) actual routing pages. Making this separation helps to keep the code clean and delineate the routing of the application.

### Your private playground

Even if the app we just created is not needed for the rest of the book, it could be useful to keep and use it as a playground to practice the topic that we will cover in the course of the book.

We have concluded our Vue project explanation, and you should now have the knowledge required to create a new Vue project from scratch. You should also know a little bit about Vite and be able to navigate the folder structure of a newly created Vue project. In the next section, we will dive into the code and start to build our first Vue.js component.

# Creating our first component

As you may remember from the first chapter, in which we introduced the Companion App, we are planning to build a clone of the social application called X (former Twitter). To start our building journey in style, we are going to build the most iconic component of the application, a post.

Figure 3.7: Example of a X.com post component

In this chapter, we are going to learn how to switch between the different branches within the book repository. We are then going to create our first **SFC (Single File Component)** component using the template knowledge we gained in the previous chapter, and we will finish by adding some dynamic content to the component by introducing two Vue reactivity functions, `Refs` and `Reactive`.

### Creating Post.vue

Back in Chapter 1, we mentioned that we were going to break down components into different layers (atoms, molecules, organisms, and so on) and `SocialPost.vue` is going to be part of the molecules layer.

So, let’s create a folder called `molecules` in the `component` folder and then add a file called `SocialPost.vue`. Once you’ve done this, your folders should look like this:

Figure 3.8: File tree of the src folder of the companion app

There are two things to notice about the new file we have created:

- The name is made up of two words. This is not just to provide more context, but also because one letter component, like `post.vue`, are discouraged due to possible future collision with native HTML components like `<button>` or `<table>` (eg. If a new HTML element called <post> is introduced in future HTML releases it could clash with our custom component)
- Component names are written in PascalCase, a naming convention in which each word that makes up the variable is capitalized.

As our file is empty, let’s open it and start to create the basic structure of a Vue component by adding the `<template>`, `<script>`, and `<style>` tags:

```
<template></template>
<script setup ></script>
<style lang="scss"></style>
```

This is going to be our standard Vue starter template. It defines an empty template where we will encapsulate our **HTML**, a script tag with the `setup` attribute, which allows us to write JavaScript logic using the Composition API, and a `style` section, in which we select **SCSS** as our preprocessor.

We are now going to define the HTML and the CSS required for our post to be displayed. This is going to be a very simple design for now; we will add more in the course of the book.

Our first draft of the component is going to include a header image, the name of the user followed by the ID of the user, and the post’s description. All of this is also going to include some basic styles. Let’s look at the code:

```
<template>
<div class="SocialPost">
  <div class="header">
    <img class="avatar" src="https://i.pravatar.cc/40" />
    <div class="name">Name of User</div>
    <div class="userId">@userId</div>
  </div>
  <div class="post">This is a dummy post</div>
</div>
</template>
<script setup >
</script>
<style lang="scss">
.SocialPost{
  .header {
    display: flex;
    align-items: center;
    margin-bottom: 8px;;
  }
  .avatar {
    border-radius: 50%;
    margin-right: 12px;
  }
  .name {
    font-weight: bold;
    margin-right: 8px;
    color: white;
   }
}
</style>
```

As you have probably noticed, the preceding component does not have anything special. There’s no `script` tag, no special tag in the HTML, and nothing special in the CSS, but it is still a perfectly normal Vue component.

Let’s highlight a few important aspects of this component:

- `<div class="SocialPost">`: It is good practice to always assign a class equal to the component name, that in our case is SocialPost, to the root element of the component. This will help us scope the style without needing to use the `scoped` attribute.
- `<style lang="scss">`: In our examples, we are going to use SCSS. This is specified here. As you will see in the following section, this needs to be configured in our Vite project. You do not need to add a pre-processor, but I am adding one to show you how to add and use it in case you are used to writing your style with one.
- `.SocialPost{`: We can use the class we attached to the component name to scope our CSS by wrapping all the styles into it. This will ensure that our style will not bleed into other components.

Now that the component is ready, it is time to test it out. To do so, we need to load the component somewhere in the application. We can do so by loading the component in `TheWelcome.vue`.

To successfully load a Vue custom component, we need to complete two simple actions. First, we need to import the component, and second, we need to call it in the HTML as if it was a native component.

To load the component, we import it like a normal JavaScript file:

```
<script setup>
  import SocialPost from './molecules/SocialPost.vue'
</script>
```

Now that the component is loaded, we can simply use it in our HTML like so:

```
<template>
  <SocialPost></SocialPost>
</template>
```

Now that our component has been fully developed and loaded, it is time to try it out. To do so, let’s run our application using the `npm run dev` command. Now, access the localhost site shown in the terminal (`http://localhost:5173/`).

Unfortunately, the browser output is not what we expected; we are presented with an error:

Figure 3.9: Error message displayed by Vite

Luckily for us, the error is expected. As I mentioned before, SASS requires us to do further configuration. I wanted to show you how Vite would react if something was misconfigured. As displayed in the error message, Vite noticed that we are using SASS and is also providing us with the command required to install it. So, let’s go and run this command in the terminal:

```
npm install –D sass
```

After running this command and refreshing the browser, our application should now display our component:

Figure 3.10: Vite welcome screen displaying a newly created custom component

Congratulations! You have just written your first working Vue component. This was just a small step, but it is important to celebrate every achievement.

As you may have noted from the file that we just created, Vue.js allows you to write simple components made up of just HTML and CSS. This is a great way to slowly get started with Vue using your existing development knowledge.

### Your turn

Try to add another component of your own, for example, to ensure that you have understood how a component is created and added. You should try and create a static footer for our application.

In this section, we learned how to create and load a Vue component, we debugged our first issue with Vite and learned how to install new plugins, and finally, we found a new way to scope style to our component by wrapping its CSS. In the next section, we are going to learn how to make our component dynamic by introducing a feature called properties.

# Introducing properties

As you have noticed, the component we created in the previous section is static and could not be used in a real-life application because it would always display the same information and not the actual post.

In the following section, we are going to add some dynamic features to our component. To ensure each topic is understood fully, we will add a small feature in each section and ensure that we take enough time to reiterate the features over the course of the book.

In this section, we are going to change the structure of our post component by exposing properties. Properties are simply attributes that are exposed by the component to allow users to customize its behavior or style.

If you have ever used HTML, you are probably already familiar with Vue.js props. Many native HTML elements have attributes that are used to modify components, such as an `<input>` tag as an attribute of `Type` to change its look, a `<textarea>` tag as an attribute of `column` and `rows`, and an `<img>` tag as an attribute of `src` to define the URL for its image.

Vue.js properties (usually referred to as props) allow you to define this attribute in our component, enabling us to turn our static component into dynamic and flexible building blocks.

In this section, we are going to pick our previously created post component and expose some Vue.js properties to allow us to use it multiple times with different values.

After revisiting our post component, it seems clear that the following variables should be changed to be dynamic entries:

- `Username`: Twitter username
- `UserId`: Twitter ID
- `AvatarSrc`: Source of the avatar image
- `Post`: The content of the post

### Declaring props in Vue.js

The first step required for us to use props is to declare them in the component. Declaring a property means defining its name and its type. To do so, we can use a compiler macro used `defineProps`:

```
<script setup >
  const props = defineProps({
    username: String,
    userId: String,
    avatarSrc: String,
    post: String
  });
</script>
```

As shown here, the `defineProps` macros accept an object with our properties. In our case, these are all `String`, but other types, such as `Number`, `Object`, `Array`, and `Boolean`, are also accepted.

When we declare a property, we inform the component and its users that this component is happy to accept this extra data.

It is now time to learn how to access these properties in our SFC.

### Accessing properties in a Vue.js SFC

Properties can be accessed in multiple places. They can be read directly in the HTML as a play string, they can be used within an HTML element declaration, or they could be used in the `script` tag as part of our component logic.

All these methods have a different syntax, but even if it seems like a lot, it is going to be quite easy to remember because it is consistent with the Vue writing style.

First, we are going to learn how to use a prop as plain text. This is done using two curly braces: `{{ props name }}`. Applying this to our template will produce the following code:

```
<template>
<div class="SocialPost">
  <div class="header">
    <img class="avatar" src="https://i.pravatar.cc/40" />
    <div class="name">{{ username }}</div>
    <div class="userId">{{ userId }}</div>
  </div>
  <div class="post">{{ post }}</div>
</div>
</template>
```

As you can see, the values of `username`, `userId`, and `post` are not hardcoded anymore and it is now using properties under the hood.

Next up, we are going to learn how to use variables in our template. I used the generic word variable instead of props because this notion applies to all variables and not just props. To use a dynamic value in our template, for example, as an HTML element attribute, we just need to prepend the attribute with the symbol `:`. So, in our scenario, the image attribute `src="..."` will become `:src="avatarSrc"`.

Our `<img>` element looks like this:

```
<img class="avatar" :src="avatarSrc" />
```

Prepending an attribute with `:` informs Vue that the value is not a plain string but an actual JavaScript variable. So, in the proceeding example, the class is evaluated as a string, but the value of `src` is not going to be literally `avatarSrc` but the JavaScript variable associated with that name.

Lastly, we are going to learn how to access properties within the `script` tag. This is achieved by using the return value of the `defineProps`.

Let’s put into practice what we just learned by trying to use our properties by logging the value of `username` when the component is mounted. The code should look like this:

```
<script setup >
import { onMounted } from 'vue';
const props = defineProps({
  username: String,
  userId: Number,
  avatarSrc: String,
  post: String
});
onMounted( () => {
  console.log(props.username);
});
</script>
```

The preceding code shows how to access properties by using `defineProps`. This function accepts an object of properties (in our case `username`, `userId`, `avatarSrc` and `post`) and will return a variable that includes all the reactive properties that have been passed when the component was initialized (eg. `<MyComponent username="simone" />`). Next, we introduced another new feature of Vue.js, `onMounted`. This was introduced in the second chapter as part of the Vue lifecycle. `OnMounted` is specifically triggered when the component is fully rendered on the page.

defineProps cannot be destructured

The returned value of `defineProps` cannot be destructured. Destructuring the return object would result in non-reactive values.

Because we have removed the hardcoded strings and changed our component to use properties, we need to do one more step before we can test it in the browser. Just like HTML elements that accept attributes, we need to define our properties when creating a component instance, which in our case was happening in `TheWelcome.vue`.

Let’s see how to update our component to include our newly created properties:

```
<template>
  <SocialPost
    username="Username one"
    userId="usernameID1"
    avatarSrc="https://i.pravatar.cc/40"
    post="This is my post"
  ></SocialPost>
</template>
```

Just like a normal HTML element, we are able to pass our properties directly into the HTML tag. The names of the properties used here are the same as the ones defined in the component. They not only have to match word for word, but they are also case sensitive.

Now that our component has been fully updated, we are able to access our application by running the CLI command to start the dev server (`npm run dev`) and check the browser (`http://localhost:5173/`).

Our application should not look any different from the previous version of the component. In fact, most of the work that we did was to change how the component behaves behind the scenes, but not how it looks. This section included multiple topics and Vue features. Let’s recap what we learned so far:

- How to declare props
- How to use props
- How to use props as plain strings
- How to use props as HTML attributes
- How to use props within the script tag
- How to use our first Vue lifecycle, `onMounted`

Remember, properties in Vue js are just like HTML attributes. They allow you to make your component dynamic by exposing values that can be used in any shape or form to make your component unique. These properties can be accessed within multiple parts of your component.

In the next section, we are going to learn how to create one or multiple instances of our component and introduce a new concept: reactive data.

### Your turn

Continue to expand the footer component you created in the first section but change the values to be dynamic using props.

# Learning Vue.js reactive data with Refs and Reactive

In the previous section, we started to make our component dynamic, but that was just the first of two steps required for our component to be fully reusable. It is time to learn about component state, also known as Data (term used in the Option API) or Refs and Reactive (terms used in the composition API). Being able to set private component information, together with the ability to define component properties, will be our toolset for dynamic and flexible components.

Before we jump into data, we need to go back to the previous section and take a look at the component we just created. If you look carefully, the versions of `SocialPost.vue` look similar, and there seems to be no actual difference between the hardcoded version and the dynamic version.

So, why have we gone through the trouble of making all those changes if nothing changed? Well, the change is there, we have just not used it yet.

Let’s think for a minute about our Companion App and try to understand how the `SocialPost` component would be used. When using a real social platform, we would never expect a single hardcoded post on screen; our timeline will eventually display a large number of dynamic posts. In our first version of the component, the one that held hardcoded values, creating the component multiple times would have just resulted in the same post author and title showing over and over again. But with the dynamic version that we have created, we have the chance to pass different values to our props, allowing us to create multiple unique posts. Let’s see how this would look in practice by creating a second post:

```
<SocialPost
  username="Username one"
  userId="usernameID1"
  avatarSrc="https://i.pravatar.cc/40"
  post="This is my post"
></SocialPost>
<SocialPost
  username="Username two"
  userId="usernameID2"
  avatarSrc="https://i.pravatar.cc/40"
  post="This is my second post"
></SocialPost>
```

Creating dynamic components is a very powerful tool in web development. It allows us to reuse the same component and simplify our development efforts. Even if making the component dynamic is a step forward from our initial hardcoded example, it is still in need of some improvement. It is time to learn about reactive data and see how it can help us simplify the HTML of our component.

Keep the logic away from the HTML

A clean component is one that has most of its logic encapsulated within the `<script>` tag and has very clean HTML. It may be tempting to add some of the logic into the HTML, but this results in hard-to-maintain components.

Adding Refs or Reactive to our component allows us to remove static data from the `<template>` section of our SFC and allows us to add some dynamicity to our code.

The definition of Refs and Reactive can be a set of primitive data, objects and arrays used by a component instance to define private reactive data (state).”

This notion is not new. In fact, native HTML components hold their own state too. For example, a video component may hold a state of started or stopped, while a dropdown may hold its selected value or an internal state of expanded or collapsed.

In Vue.js and other major frameworks, reactive data is not only used to declare a state (eg. Holding the current state of a sidebar visibility of open or closed) but also to hold component data that is used internally by the component to provide a specific feature.

In our case, we are going to use private data to try and move the information on the individual posts into an array. This will allow us, in future chapters, to use an external tool, such as an API, to fetch this data dynamically.

Before we jump into the actual implementation details, let’s define the difference between Refs and Reactive:

- `Refs`: Allows the declaration of primitive values such as string, number, and Boolean and more complex types such as arrays and objects
- `Reactive`: Allows the declaration of objects and arrays and cannot be used for primitive values

Figure 3.11: Table of supported and unsupported types for Refs and Reactive

### Using objects

Some developers prefer to use Refs for everything, while others like to split the usage depending on the type being assigned. What I am going to show you may be opinionated, and you are free to change your usage to better align with your preferences.

In the course of this book, we are going to use Refs for primitive values such as string, numbers, and Booleans and reactive for arrays and objects.

The main differences between Refs and Reactive are not only in the values that they can hold but also in the way they are used. We are going to make two changes to our component to better understand the difference between Refs and Reactive.

First, we are going to introduce Refs by modifying the `SocialPost` component by adding a new feature to it. Then, we are going to learn about Reactive by moving the post information (`userId`, `avatar`, `name`, and `post`) into an array to simplify our HTML.

### Adding Refs to SocialPost.vue

Having the ability to define private data for a component is very powerful. We have seen how a component may need to receive information from its parent by defining properties, but there are times when the component needs to handle its own state. In this section, we are going to make some modifications to our component, `SocialPost.vue`, by providing it with the ability to be selected.

For this feature to be implemented, we need to make three changes to our component:

- We are going to create a private variable called `selected`
- We are going to assign a specific style when the component is selected
- We are going to modify the value of `selected` when the component is clicked

Let’s start by creating our first private variable. As mentioned earlier, this will be done using `ref`. This is a method provided by the Vue library that accepts a value that is used to initialize it. For example, if I would like to generate a variable for my name, I would write `const name = ref("Simone")`. In our case, `selected` is going to be a Boolean, and it is going to be initialized with the value `false` because the component is expected not to be selected when first rendered:

```
<script setup >
import { onMounted, ref } from 'vue';
const selected = ref(false);
const props = defineProps({
…
```

As displayed in the preceding code snippets, declaring `ref` is quite simple. First, we import it from Vue, and then we can call it by passing it the initial value of our variable. The rest of the component is omitted but is unchanged from the previous sections.

Next, we create a style for our `selected` state and find a way for this style to be added dynamically when the value of `selected` changes. Let’s start by creating a new class called `SocialPost__selected` and adding a white border when this class is active:

```
<style lang="scss">
.SocialPost{
  &__selected{
    border: white solid 1px;
  }
  .header { ...
```

We are going to add our new style to `SocialPost.vue`. Thanks to the help of SCSS, we can define the new class name by using the `&` helper in `&__selected`. If you have never seen this syntax before, it is a SASS feature that will automatically replace the `&` with the name of the parent declaration. So, in our case, `__selected` is going to be prepended with `.SocialPost`, creating `.SocialPost__selected`. SASS is not required, and you can achieve these styles using plain CSS, but I have decided to add it to show you the flexibility of Vue with Vite and to help you experience what a real application may utilize.

To make the selected post stand out, we just declare a white border around the component.

Now it is time to assign this class to our component, but we want to do this dynamically depending on the value of `selected`. Our code is going to look like this:

```
<template>
  <div
    class="SocialPost"
    :class="{ SocialPost__selected: selected}"
  >
  <div class="header">
  ...
```

We have just introduced a new feature of Vue.js. In fact, assigning dynamic classes is not possible with plain HTML, but Vue has just the right feature for us.

In __Accessing properties in a Vue.js SFC__, we mentioned that prepending an attribute with `:` allows us to provide it dynamic value, and in the case of the `class` attribute, allows us to assign one or more dynamic classes.

The `:class` attribute accepts an object that is applied to a specific class if its value is truthy. So, in our case, it is going to assign a class of `SocialPost__selected` if the value of `selected` is `true`.

We are now ready for our last step, the last part of our component enhancement that will allow us to toggle our component and show its selected state.

So far, we have created a specific style and declared a variable that stores our state. What remains is to modify our state variable, `selected`, when the component is clicked. We are going to do this by using the `@click` attribute in the root of our component:

```
<template>
  <div
    class="SocialPost"
    :class="{ SocialPost__selected: selected}"
    @click="selected = !selected"
  >
  <div class="header">...
```

By using the native `@click` event handler and some basic JavaScript, we are able to modify our `selected` variables and update our component state.

If you are not familiar with the syntax used here, by writing `selected = !selected`, we are changing the value of `selected` to be the opposite of the current value. So, if the current value is `true`, it will set it to `false`, and vice versa.

If we run our application and click on one of the components, we should see the following result:

Figure 3.12: Companion App displaying two posts one of which in a selected state with a white border.
Figure 3.12: Companion App displaying two posts one of which in a selected state with a white border.

We have now learned how to declare and use Refs to define a component state. In the next section, we will move on to our parent component, `TheWelcome.vue`, and learn how to use Reactive.

Using Reactive to host our post information
Keeping clean HTML is the key to a maintainable application, so in this section, we are going to use Reactive to improve `TheWelcome.vue`. We are going to declare a private variable of the `array` type. As we already mentioned above, we are going to use Reactive to declare and manage Arrays:

```
<script setup>
  import { reactive } from 'vue';
  import SocialPost from './molecules/SocialPost.vue'
  const posts = reactive([]);
</script>
```

The use of Reactive is very similar to Ref because it needs to be imported from the Vue library and initialized with a base value. In our case, we have assigned our variable a name of `posts`.

In the preceding code, the value assigned is an empty array, but we need to change this to include the value of the actual posts currently held in the HTML. Our Reactive initialization will be changed to the following:

```
<script setup>
import { reactive } from 'vue';
import SocialPost from './molecules/SocialPost.vue'
const posts = reactive([
  {
    username: "Username one",
    userId: "usernameId1",
    avatarSrc: "https://i.pravatar.cc/40",
    post: "This is my post"
  },
  {
    username: "Username two",
    userId: "usernameId2",
    avatarSrc: "https://i.pravatar.cc/40",
    post: "This is my second post"
  }
]);
</script>
```

Now that our variable is ready, it is time to change the content of HTML to use our Reactive value. Just like properties and Refs, we can use this directly in the HTML.

We will access the information in the first post by using `posts[0].username`, `posts[0].avatar`, and so on. Just like we did previously, we are going to inform Vue.js that the value of our props is dynamic by prepending it with `:`. The component should look like this:

```
<template>
  <SocialPost
    :username="posts[0].username"
    :userId="posts[0].userId"
    :avatarSrc="posts[0].avatar"
    :post="posts[0].post"
  ></SocialPost>
  <SocialPost
    :username="posts[1].username"
    :userId="posts[1].userId"
    :avatarSrc="posts[1].avatar"
    :post="posts[1].post"
  ></SocialPost>
</template>
<script setup>
  import { reactive } from 'vue';
  import SocialPost from './molecules/SocialPost.vue'
  const posts = reactive([
    {
      username: "Username one",
      userId: "usernameId1",
      avatar: "https://i.pravatar.cc/40",
      post: "This is my post"
    },
    {
      username: "Username two",
      userId: "usernameId2",
      avatar: "https://i.pravatar.cc/40",
      post: "This is my second post"
    }
  ]);
</script>
```

Our template has now been cleaned from the hardcoded value, which has been replaced with dynamic values declared using Reactive. Defining components using dynamic values with Refs and Reactive will be the foundation of your Vue components for the rest of your career.

# Summary

This chapter has introduced you to some basic Vue features, and we have defined the first component for our Companion App. We started the chapter by learning how to create a Vue application using the CLI and looked at its folder structure. We then created our first Vue component. By doing so, we learned how to write and use components with the SFC syntax. We then changed our static component to make use of dynamic properties. Finally, we learned about component state and learned how to use Refs and Reactive data by enhancing the functionality of our components.

### Your turn

Use the notion of Ref and Reactive in another component. This could be done in the `footer.vue` file that you previously created by moving the `link` value and `src` into a Reactive property, just like we did for our posts.

In the next chapter, we are going to continue our mission to learn Vue by introducing Vue directives. Directives are Vue-specific attributes that give us the ability to meet complex requirements with simple code. We are going to first introduce the notion of directives and then create new components or update existing ones to learn about the different built-in directives available within the Vue framework.



| ≪ [ 04 Pt2 Understanding the Core Features of Vue.js ](/packtpub/2024/2409_vue_js_3_for_beginners/04_pt2_understanding_the_core_features_of_vue_js) | 05 Ch03 Making Our HTML Dynamic | [ 06 Ch04 Utilizing Vues Built-In Directives for Effortless Development ](/packtpub/2024/2409_vue_js_3_for_beginners/06_ch04_utilizing_vues_built-in_directives_for_effortless_development) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/2409_vue_js_3_for_beginners/05-ch03_making_our_html_dynamic
> (2) Markdown
> (3) Title: 05 Ch03 Making Our HTML Dynamic
> (4) Short Description: Sep 2024 302 pages Author Simone Cuomo
> (5) tags: vue.js
> Book Name: 2409 Vue.js 3 for Beginners
> Link: https://www.packtpub.com/en-kr/product/vuejs-3-for-beginners-9781805123293
> create: 2025-05-02 금 12:44:56
> Images: /packtpub/2024/2409_vue_js_3_for_beginners_img/
> .md Name: 05-ch03_making_our_html_dynamic.md

