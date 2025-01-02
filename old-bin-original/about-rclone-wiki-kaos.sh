#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="rclone 사이즈 확인"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}

__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----

y4m2=$(date +%Y%m)
cat <<__EOF__
----> base 파일의 년월: [${y4m2}]"
__EOF__
read a
if [ "x$a" = "x" ]; then
	a=${y4m2}
fi
y4m2=${a}
y4=${y4m2:0:4}
m2=${y4m2:4:2}

cmdRun "rclone lsf kaosngc:kaosdb/$(date +%Y)/kaosorder2/$(date +%m) | tail -4"

for base_name in cadbase emailbase georaebase scanbase
do
	cmdRun "rclone lsf kaosngc:kaosdb/${y4}/${base_name}/${m2} | tail -4"
done

# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
