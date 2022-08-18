#!/bin/sh

show_message="NOok" #-- 터미널에서 실행한다면 = "ok" , 메세지를 보여준다.

LOGIN_PATH=swlog #-- DB 로그인 패쓰
DB_NAME=gate242 #-- 백업할 데이터베이스 이름

this_year=$(date +%Y) #-- 2022
this_wol=$(date +%m) #-- 07
ymd_hm=$(date +"%y%m%d%a-%H%M") #-- ymd_hm=$(date +"%y%m%d-%H%M%S")

week_no=$(date +%u) #------------ 일0 월1 화2 수3 목4 금5 토6
week_no=$(( ${week_no} + 1 )) #-- 1   2   3   4   5   6   7   #--
yoil_atog=$(echo "abcdefg" | cut -c ${week_no}) 

uname_n=$(uname -n)
db_NOWyoil_sql_7z=${DB_NAME}_${ymd_hm}_${uname_n}${yoil_atog}.sql.7z #-- *"[a-g].sql.7z" // 요일 표시
this_wol_sql_7z="${this_wol}.sql.7z"
db_nowWOL_sql_7z=${DB_NAME}_${ymd_hm}_${uname_n}.${this_wol_sql_7z} #-- *".07.sql.7z" // 월 표시

LOCAL_DIR=${HOME}/seowontire-data/db_backup/${HOSTNAME}/${this_year}/${this_wol} #-- 백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름
REMOTE_YEAR=gate242db/${this_year}
REMOTE_WOL=${REMOTE_YEAR}/${this_wol} #-- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년/월 폴더이름
rclone_name=swlgc #-- 원격 저장소인 seowontire.libgc 를 연결하기 위해 rclone 에서 쓰는 이름



if [ ! -d ${LOCAL_DIR} ]; then
	if [ "x$show_message" = "xok" ]; then echo "mkdir -p ${LOCAL_DIR} #-- (1) 보관용 로컬 디렉토리를 만듭니다." ; fi
	#==
	mkdir -p ${LOCAL_DIR} #-- (1) 보관용 로컬 디렉토리를 만듭니다.

else
	if [ "x$show_message" = "xok" ]; then
		echo "ls -l ${LOCAL_DIR} #-- (1) 보관용 로컬 디렉토리 입니다."
		#==
		ls -l ${LOCAL_DIR} #-- (1) 보관용 로컬 디렉토리 입니다.

	fi

fi



if [ "x$show_message" = "xok" ]; then
	echo "#----> (2) 오늘날짜 백업 시작"
	echo "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_WOL}/ | grep ${yoil_atog}.sql.7z | awk '{print \$2}') #-- (3) 오늘날짜 클라우드 백업파일이 있는지 확인 합니다."
fi
#==
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_WOL}/ | grep ${yoil_atog}.sql.7z | awk '{print $2}') #-- (3) 오늘날짜 클라우드 백업파일이 있는지 확인 합니다.

if [ "x$show_message" = "xok" ]; then echo "REMOTE_SQL_7Z_LIST=----${REMOTE_SQL_7Z_LIST}---- #-- (4)" ; fi

if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	if [ "x$show_message" = "xok" ]; then
		echo "mapfile -t Remote_Sql7z_Array <<< \"\$REMOTE_SQL_7Z_LIST\" #-- (5) Array 만들기"
       	fi
	#==
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		file_name=$(echo ${val} | sed 's/ *$//g') #- 빈칸 삭제 // https://linuxhint.com/trim_string_bash/
		if [ "x$show_message" = "xok" ]; then
			echo "file_name=\$(echo ${val} | sed 's/ *$//g') #- 빈칸 삭제 // https://linuxhint.com/trim_string_bash/"
			echo "OUTRC=\$(/usr/bin/rclone deletefile ${rclone_name}:${REMOTE_WOL}/${file_name}) #-- (6-1) 오늘날짜 클라우드 백업파일을 삭제합니다."
		fi
		#==
		OUTRC=$(/usr/bin/rclone deletefile ${rclone_name}:${REMOTE_WOL}/${file_name}) #-- (6-1) 오늘날짜 클라우드 백업파일을 삭제합니다.

		if [ "x$show_message" = "xok" ]; then
			echo "OUTRC=----${OUTRC}----"
		fi
	done
