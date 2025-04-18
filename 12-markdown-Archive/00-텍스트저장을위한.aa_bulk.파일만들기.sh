#!/bin/sh

#-- file_Made "01" "P1 JavaScript Syntax" #from --> md_Create () {
#-- file_Made "${CurrentSeq}" "${CurrentChapter}" "${PrevLink}" "${NextLink}"
#----> file_Made

file_Made () {
	ChapterSeq=$1 #-- 권 번호
	ChapterJemok=$2 #-- wiki.js 왼쪽에 표시할 챕터 제목
echo "#----> file_Made CurrentSeq ${CurrentSeq}; CurrentChapter ${CurrentChapter}; PrevLink ${PrevLink}; NextLink ${NextLink};"
	if [ "x${PrevLink}" = "xBegin" ]; then
		link_box="| 🏁 ${TypingMmDd} ${BookJemok} | ${ChapterSeq} ${ChapterJemok} | $4 ≫ |"
	else
		if [ "x${NextLink}" = "xEnd" ]; then
			link_box="| ≪ $3 | ${ChapterSeq} ${ChapterJemok} | ${TypingMmDd} ${BookJemok} 🔔 |"
			#-- End 🔔 | End 🎆 | End 🎇 | End 🌟 |
		else
			link_box="| ≪ $3 | ${ChapterSeq} ${ChapterJemok} | $4 ≫ |"
		fi
	fi

	Jemok="${ChapterSeq} ${ChapterJemok}"
	#-- " ' , / 등의 특수문자는 _ 로 바꾸거나 제거한다.
	#-- 수정전내용 underline_Jemok=$(echo "${Jemok}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/_/g' | sed 's/”/_/g' | sed 's/\"/_/g' | sed "s/’/_/g" | sed "s/,/_/g" | sed "s/'/_/g" | sed "s/\//-/g")
	underline_Jemok=$(echo "${Jemok}" | sed 's/ /_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’//g" | sed "s/,//g" | sed "s/'//g" | sed "s/\//-/g")
	small_Jemok=$(echo "${underline_Jemok,,}")

	cat <<__EOF__ | tee "${small_Jemok}.md"

${link_box}
|:----:|:----:|:----:|

# ${ChapterSeq} ${ChapterJemok}
#----> 본문을 기재하는 위치.



${link_box}
|:----:|:----:|:----:|

> Page Properties:
> (1) Title: ${ChapterSeq} ${ChapterJemok}
> (2) Short Description: ${TypingJemok}
> (3) Path: ${book_path}/${underline_Jemok}
> Book Jemok: ${BookJemok}
> AuthorDate: ${AuthorDate}
> Link: ${https_line}
> create: $(date +'%Y-%m-%d %a %H:%M:%S')
> .md Name: ${small_Jemok}.md

__EOF__

}
#-- file_Made "01" "P1 JavaScript Syntax" #from <-- md_Create () {

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

#-- 링크를 만든다. JemokMade #from --> md_Create () {
JemokMade () {
	#-- 다음 페이지가 있으면,
	#-- 현재 페이지를 만들어낸다.
	if [ "x${PrevSeq}" = "xSKIP" ]; then
		PrevLink="$PrevChapter"
	else
		PrevJemok="${PrevSeq} ${PrevChapter}"
		#-- 이전 제목에 " ' , / 등의 특수문자는 _ 또는 제거한다.
		#-- 수정전내용 underline_PrevJemok=$(echo "${PrevJemok}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/_/g' | sed 's/”/_/g' | sed 's/\"/_/g' | sed "s/’/_/g" | sed "s/,//g" | sed "s/'/_/g" | sed "s/\//-/g")
		underline_PrevJemok=$(echo "${PrevJemok}" | sed 's/ /_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’//g" | sed "s/,//g" | sed "s/'//g" | sed "s/\//-/g")
		PrevLink="[ ${PrevJemok} ](/${book_path}/${underline_PrevJemok})"
	fi

	if [ "x${NextSeq}" = "xSKIP" ]; then
		NextLink="$NextChapter"
	else
		NextJemok="${NextSeq} ${NextChapter}"
		#-- 다음 제목에 " ' , / 등의 특수문자는 _ 또는 제거한다.
		#-- 수정전내용 underline_NextJemok=$(echo "${NextJemok}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/_/g' | sed 's/”/_/g' | sed 's/\"/_/g' | sed "s/’/_/g" | sed "s/,//g" | sed "s/'/_/g" | sed "s/\//-/g")
		underline_NextJemok=$(echo "${NextJemok}" | sed 's/ /_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’//g" | sed "s/,//g" | sed "s/'//g" | sed "s/\//-/g")
		NextLink="[ ${NextJemok} ](/${book_path}/${underline_NextJemok})"
	fi
}
#-- 링크를 만든다. JemokMade #from <-- md_Create () {

PrevSeq="" ; PrevChapter=""
CurrentSeq="" ; CurrentChapter=""
NextSeq="" ; NextChapter=""

#-- md_Create mdSeq  mdChapter
#-- md_Create -$1--  --$2---
#-- md_Create "SKIP" "Begin"

md_Create () {
	mdSeq=$1 #-- 권 번호
	mdChapter=$2 #-- wiki.js 왼쪽에 표시할 챕터 제목
	if [ "x$NextSeq" = "x" ]; then
		if [ "x$PrevSeq" = "x" ]; then
			#-- 이전 페이지가 없으면, 이전 페이지로 담는다.
			PrevSeq=$mdSeq ; PrevChapter=$mdChapter
		else
		if [ "x$CurrentSeq" = "x" ]; then
			#-- 현재 페이지가 없으면, 현재 페이지로 담는다.
			CurrentSeq=$mdSeq ; CurrentChapter=$mdChapter
		else
		# if [ "x$NextSeq" = "x" ]; then
			#-- 다음 페이지가 없으면, 다음 페이지로 담는다.
			NextSeq=$mdSeq ; NextChapter=$mdChapter
		# fi
		fi
		fi
	else
		#-- 링크를 만든다.
		JemokMade

		if [ "x${NextSeq}" != "xSKIP" ]; then
			file_Made "${CurrentSeq}" "${CurrentChapter}" "${PrevLink}" "${NextLink}"
		fi

		PrevSeq=$CurrentSeq ; PrevChapter=$CurrentChapter
		CurrentSeq=$NextSeq ; CurrentChapter=$NextChapter
		NextSeq=$mdSeq ; NextChapter=$mdChapter

		if [ "x${NextSeq}" = "xSKIP" ]; then
			#-- 링크를 만든다.
			JemokMade

			file_Made "${CurrentSeq}" "${CurrentChapter}" "${PrevLink}" "${NextLink}"
		fi
	fi
}

aa_bulk_OK_dir="aa_bulk_OK_dir"
aa_bulk_TEMP_dir="aa_bulk_TEMP_dir"
if [ ! -d ${aa_bulk_TEMP_dir} ]; then
	echo "#-- mkdir -p ${aa_bulk_TEMP_dir}"
	mkdir -p ${aa_bulk_TEMP_dir}
fi

#--
#-- (1-5) 책에 맞추어 수정하는 부분.
#-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#-- -------------------------------------------------------------
Publisher="packtpub" #-- (1) 출판사 --
BookJemok="Full Stack Development with Spring Boot 3 and React 4Ed" #-- 책 이름
TypingYear="2024" #-- 입력년도
TypingMmDd="1202" #-- 입력월일
TypingJemok="Spring Boot 3 React" #-- 짧은 제목
AuthorDate="Juha Hinkula / Oct 2023 / 454 pages 4Ed" #-- 저자등 설명
https_line="https://subscription.packtpub.com/book/web-development/9781805122463/pref" #-- 책 링크
#-- img_dir="img-${Publisher}_${TypingYear}_${TypingMmDd}" #-- 이미지 저장 폴더
#-- if [ ! -d ${img_dir} ]; then
#-- 	echo "#-- mkdir -p ${img_dir}"
#-- 	mkdir -p ${img_dir}
#-- fi
cd ${aa_bulk_TEMP_dir}
#-- -------------------------------------------------------------
#-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#--
#-- " ' , / 등의 특수문자는 _ 또는 제거한다. , 는 삭제함.
#-- 수정전내용 mmdd_jemok=$(echo "${TypingMmDd}-${TypingJemok}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/_/g' | sed 's/”/_/g' | sed 's/\"/_/g' | sed "s/’/_/g" | sed "s/,/_/g" | sed "s/'/_/g" | sed "s/\//-/g")
mmdd_jemok=$(echo "${TypingMmDd}-${TypingJemok}" | sed 's/ /_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’//g" | sed "s/,//g" | sed "s/'//g" | sed "s/\//-/g")
book_path="books/${Publisher}/${TypingYear}/${mmdd_jemok}"
#--
#-- (6) md_Create "권 번호" "제목"
#-- 첫줄에는 "SKIP" "Begin" , 끝줄에는 "SKIP" "End" 로 표시한다.
#--
# create  mdSeq  mdChapter
md_Create "SKIP" "Begin" #-- 첫줄 표시.
#--
#-- 본문은 권 번호 01 또는 001 부터 시작한다.
#-- 타이틀에 " ' , / 등의 특수문자는 위 로직에서 바꿀 것이므로 그대로 둬도 된다.
#--
#-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#-- -------------------------------------------------------------
# create  mdSeq  mdChapter
md_Create "000" "Preface" #-- 서문

part="Part 1: Backend Programming with Spring Boot"
md_Create "101" "Setting Up the Environment and Tools"
md_Create "102" "Understanding Dependency Injection"
md_Create "103" "Using JPA to Create and Access a Database"
md_Create "104" "Creating a RESTful Web Service with Spring Boot"
md_Create "105" "Securing Your Backend"
md_Create "106" "Testing Your Backend"

part="Part 2: Frontend Programming with React"
md_Create "207" "Setting Up the Environment and Tools"
md_Create "208" "Getting Started with React"
md_Create "209" "Introduction to TypeScript"
md_Create "210" "Consuming the REST API with React"
md_Create "211" "Useful Third-Party Components for React"

part="Part 3: Full Stack Development"
md_Create "312" "Setting Up the Frontend"
md_Create "313" "Adding CRUD Functionalities"
md_Create "314" "Styling the Frontend with MUI"
md_Create "315" "Testing Your Frontend"
md_Create "316" "Securing Your Application"
md_Create "317" "Deploying Your Application"
md_Create "400" "Other Books You May Enjoy"
md_Create "401" "Index"
#-- -------------------------------------------------------------
#-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#--
# create  mdSeq  mdChapter
md_Create "SKIP" "End" #-- 끝줄 표시.

cd ..
mv ${aa_bulk_TEMP_dir} ${aa_bulk_OK_dir}
