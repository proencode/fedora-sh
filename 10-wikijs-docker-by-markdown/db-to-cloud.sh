#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${CMD_DIR}/color_base #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp cat_and_run cat_and_read cat_and_readY

#----

show_then_run () {
	if [ "x$show_ok" = "xok" ]; then cat_and_run "$1" "#-- (${showno}) ${showqq}" ; fi
}
show_then_view () {
	if [ "x$show_ok" = "xok" ]; then echo "${cGreen}----> $1 ${cCyan}#-- (${showno}) ${showqq}${cReset}" ; fi
}
show_title () {
	if [ "x$show_ok" = "xok" ]; then
		cat <<__EOF__
    ${cGreen}|
    |
    | ${cCyan}$1
    ${cGreen}|
    |${cReset}
__EOF__
	fi
}
#--- value_keyin "LOGIN_PATH" "${LOGIN_PATH}" "데이터베이스의 로그인 패쓰 를 입력하세요."
value_keyin () {
	FIELD_NAME=$1
	FIELD_VALUE=$2
	FIELD_TITLE=$3
	cat <<__EOF__

${cGreen}----> ${FIELD_TITLE}[ ${cCyan}${FIELD_VALUE} ${cGreen}]${cReset}
__EOF__
	read return_value

	if [ "x$return_value" = "x" ]; then
		return_value="${FIELD_VALUE}"
	fi
	cat <<__EOF__
${cUp}${cCyan}${FIELD_NAME}: ${cRed} ${cYellow}${return_value} ${cRed}]

__EOF__
}

#----

show_ok="NOok"
show_ok="ok" #-- "ok" 라면 터미널에서 실행하는 경우로 보고, 메세지를 보여준다.

this_year=$(date +%Y) #-- 2022
this_wol=$(date +%m) #-- 07
ymd_hm=$(date +"%y%m%d%a-%H%M") #-- ymd_hm=$(date +"%y%m%d-%H%M%S")

week_no=$(date +%u) #------------ 일0 월1 화2 수3 목4 금5 토6
week_no=$(( ${week_no} + 1 )) #-- 1   2   3   4   5   6   7   #--
yoil_atog=$(echo "abcdefg" | cut -c ${week_no}) 

if [ "x$1" = "x" ]; then
	cat <<__EOF__

${cYellow}$1 ${cMagenta}[ DB_NAME ] 을 지정하지 않았으므로 작업을 끝냅니다.${cReset}
__EOF__
	exit -1
fi

