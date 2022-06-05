원본 제목: ysjn 220208 Windows 10 의 VirtualBox 에서 Fedora 설치하는 방법
원본 링크: -NONE-
Path:
ysjn/virtualbox_fedora
Title:
Fedora 가상 시스템 설치
Short Description:
ysjn 220208 Windows 10 의 VirtualBox 에서 Fedora 설치하는 방법

![Figure 1.1 – vsCode main.dart](/vb_fedora_ysjn_img/101-01-vscode_main.dart.png)
- cut line



# 파일 내려받기

## 설치 이미지 Fedora 다운로드
1. 크롬 브라우저 에서 https://getfedora.org/ 접속
1. 왼쪽아래 Fedora WONRKSTATION > [지금 내려받기] 클릭
1. 오른쪽 > x86_64를 위해: 페도라 35: x86_64 DVD ISO > [내려받기] 클릭
1. 파일 탐색기 > 내 PC > 다운로드 > Fedora-Workstation-Live-x86_64-35-1.2.iso 파일 확인

## 가상 시스템 VirtualBox 다운로드
1. 크롬 브라우저 > https://virtualbox.org > 왼쪽메뉴 [Downloads] 클릭
1. 중간 VirtualBox 6.1.30 platform packages 아래 > [Windows hosts] 클릭 해서 다운로드
1. 브라우저 밑에 다운로드된 파일
브라우저 아랫줄의 ^ 표시 클릭해서 [열기] 하거나,
파일 탐색기 > 내 PC > 다운로드 > VirtualBox-6.1.30-148432-Win.exe 더블클릭 해서 설치

# 가상 시스템에 리눅스 설치

## VirtualBox 에 Fedora 설치하기
1. 윈도우 키 [+]S 누르고 "vir" 입력해서 VirtualBox 실행
1. VirtualBox 관리자 위 가운데쪽의 [새로 만들기] 클릭
1. 이름 및 운영 체제 > 이름 [ fedora ] 입력 > [다음] 클릭
1. 메모리 크기 > [3072] MB 또는 [4096] MB 로 지정 > [다음] 클릭
1. 하드 디스크 > (o) 지금 새 가상 하드디스크 만들기 (C)  > [만들기] 클릭
1. 하드 디스크 파일 종류 > (o) VDI > [다음] 클릭
1. 물리적 하드 드라이브에 저장 > (o) 동적 할당 > [다음] 클릭
1. 파일 위치 및 크기 > 기본 8 GB 인데, [ 30 ] GB 로 하고 > [만들기] 클릭

## Fedora 가상 시스템 설치 시작
1. VirtualBox관리자 왼쪽 fedora 를 클릭해서 선택하고,
1. 위 오른쪽의 [시작] 클릭해서 fedora 실행
1. 시동 디스크 선택 > 아래 오른쪽 폴더 아이콘 [가상 광 디스크 파일 선택] 클릭
1. [추가] 클릭 > 내 PC > 다운로드 > 
Fedora-Workstation-Live-x86_64-35-1.2.iso 파일 더블 클릭
1. 파일이 선택됐으므로 [선택] 클릭
1. [시작] 선택
1. Start Fedora-Workstation-Live 35 선택
주르륵 글씨가 흘러내린다.

## 설치 진행
1. Try Fedora 말고, [Install to Hard Drive] 클릭
1. 똑같은 화면이 또 나온다. 
이 화면이 진짜이므로 다시 한번 [Install to Hard Drive] 클릭
1. FEDORA 99 에 오신 것을 환영합니다. 라고 나오면 한글이 선택된 것이고,
영어등 다른 글자로 표시가 되면, 
가운데 나열된 언어 중에서 [한국어 Korean] 을 선택한다.
1. [계속 진행] 클릭
1. 가운데 오른쪽 [설치 목적지] 클릭 > [완료] 클릭 > 
조금 기다리면 [설치 시작] 버튼이 정상 표시된다.
1. [설치 시작] 클릭
1. 설치 진행 > [설치 종료] 클릭
1. 전체화면의 오른쪽 위 [x] 닫기 클릭 > (o) 시스템 전원 끄기 > [확인] 클릭

