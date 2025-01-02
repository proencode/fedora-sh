#!/bin/sh

source ${HOME}/bin/color_base #-- 230524수 0828 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq cmdTTbegin cmdTTend ding_play change_special_char () <== original_file_name ==> new_name

if [ "x$1" = "x" ]; then
	file_type="txt"
else
	file_type="$1"
fi
type_len="-${#file_type}" #-- ${#str_name} = length of the string. https://www.geeksforgeeks.org/how-to-find-length-of-string-in-bash-script/

find ./ -type f | while read file_name
do
	if [ "${file_name:(${type_len})}" = "${file_type}" ]; then
		#echo "file_name ${file_name}; type_len ${type_len}; file_type ${file_type};"
		#echo "\${file_name:(${type_len})}; ${file_name:(${type_len})};"
		original_file_name=${file_name:2} #-- 'find ./' 했으므로 '쩜' 과 '슬레시' 두 글자를 뺀다.
		change_special_char # <== original_file_name ==> new_name
		# cmdRun "mv '${original_file_name}' $(date +'%y%m%d_%H%M')-${new_name}" "이름에서 특수문자를 바꾸고 앞에 변경일시를 붙입니다."
		if [ "x${original_file_name}" != "x${new_name}" ]; then
			# cmdRun "ls -l '${original_file_name:0:(-4)}'*" "수정 전"
			cmdRun "mv '${original_file_name}' ${new_name}" "이름에서 특수문자를 바꾸고 앞에 변경일시를 붙입니다."
			# cmdRun "ls -l '${new_name:0:(-4)}'*" "수정 후"
		# else
			# cmdRun "ls -l '${new_name:0:(-4)}'*" "특수문자가 없습니다."
		fi
	fi
done
