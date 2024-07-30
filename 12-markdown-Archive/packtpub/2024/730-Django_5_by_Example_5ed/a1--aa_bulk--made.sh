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
BookTitle="730 Django 5 by Example" #-- (2-2) 시작월일 + 책 제목 -- 730-Django_5_by_Example_5ed
ShortDescription="By Antonio Melé Publication Date: 2024-04-30" #-- (3) 저자등 설명 --
tags="Django" #-- (4) 찾기 위한 태그 --
https_line="https://subscription.packtpub.com/book/web-development/9781805125457/1" #-- (5) 책 링크 --
#-- -------------------------------------------------------------
#-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
#-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#-- -------------------------------------------------------------
# create  mdSeq  mdTitle
md_Create "00" "Preface" #-- 서문
md_Create "01" "Building a Blog Application" #-- 이하 본문
md_Create "02" "Enhancing Your Blog and Adding Social Features"
md_Create "03" "Extending Your Blog Application"
md_Create "04" "Building a Social Website"
md_Create "05" "Implementing Social Authentication"
md_Create "06" "Sharing Content on Your Website"
md_Create "07" "Tracking User Actions"
md_Create "08" "Building an Online Shop"
md_Create "09" "Managing Payments and Orders"
md_Create "10" "Extending Your Shop"
md_Create "11" "Adding Internationalization to Your Shop"
md_Create "12" "Building an E-Learning Platform"
md_Create "13" "Creating a Content Management System"
md_Create "14" "Rendering and Caching Content"
md_Create "15" "Building an API"
md_Create "16" "Building a Chat Server"
md_Create "17" "Going Live"
md_Create "18" "Other Books You May Enjoy"
md_Create "19" "Index"
#-- -------------------------------------------------------------
#-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#--
# create  mdSeq  mdTitle
md_Create "SKIP" "End" #-- 끝줄 표시.
