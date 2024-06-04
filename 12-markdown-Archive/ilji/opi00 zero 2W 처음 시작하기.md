# 1. zero 2W 이미지 받기


## 1. orangepi 이미지 받기

### 1. 다운로드 사이트 http://www.orangepi.org 첫줄 메뉴에서,

1. [ `Download` 클릭 / Github / Wiki / Third Party Images ]
2. 아래로 스크롤 하다가, `Orange Pi Zero 2W` 클릭.
3. 넘어간 화면의 `Official Resources` 에서, Official Tools `Downloads` 클릭.
4. Office_Tools 에서, micro SD 를 포맷해주는
`Windows-Formatting Software-SDCardFormatter` 다운로드 하고 설치한다.
5. Office_Tools 에서, orangePi zero2W 이미지를 micro SD 에 설치해주는 
`Linux image burning tool-Win32DiskImager` 다운로드 하고 설치한다.

### 2. 위 `Official Resources` 화면 아래의 `Official Images` 에서,

1. `Ubuntu Image` 의 `Downloads` 를 눌러서,
2. `드라이브` 화면에서, `Linux6.1 kernel version image` **\>** `For development boards with`**4GB**`memory, please download ...` 를 다운로드 한다.
3. 다운로드가 끝나면, 
`Orangepizero2w_1.0.0_ubuntu_jammy_`**server**`_linux6.1.31-`**4gb**`.7z` 로 받은 `서버` 파일을 압축을 풀어서 
`Orangepizero2w_1.0.0_ubuntu_jammy_server_linux6.1.31.img` 파일의 위치를 확인한다.

## 2. Windows용 프로그램

### 1. USB, microSD 에 디스크 이미지를 저장하는 프로그램

- orangepi.org 에 게재된 프로그램: https://win32diskimager.org/

또는,
- Flash OS images to SD cards & USB drives, safely and easily. https://etcher.balena.io/
`Download Etcher` https://etcher.balena.io/#download-etcher > ETCHER FOR WINDOWS (X86|X64) (INSTALLER)

### 2. `PuTTY` 원격 터미널 프로그램

https://www.ssh.com/academy/ssh/putty/windows

### 3. `WinSCP` 원격 파일복사 프로그램

https://winscp.net/eng/download.php

### 4. `7-zip` 압축 프로그램

https://www.7-zip.org/

### 5. `GIMP` Gnu Image Manipulation Program 김프 이미지 프로그램

https://www.gimp.org/downloads/

### 6. windows 에서 bash 를 사용하려면

윈도우즈 10에서 드디어 bash shell을...!! 2018, APR 19 https://krauser085.github.io/microsoft-loves-linux/

1. 먼저 `설정` - `시스템` 으로 들어가서 윈도우 버전을 확인합니다.
1607 이하의 윈도우를 사용하고 계신분들은 윈도우즈 업데이트가 필요합니다.
1. `설정` - `업데이트 및 보안` - `개발자용` 에서 개발자 모드를 켭니다. `( O)` 켬
1. 설정에서  `[`**windows 기능** 켜기/끄기 `]` 로 검색 - [__] `Linux용 Windows 하위 시스템`(베타) 를 체크합니다.
----> 체크 후 확인 ----> 재시작
1. 재시작 후 콘솔에서 `bash`를 입력하면 리눅스가 설치되기 시작합니다.
중간에 로켈설정 확인이 나오는데 저는 그냥 `ko-KR`로 했습니다. 사용할 유저명과 암호를 입력하면 설치가 완료됩니다.

```
wsl --list --online

wsl --install -d ubuntu-2204

#-- https://aka.ms/wslstore ---> wsl.exe --update

bash

sudo apt update -y & sudo apt upgrade -y

dpkg -l | grep openssh

sudo apt install openssh-server
```

### 7. 추가:

`위키백과` 누구나 편집할 수 있는 다중 언어 웹 기반 자유 콘텐츠 백과사전 프로젝트 https://ko.wikipedia.org/

## 3. Putty 색상 지정

1. Putty 화면에서 마우스 오른클릭 > Change Settings...
1. Window > Appearances > Font settings > `D2Coding, 14-point` 선택
1. Window > Colors > 에서 아래와 같이 `글자 색깔을 변경`한다.
1. Default Background 4-19-19 / 100-115-115

