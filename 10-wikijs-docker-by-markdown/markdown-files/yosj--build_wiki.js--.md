# wiki.js 설치

## 1. docker-ce 를 fedora 에 설치하기

1. 시스템을 최신으로 업데이트 한다.
```
sudo dnf -y update ; echo "#-- (1-1) 시스템을 업데이트 합니다."
```

2. Fedora 리파지토리를 시스템에 추가한 다음이라야 docker 를 설치할 수 있다.
```
echo "#-- (2-1) 출처: https://computingforgeeks.com/how-to-install-docker-on-fedora/"
sudo dnf -y install dnf-plugins-core ; echo "#-- (2-2) dnf-plugins-core 를 설치합니다."
sudo tee /etc/yum.repos.d/docker-ce.repo<<EOF
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/36/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
EOF
echo "#-- (2-3) Fedora 리파지토리를 시스템에 추가합니다."
```

3. Docker CE 를 Fedora 에 설치한다.
```
sudo dnf makecache ; echo "#-- (3-1) Docker CE 를 Fedora 에 설치합니다."
sudo dnf -y install docker-ce docker-ce-cli containerd.io ; echo "#-- (3-2)"
sudo systemctl enable --now docker ; echo "#-- (3-3) Docker 가 설치됐으므로, 도커 서비스를 실행합니다."
sudo systemctl status docker ; echo "#-- (3-4) 도커의 상태를 확인합니다."
sudo docker version ; echo "#-- (3-5) 도커 버전을 확인합니다."
```

4. sudo 를 쓰지 않고도 처리토록 하거나 설치확인을 위해 테스트하는 생략 가능한 스크립트.
```
sudo usermod -aG docker $(whoami) ; newgrp docker ; echo "#-- (4-1) Docker 그룹은 만들었지만 사용자를 추가하지는 않았으며, sudo 없이 docker 명령을 실행하기 위해, 이 그룹에 사용자를 추가합니다."
sudo docker pull alpine ; echo "#-- (4-2) 설치 확인을 위해, 테스트 도커를 다운로드해 봅니다."
sudo docker run -it --rm alpine /bin/sh ; echo "#-- (4-3) 확인을 위해 'apk update' 와 'exit' 를 입력하세요."
```

## 2. 도커 컴포즈를 빌드하기

1. wiki.js 를 위한 데이터베이스로 포스트그레스 (postgres DB) 를 선택했으므로, 이것을 보관할 디렉토리를 만들고, wiki.js 설정을 위한 파일을 보관할 디렉토리도 만든다.
```
db_folder=/home/docker
if [ ! -d ${db_folder} ]; then
	pgsql_folder=${db_folder}/pgsql
	if [ ! -d ${pgsql_folder} ]; then
		sudo mkdir -p ${pgsql_folder}
		sudo chcon -R system_u:object_r:container_file_t:s0 ${pgsql_folder}
		sudo chown -R systemd-coredump.ssh_keys ${pgsql_folder}
	fi
	wiki_conf_folder=${db_folder}/wiki.js
	if [ ! -d ${wiki_conf_folder} ]; then
		sudo mkdir -p ${wiki_conf_folder}
		sudo chown -R ${USER}.${USER} ${wiki_conf_folder}
	fi
	ls -lZ ${db_folder} ; echo "#-- (1-1) 데이터베이스 폴더를 만들었습니다."
else
	echo "#-- (1-2) ${db_folder} 디렉토리가 '있으'므로, 확인후 삭제하고 다시 시작하세요."
fi
```

2. 도커 컴포즈를 실행하기 위한 설정파일을 만든다.
```
port_no=5800
db_folder=/home/docker/pgsql
wiki_conf_folder=/home/docker/wiki.js
cd ${wiki_conf_folder} ; echo "#-- (2-1) cd ${wiki_conf_folder} 로 가서 해야 합니다."
cat > docker-compose.yml <<__EOF__
version: "3"
services:

  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: wiki
      POSTGRES_PASSWORD: wikijsrocks
      POSTGRES_USER: wikijs
    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - ${db_folder}:/var/lib/postgresql/data
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
      DB_USER: wikijs
      DB_PASS: wikijsrocks
      DB_NAME: wiki
    restart: unless-stopped
    ports:
      - "${port_no}:3000"
    container_name:
      wikijs
__EOF__
ls -l ${wiki_conf_folder} ; echo "#-- (2-2) 설정파일을 만들었습니다."
```

3. 도커 컴포즈 를 빌드한다.
```
wiki_conf_folder=/home/docker/wiki.js
cd ${wiki_conf_folder} ; echo "#-- (3-1) cd ${wiki_conf_folder} 로 가서 해야 합니다."
sudo dnf -y install docker-compose ; echo "#-- (3-2) Docker Compose 를 설치합니다."
rpm -qi docker-compose ; echo "#-- (3-3) 설치된것을 확인합니다."
sudo docker ps -a ; echo "#-- (3-4) 도커에 어떤 작업이 돌아가고 있는지 확인합니다."

sudo docker-compose pull wiki ; echo "#-- (3-5) 도커 컴포즈 wiki 를 빌드합니다."

sudo docker-compose ps ; echo "#-- (3-6) 실행중인 도커 작업을 확인합니다."
ifconfig | grep enp -A1 ; ifconfig | grep wlp -A1 ; echo "#-- (3-7) ip 를 확인합니다."
ifconfig | grep enp -A1 | tail -1 | awk '{print $2":"$port_no}' ; echo "#-- (3-8) ethernet"
ifconfig | grep wlp -A1 | tail -1 | awk '{print $2":"$port_no}' ; echo "#-- (3-9) wifi"
sudo docker-compose up --force-recreate &
echo "#-- (3-10) 빌드한 도커 컴포즈를 실행합니다."
sudo docker-compose ps -a ; echo "#-- (3-11) 도커 컴포즈에서 실행되고 있는 모든 작업을 확인합니다."
cat <<__EOF__

4. 위키서버가 시작되면 브라우저에서 이와같이 입력하면 된다.

+-------------------------------------/
|                                    /
|      localhost:${port_no}
|                                  /
+---------------------------------/
__EOF__
```

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
    sudo mkdir -p ${LOCAL_FOLDER} ; sudo chown ${USER}.${USER} ${LOCAL_FOLDER}
fi
this_y4m2=$(date +%Y)-$(date +%m) #- 2022-08
LOCAL_Y2M2=${LOCAL_FOLDER}/${this_y4m2}
if [ ! -d ${LOCAL_Y2M2} ]; then
    mkdir -p ${LOCAL_Y2M2} ; echo "#-- (2) ${LOCAL_Y2M2} 로컬 디렉토리를 만듭니다."
fi
ls -lR ${LOCAL_Y2M2} ; echo "#-- (3) 보관용 로컬 디렉토리 입니다."
#-
REMOTE_FOLDER="simple_wiki.js" #- 원격 저장소의 첫번째 폴더 이름
RCLONE_NAME="yosgc" #- rclone 이름
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
RCLONE_NAME="yosgc" #- rclone 이름
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
	sudo mkdir -p ${LOCAL_FOLDER} ; sudo chown ${USER}.${USER} ${LOCAL_FOLDER} ; echo "#-- (1-2) 매월 마지막 백업 1개씩만 보관하는 ${LOCAL_FOLDER} 로컬 디렉토리를 만듭니다."
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
