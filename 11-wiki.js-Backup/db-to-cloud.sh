#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
show_then_run () {
	if [ "x$show_ok" = "xok" ]; then
		cmdRun "$1" "#-- (${showno}) ${showqq}"
	else
		echo "$1" | sh
	fi
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

MEMO="cron job"
# cat <<__EOF__
# ${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
# __EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----

this_year=$(date +%Y) #-- 2022
this_wol=$(date +%m) #-- 07
ymd_hm=$(date +"%y%m%d%a-%H%M") #-- ymd_hm=$(date +"%y%m%d-%H%M%S")
pswd_ym=$(date +"%y%m")

yoil_number1to7=$(date +%u) #------------ 월1 화2 수3 목4 금5 토6 일7
# yoil_atog=$(echo "abcdefg" | cut -c ${yoil_number1to7}) #---- 요일 a...g 일...토 #-- XX
ju_beonho=$(date +%V) #-- 1년중 몇번째 주인지 표시. V: 월요일마다 하나씩 증가한다. U: 1월1일=일요일: 01, 아니면: 00. 일요일마다 하나씩 증가한다.


if [ "x$1" = "x" ]; then
	cat <<__EOF__
#-- !		!		/opt/ 아래	gc:/ 아래	!		!	not--use
#-- 1		2		3		4		5		6	not--use
#-- DB_NAME	DB_LOGIN_PATH	LOCAL_FOLDER	REMOTE_FOLDER	RCLONE_NAME	OK?	DB_USER_NAME
#-- kaosorder2	kaoslog		backup/kaosdb	kaosdb		kaosngc		ok/""	kaosorder2 (카오스)
#-- gate242	swlog		backup/gatedb	11-gate242	swlibgc		ok/""	gateroot (서원)
#-- wiki	not--use	backup/wikidb	wikijsdb	yosjgc		ok/""	wiki (wiki.js)
#--
#-- db_name	"" #-- 지정한 데이터베이스로 진행합니다.
#-- db_name	"ok" #-- 지정한 데이터베이스로 진행하면서 과정을 보여줍니다.
#-- db_name	"enter" #-- 조건값을 터미널에서 입력하도록 합니다. 진행 과정도 보여줍니다.
#--

${cYellow}${CMD_NAME} ${cMagenta}[ DB_NAME ] 을 지정하지 않았으므로 작업을 끝냅니다.${cReset}
__EOF__
	exit -1
fi

if [ "x$1" = "xkaosorder" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="kaoslog" #-- 데이터베이스 로그인 패쓰
	LOCAL_FOLDER="backup/kaosdb" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="kaosdb" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="kaosngc" #-- rclone 이름 kaos.notegc
	DB_TYPE="mysql"
	PSWD_GEN_CODE="zkdhtm${pswd_ym}"
else
if [ "x$1" = "xgate242" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="swlog" #-- 데이터베이스 로그인 패쓰
	LOCAL_FOLDER="backup/gatedb" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="11-gate242" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="swlibgc" #-- rclone 이름 seowontire.libgc
	DB_TYPE="mysql"
	PSWD_GEN_CODE="tjdnjs${pswd_ym}"
else
if [ "x$1" = "xwiki" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="wikipsql" #-- 데이터베이스 로그인 패쓰 ;;; pgsql 이라서 쓰지는 않음.
	LOCAL_FOLDER="backup/wikidb" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="wikijsdb" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="yosjgc" #-- rclone 이름 yosjeongc
	DB_TYPE="pgsql"
	PSWD_GEN_CODE="dnlzl${pswd_ym}"
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

	value_keyin "LOCAL_FOLDER" "${LOCAL_FOLDER}" "백업파일을 임시로 저장할 로컬 저장소의 /opt 아래에 있는 디렉토리 이름을 입력하세요."
	LOCAL_FOLDER="${return_value}"

	value_keyin "REMOTE_FOLDER" "${REMOTE_FOLDER}" "원격 저장소의 첫번째 폴더 이름을 입력하세요."
	REMOTE_FOLDER="${return_value}"

	value_keyin "RCLONE_NAME" "${RCLONE_NAME}" "rclone 이름을 입력하세요."
	RCLONE_NAME="${return_value}"

fi

LOCAL_FOLDER="/opt/${LOCAL_FOLDER}" #-- /opt 디렉토리 아래에 보관한다.

if [ ! -d ${LOCAL_FOLDER} ];then
	showno="0" ; showqq="보관용 로컬 디렉토리를 만듭니다."
	show_then_run "sudo mkdir -p ${LOCAL_FOLDER} ; sudo chown ${USER}:${USER} ${LOCAL_FOLDER}"
fi
uname_n=$(uname -n)
yoil_sql_7z=".${yoil_number1to7}yoil.sql.7z" #-- Y[1-7].sql.7z // 요일 표시
YOIL_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${yoil_sql_7z}

this_wol_sql_7z=".${this_wol}wol.sql.7z" #-- W07.sql.7z // 월 표시
WOL_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${this_wol_sql_7z}

ju_beonho_sql_7z=".${ju_beonho}ju.sql.7z" #-- J01.sql.7z // 1년중 몇번째 주인지 표시
JU_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${ju_beonho_sql_7z}

LOCAL_THIS_YEAR=${LOCAL_FOLDER}/${this_year} #-- 년도 폴더에는 매월 마지막 백업 1개씩만 보관한다.

LOCAL_YOIL=${LOCAL_THIS_YEAR}/1_7yoil #-- 년도의 yoil 폴더에는 최근 1주일치만 보관한다.
LOCAL_JU=${LOCAL_THIS_YEAR}/01_53ju #-- 년도의 ju 폴더에는 매주 마지막 백업 1개씩만 보관한다.

REMOTE_YEAR=${REMOTE_FOLDER}/${this_year}

REMOTE_YOIL=${REMOTE_YEAR}/1_7yoil #-- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년eh/last7 폴더이름
REMOTE_JU=${REMOTE_YEAR}/01_53ju #-- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년eh/sunday 폴더이름


#----> REMOTE / 2022 / 08 / 최근 1주일치


show_title "${this_year}/${this_wol} 최근 일주일 백업을 시작합니다. (${ymd_hm})"


if [ ! -d ${LOCAL_YOIL} ]; then
	showno="1a" ; showqq="보관용 로컬 디렉토리를 만듭니다."
	show_then_run "mkdir -p ${LOCAL_YOIL} ; sudo chown ${USER}:${USER} ${LOCAL_YOIL}"
fi
if [ ! -d ${LOCAL_JU} ]; then
	showno="1b" ; showqq="보관용 로컬 디렉토리를 만듭니다."
	show_then_run "mkdir -p ${LOCAL_JU} ; sudo chown ${USER}:${USER} ${LOCAL_JU}"
fi
showno="2" ; showqq="보관용 로컬 디렉토리 입니다."
show_then_run "ls -lR ${LOCAL_THIS_YEAR}"


showno="3" ; showqq="오늘날짜 클라우드 백업파일이 있는지 확인 합니다."
show_then_view "REMOTE_SQL_7Z_LIST=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YOIL}/ | grep ${yoil_sql_7z} | awk '{print \$2}')"
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YOIL}/ | grep ${yoil_sql_7z} | awk '{print $2}')


if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	showno="4a" ; shwo_msg="클라우드에 오늘날짜 백업파일이 있는 경우,"
	show_then_view "mapfile -t Remote_Sql7z_Array <<< \"$REMOTE_SQL_7Z_LIST\""
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"

	for val in "${Remote_Sql7z_Array[@]}"
	do
		showno="4a1" ; showqq="빈칸 삭제 // https://linuxhint.com/trim_string_bash/"
		show_then_view "file_name=\$(echo ${val} | sed 's/ *\$//g')"
		file_name=$(echo ${val} | sed 's/ *$//g')

		OUTRC=$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_YOIL}/${file_name})
		showno="4a2" ; showqq="오늘날짜 클라우드 백업파일을 삭제합니다."
		show_then_view "OUTRC=\$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_YOIL}/${file_name}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
		show_then_view "#"
	done