| 검정  | R 빨강  | G 초록   | Y 노랑    | B 청색    | M 보라 | C 파랑 | 흰색 |
|:-----:|:-----:|:--------:|:--------:|:--------:|:------:|:------:|:---:|
| ANSI |d42c3a   |129e00   |c0a000    |2885ff     |b148c6     |00a89a    |231030월|
|0 - 0 - 0 |212 - 44 - 58|18 - 158 - 0 |192 - 160 - 0 |40 - 133 - 255 |177 - 72 - 198 |0 - 168 - 154 | |
|(Bold)|ff5f5f   |41e141   |ffff55    |7189ff     |ff55ff     |55ffff    | |
|0 - 0 - 0 |255 - 95 - 95|65 - 225 - 65|222 - 190 - 0 |113 - 137 - 255|207 - 102 - 228|30 - 198 - 184| |

### 폰트 받기

```
sudo rsync -avzr -e 'ssh -p 777' user@server:ftp/fonts/* /usr/share/fonts/
```

### 세팅값 저장 및 재설치

Mohammad Nazmul Huda Export Import Putty Registry Setting in Windows
https://www.nazmulhuda.info/export-import-putty-registry-setting-in-windows

1. windows 의 프로그램/파일 찾기에서 `regedit` 로 들어가서,
2. putty 의 registry setting 을 가져오기 위해, 다음 위치로 가서,
`HKEY_CURRENT_USER ---> Software ---> Simon Tatham ---> PuTTy`
3. PuTTy 폴더에 대고 오른쪽 마우스 버튼을누르고 `Export` 를 클릭해서 Putty 레지스트리를 가져온다.
4. 위치를 지정해서 Putty Registry Setting 을 'export-putty-231030' 등의 이름으로 저장한다.
5. 다른 컴퓨터에서 사용하려면, 저장한 파일을 컴퓨터에 복사한 다음, 그 파일을 더블클릭하고 [Yes] 를 눌러 레지스트리 설정에 추가한다.


## 4. microSD 에 이미지 설치

비워져 있어서 포매팅 해도 되는 micro SD 를 usb 에 연결하고,

1.Ubuntu 디스크 이미지를 SD 메모리에 저장하는 `Etcher` 프로그램을 실행한다.
2. `Image File` 은 위에서 압축을 푼 `Orangepizero2w_1.0.0_ubuntu_jammy_server_linux6.1.31.img` 로 지정한다.
3. `Device` 는 포맷한 usb 를 지정하고, [ Write ] 버튼을 클릭해서 설치를 진행한다.

## 5. microSD 를 본체에 장착

1. microSD 겉면에 80, 81, 82, ... 처럼 번호를 써 두고, 노트에 번호, 설치날짜 등을 기록한다.

| # | SD 번호 | 작성 날짜 | 내용 | 정리 내역 |
|:----:|:----:|:----:|:----:|:----:|
| 1 | 80 - 256GB | 240528월-1037 | orangepi server |  |
| 2 | 81 - 256GB | 240528월-1042 | orangepi xfce desktop |  |

2. 이미지를 다시 설치하면, 새로운 줄에 기록하고, 원래의 정리 내역에 새 기록의 줄번호를 쓴다.

| # | SD 번호 | 작성 날짜 | 내용 | 정리 내역 |
|:----:|:----:|:----:|:----:|:----:|
| 1 | 90 - 256GB | 240528월-1038 | orangepi server |  |
| 2 | 91 - 256GB | 240528월-1044 | orangepi server | 3 |
| 3 | 91 - 256GB | 240528월-1127 | orangepi android desktop |  |

3. 로그인 하는 사용자의 비번을 정하고 줄 뒤에 기록한다.

# 2. zero 2W 의 ip 확인하기

OrangePi zero 2W 에 모니터, 키보드를 `연결하지 않고` 다른 PC 에서 연결하는 경우.

OrangePi zero 의 ip 를 확인하는 아래 내용의 스크립트를 타이핑해서 실행한다.
인터넷 프로토콜: https://ko.wikipedia.org/wiki/인터넷_프로토콜#대표적인_IP_주소_체계

## 1. Windows 에서 확인하기

1. 끝번호가 11 부터 254 까지 되어있는 ip 주소를 하나씩 확인하고,
확인내역에 "time=" 문자열이 들어있는 것만 xxx 파일로 저장하는 스크립트를 실행시킨다.
```
cat <<__EOF__
for i in {11..254} ;do ping -n 1 192.168.999.${i} & done | grep "time<" > xxx
__EOF__
```

2. 저장한 파일을 보고, 살아있는 ip 주소를 확인한다.

`cat xxx`

