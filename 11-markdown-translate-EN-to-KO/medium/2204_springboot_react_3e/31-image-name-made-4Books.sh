#!/bin/sh

BookCover="2204 SpringBoot React 3e"
ShortDescription="By Juha Hinkula Publication date: 4월 2022 Publisher Packt Pages 378 ISBN 9781801816786"
ChapterSeq="01-000"
ChapterName="Preface"
old_image_jemok="${ChapterSeq:3:3}-99 that are mentioned in the book"

# 출판사 이름
# -----------

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

# 책 제목
# -------

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

# 설명 요약
# ---------

cat <<__EOF__
----> Short Description: (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있습니다. [ ${ShortDescription} ]
__EOF__
read a

if [ "x$a" = "x" ]; then
	a=${ShortDescription}
fi
ShortDescription=$a

cat <<__EOF__

----> 설명 요약이 맞으면, press Enter: [ ${ShortDescription} ]
__EOF__
read a

# ChapterSeq="01-000"
# ChapterName="Preface"
# ---------------------

until [ "x$ChapterSeq" = "x" ]
do
	# 챕터 번호
	# ---------

	cat <<__EOF__

AA-BBB ----> AA = '01'로 시작하는 챕터별 전체 일련번호
             BBB = '0' 섹션 '00' 챕터로 된 코드
${ChapterSeq} ----> 이와 같이 챕터 번호를 다음 줄에 입력합니다. [엔터] 만 치면, 끝냅니다.
__EOF__
	read a
	if [ "x$a" = "x" ]; then
		ChapterSeq="" #-- 끝낸다.
		ChapterName=""
	else
		# 챕터 이름
		# ---------

		ChapterSeq=$a
		old_image_jemok="${ChapterSeq:3:3}-99 that are mentioned in the book"
		cat <<__EOF__

${ChapterName} ----> 이와 같이 챕터의 요약제목을 다음 줄에 입력합니다. [엔터] 만 치면, 끝냅니다.
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

----> (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있습니다.

${image_jemok} ----> 이와 같이 일련번호와 설명을 다음줄에 입력합니다. [엔터] 만 치면, 챕터 입력으로 갑니다.
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


/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /

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

/ / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / / /
----> 윗줄을 복사해서 사용합니다.
__EOF__
				fi
			done #-- until [ "x$image_jemok" = "x" ]
		fi #-- if [ "x$a" = "x" ]; then #-- 요약제목 없으면,

	fi #-- ChapterSeq="" 이므로 끝낸다.

done #-- until [ "x$ChapterSeq" = "x" ]

echo "----> Thank_you for using $0 ~~~"
