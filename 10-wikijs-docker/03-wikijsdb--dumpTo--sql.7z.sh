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
MEMO="backup wikijsdb to sql.7z"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

if [ "x$1" = "x" ]; then
	rm -f ${log_name}
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 프로그램 이름 다음에 ${cCyan}(백업파일을 저장할 폴더)${cBlue}를 지정해야 합니다.${cReset}"
	echo "----> ${cYellow}${0} ${cCyan}[ ${cYellow}백업파일을 저장할 폴더이름${cCyan} ] 을 입력하세요.${cReset}"
	echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
	exit 1
fi
if [ ! -d "$1" ]; then
	rm -f ${log_name}
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 백업파일을 저장할 ${cCyan}($1)${cBlue} 폴더가 없습니다.${cReset}"
	echo "----> ${cYellow}${0} ${cCyan}[ ${cYellow}백업파일을 저장할 폴더이름${cCyan} ] 을 입력하세요.${cReset}"
	echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
	exit 1
fi

dir_for_backup="$1"
sql_7z="yy.wikijs-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"

cat_and_read "# 백업파일을 저장할 폴더가 ${cReset}'''${cYellow}${dir_for_backup}${cReset}'''" "맞으면 [ 엔터 ]를 눌러서 넘어가세요."

cat_and_run "sudo docker ps -a ; sudo docker stop wikijs" "#-- 위키 도커 중단"

cat_and_read "# 비밀번호를 2번 입력해야 합니다." "[ 엔터 ]를 누르세요."
echo "${cGreen}----> ${cYellow}sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${dir_for_backup}/${sql_7z} -p ${cCyan}#-- 데이터 백업하기${cReset}"
sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${dir_for_backup}/${sql_7z} -p

cat_and_run "sudo docker start wikijs ; sudo docker ps -a" "#-- 위키 도커 다시 시작"


# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${1}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
