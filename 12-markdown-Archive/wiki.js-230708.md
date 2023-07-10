# Wiki.js 설치

1. 도커와 컨테이너는 무엇인가 https://m.blog.naver.com/complusblog/220980996544
1. 가장 강력하고 확장 가능한 오픈소스 Wiki 소프트웨어 https://js.wiki

![container 와 virtualmachine 비교](/yosj/container-virtualmachine.webp)

## Windows 에서 사용할 앱 설치

### 개발도구 등을 백업하는 USB 의 디렉토리 구조

💽 myUSB (F:)
┣━📂4winApp (윈도우용 도구)
┃╌┣━📁4Git (Git 을 위한 추가파일)
┃╌┃╌┣━📁usr
┃╌┃╌┗━D2Coding 폰트
┃╌┣━4Git-usr-D2Coding, 7z, android, BraveBrowser, gimp, Git, ideaIC, jdk, 
┃╌┣━KeePass, kotlin.7z, PhotoScape, Postman, WinSCP, wordpress,
┃╌┗━
┣━📂vdi (VirtualBox 설치를 위한 파일과 압축해 놓은 vdi 파일)
┃╌┣━7z, Git, VC, VirtualBox,
┃╌┣━Users_VBox.푸른숲.pc18-C_다운로드_bada-230628-1649.7z.001
┃╌┣━yosjfedora38.03-keepass-b4-230628-1658.7z.001
┃╌┣━yosjfedora38.03-keepass-b4-230628-1658.7z.002
┃╌┣━yosjfedora38.03-keepass-b4-230628-1658.7z.tag
┃╌┗━

### 기본 도구

7-zip, Git, WinSCP, KeePass, BraveBrowser,

1. `7zip` 압축 프로그램 ➡️ https://www.7-zip.org/ ➡️ Download  .exe  64-bit x64  1.5 MB 🔑
1.  "윈도우를 위한 Git 패키지" 를 설치하는 실행파일 ➡️ https://git-scm.com/download/win ➡️ 64-bit Git for Windows Setup 🔑
📌 `Git` 은 버전관리 시스템의 하나로 널리 쓰이는 프로그램이다.
📌 `Git-Bash` 는 "윈도우를 위한 Git 패키지" 에 포함돼 있는 Bash 셀. Bash 셸은, 유닉스 시스템에서 쓰는 셸. 커맨드 라인에서 파일 관리, 프로그램 실행 등을 명령한다.
📌 `Git` 에서 `rsync` 명령을 쓰기 위해 추가하는 `usr` 폴더와, 가독성 높은 `D2Coding` 폰트 ➡️ [ 다운로드 ](/4winapp/4git-usr-d2coding.7z) 🔑
1. BraveBrowserSetup-.exe 브라우저 https://try.bravesoftware.com/ ➡️ Download for free
📌 Chrome에서 Brave로 전환해야 하는 이유 https://requestly.io/blog/switch-to-brave-from-chrome
1. `WinSCP` 는 Windows 환경에서 `SFTP, FTP, SSH` 등의 프로토콜로 파일을 전송하는 클라이언트 프로그램이다 ➡️ https://winscp.net/eng/download.php ➡️ 아래쪽에서 (` DOWNLOAD WINSCP 6.1.1 (11 MB) `) 🔑
1. 비밀번호 관리 프로그램 KeePass https://keepass.info/download.html ➡️ Installer for Windows: Download Now 클릭 🔑

### VirtualBox 도구

VirtualBox, vc_redist.

1. VirtualBox 7.0.8 다운로드 https://www.virtualbox.org/wiki/Downloads ➡️ https://download.virtualbox.org/virtualbox/7.0.8/VirtualBox-7.0.8-156879-Win.exe
1. Windows 업데이트가 안되어 있어서 VirtualBox 설치할때 오류가 나는 경우 ➡️ Microsoft Visual C++ 재배포 가능 최신 지원 다운로드 아티클 2023. 04. 27. https://learn.microsoft.com/ko-kr/cpp/windows/latest-supported-vc-redist?view=msvc-170 ➡️ https://aka.ms/vs/17/release/vc_redist.x64.exe

### 개발 도구

jdk-17_windows, kotlin-ktor-rest-api, ideaIC, Postman, gimp, 

1. 자바 개발용 패키지 파일 https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html ➡️ Windows x64 Installer ➡️ `jdk-17_windows-x64_bin.exe` 🔑 다운로드해서 실행한다.
2. `Git-bash` 를 실행해서, 다음과 같이 샘플 프로젝트를 다운받는다. 그리고 나서 해당 폴더를 압축해서 보관한다.
```
git clone https://github.com/selimatasoy/kotlin-ktor-rest-api.git
7za a -mx=9 kotlin-ktor-rest-api.7z kotlin-ktor-rest-api
```
3. `IntelliJ IDEA`는 JetBrains 에서 개발한 자바를 포함한 다양한 프로그래밍 언어를 위한 통합 개발 환경(IDE) 이다.
https://www.jetbrains.com/idea/download/download-thanks.html?platform=windows&code=IIC ➡️ IntelliJ IDEA Community Edition 🔑 무료 버전
4. Postman 은 API를 구축하고 사용하기 위한 API 플랫폼 이다. (`A`:애플리케이션 `P`:프로그램 `I`:인터페이스)
https://www.postman.com/downloads/ ➡️ Windows 64bit ➡️ https://dl.pstmn.io/download/latest/win64 🔑 
📌 https://blog.wishket.com/api%EB%9E%80-%EC%89%BD%EA%B2%8C-%EC%84%A4%EB%AA%85-%EA%B7%B8%EB%A6%B0%ED%81%B4%EB%9D%BC%EC%9D%B4%EC%96%B8%ED%8A%B8/ 👀
📌 API를 본격적으로 알아보기 전에, 비유를 들어 쉽게 설명을 도와드리겠습니다. 여러분이 멋진 레스토랑에 있다고 가정해봅시다. 점원이 가져다준 메뉴판을 보면서 먹음직스러운 스테이크를 고르면, 점원이 주문을 받아 요리사에 요청을 할 텐데요. 그러면 요리사는 정성껏 스테이크를 만들어 점원에게 주고, 여러분은 점원이 가져다준 맛있는 음식을 먹을 수 있게 됩니다.
여기서 점원의 역할을 한 번 살펴보겠습니다. 점원은 손님에게 메뉴를 알려주고, 주방에 주문받은 요리를 요청합니다. 그다음 주방에서 완성된 요리를 손님께 다시 전달하지요. API는 점원과 같은 역할을 합니다.
API는 손님(프로그램)이 주문할 수 있게 메뉴(명령 목록)를 정리하고, 주문(명령)을 받으면 요리사(응용프로그램)와 상호작용하여 요청된 메뉴(명령에 대한 값)를 전달합니다.
쉽게 말해, API는 프로그램들이 서로 상호작용하는 것을 도와주는 매개체로 볼 수 있습니다.
5. GIMP = GNU Image Manipulation Program (그누 이미지 처리 프로그램)
https://www.gimp.org/downloads/ GIMP for Windows ➡️ Download GIMP 2.10.34 directly ➡️ https://download.gimp.org/gimp/v2.10/windows/gimp-2.10.34-setup.exe 🔑
GNU General Public License = GNU GPL = GPL, 일반 공중 사용허가서 = 자유 소프트웨어 재단에서 만든 자유 소프트웨어 라이선스
6. Google-Chrome 을 업데이트하려면 다음 단계를 따르세요.
(6-1) 컴퓨터에서 Chrome을 엽니다.
(6-2) 오른쪽 상단에서 더보기 더보기를 클릭합니다.
(6-3) 도움말 다음 Chrome 정보를 클릭합니다.
(6-4) Chrome 업데이트를 클릭합니다.
중요: 최신 버전을 사용하고 있다면 이 버튼이 표시되지 않습니다.
(6-5) 다시 실행을 클릭합니다.

