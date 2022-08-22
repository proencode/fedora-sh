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

if [ "x$1" = "xkaosorder" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="kaoslog" #-- 데이터베이스 로그인 패쓰
	LOCAL_FOLDER="${HOME}/kaosorder/${HOSTNAME}" #-- 백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="kaosorder" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="kngc" #-- rclone 이름 kaos.notegc
	DB_TYPE="mysql"
else
if [ "x$1" = "xgate242" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="swlog" #-- 데이터베이스 로그인 패쓰
	LOCAL_FOLDER="${HOME}/gate242/${HOSTNAME}" #-- 백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="gate242" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="swlgc" #-- rclone 이름 seowontire.libgc
	DB_TYPE="mysql"
else
if [ "x$1" = "xwiki" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="wikipsql" #-- 데이터베이스 로그인 패쓰 ;;; pgsql 이라서 쓰지는 않음.
	LOCAL_FOLDER="${HOME}/wiki.js/${HOSTNAME}" #-- 백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="wiki.js" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="yosgc" #-- rclone 이름 yosjeongc
	DB_TYPE="pgsql"
else
	cat <<__EOF__

${cYellow}${CMD_NAME} ${cMagenta} $1 데이터베이스는 프로그램에 등록되지 않았으므로 작업을 끝냅니다.${cReset}
__EOF__
	exit -1
fi
fi
fi

ENTER_VALUE="NOok" #-- ok=환경변수 대신 하나하나 입력하도록 한다.
show_ok="NOok" #-- ok=작업과정을 화면에 보여준다.


if [ "x$2" = "xok" ]; then
	show_ok="ok"
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
	show_ok="ok"
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
yoil_sql_7z=".${yoil_number1to7}yoil.sql.7z" #-- Y[1-7].sql.7z // 요일 표시
YOIL_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${yoil_sql_7z}

this_wol_sql_7z=".${this_wol}wol.sql.7z" #-- W07.sql.7z // 월 표시
WOL_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${this_wol_sql_7z}

ju_beonho_sql_7z=".${ju_beonho}ju.sql.7z" #-- J01.sql.7z // 1년중 몇번째 주인지 표시
JU_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${ju_beonho_sql_7z}

LOCAL_THIS_YEAR=${LOCAL_FOLDER}/${this_year} #-- 년도 폴더에는 매월 마지막 백업 1개씩만 보관한다.

LOCAL_THIS_WOL=${LOCAL_THIS_YEAR}/${this_wol} #-- 년.월별 폴더에는 이달의 마지막 1주일치만 보관한다.
LOCAL_THIS_JU=${LOCAL_THIS_YEAR}/ju #-- 년도의 ju 폴더에는 매주 마지막 백업 1개씩만 보관한다.

REMOTE_YEAR=${REMOTE_FOLDER}/${this_year}

REMOTE_WOL=${REMOTE_YEAR}/${this_wol} #-- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년/월 폴더이름
REMOTE_JU=${REMOTE_YEAR}/ju #-- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년/ju 폴더이름


#----> REMOTE / 2022 / 08 / 최근 1주일치


show_title "${REMOTE_WOL} 월 최근 일주일 백업을 시작합니다. (${ymd_hm})"


if [ ! -d ${LOCAL_THIS_WOL} ]; then
	showno="1a" ; showqq="보관용 로컬 디렉토리를 만듭니다."
	show_then_run "mkdir -p ${LOCAL_THIS_WOL}"
else
	showno="1b" ; showqq="보관용 로컬 디렉토리 입니다."
	show_then_run "ls -l ${LOCAL_THIS_WOL}"
fi
if [ ! -d ${LOCAL_THIS_JU} ]; then
	showno="2a" ; showqq="보관용 로컬 디렉토리를 만듭니다."
	show_then_run "mkdir -p ${LOCAL_THIS_JU}"
else
	showno="2b" ; showqq="보관용 로컬 디렉토리 입니다."
	show_then_run "ls -l ${LOCAL_THIS_JU}"
fi


showno="3" ; showqq="오늘날짜 클라우드 백업파일이 있는지 확인 합니다."
show_then_view "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WOL}/ | grep ${yoil_sql_7z} | awk '{print \$2}')"
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_WOL}/ | grep ${yoil_sql_7z} | awk '{print $2}')


if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	showno="4a" ; shwo_msg="클라우드에 오늘날짜 백업파일이 있는 경우,"
	show_then_view "mapfile -t Remote_Sql7z_Array <<< \"$REMOTE_SQL_7Z_LIST\""
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		showno="4a1" ; showqq="빈칸 삭제 // https://linuxhint.com/trim_string_bash/"
		show_then_view "file_name=\$(echo ${val} | sed 's/ *\$//g')"
		file_name=$(echo ${val} | sed 's/ *$//g')

		OUTRC=$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_WOL}/${file_name})
		showno="4a2" ; showqq="오늘날짜 클라우드 백업파일을 삭제합니다."
		show_then_view "OUTRC=\$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_WOL}/${file_name}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
		show_then_view "#"
	done
