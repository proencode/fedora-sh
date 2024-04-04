# 1. zero 2W 이미지 받기

1. 다운로드 사이트 http://www.orangepi.org 첫줄 메뉴에서,
(1) [ `Download` 클릭 / Github / Wiki / Third Party Images ]
(2) 아래로 스크롤 하다가, `Orange Pi Zero 2W` 클릭.
(3) 넘어간 화면의 `Official Resources` 에서, Official Tools `Downloads` 클릭.
(4) Office_Tools 에서, micro SD 를 포맷해주는 `Windows-Formatting Software-SDCardFormatter` 다운로드 하고 설치한다.
(5) Office_Tools 에서, orangePi zero2W 이미지를 micro SD 에 설치해주는 `Linux image burning tool-Win32DiskImager` 다운로드 하고 설치한다.

1. 위 `Official Resources` 화면 아래의 `Official Images` 에서,
(1) `Ubuntu Image` 의 `Downloads` 를 눌러서,
(2) `드라이브` 화면에서, `Linux6.1 kernel version image` > `For development boards with 4GB memory, ...` 를 다운로드 한다.
(3) 다운로드가 끝나면, `Orangepizero2w_1.0.0_ubuntu_jammy_server_linux6.1.31-4gb.7z` 로 받은 `서버` 파일을 압축을 풀어서 `Orangepizero2w_1.0.0_ubuntu_jammy_server_linux6.1.31.img` 파일의 위치를 확인한다.

1. 비워져 있어서 포매팅 해도 되는 micro SD 를 usb 에 연결하고,
(1) `Win32 Disk Imager` 프로그램을 실행한다.
(2) `Image File` 은 위에서 압축을 푼 `Orangepizero2w_1.0.0_ubuntu_jammy_server_linux6.1.31.img` 로 지정한다.
(3) `Device` 는 포맷한 usb 를 지정하고, [ Write ] 버튼을 클릭해서 설치를 진행한다.

# 2. zero 2W 의 ip 확인하기

OrangePi zero 2W 에 모니터, 키보드를 연결하지 않고 다른 PC 에서 연결하려면,
1. OrangePi zero 에는 유선랜 케이블을 연결해 놓고,
zero 의 ip 를 확인하는 아래 내용의 스크립트를, 다른 PC 에서 `vi ping2.sh` 명령으로 만든다.
```
#!/bin/sh

for i in {11..199}
do
	ping -c 1 192.168.999.${i}  | grep "시간=" &
	ping -c 1 192.168.999.${i}  | grep "time=" &
done
```

2. 스크립트를 실행한다.
```
$ sh ping2.sh 
  -----------
64 바이트 (192.168.999.13에서): icmp_seq=1 ttl=64 시간=0.038 ms
64 바이트 (192.168.999.108에서): icmp_seq=1 ttl=64 시간=97.9 ms
64 바이트 (192.168.999.104에서): icmp_seq=1 ttl=64 시간=0.232 ms
64 바이트 (192.168.999.106에서): icmp_seq=1 ttl=64 시간=112 ms
64 바이트 (192.168.999.112에서): icmp_seq=1 ttl=64 시간=0.042 ms
64 바이트 (192.168.999.105에서): icmp_seq=1 ttl=64 시간=408 ms
```

3. ip 를 하나씩 연결해 본다.
```
$ ssh orangepi@192.168.999.104
  ----------------------------
The authenticity of host '192.168.999.104 (192.168.999.104)' can't be established.
ED25519 key fingerprint is SHA256:QWOWy0S9IhCbQN8YSjSXNym5U/mOnqp4Etbs3lQSoyY.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added '192.168.999.104' (ED25519) to the list of known hosts.
orangepi@192.168.999.104's password: 
  ___  ____ ___   _____             ______        __
 / _ \|  _ \_ _| |__  /___ _ __ ___|___ \ \      / /
| | | | |_) | |    / // _ \ '__/ _ \ __) \ \ /\ / / 
| |_| |  __/| |   / /|  __/ | | (_) / __/ \ V  V /  
 \___/|_|  |___| /____\___|_|  \___/_____| \_/\_/   
                                                    
Welcome to Orange Pi 1.0.0 Jammy with Linux 6.1.31-sun50iw9

System load:   27%           	Up time:       3 min	Local users:   2            
Memory usage:  4% of 3.84G  	IP:	       192.168.999.104
CPU temp:      47°C           	Usage of /:    13% of 15G    	

[ 0 security updates available, 2 updates total: apt upgrade ]
Last check: 2023-10-14 02:28

Last login: Wed Sep 13 04:29:06 2023
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

orangepi@orangepizero2w:~$
```
4. 무사히 로그인이 되었다.