👉 Windows 에서 Git-Bash 를 실행한 다음, 4winApp 폴더로 이동한 뒤, 그곳의 프로그램들을 한번에 설치하기 위해서 Windows 에서 실행되는 BAT 스크립트를 다음과 같이 만든다. 🔑
`cd ~/Downloads/myusb/4winApp ; cat 00RUN.00-exe-230707-1523.bat`
```
7z2301-x64.exe
Git-2.41.0-64-bit.exe
set /p str=  ---- usr 과 D2Coding 폰트 설치 끝난뒤 Enter 누르세요 ---- :
start jdk-17_windows-x64_bin.exe
7za x kotlin-ktor-rest-api.7z
ideaIC-2023.1.3.exe
start Postman-win64-Setup.exe
start gimp-2.10.34-setup.exe
WinSCP-6.1-Setup.exe
KeePass-2.54-Setup.exe
BraveBrowserSetup-DWS000.exe
```

## 도커 설치하기

0. Fedora 시스템을 최신으로 업데이트 한다.
```
sudo dnf -y update
```

1. 다음과 같이 Fedora 리파지토리를 시스템에 추가한 다음이라야 docker 를 설치할 수 있다.
```
sudo dnf -y install dnf-plugins-core
sudo tee /etc/yum.repos.d/docker-ce.repo << EOF
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/36/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
EOF
echo "#-- (2) 출처: https://computingforgeeks.com/how-to-install-docker-on-fedora/ --> Fedora 리파지토리를 시스템에 추가합니다."
```

2. Docker CE 를 Fedora 에 설치한다.
```
sudo dnf makecache
sudo dnf -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker
```
제대로 설치되었는지 확인한다.
```
sudo systemctl status docker
echo "--------------------------- sudo systemctl status docker"
echo ""
echo "--------------------------- sudo docker version"
sudo docker version
```

## 도커 컴포즈를 빌드하기

1. 디렉토리 만들기
2. 포트번호를 지정하고 설정파일 만들기
3. 도커 컴포즈 (빌드 + 실행) 하기
4. 브라우저에서 (주소:포트번호) 입력
5. 첫번째 등록작업

작업의 편의를 위해 터미널에서 입력하는 스크립트를 추가하였다.

### 작업에 필요한 디렉토리 만들기

wiki.js 를 위한 데이터베이스로 포스트그레스 (postgres DB) 를 선택했으므로, 이것을 보관할 디렉토리를 만들고, wiki.js 설정을 위한 파일을 보관할 디렉토리도 만든다.
```
source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq

cat <<__EOF__
${cBlue}+---+
| ${cYellow}1 ${cBlue}| ${cCyan}작업에 필요한 디렉토리 만들기${cBlue}
+---+${cReset}

__EOF__

docker_folder=/home/docker
pgsql_folder=${docker_folder}/pgsql
wiki_conf_folder=${docker_folder}/wiki_conf

p_made="x"
if [ ! -d ${pgsql_folder} ]; then
	chdRun "sudo mkdir -p ${pgsql_folder}"
	chdRun "chcon -R system_u:object_r:container_file_t:s0 ${pgsql_folder}"
	#-- sudo chown -R systemd-coredump:ssh_keys ${pgsql_folder}
	p_made="o"
fi

w_made="x"
if [ ! -d ${wiki_conf_folder} ]; then
	chdRun "sudo mkdir -p ${wiki_conf_folder}"
	chdRun "sudo chown -R ${USER}:${USER} ${wiki_conf_folder}"
	w_made="o"
fi

if [ "x${p_made}" = "xx" ] || [ "x${w_made}" = "xx" ]; then
	cat <<__EOF__
!!!!> 전에 쓰던 디렉토리가 남아있던것 같습니다.
!!!!> sudo ls -l --color ${docker_folder}
$(sudo ls -l --color ${docker_folder})
!!!!> sudo ls -l --color ${pgsql_folder}
$(sudo ls -l --color ${pgsql_folder})
!!!!> sudo ls -l --color ${wiki_conf_folder}
$(sudo ls -l --color ${wiki_conf_folder})
!!!!> 확인후 삭제하고 이 스크립트를 다시 시작하세요.
!!!!> sudo rm -rf ${pgsql_folder} ${wiki_conf_folder}
!!!!>
!!!!> ( 1 )---------------------------------
!!!!>
__EOF__
else
	cat <<__EOF__
----> sudo ls -l --color ${docker_folder}
$(sudo ls -l --color ${docker_folder})
----> sudo ls -l --color ${pgsql_folder}
$(sudo ls -l --color ${pgsql_folder})
----> sudo ls -l --color ${wiki_conf_folder}
$(sudo ls -l --color ${wiki_conf_folder})

----> ( 1 )---------------------------------

__EOF__
fi
```

