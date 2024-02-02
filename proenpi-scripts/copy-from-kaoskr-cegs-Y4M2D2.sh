#!/bin/sh

CMD_NAME=`basename $0` ; CMD_DIR=${0%/$CMD_NAME} ; if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then CMD_DIR="." ; fi
cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cmdRun () {
	if [ "x${prompt_ok}" = "xok" ]; then
		echo "${cCyan}----> ${cYellow}$1 ${cGreen}#-- ${cCyan}$2${cReset}"; echo "$1" | sh
		echo "${cGreen}<---- ${cBlue}$1 ${cGreen}#-- $2${cReset}"
	else
		echo "$1" | sh
	fi
}
cmdCont () {
	if [ "x${prompt_ok}" = "xok" ]; then
		echo -e "${cCyan}----> ${cYellow}$1 ${cGreen}#-- ${cCyan}$2\n----> ${cMagenta}Enter ${cGreen}to continue${cReset}:"
		read a ; echo "${cUp}"; echo "$1" | sh
		echo "${cGreen}<---- ${cBlue}$1 ${cGreen}#-- $2${cReset}"
	else
		echo "$1" | sh
	fi
}
ALL_INSTALL="n"
cmdYenter () {
	if [ "x${prompt_ok}" = "xok" ]; then
		echo "${cCyan}----> ${cYellow}$1 ${cGreen}#-- ${cCyan}$2${cReset}"
		if [ "x${ALL_INSTALL}" = "xy" ]; then
			echo "$1" | sh ; echo "${cGreen}<---- ${cBlue}$1 ${cMagenta}#-- $2${cReset}"
		else
			echo "${cCyan}----> ${cRed}press ${cCyan}'${cYellow}y${cCyan}'${cRed} or Enter${cReset}:"; read a; echo "${cUp}"
			if [ "x$a" = "xy" ]; then
				echo "${cRed}-OK-${cReset}"; echo "$1" | sh
				echo "${cGreen}<---- ${cBlue}$1 press 'y' or Enter: ${cMagenta}#-- $2${cReset}"
			else
				echo "${cRed}[ ${cBlue}$1 ${cRed}] ${cMagenta}<--- 명령을 실행하지 않습니다.${cReset}"
			fi
		fi
	else
		echo "$1" | sh
	fi
}
eSq=0
eSqMsg=""
echoSeq () {
	if [ "x${prompt_ok}" = "xok" ]; then
		if [ "x$1" = "x" ]; then
			echo "${cBlue}(${eSq}) ${eSqMsg}${cReset}" ; echo "${cBlue}#--${cReset}"
		else
			eSq=$(( ${eSq} + 1 ))
			echo "${cMagenta}(${eSq}) ${cCyan}$1${cReset}"
			eSqMsg=$1
		fi
	fi
}
cmdTTbegin () {
	if [ "x${prompt_ok}" = "xok" ]; then
		echo "${cCyan}----> ${cRed}$1${cReset}"
	fi
}
cmdTTend () {
	if [ "x${prompt_ok}" = "xok" ]; then
		echo "${cBlue}<---- ${cMagenta}$1${cReset}"
	fi
}
#-- source ${HOME}/bin/color_base #-- edit: 230215수-2251 , 230207화-1201 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq cmdTTbegin cmdTTend

# MEMO="kaos 데이터 백업받기"
# cat <<__EOF__
# ${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
# __EOF__

zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir -p ${zz00logs_folder}" "로그 폴더" ; fi

# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----

if [ "x$1" = "x" ]; then
	y2m2d2=$(date +%y%m%d)
	prompt_ok="no" #-- 년월일을 입력하지 않은 것은 crontab 으로 실행한 것으로 보고, 화면에 표시하지 않는다.
else
	y2m2d2=$1
	prompt_ok="ok"
fi
if [[ "@${y2m2d2}" < "@220101" ]] || [[ "@${y2m2d2}" > "@991231" ]]; then
	if [ "x${prompt_ok}" = "ok" ]; then
		cat <<__EOF__
