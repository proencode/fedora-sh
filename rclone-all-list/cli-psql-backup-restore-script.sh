#!/bin/sh

cat <<__EOF__
#-- wiki58 240213-1703

proenpi@pi4b /opt/backup/wikidb $
yoran@orangepizero2w /home/docker/backup $

__EOF__

DB_NAME="wikidb" #-- pgsql 데이터베이스 이름 #--> 정리한 이름들
DB_USER="imwiki" #-- pgsql 사용자 이름
DB_PASS="wikiam9ho" #-- pgsql 비번
DB_VOLUME="/home/docker/pgsqlwiki" #-- DB 설치위치
DB_CONTAINER="dbcont" #-- 데이터베이스 컨테이너
#--
WIKI_PORTS="5900" #-- ports: 5900
WIKI_CONTAINER="wikicont" #-- 위키 컨테이너 #<-- 정리한 이름들

DB_NAME="wiki" #-- DB_NAME: wiki > wikidb #-- pgsql 데이터베이스 이름
DB_USER="wikijs" #-- DB_USER: wikijs > imwiki #-- pgsql 사용자 이름
DB_PASS="wikijsrocks" #-- DB_PASS: wikijsrocks > wikiam9ho #-- pgsql 비번
DB_VOLUME="/home/docker/pgsqlwiki" #-- db: volumes: /home/docker/pgsqlwiki #-- DB 설치위치
DB_CONTAINER="wikijsdb" #-- db: container_name: wikijsdb > dbcont #-- 데이터베이스 컨테이너
#--
WIKI_PORTS="5900" #-- ports: 5900
WIKI_CONTAINER="wikijs" #-- wiki: container_name: wikijs > wikicont #-- 위키 컨테이너

BACKUP_DIR=/home/docker/backup/$(date +%Y)
if [ ! -d ${BACKUP_DIR} ]; then
    mkdir ${BACKUP_DIR}
fi
BACKUP_FILE=${BACKUP_DIR}/wiki_$(date +%y%m%d%a-%H%M)-$(uname -n).sql.7z
RESTORE_FILE=$1
if [ ! -f "${RESTORE_FILE}" ]; then
    RESTORE_FILE=${BACKUP_DIR}/wiki_$(date +%y%m%d%a-%H%M)-$(uname -n).sql.7z
    cat <<__EOF__
----> 리스토어 하려는 파일의 이름을
----> ${RESTORE_FILE}
----> 처럼 지정해 주세요.
__EOF__
    read a
    if [ "x$a" = "x" ]; then
        a=${RESTORE_FILE}
    fi
    RESTORE_FILE=${a}
fi
cat <<__EOF__
----> ls -l ${BACKUP_DIR} #-- BACKUP_DIR
$(ls -l ${BACKUP_DIR})
----> ls -l ${RESTORE_FILE} #-- RESTORE_FILE
$(ls -l ${RESTORE_FILE})
----> sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a #-- WIKI STOP
__EOF__
sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a

cat <<__EOF__
----> time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -p -si ${BACKUP_FILE}
----> 백업하려는 파일의 새로운 비번을 입력하세요.
__EOF__
time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -p -si ${BACKUP_FILE}

#-- Archive size: 169271234 bytes (162 MiB)
#-- Everything is Ok
#--
#-- real  16m0.764s
#-- user  26m26.057s
#-- sys  0m22.980s

if [ ! -f ${RESTORE_FILE} ]; then
    echo "----> 리스토어할 파일이 없습니다."
    exit -11
fi
cat <<__EOF__

----> 리스토어 하기전 최종 백업한 BACKUP_FILE: ${BACKUP_FILE}
$(ls -l ${BACKUP_FILE})
----> DB 는 이 파일로 복구할 예정입니다 - RESTORE_FILE: ${RESTORE_FILE}
$(ls -l ${RESTORE_FILE})

----> 지정한 백업파일을 리스토어 하기 위해서는 현재 데이터베이스를 삭제해야 합니다.
---->
----> sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}
----> 리스토어 하기 전에, 현재의 위키 데이터베이스를 지워야 하므로,
----> 삭제하려면 'y' 를 입력하세요.
__EOF__
read a
if [ "x$a" != "xy" ]; then
    cat <<__EOF__

----> 리스토어 하기전 최종 백업한 BACKUP_FILE: ${BACKUP_FILE}
$(ls -l ${BACKUP_FILE})
====> 백업만 하고 현재의 위키를 그대로 두고 작업을 끝냅니다.
__EOF__
else
    echo "----> sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}"
    sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}
    echo "----> sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}"
    sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}
    cat <<__EOF__
----> time 7za x -so ${RESTORE_FILE} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} postgress
----> 백업했을때, 저 파일에 지정한 비번을 입력하세요.
__EOF__
    time 7za x -so ${RESTORE_FILE} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} postgres
cat <<__EOF__
----> 리스토어 하기전 최종 백업한 BACKUP_FILE: ${BACKUP_FILE}
$(ls -l ${BACKUP_FILE})
----> DB 는 이 파일로 복구 하였음 - RESTORE_FILE: ${RESTORE_FILE}
$(ls -l ${RESTORE_FILE})
----> sudo docker ps -a ; sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a #-- WIKI START
__EOF__
    sudo docker ps -a ; sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a
fi
cat <<__EOF__
version: "3"
services:

  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: ${DB_NAME} #-- DB_NAME: wiki > wikidb #-- 데이터베이스 이름
#--
      POSTGRES_USER: ${DB_USER} #-- DB_USER: wikijs > imwiki #-- 데이터베이스 사용자 이름
      POSTGRES_PASSWORD: ${DB_PASS} #-- DB_PASS: wikijsrocks > wikiam9ho #-- 데이터베이스 비번

    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - ${DB_VOLUME}:/var/lib/postgresql/data #-- db: volumes: /home/dicker/pgsqlwiki #-- DB 설치위치
    container_name:
      ${DB_CONTAINER} #-- db: container_name: wikijsdb > dncont #-- 데이터베이스 컨테이너

  wiki:
    image: requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_NAME: ${DB_NAME} #-- wiki > wikidb #-- wiki 데이터베이스 이름
      DB_USER: ${DB_USER} #-- wikijs > imwiki #-- wikijs 사용자 이름
      DB_PASS: ${DB_PASS} #-- wikijsrocks > wikiam9ho #-- wikijsrocks 비번

    restart: unless-stopped
    ports:
      - "${WIKI_PORT}:3000" #-- ports: 5900
    container_name:
      ${WIKI_CONTAINER} #-- wiki: container_name: wikijs > wikicont #-- 위키 컨테이너
__EOF__