if [ "x$1" = "xkaosorder" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="kaoslog" #-- 데이터베이스 로그인 패쓰
	LOCAL_FOLDER="${HOME}/gate242/${HOSTNAME}" #-- 백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="gate242db" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="swlgc" #-- rclone 이름
else
if [ "x$1" = "xgate242" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="swlog" #-- 데이터베이스 로그인 패쓰
	LOCAL_FOLDER="${HOME}/gate242/${HOSTNAME}" #-- 백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="gate242db" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="swlgc" #-- rclone 이름
else
if [ "x$1" = "xwiki" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="wikipsql" #-- 데이터베이스 로그인 패쓰
	LOCAL_FOLDER="${HOME}/wiki.js/${HOSTNAME}" #-- 백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="wiki.js" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="yosgc" #-- rclone 이름
else
fi
fi
fi

ENTER_VALUE="NOok" #-- ok=환경변수 대신 하나하나 입력하도록 한다.
SHOW_OK="NOok"
if [ "x$2" = "xok" ]; then
	SHOW_OK="ok"
else
	if [ "x$2" = "xenter" ]; then
		ENTER_VALUE="ok" #-- ok=환경변수 대신 하나하나 입력하도록 한다.
	else
		LOGIN_PATH="$2"
	fi
fi

if [ "x$1" = "xname" ]; then
	cat <<__EOF__
#-- 1		2		3		4		5		6
#-- DB_NAME	LOGIN_PATH	LOCAL_FOLDER	REMOTE_FOLDER	RCLONE_NAME	SHOW OK?
#-- kaosorder2	kaosgc		/home/kaosdb	kaosdb		kngc		ok/""
#-- gate242	swlgc		/home/gate242	gate242		swlgc		ok/""
#-- wiki	wikipsql	/home/wiki.js	wiki.js		yosgc		ok/""
#--
#-- "name" #-- 쓸수 있는 DB_NAME 을 보야주고 끝냅i니다.
#-- dbname	"" #-- 지정한 데이터베이스로 진행합니다.
#-- dbname	"ok" #-- 지정한 데이터베이스로 진행하면서 과정을 보여줍니다.
#-- dbname	"enter" #-- 조건값을 입력 받을수 있도록 한다. 진행 과정도 보여줍니다.
#-- "" #-- \$1 을 지정하지 않았으므로 바로 종료힙니다.
__EOF__
	exit -1
fi

if [ "x${ENTER_VALUE}" = "xok" ]; then
	value_keyin "LOGIN_PATH" "${LOGIN_PATH}" "데이터베이스의 로그인 패쓰 를 입력하세요."
	LOGIN_PATH="${return_value}"

	value_keyin "LOCAL_FOLDER" "${LOCAL_FOLDER}" "백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름을 입력하세요."
	LOCAL_FOLDER="${return_value}"

	value_keyin "REMOTE_FOLDER" "${REMOTE_FOLDER}" "원격 저장소의 첫번째 폴더 이름을 입력하세요."
	REMOTE_FOLDER="${return_value}"

	value_keyin "RCLONE_NAME" "${RCLONE_NAME}" "rclone 이름을 입력하세요."
	RCLONE_NAME="${return_value}"

DB_NAME
LOGIN_PATH
LOCAL_FOLDER	REMOTE_FOLDER	RCLONE_NAME
SHOW OK?
fi

uname_n=$(uname -n)
db_NOWyoil_sql_7z=${DB_NAME}_${ymd_hm}_${uname_n}${yoil_atog}.sql.7z #-- *"[a-g].sql.7z" // 요일 표시
this_wol_sql_7z="${this_wol}.sql.7z"
db_nowWOL_sql_7z=${DB_NAME}_${ymd_hm}_${uname_n}.${this_wol_sql_7z} #-- *".07.sql.7z" // 월 표시

LOCAL_THIS_YEAR=${LOCAL_FOLDER}/${this_year} #-- 년도 폴더에는 매월 마지막 백업 1개씩만 보관한다.
LOCAL_THIS_WOL=${LOCAL_THIS_YEAR}/${this_wol} #-- 년.월별 폴더에는 이달의 마지막 1주일치만 보관한다.
LOCAL_THIS_WEEK=${LOCAL_THIS_YEAR}/weeks #-- 년도의 weeks 폴더에는 매주 마지막 백업 1개씩만 보관한다.

REMOTE_YEAR=wiki.js/${this_year}
REMOTE_WOL=${REMOTE_FOLDER}/${this_wol} #-- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년/월 폴더이름

rclone_name=yosgc #-- 원격 저장소인 yosjeongc 를 연결하기 위해 rclone 에서 쓰는 이름


show_title "${REMOTE_WOL} 월 최근 일주일 백업을 시작니다. (${ymd_hm})"


if [ ! -d ${LOCAL_THIS_WOL} ]; then
	showno="1a" ; showqq="보관용 로컬 디렉토리를 만듭니다."
	show_then_run "mkdir -p ${LOCAL_THIS_WOL}"
else
	showno="1b" ; showqq="보관용 로컬 디렉토리 입니다."
	show_then_run "ls -l ${LOCAL_THIS_WOL}"
fi


showno="2" ; showqq="오늘날짜 클라우드 백업파일이 있는지 확인 합니다."
show_then_view "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_WOL}/ | grep ${yoil_atog}.sql.7z | awk '{print \$2}')"
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_WOL}/ | grep ${yoil_atog}.sql.7z | awk '{print $2}')


if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	showno="3a" ; shwo_msg="클라우드에 오늘날짜 백업파일이 있는 경우,"
	show_then_view "mapfile -t Remote_Sql7z_Array <<< \"$REMOTE_SQL_7Z_LIST\""
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		showno="3a1" ; showqq="빈칸 삭제 // https://linuxhint.com/trim_string_bash/"
		show_then_view "file_name=\$(echo ${val} | sed 's/ *\$//g')"
		file_name=$(echo ${val} | sed 's/ *$//g')

		OUTRC=$(/usr/bin/rclone deletefile ${rclone_name}:${REMOTE_WOL}/${file_name})
		showno="3a2" ; showqq="오늘날짜 클라우드 백업파일을 삭제합니다."
		show_then_view "OUTRC=\$(/usr/bin/rclone deletefile ${rclone_name}:${REMOTE_WOL}/${file_name}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
		show_then_view "#"
	done
else
	showno="3b" ; showqq="클라우드에는 오늘날짜 백업파일이 없습니다."
	show_then_view "#"
fi
# echo ">>>> ^C" ; read a

showno="4" ; showqq="오늘날짜 로컬 백업파일을 삭제합니다."
show_then_run "rm -f ${LOCAL_THIS_WOL}/*${yoil_atog}.sql.7z"

showno="5" ; showqq="DB 를 로컬에 백업합니다."
show_then_run "/usr/bin/mysqldump --login-path=${LOGIN_PATH} --column-statistics=0 ${DB_NAME} | 7za a -si ${LOCAL_THIS_WOL}/${db_NOWyoil_sql_7z}"

OUTRC=$(/usr/bin/rclone copy ${LOCAL_THIS_WOL}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_WOL}/)
showno="6" ; showqq="로컬 DB 백업파일을 클라우드로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${LOCAL_THIS_WOL}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_WOL}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"