# 3. 사용자 이름 변경하기

출처: aeong-dev 2023. 4. 20. 21:18 https://aeong-dev.tistory.com/8

1. Ubuntu 22.04 의 임시 사용자를 만들고 sudo 권한 부여.

사용자 이름들을 bash 변수로 선언하고,
```
TEMP_USER="tmpusr" ; OLD_USER="oldusr" ; NEW_USER="newuser"
echo "";echo "TEMP_USER=\"${TEMP_USER}\" ; OLD_USER=\"${OLD_USER}\" ; NEW_USER=\"${NEW_USER}\"";echo ""
#--
```

임시 사용자를 만든다.
```
sudo adduser ${TEMP_USER} #-- 임시 사용자를 추가한다.
sudo adduser ${TEMP_USER} sudo #- 새로 만든 임시 사용자에게 sudo 권한을 부여한다.
```

2. 지금 로그인 한 터미널 창에서 로그아웃 후, 생성한 임시 사용자로 다시 로그인.

진행 중인 process 가 있으면 안되는데, ssh 연결이 붙어있다는 것 자체가 process가 있다는 것이기 때문에, 꼭 임시 사용자로 로그인하고 진행한다.

3. 기존 사용하던 사용자 이름으로 진행 중인 모든 process 죽이기.
```
sudo pkill -u ${OLD_USER} pid
sudo pkill -9 -u ${OLD_USER}
```

이거 안해주면 process 있다고 다음 스텝 진행이 안됨. 아래 문구처럼 에러 뜸.
```
# usermod : user {OLD_USER} is currently used by process 16555
```

4. 사용자 이름을 바꾸고, 바뀐 사용자 이름으로 홈 디렉토리도 바꾼다.
```
sudo usermod -l ${NEW_USER} ${OLD_USER}
sudo usermod -d /home/${NEW_USER} -m ${NEW_USER}
``` 

5. group name 변경.
```
sudo groupmod -n ${NEW_USER} ${OLD_USER}
#-- 확인하기
id ${NEW_USER}
ls -ld /home/${NEW_USER}
```

6. 접속 끊고 변경된 사용자 이름으로 로그인.

```
$ exit
...

$ ssh ${NEW_USER}@192.168.999.104
```

위에서와 마찬가지로, 진행 중인 process 가 있다면 임시 사용자의 삭제가 안되기 때문에 임시 사용자의 process 를 삭제한다.
```
sudo pkill -u ${TEMP_USER} pid
sudo pkill -9 -u ${TEMP_USER}
```

7. 임시 사용자 계정 및 디렉토리 삭제.
```
sudo deluser ${TEMP_USER}
sudo rm -r /home/${TEMP_USER}
```

# 4. dash 를 bash 로 바꾸기

ubuntu 에서는 터미널의 셀을 dash 로 쓰고 있으므로 이를 bash 로 바꿔 쓰기로 한다.

1. 실행 스크립트.
```
sudo apt-get install language-pack-ko #-- ubuntu 에서 한글 추가"
sudo timedatectl set-timezone 'Asia/Seoul' ; date #-- ubuntu 에서 시각 지정"
sudo apt install p7zip-full mc net-tools openssh-server git #-- 프로그램 추가
sudo ls -al --color /bin/sh
echo "dash dash/sh boolean false" | sudo debconf-set-selections
DEBIAN_FRONTEND=noninteractive
sudo dpkg-reconfigure dash
sudo ls -al /bin/sh #-- ubuntu 에서 dash 를 bash 로 바꾸기
sudo apt update -y && sudo apt upgrade -y #-- 업데이트와 업그레이드
```

위와 동일한 스크립트를 실행하면서, 진행과정을 설명하는 부분을 추가한 것:
```
for i in {0..3}; do echo "#"; done
sudo apt-get install language-pack-ko
echo "#^^^^ (1) ubuntu 에서 한글 추가: ^^ sudo apt-get install language-pack-ko ^^"
sudo timedatectl set-timezone 'Asia/Seoul' ; date
echo "#^^^^ (2) ubuntu 에서 시각 지정: ^^ sudo timedatectl set-timezone 'Asia/Seoul' ; date ^^"
sudo apt install p7zip-full mc net-tools openssh-server git
echo "#^^^^ (3) 프로그램 추가: ^^ sudo apt install p7zip-full mc net-tools openssh-server git ^^"
sudo ls -al --color /bin/sh
echo "dash dash/sh boolean false" | sudo debconf-set-selections
DEBIAN_FRONTEND=noninteractive
sudo dpkg-reconfigure dash
sudo ls -al /bin/sh
echo "#^^^^ (4) ubuntu 에서 dash 를 bash 로 바꾸기: ^^ sudo dpkg-reconfigure dash ^^"
sudo apt update -y && sudo apt upgrade -y
echo "#^^^^ (5) 업데이트와 업그레이드 ^^ sudo apt update -y && sudo apt upgrade -y ^^"
```

