#!/bin/sh

#-- ...................... 1........ 2...... 3.... 4.... 5....
#-- rsync_day_folder_files /var/base cadbase ${y4} ${m2} ${d2}

info_message_show() { #-- crontab 을 위한 아규먼트 설명
	cat <<__EOF__
# ....> CentOS 5 버전 때문에 선언한 것임.
$ cat ~/.ssh/config

Host kaos.kr
	KexAlgorithms +diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
	# User kaosco
	PubkeyAcceptedAlgorithms +ssh-rsa
	HostKeyAlgorithms +ssh-dss
	#HostkeyAlgorithms +ssh-rsa
Host www.kaos.kr
	KexAlgorithms +diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
	# KexAlgorithms +diffie-hellman-group1-sha1
	## PubkeyAcceptedKeyTypes=ssh-rsa
# Host ssh.dev.azure.com
#     HostName ssh.dev.azure.com
#     User git
#     IdentityFile ~/.ssh/id_rsa
#     IdentitiesOnly yes
#     PubkeyAcceptedAlgorithms +ssh-rsa
#     HostkeyAlgorithms +ssh-rsa

# <.... CentOS 5 버전 때문에 선언한 것임.


# ::::> 도메인이 등록되지 않아서 추가한것임. 등록되면 삭제할것.
$ cat /etc/hosts #-- etc_hosts_kaos.kr-made

# Loopback entries; do not change.
# For historical reasons, localhost precedes localhost.localdomain:
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
# See hosts(5) for proper format and other examples:
# 192.168.1.10 foo.mydomain.org foo
# 192.168.1.13 bar.mydomain.org bar
192.168.10.99 kaos.kr #-- 220517 내부망인 경우임. 외부인 경우에는 현재 ip 인 210.223.11.244 를 쓰거나, 도메인이 등록됐다면 이를 지울것.
192.168.10.99 www.kaos.kr #-- 220517 내부망인 경우임. 외부인 경우에는 현재 ip 인 210.223.11.244 를 쓰거나, 도메인이 등록됐다면 이를 지울것.
# 210.223.11.244 kaos.kr # 도메인이 등록됐다면 이를 지울것.
# 210.223.11.80 kaos.kr #-- 220518수0940 번개후 공유기,서버,PC 재부팅되고 ip 변경됨.

$ cat ~/.ssh/kaosco.4ssh # <---- 백업시 필요한 패스워드
543254252524

# <:::: 도메인이 등록되지 않아서 추가한것임. 등록되면 삭제할것.


#====> santa 서버에서 sudo crontab -e 로 등록하고, sudo crontab -l 로 내용을 확인한다.
sudo crontab -l

#==> crontab
# Example of job definition:
# .--------------------- minute (0 - 59)
# |  .------------------ hour (0 - 23)
# |  |       .---------- day of month (1 - 31)
# |  |       |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |       |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |       |  |  |
#-*--*-------*--*--*--command to be executed
10   22      *  *  *   /bin/sh /root/bin/0100-santa-db-to-var-base_db.sh
#-*--*-------*--*--*--command to be executed
#<== crontab

#<==== santa 서버에서 sudo crontab -e 로 등록하고, sudo crontab -l 로 내용을 확인한다.


#----> ksamlib 백업 PC 에서 crontab -e 로 등록하고, crontab -l 로 내용을 확인한다.
cat crontab-kaos.kr.18022.ksamlab

#--> crontab
# Example of job definition:
# .--------------------- minute (0 - 59)
# |  .------------------ hour (0 - 23)
# |  |       .---------- day of month (1 - 31)
# |  |       |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |       |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |       |  |  |
#-*--*-------*--*--*--command to be executed
50  22       *  *  *  /bin/sh /home/santa-backup/0200-backup-from-santa.sh /home/santa-backup today
30  23      28  *  *  /bin/sh /home/santa-backup/0200-backup-from-santa.sh /home/santa-backup month
#-*--*-------*--*--*--command to be executed
# |  |       |  |  |
# 매일 1시간 간격 백업후 그날의 마지막 백업은 1주 지나면 삭제.
# ------------------------- 1=backup_dir ----- 2=arg_year 3=arg_month 4=arg_today
# 0200-backup-from-santa.sh /home/santa-backup 2018 --------- 지정한 년도만 백업한다.
# 0200-backup-from-santa.sh /home/santa-backup 2019 05 ------ 지정한 년월만 백업한다.
# 0200-backup-from-santa.sh /home/santa-backup 2020 03 28 --- 지정한 날짜만 백업한다.
# 0200-backup-from-santa.sh /home/santa-backup today -------- 오늘 전체를 백업한다.
# 0200-backup-from-santa.sh /home/santa-backup month -------- 오늘의 월 전체를 백업한다.
# 0200-backup-from-santa.sh /home/santa-backup year --------- 오늘의 년도 전체를 백업한다.
# 0200-backup-from-santa.sh /home/santa-backup all ---------- 데이터 전체를 백업한다.
# 0200-backup-from-santa.sh /home/santa-backup >< >< >< >< >< 첨자가 빠지면 안된다 >< >< >< >< ><
#<-- crontab

#<---- ksamlib 백업 PC 에서 crontab -e 로 등록하고, crontab -l 로 내용을 확인한다.


#-- (${0}) (${arg_year}) (${arg_month}) (${arg_today})

__EOF__
}
rsync_day_folder_files () {
	COPY_READY="-NO-"
	home_dir=${1}
	this_dir=${2}
	this_year=${3}
	this_month=${4}
	this_today=${5}

	if [ "x${RSYNC_HOW}" = "xtoday" ]; then
		#-- "ok"=오늘만 백업할 경우
		host_dir=${home_dir}/${this_dir}/${this_year}/${this_month}/${this_today}/ #-- "/" 가 끝에 있다.
		my_dir=${backup_dir}/${this_dir}/${this_year}/${this_month}/${this_today}
		echo "66 ---- sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})"
		ls_host=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		echo "68 ---- ls_host ${ls_host};"
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
		echo "72 ---- COPY_READY ${COPY_READY};"
	else
	if [ "x${RSYNC_HOW}" = "xmonth" ]; then
		#-- "ok"=이달만 백업할 경우
		host_dir=${home_dir}/${this_dir}/${this_year}/${this_month}/ #-- "/" 가 끝에 있다.
		my_dir=${backup_dir}/${this_dir}/${this_year}/${this_month}
		ls_host=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	else
	if [ "x${RSYNC_HOW}" = "xyear" ]; then
		#-- "ok"=올해만 백업할 경우
		host_dir=${home_dir}/${this_dir}/${this_year}/ #-- "/" 가 끝에 있다.
		my_dir=${backup_dir}/${this_dir}/${this_year}
		ls_host=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	else
	if [ "x${RSYNC_HOW}" = "xall" ]; then
		#-- "ok"=전체를 다 백업할 경우 (시간이 오래 걸린다)
		host_dir=${home_dir}/${this_dir}/ #-- "/" 가 끝에 있다.
		my_dir=${backup_dir}/${this_dir}
		ls_host=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	fi
	fi
	fi
	fi

	if [ "x${COPY_READY}" = "xyes" ]; then
		if [ ! -d ${my_dir} ]; then mkdir -p ${my_dir} ; fi
		rsync -avzr --delete --rsh="sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaosco@www.kaos.kr:${host_dir} ${my_dir}
		RSYNC_LOG="${RSYNC_LOG}o"
	else
		RSYNC_LOG="${RSYNC_LOG}."
	fi
}
#-- ........................ 1........... 2........................... 3.... 4.... 5.... 6....
#-- rsync_month_folder_1file /var/base_db kaosorder2/kaosoyo/mydb_utf8 ${y4} ${m2} ${d2} ${y2}
rsync_month_folder_1file () {
	COPY_READY="-NO-"
	home_dir=${1}
	this_dir=${2}
	this_year=${3}
	this_month=${4}
	this_today=${5}
	this_y2=${6}

	if [ "x${RSYNC_HOW}" = "xtoday" ]; then
		#-- "ok"=오늘만 백업할 경우
		host_dir=${home_dir}/${this_dir}/${this_year}/${this_month}/*${this_y2}${this_month}${this_today}*7z*
		my_dir=${backup_dir}/${this_dir}/${this_year}/${this_month}
		#-- 2...3....4..5.....................................
		#-- db2/2021/08/kaosorder2-db-210805-055001.tar.7z.001
		echo "127 ---- ls_host=\$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})"
		ls_host=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		echo "129 ---- ls_host ${ls_host};"
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
		echo "133 ---- COPY_READY ${COPY_READY};"
	else
	if [ "x${RSYNC_HOW}" = "xmonth" ]; then
		#-- "ok"=이달만 백업할 경우
		host_dir=${home_dir}/${this_dir}/${this_year}/${this_month}/ #-- "/" 가 끝에 있다.
		my_dir=${backup_dir}/${this_dir}/${this_year}/${this_month}
		#-- 2...3....4..5.....................................
		#-- db2/2021/08/kaosorder2-db-210805-055001.tar.7z.001
		ls_host=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	else
	if [ "x${RSYNC_HOW}" = "xyear" ]; then
		#-- "ok"=올해만 백업할 경우
		host_dir=${home_dir}/${this_dir}/${this_year}/ #-- "/" 가 끝에 있다.
		my_dir=${backup_dir}/${this_dir}/${this_year}
		#-- 2...3....4..5.....................................
		#-- db2/2021/08/kaosorder2-db-210805-055001.tar.7z.001
		ls_host=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	else
	if [ "x${RSYNC_HOW}" = "xall" ]; then
		#-- "ok"=전체를 다 백업할 경우 (시간이 오래 걸린다)
		host_dir=${home_dir}/${this_dir}/ #-- "/" 가 끝에 있다.
		my_dir=${backup_dir}/${this_dir}
		#-- 2...3....4..5.....................................
		#-- db2/2021/08/kaosorder2-db-210805-055001.tar.7z.001
		ls_host=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@www.kaos.kr ls ${host_dir})
		if [ "x${ls_host}" != "x" ]; then
			COPY_READY="yes"
		fi
	fi
	fi
	fi
	fi

# Q="/"
# host_str=${host_dir/$Q/_} #-- "/" 를 처음 1개만 "_" 로 변경한다.
#-- host_dir=/slash/divide/string/; >> ${host_dir/$Q/_} >> host_str=_homs/kaos/bin/;
#-- host_dir=/slash/divide/string/; >> ${host_dir//$Q/_} >> host_str=_homs_kaos_bin_;
# host_str=${host_dir//$Q/_} #-- "/" 를 모두 "_" 로 변경한다.

# Q1="rsync -avzr --delete --rsh=\"sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco\" --no-o --no-g --delete kaosco@kaos.kr:${host_dir} ${my_dir}"
# Q="/"
# Q2=${Q1//$Q/X} #-- "/" >> "X"
# Q=" "
# Q3=${Q2//$Q/_} #-- " " >> "_"
# Q="\""
# Q4=${Q3//$Q/Q} #-- '"' >> "Q"
#
# touch "${backup_log_dir}/COPY_$Q4"
#-- echo "rsync -avzr --delete --rsh=\"sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco\" kaosco@kaos.kr:${host_dir} ${my_dir} #-- ${RSYNC_NOW}" >> ${backup_log_dir}/rsync_${from_date}

	if [ "x${COPY_READY}" = "xyes" ]; then

		if [ ! -d ${my_dir} ]; then
			mkdir -p ${my_dir}
		fi
		### /usr/bin/time -p %E rsync -avzr --delete --rsh="sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco" kaosco@kaos.kr:${host_dir} ${my_dir} > ${backup_log_dir}/$(date +"%y%m%d-%H%M%S")_kaosorder2.txt
		rsync -avzr --delete --rsh="sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no -l kaosco" kaosco@kaos.kr:${host_dir} ${my_dir}

		if [ "x${RSYNC_HOW}" = "xtoday" ]; then
			#----> "ok"=오늘만 백업할 경우, 오늘에 해당하는 요일에도 복사해 놓는다.

			from_file=${backup_dir}/${this_dir}/${this_year}/${this_month}/*${this_y2}${this_month}${this_today}*7z*

			#-- to_dir=${backup_dir}/db_backup/${WEEK_DIR}/ #-- /home/santa-backup / db_backup / [1-7] /
			#-- if [ -d ${to_dir} ] ; then
			#-- 	# 주단위 디렉토리가 있으면, 전에 백업했던 이미지를 삭제한다.
			#-- 	rm -f ${to_dir}/*
			#-- else
			#-- 	# 주단위 디렉토리가 없으면, 새로 만든다.
			#-- 	mkdir ${to_dir} ; chown -R ${USER}.${USER} ${to_dir}
			#-- fi

			# 기존의 백업 이미지를 주단위 디렉토리로 옮긴다.
			cat_and_run "rclone copy ${from_file} kaos.note:db-backup/${WEEK_DIR}/" "backup to google drive"

			#<---- "ok"=오늘만 백업할 경우, 오늘에 해당하는 요일에도 복사해 놓는다.
		fi

		RSYNC_LOG="${RSYNC_LOG}o" #-- 복사작업 했음
	else
		RSYNC_LOG="${RSYNC_LOG}." #-- 복사작업 안했음
	fi
}

# ----

WEEK_DIR=$(date +"%w")

backup_dir=${1}
backup_log_dir=${backup_dir}/logs

arg_year=${2}
arg_month=${3}
arg_today=${4}

if [ "x${backup_dir}" = "x" ]; then
	info_message_show #-- crontab 을 위한 아규먼트 설명
	end_touch="/tmp/error-BACKUP_DIR_NOT_SETTING-$(date +"%y%m%d-%H%M%S")-$(uname -n)"
	echo "${0}: arg-1 is not dir name '${1}', '${2}', '${3}', '${4}' on ${end_touch}" > ${end_touch}
	echo "$0 ----> $(cat ${end_touch})"
	exit -1
fi

if [ ! -d ${backup_dir} ]; then
	sudo mkdir -p ${backup_dir}
	sudo chown -R ${USER}.${USER} ${backup_dir}
fi
if [ ! -d ${backup_log_dir} ]; then
	mkdir -p ${backup_log_dir}
fi

y4=$(date +"%Y")
m2=$(date +"%m")
d2=$(date +"%d")
y2=$(date +"%y")

ARG_1_2_3=${arg_year} #-- 첫번째 아규먼트

if [ "x${arg_year}" = "x" ]; then
	#-- 실행시 인수가 하나도 없으면,
	info_message_show #-- crontab 을 위한 아규먼트 설명
	end_touch="/tmp/error-NO-ARG-YEAR-$(date +"%y%m%d-%H%M%S")-$(uname -n)"
	echo "${0}: arg-2 is null '${1}', '${2}', '${3}', '${4}' on ${end_touch}" > ${end_touch}
	echo "$0 ----> $(cat ${end_touch})"
	exit -1
else
	if [ "x${arg_year}" = "xtoday" ]; then
		RSYNC_HOW=today
		ARG_1_2_3="${y4}-${m2}-${d2}_${RSYNC_HOW}"
	else
	if [ "x${arg_year}" = "xmonth" ]; then
		RSYNC_HOW=month
		ARG_1_2_3="${y4}-${m2}_${RSYNC_HOW}"
	else
	if [ "x${arg_year}" = "xyear" ]; then
		RSYNC_HOW=year
		ARG_1_2_3="${y4}_${RSYNC_HOW}"
	else
	if [ "x${arg_year}" = "xall" ]; then
		RSYNC_HOW=all
		ARG_1_2_3="${RSYNC_HOW}"
	else
	if [ "${arg_year}" -lt "2000" || "${arg_year}" -gt "2100" ]; then
		#-- 횡수..
		RSYNC_HOW=UNKNOWN
		ARG_1_2_3="${RSYNC_HOW}"
	else
		y4=${arg_year}
		y2=${y4:2:2}
		if [ "x${arg_month}" = "x" ]; then
			#-- 실행시 년도 인수만 있으면,
			RSYNC_HOW=year
			ARG_1_2_3="${arg_year}_${RSYNC_HOW}"
		else
			m2=${arg_month}
			if [ "x${arg_today}" = "x" ]; then
				#-- 실행시 월 인수만 있으면,
				RSYNC_HOW=month
				ARG_1_2_3="${arg_year}-${arg_month}_${RSYNC_HOW}"
			else
				#-- 실행시 년,월,일 인수를 다 지정했으면,
				RSYNC_HOW=today
				ARG_1_2_3="${arg_year}-${arg_month}-${arg_today}_${RSYNC_HOW}"
				d2=${arg_today}
			fi
		fi
	fi
	fi
	fi
	fi
	fi
fi
from_date=$(date +"%y%m%d-%H%M%S")
begin_touch="${backup_log_dir}/rsync_from_${from_date}_${ARG_1_2_3}"

echo "285 ---- touch ${begin_touch};"
touch ${begin_touch}

# ----

RSYNC_LOG="C"
# echo "291 ---- RSYNC_LOG ${RSYNC_LOG}; rsync_day_folder_files /var/base cadbase ${y4} ${m2} ${d2};"
rsync_day_folder_files /var/base cadbase ${y4} ${m2} ${d2}
RSYNC_LOG="${RSYNC_LOG}E"
# echo "294 ---- RSYNC_LOG ${RSYNC_LOG}; rsync_day_folder_files /var/base emailbase ${y4} ${m2} ${d2};"
rsync_day_folder_files /var/base emailbase ${y4} ${m2} ${d2}
RSYNC_LOG="${RSYNC_LOG}G"
rsync_day_folder_files /var/base georaebase ${y4} ${m2} ${d2}
RSYNC_LOG="${RSYNC_LOG}S"
rsync_day_folder_files /var/base scanbase ${y4} ${m2} ${d2}

#-- 이 로그를 세분화 하기위해 아래 내용으로 바꾼다.
#-- for database_name in kaosorder2 kaosoyo mydb_utf8
#-- do
#-- 	RSYNC_LOG="${RSYNC_LOG}D"
#-- 	rsync_month_folder_1file /var/base_db ${database_name} ${y4} ${m2} ${d2} ${y2}
#-- done

RSYNC_LOG="${RSYNC_LOG}O"
rsync_month_folder_1file /var/base_db kaosorder2 ${y4} ${m2} ${d2} ${y2}

RSYNC_LOG="${RSYNC_LOG}Y"
rsync_month_folder_1file /var/base_db kaosoyo ${y4} ${m2} ${d2} ${y2}

RSYNC_LOG="${RSYNC_LOG}M"
rsync_month_folder_1file /var/base_db mydb_utf8 ${y4} ${m2} ${d2} ${y2}

rm -f ${begin_touch}

to_time=$(date +"%H%M%S")
end_touch="${backup_log_dir}/rsync_${from_date}.${to_time}_${RSYNC_LOG}_${ARG_1_2_3}_$(uname -n)"

rm -f ${begin_touch}
touch ${end_touch}
