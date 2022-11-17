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

db_sql_7z=""
db_7z_dir=""
if [ "x$1" != "x" ]; then
	db_sql_7z=`basename $1` # 명령줄에서 실행 프로그램 이름만 꺼냄
	db_7z_dir=${1%/$db_sql_7z} # 실행 이름을 빼고 나머지 디렉토리만 담음
	if [ "x$db_7z_dir" == "x" ] || [ "x$db_7z_dir" == "x$db_sql_7z" ]; then
		db_7z_dir="."
	fi
fi

if [ "x${db_sql_7z}" = "x" ]; then
	echo "${cRed}!!!! ${cMagenta}----> db_sql_7z ${cReset}${db_sql_7z}${cMagenta}; db_7z_dir ${cReset}${db_7z_dir}${cBlue}; 파일이 없습니다.${cReset}"
	exit 0
fi

if [ ! -f ${1} ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cReset}${1} ${cBlue}파일이 없습니다.${cReset}"
	exit 0
fi

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="DB ${db_sql_7z} 업로드"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
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

#----

numArray=( a ) #-- 배열로 선언하고, [0]의 값을 'a' 로 지정한다.
CNT=1
ViewRange="${cRed}[ ${cReset}1 ${cRed}]${cReset}"

for out in $(sudo docker ps -a | awk '{print $NF}')
do
	if [ "x$out" != "xNAMES" ]; then
		DB_IP=$(sudo docker inspect ${out} | grep '"IPAddress"' | tail -n 1 | awk -F : '{print $2}' | awk -F \" '{print $2}')
		numArray[${CNT}]=${out} #-- 배열의 CNT 번째에 담는다.
		echo "${CNT}  ....  ${cGreen}도커 이름: ${cReset}${numArray[$CNT]} ${cGreen}; IP Address: ${cCyan}${DB_IP}${cReset}"
		if [ "x${CNT}" != "x1" ]; then
			ViewRange="${cRed}[ ${cReset}1 ${cRed}]${cReset} ... ${CNT}"
		fi
		CNT=$(( ${CNT} + 1 ))
	fi
done
CNT=$(( ${CNT} - 1 ))

cat <<__EOF__

${cYellow}----> ${cGreen}/etc/host 에 지정하려는 도커 이름의 ${cReset}번호${cGreen}를 선택하세요: ${cCyan}( ${ViewRange} ${cCyan})${cReset}
__EOF__
read a ; echo "${cUp}"
if [[ "x$a" < "x1" ]]; then
	DOCKER_NAME=${numArray[1]}
	a="1"
else
if [[ "x$a" > "x${CNT}" ]]; then
	DOCKER_NAME=${numArray[1]}
	a="1"
else
	DOCKER_NAME=${numArray[${a}]}
fi
fi

#----

L_P_DEFAULT="Login PATH 를 입력해 주세요"
U_N_DEFAULT="사용자 이름을 입력해 주세요"
D_N_DEFAULT="db 이름을 입력해 주세요"
if [ "x${DOCKER_NAME}" = "xksammy" ]; then
	LOGIN_PATH=ksamlog
	USER_NAME=ksamroot
	DB_NAME=ksam21
else
if [ "x${DOCKER_NAME}" = "xgatedb" ]; then
	LOGIN_PATH=swlog
	USER_NAME=gateroot
	DB_NAME=gate242
else
if [ "x${DOCKER_NAME}" = "xkordmy" ]; then
	LOGIN_PATH=kordlog
	USER_NAME=kordroot
	DB_NAME=kaosorder2
else
	LOGIN_PATH="${L_P_DEFAULT}"
	USER_NAME="${U_N_DEFAULT}"
	DB_NAME="${D_N_DEFAULT}"
fi
fi
fi

#----

cat <<__EOF__
${cRed}[ ${cReset}${a} ${cRed}]${cReset} ${cCyan}${DOCKER_NAME}${cReset}

${cYellow}----> ${cCyan}${DOCKER_NAME} ${cGreen}의 로그인 PATH 입력: ${cRed}[ ${cReset}${LOGIN_PATH} ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" != "x" ]; then
	LOGIN_PATH=$a
fi

#----

cat <<__EOF__
${cRed}[ ${cYellow}${LOGIN_PATH} ${cRed}] -OK-${cReset}

${cYellow}----> ${cCyan}${DOCKER_NAME} ${cGreen}의 user name 입력: ${cRed}[ ${cReset}${USER_NAME} ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" != "x" ]; then
	USER_NAME=$a
fi

#----

cat <<__EOF__
${cRed}[ ${cYellow}${USER_NAME} ${cRed}] -OK-${cReset}

${cYellow}----> ${cCyan}${DOCKER_NAME} ${cGreen}의 db name 입력: ${cRed}[ ${cReset}${DB_NAME} ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" != "x" ]; then
	DB_NAME=$a
fi
cat <<__EOF__
${cRed}[ ${cYellow}${DB_NAME} ${cRed}] -OK-${cReset}

__EOF__


# a=$(basename ${db_sql_7z})
# sql_db=${a:0:-3} # -3 = 끝에서 거꾸로 3 글자 (.7z) 제외함.

# ----------

cat <<__EOF__
+---+
| 1 | (db 를 업로드하기 전에), 현재의 db 를 백업하기 위해 다운로드 한다.
+---+
----> 백업을 하지 않으려면, 'x' 를 눌러 주세요.
__EOF__
read a ; echo "${cUp}"
echo "${cRed}[ ${cYellow}${a} ${cRed}]${cReset}"
last_skip="no"
if [ "x$a" = 'xx' ]; then
	cat <<__EOF__






${cRed}!!!! 주의 !!!! 현재의 데이터를 다운로드 + 백업하지 않고, 업로드 합니다.${cReset}

----> press 'y' Enter:
__EOF__
	read a ; echo "${cUp}"
	echo "${cRed}[ ${cYellow}${a} ${cRed}]${cReset}"
	if [ "x$a" != "xy" ]; then
		exit 1
	fi
	last_skip="yes"
fi

if [ "x${last_skip}" = "xno" ]; then
	ding_play 6 #-- 1=띠잉~ 2=뗑-~ 3=데에엥~~ 4=캐스터네츠 5=교회차임 6=딩~
	NOW_UNAME=$(date +"%y%m%d-%H%M%S")_$(uname -n)
	cat_and_run "time /usr/bin/mysqldump --login-path=${LOGIN_PATH} --column-statistics=0 ${DB_NAME} | 7za a -mx=9 -si ${db_7z_dir}/last-${DB_NAME}_${NOW_UNAME}.sql.7z" "#--> 현재 db 를 백업하기"

	cat_and_run "ls -hltr --color ${db_7z_dir}/${DB_NAME}_*.sql.7z | tail -10"
fi

cat <<__EOF__
+---+
| 2 | db 를 업로드 합니다. ${cRed} 백업할때 입력한 ${cYellow}비밀번호${cRed}를 입력하세요.${cReset}
+---+
__EOF__

ding_play 6 #-- 1=띠잉~ 2=뗑-~ 3=데에엥~~ 4=캐스터네츠 5=교회차임 6=딩~
cat_and_run "time 7za x -so ${1} | mysql --login-path=${LOGIN_PATH} -si ${DB_NAME}" "백업받았던 db 를 ${DB_NAME} 에 풀기"

cat <<__EOF__
+---+
| 3 | 업로드한 db 를 확인한다.
+---+
__EOF__

if [ "x${DOCKER_NAME}" = "xksammy" ]; then
	echo "${cYellow}----> ${DOCKER_NAME} ${cGreen}의 확인 스크립트가 준비되지 않았습니다."
else
if [ "x${DOCKER_NAME}" = "xgatedb" ]; then
	ding_play 6 #-- 1=띠잉~ 2=뗑-~ 3=데에엥~~ 4=캐스터네츠 5=교회차임 6=딩~
	cat_and_run "mysql --login-path=${LOGIN_PATH} ${DB_NAME} -vvv -e \"select concat(min(id),' / ',max(id)) as id, concat(min(y4mmdd),' / ',max(y4mmdd)) as y4mmdd, concat(min(workday),' / ',max(workday)) as workday, count(*) as 'rowis 4 only' from gt_wonjang where rowis=4 ; select concat(min(id),' / ',max(id)) as id, concat(min(y4mmdd),' / ',max(y4mmdd)) as y4mmdd, concat(min(workday),' / ',max(workday)) as workday, count(*) as 'total count' from gt_wonjang\""
	ding_play 4 #-- 1=띠잉~ 2=뗑-~ 3=데에엥~~ 4=캐스터네츠 5=교회차임 6=딩~
else
if [ "x${DOCKER_NAME}" = "xkordmy" ]; then
	echo "${cYellow}----> ${DOCKER_NAME} ${cGreen}의 확인 스크립트가 준비되지 않았습니다."
fi
fi
fi

touch "${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
