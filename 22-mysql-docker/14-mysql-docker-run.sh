#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
}
cat_and_read () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cGreen}\n----> ${cCyan}press Enter${cReset}:"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cMagenta}$1 $2${cReset}"
}
cat_and_readY () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
	else
		echo "${cGreen}----> ${cRed}press ${cCyan}y${cRed} or Enter${cReset}:"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			echo "${cRed}[ ${cYellow}$1 ${cRed}] ${cCyan}<--- 명령을 실행하지 않습니다.${cReset}"
		fi
		echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cMagenta}$1 $2${cReset}"
	fi
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="---MySQL--- DB 서버를 도커에 설치하기"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

cat_and_run "sudo docker ps -a" "운영중인 MySQL DB 도커들"
##for out in $(sudo docker ps -a | awk '{print $NF}')
##do
##	if [ "x$out" != "xNAMES" ]; then
##		DB_IP=$(sudo docker inspect ${out} | grep '"IPAddress"' | tail -n 1 | awk -F : '{print $2}' | awk -F \" '{print $2}')
##		echo "${out}	${DB_IP}"
##	fi
##done

cat <<__EOF__

${cRed}[${cReset} 1 ${cRed}]${cReset}....  gatedb (gate242)
  2  .... kordmy (kaosorder)
  3  ....  ksammy (kaos 샘플실 주문.일정.공임)

----> /etc/host 에 지정하려는 도커이름: (1...3)  ${cRed}[${cReset} 1 ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" = "x3" ]; then
	DOCKER_DB_NAME=ksammy
	NEW_DATABASE=ksam21
	USER_NAME=ksamroot
else
if [ "x$a" = "x2" ]; then
	DOCKER_DB_NAME=kordmy
	NEW_DATABASE=kord21
	USER_NAME=kordroot
else
	#-- default: 1
	DOCKER_DB_NAME=gatedb
	NEW_DATABASE=gate242
	USER_NAME=gateroot
fi
fi
echo "${cYellow}[${cReset} ${DOCKER_DB_NAME} ${cYellow}] ${cRed}-OK-${cReset}"

#--

DOCKER_NETWORK_NAME=goodworld

return_value=$(sudo docker network ls | grep "${DOCKER_NETWORK_NAME}")
if [ "x${return_value}" = "x" ]; then
	cat_and_read "sudo docker network create ${DOCKER_NETWORK_NAME}"
fi

#--

# DATABASE_FOLDER=${HOME}/docker-data/database/${DOCKER_DB_NAME}
DATABASE_FOLDER=/home/docker-data/database/${DOCKER_DB_NAME}

if [ ! -d ${DATABASE_FOLDER} ]; then
	echo "----> ${cGreen}sudo mkdir -p ${DATABASE_FOLDER}${cReset}"
	sudo mkdir -p ${DATABASE_FOLDER}
	cat_and_run "sudo chcon -R system_u:object_r:container_file_t:s0 ${DATABASE_FOLDER}"
	cat_and_run "sudo chown -R systemd-coredump.ssh_keys ${DATABASE_FOLDER}"
	cat_and_run "ls -lZ ${DATABASE_FOLDER}" "디렉토리를 만들었습니다."
else
	cat_and_run "ls -l ${DATABASE_FOLDER}"
	echo "${cRed}!!!!${cMagenta} ----> ${cCyan}${DATABASE_FOLDER}${cReset} 디렉토리가 있으므로, 진행을 중단합니다."
	exit -1
fi

IS_DATABASE=$(sudo docker ps -a | grep ${DOCKER_DB_NAME})
if [ "x${IS_DATABASE}" != "x" ]; then
	echo "${IS_DATABASE}"
	echo "${cRed}!!!!${cMagenta} ----> ${cCyan}${DOCKER_DB_NAME}${cReset} 도커가 있으므로, 진행을 중단합니다."
	exit -1
fi

# ----> MySQL 용 도커 설치

# cat_and_read "$(cat <<__EOF__
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
	--name ${DOCKER_DB_NAME} \\
	--publish 3306:3306 \\
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
	--name ${DOCKER_DB_NAME} \
	--publish 3306:3306 \
	--network ${DOCKER_NETWORK_NAME} \
	mysql:5.7

# <---- MySQL 용 도커 설치



echo "${cCyan}#----> db 초기화 작업이 끝날때까지 최대 2 분간 기다립니다."
sleep 15
for i in 1 2 3 4 5 6 7 8
do
	return_value=$(sudo docker logs ${DOCKER_DB_NAME} 2>&1 | grep PASSWORD)
	if [ "x${return_value}" = "x" ]; then
		cat_and_run "sleep 15s" "#-- 비밀번호 확인 ${i}"
	else
		break
	fi
done

#--

if [ "x${return_value}" = "x" ]; then
	cat_and_read "sudo docker logs ${DOCKER_DB_NAME} 2>&1 | grep --color PASSWORD" "${cRed}# <---- 비밀번호를 계속 확인해야 합니다."
else
	cat_and_run "sudo docker logs ${DOCKER_DB_NAME} 2>&1 | grep --color PASSWORD" "# <---- (0) 위에 표시된 비밀번호를 복사합니다."
fi

# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}

cat <<__EOF__
sudo docker exec -it ${DOCKER_DB_NAME} mysql -u root -p # ${cMagenta}<---- (1) Enter password: 가 나오면, GENERATED ROOT PASSWORD 를 여기에 붙여넣기 합니다.${cReset}

alter user 'root'@'%' identified by '<>-<>-<>' ; grant all privileges on *.* to 'root'@'%' with grant option ; create database if not exists ${NEW_DATABASE} character set utf8 ; create user '${USER_NAME}'@'%' identified by '<>-<>-<>' ; grant all privileges on *.* to '${USER_NAME}'@'%' with grant option ; exit ; # <>-<>-<> 자리에 비번을 넣습니다.

sudo docker exec -it ${DOCKER_DB_NAME} /bin/bash ; sudo docker restart ${DOCKER_DB_NAME} ; sudo docker ps -a ; ls --color ${CMD_DIR} ; ls --color ${logs_folder}

echo "character-set-server=utf8" >> /etc/mysql/mysql.conf.d/mysqld.cnf ; tail -3 /etc/mysql/mysql.conf.d/mysqld.cnf ; exit
             |
             | 위와 같이 진행해야 설치가 끝납니다.
__EOF__

echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
