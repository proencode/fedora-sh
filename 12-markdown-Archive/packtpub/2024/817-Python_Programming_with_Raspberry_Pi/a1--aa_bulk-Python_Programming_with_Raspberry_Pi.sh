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

	Jemok="${ChapterSeq} ${ChapterTitle}"
	#-- 제목에 " ' , / 등의 특수문자는 _ 또는 제거한다.
	underline_Jemok=$(echo "${Jemok}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/_/g' | sed 's/”/_/g' | sed 's/\"/_/g' | sed "s/’/_/g" | sed "s/,/_/g" | sed "s/'/_/g" | sed "s/\//-/g")
	small_Jemok=$(echo "${underline_Jemok,,}")
## 
## https://coldmater.tistory.com/226
## Vim 에서 매크로 등록하고 실행하기
## 1. `q{레지스터}` 로 매크로 기록 시작 (레지스터는 알파벳(a-z) 또는 숫자(0-9)를 지정한다)
## 하단 상태표시줄에 q 가 표시되고, 레지스터 (a-z, 0-9 중 하나) 를 정해서 입력하면
## 상태표시줄에 'Recording @a'(레지스터로 'a'를 입력했다고 가정) 와 같이
## 실제 명령어를 대기하고 있는 상태가 된다.
## 2. `q` 로 매크로 기록 종료
## 3. `@{레지스터}` 로 저장된 매크로 실행
## 4. `@@` 로 직전에 실행한 매크로 재실행
## 5. `반복횟수}@{레지스터}` 또는 `{반복횟수}@@` 로 저장된 매크로를 '반복횟수' 만큼 재실행
## 또는,
## 6. 아래와 같이 타이핑할 매크로 를 입력해 놓고,
## 해당 줄 위에서, `"ayy` (따옴표 + 레지스터 + yy) 로 레지스터에 저장할수 있다.
##
## @ Q -> # 붙이고 줄 띄우기 => 0i### ^[A^M^[
## @ W -> 현 위치에서 Copy 까지 역따옴표 => j0i\`\`\`^M^[/^Copy$^[ddk0C\`\`\`^M^[
## @ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(\`) 붙이기 => i\`^[/ ^[i\`^[/EEEEEaEEEEE^[
## @ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(\`) 붙이기 => i\`^[/\.^[i\`^[/RRRRRaRRRRR^[
## @ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(\`) 붙이기 => i\`^[/,^[i\`^[/TTTTTaTTTTT^[
## @ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(\`) 붙이기 => i\`^[/;^[i\`^[/YYYYYaYYYYY^[
## @ U -> 찾은 글자~닫은괄호앞뒤로 backtick(\`) 붙이기 => i\`^[/)^[i\`^[/UUUUUaUUUUU^[
## @ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(\`) 붙이기 => i\`^[/:^[i\`^[/IIIIIaIIIII^[
## @ O -> 찾은 글자 ~   }   앞뒤로 backtick(\`) 붙이기 => i\`^[/:^[i\`^[/OOOOOaOOOOO^[
## 
## @ A -> 빈 줄에 블록 시작하기 => 0C\`\`\`^[^Mk0
## @ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i\`\`\`^M-^[^M0i\`\`\`^[0
## @ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi\`\`\`^M^M^[kk
## @ F -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[
## @ Z -> 현 위치에서 Explain 까지 역따옴표 => j0i```^M^[/^Explain$^[3k3dd0C```^M^[
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

> Page Properties:
> (1) Title: ${ChapterSeq} ${ChapterTitle}
> (2) Short Description: ${ShortDescription}
> (3) Path: ${underline_Publisher}/${underline_BookLink}/${underline_Jemok}
> Book Title: ${BookName}
> AuthorDate: ${AuthorDate}
> tags: ${tags}
> Link: ${https_line}
> create: $(date +'%Y-%m-%d %a %H:%M:%S')
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
		#-- 이전 제목에 " ' , / 등의 특수문자는 _ 또는 제거한다.
		underline_PrevJemok=$(echo "${PrevJemok}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/_/g' | sed 's/”/_/g' | sed 's/\"/_/g' | sed "s/’/_/g" | sed "s/,/_/g" | sed "s/'/_/g" | sed "s/\//-/g")
		small_PrevJemok=$(echo "${underline_PrevJemok,,}")

		PrevLink="[ ${PrevJemok} ](/${underline_Publisher}/${underline_BookLink}/${underline_PrevJemok})"
	fi

	if [ "x${NextSeq}" = "xSKIP" ]; then
		NextLink="$NextTitle"
	else
		NextJemok="${NextSeq} ${NextTitle}"
		#-- 다음 제목에 " ' , / 등의 특수문자는 _ 또는 제거한다.
		underline_NextJemok=$(echo "${NextJemok}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/_/g' | sed 's/”/_/g' | sed 's/\"/_/g' | sed "s/’/_/g" | sed "s/,/_/g" | sed "s/'/_/g" | sed "s/\//-/g")
		small_NextJemok=$(echo "${NextJemok,,}")
		NextLink="[ ${NextJemok} ](/${underline_Publisher}/${underline_BookLink}/${underline_NextJemok})"
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

aa_bulk_dir="aa_bulk"
if [ ! -d ${aa_bulk_dir} ]; then
	echo "#-- mkdir -p ${aa_bulk_dir}"
	mkdir -p ${aa_bulk_dir}
fi
cd ${aa_bulk_dir}

#--
#-- (1-5) 책에 맞추어 수정하는 부분.
#-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#-- -------------------------------------------------------------
Publisher="packtpub" #-- (1) 출판사 --
BookYear="2024" #-- (2-1) 등록년도
BookName="Python Programming with Raspberry Pi - 1th Ed" #-- 책 이름
ShortDescription="Python with RaspPi 1ed" #-- 짧은 설명
BookTitle="817 Python Programming with Raspberry Pi 1ed" #-- (2-2) 시작월일 + 책 제목 -- 730-Django_5_by_Example_5ed
AuthorDate="By Antonio Melé Publication Date: Apr 2017 312 pages 1Ed" #-- (3) 저자등 설명 --
tags="Python RaspPi" #-- (4) 찾기 위한 태그 --
https_line="https://subscription.packtpub.com/book/iot-and-hardware/9781786467577/1" #-- (5) 책 링크 --
#-- -------------------------------------------------------------
#-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#--
#-- 출판사에 " ' , / 등의 특수문자는 _ 또는 제거한다.
underline_Publisher=$(echo "${Publisher}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/_/g' | sed 's/”/_/g' | sed 's/\"/_/g' | sed "s/’/_/g" | sed "s/,/_/g" | sed "s/'/_/g" | sed "s/\//-/g")
small_Publisher=$(echo "${underline_Publisher,,}")
BookLink="${BookYear}/${BookTitle}" #-- (2) 호스트의 경로
#-- 책제목에 " ' , / 등의 특수문자는 _ 또는 제거한다.
underline_BookLink=$(echo "${BookLink}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/_/g' | sed 's/”/_/g' | sed 's/\"/_/g' | sed "s/’/_/g" | sed "s/,/_/g" | sed "s/'/_/g") #xxx  | sed "s/\//-/g")
small_BookLink=$(echo "${underline_BookLink,,}")

#--
#-- (6) md_Create "권 번호" "제목"
#-- 첫줄에는 "SKIP" "Begin" , 끝줄에는 "SKIP" "End" 로 표시한다.
#--
# create  mdSeq  mdTitle
md_Create "SKIP" "Begin" #-- 첫줄 표시.
#--
#-- 본문은 권 번호 01 또는 001 부터 시작한다.
#-- 타이틀에 " ' , / 등의 특수문자는 위 로직에서 바꿀 것이므로 그대로 둬도 된다.
#--
#-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#-- -------------------------------------------------------------
# create  mdSeq  mdTitle
md_Create "00" "Preface" #-- 서문
md_Create "01" "Getting Started with Python and the Raspberry Pi Zero" #-- 이하 본문
md_Create "02" "Arithmetic Operations, Loops, and Blinky Lights"
md_Create "03" "Conditional Statements, Functions, and Lists"
md_Create "04" "Communication Interfaces"
md_Create "05" "Data Types and Object-Oriented Programming in Python"
md_Create "06" "File I/O and Python Utilities"
md_Create "07" "Requests and Web Frameworks"
md_Create "08" "Awesome Things You Could Develop Using Python"
md_Create "09" "Let's Build a Robot"
md_Create "10" "Home Automation Using The Raspberry Pi Zero"
md_Create "11" "Tips and Tricks"
#-- -------------------------------------------------------------
#-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#--
# create  mdSeq  mdTitle
md_Create "SKIP" "End" #-- 끝줄 표시.
