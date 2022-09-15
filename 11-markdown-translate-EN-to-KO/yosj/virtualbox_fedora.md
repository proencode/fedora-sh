# 파일 내려받기

## 1. Fedora 설치 이미지 다운로드
1. Windows 에서,
1. 크롬 브라우저 에서 https://getfedora.org/ 접속
1. 왼쪽아래 Fedora WONRKSTATION > [`지금 내려받기`] 클릭
1. 오른쪽 > x86_64를 위해: 페도라 35: x86_64 DVD ISO > [`내려받기`] 클릭
1. 파일 탐색기 > 내 PC > 다운로드 > Fedora-Workstation-Live-x86_64-36-1.5.iso 파일 확인

## 2. 버추얼박스 프로그램 다운로드
1. 크롬 브라우저 > https://virtualbox.org > 왼쪽메뉴 [`Downloads`] 클릭
1. 중간 VirtualBox 6.1.38 platform packages 아래 > [`Windows hosts`] 클릭 해서 다운로드
1. 브라우저 밑에 다운로드된 파일
  a. 브라우저 아랫줄의 `^` 표시 클릭해서 [`열기`] 하거나,
  b. 파일 탐색기 > 내 PC > 다운로드 > VirtualBox-6.1.38-153438-Win.exe 더블클릭 해서 설치

# 버추얼박스에 Fedora 설치

## 3. VirtualBox 에서 설치환경 준비

1. `윈도우 키 + S` 누르고 `vir` 입력해서 `VirtualBox` 실행
1. `VirtualBox 관리자`에서 위 가운데쪽의 [`새로 만들기`] 클릭
1. 이름 및 운영 체제 > 새로 만드는 `.vdi 의 이름` [ ***yosjfedora*** ] 입력 > [`다음`] 클릭
1. 메모리 크기 = (호스트의 실제 메모리 빼기 (-) 1GB) 의 절반 >> 8192M - 1024M =
7168M / 2 = `3584M` 또는 `4096M` 을 메모리 크기로 지정한다 >> [`다음`] 클릭
1. 하드 디스크 > `(o) 지금 새 가상 하드디스크 만들기 (C)`  > [`만들기`] 클릭
1. 하드 디스크 파일 종류 > `(o) VDI` > [`다음`] 클릭
1. 물리적 하드 드라이브에 저장 > `(o) 동적 할당` > [`다음`] 클릭
1. 파일 위치 및 크기 > 기본 8 GB 인데, [ `30` ] GB 로 하고 > [`만들기`] 클릭

## 4. Fedora 설치 시작

1. VirtualBox관리자의 왼쪽 ***yosjfedora*** 를 클릭해서 선택하고,
1. 위 오른쪽의 [`시작`] 클릭해서 ***yosjfedora*** 실행
1. 시동 디스크 선택 > 아래 오른쪽 `폴더 아이콘`에서 [`가상 광 디스크 파일 선택`] 클릭
1. [`추가`] 클릭 > 내 PC > 다운로드 > 
이미지 파일 (Fedora-Workstation-Live-x86_64-36-1.5.iso) 더블 클릭
1. 파일이 선택됐으므로 [`선택`] 클릭
1. [`시작`] 선택
1. Start Fedora-Workstation-Live 선택
주르륵 글씨가 흘러내린다.

## 5. 설치 진행

1. Try Fedora 말고, [`Install to Hard Drive`] 클릭
1. 똑같은 화면이 또 나온다. 
이 화면이 진짜이므로 다시 한번 [`Install to Hard Drive`] 클릭
1. ***FEDORA 36 에 오신 것을 환영합니다.*** 라고 나오면 한글이 선택된 것이고,
영어등 다른 글자로 표시가 되면, 
가운데 나열된 언어 중에서 [`한국어 Korean`] 을 선택한다.
1. [`계속 진행`] 클릭
1. 가운데 오른쪽 [`설치 목적지`] 클릭 > [`완료`] 클릭 > 
조금 기다리면 [`설치 시작`] 버튼이 정상 표시된다.
1. [`설치 시작`] 클릭
1. 설치 진행 > [`설치 종료`] 클릭
1. 전체화면의 오른쪽 위 [`x`] 닫기 클릭 > `(o)` 시스템 전원 끄기 > [`확인`] 클릭

