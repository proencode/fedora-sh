
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

> [ 05 P2 Flutter Web under the Hood ](/packtpub/taking_flutter_to_the_web/05_p2_flutter_web_under_the_hood) <---> [ 07 C5 Understanding Routes and Navigation ](/packtpub/taking_flutter_to_the_web/07_c5_understanding_routes_and_navigation)

# 06 C4 Flutter Web under the Hood

In the previous chapter, we learned why we should make our applications responsive and adaptive. We also updated our home page layout to make it responsive and adaptive. In this chapter, we will go deep inside the Flutter Engine and learn how it works under the hood. We will learn how Flutter produces apps for different platforms from the same code base, especially for the web.

By the end of this chapter, you will have learned about the different types of renderers available for building web applications from Flutter code, and the advantages and shortcomings of those renderers. You can use this knowledge to build your application using different renderers based on your requirements.

In this chapter, we will cover the following main topics:

- How does the Flutter Engine produce web apps?
- Different types of web renderers and their advantages and disadvantages.
- Choosing between HTML and CanvasKit renderers.

# Technical requirements

The technical requirements for this chapter are as follows:

- Flutter version 3.0 or later installed and running
- Visual Studio Code or Android Studio
- Google Chrome browser

You can download the code samples for this chapter from the book’s official GitHub repository at https://github.com/PacktPublishing/Taking-Flutter-to-the-Web. The starter code for this chapter can be found inside the `chapter4_start` folder.

# How does the Flutter Engine produce web apps?

In the previous chapters, we discussed the fact that Flutter enables us to build applications for multiple platforms from the same code base. So, the same Flutter code written in Dart can be compiled to any supported platform.

Flutter is essentially a toolkit for building user interfaces, but it also allows applications to interface directly with underlying platform services. When we build a Flutter application for release, the app code is compiled directly to machine code. For example, for the web, a Flutter app is compiled into JavaScript. Let’s learn more about the Flutter architecture in order to understand how a Flutter app is compiled into web, or any other platform-specific machine, code. The following figure shows an overview of the Flutter framework’s architecture:

![ 0500 Figure 4.1 – Flutter architecture layers ](/packtpub/taking_flutter_to_the_web_img/0500_figure_4.1_–_flutter_architecture_layers.webp
)
Figure 4.1 – Flutter architecture layers

Flutter is designed as an extensible, layered system. As you can see in Figure 4.1, there are three distinct layers. Firstly, we have the framework, which is written in Dart, then the engine, written in C/C++, and finally, the embedder, which is platform-specific. Each layer of Flutter exists as an independent library that depends on the underlying layer. At the framework level, every part is designed as optional and replaceable. For all the other platforms, the layered architecture displayed in Figure 4.1 is used. However, the web platform is essentially different from other platforms.

For web support, Flutter had to provide a reimplementation for the Flutter Engine on top of standard browser APIs. Currently, there are two options in Flutter for rendering Flutter content on the web. They are HTML and WebGL. To render content in HTML mode, HTML, CSS, Canvas, and SVG are used by Flutter, whereas in WebGL mode, a version of Skia compiled to WebAssembly called CanvasKit is used. We will look at both of these renderers in detail in the next section.

The web version of the architectural layer diagram is displayed in Figure 4.2. The most notable difference is that we don’t require a Dart runtime. Instead, the Flutter framework (along with user code) is compiled to JavaScript. Most developers would never create a line of code that has semantic differences across platforms because Dart has relatively few semantic variations across all of its modes (JIT versus AOT, native versus web compilation):

![ 0501 Figure 4.2 – Flutter web layered architecture ](/packtpub/taking_flutter_to_the_web_img/0501_figure_4.2_–_flutter_web_layered_architecture.webp
)
Figure 4.2 – Flutter web layered architecture

Flutter on the web employs the `dartdevc` compiler during development, which offers incremental compilation and supports hot restart (Hot reload is not currently supported in Flutter <= 3.0). However, Flutter is always evolving, and many improvements are made with each release. So, by the time you are reading this, there might be a lot more updates to the Flutter web version. To learn what’s going on in Flutter on the web, you can visit https://flutter.dev/multi-platform/web. Flutter uses dart2js, Dart’s highly efficient production JavaScript compiler, when you're ready to build your Flutter web application for production. Flutter's core and framework layer (along with your application) are packaged by dart2js into a single minified source file that can be delivered to any web server. If you want, you can set to split the code into multiple files through deferred imports. So, this is how the Flutter Engine compiles Dart code and produces a web application from our Flutter code. Next, we will learn about the different types of web renderers available in Flutter and their advantages and disadvantages.

