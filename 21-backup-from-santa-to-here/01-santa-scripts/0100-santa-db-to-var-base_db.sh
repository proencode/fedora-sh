#!/bin/sh

# 이 백업 운영자의 디렉토리에 백업을 받는다.
USER_ID=kaosco
# USER_HOME=/home/$USER_ID

# 데이터베이스는 루트 유저를 써서 백업한다.
DB_USER=root
DB_PSWD=ds2axa

# 오늘의 날짜등 백업 이미지 이름에 추가하는 내용들
PASSWD=tjdnjs$(date +"%Y%m")


# ----> 위에서 지정한 데이터베이스를 하나하나 백업한다.
# ------------------ # -------- # ----- # -------
for database_name in kaosorder2 kaosoyo mydb_utf8
do
	db_backup_dir=/var/base_db/${database_name}/$(date +"%Y")/$(date +"%m") # 2022/05
	if [ "x${database_name}" = "xkaosorder2" ]; then
		kaosorder2_backup_dir="$db_backup_dir"
	fi
	if [ "x${database_name}" = "xkaosoyo" ]; then
		kaosoyo_backup_dir="$db_backup_dir"
	fi
	if [ -d ${db_backup_dir} ] ; then
		# 년월단위 디렉토리가 있으면, 오늘자로서 이전 시간에 백업했던 이미지를 삭제한다.
		if [ "x${database_name}" = "xmydb_utf8" ]; then
			rm -f ${db_backup_dir}/${database_name}_$(date +"%y%m")* # _2205* mydb_utf8 DB는 월마다 최종 1건만 보관하므로 해당월의 데이터는 모두 삭제한다.
		else
			rm -f ${db_backup_dir}/${database_name}_$(date +"%y%m%d")* # _220501* 일자마다 최종 1건만 보관하므로 해당월일의 데이터는 모두 삭제한다.
		fi
	else
		# 년월단위 디렉토리가 없으면, 새로 만든다.
		mkdir ${db_backup_dir}
		chown -R $USER_ID.$USER_ID ${db_backup_dir}
		chmod a+r ${db_backup_dir}
	fi

	# ----> 데이터베이스를 덤프하고 압축해서 백업 이미지를 만든다.
	db_sql_7z=${db_backup_dir}/${database_name}_$(date +"%y%m%d-%H%M%S").sql.7z
	/usr/bin/mysqldump ${database_name} -u $DB_USER -p$DB_PSWD -h $(hostname) | /usr/bin/7za a -p${PASSWD} -si ${db_sql_7z}
	chown -R $USER_ID.$USER_ID ${db_sql_7z}
	chmod a+r ${db_sql_7z}
	# <---- 데이터베이스를 덤프하고 압축해서 백업 이미지를 만든다.
done
# <---- 위에서 지정한 데이터베이스를 하나하나 백업한다.


# ----> 데이터베이스의 상태를 저장하는 파일
log_txt_file=${kaosorder2_backup_dir}/last_db_time.txt

/bin/uname -a > ${log_txt_file}
/bin/df >> ${log_txt_file}
/usr/bin/free >> ${log_txt_file}
elinks http://whatismyip.com | grep "Your IP Addr" >> ${log_txt_file}
/sbin/ifconfig | grep -A 1 "Link encap" | grep -v "\-\-" >> ${log_txt_file}

/usr/bin/mysql kaosorder2 -u $DB_USER -p$DB_PSWD -h $(hostname) -vvv -e "

