#!/bin/sh

hhh=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2) #-- 230908

keepass_name="keepass"
cloud_name_dir="yswone:${keepass_name}"
org_dir="${HOME}/wind_bada"
if [ ! -d ${org_dir} ]; then
	mkdir -p ${org_dir}
fi
ym="$(date +%y%m)"

org_kdbx="${keepass_name}${ym}.kdbx"
org_dir_kdbx="${org_dir}/${org_kdbx}"
ym_kdbx="${keepass_name}$(date +%y%m%d-%H%M).kdbx"
ym_dir_kdbx="${HOME}/${ym_kdbx}"

echo "${bbb}#----> ${ccc}rclone copy ${cloud_name_dir}/${org_kdbx} ${org_dir_kdbx}${xxx}"
rclone copy ${cloud_name_dir}/${org_kdbx} ${org_dir_kdbx}
echo "${bbb}#----> ${ccc}ls -l ${org_dir}/${keepass_name}*.kdbx${xxx}"
ls -l ${org_dir}/${keepass_name}*.kdbx
#-- echo "${bbb}#----> ${ccc}rclone lsl ${cloud_name_dir}/ | sort -k2 -k3${xxx}"
#-- rclone lsl ${cloud_name_dir}/ | sort -k2 -k3

org_ODS="43-${keepass_name}${ym}.ods"
org_dir_ODS="${org_dir}/${org_ODS}"
ym_ODS="43-${keepass_name}$(date +%y%m%d-%H%M).ods"
ym_dir_ODS="${HOME}/${ym_ODS}"

echo "${bbb}#----> ${ccc}rclone copy ${cloud_name_dir}/${org_ODS} ${org_dir_ODS}${xxx}"
rclone copy ${cloud_name_dir}/${org_ODS} ${org_dir_ODS}
echo "${bbb}#----> ${ccc}ls -l ${org_dir}/43-${keepass_name}*.ods${xxx}"
ls -l ${org_dir}/43-${keepass_name}*.ods
echo "${bbb}#----> ${ccc}rclone lsl ${cloud_name_dir}/ | sort -k2 -k3${xxx}"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3
