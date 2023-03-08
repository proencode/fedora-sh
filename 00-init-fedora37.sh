#!/bin/sh

CMD_NAME=`basename $0` ; CMD_DIR=${0%/$CMD_NAME} ; if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then CMD_DIR="." ; fi
cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cmdRun () {
	echo "${cCyan}----> ${cYellow}$1 ${cGreen}#-- ${cCyan}$2${cReset}"; echo "$1" | sh
	echo "${cGreen}<---- ${cBlue}$1 ${cGreen}#-- $2${cReset}"
}
cmdCont () {
	echo -e "${cCyan}----> ${cYellow}$1 ${cGreen}#-- ${cCyan}$2\n----> ${cMagenta}Enter ${cGreen}to continue${cReset}:"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cGreen}<---- ${cBlue}$1 ${cGreen}#-- $2${cReset}"
}
allYn="n"
cmdYenter () {
	echo "${cCyan}----> ${cYellow}$1 ${cGreen}#-- ${cCyan}$2${cReset}"
	if [ "x${allYn}" = "xy" ]; then
		echo "$1" | sh ; echo "${cGreen}<---- ${cBlue}$1 ${cMagenta}#-- $2${cReset}"
	else
		echo "${cCyan}----> ${cRed}press ${cCyan}'${cYellow}y${cCyan}'${cRed} or Enter${cReset}:"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
			echo "${cGreen}<---- ${cBlue}$1 press 'y' or Enter: ${cMagenta}#-- $2${cReset}"
		else
			echo "${cRed}[ ${cBlue}$1 ${cRed}] ${cMagenta}<--- 명령을 실행하지 않습니다.${cReset}"
		fi
	fi
}
eSq=0
eSqMsg=""
echoSeq () {
	if [ "x$1" = "x" ]; then
		echo "${cBlue}(${eSq}) ${eSqMsg}${cReset}" ; echo "${cBlue}#--${cReset}"
	else
		eSq=$(( ${eSq} + 1 ))
		echo "${cMagenta}(${eSq}) ${cCyan}$1${cReset}"
		eSqMsg=$1
	fi
}
cmdTTbegin () {
	cat <<__EOF__
${cBlue}#---- ----
v  ${cRed}$1${cBlue}
v${cReset}
__EOF__
}
cmdTTend () {
	cat <<__EOF__
${cBlue}^
^  ${cMagenta}$1${cBlue}
#---- ----${cReset}
__EOF__
}
#-- source ${HOME}/bin/color_base #-- 230207화1201 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq cmdTTbegin cmdTTend

# echo "${cCyan}----> ${cRed}
# ${cReset}"
# echo "${cBlue}<---- ${cMagenta}
# ${cReset}"
MEMO="Fedora 업데이트"
echo "${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}"

cmdTTbegin "(1) 시스템 업데이트"
cmdYenter "sudo vi /etc/sudoers ; reset" "sudo 명령시 비번을 일일이 입력하지 않으려면, 'y' 를 눌러서 수정합니다."
cmdYenter "time sudo dnf update -y" "시간 여유가 되면, 'y' 를 눌러서 시스템을 업데이트 하는것이 좋습니다."
if [ "x${READ_Y_IS}" = "xy" ]; then
	cat <<__EOF__

---- 시스템을 업데이트 했으므로,
---- 시스템을 다시 부팅 하기 위해서는 'y' 를 입력하고,
---- ---- 다시 부팅한 뒤에는 ${CMD_NAME} 스크립트를 한번 더 실행해야 합니다.
---- 다시 부팅하지 않으려면, 그냥 Enter 를 입력하세요.

__EOF__
	cmdYenter "sudo reboot"
fi
cmdTTend "(1) 시스템 업데이트"


logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cmdRun "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----


cmdTTbegin "(2) vbox 프로그램 설치"
cmdRun "time sudo dnf -y install make automake autoconf gcc dkms kernel-debug-devel kernel-devel" "커널 컴파일용 프로그램 설치"
cmdRun "time sudo dnf -y install wget vim-enhanced vim-common mc git p7zip gnome-tweak-tool rclone livecd-tools liveusb-creator" "추가 프로그램 설치"
cmdRun "rpm -qa | grep kernel | sort | grep kernel" "kernel 버전 확인"
cmdRun "sudo systemctl enable sshd ; sudo systemctl start sshd" "sshd 실행"
cmdTTend "(2) vbox 프로그램 설치"

