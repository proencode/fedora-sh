#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        echo "${yyy}#-- ${ccc}$1 ${mmm}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${bbb}#// $1 #-- $2${xxx}"
}
cmdend () {
        echo "${bbb}#--///-- ${mmm}$1${xxx}"
}


for i in yosj@gg yosj@yrw proenpi@rp orangepi@yow orangepi@myw orangepi@nlw orangepi@mnw
do
	echo "${bbb}#-- ${ccc}ssh ${i} sudo -S apt update && sudo -S apt upgrade -y${xxx}"
	ssh ${i} sudo -S apt update && sudo -S apt upgrade -y
done
#--
#-- for i in yosj@gg yosj@yrw proenpi@rp orangepi@yow orangepi@myw orangepi@nlw orangepi@mnw; do if [ "$i" = "${USER}@$(hostname)" ]; then echo "#-- Skip ${i}"; else ssh $i; fi; done
#--
