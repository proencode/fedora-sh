#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        #-- echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${yyy}#-- ${ccc}$1 ${bbb}#-- $2${xxx}"; echo "$1" | bash
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}
enter_value() {
	retv="$2"; echo "${mmm}#-- ${ggg}$1 [ $2 ]${xxx}" >&2 # >&2를 사용해 stderr 로 출력
	read a; if [ "x$a" != "x" ]; then retv=$a; fi
	echo "$retv"
}

enter_passwd() {
	retv="$2"; echo "${mmm}#-- ${ggg}$1 [ ...... ]${xxx}" >&2 # >&2를 사용해 stderr 로 출력
	read -s a; if [ "x$a" != "x" ]; then retv=$a; fi #-- 비번은 화면에 표시 안함
	echo "$retv"
}

qq=10 #-- 문답 겟수

#-- 두번째 yml 의 초기값을 어레이에 담는다.
DockerRootDir="/home/docker"
A_DOCKER_ROOT=("${qq}-1: 도커의 루트 디렉토리:" "${DockerRootDir}")
A_BACKUP_DIR=("${qq}-2: 백업폴더:" "${DockerRootDir}/backup/$(date +%Y)")
A_DB_VOLUME=("${qq}-3: DB 설치위치:" "${DockerRootDir}/pgsql")
A_DB_NAME=("${qq}-4: pgsql 데이터베이스 이름:" "wikidb")
A_DB_USER=("${qq}-5: pgsql 사용자 이름:" "wikiuser")
A_DB_PASS=("${qq}-6: pgsql 비번:" "wikipswd")
A_DB_CONTAINER=("${qq}-7: 데이터베이스 컨테이너 이름:" "dbcon")
A_WIKI_PORT=("${qq}-8: 위키연결 포트번호:" "5940")
A_WIKI_CONTAINER=("${qq}-9: 위키 컨테이너 이름:" "wikicon")
A_CLOUD_NAME=("${qq}-10: rclone 백업용 클라우드 저장소 이름:" "tpn3mi")

#-- 첫번째 yml 의 초기값을 어레이에 담는다.
DockerRootDir="/home/docker"
A_DOCKER_ROOT=("${qq}-1. 도커의 루트 디렉토리:" "${DockerRootDir}")
A_BACKUP_DIR=("${qq}-2. 백업폴더:" "${DockerRootDir}/backup/$(date +%Y)")
A_DB_VOLUME=("${qq}-3. DB 설치위치:" "${DockerRootDir}/pgsql")
A_DB_NAME=("${qq}-4. pgsql 데이터베이스 이름:" "wiki")
A_DB_USER=("${qq}-5. pgsql 사용자 이름:" "wikijs")
A_DB_PASS=("${qq}-6. pgsql 비번:" "wikijsrocks")
A_DB_CONTAINER=("${qq}-7. 데이터베이스 컨테이너 이름:" "wikijsdb")
A_WIKI_PORT=("${qq}-8. 위키연결 포트번호:" "5940")
A_WIKI_CONTAINER=("${qq}-9. 위키 컨테이너 이름:" "wikijs")
A_CLOUD_NAME=("${qq}-10. rclone 백업용 클라우드 저장소 이름:" "tpn3mi")

#-- 값 입력
DOCKER_ROOT=$(enter_value "${A_DOCKER_ROOT[0]}" "${A_DOCKER_ROOT[1]}")
BACKUP_DIR=$(enter_value "${A_BACKUP_DIR[0]}" "${A_BACKUP_DIR[1]}")
DB_VOLUME=$(enter_value "${A_DB_VOLUME[0]}" "${A_DB_VOLUME[1]}")
DB_NAME=$(enter_value "${A_DB_NAME[0]}" "${A_DB_NAME[1]}")
DB_USER=$(enter_value "${A_DB_USER[0]}" "${A_DB_USER[1]}")
DB_PASS=$(enter_passwd "${A_DB_PASS[0]}" "${A_DB_PASS[1]}")
echo "........"
echo "password"
DB_CONTAINER=$(enter_value "${A_DB_CONTAINER[0]}" "${A_DB_CONTAINER[1]}")
WIKI_PORT=$(enter_value "${A_WIKI_PORT[0]}" "${A_WIKI_PORT[1]}")
WIKI_CONTAINER=$(enter_value "${A_WIKI_CONTAINER[0]}" "${A_WIKI_CONTAINER[1]}")
CLOUD_NAME=$(enter_value "${A_CLOUD_NAME[0]}" "${A_CLOUD_NAME[1]}")