```
Reply from 192.168.999.18: bytes=32 time<1ms TTL=255
...
Reply from 192.168.999.107: bytes=32 time<1ms TTL=128
Reply from 192.168.999.114: bytes=32 time<1ms TTL=128
Reply from 192.168.999.116: bytes=32 time<1ms TTL=128
Reply from 192.168.999.117: bytes=32 time<1ms TTL=128
Reply from 192.168.999.120: bytes=32 time<1ms TTL=128
...
```

윈도우의 경우, ip 주소를 확인하기 위해 다음 명령을 사용한다.
```
ipconfig | grep -B1 tm #-- Windows 의 ip 주소 확인.
```

## 2. Ubuntu 에서 확인하기:

1. 끝번호가 11 부터 254 까지 되어있는 ip 주소를 하나씩 확인하고,
확인내역에 "time=" 문자열이 들어있는 것만 xxx 파일로 저장하는 스크립트를 실행시킨다.

```
for i in {11..254} ;do ping -c 1 192.168.999.${i} & done | grep "time=" > ping-c1-$(date +%y%m%d%a-%H%M)
```

2. 저장한 파일을 보고, 살아있는 ip 주소를 확인한다.

`cat ping-c1-*`

```
64 bytes from 192.168.999.59: icmp_seq=1 ttl=64 time=0.097 ms
...
64 bytes from 192.168.999.103: icmp_seq=1 ttl=64 time=107 ms
64 bytes from 192.168.999.101: icmp_seq=1 ttl=64 time=343 ms
...
```

Ubuntu 의 경우, 컴퓨터의 ip 주소와 시스템 종류를 확인하는 명령.
```
ifconfig | grep -B1 tm #-- Linux 의 ip 주소 확인.
lsb_release -a #-- 시스템 종류 확인.
```

## 3. ip 를 하나씩 연결해 본다.

`ssh orangepi@192.168.999.104`