## 6. 설치 디스크 꺼내기

1. Windows 에서,
1. VirtualBox관리자의 왼쪽 ***yosjfedora*** 를 클릭해서 선택하고,
1. 오른쪽 중간 [`저장소`] 클릭
1. 가운데에서 컨트롤러: IDE 아래,
[`Fedora-Workstation-Live-x86_64-36-1.5.iso`] 클릭
1. 오른쪽 속성 > 광학 드라이브 [`IDE 세컨더리 마스터`] 
오른쪽의 [`CD모양 아이콘`] 클릭
1. [`가상 드라이브에서 디스크 꺼내기`] 클릭 > [`확인`] 클릭 > 맨 아래 [`확인`] 클릭

## 7. vdi 파일 압축

1. Windows의 파일 탐색기에서 `yosjfedora.vdi` 파일을 오른쪽 마우스 클릭
2. 나열된 선택 중에서 `7-zip` 에 마우스를 대고 > `압축 파일에 추가` 클릭
	-> 윈도우11 인 경우, `더 많은 옵션 표시` 클릭하고 `7-zip` > `압축 파일에 추가` 클릭
3. `압축파일(A)` 에서 `yosjfedora36.00-init-220815.7z` 와 같이 지정하고,
4. `볼륨 나누기, 바이트(V)` => `3900M` (USB 에 담기 위해서)
	`암호화` > `암호입력` => QQQQ (압축해제시 사용)
  `[v] 암호 보기` > `[확인]` 클릭해서 압축한다.

# 초기화 작업

## 8. Fedora 설치후 사용자 등록

1. Windows 에서,
1. 버추얼박스 관리자의 왼쪽 아이콘에서 ***yosjfedora*** 를 클릭해서 선택하고
위 오른쪽 아이콘 [`시작`] 클릭해서 fedora 가상 시스템을 시작한다.
1. Fedora Linux 99 사용을 환영합니다! > [`설정 시작`] 클릭
1. 개인 정보 > 위치 정보 서비스 (--O) -> `(O--)` 닫고 > [`다음`] 클릭
1. 서드 파티 저장소 > [`다음`] 클릭
1. 온라인 계정 연결 > [`건너뛰기`] 클릭
1. 사용자 정보 > 전체 이름 [`yosj`] > `로그인 하는 사용자 이름`을 입력하고 [`yosj`] > [`다음`] 클릭
1. 암호 지정 > 암호 [`****`] > [`다음`] 클릭
1. [`Fedora Linux 시작`] 클릭

## 9. 첫 터미널 실행

1. 좀 기다리면, Welcome to GNOME !! 이 나온다. [`괜찮습니다`] 선택
1. 앞에서 이름/비번 이 지정됐으므로 바로 로그인이 된 상태이며, 로그인 하자마자,`현재 활동` 이라고 부르는 검색 화면이 먼저 뜬다.
- 이스케이프 [`Esc`] 키 를 눌러서 검색을 중단하고 OS 로 들어가거나,
- 다음과 같이 입력해서 프로그램을 실행시키거나,
`ter` -> terminel 터미널 화면
`fir` -> firefox 브라우저
`nau` -> nautilus 파일 탐색기
`rhy` -> 리듬박스
`goo` 또는 `chr` -> 구글 크롬 브라우저를 설치한 경우 크롬 띄울때.
- 아이콘을 클릭해서 프로그램을 실행시키거나,
3. 다시 `현재 활동`으로 들어가려면, -> `윈도우 키`

## 10. 화면크기 변경

