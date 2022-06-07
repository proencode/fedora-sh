#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
}
cat_and_read () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cGreen}\n----> ${cCyan}press Enter${cReset}:"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cMagenta}$1 $2${cReset}"
}
cat_and_readY () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
	else
		echo "${cGreen}----> ${cRed}press ${cCyan}y${cRed} or Enter${cReset}:"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			echo "${cRed}[ ${cYellow}$1 ${cRed}] ${cCyan}<--- 명령을 실행하지 않습니다.${cReset}"
		fi
		echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cMagenta}$1 $2${cReset}"
	fi
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="backup markdown-files to markdown.7z"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

if [ "x$1" = "x" ]; then
	rm -f ${log_name}
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 프로그램 이름 다음에 ${cCyan}(백업하려는 폴더)${cBlue}를 지정해야 합니다.${cReset}"
	echo "----> ${cYellow}${0} ${cCyan}[ ${cYellow}백업하려는 폴더이름${cCyan} ] 을 입력하세요.${cReset}"
	echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
	exit 1
fi
if [ ! -d "$1" ]; then
	rm -f ${log_name}
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 백업하려는 ${cCyan}($1)${cBlue} 폴더가 없습니다.${cReset}"
	echo "----> ${cYellow}${0} ${cCyan}[ ${cYellow}백업하려는 폴더이름${cCyan} ] 을 입력하세요.${cReset}"
	echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
	exit 1
fi

dir_for_backup="$1"
markdown_7z="markdown-files-$(date +"%y%m%d-%H%M%S")-$(uname -n).7z"

cat_and_read "# 백업하려는 폴더가 ${cReset}'''${cYellow}${dir_for_backup}${cReset}'''" "맞으면 [ 엔터 ]를 눌러서 넘어가세요."
cat_and_read "# 백업을 위해 압축시킨 파일은 현재의 폴더 ( $(pwd) )에 저장합니다." "[ 엔터 ]를 누르세요."

cat_and_read "# 비밀번호를 2번 입력해야 합니다." "[ 엔터 ]를 누르세요."
echo "${cGreen}----> ${cYellow}time 7za a $(pwd)/${markdown_7z} ${dir_for_backup} -p -v3900M ${cCyan}#-- 데이터 백업하기${cReset}"
time 7za a $(pwd)/${markdown_7z} ${dir_for_backup} -p -v3900M

# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
ls --color ${logs_folder} ; cat_and_run "ls -ltr --color ${pwd}"
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