else
	showno="4b" ; showqq="클라우드에는 오늘날짜 백업파일이 없습니다."
	show_then_view "#"
fi
# echo ">>>> ^C" ; read a

showno="5" ; showqq="오늘날짜 로컬 백업파일을 삭제합니다."
show_then_run "rm -f ${LOCAL_YOIL}/*${yoil_sql_7z}"

showno="6" ; showqq="DB 를 로컬에 백업합니다."
ymd_hm=$(date +"%y%m%d%a-%H%M") #-- ymd_hm=$(date +"%y%m%d-%H%M%S")
#xxx pswd_code="${DB_NAME}${ymd_hm:0:6}" #-- kaosorder2/gate242/wiki + 991231 xxx crontab 으로 실행하므로 보안상 비번을 제외한다.
if [ "x${DB_TYPE}" = "xmysql" ]; then
	show_then_run "/usr/bin/mysqldump --login-path=${LOGIN_PATH} --column-statistics=0 ${DB_NAME} | 7za a -mx=9 -si ${LOCAL_YOIL}/${YOIL_sql7z} -p${PSWD_GEN_CODE}"
else
if [ "x${DB_TYPE}" = "xpgsql" ]; then
	show_then_run "sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -mx=9 -si ${LOCAL_YOIL}/${YOIL_sql7z} -p${PSWD_GEN_CODE}"
