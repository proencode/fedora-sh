#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="rclone 의 모든 클라우드에서 특정 파일이름 찾기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
#- zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
#- zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cloud_names=("yosjgc"
	"swlibgc"
	"kaosngc"
	"kaosbmi"
	"kaosb2mi"
	"kaosb3mi"
	"kaosb4mi"
	"tpnotemi"
	"tpnote2mi"
)
if [ "x$1" = "x" ]; then
	cat <<__EOF__

${cRed}!!!!> 사용법: ${cReset}$0 [찾으려는 파일의 문자열] ${cRed}<---- 이와 같이 문자열을 입력하세요.${cReset}
__EOF__
	exit 1
else
	call_string="$1"
	for cloud in ${cloud_names[@]}
	do
		cmdRun "rclone lsf ${cloud}: --include \"*${call_string}**\""
	done
fi


# ----
#- rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
#- ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
