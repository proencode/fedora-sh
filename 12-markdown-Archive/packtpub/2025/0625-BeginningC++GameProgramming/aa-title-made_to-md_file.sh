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

	Jemok="${ChapterSeq} ${ChapterName}"
	small_Jemok=$(echo "${Jemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
#== 
#== | q     | w     | e     | r     | t     | y     | u     | i     | o     | p     |
#== |### title | \`\`\` \`\`\` Expl| \`xxx` `\`|\`xxx`.`\`|\`xxx`,`\`|\`xxx`;`\`|\`xxx`)`\`|\`xxx `:`\`|\`xxx `}`\`|       |
#== | a     | s     | d     | f     | g     | h     | j     | k     | l     |
#== |- `xxx`|i **xx**| \*\*xxx` `\*\*| \*\*xxx`.`\*\*| \*\*xxx`,`\*\*| \*\*xxx`;`\*\*| \*\*xxx`)`\*\*| \*\*xxx`:`\*\*| \*\*xxx`}`\*\*|
#== 
	cat <<__EOF__ | tee "${small_Jemok}.md"

---------- cut line ----------

ff-func-key-setting.vi

| q     | w     | e     | r     | t     | y     | u     | i     | o     | p     |
:------:|------:|------:|------:|------:|------:|------:|------:|------:|------:|
|### title | \\\`\\\`\\\` \\\`\\\`\\\` Expl| \\\`xxx` `\\\`|\\\`xxx`.`\\\`|\\\`xxx`,`\\\`|\\\`xxx`;`\\\`|\\\`xxx`)`\\\`|\\\`xxx `:`\\\`|\\\`xxx `}`\\\`| 없 음 |
| a     | s     | d     | f     | g     | h     | j     | k     | l     |
|- \`x\`|- \\*\\*x\\*\\*| \\*\\*xxx` `\\*\\*| \\*\\*xxx`.`\\*\\*| \\*\\*xxx`,`\\*\\*| \\*\\*xxx`;`\\*\\*| \\*\\*xxx`)`\\*\\*| \\*\\*xxx`:`\\*\\*| \\*\\*xxx`}`\\*\\*|

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

> (1) Path: ${small_Publisher}/${small_BookCover}/${small_Jemok} __
> (2) Markdown
> (3) Title: ${ChapterSeq} ${ChapterName}
> (4) Short Description: ${ShortDescription}
> (5) tags: ${tags}
> Book Name: ${BookTitle}
> Link: ${https_line}
> create: $(date +'%Y-%m-%d %a %H:%M:%S')
> Images: /${small_Publisher}/${SMALL_BOOKCOVER_IMG}/ __
> .md Name: ${small_Jemok}.md __

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

#-- (1-5) 책에 맞추어 수정하는 부분.
#--
Publisher="packtpub" #-- (1) 출판사 --
BookYear="2025" #-- (2-1) 독서년도
BookTitle="0625 Beginning C++ Game Programming" #-- (2-2) 독서시작월일 + 책 제목 --
BookCover="${BookYear}/${BookTitle}" #-- (2) 호스트의 경로
ShortDescription="John Horton May 2024 648 pages 3rd Edition" #-- (3) 저자등 설명 --
#-- 책 안내문 https://www.packtpub.com/en-us/product/beginning-c-game-programming-9781835088258
#-- Beginning C++ Game Programming
#-- : Learn C++ from scratch by building fun games , Third Edition
#-- John Horton #// Profile IconJohn Horton
#-- 4.3 (27 Ratings)
#-- eBook May 2024 648 pages 3rd Edition
#-- eBook $5 ($39.99cut) Paperback $32.49 ($49.99XXX)

tags="C++, game" #-- (4) 찾기 위한 태그 --
https_line="https://subscription.packtpub.com/book/game-development/9781835081747/pref" #-- (5) 출판사 홈페이지 링크 --
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
