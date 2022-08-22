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
#---> value_keyin "LOGIN_PATH" "${LOGIN_PATH}" "데이터베이스의 로그인 패쓰 를 입력하세요."
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
#<--- value


show_ok="NOok" #-- "ok" 라면 터미널에서 실행하는 경우로 보고, 메세지를 보여준다.

this_year=$(date +%Y) #-- 2022
this_wol=$(date +%m) #-- 07
ymd_hm=$(date +"%y%m%d%a-%H%M") #-- ymd_hm=$(date +"%y%m%d-%H%M%S")

yoil_number0to6=$(date +%u) #------------ 일0 월1 화2 수3 목4 금5 토6
yoil_number1to7=$(( ${yoil_number0to6} + 1 )) #-- 1   2   3   4   5   6   7   #--
# yoil_atog=$(echo "abcdefg" | cut -c ${yoil_number1to7}) #---- 요일 a...g 일...토 #-- XX
ju_beonho=$(date +%V) #-- 1년중 몇번째 주인지 표시. V: 그해의 첫번째 월요일부터 01주, 첫번째 월요일 이전은 새해라도 전해 마지막 주 번째로 한다. (월요일부터 일요일까지 호번)
#--
#-- date -date '31 Dec 2021' _%Y-%m-%d__%V-V_%U-U
#--
#--    월    화    수    목    금    토    일
#--    12/27 12/28 12/29 12/30 12/31 1/1   1/2
#--    52____52____52____52____52____52____52____%V
#--    1/3   1/4   1/5   1/6   1/7   1/8   1/9
#--    01____01____01____01____01____01____01____%V
#--
#--    월    화    수    목    금    토    일
#--    1/24  1/25  1/26  1/27  1/28  1/29  1/30
#--    04____04____04____04____04____04____04____%V
#--    1/31  2/1   2/2   2/3   2/4   2/5   2/6
#--    05____05____05____05____05____05____05____%V
#--
#-- U: 그해의 첫번째 일요일부터 01주, 그해 1일부터 첫번째 토요일까지는 00주로 한다. 연말,연초만 한개의 주가 마지막 주와 00 주로 나뉘어지고 나머지는 일요일 기준 일련번호.
#--
#--      일    월    화    수    목    금    토
#--      12/26 12/27 12/28 12/29 12/30 12/31 1/1
#-- %U---52----52----52----52----52----52--( 00 )
#--      1/2   1/3   1/4   1/5   1/6   1/7   1/8
#-- %U---01----01----01----01----01----01----01
#--
#--      일    월    화    수    목    금    토
#--      1/23  1/24  1/25  1/26  1/27  1/28  1/29  
#-- %U---04----04----04----04----04----04----04
#--      1/30  1/31  2/1   2/2   2/3   2/4   2/5
#-- %U---05----05----05----05----05----05----05
#-- 

if [ "x$1" = "x" ]; then
	cat <<__EOF__

${cYellow}${CMD_NAME} ${cMagenta}[ DB_NAME ] 을 지정하지 않았으므로 작업을 끝냅니다.${cReset}
__EOF__
	exit -1
fi

