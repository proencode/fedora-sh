#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="00 docker-compose 로 mysql 설치하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
#--zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
#--zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cmdRun "sudo docker-compose ps -a" "운영중인 MySQL DB 도커들"
##for out in $(sudo docker ps -a | awk '{print $NF}')
##do
##	if [ "x$out" != "xNAMES" ]; then
##		DB_IP=$(sudo docker inspect ${out} | grep '"IPAddress"' | tail -n 1 | awk -F : '{print $2}' | awk -F \" '{print $2}')
##		echo "${out}	${DB_IP}"
##	fi
##done

CONTAINER_NAME=xlsmycon
PORT_NO=7700
DATABASE_NAME=minjsdb
LOG_NAME=xlsmyconlog
USER_NAME=xlsmyconroot

echo "${cRed}[ ${cYellow}${CONTAINER_NAME} ${cGreen}${DATABASE_NAME} ${cBlue}${USER_NAME} ${cCyan}${LOG_NAME} ${Red}] -OK-${cReset}"

#--

DOCKER_NETWORK_NAME=goodworld

return_value=$(sudo docker network ls | grep "${DOCKER_NETWORK_NAME}")
if [ "x${return_value}" = "x" ]; then
	cmdCont "sudo docker network create ${DOCKER_NETWORK_NAME}"
fi

#--

# DATABASE_FOLDER=${HOME}/docker-data/database/${CONTAINER_NAME}
DATABASE_FOLDER=/home/docker/${CONTAINER_NAME}

if [ ! -d ${DATABASE_FOLDER} ]; then
	echo "----> ${cGreen}sudo mkdir -p ${DATABASE_FOLDER}${cReset}"
	sudo mkdir -p ${DATABASE_FOLDER}
	cmdRun "sudo chcon -R system_u:object_r:container_file_t:s0 ${DATABASE_FOLDER}"
	cmdRun "sudo chown -R systemd-coredump:ssh_keys ${DATABASE_FOLDER}"
	cmdRun "ls -lZ ${DATABASE_FOLDER}" "디렉토리를 만들었습니다."
else
	cmdRun "ls -l ${DATABASE_FOLDER}"
	echo "${cRed}!!!!${cMagenta} ----> ${cCyan}${DATABASE_FOLDER}${cReset} 디렉토리가 있으므로, 진행을 중단합니다."
	exit -1
fi

IS_DATABASE=$(sudo docker ps -a | grep ${CONTAINER_NAME})
if [ "x${IS_DATABASE}" != "x" ]; then
	sudo docker ps -a | grep ${IS_DATABASE}
	CAT <<__EOF__
${cRed}!!!!${cMagenta} ----> ${cCyan}${CONTAINER_NAME}${cReset} 도커가 있으므로, 진행을 중단합니다.
__EOF__
	exit -1
fi

# ----> MySQL 용 도커 설치

# cmdCont "$(cat <<__EOF__
XML_FILE="docker-compose.yml"
if [ -f "${XML_FILE}" ]; then
	cmdRun "ls -l ${XML_FILE}"
	cat <<__EOF__
${cRed}!!!!${cMagenta} ----> ${cCyan}${XML_FILE}${cReset} 파일이 있으므로, 진행을 중단합니다.
__EOF__
	exit -1
fi

cat > ${XML_FILE} <<__EOF__
version: '3.8'
services:
  database:
    image: mysql:latest
    container_name: xlsmycon
    environment:
      MYSQL_RANDOM_ROOT_PASSWORD: 1
    ports:
      - "7700:3306"
    volumes:
      - /home/docker/mysql:/var/lib/mysql
__EOF__

cmdRun "cat ${XML_FILE}"
cmdRun "sudo docker-compose up &"



echo "${cCyan}#----> db 초기화 작업이 끝날때까지 최대 2 분간 기다립니다."
sleep 15
for i in 1 2 3 4 5 6 7 8
do
	return_value=$(sudo docker logs ${CONTAINER_NAME} 2>&1 | grep PASSWORD)
	if [ "x${return_value}" = "x" ]; then
		cmdRun "sleep 15s" "#-- 비밀번호 확인 ${i}"
	else
		break
	fi
done

#--

if [ "x${return_value}" = "x" ]; then
	cmdCont "sudo docker logs ${CONTAINER_NAME} 2>&1 | grep --color PASSWORD" "${cRed}# <---- 비밀번호를 계속 확인해야 합니다."
else
	cmdRun "sudo docker logs ${CONTAINER_NAME} 2>&1 | grep --color PASSWORD" "# <---- (0) 위에 표시된 비밀번호를 복사합니다."
fi

# ----
rm -f ${log_name} ### ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
### cmdRun "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}

cat <<__EOF__
sudo docker exec -it ${CONTAINER_NAME} mysql -u root -p ${cMagenta}# <---- ${cYellow}(1) ${cMagenta}Enter password: 가 나오면, GENERATED ROOT PASSWORD 를 여기에 붙여넣기 합니다.${cReset}

alter user 'root'@'%' identified by '<>-<>-<>' ; grant all privileges on *.* to 'root'@'%' with grant option ; create database if not exists ${DATABASE_NAME} character set utf8 ; create user '${USER_NAME}'@'%' identified by '<>-<>-<>' ; grant all privileges on *.* to '${USER_NAME}'@'%' with grant option ; exit ; ${cGreen}-- -- -- -- ${cYellow}(2) ${cMangeta}<>-<>-<> 자리에 비번을 넣습니다. 복사할때 앞의 ${cGreen}초록색 -- -- -- -- ${cMagenta} 까지만 복사해야 합니다.${cReset}

sudo docker exec -it ${CONTAINER_NAME} /bin/bash ; sudo docker restart ${CONTAINER_NAME} ; sudo docker ps -a ; ls --color ${CMD_DIR} ; ls --color ${logs_folder} ${cMagenta}# <---- ${cYellow}(3) ${cMagenta}docker 를 다시 시작해서 아래의 (4) 를 실행할 준비를 합니다.${cReset}

echo "character-set-server=utf8" >> /etc/mysql/mysql.conf.d/mysqld.cnf ; tail -3 /etc/mysql/mysql.conf.d/mysqld.cnf ; exit ${cMagenta}# <---- ${cYellow}(4) ${cMagenta}docker 에서 utf8 을 쓰도록 지정합니다.${cReset}
             |
	     | 위와 같이 (1) ~ (4) 를 진행해야 설치가 끝납니다.
__EOF__


# ----
#--rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
#--ls --color     ${zz00log_name}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