1. 맨윗줄의 메뉴중 **파일** / **머신** / **보기** / **입력** / `장치` > `클립보드 공유` > `양방향` 클릭해서 선택한다.
1. 맨윗줄의 메뉴에서 `보기` > `전체 화면 모드` 선택
--> 선택 했다가 원래대로 바꾸려면, 화면 바닥 중앙에 마우스를 대면 선택 메뉴가 나온다.
==> 이것이 불편하면, 화면 최상단 `_ ㅁ x` 에서 `ㅁ`최대화 를 누르는 것이 제일 쉽다.

## 11. 터미널에 한글폰트 적용하기

한글 폰트를 설치하기 전에, 먼저 글자 크기등을 바꾸어서 보기 편하도록 한다.
1. 터미널 제목창 오른쪽의 3자 아이콘 (`햄버거 버튼`) 클릭 > 기본 설정 > 
왼쪽 아래 프로파일 아래에 있는 [`이름없음(v)`] 클릭
1. 텍스트 > 사용자 지정 글꼴 > [`Monospace`] 클릭 > 글자 크기를 14 로 지정
1. 텍스트 옆에 있는 [`색`] 클릭 > 글자색중 빨간색, 노란색, 파란색이 너무 어두워서 보기 불편하면,
각각의 색상을 클릭하고, 십자선으로 지정한 색깔위치를 오른쪽으로 움직여서 적당한 색으로 바꾸면 된다.

# 한글 설정

## 12. 한글 입력 세팅

1. 버추얼박스 에서,
1. 맨윗줄 오른쪽 끝에는 `ko 옮 <)) (^)` 이처럼 표시 되어야 하는데,
`EN` 또는 `한` 이나 `ko` 표시가 없이 `옮 <)) (^)` 만 있는 경우,
  - 다음의 명령을 터미널에서 입력해서 한글처리 프로그램을 실행한다.
```
echo "" ; echo "" ; echo ""
echo "#-- (3) 화면에 EN 또는 한 이나 ko 표시가 없는 경우에 사용합니다."
echo "#----> press Enter:"
read aecho "#-- (3-1) ibus exit --> 한글입력 프로그램을 종료합니다."
ibus exit
echo "#----> press Enter:"
read a
echo "#-- (3-2) ibus-daemon & --> 한글입력 프로그램을 백그라운드로 실행합니다."
ibus-daemon &
```
1. 맨윗줄 오른쪽 끝에 있는 `ko  옮  <))  (^)` 클릭 > `설정` 클릭
1. 왼쪽 메뉴에서 [`키보드`] 선택하고,
`키보드` 클릭 > 윗줄 가운데 `입력 소스` 에서, 한국어 (Hangul) 을 첫줄에 놓기 위해서
  [`세로점세개 아이콘`] 클릭 > [`위로 이동`] 클릭 > 첫줄로 올라간다.
1. `ko` 클릭 > `한국어 (Hangul)` 클릭 > ko 가 EN 으로 바뀐다.
1. `EN` 또는 `한` 클릭 > `설정` 클릭 > iBus 한글 설정 화면이 나오면 >
  1. [`v`] 단어 단위로 입력 클릭 -> 체크 표시
  1. [` `] 자동 순서 교정 클릭 -> 체크 해제
  1. 아래쪽 `한영 전환키`에서
    1. `[추가]` 클릭
    1. 키보드에서 [`한글`] 키 또는 스페이스바 오른쪽 [`Alt`] 키 클릭 > [`확인`] 클릭
    1. 맨아래 [`확인`] 클릭
1. 터미널에서 알파벳 치다가 한글키 (Alt키) 치면 한글로 나온다.

## 13. 한글폰트 설치