# ---- ----

cmdTTbegin "(3) vbox 그룹 추가"
is_group=$(grep vboxsf /etc/group | grep ${USER})
if [ "x${is_group}" = "x" ]; then
	cmdRun "grep vboxsf /etc/group" "vboxsf 그룹이 user 에게 지정되지 않았습니다."
	cmdRun "sudo gpasswd -a ${USER} vboxsf ; grep vboxsf /etc/group" "vboxsf 그룹을 추가합니다."
	echo "${cGreen}----> ${cCyan}vboxsf 그룹에 ${USER} 사용자가 추가됐다면, '${cYellow}y${cCyan}' 를 눌러서 이 시스템을 다시 시작해야 합니다.${cReset}"
	read a ; echo "${cUp}"
	if [ "x$a" = "xy" ]; then
		echo "${cRed}[ ${cReset}reboot ${cRed}]${cReset}"
		rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}__ADD_vboxsf_to_etc_group_and_REBOOT" ; touch ${log_name}
		sudo reboot
	fi
fi
cmdTTend "(3) vbox 그룹 추가"

# ---- ----

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


cmdTTbegin "(4) 게스트 확장 CD 이미지 삽입"
cat <<__EOF__

${cCyan}---->${cReset}
${cCyan}---->${cReset} vfedora 초기화 작업을 진행하기 전에,
${cCyan}---->${cReset} 화면 맨 윗줄에 표시된 (파일 , 머신 , 보기 , 입력 , 장치 , 도움말) 메뉴에서,
${cCyan}---->${cReset}
${cCyan}---->${cReset} [장치] 클릭 >> [게스트 확장 CD 이미지 삽입] 을 클릭하고,
${cCyan}---->${cReset} 자동으로 시작하기로 한 프로그램 . . . 실행하시겠습니까? >> [실행] 을 클릭하고,
${cCyan}---->${cBlue} ---->${cReset} Do you wish to continue? [yes or no] ${cBlue}>> 나오면 'yes' 를 입력합니다.${cReset}

__EOF__
windows_bada_dir="${HOME}/wind_bada"
cmdYenter "sudo /sbin/rcvboxadd quicksetup all ; sudo /sbin/rcvboxadd setup" "이작업 시작전에  (장치 > 게스트 확장 CD 이미지 삽입 > 오류시 재작업) 을 먼저 끝내야 합니다."
cmdRun "df -h" "윈도우 폴더가 마운트 되었는지 확인합니다."
cmdRun "ln -s /media/sf_Downloads/bada/ ${windows_bada_dir}" "윈도우의 다운로드 폴더를 ${windows_bada_dir} 로 연결합니다."
cmdRun "ls -l ${HOME}" "Windows 링크가 만들어져 있는지 확인해야 합니다."
cmdRun "ls -l ${windows_bada_dir}/" "Windows 폴더 내용이 보이는지 확인해야 합니다."
cmdTTend "(4) 게스트 확장 CD 이미지 삽입"

# ---- ----

cmdTTbegin "(5) VundleVim 설치"
echo "${cCyan}----> https://itlearningcenter.tistory.com/entry/%E3%80%901804-LTS%E3%80%91VIM-Plug-in-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0${cReset}"
# cmdCont "git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim" "VundleVim 설치"
cmdCont "git clone https://github.com/susabolca/Vundle.vim ${HOME}/.vim/bundle/Vundle.vim" "VundleVim 설치"
#xxx-- cmdRun "cp init_files/DOTvimrc-fedora ${HOME}/.vimrc" ".vimrc 설치"

bin_init_files_dir="${HOME}/bin/init_files"
if [ ! -d ${bin_init_files_dir} ]; then
	mkdir -p ${bin_init_files_dir}
fi

bin_old_files_dir="${HOME}/bin/old_files"
if [ ! -d ${bin_old_files_dir} ]; then
	mkdir -p ${bin_old_files_dir}
fi