else
	showno="4b" ; showqq="클라우드에는 오늘날짜 백업파일이 없습니다."
	show_then_view "#"
fi
# echo ">>>> ^C" ; read a

showno="5" ; showqq="오늘날짜 로컬 백업파일을 삭제합니다."
show_then_run "rm -f ${LOCAL_THIS_WOL}/*${yoil_sql_7z}"

showno="6" ; showqq="DB 를 로컬에 백업합니다."
ymd_hm=$(date +"%y%m%d%a-%H%M") #-- ymd_hm=$(date +"%y%m%d-%H%M%S")
#xxx pswd_code="${DB_NAME}${ymd_hm:0:6}" #-- kaosorder2/gate242/wiki + 991231 xxx crontab 으로 실행하므로 보안상 비번을 제외한다.
if [ "x${DB_TYPE}" = "xmysql" ]; then
	show_then_run "/usr/bin/mysqldump --login-path=${LOGIN_PATH} --column-statistics=0 ${DB_NAME} | 7za a -si ${LOCAL_THIS_WOL}/${YOIL_sql7z}" #xxx -p${pswd_code}"
else
if [ "x${DB_TYPE}" = "xpgsql" ]; then
	show_then_run "sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${LOCAL_THIS_WOL}/${YOIL_sql7z}" #xxx -p${pswd_code}"
else
	cat <<__EOF__

${cYellow}${DB_TYPE} ${cMagenta}[ DB_TYPE ] 을 지정하지 않았으므로 작업을 끝냅니다.${cReset}
__EOF__
	exit -1
fi
fi

OUTRC=$(/usr/bin/rclone copy ${LOCAL_THIS_WOL}/${YOIL_sql7z} ${RCLONE_NAME}:${REMOTE_WOL}/)
showno="7" ; showqq="로컬 DB 백업파일을 클라우드로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${LOCAL_THIS_WOL}/${YOIL_sql7z} ${RCLONE_NAME}:${REMOTE_WOL}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"


showno="8" ; showqq="${REMOTE_WOL} 월 최근 일주일 백업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


#<---- REMOTE / 2022 / 08 / 최근 1주일치

#----> REMOTE / 2022 / 당월 최종 1개


show_title "${REMOTE_WOL} 월의 마지막 백업파일을 ${REMOTE_YEAR} 년도로 복사 시작 (${ymd_hm})"


showno="9" ; showqq="${this_wol}월 백업파일이 이전에 백업돼 있었는지 확인 합니다."
show_then_view "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR}/ | grep ${this_wol_sql_7z} | awk '{print \$2}')"
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR}/ | grep ${this_wol_sql_7z} | awk '{print $2}')

if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	showno="10a" ; shwo_msg="클라우드에 이달 백업파일이 있는 경우,"
	show_then_view "mapfile -t Remote_Sql7z_Array <<< \"$REMOTE_SQL_7Z_LIST\""
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		showno="10a1" ; showqq="빈칸 삭제"
		show_then_view "file_name=\$(echo ${val} | sed 's/ *\$//g')"
		file_name=$(echo ${val} | sed 's/ *$//g')

		OUTRC=$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_YEAR}/${file_name})
		showno="10a2" ; showqq="${this_wol}월 백업파일을 삭제합니다."
		show_then_view "OUTRC=\$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_WOL}/${file_name}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
	done
else
	showno="10b" ; showqq="클라우드에는 ${this_wol}월 백업파일이 없습니다."
	show_then_view "#"
fi

showno="11" ; showqq="오늘날짜 로컬 백업파일을 삭제합니다."
show_then_run "rm -f ${LOCAL_THIS_YEAR}/*${this_wol_sql_7z}"



showno="12" ; showqq="${REMOTE_WOL} 월 백업파일을 ${REMOTE_YEAR} 년도로 복사하는 작업을 시작합니다. (${ymd_hm})"
show_then_view "#"


