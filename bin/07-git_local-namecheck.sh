#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${bbb}#-- $1 #-- $2${xxx}"
}

for i in $(ls ~/git-projects/)
do
	url_is=$(grep url ~/git-projects/${i}/.git/config)
	str_a=$(echo "${url_is}" | awk -F"${i}" '{print $1}')
	str_b=$(echo "${url_is}" | awk -F"${i}" '{print $2}')
	if [ "x${url_is}" = "x${str_a}" ]; then
		#-- git 이름과 로컬폴더 이름이 다른 것이므로 추가로 표시한다.
		echo "#-- ${bbb}${str_a} ${xxx}(${ccc}${i}${xxx})"
	else
		#-- git 이름과 로컬폴더 이름이 같다.
		echo "#-- ${bbb}${str_a}${ccc}${i}${bbb}${str_b}${xxx}"
	fi
done
