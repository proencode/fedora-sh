#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="docker-compose wiki.js 설치"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
출처: https://computingforgeeks.com/install-and-use-docker-compose-on-fedora/
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


port_no=5800
db_folder=/home/docker/pgsql
wiki_conf_dir=/home/docker/wiki.js
cat <<__EOF__
port_no = ${port_no};
db_folder = ${db_folder};
wiki_conf_dir = ${wiki_conf_dir};
__EOF__

if [ ! -d ${db_folder} ]; then
	cmdRun "sudo mkdir -p ${db_folder}"
	cmdRun "sudo chcon -R system_u:object_r:container_file_t:s0 ${db_folder}"
	cmdRun "sudo chown -R systemd-coredump.ssh_keys ${db_folder}"
	cmdRun "ls -lZ ${db_folder}" "(1) 데이터베이스 폴더를 만들었습니다."
else
	rm -f ${zz00log_name}
	echo "${cRed}!!!!${cMagenta} ----> (2) ${cCyan}${db_folder}${cReset} 디렉토리가 있으므로, 확인후 삭제하고 다시 시작하세요."
	exit 1
fi

if [ ! -d ${wiki_conf_dir} ]; then
	cmdRun "sudo mkdir -p ${wiki_conf_dir} ; sudo chown -R ${USER}.${USER} ${wiki_conf_dir}" "(3) 위키설정용 폴더를 만들었습니다."
else
	cmdRun "sudo ls -lZ ${wiki_conf_dir}" "(4) 위키설정용 폴더가 있습니다."
fi

echo "----> cd ${wiki_conf_dir} #-- 이 디렉토리로 가서 나머지 작업을 진행합니다."
cd ${wiki_conf_dir}

cat > docker-compose.yml <<__EOF__
version: "3"
services:

  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: wiki
      POSTGRES_PASSWORD: wikijsrocks
      POSTGRES_USER: wikijs
    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - ${db_folder}:/var/lib/postgresql/data
    container_name:
      wikijsdb

  wiki:
    image: requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_USER: wikijs
      DB_PASS: wikijsrocks
      DB_NAME: wiki
    restart: unless-stopped
    ports:
      - "${port_no}:3000"
    container_name:
      wikijs
__EOF__

cmdRun "sudo dnf -y install docker-compose" "(5) Docker Compose 설치"
cmdRun "rpm -qi docker-compose" "(6) 설치 확인"
cmdRun "sudo docker ps -a" "(7) 도커 확인"
cmdRun "sudo docker-compose pull wiki" "(8) 도커 컴포즈 빌드"

cmdRun "sudo docker-compose ps" "(9) 실행중인 작업을 확인합니다."
cmdRun "ifconfig | grep enp -A1 ; ifconfig | grep wlp -A1" "(10) ip 를 확인합니다."
cmdRun "ifconfig | grep enp -A1 | tail -1 | awk '{print \$2\":${port_no}\"}'" "(11) ethernet"
cmdRun "ifconfig | grep wlp -A1 | tail -1 | awk '{print \$2\":${port_no}\"}'" "(12) wifi"
cmdYenter "sudo docker-compose up --force-recreate &" "(13) 도커 실행"
cmdRun "sudo docker-compose ps -a" "(14) 모든 작업을 확인합니다."


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
출처: https://computingforgeeks.com/install-and-use-docker-compose-on-fedora/


${cCyan}#--- 출처: https://wiki.js.org/
${cRed}+----------------+${cReset}
${cRed}|                |${cReset}
${cRed}| ${cReset}localhost:${port_no} ${cRed}| ${cGreen}#--- 위키서버가 실행되면 브라우저에서 이와같이 입력합니다.
${cRed}|                |${cReset}
${cRed}+----------------+${cReset}
${cCyan}cd ${wiki_conf_dir} ; sudo docker-compose down #--- Enter 키를 눌러보세요. ${cReset}
__EOF__
