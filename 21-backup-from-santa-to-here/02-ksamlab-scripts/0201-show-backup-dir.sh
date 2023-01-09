#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- $1 ${cBlue}$2${cReset}"
}
cat_and_read () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cGreen}\n----> ${cBlue}press ${cRed}Enter:${cReset}"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cMagenta}<---- press ${cRed}Enter: ${cMagenta}$1 ${cBlue}$2${cReset}"
}
cat_and_readY () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cMagenta}<---- $1 ${cBlue}$2${cReset}"
	else
		echo "${cGreen}----> ${cBlue}press ${cYellow}y${cBlue} or ${cRed}Enter:${cReset}"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			echo "${cRed}[ ${cYellow}$1 ${cRed}] ${cCyan}<--- 명령을 실행하지 않습니다.${cReset}"
		fi
		echo "${cMagenta}<---- press ${cRed}Enter: ${cMagenta}$1 ${cBlue}$2${cReset}"
	fi
}
read_and_enter () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"
	read a
	if [ "x$a" = "x" ]; then
		a="$1"
	fi
	echo "${cUp}" ; echo "${cRed}[ ${cYellow}$a ${cRed}]${cReset}" ; echo ""
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="santa 서버 폴더와 백업pc 폴더 파일 확인"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
## logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
## log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

read_and_enter $(date +"%Y") "또는, 년도를 2022 와 같이 입력합니다."
y4=$a

read_and_enter $(date +"%m") "또는, 월을 01 ~ 12 사이에서 ** 두자리로 ** 입력합니다."
m2=$a

read_and_enter 160 "또는, ls 로 보는 폭을 숫자로 지정합니다."
wd4ls=$a

# ssh kaosco@kaos.kr ls /var/base/*/${y4}/${m2}/ | tr ':\n' ': ' | sed 's| /var|\n/var|g' ; echo ''


read_santa_y4_m2_last_day () {
	folder_is=$1
	ls_folders=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@kaos.kr ls ${santa_dir}/${folder_is}/${y4}/${m2}/)
	ls_OneLine=$(echo $ls_folders | tr ":\n" ": ")
	#--
	reverse_folders=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@kaos.kr ls -r ${santa_dir}/${folder_is}/${y4}/${m2}/)
	reverse_OneLine=$(echo $reverse_folders | tr ":\n" ": ")
	#--
	reverse_matrix=($reverse_OneLine) 
	last_day=${reverse_matrix[0]}
	#--
	echo "${cCyan}----> ${ls_OneLine} ${cYellow}${last_day} ${cGreen} ---- SANTA  ${y4} ${m2} ${cCyan} ---- ${santa_dir}/${folder_is} ${cReset}"
	sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@kaos.kr ls -C -w ${wd4ls} ${santa_dir}/${folder_is}/${y4}/${m2}/${last_day}/


	ls_folders=$(ls ${local_dir}/${folder_is}/${y4}/${m2}/)
	ls_OneLine=$(echo $ls_folders | tr ":\n" ": ")
	#--
	reverse_folders=$(ls -r ${local_dir}/${folder_is}/${y4}/${m2}/)
	reverse_OneLine=$(echo $reverse_folders | tr ":\n" ": ")
	#--
	echo "${cMagenta}====> ${ls_OneLine} ${cYellow}${last_day} ${cMagenta} ---- BACKUP ${y4} ${m2} ${cBlue} ---- ${local_dir}/${folder_is} ${cReset}"
	ls -C -w ${wd4ls} ${local_dir}/${folder_is}/${y4}/${m2}/${last_day}/
}


santa_dir=/var/base
local_dir=/home/santa-backup

read_santa_y4_m2_last_day cadbase
read_santa_y4_m2_last_day emailbase
read_santa_y4_m2_last_day georaebase
read_santa_y4_m2_last_day scanbase



santadb_y4_last_month () {
	folder_is=$1
	ls_folders=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@kaos.kr ls ${santa_dir}/${folder_is}/${y4}/)
	ls_OneLine=$(echo $ls_folders | tr ":\n" ": ")
	#--
	reverse_folders=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@kaos.kr ls -r ${santa_dir}/${folder_is}/${y4}/)
	reverse_OneLine=$(echo $reverse_folders | tr ":\n" ": ")
	#--
	reverse_matrix=($reverse_OneLine) 
	last_month=${reverse_matrix[0]}
	#--
	echo "${cCyan}----> ${ls_OneLine} ${cYellow}${last_month} ${cGreen} ---- SANTA  ${y4} ${cCyan} ---- ${santa_dir}/${folder_is} ${cReset}"
	sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@kaos.kr ls -C -w ${wd4ls} ${santa_dir}/${folder_is}/${y4}/${last_month}/


	ls_folders=$(ls ${local_dir}/${folder_is}/${y4}/)
	ls_OneLine=$(echo $ls_folders | tr ":\n" ": ")
	#--
	reverse_folders=$(ls -r ${local_dir}/${folder_is}/${y4}/)
	reverse_OneLine=$(echo $reverse_folders | tr ":\n" ": ")
	#--
	echo "${cMagenta}====> ${ls_OneLine} ${cYellow}${last_month} ${cMagenta} ---- BACKUP ${y4} ${cBlue} ---- ${local_dir}/${folder_is} ${cReset}"
	ls -C -w ${wd4ls} ${local_dir}/${folder_is}/${y4}/${last_month}/
}


santa_dir=/var/base_db

santadb_y4_last_month kaosorder2
santadb_y4_last_month kaosoyo
santadb_y4_last_month mydb_utf8


# ----
## rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
## cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
