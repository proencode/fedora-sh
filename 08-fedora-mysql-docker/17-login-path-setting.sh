#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="17. login-path 지정하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


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

cmdRun "mysql_config_editor print --all" "#-- 이전에 선언한 Login PATH"

numArray=( a ) #-- 배열로 선언하고, [0]의 값을 'a' 로 지정한다.
CNT=1
ViewRange="${cRed}[ ${cReset}1 ${cRed}]${cReset}"

for out in $(sudo docker ps -a | awk '{print $NF}')
do
	if [ "x$out" != "xNAMES" ]; then
		DB_IP=$(sudo docker inspect ${out} | grep '"IPAddress"' | tail -n 1 | awk -F : '{print $2}' | awk -F \" '{print $2}')
		numArray[${CNT}]=${out} #-- 배열의 CNT 번째에 담는다.
		echo "${CNT}  ....  ${cGreen}도커 이름: ${cReset}${numArray[$CNT]} ${cGreen}; IP Address: ${cCyan}${DB_IP}${cReset}"
		if [ "x${CNT}" != "x1" ]; then
			ViewRange="${cRed}[ ${cReset}1 ${cRed}]${cReset} ... ${CNT}"
		fi
		CNT=$(( ${CNT} + 1 ))
	fi
done
CNT=$(( ${CNT} - 1 ))

cat <<__EOF__

${cYellow}----> ${cGreen}/etc/host 에 지정하려는 도커 이름의 ${cReset}번호${cGreen}를 선택하세요: ${cCyan}( ${ViewRange} ${cCyan})${cReset}
__EOF__
read a ; echo "${cUp}"
if [[ "x$a" < "x1" ]]; then
	DOCKER_NAME=${numArray[1]}
	a="1"
else
if [[ "x$a" > "x${CNT}" ]]; then
	DOCKER_NAME=${numArray[1]}
	a="1"
else
	DOCKER_NAME=${numArray[${a}]}
fi
fi
cat <<__EOF__
${cRed}[ ${cReset}${a} ${cRed}]${cReset} ${cCyan}${DOCKER_NAME}${cReset}

__EOF__

#----

L_P_DEFAULT="Login PATH 를 입력해 주세요"
U_N_DEFAULT="사용자 이름을 입력해 주세요"
if [ "x${DOCKER_NAME}" = "xksammy" ]; then
	LOGIN_PATH=ksamlog
	USER_NAME=ksamroot
else
if [ "x${DOCKER_NAME}" = "xmysqldb" ]; then
	LOGIN_PATH=swlog
	USER_NAME=gateroot
else
if [ "x${DOCKER_NAME}" = "xkordmy" ]; then
	LOGIN_PATH=kordlog
	USER_NAME=kordroot
else
	LOGIN_PATH="${L_P_DEFAULT}"
	USER_NAME="${U_N_DEFAULT}"
fi
fi
fi

#----

echo "${cYellow}----> ${cCyan}${DOCKER_NAME} ${cGreen}의 로그인 PATH 입력: ${cRed}[ ${cReset}${LOGIN_PATH} ${cRed}]${cReset}"
read a ; echo "${cUp}"
if [ "x$a" != "x" ]; then
	LOGIN_PATH=$a
fi
cat <<__EOF__
${cRed}[ ${cReset}${LOGIN_PATH} ${cRed}]${cReset}

__EOF__

#----

echo "${cYellow}----> ${cCyan}${DOCKER_NAME} ${cGreen}의 user name 입력: ${cRed}[ ${cReset}${USER_NAME} ${cRed}]${cReset}"
read a ; echo "${cUp}"
if [ "x$a" != "x" ]; then
	USER_NAME=$a
fi
cat <<__EOF__
${cRed}[ ${cReset}${USER_NAME} ${cRed}]${cReset}

__EOF__

#----

MYSQL_IP=$(sudo docker inspect ${DOCKER_NAME} | grep '"IPAddress"' | tail -n 1 | awk -F : '{print $2}' | awk -F \" '{print $2}')
etc_hosts_value=$(grep "${MYSQL_IP} ${DOCKER_NAME}" /etc/hosts)
if [ "x${etc_hosts_value}" = "x" ]; then
        cmdRun "grep ${DOCKER_NAME} /etc/hosts ; ls -lZ /etc/hosts" "#--> /etc/hosts old images"
        grep -v " ${DOCKER_NAME}" /etc/hosts > new_etc_hosts
        echo "${MYSQL_IP} ${DOCKER_NAME}" >> new_etc_hosts
        sudo mv new_etc_hosts /etc/hosts
        cmdRun "sudo chown root:root /etc/hosts"
        cmdRun "sudo chcon system_u:object_r:net_conf_t:s0 /etc/hosts"
        cmdRun "grep ${DOCKER_NAME} /etc/hosts ; ls -lZ /etc/hosts" "#--> /etc/hosts NEW images"
else
        cmdRun "grep ${DOCKER_NAME} /etc/hosts" "#--> hosts ok"
fi

#----

# mysql_config_editor set --login-path=${login_path} --host=${hostname} --user=${username} --password --socket=/tmp/mysql.sock --port=3306
echo "${cYellow}----> ${cGreen}mysql_config_editor set --login-path=${LOGIN_PATH} --host=${DOCKER_NAME} --user=${USER_NAME} --password --port=3306 ${cCyan}#--> 로그인 PATH, 도커 이름, user name 지정.${cReset}"
mysql_config_editor set --login-path=${LOGIN_PATH} --host=${DOCKER_NAME} --user=${USER_NAME} --password --port=3306
echo "${cYellow}<${cMagenta}---- mysql_config_editor set --login-path=${LOGIN_PATH} --host=${DOCKER_NAME} --user=${USER_NAME} --password --port=3306 ${cBlue}#--> 로그인 PATH, 도커 이름, user name 지정.${cReset}"

cmdRun "mysql_config_editor print --all" "#--> 지정 내역 확인"


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
