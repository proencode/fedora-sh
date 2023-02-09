#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cCyan}$1 ${cBlue}$2${cReset}"
}
cat_and_read () {
	echo -e "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cGreen}\n----> ${cCyan}press Enter${cReset}:"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cCyan}$1 ${cMagenta}$2${cReset}"
}
READ_Y_IS=""
cat_and_readY () {
	echo "${cGreen}----> ${cYellow}$1 ${cCyan}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		READ_Y_IS="y"
		echo "$1" | sh ; echo "${cMagenta}<---- ${cCyan}$1 ${cBlue}$2${cReset}"
	else
		echo "${cGreen}----> ${cRed}press ${cCyan}y${cRed} or Enter${cReset}:"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			READ_Y_IS="y"
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
		else
			READ_Y_IS="n"
			echo "${cRed}[ ${cYellow}$1 ${cRed}] ${cCyan}<--- 명령을 실행하지 않습니다.${cReset}"
		fi
		echo "${cMagenta}<---- ${cBlue}press Enter${cReset}: ${cCyan}$1 ${cMagenta}$2${cReset}"
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
MEMO="VirtualBox용 프로그램 설치"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"


title_begin "로그 기록전에 업데이트부터 합니다."
cat_and_readY "sudo vi /etc/sudoers ; reset" "sudo 명령시 비번을 일일이 입력하지 않으려면, 'y' 를 눌러서 수정합니다."
cat_and_readY "time sudo dnf update -y" "시간 여유가 되면, 'y' 를 눌러서 시스템을 업데이트 하는것이 좋습니다."
if [ "x${READ_Y_IS}" = "xy" ]; then
	cat <<__EOF__

---- 시스템을 업데이트 했으므로,
---- 시스템을 다시 부팅 하기 위해서는 'y' 를 입력하고,
---- ---- 다시 부팅한 뒤에는 ${CMD_NAME} 스크립트를 한번 더 실행해야 합니다.
---- 다시 부팅하지 않으려면, 그냥 Enter 를 입력하세요.

__EOF__
	cat_and_readY "sudo reboot"
fi
title_end "로그 기록전에 업데이트부터 합니다."


logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----


title_begin "vbox 프로그램 설치"
cat_and_run "time sudo dnf -y install make automake autoconf gcc dkms kernel-debug-devel kernel-devel" "커널 컴파일용 프로그램 설치"
cat_and_run "time sudo dnf -y install wget vim-enhanced vim-common mc git p7zip gnome-tweak-tool rclone livecd-tools liveusb-creator" "추가 프로그램 설치"
cat_and_run "rpm -qa | grep kernel | sort | grep kernel" "kernel 버전 확인"
cat_and_run "sudo systemctl enable sshd ; sudo systemctl start sshd" "sshd 실행"
title_end "vbox 프로그램 설치"


title_begin "vbox 그룹 추가"
is_group=$(grep vboxsf /etc/group | grep ${USER})
if [ "x${is_group}" = "x" ]; then
	cat_and_run "grep vboxsf /etc/group" "vboxsf 그룹이 user 에게 지정되지 않았습니다."
	cat_and_run "sudo gpasswd -a ${USER} vboxsf ; grep vboxsf /etc/group" "vboxsf 그룹을 추가합니다."
	echo "${cGreen}----> ${cCyan}vboxsf 그룹에 ${USER} 사용자가 추가됐다면, '${cYellow}y${cCyan}' 를 눌러서 이 시스템을 다시 시작해야 합니다.${cReset}"
	read a ; echo "${cUp}"
	if [ "x$a" = "xy" ]; then
		echo "${cRed}[ ${cReset}reboot ${cRed}]${cReset}"
		rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}__ADD_vboxsf_to_etc_group_and_REBOOT" ; touch ${log_name}
		sudo reboot
	fi
fi
title_end "vbox 그룹 추가"


#-- cat <<__EOF__
#-- vi ~/.ssh/config
#-- Host kaos.kr
#--         KexAlgorithms +diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
#--         # KexAlgorithms +diffie-hellman-group1-sha1
#--         ## PubkeyAcceptedKeyTypes=ssh-rsa
#-- Host www.kaos.kr
#--         KexAlgorithms +diffie-hellman-group-exchange-sha1,diffie-hellman-group14-sha1,diffie-hellman-group1-sha1
#--         # KexAlgorithms +diffie-hellman-group1-sha1
#--         ## PubkeyAcceptedKeyTypes=ssh-rsa
#-- 
#-- __EOF__


title_begin "게스트 확장 CD 이미지 삽입"
cat <<__EOF__

${cCyan}---->${cReset}
${cCyan}---->${cReset} vfedora 초기화 작업을 진행하기 전에,
${cCyan}---->${cReset} 화면 맨 윗줄에 표시된 (파일 , 머신 , 보기 , 입력 , 장치 , 도움말) 메뉴에서,
${cCyan}---->${cReset}
${cCyan}---->${cReset} [장치] 클릭 >> [게스트 확장 CD 이미지 삽입] 을 클릭하고,
${cCyan}---->${cReset} 자동으로 시작하기로 한 프로그램 . . . 실행하시겠습니까? >> [실행] 을 클릭하고,
${cCyan}---->${cBlue} ---->${cReset} Do you wish to continue? [yes or no] ${cBlue}>> 나오면 'yes' 를 입력합니다.${cReset}

__EOF__
cat_and_readY "sudo /sbin/rcvboxadd quicksetup all ; sudo /sbin/rcvboxadd setup" "이작업 시작전에  (장치 > 게스트 확장 CD 이미지 삽입 > 오류시 재작업) 을 먼저 끝내야 합니다."
title_begin "게스트 확장 CD 이미지 삽입"


title_begin "VundleVim 설치"
echo "${cCyan}----> https://itlearningcenter.tistory.com/entry/%E3%80%901804-LTS%E3%80%91VIM-Plug-in-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0${cReset}"
cat_and_run "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim" "VundleVim 설치"
cat_and_run "cp init_files/DOTvimrc-fedora ~/.vimrc" ".vimrc 설치"
echo "${cGreen}----> ${cYellow}vi +BundleInstall +qall ${cCyan}Bundle 설치${cReset}"
vim +BundleInstall +qall
title_end "VundleVim 설치"


title_begin "credential.helper 설치"
cat <<__EOF__

#-- github 비번관리
1. https://github.com 로그인 후,
   1) 우상단 프로필 사진 클릭 > 설정 Setting 클릭
   2) 좌 사이드바에서 개발자 설정 Developer setting 클릭
   3) 개인 액세스 토큰 Personal access token 클릭
   4) 새 토큰 생성 Generate new token 클릭 > 권한에서 저장소 액세스 repo 선택
   5) 토큰 생성 Generate token
   6) 토큰을 복사한다.
2. 저장소 repository 복사.
   1) git clone https://proencode@github.com/proencode/fedira-sh.git
      (1) 이때 비밀번호를 물어오면 토큰을 입력한다.
      (2) 위 비번을 저장하기 위해 다음 명령을 실행한다.
          a) git config --global credential.helper ‘cache –timeout=300’ (5분동안만 비번없이 진행한다)
          b) git config --global credential.helper cache (cache 만 지정하면 15분동안 비번없이 진행한다)
          c) git config --global credential.helper store (토큰의 유효기간동안 비번없이 진행한다)

__EOF__
cat_and_readY "git config credential.helper store" "이와 같이 저장합니다."
title_end "credential.helper 설치"


cat_and_readY "sudo reboot" "시스템을 업데이트 한뒤에는, 반드시 'y' 를 눌러서 시스템을 다시 부팅 하세요."


# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
