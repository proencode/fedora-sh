#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
	echo "${bbb}# ----> ${ccc}$1 ${bbb}#-- ${ggg}$2${xxx}"; echo "$1" | sh
	echo "${bbb}# <.... $1 #-- $2${xxx}"
}

git_dir="${HOME}/git-projects/fedora-sh"
pg_name=$(echo $0)
if [ ! -f ${git_dir}/${pg_name} ]; then
	echo "${bbb}!!!! ${ccc}${git_dir}/${pg_name} 파일이 없습니다.${xxx}"
	exit -1
else
	cmdrun "ls -l ${pg_name} ${git_dir}/${pg_name}" "파일을 확인합니다."
fi

if [ "x$(diff ${pg_name} ${git_dir}/${pg_name})" != "x" ]; then
	cmdrun "diff ${pg_name} ${git_dir}/${pg_name}" "!!!! 파일이 다릅니다."
	exit -1
fi
echo "${bbb}#---> ${ccc}press Enter:${xxx}"
read a

wavbox=(NONE play-1-pbong.wav play-2-castanets.wav play-3-ddenng.wav play-4-tiiill.wav play-5-gguuuung.wav play-6-ddeeeng.wav)
wavhan=(0=none 1=딩~ 2=캐스터네츠~ 3=뗅- 4=띠일~ 5=데에엥~~ 6=교회_뎅-)
bin_fs="${HOME}/bin/freesound"
#-- play -q ${bin_fs}/${wavbox[ 1 ]} & #-- 1=딩~
#-- play -q ${bin_fs}/${wavbox[ 2 ]} & #-- 2=캐스터네츠~
#-- play -q ${bin_fs}/${wavbox[ 3 ]} & #-- 3=뗅-
#-- play -q ${bin_fs}/${wavbox[ 4 ]} & #-- 4=띠일~
#-- play -q ${bin_fs}/${wavbox[ 5 ]} & #-- 5=데에엥~~
#-- play -q ${bin_fs}/${wavbox[ 6 ]} & #-- 6=교회_뎅-

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
	play -q ${bin_fs}/${wavbox[ 1 ]} & #-- 1=딩~
	cmdrun "ls -hl --color ${file_name}*"
done
cmdrun "ls -hl --color *xml*"

cmdrun "rclone copy ./ --include \"[cs]*7z\" yosjgc:calls_sms/"
cmdrun "rclone lsl yosjgc:calls_sms/ --include \"[cs]*xml*\""

cat <<__EOF__

${bbb}#  ${ccc}rclone delete yosjgc:calls_sms/ --include "[cs]*xml" | sort -k4
${bbb}#
#  ${ccc}rclone delete yosjgc:calls_sms/ | sort -k4${xxx}

__EOF__
play -q ${bin_fs}/${wavbox[ 2 ]} & #-- 2=캐스터네츠~
