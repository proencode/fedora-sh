# Wiki.js 설치하기

```
| lll | 검정 b(L)ack | rrr | 빨강 Red | ggg | 녹색 Green | yyy | 노랑 Yellow | bbb | 파랑 Blue |
|:---:|:---|:---:|---:|:---:|:---:|:---:|---|:---:|:---:|
|:---:|:--- sit in the LEFT|:---:|---: to the RIGHT|:---:|:---: CENTER align|:---:|--- basic|:---:|:---:|
| mmm | 보라 Magenta | ccc | 청록 Cyan | www | 흰색 White | xxx | 색표시 끝 | uuu | 윗쪽으로 Up |
```

| lll | 검정 b(L)ack | rrr | 빨강 Red | ggg | 녹색 Green | yyy | 황 | bbb | 파랑 Blue |
|:---:|:---|:---:|---:|:---:|:---:|:---:|---|:---:|:---:|
|:---:|:--- sit in the LEFT|:---:|---: to the RIGHT|:---:|:---: CENTER align|:---:|---|:---:|:---:|
| mmm | 보라 Magenta | ccc | 청록 Cyan | www | 흰색 White | xxx | 색표시 끝 | uuu | 윗쪽으로 Up |

## 1. 도커 프로그램 설치

1. 📌 이모지 https://wepplication.github.io/tools/charMap/#emoji
1. 시스템을 최신버전으로 유지하기 위해 다음을 실행한다.
```
lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

echo "시스템을 최신버전으로 유지하기 위해 다음을 실행합니다: time sudo dnf -y update"
time sudo dnf -y update
echo "🎶 --------------------"
```

2. 시스템 명령어인 dnf 의 플러그인 코어를 받는다.
```
for i in {0..3}; do echo "#"; done

echo "(1-1) dnf 의 플러그인 코어를 받습니다: time sudo dnf -y install dnf-plugins-core (jj 0m35.843s; prn 0m20.586s; yscart 0m51.644s; yscartV 1m35.838s)"
time sudo dnf -y install dnf-plugins-core
echo "🎶 (1-2) --------------------"
```

3. 지금 받으려는 docker-ce 가 있는 위치를 리파지토리에 기록한다.
```
for i in {0..3}; do echo "#"; done

echo "(1-3) 지금 받으려는 docker-ce 가 있는 위치를 /etc/yum.repos.d/docker-ce.repo 리파지토리에 기록합니다: sudo tee /etc/yum.repos.d/docker-ce.repo << __EOF__"
sudo tee /etc/yum.repos.d/docker-ce.repo << __EOF__
[docker-ce-stable]
name=Docker CE Stable - \$basearch
baseurl=https://download.docker.com/linux/fedora/36/\$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/fedora/gpg
__EOF__
echo "🎶 (1-4) --------------------"
```

4. docker-ce 를 받는다.
```
for i in {0..3}; do echo "#"; done

echo "(1-5) docker-ce 를 받습니다: time sudo dnf makecache (jj 0m26.703s; prn 0m8.104s; yscart 0m13.500s; yscartV 0m15.553s)"
time sudo dnf makecache
echo "(1-6) time sudo dnf -y install docker-ce docker-ce-cli containerd.io (prn 0m21.065s; yscart 1m23.275s; yscartV 1m0.635s)"
time sudo dnf -y install docker-ce docker-ce-cli containerd.io
echo "(1-7) sudo systemctl enable --now docker"
sudo systemctl enable --now docker
echo "🎶 (1-8) --------------------"
```

5. Docker 설치 확인

```
for i in {0..3}; do echo "#"; done

echo "(1-9) 줄의 끝에 lines 1-24/24 (END) 가 나오면, 'Q' 를 눌러서 끝내야 합니다: sudo systemctl status docker"
sudo systemctl status docker
echo "(1-10) sudo docker version"
sudo docker version
echo "🎶 (1-11) --------------------"
```

6. docker-compose 를 설치한다.
```
lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

for i in {0..3}; do echo "#"; done

echo "(1-12) docker-compose 를 설치합니다: time sudo dnf -y install docker-compose (jj 0m12.520s; prn 0m12.703s; yscart 0m47.560s; yscartV 0m33.561s)"
time sudo dnf -y install docker-compose
echo "(1-13) rpm -qi docker-compose"
rpm -qi docker-compose
echo "(1-14) sudo docker ps -a"
sudo docker ps -a
echo "🎶 (1-15) --------------------"
```

## 2. wiki.js 용 데이터베이스 서비스

