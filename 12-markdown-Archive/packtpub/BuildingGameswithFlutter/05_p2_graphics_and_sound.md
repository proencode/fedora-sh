
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

> [ 04 C3 Building a Game Design ](/packtpub/javascript_from_frontend_to_backend/04_c3_building_a_game_design) <---> [ 06 C4 Drawing and Animating Graphics ](/packtpub/javascript_from_frontend_to_backend/06_c4_drawing_and_animating_graphics)

# Part 2: Graphics and Sound

In this part of the book, we will demonstrate how to use the media capabilities of the Flame library to animate graphics and play sound. We will also discuss how to animate the graphics based on input received from the player. Finally, we will discuss level design and how to scale your game across multiple platforms.

This part contains the following chapters:

Chapter 4, Drawing and Animating Graphics
Chapter 5, Moving the Graphics with Input
Chapter 6, Playing Sound Effects and Music
Chapter 7, Designing Your Own Levels
Chapter 8, Scaling the Game for Web and Desktop



> [ 04 C3 Building a Game Design ](/packtpub/javascript_from_frontend_to_backend/04_c3_building_a_game_design) <---> [ 06 C4 Drawing and Animating Graphics ](/packtpub/javascript_from_frontend_to_backend/06_c4_drawing_and_animating_graphics)
>
> Title: 05 P2 Graphics and Sound
> Short Description: Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317
> Path: packtpub/javascript_from_frontend_to_backend/05_p2_graphics_and_sound
> tags: vue.js node.js
> Book Name: JavaScript from Frontend to Backend
> Link: https://subscription.packtpub.com/book/web-development/9781801070317/4
> create: 2022-10-07 금 15:56:31
> Images: /packtpub/javascript_from_frontend_to_backend_img/
> .md Name: 05_p2_graphics_and_sound.md

