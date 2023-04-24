#!/bin/sh

ymda_hms=$(date +"%y%m%d%a-%H%M%S")
local_dir=s11-rclone_ls_${ymda_hms}
if [ ! -d "x${local_dir}" ]; then
	mkdir ${local_dir}
fi

for cloud_name in kaos1mi  kaos2mi  kaos3mi  kaos4mi  kaosngc  swlibgc  tpnote1mi  tpnote2mi  tpnote3mi  y5dnmi  y5ncmi  yosjgc  ysw10mi
do
	ymda_hms=$(date +"%y%m%d%a-%H%M%S")

	echo "----> rclone ls ${cloud_name}: | sort -k2 - >> ${local_dir}/${cloud_name}-${ymda_hms}.ls"
	echo "----> rclone ls ${cloud_name}: | sort -k2 - >> ${local_dir}/${cloud_name}-${ymda_hms}.ls" > ${local_dir}/${cloud_name}-${ymda_hms}.ls
	rclone ls ${cloud_name}: | sort -k2 - >> ${local_dir}/${cloud_name}-${ymda_hms}.ls

	echo "----> rclone size ${cloud_name}: >> ${local_dir}/${cloud_name}-${ymda_hms}.ls"
	echo "----> rclone size ${cloud_name}: >> ${local_dir}/${cloud_name}-${ymda_hms}.ls" >> ${local_dir}/${cloud_name}-${ymda_hms}.ls
	rclone size ${cloud_name}: >> ${local_dir}/${cloud_name}-${ymda_hms}.ls
done

ls_dir=s12-rclone_ls_${ymda_hms}
echo "----> ls -l ${local_dir} > ${ls_dir}.ll"
ls -l ${local_dir} > ${ls_dir}.ll
echo "----> 7za a -mx=9 ${ls_dir}.7z ${local_dir}"
7za a -mx=9 ${ls_dir}.7z ${local_dir}
ls --color