#--
if [ ! -d ${BACKUP_DIR} ]; then
	cmdrun "mkdir -p ${BACKUP_DIR}" "(0) 백업 폴더를 처음으로 만듭니다."
fi
#--
cmdrun "find ${BACKUP_DIR} -maxdepth 1 -print0 | xargs -0 ls -lhd" "(1) 백업 폴더에 있는 백업된 wiki 파일들입니다."
# -maxdepth 1 : 현재 디렉토리(/home/test/)의 하위 디렉토리를 탐색하지 않고,
#               오직 해당 디렉토리의 파일만 찾도록 제한합니다.
# -print      : 찾은 파일의 전체 경로를 출력합니다.
#-------------- find /home/test/ -maxdepth 1 -print
#--
RESTORE_FILE=$1
if [ ! -f "${RESTORE_FILE}" ]; then
	#-- $1= 백업된 파일이 없으면,

    cat <<__EOF__
${mmm}#-- ${ccc}${RESTORE_FILE} ${bbb}#-- 백업된 wiki 파일이 없습니다.
${mmm}#-- ${ggg}리스토어 하려는 wiki 파일의 이름을 루트(/) 부터 시작해서 입력 하세요.${xxx}
__EOF__

    read RESTORE_FILE
    if [ ! -f ${RESTORE_FILE} ]; then
		echo "${mmm}#-- 지정한 ${rrr}${RESTORE_FILE} ${bbb}파일이 없으므로 작업을 중단합니다.${xxx}"
		exit -5001 #-- ${RESTORE_FILE} 없음
	fi
	#-- $1= 백업 파일이 없으면,
fi
cmdrun "ls -l ${RESTORE_FILE}" "(2) 리스토어 하려는 백업된 wiki 파일 입니다."

cmdrun "sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a" "(3) wiki 컨테이너를 리스토어가 끝날 때까지 중지합니다."

echo "${yyy}#-- ${bbb}(4) 현재의 wiki DB 를 ${ccc}백업하지 않으려면${bbb}, 소문자 ${yyy}'${rrr}n${yyy}' ${bbb}을 눌러 주세요.${xxx}"
read N_is_current_no_backup ; echo "${uuu}"
if [ "x${N_is_current_no_backup}" != "xn" ]; then
    N_is_current_no_backup="y"
fi
echo "${rrr}[ ${ccc}현재 wiki DB 를 백업하겠습니다 == ${yyy}'${rrr}${N_is_current_no_backup}${yyy}' ${rrr}]${xxx}"

if [ "x$N_is_current_no_backup" = 'xn' ]; then
    #---- 'n': 백업을 하지 않겠다고 하면, 한번 더 물어본다.

    cat <<__EOF__
# |
# |
# |
# |
# |
# | ${mmm}!!!! 주의 !!!!${xxx} 현재 wiki DB 를 백업한 뒤에, 업로드 하는게 좋습니다.
# |
# | 백업을 하지 않기 위해서, 소문자 ${yyy}'${rrr}n${yyy}'${xxx} 을 누르면
# | 현재의 ${mmm}wiki DB 백업을 하지 않습니다.${xxx}
# |
# | 소문자 ${yyy}'${rrr}n${yyy}'${xxx} 이 아니거나 그냥 Enter 를 누르면 wiki 백업 작업이 먼저 진행됩니다.
# |
# | (5) wiki 백업을 하지 않으려면, ${yyy}'${rrr}n${yyy}'${xxx} Enter: (${mmm}'n' = NO BACKUP${xxx}):
__EOF__

    read n_is_no_backup ; echo "${uuu}"
    if [ "x$n_is_no_backup" = "xn" ]; then
        N_is_current_no_backup="n"
		a="wiki 백업 하지 않음"
    else
        N_is_current_no_backup="y"
		a="wiki 백업함"
    fi
    echo "${rrr}[ ${ccc}현재 wiki DB 를 = ${yyy}${a} ${rrr}]${xxx}"

    #---- 'n': 백업을 하지 않겠다고 하면, 한번 더 물어본다.
fi

if [ "x$N_is_current_no_backup" = 'xn' ]; then

    cat <<__EOF__
# |
# | $(date +%y%m%d_%a-%H%M)
# |
# | (5-a) 현재의 wiki DB 를 백업 하지 않습니다.
# |
__EOF__

