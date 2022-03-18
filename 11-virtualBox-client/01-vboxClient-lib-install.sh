#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}$1 $2${cReset}"
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="게스트확장 을 위한 프로그램 설치"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
logs_folder="${HOME}/zz00-logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

cat_and_run "sudo dnf -y install kernel-debug-devel kernel-devel" "커널 devel 추가"
cat_and_run "sudo dnf -y install vim-enhanced vim-common mc lynx p7zip keepass rclone liveusb-creator " "컴파일용과 추가 프로그램들"

cat <<__EOF__
vi ~/.ssh/config
Host kaos.kr
        KexAlgorithms +diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
        # KexAlgorithms +diffie-hellman-group1-sha1
        ## PubkeyAcceptedKeyTypes=ssh-rsa
Host www.kaos.kr
        KexAlgorithms +diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
        # KexAlgorithms +diffie-hellman-group1-sha1
        ## PubkeyAcceptedKeyTypes=ssh-rsa

__EOF__

echo "${cCyan}---->${cReset}"
echo "${cCyan}---->${cReset} 이 작업이 끝나면,"
echo "${cCyan}---->${cReset} 화면 맨 위에 있는 ''파일 머신 보기 입력 장치 도움말'' 메뉴에서,"
echo "${cCyan}---->${cReset} [장치] 클릭 > [게스트 확장 CD 이미지 삽입] 클릭"
echo "${cCyan}---->${cReset} 자동으로 시작하기로 한 프로그램 . . . 실행하시겠습니까? > [실행] 클릭"
echo "${cCyan}---->${cBlue} ---->${cReset} Do you wish to continue? [yes or no] > 나오면 yes 를 입력하고, 다음 명령을 준다"
echo "sudo /sbin/rcvboxadd quicksetup all ; sudo /sbin/rcvboxadd setup"
echo "ls -l /media/sf_Downloads/ #--- 다운로드 폴더를 보여준다"

# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