else
	cat <<__EOF__

${cYellow}${DB_TYPE} ${cMagenta}[ DB_TYPE ] 을 지정하지 않았으므로 작업을 끝냅니다.${cReset}
__EOF__
	exit -1
fi
fi

OUTRC=$(/usr/bin/rclone copy ${LOCAL_YOIL}/${YOIL_sql7z} ${RCLONE_NAME}:${REMOTE_YOIL}/)
showno="7" ; showqq="로컬 DB 백업파일을 클라우드로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${LOCAL_YOIL}/${YOIL_sql7z} ${RCLONE_NAME}:${REMOTE_YOIL}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"


showno="8" ; showqq="${REMOTE_YOIL} 월 최근 일주일 백업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


#<---- REMOTE / 2022 / 08 / 최근 1주일치

#----> REMOTE / 2022 / 당월 최종 1개


show_title "${REMOTE_YOIL} 월의 마지막 백업파일을 ${REMOTE_YEAR} 년도로 복사 시작 (${ymd_hm})"


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
		show_then_view "OUTRC=\$(/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_YOIL}/${file_name}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"
	done
else
	showno="10b" ; showqq="클라우드에는 ${this_wol}월 백업파일이 없습니다."
	show_then_view "#"
fi

showno="11" ; showqq="오늘날짜 로컬 백업파일을 삭제합니다."
show_then_run "rm -f ${LOCAL_THIS_YEAR}/*${this_wol_sql_7z}"



showno="12" ; showqq="${REMOTE_YOIL} 월 백업파일을 ${REMOTE_YEAR} 년도로 복사하는 작업을 시작합니다. (${ymd_hm})"
show_then_view "#"


showno="13" ; showqq="로컬 디렉토리의 월 백업파일을 년도로 복사합니다."
show_then_run "cp ${LOCAL_YOIL}/${YOIL_sql7z} ${LOCAL_THIS_YEAR}/${WOL_sql7z}"

OUTRC=$(/usr/bin/rclone copy ${LOCAL_THIS_YEAR}/${WOL_sql7z} ${RCLONE_NAME}:${REMOTE_YEAR}/)
showno="14" ; showqq="${this_wol}월 백업파일을 ${this_year}년도 폴더로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${LOCAL_THIS_YEAR}/${WOL_sql7z} ${RCLONE_NAME}:${REMOTE_YEAR}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

OUTRC=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR})
showno="15" ; showqq="폴더 확인"
show_then_view "OUTRC=\$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR}) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

showno="16" ; showqq="${REMOTE_YOIL} 월 백업파일을 ${REMOTE_YEAR} 년도로 복사하는 작업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


#<---- REMOTE / 2022 / 당월 최종 1개

#----> REMOTE / 2022 / ju / 매주 주말 1개


#-- JU_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${ju_beonho_sql_7z}

show_title "${REMOTE_YOIL} 월의 마지막 백업파일을 ${REMOTE_JU} 폴더에 J${ju_beonho} 번호로 복사 시작 (${ymd_hm})"


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
show_then_run "rm -f ${LOCAL_JU}/*${ju_beonho_sql_7z}"


showno="20" ; showqq="${ju_beonho_sql_7z} 백업파일을 ${REMOTE_JU} 로 복사하는 작업을 시작합니다. (${ymd_hm})"
show_then_run "cp ${LOCAL_YOIL}/${YOIL_sql7z} ${LOCAL_JU}/${JU_sql7z}"

OUTRC=$(/usr/bin/rclone copy ${LOCAL_JU}/${JU_sql7z} ${RCLONE_NAME}:${REMOTE_JU}/)
showno="21" ; showqq="${this_wol}월 백업파일을 ${REMOTE_JU} 폴더로 복사합니다."
show_then_view "OUTRC=\$(/usr/bin/rclone copy ${LOCAL_JU}/${JU_sql7z} ${RCLONE_NAME}:${REMOTE_JU}/) ${cMagenta}#----${cYellow}${OUTRC}${cMagenta}----"

showno="22a" ; showqq="보관용 로컬 디렉토리 입니다."
show_then_run "ls -lR ${LOCAL_THIS_YEAR}"
showno="22b" ; showqq="원격 디렉토리 입니다."
show_then_run "/usr/bin/rclone lsl ${RCLONE_NAME}:${REMOTE_YEAR}"

showno="23" ; showqq="${REMOTE_YOIL} 월의 마지막 백업파일을 ${REMOTE_JU} 폴더에 J${ju_beonho} 번호로 복사하는 작업을 끝냅니다. (${ymd_hm})"
show_then_view "#"


#<---- REMOTE / 2022 / ju / 매주 주말 1개

# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
# cat <<__EOF__
# ${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
# __EOF__