else
	#-- (5-b) ----> 현재 wiki DB 를 다운로드 + 백업 합니다.
    #--
    cat <<__EOF__
# |
# | (5-b.1) 백업하는 .7z 파일에 지정해 줄 새로운 ===${ccc}비밀번호${xxx}=== 를 입력하세요.
${bbb}v=== 비번 입력:${xxx}
__EOF__
    read -s BACKUP_PSWD

    BACKUP_FILE=${BACKUP_DIR}/wiki_$(date +%y%m%d_%a-%H%M)-$(uname -n).sql.7z
	CLOUD_Y2M2=${DB_CONTAINER}/$(date +%y%m)
    cmdrun "sudo bash -c \"docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -p${BACKUP_PSWD} -si ${BACKUP_FILE}\"" "(5-b.2) 업로드 하기전에, 현재의 wiki DB 파일을 백업합니다."

    cmdrun "rclone copy ${BACKUP_FILE} ${CLOUD_NAME}:${CLOUD_Y2M2}/" "(5-b.3) wiki DB 파일을 클라우드로 복사합니다."
    cmdrun "rclone lsl ${CLOUD_NAME}:${CLOUD_Y2M2}" "(5-b.4) 클라우드 폴더의 내용입니다."
    #--
	#-- (5-b) <---- 현재 wiki DB 를 다운로드 + 백업 합니다.
fi

echo "sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}------(6) 현재의 wiki DB 를 삭제합니다."
sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}

### cmdrun "sudo rm -rf ../pgsql" "(6-2) 현재의 wiki DB 를 담은 폴더도 삭제합니다."

echo "sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}------(7) 빈 wiki DB 를 새로 만듭니다."
sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}

cat <<__EOF__
# |
# | 백업된 wiki DB 파일을 데이터베이스에 다시 붓습니다. (RESTORE)
# |
# | (8) 백업할때 입력한 ----비밀번호---- 를 입력하세요.
# |
${bbb}vvvv 비번 입력:${xxx}
__EOF__
read -s backup_pswd

cmdrun "7za x -p${backup_pswd} -so ${RESTORE_FILE} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} -d ${DB_NAME}" "(9) 백업된 wiki DB 파일을 데이터베이스에 다시 붓습니다. (RESTORE)"

cmdrun "sudo docker ps -a" "(10) 멈췄던 위키 컨테이너를 다시 시작합니다."

cmdrun "sudo docker start ${WIKI_CONTAINER}" "sudo docker start ${WIKI_CONTAINER}"

cmdrun "sudo docker ps -a" "sudo docker ps -a"

cat <<__EOF__
# |
# |
# | (11) 백업 작업이 끝났습니다.
# |
# | 리스토어 하기전 최종 백업한 BACKUP_FILE: ${BACKUP_FILE}
__EOF__
ls -l ${BACKUP_FILE}

cat <<__EOF__
# |
# | DB 는 이 파일로 복구 하였음 - RESTORE_FILE: ${RESTORE_FILE}
__EOF__
ls -l ${RESTORE_FILE}

NEW_DOCKER_FILE="${DOCKER_ROOT}/compose/docker-compose-$(date +%y%m%d_%a-%H%M).yml"

cat > ${NEW_DOCKER_FILE} <<__EOF__
services:

  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: ${DB_NAME} #-- 데이터베이스 이름
      POSTGRES_USER: ${DB_USER} #-- 데이터베이스 사용자 이름
      POSTGRES_PASSWORD: ${DB_PASS} #-- 데이터베이스 비번

    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - ${DB_VOLUME}:/var/lib/postgresql/data #-- DB 설치위치
    container_name:
      ${DB_CONTAINER} #-- 데이터베이스 컨테이너 이름

  wiki:
    image: requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_NAME: ${DB_NAME} #-- 데이터베이스 이름
      DB_USER: ${DB_USER} #-- 데이터베이스 사용자 이름
      DB_PASS: ${DB_PASS} #-- 데이터베이스 비번

    restart: unless-stopped
    ports:
      - "${WIKI_PORT}:3000" #-- 위키연결 포트번호
    container_name:
      ${WIKI_CONTAINER} #-- 위키 컨테이너 이름
__EOF__

cat <<__EOF__
# |
# | cat ${NEW_DOCKER_FILE}
__EOF__
cat ${NEW_DOCKER_FILE}

cat <<__EOF__
# |
# | $(date +%y%m%d_%a-%H%M)
__EOF__
