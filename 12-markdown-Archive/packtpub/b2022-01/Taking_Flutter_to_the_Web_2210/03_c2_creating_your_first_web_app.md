
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

> [ 02 C1 Getting Started with Flutter on the Web ](/packtpub/taking_flutter_to_the_web/02_c1_getting_started_with_flutter_on_the_web) <---> [ 04 C3 Building Responsive and Adaptive Designs ](/packtpub/taking_flutter_to_the_web/04_c3_building_responsive_and_adaptive_designs)

# 03 C2 Creating Your First Web App

In the previous chapter, we introduced you to Flutter on the web. In this chapter, we will start exploring the basics of Flutter web. We will begin by creating a new Flutter project, which we will complete during the course of this book.

By the end of this chapter, you will be able to create and run a new Flutter project with web support. You will also learn about basic Flutter widgets, and then go on to learn about Flutter layout widgets to build different layouts. We will also develop a basic UI required for our application. We will be building an online learning platform, a lightweight version of Udemy.

In this chapter, we will cover the following main topics:

- Creating a new Flutter project with Flutter web
- Using basic widgets
- Building layouts

# Technical requirements

The technical requirements for this chapter are as follows:

- Flutter version 3.0 or later installed and running
- Visual Studio Code or Android Studio
- Google Chrome browser

You can download the code samples for this chapter and other chapters from the book’s official GitHub repository at https://github.com/PacktPublishing/Taking-Flutter-to-the-Web. The starter code for this chapter can be found inside the `chapter2_start` folder.

# Creating a new Flutter project with Flutter web

In the last chapter, we already created our Flutter project with web support. In this chapter, we will start our project for this book. As before, let’s create our new project:

```
flutter create flutter_academy
```

This command will create a new Flutter project, and if you have followed the steps from the previous chapter, you should already have web enabled. This new project should be created with web support.

Now, make sure you can run your project using the following command from your terminal, or by tapping F5 after opening the project in Visual Studio Code:

```
flutter run -d chrome
```

As we will have already coded some starter code, copy the files inside `chapter2_start/lib` to the `lib` folder of the project you just created. We have some basic widgets already set up here, which we will talk about in the next section.

# Using basic widgets

We will start by revising some basics, which will involve creating sections of our home page. To begin, open the `chapter2_start/lib/widgets/featured_section.dart` file and start updating the code as the following.

First, we will create a stateless widget:

