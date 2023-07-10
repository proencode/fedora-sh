#!/bin/sh

#-- file_Made "01" "P1 JavaScript Syntax"
file_Made () {
	ChapterSeq=$1 #-- 권 번호
	ChapterName=$2 #-- wiki.js 왼쪽에 표시할 챕터 제목
	link_box="$3 <---> $4"

	Jemok="${ChapterSeq} ${ChapterName}"
	small_Jemok=$(echo "${Jemok,,}" | sed 's/ /_/g' | sed 's/\./_/g')
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
#----> 본문을 기재하는 위치.



> ${link_box}
>
> (1) Path: ${small_Publisher}/${small_BookCover}/${small_Jemok}
> (2) Markdown
> (3) Title: ${ChapterSeq} ${ChapterName}
> (4) Short Description: ${ShortDescription}
> (5) tags: ${tags}
> Book Name: ${BookCover}
> Link: ${https_line}
> create: $(date +'%Y-%m-%d %a %H:%M:%S')
> Images: /${small_Publisher}/${small_BookCover}_img/
> .md Name: ${small_Jemok}.md

__EOF__
}

#-- 링크를 만든다.
JemokMade () {
	#-- 다음 페이지가 있으면,
	#-- 현재 페이지를 만들어낸다.
	if [ "x${PrevSeq}" = "xSKIP" ]; then
		PrevLink="$PrevName"
	else
		PrevJemok="${PrevSeq} ${PrevName}"
		small_PrevJemok=$(echo "${PrevJemok,,}" | sed 's/ /_/g' | sed 's/\./_/g')
		PrevLink="[ ${PrevJemok} ](/${small_Publisher}/${small_BookCover}/${small_PrevJemok})"
	fi

	if [ "x${NextSeq}" = "xSKIP" ]; then
		NextLink="$NextName"
	else
		NextJemok="${NextSeq} ${NextName}"
		small_NextJemok=$(echo "${NextJemok,,}" | sed 's/ /_/g' | sed 's/\./_/g')
		NextLink="[ ${NextJemok} ](/${small_Publisher}/${small_BookCover}/${small_NextJemok})"
	fi
}

PrevSeq="" ; PrevName=""
CurrentSeq="" ; CurrentName=""
NextSeq="" ; NextName=""

md_Create () {
	TitleSeq=$1 #-- 권 번호
	TitleName=$2 #-- wiki.js 왼쪽에 표시할 챕터 제목
	if [ "x$NextSeq" = "x" ]; then
		if [ "x$PrevSeq" = "x" ]; then
			#-- 이전 페이지가 없으면, 이전 페이지로 담는다.
			PrevSeq=$TitleSeq ; PrevName=$TitleName
		else
		if [ "x$CurrentSeq" = "x" ]; then
			#-- 현재 페이지가 없으면, 현재 페이지로 담는다.
			CurrentSeq=$TitleSeq ; CurrentName=$TitleName
		else
		# if [ "x$NextSeq" = "x" ]; then
			#-- 다음 페이지가 없으면, 다음 페이지로 담는다.
			NextSeq=$TitleSeq ; NextName=$TitleName
		# fi
		fi
		fi
	else
		#-- 링크를 만든다.
		JemokMade

		if [ "x${NextSeq}" != "xSKIP" ]; then
			file_Made "${CurrentSeq}" "${CurrentName}" "${PrevLink}" "${NextLink}"
		fi

		PrevSeq=$CurrentSeq ; PrevName=$CurrentName
		CurrentSeq=$NextSeq ; CurrentName=$NextName
		NextSeq=$TitleSeq ; NextName=$TitleName

		if [ "x${NextSeq}" = "xSKIP" ]; then
			#-- 링크를 만든다.
			JemokMade

			file_Made "${CurrentSeq}" "${CurrentName}" "${PrevLink}" "${NextLink}"
		fi
	fi
}

figure_title_made () {
	SeqNumber=$1
	FigureNumber=$2
	FigureTitle=$3
	FigureMemo="${SeqNumber}${FigureNumber} ${FigureTitle}"

# 이미지를 "0207.webp" 로 저장하고, .md 문서에 "img0207webp" 로 기록한 경우,
# .md 파일에서 "img0207webp" 를 다음줄과 같이 변경하는 스크립트를 만든다.
	small_FigureMemo=$(echo "${FigureMemo,,}" | sed 's/ /_/g')
figure_title_made "00" "00" "Software covered in the book"
	cat >>edit.sh  <<__EOF__
__EOF__
# 	cat <<__EOF__
# 
# ![ ${FigureMemo} ](/${small_Publisher}/${small_BookCover}_img/${small_FigureMemo}.webp
# )
# ${small_FigureMemo}.webp
# ----> press Enter:
# __EOF__
# 	read a
}

#--
#--

Publisher="packtpub" #-- (1) 출판사 --
small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g' | sed 's/\./_/g')

BookCover="Mastering Vim" #-- (2) 책 제목 --
small_BookCover=$(echo "${BookCover,,}" | sed 's/ /_/g' | sed 's/\./_/g')

ShortDescription="Publication date: 11월 2018 Publisher Packt Pages 330 ISBN 9781789341096" #-- (3) 저자등 설명 --

tags="vim" #-- (4) 찾기 위한 태그 --

https_line="https://subscription.packtpub.com/book/application-development/9781789341096/pref" #-- (5) 출판사 홈체이지 링크 --

mkdir ${small_BookCover}_img/

#-- (6) 권번호와 파트/팹터 별 제목 --
#-- md_Create "권 번호" "wiki.js 왼쪽에 표시할 챕터 제목"
#-- 첫줄에는 "SKIP" "Begin" , 끝줄에는 "SKIP" "End" 로 표시한다.
#
# md_Create "SKIP" "Begin"
# md_Create "SKIP" "End"
#
#-- 본문인 .md 파일은 그 이름을 '00.md' 처럼 '권번호 + .md` 로 저장한다.
#--
md_Create "SKIP" "Begin"
md_Create "00" "Preface"
md_Create "01" "Inkscape Is Ready for Work"
md_Create "02" ""
md_Create "03" ""
md_Create "04" ""
md_Create "05" ""
md_Create "06" ""
md_Create "07" ""
md_Create "08" ""
md_Create "09" ""
md_Create "10" ""
md_Create "11" ""
md_Create "SKIP" "End"
#--

#----------- (3) 권번호, 사진번호, 사진제목 및 설명 중 일부 --
# figure_title_made "02" "00" "Displaying a message in the browser window"
#
# 이미지를 "0207.webp" 로 저장하고, .md 문서에 "img0207webp" 로 기록한 경우,
# .md 파일에서 "img0207webp" 를 다음줄과 같이 변경하는 스크립트를 만든다.
#
# ![ Displaying a message in the browser window ](/packtpub/inkscapeByExample/inkscapeByExample_img/02_07_displaying_a_message_in_the_browser_window.webp)
#
figure_title_made "00" "00" "Software covered in the book"
figure_title_made "01" "00" ""
figure_title_made "02" "00" ""
figure_title_made "03" "00" ""
figure_title_made "04" "00" ""
figure_title_made "05" "00" ""
figure_title_made "06" "00" ""
figure_title_made "07" "00" ""
figure_title_made "08" "00" ""
figure_title_made "09" "00" ""
figure_title_made "10" "00" ""
figure_title_made "11" "00" ""

#--
