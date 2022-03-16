#!/bin/sh

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi

cat <<__EOF__

----> curl -s "https://get.sdkman.io" | bash

source ~/.bashrc #-- 설치한 sdkman 을 적용합니다.

__EOF__

curl -s "https://get.sdkman.io" | bash
source ~/.bashrc

touch "${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; ls --color ${logs_folder}