select max(created_at), max(id), count(*), 'kaosorder2 agent' as table_name from agent ;
select count(*), 'kaosorder2 agent_agent' as table_name from agent_agent ;
select max(id), count(*), 'kaosorder2 authority' as table_name from authority ;
select max(id), count(*), 'kaosorder2 bank' as table_name from bank ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosorder2 board' as table_name from board ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosorder2 buyer' as table_name from buyer ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosorder2 buyerboard' as table_name from buyerboard ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosorder2 cadsheet' as table_name from cadsheet ;
select count(*), 'kaosorder2 cadsheet_ordersheet' as table_name from cadsheet_ordersheet ;
select count(*), 'kaosorder2 ccmail_agent' as table_name from ccmail_agent ;
select max(id), count(*), 'kaosorder2 dangaguide' as table_name from dangaguide ;
select max(id), count(*), 'kaosorder2 dangamaster' as table_name from dangamaster ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosorder2 detailsheet' as table_name from detailsheet ;
select max(created_at), max(id), count(*), 'kaosorder2 faximage' as table_name from faximage ;
select max(created_at), max(id), count(*), 'kaosorder2 georaepdf' as table_name from georaepdf ;
select max(created_at), max(id), count(*), 'kaosorder2 gukseimage' as table_name from gukseimage ;
select max(id), count(*), 'kaosorder2 gyejeolstyle' as table_name from gyejeolstyle ;
select max(id), count(*), 'kaosorder2 humanstyle' as table_name from humanstyle ;
select max(id), count(*), 'kaosorder2 itemstyle' as table_name from itemstyle ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosorder2 jobmemo' as table_name from jobmemo ;
select max(id), count(*), 'kaosorder2 jobtype' as table_name from jobtype ;
select max(ym), max(yyyy), max(id), count(*), 'kaosorder2 kaosaccess' as table_name from kaosaccess ;
select max(created_at), max(id), count(*), 'kaosorder2 logtab' as table_name from logtab ;
select max(created_at), max(id), count(*), 'kaosorder2 makaimage' as table_name from makaimage ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosorder2 memoboard' as table_name from memoboard ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosorder2 ordersheet' as table_name from ordersheet ;
select count(*), 'kaosorder2 ordersheet_georaepdf' as table_name from ordersheet_georaepdf ;
select count(*), 'kaosorder2 ordersheet_sekumpdf' as table_name from ordersheet_sekumpdf ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosorder2 partnerboard' as table_name from partnerboard ;
select max(id), count(*), 'kaosorder2 person' as table_name from person ;
select count(*), 'kaosorder2 person_authority' as table_name from person_authority ;
select max(id), count(*), 'kaosorder2 running' as table_name from running ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosorder2 samplesheet' as table_name from samplesheet ;
select count(*), 'kaosorder2 samplesheet_faximage' as table_name from samplesheet_faximage ;
select count(*), 'kaosorder2 samplesheet_makaimage' as table_name from samplesheet_makaimage ;
select count(*), 'kaosorder2 samplesheet_yukaimage' as table_name from samplesheet_yukaimage ;
select max(created_at), max(id), count(*), 'kaosorder2 sekumpdf' as table_name from sekumpdf ;
select max(id), count(*), 'kaosorder2 sleevestyle' as table_name from sleevestyle ;
select max(created_at), max(id), count(*), 'kaosorder2 tongbo' as table_name from tongbo ;
select max(id), count(*), 'kaosorder2 upcode' as table_name from upcode ;
select max(id), count(*), 'kaosorder2 userinit' as table_name from userinit ;
select max(updated_at), max(id), count(*), 'kaosorder2 valueinit' as table_name from valueinit ;
select max(created_at), max(id), count(*), 'kaosorder2 yukaimage' as table_name from yukaimage ;

" >> $log_txt_file

chown -R $USER_ID.$USER_ID $log_txt_file
chmod a+r $log_txt_file
# <---- 데이터베이스의 상태를 저장하는 파일


# ----> 데이터베이스의 상태를 저장하는 파일
log_txt_file=${kaosoyo_backup_dir}/last_db_time.txt

/usr/bin/mysql kaosoyo -u $DB_USER -p$DB_PSWD -h $(hostname) -vvv -e "

select max(id), count(*), 'kaosoyo authority' as table_name from authority ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo buwi' as table_name from buwi ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo choitem' as table_name from choitem ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo humanstyle' as table_name from humanstyle ;
select count(*), 'kaosoyo humanstyle_itemstyle' as table_name from humanstyle_itemstyle ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo temstyle' as table_name from itemstyle ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo joribox' as table_name from joribox ;
select max(created_at), max(id), count(*), 'kaosoyo logtab' as table_name from logtab ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo pattern' as table_name from pattern ;
select max(ok_at), max(jeobsu_at), max(id), count(*), 'kaosoyo person' as table_name from person ;
select count(*), 'kaosoyo person_authority' as table_name from person_authority ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo selpart' as table_name from selpart ;
select max(id), count(*), 'kaosoyo usepatwonbu' as table_name from usepatwonbu ;
select max(id), count(*), 'kaosoyo valueinit' as table_name from valueinit ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo wondan' as table_name from wondan ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo yochoitem' as table_name from yochoitem ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo yojoribox' as table_name from yojoribox ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo yoorder' as table_name from yoorder ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo yoselpart' as table_name from yoselpart ;
select max(updated_at), max(created_at), max(id), count(*), 'kaosoyo yowondan' as table_name from yowondan ;

" >> $log_txt_file

chown -R $USER_ID.$USER_ID $log_txt_file
chmod a+r $log_txt_file
# <---- 데이터베이스의 상태를 저장하는 파일
