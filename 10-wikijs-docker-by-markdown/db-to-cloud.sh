#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${HOME}/lib/color_base #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp
# ~/lib/color_base 220827-0920 cat_and_run cat_and_run_cr cat_and_read cat_and_readY view_and_read show_then_run show_then_view show_title value_keyin () {

MEMO="cron job"
## echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
#--xx-- zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cat_and_run "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
#--xx-- zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
#----


this_year=$(date +%Y) #-- 2022
this_wol=$(date +%m) #-- 07
ymd_hm=$(date +"%y%m%d%a-%H%M") #-- ymd_hm=$(date +"%y%m%d-%H%M%S")
pswd_ym=$(date +"%y%m")

yoil_number1to7=$(date +%u) #------------ 월1 화2 수3 목4 금5 토6 일7
# yoil_atog=$(echo "abcdefg" | cut -c ${yoil_number1to7}) #---- 요일 a...g 일...토 #-- XX
ju_beonho=$(date +%V) #-- 1년중 몇번째 주인지 표시. V: 월요일마다 하나씩 증가한다. U: 1월1일=일요일: 01, 아니면: 00. 일요일마다 하나씩 증가한다.

#|  cat date.sh #-- 주 표시 보여주기 스크립트
#|  
#|  #!/bin/sh
#|  
#|  echo "date --date='31 Dec 2020' +\"U_%U  %Y-%m-%d %a  V %V\""
#|  echo ""
#|  
#|  for day in 26 27 28 29 30 31
#|  do
#|  	date --date="${day} Dec 2020" +"U_%U  %Y-%m-%d %a  V %V"
#|  done
#|  
#|  for day in 1 2 3 4 5 6
#|  do
#|  	date --date="${day} Jan 2021" +"U_%U  %Y-%m-%d %a  V %V"
#|  done
#|  
#|  sh date.sh #-- 주 표시 보여주기
#|  
#|  date --date='31 Dec 2020' +"U_%U  %Y-%m-%d %a  V %V"
#|  
#|  U_51  2020-12-26 토  V 52
#|  U(52) 2020-12-27 일  V 52
#|  U_52  2020-12-28 월  V(53)
#|  U_52  2020-12-29 화  V 53
#|  U_52  2020-12-30 수  V 53
#|  U_52  2020-12-31 목  V 53
#|  
#|  U(00) 2021-01-01 금  V 53
#|  U_00  2021-01-02 토  V 53
#|  U(01) 2021-01-03 일  V 53
#|  U_01  2021-01-04 월  V(01)
#|  U_01  2021-01-05 화  V 01
#|  U_01  2021-01-06 수  V 01

#|  %U=일...토 의 주 번호, 1월의 첫날이 일요일이 아니면 그 주의 순서 번호는 00 이 된다.
#|  
#|  |일 |월 |화 |수 |목 |금| 토 | %U 일요일 기준 |
#|  |:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|
#|  |29 |30 |31 |1  |2  |3  |4  |<-- 12월과 1월 |
#|  |52 |52 |52 |00 |00 |00 |00 |<-- U |
#|  |5  |6  |7  |8  |9  |10 |11 |<-- 12월과 1월 |
#|  |01 |01 |01 |01 |01 |01 |01 |<-- U |
#|  
#|  %V=월요일부터 일요일까지의 주 번호, 1월 1일부터 주의 순서가 01 이 되고, 그 이전은 작년 말일의 주의 순서를 따른다.
#|  
#|  |일 |월 |화 |수 |목 |금| 토 | %V 월요일 기준 |
#|  |:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|
#|  |29 |30 |31 |1  |2  |3  |4  |<-- 12월과 1월 |
#|  |52 |01 |01 |01 |01 |01 |01 |<-- V |
#|  |5  |6  |7  |8  |9  |10 |11 |<-- 12월과 1월 |
#|  |01 |02 |02 |02 |02 |02 |02 |<-- V |
#|  
#|  일요일 대신에 월요일을 주의 첫날로 두면 이해하기 쉽다.
#|  
#|  |   |월 |화 |수 |목 |금| 토| 일| %V 월요일 기준 |
#|  |:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|---|
#|  |   |30 |31 |1  |2  |3  |4  |5  |<-- 12월과 1월 |
#|  |   |01 |01 |01 |01 |01 |01 |01 |<-- V |
#|  |   |6  |7  |8  |9  |10 |11 |12 |<-- 12월과 1월 |
#|  |   |02 |02 |02 |02 |02 |02 |02 |<-- V |


