#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="Fedora36 에서 Docker 설치하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


echoSeq "Install all available updates & reboot the system."
cmdRun "sudo dnf update -y"
cmdYenter "sudo reboot" "시스템을 다시 부팅하려면, 'y' 를 눌러주세요."
echoSeq ""

echoSeq "Enable Docker CE Official Repository"
cmdRun "sudo dnf -y install dnf-plugins-core"
cmdRun "sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo"
echoSeq ""

echoSeq "Install Docker and its Dependencies"
cmdRun "sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin"
echoSeq ""

echoSeq "start, and verify its service"
cmdRun "sudo systemctl enable docker --now"
cmdRun "sudo systemctl status docker" "중단하려면 'Q' 를 눌러주세요."
echoSeq ""

echoSeq "옵션: Verify Docker Installation"
cmdYenter "sudo docker run hello-world" "옵션을 실행하려면, 'y' 를 눌러주세요."
echoSeq ""

echoSeq "옵션: To allow local user to run docker commands"
cmdYenter "sudo usermod -aG docker $USER" "옵션을 실행하려면, 'y' 를 눌러주세요."
echoSeq ""


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