위 명령으로 설치후, `sudo cat /etc/default/locale` 명령으로 다음의 선언이 추가되었는지 확인한다.
```
#-- Ubuntu locale 한글로 설정하기  2019-11-04 https://jinmay.github.io/2019/11/04/linux/linux-change-locale-to-korean/
LANG=ko_KR.UTF-8
LC_MESSAGES=POSIX
LANGUAGE=ko_KR.UTF-8
#--
```

# 5. 프롬프트에 색상 지정하기

`vi ~/.bashrc` 명령으로 파일을 불러낸 뒤, `alias rm='rm -i'` 문장이 나오는 근처에서 아래 내용을 추가한다.
```
#----> 부터 추가
# ..... user 3x:글자색 4x:바탕색 0회 1빨 2초 3노 4청 5보 6파 7흰
# 00 01 02 흐림 03 이탤릭 04 밑줄 05 깜빡거림 06 07 반전 08 09 글자에 줄긋기 10
PS1='\e[0;36m\t\e[0m\e[0;33m\D{%a}\e[0;35m\D{%y}\e[0;36m\D{%m}\e[0;31m\D{%d} \e[0;36m\u\e[0;33m@\e[0;34m\h\e[0m \e[04;32m\w\e[0m\n\W $ '
PS1='\e[0;36m\t\e[0m\e[0;31m\D{%a}\e[0;35m\D{%y}\e[04;32m\D{%m}\e[04;33m\D{%d}\e[0;34m \u\e[0;36m@\e[0;34m\h\e[0m \e[0;32m\w\e[0m\n\W $ '
#........ 11:35:04 .......... 화 .......... 23 .......... 10 .......... 17 ........ yosj ..... @ . orangepizero2w .. 디렉토리전체 .. 줄바꾸고 최종디렉토리
export EDITOR=vi
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias more='more -e'
alias ls='ls --color=auto'
alias ll='ls -l --color=auto'
alias grep='grep --color=auto'
#<---- 까지 추가
```

# 6. 글꼴 다운로드

다음의 폰트들을 다운로드 하고, **윈도우 탐색기**에서 파일 위에 **오른쪽 마우스**로 `설치` 를 클릭해서 설치한다.

[ d2coding.ttf ](/tutorial/fonts/d2coding.ttf)
[ d2codingbold.ttf ](/tutorial/fonts/d2codingbold.ttf)
[ notomono-regular.ttf ](/tutorial/fonts/notomono-regular.ttf)
[ notosansmono-bold.ttf ](/tutorial/fonts/notosansmono-bold.ttf)
[ notosansmono-regular.ttf ](/tutorial/fonts/notosansmono-regular.ttf)


# 7. Bundle 플러그인 추가

출처: 【22.04 LTS】 VIM Plug-in 설치하기 유틸리티/우분투 2023. 10. 20. 13:47 https://itlearningcenter.tistory.com/entry/%E3%80%901804-LTS%E3%80%91VIM-Plug-in-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0

```
sudo apt-get install vim git
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

`vi ~/.vimrc` - 플러그인에 대한 설명은 위쿨리님의 블로그 https://agvim.wordpress.com/2017/09/05/vim-plugins-100/  글을 읽어보시기 바랍니다.
```
" VIM 옵션
syntax on                        " 구문강조 사용
set autoindent                   " 자동 들여쓰기
set smartindent                  " 스마트한 들여쓰기
set cindent                      " C 프로그래밍용 자동 들여쓰기
set shiftwidth=4                 " 자동 들여쓰기 4칸
set tabstop=4                    " 탭을 4칸으로
set nobackup                     " 백업 파일을 안만듬
set nowrapscan                   " 검색할 때 문서의 끝에서 처음으로 안돌아감
set ignorecase                   " 검색시 대소문자 무시, set ic 도 가능
set hlsearch                     " 검색어 강조, set hls 도 가능
set number                       " 행번호 표시, set nu 도 가능
set nocompatible                 " 오리지날 VI와 호환하지 않음
set backspace=eol,start,indent   " 줄의 끝, 시작, 들여쓰기에서 백스페이스시 이전줄로
set ruler                        " 화면 우측 하단에 현재 커서의 위치(줄,칸) 표시
set cursorline                   " 편집 위치에 커서 라인 설정
set laststatus=2                 " 상태바 표시를 항상한다
set incsearch                    " 키워드 입력시 점진적 검색
set fencs=ucs-bom,utf-8,euc-kr.latin1   " 한글 파일은 euc-kr로, 유니코드는 유니코드로
set fileencoding=utf-8           " 파일저장인코딩
set tenc=utf-8                   " 터미널 인코딩
set background=dark              " 하이라이팅 lihgt / dark
set history=1000                 " vi 편집기록 기억갯수 .viminfo에 기록
set t_Co=256                     " 색 조정
highlight Comment term=bold cterm=bold ctermfg=4   " 코멘트 하이라이트
set wrap
set noswapfile
set lbr
"set visualbell                  " 키를 잘못눌렀을 때 화면 프레시
"set mouse=a                     " vim에서 마우스 사용