### 포트번호를 지정하고 설정파일 만들기
```
source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq

cat <<__EOF__
${cBlue}+---+
| ${cYellow}2 ${cBlue}| ${cCyan}포트번호를 지정하고 설정파일 만들기${cBlue}
+---+${cReset}

----> port 번호를 9900 처럼 입력하세요.
__EOF__

read port_no
if [ "x${port_no}" = "x" ]; then
	exit -1
fi
cat <<__EOF__
포트번호 = ${port_no}
----> press Enter:
__EOF__
read a

cd ${wiki_conf_folder}
cat > docker-compose.yml <<__EOF__
version: "3"
services:

  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_USER: imwiki
      POSTGRES_PASSWORD: wikijsrocks
      POSTGRES_DB: wiki
    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - ${pgsql_folder}:/var/lib/postgresql/data
    container_name:
      wikijsdb

  wiki:
    image: requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_USER: imwiki
      DB_PASS: wikijsrocks
      DB_NAME: wiki
    restart: unless-stopped
    ports:
      - "${port_no}:3000"
    container_name:
      wikijs
__EOF__
ls -l ${wiki_conf_folder}
cat <<__EOF__

----> ( 2 )---------------------------------

__EOF__
```

### 도커 컴포즈 `빌드 + 실행` 하기
```
source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq

cat <<__EOF__
${cBlue}+---+
| ${cYellow}3 ${cBlue}| ${cCyan}도커 컴포즈 `빌드 + 실행` 하기${cBlue}
+---+${cReset}
__EOF__

cd ${wiki_conf_folder}
cmdRun "sudo dnf -y install docker-compose" "docker-compose 를 설치합니다."

cmdRun "rpm -qi docker-compose" "docker-compose 내역을 확인합니다."
cmdRun "sudo docker ps -a" "docker 실행 내역을 봅니다."

cmdRun "sudo docker-compose pull wiki" "도커 컴포즈 wiki 를 빌드합니다."

cmdRun "sudo docker-compose up --force-recreate &" "빌드한 도커 컴포즈를 실행합니다."

cmdRun "sudo docker-compose ps -a"
cat <<__EOF__
wikijs  | 2023-07-07T08:19:07.832Z [MASTER] info: 🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻
wikijs  | 2023-07-07T08:19:07.832Z [MASTER] info: 
wikijs  | 2023-07-07T08:19:07.832Z [MASTER] info: Browse to http://YOUR-SERVER-IP:3000/ to complete setup!
wikijs  | 2023-07-07T08:19:07.832Z [MASTER] info: 
wikijs  | 2023-07-07T08:19:07.832Z [MASTER] info: 🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺


이와 같은 메세지가 표시되면, 다음 명령을 입력해서 도커 실행내역을 확인합니다.


${cYellow}sudo docker ps -a${cReset}


__EOF__
```

### 도커의 위키서버가 시작되면, 브라우저에서 `주소 또는 localhost:포트번호` 를 입력한다.

`localhost:포트번호`

### 첫번째 등록작업을 한다.

- id / passwd 입력
id = 이메일 주소
passwd = 위키서버에 로그인 하기위한 비밀번호를 새로 등록한다.
[ + CREATE HOME PAGE ] = 홈 페이지를 만들기 위해 클릭한다.
저 id 와 passwd 로 로그인이 된다.
- 홈 페이지 만들기
문서편집기로 `Markdown` 을 선택한다.
`Title` 제목은 한글로 써도 되며, "2022-11 일지" 등으로 쓴다.
`Short Desc` 설명은 "작성중" 또는 간단한 설명을 쓴다.
`Path` 파일 이름에 해당하는 것인데, 알파벳으로 정해야 한다.
처음에는 "home" 으로 고정돼 있다.
`v ok` 버튼을 눌러서 홈 페이지의 조건 작성을 끝낸다.
처음 작성한 화면은 Path 가 /home 으로 되어 있어서
`localhost:포트번호/en/home` 으로 지정이 된다.

### 이후로 진행할 작업
VirtualBox fedora38 (용도: 가상시스템에서 홈페이지 운영)
1. wiki.js
(1) wiki.js 설치
(2) wiki.js 작성
(3) 데이터 백업
(4) 네트워크 구축
1. WordPress
(1) wordpress 설치
(2) wordpress 작성
(3) PhotoScape 사용
(4) wordpress 구축
1. ktor
(1) start.ktor.io 사용
(2) Postman 테스트
(3) 샘플-1 실행

# rclone 으로 구글 드라이브 사용하기

1. 구글 드라이브를 Fedora 에서 `백업용 클라우드`로 쓰기 위해서는 google drive 를 연결하는 이름을 만들어야 한다.
```
rclone config #-- (1) 구글 드라이브를 fedora 에서 쓰기 위한 설정작업을 시작합니다.
```

2. 화면에 다음과 같이 설정에 필요한 명령어가 나타난다.
```
No remotes found - make a new one
n) New remote
s) Set configuration password
q) Quit config
n/s/q>
```
3 `n` 을 입력해서 새로운 원격장소 (리모트) 만들기를 시작한다.
```
n/s/q> n
      === (새로운 리모트 만들기)
name>
```
4. 구글 드라이브는 구글 `이메일 계정 하나당 1개만` 지정된다. 그 드라이브를 가리키는 리모트의 이름을 입력한다.
```
name> abcdefg
     ========= (rclone 사용할 이름. 앞으로 이 이름으로 연결하게 된다.)
Option Storage.
Type of storage to configure.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value.
...
Storage>
```
5. `rclone` 프로그램은 구글 드라이브 뿐 아니라 다른 클라우드 스토리지도 연결할수 있으므로, 어느 클라우드를  쓸 것인지 선택해야 한다. 여기서는 구글 드라이브를 선택한다.
나열되는 숫자를 입력해도 되고, 문자를 입력해도 된다. 여기서는 구글 드라이브를 가리키는 `drive` 를 입력했다.
```
Choose a number from below, or type in your own value.
...
16 / Google Drive
   \ "drive"
...
(스토리지 종류가 45개로 상당히 많다.)
...
Storage> drive
        ======= (Google Drive 로 지정)
Option client_id.
Google Application Client Id
Setting your own is recommended.
...
client_id> 
```
6. `client_id` 는 기본 값으로 하기 위해 그냥 ```엔터```를 친다.
```
client_id> 
          ---
Option client_secret.
OAuth Client Secret.
client_secret> 
              ---
Option scope.
Scope that rclone should use when requesting access from drive.
Enter a string value. Press Enter for the default ("").
Choose a number from below, or type in your own value.
 1 / Full access all files, excluding Application Data Folder.
...
scope>
```