# Different types of web renderers and their advantages and disadvantages

When running and building apps for the web using Flutter, we can choose between two different renderers. In this section, we will learn what those renderers are and what the advantages and disadvantages of using each of them are.

So, what are renderers? As the name implies, they are used to render our Flutter app on the web. The two renderers that we can use to render our Flutter application on the web are the HTML renderer and the CanvasKit renderer. So, how did these renderers come to be? As we discussed in the previous section, to enable web support, the Flutter team had to rewrite the Flutter Engine on top of browser APIs. The first solution was to use HTML, CSS, and CanvasAPI on the web, which is how the HTML renderer came to be. This was the easier (and first) solution. However, later came another solution: using WebGL. For this, the team brought Skia (the underlying graphic engine that supported Flutter on other platforms to the web) via CanvasKit (https://skia.org/docs/user/modules/canvaskit) and WebAssembly. Unlike the HTML renderer, CanvasKit doesn’t depend on HTML or CSS, making it independent of browser-rendering techniques. This also allowed the Flutter application to have more control over the screen pixels, enabling pixel-perfect rendering on the web.

Let’s look at each of the renderers in detail.

## HTML renderer

Flutter’s HTML renderer uses HTML elements, CSS, Canvas elements, and SVG elements, that is, a combination of these four elements, to render a user interface built using Flutter. This was the first solution devised by the Flutter team to port Flutter to the web. This renderer has a smaller download size and is suitable when prioritizing download size over performance.

The advantages of using the HTML renderer are as follows:

- It has a smaller bundle size than CanvasKit and therefore, the initial load is faster.
- It uses native text rendering, allowing for the use of system fonts in a Flutter application.

Some of its disadvantages are as follows:

- Fidelity issues with text layout
- Less performant than CanvasKit
- Problematic SVG support (SVG is supported on the web natively; however, on other platforms, it requires the `flutter_svg` package, so you need to use the Image widget on the web and the SvgPicture widget on other platforms)

Text layout was one of the biggest issues the Flutter team faced with web support, and it still is an issue. That is why in 
[ Chapter 1 ](/packtpub/taking_flutter_to_the_web/02_c1_getting_started_with_flutter_on_the_web
)
, Getting Started with Flutter on the Web, we suggested that Flutter is not yet suitable for text-heavy websites.

## CanvasKit renderer

As the CanvasKit renderer uses the web port of Skia, this renderer is fully consistent across Flutter mobile and desktop and has the best performance. CanvasKit provides the fastest path to your browser’s graphics stack and offers higher graphical fidelity, but adds about 2 MB in download size.

The advantages are as follows:

- Blazing fast and extremely performant
- Accurate text measurement and layout
- Behaves pretty much the same as Flutter for mobile/desktop (all paint methods are supported and SVGs work as normal)

The disadvantages are as follows:

- Does not use native text rendering. Therefore, custom fonts must be shipped along with it.
- Emoji preloading issues. A custom font for emojis must be preloaded into your app when it is first loaded. The font (Noto Color Emoji) is also quite large (9 MB at the time of writing).
- Larger bundle size. The renderer is about 2 MB larger than the HTML renderer.
- **Cross-Origin Resource Sharing (CORS)** issues.

Both renderers have great advantages. However, their disadvantages are just as great as their advantages. To choose the best renderer for your application, you will have to consider a few things. We will investigate these in the next section.

# Choosing between the HTML and CanvasKit renderers

We should consider our requirements in order to decide between the HTML and CanvasKit renderers. In this section, we will explore our requirements and accordingly choose the renderer. Additionally, we will also look into different options available to set up these renderers.

## Loading time

If your application requires faster initial loading times, especially on mobile, you should go with the HTML renderer. As we discussed in the previous section, the CanvasKit renderer adds an additional 2 MB download size. The default behavior is to select the HTML renderer on mobile, whereas the CanvasKit renderer would be selected on desktops.

## Data usage

Firstly, CanvasKit’s bundle size is larger than HTML’s. Also, if you’re going to use emojis in your app, you won’t want the user to download a large font in addition to your application. So again, if you’re concerned about data consumption, you should go with the HTML renderer.

## Text fidelity

If your app has a lot of text (such as a note-taking or journal app), CanvasKit would be a better option. However, if your app is dealing with a lot of emojis, it might be safer to stick with the HTML renderer for now.

## Performance and uniformity

If you are concerned about high performance, and your application is graphic-centric, or if it relies on canvas APIs available only on CanvasKit, the CanvasKit renderer would be the default choice. For example, if you are building a graphic design tool, then CanvasKit would provide the best output.

Most of the time, however, we may not need the performance CanvasKit offers. On these occasions, it may be worth trading performance for faster loading times and a smaller bundle size.

Now that we know how to decide which renderer to use when, let’s look at what options are available to set the default renderer.

## Command-line options

The Flutter CLI has the `--web-renderer` command-line option, which takes any one of the following values:

- `auto`
- `html`
- `canvaskit`

`auto` is the default option. This option automatically chooses which renderer to use. When the app is running in a mobile browser, it will choose the HTML renderer, whereas the CanvasKit renderer is chosen when the app is running in a desktop browser. `html` will always use the HTML renderer, and `canvaskit` will always use the CanvasKit renderer.

This flag can be used with the `run` or `build` subcommands. Let’s test it with our application. Navigate to the `flutter_academy` project folder in your terminal, and let’s run the application with the following code:

```
flutter run -d chrome –web-renderer html
```

Similarly, you can set the web renderer as CanvasKit while running. You might not notice any difference in an application such as this.

Let’s also see how we can build with different renderers. First, let’s build with the CanvasKit renderer. Use the following command:

```
flutter build web --web-renderer canvaskit
```

You can run and test the app built with the CanvasKit renderer. Similarly, you can change to the HTML renderer and test the application. As we move further through the chapter and add more features to our application, the difference in performance might become more apparent, so we will test our application with different renderers in the upcoming chapters as well.

## Runtime configuration

There is also a runtime configuration, using which you can switch between different renderers at runtime and allow your users to choose the renderer for your application. To override the web renderer at runtime, follow this process:

1. First, build the application with the `auto` option for `–web-renderer`.
1. Then, insert a `\<script>` tag in the `web/index.html` file before the `main.dart.js` script, where you can set `window.flutterWebRenderer` to `“canvaskit”` or `“html”`:

```
  <script type="text/javascript">
    let useHtml = // some code to decide when to use 
                  // HTML and CanvasKit renderer
    if(useHtml) {
      window.flutterWebRenderer = "html";
    } else {
      window.flutterWebRenderer = "canvaskit";
    }
  </script>
  <script src="main.dart.js" 
    type="application/javascript"></script>
```

This must happen before loading `main.dart.js`. Once the Flutter Engine startup process begins in `main.dart.js`, the web renderer can’t be changed.

# Summary

In this chapter, we looked at the architecture of the Flutter framework and learned how Flutter produces multiplatform applications. We looked at how Flutter produces web applications. We also learned about the different renderers available to build and run web apps with Flutter and learned about the advantages and disadvantages of both of those renderer options. Finally, we looked at how we could choose between the two renderers and when to choose which renderer. I hope this information will help you choose the most suitable renderer based on your target user and application requirements. In the next chapter, we will learn about routing and navigation in Flutter on the web.



> [ 05 P2 Flutter Web under the Hood ](/packtpub/taking_flutter_to_the_web/05_p2_flutter_web_under_the_hood) <---> [ 07 C5 Understanding Routes and Navigation ](/packtpub/taking_flutter_to_the_web/07_c5_understanding_routes_and_navigation)
>
> (1) Path: packtpub/taking_flutter_to_the_web/06_c4_flutter_web_under_the_hood
> (2) Markdown
> (3) Title: 06 C4 Flutter Web under the Hood
> (4) Short Description: Publication date: 10월 2022 Publisher Packt Pages 206 ISBN 9781801817714
> (5) tags: flutter web
> Book Name: Taking Flutter to the Web
> Link: https://subscription.packtpub.com/book/web-development/9781801817714/pref/
> create: 2023-01-19 목 14:36:09
> Images: /packtpub/taking_flutter_to_the_web_img/
> .md Name: 06_c4_flutter_web_under_the_hood.md

