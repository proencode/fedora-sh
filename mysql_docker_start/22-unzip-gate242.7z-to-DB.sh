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

# ----------
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
clear_cnr_value #-- Cat_N_Run 초기화
PLAY_OK="-NO-" # "ok" <-- play 설치가 된 경우,
# ding_play 1 #-- 1=딩~ 2=캐스터네츠~ 3=뗅- 4=띠일~ 5=데에엥~~ 6=교회 뎅-
MEMO="데이터베이스 백업하기"
# ----------

cat <<__EOF__

${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}
출처: yosjeon@gmail.com

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

${cRed}[${cYellow} 1 ${cRed}]${cReset}.... ksamlog
  2  .... gatelog

----> login-path 선택: (1...2)  (또는 직접 입력)  ${cRed}[${cYellow} 1 ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"

if [ "x$a" = "x1" ]; then
	LOGINPATH_NAME=ksamlog
else if [ "x$a" = "x2" ]; then
	LOGINPATH_NAME=gatelog
else if [ "x$a" = "x" ]; then
	#--- 엔터의 경우, default
	LOGINPATH_NAME=ksamlog
else
	#--- 나머지 경우, 입력으로 처리.
	LOGINPATH_NAME=$a
fi
fi
fi

# - - - - - - - - - - - - - - -

cat <<__EOF__
${cRed}[${cYellow} ${LOGINPATH_NAME} ${cRed}] -OK-${cReset}

${cRed}[${cYellow} 1 ${cRed}]${cReset}.... ksam21
  2  .... gate242
  3  .... kaosorder2

----> db 선택: (1...3)  (또는 직접 입력)  ${cRed}[${cYellow} 1 ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"

if [ "x$a" = "x1" ]; then
	DB_NAME=ksam21
else if [ "x$a" = "x2" ]; then
	DB_NAME=gate242
else if [ "x$a" = "x3" ]; then
	DB_NAME=kaosorder2
else if [ "x$a" = "x" ]; then
	#--- 엔터의 경우, default
	DB_NAME=ksam21
else
	#--- 나머지 경우, 입력으로 처리.
	DB_NAME=$a
fi
fi
fi
fi

# - - - - - - - - - - - - - - -

echo "${cRed}[${cYellow} ${DB_NAME} ${cRed}] -OK-${cReset}"

uname_n=$(uname -n)
HOME_UNAME_N="../${uname_n}" # ="${HOME}/${uname_n}"

NOW_UNAME=$(date +"%y%m%d-%H%M%S")_${uname_n}

if [ ! -d ${HOME_UNAME_N} ]; then
	cat_and_run "mkdir -p ${HOME_UNAME_N}"
fi
shout=$(ls ${HOME_UNAME_N}/${DB_NAME}_*.sql.7z)
if [[ "x${shout}" != "x" ]]; then
	cat_and_run "ls -hltr --color ${HOME_UNAME_N}/${DB_NAME}_*.sql.7z | tail -10" "보관중인 백업파일"

	cat <<__EOF__

----> 위 목록을 보고, 업로드할 ${cRed}[${cYelow} *.sql.7z ${cRed}]${cReset} 파일이름을 ${cYellow}폴더 이름 ${cRed}[${cYellow} ${HOME_UNAME_N}/ ${cRed}]${cYellow} 까지 포함해서 입력하세요.${cReset}
__EOF__
	read DB_SQL_7Z
	if [ ! -f ${DB_SQL_7Z} ]; then
		cat <<__EOF__

[ $DB_SQL_7Z} ] ${HOME_UNAME_N}/${DB_NAME}_*.sql.7z 파일이 없습니다. 입력한 내용을 확인하세요.
__EOF__
		exit 0
	fi
else
	cat <<__EOF__

${HOME_UNAME_N}/${DB_NAME}_*.sql.7z 파일이 없습니다.
__EOF__
	exit 0
fi

a=$(basename ${DB_SQL_7Z})
sql_db=${a:0:-3} # -3 = 끝에서 거꾸로 3 글자 제외함.

# ----------

cat <<__EOF__

1. (db 를 업로드하기 전에), 현재의 db 를 다운로드 한다.${cCyan}
-------------------------------------------------------${cReset}

__EOF__

ding_play 6 #-- 1=띠잉~ 2=뗑-~ 3=데에엥~~ 4=캐스터네츠 5=교회차임 6=딩~
cat_and_run "time /usr/bin/mysqldump --login-path=${LOGINPATH_NAME} --column-statistics=0 ${DB_NAME} | 7za a -si ${HOME_UNAME_N}/${DB_NAME}_${NOW_UNAME}.sql.7z" "${cBlue}현재 db 를 백업하기${cReset}"

cat_and_run "ls -hltr --color ${HOME_UNAME_N}/${DB_NAME}_*.sql.7z | tail -10"

cat <<__EOF__

2. db 를 업로드 한다.${cCyan}
---------------------${cReset}

__EOF__

ding_play 6 #-- 1=띠잉~ 2=뗑-~ 3=데에엥~~ 4=캐스터네츠 5=교회차임 6=딩~
cat_and_run "time 7za x -so ${DB_SQL_7Z} | mysql --login-path=${LOGINPATH_NAME} -si ${DB_NAME}" "${cBlue}백업받았던 db 를 ${DB_NAME} 에 풀기${cReset}"

cat <<__EOF__

3. 업로드한 db 를 확인한다.${cCyan}
---------------------------${cReset}

__EOF__

ding_play 6 #-- 1=띠잉~ 2=뗑-~ 3=데에엥~~ 4=캐스터네츠 5=교회차임 6=딩~
cat_and_run "mysql --login-path=${LOGINPATH_NAME} ${DB_NAME} -vvv -e \"select max(id),max(y4mmdd),max(workday),count(*) from gt_wonjang\""

ding_play 4 #-- 1=띠잉~ 2=뗑-~ 3=데에엥~~ 4=캐스터네츠 5=교회차임 6=딩~