```
lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

for i in {0..3}; do echo "#"; done

#----> wiki.js 도커에서 쓰는 bash 변수 선언.
#--
DOCKER_DIR="/home/docker" #----- dwjs 도커 디렉토리 홈
DATABASE_DIR="${DOCKER_DIR}/wikijs_data" #-- dwjs wiki 데이터베이스 보관 디렉토리
YML_DIR="${DOCKER_DIR}/wikijs_yml" #-------- dwjs docker-compose.yml 을 보관하는 /home/docker/ 아래의 디렉토리
YML_NAME="${YML_DIR}/docker-compose.yml" #-- dwjs docker-compose.yml 이름을 지정
DATABASE_SERVICE="db_srv" #----- dwjs 데이터베이스 서비스 이름
DATABASE_NAME="wikidb" #-------- dwjs 데이터베이스 이름
DATABASE_CONTAINER="pgwikic" #-- dwjs 데이터베이스 컨테이너 이름
DB_user_NAME="imwiki" #--------- dwjs 데이터베이스 유저 이름
DB_user_PASS="wikipswd" #------- dwjs 데이터베이스 유저 비번
WIKI_SERVICE="wiki_srv" #---- dwjs 위키 서비스 이름

if [ "x${WIKI_PORT_NO}" = "x" ]; then
    WIKI_PORT_NO="7700" #-------- dwjs 위키 포트 번호
fi
echo "🖍️ (2-0a) Wiki.js 의 포트 번호: [ ${WIKI_PORT_NO} ]"
read a
if [ "x$a" != "x" ]; then
    WIKI_PORT_NO=$a
fi
if [ "x${CLOUD_NAME}" = "x" ]; then
    CLOUD_NAME="tpn4mi" #--------- dwjs rclone 백업용 클라우드 이름
fi
echo "🖍️ (2-0b) CLOUD_NAME 이름: [ ${CLOUD_NAME} ]"
read a
if [ "x$a" != "x" ]; then
    CLOUD_NAME=$a
fi

WIKI_CONTAINER="wikijsc" #--- dwjs 위키 컨테이너
LOCAL_BACKUP_DIR="${DOCKER_DIR}/backup/${DATABASE_CONTAINER}" #-- dwjs 압축한 데이터베이스 백업 디렉토리
#--
#<---- wiki.js 도커에서 쓰는 bash 변수 선언.

if [ -d ${DATABASE_DIR} ]; then
    echo "(2-1) sudo ls -alR ${DATABASE_DIR}"
    sudo ls -alR ${DATABASE_DIR}
    cat <<__EOF__
(2-2) ${DATABASE_DIR} 디렉토리가 있으므로,
      내용을 확인해봐서 쓰지 않는 것이면,
      이 디렉토리를 지우고 다시 만들기 위해,
          터미널을 새로 열고,
          다음의 명령을 입력허세요.

      sudo rm -rf ${DATABASE_DIR}

🖍️ (2-3) 터미널을 새로 열고 디렉토리 재확인 Enter:
__EOF__
    read a
else
    echo "(2-4) 데이터베이스가 사용하는 디렉토리 만들기: sudo mkdir -p ${DATABASE_DIR}"
    sudo mkdir -p ${DATABASE_DIR}
fi
echo "(2-5) sudo ls -alR ${DOCKER_DIR}"
sudo ls -alR ${DOCKER_DIR}
echo "🎶 (2-6) --------------------"
```

## 3. 위키 서비스

```
lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

for i in {0..3}; do echo "#"; done

#----> wiki.js 도커에서 쓰는 bash 변수 선언.
#--
DOCKER_DIR="/home/docker" #----- dwjs 도커 디렉토리 홈
DATABASE_DIR="${DOCKER_DIR}/wikijs_data" #-- dwjs wiki 데이터베이스 보관 디렉토리
YML_DIR="${DOCKER_DIR}/wikijs_yml" #-------- dwjs docker-compose.yml 을 보관하는 /home/docker/ 아래의 디렉토리
YML_NAME="${YML_DIR}/docker-compose.yml" #-- dwjs docker-compose.yml 이름을 지정
DATABASE_SERVICE="db_srv" #----- dwjs 데이터베이스 서비스 이름
DATABASE_NAME="wikidb" #-------- dwjs 데이터베이스 이름
DATABASE_CONTAINER="pgwikic" #-- dwjs 데이터베이스 컨테이너 이름
DB_user_NAME="imwiki" #--------- dwjs 데이터베이스 유저 이름
DB_user_PASS="wikipswd" #------- dwjs 데이터베이스 유저 비번
WIKI_SERVICE="wiki_srv" #---- dwjs 위키 서비스 이름

if [ "x${WIKI_PORT_NO}" = "x" ]; then
    WIKI_PORT_NO="7700" #-------- dwjs 위키 포트 번호
fi
echo "🖍️ (3-1a) Wiki.js 의 포트 번호: [ ${WIKI_PORT_NO} ]"
read a
if [ "x$a" != "x" ]; then
    WIKI_PORT_NO=$a
fi
if [ "x${CLOUD_NAME}" = "x" ]; then
    CLOUD_NAME="tpn4mi" #--------- dwjs rclone 백업용 클라우드 이름
fi
echo "🖍️ (3-1b) CLOUD_NAME 이름: [ ${CLOUD_NAME} ]"
read a
if [ "x$a" != "x" ]; then
    CLOUD_NAME=$a
fi

WIKI_CONTAINER="wikijsc" #--- dwjs 위키 컨테이너
LOCAL_BACKUP_DIR="${DOCKER_DIR}/backup/${DATABASE_CONTAINER}" #-- dwjs 압축한 데이터베이스 백업 디렉토리
#--
#<---- wiki.js 도커에서 쓰는 bash 변수 선언.

if [ ! -d ${YML_DIR} ]; then
    echo "(3-2) docker-compose.yml 보관 디렉토리 만들기: sudo mkdir -p ${YML_DIR} ; sudo chmod 755 ${YML_DIR} ; sudo chown ${USER}:${USER} ${YML_DIR}"
    sudo mkdir -p ${YML_DIR} ; sudo chmod 755 ${YML_DIR} ; sudo chown ${USER}:${USER} ${YML_DIR}
fi
echo "(3-3) ${YML_NAME} 파일을 만듭니다: cat > ${YML_NAME} <<__EOF__"
cat > ${YML_NAME} <<__EOF__
version: "3"
services:
  ${DATABASE_SERVICE}:
    image: postgres:11-alpine
    environment:
      POSTGRES_USER: ${DB_user_NAME}
      POSTGRES_PASSWORD: ${DB_user_PASS}
      POSTGRES_DB: ${DATABASE_NAME}
    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - ${DATABASE_DIR}:/var/lib/postgresql/data
    container_name:
      ${DATABASE_CONTAINER}

  ${WIKI_SERVICE}:
    image: requarks/wiki:2
    depends_on:
      - ${DATABASE_SERVICE}
    environment:
      DB_TYPE: postgres
      DB_HOST: ${DATABASE_SERVICE}
      DB_PORT: 5432
      DB_USER: ${DB_user_NAME}
      DB_PASS: ${DB_user_PASS}
      DB_NAME: ${DATABASE_NAME}
    restart: unless-stopped
    ports:
      - "${WIKI_PORT_NO}:3000"
    container_name:
      ${WIKI_CONTAINER}
__EOF__

echo "(3-4) ls -lR ${YML_NAME} ; cat ${YML_NAME}"
ls -lR ${YML_NAME} ; cat ${YML_NAME}

echo "🎶 (3-5) --------------------"
```

