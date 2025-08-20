#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
        echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${bbb}#-- $1 #-- $2${xxx}"
}
cmdend () {
        echo "${bbb}#--///-- ${mmm}$1${xxx}"
}
cmdreada_s () { #-- cmdreada_s "(1) INPUT: port no" "(입력시 표시 안됨)"
    echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"
    read -s reada_s
}
cmdreada () { #-- cmdreada "(2) INPUT: domain name" "호스트 주소 입력"
    echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"
    read reada
}

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then CMD_DIR="."; fi


tt_seq="1"; tt_msg="이전의 버전 제거하기"; i=1

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc
do
	cmdrun "sudo apt-get remove $pkg" "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
done


tt_seq="2"; tt_msg="apt 로 도커 설치"; i=1

cmdrun "sudo apt-get update"                            "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "sudo apt-get install ca-certificates curl"      "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "sudo install -m 0755 -d /etc/apt/keyrings"      "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc" "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "sudo chmod a+r /etc/apt/keyrings/docker.asc"    "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))

echo "${yyy}#-- ${ccc}sudo tee /etc/apt/sources.list.d/docker.list > /dev/null ${ggg}#-- ${bbb}(${tt_seq}-${i}) ${tt_msg}${xxx}"; i=$(( i + 1 ))
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "${bbb}#-- sudo tee /etc/apt/sources.list.d/docker.list > /dev/null #-- (${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "sudo apt-get update && sudo apt upgrade -y"     "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))


tt_seq="3"; tt_msg="Docker 패키지 설치"; i=1

cmdrun "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin" "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "sudo service docker start"                      "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))

DIR_BACKUP="/home/docker/backup"
DIR_COMPOSE="/home/docker/compose"
DIR_PGSQL="/home/docker/pgsql"


tt_seq="4"; tt_msg="Wiki.js 디렉토리 만들기"; i=1

cmdrun "sudo mkdir -p ${DIR_BACKUP}  ${DIR_COMPOSE}  ${DIR_PGSQL}"       "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "sudo chown -R ${USER}:${USER}  ${DIR_BACKUP}"                    "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "sudo chmod -R 755 ${DIR_BACKUP}"                                 "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "y4=$(date +%Y) #-- 2023"                                         "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "mkdir ${DIR_BACKUP}/${y4}"                                       "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
cmdrun "sudo chown ${USER}:${USER}  ${DIR_COMPOSE}  ${DIR_BACKUP}/${y4}" "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))


tt_seq="5"; tt_msg="이전의 yml 이름 바꾸기"; i=1

if [ -f ${DIR_COMPOSE}/docker-compose.yml ]; then
    i=1
	cmdrun "mv ${DIR_COMPOSE}/docker-compose.yml ${DIR_COMPOSE}/docker-compose-$(date +%y%m%d-%H%M).yml" "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
fi


tt_seq="6"; tt_msg="docker-compose.yml 만들기"; i=1

echo "${yyy}#-- ${ccc}cat <<__EOF__ > ${DIR_COMPOSE}/docker-compose.yml ${ggg}#-- ${bbb}(${tt_seq}-${i}) ${tt_msg}${xxx}"
cat <<__EOF__ > ${DIR_COMPOSE}/docker-compose.yml
# version: "3"
services:

  database:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: wiki #-- wikidb #-- 데이터베이스 이름
      POSTGRES_PASSWORD: wikijsrocks #-- wikipswd #-- 데이터베이스 비번
      POSTGRES_USER: wikijs #-- wikiuser #-- 데이터베이스 사용자 이름
    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - ${DIR_PGSQL}:/var/lib/postgresql/data #-- DB 설치위치
    container_name:
      wikijsdb #-- dbcon #-- 데이터베이스 컨테이너 이름

  wiki:
    image: requarks/wiki:2
    depends_on:
      - database
    environment:
      DB_TYPE: postgres
      DB_HOST: database
      DB_PORT: 5432
      DB_NAME: wiki #-- wikidb #-- 데이터베이스 이름
      DB_PASS: wikijsrocks #-- wikipswd #-- 데이터베이스 비번
      DB_USER: wikijs #-- wikiuser #-- 데이터베이스 사용자 이름
    restart: unless-stopped
    ports:
      - "5940:3000" #-- 위키연결 포트번호
    container_name:
      wikijs #-- wikicon #-- 위키 컨테이너 이름
__EOF__
echo "${bbb}#-- cat <<__EOF__ > ${DIR_COMPOSE}/docker-compose.yml #-- (${tt_seq}-${i}) ${tt_msg}${xxx}"


cd ${DIR_COMPOSE}

tt_seq="7"; tt_msg="docker-compose 실행"; i=1
cmdrun "sudo docker compose up -d"          "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))

            tt_msg="부팅시 실행할 수 있도록 해당 서비스 활성화"
cmdrun "sudo systemctl enable docker --now" "(${tt_seq}-${i}) ${tt_msg}"; i=$(( i + 1 ))
