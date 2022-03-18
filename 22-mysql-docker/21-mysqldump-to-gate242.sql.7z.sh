#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	if [ "x${cnr_freepass_all}" = "xall" ]; then # <-- 스크립트로 실행하는중, 묻지않고 지나감.
		echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cRed} ---free-pass---${cReset}"
	else if [ "x${cnr_enter_or_yes}" = "xenter" ]; then # <-- 엔터키만 받고 넘어감.
		echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cYellow}" ; echo "- - - Enter please:${cReset}" ; read a ; echo "${cUp}"
	else if [ "x${cnr_enter_or_yes}" = "xyes" ]; then # <-- "y" 인 경우만 진행함.
		echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cYellow}" ; echo "- - - press ${cRed}y${cYellow} or Enter:${cReset}"; read a; echo "${cUp}"
		if [ "x$a" != "xy" ]; then cnr_no_running="ok" ; echo "${cRed}-OK-${cReset}" ; fi
	else echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"
	fi ; fi ; fi
	if [ "x${cnr_no_running}" = "xok" ]; then
		echo "${cRed}[${cYellow} $1 ${cRed}]${cMagenta} --- 를 실행하지 않습니다.${cReset}"
	else
		if [ "x${cnr_GraiLs_Feed}" = "xok" ]; then echo "#" ; fi
		#-- echo "$1" | sh --> 따옴표 있는것을 처리한다. 대신 cd 등은 실행이 돼도, 나가면 반영되지 않는다.
		#-- $1 --> 따옴표가 없는 것만 처리한다. 대신 cd 등을 실행하면, 다음번에도 반영이 된다.
		if [ "x${cnr_no_quote}" = "xok" ]; then $1
		else echo "$1" | sh
		fi
	       	echo "${cRed}<---- ${cBlue}$1 ${cMagenta}$2${cReset}"
	fi
	clear_cnr_value #-- Cat_N_Run 초기화
}
clear_cnr_value () {
	cnr_freepass_all="" # "all" <-- 스크립트로 쓰기위해 묻지않고 지나감.
	cnr_enter_or_yes="" # "enter" <-- 엔터만 치면 넘어감, "yes" <-- "y" 를 눌러야 실행하고, 아니면 실행 안하고 넘어감.
	cnr_no_running="" # "ok" <-- yes/no 에서 'y' 가 아닌경우임.
	cnr_no_quote="" # "ok" <-- 따옴표 --없는-- 것만 처리한다. cd 등이 계속 반영이 된다.
	cnr_GraiLs_Feed="" # "ok" <-- grails 2 에서 줄바꿈 안되는 것 때문에 처리함.
	cnr_no_yes_no="" # "ok" <-- yes/no 입력받지 않고 그냥 실행.
}
cat_and_enter () {
	cnr_enter_or_yes="enter" ; cat_and_run "$1" "$2"
}
cat_and_yes () {
	cnr_enter_or_yes="yes" ; cat_and_run "$1" "$2"
}
cat_and_noq () { #-- 따옴표 없는것 처리는 이것 한가지임.
	cnr_no_quote="ok" ; cat_and_run "$1" "$2"
}
cat_and_gf () {
	cnr_GraiLs_Feed="ok" ; cat_and_run "$1" "$2"
}
cat_and_gf_enter () {
	cnr_enter_or_yes="enter" ; cnr_GraiLs_Feed="ok" ; cat_and_run "$1" "$2"
}
cat_and_gf_yes () {
	cnr_enter_or_yes="yes" ; cnr_GraiLs_Feed="ok" ; cat_and_run "$1" "$2"
}
ding_play () {
	if [ "x$PLAY_OK" = "xok" ]; then #-- play 설치가 된 경우,
		if [ "x$1" = "x1" ]; then play -q ~/bin/1-bin-scripts/freesound/91926__tim-kahn__ding.wav & #---- x1=딩~
		else if [ "x$1" = "x2" ]; then play -q ~/bin/1-bin-scripts/freesound/411459__inspectorj__castanets-multi-a-h1.wav & #---- x2=캐스터네츠~
		else if [ "x$1" = "x3" ]; then play -q ~/bin/1-bin-scripts/freesound/339816__inspectorj__hand-bells-f-single.wav & #---- x3=뗅-
		else if [ "x$1" = "x4" ]; then play -q ~/bin/1-bin-scripts/freesound/212541__misstickle__indian-bell-chime.wav & #---- x4=띠일~
		else if [ "x$1" = "x5" ]; then play -q ~/bin/1-bin-scripts/freesound/411090__inspectorj__wind-chime-gamelan-gong-a.wav & #---- x5=데에엥~~
		else play -q ~/bin/1-bin-scripts/freesound/513865__wormletter__chime-c.wav & #---- x6=교회 뎅-
		fi ; fi ; fi ; fi ; fi
	else
		echo "${cRed}play-${1}${cReset}"
	fi
}
clear_cnr_value #-- Cat_N_Run 초기화
PLAY_OK="-NO-" # "ok" <-- play 설치가 된 경우,
# ding_play 1 #-- 1=딩~ 2=캐스터네츠~ 3=뗅- 4=띠일~ 5=데에엥~~ 6=교회 뎅-

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="데이터베이스 백업하기"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

