#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
if [ "x$1" = "x" ]; then
	that_year=$(date +"%Y")
	MEMO="클라우드 ${that_year} 년도 백업 확인"
else
	that_year=$1
	MEMO="클라우드 ${cYellow}${that_year}${cMagenta} 년도 백업 확인"
fi
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
#-- zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
#-- zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


#-- LsVal="lsl" ; KeyVal="4"
LsVal="ls" ; KeyVal="2"

echo "${cYellow}----> rclone ${LsVal} yosjgc:11-wiki.js/${that_year}/ --include \"/wiki*\" | sort -k${KeyVal}${cGreen}"
rclone ${LsVal} yosjgc:11-wiki.js/${that_year}/ --include "/wiki*" | sort -k${KeyVal}
echo "${cCyan}$(rclone ${LsVal} yosjgc:11-wiki.js/${that_year}/ --include '*ju/wiki*' | sort -k${KeyVal})"
echo "${cGreen}$(rclone ${LsVal} yosjgc:11-wiki.js/${that_year}/ --include '*yoil/wiki*' | sort -k${KeyVal})"
echo "${cYellow}----> rclone ${LsVal} swlibgc:gate242/${that_year}/ --include \"/gate242*\" | sort -k${KeyVal}${cBlue}"
rclone ${LsVal} swlibgc:gate242/${that_year}/ --include "/gate242*" | sort -k${KeyVal}
echo "${cYellow}----> rclone ${LsVal} kaosngc:db-backup/kaosorder2/ --include \"/[km]*\" | sort -k${KeyVal}${cCyan}"
rclone ${LsVal} kaosngc:db-backup/kaosorder2/ --include "/[km]*" | sort -k${KeyVal}


# ----
#-- rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
#-- ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