```
import 'package:flutter/material.dart';
class FeaturedSection extends StatelessWidget {
  const FeaturedSection({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

Here, we are creating a stateless widget that just displays a blank container. Our featured section will have an image, a title, a description, and a button. We want to display the image on the left and content on the right, or vice versa. Let’s add our image and content. Update the body of the `build` method, as follows:

```
return Container(
  child: Row(
    children: [
      Image.asset("image"),
      Text("Title"),
      Text("Description"),
      ElevatedButton(
        child: Text("Button"),
        onPressed: (){},
      )
    ],
  ),
);
```

Here, we added a `Row` widget as a child of the container. The `Row` widget allows us to render its child widget horizontally. However, we want the content to be vertically stacked one after another. So, let’s update the children of `row`, as follows:

```
children: [
  Expanded(child: Image.asset("image")),
  Expanded(
    child: Column(
      children: [
        Text("Title"),
        Text("Description"),
        ElevatedButton(
          child: Text("Button"),
          onPressed: () {},
        )
      ],
    ),
  )
],
```

Here, we are wrapping our `Image` widget with an `Expanded` widget. That will expand to take the available space on the row. We are also wrapping the right-side content with an `Expanded` widget, so both contents will take exactly 50% of the available space. In order to display the content vertically, we are using the `Column` widget. Now, all that remains to do is to add parameters to receive the image path, title, description, button text, and the button `onPressed` handler. Let’s add those parameters:

```
class FeaturedSection extends StatelessWidget {
  const FeaturedSection({
    Key? Key,
    required this.image,
    required this.title,
    required this.description,
    required this.buttonLabel,
    required this.onActionPressed,
  }) : super(key: key);
  final String image;  
  final String title;
  final String description;
  final String buttonLabel;
  final Function() onActionPressed;
...
```

We have updated the class constructor, as well as added class properties to accept the title, description, button label, and button-pressed function handler. Now, we will use these in our widgets. To do that, update the `build` method with the following:

```
return Container(
  child: Row(
    children: [
      Expanded(child: Image.asset(image)),
      Expanded(
        child: Column(
          children: [
            Text(title),
            Text(description),
            ElevatedButton(
              child: Text(buttonLabel),
              onPressed: onActionPressed,
            )
          ],
        ),
      )
    ],
  ),
);
```

Here, we are using the properties to display our image and content instead of hardcoding the values. This will allow us to use this widget multiple times, each instance with different values. Using the `FeaturedSection` widget we have created here will enable multiple featured sections with different properties to appear on our home page. Finally, we will now add some styles to our code.

Let’s first style the title. Replace the title text with the following:

```
Text(
  title,
  style: Theme.of(context).textTheme.headline3,
),
```

Here, we are giving the `headline3` text theme for the title. The style comes from the default theme applied to our application, so that later we can update the theme to update the overall style of the text everywhere in the app, instead of updating individual styles.

Finally, we will add some spacing and alignments to make the widget look nicer. Update the `build` method, as follows:

```
return Container(
  width: 1340,
  padding: const EdgeInsets.all(32.0),
  child: Row(
    children: [
      Expanded(
        child: Image.asset(
          image,
          height: 450,
        ),
      ),
      const SizedBox(width: 20.0),
      Expanded(
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(height: 20.0),
            Text(description),
            const SizedBox(height: 10.0),
            ElevatedButton(
              child: Text(buttonLabel),
              onPressed: onActionPressed,
            )
          ],
        ),
      )
    ],
  ),
);
```

Here, we have added some spacing between contents using the `SizedBox` widget. We have also given a fixed height to our `Image` to keep the size constant, no matter the size of the image used. We also gave a fixed width to our wrapping container so that it won’t take up the whole screen’s width. Then, we added some padding around the content by passing `padding` to the wrapping container. This completes our featured section widget. The complete code for this can be found in the `chapter2_final/lib/widgets/featured_section.dart` folder.

Let’s also build the `CourseCard` widget that we will use to display the list of courses on our home page. We will begin by creating a new stateless widget and then add some properties, as we did in the previous section. Create a new file called `chapter2/lib/widgets/course_card.dart` and update it as follows:

```
import 'package:flutter/material.dart';
class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.image,
    required this.title,
    required this.onActionPressed,
    required this.description,
  }) : super(key: key);
  final String image;
  final String title;
  final Function() onActionPressed;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

Here, we created a simple stateless widget and added properties for the image, title, description, and action handler, which is similar to what we used before to build our `FeaturedSection` widget. Now, we will update the `build` method, as follows, to build the layout:

```
return Container(
  width: 350.0,
  child: Card(
    child: InkWell(
      onTap: onActionPressed,
      child: Column(
        children: [
          Image.asset(
            image,
            height: 250,
          ),
          const SizedBox(height: 10.0),
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 10.0),
          Text(description)
        ],
      ),
    ),
  ),
);
```

Similar to what we have done before, we are building this layout using a `Card` widget in combination with the `Column` and `InkWell` widgets to make the whole card clickable. We have also given some fixed sizes as well as some stylings.

So, we’ve now covered the basics of widgets. We are not going too deep into this, as you should have already covered these concepts while learning the basics of Flutter. You can view other widgets that we have already built for you in the `chapter2/lib/widgets` folder. They too are widgets that we will use in the next section to build the layout of our home page. All the widgets in the `widgets` folder are built using basic widgets similar to what we have looked at in this chapter.

Tip

If you have any queries, revisit the basics of Flutter and widgets in Chapter 1, Getting Started with Flutter on the Web.

# Building layouts

