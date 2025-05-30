#!/bin/sh

#-- file_Made "01" "P1 JavaScript Syntax" #from --> md_Create () {
#-- file_Made "${CurrentSeq}" "${CurrentName}" "${PrevLink}" "${NextLink}"
#----> file_Made

file_Made () {
	ChapterSeq=$1 #-- 권 번호
	ChapterName=$2 #-- wiki.js 왼쪽에 표시할 챕터 제목
echo "#----> file_Made CurrentSeq ${CurrentSeq}; CurrentName ${CurrentName}; PrevLink ${PrevLink}; NextLink ${NextLink};"
	if [ "x${PrevLink}" = "xBegin" ]; then
		link_box="| 🏁 ${BookTitle} | ${ChapterSeq} ${ChapterName} | $4 ≫ |"
	else
		if [ "x${NextLink}" = "xEnd" ]; then
			link_box="| ≪ $3 | ${ChapterSeq} ${ChapterName} | ${BookTitle} 🔔 |"
			#-- End 🔔 | End 🎆 | End 🎇 | End 🌟 |
		else
			link_box="| ≪ $3 | ${ChapterSeq} ${ChapterName} | $4 ≫ |"
		fi
	fi

	Jemok="${ChapterSeq}-${ChapterName}"
	small_Jemok=$(echo "${Jemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
	cat <<__EOF__ | tee "${small_Jemok}.md"

--------> @ Q -> # 붙이고 줄 띄우기 
--------> @ W -> 현 위치에서 Explain 까지 역따옴표 
--------> @ E -> 찾은 글자 ~ SPACE 앞뒤로 backtick(\`) 붙이기 
--------> @ R -> 찾은 글자 ~ POINT 앞뒤로 backtick(\`) 붙이기 
--------> @ T -> 찾은 글자 ~ COMMA 앞뒤로 backtick(\`) 붙이기 
--------> @ Y -> 찾은 글자 ~   ;   앞뒤로 backtick(\`) 붙이기 
--------> @ U -> 찾은 글자~닫은괄호앞뒤로 backtick(\`) 붙이기 
--------> @ I -> 찾은 글자 ~ COLON 앞뒤로 backtick(\`) 붙이기 
--------> @ O -> 찾은 글자 ~   }   앞뒤로 backtick(\`) 붙이기 
++++++++> @ A -> 빈 줄에 블록 시작하기 
++++++++> @ S -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 
++++++++> @ D -> 줄 아래에 블록 마감하고 한줄 더 띄우기 
++++++++> @ F -> 이 줄을 타이틀로 만들기 
++++++++> @ K -> 찾은 글자 ~ COLON 앞뒤로 긁은글자(**) 붙이기 
========> @ Z -> 현 위치에서 Copy 까지 역따옴표 

마크다운 입력시 vi 커맨드 표시 ; (^[)=Ctrl+[ ; (^M)=Ctrl+M
인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}

---------- cut line ----------

${link_box}
|:----:|:----:|:----:|

# ${ChapterSeq} ${ChapterName}
#----> 본문을 기재하는 위치.



${link_box}
|:----:|:----:|:----:|

> (1) Path: ${small_Publisher}/${small_BookCover}/${small_Jemok}
> (2) Markdown
> (3) Title: ${ChapterSeq} ${ChapterName}
> (4) Short Description: ${ShortDescription}
> (5) tags: ${tags}
> Book Name: ${BookTitle}
> Link: ${https_line}
> create: $(date +'%Y-%m-%d %a %H:%M:%S')
> Images: /${small_Publisher}/${SMALL_BOOKCOVER_IMG}/
> .md Name: ${small_Jemok}.md

__EOF__
}
#-- file_Made "01" "P1 JavaScript Syntax" #from <-- md_Create () {

#-- 링크를 만든다. JemokMade #from --> md_Create () {
JemokMade () {
	#-- 다음 페이지가 있으면,
	#-- 현재 페이지를 만들어낸다.
	if [ "x${PrevSeq}" = "xSKIP" ]; then
		PrevLink="$PrevName"
	else
		PrevJemok="${PrevSeq} ${PrevName}"
		small_PrevJemok=$(echo "${PrevJemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")

		PrevLink="[ ${PrevJemok} ](/${small_Publisher}/${small_BookCover}/${small_PrevJemok})"
	fi

	if [ "x${NextSeq}" = "xSKIP" ]; then
		NextLink="$NextName"
	else
		NextJemok="${NextSeq} ${NextName}"
		small_NextJemok=$(echo "${NextJemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
		NextLink="[ ${NextJemok} ](/${small_Publisher}/${small_BookCover}/${small_NextJemok})"
	fi
}
#-- 링크를 만든다. JemokMade #from <-- md_Create () {

PrevSeq="" ; PrevName=""
CurrentSeq="" ; CurrentName=""
NextSeq="" ; NextName=""

md_Create () {
	TitleSeq=$1 #-- 권 번호
	TitleName=$(echo $2 | sed "s/’//g") #-- wiki.js 왼쪽에 표시할 챕터 제목
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

#-- (1-5) 책에 맞추어 수정하는 부분.
#--
Publisher="packtpub" #-- (1) 출판사 --
BookYear="2025" #-- (2-1) 등록년도
BookTitle="2505 Real-World Svelte" #-- (2-2) 시작월일 + 책 제목 --
BookCover="${BookYear}/${BookTitle}" #-- (2) 호스트의 경로
ShortDescription="Hau Dec 2023 282 pages" #-- (3) 저자등 설명 --
tags="Svelte" #-- (4) 찾기 위한 태그 --
https_line="https://subscription.packtpub.com/book/web-development/9781804616031/pref" #-- (5) 출판사 홈페이지 링크 --
#--
small_Publisher=$(echo "${Publisher,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
small_BookCover=$(echo "${BookCover,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
SMALL_BOOKCOVER_IMG="${small_BookCover}_img"
mkdir ${SMALL_BOOKCOVER_IMG}
#--
#-- (6) md_Create "권 번호" "S섹션/C챕터 번호 + 제목"
#-- 권번호의 0.. 은 목차, 1.. ~ 8.. 은 본문, 9.. 는 색인 등으로 정한다.
#-- 첫줄에는 "SKIP" "Begin" , 끝줄에는 "SKIP" "End" 로 표시한다.
md_Create "SKIP" "Begin"
md_Create "00" "Preface"

md_Create "01" "Pt1 Writing Svelte Components"
md_Create "02" "Ch01 Lifecycles in Svelte"
md_Create "03" "Ch02 Implementing Styling and Theming"
md_Create "04" "Ch03 Managing Props and State"
md_Create "05" "Ch04 Composing Components"
md_Create "06" "Pt2 Actions"
md_Create "07" "Ch05 Custom Events with Actions"
md_Create "08" "Ch06 Integrating Libraries with Actions"
md_Create "09" "Ch07 Progressive Enhancement with Actions"
md_Create "10" "Pt3 Context and Stores"
md_Create "11" "Ch08 Context versus Stores"
md_Create "12" "Ch09 Implementing Custom Stores"
md_Create "13" "Ch10 State Management with Svelte Stores"
md_Create "14" "Ch11 Renderless Components"
md_Create "15" "Ch12 Stores and Animations"
md_Create "16" "Pt4 Transitions"
md_Create "17" "Ch13 Using Transitions"
md_Create "18" "Ch14 Exploring Custom Transitions"
md_Create "19" "Ch15 Accessibility with Transitions"
md_Create "20" "Index"
md_Create "21" "Other Books You May Enjoy"


