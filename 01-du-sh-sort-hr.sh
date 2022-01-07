#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}

# ---

fname=zz.du-sh-sort-hr.$(date +"%y%m%d")
if [ "x$1" = "x" ]; then
	cnt=15
else
	cnt=$1
fi
now=$(date +"%y%m%d%a%H:%M:%S")

cat_and_run "sudo du -sh * .??* | sort -hr > ${fname} ; head -${cnt} ${fname}" "#-- ${now}"
