#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="rclone 사이즈 확인"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cmdRun "rclone size kaosb2mi:"
cmdRun "rclone size kaosb3mi:"
cmdRun "rclone size kaosb4mi:"
cmdRun "rclone size kaosbmi:"
cmdRun "rclone size kaosngc:"
cmdRun "rclone size swlibgc:"
cmdRun "rclone size yosjgc:"


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