else
	if [ "x$show_message" = "xok" ]; then echo "#-- (6-2) 클라우드에는 오늘날짜 백업파일이 없습니다." ; fi
fi



if [ "x$show_message" = "xok" ]; then
	echo "rm -f ${LOCAL_DIR}/*${yoil_atog}.sql.7z #-- (7) *\"[a-g].sql.7z\" 오늘날짜 로컬 백업파일을 삭제합니다."
fi
#==
rm -f ${LOCAL_DIR}/*${yoil_atog}.sql.7z #-- (7) *"[a-g].sql.7z" 오늘날짜 로컬 백업파일을 삭제합니다.

if [ "x$show_message" = "xok" ]; then
	echo "/usr/bin/mysqldump --login-path=${LOGIN_PATH} --column-statistics=0 ${DB_NAME} | 7za a -si ${LOCAL_DIR}/${db_NOWyoil_sql_7z} #-- (8) DB 를 로컬에 백업합니다."
fi
#==
/usr/bin/mysqldump --login-path=${LOGIN_PATH} --column-statistics=0 ${DB_NAME} | 7za a -si ${LOCAL_DIR}/${db_NOWyoil_sql_7z} #-- (8) DB 를 로컬에 백업합니다.

if [ "x$show_message" = "xok" ]; then
	echo "OUTRC=\$(/usr/bin/rclone copy ${LOCAL_DIR}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_WOL}/) #-- (9) 로컬 DB 백업파일을 클라우드로 복사합니다."
fi
#==
OUTRC=$(/usr/bin/rclone copy ${LOCAL_DIR}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_WOL}/) #-- (9) 로컬 DB 백업파일을 클라우드로 복사합니다.

if [ "x$show_message" = "xok" ]; then
	echo "OUTRC=----${OUTRC}----"
	echo "#<---- (10) 오늘날짜 백업 끝"
fi



if [ "x$show_message" = "xok" ]; then
	echo "#----> (11) 월별 백업 시작"
	echo "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR}/ | grep ${this_wol_sql_7z} | awk '{print \$2}') #-- (12) ${this_wol}월 백업파일이 있는지 확인 합니다."
fi
#==
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR}/ | grep ${this_wol_sql_7z} | awk '{print $2}') #-- (12) ${this_wol}월 백업파일이 있는지 확인 합니다.

if [ "x$show_message" = "xok" ]; then echo "REMOTE_SQL_7Z_LIST=----${REMOTE_SQL_7Z_LIST}---- #-- (13)" ; fi

if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	if [ "x$show_message" = "xok" ]; then echo "mapfile -t Remote_Sql7z_Array <<< \"\$REMOTE_SQL_7Z_LIST\" #-- (14-1-1) Array 만들기" ; fi
	#==
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		#==
		file_name=$(echo ${val} | sed 's/ *$//g') #- 빈칸 삭제 // https://linuxhint.com/trim_string_bash/

		if [ "x$show_message" = "xok" ]; then
			echo "----------> val ${val};" ;
			echo "----> file_name ${file_name};"
			echo "OUTRC=\$(/usr/bin/rclone deletefile ${rclone_name}:${REMOTE_YEAR}/${file_name}) #-- (14-1-2) ${this_wol}월 백업파일을 삭제합니다."
		fi
		#==
		OUTRC=$(/usr/bin/rclone deletefile ${rclone_name}:${REMOTE_YEAR}/${file_name}) #-- (14-1-2) ${this_wol}월 백업파일을 삭제합니다.

		if [ "x$show_message" = "xok" ]; then echo "OUTRC=----${OUTRC}----" ; fi
	done
else
	if [ "x$show_message" = "xok" ]; then echo "#-- (14-2) ${this_wol}월 백업파일이 없습니다." ; fi
fi



if [ "x$show_message" = "xok" ]; then
	echo "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR}/ | grep '.${this_wol}.sql.7z' | awk '{print \$2}') #-- (15) ${this_wol}월 백업입니다."
fi
#==
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR}/ | grep '.${this_wol}.sql.7z' | awk '{print $2}') #-- (15) ${this_wol}월 백업입니다.

if [ "x$show_message" = "xok" ]; then echo "REMOTE_SQL_7Z_LIST=----${REMOTE_SQL_7Z_LIST}---- #-- (16)" ; fi

if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	if [ "x$show_message" = "xok" ]; then echo "mapfile -t Remote_Sql7z_Array <<< \"$REMOTE_SQL_7Z_LIST\" #-- (17-1-1)" ; fi
	#==
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		#==
		file_name=$(echo ${val} | sed 's/ *$//g') #- 빈칸 삭제 // https://linuxhint.com/trim_string_bash/

		if [ "x$show_message" = "xok" ]; then
			echo "----------> val ${val};"
			echo "----> file_name ${file_name};"
			echo "OUTRC=\$(/usr/bin/rclone deletefile ${rclone_name}:${REMOTE_YEAR}/${file_name}) #-- (17-1-2) ${this_wol}월 백업파일을 삭제합니다."
		fi
		#==
		OUTRC=$(/usr/bin/rclone deletefile ${rclone_name}:${REMOTE_YEAR}/${file_name}) #-- (17-1-2) ${this_wol}월 백업파일을 삭제합니다.

		if [ "x$show_message" = "xok" ]; then echo "OUTRC=----${OUTRC}----" ; fi
	done
else
	if [ "x$show_message" = "xok" ]; then echo "#-- (17-2) ${this_wol}월 백업파일이 없습니다." ; fi
fi


if [ "x$show_message" = "xok" ]; then
	echo "OUTRC=\$(/usr/bin/rclone copy ${rclone_name}:${REMOTE_WOL}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_YEAR}/) #-- (18) ${this_year}년도 폴더로 복사합니다."
fi
#==
OUTRC=$(/usr/bin/rclone copy ${rclone_name}:${REMOTE_WOL}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_YEAR}/) #-- (18) ${this_year}년도 폴더로 복사합니다.

if [ "x$show_message" = "xok" ]; then
	echo "OUTRC=----${OUTRC}----"
	echo "OUTRC=\$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR})"
fi
#==
OUTRC=$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR})

if [ "x$show_message" = "xok" ]; then
	echo "OUTRC=----${OUTRC}----"
	echo "OUTRC=\$(/usr/bin/rclone moveto ${rclone_name}:${REMOTE_YEAR}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_YEAR}/${db_nowWOL_sql_7z}) #-- (19) 파일 이름을 바꿉니다."
fi
#==
OUTRC=$(/usr/bin/rclone moveto ${rclone_name}:${REMOTE_YEAR}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_YEAR}/${db_nowWOL_sql_7z}) #-- (19) 파일 이름을 바꿉니다.

if [ "x$show_message" = "xok" ]; then
	echo "OUTRC=----${OUTRC}----"
	echo "/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR} # 년도"
	#==
	/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR}

	echo "/usr/bin/rclone ls ${rclone_name}:${REMOTE_WOL} # 월"
	#==
	/usr/bin/rclone ls ${rclone_name}:${REMOTE_WOL}
fi

if [ "x$show_message" = "xok" ]; then echo "#<---- (20) 월별 백업 끝" ; fi


#|====>>
#|
#|  16:46:47화220809 fedora@vfc36jj ~/git-projects/gate242
#|  gate242 $ sh run_sh/crontab/backupto-swlgc-gate242db/backup-gate242db.sh
#|  ls -l /home/fedora/seowontire-data/db_backup/vfc36jj/2022/08 #-- (1) 보관용 로컬 디렉토리 입니다.
#|  합계 57152
#|  -rw-rw-r-- 1 fedora fedora 58520197  8월  9일 16:29 gate242_220809화-1622_vfc36jjc.sql.7z
#|  #----> (2) 오늘날짜 백업 시작
#|  REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls swlgc:gate242db/2022/08/ | grep c.sql.7z | awk '{print $2}') #-- (3) 오늘날짜 클라우드 백업파일이 있는지 확인 합니다.
#|  REMOTE_SQL_7Z_LIST=----gate242_220809화-1622_vfc36jjc.sql.7z---- #-- (4)
#|  mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST" #-- (5) Array 만들기
#|  file_name=$(echo gate242_220809화-1622_vfc36jjc.sql.7z | sed 's/ *$//g') #- 빈칸 삭제 // https://linuxhint.com/trim_string_bash/
#|  OUTRC=$(/usr/bin/rclone deletefile swlgc:gate242db/2022/08/gate242_220809화-1622_vfc36jjc.sql.7z) #-- (6-1) 오늘날짜 클라우드 백업파일을 삭제합니다.
#|  OUTRC=--------
#|  rm -f /home/fedora/seowontire-data/db_backup/vfc36jj/2022/08/*c.sql.7z #-- (7) *"[a-g].sql.7z" 오늘날짜 로컬 백업파일을 삭제합니다.
#|  /usr/bin/mysqldump --login-path=swlog --column-statistics=0 gate242 | 7za a -si /home/fedora/seowontire-data/db_backup/vfc36jj/2022/08/gate242_220809화-1646_vfc36jjc.sql.7z #-- (8) DB 를 로컬에 백업합니다.
#|  
#|  7-Zip (a) [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
#|  p7zip Version 16.02 (locale=ko_KR.UTF-8,Utf16=on,HugeFiles=on,64 bits,1 CPU Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz (906EA),ASM,AES-NI)
#|  
#|  Creating archive: /home/fedora/seowontire-data/db_backup/vfc36jj/2022/08/gate242_220809화-1646_vfc36jjc.sql.7z
#|  
#|  Items to compress: 1
#|  
#|  
#|  Files read from disk: 1
#|  Archive size: 58520197 bytes (56 MiB)
#|  Everything is Ok
#|  OUTRC=$(/usr/bin/rclone copy /home/fedora/seowontire-data/db_backup/vfc36jj/2022/08/gate242_220809화-1646_vfc36jjc.sql.7z swlgc:gate242db/2022/08/) #-- (9) 로컬 DB 백업파일을 클라우드로 복사합니다.
#|  OUTRC=--------
#|  #<---- (10) 오늘날짜 백업 끝
#|  #----> (11) 월별 백업 시작
#|  REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls swlgc:gate242db/2022/ | grep 08.sql.7z | awk '{print $2}') #-- (12) 08월 백업파일이 있는지 확인 합니다.
#|  REMOTE_SQL_7Z_LIST=----gate242_220809화-1622_vfc36jj.08.sql.7z---- #-- (13)
#|  mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST" #-- (14-1-1) Array 만들기
#|  ----------> val gate242_220809화-1622_vfc36jj.08.sql.7z;
#|  ----> file_name gate242_220809화-1622_vfc36jj.08.sql.7z;
#|  OUTRC=$(/usr/bin/rclone deletefile swlgc:gate242db/2022/gate242_220809화-1622_vfc36jj.08.sql.7z) #-- (14-1-2) 08월 백업파일을 삭제합니다.
#|  OUTRC=--------
#|  REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls swlgc:gate242db/2022/ | grep '.08.sql.7z' | awk '{print $2}') #-- (15) 08월 백업입니다.
#|  REMOTE_SQL_7Z_LIST=-------- #-- (16)
#|  #-- (17-2) 08월 백업파일이 없습니다.
#|  OUTRC=$(/usr/bin/rclone copy swlgc:gate242db/2022/08/gate242_220809화-1646_vfc36jjc.sql.7z swlgc:gate242db/2022/) #-- (18) 2022년도 폴더로 복사합니다.
#|  OUTRC=--------
#|  OUTRC=$(/usr/bin/rclone ls swlgc:gate242db/2022)
#|  OUTRC=---- 58520197 gate242_220809화-1646_vfc36jjc.sql.7z
#|   59006595 gate242_220731일-2210_g1ssd128.07.sql.7z
#|   59006595 07/gate242_220731일-2210_g1ssd128-7.sql.7z
#|   59006594 07/gate242_220730토-2210_g1ssd128-6.sql.7z
#|   59006594 07/gate242_220729금-2210_g1ssd128-5.sql.7z
#|   59006595 07/gate242_220728목-2210_g1ssd128-4.sql.7z
#|   59006594 07/gate242_220727수-2210_g1ssd128-3.sql.7z
#|   59006594 07/gate242_220726화-2210_g1ssd128-2.sql.7z
#|   59006594 07/gate242_220725월-2210_g1ssd128-1.sql.7z
#|   58520197 08/gate242_220809화-1646_vfc36jjc.sql.7z
#|   59009840 08/gate242_220808월-2210_g1ssd128b.sql.7z
#|   59009841 08/gate242_220807일-2210_g1ssd128.sql.7z----
#|  OUTRC=$(/usr/bin/rclone moveto swlgc:gate242db/2022/gate242_220809화-1646_vfc36jjc.sql.7z swlgc:gate242db/2022/gate242_220809화-1646_vfc36jj.08.sql.7z) #-- (19) 파일 이름을 바꿉니다.
#|  OUTRC=--------
#|  /usr/bin/rclone ls swlgc:gate242db/2022 # 년도
#|   58520197 gate242_220809화-1646_vfc36jj.08.sql.7z
#|   59006595 gate242_220731일-2210_g1ssd128.07.sql.7z
#|   59006595 07/gate242_220731일-2210_g1ssd128-7.sql.7z
#|   59006594 07/gate242_220730토-2210_g1ssd128-6.sql.7z
#|   59006594 07/gate242_220729금-2210_g1ssd128-5.sql.7z
#|   59006595 07/gate242_220728목-2210_g1ssd128-4.sql.7z
#|   59006594 07/gate242_220727수-2210_g1ssd128-3.sql.7z
#|   59006594 07/gate242_220726화-2210_g1ssd128-2.sql.7z
#|   59006594 07/gate242_220725월-2210_g1ssd128-1.sql.7z
#|   58520197 08/gate242_220809화-1646_vfc36jjc.sql.7z
#|   59009840 08/gate242_220808월-2210_g1ssd128b.sql.7z
#|   59009841 08/gate242_220807일-2210_g1ssd128.sql.7z
#|  /usr/bin/rclone ls swlgc:gate242db/2022/08 # 월
#|   58520197 gate242_220809화-1646_vfc36jjc.sql.7z
#|   59009840 gate242_220808월-2210_g1ssd128b.sql.7z
#|   59009841 gate242_220807일-2210_g1ssd128.sql.7z
#|  #<---- (20) 월별 백업 끝
#|  16:53:51화220809 fedora@vfc36jj ~/git-projects/gate242
#|  gate242 $
#|
#|  echo $(date 0301000021; date +'%Y-%m-%d%a %H:%M %U-%W %u-%w %g-%V'; echo "%U..(첫번째일요일의주=00) %W..(첫번째월요일의주=00) %u..(월=1,일=7) %w..(일=0,토=6) %g..(4분기) %V..(첫번째일요일의주=0)")
#|
#|<<====