"
" VIM 플러그인 설치 목록
"
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'    " VIM 플러그인 관리 플러그인

Plugin 'airblade/vim-gitgutter'  " Git으로 관리하는 파일의 변경된 부분을 확인
Plugin 'scrooloose/nerdtree'     " 파일트리
Plugin 'scrooloose/nerdcommenter'   " 주석
Plugin 'taglist-plus'            " 소스파일의 클래스, 함수, 변수 정보 창
Plugin 'bling/vim-airline'       " 상태바(Vim 사용자의 하단 상태바를 변경)
Plugin 'vim-syntastic/syntastic' " 구문 체크
Plugin 'nanotech/jellybeans.vim' " 색상 테마 변경
Plugin 'ctrlpvim/ctrlp.vim'      " 하위 디렉토리 파일 찾기
Plugin 'Lokaltog/vim-easymotion' " 한 화면에서 커서 이동
Plugin 'surround.vim'            " 소스 버전 컨트롤
Plugin 'iwataka/ctrlproj.vim'    " 지정된 위치 프로젝트 파일 찾기
Plugin 'Quich-Filter'            " 라인 필터링
Plugin 'terryma/vim-multiple-cursors'   " 여러 커서에서 동시 수정
Plugin 'SirVer/ultisnips'        " 저장한 코드 조각 입력
Plugin 'mattn/emmet-vim'         " HTML, CSS 코드 단축 입력
Plugin 'HTML.zip'                " HTML 단축 입력
Plugin 'rking/ag.vim'            " 문자열 찾기
Plugin 'chrisbra/NrrwRgn'        " 라인 범위 지정 후 수정
Plugin 'MultipleSearch'          " 여러 문자열 동시에 강조
Plugin 'majutsushi/tagbar'       " ctags 결과 표시
Plugin 'xuhdev/SingleCompile'    " 하나의 파일 컴파일 후 실행
Plugin 'mhinz/vim-signify'       " 버전 관리 파일 상태 표시
Plugin 'tommcdo/vim-lion'        " 라인 정렬
Plugin 'tpope/vim-fugitive'      " Vim에서 git 명령어 사용
Plugin 'elzr/vim-json'           " JSON 파일 보기
Plugin 'AutoComplPop'            " 자동 완성(Ctrl + P)를 누르지 않음

call vundle#end()

filetype plugin indent on        " 파일 종류에 따른 구문강조
colorscheme jellybeans           " vi 색상 테마 설정

au FileType * setl fo-=cro       " 자동 주석 기능 해제

"
" ctrlp.vim 설정
"
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|public$\|log$\|tmp$\|vendor$',
  \ 'file': '\v\.(exe|so|dll)$'
\ }

"
" Tag list 설정
"
let Tlist_Use_Right_Window = 1
let Tlist_Auto_Open = 0
let Tlist_Exit_OnlyWindow = 0
let Tlist_Inc_Winwidth = 0
let Tlist_Ctags_Cmd = "/usr/bin/ctags"