#### 1. 폰트 설치하기 전에 프로그램을 업데이트하고, 임시 디렉토리를 만든다.
```
echo "" ; echo "" ; echo ""
sudo time dnf -y update ; echo "#-- (1-1) 푸른숲도서관 36.00 처음 설치후 400.37user 61.14system 14:50.64elapsed 51%CPU"
mkdir ~/tmp ; cd ~/tmp echo "#-- (1-2) 임시 디렉토리를 만듭니다."
```

#### 2. D2Coding 폰트를 설치한다.
```
sudo ls -l /usr/share/fonts/D2Coding ; sudo rm -rf /usr/share/fonts/D2Coding ; sudo mkdir /usr/share/fonts/D2Coding ; echo "#-- (2-1) 폴더를 지우고 새로 만듭니다."
time wget --no-check-certificate --content-disposition https://github.com/naver/d2codingfont/releases/download/VER1.3.2/D2Coding-Ver1.3.2-20180524.zip ; echo "#-- (2-2) 폰트 내려받기"
time 7za x D2Coding-Ver1.3.2-20180524.zip ; echo "#-- (2-3) 폰트 압축해제"

#|  ----> 이때,
#|  bash: 7za: 명령을 찾을 수 없습니다...
#|  'p7zip' 명령을 제공하는 '7za' 꾸러미를 설치하시겠습니까? [N/y]
#|  ----> 라고 나오면, [y 엔터] 를 눌러서 설치하고 진행하면 된다.

sudo mv D2Coding/* /usr/share/fonts/D2Coding/ ; echo "#-- (2-4) 폰트를 옮깁니다."
sudo chown -R root.root /usr/share/fonts/D2Coding ; echo "#-- (2-5) 소유자를 root.root 로 지정합니다."
sudo chmod 755 /usr/share/fonts/D2Coding ; echo "#-- (2-6) 폴더의 모드를 rwxr-xr-x 로 지정합니다."
sudo chmod 644 -R /usr/share/fonts/D2Coding/* ; echo "#-- (2-7) 모든 파일을 rw-로 지정합니다."
sudo ls -l /usr/share/fonts/ | grep D2Coding ; sudo ls -l /usr/share/fonts/D2Coding ; echo "#-- (2-8) 복사내역 확인"
rm -rf * ; echo "#-- (2-9) 나머지 필요없는 파일을 삭제합니다."
```

#### 3. Seoul 폰트를 설치한다.
```
sudo ls -l /usr/share/fonts/seoul ; sudo rm -rf /usr/share/fonts/seoul ; sudo mkdir /usr/share/fonts/seoul ; echo "#-- (3-1) 폴더를 지우고 새로 만듭니다."
time wget --no-check-certificate --content-disposition https://www.seoul.go.kr/upload/seoul/font/seoul_font.zip ; echo "#-- (3-2) 폰트 내려받기"
time 7za x seoul_font.zip ; echo "#-- (3-3) 폰트 압축해제"
sudo mv */Seoul*.ttf /usr/share/fonts/seoul/ ; echo "#-- (3-4) 폰트를 옮깁니다."
sudo chown -R root.root /usr/share/fonts/seoul ; echo "#-- (3-5) 소유자를 root.root 로 지정합니다."
sudo chmod 755 /usr/share/fonts/seoul ; echo "#-- (3-6) 폴더의 모드를 rwxr-xr-x 로 지정합니다."
sudo chmod 644 -R /usr/share/fonts/seoul/* ; echo "#-- (3-7) 모든 파일을 rw-로 지정합니다."
sudo ls -l /usr/share/fonts/ | grep D2Coding ; sudo ls -l /usr/share/fonts/D2Coding ; sudo ls -l /usr/share/fonts/ | grep seoul ; sudo ls -l /usr/share/fonts/seoul ; echo "#-- (3-8) 복사내역 확인"
rm -rf * ; echo "#-- (3-9) 나머지 필요없는 파일을 삭제합니다."
```

## 14. 터미널에 한글폰트 적용하기

