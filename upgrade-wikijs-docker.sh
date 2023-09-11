#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="docker-compose wiki.js 설치"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cat <<__EOF__
출처: https://docs.requarks.io/install/upgrade

__EOF__

WikiJs_Name="wikijs"
Port_Number="5800"

cmdRun "sudo docker ps -a" "(1) WikiJs 도커가 실행중인지 확인합니다."
cmdYenter "sudo docker stop ${WikiJs_Name} ; docker rm ${WikiJs_Name}" "(2) ${WikiJs_Name} 도커를 삭제합니다."
# Pull latest image of Wiki.js
cmdCont "sudo docker pull ghcr.io/requarks/wiki:2" "(3) Wiki.js 의 최종 이미지를 가져옵니다."

# Create new container of Wiki.js based on latest image
cmdCont "sudo docker run -d -p ${Port_Number}:3000 --name wiki --restart unless-stopped -e "DB_TYPE=mysql" -e "DB_HOST=db" -e "DB_PORT=3306" -e "DB_USER=wikijs" -e "DB_PASS=wikijsrocks" -e "DB_NAME=wiki" ghcr.io/requarks/wiki:2
#--


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
