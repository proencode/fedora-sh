#!/bin/bash

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
	echo "${yyy}# ----> ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | sh
	echo "${yyy}# <~~~~ ${bbb}$1 #-- $2${xxx}"
}

wikijsdb_dir="wind_bada/wikijsdb"
if [ ! -d ~/${wikijsdb_dir} ]; then
	cmdrun "cd ~/; mkdir -p ${wikijsdb_dir}" "받는 폴더를 만들고 이동합니다."
fi
cd ~/${wikijsdb_dir}

cmdrun "rclone copy tpn3mi:wikijsdb/$(date +%Y)/ --include \"wiki_$(date +%y%m%d)*wol.sql.7z\" ." "wikijsdb 파일 다운로드"
echo "#------------"
echo "#------------ 1. tpn3mi: 클라우드에서 wiki.js 파일 다운로드"
