#!/bin/sh

keepass_name="keepass"
cloud_name_dir="yswone:${keepass_name}"
org_dir="${HOME}/wind_bada/downloads"
ym="$(date +%y%m)"
org_kdbx="${keepass_name}${ym}.kdbx"
org_dir_kdbx="${org_dir}/${org_kdbx}"
ym_kdbx="${keepass_name}$(date +%y%m%d-%H%M).kdbx"
ym_dir_kdbx="${HOME}/${ym_kdbx}"

echo "#----> rclone copy ${cloud_name_dir}/${org_kdbx} ${org_dir}/"
rclone copy ${cloud_name_dir}/${org_kdbx} ${org_dir}/
echo "#----> ls -l ${org_dir}/${keepass_name}*.kdbx"
ls -l ${org_dir}/${keepass_name}*.kdbx
echo "#----> rclone lsl ${cloud_name_dir}/ | sort -k2 -k3"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3