7. scope 는 `1` 로 지정한다.
```
scope> 1
      === (지정)
root_folder_id> 
```

8. 이후는 기본값으로 지정하기 위해 그냥 `엔터`를 친다.
```
Option root_folder_id.
ID of the root folder.
root_folder_id> 
               ---
Option service_account_file.
Service Account Credentials JSON file path.
service_account_file> 
                     ---
Edit advanced config?
y/n> 
    ---
Use auto config?
y/n> 
    --- (브라우저가 뜨면,)
```

9. `auto config` 다음에는 프로그램이 브라우저를 띄워서 본인 확인을 한다.
Google 계정으로 `로그인` >
`계정에 액세스하려고 합니다` > emails `주소` 확인후 [`취소`] [`허용`] 선택.
끝내면 된다)
```
Use auto config?
y/n> 
    ---
Configure this as a Shared Drive (Team Drive)?
y/n> 
    ---
y/e/d> 
      ---
Current remotes:

Name                 Type
====                 ====
abcdefg              drive
```

10. 리모트 이름이 위와 같이 등록되었므므로 이 작업을 끝낸다.
```
e/n/d/r/c/s/q> q
              ===
```

# wiki.js 데이터의 백업과 리스토어

## wiki.js 단순백업 보관하기

```
DB_NAME="wiki" #- 백업할 데이터베이스 이름
#-
sudo docker ps -a ; sudo docker stop wikijs ; echo "#-- (1) 위키 도커를 중단합니다."
LOCAL_FOLDER="/home/backup/simple_wikidb" #- 보관용 로컬 저장소
if [ ! -d ${LOCAL_FOLDER} ]; then
    sudo mkdir -p ${LOCAL_FOLDER} ; sudo chown ${USER}:${USER} ${LOCAL_FOLDER}
fi
this_y4m2=$(date +%Y)-$(date +%m) #- 2022-08
LOCAL_Y2M2=${LOCAL_FOLDER}/${this_y4m2}
if [ ! -d ${LOCAL_Y2M2} ]; then
    mkdir -p ${LOCAL_Y2M2} ; echo "#-- (2) ${LOCAL_Y2M2} 로컬 디렉토리를 만듭니다."
fi
ls -lR ${LOCAL_Y2M2} ; echo "#-- (3) 보관용 로컬 디렉토리 입니다."
#-
REMOTE_FOLDER="simple_wiki.js" #- 원격 저장소의 첫번째 폴더 이름
RCLONE_NAME="yosjgc" #- rclone 이름
REMOTE_Y2M2=${REMOTE_FOLDER}/${this_y4m2}
#-
ymd_hm=$(date +"%y%m%d%a-%H%M")
DB_sql7z=${DB_NAME}_${ymd_hm}_$(uname -n).sql.7z #- 압축파일 이름
cat <<__EOF__
#-
#- DB 백업
#-
#- (4) wili.js 데이터베이스를 백업하기 위해서 아래에 ---비밀번호--- 를 입력하세요.
#-
__EOF__
sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${LOCAL_Y2M2}/${DB_sql7z} -p ; echo "#-- (5) 오늘 요일이름의 로컬 보관장소에 백업합니다."
ls -lR ${LOCAL_Y2M2} ; echo "#-- (6) 보관용 로컬 폴더입니다."
/usr/bin/rclone copy ${LOCAL_Y2M2}/${DB_sql7z} ${RCLONE_NAME}:${REMOTE_Y2M2}/ ; echo "#-- (7) 오늘 요일이름의 파일을 클라우드로 복사합니다."
/usr/bin/rclone lsl ${RCLONE_NAME}:${REMOTE_Y2M2} ; echo "#-- (8) 클라우드 폴더입니다."
#-
sudo docker start wikijs ; sudo docker ps -a ; echo "#-- (9) 위키 도커를 다시 시작합니다."
```

## wiki.js 클라우드에 백업하기

