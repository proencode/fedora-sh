
@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i\`\`\`^M^[/^Copy$^[ddk0C\`\`\`^M^[
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(\`) 붙이기 => i\`^[/ ^[i\`^[/EEEEEEEEEE^[
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(\`) 붙이기 => i\`^[/.^[i\`^[/RRRRRRRRRR^[
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(\`) 붙이기 => i\`^[/,^[i\`^[/TTTTTTTTTT^[
@ Y -> 찾은 글자 ~ COLON 앞뒤로 backtick(\`) 붙이기 => i\`^[/;^[i\`^[/YYYYYYYYYY^[
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(\`) 붙이기 => i\`^[/)^[i\`^[/UUUUUUUUUU^[

@ A -> 빈 줄에 블록 시작하기 => 0C\`\`\`^[^Mk0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i\`\`\`^M-^[^M0i\`\`\`^[0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi\`\`\`^M^M^[kk
@ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
    마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

> [ 00 Preface ](/packtpub/javascript_from_frontend_to_backend/00_preface) <---> [ 02 C1 Exploring the Core Concepts of JavaScript ](/packtpub/javascript_from_frontend_to_backend/02_c1_exploring_the_core_concepts_of_javascript)

# Part 1: JavaScript Syntax

This part explains the basics you need to know to use JavaScript on the client or on the server. It explains the syntax and the main data types that can be used in JavaScript.

This section comprises the following chapters:

[ Chapter 1 ](/packtpub/javascript_from_frontend_to_backend/02_c1_exploring_the_core_concepts_of_javascript), Exploring the Core Concepts of JavaScript
[ Chapter 2 ](/packtpub/javascript_from_frontend_to_backend/03_c2_exploring_the_advanced_concepts_of_javascript), Exploring the Advanced Concepts of JavaScript



> [ 00 Preface ](/packtpub/javascript_from_frontend_to_backend/00_preface) <---> [ 02 C1 Exploring the Core Concepts of JavaScript ](/packtpub/javascript_from_frontend_to_backend/02_c1_exploring_the_core_concepts_of_javascript)
>
> Title: 01 P1 JavaScript Syntax
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/01_p1_javascript_syntax
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-04 화 15:11:07
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 01_p1_javascript_syntax.md