## 4. 도커 컴포즈 빌드 + 실행

```
lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

for i in {0..3}; do echo "#"; done

#----> wiki.js 도커에서 쓰는 bash 변수 선언.
#--
DOCKER_DIR="/home/docker" #----- dwjs 도커 디렉토리 홈
DATABASE_DIR="${DOCKER_DIR}/wikijs_data" #-- dwjs wiki 데이터베이스 보관 디렉토리
YML_DIR="${DOCKER_DIR}/wikijs_yml" #-------- dwjs docker-compose.yml 을 보관하는 /home/docker/ 아래의 디렉토리
YML_NAME="${YML_DIR}/docker-compose.yml" #-- dwjs docker-compose.yml 이름을 지정
DATABASE_SERVICE="db_srv" #----- dwjs 데이터베이스 서비스 이름
DATABASE_NAME="wikidb" #-------- dwjs 데이터베이스 이름
DATABASE_CONTAINER="pgwikic" #-- dwjs 데이터베이스 컨테이너 이름
DB_user_NAME="imwiki" #--------- dwjs 데이터베이스 유저 이름
DB_user_PASS="wikipswd" #------- dwjs 데이터베이스 유저 비번
WIKI_SERVICE="wiki_srv" #---- dwjs 위키 서비스 이름

if [ "x${WIKI_PORT_NO}" = "x" ]; then
    WIKI_PORT_NO="7700" #-------- dwjs 위키 포트 번호
fi
echo "🖍️ (4-0a) Wiki.js 의 포트 번호: [ ${WIKI_PORT_NO} ]"
read a
if [ "x$a" != "x" ]; then
    WIKI_PORT_NO=$a
fi
if [ "x${CLOUD_NAME}" = "x" ]; then
    CLOUD_NAME="tpn4mi" #--------- dwjs rclone 백업용 클라우드 이름
fi
echo "🖍️ (4-0b) CLOUD_NAME 이름: [ ${CLOUD_NAME} ]"
read a
if [ "x$a" != "x" ]; then
    CLOUD_NAME=$a
fi

WIKI_CONTAINER="wikijsc" #--- dwjs 위키 컨테이너
LOCAL_BACKUP_DIR="${DOCKER_DIR}/backup/${DATABASE_CONTAINER}" #-- dwjs 압축한 데이터베이스 백업 디렉토리
#--
#<---- wiki.js 도커에서 쓰는 bash 변수 선언.

if [ ! -d ${YML_DIR} ]; then
    echo "(4-1) docker-compose.yml 보관 디렉토리 만들기: sudo mkdir -p ${YML_DIR} ; sudo chmod 755 ${YML_DIR} ; sudo chown ${USER}:${USER} ${YML_DIR}"
    sudo mkdir -p ${YML_DIR} ; sudo chmod 755 ${YML_DIR} ; sudo chown ${USER}:${USER} ${YML_DIR}
fi
echo "(4-2) cd ${YML_DIR} "
cd ${YML_DIR}
echo "(4-3) 도커 컴포즈 설치: time sudo dnf -y install docker-compose (yscart 0m4.603s; yscartV 0m4.271s)"
time sudo dnf -y install docker-compose
echo "(4-4) 설치내역 확인: rpm -qi docker-compose"
rpm -qi docker-compose
echo "(4-5) sudo docker ps -a"
sudo docker ps -a
echo "(4-6) 도커 컴포즈 빌드: time sudo docker-compose pull ${WIKI_SERVICE} (prn 0m23.508s; yscart 0m57.622s; yscartV 1m3.054s)"
time sudo docker-compose pull ${WIKI_SERVICE}
### ### sudo docker-compose up --build 를 쓰지 않음 ###

cat <<__EOF__
...
${WIKIJS_CONTAINER_NAME}  | 2023-07-07T08:19:07.832Z [MASTER] info: 🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻
${WIKIJS_CONTAINER_NAME}  | 2023-07-07T08:19:07.832Z [MASTER] info: 
${WIKIJS_CONTAINER_NAME}  | 2023-07-07T08:19:07.832Z [MASTER] info: Browse to http://YOUR-SERVER-IP:3000/ to complete setup!
${WIKIJS_CONTAINER_NAME}  | 2023-07-07T08:19:07.832Z [MASTER] info: 
${WIKIJS_CONTAINER_NAME}  | 2023-07-07T08:19:07.832Z [MASTER] info: 🔻🔻🔻🔻🔻🔻🔻🔻🔻🔻

위와 같은 메세지가 표시되면, 작업이 정상적으로 실행이 된 것이므로,
[ Enter ] 키를 눌러서 터미널 프롬프트가 나오도록 합니다.

(1) ----> 아래의 명령을 --- 직접 --- 입력해서, 도커 실행내역을 확인합니다.

sudo docker ps -a

(2) ----> 브라우저에서 --- 아래의 주소를 입력해서,

localhost:${WIKI_PORT_NO}

이 작업이 끝나면, 관리자 등록과 첫 홈페이지를 만듭니다.

🖍️ (4-7) press Enter:
__EOF__
read a

echo "(4-8) 빌드한 도커 컴포즈를 실행합니다: sudo docker-compose up --force-recreate &"
sudo docker-compose up --force-recreate &
echo "(4-9) sudo docker-compose ps -a"
sudo docker-compose ps -a
echo "🎶 (4-10) --------------------"
```

