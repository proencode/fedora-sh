#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

eSq=0
echoSeq () {
	eSq=$(( ${eSq} + 1 ))
	echo "${cMagenta}(${eSq}) ${cCyan}$1${cReset}"
}
echoRun () {
	echo "${cGreen}----> ${cYellow}$1 ${cGreen}#-- ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cGreen}<---- ${cBlue}$1 ${cGreen}#-- $2${cReset}"
}

echoSeq "microsoft 의 저장소 키를 가져옵니다."
echoRun "time sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc"
echoSeq "VS Code 리포지토리 콘텐츠를 Fedora Linux에 추가합니다."
cat <<__EOF__ | sudo tee /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
__EOF__
echoSeq "패키지 캐시를 업데이트하고,"
echoRun "time sudo dnf check-update"
echoSeq "Fedora 에 Visual Studio Code를 설치합니다."
echoRun "time sudo dnf install -y code"
echoSeq "code 패키지 세부 정보"
echoRun "rpm -qi code"
echoSeq "출처: Install Visual Studio Code on Fedora 36/35/34/33/32 By Josphat Mutai - July 14, 2022 https://computingforgeeks.com/install-visual-studio-code-on-fedora/"
