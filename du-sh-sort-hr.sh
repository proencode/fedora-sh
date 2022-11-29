#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
# MEMO="디렉토리의 파일별 사이즈를 표시"
# cat <<__EOF__
# ${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
# __EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----

zz00logs=zz00logs
if [ ! -d "${zz00logs}" ]; then
	cmdRun "mkdir -p ${zz00logs}" "로그를 담는 디렉토리를 만듭니다."
fi
fname=zz.du-sh-sort-hr
if [ "x$1" = "x" ]; then
	cnt=15
else
	cnt=$1
	if [ "x$2" != "x" ]; then
		fname=$2
	fi
fi
now=$(date +"%H:%M:%S")
fDirName=${zz00logs}/${fname}.$(date +"%y%m%d%a-%H%M%S")


MEMO="[줄수=${cnt}] [파일명=${fDirName}]"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cBlue}
__EOF__
ls ${zz00logs}


sudo du -sh * .??* | sort -hr > ${fDirName}
echo -e "${cReset}$(head -${cnt} ${fDirName})"


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