${cCyan}
----> ${cYellow}${y2m2d2}${cCyan}
----> ${cRed}YY${cMagenta}MM${cRed}DD ${cCyan} 스크립트 이름 다음에, ${cRed}년도 끝 2자리, ${cMagenta}월 2자리, ${cRed}일 2자리 ${cCyan} 를 입력하세요.
${cReset}
__EOF__
	fi
	exit -1
fi

y2=${y2m2d2:0:2}
y4="20${y2}"
m2=${y2m2d2:2:2}
d2=${y2m2d2:4:2}
pscode=zkdhtm${y4}

cd ${zz00logs_folder} #-- 아래에서 local_opt_backup_kaosdb_Y4_basename_m2 에 절대경로를 줬기 때문에 의미없다.

#--- cadbase emailbase georaebase scanbase ---#

for cegs_base in cadbase emailbase georaebase scanbase
do
	server_var_base_basename_Y4M2D2=/var/base/${cegs_base}/${y4}/${m2}/${d2} #-- kaos server 로컬 디렉토리 #-- /var/base/cadbase/2023/02/15
	cloud_kaosdb_Y4_basename_M2=kaosdb/${y4}/${cegs_base}/${m2} #-- 클라우드쪽 폴더 #-- kaosdb/2023/cadbase/02
	local_opt_backup_kaosdb_Y4_basename_m2=/opt/backup/${cloud_kaosdb_Y4_basename_M2} #-- crontab 쪽 디렉토리 #-- /opt/backup/kaosdb/2023/cadbase/02

	if [ ! -d "${local_opt_backup_kaosdb_Y4_basename_m2}" ]; then
		cmdRun "mkdir -p ${local_opt_backup_kaosdb_Y4_basename_m2} ; ls -l ${local_opt_backup_kaosdb_Y4_basename_m2}/../" "(1) 백업할 폴더를 만듭니다."
	fi
	cmdRun "rm -rf ${local_opt_backup_kaosdb_Y4_basename_m2}/${y2m2d2}-${cegs_base}*" "(2) 이전에 있던 지정일자 파일을 지웁니다."

	if [ "x${prompt_ok}" = "ok" ]; then
		echo "${cCyan}#-- rsync kaosco@kaos.kr:${server_var_base_basename_Y4M2D2} ---> ${local_opt_backup_kaosdb_Y4_basename_m2}/ ${cGreen}#-- (3) ${cMagenta}호스트에서 로컬로 백업파일을 복사합니다.${cReset}"
	fi
	time rsync -avzr --delete --rsh="/usr/bin/sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -oHostKeyAlgorithms=+ssh-dss -Y -p2022 -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@kaos.kr:${server_var_base_basename_Y4M2D2} ${local_opt_backup_kaosdb_Y4_basename_m2}/

	if [ ! -d ${local_opt_backup_kaosdb_Y4_basename_m2}/${d2} ]; then
		cmdRun "ls -lR ${local_opt_backup_kaosdb_Y4_basename_m2}/" "(4) 복사한 ${d2}일 파일이 없습니다."
	else
		ymdHMS=$(date +%y%m%d-%H%M%S)
		cmdRun "ls -alR ${local_opt_backup_kaosdb_Y4_basename_m2}/${d2}/ > ${local_opt_backup_kaosdb_Y4_basename_m2}/${y2m2d2}-${cegs_base}-${ymdHMS}.ls-alR" "(5) 목록을 만들고, 7za a -mx=9 -p ${local_opt_backup_kaosdb_Y4_basename_m2} 디렉토리를 압축합니다.${cReset}"
		time 7za a -mx=9 -p${pscode} ${local_opt_backup_kaosdb_Y4_basename_m2}/${y2m2d2}-${cegs_base}-${ymdHMS}.7z ${local_opt_backup_kaosdb_Y4_basename_m2}/${d2}
		cmdRun "rm -rf ${local_opt_backup_kaosdb_Y4_basename_m2}/${d2}" "(6) 압축했으므로 백업한 디렉토리는 지웁니다."

		cmdRun "rclone delete kaosngc:${cloud_kaosdb_Y4_basename_M2} --include \"${y2m2d2}-${cegs_base}*\"" "(7) 복사하기전 클라우드에 동일 날짜 데이터를 삭제합니다."
		cmdRun "rclone copy ${local_opt_backup_kaosdb_Y4_basename_m2} --include \"${y2m2d2}-${cegs_base}*\" kaosngc:${cloud_kaosdb_Y4_basename_M2}" "(8) 로컬 파일들을 kaosngc: 클라우드로 복사합니다."
		cmdRun "rclone ls kaosngc:${cloud_kaosdb_Y4_basename_M2}" "(9) 클라우드 확인"
	fi