"
" 단축키
"
map <F3> <C-w><C-v>
map <F4> <C-w><C-w>
map <F5> :NERDTreeToggle<cr>
map <F6> :TlistToggle<cr>
```

```
vim +PluginInstall +qall
```

설치가 끝나면 자동으로 터미널 입력 화면으로 바뀝니다. 이제 vim 혹은 vi를 실행하고 `<F5>`키와 `<F6>` 키를 누르시면 저와 같은 화면을 보실 수 있습니다.

240404-0917

| No. | ON/OFF | 서비스 포트 | 프로토콜 | IP 주소 | 내부 포트 | 설명 |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 1 | ONOFF | 13022-13022 | TCP | 192.168.219.13 | 22-22 | giga wifi ssh |
| 2 | ONOFF | 5800-5800 | TCP | 192.168.219.58 | 5800-5800 | pi4b lan ssh |
| 3 | ONOFF | 5822-5822 | TCP | 192.168.219.58 | 22-22 | ssh |
| 4 | ONOFF | 15800-15800 | TCP | 192.168.219.158 | 5800-5800 | pi4b wifi wikijs |
| 5 | ONOFF | 15822-15822 | TCP | 192.168.219.158 | 22-22 | ssh |
| 6 | ONOFF | 5900-5900 | TCP | 192.168.219.59 | 5900-5900 | opi lan wikijs |
| 7 | ONOFF | 5922-5922 | TCP | 192.168.219.59 | 22-22 | ssh |
| 8 | ONOFF | 5910-5910 | TCP | 192.168.219.59 | 21-21 | vsftpd |
| 9 | ONOFF | 45911-45911 | TCP | 192.168.219.59 | 45911-45911 | vsftpd pasv |
| 10 | ONOFF | 45912-45912 | TCP | 192.168.219.59 | 45912-45912 | vsftpd pasv |
| 11 | ONOFF | 45913-45913 | TCP | 192.168.219.59 | 45913-45913 | vsftpd pasv |
| 12 | ONOFF | 15900-15900 | TCP | 192.168.219.159 | 5900-5900 | opi lan wikijs |
| 13 | ONOFF | 15922-15922 | TCP | 192.168.219.159 | 22-22 | ssh |
| 14 | ONOFF | 15910-15910 | TCP | 192.168.219.159 | 21-21 | vsftpd |
| 15 | ONOFF | 55911-55911 | TCP | 192.168.219.159 | 55911-55911 | vsftpd pasv |
| 16 | ONOFF | 55912-55912 | TCP | 192.168.219.159 | 55912 | vsftpd pasv |
| 17 | ONOFF | 55913-55913 | TCP | 192.168.219.159 | 55913 | vsftpd pasv |

240404-0851

| No. | ON/OFF | 서비스 포트 | 프로토콜 | IP 주소 | 내부 포트 | 설명 |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| 1 | ONOFF | 13022-13022 | TCP | 9.9.9.13 | 22-22 | giga wifi ssh |
|   |       |   |   |   |   |   |
| 2 | ONOFF | 5800-5800 | TCP | 9.9.9.58 | 5800-5800 | pi4b lan wikijs |
| 3 | ONOFF | 5822-5822 | TCP | 9.9.9.58 | 22-22 | ssh |
|   |       |   |   |   |   |   |
| 4 | ONOFF | 15800-15800 | TCP | 9.9.9.158 | 5800-5800 | pi4b wifi wikijs |
| 5 | ONOFF | 15822-15822 | TCP | 9.9.9.158 | 22-22 | ssh |
|   |       |   |   |   |   |   |
| 6 | ONOFF | 5900-5900 | TCP | 9.9.9.59 | 5900-5900 | opi lan wikijs |
| 7 | ONOFF | 5922-5922 | TCP | 9.9.9.59 | 22-22 | ssh |
| 8 | ONOFF | 5910-5910 | TCP | 9.9.9.59 | 21-21 | vsftpd |
| 9 | ONOFF | 45911-45911 | TCP | 9.9.9.59 | 45911-45911 | vsftpd pasv |
|10 | ONOFF | 45912-45912 | TCP | 9.9.9.59 | 45912-45912 | vsftpd pasv |
|11 | ONOFF | 45913-45913 | TCP | 9.9.9.59 | 45913-45913 | vsftpd pasv |
|   |       |   |   |   |   |   |
|12 | ONOFF | 15900-15900 | TCP | 9.9.9.159 | 5900-5900 | opi wifi wikijs |
|13 | ONOFF | 15922-15922 | TCP | 9.9.9.159 | 22-22 | ssh |
|14 | ONOFF | 15910-15910 | TCP | 9.9.9.159 | 21-21 | vsftpd |
|15 | ONOFF | 55911-55911 | TCP | 9.9.9.159 | 55911-55911 | vsftpd pasv |
|16 | ONOFF | 55912-55912 | TCP | 9.9.9.159 | 55912-55912 | vsftpd pasv |
|17 | ONOFF | 55913-55913 | TCP | 9.9.9.159 | 55913-55913 | vsftpd pasv |