## 설치 디스크 꺼내기
1. 왼쪽 fedora 를 클릭해서 선택하고,
1. 오른쪽 중간 [저장소] 클릭
1. 가운데에서 컨트롤러: IDE 아래, 
[Fedora-Workstation-Live-x86_64-35-1.2.iso] 클릭
1. 오른쪽 속성 > 광학 드라이브 [IDE 세컨더리 마스터] 
오른쪽의 [CD모양 아이콘] 클릭
1. [가상 드라이브에서 디스크 꺼내기] 클릭 > [확인] 클릭 > 맨 아래 [확인] 클릭
1. 윈도우에서, fedora.vdi 파일을 7-Zip 프로그램으로 압축

# 초기화 작업

## Fedora 첫 출발
1. VirtualBox관리자 왼쪽 fedora 를 클릭해서 선택하고, + 위 오른쪽의 [시작] 클릭해서 fedora 실행 
(=> fedora 가상 시스템을 시작한다)
1. Fedora Linux 99 사용을 환영합니다! > [설정 시작] 클릭
1. 개인 정보 > 위치 정보 서비스 (__O) -> (O__) 닫고 > [다음] 클릭
1. 서드 파티 저장소 > [다음] 클릭
1. 온라인 계정 연결 > [건너뛰기] 클릭
1. 사용자 정보 > 전체 이름 [fedora] > 사용자 이름 [fedora] > [다음] 클릭
1. 암호 지정 > 암호 [....] > [다음] 클릭
1. [Fedora Linux 시작] 클릭
	1. 좀 기다리면, Welcome to GNOME !! 이 나온다. [괜찮습니다] 선택
	1. 앞에서 이름/비번 이 지정됐으므로 바로 로그인이 된 상태이며, 로그인 하자마자, 검색 화면이 먼저 뜬다.
	1. 이스케이프 [Esc] 키 를 눌러서 검색을 중단하고 OS 로 들어가거나,
	1. 다음 키를 입력해서 프로그램을 실행시키거나,
	ter -> terminel 터미널 화면
  fir -> firefox 브라우저
  nau -> nautilus 파일 탐색기
  rhy -> 리듬박스
	1. 아이콘을 클릭해서 프로그램을 실행시키거나,
1. 다시 검색화면으로 들어가려면, -> 윈도우 [+] 키

## Fedora: 한글 설정
1. 맨위 오른쪽 끝 [(^)] 전원버튼 클릭 > [설정] 클릭
1. 왼쪽 메뉴에서 [키보드] 선택
1. 오른쪽 입력소스 에서 ‘ 한국어 (Hangul) ‘ 을 찾아서
1. 첫번째 줄에 있지 않으면, [점세개 아이콘] 클릭 > [위로 이동]을 클릭헤서 첫줄로 이동시킨다
1. [점세개 아이콘] 클릭 > [기본 설정] 클릭
	1. [v] 단어단위로 입력 -> 체크 표시
	1. [_] 자동 순서 교정 -> 체크 해제
	1. 아래쪽 > 한영전환키
	1. [추가] 클릭
	1. 키보드에서 [한글] 키 또는 스페이스바 오른쪽 [Alt] 키 클릭 > [확인] 클릭
	1. 맨아래 [확인] 클릭
1. 맨위 오른쪽 끝 [(^)] 전원버튼 > 
	1. [컴퓨터 끄기 / 로그아웃] > [컴퓨터 끄기…] > [컴퓨터 끄기] 클릭
	1. 이때 업데이트할 프로그램이 있으면, 그 설치를 한 뒤에 자동으로 꺼질때까지 기다려야 한다.

## Window: 네트워크와 공유 폴더 설정하기
1. VirtualBox관리자 왼쪽 fedora 를 클릭해서 선택하고,
1. 오른쪽 [네트워크] 선택
	1. 오른쪽 네트워크 아래에 있는 [어댑터 2] 선택
	1. [내트워크 어댑터 사용하기] 클릭해서 선택
	1. 아랫줄 다음에 연결됨 에서, [호스트 전용 어댑터] 선택
	1. 왼쪽 [공유 폴더] 선택
	1. 공유 폴더 아래 맨 오른쪽 [+ 표시된 폴더아이콘] 클릭
		1. 공유 추가 에서 > 폴더 경로 > 아래 화살표 클릭 > [기타] 선택
		1. 내 PC > 다운로드 선택하고 [폴더 선택] 클릭
		1. 자동 마운트 에 체크하고 > [확인] 클릭
	1. fedora - 설정 이 끝났으므로 [확인] 클릭

