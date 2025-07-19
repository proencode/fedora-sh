#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

#-- file_Made "${CurrentSeq}" "${CurrentTitle}" "${PrevLink}" "${NextLink}"
file_Made () {
	ChapterSeq="$1" #-- 권 번호
	ChapterName="$2" #-- wiki.js 왼쪽에 표시할 챕터 제목
	PrevLink="$3"
	NextLink="$4"
	if [ "x${PrevLink}" = "xBegin" ]; then
		link_box="| 🏁 ${read_mmdd} ${JeMok} | ${ChapterSeq} ${ChapterName} | ${NextLink} ≫ |"
	else
		if [ "x${NextLink}" = "xEnd" ]; then
			link_box="| ≪ ${PrevLink} | ${ChapterSeq} ${ChapterName} | ${read_mmdd} ${JeMok} 🔔 |"
			#-- End 🔔 | End 🎆 | End 🎇 | End 🌟 |
		else
			link_box="| ≪ ${PrevLink} | ${ChapterSeq} ${ChapterName} | ${NextLink} ≫ |"
		fi
	fi

	Jemok="${ChapterSeq} ${ChapterName}"
	small_Jemok=$(echo "${Jemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g" | sed "s/,//g")
	cat <<__EOF__ | tee "${small_Jemok}.md"

${link_box}
|:----:|:----:|:----:|

# ${ChapterSeq} ${ChapterName}
#----> 본문을 기재하는 위치.



${link_box}
|:----:|:----:|:----:|

> (1) Title: ${ChapterSeq} ${ChapterName}
> (2) Short Description: ${JeoJa}
> (3) Path: /${top_path}/${small_ChulPanSa}/${read_y4}/${small_MMDD_JeMok}/${CurrentSeq}
> (4) tags: ${tags}
> (5) .md 파일의 이름: ${small_Jemok}.md
> (6) 이미지 저장폴더: ./${img_dir}
> (7) 이미지링크 예시: ![ 설명 ](${img_link}/99-예시_이미지.webp)
> 책이름: ${JeMok}
> 안내: ${book_info}
> 서문: ${SeoMun}
> 독서시작일: $(date +'%Y-%m-%d %a %H:%M:%S')

---------- cut line ----------

https://coldmater.tistory.com/226
Vim 에서 매크로 등록하고 실행하기
1. 알파벳(a-z), 숫자(0-9) 중 1 글자로 된 '레지스터' 를 정해서
   +---+----------+
   | q | 레지스터 | 로 매크로 기록을 시작한다.
   +---+----------+
- 'q' 를 누르고, 레지스터 이름으로 a-z, 0-9 중 하나를 정해서 입력하면
  (레지스터로 'a'를 입력했다고 가정)
  상태표시줄에 'Recording @a' 라고 표시되면서 실제 명령어를 입력받을 준비가 된다.
- 명령어를 다 입력했으면, 다시 \`q\` 를 눌러서 매크로 기록을 끝낸다.
   +---+----------+
2. | @ | 레지스터 | 로 레지스터 에 저장된 매크로를 실행한다.
   +---+----------+
   +----+
3. | @@ | 로 직전에 실행한 매크로를 다시한번 실행한다.
   +----+
   +----------+---+----------+      +----------+----+
4. | 반복횟수 | @ | 레지스터 | 또는 | 반복횟수 | @@ | 로 저장된 매크로를
   +----------+---+----------+      +----------+----+
   '반복횟수' 만큼 재실행 할수 있다.
5. 또는, 아래와 같이 타이핑할 매크로 를 vi 로 입력해 놓고,
                +---+----------+----+
해당 줄 위에서, | " | 레지스터 | yy | 로 레지스터에 저장할수 있다.
                +---+----------+----+

**ff-func-key-setting.vi**
|   q   |   w   |   e   |   r   |   t   |   y   |   u   |   i   |   o   |   p   |
:------:|------:|------:|------:|------:|------:|------:|------:|------:|------:|
|- 'X': |'''Expl| 'XX'Δ | 'XX'. | 'XX', | 'XX'; | 'XX') | 'XX': | 'XX'} |       |
|'=BackQuote    |Δ=space|       |       |       |       |       |       |       |
|   a   |   s   |   d   |   f   |   g   |   h   |   j   |   k   |   l   |   ;   |
|-**X**:|  ###  |**X**_ |**X**. |**X**, |**X**; |**X**) |**X**: |**X**} |       |
|       |       |       |       |       |       |       |       |       |       |
|   z   |   x   |   c   |   v   |   b   |   n   |   m   |   ,   |   .   |   /   |
|       |       |       |       |       |       |       |       |       |       |
|       |       |       |       |       |       |       |       |       |       |

---------- cut line ----------
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
		#xx small_PrevJemok=$(echo "${PrevJemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
		PrevLink="[ ${PrevJemok} ](/${top_path}/${small_ChulPanSa}/${read_y4}/${small_MMDD_JeMok}/${PrevSeq})"
	fi

	if [ "x${NextSeq}" = "xSKIP" ]; then
		NextLink="$NextTitle"
	else
		NextJemok="${NextSeq} ${NextTitle}"
		#xx small_NextJemok=$(echo "${NextJemok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
		NextLink="[ ${NextJemok} ](/${top_path}/${small_ChulPanSa}/${read_y4}/${small_MMDD_JeMok}/${NextSeq})"
	fi
	#-- 이미지 파일을 로컬에 저장하는 폴더를 지정하고, 이곳에 이미지를 저장한다.
	img_dir="img_${read_mmdd}/${CurrentSeq}"
	echo "#-- mkdir ${img_dir}"
	mkdir -p ${img_dir}
	echo "#== mkdir ${img_dir}"
	#-- .md 파일에서 지정하는 이미지 보관 폴더.
	img_link="/img/${small_ChulPanSa}/${read_y4}/${img_dir}"
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
top_path="books" #-- (1) 상단 경로
ChulPanSa="packtpub" #-- (2) 출판사
read_y4="2025" #-- (3) 독서년도
read_mmdd="0625" #-- (4) 독서시작월일
JeMok="Beginning C++ Game Programming" #-- (5) 책 제목
tags="C++, game" #-- (6) 찾기 위한 태그
JeoJa="John Horton May 2024 648 pages 3rd Edition" #-- (7) 저자등 설명
book_info="https://www.packtpub.com/en-us/product/beginning-c-game-programming-9781835088258" #-- (8) 책 안내
SeoMun="https://subscription.packtpub.com/book/game-development/9781835081747/pref" #-- (9) 서문 링크
#--
MMDD_JeMok="${read_mmdd} ${JeMok}"
small_MMDD_JeMok=$(echo "${MMDD_JeMok,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g" | sed "s/,//g")
small_ChulPanSa=$(echo "${ChulPanSa,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g" | sed "s/,//g")
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