if [ "x$1" = "xkaosorder" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="kaoslog" #-- 데이터베이스 로그인 패쓰
	LOCAL_FOLDER="${HOME}/kaosorder/${HOSTNAME}" #-- 백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="kaosorder" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="kngc" #-- rclone 이름 kaos.notegc
else
if [ "x$1" = "xgate242" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="swlog" #-- 데이터베이스 로그인 패쓰
	LOCAL_FOLDER="${HOME}/gate242/${HOSTNAME}" #-- 백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="gate242" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="swlgc" #-- rclone 이름 seowontire.libgc
else
if [ "x$1" = "xwiki" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="wikipsql" #-- 데이터베이스 로그인 패쓰 ;;; pgsql 이라서 쓰지는 않음.
	LOCAL_FOLDER="${HOME}/wiki.js/${HOSTNAME}" #-- 백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="wiki.js" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="yosgc" #-- rclone 이름 yosjeongc
else
	cat <<__EOF__

${cYellow}${CMD_NAME} ${cMagenta} $1 데이터베이스는 프로그램에 등록되지 않았으므로 작업을 끝냅니다.${cReset}
__EOF__
	exit -1
fi
fi
fi

ENTER_VALUE="NOok" #-- ok=환경변수 대신 하나하나 입력하도록 한다.
SHOW_OK="NOok" #-- ok=작업과정을 화면에 보여준다.

if [ "x$2" = "xok" ]; then
	SHOW_OK="ok"
else
	if [ "x$2" = "xenter" ]; then
		ENTER_VALUE="ok" #-- ok=환경변수 대신 하나하나 입력하도록 한다.
	else
		if [ "x$2" != "x" ]; then
			LOGIN_PATH="$2"
		fi
	fi
fi
if [ "x$3" != "x" ]; then
	LOCAL_FOLDER="$3"
fi
if [ "x$4" != "x" ]; then
	REMOTE_FOLDER="$4"
fi
if [ "x$5" != "x" ]; then
	RCLONE_NAME="$5"
fi
if [ "x$6" = "xok" ]; then
	SHOW_OK="ok"
fi

if [ "x$1" = "xhelp" ]; then
	cat <<__EOF__
#-- 1		2		3		4		5		6
#-- DB_NAME	LOGIN_PATH	LOCAL_FOLDER	REMOTE_FOLDER	RCLONE_NAME	SHOW OK?
#-- kaosorder2	kaosgc		/home/kaosdb	kaosorder	kngc		ok/""
#-- gate242	swlgc		/home/gate242	gate242		swlgc		ok/""
#-- wiki	wikipsql	/home/wiki.js	wiki.js		yosgc		ok/""
#--
#-- dbname	"" #-- 지정한 데이터베이스로 진행합니다.
#-- dbname	"ok" #-- 지정한 데이터베이스로 진행하면서 과정을 보여줍니다.
#-- dbname	"enter" #-- 조건값을 터미널에서 입력하도록 합니다. 진행 과정도 보여줍니다.
#-- "help" #-- 쓸수 있는 DB_NAME 을 보야주고 끝냅i니다.
#--
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

fi

uname_n=$(uname -n)
yoil_sql_7z=Y${yoil_number1to7}.sql.7z #-- Y[1-7].sql.7z // 요일 표시
Db_Time_Uname_Yoil_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${yoil_sql_7z}

this_wol_sql_7z=W${this_wol}.sql.7z #-- W07.sql.7z // 월 표시
db_nowWOL_sql_7z=${DB_NAME}_${ymd_hm}_${uname_n}${this_wol_sql_7z}

ju_beonho_sql_7z=J${ju_beonho}.sql.7z #-- J01.sql.7z // 1년중 몇번째 주인지 표시
db_jubeonho_sql_7z=${DB_NAME}_${ymd_hm}_${uname_n}${ju_beonho_sql_7z}

LOCAL_THIS_YEAR=${LOCAL_FOLDER}/${this_year} #-- 년도 폴더에는 매월 마지막 백업 1개씩만 보관한다.

LOCAL_THIS_WOL=${LOCAL_THIS_YEAR}/${this_wol} #-- 년.월별 폴더에는 이달의 마지막 1주일치만 보관한다.
LOCAL_THIS_WEEKS=${LOCAL_THIS_YEAR}/weeks #-- 년도의 weeks 폴더에는 매주 마지막 백업 1개씩만 보관한다.

REMOTE_YEAR=${REMOTE_FOLDER}/${this_year}

REMOTE_WOL=${REMOTE_YEAR}/${this_wol} #-- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년/월 폴더이름
REMOTE_WEEKS=${REMOTE_YEAR}/weeks #-- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년/weeks 폴더이름


#----> REMOTE / 2022 / 08 / 최근 1주일치


show_title "${REMOTE_WOL} 월 최근 일주일 백업을 시작합니다. (${ymd_hm})"


if [ ! -d ${LOCAL_THIS_WOL} ]; then
	showno="1a" ; showqq="보관용 로컬 디렉토리를 만듭니다."
	show_then_run "mkdir -p ${LOCAL_THIS_WOL}"
else
	showno="1b" ; showqq="보관용 로컬 디렉토리 입니다."
	show_then_run "ls -l ${LOCAL_THIS_WOL}"
fi


showno="2" ; showqq="오늘날짜 클라우드 백업파일이 있는지 확인 합니다."
show_then_view "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WOL}/ | grep ${yoil_sql_7z} | awk '{print \$2}')"
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WOL}/ | grep ${yoil_sql_7z} | awk '{print $2}')


if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	showno="3a" ; shwo_msg="클라우드에 오늘날짜 백업파일이 있는 경우,"
	show_then_view "mapfile -t Remote_Sql7z_Array <<< \"$REMOTE_SQL_7Z_LIST\""
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		showno="3a1" ; showqq="빈칸 삭제 // https://linuxhint.com/trim_string_bash/"
		show_then_view "file_name=\$(echo ${val} | sed 's/ *\$//g')"
		file_name=$(echo ${val} | sed 's/ *$//g')

		OUTRC=$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_WOL}/${file_name})
		showno="3a2" ; showqq="오늘날짜 클라우드 백업파일을 삭제합니다."
		show_then_view "OUTRC=\$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_WOL}/${file_name}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
		show_then_view "#"
	done
