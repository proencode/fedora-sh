#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cat_and_run () {
	echo "${ggg}----> ${yyy}$1 ${cCyan}$2${xxx}"; echo "$1" | bash
	echo "${mmm}<---- $1 ${bbb}$2${xxx}"
}
cat_and_read () {
	echo -e "${ggg}----> ${yyy}$1 ${cCyan}$2${ggg}\n----> ${bbb}press ${rrr}Enter:${xxx}"
	read a ; echo "${uuu}"; echo "$1" | bash
	echo "${mmm}<---- press ${rrr}Enter: ${mmm}$1 ${bbb}$2${xxx}"
}
cat_and_readY () {
	echo "${ggg}----> ${yyy}$1 ${cCyan}$2${xxx}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | bash ; echo "${mmm}<---- $1 ${bbb}$2${xxx}"
	else
		echo "${ggg}----> ${bbb}press ${yyy}y${bbb} or ${rrr}Enter:${xxx}"; read a; echo "${uuu}"
		if [ "x$a" = "xy" ]; then
			echo "${rrr}-OK-${xxx}"; echo "$1" | bash
		else
			echo "${rrr}[ ${yyy}$1 ${rrr}] ${cCyan}<--- 명령을 실행하지 않습니다.${xxx}"
		fi
		echo "${mmm}<---- press ${rrr}Enter: ${mmm}$1 ${bbb}$2${xxx}"
	fi
}
read_and_enter () {
	echo -e "${ggg}----> ${yyy}$1 ${cCyan}$2${xxx}"
	read a
	if [ "x$a" = "x" ]; then
		a="$1"
	fi
	echo "${uuu}" ; echo "${rrr}[ ${yyy}$a ${rrr}]${xxx}" ; echo ""
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi

MEMO="rclone 디렉토리 마운트 하기"
echo -e "\n${rrr}>>>>>>>>>>${yyy} $0 ${ggg}||| ${mmm}${MEMO} ${rrr}>>>>>>>>>>${xxx}"
## logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
## log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

rclone_name="gdrive-kaos.note" #-- 마운트할 디렉토리 이름
read_and_enter ${rclone_name} "마운트할 디렉토리 이름. 다르면 직접 입력하세요."

mount_dir="/home/${rclone_name}" #-- 전체 경로 이름

#df -h
df -h | grep -v ${rclone_name}
df -h | grep --color ${rclone_name}
mount_ok=$(df -h | grep ${rclone_name})

if [ "x$mount_ok" != "x" ]; then
	cat_and_run "ls -lh ${mount_dir}" "${rclone_name} 디렉토리가 이미 마운트 되어 있습니다."
	echo "${rrr}<<<<<<<<<<${yyy} $0 ${rrr}||| ${mmm}${MEMO} ${rrr}<<<<<<<<<<${xxx}"
	exit 1
fi

cat_and_run "rclone mount --allow-non-empty --allow-other --drive-chunk-size 64M kaosnote: ${mount_dir}/ &" "구글 드라이브에 마운트 합니다."

cat_and_run "sleep 2" "마운트 완료까지 시간 여유를 둡니다."
sleep 1 ; df -h | grep -v ${rclone_name}
sleep 1 ; df -h | grep --color ${rclone_name}
cat_and_run "ls -lh ${mount_dir}"

# ----
## rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
## cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${rrr}<<<<<<<<<<${yyy} $0 ${rrr}||| ${mmm}${MEMO} ${rrr}<<<<<<<<<<${xxx}"
