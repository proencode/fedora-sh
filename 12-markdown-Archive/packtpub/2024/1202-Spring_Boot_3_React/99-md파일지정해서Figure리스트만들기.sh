#!/bin/sh

if [ "x$1" == "x" ] || [ ! -f $1 ]; then
	echo "#-- $1 파일이 없습니다."
	ls -l *.md | sed 's/-rw-rw-r-- 1 ${USER} ${USER}//'
	exit -1
fi

#--
#-- (1-5) 책에 맞추어 수정하는 부분.
#-- vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
#-- -------------------------------------------------------------
Publisher="packtpub" #-- (1) 출판사 --
BookJemok="Full Stack Development with Spring Boot 3 and React 4Ed" #-- 책 이름
TypingYear="2024" #-- 입력년도
TypingMmDd="1202" #-- 입력월일
TypingJemok="Spring Boot 3 React" #-- 짧은 제목
AuthorDate="Juha Hinkula / Oct 2023 / 454 pages 4Ed" #-- 저자등 설명
https_line="https://subscription.packtpub.com/book/web-development/9781805122463/pref" #-- 책 링크
img_dir="img-${Publisher}_${TypingYear}_${TypingMmDd}" #-- 이미지 저장 폴더
if [ ! -d ${img_dir} ]; then
	echo "#-- mkdir -p ${img_dir}"
	mkdir -p ${img_dir}
fi
#-- -------------------------------------------------------------
#-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
#--

img_link="img-${Publisher}_${TypingYear}_${TypingMmDd}" #-- 이미지 저장 폴더
if [ ! -d ${img_dir} ]; then
	echo "#-- mkdir -p ${img_dir}"
	mkdir -p ${img_dir}
fi
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

			third_word=$(echo $fig_memo | awk '{print $3}')
			if [ "x${third_word}" == "x" ]; then
				second_word=$(echo $fig_memo | awk '{print $2}')
				if [ "x${second_word}" == "x" ]; then
					fig_title=$(echo $fig_memo | awk '{print $1}')
				else
					fig_title=$(echo $fig_memo | awk '{print $1" "$2}')
				fi
			else
				fig_title=$(echo $fig_memo | awk '{print $1" "$2" "$3}')
			fi

			#-- a_video_with
			small_fig_title=$(echo "${fig_title,,}" | sed 's/ /_/g' | sed 's/\./_/g' | sed 's/“/\"/g' | sed 's/”/\"/g' | sed "s/’/'/g" | sed 's/(//g' | sed "s/)//g")
			cat <<__EOF__
![ ${chapter_numb} ${fig_memo} ](${img_link}/${chapter_numb}-${small_fig_title}.webp)
${chapter_numb}-${small_fig_title}.webp
__EOF__
		fi
	fi
done < $1
