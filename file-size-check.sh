#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

echo "${ccc}#----> ${bbb}사이즈 합계를 내려는 파일 이름들: [ .7z .jpg 등 / Wind Card '${ccc}*${bbb}' 는 ${ccc}제외${bbb}함 ]${xxx}"
read f
if [ "x$f" = "x" ]; then
	exit -1
fi

#--f=$(echo "$f" | sed 's/ /\\ /g')
echo "${ccc}--- ${bbb}$f ${ccc}---${xxx}"

ls -l | grep --color "${f}"; a="0"; b=$(ls -l | grep --color "${f}" | awk '{print $5}'); for i in $b; do a="$a+$i"; done ; v=$(echo $a | bc); printf "${yyy}%'.f${xxx}\n" $v
#-- printf "%'.2f\n" $v #-- 소숫점이하 포함.
