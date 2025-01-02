#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

if [ "x$1" = "xok" ]; then
	echo "${cGreen}----> uname -m // --machine${cReset}" ; uname --machine
	echo "${cGreen}----> uname -n // --nodename${cReset}" ; uname --nodename
	echo "${cGreen}----> uname -r // --release${cReset}" ; uname --release
	echo "${cGreen}----> uname -s // --sysname${cReset}" ; uname --sysname
	echo "${cGreen}----> uname -v${cReset}" ; uname -v
	echo "${cGreen}----> uname --version${cReset}" ; uname --version
fi

cat <<__EOF__
${cGreen}----> free -h
${cBlue}$(free -h)
${cGreen}----> df -h /home
${cCyan}$(df -h /home)
${cGreen}----> uname -r
${cReset}$(uname -r)
__EOF__
