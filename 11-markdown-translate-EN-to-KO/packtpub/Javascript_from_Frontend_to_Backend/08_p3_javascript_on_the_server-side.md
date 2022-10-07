
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

> [ 07 C5 Managing a List with Vue.js ](/packtpub/javascript_from_frontend_to_backend/07_c5_managing_a_list_with_vue.js) <---> [ 09 C6 Creating and Using Node.js Modules ](/packtpub/javascript_from_frontend_to_backend/09_c6_creating_and_using_node.js_modules)

# Part 3: JavaScript on the Server-Side

This part is about using JavaScript in a Node.js server. It explains the use of modules such as Express (to quickly create a Node. js-based web application using the MVC pattern) and the MongoDB database.

We end our study by building an application on a single page (this principle is called Single Page Application) which is written with Vue.js on the client-side, and with Node.js, Express and MongoDB on the server-side. The purpose of this book is to enable you to know how to make this type of application.

This section comprises the following chapters:

Chapter 6, Creating and Using Node.js Modules
Chapter 7, Using Express with Node.js
Chapter 8, Using MongoDB with Node.js
Chapter 9, Integrating Vue.js with Node.js



> [ 07 C5 Managing a List with Vue.js ](/packtpub/javascript_from_frontend_to_backend/07_c5_managing_a_list_with_vue.js) <---> [ 09 C6 Creating and Using Node.js Modules ](/packtpub/javascript_from_frontend_to_backend/09_c6_creating_and_using_node.js_modules)
>
> Title: 08 P3 JavaScript on the Server-Side
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/08_p3_javascript_on_the_server-side
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 13:20:55
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 08_p3_javascript_on_the_server-side.md

