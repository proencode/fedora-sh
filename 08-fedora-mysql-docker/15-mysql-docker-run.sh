#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="(15) ---MySQL--- DB 서버를 도커에 설치하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cmdRun "sudo docker ps -a" "운영중인 MySQL DB 도커들"
##for out in $(sudo docker ps -a | awk '{print $NF}')
##do
##	if [ "x$out" != "xNAMES" ]; then
##		DB_IP=$(sudo docker inspect ${out} | grep '"IPAddress"' | tail -n 1 | awk -F : '{print $2}' | awk -F \" '{print $2}')
##		echo "${out}	${DB_IP}"
##	fi
##done

cat <<__EOF__

${cRed}[${cReset} 1 ${cRed}]${cReset}.... 도커: mysqldb | 데이터베이스: gate242 | 로그: swlog | 용도: sw입출고, 올바로등록
  2  .... 도커: kaosdb | 데이터베이스: kaosorder2 | 로그: kaoslog | 용도: 주문접수, 작업공정, 납품청구, 월마감
  3  .... 도커: ksammy | 데이터베이스: ksam21 | 로그: ksamlog | 용도: 샘플실 주문.일정.공임

----> /etc/host 에 지정하려는 도커이름의 번호: (1...3)  ${cRed}[${cReset} 1 ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" = "x3" ]; then
	DOCKER_NAME=ksammy
	PORT_NO=13326
	DATABASE_NAME=ksam21
	LOG_NAME=ksamlog
	USER_NAME=ksamroot
else
if [ "x$a" = "x2" ]; then
	DOCKER_NAME=kaosdb
	PORT_NO=13316
	DATABASE_NAME=kaosorder2
	LOG_NAME=kaoslog
	USER_NAME=kaosorder2
else
	#-- default: 1
	DOCKER_NAME=mysqldb
	PORT_NO=3306
	DATABASE_NAME=gate242
	LOG_NAME=swlog
	USER_NAME=gateroot
fi
fi
echo "${cRed}[ ${cYellow}${DOCKER_NAME} ${cGreen}${DATABASE_NAME} ${cBlue}${USER_NAME} ${cCyan}${LOG_NAME} ${Red}] -OK-${cReset}"

#--

DOCKER_NETWORK_NAME=goodworld

return_value=$(sudo docker network ls | grep "${DOCKER_NETWORK_NAME}")
if [ "x${return_value}" = "x" ]; then
	cmdCont "sudo docker network create ${DOCKER_NETWORK_NAME}"
fi

#--

# DATABASE_FOLDER=${HOME}/docker-data/database/${DOCKER_NAME}
DATABASE_FOLDER=/home/docker/${DOCKER_NAME}

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

IS_DATABASE=$(sudo docker ps -a | grep ${DOCKER_NAME})
if [ "x${IS_DATABASE}" != "x" ]; then
	echo "${IS_DATABASE}"
	echo "${cRed}!!!!${cMagenta} ----> ${cCyan}${DOCKER_NAME}${cReset} 도커가 있으므로, 진행을 중단합니다."
	exit -1
fi

# ----> MySQL 용 도커 설치

# cmdCont "$(cat <<__EOF__
cat <<__EOF__
${cYellow}sudo docker run --detach \\
	--restart=always \\
	# -it \\
	--volume ${DATABASE_FOLDER}:/var/lib/mysql \\
	--env LANG=C.UTF-8 \\
	--env LC_ALL=C.UTF-8 \\
	--env MYSQL_RANDOM_ROOT_PASSWORD="true yes" \\
	--character-set-server=utf8 \\
	--collation-server=utf8_unicode_ci \\
	--name ${DOCKER_NAME} \\
	--publish ${PORT_NO}:3306 \\
	--network ${DOCKER_NETWORK_NAME} \\
	mysql:5.7
${cReset}
__EOF__
# )"

sudo docker run --detach \
	--restart=always \
	--volume ${DATABASE_FOLDER}:/var/lib/mysql \
	--env LANG=C.UTF-8 \
	--env LC_ALL=C.UTF-8 \
	--env MYSQL_RANDOM_ROOT_PASSWORD=yes \
	--name ${DOCKER_NAME} \
	--publish ${PORT_NO}:3306 \
	--network ${DOCKER_NETWORK_NAME} \
	mysql:5.7

# <---- MySQL 용 도커 설치



echo "${cCyan}#----> db 초기화 작업이 끝날때까지 최대 2 분간 기다립니다."
sleep 15
for i in 1 2 3 4 5 6 7 8
do
	return_value=$(sudo docker logs ${DOCKER_NAME} 2>&1 | grep PASSWORD)
	if [ "x${return_value}" = "x" ]; then
		cmdRun "sleep 15s" "#-- 비밀번호 확인 ${i}"
	else
		break
	fi
done

#--

if [ "x${return_value}" = "x" ]; then
	cmdCont "sudo docker logs ${DOCKER_NAME} 2>&1 | grep --color PASSWORD" "${cRed}# <---- 비밀번호를 계속 확인해야 합니다."
else
	cmdRun "sudo docker logs ${DOCKER_NAME} 2>&1 | grep --color PASSWORD" "# <---- (0) 위에 표시된 비밀번호를 복사합니다."
fi

# ----
rm -f ${log_name} ### ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
### cmdRun "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}

cat <<__EOF__
sudo docker exec -it ${DOCKER_NAME} mysql -u root -p ${cMagenta}# <---- ${cYellow}(1) ${cMagenta}Enter password: 가 나오면, GENERATED ROOT PASSWORD 를 여기에 붙여넣기 합니다.${cReset}

alter user 'root'@'%' identified by '<>-<>-<>' ; grant all privileges on *.* to 'root'@'%' with grant option ; create database if not exists ${DATABASE_NAME} character set utf8 ; create user '${USER_NAME}'@'%' identified by '<>-<>-<>' ; grant all privileges on *.* to '${USER_NAME}'@'%' with grant option ; exit ; ${cGreen}-- -- -- -- ${cYellow}(2) ${cMangeta}<>-<>-<> 자리에 비번을 넣습니다. 복사할때 앞의 ${cGreen}초록색 -- -- -- -- ${cMagenta} 까지만 복사해야 합니다.${cReset}

sudo docker exec -it ${DOCKER_NAME} /bin/bash ; sudo docker restart ${DOCKER_NAME} ; sudo docker ps -a ; ls --color ${CMD_DIR} ; ls --color ${logs_folder} ${cMagenta}# <---- ${cYellow}(3) ${cMagenta}docker 를 다시 시작해서 아래의 (4) 를 실행할 준비를 합니다.${cReset}

echo "character-set-server=utf8" >> /etc/mysql/mysql.conf.d/mysqld.cnf ; tail -3 /etc/mysql/mysql.conf.d/mysqld.cnf ; exit ${cMagenta}# <---- ${cYellow}(4) ${cMagenta}docker 에서 utf8 을 쓰도록 지정합니다.${cReset}
             |
	     | 위와 같이 (1) ~ (4) 를 진행해야 설치가 끝납니다.
__EOF__


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color     ${zz00log_name}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
