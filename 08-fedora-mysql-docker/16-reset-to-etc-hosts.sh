#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="16. 데이터베이스에 연결하는 로그인 패쓰 지정하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cat <<__EOF__
----> 도커이름 전체
__EOF__

for out in $(sudo docker ps -a | awk '{print $NF}')
do
	if [ "x$out" != "xNAMES" ]; then
		DB_IP=$(sudo docker inspect ${out} | grep '"IPAddress"' | tail -n 1 | awk -F : '{print $2}' | awk -F \" '{print $2}')
		echo "NAMES: ${out}; IP Address: ${DB_IP}"
	fi
done

cat <<__EOF__

${cRed}[${cReset} 1 ${cRed}]${cReset}....  mysqldb (gate242)
  2  ....  kordmy (kaosorder)
  3  ....  ksammy (kaos 샘플실 주문.일정.공임)

----> /etc/host 에 지정하려는 도커이름의 번호: (1...3)  ${cRed}[${cReset} 1 ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" = "x2" ]; then
	DOCKER_NAME=kordmy
	echo "${cYellow}[${cYellow} ${DOCKER_NAME} ${cYellow}] ${cRed}-OK-${cReset}"
else
if [ "x$a" = "x3" ]; then
	DOCKER_NAME=ksammy
	echo "${cYellow}[${cYellow} ${DOCKER_NAME} ${cYellow}] ${cRed}-OK-${cReset}"
else
	#-- default: 1
	DOCKER_NAME=mysqldb
	echo "${cYellow}[${cYellow} ${DOCKER_NAME} ${cYellow}] ${cRed}-OK-${cReset}"
	a="1"
fi
fi


DOCKER_IS=$(sudo docker ps -a | grep ${DOCKER_NAME})
if [ "x${DOCKER_IS}" = "x" ]; then
	echo "${cRed}!!!!---->${cCyan} ${DOCKER_NAME} ${cYellow}의 도커가 실행되어 있지 않습니다.${cReset}"
else
	DB_IP=$(sudo docker inspect ${DOCKER_NAME} | grep '"IPAddress"' | tail -n 1 | awk -F : '{print $2}' | awk -F \" '{print $2}')

	if [ "x${DB_IP}" = "x" ]; then
		echo "${cRed}!!!!---->${cYellow} ${DOCKER_NAME} 의 도커가 실행되어 있지 않습니다.${cReset}"
	else
		etc_hosts_value=$(grep "${DB_IP} ${DOCKER_NAME}" /etc/hosts)
		if [ "x${etc_hosts_value}" = "x" ]; then
			cmdRun "grep ${DOCKER_NAME} /etc/hosts ; ls -lZ /etc/hosts" "/etc/hosts 수정 전 내용"

			grep -v " ${DOCKER_NAME}" /etc/hosts > new_etc_hosts
			echo "${DB_IP} ${DOCKER_NAME}" >> new_etc_hosts
			sudo mv new_etc_hosts /etc/hosts
			sudo chown root:root /etc/hosts
			sudo chcon system_u:object_r:net_conf_t:s0 /etc/hosts

			cmdRun "grep ${DOCKER_NAME} /etc/hosts ; ls -lZ /etc/hosts" "/etc/hosts 수정 후 내용"
		else
			cmdRun "grep ${DOCKER_NAME} /etc/hosts"
		fi
	fi
fi

cat <<__EOF__

----> 도커이름 전체 보기

__EOF__

for out in $(sudo docker ps -a | awk '{print $NF}')
do
	if [ "x$out" != "xNAMES" ]; then
		DB_IP=$(sudo docker inspect ${out} | grep '"IPAddress"' | tail -n 1 | awk -F : '{print $2}' | awk -F \" '{print $2}')
		echo "NAMES: ${out}; IP Address: ${DB_IP}"
	fi
done


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
