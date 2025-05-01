
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

| ≪ [ 03 URL Mapping, Views, and Templates ](/packtpub/2024/422_web_development_with_django_2ed/03_url_mapping,_views,_and_templates) | 04 An Introduction to Django Admin | [ 05 Serving Static Files ](/packtpub/2024/422_web_development_with_django_2ed/05_serving_static_files) ≫ |
|:----:|:----:|:----:|

# 04 An Introduction to Django Admin
#----> 본문을 기재하는 위치.



| ≪ [ 03 URL Mapping, Views, and Templates ](/packtpub/2024/422_web_development_with_django_2ed/03_url_mapping,_views,_and_templates) | 04 An Introduction to Django Admin | [ 05 Serving Static Files ](/packtpub/2024/422_web_development_with_django_2ed/05_serving_static_files) ≫ |
|:----:|:----:|:----:|

> (1) Path: packtpub/2024/422_web_development_with_django_2ed/04_an_introduction_to_django_admin
> (2) Markdown
> (3) Title: 04 An Introduction to Django Admin
> (4) Short Description: Publication date: May 2023 Publisher Packt Pages 764
> (5) tags: Django
> Book Name: 422 Web Development with Django 2ed
> Link: https://subscription.packtpub.com/book/web-development/9781803230603/pref
> create: 2024-04-23 화 17:16:18
> Images: /packtpub/2024/422_web_development_with_django_2ed_img/
> .md Name: 04_an_introduction_to_django_admin.md