new_DOT_vimrc=$(pwd)/${CMD_DIR}/init_files/DOTvimrc #-- 스크립트가 있는 디렉토리에 이 파일이 있어야 한다.
if [ ! -f ${new_DOT_vimrc} ]; then
	new_DOT_vimrc=${bin_init_files_dir}/DOTvimrc
	cat <<__EOF__ | tee ${new_DOT_vimrc}
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set cursorline
set number
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'susabolca/Vundle.vim'
" Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
" 파일 트리 (:NERDTree 로 실행)
Plugin 'scrooloose/nerdtree'
autocmd VimEnter  NERDTree
" 코드 문법체크 (vim-airline 와 연동
"" Plugin 'scrooloose/syntastic'
" 칼라테마 (http://vimcolors.com/ 에서 종류 확인 가능)
" Plugin 'nanotech/jellybeans.vim'
" 자동완성 기능 (Ctrl+P 안눌러도 자동으로 나타나게)
"" Plugin 'AutoComplPop'
" 열리있는 소스파일의 클래스, 함수, 변수 정보 창 - Tag List
"" Plugin 'taglist-plus'
"" call vundle#end()            " required
"" filetype plugin indent on    " required

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"-- Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"-- Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" nerd 입력하면 수행됨.
nmap nerd :NERDTreeToggle<CR>
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" 230224 금 1416 from https://github.com/susabolca/Vundle.vim
" 210422 목 1036 from https://github.com/VundleVim/Vundle.vim
" at dOTvimrc-old-$(date +'%y%m%d%a_%H%M%S')-$(uname -r)
__EOF__
fi

if [ -f ${HOME}/.vimrc ]; then
	cmdRun "mv ${HOME}/.vimrc ${bin_old_files_dir}/dOTvimrc-old-$(date +'%y%m%d%a_%H%M%S')-$(uname -r)" "원래의 .vimrc 파일을 이곳으로 복사합니다."
fi
cmdRun "cp ${new_DOT_vimrc} ${HOME}/.vimrc" "미리 작성했던 파일을 ${HOME}/.vimrc 로 복사합니다."


echo "${cGreen}----> ${cYellow}vi +BundleInstall +qall ${cCyan}Bundle 설치${cReset}"
vim +BundleInstall +qall
cmdTTend "(5) VundleVim 설치"

# ---- ----

cmdTTbegin "(6) credential.helper 설치"
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
cmdYenter "git config credential.helper store" "이와 같이 저장합니다."
cmdTTend "(6) credential.helper 설치"
cmdYenter "sudo reboot" "시스템을 업데이트 한뒤에는, 반드시 'y' 를 눌러서 시스템을 다시 부팅 하세요."

# ---- ----

cmdTTbegin "(7) 호스트 이름 바꾸기"
HOSTNAME=$(hostname)
cat <<__EOF__
${cCyan}----> 호스트 이름을 바꾸려면 입력하세요: ${cRed}[${cYellow} ${HOSTNAME} ${cRed}]${cReset}
__EOF__
read a ; echo "${cUp}"
if [ "x$a" = "x" ]; then
	echo "= ${cRed}${HOSTNAME}${cReset} ="
else
	echo "= ${cRed}${a}${cReset} ="
	cmdRun "sudo hostnamectl set-hostname $a" "호스트 이름을 $a 로 지정합니다."
fi
cmdTTend "(7) 호스트 이름 바꾸기"

# ---- ----

cmdTTbegin "(8) 한글 폰트파일 설치를 위해 임시로 쓸 폴더 확인"
wind_bada_Downloads_dir=${windows_bada_dir}/Downloads
bin_temp_fonts_dir=${wind_bada_Downloads_dir}/temp_fonts
if [ ! -d ${wind_bada_Downloads_dir} ]; then
	bin_temp_fonts_dir=${HOME}/bin/temp_fonts
fi
mkdir -p ${bin_temp_fonts_dir}

WGET="wget --no-check-certificate --content-disposition"
cmdRun "rm -rf ${bin_temp_fonts_dir} ; mkdir -p ${bin_temp_fonts_dir}" "임시로 쓰는 폴더를 새로 만듭니다."
cmdTTend "(8) 한글 폰트파일 설치를 위해 임시로 쓸 폴더 확인"