```
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
이와 같이 나오면, 제대로 연결이 된 것이다.

## 4. 공유기 선언내용

| No. | ON/OFF | 서비스 포트 | 프로토콜 | IP 주소 | 내부 포트 | 설명 |
|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
|   |       | giga WIFI | | | | |
| 1 | ONOFF | 13022-13022 | TCP | 9.9.9.13 | 22-22 | ssh |
|   |       | pi4b lan | | | | |
| 2 | ONOFF | 5840-5840 | TCP | 9.9.9.58 | 5840-5840 | wikijs |
| 3 | ONOFF | 5822-5822 | TCP | 9.9.9.58 | 22-22 | ssh |
|   |       | pi4b WIFI | | | | |
| 4 | ONOFF | 15840-15840 | TCP | 9.9.9.158 | 5840-5840 | wikijs |
| 5 | ONOFF | 15822-15822 | TCP | 9.9.9.158 | 22-22 | ssh |
|   |       | opi lan | | | | |
| 6 | ONOFF | 5940-5940 | TCP | 9.9.9.59 | 5940-5940 | wikijs |
| 7 | ONOFF | 5922-5922 | TCP | 9.9.9.59 | 22-22 | ssh |
|   |       | vsftpd | | | | |
| 8 | ONOFF | 5910-5910 | TCP | 9.9.9.59 | 21-21 | vsftpd |
| 9 | ONOFF | 45911-45911 | TCP | 9.9.9.59 | 45911-45911 | vsftpd pasv |
| 10 | ONOFF | 45912-45912 | TCP | 9.9.9.59 | 45912-45912 | vsftpd pasv |
| 11 | ONOFF | 45913-45913 | TCP | 9.9.9.59 | 45913-45913 | vsftpd pasv |
|    |       | opi WIFI | | | | |
| 12 | ONOFF | 15940-15940 | TCP | 9.9.9.159 | 5940-5940 | wikijs |
| 13 | ONOFF | 15922-15922 | TCP | 9.9.9.159 | 22-22 | ssh |
|   |       | vsftpd | | | | |
| 14 | ONOFF | 15910-15910 | TCP | 9.9.9.159 | 21-21 | vsftpd |
| 15 | ONOFF | 55911-55911 | TCP | 9.9.9.159 | 55911-55911 | vsftpd pasv |
| 16 | ONOFF | 55912-55912 | TCP | 9.9.9.159 | 55912 | vsftpd pasv |
| 17 | ONOFF | 55913-55913 | TCP | 9.9.9.159 | 55913 | vsftpd pasv |
|    |       | django 용 port | | | | |
| 18 | ONOFF | 5980 | TCP | 9.9.9.59 | 8000 | django |
| 19 | ONOFF | 15980 | TCP | 9.9.9.159 | 8000 | django |
|   |       | vsftpd | | | | |
| 20 | ONOFF | 15810-15810 | TCP | 9.9.9.158 | 21-21 | vsftpd |
| 21 | ONOFF | 55811-55811 | TCP | 9.9.9.158 | 55811-55911 | vsftpd pasv |
| 22 | ONOFF | 55812-55812 | TCP | 9.9.9.158 | 55812 | vsftpd pasv |
| 23 | ONOFF | 55813-55813 | TCP | 9.9.9.158 | 55813 | vsftpd pasv |
|    |       | django 용 port | | | | |
| 24 | ONOFF | 5880 | TCP | 9.9.9.58 | 8000 | django |
| 25 | ONOFF | 15880 | TCP | 9.9.9.158 | 8000 | django |

# 3. dash 를 bash 로 바꾸기

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

위 명령으로 설치후, `sudo cat /etc/default/locale` 명령으로 다음의 선언이 추가되었는지 확인한다.
```
#-- Ubuntu locale 한글로 설정하기  2019-11-04 https://jinmay.github.io/2019/11/04/linux/linux-change-locale-to-korean/
LANG=ko_KR.UTF-8
LC_MESSAGES=POSIX
LANGUAGE=ko_KR.UTF-8
#--
```

# 4. 프롬프트에 색상 지정하기

`vi ~/.bashrc` 명령으로 파일을 불러낸 뒤, `alias rm='rm -i'` 문장이 나오는 근처에서 아래 내용을 추가한다.
```
#----> 부터 추가
# \e[ 0 ; 36 m
# +++ |   || |
#  |  |   || +--- 색상 마크 끝남
#  |  |   |+--- 0회 1빨 2초 3노 4청 5보 6파 7흰
#  |  |   +---- 3x:글자색 4x:바탕색
#  |  +---- 00 01 02 흐림 03 이탤릭 04 밑줄 05 깜빡거림 06 07 반전 08 09 글자에 줄긋기 10
#  +---- 색상 마크 시작함
# \t 현재시각, \D{%a} 요일, \D{%y} 년2자리, \D{%m} 월, \D{%d} 일, \u 사용자 아이디,
# \h 호스트 이름, \w 현재의 전체 디렉토리, \n 줄바꿈, \W 현재 디렉토리만,
#--
cB="\[\e[" ;cE="\]" #-- 색깔 시작과 끝 표시
# 색깔지정의 구조: '\[' + '\e[' + '첫번째 1,2글자:글자형태' + '두번째 2글자:색깔' + '세번째 2글자:색>깔' + 'm' + '\]'
# 첫번째 => 0:보통 1:굵게 2:흐림 3:이탤릭 4:밑줄 5:깜빡거림 6 7:반전 8 9:글자에 줄긋기 10:
# 두번째/세번째의 앞글자 => 3x:글자색 4x:바탕색
# 두번째/세번째의 뒷글자 => x0:회 x1:빨 x2:초 x3:노 x4:청 x5:보 x6:파 x7:흰
cGray="${cB}0;30m${cE}"; cRed="${cB}0;31m${cE}"; cGreen="${cB}0;32m${cE}"; cYellow="${cB}0;33m${cE}"; cBlue="${cB}0;34m${cE}"; cMagenta="${cB}0;35m${cE}"; cCyan="${cB}0;36m${cE}"; cWhite="${cB}0;37m${cE}"; cReset="${cB}0m${cE}" #-- 보통 글자색
uGray="${cB}4;30m${cE}"; uRed="${cB}4;31m${cE}"; uGreen="${cB}4;32m${cE}"; uYellow="${cB}4;33m${cE}"; uBlue="${cB}4;34m${cE}"; uMagenta="${cB}4;35m${cE}"; uCyan="${cB}4;36m${cE}"; uWhite="${cB}4;37m${cE}"; #-- 굵은 글자색
# '\t' 12:34:56 시분초
# '\D' 날짜처리 '{' '}' 사이에 넣는것: %Y=2022 %y=22 %m=01 %d=28 %a=금
# \u 사용자아이디 \h 호스트이름 \w 현재 디렉토리
#
PS1="${cGreen}\t${uMagenta}\D{%y}${cGreen}\D{%m}${cYellow}\D{%d}${cRed}\D{%a} ${cBlue}\u${cCyan}@${cGreen}\h ${cCyan}\w\n${cGreen}\W${cReset} $ " #-- vu2404desk 240529
#--
#--PS1='\e[0;36m\t\e[04;35m\D{%y}\e[0;32m\D{%m}\e[0;33m\D{%d}\e[0m\e[0;31m\D{%a}\e[0;34m \u\e[0;36m@\e[0;34m\h\e[0m \e[0;32m\w\e[0m\n\W $ '
#--
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