else
	showno="3b" ; showqq="클라우드에는 오늘날짜 백업파일이 없습니다."
	show_then_view "#"
fi
# echo ">>>> ^C" ; read a

showno="4" ; showqq="오늘날짜 로컬 백업파일을 삭제합니다."
show_then_run "rm -f ${LOCAL_THIS_WOL}/*${yoil_sql_7z}"

showno="5" ; showqq="DB 를 로컬에 백업합니다."
show_then_run "/usr/bin/mysqldump --login-path=${LOGIN_PATH} --column-statistics=0 ${DB_NAME} | 7za a -si ${LOCAL_THIS_WOL}/${Db_Time_Uname_Yoil_sql7z}"

OUTRC=$(/usr/bin/rclone copy ${LOCAL_THIS_WOL}/${Db_Time_Uname_Yoil_sql7z} ${RCLONE_NAME}:${REMOTE_WOL}/)
showno="6" ; showqq="로컬 DB 백업파일을 클라우드로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${LOCAL_THIS_WOL}/${Db_Time_Uname_Yoil_sql7z} ${RCLONE_NAME}:${REMOTE_WOL}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"


showno="6" ; showqq="${REMOTE_WOL} 월 최근 일주일 백업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


#<---- REMOTE / 2022 / 08 / 최근 1주일치

#----> REMOTE / 2022 / 당월 최종 1개


show_title "${REMOTE_WOL} 월의 마지막 백업파일을 ${REMOTE_YEAR} 년도로 복사 시작 (${ymd_hm})"


showno="11" ; showqq="${this_wol}월 백업파일이 이전에 백업돼 있었는지 확인 합니다."
show_then_view "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR}/ | grep ${this_wol_sql_7z} | awk '{print \$2}')"
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR}/ | grep ${this_wol_sql_7z} | awk '{print $2}')


if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	showno="12a" ; shwo_msg="클라우드에 이달 백업파일이 있는 경우,"
	show_then_view "mapfile -t Remote_Sql7z_Array <<< \"$REMOTE_SQL_7Z_LIST\""
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		showno="12a1" ; showqq="빈칸 삭제"
		show_then_view "file_name=\$(echo ${val} | sed 's/ *\$//g')"
		file_name=$(echo ${val} | sed 's/ *$//g')

		OUTRC=$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_YEAR}/${file_name})
		showno="12a2" ; showqq="${this_wol}월 백업파일을 삭제합니다."
		show_then_view "OUTRC=\$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_WOL}/${file_name}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
	done
else
	showno="12b" ; showqq="클라우드에는 ${this_wol}월 백업파일이 없습니다."
	show_then_view "#"
fi



showno="13" ; showqq="${REMOTE_WOL} 월 백업파일을 ${REMOTE_YEAR} 년도로 복사하는 작업을 시작합니다. (${ymd_hm})"
show_then_view "#"


OUTRC=$(/usr/bin/rclone copy ${RCLONE_NAME}:${REMOTE_WOL}/${Db_Time_Uname_Yoil_sql7z} ${RCLONE_NAME}:${REMOTE_YEAR}/)
showno="14" ; showqq="${this_wol}월 백업파일을 ${this_year}년도 폴더로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${RCLONE_NAME}:${REMOTE_WOL}/${Db_Time_Uname_Yoil_sql7z} ${RCLONE_NAME}:${REMOTE_YEAR}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR})
showno="16" ; showqq="폴더 확인"
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone moveto ${RCLONE_NAME}:${REMOTE_YEAR}/${Db_Time_Uname_Yoil_sql7z} ${RCLONE_NAME}:${REMOTE_YEAR}/${db_nowWOL_sql_7z})
showno="18" ; showqq="파일 이름을 바꿉니다."
show_then_view "OUTRC=\$(/usr/bin/rclone moveto ${RCLONE_NAME}:${REMOTE_YEAR}/${Db_Time_Uname_Yoil_sql7z} ${RCLONE_NAME}:${REMOTE_YEAR}/${db_nowWOL_sql_7z}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR})
showno="18" ; showqq="년도"
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
show_then_view "${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WOL})
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WOL}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"