cmdTTbegin "(9) 압축한 파일을 찾아서 폰트 설치"
font_zip_file=$(pwd)/${CMD_DIR}/init_files/Font-D2-KoPub-jeju-nanum-seoul.7z
font_zip_file=$(pwd)/${CMD_DIR}/init_files/Font-D2-KoPub-jeju-nanum-seoul.7z
FONT_DIR=/usr/share/fonts #-- 폰트 폴더
if [ -f ${font_zip_file} ]; then
	cmdRun "ls ${FONT_DIR}" "폰트 등록전의 폴더 내용"
	cmdRun "cd ${FONT_DIR} ; sudo 7za -y x ${font_zip_file}" "폰트 설치"
	cmdRun "ls ${FONT_DIR}" "폰트 등록후의 폴더 내용"
#--	cmdTTend "압축한 파일을 찾아서 폰트 설치"
#--	# ----
#--	rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
#--	cmdRun "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
#--	echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
#--	exit 0
else
	echo "!!!! ${cRed}----> ${cBlue}압축한 파일이 없습니다.${cReset}"
	cmdTTend "(9) 압축한 파일을 찾아서 폰트 설치"
	cmdTTbegin "(10-1) D2Coding 폰트 설치"
	FONT_HOST="https://github.com/naver/d2codingfont/releases/download/VER1.3.2"
	FONT_NAME="D2Coding-Ver1.3.2-20180524.zip"
	LOCAL_DIR="${FONT_DIR}/D2Coding"
	
	cmdYenter "cd ${bin_temp_fonts_dir} ; ${WGET} ${FONT_HOST}/${FONT_NAME}" "폰트 내려받기"
	cmdRun "sudo rm -rf ${LOCAL_DIR}*" "기존 폴더 삭제"
	cmdRun "cd ${bin_temp_fonts_dir} ; 7za x ${FONT_NAME}" "폰트 압축해제"
	cmdRun "cd ${bin_temp_fonts_dir} ; sudo chown -R root:root D2Coding ; sudo mv D2Coding ${FONT_DIR}/ ; sudo chmod 755 -R ${LOCAL_DIR} ; sudo chmod 644 ${LOCAL_DIR}/*" "폰트 설치"
	cmdRun "cd ${LOCAL_DIR} ; sudo mv D2Coding-Ver1.3.2-20180524.ttc D2Coding.ttc ; sudo mv D2Coding-Ver1.3.2-20180524.ttf D2Coding.ttf ; sudo mv D2CodingBold-Ver1.3.2-20180524.ttf D2CodingBold.ttf" "폰트 파일이름을 수정합니다."
	cmdTTend "(10-1) D2Coding 폰트 설치"
	
	
	cmdTTbegin "(10-2) seoul 폰트 설치"
	cmdRun "sudo rm -rf ${bin_temp_fonts_dir} ; mkdir ${bin_temp_fonts_dir}" "임시폴더 다시만들고,"
	FONT_HOST="https://www.seoul.go.kr/upload/seoul/font"
	FONT_NAME="seoul_font.zip" #-- 파일을 한글코드로 된 폴더에 담아서 압축했기 때문에, 풀면 fedora35 에서 깨진 글자로 나온다.
	LOCAL_DIR="${FONT_DIR}/seoul"
	
	cmdYenter "cd ${bin_temp_fonts_dir} ; ${WGET} ${FONT_HOST}/${FONT_NAME}" "폰트 내려받기"
	cmdRun "sudo rm -rf ${LOCAL_DIR} ; sudo mkdir ${LOCAL_DIR}" "폴더 만들기"
	cmdRun "cd ${bin_temp_fonts_dir} ; ls -l ; 7za x ${FONT_NAME}" "폰트 압축해제"
	cmdRun "cd ${bin_temp_fonts_dir} ; sudo mv */Seoul*.ttf ${LOCAL_DIR}/ ; sudo chmod 644 ${LOCAL_DIR}/*" "폰트 설치"
	cmdTTend "(10-2) seoul 폰트 설치"
fi


cmdTTbegin "(11) 폰트 설치 확인"
cmdRun "ls -ltr --color ${FONT_DIR}" "시간역순 font 디렉토리"
cmdRun "ls --color ${FONT_DIR}/D2Coding*" "d2coding 설치 확인"
cmdRun "ls --color ${FONT_DIR}/seoul*" "seoul 설치 확인"
cmdRun "sudo rm -rf ${bin_temp_fonts_dir}" "임시폴더 삭제"
cmdTTend "(11) 폰트 설치 확인"

