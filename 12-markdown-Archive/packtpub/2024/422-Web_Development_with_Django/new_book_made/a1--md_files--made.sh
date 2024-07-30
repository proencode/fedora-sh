#!/bin/sh

#-- file_Made "01" "P1 JavaScript Syntax" #from --> md_Create () {
#-- file_Made "${CurrentSeq}" "${CurrentTitle}" "${PrevLink}" "${NextLink}"
#----> file_Made

file_Made () {
	ChapterSeq=$1 #-- 권 번호
	ChapterTitle=$2 #-- wiki.js 왼쪽에 표시할 챕터 제목
echo "#----> file_Made CurrentSeq ${CurrentSeq}; CurrentTitle ${CurrentTitle}; PrevLink ${PrevLink}; NextLink ${NextLink};"
	if [ "x${PrevLink}" = "xBegin" ]; then
		link_box="| 🏁 ${BookTitle} | ${ChapterSeq} ${ChapterTitle} | $4 ≫ |"
	else
		if [ "x${NextLink}" = "xEnd" ]; then
			link_box="| ≪ $3 | ${ChapterSeq} ${ChapterTitle} | ${BookTitle} 🔔 |"
			#-- End 🔔 | End 🎆 | End 🎇 | End 🌟 |
		else
			link_box="| ≪ $3 | ${ChapterSeq} ${ChapterTitle} | $4 ≫ |"
		fi
	fi

	small_ChapterSeq=$(echo "${ChapterSeq,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
	Jemok="${ChapterSeq} ${ChapterTitle}"
	small_Jemok=$(echo "${Jemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
## 
## @ Q -> # 붙이고 줄 띄우기 => 0i### ^[A^M^[
## @ W -> 현 위치에서 Copy 까지 역따옴표 => j0i\`\`\`^M^[/^Copy$^[ddk0C\`\`\`^M^[
## @ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(\`) 붙이기 => i\`^[/ ^[i\`^[/EEEEEEEEEE^[
## @ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(\`) 붙이기 => i\`^[/\.^[i\`^[/RRRRRRRRRR^[
## @ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(\`) 붙이기 => i\`^[/,^[i\`^[/TTTTTTTTTT^[
## @ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(\`) 붙이기 => i\`^[/;^[i\`^[/YYYYYYYYYY^[
## @ U -> 찾은 글자~닫은괄호앞뒤로 backtick(\`) 붙이기 => i\`^[/)^[i\`^[/UUUUUUUUUU^[
## @ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(\`) 붙이기 => i\`^[/:^[i\`^[/CCCCCCCCCC^[
## 
## @ A -> 빈 줄에 블록 시작하기 => 0C\`\`\`^[^Mk0
## @ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i\`\`\`^M-^[^M0i\`\`\`^[0
## @ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi\`\`\`^M^M^[kk
## @ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
## 
##     마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
##     인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
##     https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
##     blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}
## 
## ---------- cut line ----------
## 
	cat <<__EOF__ | tee "${small_Jemok}.md"

${link_box}
|:----:|:----:|:----:|

# ${ChapterSeq} ${ChapterTitle}
#----> 본문을 기재하는 위치.



${link_box}
|:----:|:----:|:----:|

> (1) Path: ${small_Publisher}/${small_BookLink}/${small_Jemok}
> (2) Markdown
> (3) Title: ${ChapterSeq} ${ChapterTitle}
> (4) Short Description: ${ShortDescription}
> (5) tags: ${tags}
> Book Title: ${BookTitle}
> Link: ${https_line}
> create: $(date +'%Y-%m-%d %a %H:%M:%S')
> Images: /${small_Publisher}/${img_dir}/${small_ChapterSeq}/
> .md Name: ${small_Jemok}.md

__EOF__
}
#-- file_Made "01" "P1 JavaScript Syntax" #from <-- md_Create () {

#-- 링크를 만든다. JemokMade #from --> md_Create () {
JemokMade () {
	#-- 다음 페이지가 있으면,
	#-- 현재 페이지를 만들어낸다.
	if [ "x${PrevSeq}" = "xSKIP" ]; then
		PrevLink="$PrevTitle"
	else
		PrevJemok="${PrevSeq} ${PrevTitle}"
		small_PrevJemok=$(echo "${PrevJemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")

		PrevLink="[ ${PrevJemok} ](/${small_Publisher}/${small_BookLink}/${small_PrevJemok})"
	fi

	if [ "x${NextSeq}" = "xSKIP" ]; then
		NextLink="$NextTitle"
	else
		NextJemok="${NextSeq} ${NextTitle}"
		small_NextJemok=$(echo "${NextJemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
		NextLink="[ ${NextJemok} ](/${small_Publisher}/${small_BookLink}/${small_NextJemok})"
	fi
}
#-- 링크를 만든다. JemokMade #from <-- md_Create () {

PrevSeq="" ; PrevTitle=""
CurrentSeq="" ; CurrentTitle=""
NextSeq="" ; NextTitle=""

#-- md_Create mdSeq  mdTitle
#-- md_Create -$1--  --$2---
#-- md_Create "SKIP" "Begin"

md_Create () {
	mdSeq=$1 #-- 권 번호
	mdTitle=$2 #-- wiki.js 왼쪽에 표시할 챕터 제목
	if [ "x$NextSeq" = "x" ]; then
		if [ "x$PrevSeq" = "x" ]; then
			#-- 이전 페이지가 없으면, 이전 페이지로 담는다.
			PrevSeq=$mdSeq ; PrevTitle=$mdTitle
		else
		if [ "x$CurrentSeq" = "x" ]; then
			#-- 현재 페이지가 없으면, 현재 페이지로 담는다.
			CurrentSeq=$mdSeq ; CurrentTitle=$mdTitle
		else
		# if [ "x$NextSeq" = "x" ]; then
			#-- 다음 페이지가 없으면, 다음 페이지로 담는다.
			NextSeq=$mdSeq ; NextTitle=$mdTitle
		# fi
		fi
		fi
	else
		#-- 링크를 만든다.
		JemokMade

		if [ "x${NextSeq}" != "xSKIP" ]; then
			file_Made "${CurrentSeq}" "${CurrentTitle}" "${PrevLink}" "${NextLink}"
		fi

		PrevSeq=$CurrentSeq ; PrevTitle=$CurrentTitle
		CurrentSeq=$NextSeq ; CurrentTitle=$NextTitle
		NextSeq=$mdSeq ; NextTitle=$mdTitle

		if [ "x${NextSeq}" = "xSKIP" ]; then
			#-- 링크를 만든다.
			JemokMade

			file_Made "${CurrentSeq}" "${CurrentTitle}" "${PrevLink}" "${NextLink}"
		fi
	fi
}

img_dir="img"
if [ ! -d ${img_dir} ]; then
	echo "#-- mkdir -p ${img_dir}"
	mkdir -p ${img_dir}
fi

md_files_dir="md_files"
if [ ! -d ${md_files_dir} ]; then
	echo "#-- mkdir -p ${md_files_dir}"
	mkdir -p ${md_files_dir}
fi
cd ${md_files_dir}

#--
#-- (1-5) 책에 맞추어 수정하는 부분.
#--
Publisher="packtpub" #-- (1) 출판사 --
BookYear="2024" #-- (2-1) 등록년도
BookTitle="422-Web Development with Django 2ed" #-- (2-2) 시작월일 + 책 제목 --
ShortDescription="Publication date: May 2023 Publisher Packt Pages 764" #-- (3) 저자등 설명 --
tags="Django" #-- (4) 찾기 위한 태그 --
https_line="https://subscription.packtpub.com/book/web-development/9781803230603/pref" #-- (5) 출판사 홈페이지 링크 --
#--
small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
BookLink="${BookYear}/${BookTitle}" #-- (2) 호스트의 경로
small_BookLink=$(echo "${BookLink,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")

#--
#-- (6) md_Create "권 번호" "제목"
#-- 첫줄에는 "SKIP" "Begin" , 끝줄에는 "SKIP" "End" 로 표시한다.
#--
# create  mdSeq  mdTitle
md_Create "SKIP" "Begin" #-- 첫줄 표시.
#--
#-- 본문은 권 번호 01 또는 001 부터 시작한다.
#--
# create  mdSeq  mdTitle
md_Create "00.0" "Contents" #-- 목차
md_Create "00.1" "Preface" #-- 서문
md_Create "01" "An Introduction to Django" #-- 이하 본문
md_Create "02" "Models and Migrations"
md_Create "03" "URL Mapping, Views, and Templates"
md_Create "04" "An Introduction to Django Admin"
md_Create "05" "Serving Static Files"
md_Create "06" "Forms"
md_Create "07" "Advanced Form Validation and Model Forms"
md_Create "08" "Media Serving and File Uploads"
md_Create "09" "Sessions and Authentication"
md_Create "10" "Advanced Django Admin and Customizations"
md_Create "11" "Advanced Templating and Class-Based Views"
md_Create "12" "Building a REST API"
md_Create "13" "Generating CSV, PDF, and Other Binary Files"
md_Create "14" "Testing Your Django Applications"
md_Create "15" "Django Third-Party Libraries"
md_Create "16" "Using a Frontend JavaScript Library with Django"
md_Create "17" "Index"
md_Create "18" "Other Books You May Enjoy"
#--
# create  mdSeq  mdTitle
md_Create "SKIP" "End" #-- 끝줄 표시.
