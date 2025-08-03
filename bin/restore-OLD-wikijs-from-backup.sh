#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        #-- echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${yyy}#-- ${ccc}$1 ${bbb}#-- $2${xxx}"; echo "$1" | bash
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}
enter_value() {
	retv="$2"; echo "$1 [ $2 ]" >&2 # >&2를 사용해 stderr 로 출력
	read a; if [ "x$a" != "x" ]; then retv=$a; fi
	echo "$retv"
}

qq=10
DOCKER_ROOT=$(enter_value "${qq}-1. 도커의 루트 디렉토리:" "home/docker")
BACKUP_DIR=$(enter_value "${qq}-2. 백업폴더:" "${DOCKER_ROOT}/backup/$(date +%Y)")
DB_VOLUME=$(enter_value "${qq}-3. DB 설치위치:" "${DOCKER_ROOT}/pgsql")
DB_NAME=$(enter_value "${qq}-4. pgsql 데이터베이스 이름:" "wiki")
DB_USER=$(enter_value "${qq}-5. pgsql 사용자 이름:" "imwiki")
DB_PASS=$(enter_value "${qq}-6. pgsql 비번:" "wikiam9ho")
DB_CONTAINER=$(enter_value "${qq}-7. 데이터베이스 컨테이너 이름:" "wikidb")
WIKI_PORT=$(enter_value "${qq}-8. 위키연결 포트번호:" "5940")
WIKI_CONTAINER=$(enter_value "${qq}-9. 위키 컨테이너:" "wiki")
CLOUD_NAME=$(enter_value "${qq}-10. rclone 백업용 클라우드 저장소 이름:" "tpn3mi")
echo "CLOUD_NAME is ($CLOUD_NAME)"
read a

#--
if [ ! -d ${BACKUP_DIR} ]; then
    mkdir -p ${BACKUP_DIR}
fi
#--
cmdrun "ls -l ${BACKUP_DIR}/" "(1) 백업 폴더에 있는 백업 파일들입니다."
RESTORE_FILE=$1
if [ ! -f "${RESTORE_FILE}" ]; then
	#-- $1= 백업 파일이 없으면,
    cat <<__EOF__
${mmm}#-- ${ccc}${RESTORE_FILE} ${bbb}#-- 파일이 없습니다.
${mmm}#-- ${ggg}리스토어 하려는 파일의 이름을 루트(/) 부터 시작해서 입력하세요.${xxx}
__EOF__
    read RESTORE_FILE
    if [ ! -f ${RESTORE_FILE} ]; then
		echo "${mmm}#-- ${rrr}${RESTORE_FILE} ${bbb}파일이 없으므로 작업을 중단합니다.${xxx}"
		exit -5001 #-- ${RESTORE_FILE} 없음
	fi
	#-- $1= 백업 파일이 없으면,
fi
cmdrun "ls -l ${RESTORE_FILE}" "(2) 리스토어 하려는 백업 파일 입니다."

cmdrun "sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a" "(3) wiki 컨테이너를 중지합니다."

echo "${yyy}#-- ${bbb}(4) 현재의 DB 를 ${ccc}백업하지 않으려면${bbb}, 소문자 ${yyy}'${rrr}n${yyy}' ${bbb}을 눌러 주세요.${xxx}"
read N_is_current_no_backup ; echo "${uuu}"
if [ "x${N_is_current_no_backup}" != "xn" ]; then
    N_is_current_no_backup="y"
fi
echo "${rrr}[ ${ccc}현재 DB 를 백업하겠습니다 == ${yyy}'${rrr}${N_is_current_no_backup}${yyy}' ${rrr}]${xxx}"

if [ "x$N_is_current_no_backup" = 'xn' ]; then
    #---- 'n': 백업을 하지 않겠다고 하면, 한번 더 물어본다.
    cat <<__EOF__
