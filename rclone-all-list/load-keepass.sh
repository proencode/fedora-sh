#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cmdrun () {
	echo "${yyy}----> ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | sh
	echo "${bbb}<.... $1 #-- $2${xxx}"
}
cmdcont () {
	echo -e "${yyy}----> ${ccc}$1 ${ggg}#-- ${bbb}$2\n----> ${mmm}Enter ${ggg}to continue${xxx}:"
	read a ; echo "${uuu}"; echo "$1" | sh
	echo "${bbb}<.... $1 #-- $2${xxx}"
}
ALL_INSTALL="n"
cmdyes () {
	echo "${yyy}----> ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${bbb}<.... $1 #-- $2${xxx}"
	else
		echo "${yyy}----> ${rrr}press ${ccc}'${yyy}y${ccc}'${rrr} or Enter${xxx}:"; read a; echo "${uuu}"
		if [ "x$a" = "xy" ]; then
			echo "${rrr}-OK-${xxx}"; echo "$1" | sh
			echo "${bbb}<.... $1 press 'y' or Enter: #-- $2${xxx}"
		else
			echo "${rrr}[ ${bbb}$1 ${rrr}] ${mmm}<.... 명령을 실행하지 않습니다.${xxx}"
		fi
	fi
}

keepass_dir="keepass"
cloud_name_dir="yswone:${keepass_dir}" #-- 클라우드 폴더

keepass_name="${keepass_dir}proen"
keepass_kdbx="${keepass_name}.kdbx" #-- kdbx 이름

local_dir="${HOME}/wind_bada" #-- 로컬 저장폴더
local_dir_kdbx="${local_dir}/${keepass_kdbx}" #-- 로컬 keepass 파일

local_backup_dir="${local_dir}/old_file" #-- 로컬 백업폴더
if [ ! -d ${local_backup_dir} ]; then
	cmdrun "mkdir -p ${local_backup_dir}" "0. 로컬 디렉토리 만들기"
fi

ymdhm_kdbx="${keepass_name}$(date +%y%m%d-%H%M).kdbx"
cmdrun "mv ${local_dir}/${keepass_kdbx} ${local_backup_dir}/${ymdhm_kdbx}" "1. 로컬 kdbx 를 옮기고,"

cmdrun "rclone copy ${cloud_name_dir}/${keepass_kdbx} ${local_dir}/" "2. 클라우드에서 로컬로 받기"
cmdrun "ls -ltr ${local_dir}/${keepass_name}*.kdbx" "3. 받은 파일 확인"

keepass_ODS="43-${keepass_name}.ods"
local_dir_ODS="${local_dir}/${keepass_ODS}"
ymdhm_ODS="43-${keepass_name}$(date +%y%m%d-%H%M).ods"
ymdhm_dir_ODS="${HOME}/${ymdhm_ODS}"

cmdrun "rclone copy ${cloud_name_dir}/${keepass_ODS} ${local_dir}/" "4. 클라우드에서 .ods 받기"
cmdrun "ls -ltr ${local_dir}/43-${keepass_name}*.ods" "5. 받은 .ods 파일"
cmdrun "rclone lsl ${cloud_name_dir}/ | sort -k2 -k3" "6. 클라우드 백업 확인"
