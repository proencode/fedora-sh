
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

> [ 00 Preface ](/packtpub/taking_flutter_to_the_web/00_preface) <---> [ 02 C1 Getting Started with Flutter on the Web ](/packtpub/taking_flutter_to_the_web/02_c1_getting_started_with_flutter_on_the_web)

# 01 P1 Basics of Flutter Web

In this part of the book, you will be introduced to the web platform and the importance of learning Flutter web.

This part comprises the following chapters:

- [ Chapter 1 ](/packtpub/taking_flutter_to_the_web/02_c1_getting_started_with_flutter_on_the_web
), Getting Started with Flutter on the Web
- [ Chapter 2 ](/packtpub/taking_flutter_to_the_web/03_c2_creating_your_first_web_app
), Creating Your First Web App
- [ Chapter 3 ](/packtpub/taking_flutter_to_the_web/04_c3_building_responsive_and_adaptive_designs
), Building Responsive and Adaptive Design



> [ 00 Preface ](/packtpub/taking_flutter_to_the_web/00_preface) <---> [ 02 C1 Getting Started with Flutter on the Web ](/packtpub/taking_flutter_to_the_web/02_c1_getting_started_with_flutter_on_the_web)
>
> (1) Path: packtpub/taking_flutter_to_the_web/01_p1_basics_of_flutter_web
> (2) Markdown
> (3) Title: 01 P1 Basics of Flutter Web
> (4) Short Description: Publication date: 10월 2022 Publisher Packt Pages 206 ISBN 9781801817714
> (5) tags: flutter web
> Book Name: Taking Flutter to the Web
> Link: https://subscription.packtpub.com/book/web-development/9781801817714/pref/
> create: 2023-01-19 목 14:36:08
> Images: /packtpub/taking_flutter_to_the_web_img/
> .md Name: 01_p1_basics_of_flutter_web.md