# 5. 글꼴 다운로드

다음의 폰트들을 다운로드 하고, **윈도우 탐색기**에서 파일 위에 **오른쪽 마우스**로 `설치` 를 클릭해서 설치한다.

[ d2coding.ttf ](/tutorial/fonts/d2coding.ttf)
[ d2codingbold.ttf ](/tutorial/fonts/d2codingbold.ttf)
[ notomono-regular.ttf ](/tutorial/fonts/notomono-regular.ttf)
[ notosansmono-bold.ttf ](/tutorial/fonts/notosansmono-bold.ttf)
[ notosansmono-regular.ttf ](/tutorial/fonts/notosansmono-regular.ttf)

# 6. Bundle 플러그인 추가

출처: 【22.04 LTS】 VIM Plug-in 설치하기 유틸리티/우분투 2023. 10. 20. 13:47 https://itlearningcenter.tistory.com/entry/%E3%80%901804-LTS%E3%80%91VIM-Plug-in-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0

```
sudo apt-get install vim git
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

`vi ~/.vimrc` - 플러그인에 대한 설명은 위쿨리님의 블로그 https://agvim.wordpress.com/2017/09/05/vim-plugins-100/  글을 읽어보시기 바랍니다.
```
" VIM 옵션 240214-1354
syntax on                        " 구문강조 사용
set autoindent                   " 자동 들여쓰기
set smartindent                  " 스마트한 들여쓰기
set cindent                      " C 프로그래밍용 자동 들여쓰기
set shiftwidth=4                 " 자동 들여쓰기 4칸
set tabstop=4                    " 탭을 4칸으로
set nobackup                     " 백업 파일을 안만듬
" set nowrapscan                   " 검색할 때 문서의 끝에서 처음으로 안돌아감
set ignorecase                   " 검색시 대소문자 무시, set ic 도 가능
set hlsearch                     " 검색어 강조, set hls 도 가능
set number                       " 행번호 표시, set nu 도 가능
set nocompatible                 " 오리지날 VI와 호환하지 않음
set backspace=eol,start,indent   " 줄의 끝, 시작, 들여쓰기에서 백스페이스시 이전줄로
set ruler                        " 화면 우측 하단에 현재 커서의 위치(줄,칸) 표시
set cursorline                   " 편집 위치에 커서 라인 설정
set laststatus=2                 " 상태바 표시를 항상한다
set incsearch                    " 키워드 입력시 점진적 검색
" set fencs=ucs-bom,utf-8,euc-kr.latin1   " 한글 파일은 euc-kr로, 유니코드는 유니코드로
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

" Plugin 'airblade/vim-gitgutter'  " Git으로 관리하는 파일의 변경된 부분을 확인
Plugin 'scrooloose/nerdtree'     " 파일트리
" Plugin 'scrooloose/nerdcommenter'   " 주석
" Plugin 'taglist-plus'            " 소스파일의 클래스, 함수, 변수 정보 창
Plugin 'bling/vim-airline'       " 상태바(Vim 사용자의 하단 상태바를 변경)
" Plugin 'vim-syntastic/syntastic' " 구문 체크
" Plugin 'nanotech/jellybeans.vim' " 색상 테마 변경
" Plugin 'ctrlpvim/ctrlp.vim'      " 하위 디렉토리 파일 찾기
" Plugin 'Lokaltog/vim-easymotion' " 한 화면에서 커서 이동
" Plugin 'surround.vim'            " 소스 버전 컨트롤
" Plugin 'iwataka/ctrlproj.vim'    " 지정된 위치 프로젝트 파일 찾기
" Plugin 'Quich-Filter'            " 라인 필터링
" Plugin 'terryma/vim-multiple-cursors'   " 여러 커서에서 동시 수정
" Plugin 'SirVer/ultisnips'        " 저장한 코드 조각 입력
" Plugin 'mattn/emmet-vim'         " HTML, CSS 코드 단축 입력
" Plugin 'HTML.zip'                " HTML 단축 입력
" Plugin 'rking/ag.vim'            " 문자열 찾기
" Plugin 'chrisbra/NrrwRgn'        " 라인 범위 지정 후 수정
" Plugin 'MultipleSearch'          " 여러 문자열 동시에 강조
" Plugin 'majutsushi/tagbar'       " ctags 결과 표시
" Plugin 'xuhdev/SingleCompile'    " 하나의 파일 컴파일 후 실행
" Plugin 'mhinz/vim-signify'       " 버전 관리 파일 상태 표시
" Plugin 'tommcdo/vim-lion'        " 라인 정렬
" Plugin 'tpope/vim-fugitive'      " Vim에서 git 명령어 사용
" Plugin 'elzr/vim-json'           " JSON 파일 보기
" Plugin 'AutoComplPop'            " 자동 완성(Ctrl + P)를 누르지 않음

