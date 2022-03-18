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
MEMO="Install docker on Fedora 35"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
출처: https://computingforgeeks.com/how-to-install-docker-on-fedora/
__EOF__
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

cat_and_readY "sudo dnf -y update" "(1-1) 시스템을 업데이트 합니다."
cat_and_readY "sudo reboot" "(1-2) 재부팅 하시겠습니까?"

cat_and_run "sudo dnf -y install dnf-plugin-core" "(2-1) Fedora 리파지토리를 시스템에 추가합니다."

sudo tee /etc/yum.repos.d/docker-ce.repo <<__EOF__
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/35/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
__EOF__

cat_and_run "sudo dnf makecache" "(3-1) Docker CE 를 Fedora 에 설치합니다."
cat_and_run "sudo dnf -y install docker-ce docker-ce-cli containerd.io" "(3-2)"
cat_and_readY "sudo systemctl enable --now docker" "(3-3) Docer 가 설치됐으므로, 도커 서비스를 실행합니다."
cat_and_run "sudo systemctl status docker" "(3-4) 도커의 상태를 확인합니다."
cat_and_readY "sudo usermod -aG docker $(whoami) ; newgrp docker" "(3-5) Docker 그룹은 만들었지만 사용자를 추가하지는 않았으며, sudo 없이 docker 명령을 실행하기 위해, 이 그룹에 사용자를 추가합니다."
cat_and_run "docker version" "(3-6) 도커 버전"

cat_and_run "docker pull alpine" "(4-1) 설치 확인을 위해, 테스트 도커를 다운로드해 봅니다."
cat_and_run "docker run -it --rm alpine /bin/sh" "(4-2) 확인을 위해 'apk update' 와 'exit' 를 입력하세요."

# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
