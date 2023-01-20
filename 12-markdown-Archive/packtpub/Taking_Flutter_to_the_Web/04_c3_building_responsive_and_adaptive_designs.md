
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

> [ 03 C2 Creating Your First Web App ](/packtpub/taking_flutter_to_the_web/03_c2_creating_your_first_web_app) <---> [ 05 P2 Flutter Web under the Hood ](/packtpub/taking_flutter_to_the_web/05_p2_flutter_web_under_the_hood)

# 04 C3 Building Responsive and Adaptive Designs

In the previous chapter, we learned about the basics of Flutter and built a basic home page layout for our Flutter Academy application. In this chapter, we will learn concepts such as responsive and adaptive design and update our home page using these concepts.

By the end of this chapter, you will understand what responsive and adaptive design is. You will also understand why you need to make your apps responsive and adaptive and why it is even more important in Flutter. Along with this, you will gain the necessary skills to make your app responsive and adaptive. Finally, you will also learn how to make the UI of your Flutter Academy application responsive and adaptive for the web.

In this chapter, we will cover the following main topics:

- What is responsive and adaptive design?
- Why there’s a need for responsive and adaptive design in Flutter
- Responsive and adaptive design tools you may have known and used
- Tools and techniques available in Flutter to make designs responsive and adaptive
- Making our app responsive and adaptive

# Technical requirements

The technical requirements for this chapter are as follows:

- Flutter version 3.0 or later installed and running
- Visual Studio Code or Android Studio
- A Google Chrome browser

You can download the code samples of this chapter and other chapters from the book’s official GitHub repository at https://github.com/PacktPublishing/Taking-Flutter-to-the-Web. The starter code for this chapter can be found inside the `chapter3_start` folder.

# What is responsive and adaptive design?

First, let’s understand the difference between responsive and adaptive applications. They are separate dimensions of an application. An app can be either responsive or adaptive, both, or none. In this section, I will give you detailed information about the difference between these two. So, let’s get started.

## Responsive design

A responsive app is one whose layout is tuned for multiple screen sizes that the app is targeted for. The layout adapts to the changing screen size no matter what the target device is. This often means that if the user resizes the window or the orientation changes, then we can relay the UI to adapt to the change in the size of the viewport. This is especially necessary for web applications, as they can run on all sorts of devices, each with a screen of a different size and density.

## Adaptive design

An adaptive app is one that runs on different types of devices and adapts to the norms of each device type. This is a bit different from the adaptive designs that you may have heard about in a web design context. For example, on mobile, an app has to deal with touch input, whereas on desktop, it has to deal with mouse and keyboard input. Each platform has different expectations about the app’s visuals. If we want to make users feel at home, we need to make our applications adapt to the expectations of each device type. This also involves using platform-specific features. For a framework such as Flutter, this also takes care of the differences in each platform.

Now that we know what responsive and adaptive designs are, let’s see why we need to consider these approaches while designing our application in the next section.

# Why there’s a need for responsive and adaptive design in Flutter

Now you know about what responsive and adaptive design is. So, as a Flutter developer, why should you care about responsive and adaptive design? Flutter enables you to build apps that can run on mobile, desktop, and the web from a single code base. However, this raises new challenges. Though you are using the same code base, you want your app to feel familiar to users, which means adapting to each platform. So, as well as being multiplatform, the app should also be fully platform-adaptive.

Another challenge is the range of device sizes the app supports. Sizes range from mobile devices to desktops and anything that can run web applications. Thus, you need to build an app that is responsive to the screen sizes the app gets loaded into. This also means making the app responsive to the changing screen size and layouts.

Another challenge with a cross-platform framework is the different forms of input. For example, mobile devices have touch input, whereas desktops have mouse and keyboard input. An application while running on mobile should consider the touch input and make tappable items larger so that it’s easier to tap with a finger. The same application running on desktops can have smaller tappable items, as the mouse will be the primary source of input. Similarly, unlike mobile devices, you will have to think of keyboard shortcuts and keyboard inputs while running on desktop devices.

With a framework such as Flutter, it’s very necessary to implement the concepts of responsive and adaptive design to give an application a proper user experience, no matter what the platform is and what screen size the application is being loaded into. By implementing responsive and adaptive design, users of each platform will feel right at home with the application. An application made with Flutter for multiple platforms from a single code base, if properly implemented, will allow users to feel like it has been built natively for their platform.

