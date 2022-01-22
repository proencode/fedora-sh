#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}

MEMO="Color Base"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"

cat_and_run "sudo dnf -y install make automake autoconf gcc dkms wget vim-enhanced vim-common mc git p7zip gnome-tweak-tool livecd-tools" "꼭 필요한 프로그램들"
cat_and_run "sudo dnf -y install keepass rclone liveusb-creator" "꼭 필요한 앱"
cat_and_run "sudo systemctl enable sshd"
cat_and_run "sudo systemctl start sshd"
