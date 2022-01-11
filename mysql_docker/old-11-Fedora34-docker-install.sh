#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cRed}---- ${cMagenta}$1 $2${cReset}"
}
cat_and_read () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2 ${cYellow}- - - press Enter:${cReset}"
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

# play -q ~/bin/1-bin-scripts/freesound/212541__misstickle__indian-bell-chime.wav & #---- 띠잉~
# play -q ~/bin/1-bin-scripts/freesound/339816__inspectorj__hand-bells-f-single.wav & #---- 뗑-~
# play -q ~/bin/1-bin-scripts/freesound/411090__inspectorj__wind-chime-gamelan-gong-a.wav & #---- 데에엥~~
# play -q ~/bin/1-bin-scripts/freesound/411459__inspectorj__castanets-multi-a-h1.wav & #---- 캐스터네츠~
# play -q ~/bin/1-bin-scripts/freesound/513865__wormletter__chime-c.wav & #---- 교회 뎅-
# play -q ~/bin/1-bin-scripts/freesound/91926__tim-kahn__ding.wav & #---- 딩~

# ----------
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then mkdir "${logs_folder}" ; fi
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="Fedora34에 Docker Engine 설치"

cat <<__EOF__

${cMagenta}$0 ${cYellow} ${MEMO} ${cReset}
출처: https://docs.docker.com/engine/install/fedora/

__EOF__
# ----------

cat_and_run "ls -lZ /usr/lib/systemd/system/containerd.service" " docker.service  docker.socket zvbid.service"

#cat_and_read "$(cat <<__EOF__
cat_and_run "sudo dnf -y remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine" "이러한 패키지가 설치되어 있지 않다고 나와도 괜찮습니다."
#__EOF__
#)" "이러한 패키지가 설치되어 있지 않다고 나와도 괜찮습니다."
echo "이러한 패키지가 설치되어 있지 않다고 나와도 괜찮습니다."

cat_and_run "ls -lZ /usr/lib/systemd/system/containerd.service" " docker.service  docker.socket zvbid.service"

cat <<__EOF__
210513 목 1051 : https://docs.docker.com/engine/install/fedora/

저장소 설정

설치 dnf-plugins-core와 설정 (당신의 DNF 저장소를 관리 할 수있는 명령을 제공합니다) 패키지 안정의 저장소.
__EOF__

cat_and_run "sudo dnf -y install dnf-plugins-core"

cat_and_run "ls -lZ /usr/lib/systemd/system/containerd.service" " docker.service  docker.socket zvbid.service"

cat_and_run "sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo"

cat_and_run "ls -lZ /usr/lib/systemd/system/containerd.service" " docker.service  docker.socket zvbid.service"

cat <<__EOF__

선택 사항 : 야간 또는 테스트 저장소를 활성화 합니다.

이러한 리포지토리는 docker.repo위 파일에 포함되어 있지만 기본적으로 비활성화되어 있습니다.
안정적인 저장소와 함께 활성화 할 수 있습니다. 다음 명령은 야간 저장소를 활성화 합니다.

#-- sudo dnf config-manager --set-enabled docker-ce-nightly

테스트 채널 을 활성화하려면 다음 명령을 실행하십시오.

#-- sudo dnf config-manager --set-enabled docker-ce-test

--set-disabled 플래그 와 함께 dnf config-manager 명령을 실행 하여 야간 또는 테스트 저장소를 비활성화 할 수 있습니다.
다시 활성화하려면 --set-enabled 플래그를 사용하십시오.
다음 명령은 야간 저장소를 비활성화 합니다.

#-- sudo dnf config-manager --set-disabled docker-ce-nightly

야간 및 테스트 채널에 대해 알아보십시오 .

Docker Engine 설치
==================

최신 버전 도커 엔진 및 containerd 를 설치합니다. 또는 특정 버전을 설치하려면 다음 단계로 이동합니다.
__EOF__

cat_and_run "sudo dnf -y install docker-ce docker-ce-cli containerd.io"

cat_and_run "ls -lZ /usr/lib/systemd/system/containerd.service" " docker.service  docker.socket zvbid.service"

cat <<__EOF__

GPG 키를 수락하라는 메시지가 표시되면 지문이 일치하는지 확인하고

060A 61C5 1B55 8A7F 742B 77AA C52F EB6B 621E 9F35

일치하는 경우 수락합니다.

Docker 저장소가 여러 개 있습니까?

여러 Docker 리포지토리가 활성화 된 경우 dnf install또는 dnf update명령에 버전을 지정하지 않고 설치하거나 업데이트하면 항상 가능한 가장 높은 버전이 설치되므로 안정성 요구 사항에 적합하지 않을 수 있습니다.

Docker가 설치되었지만 시작되지 않았습니다. docker그룹이 생성되어 있지만 사용자는 그룹에 추가되지 않습니다.

특정 버전 의 Docker Engine 을 설치하려면 저장소에서 사용 가능한 버전을 나열한 후 다음을 선택하고 설치하십시오.

ㅏ. 저장소에서 사용 가능한 버전을 나열하고 정렬합니다. 이 예에서는 버전 번호별로 결과를 가장 높은 값에서 가장 낮은 값으로 정렬하고 잘립니다.

#-- dnf list docker-ce  --showduplicates | sort -r

반환되는 목록은 활성화 된 저장소에 따라 다르며 Fedora 버전에 따라 다릅니다 ( .fc28이 예 에서 접미사로 표시됨).

비. 정규화 된 패키지 이름으로 특정 버전을 설치합니다. 패키지 이름 ( docker-ce)과 첫 번째 하이픈까지의 버전 문자열 (두 번째 열)을 하이픈 ( -)으로 구분합니다 ( 예 :) docker-ce-3:18.09.1.

#--  sudo dnf -y install docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io

Docker가 설치되었지만 시작되지 않았습니다. docker그룹이 생성되어 있지만 사용자는 그룹에 추가되지 않습니다.

Docker를 시작하십시오.
__EOF__

cat_and_run "sudo systemctl start docker ; sudo systemctl enable docker"

cat_and_run "ls -lZ /usr/lib/systemd/system/containerd.service" " docker.service  docker.socket zvbid.service"

cat <<__EOF__
hello-world 이미지 를 실행하여 Docker Engine이 올바르게 설치되었는지 확인하십시오 .
__EOF__

cat_and_run "ls -lZ /usr/lib/systemd/system/containerd.service" " docker.service  docker.socket zvbid.service"

cat <<__EOF__
이 명령어는 테스트 이미지를 다운로드하고 컨테이너에서 실행합니다. 컨테이너가 실행되면 정보 메시지를 인쇄하고 종료합니다.

Docker Engine이 설치되어 실행 중입니다. sudoDocker 명령을 실행 하려면을 사용해야 합니다. 권한이없는 사용자가 Docker 명령 및 기타 선택적 구성 단계를 실행할 수 있도록 Linux 사후 설치 를 계속 합니다.

sudo systemctl status docker

sudo systemctl start docker
sudo systemctl enable docker

sudo docker run hello-world #------- 도커 실행 테스트입니다.

__EOF__

cat_and_run "cd /usr/lib/systemd/system ; sudo ls -lZ containerd.service docker.service  docker.socket zvbid.service"

touch "${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__${CMD_NAME}"
cat_and_run "sudo docker ps -a ; ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
