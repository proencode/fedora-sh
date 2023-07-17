#!/bin/sh

dir_name=${HOME}/myusb/backup

if [ ! -d ${dir_name} ]; then
	mkdir ${dir_name}
fi

crontab_file=${dir_name}/crontab_$(date +%y%m%d%a-%H%M%S)

crontab -l > ${crontab_file}

cat >> ${crontab_file} <<__EOF__
----> ${crontab_file}
__EOF__
