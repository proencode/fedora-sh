#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="Install docker-ce on Fedora 35"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
출처: https://computingforgeeks.com/install-and-use-docker-compose-on-fedora/
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cmdYenter "sudo dnf -y update" "(1) 시스템을 업데이트 합니다."
cmdYenter "sudo reboot" "(2) 재부팅 하시겠습니까?"

cmdRun "sudo dnf -y install dnf-plugin-core" "(3) Fedora 리파지토리를 시스템에 추가합니다."

sudo tee /etc/yum.repos.d/docker-ce.repo <<__EOF__
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/35/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
__EOF__

cmdRun "sudo dnf makecache" "(4) Docker CE 를 Fedora 에 설치합니다."
cmdRun "sudo dnf -y install docker-ce docker-ce-cli containerd.io" "(5)"
cmdYenter "sudo systemctl enable --now docker" "(6) Docer 가 설치됐으므로, 도커 서비스를 실행합니다."
cmdRun "sudo systemctl status docker" "(7) 도커의 상태를 확인합니다."
cmdYenter "sudo usermod -aG docker $(whoami) ; newgrp docker" "(8) Docker 그룹은 만들었지만 사용자를 추가하지는 않았으며, sudo 없이 docker 명령을 실행하기 위해, 이 그룹에 사용자를 추가합니다."
cmdRun "sudo docker version" "(9) 도커 버전"

cmdYenter "sudo docker pull alpine" "(10) 설치 확인을 위해, 테스트 도커를 다운로드해 봅니다."
cmdYenter "sudo docker run -it --rm alpine /bin/sh" "(11) 확인을 위해 'apk update' 와 'exit' 를 입력하세요."


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