cat <<__EOF__
----> play 를 사용하려면 'y' 를 누르세요:
__EOF__
read a ; echo "${cUp}"
if [ "x$a" = "xy" ]; then
	PLAY_OK="ok" # "ok"=play 설치가 된 경우,
	echo "play ${cRed}-OK-${cReset}"
else
	PLAY_OK="XXXok" # "ok"=play 설치가 된 경우,
	echo "good ${cGreen}-silence-${cReset}"
fi

# - - - - - - - - - - - - - - -

cat_and_run "mysql_config_editor print --all"

cat <<__EOF__

${cRed}[${cYellow} 1 ${cRed}]${cReset}....  swlog
  2  ....  ksamlog

----> login-path 선택: (1...2)  (또는 직접 입력)  ${cRed}[${cYellow} 1 ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"

if [ "x$a" = "x1" ]; then
	LOGINPATH_NAME=swlog
else if [ "x$a" = "x2" ]; then
	LOGINPATH_NAME=ksamlog
else if [ "x$a" = "x" ]; then
	#--- 엔터의 경우, default
	LOGINPATH_NAME=swlog
else
	#--- 나머지 경우, 입력으로 처리.
	LOGINPATH_NAME=$a
fi
fi
fi

# - - - - - - - - - - - - - - -

cat <<__EOF__
${cRed}[${cYellow} ${LOGINPATH_NAME} ${cRed}] -OK-${cReset}

${cRed}[${cYellow} 1 ${cRed}]${cReset}....  gate242
  2  ....  ksam21
  3  ....  kaosorder2

----> db 선택: (1...3)  (또는 직접 입력)  ${cRed}[${cYellow} 1 ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"

if [ "x$a" = "x1" ]; then
	DB_NAME=gate242
else if [ "x$a" = "x2" ]; then
	DB_NAME=ksam21
else if [ "x$a" = "x3" ]; then
	DB_NAME=kaosorder2
else if [ "x$a" = "x" ]; then
	#--- 엔터의 경우, default
	DB_NAME=gate242
else
	#--- 나머지 경우, 입력으로 처리.
	DB_NAME=$a
fi
fi
fi
fi

cat <<__EOF__
alter table faximage add     file_dir   varchar(255) ;
alter table sec_user modify  carno      null ; -- 컬럼 내역변경
alter table bill     change  billy4mmdd billy2mmdd varchar(255) null ; -- 컬럼 이름까지 변경
alter table faximage drop    file_size ;
alter table markdb   rename  markworkingdb ;

__EOF__

# - - - - - - - - - - - - - - -

echo "${cRed}[${cYellow} ${DB_NAME} ${cRed}] -OK-${cReset}"

uname_n=$(uname -n)
HOST_DIR=${HOME}/bada-mega_yssc #-- 이 폴더는 $(ln -s /media/sf_Downloads/bada/ ~/bada-mega_yssc) 명령으로 미리 만들어놔야 한다.
BACKUP_DIR=${HOST_DIR}/01-gate242-sql.7z #-- 엑셀파일=02-gukdong-allbaro-xls

if [ ! -d ${BACKUP_DIR} ]; then
	cat_and_run "mkdir -p ${BACKUP_DIR}"
fi
db_ALL_sql7z=${DB_NAME}_*.sql.7z
if [[ -f ${BACKUP_DIR}/${db_ALL_sql7z} ]]; then
	cat_and_run "ls -hltr --color ${BACKUP_DIR}/${db_ALL_sql7z} | tail -10" "보관중인 백업파일"
fi

ding_play 6 #-- 1=띠잉~ 2=뗑-~ 3=데에엥~~ 4=캐스터네츠 5=교회차임 6=딩~

db_now_sql_7z=${DB_NAME}_$(date +"%y%m%d-%H%M%S")_${uname_n}.sql.7z

# cat_and_run "time /usr/bin/mysqldump --login-path=${LOGINPATH_NAME} --column-statistics=0 ${DB_NAME} | 7za a -si ${BACKUP_DIR}/${db_now_sql_7z}" "db 백업받기"
# BACKUP_DIR 을 MEGA Cloud 로 쓰는 경우, 파일이 생성되면서 클라우드에 실시간 저장이 되어서
# 한단계 아래인 HOST_DIR 에 저장을 먼저 하고, 저장이 끝난 다음에 BACKUP_DIR 로 옮기도록 하였다.
cat_and_run "time /usr/bin/mysqldump --login-path=${LOGINPATH_NAME} --column-statistics=0 ${DB_NAME} | 7za a -si ${HOST_DIR}/${db_now_sql_7z}" "db 백업받기"
cat_and_run "mv ${HOST_DIR}/${db_now_sql_7z} ${BACKUP_DIR}/${db_now_sql_7z}" "백업파일을 클라우드 연결점인 최종 위치로 옮김"

cat_and_run "ls -hltr --color ${BACKUP_DIR}/${DB_NAME}_*.sql.7z | tail -10" "새로 만들어진 백업파일"

ding_play 4 #-- 1=띠잉~ 2=뗑-~ 3=데에엥~~ 4=캐스터네츠 5=교회차임 6=딩~

# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
