#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}
cat_and_read () {
	echo -e "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cYellow}\n - -> ${cRed}press Enter${cCyan}:${cReset}"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta} - - ${cBlue}press Enter${cRed}: ${cMagenta}$1 $2${cReset}"
}
cat_and_readY () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cYellow}<${cMagenta}---- ${cBlue}$1${cReset}"
	else
		echo "${cYellow} - -> ${cRed}press ${cCyan}y${cRed} or Enter${cCyan}:${cReset}"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			echo "${cRed}$1 ${cYellow}--- 를 실행하지 않습니다.${cReset}"
		fi
		echo "${cYellow}<${cMagenta} - - ${cBlue}press Enter${cRed}: ${cMagenta}$1 $2${cReset}"
	fi
}

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi

Shared_Folder=/media/sf_Downloads #-- 공유폴더
hostLINK_mega=${Shared_Folder}/bada/mega-yssc #-- 호스트쪽 다운로드/bada
thisLINK_home_mega=${HOME}/mega-yssc #-- 홈 폴더에 있는 링크

MEMO="MEGAsync 실행하기"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"

if [ ! -d ${Shared_Folder} ]; then
	echo "${cRed}!!!!! ----> ${cYellow}링크할 ${Shared_Folder} 폴더가 없으므로 중단합니다.${cReset}"
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

echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"