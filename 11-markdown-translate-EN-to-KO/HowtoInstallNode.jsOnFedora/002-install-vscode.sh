#!/bin/sh

source ${HOME}/lib/color_base #-- (0) 화면에 색상표시
MEMO="VS Code 설치"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"

cat <<__EOF__
Install Visual Studio Code on Fedora 36/35/34/33/32 By Josphat Mutai - July 14, 2022
https://computingforgeeks.com/install-visual-studio-code-on-fedora/

__EOF__
cat_and_run "sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc" "(1) 저장소 키를 가져옵니다."

cat <<__EOF__
${cCyan}#-- (2) 완료되면 VS Code 리포지토리 콘텐츠를 Fedora Linux에 추가합니다.
${cGreen}----> ${cYellow}cat <<EOF | sudo tee /etc/yum.repos.d/vscode.repo${cReset}
__EOF__
cat <<EOF | sudo tee /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF
cat <<__EOF__
${cMagenta}<---- ${cBlue}cat <<EOF | sudo tee /etc/yum.repos.d/vscode.repo${cReset}
__EOF__

cat_and_run "dnf check-update" "(3) 패키지 캐시를 업데이트하고,"
cat_and_run "sudo dnf install -y code" "(4) Fedora 에 Visual Studio Code를 설치합니다."
cat_and_run "rpm -qi code" "(5) code 패키지 세부 정보"

echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
