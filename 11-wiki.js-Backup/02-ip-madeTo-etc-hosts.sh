#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="도커 ip 와 그 이름을 /etc/hosts 에 지정합니다."
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cmdRun "ifconfig | grep -B1 inet\ " "(1) 외부로 서비스 하기위한 enp0s8 의 ip 번호를 보여줍니다."
cat <<__EOF__

${cGreen}----> ${cCyan}지정할 ip 번호를 입력하세요. ${cBlue} 위에서 enp0s8 등으로 RUNNING 된 inet 을 입력합니다.${cReset}
__EOF__
read this_ip ; echo "${cUp}"
if [ "x$this_ip" = "x" ]; then
	rm -f ${zz00log_name}
	echo "${cRed}!!!! ${cYellow}----> ${cBlue}ip 를 지정하지 않으므로 여기서 끝냅니다.${gReset}"
	exit 1
fi

this_domain="sw"
cat <<__EOF__
${cRed}[ ${cYellow}${this_ip} ${cRed}]${cReset}

${cGreen}----> ${cRed}[ ${cCyan}${this_domain} ${cRed}] ${cCyan}지정할 도메인 이름${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" != "x" ]; then
	this_domain=$a
fi

cat<<__EOF__
${cRed}[ ${cYellow}${this_domain} ${cRed}]${cReset}

${cRed}[ ${cReset}${this_ip} ${this_domain} ${cRed}]${cReset}
${cGreen}----> ${cCyan}press Enter${cReset}:
__EOF__
read a

cmdRun "ls -lZ /etc/hosts ; grep ${this_domain} /etc/hosts" "(2) 수정전 도메인"

grep -v " ${this_domain}" /etc/hosts > new_etc_hosts
echo "${this_ip} ${this_domain}" >> new_etc_hosts
sudo mv new_etc_hosts /etc/hosts
sudo chown root.root /etc/hosts
#-- for fedora -- sudo chcon system_u:object_r:net_conf_t:s0 /etc/hosts

cmdRun "ls -lZ /etc/hosts ; grep ${this_domain} /etc/hosts" "(3) 수정 후 도메인"
cmdRun "cat /etc/hosts"


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
