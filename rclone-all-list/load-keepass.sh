#!/bin/sh

hhh=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2) #-- 230908

keepass_name="keepass"
cloud_name_dir="yswone:${keepass_name}"
org_dir="${HOME}/wind_bada"
ym="$(date +%y%m)"
org_kdbx="${keepass_name}${ym}.kdbx"
org_dir_kdbx="${org_dir}/${org_kdbx}"
ym_kdbx="${keepass_name}$(date +%y%m%d-%H%M).kdbx"
ym_dir_kdbx="${HOME}/${ym_kdbx}"

echo "${bbb}#----> ${ccc}rclone copy ${cloud_name_dir}/${org_kdbx} ${org_dir}/${xxx}"
rclone copy ${cloud_name_dir}/${org_kdbx} ${org_dir}/
echo "${bbb}#----> ${ccc}ls -l ${org_dir}/${keepass_name}*.kdbx${xxx}"
ls -l ${org_dir}/${keepass_name}*.kdbx
echo "${bbb}#----> ${ccc}rclone lsl ${cloud_name_dir}/ | sort -k2 -k3${xxx}"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3
