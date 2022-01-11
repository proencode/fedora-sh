#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}
cat_and_read () {
	echo -e "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cYellow}\n - -> ${cRed}press Enter${cCyan}:${cReset}"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta} - - ${cBlue}press Enter${cRed}: ${cMagenta}$1 $2${cReset}"
}
cat_and_readY () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cYellow}<${cMagenta}---- ${cBlue}$1${cReset}"
	else
		echo "${cYellow} - -> ${cRed}press ${cCyan}y${cRed} or Enter${cCyan}:${cReset}"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			echo "${cRed}$1 ${cYellow}--- 를 실행하지 않습니다.${cReset}"
		fi
		echo "${cYellow}<${cMagenta} - - ${cBlue}press Enter${cRed}: ${cMagenta}$1 $2${cReset}"
	fi
}

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi

# ---

MEMO="Docker 및 Docker-Compose 설치"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"

# ---

cat <<__EOTxt__
${cBlue}
cat <<__EOF__

출처: https://computingforgeeks.com/how-to-install-docker-on-fedora/
Fedora 35/34/33/32/31/30에 Docker CE 설치 2021-11-05
__EOF__

cat_and_run "sudo dnf -y install dnf-plugins-core" "Fedora 시스템에 저장소를 추가"

sudo tee /etc/yum.repos.d/docker-ce.repo <<__EOF__
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/35/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
__EOF__
cat_and_run "cat /etc/yum.repos.d/docker-ce.repo" "Fedora 35 에 Docker CE 리포지토리 추가"

cat_and_run "sudo dnf makecache" "저장소 메타 데이터 캐시 생성"
cat_and_run "sudo dnf install docker-ce docker-ce-cli containerd.io" "Docker CE 설치"
cat_and_run "sudo systemctl enable --now docker" "도커 서비스 시작 지시"
cat_and_run "systemctl status docker" "상태 확인"

cat_and_run "sudo usermod -aG docker $(whoami) ; newgrp docker" "docker 그룹에 사용자를 추가"

cat_and_run "docker version" "버전 확인"
cat_and_run "docker pull alpine" "도커 컨테이너 alpine 설치 테스트"
cat_and_run "docker run -it --rm alpine /bin/sh" "실행되면, apk update 와 exit 로 테스트합니다."

cat_and_readY "google-chrome https://computingforgeeks.com/install-docker-ui-manager-portainer/" "도커 UI 관리자 - 포테이너"
cat_and_readY "google-chrome https://computingforgeeks.com/top-command-for-container-metrics/" "Ctop으로 Docker 컨테이너 리소스 사용량 모니터링"
${cReset}
__EOTxt__

# ---

cat <<__EOF__
${cCyan}
출처: https://computingforgeeks.com/install-docker-ce-on-linux-systems/
Linux 시스템에 Docker CE를 설치하는 방법 2021-11-08
${cReset}
__EOF__

cat_and_read "sudo dnf -y remove docker docker-common docker-selinux docker-engine-selinux docker-engine 2>/dev/null" "이전 버전의 Docker 제거"
cat_and_run "sudo dnf -y install dnf-plugins-core ; sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo" "Docker 리포지토리 구성:"
cat_and_run "sudo dnf -y install docker-ce docker-ce-cli containerd.io" "도커 CE 설치"
cat_and_run "sudo systemctl start docker && sudo systemctl enable docker" "도커 서비스 시작 및 활성화"
cat_and_run "docker version" "버전 확인"

# ---

cat <<__EOF__
${cCyan}
출처: https://computingforgeeks.com/install-and-use-docker-compose-on-fedora/
Fedora 35/34/33/32/31/30에 Docker CE 설치 2021-11-05
${cReset}
__EOF__

cat_and_run "sudo dnf -y install docker-compose" "Fedora 저장소에서 docker-compose 설치"
cat_and_run "rpm -qi docker-compose" "설치된 내용 확인"
cat_and_run "sudo curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose ; source /etc/bash_completion.d/docker-compose" "스크립트 넣기"
cat_and_run "docker-compose -version" "버전 확인"

# ---

cat <<__EOF__
${cCyan}
다음 사이트에서 최신 버젼을 확인한다.
https://github.com/docker/compose/releases #--- 오른쪽 마우스로 클릭해서 링크열기 하면된다.

https://computingforgeeks.com/install-docker-ui-manager-portainer/ #--- 도커 UI 관리자 - 포테이너
https://computingforgeeks.com/top-command-for-container-metrics/ #--- Ctop으로 Docker 컨테이너 리소스 사용량 모니터링
${cReset}
__EOF__


echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"
