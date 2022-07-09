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
# echo "${cCyan}----> ${cRed}
# ${cReset}"
# echo "${cBlue}<---- ${cMagenta}
# ${cReset}"
MEMO="마침표 기준으로 줄을 바꿉니다."
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
# logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
# log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----


if [ "x$1" = "x" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 프로그램 이름 다음에 ${cCyan}(마침표 위치에서 줄을 바꾸려는 md 파일)${cBlue}을 지정해야 합니다.${cReset}"
	echo "----> ${cYellow}${0} [md 파일 이름]${cReset}"
	exit 1
fi
if [ ! -f "$1" ]; then
	echo "${cRed}!!!! ${cMagenta}----> ${cBlue} 마침표 위치에서 줄을 바꾸려는 ${cCyan}($1)${cBlue} md 파일이 없습니다.${cReset}"
	echo "----> ${cYellow}${0} [md 파일 이름]${cReset}"
	exit 1
fi


org_dir_name="$1" #-- 원본 파일 폴더/이름

qq=${org_dir_name:0:1}
# echo "qq ${qq};"
if [ "x${qq}" != "x." ]; then
	if [ "x${qq}" != "x/" ]; then
		org_dir_name="./${org_dir_name}"
	fi
fi

org_name=$(basename "${org_dir_name}") # 백업파일 이름만 꺼냄
org_dir=${org_dir_name%/"$org_name"} # 백업파일 이름을 빼고 나머지 디렉토리만 담음
en2ko_file="dot.${org_name}" #-- 최종 번역 파일

cat <<__EOF__

${cCyan}           \$1= ${cYellow}${1} ${cCyan};
${cCyan} org_dir_name= ${cYellow}${org_dir_name} ${cCyan}; #-- 원본 파일 폴더/이름
${cCyan}     org_name= ${cYellow}${org_name} ${cCyan}; #-- 백업파일 이름만 꺼냄
${cCyan}      org_dir= ${cYellow}${org_dir} ${cCyan}; #-- 백업파일 이름을 빼고 나머지 디렉토리만 담음
${cCyan}   en2ko_file= ${cYellow}${en2ko_file} ${cCyan}; #-- 최종 번역 파일

__EOF__

cat_and_run "cat \"${org_dir_name}\" | sed -e s'/\.$/\.\n/g' | sed -e s'/\. /\.\n/g' > \"${en2ko_file}\"" "마침표 (.) 기준으로 줄을 분리합니다."

echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