done

#--- kaosorder2 ---#

#-- kaos server 로컬 디렉토리 #-- 이 폴더의 base_db 이름이 달라서 위 for 문에 넣지 못했음.
cloud_kaosdb_Y4_basename_M2=kaosdb/${y4}/kaosorder2/${m2} #-- 클라우드쪽 폴더 #-- kaosdb/2023/kaosorder2/02
local_opt_backup_kaosdb_Y4_basename_m2=/opt/backup/${cloud_kaosdb_Y4_basename_M2} #-- crontab 쪽 디렉토리 #-- /opt/backup/kaosdb/2023/kaosorder2/02

if [ ! -d "${local_opt_backup_kaosdb_Y4_basename_m2}" ]; then
	cmdRun "mkdir -p ${local_opt_backup_kaosdb_Y4_basename_m2} ; ls -l ${local_opt_backup_kaosdb_Y4_basename_m2}/../" "(11) 백업할 폴더를 만듭니다."
fi
cmdRun "rm -rf ${local_opt_backup_kaosdb_Y4_basename_m2}/kaosorder2_${y2m2d2}*" "(12) 이전에 있던 지정일자 파일을 지웁니다."

if [ "x${prompt_ok}" = "ok" ]; then
	echo "${cCyan}#-- time rsync -avzr --delete --rsh=\"/usr/bin/sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -oHostKeyAlgorithms=+ssh-dss -Y -p2022 -o StrictHostKeyChecking=no -l kaosco\" --no-o --no-g --delete kaosco@kaos.kr:/var/base_db/kaosorder2/${y4}/${m2}/kaosorder2_${y2m2d2}* ${local_opt_backup_kaosdb_Y4_basename_m2}/ ${cGreen}#-- (13) ${cMagenta}호스트에서 로컬로 백업파일을 복사합니다.${cReset}"
fi
time rsync -avzr --delete --rsh="/usr/bin/sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -oHostKeyAlgorithms=+ssh-dss -Y -p2022 -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@kaos.kr:/var/base_db/kaosorder2/${y4}/${m2}/kaosorder2_${y2m2d2}* ${local_opt_backup_kaosdb_Y4_basename_m2}/

cmdRun "rclone delete kaosngc:${cloud_kaosdb_Y4_basename_M2} --include \"kaosorder2_${y2m2d2}*\"" "(15) 복사하기전 클라우드에 동일 날짜 데이터를 삭제합니다."
cmdRun "rclone copy ${local_opt_backup_kaosdb_Y4_basename_m2} --include \"kaosorder2_${y2m2d2}*\" kaosngc:${cloud_kaosdb_Y4_basename_M2}" "(16) 로컬 파일들을 kaosngc: 클라우드로 복사합니다."
# /var/base_db/kaosorder2/2023/02/kaosorder2_230205-221001.sql.7z  ~/zz00logs/kaos-2023/kaosorder2-2023/02/kaosorder2_230215-221001.sql.7z 
cmdRun "rclone ls kaosngc:${cloud_kaosdb_Y4_basename_M2}" "(17) 클라우드 확인"


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
# cat <<__EOF__
# ${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
# __EOF__