# |
# |
# |
# |
# |
# | ${mmm}!!!! 주의 !!!!${xxx} 현재 DB 를 백업한 뒤에, 업로드 하는게 좋습니다.
# |
# | 백업을 하지 않기 위해서, 소문자 ${yyy}'${rrr}n${yyy}'${xxx} 을 누르면
# | 현재의 ${mmm}DB 백업을 하지 않습니다.${xxx}
# |
# | 소문자 ${yyy}'${rrr}n${yyy}'${xxx} 이 아니거나 그냥 Enter 를 누르면 백업 작업이 먼저 진행됩니다.
# |
# | (5) 백업을 하지 않으려면, ${yyy}'${rrr}n${yyy}'${xxx} Enter: (${mmm}'n' = NO BACKUP${xxx}):
__EOF__
    read n_is_no_backup ; echo "${uuu}"
    if [ "x$n_is_no_backup" = "xn" ]; then
        N_is_current_no_backup="n"
		a="백업하지 않음"
    else
        N_is_current_no_backup="y"
		a="백업함"
    fi
    echo "${rrr}[ ${ccc}현재 DB 를 = ${yyy}${a} ${rrr}]${xxx}"

    #---- 'n': 백업을 하지 않겠다고 하면, 한번 더 물어본다.
fi

if [ "x$N_is_current_no_backup" != 'xn' ]; then
    #-- ----> 현재 DB 를 다운로드 + 백업 합니다.
    cat <<__EOF__
# |
# | (5-1) 백업하는 .7z 파일에 지정해 줄 새로운 ===${ccc}비밀번호${xxx}=== 를 입력하세요.
__EOF__
    read -s backup_pswd

    BACKUP_FILE=${BACKUP_DIR}/wiki_$(date +%y%m%d_%a-%H%M)-$(uname -n).sql.7z

    cat <<__EOF__
# |
# | (5-2) 업로드 하기전 백업합니다.
# |
# | time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -pxxx -si ${BACKUP_FILE}
__EOF__
    time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -p${backup_pswd} -si ${BACKUP_FILE}

	CLOUD_Y2M2=wikidb/$(date +%y%m)
    cat <<__EOF__
# |
# | (5-3) 오늘 요일이름의 파일을 클라우드로 복사합니다.
# |
# | time rclone copy ${BACKUP_FILE} ${CLOUD_NAME}:${CLOUD_Y2M2}/
__EOF__
    time rclone copy ${BACKUP_FILE} ${CLOUD_NAME}:${CLOUD_Y2M2}/
    cat <<__EOF__
# |
# | (5-4) 클라우드 폴더입니다.
# |
# | time rclone lsl ${CLOUD_NAME}:${CLOUD_Y2M2}
__EOF__
    time rclone lsl ${CLOUD_NAME}:${CLOUD_Y2M2}

    #-- <---- 현재 DB 를 다운로드 + 백업 합니다.
fi

cat <<__EOF__
# |
(6) 기존의 데이터베이스를 삭제합니다.
# |
    time sudo docker exec -it pgsql dropdb -U imwiki wikidb
__EOF__
time sudo docker exec -it pgsql dropdb -U imwiki wikidb
cat <<__EOF__
# |
(7) 빈 데이터베이스를 새로 만듭니다.
# |
    time sudo docker exec -it pgsql createdb -U imwiki wikidb
__EOF__
time sudo docker exec -it pgsql createdb -U imwiki wikidb
cat <<__EOF__
# |
(8) 지정한 백업파일을 데이터베이스에 다시 붓습니다. (RESTORE)
# |
    time 7za x -so ${zzz} | sudo docker exec -i pgsql psql -U imwiki wikidb
# |
# |
# |
(9) 백업할때 입력한 ----비밀번호---- 를 입력하세요.
__EOF__
time 7za x -so ${zzz} | sudo docker exec -i pgsql psql -U imwiki wikidb
cat <<__EOF__
# |
(10) 멈췄던 위키 컨테이너를 다시 시작합니다.
# |
    sudo docker start pgsql ; sudo docker ps -a
__EOF__
sudo docker start pgsql ; sudo docker ps -a
# |
echo "(6-17) 백업 작업이 끝났습니다."
#-- <---- 리스토어 할 .7z 파일이 있다.