call vundle#end()

filetype plugin indent on        " 파일 종류에 따른 구문강조
" colorscheme jellybeans           " vi 색상 테마 설정

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

설치가 끝나면 자동으로 터미널 입력 화면으로 바뀝니다. 이제 vim 혹은 vi를 실행하고 `<F5>`키와 `<F6>` 키를 누르시면 저와 같은 화면을 보실 수 있습니다.

- 겨정의 비밀번호를 스크립트로 바꾸려면, 다음과 같이 패스워드를 지정해 준다. 리눅스 패스워드 한줄로 변경하기 2012. 9. 13. 20:00 | 리눅스
```
echo 'mypass*2024' | passwd --stdin myid
```
우분투 - 쉘 스크립트를 사용하여 사용자 암호를 변경 https://techexpert.tips/ko/ubuntu-ko/%EC%9A%B0%EB%B6%84%ED%88%AC-%EC%89%98-%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%98%EC%97%AC-%EC%82%AC%EC%9A%A9%EC%9E%90-%EC%95%94%ED%98%B8%EB%A5%BC-%EB%B3%80%EA%B2%BD/


# 7. 키보드 특수문자 이름 (231102 목)

출처: [IT상식]키보드의 특수문자 이름(명칭)을 정확히 알아볼까요? IT강사 이혜정|작성자 오피스위즈 https://blog.naver.com/h333j333/221132851951

다운로드 링크: [ 키보드 특수문자 이름 - 이혜정 엑셀강사 ](/ilji/2311/231102-키보드특수문자이름_이혜정_엑셀강사.pdf)

