#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq
MEMO="백업파일을 wiki.js 데이터베이스에 리스토어 하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----
DOCKER_DIR=/home/docker
DB_DIR=${DOCKER_DIR}/pgsql
#-- pgsql db
DB_USER="imwiki"
DB_PSWD="wikijsrocks"
DB_NAME="wikidb"
DB_CONTAINER="wikipg"
#-- wiki.js
WIKI_CONF_DIR=${DOCKER_DIR}/wiki_conf
WIKI_CONTAINER="wikijs"
WIKI_PORT_NO="9900"
#-- services
DB_SERVICE="db"
WIKI_SERVICE="wiki"

#-- local/remote folder
LOCAL_FOLDER="/home/backup/wikidb" #- 보관용 로컬 저장소
CLOUD_NAME="yosjgc" #- rclone 이름
CLOUD_FOLDER="wikijs" #- 원격 저장소의 첫번째 폴더 이름

#--

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
#- 백업파일을 DB 에 도로 담으면, 현재 운영중인 데이터베이스는 지워지므로,
#- 현재 운영중인 데이터베이스를 백업하려고 합니다.
#-
#- 만일 ${cRed}백업할 필요가 없다면 ${cYellow}'n' ${cBlue}을 눌러 주세요.
#-${cReset}
__EOF__
read a ; echo "[ $a ]"
last_skip="backup_ok"
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


cmdRun "sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a" "#-- (2) 백업을 위해 wiki.js 도커를 중단합니다."

#--

if [ "x${last_skip}" = "xbackup_ok" ]; then
    this_y4m2=$(date +%Y)-$(date +%m) #- 2022-08
    LOCAL_Y2M2=${LOCAL_FOLDER}/${this_y4m2}
    if [ ! -d ${LOCAL_Y2M2} ]; then
            echo "#-- (8-3) ${LOCAL_Y2M2} 로컬 디렉토리를 만듭니다."
        mkdir -p ${LOCAL_Y2M2}
    fi
    dir_for_backup=${CLOUD_FOLDER}/${this_y4m2}
    current_backup="last-wikijs-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
    cat <<__EOF__
${cBlue}#-
#- (3) 지정한 백업파일을 DB 서버에 ${cRed}리스토어 하기전에${cBlue}, 현재 운영중인 DB 를 먼저 백업합니다.
#-
#- 백업시 ${cYellow}비밀번호 ${cBlue}를 입력하세요.
#-${cReset}
__EOF__
    cmdRun "sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | time 7za a -si ${dir_for_backup}/${current_backup} -p" "#-- (4) 현재 운영중인 DB 를 먼저 ${dir_for_backup} 에 백업합니다."
fi

#--

#cmdRun "sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}" "#-- (5) 데이터베이스를 삭제합니다."
cmdRun "sudo docker exec  ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}" "#-- (5) 데이터베이스를 삭제합니다."
cmdRun "sudo docker exec  ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}" "#-- (6) 데이터베이스를 새로 만듭니다."
cat <<__EOF__
${cBlue}#-
#-- (7) 지정한 백업파일을 ${cRed}DB 서버에${cBlue} 리스토어 합니다.
#-
#- 백업시 ${cYellow}비밀번호 ${cBlue}를 입력하세요.
#-${cReset}
__EOF__
cmdRun "time 7za x -so ${db_sql_7z} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} ${DB_NAME}" "#-- (8) 백업파일을 DB 에 리스토어 합니다."
cmdRun "sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a" "#-- (9) 중단했던 wiki.js 도커를 다시 시작합니다."


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
