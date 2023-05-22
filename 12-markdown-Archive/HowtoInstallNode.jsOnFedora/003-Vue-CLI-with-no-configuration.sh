#!/bin/sh

source ${HOME}/lib/color_base
zz00log_name="${CMD_DIR}/zz.$(date +"%y%m%d%a%H:%M:%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name} #-- 작업진행 시작
MEMO="설정 없이 Cue CLI 실행"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"


cat_and_run "mkdir noConfig ; cd noConfig" "(1) Vue CLI with no configuration"
cat_and_run "code ." "(2) start VS Code"


echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
rm -f ${zz00log_name} ; zz00log_name="${CMD_DIR}/zz.$(date +"%y%m%d%a%H:%M:%S")..${CMD_NAME}" ; touch ${zz00log_name} #-- 작업 마무리
ls --color ${CMD_DIR}/zz.*
