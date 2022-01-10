#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat_and_run () {
	echo "${cYellow}----> ${cGreen}$1 ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cYellow}<${cMagenta}---- ${cBlue}$1 $2${cReset}"
}

MEMO="게스트확장 을 위한 프로그램 설치"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"

cat_and_run "sudo dnf install kernel-debug-devel kernel-devel" "커널 devel 추가"
cat_and_run "sudo dnf install automake autoconf dkms vim-enhanced vim-common mc lynx p7zip" "컴파일용과 추가 프로그램들"
echo "${cCyan}---->${cReset}"
echo "${cCyan}---->${cReset} 이 작업이 끝나면,"
echo "${cCyan}---->${cReset} 화면 맨 위에 있는 ''파일 머신 보기 입력 장치 도움말'' 메뉴에서,"
echo "${cCyan}---->${cReset} [장치] 클릭 > [게스트 확장 CD 이미지 삽입] 클릭"
echo "${cCyan}---->${cReset} 자동으로 시작하기로 한 프로그램 . . . 실행하시겠습니까? > [실행] 클릭"
echo "${cCyan}---->${cBlue} ---->${cReset} Do you wish to continue? [yes or no] > 나오면 yes 를 입력하고, 다음 명령을 준다"
echo "${cCyan}---->${cBlue} ---->${cReset} sudo /sbin/rcvboxadd quicksetup all"
echo "${cCyan}---->${cReset} ls -l /media/sf_Downloads/ #--- 다운로드 폴더를 보여준다"
echo "${cCyan}---->${cReset}"
echo "${cYellow}>>>>>>>>>>${cGreen} $0 ||| ${cCyan}${MEMO} ${cYellow}>>>>>>>>>>${cReset}"
