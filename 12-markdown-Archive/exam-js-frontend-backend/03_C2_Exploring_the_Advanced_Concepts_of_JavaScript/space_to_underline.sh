#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
# MEMO="arg1 [$1] 의 빈칸을 언더라인으로 바꾸기"
# cat <<__EOF__
# ${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
# __EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


if [ "x$2" = "x" ]; then
	echo "${cRed}!!!!> ${cGreen}$0 ${cMagenta}[${cGreen}스크립트의 일련번호${cMagenta}] [${cGreen}이름을 위한 메세지${cMagenta}] ${cBlue}----> 이와 같이 입력해야 합니다.${cReset}"
	exit 1
fi

anumber=$1
aspace=$2

aunder=$(echo ${aspace} | sed -e 's/ /_/g')
aname="${anumber}-${aunder}.js"

vi ${aname}

if [ -f ${aname} ]; then
	cmdRun "node ${aname}" "자바스크립트를 실행합니다."
	cmdRun "cat ${aname}" "입력한 자바스크립트 내용"
	ls
fi


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
# cat <<__EOF__
# ${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
# __EOF__
