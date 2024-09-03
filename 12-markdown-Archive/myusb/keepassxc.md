
# keepassxc 다운로드

### 로컬 드라이브 또는 USB 드라이브에 myusb/ 폴더를 만들고 이곳에 다운로드한다.

1. 내 Windows PC 설치 --> https://keepassxc.org/download/#windows DOWNLOAD FOR WINDOWS 설치 프로그램
(=KeePassXC-`2.7.9`-Win64.msi)
2. 공용 Windows PC 사용 --> See more options > Portable ZIP (64-bit, Windows 10 / 11) 설치과정 없는 압축파일
(=KeePassXC-`2.7.9`-Win64.zip)

# keepassxc 설치

1. 내 Windows PC에 설치 --> KeePassXC-`2.7.9`-Win64.msi 더블 클릭
1. 공용 Windows PC 사용 --> KeePassXC-`2.7.9`-Win64.zip 압축해제 --> KeePassXC-`2.7.9`-Win64 / KeePassXC.exe 더블 클릭
1. ubuntu desktop 의 경우: Ubuntu 24.04, 22.04 또는 20.04에 KeePassXC를 설치하는 방법 2024-06-29 13:55 Joshua James
https://linuxcapable.com/how-to-install-keepassxc-on-ubuntu-linux/
(1) 옵션 2: KeePassXC PPA를 통해 KeePassXC 설치
```
sudo apt update && sudo apt upgrade
sudo add-apt-repository ppa:phoerious/keepassxc -y
sudo apt update
sudo apt install keepassxc
```

# keepassxc 실행

1. 윈도우 키를 누른뒤 `keepass` 를 입력 --> 프로그램을 실행.
또는, KeePassXC-`2.7.9`-Win64 폴더에서 `KeePassXC.exe` 프로그램 더블 클릭
ubuntu desktop 에서는, 윈도우 키를 누른뒤 `keepass` 입력해서 프로그램 실행
1. 첫 시작시, 환영 메세지 아래에 있는 버튼중에서 `[+ 데이터베이스 만들기]` 클릭
(1) 데이터베이스 이름: `mykeepass` 입력
(2) 암호화 설정: `[계속]` 클릭
(3) 데이터베이스 자격 증명: `새로운 keepass 비번` 입력후 `[완료]` 클릭
다른 이름으로 데이터베이스 저장: `다운로드 폴더`에서 `mykeepass.kdbx` 와 같이 파일이름을 입력하고 저장한다.
1. 처음 실행이 아니면, `KeePassXC 데이터베이스 잠금해제` 메세지가 나온다.
그 아랫줄에 표시된 `C:\Users\-유저--\Downloads\...\keepass.kdbx` 파일이 맞으면,
암호를 `암호 입력:` 칸에 입력하면 된다.
다른 .kdbx 파일을 선택하려면, 윗 메뉴 `[데이터베이스]` > `[데이터베이스 열기]` 를 선택해서 원하는 .kdbx 를 선택한다.
1. 브라우저 통합 지정
(1) `도구` > `설정` 또는 `Ctrl`+`,` 또는 톱니바퀴 아이콘 `설정(S)` 클릭
(2) 왼쪽. 지구본 아이콘 `브라우저 통합` 클릭
(3) 윗쪽. `브라우저 통합 활성화` 체크
(4) 아랫쪽, 다음 브라우저에 통합: `Chrome...Brave` 체크, `Chromium` 체크
(5) `확인` 클릭

# 그룹 / 항목 만들기