```
sudo docker ps -a ; sudo docker stop wikijs ; echo "#-- (1-1) 위키 도커를 중단합니다."
#-
DB_NAME="wiki" #- 백업할 데이터베이스 이름
LOCAL_FOLDER="/home/backup/wikidb" #- 백업파일을 저장하는 로컬 저장소의 디렉토리 이름
REMOTE_FOLDER="wiki.js" #- 원격 저장소의 첫번째 폴더 이름
RCLONE_NAME="yosjgc" #- rclone 이름
#-
this_year=$(date +%Y) #- 2022
this_wol=$(date +%m) #- 07
ymd_hm=$(date +"%y%m%d%a-%H%M")
pswd_ym=$(date +"%y%m")
yoil_number0to6=$(date +%u) #- 일0 월1 화2 수3 목4 금5 토6
yoil_number1to7=$(( ${yoil_number0to6} + 1 )) #- 1 2 3 4 5 6 7
ju_beonho=$(date +%V) #- 1년중 몇번째 주인지 표시.
#- V: 월요일마다 하나씩 증가한다.
#- U: (1월1일이 일요일 이면 01, 아니면 00), 일요일마다 하나씩 증가한다.
#-
yoil_sql_7z=".${yoil_number1to7}yoil.sql.7z" #- 요일 표시
uname_n=$(uname -n)
YOIL_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${yoil_sql_7z}
this_wol_sql_7z=".${this_wol}wol.sql.7z" #- 월 표시
WOL_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${this_wol_sql_7z}
ju_beonho_sql_7z=".${ju_beonho}ju.sql.7z" #- 1년중 몇번째 주인지 표시
JU_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${ju_beonho_sql_7z}
#-
if [ ! -d ${LOCAL_FOLDER} ];then
	sudo mkdir -p ${LOCAL_FOLDER} ; sudo chown ${USER}:${USER} ${LOCAL_FOLDER} ; echo "#-- (1-2) 매월 마지막 백업 1개씩만 보관하는 ${LOCAL_FOLDER} 로컬 디렉토리를 만듭니다."
fi
LOCAL_THIS_YEAR=${LOCAL_FOLDER}/${this_year}
LOCAL_YOIL=${LOCAL_THIS_YEAR}/1_7yoil
if [ ! -d ${LOCAL_YOIL} ]; then
	mkdir -p ${LOCAL_YOIL} ; echo "#-- (1-3) 최근 1주일치만 보관하는 ${LOCAL_YOIL} 로컬 디렉토리를 만듭니다."
fi
LOCAL_JU=${LOCAL_THIS_YEAR}/01_53ju #- 년도의 ju 폴더에는 매주 마지막 백업 1개씩만 보관한다.
if [ ! -d ${LOCAL_JU} ]; then
	mkdir -p ${LOCAL_JU} ; echo "#-- (1-4) 매주 마지막 백업 1개씩만 보관하는 ${LOCAL_JU} 로컬 디렉토리를 만듭니다."
fi
#-
REMOTE_YEAR=${REMOTE_FOLDER}/${this_year} #- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년도
REMOTE_YOIL=${REMOTE_YEAR}/1_7yoil #- 최근 요일
REMOTE_JU=${REMOTE_YEAR}/01_53ju #- 주 일련번호
ls -lR ${LOCAL_THIS_YEAR} ; echo "#-- (1-5) ${LOCAL_THIS_YEAR} 보관용 --로컬-- 디렉토리 입니다."
#-
rm -f ${LOCAL_YOIL}/*${yoil_sql_7z} ; echo "#-- (1-6) < ${yoil_sql_7z} > 이름의 --로컬-- 지난백업 을 삭제합니다."
#-
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YOIL}/ | grep ${yoil_sql_7z} | awk '{print $2}') #- < ${yoil_sql_7z} > 이름의 백업파일이 클라우드에 있는지 확인합니다.
if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST" #- < ${yoil_sql_7z} > 이름의 클라우드 백업파일이 있는 경우,
	for val in "${Remote_Sql7z_Array[@]}"
	do
		file_name=$(echo ${val} | sed 's/ *$//g') #- 빈칸 삭제 // https://linuxhint.com/trim_string_bash/
		/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_YOIL}/${file_name} ; echo "#-- (1-7) < ${yoil_sql_7z} > 이름의 ==클라우드== 지난백업 을 삭제합니다."
	done
fi
cat <<__EOF__
#-
#- DB 를 < ${yoil_sql_7z} > 이름으로 압축.
#-
#-- (1-8) wili.js 데이터베이스를 백업하기 위해서 아래에 ---비밀번호--- 를 입력하세요.
#-
__EOF__
sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${LOCAL_YOIL}/${YOIL_sql7z} -p ; echo "#-- (1-9) < ${yoil_sql_7z} > 이름의 --로컬-- 에 압축보관 합니다."
/usr/bin/rclone copy ${LOCAL_YOIL}/${YOIL_sql7z} ${RCLONE_NAME}:${REMOTE_YOIL}/ ; echo "#-- (1-10) < ${yoil_sql_7z} > 이름의 ==클라우드== 에 복사합니다."
/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YOIL} ; echo "#-- (1-11) < ${yoil_sql_7z} > 이름의 ==클라우드== 백업 내역입니다."
cat <<__EOF__
#-
#- ::${this_wol_sql_7z}:: 지난백업 삭제
#-
__EOF__
rm -f ${LOCAL_THIS_YEAR}/*${this_wol_sql_7z} ; echo "#-- (1-12) ::${this_wol_sql_7z}:: 이름의 --로컬-- 지난백업 을 삭제합니다."
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR}/ | grep ${this_wol_sql_7z} | awk '{print $2}') #- ::${this_wol_sql_7z}:: 의 백업파일이 클라우드에 있는지 확인 합니다.
if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"
	for val in "${Remote_Sql7z_Array[@]}"
	do
		file_name=$(echo ${val} | sed 's/ *$//g') #- 빈칸 삭제
		/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_YEAR}/${file_name} ; echo "#-- (1-13) ::${this_wol_sql_7z}:: 이름의 ==클라우드== 지난백업 을 삭제합니다."
	done
fi
cat <<__EOF__
#-
#- ::${this_wol_sql_7z}:: 으로 복사
#-
__EOF__
cp ${LOCAL_YOIL}/${YOIL_sql7z} ${LOCAL_THIS_YEAR}/${WOL_sql7z} ; echo "#-- (1-14) < ${yoil_sql_7z} > 이름의 파일을 ::${this_wol_sql_7z}:: 이름으로 바꾸어 로컬의 년도폴더에 복사합니다."
/usr/bin/rclone copy ${LOCAL_THIS_YEAR}/${WOL_sql7z} ${RCLONE_NAME}:${REMOTE_YEAR}/ ; echo "#-- (1-15) ::${this_wol_sql_7z}:: 이름의 ==클라우드== 에 복사합니다."
/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR} ; echo "#-- (1-16) ::${this_wol_sql_7z}:: 이름의 ==클라우드== 백업 내역입니다."
cat <<__EOF__
#-
#- ( ${ju_beonho_sql_7z} ) 이름으로 된 지난백업 삭제
#-
__EOF__
rm -f ${LOCAL_JU}/*${ju_beonho_sql_7z} ; echo "#-- (1-17) ( ${ju_beonho_sql_7z} ) 이름의 --로컬-- 지난백업 을 삭제합니다."
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_JU}/ | grep ${ju_beonho_sql_7z} | awk '{print \$2}') #- ( ${ju_beonho_sql_7z} ) 이름의 백업파일이 클라우드에 있는지 확인 합니다.
if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
	mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"
	for val in "${Remote_Sql7z_Array[@]}"
	do
		file_name=$(echo ${val} | sed 's/ *$//g') #- 빈칸 삭제
		/usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_JU}/${file_name} ; echo "#-- (1-18) ( ${ju_beonho_sql_7z} ) 이름의 ==클라우드== 지난백업 을 삭제합니다."
	done
fi
cat <<__EOF__
#-
#- 오늘의 ${ju_beonho_sql_7z} 이름으로 복사
#-
__EOF__
cp ${LOCAL_YOIL}/${YOIL_sql7z} ${LOCAL_JU}/${JU_sql7z} ; echo "#-- (1-19) < ${yoil_sql_7z} > 이름의 파일을 ( ${ju_beonho_sql_7z} ) 이름으로 바꾸어 로컬의 ( ${ju_beonho_sql_7z} ) 폴더에 복사합니다."
/usr/bin/rclone copy ${LOCAL_JU}/${JU_sql7z} ${RCLONE_NAME}:${REMOTE_JU}/) ; echo "#-- (1-20) ( ${ju_beonho_sql_7z} ) 이름의 ==클라우드== 에 복사합니다."
#-
ls -lR ${LOCAL_THIS_YEAR} ; echo "#-- (1-21) ${LOCAL_THIS_YEAR} 보관용 로컬 폴더입니다."
/usr/bin/rclone lsl ${RCLONE_NAME}:${REMOTE_YEAR} ; echo "#-- (1-22) ==클라우드== 백업 내역입니다."
#-
sudo docker start wikijs ; sudo docker ps -a ; echo "#-- (1-23) 위키 도커를 다시 시작합니다."
```