Let’s continue by building our home page, and in the process, we will learn about some more basic layout widgets that will be essential in further chapters when we’re learning about more advanced concepts. We will be reusing the widgets we built in the last section as well as the ones already provided with the starter project in the `chapter2/lib/widgets` folder. Let us start by creating our home page. Create a new file called `chapter2/lib/pages/home_page.dart`, and start by creating a stateless widget with the following:

```
import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          AppBar(
            title: Text('Flutter Academy'),
          ),
        ],
      ),
    );
  }
}
```

Here, we are introducing new widgets that will help build layouts. Firstly, we will be using the Material Design widgets. For each page, we will use the `Scaffold` widget, which provides the basic layout for a page. Then, we have `ListView`, which will allow us to render a list of widgets, such as `Row` or `Column` that we used in the previous section. However, unlike rows and columns, the `ListView` widget allows us to render content that can overflow the screen. The `ListView` widget automatically handles the overflowing content by providing a scrolling container. In our `ListView`, we have only added an `AppBar` widget for now, which will be our top navigation. We will now build our home page by using the different widgets provided to us in the `chapter2/lib/widgets` folder.

First, let’s add a header section below `AppBar`. For that, import the `header.dart` file, which contains the header widget at the top:

```
import 'package:flutter_academy/widgets/header.dart';
```

Once you import the header, you can now use the widget, so below `AppBar`, add the `Header` widget with the following code:

```
...
Header(),
...
```

After adding the header, our home page is starting to take shape. Now, you can run the app on the web using the following command from your terminal:

```
flutter run -d web
```

Once you run this, your app should build and run on a Chrome browser, and you should see the following output:

![ 0300 Figure 2.1 – Home page with header ](/packtpub/taking_flutter_to_the_web_img/0300_figure_2.1_–_home_page_with_header.webp
)
Figure 2.1 – Home page with header

The second section will be a list of recent courses. For this, we will add a horizontally scrollable list of courses in a card view. If you look inside the `chapter2/lib/widgets` folder, there is a file named `course_card.dart` that contains our course card view. We will use this and build our recent courses section. Now, below the `Header` widget, we will add a horizontally scrolling `ListView` using the following code:

```
const SizedBox(height: 40.0),
Padding(
  padding: const EdgeInsets.only(left: 20.0),
  child: Text("Recent Courses",
      style: Theme.of(context).textTheme.headline3),
),
const SizedBox(height: 10.0),
Container(
  height: 450,
  child: ListView(
    scrollDirection: Axis.horizontal,
    children: [
     // Add course cards
    ],
  ),
),
```

Here, we start by adding a 40-point gap, followed by a heading that says **Recent Courses**. Then, we add a container and give it a fixed height; otherwise, `ListView` inside another `ListView` would cause an overflow error. Giving this fixed height makes it possible to render the horizontal `ListView`. It also ensures that all of our course cards will have the same fixed height.

Finally, inside `ListView`, we will add our `CourseCard`. As we did before, we will first import the course card, as follows:

```
import 'package:flutter_academy/widgets/course_card.dart';
```

Now, we add the course cards as the children of `ListView` by adding the following:

```
...
children: [
  const SizedBox(width: 20.0),
  CourseCard(
    title: "Taking Flutter to Web",
    image: Assets.course,
    description:
        "Flutter web is stable. But there are no proper
         courses focused on Flutter web. So, in this course
         we will learn what Flutter web is good for and we 
         will build a production grade application along 
         the way.",
    onActionPressed: () {},
  ),
  const SizedBox(width: 20.0),
  CourseCard(
    title: "Flutter for Everyone",
    image: Assets.course,
    description:
        "Flutter beginners' course for everyone. For those
         who know basic programming, can easily start 
         developing Flutter apps after taking this
         course.",
    onActionPressed: () {},
  ),
  // ... you can add more courses
],
...
```

Here, we added two `CourseCard` widgets separated by a width of 20 points. You can add more cards in the same way. If you now hit **hot restart**, you should see the following output:

![ 0301 Figure 2.2 – Home page with course cards ](/packtpub/taking_flutter_to_the_web_img/0301_figure_2.2_–_home_page_with_course_cards.webp
)
Figure 2.2 – Home page with course cards

Now, we have our header and our recent courses. This means we are ready to add some featured sections to display different information. We will add two featured sections below the container showing the list of courses. Make sure you import the `FeaturedSection` widget as we imported other widgets before:

```
...
Center(
  child: FeaturedSection(
    image: Assets.instructor,
    title: "Start teaching today",
    description:
        "Instructors from around the world teach millions 
         of students on Udemy. We provide the tools and 
         skills to teach what you love.",
    buttonLabel: "Become an instructor",
    onActionPressed: () {},
  ),
),
Center(
  child: FeaturedSection(
    imageLeft: false,
    image: Assets.instructor,
    title: "Transform your life through education",
    description:
        "Education changes your life beyond your 
         imagination. Education enables you to achieve your
         dreams.",
    buttonLabel: "Start learning",
    onActionPressed: () {},
  ),
),
...
```

The following screenshot shows how the two featured sections look. We are adding two variations, where one has the image on the left and the other has the image on the right:

![ 0302 Figure 2.3 – Home page featured section ](/packtpub/taking_flutter_to_the_web_img/0302_figure_2.3_–_home_page_featured_section.webp
)
Figure 2.3 – Home page featured section

Now it’s time to complete our layout by adding a call to action section, then one more featured section, and finally a footer. We will do that by following the same process as we have up until now. Firstly, we will import our call to action and footer widgets, as we have already imported the featured section widget:

```
import 'package:flutter_academy/widgets/call_to_action.dart';
import 'package:flutter_academy/widgets/footer.dart';
```

Now, let’s add these sections below the featured section we’ve already added, by using the following code:

```
...
CallToAction(),
Center(
  child: FeaturedSection(
    imageLeft: false,
    image: Assets.instructor,
    title: "Know your instructors",
    description:
        "Know your instructors. We have chosen the best of
         them to give you highest quality courses.",
    buttonLabel: "Browse",
    onActionPressed: () {},
  ),
),
Footer(),
...
```

Here, we have added the call to action widget, a featured section widget as we did previously, and finally, a footer widget that contains various links and some more information about our product.

This screenshot shows the sections we just added:

![ 0303 Figure 2.4 – Call to action and footer ](/packtpub/taking_flutter_to_the_web_img/0303_figure_2.4_–_call_to_action_and_footer.webp
)
Figure 2.4 – Call to action and footer

Well done! We have successfully built the layout of our home page widget! We’ve also revised the basics of widgets.

# Summary

In this chapter, we revised the basics of widgets. We built simple widgets, as well as a complex home page layout using a variety of the widgets we built. Now that we have revised the basics of widgets, we can move on to more advanced topics in the next chapter. We will start the next chapter by learning about responsive and adaptive design. We will also modify our home page to be responsive, to fit both large and small screen sizes.



> [ 02 C1 Getting Started with Flutter on the Web ](/packtpub/taking_flutter_to_the_web/02_c1_getting_started_with_flutter_on_the_web) <---> [ 04 C3 Building Responsive and Adaptive Designs ](/packtpub/taking_flutter_to_the_web/04_c3_building_responsive_and_adaptive_designs)
>
> (1) Path: packtpub/taking_flutter_to_the_web/03_c2_creating_your_first_web_app
> (2) Markdown
> (3) Title: 03 C2 Creating Your First Web App
> (4) Short Description: Publication date: 10월 2022 Publisher Packt Pages 206 ISBN 9781801817714
> (5) tags: flutter web
> Book Name: Taking Flutter to the Web
> Link: https://subscription.packtpub.com/book/web-development/9781801817714/pref/
> create: 2023-01-19 목 14:36:08
> Images: /packtpub/taking_flutter_to_the_web_img/
> .md Name: 03_c2_creating_your_first_web_app.md