Now that we understand the need for considering responsive and adaptive approaches while developing our application, let’s see what responsive and adaptive design tools you may already know and use in the next section.

# Responsive and adaptive design tools you may have known and used

If you already are a developer, you might have come across the concept of responsive design and might even have used some existing tools on different platforms to build responsive applications. If you are a web developer, you must be familiar with `Cascading Style Sheets (CSS)` media queries. CSS media queries are used on the web to handle different screen sizes to make application layouts. By using CSS media queries, you can define different CSS styling for your application based on the screen size. The screen size is provided, and media queries are handled by the browser.

If you are an Android developer, then you might have used another technique to handle different screen sizes of Android devices to make different layouts. Android allows you to provide different layout files, each in a specific folder, for device orientation and screen sizes. Here, you write a totally different layout file for each screen size and orientation that you want to handle. Any size or orientation that you don’t have a custom layout for will use the default layout.

Here, we learned about different responsive and adaptive design tools that you may have already used. In the next section, we will learn about the tools and techniques available in Flutter for responsive and adaptive design.

# Tools and techniques available for responsive and adaptive design

Flutter provides different tools and techniques for developing responsive and adaptive design. Like CSS, Flutter also provides media query objects with details regarding device size, orientation, pixel density, and so on. Like Android, we can decide to build different layouts based on screen size and orientation if we choose to. In this section, we will learn about those tools and techniques. There are basically two things we need to make designs responsive and adaptive: the viewport size and the platform or device that it’s running on. Flutter provides ways to get this information. Apart from tools to provide this information, Flutter by default provides various widgets that allow you to lay out your design in a way that adapts to the changing viewport.

