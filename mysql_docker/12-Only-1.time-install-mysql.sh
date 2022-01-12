#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0)    # black     COLOR_BLACK     0,0,0
cRed=$(tput bold)$(tput setaf 1)      # red       COLOR_RED       1,0,0
cGreen=$(tput bold)$(tput setaf 2)    # green     COLOR_GREEN     0,1,0
cYellow=$(tput bold)$(tput setaf 3)   # yellow    COLOR_YELLOW    1,1,0
cBlue=$(tput bold)$(tput setaf 4)     # blue      COLOR_BLUE      0,0,1
cMagenta=$(tput bold)$(tput setaf 5)  # magenta   COLOR_MAGENTA   1,0,1
cCyan=$(tput bold)$(tput setaf 6)     # cyan      COLOR_CYAN      0,1,1
cWhite=$(tput bold)$(tput setaf 7)    # white     COLOR_WHITE     1,1,1
cReset=$(tput bold)$(tput sgr0)       # Reset text format to the terminal's default

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1${cReset} $2"
	echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}
cat_and_read () {
	echo "${cYellow}----> ${cGreen}$1${cReset} $2 ${cBlue}- - - press Enter:${cReset}"
	read a ; echo "$(tput cuu 2)"
	echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}- - - press Enter:${cGreen} $1 ${cReset}"
}

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then mkdir "${logs_folder}" ; fi
MEMO="MySQL 도커와 연결하기 전에, 먼저 로컬에 mysql 을 설치합니다."
echo "${cRed}<<<<<<<<<<${cBlue} $0 ||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"

cat_and_run "rpm -qa | grep mysql | sort"
cat_and_run "rpm -qa | grep mariadb | sort"

# cat_and_run "sudo dnf -y install community-mysql-common community-mysql mariadb-config"
cat_and_run "sudo dnf -y install community-mysql-common community-mysql mariadb-common"

cat_and_run "rpm -qa | grep mysql | sort"
cat_and_run "rpm -qa | grep mariadb | sort"

cat_and_run "sudo systemctl enable docker"
cat_and_run "sudo systemctl start docker"

touch "${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__${CMD_NAME}"
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
