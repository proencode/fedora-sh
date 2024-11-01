#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="백업했던 sql.7z 파일을 서버의 wikijsdb 에 업로드하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


db_sql_7z=$1
if [ "x${db_sql_7z}" = "x" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 프로그램 이름 다음에 ${cCyan}(DB 에 업로드하기 위한 백업파일=${db_sql_7z})${cBlue}을 지정해야 합니다.${cReset}"
	echo "----> ${cYellow}${0} [\$1 $1: 업로드 할 백업파일]${cReset}"
	exit
fi
if [ ! -f "${db_sql_7z}" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} DB 에 업로드하기 위한 ${cCyan}(${db_sql_7z})${cBlue} 백업파일이 없습니다.${cReset}"
	echo "----> ${cYellow}${0} [업로드 할 백업파일]${cReset}"
	exit
fi


# ----

DOCKER_DIR=/home/docker
DB_DIR=${DOCKER_DIR}/pgsql
#-- pgsql db
DB_USER="wikijs" #---POSTGRES_USER: "imwiki"
DB_PSWD="wikijsrocks" #---POSTGRES_PASSWORD: "wikijsrocks"
DB_NAME="wiki" #---POSTGRES_DB: "wikidb"
DB_CONTAINER="wikijsdb" #---container_name: "wikijsdb"
#-- wiki.js
#--NOT_USE--WIKI_CONF_DIR=${DOCKER_DIR}/wiki_conf
WIKI_CONTAINER="wikijs"
WIKI_PORT_NO="9900"
#-- services
#--NOT_USE--DB_SERVICE="db"
#--NOT_USE--WIKI_SERVICE="wiki"

#////////////////////////////////////////////////
#///---version: "3"
#///---services:
#///---
#///---  db: 
#///---    image: postgres:11-alpine
#///---    environment:
#///---      POSTGRES_DB: wiki
#///---      POSTGRES_PASSWORD: wikijsrocks
#///---      POSTGRES_USER: wikijs
#///---    logging:
#///---      driver: "none"
#///---    restart: unless-stopped
#///---    volumes:
#///---      - /home/docker/pgsql:/var/lib/postgresql/data
#///---    container_name:
#///---      wikijsdb
#///---
#///---  wiki:
#///---    image: requarks/wiki:2
#///---    depends_on:
#///---      - db
#///---    environment:
#///---      DB_TYPE: postgres
#///---      DB_HOST: db
#///---      DB_PORT: 5432
#///---      DB_USER: wikijs
#///---      DB_PASS: wikijsrocks
#///---      DB_NAME: wiki
#///---    restart: unless-stopped
#///---    ports:
#///---      - "5840:3000"
#///---    container_name:
#///---      wikijs
#////////////////////////////////////////////////

#-- local/remote folder
LOCAL_FOLDER="/home/backup/wikidb" #- 보관용 로컬 저장소
CLOUD_NAME="yosjgc" #- rclone 이름
CLOUD_FOLDER="wikijs" #- 원격 저장소의 첫번째 폴더 이름

#--


sql_name=$(basename ${db_sql_7z}) # 백업파일 이름만 꺼냄
sql_dir=${db_sql_7z%/$sql_name} # 백업파일 이름을 빼고 나머지 디렉토리만 담음
cat <<__EOF__

${cYellow}db_sql_7z="${db_sql_7z}"${cReset}
${cYellow}sql_name=$(basename ${db_sql_7z}) ${cCyan}# 백업파일 이름만 꺼냄${cReset}
${cYellow}sql_dir=${db_sql_7z%/$sql_name} ${cCyan}# 백업파일 이름을 빼고 나머지 디렉토리만 담음${cReset}
${cGreen}----> ${cCyan}Press Enter${cReset}:
__EOF__
read a

cmdRun "sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a" "(1) 위키 도커 중단"


echoSeq "현재의 DB 를 last_backup 으로 백업"

echo "${cGreen}----> ${cCyan}(2) 현재의 DB 를 last_backup 으로 백업하지 않으려면, ' ${cYellow}n${cCyan} ' 을 눌러 주세요.${cReset}"
read a ; echo "${cUp}"
echo "${cRed}[ ${cYellow}${a} ${cRed}]${cReset}"
last_skip="db_backup_ok"
if [ "x$a" = 'xn' ]; then
	cat <<__EOF__
${cRed}# |
# |
# |
# |
# |
# |
!!!! 주의 !!!! 현재 DB 를 다운로드 + 백업하지 않고, 업로드 합니다.${cReset}

${cGreen}----> ${cCyan}press ' ${cYellow}y ${cCyan}' Enter:${cReset}
__EOF__
	read a ; echo "${cUp}"
	echo "${cRed}[ ${cYellow}${a} ${cRed}]${cReset}"
	if [ "x$a" != "xy" ]; then
		# ----
		rm -f ${zz00log_name}
		echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
		exit 1
	fi
	last_skip="no_backup"
fi

dir_for_backup=${LOCAL_FOLDER}/last_backup #-- 백업을 리스토어 하기전, 현재DB 백업하는 로컬 저장소
if [ ! -f ${dir_for_backup} ]; then
	cmdRun "sudo mkdir -p ${dir_for_backup} ; sudo chown ${USER}:${USER} ${dir_for_backup}" "(3) 백업을 리스토어 하기전, 현재DB 백업하는 로컬 저장소 만들기"
fi


if [ "x${last_skip}" = "xdb_backup_ok" ]; then
	current_backup="last-wikijs-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
	cat <<__EOF__

${cGreen}----> ${cYellow}sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -si ${dir_for_backup}/${current_backup} -p ${cCyan}#-- (4) 지정한 백업파일을 DB 서버에 리스토어 하기전에, 현재의 DB 를 먼저 백업합니다.

${cRed}----> ${cYellow}비밀번호${cRed}를 위키 입력하세요.${cReset}

__EOF__
	sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -pdnlzl -si ${dir_for_backup}/${current_backup}
fi

echoSeq ""


echoSeq "sql.7z 로 백업한 파일을 DN 에 리스토어"

echo "sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME} --- (5) DB 삭제하기"
sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME} ; echo "#-- (5) DB 삭제하기"
echo "sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME} --- (6) DB 만들기"
sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME} ; echo "#-- (6) DB 만들기"

cat <<__EOF__

${cGreen}----> ${cYellow}time 7za x -so ${db_sql_7z} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} ${DB_NAME} ${cCyan}#-- (7) 백업파일을 DB 에 리스토어하기

${cRed}----> 백업할때 입력한 ${cYellow}비밀번호${cRed}를 입력하세요.${cReset}

__EOF__
time 7za x -so ${db_sql_7z} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} ${DB_NAME}

cmdRun "sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a" "(8) 위키 도커 다시 시작"

echoSeq ""


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
