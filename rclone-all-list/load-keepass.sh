#!/bin/sh

source ~/bin/cmdbox

keepass_name="keepass"
cloud_name_dir="yswone:${keepass_name}"
org_dir="${HOME}/wind_bada"
if [ ! -d ${org_dir} ]; then
	cmdrun "mkdir -p ${org_dir}" "0. 로컬 디렉토리"
fi
ym="$(date +%y%m)"

org_kdbx="${keepass_name}${ym}.kdbx"
org_dir_kdbx="${org_dir}/${org_kdbx}"
ym_kdbx="${keepass_name}$(date +%y%m%d-%H%M).kdbx"
ym_dir_kdbx="${HOME}/${ym_kdbx}"

cmdrun "rclone copy ${cloud_name_dir}/${org_kdbx} ${org_dir}/" "1. 클라우드에서 로컬로 받기"
cmdrun "ls -ltr ${org_dir}/${keepass_name}*.kdbx" "2. 받은 파일"

org_ODS="43-${keepass_name}${ym}.ods"
org_dir_ODS="${org_dir}/${org_ODS}"
ym_ODS="43-${keepass_name}$(date +%y%m%d-%H%M).ods"
ym_dir_ODS="${HOME}/${ym_ODS}"

cmdrun "rclone copy ${cloud_name_dir}/${org_ODS} ${org_dir}/" "3. 클라우드에서 .ods 받기"
cmdrun "ls -ltr ${org_dir}/43-${keepass_name}*.ods" "4. 받은 .ods 파일"
cmdrun "rclone lsl ${cloud_name_dir}/ | sort -k2 -k3" "5. 클라우드 내용"
