#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${HOME}/lib/color_base #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp
# ~/lib/color_base 220827-0920 cat_and_run cat_and_run_cr cat_and_read cat_and_readY view_and_read show_then_run show_then_view show_title value_keyin () {

#MEMO="memo"
#echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
#--xx-- zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cat_and_run "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
#--xx-- zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}



#--xx-- rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
#--xx-- cat_and_run "ls --color ${1}" "프로그램들" ; ls --color ${zz00logs_folder}
#echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"


minus_mark="----------"
equal_mark="=========="

if [ "x$1" != "x" ]; then
	publisher="$1"
else
	publisher="packtpub"
fi
if [ "x$2" != "x" ]; then
	BookCover="$2"
else
	BookCover="2206_building_games_with_flutter"
fi
if [ "x$3" != "x" ]; then
	ShortDescription="$3"
else
	ShortDescription="By Paul Teale Publication date: 6월 2022 Publisher Packt Pages 224 ISBN 9781801816984"
fi
if [ "x$4" != "x" ]; then
	ChapterSeq="$4"
else
	ChapterSeq="01-000"
fi
if [ "x$5" != "x" ]; then
	ChapterName="$5"
else
	ChapterName="Preface"
fi
if [ "x$6" != "x" ]; then
	old_image_jemok="$6"
else
	old_image_jemok="이미지 제목을 넣어주세요"
fi
if [ "x$7" != "x" ]; then
	https_line="$7"
else
	https_line="https://subscription.packtpub.com/book/web-development/9781801816786/pref"
fi
if [ "x$8" != "x" ]; then
	tags="$8"
else
	tags="spring_boot react"
fi

cat <<__EOF__

${cBlue}${CMD_NAME} ${cRed}"${publisher}"  ${cMagenta}"${BookCover}"  ${cRed}"${ShortDescription}"  ${cMagenta}"${ChapterSeq}"  ${cRed}"${ChapterName}"  ${cMagenta}"${old_image_jemok}"  ${cRed}"${https_line}"  ${cMagenta}"${tags}"

publisher="${cRed}${publisher}${cBlue}"
BookCover="${cMagenta}${BookCover}${cBlue}"
ShortDescription="${cRed}${ShortDescription}${cBlue}"
ChapterSeq="${cMagenta}${ChapterSeq}${cBlue}"
ChapterName="${cRed}${ChapterName}${cBlue}"
old_image_jemok="${cMagenta}${old_image_jemok}${cBlue}"
https_line="${cRed}${https_line}${cBlue}"
tags="${cMagenta}${tags}${cBlue}"
${cReset}
__EOF__

# 01-000 Preface

# 출판사 이름
# -----------

if [ "x$1" = "x" ]; then
	#-- (대문자, 공백, - 와 _ 제외한 특수문자) 는 안됨 !
	cat <<__EOF__

${cRed}[ ${cYellow}1 ${cRed}] ${cCyan}---- packtpub
  2   ---- medium
  3   ---- docker
  4   ---- howtogeek
  5   ---- ddanzi
  6   ---- ysjn
  7   ---- gihyo.jp

${cGreen}----> ${cCyan}출판사 이름 ${cRed}[ ${cGreen}1 ~ 6 ${cRed}]${cCyan} 또는 새로운 ${cRed}[ ${cGreen}출판사 분류명 ${cRed}] ${cCyan}을 입력하세요.${cReset}
__EOF__
	read a
	if [ "x$a" = "x" ]; then
		publisher="packtpub"
		echo "${cGreen}${minus_mark:0:3}${cReset}"
	else
		echo "${cBlue}${equal_mark:0:${#a}}${cReset}"
		if [ "x$a" = "x1" ]; then
			publisher="packtpub"
		else
		if [ "x$a" = "x2" ]; then
			publisher="medium"
		else
		if [ "x$a" = "x3" ]; then
			publisher="docker"
		else
	
		if [ "x$a" = "x4" ]; then
			publisher="howtogeek"
		else
		if [ "x$a" = "x5" ]; then
			publisher="ddanzi"
		else
		if [ "x$a" = "x6" ]; then
			publisher="ysjn"
		else

		if [ "x$a" = "x7" ]; then
			publisher="gihyo.jp"
		else
			publisher="$a"
		fi
		fi
		fi

		fi
		fi
		fi

		fi
	fi
else
	a="cmd 에서 지정"
	publisher="$1"

fi

chulpansa=$(echo "${publisher,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.

cat <<__EOF__
${cGreen}----> ${cBlue}출판사 이름이 ${cRed}[ ${cYellow}${chulpansa} ${cRed}] ${cBlue}맞으면 엔터를 누르세요.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cGreen}${minus_mark:0:3}${cReset}"
else
	echo "${cBlue}${equal_mark:0:${#a}}${cReset}"
