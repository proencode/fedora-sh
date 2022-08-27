#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${HOME}/lib/color_base #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp
# ~/lib/color_base 220827-0920 cat_and_run cat_and_run_cr cat_and_read cat_and_readY view_and_read show_then_run show_then_view show_title value_keyin () {


MEMO="도커 ip 와 그 이름을 /etc/hosts 에 지정합니다."
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cat_and_run "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cat_and_run "ifconfig | grep -B1 inet\ " "(1) 외부로 서비스 하기위한 enp0s8 의 ip 번호를 보여줍니다."
cat <<__EOF__

${cGreen}----> ${cCyan}지정할 ip 번호 ${cBlue} 위에서 enp0s8 등으로 RUNNING 된 inet 을 입력합니다.${cReset}
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

cat_and_run "ls -lZ /etc/hosts ; grep ${this_domain} /etc/hosts" "(2) 수정전 도메인"

grep -v " ${this_domain}" /etc/hosts > new_etc_hosts
echo "${this_ip} ${this_domain}" >> new_etc_hosts
sudo mv new_etc_hosts /etc/hosts
sudo chown root.root /etc/hosts
#-- for fedora -- sudo chcon system_u:object_r:net_conf_t:s0 /etc/hosts

cat_and_run "ls -lZ /etc/hosts ; grep ${this_domain} /etc/hosts" "(3) 수정 후 도메인"
cat /etc/hosts


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
cat_and_run "ls --color ${1}" "프로그램들" ; ls --color ${zz00logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
