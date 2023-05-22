#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
cut_some_char () {
	#-- " str_01 " == 빈칸을 밑줄로.
	local str_01=$(echo ${original_file_name} | sed 's/ /_/g')
	#-- " str_02 " == 대문자를 소문자로.
	# https://varie.tistory.com/entry/Bash%EC%89%98%EC%97%90%EC%84%9C-%ED%8C%8C%EC%9D%BC%EB%AA%85-%EC%9D%BC%EA%B4%84-%EB%8C%80%EC%86%8C%EB%AC%B8%EC%9E%90-%EB%B3%80%ED%99%98
	local str_02=$(echo ${str_01,,})
	#-- 소문자를 대문자로 바꿀때는: str_02=$(echo ${str_01^^})
	#-- bash3.x 인 경우: str_02=$(echo ${str_01} | tr '[A-Z]' '[a-z]')
	#-- "str_03 " == 특수문자 삭제하거나 변경
	new_name=$(echo ${str_02} | sed 's/(/./g' | sed 's/)/./g' | sed 's/;/./g' | sed 's/</./g' | sed 's/>/./g' | sed 's/\[/./g' | sed 's/\]/./g' | sed 's/\//./g' | sed 's/+/./g')
}

cmdRun "ls -l" "수정 전"
find ./ -type f | while read file_name
do
	if [ "${file_name:(-4)}" = ".pdf" ]; then
		original_file_name=${file_name:2} #-- 'find ./' 했으므로 '쩜' 과 '슬레시' 두 글자를 뺀다.
		cut_some_char
		cmdRun "mv '${original_file_name}' $(date +'%y%m%d_%H%M')-${new_name}" "이름에서 특수문자를 바꾸고 앞에 변경일시를 붙입니다."
	fi
done
cmdRun "ls -l" "수정 후"