## Fedora 공유 폴더 사용 위해
1. (=> fedora 가상 시스템을 시작한다)
1. 로그인 > 검색 화면 > ”ter” 엔터 로 터미널 실행
1. 터미널에서 폰트 지정하기
	1. 3자아이콘 (햄버거 버튼) 클릭 > 기본 설정 > 
	왼쪽 아래 프로파일 아래에 있는 [이름없음(v)] 클릭
	1. 텍스트 > [v] 사용자 지정 글꼴 체크표시 > 
	[ Monospace ] 클릭 > 크기를 12 또는 14 로 지정
1. 가상 시스템 그룹 이름인 vboxsf 를 지정하기 위해 터미널에서 다음 명령을 준다
```
ls -l /etc/group
cat /etc/group #--- fedora 에서 쓰는 그룹들
grep vboxsf /etc/group #--- vboxsf 있는지 확인
sudo gpasswd -a ${USER} vboxsf #--- vboxsf 그룹에 사용자를 추가
grep vboxsf /etc/group #--- vboxsf 있는지 확인
sudo dnf install kernel-debug-devel kernel-devel #--- virtualbox 를 위한 커널 추가
sudo dnf install -y make automake autoconf gcc dkms wget vim-enhanced vim-common mc lynx git p7zip #--- 컴파일러등 필요한것 설치
```
1. [컴퓨터 끄기 / 로그아웃] > [다시 시작…] > 
[다시 시작] 클릭 또는, sudo reboot
1. 로그인 > [Esc] 키로 검색화면에서 나오고 > 
	1. 맨 윗줄의 메뉴에서 장치 > 클립보드 공유 > 양벙향 선택
	1. 메뉴에서 장치 > 게스트 확장 CD 이미지 삽입 > 
		자동으로 시작하기로 한 프로그램 . . . 
		실행하시겠습니까? > [실행] 클릭
1. Do you wish to continue? [yes or no] > yes 인 경우
```
sudo /sbin/rcvboxadd quicksetup all
ls -l /media/sf_Downloads/ #--- 다운로드 폴더를 보여준다
```

## 게스트 확장 CD 꺼내기
1. [컴퓨터 끄기 / 로그아웃] > [컴퓨터 끄기] > [컴퓨터 끄기]
1. 오른쪽 [저장소] 선택
	1. [컨트롤러 IDE] 아래 [VBoxGuestAdditions.iso] 클릭
	1. 오른쪽 속성 끝에 있는 CD 아이콘 클릭
	1. [가상 드라이브에서 디스크 꺼내기] 클릭 > [확인]
```
openssl 네트워크 통합 데이터 통신에 쓰이는 프로토콜
m4 매크로 처리언어 - 데니스 리치, 브라이언 커니핸 flex 구문분석기 C생성
elfutils 리눅스 e실행가능 l링크가능 f파일포맷
```

## 한글 폰트 설치
1. 맨 윗줄 장치 > 클립보드 공유  > (o) 양방향 선택
1. [+]키 > 검색 화면 > ”ter” 엔터 로 터미널 실행
1. 깃허브 github.com 에서 쉘 스크립트 파일을 받는다.
```
cd /media/sf_Downloads #-- '다운로드' 폴더로 가서,
git clone https://proencode@github.com/proencode/fedora-sh.git
ls -l #-- 현위치의 파일들을 확인한다.
cd fedora-sh
ls -l
cd 12-font-install
pwd #-- 현재 위치의 폴더 이름을 보여준다.
```
4. 다음 명령으로 한글 폰트를 설치한다.
```
cd /media/sf_Downloads/fedora-sh/12-font-install
ls -l
sh 00-d2coding-seoul-font-install.sh
```

## 터미널에 한글폰트 적용하기
1. 3자 아이콘 (햄버거 버튼) 클릭 > 기본 설정 > 
왼쪽 아래 프로파일 아래에 있는 [이름없음(v)] 클릭
1. 텍스트 > 사용자 지정 글꼴 > [ Monospace ] 클릭 > 
D2Coding 선택하고 > 크기를 14 로 지정
1. 텍스트 옆에 있는 [색] 클릭 > 바탕색이 어두우면 파란색이 너무 진하므로 
#1F83FE 등 밝은색으로 지정한다.
1. 크롬 브라우저를 설치하려면,
```
sh ~/fedora-sh/12-google-chrome-install.sh
```
5. 프롬프트의 색깔을 바꾸려면,
```
cp ~/.bashrc ~/fedora-sh/bashrc-original
cp ~/fedora-sh/DOTbashrc-vfedora35 ~/.bashrc
```
