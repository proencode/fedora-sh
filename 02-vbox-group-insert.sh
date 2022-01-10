#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}

MEMO="사용자를 vboxsf 그룹에 추가합니다"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"

cat_and_run "grep vboxsf /etc/group" "vboxsf 그룹 확인"
cat_and_run "sudo gpasswd -a ${USER} vboxsf ; grep vboxsf /etc/group"
echo "${cYellow}----> ${cReset}vboxsf 그룹에 ${USER} 사용자가 추가됐다면, 'y' 를 눌러서 다시 시작해야 합니다."
read a ; echo "${cUp}"
if [ "x$a" = "xy" ]; then
	echo "${cRed}[ ${cReset}reboot ${cRed}]${cReset}"
	reboot
fi

echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"
