#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
       echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
       echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
}
title_begin () {
	echo "${cCyan}----> ${cRed}$1${cReset}"
}
title_end () {
	echo "${cBlue}<---- ${cMagenta}$1${cReset}"
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
       CMD_DIR="."
fi
MEMO="호스트 이름을 바꿉니다."
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----


title_begin "호스트 이름 바꾸기"
HOSTNAME=$(hostname)
cat <<__EOF__
${cCyan}----> 호스트 이름을 바꾸려면 입력하세요: ${cRed}[${cYellow} ${HOSTNAME} ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" = "x" ]; then
	echo "= ${cRed}${HOSTNAME}${cReset} ="
else
	echo "= ${cRed}${a}${cReset} ="
	cat_and_run "sudo hostnamectl set-hostname $a" "호스트 이름을 $a 로 지정합니다."
fi
title_end "호스트 이름 바꾸기"


# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