First, let’s talk about the **MediaQuery** (https://api.flutter.dev/flutter/widgets/MediaQuery-class.html) object. Flutter provides the `MediaQuery` object that you can access in your application and also provides the **MediaQueryData** (https://api.flutter.dev/flutter/widgets/MediaQueryData-class.html) object, which has various information regarding current media – for example, a window that the application is running on. This is somewhat like the media query that is used in CSS if you have done web development before. As you can see, the `MediaQueryData` object provides a viewport size, view insets, view padding, platform brightness, and various other information regarding the device and viewport. You can use this information to make your application respond to the changes in the viewport.

Next, when we want to figure out the platform that the application is currently running on, we have a `Platform` as well as a constant called **kIsWeb**. The `Platform` class provides different properties to figure out which platform the app is running on. kIsWeb is a Boolean value that is `true` only when the application is running on the Flutter web platform. These handy properties allow us to figure out which platform and operating system our application is running on during the application’s runtime. Once we know the platform details, we can make platform-specific decisions to modify and adapt our application. For example, in an application where the user has to choose between different options, you could use bottom sheets if the application is running on iOS, dialog if the application is running on Android, and a drop-down button if it’s running on desktop and web.

Now, apart from these two tools, Flutter provides other widgets to make your application responsive. `AspectRatio`, `FittedBox`, `FractionallySizedBox`, `LayoutBuilder`, and so on are just a few of those widgets. We will use the aforementioned tools and some of these widgets in the next section to make our application responsive.

Important Note

While going through the chapter, remember that the method that is described in this chapter is not the only way to achieve responsive and adaptive design. There are always multiple ways to achieve the same thing.

There are some great open source example web applications that you can refer to see how to achieve responsive and adaptive design:

- Flokk (https://github.com/gskinnerTeam/flokk)
- Flutter gallery (https://github.com/flutter/gallery)

# Making our app responsive and adaptive

In this section, we will use some of the tools and techniques we learned about in the previous section to improve our Flutter Academy app. We will make our Flutter Academy app responsive and adaptive.

## Defining metrics for responsive design

First, we will start by defining some screen size constants. We will use some of the popular screen sizes on the market that are also used by other web application frameworks.

In `chapter3_start/lib/res`, create a file named `responsive.dart`. Inside this file, define the following class and the constants. As we are working on Flutter on the web, the sizes here are taken from Tailwind CSS, a popular CSS framework. You can use this or decide the sizes yourself by researching the common screen sizes:

```
class ScreenSizes {
  static const double xs = 480.0;
  static const double sm = 640.0;
  static const double md = 768.0;
  static const double lg = 1024.0;
  static const double xl = 1280.0;
  static const double xxl = 1536.0;
}
```

Now that we have the screen sizes, we will use this and the `MediaQueryData` we discussed in the previous section to first make our featured section widget responsive.

## Updating a featured section to be responsive

Based on the screen size, we want to change the layout of a featured section widget. Before writing the code, we need to decide the layout. Currently, the featured section shows the image and the text in a row, each occupying 50% of the space using the expanded widget. So, let’s say for a screen size above the medium (768), we want the current layout, whereas for a screen size below that, we want the information to be displayed in a single column. For this, we will need to remove the fixed width given to the top container and switch the top-level `Row` widget that we are using with the `Flex` widget. The `Flex` widget is the primitive version of `Row` and `Column` and allows us to define the direction by laying out the children either horizontally or vertically. To decide the direction, we will get the screen width from the MediaQueryData object and compare it with the screen size constants that we have defined. We might want to use this strategy in a couple of widgets later on, so first, in `chapter3_start/lib/res/responsive.dart`, let’s create a method called `getAxis` as follows:

```
Axis getAxis(double width) {
  return width > ScreenSizes.md ? Axis.horizontal :
    Axis.vertical;
}
```

This function takes a width and returns `Axis`. If the provided width is greater than the medium screen size that we have defined, then the axis will be horizontal; otherwise, it will be vertical. Let’s update our `FeaturedSection` widget using the `Flex` widget along with the `getAxis` method we just defined. Update the `build` method as follows:

```
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return Container(
    height: width > ScreenSizes.md ? null : 600,
    padding: const EdgeInsets.all(32.0),
    child: Flex(
      direction: getAxis(width),
      children: [
        ...
      ],
    ),
  );
}
```

The following figure shows how it looks on a large screen:

![ 0400 Figure 3.1 – The featured section on a large screen ](/packtpub/taking_flutter_to_the_web_img/0400_figure_3.1_–_the_featured_section_on_a_large_screen.webp
)
Figure 3.1 – The featured section on a large screen

The following figure shows how it looks on a small screen:

![ 0401 Figure 3.2 – The featured section on a small screen ](/packtpub/taking_flutter_to_the_web_img/0401_figure_3.2_–_the_featured_section_on_a_small_screen.webp
)
Figure 3.2 – The featured section on a small screen

Here, we are getting the width from the `MediaQuery`. Accessing the width from MediaQuery this way makes sure that whenever the width changes, the `build` method is called again with the new value for the width. Then, we are defining the container height instead of the width. We are giving a fixed height when the width is greater than the medium screen size we defined. This makes sure that when the widgets are laid out horizontally, we have a proper section with enough height. And finally, we replaced the `Row` widget with `Flex`, and the direction is defined again by the same `getAxis` method we defined previously. The `getAxis` method will decide whether to lay children down horizontally or vertically, based on the width given to it as a parameter. Now that our featured section looks great, on both small and large screens, let’s move on to modifying the footer in the next section.

## Modifying the footer

Next, we will work on the footer, as it involves similar decisions. So, let’s get started. Like before, we first need to decide how it looks in different screen sizes. Right now, the footer has three different columns of links, and below them, there is a row with a title and copyright information. To make it simple, we will use the same logic as before – that is, when we are in screens a size larger than the medium size that we have defined, we will use the current layout; otherwise, we will lay out everything in a single column.

We will start by getting the width from MediaQuery inside our `build` method. Open `lib/widgets/footer.dart` and update the `build` method by adding the following lines:

```
Widget build(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  ...
}
```

Next, we will make a few modifications. Right now, we are giving the footer’s wrapping container a height of `300`; however, when we switch to a single column layout on small screens, this will not be sufficient, and we will run into an overflow error. So, we will drop the height and also the expanded widget we have used for our row inside the top-level column in the footer widget.

The current `build` method code in the footer widget looks like this:

```
return Container(
  height: 300,
  color: Colors.grey.shade900,?
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(height: 20.0),
      Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          ...
```

We will update it to the following:

```
return Container(
  color: Colors.grey.shade900,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        ...
```

The Column widget usually takes all the available vertical space, and we run into an overflow error; however, by setting `mainAxisSize` as `MainAxisSize.min`, we tell the column to only take the minimum space required.

Now, we will replace the `Row` widget that we are using to display the three columns of links with the `Flex` widget as we did before. Here again, we will use the `getAxis` method we wrote previously to set the direction of our `Flex` widget, so that footer links are displayed in three columns on larger screens and a single column on smaller screens. Again, update the `build` method code as follows:

```
return Container(
  color: Colors.grey.shade900,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 20.0),
      child: Flex(
        direction: getAxis(width),
        crossAxisAlignment: CrossAxisAlignment.start,
        ...
```

Similarly, inside the `Flex` children, we will display the sized box for spacing only when the screen width is larger than medium and the `Flex` is laid out horizontally. So, we update the sized box as follows:

```
if (width > ScreenSizes.md) const SizedBox(width: 20.0),
```

This will make sure the sized box is only displayed when the screen width is greater than the medium screen size that we have defined. Similarly, we will do the same thing for the `Spacer` widget, as we don’t want spacers when everything is laid out in a single column. Update the `Spacer` widget as follows:

```
if (width > ScreenSizes.md) const Spacer(),
```

In the same manner, let’s also update the row below the links displaying the app name and the copyright information, as follows:

```
Flex(
  direction: getAxis(width),
  children: [
    Padding(
      padding: width > ScreenSizes.md
          ? const EdgeInsets.only(left: 30.0)
          : const EdgeInsets.all(0),
      child: Text(
        "Flutter Academy",
        style: 
          Theme.of(context).textTheme.headline5?.copyWith(
              color: Colors.white,
            ),
      ),
    ),
    width > ScreenSizes.md
        ? const Spacer()
        : const SizedBox(height: 10),
    Padding(
      padding: width > ScreenSizes.md
          ? const EdgeInsets.only(right: 30.0)
          : const EdgeInsets.only(bottom: 10),
      child: Text(
        "© 2018 Flutter Academy",
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(color: Colors.white),
      ),
    ),
  ],
),
```

The following screenshot shows how the footer looks on a large screen:

![ 0402 Figure 3.3 – The footer on a large screen ](/packtpub/taking_flutter_to_the_web_img/0402_figure_3.3_–_the_footer_on_a_large_screen.webp
)
Figure 3.3 – The footer on a large screen

The following screenshot shows how the footer looks on a small screen:

![ 0403 Figure 3.4 – The footer on a small screen ](/packtpub/taking_flutter_to_the_web_img/0403_figure_3.4_–_the_footer_on_a_small_screen.webp
)
Figure 3.4 – The footer on a small screen

Here, we are again replacing the row with a `Flex` widget and using the `getAxis` method to determine the direction of it. We are also making sure that the `Spacer` widget is displayed on screens sized larger than medium. Finally, based on the screen size, we are also modifying the padding to make it look consistent.

We have now successfully applied the responsive design techniques we learned in the previous sections to make our featured section and footer responsive. Next, let’s see how we can update a design based on the input that users provide.

## Making our app input-ready

Next, let’s talk about input. The web runs on desktop as well as mobile devices. Unlike desktops, mobile devices have touch input. Therefore, it is better to use large areas for intractable items such as buttons. So, let’s handle that in our call-to-action section. Our call-to-action button has the same size on all devices. So again, using the media query, we will decide on our button size. On devices smaller than the medium screen size we defined, which we assume are tablets and mobiles with touch input, we will make the button large so that it’s easy to tap, and on large screens, we will make it smaller.

Open `lib/widgets/call_to_action.dart` and update the Elevated Button widget, like so:

```
ElevatedButton(
  style: ElevatedButton.styleFrom(
    fixedSize: MediaQuery.of(context).size.width >
      ScreenSizes.md
        ? Size(180, 50)
        : Size(180, 60),
  ),
  onPressed: () {
    print("register");
  },
  child: Text("Get Started"),
)
```

Here, we just updated the size of the button based on the screen size. You can modify the buttons on the featured section using the same principle.

This is how the button looks on small and large screens:

![ 0404 Figure 3.5 – The button on small and large screens ](/packtpub/taking_flutter_to_the_web_img/0404_figure_3.5_–_the_button_on_small_and_large_screens.webp
)
Figure 3.5 – The button on small and large screens

Now that we have seen how we can modify the button based on the input that might be available, making it easier for the user to respond and provide the required input, let’s also update the app navigation so that it’s easily accessible in each screen size.

## Updating navigation to be responsive

Now, it’s time to handle the top navigation. Unlike other layouts we have dealt with, we will use a totally different idea here. For the top navigation, on a large screen, we will display the horizontal navigation as it is right now. It is displayed using the actions in `AppBar`:

![ 0405 Figure 3.6 – Top navigation on a large screen ](/packtpub/taking_flutter_to_the_web_img/0405_figure_3.6_–_top_navigation_on_a_large_screen.webp
)
Figure 3.6 – Top navigation on a large screen

On a small screen, we want to hide the top navigation so, let’s modify the `AppBar` actions like so:

```
AppBar(
  ...
  actions: (MediaQuery.of(context).size.width <= 
    ScreenSizes.md)
      ? null
      : [
          TextButton(
            child: Text("Home"),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {},
          ),
          TextButton(
            child: Text("Courses"),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {},
          ),
          TextButton(
            child: Text("About"),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {},
          ),
          TextButton(
            child: Text("Contact"),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
),
```

So, we just hid the actions on a screen size smaller than medium.

However, on the small screen, we want to display side navigation, which is hidden by default and only displayed when the user taps the icon on the top bar. In order to display this menu, Material Design provides a `drawer` property on the scaffold. We will use that to build a menu that looks like this:

![ 0406 Figure 3.7 – Side navigation on a small screen ](/packtpub/taking_flutter_to_the_web_img/0406_figure_3.7_–_side_navigation_on_a_small_screen.webp
)
Figure 3.7 – Side navigation on a small screen

In the scaffold, let’s add `drawer`, as shown in the following code block:

```
return Scaffold(
  body: ListView(
    ...
  )
  drawer: MediaQuery.of(context).size.width > 
    ScreenSizes.md
      ? null
      : Drawer(
          child: ListView(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Flutter Academy",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.white),
                ),
              ),
              ListTile(
                title: Text("Home"),
                onTap: () {},
              ),
              ListTile(
                title: Text("Courses"),
                onTap: () {},
              ),
              ListTile(
                title: Text("About"),
                onTap: () {},
              ),
              ListTile(
                title: Text("Contact"),
                onTap: () {},
              ),
            ],
          ),
        ),
);
```

Here, again, we decided that we want to display `drawer` only when the screen size is smaller than the medium size. Now, we have our responsive navigation too.

This is all for now. We will learn more about these techniques and use more of these widgets further as we proceed to implement more features in our application.

# Summary

In this chapter, we learned about responsive and adaptive design. We learned why we need to make our applications responsive and adaptive. We learned that as Flutter is a cross-platform framework, we need responsive and adaptive designs more than ever. Finally, we used the information that we gathered during the lesson to make our Flutter Academy app’s home page responsive and adaptive.

In the next chapter, we will learn how Flutter on the web works under the hood and how to use that information to benefit our application.



> [ 03 C2 Creating Your First Web App ](/packtpub/taking_flutter_to_the_web/03_c2_creating_your_first_web_app) <---> [ 05 P2 Flutter Web under the Hood ](/packtpub/taking_flutter_to_the_web/05_p2_flutter_web_under_the_hood)
>
> (1) Path: packtpub/taking_flutter_to_the_web/04_c3_building_responsive_and_adaptive_designs
> (2) Markdown
> (3) Title: 04 C3 Building Responsive and Adaptive Designs
> (4) Short Description: Publication date: 10월 2022 Publisher Packt Pages 206 ISBN 9781801817714
> (5) tags: flutter web
> Book Name: Taking Flutter to the Web
> Link: https://subscription.packtpub.com/book/web-development/9781801817714/pref/
> create: 2023-01-19 목 14:36:08
> Images: /packtpub/taking_flutter_to_the_web_img/
> .md Name: 04_c3_building_responsive_and_adaptive_designs.md

