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

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi

# ----------
MEMO="restore sql to wikijsdb"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"

if [ "x$1" = "x" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 프로그램 이름 다음에 ${cCyan}(DB 에 업로드하기 위한 백업파일)${cBlue}을 지정해야 합니다.${cReset}"
	echo "----> ${cYellow}${0} [업로드 할 백업파일]${cReset}"
	exit
fi
if [ ! -f "$1" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} DB 에 업로드하기 위한 ${cCyan}($1)${cBlue} 백업파일이 없습니다.${cReset}"
	echo "----> ${cYellow}${0} [업로드 할 백업파일]${cReset}"
	exit
fi

db_sql_7z="$1"
sql_name=$(basename ${db_sql_7z}) # 백업파일 이름만 꺼냄
dir_for_backup=${db_sql_7z%/$sql_name} # 백업파일 이름을 빼고 나머지 디렉토리만 담음
cat <<__EOF__

db_sql_7z="$1"
sql_name=$(basename ${db_sql_7z}) # 백업파일 이름만 꺼냄
dir_for_backup=${db_sql_7z%/$sql_name} # 백업파일 이름을 빼고 나머지 디렉토리만 담음
__EOF__
read a


cat_and_run "sudo docker ps -a ; sudo docker stop wikijs" "#-- 위키도커 중단"

current_backup="wikijs-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
cat_and_run "sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${dir_for_backup}/${current_backup}" "#-- 현재의 DB 백업하기"
cat_and_run "sudo docker exec -it wikijsdb dropdb -U wikijs wiki" "#-- DB 삭제하기"
cat_and_run "sudo docker exec -it wikijsdb createdb -U wikijs wiki" "#-- DB 만들기"

cat_and_run "time 7za x -so ${db_sql_7z} | sudo docker exec -i wikijsdb psql -U wikijs wiki" "#-- 백업파일을 db 에 담기"

cat_and_run "sudo docker stop wikijs ; sudo docker ps -a" "#-- 위키도커 다시 시작"

cat_and_run "ls --color ${CMD_DIR} ; ls -l --color ${dir_for_backup}"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"
