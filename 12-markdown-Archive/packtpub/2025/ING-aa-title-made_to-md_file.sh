#!/bin/sh

#-- file_Made "${CurrentSeq}" "${CurrentTitle}" "${PrevLink}" "${NextLink}"
file_Made () {
	ChapterSeq="$1" #-- 권 번호
	ChapterName="$2" #-- wiki.js 왼쪽에 표시할 챕터 제목
	PrevLink="$3"
	NextLink="$4"
echo "#----> file_Made CurrentSeq ${CurrentSeq}; CurrentTitle ${CurrentTitle}; PrevLink ${PrevLink}; NextLink ${NextLink};"
	if [ "x${PrevLink}" = "xBegin" ]; then
		link_box="| 🏁 ${JeMok} | ${ChapterSeq} ${ChapterName} | $4 ≫ |"
	else
		if [ "x${NextLink}" = "xEnd" ]; then
			link_box="| ≪ $3 | ${ChapterSeq} ${ChapterName} | ${JeMok} 🔔 |"
			#-- End 🔔 | End 🎆 | End 🎇 | End 🌟 |
		else
			link_box="| ≪ $3 | ${ChapterSeq} ${ChapterName} | $4 ≫ |"
		fi
	fi

	Jemok="${ChapterSeq} ${ChapterName}"
	small_Jemok=$(echo "${Jemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
	cat <<__EOF__ | tee "${small_Jemok}.md"

---------- cut line ----------

ff-func-key-setting.vi

| q     | w     | e     | r     | t     | y     | u     | i     | o     | p     |
:------:|------:|------:|------:|------:|------:|------:|------:|------:|------:|
|### title | \`\`\` \`\`\` Expl| \`xxx \`|\`xxx.\`|\`xxx,\`|\`xxx;\`|\`xxx)\`|\`xxx:\`|\`xxx}\`| 없 음 |
| a     | s     | d     | f     | g     | h     | j     | k     | l     |
|- \`xxx\`|- \*\*xxx \*\*| \*\*xxx.\*\*| \*\*xxx,\*\*| \*\*xxx;\*\*| \*\*xxx)\*\*| \*\*xxx:\*\*| \*\*xxx}\*\*|

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

> (1) Title: ${ChapterSeq} ${ChapterName}
> (2) Short Description: ${JeoJa}
> (3) Path: /${top_path}/${small_ChulPanSa}/${read_y4}/${read_mmdd}/
> (4) tags: ${tags}
> 책이름: ${JeMok}
> 책 안내: ${book_info}
> 서문: ${SeoMun}
> 독서시작일: $(date +'%Y-%m-%d %a %H:%M:%S')
> 이미지: /${small_ChulPanSa}/${SMALL_BOOKCOVER_IMG}/
> .md Name: ${small_Jemok}.md

__EOF__
}
#-- > (1) Path: /books/packtpub/2025/0625/01
#--
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

		PrevLink="[ ${PrevJemok} ](/${top_path}/${small_ChulPanSa}/${small_BookCover}/${small_PrevJemok})"
	fi

	if [ "x${NextSeq}" = "xSKIP" ]; then
		NextLink="$NextTitle"
	else
		NextJemok="${NextSeq} ${NextTitle}"
		small_NextJemok=$(echo "${NextJemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
		NextLink="[ ${NextJemok} ](/${top_path}/${small_ChulPanSa}/${small_BookCover}/${small_NextJemok})"
	fi
}
#-- 링크를 만든다. JemokMade #from <-- md_Create () {

PrevSeq="" ; PrevTitle=""
CurrentSeq="" ; CurrentTitle=""
NextSeq="" ; NextTitle=""

#-- md_Create 
md_Create () {
	ChapSeq=$1 #-- 권 번호
	ChapTitle=$2 #-- wiki.js 왼쪽에 표시할 챕터 제목
	if [ "x$NextSeq" = "x" ]; then
		if [ "x$PrevSeq" = "x" ]; then
			#-- 이전 페이지가 없으면, 이전 페이지로 담는다.
			PrevSeq=$ChapSeq ; PrevTitle=$ChapTitle
		else
		if [ "x$CurrentSeq" = "x" ]; then
			#-- 현재 페이지가 없으면, 현재 페이지로 담는다.
			CurrentSeq=$ChapSeq ; CurrentTitle=$ChapTitle
		else
		# if [ "x$NextSeq" = "x" ]; then
			#-- 다음 페이지가 없으면, 다음 페이지로 담는다.
			NextSeq=$ChapSeq ; NextTitle=$ChapTitle
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
		NextSeq=$ChapSeq ; NextTitle=$ChapTitle

		if [ "x${NextSeq}" = "xSKIP" ]; then
			#-- 링크를 만든다.
			JemokMade

			file_Made "${CurrentSeq}" "${CurrentTitle}" "${PrevLink}" "${NextLink}"
		fi
	fi
}

#-- (1-5) 책에 맞추어 수정하는 부분.
#--
top_path="books" #-- (1) 상단 경로 --
ChulPanSa="packtpub" #-- (2) 출판사 --
read_y4="2025" #-- (3) 독서년도 --
read_mmdd="0625" #-- (4) 독서시작월일 --
JeMok="Beginning C++ Game Programming" #-- (5) 책 제목 --
tags="C++, game" #-- (6) 찾기 위한 태그 --
JeoJa="John Horton May 2024 648 pages 3rd Edition" #-- (7) 저자등 설명 --
book_info="https://www.packtpub.com/en-us/product/beginning-c-game-programming-9781835088258" #-- (8) 책 안내
SeoMun="https://subscription.packtpub.com/book/game-development/9781835081747/pref" #-- (9) 서문 링크

BookCover="${read_y4}/${JeMok}" #-- (2) 호스트의 경로
#--
small_ChulPanSa=$(echo "${ChulPanSa,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
small_BookCover=$(echo "${BookCover,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
SMALL_BOOKCOVER_IMG="/${small_ChulPanSa}/${read_y4}/${small_BookCover}_img"
mkdir ${SMALL_BOOKCOVER_IMG}
#--
#-- (6) md_Create "권 번호" "S섹션/C챕터 번호 + 제목"
#-- 권번호의 0.. 은 목차, 1.. ~ 8.. 은 본문, 9.. 는 색인 등으로 정한다.
#-- 첫줄에는 "SKIP" "Begin" , 끝줄에는 "SKIP" "End" 로 표시한다.
md_Create "SKIP" "Begin"
#--
md_Create "00" "Preface"
md_Create "01" "Welcome to Beginning C++ Game Programming, 3Ed"
md_Create "02" "Variables Operators and Decisions"
md_Create "03" "C++ Strings SFML Time Player Input and HUD"
md_Create "04" "Loops Arrays Switch Enumerations and Functions"
md_Create "05" "Collisions Sound and End Conditions"
md_Create "06" "Object-Oriented Programming"
md_Create "07" "AABB Collision Detection and Physics"
md_Create "08" "SFML Views"
md_Create "09" "C++ References Sprite Sheets and Vertex Arrays"
md_Create "10" "Pointers the Standard Template Library and Texture Management"
md_Create "11" "Coding the TextureHolder Class and Building a Horde of Zombies"
md_Create "12" "Collision Detection Pickups and Bullets"
md_Create "13" "Layering Views and Implementing the HUD"
md_Create "14" "Sound Effects File IO and Finishing the Game"
md_Create "15" "Run"
md_Create "16" "Sound Game Logic Inter-Object Communication and the Player"
md_Create "17" "Graphics Camera Action"
md_Create "18" "Coding the Platforms Player Animations and Controls"
md_Create "19" "Building the Menu and Making It Rain"
md_Create "20" "Fireballs and Spatialization"
md_Create "21" "Parallax Backgrounds and Shaders"
#--
md_Create "SKIP" "End"
