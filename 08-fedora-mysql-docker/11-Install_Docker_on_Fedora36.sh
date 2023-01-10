#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="11. Fedora36 에서 Docker 설치하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
https://docs.docker.com/engine/install/fedora/#install-using-the-repository
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----

docker_ok=$(rpm -qa | grep docker-ce-)
if [ "x$docker_ok" != "x" ]; then
	cat <<__EOF__
${cMagenta}---->
${cYellow}${docker_ok}
${cMagenta}<---- ${cGreen}이와같이 설치되어 있습니다.

${cCyan}계속 하려면 ${cRed}'${cYellow}y${cRed}' ${cCyan}를 입력하세요.${cReset}
__EOF__
	read a
	if [ "x$a" != "xy" ]; then
		rm -f ${zz00log_name}
		ls --color ${zz00logs_folder}
		cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
		exit 1
	fi
fi

echoSeq "Install all available updates & reboot the system." #--->
cmdYenter "sudo dnf update" "(0) 시스템을 업데이트 하려면 'y' 를 입력하세요."
cmdYenter "sudo reboot" "(1) 시스템을 다시 부팅하려면, 'y' 를 눌러주세요."
cmdRun "rpm -qa | grep docker" "(2) 이전 버전이 있는지 확인합니다."
cmdYenter "sudo dnf remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine" "(3) 이전 버전을 삭제하고 다시 설치하려면 'y' 를 눌러주세요."
echoSeq "" #<---

echoSeq "Enable Docker CE Official Repository" #--->
cmdRun "sudo dnf -y install dnf-plugins-core" "(4) dnf 플러그인 패키지 설치"
cmdRun "sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo" "(5) 리파지토리 설정"
echoSeq "" #<---

echoSeq "Install Docker and its Dependencies" #--->
cmdRun "sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin" "(6) Docker 설치"
echoSeq "" #<---

echoSeq "start, and verify its service" #--->
cmdRun "sudo systemctl enable docker --now" "(7) Docker 사용가능i 처리"
cmdRun "sudo systemctl status docker" "(8) 상태확인: 중단하려면 'Q' 를 눌러주세요."
echoSeq "" #<---

echoSeq "옵션: Verify Docker Installation" #--->
cmdYenter "sudo docker run hello-world" "(9) 확인을 위한 hello world 설치: 옵션을 실행하려면, 'y' 를 눌러주세요."
echoSeq "" #<---

echoSeq "옵션: To allow local user to run docker commands" #--->
cmdYenter "sudo usermod -aG docker $USER" "(10) 사용자를 Docker 그룹에 추가: 옵션을 실행하려면, 'y' 를 눌러주세요."
echoSeq "" #<---


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
