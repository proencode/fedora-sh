#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
	echo "${yyy}# ----> ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | sh
	echo "${yyy}# <~~~~ ${bbb}$1 #-- $2${xxx}"
}

cmdrun "sudo docker ps -a" "(1-1) 현재 도커 작업"
cmdrun "sudo docker stop wikijs wikijsdb" "(1-2) 도커 정지"
cmdrun "sudo docker rm wikijs wikijsdb" "(1-3) 도커 삭제"
cmdrun "sudo docker ps -a" "(1-4) 현재 도커 작업"
cmdrun "for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done" "(1-5) 이전 버전 제거"
echo "#------------ 1. 이전 버전 제거"
echo "#------------"

cmdrun "sudo apt-get update" "(2-1) Add Docker's official GPG key:"
cmdrun "sudo apt-get install ca-certificates curl" "(2-2)"
cmdrun "sudo apt-get install ca-certificates curl" "(2-3)"
cmdrun "sudo install -m 0755 -d /etc/apt/keyrings" "(2-4)"
cmdrun "sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc" "(2-5)"
cmdrun "sudo chmod a+r /etc/apt/keyrings/docker.asc" "(2-6)"

echo "${yyy}# ----> ${ccc}echo ... | sudo tee /etc/apt/sources.list.d/docker.list ${ggg}#-- ${bbb}(2-7) Add the repository to Apt sources: ${xxx}"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
cmdrun "sudo apt-get update" "(2-8)"
echo "#------------ 2. Docker 저장소를 설정"
echo "#------------"

cmdrun "sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin" "(3-1)"
echo "#------------ 3. Docker 패키지를 설치"
echo "#------------"

y4=$(date +%Y) #-- 2023

cmdrun "ls -R /home/docker" "(4-1) 삭제하려는 디렉토리 확인"
echo "${rrr}# ----> ${ccc}(4-2) /home/docker 디렉토리를 삭제합니다. ${mmm}press Enter:${xxx}"
read a
cmdrun "sudo rm -rf /home/docker" "(4-3)"
cmdrun "sudo mkdir -p /home/docker/backup/${y4} /home/docker/compose /home/docker/pgreswiki" "(4-4)"
cmdrun "sudo chown -R ${USER}:${USER} /home/docker/backup" "(4-5)"
cmdrun "sudo chmod -R 755 /home/docker/backup" "(4-6)"
cmdrun "sudo chown ${USER}:${USER} /home/docker/compose /home/docker/backup/${y4}" "(4-7)"
echo "#------------ 4. 디렉토리를 지우고 새로 만듬."
echo "#------------"

cat > /home/docker/compose/docker-compose.yml <<__EOF__
version: "3"
services: #-- orangepi59zero2w 240214-1424

  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: wiki #wikidb #-- old_name= wiki #-- 데이터베이스 이름
      POSTGRES_USER: wikijs #imwiki #-- old_name= wikijs #-- 사용자 이름
      POSTGRES_PASSWORD: wikijsrocks #wikiam9ho #-- old_name= wikijsrocks #-- 비번

    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - /home/docker/pgreswiki:/var/lib/postgresql/data
    container_name:
      wikijsdb #dbcntnr #-- old_name= wikijsdb #-- db: 컨테이너 이름

  wiki:
    image: requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_NAME: wiki #wikidb #-- old_name= wiki #-- 데이터베이스 이름
      DB_USER: wikijs #imwiki #-- old_name= wikijs #-- 사용자 이름
      DB_PASS: wikijsrocks #wikiam9ho #-- old_name= wikijsrocks #-- 비번

    restart: unless-stopped
    ports:
      - "5740:3000"
    container_name:
      wikijs #wikicntnr #-- old_name= wikijs #-- wiki: 컨테이너 이름
__EOF__
cmdrun "sudo ls -alR /home/docker/" "(5-1)"
echo "${rrr}# ----> ${ccc}(5-2) 디렉토리를 다시 만들었습니다. ${mmm}press Enter:${xxx}"
read a
echo "#------------ 5. Wiki.js 디렉토리 만들고, yml 저장"
echo "#------------"

echo "${yyy}# ----> ${ccc}(6-1) cd /home/docker/compose${xxx}"
cd /home/docker/compose
#-- time sudo docker-compose pull wikijs
cmdrun "sudo docker compose up -d" "(6-2) wikijs 실행"
echo "#------------ 6. wiki.js 도커 실행"
echo "#------------"

if [ "x$1" = "x" ] || [ ! -f ${up_file} ]; then
	cmdrun "ls ~/wind*/wiki*/wiki*z*" "(7-1) 업로드할 파일 목록보기"
	echo "${rrr}# ----> ${ccc}(7-2) 업로드할 파일이름을 입력하세요.${xxx}"
	read up_file
	if [ "x${up_file}" = "x" ] || [ ! -f ${up_file} ]; then
		echo "#-- ${up_file}(7-3) 파일이 없습니다."
		exit -1
	fi
else
	up_file="$1"
fi
echo "#------------ 7. 업로드할 파일 선택"
echo "#------------"

cmdrun "bash ~/bin/31-last-12-sql.7z--RESTORE-to--wikijs-DB.sh ${up_file}" "(8-1) wiki DB 업로드"
echo "#------------ 8. 업로드 작업"
echo "#------------"
