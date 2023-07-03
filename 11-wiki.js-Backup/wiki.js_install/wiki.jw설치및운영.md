# wiki.js 설치

## 1. 도커 설치하기

1. 시스템을 최신으로 업데이트 한다.
```
sudo dnf -y update
```

2. Fedora 리파지토리를 시스템에 추가한 다음이라야 docker 를 설치할 수 있다.
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

3. Docker CE 를 Fedora 에 설치한다.
```
sudo dnf makecache
sudo dnf -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker
```
제대로 설치되었는지 확인한다.
```
sudo systemctl status docker
sudo docker version
```

4. sudo 를 쓰지 않고도 처리토록 하거나 설치확인을 위해 테스트하는 생략 가능한 스크립트.
```
sudo usermod -aG docker $(whoami) ; newgrp docker ; echo "#-- (4-1) Docker 그룹은 만들었지만 사용자를 추가하지는 않았으며, sudo 없이 docker 명령을 실행하기 위해, 이 그룹에 사용자를 추가합니다."
sudo docker pull alpine ; echo "#-- (4-2) 설치 확인을 위해, 테스트 도커를 다운로드해 봅니다."
sudo docker run -it --rm alpine /bin/sh ; echo "#-- (4-3) 확인을 위해 'apk update' 와 'exit' 를 입력하세요."
```

## 2. 도커 컴포즈를 빌드하기

1. 디렉토리 만들기
2. 포트번호를 지정하고 설정파일 만들기
3. 도커 컴포즈 (빌드 + 실행) 하기
4. 브라우저에서 (주소:포트번호) 입력
5. 첫번째 등록작업

작업의 편의를 위해 터미널에서 입력하는 스크립트를 추가하였다
.

### 1. 작업에 필요한 디렉토리 만들기
wiki.js 를 위한 데이터베이스로 포스트그레스 (postgres DB) 를 선택했으므로, 이것을 보관할 디렉토리를 만들고, wiki.js 설정을 위한 파일을 보관할 디렉토리도 만든다.
```
cat <<__EOF__
---------------------------------


+---+
|   | 1. 작업에 필요한 디렉토리 만들기
+---+

__EOF__

docker_folder=/home/docker
pgsql_folder=${docker_folder}/pgsql
wiki_conf_folder=${docker_folder}/wiki_conf

p_made="x"
if [ ! -d ${pgsql_folder} ]; then
	sudo mkdir -p ${pgsql_folder}
	sudo chcon -R system_u:object_r:container_file_t:s0 ${pgsql_folder}
	sudo chown -R systemd-coredump:ssh_keys ${pgsql_folder}
	p_made="o"
fi

w_made="x"
if [ ! -d ${wiki_conf_folder} ]; then
	sudo mkdir -p ${wiki_conf_folder}
	sudo chown -R ${USER}:${USER} ${wiki_conf_folder}
	w_made="o"
fi

if [ "x${p_made}" = "xx" ] || [ "x${w_made}" = "xx" ]; then
	cat <<__EOF__
!!!!> 다음 디렉토리가 이미 있습니다.
$(sudo ls -l --color ${pgsql_folder})
$(sudo ls -l --color ${wiki_conf_folder})
$(sudo ls -l --color ${docker_folder})
!!!!> 전에 쓰던 디렉토리가 남아있던것 같습니다.
!!!!> 확인후 삭제하고 이 스크립트를 다시 시작하세요.
!!!!> sudo rm -rf ${pgsql_folder} ${wiki_conf_folder}
__EOF__
	exit -1
fi
cat <<__EOF__
( 1 )---------------------------------
__EOF__
```

### 2. 포트번호를 지정하고 설정파일 만들기
```
cat <<__EOF__
---------------------------------


+---+
|   | 2. 포트번호를 지정하고 설정파일 만들기
+---+

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
( 2 )---------------------------------
__EOF__
```

### 3. 도커 컴포즈 `빌드 + 실행` 하기
```
cat <<__EOF__
---------------------------------


+---+
|   | 3. 도커 컴포즈 `빌드 + 실행` 하기
+---+

__EOF__

cd ${wiki_conf_folder}
sudo dnf -y install docker-compose

rpm -qi docker-compose
sudo docker ps -a

sudo docker-compose pull wiki
echo "#-- 도커 컴포즈 wiki 를 빌드합니다."

sudo docker-compose up --force-recreate &
echo "#-- 빌드한 도커 컴포즈를 실행합니다."

sudo docker-compose ps -a
cat <<__EOF__
( 3 )---------------------------------
__EOF__
```

### 4. 도커의 위키서버가 시작되면, 브라우저에서 `주소 또는 localhost:포트번호` 를 입력한다.

`localhost:포트번호`

### 5. 첫번째 등록작업을 한다.
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

# rclone 으로 구글 드라이브 사용하기

1. 구글 드라이브를 Fedora 에서 쓰기 위해서는 google drive 를 연결하는 이름을 만들어야 한다.
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

# wiki.js 단순백업 보관하기

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

# wiki.js 클라우드에 백업하기

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

# 서버용 simple_wiki.js-BACKUP.sh 스크립트.
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

## pgAdmin: PostgreSQL 도구 (https://www.pgadmin.org/)

pgAdmin은 세계에서 가장 발전된 오픈 소스 데이터베이스인 PostgreSQL을 위한 가장 인기 있고 기능이 풍부한 오픈 소스 관리 및 개발 플랫폼입니다.
pgAdmin은 Linux, Unix, macOS 및 Windows에서 PostgreSQL 및 EDB Advanced Server 10 이상을 관리하는 데 사용할 수 있습니다.

다운로드: (https://www.pgadmin.org/download/)

### RPM / Fedora 버전

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

### Windows 버전

windows: (https://www.pgadmin.org/download/pgadmin-4-windows/)

[ 2023년 3월 9일 릴리스 ](pgAdmin 4 v6.21)