# 백업용 클라우드 스토리지 준비

### 1. 클라우드 스토리지

`인터넷 스토리지` (인터넷에 있는 데이터 보관장소 = 디스크) 에, 나의 `데이터와 파일`을 저장할 수 있는 **클라우드 컴퓨팅 모델**

### 2. outlook.kr 메일계정 만들기

login.live.com
계정이 없으신가요? 계정을 만드세요!
자세히 > 뒤로
자세히 > 뒤로 > 동의
동의하고 계정만들기
이름입력
생년월일 입력
퍼즐
확인 > 계속

### 3. mega.io 계정 만들기

mega.io/login > 계정 생성 선택
당신의 무료 계정을 만드세요 > 입력
이해 및 이용 약관 체크 > 계정 생성 클릭
outlook.kr 이메일 열림 > 계정 활성화 클릭
당신의 계정을 확인하세요 > 비번 입력 > 당신의 계정을 확인하세요 클릭
키 생성중 > 당신에게 맞는 요금제를 선택하세요
무료 요금제로 시작하세요 > 무료로 시작하세요 클릭
계정 복구 > 복구키 내보내기 다운로드 클릭
계정 복구 > OK 클릭

### 4. rclone 명령으로 mega.io 연결하기

```
10:38:56금230929 yos@yscart ~/git-projects/fedora-sh
fedora-sh $ rclone config
Current remotes:

Name                 Type
====                 ====

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> n

Enter name for new remote.
name> tpn4mi

Option Storage.
Type of storage to configure.
Choose a number from below, or type in your own value.
 1 / 1Fichier
   \ (fichier)
 2 / Akamai NetStorage
   \ (netstorage)
 3 / Alias for an existing remote
   \ (alias)
 4 / Amazon Drive
   \ (amazon cloud drive)
 5 / Amazon S3 Compliant Storage Providers including AWS, Alibaba, Ceph, China Mobile, Cloudflare, ArvanCloud, Digital Ocean, Dreamhost, Huawei OBS, IBM COS, IDrive e2, IONOS Cloud, Lyve Cloud, Minio, Netease, RackCorp, Scaleway, SeaweedFS, StackPath, Storj, Tencent COS, Qiniu and Wasabi
   \ (s3)
 6 / Backblaze B2
   \ (b2)
 7 / Better checksums for other remotes
   \ (hasher)
 8 / Box
   \ (box)
 9 / Cache a remote
   \ (cache)
10 / Citrix Sharefile
   \ (sharefile)
11 / Combine several remotes into one
   \ (combine)
12 / Compress a remote
   \ (compress)
13 / Dropbox
   \ (dropbox)
14 / Encrypt/Decrypt a remote
   \ (crypt)
15 / Enterprise File Fabric
   \ (filefabric)
16 / FTP
   \ (ftp)
17 / Google Cloud Storage (this is not Google Drive)
   \ (google cloud storage)
18 / Google Drive
   \ (drive)
19 / Google Photos
   \ (google photos)
20 / HTTP
   \ (http)
21 / Hadoop distributed file system
   \ (hdfs)
22 / HiDrive
   \ (hidrive)
23 / In memory object storage system.
   \ (memory)
24 / Internet Archive
   \ (internetarchive)
25 / Jottacloud
   \ (jottacloud)
26 / Koofr, Digi Storage and other Koofr-compatible storage providers
   \ (koofr)
27 / Local Disk
   \ (local)
28 / Mail.ru Cloud
   \ (mailru)
29 / Mega
   \ (mega)
30 / Microsoft Azure Blob Storage
   \ (azureblob)
31 / Microsoft OneDrive
   \ (onedrive)
32 / OpenDrive
   \ (opendrive)
33 / OpenStack Swift (Rackspace Cloud Files, Memset Memstore, OVH)
   \ (swift)
34 / Oracle Cloud Infrastructure Object Storage
   \ (oracleobjectstorage)
35 / Pcloud
   \ (pcloud)
36 / Put.io
   \ (putio)
37 / QingCloud Object Storage
   \ (qingstor)
38 / SMB / CIFS
   \ (smb)
39 / SSH/SFTP
   \ (sftp)
40 / Sia Decentralized Cloud
   \ (sia)
41 / Storj Decentralized Cloud Storage
   \ (storj)
42 / Sugarsync
   \ (sugarsync)
43 / Transparently chunk/split large files
   \ (chunker)
44 / Union merges the contents of several upstream fs
   \ (union)
45 / Uptobox
   \ (uptobox)
46 / WebDAV
   \ (webdav)
47 / Yandex Disk
   \ (yandex)
48 / Zoho
   \ (zoho)
49 / premiumize.me
   \ (premiumizeme)
50 / seafile
   \ (seafile)
Storage> mega

Option user.
User name.
Enter a value.
user> tpnote4@outlook.kr #-- mega에 등록한 메일

Option pass.
Password.
Choose an alternative below.
y) Yes, type in my own password
g) Generate random password
y/g> y
Enter the password: #-- mega에 등록한 비번, 메일과 관계없음
password:
Confirm the password:
password:

Edit advanced config?
y) Yes
n) No (default)
y/n> 

Configuration complete.
Options:
- type: mega
- user: tpnote4@outlook.kr
- pass: *** ENCRYPTED ***
Keep this "tpn4mi" remote?
y) Yes this is OK (default)
e) Edit this remote
d) Delete this remote
y/e/d> 

Current remotes:

Name                 Type
====                 ====
tpn4mi               mega

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> q
10:41:33금230929 yos@yscart ~/git-projects/fedora-sh
fedora-sh $ rclone size tpn4mi:
Total objects: 1 (1)
Total size: 924.248 KiB (946430 Byte)
10:41:47금230929 yos@yscart ~/git-projects/fedora-sh
fedora-sh $ 

11:06:09금230929 yos@yscart ~/archive/opt-backup
opt-backup $ ll wikidb/
합계 20
drwxrwxr-x 1 yos yos   102 2022년 12월 31일 2022
drwxrwxr-x 1 yos yos   694  9월 28일  11:14 2023
-rw-rw-r-- 1 yos yos  3746 2022년 12월 16일 color_base
-rw-r--r-- 1 yos yos 16186  8월  8일  14:55 db-to-cloud.sh
11:06:10금230929 yos@yscart ~/archive/opt-backup
opt-backup $ rclone copy wikidb tpn4mi:wikidb
11:12:27금230929 yos@yscart ~/archive/opt-backup
opt-backup $ rclone size tpn4mi:
Total objects: 69 (69)
Total size: 3.586 GiB (3850681326 Byte)
11:14:36금230929 yos@yscart ~/archive/opt-backup
opt-backup $  
```