showno="13" ; showqq="로컬 디렉토리의 월 백업파일을 년도로 복사합니다."
show_then_run "cp ${LOCAL_THIS_WOL}/${YOIL_sql7z} ${LOCAL_THIS_YEAR}/${WOL_sql7z}"

OUTRC=$(/usr/bin/rclone copy ${LOCAL_THIS_YEAR}/${WOL_sql7z} ${RCLONE_NAME}:${REMOTE_YEAR}/)
showno="14" ; showqq="${this_wol}월 백업파일을 ${this_year}년도 폴더로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${LOCAL_THIS_YEAR}/${WOL_sql7z} ${RCLONE_NAME}:${REMOTE_YEAR}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR})
showno="15" ; showqq="폴더 확인"
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

showno="16" ; showqq="${REMOTE_WOL} 월 백업파일을 ${REMOTE_YEAR} 년도로 복사하는 작업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


#<---- REMOTE / 2022 / 당월 최종 1개

#----> REMOTE / 2022 / ju / 매주 주말 1개


#-- JU_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${ju_beonho_sql_7z}

show_title "${REMOTE_WOL} 월의 마지막 백업파일을 ${REMOTE_JU} 폴더에 J${ju_beonho} 번호로 복사 시작 (${ymd_hm})"


showno="17" ; showqq="${this_wol}월 백업파일이 이전에 백업돼 있었는지 확인 합니다."
show_then_view "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_JU}/ | grep ${ju_beonho_sql_7z} | awk '{print \$2}')"
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_JU}/ | grep ${ju_beonho_sql_7z} | awk '{print $2}')


if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	showno="18a" ; shwo_msg="클라우드에 이달 백업파일이 있는 경우,"
	show_then_view "mapfile -t Remote_Sql7z_Array <<< \"$REMOTE_SQL_7Z_LIST\""
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		showno="18a1" ; showqq="빈칸 삭제"
		show_then_view "file_name=\$(echo ${val} | sed 's/ *\$//g')"
		file_name=$(echo ${val} | sed 's/ *$//g')

		OUTRC=$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_JU}/${file_name})
		showno="18a2" ; showqq="${this_wol}월 백업파일을 삭제합니다."
		show_then_view "OUTRC=\$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_JU}/${file_name}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
	done
else
	showno="18b" ; showqq="클라우드에는 ${ju_beonho_sql_7z} 백업파일이 없습니다."
	show_then_view "#"
fi

showno="19" ; showqq="오늘날짜 로컬 백업파일을 삭제합니다."
show_then_run "rm -f ${LOCAL_THIS_JU}/*${ju_beonho_sql_7z}"


showno="20" ; showqq="${ju_beonho_sql_7z} 백업파일을 ${REMOTE_JU} 로 복사하는 작업을 시작합니다. (${ymd_hm})"
show_then_run "cp ${LOCAL_THIS_WOL}/${YOIL_sql7z} ${LOCAL_THIS_JU}/${JU_sql7z}"

OUTRC=$(/usr/bin/rclone copy ${LOCAL_THIS_JU}/${JU_sql7z} ${RCLONE_NAME}:${REMOTE_JU}/)
showno="21" ; showqq="${this_wol}월 백업파일을 ${REMOTE_JU} 폴더로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${LOCAL_THIS_JU}/${JU_sql7z} ${RCLONE_NAME}:${REMOTE_JU}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_JU})
showno="22" ; showqq="폴더 확인"
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_JU}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"


showno="23" ; showqq="${REMOTE_WOL} 월의 마지막 백업파일을 ${REMOTE_JU} 폴더에 J${ju_beonho} 번호로 복사하는 작업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


#<---- REMOTE / 2022 / ju / 매주 주말 1개


