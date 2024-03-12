#!/bin/sh

org_dir="${HOME}/wind_bada/downloads"
org_file="keepass$(date +%y%m).kdbx"
org_kdbx=${org_dir}/${org_file}
last_kdbx="keepass$(date +%y%m)-last.kdbx"

echo "#----> ls -l ${org_dir}/keepass*.kdbx"
ls -l ${org_dir}/keepass*.kdbx

if [ ! -f ${org_kdbx} ]; then
	cat <<__EOF__
#--
#-- ${org_kdbx} 파일이 없습니다.
#--
__EOF__
	exit -1
fi

echo "#----> rclone lsl yswone:keepass/ | sort -k2 -k3"
rclone lsl yswone:keepass/ | sort -k2 -k3
echo "#----> rclone copy ${org_kdbx} yswone:keepass/"
rclone copy ${org_kdbx} yswone:keepass/
echo "#----> cp ${org_kdbx} ~/${last_kdbx}"
cp ${org_kdbx} ~/${last_kdbx}
#echo "#----> rclone delete yswone:keepass/${last_kdbx}"
#rclone delete yswone:keepass/${last_kdbx}
echo "#----> rclone copy ~/${last_kdbx} yswone:keepass/"
rclone copy ~/${last_kdbx} yswone:keepass/
echo "#----> rm -f ~/${last_kdbx}"
rm -f ~/${last_kdbx}
echo "#----> rclone lsl yswone:keepass/ | sort -k2 -k3"
rclone lsl yswone:keepass/ | sort -k2 -k3
