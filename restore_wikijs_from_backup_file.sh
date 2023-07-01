#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="docker-compose wiki.js 설치"
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
# ! wiki.js 데이터베이스에 리스토어 하기 위한 백업파일 이름을 지정해야 합니다.
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
last_skip="db_backup_ok"
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
LOCAL_FOLDER="/home/backup/wiki.js" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
# REMOTE_FOLDER="wiki.js" #-- 원격 저장소의 첫번째 폴더 이름
# RCLONE_NAME="yosgc" #-- rclone 이름 yosjeongc
# DB_TYPE="pgsql"
dir_for_backup=${LOCAL_FOLDER}/last_backup #-- 백업을 리스토어 하기전, 현재DB 백업하는 로컬 저장소
if [ ! -f ${dir_for_backup} ]; then
	cmdRun "sudo mkdir -p ${dir_for_backup} ; sudo chown ${USER}.${USER} ${dir_for_backup}" "#-- (1) 현재 운영중인 DB 를 백업하는 로컬 저장소 만듭니다."
fi

cmdRun "sudo docker ps -a ; sudo docker stop wikijs ; sudo docker ps -a" "#-- (2) 백업을 위해 wiki.js 도커를 중단합니다."

if [ "x${last_skip}" = "xdb_backup_ok" ]; then
	current_backup="last-wikijs-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
	cat <<__EOF__
${cBlue}#-
#- (3) 지정한 백업파일을 DB 서버에 ${cRed}리스토어 하기전에${cBlue}, 현재 운영중인 DB 를 먼저 백업합니다.
#-
#- 백업시 ${cYellow}비밀번호 ${cBlue}를 입력하세요.
#-${cReset}
__EOF__
	cmdRun "sudo docker exec wikijsdb pg_dumpall -U wikijs | time 7za a -si ${dir_for_backup}/${current_backup} -p" "#-- (4) 현재 운영중인 DB 를 먼저 ${dir_for_backup} 에 백업합니다."
fi
cmdRun "sudo docker exec -it wikijsdb dropdb -U wikijs wiki" "#-- (5) 데이터베이스를 삭제합니다."
cmdRun "sudo docker exec -it wikijsdb createdb -U wikijs wiki" "#-- (6) 데이터베이스를 새로 만듭니다."
cat <<__EOF__
${cBlue}#-
#-- (7) 지정한 백업파일을 ${cRed}DB 서버에${cBlue} 리스토어 합니다.
#-
#- 백업시 ${cYellow}비밀번호 ${cBlue}를 입력하세요.
#-${cReset}
__EOF__
cmdRun "time 7za x -so ${db_sql_7z} | sudo docker exec -i wikijsdb psql -U wikijs wiki" "#-- (8) 백업파일을 DB 에 리스토어 합니다."
cmdRun "sudo docker start wikijs ; sudo docker ps -a" "#-- (9) 중단했던 wiki.js 도커를 다시 시작합니다."


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
