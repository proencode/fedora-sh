#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}

# ---

cat <<__EOF__

${cYellow}git config --global user.name "yosjeon at $(uname -n)"${cReset}
${cYellow}git config --global user.email "yosjeon@gmail.com"${cReset}
${cYellow}git config --global alias.ll "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # ----> 한줄로 로그보기${cReset}
${cYellow}git config --global --list${cReset}
__EOF__

cat_and_run "git config --global --list" "git 의 설정을 확인합니다."
cat_and_run "git ll -5" "다섯개의 로그를 확인합니다."
cat <<__EOF__

${cYellow}----> ${cGreen}git pull ${cReset}//////// ${cYellow}//////// ${cBlue}//////// ${cYellow}//////// ${cBlue}//////// ${cYellow}//////// ${cBlue}//////// ${cReset}//////// ${cYellow}---->${cReset}
$(git pull)
${cRed}<---- ${cBlue}git pull ${cReset}//////// ${cMagenta}//////// ${cBlue}//////// ${cMagenta}//////// ${cBlue}//////// ${cMagenta}//////// ${cBlue}//////// ${cReset}//////// ${cRed}<----${cReset}

__EOF__
cat_and_run "git ll -5" "최근 다섯개의 로그를 확인합니다."
cat_and_run "git status" "현재의 상태를 확인합니다."
