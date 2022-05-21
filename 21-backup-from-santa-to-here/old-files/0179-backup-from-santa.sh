#!/bin/sh

santa_to_here () {
	cat <<__EOF__
time rsync -avzr --delete --rsh="/usr/bin/sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@www.kaos.kr:${1} . #-- at $(date +"%y%m%d-%H%M%S")
__EOF__
	time rsync -avzr --delete --rsh="sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@www.kaos.kr:${1} .
}

from_date=$(date +"%y%m%d-%H%M%S")
begin_touch="rsync_from_${from_date}"

backup_dir=${HOME}/santa-backup

if [ ! -d ${backup_dir} ]; then
	mkdir ${backup_dir}
fi
cd ${backup_dir}

touch ${begin_touch}

santa_to_here /var/base/cadbase
santa_to_here /var/base/emailbase
santa_to_here /var/base/georaebase
santa_to_here /var/base/scanbase 
santa_to_here /var/kaosorder-backup/db2

rm -f ${begin_touch}

to_date=$(date +"%y%m%d-%H%M%S")
begin_touch="rsync_${from_date}...${to_date}_in_$(uname -n)"