1. 그룹 만들기
그룹이란, 아이디와 비번을 저장한 항목 여러개를 하나로 묶어서 부르는 이름이다.
keepassxc 가 설치되면 `루트` 라는 그룹이 미리 만들어져 있고, 그 안에 `휴지통` 그룹이 들어있다.
그룹 이름은 마음대로 지을 수 있으므로, 첫번째로 만드는 그룹 이름을 `서버`로 짓기로 한다.
(1) 그룹을 만들 위치인 `루트` 를 클릭 (그룹을 어느 아래에 둘 것인지 지정해야 한다)
(2) `그룹(Alt+G)` > `새 그룹(Alt+N)` 클릭
--> 이름: `"서버"`
--> 메모: `"서버 관련 정보"`
`확인` 을 눌러 저장한다.
(3) `루트` 그룹 아래에 `서버` 그룹이 만들어졌다.
2. 항목 만들기
(1) 그룹을 선택 (`서버`를 클릭)
(2) `항목(E)` > `새 항목(N)` 을 클릭
--> 제목: `네이버 로그인`
--> 사용자 이름: `mynaver`
--> 암호: `pswdNVR`
--> URL: `https://nid.naver.com/nidlogin.login`
--> 태그: `login` 찾기할때 사용할 키워드
--> 메모: `240714-1626 첫번째 등록`
`확인` 을 눌러 저장한다.
(3) `루트/서버` 그룹 아래에 `네이버 로그인` 제목의 항목이 만들어졌다.

# Dark Reader, KeePassXC 설치

1. 브라우저에서 `"dark reader"`를 찾아서 설치한다.
Dark Reader - Chrome 웹 스토어 https://chromewebstore.google.com/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh?hl=ko&pli=1
1. Dark Reader 설치시 들어간 Chrome 웹 스토어 안에서 `확장 프로그램 및 테마 검색` 에 `"keepassxc"` 를 검색해서, KeePassXC-Browser 를 설치한다.
1. 브라우저의 `확장 프로그램` 메뉴로 들어가서, `Dark Reader` 와 `KeePassXC-Browser` 의 `고정` 을 클릭해서 고정시킨다.
1. `확장 프로그램` 메뉴 옆에 표시된 keepassxc 아이콘에 빨간 X 표시가 있으면, 연결이 안된 경우이므로, 새로 연결시켜야 한다.
(1) keepass 프로그램을 띄우고, 로그인 하려는 URL, 아이디, 비번 데이터가 있는지 확인한다.
--> 사용자 이름(U) `(네이버 아이디)`
--> 암호(P) `(비번)`
--> 등록된 URL(U) `(네이버 로그인 창 https://nid.naver.com/nidlogin.login)`
(2) 브라우저에서, keepass 프로그램에 등록된 URL (ex: https://nid.naver.com/nidlogin.login) 으로 들어간다.
(3) 브라우저의 keepass 아이콘을 클릭해서 URL 주소가 keepass 에 등록됐는지 확인한다.
(4) 등록돼 있으면, 아이디, 비번 입력칸이 채워진다.
등록돼 있지 않으면, 그냥 아이디, 비번을 입력한다.
로그인이 완료되면 keepass 가 해당 아이디, 비번을 저장할 것인지 물어온다.
(5) keepassxc 아이콘에 빨간 X 표시가 있으면, 그 아이콘을 클릭해서, 안내를 확인하고, `새로 고침` 을 클릭한다.

# keepass 표준 운영 절차

`S`tandard `O`perating `P`rocedure

## 1. 새로 입력, 수정, 삭제 할때마다 바로 최종 설명을 기록한다.

### (1) 수정후 `일시-설명`을 메모하기 위해, `일시`를 표시하는 다음 명령을 입력한다.

1. 윈도우의 cmd 창에서,
```
echo %date:~2,2%%date:~5,2%%date:~8,2%-%time:~0,2%%time:~3,2% 오늘의 설명 추가
```
- 출처: Windows - cmd 에서 날짜, 시간 출력하기 삼삼한소나무 2023. 11. 30. 13:28 출처: https://samso.tistory.com/44 [삼소의 삼삼한 메모장:티스토리]

2. ubuntu 의 터미널 에서,
```
echo "$(date +%y%m%d-%H%M) 오늘의 설명 추가"
```
### (2) 그 결과인 "240714-1626 오늘의 설명 추가" 문자열을 복사한다.
### (3) keepassxc 프로그램에서 특정 그룹 (`서버` 등) 의 특정 항목 (`공유기` 등) 에 붙여넣기 해서 저장한다.
```
240823금-0932 쿠팡을 추가합니다.
-rw-r--r-- 1 yos yos 28677  8월 23일  09:31 mykeepass.kdbx
```
### (4) keep.google.com 구글 킵 `'keepassxc 수정메모'` 의 첫줄에, 위에서 만든 문자열을 붙여넣는다.
```
☐ 240823금-0932 쿠팡을 추가합니다.
☐ -rw-r--r-- 1 yos yos 28677  8월 23일  09:31 mykeepass.kdbx
☑
```

## 2. 최종 설명을 기록한 `keepass.kdbx` 파일을 원격 드라이브에 백업한다.

### (1) 로컬의 `keepass.kdbx` 파일을 구글 드라이브 drive.google.com 로 업로드 한다.

1. 브라우저에서, 구글 드라이브 drive.google.com 에 로그인 해서, keepass/ 폴더로 이동한다.
1. 로컬 드라이브의 keepass.kdbx 파일을 구글 드라이브의 keepass/ 폴더로 업로드 한다.
1. 또는, git-bash 프로그램에서 rclone 명령으로 백업한다.
`MYCLOUD`: rclone 명령에 등록한 구글 드라이브의 remote 이름)
```
rclone copy ~/Downloads/keepass.kdbx MYCLOUD:keepass/
```