#|====>>
#|
#|  16:32:01월220822 fedora@vfc36jj ~/git-projects/fedora-sh/10-wikijs-docker-by-markdown
#|  10-wikijs-docker-by-markdown $ sh db-to-cloud.sh wiki ok
#|      |
#|      |
#|      | wiki.js/2022/08 월 최근 일주일 백업을 시작합니다. (220822월-1632)
#|      |
#|      |
#|  ----> ls -l /home/fedora/wiki.js/vfc36jj/2022/08 #-- #-- (1b) 보관용 로컬 디렉토리 입니다.
#|  합계 22336
#|  -rw-r--r-- 1 fedora fedora 22870240  8월 22일 16:11 wiki_220822월-1610_vfc36jjY2.sql.7z
#|  <---- ls -l /home/fedora/wiki.js/vfc36jj/2022/08 #-- #-- (1b) 보관용 로컬 디렉토리 입니다.
#|  ----> ls -l /home/fedora/wiki.js/vfc36jj/2022/ju #-- #-- (2b) 보관용 로컬 디렉토리 입니다.
#|  합계 22336
#|  -rw-r--r-- 1 fedora fedora 22870240  8월 22일 16:11 wiki_220822월-1610_vfc36jjJ34.sql.7z
#|  <---- ls -l /home/fedora/wiki.js/vfc36jj/2022/ju #-- #-- (2b) 보관용 로컬 디렉토리 입니다.
#|  ----> REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls yosgc:wiki.js/2022/08/ | grep .2yoil.sql.7z | awk '{print $2}') #-- (3) 오늘날짜 클라우드 백업파일이 있는지 확인 합니다.
#|  ----> # #-- (4b) 클라우드에는 오늘날짜 백업파일이 없습니다.
#|  ----> rm -f /home/fedora/wiki.js/vfc36jj/2022/08/*.2yoil.sql.7z #-- #-- (5) 오늘날짜 로컬 백업파일을 삭제합니다.
#|  <---- rm -f /home/fedora/wiki.js/vfc36jj/2022/08/*.2yoil.sql.7z #-- #-- (5) 오늘날짜 로컬 백업파일을 삭제합니다.
#|  ----> sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si /home/fedora/wiki.js/vfc36jj/2022/08/wiki_220822월-1632_vfc36jj.2yoil.sql.7z #-- #-- (6) DB 를 로컬에 백업합니다.
#|  
#|  7-Zip (a) [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
#|  p7zip Version 16.02 (locale=ko_KR.UTF-8,Utf16=on,HugeFiles=on,64 bits,1 CPU Intel(R) Core(TM) i5-9500 CPU @ 3.00GHz (906EA),ASM,AES-NI)
#|  
#|  Creating archive: /home/fedora/wiki.js/vfc36jj/2022/08/wiki_220822월-1632_vfc36jj.2yoil.sql.7z
#|  
#|  Items to compress: 1
#|  
#|  
#|  Files read from disk: 1
#|  Archive size: 22870240 bytes (22 MiB)
#|  Everything is Ok
#|  <---- sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si /home/fedora/wiki.js/vfc36jj/2022/08/wiki_220822월-1632_vfc36jj.2yoil.sql.7z #-- #-- (6) DB 를 로컬에 백업합니다.
#|  ----> OUTRC=$(/usr/bin/rclone copy /home/fedora/wiki.js/vfc36jj/2022/08/wiki_220822월-1632_vfc36jj.2yoil.sql.7z yosgc:wiki.js/2022/08/) #-------- #-- (7) 로컬 DB 백업파일을 클라우드로 복사합니다.
#|  ----> # #-- (8) wiki.js/2022/08 월 최근 일주일 백업을 끝냅니다. (220822월-1632)
#|      |
#|      |
#|      | wiki.js/2022/08 월의 마지막 백업파일을 wiki.js/2022 년도로 복사 시작 (220822월-1632)
#|      |
#|      |
#|  ----> REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls yosgc:wiki.js/2022/ | grep .08wol.sql.7z | awk '{print $2}') #-- (9) 08월 백업파일이 이전에 백업돼 있었는지 확인 합니다.
#|  ----> # #-- (10b) 클라우드에는 08월 백업파일이 없습니다.
#|  ----> rm -f /home/fedora/wiki.js/vfc36jj/2022/*.08wol.sql.7z #-- #-- (11) 오늘날짜 로컬 백업파일을 삭제합니다.
#|  <---- rm -f /home/fedora/wiki.js/vfc36jj/2022/*.08wol.sql.7z #-- #-- (11) 오늘날짜 로컬 백업파일을 삭제합니다.
#|  ----> # #-- (12) wiki.js/2022/08 월 백업파일을 wiki.js/2022 년도로 복사하는 작업을 시작합니다. (220822월-1632)
#|  ----> cp /home/fedora/wiki.js/vfc36jj/2022/08/wiki_220822월-1632_vfc36jj.2yoil.sql.7z /home/fedora/wiki.js/vfc36jj/2022/wiki_220822월-1632_vfc36jj.08wol.sql.7z #-- #-- (13) 로컬 디렉토리의 월 백업파일을 년도로 복사합니다.
#|  <---- cp /home/fedora/wiki.js/vfc36jj/2022/08/wiki_220822월-1632_vfc36jj.2yoil.sql.7z /home/fedora/wiki.js/vfc36jj/2022/wiki_220822월-1632_vfc36jj.08wol.sql.7z #-- #-- (13) 로컬 디렉토리의 월 백업파일을 년도로 복사합니다.
#|  ----> OUTRC=$(/usr/bin/rclone copy /home/fedora/wiki.js/vfc36jj/2022/wiki_220822월-1632_vfc36jj.08wol.sql.7z yosgc:wiki.js/2022/) #-------- #-- (14) 08월 백업파일을 2022년도 폴더로 복사합니다.
#|  ----> OUTRC=$(/usr/bin/rclone ls yosgc:wiki.js/2022) #---- 22870240 wiki_220822월-1632_vfc36jj.08wol.sql.7z
#|   22870240 wiki_220822월-1610_vfc36jjW08.sql.7z
#|   22870240 08/wiki_220822월-1632_vfc36jj.2yoil.sql.7z
#|   22870240 08/wiki_220822월-1610_vfc36jjY2.sql.7z
#|   22870240 ju/wiki_220822월-1610_vfc36jjJ34.sql.7z---- #-- (15) 폴더 확인
#|  ----> # #-- (16) wiki.js/2022/08 월 백업파일을 wiki.js/2022 년도로 복사하는 작업을 끝냅니다. (220822월-1632)
#|      |
#|      |
#|      | wiki.js/2022/08 월의 마지막 백업파일을 wiki.js/2022/ju 폴더에 J34 번호로 복사 시작 (220822월-1632)
#|      |
#|      |
#|  ----> REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls yosgc:wiki.js/2022/ju/ | grep .34ju.sql.7z | awk '{print $2}') #-- (17) 08월 백업파일이 이전에 백업돼 있었는지 확인 합니다.
#|  ----> # #-- (18b) 클라우드에는 .34ju.sql.7z 백업파일이 없습니다.
#|  ----> rm -f /home/fedora/wiki.js/vfc36jj/2022/ju/*.34ju.sql.7z #-- #-- (19) 오늘날짜 로컬 백업파일을 삭제합니다.
#|  <---- rm -f /home/fedora/wiki.js/vfc36jj/2022/ju/*.34ju.sql.7z #-- #-- (19) 오늘날짜 로컬 백업파일을 삭제합니다.
#|  ----> cp /home/fedora/wiki.js/vfc36jj/2022/08/wiki_220822월-1632_vfc36jj.2yoil.sql.7z /home/fedora/wiki.js/vfc36jj/2022/ju/wiki_220822월-1632_vfc36jj.34ju.sql.7z #-- #-- (20) .34ju.sql.7z 백업파일을 wiki.js/2022/ju 로 복사하는 작업을 시작합니다. (220822월-1632)
#|  <---- cp /home/fedora/wiki.js/vfc36jj/2022/08/wiki_220822월-1632_vfc36jj.2yoil.sql.7z /home/fedora/wiki.js/vfc36jj/2022/ju/wiki_220822월-1632_vfc36jj.34ju.sql.7z #-- #-- (20) .34ju.sql.7z 백업파일을 wiki.js/2022/ju 로 복사하는 작업을 시작합니다. (220822월-1632)
#|  ----> OUTRC=$(/usr/bin/rclone copy /home/fedora/wiki.js/vfc36jj/2022/ju/wiki_220822월-1632_vfc36jj.34ju.sql.7z yosgc:wiki.js/2022/ju/) #-------- #-- (21) 08월 백업파일을 wiki.js/2022/ju 폴더로 복사합니다.
#|  ----> OUTRC=$(/usr/bin/rclone ls yosgc:wiki.js/2022/ju) #---- 22870240 wiki_220822월-1632_vfc36jj.34ju.sql.7z
#|   22870240 wiki_220822월-1610_vfc36jjJ34.sql.7z---- #-- (22) 폴더 확인
#|  ----> # #-- (23) wiki.js/2022/08 월의 마지막 백업파일을 wiki.js/2022/ju 폴더에 J34 번호로 복사하는 작업을 끝냅니다. (220822월-1632)
#|  16:33:44월220822 fedora@vfc36jj ~/git-projects/fedora-sh/10-wikijs-docker-by-markdown
#|  10-wikijs-docker-by-markdown $
#|
#|<<====
