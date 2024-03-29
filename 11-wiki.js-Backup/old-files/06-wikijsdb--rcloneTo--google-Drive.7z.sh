#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
}
cat_and_read () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cGreen}\n----> ${cCyan}press Enter${cReset}:"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cMagenta}$1 $2${cReset}"
}
cat_and_readY () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
	else
		echo "${cGreen}----> ${cRed}press ${cCyan}y${cRed} or Enter${cReset}:"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			echo "${cRed}[ ${cYellow}$1 ${cRed}] ${cCyan}<--- 명령을 실행하지 않습니다.${cReset}"
		fi
		echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cMagenta}$1 $2${cReset}"
	fi
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="rclone wikijsdb sql.7z to google Drive"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
#--xx-- logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
#--xx-- log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

Y4M2WEEK_DIR="wiki.js/$(date +'%Y/%m/%a')"
dir_for_backup="${HOME}/archive/${Y4M2WEEK_DIR}"
if [ ! -f ${dir_for_backup} ]; then
	cat_and_run "mkdir -p ${dir_for_backup}" "#-- (1) 백업하는 폴더를 새로 만듭니다."
else
	echo "#-- (1) 백업하는 폴더: ${dir_for_backup}" 
fi

sql_7z="wikijs-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"

cat_and_run "sudo docker ps -a ; sudo docker stop wikijs" "#-- (2) 위키 도커 중단"

cat <<__EOF__
${cGreen}----> ${cYellow}sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -mx=9 -si ${dir_for_backup}/${sql_7z} -p ${cCyan}#-- (3) 데이터 백업하기${cReset}
${cGreen}----> ${cYellow}비밀번호${cCyan}를 입력하세요.${cReset}
__EOF__
sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -mx=9 -si ${dir_for_backup}/${sql_7z} -p

cat_and_run "rclone lsl yosjeon:${Y4M2WEEK_DIR}/" "#-- (4) 구글 드라이브 ${Y4M2WEEK_DIR} 폴더 입니다."

cat_and_readY "rclone delete yosjeon:${Y4M2WEEK_DIR}/" "#-- (5) 구글 드라이브 ${Y4M2WEEK_DIR} 폴더의 파일들을 모두 삭제할까요 ?"

cat_and_run "rclone copy ${dir_for_backup}/${sql_7z} yosjeon:${Y4M2WEEK_DIR}/" "#-- (6) 백업 파일을 구글 드라이브 ${Y4M2WEEK_DIR} 폴더로 복사합니다."

cat_and_run "rclone lsl yosjeon:${Y4M2WEEK_DIR}/" "#-- (7) 구글 드라이브 ${Y4M2WEEK_DIR} 폴더 입니다."

cat_and_run "ls -l ${dir_for_backup}" "#-- (8) 백업한 파일들니다."
cat_and_readY "rm -f ${dir_for_backup}/${sql_7z}" "#-- (9) 구글 드라이브로 백업이 끝났으므로, 로컬에 있는 백업 파일을 삭제할까요 ?"

cat_and_run "sudo docker start wikijs ; sudo docker ps -a" "#-- (10) 위키 도커 다시 시작"


# ----
#--xx-- rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
#--xx-- cat_and_run "ls --color ${1}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