showno="19" ; showqq="${REMOTE_WOL} 월 백업파일을 ${REMOTE_YEAR} 년도로 복사하는 작업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


#<---- REMOTE / 2022 / 당월 최종 1개

#----> REMOTE / 2022 / weeks / 매주 주말 1개


#-- db_jubeonho_sql_7z=${DB_NAME}_${ymd_hm}_${uname_n}${ju_beonho_sql_7z}

show_title "${REMOTE_WOL} 월의 마지막 백업파일을 ${REMOTE_WEEKS} 폴더에 J${ju_beonho} 번호로 복사 시작 (${ymd_hm})"


showno="11" ; showqq="${this_wol}월 백업파일이 이전에 백업돼 있었는지 확인 합니다."
show_then_view "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WEEKS}/ | grep ${ju_beonho_sql_7z} | awk '{print \$2}')"
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WEEKS}/ | grep ${ju_beonho_sql_7z} | awk '{print $2}')


if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	showno="12a" ; shwo_msg="클라우드에 이달 백업파일이 있는 경우,"
	show_then_view "mapfile -t Remote_Sql7z_Array <<< \"$REMOTE_SQL_7Z_LIST\""
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		showno="12a1" ; showqq="빈칸 삭제"
		show_then_view "file_name=\$(echo ${val} | sed 's/ *\$//g')"
		file_name=$(echo ${val} | sed 's/ *$//g')

		OUTRC=$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_WEEKS}/${file_name})
		showno="12a2" ; showqq="${this_wol}월 백업파일을 삭제합니다."
		show_then_view "OUTRC=\$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_WEEKS}/${file_name}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
	done
else
	showno="12b" ; showqq="클라우드에는 ${ju_beonho_sql_7z} 백업파일이 없습니다."
	show_then_view "#"
fi



showno="13" ; showqq="${ju_beonho_sql_7z} 백업파일을 ${REMOTE_WEEKS} 로 복사하는 작업을 시작합니다. (${ymd_hm})"
show_then_view "#"


OUTRC=$(/usr/bin/rclone copy ${RCLONE_NAME}:${REMOTE_WOL}/${Db_Time_Uname_Yoil_sql7z} ${RCLONE_NAME}:${REMOTE_WEEKS}/)
showno="14" ; showqq="${this_wol}월 백업파일을 ${REMOTE_WEEKS} 폴더로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${RCLONE_NAME}:${REMOTE_WOL}/${Db_Time_Uname_Yoil_sql7z} ${RCLONE_NAME}:${REMOTE_WEEKS}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WEEKS})
showno="16" ; showqq="폴더 확인"
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WEEKS}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone moveto ${RCLONE_NAME}:${REMOTE_YEAR}/${Db_Time_Uname_Yoil_sql7z} ${RCLONE_NAME}:${REMOTE_WEEKS}/${db_jubeonho_sql_7z})
showno="18" ; showqq="파일 이름을 바꿉니다."
show_then_view "OUTRC=\$(/usr/bin/rclone moveto ${RCLONE_NAME}:${REMOTE_YEAR}/${Db_Time_Uname_Yoil_sql7z} ${RCLONE_NAME}:${REMOTE_WEEKS}/${db_jubeonho_sql_7z}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WEEKS})
showno="18" ; showqq="년도"
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WEEKS}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
show_then_view "${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"


showno="19" ; showqq="${REMOTE_WOL} 월의 마지막 백업파일을 ${REMOTE_WEEKS} 폴더에 J${ju_beonho} 번호로 복사하는 작업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


#<---- REMOTE / 2022 / weeks / 매주 주말 1개


#|====>>
#|
#|
#|  echo $(date 0301000021; date +'%Y-%m-%d%a %H:%M %U-%W %u-%w %g-%V'; echo "%U..(첫번째일요일의주=00) %W..(첫번째월요일의주=00) %u..(월=1,일=7) %w..(일=0,토=6) %g..(4분기) %V..(첫번째일요일의주=0)")
#|
#|<<====
