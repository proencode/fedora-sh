#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cmdRun () {
	echo "${cYellow}----> ${cCyan}$1 ${cGreen}#-- ${cBlue}$2${cReset}"; echo "$1" | sh
	echo "${cGreen}<---- ${cBlue}$1 ${cGreen}#-- ${cBlue}$2${cReset}"
}
cmdCont () {
	echo -e "${cYellow}----> ${cCyan}$1 ${cGreen}#-- ${cBlue}$2\n----> ${cMagenta}Enter ${cGreen}to continue${cReset}:"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cGreen}<---- ${cBlue}$1 ${cGreen}#-- ${cBlue}$2${cReset}"
}
ALL_INSTALL="n"
cmdYenter () {
	echo "${cYellow}----> ${cCyan}$1 ${cGreen}#-- ${cBlue}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cGreen}<---- ${cBlue}$1 ${cMagenta}#-- ${cBlue}$2${cReset}"
	else
		echo "${cYellow}----> ${cRed}press ${cCyan}'${cYellow}y${cCyan}'${cRed} or Enter${cReset}:"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
			echo "${cGreen}<---- ${cBlue}$1 press 'y' or Enter: ${cMagenta}#-- ${cBlue}$2${cReset}"
		else
			echo "${cRed}[ ${cBlue}$1 ${cRed}] ${cMagenta}<--- 명령을 실행하지 않습니다.${cReset}"
		fi
	fi
}
eSq=0
eSqMsg=""
echoSeq () {
	if [ "x$1" = "x" ]; then
		echo "${cBlue}(${eSq}) ${eSqMsg}${cReset}" ; echo "${cBlue}#--${cReset}"
	else
		eSq=$(( ${eSq} + 1 ))
		echo "${cMagenta}(${eSq}) ${cCyan}$1${cReset}"
		eSqMsg=$1
	fi
}
cmdTTbegin () {
	echo "${cYellow}----> ${cRed}$1${cReset}"
}
cmdTTend () {
	echo "${cBlue}<---- ${cMagenta}$1${cReset}"
}

#--xx-- source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="백업파일을 wikijsdb 컨테이너의 wiki 데이터베이스로 리스토어 하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


if [ "x$1" != "x" ]; then
	db_sql_7z="$1"
else
	cat <<__EOF__
${cBlue}#-
#- 리스토어 할 sql.7z 파일 위치 및 이름을 [ /media/sf_Downloads/wiki_220906화-1802_proenpi4b.36ju.sql.7z ] 처럼 입력하세요.
#-${cReset}
__EOF__
	read db_sql_7z
fi
if [ "x${db_sql_7z}" = "x" ]; then
	cat <<__EOF__
${cBlue}# !
# ! wiki 데이터베이스에 리스토어 하기 위한 백업파일 이름을 지정해야 합니다.
# !${cReset}
__EOF__
	exit 1
fi
if [ ! -f "${db_sql_7z}" ]; then
	cat <<__EOF__
${cBlue}# !
# ! --${db_sql_7z}-- 백업파일이 없습니다.
# !${cReset}
__EOF__
	exit 2
fi
cat <<__EOF__
${cBlue}#-
#- 현재 운영중인 데이터베이스를 백업하려고 합니다.
#-
#- 만일 ${cRed}백업할 필요가 없다면 ${cYellow}'n' ${cBlue}을 눌러 주세요.
#-${cReset}
__EOF__
read a ; echo "[ $a ]"
last_skip="backup_ok"
if [ "x$a" = 'xn' ]; then
	cat <<__EOF__
${cBlue}#-
#-
#-
#- ${cMagenta}!!!! 주의 !!!! ${cRed}현재 운영중인 데이터베이스를 다운로드 + 백업 하지않고${cBlue}, 이전의 백업을 리스토어 합니다.
#-
#- ----> 맞으면 ${cYellow}'y' ${cBlue}를 눌러 주세요.
#-${cReset}
__EOF__
	read a ; echo "[ $a ]"
	if [ "x$a" != "xy" ]; then
		exit 3
	fi
	last_skip="no_backup"
fi
# DB_NAME="wiki" #-- 백업할 데이터베이스 이름
# LOGIN_PATH="wikipsql" #-- 데이터베이스 로그인 패쓰 ;;; pgsql 이라서 쓰지는 않음.
# LOCAL_FOLDER="/home/backup/wiki.js" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
# REMOTE_FOLDER="wiki.js" #-- 원격 저장소의 첫번째 폴더 이름
# RCLONE_NAME="yosgc" #-- rclone 이름 yosjeongc
# DB_TYPE="pgsql"

LOCAL_FOLDER="/home/backup/" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
dir_for_backup=${LOCAL_FOLDER}/last_backup_b4_restore #-- 백업을 리스토어 하기전, 현재DB 백업하는 로컬 저장소
if [ ! -d ${dir_for_backup} ]; then
	cmdRun "sudo mkdir -p ${dir_for_backup} ; sudo chown ${USER}:${USER} ${dir_for_backup}" "#-- (1) 현재 운영중인 DB 를 백업하는 로컬 저장소 만듭니다."
fi

cmdRun "sudo docker ps -a ; sudo docker stop wikijs ; sudo docker ps -a" "#-- (2) 백업을 위해 pgsql 도커를 중단합니다."

if [ "x${last_skip}" = "xbackup_ok" ]; then
	current_backup="last-wiki-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
	cat <<__EOF__
${cBlue}#-
#- (3) 지정한 백업파일을 DB 서버에 ${cRed}리스토어 하기전에${cBlue}, 현재 운영중인 DB 를 먼저 백업합니다.
#-
#- 백업시 ${cYellow}비밀번호 ${cBlue}를 입력하세요.
#-${cReset}
__EOF__
	cmdRun "sudo docker exec wikijsdb pg_dumpall -U imwiki | time 7za a -si ${dir_for_backup}/${current_backup} -p" "#-- (4) 현재 운영중인 DB 를 먼저 ${dir_for_backup} 에 백업합니다."
fi
#cmdRun "sudo docker exec -it pgsql(<--wikijsdb) dropdb -U imwiki(<---wikijs) wiki" "#-- (5) 데이터베이스를 삭제합니다."
cmdRun "sudo docker exec  wikijsdb dropdb -U imwiki wiki" "#-- (5) 데이터베이스를 삭제합니다."
cmdRun "sudo docker exec  wikijsdb createdb -U imwiki wiki" "#-- (6) 데이터베이스를 새로 만듭니다."
cat <<__EOF__
${cBlue}#-
#-- (7) 지정한 백업파일을 ${cRed}DB 서버에${cBlue} 리스토어 합니다.
#-
#- 백업시 ${cYellow}비밀번호 ${cBlue}를 입력하세요.
#-${cReset}
__EOF__
cmdRun "time 7za x -so ${db_sql_7z} | sudo docker exec -i wikijsdb psql -U imwiki wiki" "#-- (8) 백업파일을 DB 에 리스토어 합니다."
cmdRun "sudo docker start wikijs ; sudo docker ps -a" "#-- (9) 중단했던 pgsql 도커를 다시 시작합니다."


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