| 기호 | 영문 이름 | 한글읽기 | 한글 이름 |
|:----:|:----:|:----:|:----:|:----:|
| \` | GRAVE. back quote | 그레이브, 백 쿼트 _ | 물결표시 아래 따옴표 |
| ~ | Tilde | 틸드 | 물결표시 |
| ! | Exclamation Point | 엑스클러메이션 포인트 | 느낌표 |
| @ | At Sign /Commercial At | 앳 사인, 커머셜 앳 | 골뱅이 |
| # | Crosshatch/Sharp | 크로스해치, 샵 | 샵, 우물 정 |
| $ | Dollar Sign | 달러사인 | 달러 |
| % | Percent Sign | 퍼센트사인 | 퍼센트 |
| ^ | Circumflex/caret | 서컴플렉스, 캐럿 | 위로 꺽쇠, 웃는 눈 |
| & | Ampersand | 앰퍼샌드 | 앤드 마크  |
| * | Asterisk | 애스터리스크 | 별표 |
| - | Minus Sign/Hyphen/Dash | 마이너스사인, 하이픈, 대시 | 빼기, 마이너스 |
| _ | Underscore/Underline | 언더스코어, 언더라인 | 밑줄 |
| = | Equal Sign | 이퀄 사인 | 등호, 이퀄, 같다 |
| + | Plus Sign | 플러스 사인 | 더하기, 플러스 |
| " | Quotation Mark | 쿼테이션 마크 | 큰 따옴표 |
| ' or ’ | Apostrophe | 어퍼스트로피 | 작은 따옴표 |
| , | Comma| 콤마 | 쉼표, 콤마 |
| . | Period, Full Stop | 피리어드, 풀스탑 | 점, 마침표 |
| ? | question Mark| 퀘스천 마크 | 물음표 |
| / | Slash/Virgule | 슬래시, 버귤 | 슬러쉬 |
| \\ | Back Slash | 백슬래시 _ | 역슬러쉬, 백슬러쉬 |
| \ | Won sign | 원사인 | 원, 원화 |
| \| | Vertical Bar | 버티컬바 _ | 세로줄, 파이프 |
| : | Colon | 콜론 | 콜론, 땡땡 |
| ; | Semicolon | 세미콜론 | 세미콜론 |
| ( | Left Parenthesis | 레프트 퍼렌써시스 | 소괄호 열고 |
| ) | Right Parenthesis | 라이트 퍼렌써시스 | 소괄호 닫고 |
| { | Left Brace | 레프트 브레이스 | 중괄호 열고 |
| } | Right Brace | 라이트 브레이스 | 중괄호 닫고 |
| [ | Left Bracket | 레프트 브래킷 | 대괄호 열고 |
| ] | Right Bracket | 라이트 브래킷 | 대괄호 닫고 |
| < | Less Than Sign/Left Angle Bracket | 레스댄 사인, 레프트 앵글브래킷 | 작다, 꺽쇠 열고 |
| > | Greater Than Sign/Right Angle Bracket | 그레이터댄 사인, 레프트 앵글 브래킷 | 크다, 꺽쇠 닫고 |

![ 특수문자이름정리 이혜정엑셀강사 ](/ilji/2311/231102-특수문자이름정리-이혜정엑셀강사.webp)

# 8. 사용자 이름 변경하기

출처: aeong-dev 2023. 4. 20. 21:18 https://aeong-dev.tistory.com/8

1. Ubuntu 22.04 의 임시 사용자를 만들고 sudo 권한 부여.

사용자 이름을 변수로 정한다.
```
TMPUSR="tmpusr" ; OLDUSR="orangepi" ; NEWUSR="newusr"
echo "TMPUSR=${TMPUSR} ; OLDUSR=${OLDUSR} ; NEWUSR=${NEWUSR} # <----"
```

임시 사용자를 만든다.
```
sudo adduser ${TMPUSR} #-- 임시 사용자를 추가한다.
sudo adduser ${TMPUSR} sudo #- 새로 만든 임시 사용자에게 sudo 권한을 부여한다.
```

2. 지금 로그인 한 터미널 창에서 로그아웃 후, 생성한 임시 사용자로 다시 로그인.

진행 중인 process 가 있으면 안되는데, ssh 연결이 붙어있다는 것 자체가 process가 있다는 것이기 때문에, 꼭 임시 사용자로 로그인하고 진행한다.

3. 기존 사용하던 사용자 이름으로 진행 중인 모든 process 죽이기.
```
sudo pkill -u ${OLDUSR} pid
sudo pkill -9 -u ${OLDUSR}
```

이거 안해주면 process 있다고 다음 스텝 진행이 안됨. 아래 문구처럼 에러 뜸.
```
# usermod : user ${OLDUSR} is currently used by process 16555
```

4. 사용자 이름을 바꾸고, 바뀐 사용자 이름으로 홈 디렉토리도 바꾼다.
```
sudo usermod -l ${NEWUSR} ${OLDUSR}
sudo usermod -d /home/${NEWUSR} -m ${NEWUSR}
``` 

5. group name 변경.
```
sudo groupmod -n ${NEWUSR} ${OLDUSR}
#-- 확인하기
id ${NEWUSR}
ls -ld /home/${NEWUSR}
```

6. 접속 끊고 변경된 사용자 이름으로 로그인.

```
$ exit
...

