#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="vscode 설치"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
출처: Install Visual Studio Code on Fedora 36/35/34/33/32 By Josphat Mutai - July 14, 2022 https://computingforgeeks.com/install-visual-studio-code-on-fedora/
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


echoSeq "microsoft 의 저장소 키를 가져옵니다."
cmdRun "time sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc"
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
cmdRun "time sudo dnf check-update"
echoSeq "Fedora 에 Visual Studio Code를 설치합니다."
cmdRun "time sudo dnf install -y code"
echoSeq "code 패키지 세부 정보"
cmdRun "rpm -qi code"


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
출처: Install Visual Studio Code on Fedora 36/35/34/33/32 By Josphat Mutai - July 14, 2022 https://computingforgeeks.com/install-visual-studio-code-on-fedora/
__EOF__
