#!/bin/sh

keepass_name="keepass"
cloud_name_dir="yswone:${keepass_name}"
org_dir="${HOME}/wind_bada/downloads"
ym="$(date +%y%m)"
org_kdbx="${keepass_name}${ym}.kdbx"
org_dir_kdbx="${org_dir}/${org_kdbx}"
ym_kdbx="${keepass_name}$(date +%y%m%d-%H%M).kdbx"
ym_dir_kdbx="${HOME}/${ym_kdbx}"

echo "#----> ls -l ${org_dir}/${keepass_name}*.kdbx"
ls -l ${org_dir}/${keepass_name}*.kdbx

if [ ! -f ${org_dir_kdbx} ]; then
        cat <<__EOF__
#-- ${org_dir_kdbx} 파일이 없습니다.
#-- ${org_dir} 에서 ${keepass_name}-9912.kdbx 파일이 있으면,
#-- ${org_kdbx} 로 이름을 바꾸고 다시 실행하세요~
#-- ls -l ${org_dir}/
$(ls -l ${org_dir}/)
#--
__EOF__
        exit -1
fi

echo "#----> rclone lsl ${cloud_name_dir}/ | sort -k2 -k3"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3
echo "#----> rclone copy ${org_dir_kdbx} ${cloud_name_dir}/"
rclone copy ${org_dir_kdbx} ${cloud_name_dir}/
echo "#----> cp ${org_dir_kdbx} ${ym_dir_kdbx}"
cp ${org_dir_kdbx} ${ym_dir_kdbx}
echo "#----> rclone copy ${ym_dir_kdbx} ${cloud_name_dir}/${ym}/"
rclone copy ${ym_dir_kdbx} ${cloud_name_dir}/${ym}/
echo "#----> rm -f ${ym_dir_kdbx}"
rm -f ${ym_dir_kdbx}
echo "#----> rclone lsl ${cloud_name_dir}/ | sort -k2 -k3"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3
