#!/bin/bash

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
	echo "${yyy}# ----> ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | sh
	echo "${yyy}# <~~~~ ${bbb}$1 #-- $2${xxx}"
}

wikijsdb_dir="wind_bada/wikijsdb"
if [ ! -d ~/${wikijsdb_dir} ]; then
	cmdrun "cd ~/; mkdir -p ${wikijsdb_dir}" "받는 폴더를 만듭니다."
fi
echo "${yyy}#--->${bbb} cd ~/${wikijsdb_dir} ${ggg}#-- ${bbb}받는 폴더로 갑니다.${xxx}"
cd ~/${wikijsdb_dir}

db_sql_7z="$1"
if [ "x${db_sql_7z}" = "x" ] || [ ! -f "${db_sql_7z}" ]; then
	echo "${yyy}#--->${bbb} ls -l *.sql.7z${xxx}"
	ls -l *.sql.7z
	echo "${rrr}#--->${ggg} 프로그램 이름 다음에 wiki_*sql.7z 파일을 지정하지 않았으므로, 클라우드에서 파일을 다운로드 받습니다.${xxx}"
	echo "${rrr}#--->${ggg} press Enter:${xxx}"
	read a
	echo "${yyy}#--->${bbb} time rclone copy tpn3mi:wikijsdb/$(date +%Y)/ --include \"wiki_$(date +%y%m)*wol*sql.7z\" .${xxx}"
	time rclone copy tpn3mi:wikijsdb/$(date +%Y)/ --include "wiki_$(date +%y%m)*wol*sql.7z" .
	echo "${yyy}#--->${bbb} ls -l wiki_$(date +%y%m)*wol*sql.7z${xxx}"
	ls -l wiki_$(date +%y%m)*wol*sql.7z
	echo "${yyy}#--->${bbb} 다운로드 받으려는 wiki_*wol.sql.7z 형식의 이름을 다음줄에 입력하세요:${xxx}"
	read db_sql_7z
	if [ "x${db_sql_7z}" = "x" ] || [ ! -f "${db_sql_7z}" ]; then
		echo "${rrr}#--->${ggg} DB 에 업로드하기 위한 ${ccc}(${db_sql_7z})${bbb} 백업파일이 없습니다.${xxx}"
		echo "${rrr}#--->${ggg} ${0} [\$1 $1: 업로드 할 백업파일]${xxx}"
		exit
	fi
fi

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

echo "${yyy}#--->${bbb} (1) 위키 도커 중단: sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a${xxx}"
sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a
echo "${yyy}#--->${bbb} (2) DB 삭제하기: sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}${xxx}"
sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}
echo "${yyy}#--->${bbb} (3) DB 만들기: sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}${xxx}"
sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}
echo "${yyy}#--->${bbb} time 7za x -so ${db_sql_7z} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} ${DB_NAME}"
echo "${yyy}#--->${bbb} (4) 백업파일을 DB 에 리스토어하기 위해 ${mmm}비번${bbb} 을 입력하세요.${xxx}"
time 7za x -so ${db_sql_7z} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} ${DB_NAME}
echo "${yyy}#--->${bbb} (5) 위키 도커 다시 시작: sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a${xxx}"
sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a
echo "${yyy}#--->${bbb} (6) localhost:5740 (포트번호)${xxx}"
echo "#------------"
echo "#------------ [31-] wiki.js 리스토어 작업"
