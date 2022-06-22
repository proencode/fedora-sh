#!/bin/sh

BookCover="2204 SpringBoot React 3e"
ChapterSeq="01-000"
ChapterName="Preface"
old_sajin_jemok="01-000 that are mentioned in the book"

if [ "x$1" = "x" ]; then
	#-- (대문자, 공백, - 와 _ 제외한 특수문자) 는 안됨 !
	cat <<__EOF__
  1   ---- packtpub
[ 2 ] ---- medium
  3   ---- docker
  4   ---- howtogeek
  5   ---- ddanzi
  6   ---- ysjn

----> [ 1 ~ 6 ] 또는 새로운 분류명을 입력하세요.
__EOF__
	read a
	if [ "x$a" = "x" ]; then
		publisher="medium"
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
	a="cmd에서지정"
	publisher="$1"

fi

chulpansa=$(echo "${publisher,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.

cat <<__EOF__

----> 출판사 지정이 맞으면, press Enter: $a ... ${publisher} [ ${chulpansa} ]
__EOF__
read a



cat <<__EOF__
----> 폴더 이름으로 쓰기 위한 책 제목: (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있습니다. [ ${BookCover} ]
__EOF__
read a

if [ "x$a" = "x" ]; then
	a=${BookCover}
fi
BookCover=$a

cheak_jemok=$(echo "${BookCover,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.

cat <<__EOF__

----> 책 제목이 맞으면, press Enter: ${BookCover} [ ${chulpansa}/${cheak_jemok} ]
__EOF__
read a



# ChapterSeq="01-000"
# ChapterName="Preface"
until [ "x$ChapterSeq" = "x" ]
do
	cat <<__EOF__

${ChapterSeq} ----> 이와 같이 챕터 번호를 다음 줄에 입력합니다. [엔터] 만 치면, 끝냅니다.
__EOF__
	read a
	if [ "x$a" = "x" ]; then
		ChapterSeq="" #-- 끝낸다.
		ChapterName=""
	else
		cat <<__EOF__

${ChapterName} ----> 이와 같이 챕터의 요약제목을 다음 줄에 입력합니다. [엔터] 만 치면, 끝냅니다.
__EOF__
		read a
		if [ "x$a" = "x" ]; then
			ChapterSeq="" #-- 끝낸다.
			ChapterName=""
		else
			sajin_jemok=${old_sajin_jemok}
			until [ "x$sajin_jemok" = "x" ]
			do
				cat <<__EOF__

----> (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있습니다.

${sajin_jemok} ----> 이와 같이 일련번호와 설명을 다음줄에 입력합니다. [엔터] 만 치면, 챕터 입력으로 갑니다.
__EOF__
				read sajin_jemok
				if [ "x$sajin_jemok" = "x" ]; then
					cat <<__EOF__



__EOF__
					#-- ChapterSeq=""
					#-- ChapterName=""
				else
					old_sajin_jemok=${sajin_jemok}
					img_name=$(echo "${sajin_jemok,,}" | sed 's/ /_/g') #-- 전부 대문자로 바꾸려면 ${sajin_jemok^^}, 전부 소문자는 ${sajin_jemok,,}
					chapter_name=$(echo "${ChapterName,,}" | sed 's/ /_/g')
					cat <<__EOF__

> create: $(date +'%Y-%m-%d %a %H:%M:%S')
> Path: ${chulpansa}/${cheak_jemok}/${ChapterSeq}-${chapter_name}
> Image: ${chulpansa}/${cheak_jemok}/img/

![ ${sajin_jemok} ](${chulpansa}/${cheak_jemok}/img/${img_name}.png)
----> 윗줄을 복사해서 사용합니다.
__EOF__
				fi
			done #-- until [ "x$sajin_jemok" = "x" ]
		fi #-- if [ "x$a" = "x" ]; then #-- 요약제목 없으면,

	fi #-- ChapterSeq="" 이므로 끝낸다.

done #-- until [ "x$ChapterSeq" = "x" ]

echo "----> Thank_you for using $0 ~~~"