## 서버용 simple_wiki.js-BACKUP.sh 스크립트.
```
#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="wiki.js 데이터를 google drive 에 백업"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


DB_NAME="wiki" #- 백업할 데이터베이스 이름
#-
cmdRun "sudo docker ps -a ; sudo docker stop wikijs" "(1) 위키 도커를 중단합니다."
LOCAL_FOLDER="/home/backup/simple_wikidb" #- 보관용 로컬 저장소
if [ ! -d ${LOCAL_FOLDER} ]; then
	cmdRun "sudo mkdir -p ${LOCAL_FOLDER} ; sudo chown ${USER}:${USER} ${LOCAL_FOLDER}" "(2) 보관용 로컬 저장소 폴더를 새로 만듭니다."
fi
this_y4m2=$(date +%Y)-$(date +%m) #- 2022-08
LOCAL_Y2M2=${LOCAL_FOLDER}/${this_y4m2}
if [ ! -d ${LOCAL_Y2M2} ]; then
    cmdRun "mkdir -p ${LOCAL_Y2M2}" "(3) ${LOCAL_Y2M2} 로컬 디렉토리를 만듭니다."
fi
cmdRun "ls -lR ${LOCAL_Y2M2}" "(4) 보관용 로컬 디렉토리 입니다."
#-
REMOTE_FOLDER="simple_wiki.js" #- 원격 저장소의 첫번째 폴더 이름
RCLONE_NAME="yosjgc" #- rclone 이름
REMOTE_Y2M2=${REMOTE_FOLDER}/${this_y4m2}
#-
ymd_hm=$(date +"%y%m%d%a-%H%M")
DB_sql7z=${DB_NAME}_${ymd_hm}_$(uname -n).sql.7z #- 압축파일 이름
cat <<__EOF__
${cMagenta}
#- DB 백업

#- ${cRed}${DB_sql7z} ${cMagenta}데이터베이스를 백업하기 위해서 아래에 ${cRed}----${cYellow}비밀번호${cRed}----${cMagenta} 를 입력하세요.
${cReset}
__EOF__
cmdRun "sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${LOCAL_Y2M2}/${DB_sql7z} -p" "(5) 데이터베이스를 백업하기 위해서 아래에 ${cRed}----${cYellow}비밀번호${cRed}----${cCyan} 를 입력하세요."
cmdRun "ls -lR ${LOCAL_Y2M2}" "(6) 보관용 로컬 폴더입니다."
cmdRun "/usr/bin/rclone copy ${LOCAL_Y2M2}/${DB_sql7z} ${RCLONE_NAME}:${REMOTE_Y2M2}/" "(7) 오늘 요일이름의 파일을 클라우드로 복사합니다."
cmdRun "/usr/bin/rclone lsl ${RCLONE_NAME}:${REMOTE_Y2M2}" "(8) 클라우드 폴더입니다."
#-
cmdRun "sudo docker start wikijs ; sudo docker ps -a" "(9) 위키 도커를 다시 시작합니다."


# ----
rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
```

## 백업한 .7z 파일을 wiki.js 데이터베이스로 리스토어 하기

