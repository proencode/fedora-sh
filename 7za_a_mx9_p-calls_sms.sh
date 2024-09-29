#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
	echo "${yyy}# ----> ${ccc}$1 ${bbb}#-- ${ggg}$2${xxx}"; echo "$1" | sh
	echo "${bbb}# <.... $1 #-- $2${xxx}"
}

cmdrun "ls -l \"[cs]*xml\""
cmdrun "rclone copy yosjgc:calls_sms/ --include \"[cs]*xml\" ."
cmdrun "ls -l \"[cs]*xml\""
cmdrun "read a " "Press Enter:"

tot_cnt=$(ls calls*xml sms*xml | wc -l)
seq=0
for file_name in $(ls calls*xml sms*xml)
do
	seq=$(( seq + 1 ))
	cmdrun "7za a -mx=9 -p ${file_name}.7z ${file_name}" "(${tot_cnt}-${seq})"
	cmdrun "ls -hl --color ${file_name}*"
done
cmdrun "ls -hl --color *xml*"

cmdrun "rclone copy ./ --include \"[cs]*7z\" yosjgc:calls_sms/"
cmdrun "rclone lsl yosjgc:calls_sms/ --include \"[cs]*xml*\""

call <<__EOF__

#  rclone delete yosjgc:calls_sms/ --include "[cs]*xml" | sort -k4
#
#  rclone delete yosjgc:calls_sms/ | sort -k4

__EOF__
