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
MEMO="restore sql to wikijsdb"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
#-- logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
#-- log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

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
sql_dir=${db_sql_7z%/$sql_name} # 백업파일 이름을 빼고 나머지 디렉토리만 담음
cat <<__EOF__

${cYellow}db_sql_7z="$1"${cReset}
${cYellow}sql_name=$(basename ${db_sql_7z}) ${cCyan}# 백업파일 이름만 꺼냄${cReset}
${cYellow}sql_dir=${db_sql_7z%/$sql_name} ${cCyan}# 백업파일 이름을 빼고 나머지 디렉토리만 담음${cReset}
${cGreen}----> ${cCyan}Press Enter${cReset}:
__EOF__
read a

cat_and_run "sudo docker ps -a ; sudo docker stop wikijs" "#-- 위키 도커 중단"

echo "${cGreen}----> ${cCyan}DB 백업을 하지 않으려면, ' ${cYellow}x${cCyan} ' 를 눌러 주세요.${cReset}"
read a ; echo "${cUp}"
echo "${cRed}[ ${cYellow}${a} ${cRed}]${cReset}"
last_skip="db_backup_ok"
if [ "x$a" = 'xx' ]; then
	cat <<__EOF__






${cRed}!!!! 주의 !!!! 현재 DB 를 다운로드 + 백업하지 않고, 업로드 합니다.${cReset}

${cGreen}----> ${cCyan}press ' ${cYellow}y ${cCyan}' Enter:${cReset}
__EOF__
	read a ; echo "${cUp}"
	echo "${cRed}[ ${cYellow}${a} ${cRed}]${cReset}"
	if [ "x$a" != "xy" ]; then
		# ----
		rm -f ${log_name}
		echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
		exit 1
	fi
	last_skip="no_backup"
fi

dir_for_backup="${HOME}/archive/wikijs/$(date +%Y)/$(date +%m)/"
if [ ! -f ${dir_for_backup} ]; then
	cat_and_run "mkdir -p ${dir_for_backup}" "백업하는 폴더를 새로 만듭니다."
fi

if [ "x${last_skip}" = "xdb_backup_ok" ]; then
	current_backup="last-wikijs-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
	cat <<__EOF__
${cGreen}----> ${cYellow}sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${dir_for_backup}/${current_backup} -p ${cCyan}#-- 현재의 DB 백업하기
${cGreen}----> ${cYellow}비밀번호${cCyan}를 입력하세요.${cReset}
__EOF__
	sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${dir_for_backup}/${current_backup} -p
fi


echo "${cGreen}----> ${cYellow}sudo docker exec -it wikijsdb dropdb -U wikijs wiki ${cCyan}#-- DB 삭제하기${cReset}"
sudo docker exec -it wikijsdb dropdb -U wikijs wiki
echo "${cGreen}----> ${cYellow}sudo docker exec -it wikijsdb createdb -U wikijs wiki ${cCyan}#-- DB 만들기${cReset}"
sudo docker exec -it wikijsdb createdb -U wikijs wiki

# cat_and_run "time 7za x -so ${db_sql_7z} | sudo docker exec -i wikijsdb psql -U wikijs wiki" "#-- 백업파일을 db 에 담기"
echo "${cGreen}----> ${cYellow}time 7za x -so ${db_sql_7z} | sudo docker exec -i wikijsdb psql -U wikijs wiki ${cCyan}#-- 백업파일을 db 에 담기${cReset}"
echo "${cGreen}----> ${cYellow}비밀번호${cCyan}를 입력하세요.${cReset}"
time 7za x -so ${db_sql_7z} | sudo docker exec -i wikijsdb psql -U wikijs wiki
cat_and_run "sudo docker start wikijs ; sudo docker ps -a" "#-- 위키 도커 다시 시작"

# ----
#-- rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
#-- cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
