#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cat_and_run () {
	echo "${ggg}----> ${yyy}$1 ${ccc}$2${xxx}"; echo "$1" | bash
	echo "${mmm}<---- ${bbb}$1 $2${xxx}"
}
cat_and_read () {
	echo -e "${ggg}----> ${yyy}$1 ${ccc}$2${ggg}\n----> ${ccc}press Enter${xxx}:"
	read a ; echo "${uuu}"; echo "$1" | bash
	echo "${mmm}<---- ${bbb}press Enter${xxx}: ${mmm}$1 $2${xxx}"
}
cat_and_readY () {
	echo "${ggg}----> ${yyy}$1 ${ccc}$2${xxx}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | bash ; echo "${mmm}<---- ${bbb}$1 $2${xxx}"
	else
		echo "${ggg}----> ${rrr}press ${ccc}y${rrr} or Enter${xxx}:"; read a; echo "${uuu}"
		if [ "x$a" = "xy" ]; then
			echo "${rrr}-OK-${xxx}"; echo "$1" | bash
		else
			echo "${rrr}[ ${yyy}$1 ${rrr}] ${ccc}<--- 명령을 실행하지 않습니다.${xxx}"
		fi
		echo "${mmm}<---- ${bbb}press Enter${xxx}: ${mmm}$1 $2${xxx}"
	fi
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="MEGAsync 실행하기"
echo "${mmm}>>>>>>>>>>${ggg} $0 ${mmm}||| ${ccc}${MEMO} ${mmm}>>>>>>>>>>${xxx}"
logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

Shared_Folder=/media/sf_Downloads #-- 공유폴더
hostLINK_mega=${Shared_Folder}/bada/mega-yssc #-- 호스트쪽 다운로드/bada
thisLINK_home_mega=${HOME}/mega-yssc #-- 홈 폴더에 있는 링크

if [ ! -d ${Shared_Folder} ]; then
	echo "${rrr}!!!!! ----> ${yyy}링크할 ${Shared_Folder} 폴더가 없으므로 중단합니다.${xxx}"
	exit 1
fi
if [ ! -d ${hostLINK_mega} ]; then
	cat_and_run "mkdir -p ${hostLINK_mega}" "MEGAsync 를 담을 실제 디렉토리를 만듭니다."
fi

if [ ! -d ${thisLINK_home_mega} ]; then
	cat_and_run "ln -s ${hostLINK_mega} ${thisLINK_home_mega}" "가상시스템의 용량을 줄이기 위해 공유 폴더로 링크를 겁니다."
	cat_and_run "ls -l --color ${HOME}"
fi

if ! [ -x "$(command -v megasync)" ]; then
	cat_and_run "sudo dnf -y install megasync" "megasync 를 설치합니다."
fi
cat_and_run "megasync &" "megasync 를 실행합니다."
cat_and_run "ls -lh --color ${thisLINK_home_mega}" "MEGAsync 에서는 ${hostLINK_mega} 에 링크를 걸어야 합니다."

# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${rrr}<<<<<<<<<<${bbb} $0 ${rrr}||| ${mmm}${MEMO} ${rrr}<<<<<<<<<<${xxx}"