fi

# 책 제목
# -------

cat <<__EOF__
${cGreen}----> ${cCyan}폴더 이름으로 쓰기 위한 책 제목 Title: ${cRed}[ ${cGreen}${BookCover} ${cRed}] (${cMagenta}대,소문자, 숫자,  ., -, _, 빈칸${cBlue}) 만 쓸 수 있습니다.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
else
	echo "${cUp}${cBlue}${equal_mark:0:${#a}}${cReset}"
fi

if [ "x$a" = "x" ]; then
	a=${BookCover}
fi
BookCover=$a

cheak_jemok=$(echo "${BookCover,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.

cat <<__EOF__
${cGreen}----> ${cBlue}책 제목이 ${cRed}[ ${cYellow}${chulpansa} / ${cheak_jemok} ${cRed}] ${cBlue}맞으면 엔터를 누르세요.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
else
	echo "${cUp}${cBlue}${equal_mark:0:${#a}}${cReset}"
fi

# 설명 요약
# ---------

cat <<__EOF__
${cGreen}----> ${cCyan}설명 요약 Short Description: ${cRed}[ ${cGreen}${ShortDescription} ${cRed}] (${cMagenta}대,소문자, 숫자,  ., -, _, 빈칸${cBlue}) 만 쓸 수 있습니다.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
else
	echo "${cUp}${cBlue}${equal_mark:0:${#a}}${cReset}"
fi

if [ "x$a" = "x" ]; then
	a=${ShortDescription}
fi
ShortDescription=$a

cat <<__EOF__
${cGreen}----> ${cBlue}설명 요약이 ${cRed}[ ${cYellow}${ShortDescription} ${cRed}] ${cBlue}맞으면 엔터를 누르세요.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
else
	echo "${cUp}${cBlue}${equal_mark:0:${#a}}${cReset}"
fi

# 원본 링크
# ---------

cat <<__EOF__
${cGreen}----> ${cCyan}원본 링크 ${cRed}[ ${cGreen}${https_line} ${cRed}] (${cMagenta}대,소문자, 숫자,  ., -, _, 빈칸${cBlue}) 만 쓸 수 있습니다.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
else
	echo "${cUp}${cBlue}${equal_mark:0:${#a}}${cReset}"
fi

if [ "x$a" = "x" ]; then
	a=${https_line}
fi
https_line=$a

cat <<__EOF__
${cGreen}----> ${cBlue}원본 링크가 ${cRed}[ ${cYellow}${https_line} ${cRed}] ${cBlue}맞으면 엔터를 누르세요.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
else
	echo "${cUp}${cBlue}${equal_mark:0:${#a}}${cReset}"
fi

# 태그
# ---------

cat <<__EOF__
${cGreen}----> ${cCyan}태그 ${cRed}[ ${cGreen}${tags} ${cRed}] (${cMagenta}대,소문자, 숫자,  ., -, _, 빈칸${cBlue}) 만 쓸 수 있습니다.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
else
	echo "${cUp}${cBlue}${equal_mark:0:${#a}}${cReset}"
fi

if [ "x$a" = "x" ]; then
	a=${tags}
fi
tags=$a

cat <<__EOF__
${cGreen}----> ${cBlue}태그가 ${cRed}[ ${cYellow}${tags} ${cRed}] ${cBlue}맞으면 엔터를 누르세요.${cReset}
__EOF__
read a
if [ "x$a" = "x" ]; then
	echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
else
	echo "${cUp}${cBlue}${equal_mark:0:${#a}}${cReset}"
fi



# ChapterSeq="01-000"
# ChapterName="Preface"
# ---------------------

until [ "x$ChapterSeq" = "x" ]
do
	cat <<__EOF__
${cGreen}+--------+ 챕터  번호
| AA-BBB | AA = '01'로 시작하는 챕터별 전체 일련번호
|        | BBB = '0' 섹션 '00' 챕터로 된 코드
+--------+
${cGreen}----> ${cCyan}챕터 번호를 ${cRed}[ ${cGreen}${ChapterSeq} ${cRed}] ${cCyan}이와 같이 다음 줄에 입력합니다. ${cRed}[ ${cGreen}엔터 ${cRed}]${cCyan} 만 누르면 이 작업을 끝냅니다.${cReset}
__EOF__
	read a
	if [ "x$a" = "x" ]; then
		echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
		ChapterSeq="" #-- 끝낸다.
		ChapterName=""
	else
		echo "${cUp}${cBlue}${equal_mark:0:${#a}}${cReset}"
		ChapterSeq=$a
		cat <<__EOF__
${cBlue}챕터  이름
==========${cReset}
${cGreen}----> ${cCyan}챕터의 요약제목을 ${cRed}[ ${cGreen}${ChapterName} ${cRed}] ${cCyan}이와 같이 다음 줄에 입력합니다. ${cRed}[ ${cGreen}엔터 ${cRed}]${cBlue} 만 누르면 ${cCyan}챕터 번호 ${cBlue}입력으로 돌아갑니다.${cReset}
__EOF__
		read a
		if [ "x$a" = "x" ]; then
			echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
			ChapterSeq="" #-- 끝낸다.
			ChapterName=""
		else
			echo "${cUp}${cBlue}${equal_mark:0:${#a}}${cReset}"
			# 이미지 제목
			# -----------

			ChapterName=$a
			image_jemok=${old_image_jemok}
			until [ "x$image_jemok" = "x" ]
			do
				cat <<__EOF__

${cCyan}----> ${cMagenta}이미지의 제목 입력 (${cCyan}대,소문자, 숫자,  ., -, _, 빈칸${cMagenta}) 만 쓸 수 있습니다.${cReset}

${cCyan}----> ${cMagenta}이미지별 일련번호 (${cRed}00-000${cMagenta}) 와 이미지에 대한 설명을 ${cRed}[ ${cGreen}${image_jemok} ${cRed}] ${cMagenta}이와 같이 다음줄에 입력합니다. ${cRed}[ ${cGreen}엔터 ${cRed}]${cMagenta} 만 누르면 ${cCyan}챕터 번호 ${cMagenta}입력으로 돌아갑니다.${cReset}
__EOF__
				read image_jemok
				if [ "x$image_jemok" = "x" ]; then
					echo "${cUp}${cGreen}${minus_mark:0:3}${cReset}"
					cat <<__EOF__



__EOF__
				else
					echo "${cUp}${cBlue}${equal_mark:0:${#image_jemok}}${cReset}"
					old_image_jemok=${image_jemok}
					img_name=$(echo "${image_jemok,,}" | sed 's/ /_/g') #-- 전부 대문자로 바꾸려면 ${image_jemok^^}, 전부 소문자는 ${image_jemok,,}
					chapter_name=$(echo "${ChapterName,,}" | sed 's/ /_/g')
					cat <<__EOF__
${cBlue}
/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
${cReset}
@ Q -> # 붙이고 줄 띄우기 => 0i# ^[A^M^[
@ W -> 현 위치에서 Copy 까지 역따옴표 => j0i\`\`\`^M^[/^Copy$^[ddk0C\`\`\`^M^[
@ E -> 찾은 글자 앞뒤로 backtick(\`) 붙이기 => i\`^[/ ^[i\`^[/rrqeEWQRQewreq^[
    마크다운 입력시 vi 커맨드 표시 ; (^{)=Ctrl+[ ; (^M)=Ctrl+M
    인용구 작성시 ; 본문앞에는 꺽쇠 > 붙이고, 스타일 첨가시 끝줄에 종류별 구분을 표시한다.
    https://docs.requarks.io/en/editors/markdown > Blockquotes > Stylings >
    blue= {.is-info} ; green= {.is-success} ; yellow= {.is-warning} ; red= {.is-danger}
@ Q -> 빈 줄에 블록 시작하기 => 0C\`\`\`^[^Mk0
@ W -> 줄 앞에 > 나오면 안되므로 블록 마감하고 > 앞에 - 끼우기 => 0i\`\`\`^M-^[^M0i\`\`\`^[0
@ E -> 줄 아래에 블록 마감하고 한줄 더 띄우기 => 0^Mi\`\`\`^M^M^[kk
@ A -> 이 줄을 타이틀로 만들기 => 0i#### ^[^M^[

---------- cut line ----------


> Path: ${chulpansa}/${cheak_jemok}/${ChapterSeq}_${chapter_name}
> Title: ${ChapterSeq} ${ChapterName}
> Short Description: ${ShortDescription}
> Link: ${https_line}
> tags: ${tags}
> Images: / ${chulpansa} / ${cheak_jemok} /
> create: $(date +'%Y-%m-%d %a %H:%M:%S')

# ${ChapterSeq} ${ChapterName}


![ ${image_jemok} ](/${chulpansa}/${cheak_jemok}_img/${img_name})
${cBlue}
/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
${cMagenta}
----> 윗줄을 복사해서 사용합니다.
${cReset}
__EOF__
				fi
			done #-- until [ "x$image_jemok" = "x" ]
		fi #-- if [ "x$a" = "x" ]; then #-- 요약제목 없으면,

	fi #-- ChapterSeq="" 이므로 끝낸다.

done #-- until [ "x$ChapterSeq" = "x" ]

echo "----> Thank_you for using $0 ~~~"