cat ~/bin/color_base 
```
#!/bin/sh

CMD_NAME=`basename $0` ; CMD_DIR=${0%/$CMD_NAME} ; if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then CMD_DIR="." ; fi
cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cmdRun () {
	echo "${cCyan}----> ${cYellow}$1 ${cGreen}#-- ${cBlue}$2${cReset}"; echo "$1" | sh
	echo "${cGreen}<---- ${cBlue}$1 ${cGreen}#-- ${cBlue}$2${cReset}"
}
cmdCont () {
	echo -e "${cCyan}----> ${cYellow}$1 ${cGreen}#-- ${cBlue}$2\n----> ${cMagenta}Enter ${cGreen}to continue${cReset}:"
	read a ; echo "${cUp}"; echo "$1" | sh
	echo "${cGreen}<---- ${cBlue}$1 ${cGreen}#-- ${cBlue}$2${cReset}"
}
ALL_INSTALL="n"
cmdYenter () {
	echo "${cCyan}----> ${cYellow}$1 ${cGreen}#-- ${cBlue}$2${cReset}"
	if [ "x${ALL_INSTALL}" = "xy" ]; then
		echo "$1" | sh ; echo "${cGreen}<---- ${cBlue}$1 ${cMagenta}#-- ${cBlue}$2${cReset}"
	else
		echo "${cCyan}----> ${cRed}press ${cCyan}'${cYellow}y${cCyan}'${cRed} or Enter${cReset}:"; read a; echo "${cUp}"
		if [ "x$a" = "xy" ]; then
			echo "${cRed}-OK-${cReset}"; echo "$1" | sh
			echo "${cGreen}<---- ${cBlue}$1 press 'y' or Enter: ${cMagenta}#-- ${cBlue}$2${cReset}"
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
	echo "${cCyan}----> ${cRed}$1${cReset}"
}
cmdTTend () {
	echo "${cBlue}<---- ${cMagenta}$1${cReset}"
}
freesound_dir="${HOME}/bin/freesound"
ding_play () {
	if [ "x$PLAY_OK" = "xok" ]; then #-- play 설치가 된 경우,
		if [ "x$1" = "x1" ]; then play -q ${freesound_dir}/play-1-pbong.wav & #-- 91926__tim-kahn__ding.wav & #---- x1=딩~
		else if [ "x$1" = "x2" ]; then play -q ${freesound_dir}/play-2-castanets.wav & #-- 411459__inspectorj__castanets-multi-a-h1.wav & #---- x2=캐스터네츠~
		else if [ "x$1" = "x3" ]; then play -q ${freesound_dir}/play-3-ddenng.wav & #-- 339816__inspectorj__hand-bells-f-single.wav & #---- x3=뗅-
		else if [ "x$1" = "x4" ]; then play -q ${freesound_dir}/play-4-tiiill.wav & #-- 212541__misstickle__indian-bell-chime.wav & #---- x4=띠일~
		else if [ "x$1" = "x5" ]; then play -q ${freesound_dir}/play-5-gguuuung.wav & #-- 411090__inspectorj__wind-chime-gamelan-gong-a.wav & #---- x5=데에엥~~
		else play -q ${freesound_dir}/play-6-ddeeeng.wav & #-- 513865__wormletter__chime-c.wav & #---- x6=교회 뎅-
		fi ; fi ; fi ; fi ; fi
	else
		echo "${cRed}~~~ play-${1} ~~~${cReset}"
	fi
}
# ding_play 1 #-- 1=딩~ 2=캐스터네츠~ 3=뗅- 4=띠일~ 5=데에엥~~ 6=교회 뎅-
# $PLAY_OK="ok" #-- 인 경우만 사용할수 있다.

change_special_char () {
	#-- " str_01 " == 빈칸을 밑줄로.
	local str_01=$(echo ${original_file_name} | sed 's/ /_/g')
	#-- " str_02 " == 대문자를 소문자로.
	# https://varie.tistory.com/entry/Bash%EC%89%98%EC%97%90%EC%84%9C-%ED%8C%8C%EC%9D%BC%EB%AA%85-%EC%9D%BC%EA%B4%84-%EB%8C%80%EC%86%8C%EB%AC%B8%EC%9E%90-%EB%B3%80%ED%99%98
	local str_02=$(echo ${str_01,,})
	#-- 소문자를 대문자로 바꿀때는: str_02=$(echo ${str_01^^})
	#-- bash3.x 인 경우: str_02=$(echo ${str_01} | tr '[A-Z]' '[a-z]')
	#-- "str_03 " == 특수문자 삭제하거나 변경
	new_name=$(echo ${str_02} | sed 's/(/./g' | sed 's/)/./g' | sed 's/;/./g' | sed 's/</./g' | sed 's/>/./g' | sed 's/\[/./g' | sed 's/\]/./g' | sed 's/\//./g' | sed 's/+/./g' | sed 's/,/./g')
}

#-- source ${HOME}/bin/color_base #-- 230524수 0828 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq cmdTTbegin cmdTTend ding_play change_special_char () <== original_file_name ==> new_name
```