BACKUP_FILE=${BACKUP_DIR}/wiki_$(date +%y%m%d_%a-%H%M)-$(uname -n).sql.7z
cat <<__EOF__
#----> time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -p -si ${BACKUP_FILE}
#----> 백업하려는 파일의 새로운 비번을 입력하고 Enter 를 눌러서 백업을 시작합니다.
__EOF__
read -s backup_pswd
echo "#----> time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -pxxx -si ${BACKUP_FILE}"
time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -p${backup_pswd} -si ${BACKUP_FILE}

#-- Archive size: 169271234 bytes (162 MiB)
#-- Everything is Ok
#--
#-- real  16m0.764s
#-- user  26m26.057s
#-- sys  0m22.980s

if [ ! -f ${RESTORE_FILE} ]; then
    echo "#----> 리스토어할 파일이 없습니다."
    exit -11
fi
cat <<__EOF__

#----> 리스토어 하기전 최종 백업한 BACKUP_FILE: ${BACKUP_FILE}
$(ls -l ${BACKUP_FILE})
#----> DB 는 이 파일로 복구할 예정입니다 - RESTORE_FILE: ${RESTORE_FILE}
$(ls -l ${RESTORE_FILE})

#----> 지정한 백업파일을 리스토어 하기 위해서는 현재 데이터베이스를 삭제해야 합니다.
#---->
#----> sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}
#----> 리스토어 하기 전에, 현재의 위키 데이터베이스를 지워야 하므로,
#----> 삭제하려면 'y' 를 입력하세요.
__EOF__
read a
if [ "x$a" != "xy" ]; then
    cat <<__EOF__

#----> 리스토어 하기전 최종 백업한 BACKUP_FILE: ${BACKUP_FILE}
$(ls -l ${BACKUP_FILE})
====> 백업만 하고 현재의 위키를 그대로 두고 작업을 끝냅니다.
__EOF__
else
    echo "#----> sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}"
    sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}
    echo "#----> sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}"
    sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}
    cat <<__EOF__
#----> time 7za x -so ${RESTORE_FILE} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} postgress
#----> 백업했을때, 저 파일에 지정한 비번을 입력하세요.
__EOF__
    time 7za x -so ${RESTORE_FILE} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} postgres
cat <<__EOF__
#----> 리스토어 하기전 최종 백업한 BACKUP_FILE: ${BACKUP_FILE}
$(ls -l ${BACKUP_FILE})
#----> DB 는 이 파일로 복구 하였음 - RESTORE_FILE: ${RESTORE_FILE}
$(ls -l ${RESTORE_FILE})
#----> sudo docker ps -a ; sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a #-- WIKI START
__EOF__
    sudo docker ps -a ; sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a
fi
cat <<__EOF__
version: "3"
services:

  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: ${DB_NAME} #-- wikidb < wiki #-- 데이터베이스 이름
      POSTGRES_USER: ${DB_USER} #-- imwiki < wikijs #-- 데이터베이스 사용자 이름
      POSTGRES_PASSWORD: ${DB_PASS} #-- wikiam9ho < wikijsrocks #-- 데이터베이스 비번

    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - ${DB_VOLUME}:/var/lib/postgresql/data #-- /home/docker/pgsql #-- DB 설치위치
    container_name:
      ${DB_CONTAINER} #-- wikidb < wikijsdb #-- 데이터베이스 컨테이너 이름

  wiki:
    image: requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_NAME: ${DB_NAME} #-- wikidb < wiki #-- 데이터베이스 이름
      DB_USER: ${DB_USER} #-- imwiki < wikijs #-- 데이터베이스 사용자 이름
      DB_PASS: ${DB_PASS} #-- wikiam9ho < wikijsrocks #-- 데이터베이스 비번

    restart: unless-stopped
    ports:
      - "${WIKI_PORT}:3000" #-- 위키연결 포트번호
    container_name:
      ${WIKI_CONTAINER} #-- wiki < wikijs #-- 위키 컨테이너 이름
__EOF__