# ---- ----

cmdTTbegin "(12) 새로운 .bashrc 만들기"
new_dot_bashrc=$(pwd)/${CMD_DIR}/init_files/DOTbashrc-vfedora37 #-- 스크립트가 있는 디렉토리에 이 파일이 있어야 한다.
if [ ! -f ${new_dot_bashrc} ]; then
	new_dot_bashrc=${bin_init_files_dir}/DOTbashrc-vfedora37 #-- 스크립트가 있는 디렉토리에 이 파일이 있어야 한다.
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
if ! [[ "\$PATH" =~ "/snap/intellij-idea-community/current/bin/:\$HOME/bin:" ]]
then
    PATH="/snap/intellij-idea-community/current/bin/:\$HOME/bin:\$PATH" #-- intellij IDEA
fi
export PATH
export EXINIT='set nomore'

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
alias more='more -e'
alias ll 'ls -l --color=auto'
__EOF__
fi

if [ -f ${HOME}/.bashrc ]; then
	cmdRun "mv ${HOME}/.bashrc ${bin_old_files_dir}/dOTbashrc-old-$(date +'%y%m%d%a_%H%M%S')-$(uname -r)" "원래의 .bashrc 파일을 이곳으로 복사합니다."
fi
cmdRun "cp ${new_dot_bashrc} ${HOME}/.bashrc" "미리 작성했던 파일을 ${HOME}/.bashrc 로 복사합니다."
cmdRun "tail -9 ~/.bashrc ; tail -9 ~/.zshrc"
cmdYenter "sudo dnf install snapd -y" "snap 설치하기"
cmdRun "tail -9 ~/.bashrc ; tail -9 ~/.zshrc"
cmdRun "ls -l --color /snap" "snap 링크 설치 확인"
cmdRun "sudo ln -s /var/lib/snapd/snap /snap" "snap 설치시 추가작업"
cmdRun "ls -l --color /snap" "snap 링크 설치 확인"

cmdRun "tail -9 ~/.bashrc ; tail -9 ~/.zshrc"
cmdYenter "curl -s \"https://get.sdkman.io\" | bash" "sdkman 설치하기"
cmdRun "tail -9 ~/.bashrc ; tail -9 ~/.zshrc"
cat <<__EOF__
# ------------------------------------------------------------
# sdkman 설치후에는 다음 명령을 터미널에서 직접 실행해야 합니다.

source "/home/yosj/.sdkman/bin/sdkman-init.sh"

# ----> press Enter:
__EOF__
read a

cat <<__EOF__
${cCyan}
터미널을 새로 열고, ${cYellow}source ${HOME}/.bashrc ${cCyan}#--- 이 명령으로 프롬프트를 새로 지정하세요.
${cGreen}----> press Enter:${cReset}
__EOF__
read a
cmdTTend "(12) 새로운 .bashrc 만들기"

# ---- ----

cmdTTbegin "(13) 구글 크롬 브라우저 설치"
cmdRun "sudo dnf install -y fedora-workstation-repositories" "3rd Party 저장소 설치"
cmdRun "sudo dnf config-manager --set-enabled google-chrome" "Google 크롬 리포지토리를 활성화합니다."
cmdRun "sudo dnf install -y google-chrome-stable" "마지막으로 Chrome을 설치합니다."
cmdTTend "(13) 구글 크롬 브라우저 설치"

# ---- ----

cmdTTbegin "(14) rclone 사이즈 확인"
cmdRun "rclone about yosjgc:"
cmdRun "rclone about kaosngc:"
cmdRun "rclone about swlibgc:"
cmdRun "rclone about ysj5ncmi:"
cmdRun "rclone about kaosbmi:"
cmdRun "rclone about kaosb2mi:"
cmdRun "rclone about kaosb3mi:"
cmdRun "rclone about kaosb4mi:"
cmdRun "rclone about tpnotemi:"
cmdRun "rclone about tpnote2mi:"
cmdTTend "(14) rclone 사이즈 확인"

cmdYenter "sudo snap install intellij-idea-community --classic" "snap 으로 intellij-idea-community 버전 설치하기"

# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cmdRun "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}"