cat restore_wikijs_from_backup_file.sh 
```
#!/bin/sh

source ${HOME}/bin/color_base #-- 221027목-1257 CMD_DIR CMD_NAME cmdRun cmdCont cmdYenter echoSeq 
MEMO="백업파일을 wiki.js 데이터베이스로 리스토어 하기"
cat <<__EOF__
${cMagenta}>>>>>>>>>>${cGreen} $0 ${cMagenta}||| ${cCyan}${MEMO} ${cMagenta}>>>>>>>>>>${cReset}
__EOF__
# zz00logs_folder="${HOME}/zz00logs" ; if [ ! -d "${zz00logs_folder}" ]; then cmdRun "mkdir ${zz00logs_folder}" "로그 폴더" ; fi
# zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")__RUNNING_${CMD_NAME}" ; touch ${zz00log_name}
# ----


if [ "x$1" != "x" ]; then
	db_sql_7z="$1"
else
	cat <<__EOF__
${cBlue}#-
#- 리스토어 할 sql.7z 파일 위치 및 이름을 [ /media/sf_Downloads/wiki_220906화-1802_proenpi4b.36ju.sql.7z ] 처럼 입력하세요.
#-${cReset}
__EOF__
	read db_sql_7z
fi
if [ "x${db_sql_7z}" = "x" ]; then
	cat <<__EOF__
${cBlue}# !
# ! wiki.js 데이터베이스에 리스토어 하기 위한 백업파일 이름을 지정해야 합니다.
# !${cReset}
__EOF__
	exit 1
fi
if [ ! -f "${db_sql_7z}" ]; then
	cat <<__EOF__
${cBlue}# !
# ! --${db_sql_7z}-- 백업파일이 없습니다.
# !${cReset}
__EOF__
	exit 2
fi
cat <<__EOF__
${cBlue}#-
#- 현재 운영중인 데이터베이스를 백업하려고 합니다.
#-
#- 만일 ${cRed}백업할 필요가 없다면 ${cYellow}'n' ${cBlue}을 눌러 주세요.
#-${cReset}
__EOF__
read a ; echo "[ $a ]"
last_skip="backup_ok"
if [ "x$a" = 'xn' ]; then
	cat <<__EOF__
${cBlue}#-
#-
#-
#- ${cMagenta}!!!! 주의 !!!! ${cRed}현재 운영중인 데이터베이스를 다운로드 + 백업 하지않고${cBlue}, 이전의 백업을 리스토어 합니다.
#-
#- ----> 맞으면 ${cYellow}'y' ${cBlue}를 눌러 주세요.
#-${cReset}
__EOF__
	read a ; echo "[ $a ]"
	if [ "x$a" != "xy" ]; then
		exit 3
	fi
	last_skip="no_backup"
fi
# DB_NAME="wiki" #-- 백업할 데이터베이스 이름
# LOGIN_PATH="wikipsql" #-- 데이터베이스 로그인 패쓰 ;;; pgsql 이라서 쓰지는 않음.
# LOCAL_FOLDER="/home/backup/wiki.js" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
# REMOTE_FOLDER="wiki.js" #-- 원격 저장소의 첫번째 폴더 이름
# RCLONE_NAME="yosgc" #-- rclone 이름 yosjeongc
# DB_TYPE="pgsql"

LOCAL_FOLDER="/home/backup/wiki.js" #-- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
dir_for_backup=${LOCAL_FOLDER}/last_backup_b4_restore #-- 백업을 리스토어 하기전, 현재DB 백업하는 로컬 저장소
if [ ! -d ${dir_for_backup} ]; then
	cmdRun "sudo mkdir -p ${dir_for_backup} ; sudo chown ${USER}.${USER} ${dir_for_backup}" "#-- (1) 현재 운영중인 DB 를 백업하는 로컬 저장소 만듭니다."
fi

cmdRun "sudo docker ps -a ; sudo docker stop wikijs ; sudo docker ps -a" "#-- (2) 백업을 위해 wiki.js 도커를 중단합니다."

if [ "x${last_skip}" = "xbackup_ok" ]; then
	current_backup="last-wikijs-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
	cat <<__EOF__
${cBlue}#-
#- (3) 지정한 백업파일을 DB 서버에 ${cRed}리스토어 하기전에${cBlue}, 현재 운영중인 DB 를 먼저 백업합니다.
#-
#- 백업시 ${cYellow}비밀번호 ${cBlue}를 입력하세요.
#-${cReset}
__EOF__
	cmdRun "sudo docker exec wikijsdb pg_dumpall -U imwiki | time 7za a -si ${dir_for_backup}/${current_backup} -p" "#-- (4) 현재 운영중인 DB 를 먼저 ${dir_for_backup} 에 백업합니다."
fi
#cmdRun "sudo docker exec -it wikijsdb dropdb -U imwiki wiki" "#-- (5) 데이터베이스를 삭제합니다."
cmdRun "sudo docker exec  wikijsdb dropdb -U imwiki wiki" "#-- (5) 데이터베이스를 삭제합니다."
cmdRun "sudo docker exec  wikijsdb createdb -U imwiki wiki" "#-- (6) 데이터베이스를 새로 만듭니다."
cat <<__EOF__
${cBlue}#-
#-- (7) 지정한 백업파일을 ${cRed}DB 서버에${cBlue} 리스토어 합니다.
#-
#- 백업시 ${cYellow}비밀번호 ${cBlue}를 입력하세요.
#-${cReset}
__EOF__
cmdRun "time 7za x -so ${db_sql_7z} | sudo docker exec -i wikijsdb psql -U imwiki wiki" "#-- (8) 백업파일을 DB 에 리스토어 합니다."
cmdRun "sudo docker start wikijs ; sudo docker ps -a" "#-- (9) 중단했던 wiki.js 도커를 다시 시작합니다."


# ----
# rm -f ${zz00log_name} ; zz00log_name="${zz00logs_folder}/zz.$(date +"%y%m%d%a-%H%M%S")..${CMD_NAME}" ; touch ${zz00log_name}
# ls --color ${zz00logs_folder}
cat <<__EOF__
${cRed}<<<<<<<<<<${cBlue} $0 ${cRed}||| ${cMagenta}${MEMO} ${cRed}<<<<<<<<<<${cReset}
__EOF__
```

# pgAdmin: PostgreSQL 도구
(https://www.pgadmin.org/)

pgAdmin은 세계에서 가장 발전된 오픈 소스 데이터베이스인 PostgreSQL을 위한 가장 인기 있고 기능이 풍부한 오픈 소스 관리 및 개발 플랫폼입니다.
pgAdmin은 Linux, Unix, macOS 및 Windows에서 PostgreSQL 및 EDB Advanced Server 10 이상을 관리하는 데 사용할 수 있습니다.

다운로드: (https://www.pgadmin.org/download/)

## RPM / Fedora 버전

rpm: (https://www.pgadmin.org/download/pgadmin-4-rpm/)

0. 이전의 pgAdmin 리포지토리 패키지가 있을경우, 삭제하려면.
```
sudo rpm -e pgadmin4-fedora-repo
```

1. 리포지토리 설정하기
```
sudo rpm -i https://ftp.postgresql.org/pub/pgadmin/pgadmin4/yum/pgadmin4-fedora-repo-2-1.noarch.rpm
```

2. pgAdmin 설치하기

(2-1) 데스크톱 및 웹 모드 모두 설치하기.
```
sudo yum install pgadmin4
```

(2-2) 데스크톱 모드 전용으로 설치.
```
sudo yum install pgadmin4-desktop
```

(2-3) 웹 모드 전용으로 설치.
```
sudo yum install pgadmin4-web
```

(2-4) 이때 pgadmin4 또는 pgadmin4-web 을 설치한 경우.

다음의 웹 설정 스크립트를 실행하여 웹 모드에서 실행되도록 시스템을 구성합니다.
```
sudo /usr/pgadmin4/bin/setup-web.sh
```

3. pgAdmin을 업그레이드하려면 다음 명령을 실행합니다.

```
sudo yum upgrade pgadmin4
```

## Windows 버전

windows: (https://www.pgadmin.org/download/pgadmin-4-windows/)

[ 2023년 3월 9일 릴리스 ](https://www.postgresql.org/ftp/pgadmin/pgadmin4/v6.21/windows/)

1. 안녕히주무세요 어퍼컷Tube 구독자 97.4만명 조회수 22만회  3일 전 스타워즈 모든 시리즈는 디즈니 플러스에서 시청가능합니다!! https://www.youtube.com/watch?v=AUfAN2wNEMk

📌 특수문자 이모티콘 모음 wepplication.github.io/tools/charMap/#unicode-2500-257F
┏┳━┓
┃┃╌┃
┣╋━┫
┗┻━┛

📌 https://wepplication.github.io/tools/charMap/#emoji