# 데이터 백업과 리스토어

## 5. 단순백업 보관하기

```
lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

for i in {0..3}; do echo "#"; done

#----> wiki.js 도커에서 쓰는 bash 변수 선언.
#--
DOCKER_DIR="/home/docker" #----- dwjs 도커 디렉토리 홈
DATABASE_DIR="${DOCKER_DIR}/wikijs_data" #-- dwjs wiki 데이터베이스 보관 디렉토리
YML_DIR="${DOCKER_DIR}/wikijs_yml" #-------- dwjs docker-compose.yml 을 보관하는 /home/docker/ 아래의 디렉토리
YML_NAME="${YML_DIR}/docker-compose.yml" #-- dwjs docker-compose.yml 이름을 지정
DATABASE_SERVICE="db_srv" #----- dwjs 데이터베이스 서비스 이름
DATABASE_NAME="wikidb" #-------- dwjs 데이터베이스 이름
DATABASE_CONTAINER="pgwikic" #-- dwjs 데이터베이스 컨테이너 이름
DB_user_NAME="imwiki" #--------- dwjs 데이터베이스 유저 이름
DB_user_PASS="wikipswd" #------- dwjs 데이터베이스 유저 비번
WIKI_SERVICE="wiki_srv" #---- dwjs 위키 서비스 이름

if [ "x${WIKI_PORT_NO}" = "x" ]; then
    WIKI_PORT_NO="7700" #-------- dwjs 위키 포트 번호
fi
echo "🖍️ (5-0a) Wiki.js 의 포트 번호: [ ${WIKI_PORT_NO} ]"
read a
if [ "x$a" != "x" ]; then
    WIKI_PORT_NO=$a
fi
if [ "x${CLOUD_NAME}" = "x" ]; then
    CLOUD_NAME="tpn4mi" #--------- dwjs rclone 백업용 클라우드 이름
fi
echo "🖍️ (5-0b) CLOUD_NAME 이름: [ ${CLOUD_NAME} ]"
read a
if [ "x$a" != "x" ]; then
    CLOUD_NAME=$a
fi

WIKI_CONTAINER="wikijsc" #--- dwjs 위키 컨테이너
LOCAL_BACKUP_DIR="${DOCKER_DIR}/backup/${DATABASE_CONTAINER}" #-- dwjs 압축한 데이터베이스 백업 디렉토리
#--
#<---- wiki.js 도커에서 쓰는 bash 변수 선언.

this_y4m2=$(date +%Y)-$(date +%m) #- 2022-08 과 같이 만든다.

LOCAL_Y2M2=${LOCAL_BACKUP_DIR}/${this_y4m2}
if [ ! -d ${LOCAL_Y2M2} ]; then
    echo "(5-1) ${LOCAL_Y2M2} 로컬 디렉토리를 만듭니다: sudo mkdir -p ${LOCAL_Y2M2} ; sudo chmod 755 ${LOCAL_Y2M2} ; sudo chown ${USER}:${USER} ${LOCAL_Y2M2}"
    sudo mkdir -p ${LOCAL_Y2M2} ; sudo chmod 755 ${LOCAL_Y2M2} ; sudo chown ${USER}:${USER} ${LOCAL_Y2M2}
fi

if [ "x${CLOUD_NAME}" = "x" ]; then
    echo "(5-2) 클라우드 이름이 없어서 중단합니다."
else
    echo "(5-3) time rclone lsf ${CLOUD_NAME}: (prn 0m3.421s; yscart 0m5.213s)"
    time rclone lsf ${CLOUD_NAME}:

    CLOUD_Y2M2=${DATABASE_CONTAINER}/${this_y4m2}
    echo "(5-4) 위키 컨테이너를 중단합니다."
    echo "sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER}"
    sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER}

    ymd_hm=$(date +"%y%m%d%a-%H%M")
    current_backup_7z=${DATABASE_NAME}_${ymd_hm}_$(uname -n).sql.7z #- 압축파일 이름
    cat <<__EOF__
///
/// DB 백업
///
/// (5-5) wili.js 데이터베이스를 백업하기 위해서 아래에 ---비밀번호--- 를 입력하세요. (prn 0m9.770s; yscart 0m56.533s)
///
///       오늘 요일이름의 로컬 보관장소에 백업합니다.
__EOF__
    echo "time sudo docker exec ${DATABASE_CONTAINER} pg_dumpall -U ${DB_user_NAME} | 7za a -p -mx=9 -si ${LOCAL_Y2M2}/${current_backup_7z}"
    time sudo docker exec ${DATABASE_CONTAINER} pg_dumpall -U ${DB_user_NAME} | 7za a -p -mx=9 -si ${LOCAL_Y2M2}/${current_backup_7z}
    echo "(5-6) 보관용 로컬 폴더입니다: ls -lR ${LOCAL_Y2M2}"
    ls -lR ${LOCAL_Y2M2}
    echo "#-- (5-7) 오늘 요일이름의 파일을 클라우드로 복사합니다: time rclone copy ${LOCAL_Y2M2}/${DB_sql7z} ${CLOUD_NAME}:${CLOUD_Y2M2}/ (prn 0m5.001s; yscart 0m5.816s)"
    time rclone copy ${LOCAL_Y2M2}/${DB_sql7z} ${CLOUD_NAME}:${CLOUD_Y2M2}/
    echo "#-- (5-8) 클라우드 폴더입니다: time rclone lsl ${CLOUD_NAME}:${CLOUD_Y2M2} (prn 0m3.558s; yscart 0m3.922s)"
    time rclone lsl ${CLOUD_NAME}:${CLOUD_Y2M2}
    # echo "#-- (5-7) 오늘 요일이름의 파일을 클라우드로 복사합니다: time rclone copy ${LOCAL_Y2M2}/${current_backup_7z} ${CLOUD_NAME}:${CLOUD_Y2M2}/"
    # time rclone copy ${LOCAL_Y2M2}/${DB_sql7z} ${CLOUD_NAME}:${CLOUD_Y2M2}/
    # echo "#-- (5-8) 클라우드 폴더입니다. time rclone lsl ${CLOUD_NAME}:${CLOUD_Y2M2}"
    # time rclone lsl ${CLOUD_NAME}:${CLOUD_Y2M2}
    echo "(5-9) 위키 컨테이너를 다시 시작합니다: sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a"
    sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a
fi
echo "🎶 (5-10) --------------------"
```

