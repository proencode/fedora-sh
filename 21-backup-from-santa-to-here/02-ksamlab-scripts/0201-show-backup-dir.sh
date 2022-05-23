#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- $1 ${cBlue}$2${cReset}"
}
cat_and_read () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cGreen}\n----> ${cBlue}press ${cRed}Enter:${cReset}"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cMagenta}<---- press ${cRed}Enter: ${cMagenta}$1 ${cBlue}$2${cReset}"
}
cat_and_readY () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cMagenta}<---- $1 ${cBlue}$2${cReset}"
	else
		echo "${cGreen}----> ${cBlue}press ${cYellow}y${cBlue} or ${cRed}Enter:${cReset}"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			echo "${cRed}[ ${cYellow}$1 ${cRed}] ${cCyan}<--- 명령을 실행하지 않습니다.${cReset}"
		fi
		echo "${cMagenta}<---- press ${cRed}Enter: ${cMagenta}$1 ${cBlue}$2${cReset}"
	fi
}
read_and_enter () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"
	read a
	if [ "x$a" = "x" ]; then
		a="$1"
	fi
	echo "${cUp}" ; echo "${cRed}[ ${cYellow}$a ${cRed}]${cReset}" ; echo ""
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="santa 서버 폴더와 백업pc 폴더 파일 확인"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
## logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
## log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

read_and_enter $(date +"%Y") "또는, 년도를 2022 와 같이 입력합니다."
y4=$a

read_and_enter $(date +"%m") "또는, 월을 01 ~ 12 사이에서 ** 두자리로 ** 입력합니다."
m2=$a

read_and_enter 160 "또는, ls 로 보는 폭을 숫자로 지정합니다."
wd4ls=$a

# ssh kaosco@kaos.kr ls /var/base/*/${y4}/${m2}/ | tr ':\n' ': ' | sed 's| /var|\n/var|g' ; echo ''

santa_dir=/var/base

read_santa_ksamlib () {
	folder_is=$1
	iiii=$(sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@kaos.kr ls -r ${santa_dir}/${folder_is}/${y4}/${m2}/)
	kkkk=$(echo $iiii | tr ":\n" ": ") ; ilja=($kkkk) 
	echo "${cCyan}----> ${kkkk} ---- ${cGreen} SANTA ${cYellow}${ilja[0]} ${cGreen}${y4} ${m2} ${cCyan} ---- ${santa_dir}/${folder_is} ${cReset}"
	sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@kaos.kr ls -C -w ${wd4ls} ${santa_dir}/${folder_is}/${y4}/${m2}/${ilja[0]}/

	local_dir=/home/santa-backup
	iiii=$(ls -r ${local_dir}/${folder_is}/${y4}/${m2}/)
	kkkk=$(echo $iiii | tr ":\n" ": ")
	echo "${cBlue}====> ${kkkk} ==== ${cMagenta}BACKUP ${cYellow}${ilja[0]} ${cBlue} ==== ${local_dir}/${folder_is}${cReset}"
	ls -C -w ${wd4ls} ${local_dir}/${folder_is}/${y4}/${m2}/${ilja[0]}/
}

read_santa_ksamlib cadbase

read_santa_ksamlib emailbase

read_santa_ksamlib georaebase

read_santa_ksamlib scanbase

# cat <<__EOF__
# ${cGreen}----> ${cCyan} 다음과 같이 된 경우,${cBlue}
# /var/base/cadbase/2022/05/: 06 10 11 13 16 18 19
# /var/base/emailbase/2022/05/: 06 10 13 16 18 19 20
# /var/base/georaebase/2022/05/: 18
# /var/base/scanbase/2022/05/: 02 03 06 10 11 12 13 14 16 17 20 23
# __EOF__
# read_and_enter "01 01 01 01" "위부터 차례로 보려는 일자 또는 없으면 00 을 입력하세요."
# ilja=($a)
# 
# echo "${cGreen}----> ${cYellow} ssh kaosco@kaos.kr ls /var/base/cadbase/${y4}/${m2}/${ilja[0]}/  /var/base/emailbase/${y4}/${m2}/${ilja[1]}/  /var/base/georaebase/${y4}/${m2}/${ilja[2]}/  /var/base/scanbase/${y4}/${m2}/${ilja[3]}/ | tr \":\n\" \": \" | sed \"s| /var|\n\n/var|g\" | sed \"s|/:|/:\n|g\" ; echo \"\"${cReset}"
# # ssh kaosco@kaos.kr ls -C -w ${wd4ls} /var/base/cadbase/${y4}/${m2}/${ilja[0]}/  /var/base/emailbase/${y4}/${m2}/${ilja[1]}/  /var/base/georaebase/${y4}/${m2}/${ilja[2]}/  /var/base/scanbase/${y4}/${m2}/${ilja[3]}/ | tr "\n:" "\t:" | sed "s|/var|\n\n/var|g" | sed "s|/:|/:\n|g" ; echo ""
# 
# 
# # sshpass -f /home/kaosco/.ssh/kaosco.4ssh ssh -o StrictHostKeyChecking=no kaosco@kaos.kr ls -C -w ${wd4ls} /var/base/cadbase/${y4}/${m2}/${ilja[0]}/  /var/base/emailbase/${y4}/${m2}/${ilja[1]}/  /var/base/georaebase/${y4}/${m2}/${ilja[2]}/  /var/base/scanbase/${y4}/${m2}/${ilja[3]}/ # | tr "\n:" "\t:" | sed "s|/var|\n\n/var|g" | sed "s|/:|/:\n|g" ; echo ""
# 
# 
# 
# 
# cat_and_run "ls -C -w ${wd4ls} ~/santa-backup/cadbase/${y4}/${m2}/${ilja[0]}/ ~/santa-backup/emailbase/${y4}/${m2}/${ilja[1]}/ ~/santa-backup/georaebase/${y4}/${m2}/${ilja[2]}/ ~/santa-backup/scanbase/${y4}/${m2}/${ilja[3]}/"

# ----
## rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
## cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