### (2) mega.io/login 등 다른 클라우드에 한번 더 업로드 한다.

1. 브라우저에서, 메가 드라이브 mega.io 에 로그인 해서, keepass/ 폴더로 이동한다.
1. 로컬 드라이브의 keepass.kdbx 파일을 메가 드라이브의 keepass/ 폴더로 업로드 한다.
1. 또는, git-bash 프로그램에서 rclone 명령으로 백업한다.
`MEGADRIVE`: rclone 명령에 등록한 메가 드라이브의 remote 이름)
```
rclone copy ~/Downloads/keepass.kdbx MEGADRIVE:keepass/
```

## 3. 백업한 .kdbx 파일 확인

`rclone lsl mycloud:keepass/`
```
    27493 2024-07-29 22:12:40.970000000 mykeepass.kdbx
```

# 윈도우 화면 캡쳐

`PrtSc` Print Screen 키: 모니터 전체영역 화면을 클립보드에 저장 >> gimp 등에서 `Ctrl + V` 로 붙여넣기
`Alt + PrtSc` 현재 활성화된 화면만 캡쳐해서 클립보드에 저장
`Windows + PrtSc` 윈도우 키와 동시에 누르면 전체영역 화면을 파일로 만들어 `사진>스크린샷` 폴더에 저장
`Windows + Shift + S` 화면 상단에 스크린 샷 버튼이 나타난다.
(1) 사각형 캡쳐 : 사각형 화면을 지정해 주면 해당된 구역에서 스크린 샷이 이뤄짐
(2) 자유형 캡쳐 : 직선 혹은 곡선 형태로 다양하고 자유롭게 영역을 지정해서 캡쳐가 가능
(3) 창 캡쳐 : 화면에 보이는 윈도우 창 중에서 선택된 창만 캡처를 해주는 기능
(4) 전체 화면 캡쳐 : 말 그대로 모니터에 보이는 화면 전체를 캡쳐

윈도우 컴퓨터 스크린 샷(화면 캡쳐) 하는 7가지 방법 빅웨이브 2022. 1. 28. 23:15 19:00:21안녕하시죠? https://www.ddanzi.com/index.php?mid=free&document_srl=813678526&statusList=HOT%2CHOTBEST%2CHOTAC%2CHOTBESTAC