showno="6" ; showqq="${REMOTE_WOL} 월 최근 일주일 백업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


#--


show_title "${REMOTE_WOL} 월의 마지막날짜로 복사 시작 (${ymd_hm})"


showno="11" ; showqq="${this_wol}월 백업파일이 이전에 백업돼 있었는지 확인 합니다."
show_then_view "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR}/ | grep ${this_wol_sql_7z} | awk '{print \$2}')"
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR}/ | grep ${this_wol_sql_7z} | awk '{print $2}')


if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	showno="12a" ; shwo_msg="클라우드에 이달 백업파일이 있는 경우,"
	show_then_view "mapfile -t Remote_Sql7z_Array <<< \"$REMOTE_SQL_7Z_LIST\""
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		showno="12a1" ; showqq="빈칸 삭제"
		show_then_view "file_name=\$(echo ${val} | sed 's/ *\$//g')"
		file_name=$(echo ${val} | sed 's/ *$//g')

		OUTRC=$(/usr/bin/rclone deletefile ${rclone_name}:${REMOTE_YEAR}/${file_name})
		showno="12a2" ; showqq="${this_wol}월 백업파일을 삭제합니다."
		show_then_view "OUTRC=\$(/usr/bin/rclone deletefile ${rclone_name}:${REMOTE_WOL}/${file_name}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
	done
else
	showno="12b" ; showqq="클라우드에는 ${this_wol}월 백업파일이 없습니다."
	show_then_view "#"
fi



showno="13" ; showqq="${REMOTE_WOL} 월 백업을 시작합니다. (${ymd_hm})"
show_then_view "#"


OUTRC=$(/usr/bin/rclone copy ${rclone_name}:${REMOTE_WOL}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_YEAR}/)
showno="14" ; showqq="${this_wol}월 백업파일을 ${this_year}년도 폴더로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${rclone_name}:${REMOTE_WOL}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_YEAR}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR})
showno="16" ; showqq="폴더 확인"
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone moveto ${rclone_name}:${REMOTE_YEAR}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_YEAR}/${db_nowWOL_sql_7z})
showno="18" ; showqq="파일 이름을 바꿉니다."
show_then_view "OUTRC=\$(/usr/bin/rclone moveto ${rclone_name}:${REMOTE_YEAR}/${db_NOWyoil_sql_7z} ${rclone_name}:${REMOTE_YEAR}/${db_nowWOL_sql_7z}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR})
showno="18" ; showqq="년도"
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_YEAR}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
show_then_view "${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_WOL})
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${rclone_name}:${REMOTE_WOL}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"


showno="19" ; showqq="${REMOTE_WOL} 월 백업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


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
