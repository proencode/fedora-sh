#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="rclone 사이즈 확인"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
${cCyan}#--
#-- 이 스크립트 실행시 "${cYellow}wiki${cCyan}" 파라미터를 추가하면, 결과를 ${cMagenta}wiki.js 마크다운${cCyan}으로 보여줍니다.
#-- ${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


if [ "x$1" = "xwiki" ]; then
	echo "${cRed}----> 완료까지 1분정도 기다려 주세요. <----${cReset}"
fi
for hostname in kaos1mi  kaos2mi  kaos3mi  kaos4mi  yosjgc  kaosngc  swlibgc  tpnote1mi  tpnote2mi  y5dnmi  y5ncmi  yosjgc
do
	if [ "x$1" = "xwiki" ]; then
		#-- 이 스크립트 실행시 "wiki" 파라미터를 추가하면, 결과를 wiki.js 마크다운으로 보여준다.
		cmdRun "rclone about ${hostname}:" "$(date +"%y%m%d%a-%H%M") ${USER}@$(uname -n)" | grep -v "|||" | grep -v "<----" | sed 's/---->/####/'
	else
		cmdRun "rclone about ${hostname}:" "$(date +"%y%m%d%a-%H%M") ${USER}@$(uname -n)"
	fi
done


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
