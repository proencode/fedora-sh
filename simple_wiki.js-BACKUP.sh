#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="wiki.js 데이터를 google drive 에 백업"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


DB_NAME="wiki" #- 백업할 데이터베이스 이름
#-
cmdRun "sudo docker ps -a ; sudo docker stop wikijs" "(1) 위키 도커를 중단합니다."
LOCAL_FOLDER="/home/backup/simple_wikidb" #- 보관용 로컬 저장소
if [ ! -d ${LOCAL_FOLDER} ]; then
	cmdRun "sudo mkdir -p ${LOCAL_FOLDER} ; sudo chown ${USER}.${USER} ${LOCAL_FOLDER}" "(2) 보관용 로컬 저장소 폴더를 새로 만듭니다."
fi
this_y4m2=$(date +%Y)-$(date +%m) #- 2022-08
LOCAL_Y2M2=${LOCAL_FOLDER}/${this_y4m2}
if [ ! -d ${LOCAL_Y2M2} ]; then
    cmdRun "mkdir -p ${LOCAL_Y2M2}" "(3) ${LOCAL_Y2M2} 로컬 디렉토리를 만듭니다."
fi
cmdRun "ls -lR ${LOCAL_Y2M2}" "(4) 보관용 로컬 디렉토리 입니다."
#-
REMOTE_FOLDER="simple_wiki.js" #- 원격 저장소의 첫번째 폴더 이름
RCLONE_NAME="yosjgc" #- rclone 이름
REMOTE_Y2M2=${REMOTE_FOLDER}/${this_y4m2}
#-
ymd_hm=$(date +"%y%m%d%a-%H%M")
DB_sql7z=${DB_NAME}_${ymd_hm}_$(uname -n).sql.7z #- 압축파일 이름
cat <<__EOF__
${cMagenta}
#- DB 백업

#- ${cRed}${DB_sql7z} ${cMagenta}데이터베이스를 백업하기 위해서 아래에 ${cRed}----${cYellow}비밀번호${cRed}----${cMagenta} 를 입력하세요.
${cReset}
__EOF__
cmdRun "sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${LOCAL_Y2M2}/${DB_sql7z} -p" "(5) 데이터베이스를 백업하기 위해서 아래에 ${cRed}----${cYellow}비밀번호${cRed}----${cCyan} 를 입력하세요."
cmdRun "ls -lR ${LOCAL_Y2M2}" "(6) 보관용 로컬 폴더입니다."
cmdRun "/usr/bin/rclone copy ${LOCAL_Y2M2}/${DB_sql7z} ${RCLONE_NAME}:${REMOTE_Y2M2}/" "(7) 오늘 요일이름의 파일을 클라우드로 복사합니다."
cmdRun "/usr/bin/rclone lsl ${RCLONE_NAME}:${REMOTE_Y2M2}" "(8) 클라우드 폴더입니다."
#-
cmdRun "sudo docker start wikijs ; sudo docker ps -a" "(9) 위키 도커를 다시 시작합니다."


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
