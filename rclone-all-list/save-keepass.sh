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

org_ODS="43-${keepass_name}${ym}.ods"
org_dir_ODS="${org_dir}/${org_ODS}"
ym_ODS="43-${keepass_name}$(date +%y%m%d-%H%M).ods"
ym_dir_ODS="${HOME}/${ym_ODS}"

echo "#----> ls -ltr ${org_dir}/${keepass_name}*.kdbx"
ls -ltr ${org_dir}/${keepass_name}*.kdbx
echo "#----> ls -ltr 43-${org_dir}/${keepass_name}*.ods"
ls -ltr ${org_dir}/43-${keepass_name}*.ods

if [ ! -f ${org_dir_kdbx} ]; then
        cat <<__EOF__
#-- ${org_dir_kdbx} 파일이 없습니다.
#-- ${org_dir} 에서 ${keepass_name}-9912.kdbx 파일이 있으면,
#-- ${org_kdbx} 로 이름을 바꾸고 다시 실행하세요~
#-- ls -ltr ${org_dir}/
$(ls -ltr ${org_dir}/)
#--
__EOF__
        exit -1
fi
if [ ! -f ${org_dir_ODS} ]; then
        cat <<__EOF__
#-- ${org_dir_ODS} 파일이 없습니다.
#-- ${org_dir} 에서 43-${keepass_name}-9912.ods 파일이 있으면,
#-- ${org_ODS} 로 이름을 바꾸고 다시 실행하세요~
#-- ls -ltr ${org_dir}/
$(ls -ltr ${org_dir}/)
#--
__EOF__
        exit -1
fi

echo "${bbb}#----> ${ccc}rclone lsl ${cloud_name_dir}/ | sort -k2 -k3${xxx}"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3
echo "${bbb}#----> ${ccc}rclone copy ${org_dir_kdbx} ${cloud_name_dir}/${xxx}"
rclone copy ${org_dir_kdbx} ${cloud_name_dir}/
echo "${bbb}#----> ${ccc}cp ${org_dir_kdbx} ${ym_dir_kdbx}${xxx}"
cp ${org_dir_kdbx} ${ym_dir_kdbx}
echo "${bbb}#----> ${ccc}rclone copy ${ym_dir_kdbx} ${cloud_name_dir}/${ym}/${xxx}"
rclone copy ${ym_dir_kdbx} ${cloud_name_dir}/${ym}/
echo "${bbb}#----> ${ccc}rm -f ${ym_dir_kdbx}${xxx}"
rm -f ${ym_dir_kdbx}
echo "${bbb}#----> ${ccc}rclone lsl ${cloud_name_dir}/ | sort -k2 -k3${xxx}"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3

echo "${bbb}#----> ${ccc}rclone lsl ${cloud_name_dir}/ | sort -k2 -k3${xxx}"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3
echo "${bbb}#----> ${ccc}rclone copy ${org_dir_ODS} ${cloud_name_dir}/${xxx}"
rclone copy ${org_dir_ODS} ${cloud_name_dir}/
echo "${bbb}#----> ${ccc}cp ${org_dir_ODS} ${ym_dir_ODS}${xxx}"
cp ${org_dir_ODS} ${ym_dir_ODS}
echo "${bbb}#----> ${ccc}rclone copy ${ym_dir_ODS} ${cloud_name_dir}/${ym}/${xxx}"
rclone copy ${ym_dir_ODS} ${cloud_name_dir}/${ym}/
echo "${bbb}#----> ${ccc}rm -f ${ym_dir_ODS}${xxx}"
rm -f ${ym_dir_ODS}
echo "${bbb}#----> ${ccc}rclone lsl ${cloud_name_dir}/ | sort -k2 -k3${xxx}"
rclone lsl ${cloud_name_dir}/ | sort -k2 -k3
