#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cat_and_run () {
	echo "${ggg}----> ${yyy}$1 ${ccc}$2${xxx}"; echo "$1" | bash
	echo "${mmm}<---- ${bbb}$1 $2${xxx}"
}
title_begin () {
	echo "${ccc}----> ${rrr}$1${xxx}"
}
title_end () {
	echo "${bbb}<---- ${mmm}$1${xxx}"
}
CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
MEMO="vi 용 Vundle 과 파일트리 nerd 를 설치합니다."
echo "${mmm}>>>>>>>>>>${ggg} $0 ${mmm}||| ${ccc}${MEMO} ${mmm}>>>>>>>>>>${xxx}"
logs_folder="${HOME}/zz00logs" ; if [ ! -d "${logs_folder}" ]; then cat_and_run "mkdir ${logs_folder}" ; fi
log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${log_name}
# ----


title_begin "VundleVim 설치"
echo "${ggg}----> ${ccc}https://itlearningcenter.tistory.com/entry/%E3%80%901804-LTS%E3%80%91VIM-Plug-in-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0${xxx}"
cat_and_run "sudo dnf -y install vim-enhanced vim-common" "vim 설치"
cat_and_run "git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim" "VundleVim 설치"
title_begin "VundleVim 설치"


title_begin "${HOME}/.vimrc 만들기"
now=$(date +"%y%m%d-%H%M%S")
cat_and_run "mv ${HOME}/.vimrc ${HOME}/.vimrc-$now"
cat > ${HOME}/.vimrc <<__EOF__
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
Plugin 'VundleVim/Vundle.vim'
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
" at 210422 목 1036 from https://github.com/VundleVim/Vundle.vim
__EOF__
title_end "${HOME}/.vimrc 만들기"


title_begin "vi +BundleInstall +qall #-- vi 에 등록"
vim +BundleInstall +qall
title_end "vi +BundleInstall +qall #-- vi 에 등록"


# ----
rm -f ${log_name} ; log_name="${logs_folder}/zz.$(date +"%y%m%d-%H%M%S")..${CMD_NAME}" ; touch ${log_name}
cat_and_run "ls --color ${CMD_DIR}" ; ls --color ${logs_folder}
echo "${rrr}<<<<<<<<<<${bbb} $0 ${rrr}||| ${mmm}${MEMO} ${rrr}<<<<<<<<<<${xxx}"
