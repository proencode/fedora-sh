
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

> [ 06 C6 Refactoring Code with Regex and Macros ](/packtpub/mastering_vim/06_c6_refactoring_code_with_regex_and_macros) <---> [ 08 C8 Transcending the Mundane with Vimscript ](/packtpub/mastering_vim/08_c8_transcending_the_mundane_with_vimscript)

# 07 C7 Making Vim Your Own
#----> 본문을 기재하는 위치.



> [ 06 C6 Refactoring Code with Regex and Macros ](/packtpub/mastering_vim/06_c6_refactoring_code_with_regex_and_macros) <---> [ 08 C8 Transcending the Mundane with Vimscript ](/packtpub/mastering_vim/08_c8_transcending_the_mundane_with_vimscript)
>
> (1) Path: packtpub/mastering_vim/07_c7_making_vim_your_own
> (2) Markdown
> (3) Title: 07 C7 Making Vim Your Own
> (4) Short Description: Publication date: 11월 2018 Publisher Packt Pages 330 ISBN 9781789341096
> (5) tags: vim
> Book Name: Mastering Vim
> Link: https://subscription.packtpub.com/book/application-development/9781789341096/pref
> create: 2023-02-01 수 01:05:05
> Images: /packtpub/mastering_vim_img/
> .md Name: 07_c7_making_vim_your_own.md

