#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}

MEMO="호스트 이름을 바꿉니다."
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"

HOSTNAME=$(hostname)

cat <<__EOF__
----> 호스트 이름을 바꾸려면 입력하세요: ${cRed}[${cYellow} ${HOSTNAME} ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" = "x" ]; then
	echo "= ${cRed}${HOSTNAME}${cReset} ="
else
	echo "= ${cRed}${a}${cReset} ="
	cat_and_run "sudo hostnamectl set-hostname $a" "호스트 이름을 $a 로 지정합니다."
fi

echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"
