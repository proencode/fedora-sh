#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}
cat_and_read () {
	echo -e "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cYellow}\n - -> ${cRed}press Enter${cCyan}:${cReset}"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta} - - ${cBlue}press Enter${cRed}: ${cMagenta}$1 $2${cReset}"
}
cat_and_readY () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cYellow}<${cMagenta}---- ${cBlue}$1${cReset}"
	else
		echo "${cYellow} - -> ${cRed}press ${cCyan}y${cRed} or Enter${cCyan}:${cReset}"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			echo "${cRed}$1 ${cYellow}--- 를 실행하지 않습니다.${cReset}"
		fi
		echo "${cYellow}<${cMagenta} - - ${cBlue}press Enter${cRed}: ${cMagenta}$1 $2${cReset}"
	fi
}

#----
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
#----

MEMO="backup wikijsdb to sql.7z"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"

if [ "x$1" = "x" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 프로그램 이름 다음에 ${cCyan}(저장하기 위한 폴더)${cBlue}를 지정해야 합니다.${cReset}"
	echo "----> ${cYellow}${0} [백업파일을 저장할 폴더이름]${cReset}"
	exit
fi
if [ ! -d "$1" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 저장하기 위한 ${cCyan}($1)${cBlue} 폴더가 없습니다.${cReset}"
	echo "----> ${cYellow}${0} [백업파일을 저장할 폴더이름]${cReset}"
	exit
fi

dir_for_backup="$1"
sql_7z="wikijs-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"

cat_and_run "sudo docker ps -a ; sudo docker stop wikijs" "#-- 위키도커 중단"
cat_and_run "sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${dir_for_backup}/${sql_7z}" "#-- 데이터 백업하기"
cat_and_run "sudo docker start wikijs ; sudo docker ps -a" "#-- 위키도커 다시 시작"

cat_and_run "ls --color ${CMD_DIR} ; ls -l --color ${dir_for_backup}"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"