#|  #-- ubuntu 22.04 에서 /etc/sudoers.d 디렉토리 밑에 사용자의 권한을 지정하는 내용을  proenpi 사용자 이름으로 만든다.
#|  
#|  proenpi@proenpi-4b:~$ echo "proenpi  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/proenpi
#|  [sudo] proenpi 암호:
#|  proenpi  ALL=(ALL) NOPASSWD:ALL
#|  
#|  #-- 파일이 만들어졌는지 내용을 확인한다.
#|  
#|  proenpi@proenpi-4b:~$ cat /etc/sudoers.d/
#|  README   proenpi
#|  proenpi@proenpi-4b:~$ cat /etc/sudoers.d/proenpi
#|  proenpi  ALL=(ALL) NOPASSWD:ALL
#|  proenpi@proenpi-4b:~$ sudo whoami
#|  root
#|  
#|  #-- root 권한으로 만들어졌으므로, 압호를 넣지 않고 sudo 로 명령하는 사용자의 스크립트를 쓸수 있다.
#|  
#|  proenpi@proenpi-4b:~$ crontab -l
#|  #--분--시--일--월--요일 (0:일 1:월 2:화 … 6:토)   명령어
#|  01  12  *  *  *  /bin/sh /home/proenpi/backup/wiki.js/db-to-cloud.sh wiki >/dev/null 2>&1
#|  02  17  *  *  *  /bin/sh /home/proenpi/backup/wiki.js/db-to-cloud.sh wiki >/dev/null 2>&1
#|  03  22  *  *  *  /bin/sh /home/proenpi/backup/wiki.js/db-to-cloud.sh wiki >/dev/null 2>&1

#|  13:26:35목22-08-25 yosjn@g1ssd128 ~/backup/gatedb
#|  gatedb $ crontab -l
#|  # Example of job definition:
#|  # .---------------- minute (0 - 59)
#|  # |   .------------- hour (0 - 23)
#|  # |   |    .--------- day of month (1 - 31)
#|  # |   |    |  .------- month (1 - 12) OR jan,feb,mar,apr ...
#|  # |   |    |  |  .----- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
#|  # |   |    |  |  |
#|  # *   *    *  *  *    command to be executed
#|  # *   *    *  *  *    # DB backup to cloud
#|  # 15  12,19    *  *  *    /bin/sh /home/vbox/gdrive/999-rclone-yossc-download.sh
#|  # 02  6,12,21 *  *  1-6  /bin/sh /root/bin/1-bin-scripts/002-swtire60-db-to-dropbox.sh
#|  # 12  12,15,18,21   *  *  *    /bin/sh /root/bin/1-bin-scripts/035-gmail-copyto-db.sh 1
#|  # 12  0,3,6,9       *  *  *    /bin/sh /root/bin/1-bin-scripts/035-gmail-copyto-db.sh 2
#|  # 42  18    *  *  *    /bin/sh /root/bin/1-bin-scripts/035-gmail-copyto-db.sh 7
#|  # 58  12  11  02  *    /bin/sh /root/bin/1-bin-scripts/021-bbox-ftp-main.sh
#|  # *   *    *  *  *
#|  #xxx 10    22   *  *  *    /bin/sh /home/vbox/gdrive/backup-gate242db.sh
#|  # *   *    *  *  *
#|  01  22  *  *  *  /bin/sh /home/yosjn/backup/gatedb/db-to-cloud.sh gatedb >/dev/null 2>&1
#|  13:26:42목22-08-25 yosjn@g1ssd128 ~/backup/gatedb
#|  gatedb $ 

