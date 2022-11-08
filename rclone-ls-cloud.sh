#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="클라우드 백업내용 보기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
#-- zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
#-- zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


that_year=$(date +"%Y")
echo "${cYellow}----> rclone lsl yosjgc:11-wiki.js/2022/ --include \"/wiki*\" | sort -k4${cGreen}"
rclone lsl yosjgc:11-wiki.js/2022/ --include "/wiki*" | sort -k4
echo "${cCyan}$(rclone lsl yosjgc:11-wiki.js/2022/ --include '*ju/wiki*' | sort -k4)"
echo "${cGreen}$(rclone lsl yosjgc:11-wiki.js/2022/ --include '*yoil/wiki*' | sort -k4)"
echo "${cYellow}----> rclone lsl swlibgc:gate242/2022/ --include \"/gate242*\" | sort -k4${cBlue}"
rclone lsl swlibgc:gate242/2022/ --include "/gate242*" | sort -k4
echo "${cYellow}----> rclone lsl kaosngc:db-backup/kaosorder2/ --include \"/[km]*\" | sort -k4${cCyan}"
rclone lsl kaosngc:db-backup/kaosorder2/ --include "/[km]*" | sort -k4


# ----
#-- rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
#-- ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