1. 터미널 제목창 오른쪽의 3자 아이콘 (`햄버거 버튼`) 클릭 > 기본 설정 > 
왼쪽 아래 프로파일 아래에 있는 [`이름없음(v)`] 클릭 -> `이름없음` 이라는 이름도 옆의 아래쪽 화살표를 눌러서 이름을 바꿀수 있다.
1. 텍스트 > 사용자 지정 글꼴 > [`Monospace`] 클릭 > 
`D2Coding` 선택하고 > 크기를 `14` 로 지정
1. 텍스트 옆에 있는 [`색`] 클릭 > 글자색중 빨간색, 노란색, 파란색이 너무 진하므로 
각각의 색상을 클릭하고, 십자선으로 지정한 색깔위치를 오른쪽으로 움직여서 적당한 색으로 바꾸면 된다.

# 프로그램 추가

## 15. Google-Chrome 설치
```
sudo time dnf -y install fedora-workstation-repositories ; echo "#-- (14-1) 3rd Party 저장소 설치"
sudo time dnf config-manager --set-enabled google-chrome ; echo "#-- (14-2) Google 크롬 리포지토리를 활성화합니다."
sudo time dnf -y install google-chrome-stable ; echo "#-- (14-3) 구글 크롬을 설치합니다."
```

## 16. 기타 프로그램 추가 설치
```
sudo time dnf -y install make automake autoconf gcc dkms kernel-debug-devel kernel-devel ; echo "#-- (15-1) 커널 컴파일용 프로그램 설치"
sudo time dnf -y install wget vim-enhanced vim-common mc git p7zip gnome-tweak-tool rclone livecd-tools liveusb-creator ; echo "#-- (15-2) 추가 프로그램을 설치합니다."
rpm -qa | grep kernel | sort | grep kernel ; echo "#-- (15-3) kernel 버전 확인"
sudo systemctl enable sshd ; sudo systemctl start sshd ; echo "#-- (15-4) sshd 데몬을 등록하고 실행합니다."

#-> https://itlearningcenter.tistory.com/entry/%E3%80%901804-LTS%E3%80%91VIM-Plug-in-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0$
time git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim ; echo "#-- (15-5) VundleVim 설치"
cat <<__EOF__
#-
#- .bashrc .vimrc 를 복사하기 위해, "연결하시겠습니까" 에 yes 입력하고, 비번을 입력하세요.
#-
__EOF__
rsync -avzr -e 'ssh -p 13022' yos@proen.duckdns.org:/opt/usb22/yscart* .
mv yscartDOTbashrc ~/.bashrc
mv yscartDOTvimrc ~/.vimrc
cat <<__EOF__
#-
#- Bundle을 설치하기 위해 엔터를 입력하세요.
#-
__EOF__
vim +BundleInstall +qall ; echo "#-- (15-6) Bundle 프로그램을 설치합니다."
```

## 17. 요일 표시 및 Caps Lock 키 사용 안 함

1. 윈도우 키 눌러서 `현재 활동` 으로 들어가서 > 점 아홉개 있는 `프로그램 표시` 클릭
2. 나열된 아이콘들 중에서 `유틸리티` 클릭 > `유틸리티` 중에서 `기능 개선` 클릭
3. 왼쪽의 메뉴에서 > `최상위 표시줄` 클릭 > `요일` 의 `(O--)` 클릭해서 맨윗줄 날짜에 요일을 표시하도록 `(--O)` 로 만든다.
4. 왼쪽의 메뉴에서 > `키보드와 마우스` 클릭
	 `키보드` 제목의 메뉴중 `바로가기 키 개요` 에서 `추가 배치 옵션` 클릭
5. `추가 배치 옵션` 에서 `|> Caps Lock 키 동작` 클릭 > `사용 안함` 을 `(O) Caps Lock 키 사용 안 함` 으로 바꾼다.

## 18. sudo 에 비번을 입력하지 않으려면

