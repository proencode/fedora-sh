#!/bin/sh

hhh=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2) #-- 230908

lll () {
	echo "${bbb}#-- ls -l ${base_dir}/$1${xxx}"
	if [ -f ${base_dir}/$1 ]; then
		ls -l ${base_dir}/$1
	else
		echo ""
	fi
}

base_dir=${HOME}
echo "#-- base dir: [ ${base_dir} ]"
read a
if [ "x$a" != "x" ]; then
	base_dir=${a}
fi
echo "#-- base_dir = ${base_dir}"

lll keepassproen.kdbx
lll wind_bada/keepassproen.kdbx
lll archive/myusb/lg1-big-win-app/keepassproen.kdbx
lll archive/keepass/keepassproen.kdbx
lll nhbank/keepassproen.kdbx
lll diff-keepass/root-keepass/keepassproen.kdbx
