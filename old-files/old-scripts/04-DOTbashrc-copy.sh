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
MEMO=".bashrc 바꾸기"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"
logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----

new_dot_bashrc=$(pwd)/${CMD_DIR}/init_files/DOTbashrc-vfedora37 #-- 스크립트가 있는 디렉토리에 이 파일이 있어야 한다.
if [ ! -f ${new_dot_bashrc} ]; then
	cat <<__EOF__ | tee ${new_dot_bashrc}
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "\$PATH" =~ "\$HOME/.local/bin:\$HOME/bin:" ]]
then
    PATH="\$HOME/.local/bin:\$HOME/bin:\$PATH"
fi
export PATH

#--
cB="\\[\\e[" ;cE="\\]" #-- 색깔 시작과 끝 표시
# 색깔지정의 구조: '\\[' + '\\e[' + '첫번째 1,2글자:글자형태' + '두번째 2글자:색깔' + '세번째 2글자:색깔' + 'm' + '\\]'
# 첫번째 => 0:보통 1:굵게 2:흐림 3:이탤릭 4:밑줄 5:깜빡거림 6 7:반전 8 9:글자에 줄긋기 10:
# 두번째/세번째의 앞글자 => 3x:글자색 4x:바탕색
# 두번째/세번째의 뒷글자 => x0:회 x1:빨 x2:초 x3:노 x4:청 x5:보 x6:파 x7:흰
cGray="\${cB}0;30m\${cE}"; cRed="\${cB}0;31m\${cE}"; cGreen="\${cB}0;32m\${cE}"; cYellow="\${cB}0;33m\${cE}"; cBlue="\${cB}0;34m\${cE}"; cMagenta="\${cB}0;35m\${cE}"; cCyan="\${cB}0;36m\${cE}"; cWhite="\${cB}0;37m\${cE}"; cReset="\${cB}0m\${cE}" #-- 보통 글자색
dGray="\${cB}1;30m\${cE}"; dRed="\${cB}1;31m\${cE}"; dGreen="\${cB}1;32m\${cE}"; dYellow="\${cB}1;33m\${cE}"; dBlue="\${cB}1;34m\${cE}"; dMagenta="\${cB}1;35m\${cE}"; dCyan="\${cB}1;36m\${cE}"; dWhite="\${cB}1;37m\${cE}"; #-- 굵은 글자색
# '\\t' 12:34:56 시분초
# '\\D' 날짜처리 '{' '}' 사이에 넣는것: %Y=2022 %y=22 %m=01 %d=28 %a=금
# \\u 사용자아이디 \\h 호스트이름 \\w 현재 디렉토리
## cWhiteGreen="\${cB}0;37;42m\${cE}"
cBlackGreen="\${cB}0;30;42m\${cE}"
# PS1="\${cGreen}\\t\${cYellow}\\D{%a}\${cCyan}\\D{%y}\${cMagenta}\\D{%m}\${cGreen}\\D{%d} \${dCyan}\\u\${cWhite}@\${cBlackGreen}\\h\${cReset} \${cCyan}\\w\\n\${cCyan}\\W\${cReset} \$ " #-- vfed35 220330
PS1="\${cGreen}\\t\${cRed}\\D{%a}\${cMagenta}\\D{%y}\${cCyan}\\D{%m}\${cYellow}\\D{%d} \${dCyan}\\u\${cWhite}@\${cGreen}\\h\${cReset} \${cCyan}\\w\\n\${cCyan}\\W\${cReset} $ " #-- vfed35 220330
## PS1="\${cGreen}\\t\${cYellow}\\D{%a}\${cBlue}\\D{%y}-\${cGreen}\\D{%m-%d} \${dMagenta}\\u\${cWhite}@\${cWhiteGreen}\\h\${cReset} \${cCyan}\\w\\\n\${cCyan}\\W\${cReset} $ " #-- oldvfed35
## PS1='\e[0;36m\\t\\e[0m \\e[0;33m\\D{%a}\\e[0m \\D{%Y-%m-%d} \\e[01;36m\\u\\e[01;37m@\\e[01;42m\\h\\e[0m \\e[0;32m\\w\\e[0m\\n\\e[0;32m\\W\\e[0m $ ' #-- g1ssd128
#--

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "\$rc" ]; then
			. "\$rc"
		fi
	done
fi

unset rc

# ----------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
__EOF__
fi

old_files=$(pwd)/${CMD_DIR}/old_files
if [ ! -d ${old_files} ]; then
	mkdir ${old_files}
fi
cat_and_run "mv ~/.bashrc ${old_files}/dOTbashrc-original-$(date +'%y%m%d_%H%M%S')-$(uname -r)" "원래의 .bashrc 파일을 이곳으로 복사합니다."
cat_and_run "cp ${new_dot_bashrc} ~/.bashrc" "미리 작성했던 파일을 ~/.bashrc 로 복사합니다."
cat <<__EOF__
${cCyan}----------------${cReset}
source ~/.bashrc ${cCyan}#--- 이 명령으로 프롬프트를 새로 지정합니다.${cReset}
${cCyan}----------------${cReset}
__EOF__
cat_and_run "ls -a --color ~/"

# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
