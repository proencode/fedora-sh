#!/bin/sh

source ${HOME}/bin/color_base #-- 230524수 0828 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq cmdTTbegin cmdTTend ding_play change_special_char () <== original_file_name ==> new_name

if [ "x$1" = "x" ]; then
	echo "----> $0 file_name 을 지정해야 합니다."
else
	original_file_name="$1"
	change_special_char # <== original_file_name ==> new_name
	if [ "x${original_file_name}" != "x${new_name}" ]; then
		cmdRun "ls -l '${original_file_name:0:(-4)}'*" "수정 전"
		cmdRun "mv '${original_file_name}' ${new_name}" "이름에서 특수문자를 바꾸고 앞에 변경일시를 붙입니다."
		cmdRun "ls -l '${new_name:0:(-4)}'*" "수정 후"
	else
		cmdRun "ls -l '${new_name:0:(-4)}'*" "특수문자가 없습니다."
	fi
fi