## 6. 백업파일을 DB 에 도로담는 리스토어 작업

1. 구글 클라우드로 백업했던 wiki.js db 파일을 로컬 폴더로 복사한다.
1. 복사한 db 파일 이름 을 다음과 같이 스크립트를 사용해서 wiki.js 에 올린다.
1. 리스토어 하기 전에, 현재의 데이터베이스를 저장할 것인지 물어서, 답에 따라 현재 db 를 만들어 놓고 나서 리스토어한다

`백업 backup`: 현재의 데이터베이스를 **wikipg-220907수-1802-proenpi4b.sql.7z** 와 같은 이름으로 압축해서 저장한다.
`리스토어 restore`: 압축해서 보관했던 백업 파일을 데이터베이스에 도로 부어 담는다.
`현재 상태의 마지막 백업`: 백업파일을 리스토어 하는 경우, 현재의 db 에 들어있던 데이터는 백업파일에 의해 지워진다. 그래서 일단 현재상태의 db 를 **" last-\${DATABASE_CONTAINER}-\$(date +%y%m%d_%H%M%S)-\$(uname -n).sql.7z "** 등으로 백업하고서 리스토어 하기 위해서 마지막 백업을 실시한다.

```
lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

for i in {0..3}; do echo "#"; done

#----> wiki.js 도커에서 쓰는 bash 변수 선언.
#--
DOCKER_DIR="/home/docker" #----- dwjs 도커 디렉토리 홈
DATABASE_DIR="${DOCKER_DIR}/wikijs_data" #-- dwjs wiki 데이터베이스 보관 디렉토리
YML_DIR="${DOCKER_DIR}/wikijs_yml" #-------- dwjs docker-compose.yml 을 보관하는 /home/docker/ 아래의 디렉토리
YML_NAME="${YML_DIR}/docker-compose.yml" #-- dwjs docker-compose.yml 이름을 지정
DATABASE_SERVICE="db_srv" #----- dwjs 데이터베이스 서비스 이름
DATABASE_NAME="wikidb" #-------- dwjs 데이터베이스 이름
DATABASE_CONTAINER="pgwikic" #-- dwjs 데이터베이스 컨테이너 이름
DB_user_NAME="imwiki" #--------- dwjs 데이터베이스 유저 이름
DB_user_PASS="wikipswd" #------- dwjs 데이터베이스 유저 비번
WIKI_SERVICE="wiki_srv" #---- dwjs 위키 서비스 이름

if [ "x${WIKI_PORT_NO}" = "x" ]; then
    WIKI_PORT_NO="7700" #-------- dwjs 위키 포트 번호
fi
echo "🖍️ (6-0a) Wiki.js 의 포트 번호: [ ${WIKI_PORT_NO} ]"
read a
if [ "x$a" != "x" ]; then
    WIKI_PORT_NO=$a
fi
if [ "x${CLOUD_NAME}" = "x" ]; then
    CLOUD_NAME="tpn4mi" #--------- dwjs rclone 백업용 클라우드 이름
fi
echo "🖍️ (6-0b) CLOUD_NAME 이름: [ ${CLOUD_NAME} ]"
read a
if [ "x$a" != "x" ]; then
    CLOUD_NAME=$a
fi

WIKI_CONTAINER="wikijsc" #--- dwjs 위키 컨테이너
LOCAL_BACKUP_DIR="${DOCKER_DIR}/backup/${DATABASE_CONTAINER}" #-- dwjs 압축한 데이터베이스 백업 디렉토리
#--
#<---- wiki.js 도커에서 쓰는 bash 변수 선언.

#--> 로컬과 원격 보관장소
this_y4m2=$(date +%Y)-$(date +%m) #- 2022-08
LOCAL_Y2M2=${LOCAL_BACKUP_DIR}/${this_y4m2}
if [ ! -d ${LOCAL_Y2M2} ]; then
    echo "(6-1) ${LOCAL_Y2M2} 로컬 디렉토리를 만듭니다: mkdir -p ${LOCAL_Y2M2}"
    mkdir -p ${LOCAL_Y2M2}
fi
CLOUD_Y2M2=${DATABASE_CONTAINER}/${this_y4m2}
#<-- 로컬과 원격 보관장소

#-- ----> 리스토어 파일이 있으면 현재의 DB 를 백업하고 리스토어 한다.
if [ "x$zzz" = "x" ]; then
    zzz="$(ls -ltr ${LOCAL_BACKUP_DIR}}/*.7z | tail -1 | awk '{print $9}')"
fi
echo "(6-2) ls -lR ${LOCAL_BACKUP_DIR} #--- 백업 디렉토리 내용"
ls -lR ${LOCAL_BACKUP_DIR}
echo "🖍️ (6-3) 전체 경로를 다 지정하는 리스토어 파일을 입력하세요: [ ${zzz} ]"
read a
if [ "x$a" = "x" ]; then
    a=${zzz}
fi
zzz=${a}

if [ "x${zzz}" = "x" ] || [ ! -f "${zzz}" ]; then
    #-- ----> 리스토어 파일이 없으면 여기서 끝냄.
    cat <<__EOF__
||| (6-2) ls -lR ${LOCAL_BACKUP_DIR} #--- 백업 디렉토리 내용
$(ls -lR ${LOCAL_BACKUP_DIR})
|||
||| (6-3) 지정한 (리스토어 할) ${zzz} 파일이 존재하지 않습니다.
|||
||| 리스토어 할 파일 이름이 "${LOCAL_Y2M2}" 디렉토리에 있는
||| "last-${DATABASE_CONTAINER}-\$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z" 인 경우:
||| 
||| zzz="${LOCAL_Y2M2}/last-${DATABASE_CONTAINER}-\$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
|||
||| (복구하려는 파일 이름을 담은 환경 변수의 이름이 'zzz' 임.)
|||
||| 이와 같이 Bash Terminal 에서 선언하고 나서, 이 스크립트를 다시 실행해야 합니다.
||| 
🎶 (6-4) ${zzz} 파일이 없으므로 작업을 중단합니다.
__EOF__
    #-- <---- 리스토어 파일이 없으면 여기서 끝냄.
else
    #-- ----> 리스토어 할 .7z 파일이 있다.
    sql_name=$(basename ${zzz}) # 백업파일 이름만 꺼냄
    sql_dir=${zzz%/$sql_name} # 백업파일 이름을 빼고 나머지 디렉토리만 담음
    cat <<__EOF__
zzz = "${zzz}"
sql_name = ${sql_name} # 백업파일 이름만 꺼냄
sql_dir = ${sql_dir} # 백업파일 이름을 빼고 나머지 디렉토리만 담음

🖍️ (6-5) 현재의 DB 를 백업하지 않으려면, 소문자 'n' 을 눌러 주세요."
__EOF__
    read N_is_current_no_backup ; echo "${uuu}"
    if [ "x${N_is_current_no_backup}" != "xn" ]; then
        N_is_current_no_backup="y"
    fi
    echo "[ 현재 DB 를 백업 = ${N_is_current_no_backup} ]"

    echo "qq1----> N_is_current_no_backup = [ ${N_is_current_no_backup} ]"
    echo "qq1----> restore_only = [ ${restore_only} ]"

    #-- --> '백업 받기 전' 위키 컨테이너 정지
    cat <<__EOF__
(6-6) 백업을 시작하기전 위키 컨테이너를 멈춥니다.
      sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a
__EOF__
    sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a
    #-- <-- '백업 받기 전' 위키 컨테이너 정지

    if [ "x$N_is_current_no_backup" = 'xn' ]; then
        #-- ----> 현재의 DB 를 백업하지 않는다 선택.
        cat <<__EOF__
# |
# |
# |
# |
# |
# | !!!! 주의 !!!! 현재 DB 를 다운로드 + 백업하지 않고, 업로드 합니다.
# |
# | 여기서 소문자 'y' 를 누르면 현재의 DB 백업을 하지 않습니다.
# |
# | 다른 글자거나 그냥 Enter 를 누르면 백업이 진행됩니다.
# |
🖍️ (6-7) 백업 하지 않고 = 'y' Enter ('y' = NO BACKUP):
__EOF__
        read restore_only ; echo "${uuu}"
        if [ "x$restore_only" = "xy" ]; then
            N_is_current_no_backup="n"
        else
            N_is_current_no_backup="y"
        fi
        echo "[ 현재 DB 를 백업하지 않음 = ${restore_only} ]"

        #-- ----> 현재의 DB 를 백업하지 않는다 선택.
    fi

    echo "qq2----> N_is_current_no_backup = [ ${N_is_current_no_backup} ]"
    if [ "x$N_is_current_no_backup" != 'xn' ]; then
        echo "x$N_is_current_no_backup != 'xn'"
    else
        echo "x$N_is_current_no_backup = 'xn'"
    fi
    echo "qq2----> restore_only = [ ${restore_only} ]"

    if [ "x$N_is_current_no_backup" != 'xn' ]; then
        #-- ----> 현재 DB 를 다운로드 + 백업 합니다.

        current_backup_7z="${LOCAL_Y2M2}/last-${DATABASE_CONTAINER}-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
        cat <<__EOF__
(6-8) 지정한 백업파일을 데이터베이스에 붓기 전에,
      현재 운영중인 DB 를 먼저 ${LOCAL_Y2M2} 에 백업합니다.
      
      time sudo docker exec ${DATABASE_CONTAINER} pg_dumpall -U ${DB_user_NAME} | 7za a -mx=9 -p -si ${current_backup_7z}

🖍️ (6-9) 백업하는 .7z 파일에 지정해 줄 새로운 ===비밀번호=== 를 입력하세요.

__EOF__
        time sudo docker exec ${DATABASE_CONTAINER} pg_dumpall -U ${DB_user_NAME} | 7za a -mx=9 -p -si ${current_backup_7z}
        cat <<__EOF__
(6-10) 오늘 요일이름의 파일을 클라우드로 복사합니다.
      time rclone copy ${current_backup_7z} ${CLOUD_NAME}:${CLOUD_Y2M2}/
__EOF__
        time rclone copy ${current_backup_7z} ${CLOUD_NAME}:${CLOUD_Y2M2}/
        cat <<__EOF__
(6-11) 클라우드 폴더입니다.
       time rclone lsl ${CLOUD_NAME}:${CLOUD_Y2M2}
__EOF__
        time rclone lsl ${CLOUD_NAME}:${CLOUD_Y2M2}

        #-- <---- 현재 DB 를 다운로드 + 백업 합니다.
    fi

    cat <<__EOF__
(6-12) 기존의 데이터베이스를 삭제합니다.
       time sudo docker exec -it ${DATABASE_CONTAINER} dropdb -U ${DB_user_NAME} ${DATABASE_NAME}
__EOF__
    time sudo docker exec -it ${DATABASE_CONTAINER} dropdb -U ${DB_user_NAME} ${DATABASE_NAME}
cat <<__EOF__
(6-13) 빈 데이터베이스를 새로 만듭니다.
       time sudo docker exec -it ${DATABASE_CONTAINER} createdb -U ${DB_user_NAME} ${DATABASE_NAME}
__EOF__
    time sudo docker exec -it ${DATABASE_CONTAINER} createdb -U ${DB_user_NAME} ${DATABASE_NAME}
    cat <<__EOF__
(6-14) 지정한 백업파일을 데이터베이스에 다시 붓습니다. (RESTORE)

       time 7za x -so ${zzz} | sudo docker exec -i ${DATABASE_CONTAINER} psql -U ${DB_user_NAME} ${DATABASE_NAME}

🖍️ (6-15) 백업할때 입력한 ----비밀번호---- 를 입력하세요.

__EOF__
    time 7za x -so ${zzz} | sudo docker exec -i ${DATABASE_CONTAINER} psql -U ${DB_user_NAME} ${DATABASE_NAME}
    cat <<__EOF__
(6-16) 멈췄던 위키 컨테이너를 다시 시작합니다.
       sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a
__EOF__
    sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a
    echo "(6-17) 백업 작업이 끝났습니다."
    #-- <---- 리스토어 할 .7z 파일이 있다.
fi
zzz=""
echo "🎶 (6-18) --------------------"
```

