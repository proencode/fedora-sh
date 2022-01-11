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
logs_folder="~/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then mkdir "${logs_folder}" ; fi
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
DOCKER_NAME=ksammy
USER_NAME=ksamroot
LOGIN_PATH=ksamlog
MEMO="login-path 지정하기"
# ----------

cat <<__EOF__

${cMagenta}$0 ${cYellow} ${MEMO} ${cReset}
출처: yosjeon@gmail.com

__EOF__


cat <<__EOF__

200527 수

# mysql 5.6 이후 버전에서는 셀이나 커맨드 라인에서 계정정보를 그대로 노출하면 경고가 발생한다.
Waring: Using a password on the command line interface can be insecure.

ex-1) # mysql_config_editor set --login-path=[접속명칭] --host=[host 정보] --user=[계정명] --password --socket=/tmp/mysql.sock --port=3306
ex-2) # mysql_config_editor set --login-path=[접속명칭] --host=[host 정보] --user=[계정명] --password --port=3306

	# 등록이 완료되면 계정 폴더에 .mylogin.cnf 파일이 생성된다.
mysql_config_editor set --login-path=redoki --host=pinksvr --user=conan --password --port=3306
	# 등록 내역을 보고 싶을때는
mysql_config_editor print --all
	# mysql 에 접속
mysql --login-path=redoki
	# 특정 접속 정보만 삭제
mysql_config_editor remove --login-path=redoki
	# 전체 정보를 삭제
mysql_config_editor remove 

출처: https://devse.tistory.com/25

# ----------

mysql 5.6 이후 버전에서는 셀이나 커맨드 라인에서 계정정보를 그대로 노출하면 경고가 발생하므로,
Waring: Using a password on the command line interface can be insecure.

다음 프로그램을 써서 호스트,계정,비밀번호를 접속명칭으로 지정해서 저장한다.
mysql_config_editor set --login-path=[접속명칭] --host=[host 정보] --user=[계정명] --password --socket=/tmp/mysql.sock --port=3306
__EOF__

cat_and_run "mysql_config_editor print --all"

cat <<__EOF__
----> Enter 로그인 PATH: [ ${LOGIN_PATH} ]
__EOF__
read a

if [ "x$a" != "x" ]; then
	LOGIN_PATH=$a
fi

cat <<__EOF__
${cYellow}----> 로그인 PATH = [${cReset} ${LOGIN_PATH} ${cYellow}]${cReset}

----> host == 도커 이름: [ ${DOCKER_NAME} ]
__EOF__
read a

if [ "x$a" != "x" ]; then
	DOCKER_NAME=$a
fi
echo "${cYellow}----> host 정보 = 도커 이름 = [${cReset} ${DOCKER_NAME} ${cYellow}]${cReset}"

MYSQL_IP=$(sudo docker inspect ${DOCKER_NAME} | grep '"IPAddress"' | tail -n 1 | awk -F : '{print $2}' | awk -F \" '{print $2}')
etc_hosts_value=$(grep "${MYSQL_IP} ${DOCKER_NAME}" /etc/hosts)
if [ "x${etc_hosts_value}" = "x" ]; then
        echo "----> /etc/hosts old images"
        grep "${DOCKER_NAME}" /etc/hosts
        ls -lZ /etc/hosts
        grep -v " ${DOCKER_NAME}" /etc/hosts > new_etc_hosts
        echo "${MYSQL_IP} ${DOCKER_NAME}" >> new_etc_hosts
        sudo mv new_etc_hosts /etc/hosts
        echo "----"
        echo "----> sudo chown root.root /etc/hosts"
        sudo chown root.root /etc/hosts
        echo "----> sudo chcon system_u:object_r:net_conf_t:s0 /etc/hosts"
        sudo chcon system_u:object_r:net_conf_t:s0 /etc/hosts
        echo "----"
        grep "${DOCKER_NAME}" /etc/hosts
        ls -lZ /etc/hosts
        echo "<---- /etc/hosts new images"
else
        echo "----> hosts ok"
        grep "${DOCKER_NAME}" /etc/hosts
fi

cat <<__EOF__

${cYellow}----> 사용자 이름 = [${cReset} ${USER_NAME} ${cYellow}]${cReset}
__EOF__
read a

if [ "x$a" != "x" ]; then
	USER_NAME=$a
fi

# mysql_config_editor set --login-path=${login_path} --host=${hostname} --user=${username} --password --socket=/tmp/mysql.sock --port=3306
cat_and_run "mysql_config_editor set --login-path=${LOGIN_PATH} --host=${DOCKER_NAME} --user=${USER_NAME} --password --port=3306"

cat_and_run "mysql_config_editor print --all"

touch "${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__${CMD_NAME}"
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}

cat_and_run "mysql --login-path=${LOGIN_PATH} mysql" "#-- mysql 데이터베이스를 엽니다."
