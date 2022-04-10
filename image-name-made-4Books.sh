#!/bin/sh

if [ "x$1" = "x" ]; then
	image_folder="books_img"
else
	image_folder="${1}"
fi

cat <<__EOF__
----> Enter image folder name:
      or just Enter for [ ${image_folder} ]
---->
__EOF__
read a

if [ "x$a" != "x" ]; then
	image_folder="$a"
fi
cat <<__EOF__
.... Image folder name is [ ${image_folder} ]


__EOF__

a="-ok-"

until [ "x$a" = "x" ]
do
	echo "----> Please_Enter_A_Sentence:"
	read a
	if [ "x$a" != "x" ]; then
		echo " "
		echo "![ ${a} ](/${image_folder}/${a,,})" | sed 's/ /_/g' #-- 전부 대문자로 바꾸려면 ${a^^}, 전부 소문자는 ${a,,}
		echo " "
	fi
done
echo "----> Thank_you for using $0 ~~~"