#|  13:42:32목22-08-25 yosjn@g1ssd128 ~/backup/gatedb
#|  gatedb $ ls -l
#|  합계 36
#|  drwxr-xr-x. 4 yosjn yosjn  4096  8월 25 13:37 2022
#|  -rw-rw-r--. 1 yosjn yosjn  2230  8월 25 13:28 color_base
#|  -rw-rw-r--. 1 yosjn yosjn 28037  8월 25 13:33 db-to-cloud.sh
#|  13:42:37목22-08-25 yosjn@g1ssd128 ~/backup/gatedb
#|  gatedb $ 


if [ "x$1" = "x" ]; then
	cat <<__EOF__
#-- 1		2		3		4		5		6	-not use-
#-- DB_NAME	DB_LOGIN_PATH	LOCAL_FOLDER	REMOTE_FOLDER	RCLONE_NAME	OK?	DB_USER_NAME
#-- kaosorder2	kaoslog		backup/kaosdb	11-kaosorder	kngc		ok/""	kaosorder2 (카오스)
#-- gate242	swlog		backup/gatedb	11-gate242	swlgc		ok/""	gateroot (서원)
#-- wiki	-not use-	backup/wikidb	11-wiki.js	yosgc		ok/""	wiki (wiki.js)
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
	LOCAL_FOLDER="/home/backup/kaosdb" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="11-kaosorder" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="kngc" #-- rclone 이름 kaos.notegc
	DB_TYPE="mysql"
	PSWD_GEN_CODE="zkdhtm${pswd_ym}"
else
if [ "x$1" = "xgate242" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="swlog" #-- 데이터베이스 로그인 패쓰
	LOCAL_FOLDER="/home/backup/gatedb" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="11-gate242" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="swlgc" #-- rclone 이름 seowontire.libgc
	DB_TYPE="mysql"
	PSWD_GEN_CODE="tjdnjs${pswd_ym}"
else
if [ "x$1" = "xwiki" ]; then
	DB_NAME="$1" #-- 백업할 데이터베이스 이름
	LOGIN_PATH="wikipsql" #-- 데이터베이스 로그인 패쓰 ;;; pgsql 이라서 쓰지는 않음.
	LOCAL_FOLDER="/home/backup/wikidb" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
	REMOTE_FOLDER="11-wiki.js" #-- 원격 저장소의 첫번째 폴더 이름
	RCLONE_NAME="yosgc" #-- rclone 이름 yosjeongc
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

	value_keyin "LOCAL_FOLDER" "${LOCAL_FOLDER}" "백업파일을 임시로 저장할 로컬 저장소의 디렉토리 이름을 입력하세요."
	LOCAL_FOLDER="${return_value}"

	value_keyin "REMOTE_FOLDER" "${REMOTE_FOLDER}" "원격 저장소의 첫번째 폴더 이름을 입력하세요."
	REMOTE_FOLDER="${return_value}"

	value_keyin "RCLONE_NAME" "${RCLONE_NAME}" "rclone 이름을 입력하세요."
	RCLONE_NAME="${return_value}"

fi

if [ ! -d ${LOCAL_FOLDER} ];then
	showno="0" ; showqq="보관용 로컬 디렉토리를 만듭니다."
	show_then_run "sudo mkdir -p ${LOCAL_FOLDER} ; sudo chown ${USER}.${USER} ${LOCAL_FOLDER}"
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
	show_then_run "mkdir -p ${LOCAL_YOIL}"
fi
if [ ! -d ${LOCAL_JU} ]; then
	showno="1b" ; showqq="보관용 로컬 디렉토리를 만듭니다."
	show_then_run "mkdir -p ${LOCAL_JU}"
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
	show_then_run "/usr/bin/mysqldump --login-path=${LOGIN_PATH} --column-statistics=0 ${DB_NAME} | 7za a -si ${LOCAL_YOIL}/${YOIL_sql7z} -p${PSWD_GEN_CODE}"
else
if [ "x${DB_TYPE}" = "xpgsql" ]; then
	show_then_run "sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${LOCAL_YOIL}/${YOIL_sql7z} -p${PSWD_GEN_CODE}"
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

#--xx-- rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
#--xx-- cat_and_run "ls --color ${1}" "프로그램들" ; ls --color ${zz00logs_folder}
## echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
