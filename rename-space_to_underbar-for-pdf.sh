#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 

find ./ -type f | while read file_name
do
	if [ "${file_name:(-4)}" = ".pdf" ]; then
		fn=${file_name:2} #-- find ./ 했으므로 '쩜슬레시' 2 글자를 뺀다.
		under_bar_name=$(echo $fn | sed 's/ /_/g')
		cmdYenter "mv \"${fn}\" $(date +'%y%m%d')-${under_bar_name}" "이름에서 'space' 를 '_' 로 바꾸고 앞에 날짜를 붙입니다."
	fi
done
