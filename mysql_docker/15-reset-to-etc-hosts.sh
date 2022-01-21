#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cRed}---- ${cMagenta}$1 $2${cReset}"
}
cat_and_read () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cYellow} - - - press Enter:${cReset}"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cYellow}<${cRed}---- ${cBlue}- - - press Enter:${cMagenta}$1 $2${cReset}"
}
cat_and_readY () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"
	echo "${cYellow}- - - press ${cRed}y${cYellow} or Enter:${cReset}"; read a; echo "${cUp}"
	if [ "x$a" = "xy" ]; then
		echo "${cRed}-OK-${cReset}"; echo "$1" | sh
	else
		echo "${cRed}$1 ${cYellow}--- 를 실행하지 않습니다.${cReset}"
	fi
	echo "${cYellow}<${cMagenta}---- ${cBlue}pressEnter: $1${cReset} $2"
}
# ----------
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then mkdir "${logs_folder}" ; fi
MEMO="데이터베이스에 연결하는 로그인 패쓰 지정하기"
echo "${cRed}<<<<<<<<<<${cBlue} $0 ||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
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

${cRed}[${cReset} 1 ${cRed}]${cReset}.... ksammy (kaos 샘플실 주문.일정.공임)
  2  .... kordmy (kaosorder)
  3  .... gatedb (gate242)

----> /etc/host 에 지정하려는 도커이름: (1...3)  ${cRed}[${cReset} 1 ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" = "x2" ]; then
	DOCKER_NAME=kordmy
	echo "${cYellow}[${cReset} ${DOCKER_NAME} ${cYellow}] ${cRed}-OK-${cReset}"
else
if [ "x$a" = "x3" ]; then
	DOCKER_NAME=gatedb
	echo "${cYellow}[${cReset} ${DOCKER_NAME} ${cYellow}] ${cRed}-OK-${cReset}"
else
	#-- default: 1
	DOCKER_NAME=ksammy
	echo "${cYellow}[${cReset} ${DOCKER_NAME} ${cYellow}] ${cRed}-OK-${cReset}"
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
			cat_and_run "grep ${DOCKER_NAME} /etc/hosts ; ls -lZ /etc/hosts" "/etc/hosts 수정 전 내용"

			grep -v " ${DOCKER_NAME}" /etc/hosts > new_etc_hosts
			echo "${DB_IP} ${DOCKER_NAME}" >> new_etc_hosts
			sudo mv new_etc_hosts /etc/hosts
			sudo chown root.root /etc/hosts
			sudo chcon system_u:object_r:net_conf_t:s0 /etc/hosts

			cat_and_run "grep ${DOCKER_NAME} /etc/hosts ; ls -lZ /etc/hosts" "/etc/hosts 수정 후 내용"
		else
			cat_and_run "grep ${DOCKER_NAME} /etc/hosts"
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

touch "${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__${CMD_NAME}"
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
