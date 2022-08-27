#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${HOME}/lib/color_base #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp
# ~/lib/color_base 220827-0920 cat_and_run cat_and_run_cr cat_and_read cat_and_readY view_and_read show_then_run show_then_view show_title value_keyin () {


MEMO="Install docker on Fedora 35"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
출처: https://computingforgeeks.com/how-to-install-docker-on-fedora/
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cat_and_run "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


cat_and_readY "sudo dnf -y update" "(1) 시스템을 업데이트 합니다."
cat_and_readY "sudo reboot" "(2) 재부팅 하시겠습니까?"

cat_and_run "sudo dnf -y install dnf-plugin-core" "(3) Fedora 리파지토리를 시스템에 추가합니다."

sudo tee /etc/yum.repos.d/docker-ce.repo <<__EOF__
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/35/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
__EOF__

cat_and_run "sudo dnf makecache" "(4) Docker CE 를 Fedora 에 설치합니다."
cat_and_run "sudo dnf -y install docker-ce docker-ce-cli containerd.io" "(5)"
cat_and_readY "sudo systemctl enable --now docker" "(6) Docer 가 설치됐으므로, 도커 서비스를 실행합니다."
cat_and_run "sudo systemctl status docker" "(7) 도커의 상태를 확인합니다."
cat_and_readY "sudo usermod -aG docker $(whoami) ; newgrp docker" "(8) Docker 그룹은 만들었지만 사용자를 추가하지는 않았으며, sudo 없이 docker 명령을 실행하기 위해, 이 그룹에 사용자를 추가합니다."
cat_and_run "sudo docker version" "(9) 도커 버전"

cat_and_run "sudo docker pull alpine" "(10) 설치 확인을 위해, 테스트 도커를 다운로드해 봅니다."
cat_and_run "sudo docker run -it --rm alpine /bin/sh" "(11) 확인을 위해 'apk update' 와 'exit' 를 입력하세요."


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
cat_and_run "ls --color ${1}" "프로그램들" ; ls --color ${zz00logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
