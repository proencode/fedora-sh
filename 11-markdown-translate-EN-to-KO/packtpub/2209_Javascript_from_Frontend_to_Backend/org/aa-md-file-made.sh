#!/bin/sh
#
Publisher="packtpub" #-- (1) 출판사
BookCover="JavaScript from Frontend to Backend" #-- (2) 책 제목
ShortDescription="Publication date: 7월 2022 Publisher: Packt Pages: 336 ISBN: 9781801070317" #-- (3) 저자등 설명
tags="vue.js node.js" #-- (4) 찾기 위한 태그
https_line="https://subscription.packtpub.com/book/web-development/9781801070317/4" #-- (5) 출판사 홈체이지 링크

small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g')
small_BookCover=$(echo "${BookCover,,}" | sed 's/ /_/g')

#-- file_Made "01" "P1 JavaScript Syntax"
file_Made () {
	ChapterSeq=$1 #-- 권 번호
	ChapterName=$2 #-- wiki.js 왼쪽에 표시할 챕터 제목
	link_box="$3 <---> $4"

	Jemok="${ChapterSeq} ${ChapterName}"
	small_Jemok=$(echo "${Jemok,,}" | sed 's/ /_/g')

	cat <<__EOF__ | tee "${small_Jemok}.md"

@ Q -> # 붙이고 줄 띄우기 => 0i### ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i\`\`\`^M^[/^Copy$^[ddk0C\`\`\`^M^[
@ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(\`) 붙이기 => i\`^[/ ^[i\`^[/EEEEEEEEEE^[
@ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(\`) 붙이기 => i\`^[/\.^[i\`^[/RRRRRRRRRR^[
@ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(\`) 붙이기 => i\`^[/,^[i\`^[/TTTTTTTTTT^[
@ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(\`) 붙이기 => i\`^[/;^[i\`^[/YYYYYYYYYY^[
@ U -> 찾은 글자~닫은괄호앞뒤로 backtick(\`) 붙이기 => i\`^[/)^[i\`^[/UUUUUUUUUU^[
@ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(\`) 붙이기 => i\`^[/:^[i\`^[/CCCCCCCCCC^[

@ A -> 빈 줄에 블록 시작하기 => 0C\`\`\`^[^Mk0
@ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i\`\`\`^M-^[^M0i\`\`\`^[0
@ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi\`\`\`^M^M^[kk
@ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
    마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

> ${link_box}

# ${ChapterSeq} ${ChapterName}




> ${link_box}
>
> Title: ${ChapterSeq} ${ChapterName}
> Short Description: ${ShortDescription}
> Path: ${small_Publisher}/${small_BookCover}/${small_Jemok}
> tags: ${tags}
> Book Name: ${BookCover}
> Link: ${https_line}
> create: $(date +'%Y-%m-%d %a %H:%M:%S')
> Images: /${small_Publisher}/${small_BookCover}_img/
> .md Name: ${small_Jemok}.md

__EOF__
}

#--
#-- file_Made "00 부터 매기는 권번호" "보여주기 위한 제목" \
#--	"이전 페이지 링크 또는 Begin" \
#--	"이후 페이지 링크 또는 End"
# file_Made "00" "Preface" \
#	"Begin" \
#	"[ 01 P1 JavaScript Syntax ](/packtpub/javascript_from_frontend_to_backend/01_p1_javascript_syntax)"
# file_Made "01" "P1 JavaScript Syntax" \
#	"[ 00 Preface ](/packtpub/javascript_from_frontend_to_backend/00_preface)" \
#	"[ 02 C1 Exploring the Core Concepts of JavaScript ](/packtpub/javascript_from_frontend_to_backend/02_c1_exploring_the_core_concepts_of_javascript)"
# file_Made "02" "C1 Exploring the Core Concepts of JavaScript" \
#	"[ 01 P1 JavaScript Syntax ](/packtpub/javascript_from_frontend_to_backend/01_p1_javascript_syntax)" \
#	"[ 03 C2 Exploring the Advanced Concepts of JavaScript ](/packtpub/javascript_from_frontend_to_backend/03_c2_exploring_the_advanced_concepts_of_javascript)"
# file_Made "03" "C2 Exploring the Advanced Concepts of JavaScript" \
#	"[ 02 C1 Exploring the Core Concepts of JavaScript ](/packtpub/javascript_from_frontend_to_backend/02_c1_exploring_the_core_concepts_of_javascript)" \
#	"[ 04 P2 JavaScript on the Client-Side ](/packtpub/javascript_from_frontend_to_backend/04_p2_javascript_on_the_client-side)"
#file_Made "04" "P2 JavaScript on the Client-Side" \
#	"[ 03 C2 Exploring the Advanced Concepts of JavaScript ](/packtpub/javascript_from_frontend_to_backend/03_c2_exploring_the_advanced_concepts_of_javascript)" \
#	"[ 05 C3 Getting Started with Vue.js ](/packtpub/javascript_from_frontend_to_backend/05_c3_getting_started_with_vue.js)"
file_Made "05" "C3 Getting Started with Vue.js" \
	"[ 04 P2 JavaScript on the Client-Side ](/packtpub/javascript_from_frontend_to_backend/04_p2_javascript_on_the_client-side)" \
	"[ 06 C4 Advanced Concepts of Vue.js ](/packtpub/javascript_from_frontend_to_backend/06_c4_advanced_concepts_of_vue.js)"
file_Made "06" "C4 Advanced Concepts of Vue.js" \
	"[ 05 C3 Getting Started with Vue.js ](/packtpub/javascript_from_frontend_to_backend/05_c3_getting_started_with_vue.js)" \
	"[ 07 C5 Managing a List with Vue.js ](/packtpub/javascript_from_frontend_to_backend/07_c5_managing_a_list_with_vue.js)"
file_Made "07" "C5 Managing a List with Vue.js" \
	"[ 06 C4 Advanced Concepts of Vue.js ](/packtpub/javascript_from_frontend_to_backend/06_c4_advanced_concepts_of_vue.js)" \
	"[ 08 P3 JavaScript on the Server-Side ](/packtpub/javascript_from_frontend_to_backend/08_p3_javascript_on_the_server-side)"
file_Made "08" "P3 JavaScript on the Server-Side" \
	"[ 07 C5 Managing a List with Vue.js ](/packtpub/javascript_from_frontend_to_backend/07_c5_managing_a_list_with_vue.js)" \
	"[ 09 C6 Creating and Using Node.js Modules ](/packtpub/javascript_from_frontend_to_backend/09_c6_creating_and_using_node.js_modules)"
file_Made "09" "C6 Creating and Using Node.js Modules" \
	"[ 08 P3 JavaScript on the Server-Side ](/packtpub/javascript_from_frontend_to_backend/08_p3_javascript_on_the_server-side)" \
	"[ 10 C7 Using Express with Node.js ](/packtpub/javascript_from_frontend_to_backend/10_c7_using_express_with_node.js)"
file_Made "10" "C7 Using Express with Node.js" \
	"[ 09 C6 Creating and Using Node.js Modules ](/packtpub/javascript_from_frontend_to_backend/09_c6_creating_and_using_node.js_modules)" \
	"[ 11 C8 Using MongoDB with Node.js ](/packtpub/javascript_from_frontend_to_backend/11_c8_using_mongodb_with_node.js)"
file_Made "11" "C8 Using MongoDB with Node.js" \
	"[ 10 C7 Using Express with Node.js ](/packtpub/javascript_from_frontend_to_backend/10_c7_using_express_with_node.js)" \
	"[ 12 C9 Integrating Vue.js with Node.js ](/packtpub/javascript_from_frontend_to_backend/12_c9_integrating_vue.js_with_node.js)"
file_Made "12" "C9 Integrating Vue.js with Node.js" \
	"[ 11 C8 Using MongoDB with Node.js ](/packtpub/javascript_from_frontend_to_backend/11_c8_using_mongodb_with_node.js)" \
	"[ 13 C10 Other Books You May Enjoy ](/packtpub/javascript_from_frontend_to_backend/13_p4_other_books_you_may_enjoy)"
file_Made "13" "P4 Other Books You May Enjoy" \
	"[ 12 C9 Integrating Vue.js with Node.js ](/packtpub/javascript_from_frontend_to_backend/12_c9_integrating_vue.js_with_node.js)" \
	"End"
#--