1. /etc/sudoers 파일을 수정한다.
```
vi /etc/sudoers
```
2. vi 명령어로 `G10kyyp` 입력해서 복사하고, `3cw%hnfedora`[ESC] 를 입력해서, 
  맨앞에 있는 리마크 문자 `#` 을 빼고, 실제 `유저 아이디`로 바꾼다.
```
# %wheel        ALL=(ALL)       NOPASSWD: ALL
%hnfedora       ALL=(ALL)       NOPASSWD: ALL #- 이와같이 사용자 (예를 들면 hnfedora) 를 등록합니다.
```
3. vi 명령어에서 끝내려면, `:x` 를 입력한다.
여기서 수정한 `/etc/sudoers` 파일은 ReadOnly 옵션이 있으므로 `:x!` 와 같이 강제하는 권한 `!` 를 추가한다.

## 19. 터미널 프롬프트 에 날짜,시각 과 색깔 넣기

1. 홈 디렉토리에 에 있는 .bashrc 파일을 `vi ~/.bashrc` 명령으로 열고,
`alias rm='rm -i'` 가 있는 줄의 근처에 다음 줄을 끼워넣는다.
```
PS1='\e[0;32m\t\e[0m \e[0;33m\D{%a}\e[0;36m \D{%Y-%m-%d} \e[0;35m\u\e[0;33m@\e[0;32m\h\e[0m \e[0;33m\w\e[0m\n\W $ '
# ------------------------------------------------------------^^ !!     ^^ !     ^^ !!           ^^ !!
# ----------------------------------------------------------- user ---- @ ------ host_name ----- dir
```

# 윈도우-페도라 공유폴더 설정

## 20. 네트워크 및 공유 폴더 추가

1. Windows 에서,
1. VirtualBox 관리자의 왼쪽 ***yosjfedora*** 를 클릭해서 선택하고,
1. 오른쪽 [`네트워크`] 선택
	1. 오른쪽 네트워크 아래에 있는 [`어댑터 2`] 선택
	1. [`내트워크 어댑터 사용하기`] 클릭해서 선택
	1. 아랫줄 다음에 연결됨 에서, [`호스트 전용 어댑터`] 선택
	1. 왼쪽 메뉴에서 [`공유 폴더`] 선택
	1. 공유 폴더(F)의 맨 오른쪽에서 +가 붙은 그림이 있는 [`+ 폴더아이콘`] 클릭
		1. 공유 추가 에서 > 폴더 경로 > 아래 화살표 클릭 > [`기타`] 선택
		1. 내 PC > 다운로드 선택하고 [`폴더 선택`] 클릭
		1. 자동 마운트 에 체크하고 > [`확인`] 클릭
	1. 네트워크, 공유폴더 설정이 끝났으므로 아래의 [`확인`] 클릭

## 21. 가상 시스템 그룹인 vboxsf 추가

1. yosjfedora 에서,
1. 가상 시스템 그룹 이름인 `vboxsf` 를 /etc/group 에 지정한다
```
is_group=$(grep vboxsf /etc/group | grep ${USER})
if [ "x${is_group}" = "x" ]; then
	grep vboxsf /etc/group ; echo "#-- (20-1) vboxsf 그룹이 user 에게 지정되지 않았습니다."
	sudo gpasswd -a ${USER} vboxsf ; echo "#-- (20-2) vboxsf 그룹을 추가합니다."
	grep vboxsf /etc/group ; echo "#-- (20-3) vboxsf 그룹이 user 에게 지정되었습니다."
fi
```
3. 작업이 끝났으므로 `[(^) 컴퓨터 끄기 / 로그아웃]` > `[컴퓨터 끄기]` > `[컴퓨터 끄기]` 와 같이 가상 시스템을 끝내고, 다시 부팅한다.
4. 가상 시스템 맨윗줄의 메뉴중 **파일** / **머신** / **보기** / **입력** / `장치` > `게스트 확장 CD 이미지 삽입` > 
	자동으로 시작하기로 한 프로그램 . . . 
	실행하시겠습니까? > `[실행]` 클릭
  ==> 자동으로 시작되지 않으면, 터미널에서 다음과 같이 입력한다.
