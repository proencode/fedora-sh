#!/bin/sh

if [ "x$1" == "x" ] || [ ! -f $1 ]; then
	echo "#-- $1 파일이 없습니다."
	ls -l *.md | sed 's/-rw-rw-r-- 1 ${USER} ${USER}//'
	exit -1
fi
img_link="/packtpub/2024/1118"
echo "#-- 이미지를 보관하기 위한 wiki 의 폴더: [ ${img_link} ]"
read a
if [ "x$a" != "x" ]; then
	img_link=$a
fi
cat <<__EOF__

문서에
	" Figure 6.4: A video with caption"
이와 같이 되어 있으면,

![ 6.4 A video with caption ](/packtpub/2024/1118/6.4-a_video_with.webp)
6.4-a_video_with.webp

위와같이 표시됩니다.

__EOF__

while IFS= read -r line #-- $1 으로 지정된 파일을 한줄씩 읽어서 $line 에 담는다.
do
	#-- Figure 6.4: A video with caption text stating, “This is the caption text”
	#---^fig_num^^||^:^^^^^:^^^^|^^^^^^^^^^^fig_memo^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	#---^^^^^^|^^^||^:^^^^^:^^^^|
	#-chapter_numb||^^fig_title^^
	if [[ $line == "Figure "* ]]; then
		if [[ $line == *": "* ]]; then
			#-- A video with caption text stating, “This is the caption text”
			fig_memo=$(echo $line | awk -F": " '{print $2}')
			#-- Figure 6.4
			fig_num=$(echo $line | awk -F": " '{print $1}')
			#-- 6.4
			chapter_numb=$(echo ${fig_num} | awk '{print $2}')
			#-- A video with
			fig_title=$(echo $fig_memo | awk '{print $1" "$2" "$3}')
			#-- a_video_with
			small_fig_title=$(echo "${fig_title,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g")
			cat <<__EOF__
![ ${chapter_numb} ${fig_memo} ](${img_link}/${chapter_numb}-${small_fig_title}.webp)
${chapter_numb}-${small_fig_title}.webp
__EOF__
		fi
	fi
done < $1
