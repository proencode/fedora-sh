#!/bin/sh

BookCover="2204 SpringBoot React 3e"
ShortDescription="By Juha Hinkula Publication date: 4월 2022 Publisher Packt Pages 378 ISBN 9781801816786"
ChapterSeq="01-000"
ChapterName="Preface"
old_image_jemok="${ChapterSeq} that are mentioned in the book"

# 출판사 이름
# -----------

if [ "x$1" = "x" ]; then
	#-- (대문자, 공백, - 와 _ 제외한 특수문자) 는 안됨 !
	cat <<__EOF__
${cCyan}
출판사 이름

${cRed}[ ${cYellow}1 ${cRed}] ${cCyan}---- packtpub
  2   ---- medium
  3   ---- docker
  4   ---- howtogeek
  5   ---- ddanzi
  6   ---- ysjn

${cGreen}----> ${cRed}[ ${cYellow}1 ~ 6 ${cRed}]${cCyan} 또는 새로운 [ 출판사 분류명 ] 을 입력하세요.${cReset}
__EOF__
	read a
	if [ "x$a" = "x" ]; then
		publisher="packtpub"
	else
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
		publisher="$a"
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
----

${cGreen}----> ${cBlue}출판사 지정이 ${cRed}[ ${cYellow}$a ${cRed}] ${cCyan}${publisher} --> ${chulpansa} ${cBlue}맞으면 엔터를 누르세요.${cReset}
__EOF__
read a

# 책 제목
# -------

cat <<__EOF__
----

${cGreen}----> ${cBlue}폴더 이름으로 쓰기 위한 ${cCyan}책 제목 ${cBlue}Title: (${cMagenta}대,소문자, 숫자,  ., -, _, 빈칸${cBlue}) 만 쓸 수 있습니다. ${cRed}[ ${cYellow}${BookCover} ${cRed}]${cReset}
__EOF__
read a

if [ "x$a" = "x" ]; then
	a=${BookCover}
fi
BookCover=$a

cheak_jemok=$(echo "${BookCover,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.

cat <<__EOF__

${cGreen}----> ${cBlue}책 제목 ${cCyan}${BookCover} --> ${chulpansa} / ${check_jemk} ${cBlue}맞으면 엔터를 누르세요.${cReset}
__EOF__
read a

# 설명 요약
# ---------

cat <<__EOF__
----

${cGreen}----> ${cCyan}설명 요약 ${cBlue}Short Description: (${cMagenta}대,소문자, 숫자,  ., -, _, 빈칸${cBlue}) 만 쓸 수 있습니다. ${cRed}[ ${cYellow}${ShortDescription} ${cRed}]${cReset}
__EOF__
read a

if [ "x$a" = "x" ]; then
	a=${ShortDescription}
fi
ShortDescription=$a

cat <<__EOF__

${cGreen}----> ${cBlue}설명 요약 ${cCyan}${ShortDescription} ${cBlue}맞으면 엔터를 누르세요.${cReset}
__EOF__
read a

# ChapterSeq="01-000"
# ChapterName="Preface"
# ---------------------

until [ "x$ChapterSeq" = "x" ]
do
	cat <<__EOF__
${cGreen}
챕터  번호
+--------+
| AA-BBB | AA = '01'로 시작하는 챕터별 전체 일련번호
|        | BBB = '0' 섹션 '00' 챕터로 된 코드
+--------+${cReset}
${ChapterSeq} ${cGreen}----> ${cCyan}이와 같이 챕터 번호를 다음 줄에 입력합니다. ${cRed}[ ${cYellow}엔터 ${cRed}]${cCyan} 만 누르면 이 작업을 끝냅니다.${cReset}
__EOF__
	read a
	if [ "x$a" = "x" ]; then
		ChapterSeq="" #-- 끝낸다.
		ChapterName=""
	else
		ChapterSeq=$a
		cat <<__EOF__
${cBlue}챕터  이름
==========${cReset}
${ChapterName} ${cGreen}----> ${cCyan}이와 같이 챕터의 요약제목을 다음 줄에 입력합니다. ${cRed}[ ${cYellow}엔터 ${cRed}]${cBlue} 만 누르면 ${cCyan}챕터 번호 ${cBlue}입력으로 돌아갑니다.${cReset}
__EOF__
		read a
		if [ "x$a" = "x" ]; then
			ChapterSeq="" #-- 끝낸다.
			ChapterName=""
		else
			# 이미지 제목
			# -----------

			ChapterName=$a
			image_jemok=${old_image_jemok}
			until [ "x$image_jemok" = "x" ]
			do
				cat <<__EOF__

${cGreen}----> ${cBlue}(${cCyan}대,소문자, 숫자,  ., -, _, 빈칸${cBlue}) 만 쓸 수 있습니다.${cReset}

${image_jemok} ${cGreen}----> ${cBlue}이와 같이 ${cCyan}일련번호와 설명${cBlue}을 다음줄에 입력합니다. ${cRed}[ ${cYellow}엔터 ${cRed}]${cBlue} 만 누르면 ${cCyan}챕터 번호 ${cBlue}입력으로 돌아갑니다.${cReset}
__EOF__
				read image_jemok
				if [ "x$image_jemok" = "x" ]; then
					cat <<__EOF__



__EOF__
				else
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

---------- cut line ----------


> Path: ${chulpansa}/${cheak_jemok}/${ChapterSeq}_${chapter_name}
> Title: ${ChapterSeq} ${ChapterName}
> Short Description: ${ShortDescription}
> Link: https://subscription.packtpub.com/book/web-development/9781801816786/pref
> tags: spring_boot react
> Images: / ${chulpansa} / ${cheak_jemok} /
> create: $(date +'%Y-%m-%d %a %H:%M:%S')

# ${ChapterSeq} ${ChapterName}


![ ${image_jemok} ](/${chulpansa}/${cheak_jemok}/${img_name}.webp .png .jpg)
${cMagenta}
/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
${cReset}
----> 윗줄을 복사해서 사용합니다.
__EOF__
				fi
			done #-- until [ "x$image_jemok" = "x" ]
		fi #-- if [ "x$a" = "x" ]; then #-- 요약제목 없으면,

	fi #-- ChapterSeq="" 이므로 끝낸다.

done #-- until [ "x$ChapterSeq" = "x" ]

echo "----> Thank_you for using $0 ~~~"
