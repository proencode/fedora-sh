#!/bin/bash

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
	echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | bash
	echo "${yyy}#-- ${bbb}$1 #-- $2${xxx}"
}


grepString="tradepub"

echo "${yyy}#-- ${bbb}grep String [ ${ccc}${grepString}${bbb} ] press Enter:${xxx}"
read a
if [ "x$a" != "x" ]; then
	grepString="$a"
fi

cmdrun "grep \"${grepString}\" *l | awk -F\":\" '{print \$4}' | awk '{print \$2}' | uniq"
