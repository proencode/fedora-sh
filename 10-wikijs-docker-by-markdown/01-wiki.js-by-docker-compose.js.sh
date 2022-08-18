#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${CMD_DIR}/color_base #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp cat_and_run cat_and_read cat_and_readY

MEMO="docker-compose wiki.js 설치"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
출처: https://computingforgeeks.com/install-and-use-docker-compose-on-fedora/
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cat_and_run "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----

port_no=5800
db_folder=/home/docker/pgsql
wiki_conf_dir=/home/docker/wikijs.conf

if [ ! -d ${db_folder} ]; then
	cat_and_run "sudo mkdir -p ${db_folder}"
	cat_and_run "sudo chcon -R system_u:object_r:container_file_t:s0 ${db_folder}"
	cat_and_run "sudo chown -R systemd-coredump.ssh_keys ${db_folder}"
	cat_and_run "ls -lZ ${db_folder}" "(1) 데이터베이스 폴더를 만들었습니다."
else
	echo "${cRed}!!!!${cMagenta} ----> ${cCyan}${db_folder}${cReset} 디렉토리가 있으므로, 확인후 삭제하고 다시 시작하세요."
	exit 1
fi

if [ ! -d ${wiki_conf_dir} ]; then
	cat_and_run "sudo mkdir -p ${wiki_conf_dir} ; sudo chown -R ${USER}.${USER} ${wiki_conf_dir}" "(2a) 위키설정용 폴더를 만들었습니다."
else
	cat_and_run "sudo ls -lZ ${wiki_conf_dir}" "(2b) 위키설정용 폴더가 있습니다."
fi
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

cat_and_run "sudo dnf -y install docker-compose" "(3) Docker Compose 설치"
cat_and_run "rpm -qi docker-compose" "(4) 설치 확인"
cat_and_run "sudo docker ps -a" "(5) 도커 확인"
cat_and_run "sudo docker-compose pull wiki" "(6) 도커 컴포즈 빌드"

cat_and_run "sudo docker-compose ps" "(10) 실행중인 작업을 확인합니다."
cat_and_run "ifconfig | grep enp -A1 ; ifconfig | grep wlp -A1" "(112) ip 를 확인합니다."
cat_and_run "ifconfig | grep enp -A1 | tail -1 | awk '{print \$2\":${port_no}\"}'" "(12) ethernet"
cat_and_run "ifconfig | grep wlp -A1 | tail -1 | awk '{print \$2\":${port_no}\"}'" "(13) wifi"
cat_and_run "sudo docker-compose up --force-recreate &" "(14) 도커 실행"
cat_and_run "sudo docker-compose ps -a" "(15) 모든 작업을 확인합니다."


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
cat_and_run "ls --color ${1}" "프로그램들" ; ls --color ${zz00logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"

cat  <<__EOF__

${cCyan}#--- 출처: https://wiki.js.org/
${cRed}+----------------+${cReset}
${cRed}|                |${cReset}
${cRed}| ${cReset}localhost:${port_no} ${cRed}| ${cGreen}#--- 위키서버가 실행되면 브라우저에서 이와같이 입력합니다.
${cRed}|                |${cReset}
${cRed}+----------------+${cReset}
${cCyan}cd ${wiki_conf_dir} ; sudo docker-compose down #--- 작업을 중단하려면, 입력합니다. ${cReset}
__EOF__