```
sudo sh /run/media/${USER}/VBox_GAs_*/VBoxLinuxAdditions.run ; echo "sudo /sbin/rcvboxadd quicksetup all #-- (20-4) Do you wish to continue? '[yes or no]' 가 나오면, yes 입력후, 이 명령을 직접 입력해야 합니다."
```
5. Do you wish to continue? `[yes or no]` > yes 인 경우
```
sudo /sbin/rcvboxadd quicksetup all
ls -l /media/sf_Downloads/ ; echo "#-- (20-5) 다운로드 폴더를 보여줍니다."
```

## 22. 게스트 확장 CD 꺼내기

1. Windows 에서,
1. VirtualBox관리자의 왼쪽 ***yosjfedora*** 를 클릭해서 선택하고,
1. 화면 맨윗줄 오른쪽 끝의 `ko` 옆에 있는 `옮 <))  (^)` 클릭 >
1. `[(^) 컴퓨터 끄기 / 로그아웃]` > `[컴퓨터 끄기]` > `[컴퓨터 끄기]`
1. 오른쪽 `[저장소]` 선택
	1. `[컨트롤러 IDE]` 아래 `[VBoxGuestAdditions.iso]` 클릭
	1. 오른쪽 속성 끝에 있는 CD 아이콘 클릭
	1. `[가상 드라이브에서 디스크 꺼내기]` 클릭 > `[확인]`

## 23. 공유폴더에서 읽기/쓰기 문제

### Windows 에 Fedora 버추얼박스를 설치하고, 공유폴더를 사용할때, 종종 권한때문에 읽기/쓰기 문제가 생기는 경우,
1. 현재 마우트된 유폴더의 소유 사용자계정과 그룹을 확인하면,
```
$ ls -al /media
합계 24
drwxr-xr-x. 1 root root       24  9월 15일 13:11 .
dr-xr-xr-x. 1 root root      158  9월  5일 11:43 ..
drwxrwxrwx. 1 root vboxsf  24576  9월 15일 11:47 sf_Downloads
```
2. 지금 로그인 되어있는 계정의 UID와 GID를 확인한다. (보통 1000 이 할당된다.)
```
$ id
uid=1000(yos) gid=1000(yos) groups=1000(yos),10(wheel),981(vboxsf) context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
```
3. 이제 공유폴더를 다음과 같이 uid 와 gid 를 지정해서 다시 마운트한다.
```
sudo mount -t vboxsf -o remount,uid=1000,gid=1000,rw wind /media/sf_Downloads
```
4. 제대로 수정이 됐는지 확인한다.
```
$ ls -al /media/
합계 24
drwxr-xr-x. 1 root root    24  9월 15일 13:11 .
dr-xr-xr-x. 1 root root   158  9월  5일 11:43 ..
drwxrwxrwx. 1 yos  yos  24576  9월 15일 11:47 sf_Downloads
```

## 24. vdi 파일 압축

1. Windows의 파일 탐색기에서 `yosjfedora.vdi` 파일을 오른쪽 마우스 클릭
2. 나열된 선택 중에서 `7-zip` 에 마우스를 대고 > `압축 파일에 추가` 클릭
	-> 윈도우11 인 경우, `더 많은 옵션 표시` 클릭하고 `7-zip` > `압축 파일에 추가` 클릭
3. `압축파일(A)` 에서 `yosjfedora36.01-terminal-220831.7z` 와 같이 지정하고,
4. `볼륨 나누기, 바이트(V)` => `3900M` (USB 에 담기 위해서)
	`암호화` > `암호입력` => PPQQ (압축해제시 사용할 비번)
  `[v] 암호 보기` > `[확인]` 클릭해서 압축한다.

