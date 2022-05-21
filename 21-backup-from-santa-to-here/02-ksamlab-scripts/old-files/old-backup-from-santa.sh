#!/bin/sh
#-- ...................... 1........ 2...... 3.... 4.... 5....
#-- rsync_day_folder_files /var/base cadbase ${y4} ${m2} ${d2}
rsync_day_folder_files () {
	COPY_READY="-NO-"

	if [ "x${RSYNC_HOW}" = "xtoday" ]; then
		#-- "ok"=오늘만 백업할 경우
		host_dir=${1}/${2}/${3}/${4}/${5}
		my_dir=${2}/${3}/${4}/${5}
		ls_host=$(sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	else
	if [ "x${RSYNC_HOW}" = "xmonth" ]; then
		#-- "ok"=이달만 백업할 경우
		host_dir=${1}/${2}/${3}/${4}
		my_dir=${2}/${3}/${4}
		ls_host=$(sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	else
	if [ "x${RSYNC_HOW}" = "xyear" ]; then
		#-- "ok"=올해만 백업할 경우
		host_dir=${1}/${2}/${3}
		my_dir=${2}/${3}
		ls_host=$(sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	else
	if [ "x${RSYNC_HOW}" = "xall" ]; then
		#-- "ok"=전체를 다 백업할 경우 (시간이 오래 걸린다)
		host_dir=${1}/${2}
		my_dir=${2}
		ls_host=$(sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	fi
	fi
	fi
	fi

	if [ "x${COPY_READY}" = "xyes" ]; then
		rsync -avzr --delete --rsh="sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@www.kaos.kr:${host_dir}/ ${my_dir}
		RSYNC_LOG="${RSYNC_LOG}o"
	else
		RSYNC_LOG="${RSYNC_LOG}x"
	fi
}
#-- ........................ 1.................... 2.. 3.... 4.... 5.... 6....
#-- rsync_month_folder_1file /var/kaosorder-backup db2 ${y4} ${m2} ${d2} ${y2}
rsync_month_folder_1file () {
	COPY_READY="-NO-"

	if [ "x${RSYNC_HOW}" = "xtoday" ]; then
		#-- "ok"=오늘만 백업할 경우
		host_dir=${1}/${2}/${3}/${4}/*${6}${4}${5}*7z*
		my_dir=${2}/${3}/${4}
		#-- 2...3....4..5.....................................
		#-- db2/2021/08/kaosorder2-db-210805-055001.tar.7z.001
		ls_host=$(sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	else
	if [ "x${RSYNC_HOW}" = "xmonth" ]; then
		#-- "ok"=이달만 백업할 경우
		host_dir=${1}/${2}/${3}/${4}
		my_dir=${2}/${3}/${4}
		#-- 2...3....4..5.....................................
		#-- db2/2021/08/kaosorder2-db-210805-055001.tar.7z.001
		ls_host=$(sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	else
	if [ "x${RSYNC_HOW}" = "xyear" ]; then
		#-- "ok"=올해만 백업할 경우
		host_dir=${1}/${2}/${3}
		my_dir=${2}/${3}
		#-- 2...3....4..5.....................................
		#-- db2/2021/08/kaosorder2-db-210805-055001.tar.7z.001
		ls_host=$(sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	else
	if [ "x${RSYNC_HOW}" = "xall" ]; then
		#-- "ok"=전체를 다 백업할 경우 (시간이 오래 걸린다)
		host_dir=${1}/${2}
		my_dir=${2}
		#-- 2...3....4..5.....................................
		#-- db2/2021/08/kaosorder2-db-210805-055001.tar.7z.001
		ls_host=$(sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	fi
	fi
	fi
	fi

	if [ "x${COPY_READY}" = "xyes" ]; then
		rsync -avzr --delete --rsh="sshpass -f ${HOME}/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@www.kaos.kr:${host_dir} ${my_dir}
		RSYNC_LOG="${RSYNC_LOG}o"
	else
		RSYNC_LOG="${RSYNC_LOG}x"
	fi
}

# ----

# 098-backup-from-santa.sh -------------- 오늘 전체를 백업한다.
# 098-backup-from-santa.sh today -------- 오늘 전체를 백업한다.
# 098-backup-from-santa.sh month -------- 오늘의 월 전체를 백업한다.
# 098-backup-from-santa.sh year --------- 오늘의 년도 전체를 백업한다.
# 098-backup-from-santa.sh all ---------- 데이터 전체를 백업한다.
# 098-backup-from-santa.sh 2017 --------- 지정한 년도만 백업한다.
# 098-backup-from-santa.sh 2019 05 ------ 지정한 년월만 백업한다.
# 098-backup-from-santa.sh 2021 03 28 --- 지정한 날짜만 백업한다.

y4=$(date +"%Y")
m2=$(date +"%m")
d2=$(date +"%d")
y2=$(date +"%y")

if [ "x$1" = "x" ]; then
	#-- 실행시 인수가 하나도 없으면,
	RSYNC_HOW=today #-- "today"=오늘만, "month"=이달만, "year"=올해만, "all"=전부.
else
	if [ "x$1" = "xtoday" ]; then
		RSYNC_HOW=today
	else
	if [ "x$1" = "xmonth" ]; then
		RSYNC_HOW=month
	else
	if [ "x$1" = "xyear" ]; then
		RSYNC_HOW=year
	else
	if [ "x$1" = "xall" ]; then
		RSYNC_HOW=all
	else
	if [ "$1" -lt "2000" ] || [ "$1" -gt "2100" ]; then
		#-- 횡수..
		RSYNC_HOW=today
	else
		y4=$1
		y2=${y4:2:2}
		if [ "x$2" = "x" ]; then
			#-- 실행시 년도 인수만 있으면,
			RSYNC_HOW=year
		else
			m2=$2
			if [ "x$3" = "x" ]; then
				#-- 실행시 월 인수만 있으면,
				RSYNC_HOW=month
			else
				#-- 실행시 년,월,일 인수를 다 지정했으면,
				RSYNC_HOW=today
				d2=$3
			fi
		fi
	fi
	fi
	fi
	fi
	fi
fi
# ----

from_date=$(date +"%y%m%d-%H%M%S")
begin_touch="rsync_from_${from_date}"

backup_dir=${HOME}/santa-backup

if [ ! -d ${backup_dir} ]; then
	mkdir ${backup_dir}
fi
cd ${backup_dir}

touch ${begin_touch}

RSYNC_LOG="C"
rsync_day_folder_files /var/base cadbase ${y4} ${m2} ${d2}
RSYNC_LOG="${RSYNC_LOG}E"
rsync_day_folder_files /var/base emailbase ${y4} ${m2} ${d2}
RSYNC_LOG="${RSYNC_LOG}G"
rsync_day_folder_files /var/base georaebase ${y4} ${m2} ${d2}
RSYNC_LOG="${RSYNC_LOG}S"
rsync_day_folder_files /var/base scanbase ${y4} ${m2} ${d2}

RSYNC_LOG="${RSYNC_LOG}D"
rsync_month_folder_1file /var/kaosorder-backup db2 ${y4} ${m2} ${d2} ${y2}

rm -f ${begin_touch}

to_time=$(date +"%H%M%S")
end_touch="rsync_${from_date}.${to_time}_${RSYNC_LOG}_$(uname -n)"

rm -f ${begin_touch}
touch ${end_touch}
