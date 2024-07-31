#!/bin/sh

if [ ! -f $1 ]; then
	echo "#-- $1 파일이 없습니다."
	exit -1
fi

while IFS= read -r line
do
	if [[ $line == "Figure "* ]]; then
		if [[ $line == *": "* ]]; then
			fig_memo=$(echo $line | awk -F": " '{print $2}')
			fig_num=$(echo $line | awk -F": " '{print $1}')
			chapter_numb=$(echo ${fig_num} | awk '{print $2}')
			fig_title=$(echo $fig_memo | awk '{print $1" "$2" "$3}')
			small_fig_title=$(echo "${fig_title,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
			echo "![ ${chapter_numb} ${fig_memo} ](/packtpub/2024/730/${chapter_numb}-${small_fig_title}.webp)     ${chapter_numb}-${small_fig_title}.webp"
		fi
	fi
done < $1
