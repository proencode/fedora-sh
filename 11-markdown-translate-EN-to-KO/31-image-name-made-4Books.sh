#!/bin/sh

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

cat <<__EOF__

----> press Enter: $a [ ${publisher} ]
__EOF__
read a
copy_publ=$(echo "${publisher,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.

#--

cat <<__EOF__
----> Book Cover Name: 폴더 이름으로 쓰기 위한것. (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있음.
__EOF__
read BookCover

if [ "x$BookCover" = "x" ]; then
	exit 1
fi

copy_book=$(echo "${BookCover,,}" | sed 's/ /_/g') #-- 소문자로 바꾸고 공백을 밑줄로 바꾼다.
book_cover_dir="/${copy_publ}/${copy_book}/"

cat <<__EOF__

----> press Enter: [ ${BookCover} : ${book_cover_dir} ]
__EOF__
read a

#--

enter_string="1.1 Flutter From Zero to Hero LOGO"

until [ "x$enter_string" = "x" ]
do
	cat <<__EOF__

----> (대,소문자, 숫자,  ., -, _, 빈칸) 만 쓸 수 있음.

${enter_string} ----> 이와 같이 일련번호와 설명을 다음줄에 입력한다.
__EOF__
	read enter_string
	if [ "x$enter_string" != "x" ]; then
		img_name=$(echo "${enter_string,,}" | sed 's/ /_/g') #-- 전부 대문자로 바꾸려면 ${enter_string^^}, 전부 소문자는 ${enter_string,,}
		cat <<__EOF__

![ ${enter_string} ](${book_cover_dir}${img_name}.png
----> 윗줄을 복사해서 사용한다.
__EOF__
	fi
done
echo "----> Thank_you for using $0 ~~~"
