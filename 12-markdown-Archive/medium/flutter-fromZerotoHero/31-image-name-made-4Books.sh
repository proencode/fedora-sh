#!/bin/sh

if [ "x$1" = "x" ]; then
	image_dir="books_img"
else
	image_dir="${1}"
fi

cat <<__EOF__
----> Enter image folder name: or just Enter for [ ${image_dir} ]
__EOF__
read a

if [ "x$a" != "x" ]; then
	image_dir="$a"
fi
cat <<__EOF__
.... Image folder name is [ ${image_dir} ]
__EOF__

enter_string="1.1 Flutter From Zero to Hero LOGO"

until [ "x$enter_string" = "x" ]
do
	cat <<__EOF__

${enter_string} ----> 이와 같이 일련번호와 설명을 다음줄에 입력한다.
__EOF__
	read enter_string
	if [ "x$enter_string" != "x" ]; then
		img_name=$(echo "figure${enter_string,,}" | sed 's/ /_/g') #-- 전부 대문자로 바꾸려면 ${enter_string^^}, 전부 소문자는 ${enter_string,,}
		cat <<__EOF__

![ Figure${enter_string} ](/${image_dir}/${img_name}.png .webp)
----> 윗줄을 복사해서 사용한다.
__EOF__
	fi
done
echo "----> Thank_you for using $0 ~~~"