$ ssh ${NEWUSR}@op
```

위에서와 마찬가지로, 진행 중인 process 가 있다면 임시 사용자의 삭제가 안되기 때문에 임시 사용자의 process 를 삭제한다.
```
sudo pkill -u ${TMPUSR} pid
sudo pkill -9 -u ${TMPUSR}
```

7. 임시 사용자 계정 및 디렉토리 삭제.
```
sudo deluser ${TMPUSR}
sudo rm -r /home/${TMPUSR}
```

# 9. 3d 프린터 무료 대여

1. 무료 3D프린터 대여 & 이용할 수 있는 곳들을 모아봤어요. by SB3D 2022. 4. 20. https://ssb3d.tistory.com/10
전국 무료 3D프린터 대여 공간
메이커스페이스(전국 다수) https://www.makeall.com/home/kor/main.do
무한상상실(전국 13개 시도) https://ideaall.net/sub3/sub3.php
양주시 청년센터 https://www.yangju.go.kr/youth/selectTnLendFcltyListU.do?key=3183
거제시 통통 3D메이커공방 https://blog.naver.com/geojecity/222621374513
3D프린팅 대구센터 https://www.3dprinter.or.kr/page/join/info_equip.php
1. 무료로 3D프린터 파일 출력하는 방법 (장소 및 방법)  https://creatorjo.tistory.com/entry/%EB%AC%B4%EB%A3%8C%EB%A1%9C-3D%ED%94%84%EB%A6%B0%ED%84%B0-%ED%8C%8C%EC%9D%BC-%EC%B6%9C%EB%A0%A5%ED%95%98%EB%8A%94-%EB%B0%A9%EB%B2%95%EC%9E%A5%EC%86%8C-%EB%B0%8F-%EB%B0%A9%EB%B2%95
중소벤처기업부 창업진흥원 > 메이커 스페이스 (열린 제작실) https://www.makeall.com/home/kor/main.do
1. 프로필 3D프린팅&3D펜 체험교육(2인 이상) 3D프린터와 3D펜 창의 융합 체험 교육 놀이 1인 24,000원/2인 이상 예약가능 리뷰 2 https://booking.naver.com/booking/5/bizes/224395
서울특별시 마포구 동교동 166-14, (양화로 176) 와이즈파크 7층 서울시 2호선 홍대입구역 8번출구 앞 와이즈파크 빌딩 7층 02-3141-5557
1. 와우쓰리디 HOME > 교육과정 > 모집중인과정 http://www.wow3d.co.kr/?c=25/27
1. 소상공인 지식배움터 전문기술교육 https://edu.sbiz.or.kr/edu/user/spt/atnlcReqst/atnlcProgrmList.do
1. 성북창작소 https://blog.naver.com/sbcreative/223455056400
공지 성북창작소 5월 장비활용교육 완료 2024. 5. 22.
공지 [성북창작소] 창업(아이디어) 멘토링 공지 2024. 4. 24.
공지 [성북창작소] 기초장비교육영상 - 레이저 커팅기 2024. 5. 9.
공지 [성북창작소] 기초장비교육영상 - 3D프린터 2024. 5. 7.
공지 [성북창작소] 공유누리 예약하기! #장비 #교육 #공간 #예약 2022. 5. 4.	

먼저! "공유누리" 라는 아래의 홈페이지에 들어갑니다
www.eshare.go.kr
[로그인] 또는 [회원가입]을 해주셔야 예약이 가능합니다!

로그인을 하셨다면
첫번째 상단 메뉴인 [공유신청·예약]을 클릭해줍니다!
다음, 자원명에 [성북창작소]를 검색!
성북창작소가 짜잔~!!

뭐라구요?
다목적실이 아닌 장비를 이용하고 싶어요...
장비는 아래의 순서대로 따라와주세요!
[공유신청·예약]   ->   [물품(생활,사무,교통)]   ->   성북창작소 검색!
다양한 성북창작소의 장비 중 원하는 것을 선택!

다음, 날짜를 선택하는 페이지가 나옵니다
회색으로 빗금이 쳐져있는 날짜는 예약이 차있는 상태이니
[예약가능]한 날짜 중 선택해주시면 됩니다
원하는 날짜를 선택 후 예약하기를 누르시기 전에!!!
예약화면 하단의 상세설명과 주의사항을 반드시!! 꼭!! 꼭!! 
읽어주시기를 간곡히 부탁드립니다.

-예약 승인 후 이용이 가능하며, 취소 및 변경은 전화,이메일 문의 바랍니다.
-예약 승인 가능 시간 : 평일 11:00~ 20:00 
(당일 예약 불가 / 사용 1일전 20:00 전 까지만 예약 가능합니다!)
마지막으로 간단하게 신청서 작성만 해주시면
이제 예약한 날짜에 방문 후 장비를 이용하시면 됩니다!

아직 잘 모르겠다구요?
【전화】 070-8844-6669
【이메일】 sb@fixfree.co.kr
으로 문의해주시기 바랍니다!
그럼 성북창작소에서 만나요~~👋👋
이번 포스팅으로
성북창작소 를 이용하시는데
도움이 되셨으면 하네요!

※ 코로나19 방역 수칙을 준수하고 있으며,
입 퇴실 시 체온체크 및 방문 체크 진행 중 입니다.
이용자분들의 협조 바랍니다!
【 운영시간 】평일 11:00 - 21:00 ( 주말, 공휴일 휴무 )
【 연락처 】 070 - 8844 - 6669
【 이메일 】 sb@fixfree.co.kr
© NAVER Corp. 북창작소 울특별시 성북구 오패산로1길 57
● KT 월곡지사 혹은 종암사거리 하차 후 도보 5분
● 월곡역 혹은 길음역 하차 후 도보 15분 (월곡역 2번 출구, 길음역 5번 출구 이용)
● 주차 3대 가능 (차량 방문자는 사전에 말씀해주시면 방문용 스티커를 부착해 드립니다).
​[출처] [성북창작소] 한번에 알아보기 #소개 #예약|작성자 성북창작소

