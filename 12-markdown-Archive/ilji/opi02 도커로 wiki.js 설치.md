# 1. Docker Compose 설치

출처: Ubuntu Docker Compose 설치 방법(22.04 기준) 2023-02-15 by 나루 https://osg.kr/archives/2108

## 1-1. Docker 저장소 추가

```
#-- HTTPS 기반 리포지토리를 사용 하려면 다음 네 가지 패키지가 필요합니다 .
#-- ca-certificates- SSL/TLS 인증서를 확인하는 패키지입니다.
#-- curl- HTTPS를 포함한 여러 프로토콜을 지원하는 널리 사용되는 데이터 전송 도구입니다.
#-- gnupg- PGP(Pretty Good Privacy) 암호화 도구 제품군의 오픈 소스 구현입니다.
#-- lsb-release- LSB(Linux Standard Base) 버전을 보고하기 위한 유틸리티
sudo apt install ca-certificates curl gnupg lsb-release
#-- Docker의 GPG 키용 디렉터리를 만듭니다.
sudo mkdir /etc/apt/demokeyrings
#-- Docker의 저장소를 신임
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/demokeyrings/demodocker.gpg
#-- 시스템에 Docker 저장소를 추가
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/demokeyrings/demodocker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
```

## 1-2. Docker Compose 설치

```
sudo apt update -y
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo docker --version ; sudo docker compose version ; sudo ctr version
```

# 2. Wiki.Js 설치하기

출처: 달소씨의 하루 https://blog.dalso.org/article/docker-compose%EB%A5%BC-%EC%9D%B4%EC%9A%A9%ED%95%9C-wiki-js-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0

| 저장소                   | 용도            |
|:----:|:----:|
| /home/docker/backup/    | wiki DB 백업파일 |
| /home/docker/compose/   | 도커 컴포즈 파일  |
| /home/docker/pgreswiki/ | pgsql DB 저장소 |

## 2-1. Wiki.js 디렉토리 만들기

```
sudo mkdir -p /home/docker/backup /home/docker/compose /home/docker/pgreswiki
sudo chown -R ${USER}:${USER} /home/docker/backup
sudo chmod -R 755 /home/docker/backup
y4=$(date +%Y) #-- 2023
mkdir /home/docker/backup/${y4}
sudo chown ${USER}:${USER} /home/docker/compose /home/docker/backup/${y4}
cd /home/docker/compose
vi docker-compose.yml
echo "🎶 (6) ---------"
```

## 2-2. docker-compose.yml

```
version: "3"
services: : #-- orangepi59zero2w 240214-1424

  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: wikidb #-- old_name= wiki #-- 데이터베이스 이름
      POSTGRES_USER: imwiki #-- old_name= wikijs #-- 사용자 이름
      POSTGRES_PASSWORD: wikiam9ho #-- old_name= wikijsrocks #-- 비번

    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - /home/docker/pgreswiki:/var/lib/postgresql/data
    container_name:
      dbcont #-- old_name= wikijsdb #-- db: 컨테이너 이름

  wiki:
    image: requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_NAME: wikidb #-- old_name= wiki #-- 데이터베이스 이름
      DB_USER: imwiki #-- old_name= wikijs #-- 사용자 이름
      DB_PASS: wikiam9ho #-- old_name= wikijsrocks #-- 비번

    restart: unless-stopped
    ports:
      - "5900:3000"
    container_name:
      wikicont #-- old_name= wikijs #-- wiki: 컨테이너 이름
```

## 2-3. wiki.js 실행

```
cd /home/docker/compose
#-- time sudo docker-compose pull wikijs
sudo docker compose up -d
echo "🎶 (8) ---------"
```

## 2-4. 도메인 네임과 IP 주소, 그리고 포트번호

1. 내 컴퓨터의 웹 브라우저 주소창 에서 아래와 같이 주소를 입력하면,
저 `http://....` 주소를,
내 컴퓨터 웹 브라우저 ---> 인터넷의 `DNS 서버` (도메인 네임 시스템 서버)
이 방향으로 보내준다.
```
┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓      ┏━━━━━━━━━┓
┃ 주소 ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ ┃      ┃         ┃
┃     ┃ http://www.yourdomain.kr:9900  ┃ ┃ ---> ┃         ┃
┃     ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛ ┃      ┃         ┃
┃                     내 컴퓨터 웹 브라우저  ┃      ┃ DNS 서버 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛      ┗━━━━━━━━━┛
```
| 도메인 네임 | ip 주소 | 소유권자 | 기타등등 |
|:---:|:---:|:---:|:---:|
| kt.com | 14.63.149.115 | KT 공식 온라인샵 | @@ |
| ottogi.co.kr | 99.83.196.71 | 오뚜기 소개 | ! ! ! |
| mydomain.kr | 116.126.142.105 | 인터넷 호스트 ... | ㅜㅜ |
| yourdomain.kr | 111.112.113.114 | 테스트! 테스트! | :) |
| [Google LLC (안내)](https://ko.ipshu.com/dns-ip/8.8.8.8) | 8.8.8.8 | Google LLC의 DNS 서버 | Alphabet Inc 자회사 |

LLC means: A limited liability company, 유한 책임 회사의 약자.
(자본주의 살아남기) Inc와 CO., LTD 무슨 의미인가요? 에디 2016. 7. 21. 15:39 https://m.blog.naver.com/olivia105/220767980771

2. DNS 서버 에서,
도메인 네임 `www.yourdomain.kr` 의 주소가 `111.112.113.114` 임을 확인하고,
```
┏━┃━━━━━━━━━━━┫ DNS Server ┣━━━━━━━━━━━┓
┃ ┗━> http://www.yourdomain.kr:9900    ┃
┃                     |                ┃
┃                     V                ┃
┃              111.112.113.114:9900 ---┃---->
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
```
`111.112.113.114` 주소를 찾아 `111.112.113.114:9900` 을 보낸다.

3. 주소가 `111.112.113.114` 인 서버의 공유기에서,
```
┏━┃━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
┃ ┗━> 111.112.113.114:9900     ┃
┃                     ||||     ┃
┃                     ::::     ┃    ┏━━━━━┓
┃                     9900 --->┃--->┃PC-01┃
┃                     ::::     ┃    ┗━━━━━┛ ┏━━━━━┓
┃                     7700 --->┃----------->┃PC-02┃
┃                     ::::     ┃            ┗━━━━━┛  ┏━━━━━┓
┃                     8850 --->┃-------------------->┃PC-03┃
┗━━━━━━━━━━┫ 공유기 ┣━━━━━━━━━━━┛                     ┗━━━━━┛
```
공유기는, 주소의 콜론 (`:`) 뒤에 붙은 포트번호를 보고, `그 포트 번호가 미리 예약된 PC` 로 주소를 전달한다.

| 예약된 포트 번호 | 받을 PC 의 IP주소 | PC 이름 |
|:---:|:---:|:---:|
| 9900 | 192.168.100.32 | PC-01 |
| 8850 | 192.168.100.36 | PC-03 |
| 7700 | 192.168.100.143 | PC-02 |

## 2-5. 위키 주소 입력

```
192.168.000.111:9900
||| ||| ||| ||| ||||
||| ||| ||| ||| ++++---- docker-compose.yml 파일에서 지정한 포트 번호
||| ||| ||| |||
+++-+++-+++-+++---- wiki.js 를 실행한 서버의 ip 주소
```
도커가 읽어보는 파일인 docker-compose.yml 에는 다음과 같이 포트 번호를 지정하고 있다.

```
  wiki:
    ports:
      - "9900:3000"
```
- `9900:3000` <---- 외부에서 포트 `9900` 에 요청을 하면, 도커는 포트 `3000` 에 그 요청을 전달한다.

### 1. 포트번호 0 ~ 65535 번의 분류

| well-known ports | registered ports | dynamic ports |
|:-----:|:-----:|:-----:|
| 0 ~ 1023 번 | 1024 ~ 49151 번 | 49152 ~ 65535 번 |
| 서버 애플리케이션으로 예약된 포트 | 자주 이용하는 서버 애플리케이션을 식별하기 위한 포트 | 클라이언트 애플리케이션용 임시 포트 |

### 2. 서버 애플리케이션에 습관적으로 붙이는 well known port

서버에서 주로 쓰이는 애플리케이션에는 `0 ~ 1023 번` 범위내에서 다음과 같이 관례로 굳어진 번호를 사용한다.

| 포트 번호 | 서버 애플리케이션 |
|:-----:|:-----:|
| 20 번 | FTP (파일 전송) |
| 22 번 | SSH (원격제어, 보안기능 추가) |
| 23 번 | Telnet (원격제어) |
| 25 번 | SMTP (이메일 전송) |
| 80 번 | HTTP (웹) |
| 110 번 | POP3 (이메일 수신) |
| 143 번 | IMAP4 (이메일 수신, + 보관) |
| 443 번 | HTTPS (보안기능 추가한 웹) |

### 3. 웰노운 이외의 서버 애플리케이션에 지정하고 공지하는 registered port

웰노운 이외의 서버 애플리케이션에는 `1024 ~ 49151 번` 을 지정한다.

### 4. 클라이언트 애플리케이션인데 포트번호가 필요할때 쓰는 dynamic ports

well known port 나 registered port 는 그 포트 번호를 서버 애플리케이션이 미리 알고서 시작한다.
이와 반대로, 클라이언트 애플리케이션은 시작한 다음에 OS 에게 포트번호를 요청해서, 포트 번호가 몇번인지를 전달 받는다.
그리고, 클라이언트 애플리케이션이 끝나게 되면, OS 는 그 포트번호를 반납으로 체크해 놓고,
다른 크라이언트가 시작하면서 포트번호를 요청할때, 반납한 포트번호 (`49152 ~ 65535 번`) 중에서 하나를 골라 전달해 준다.

출처: TCP/IP 전송 계층(Transport)과 포트(Port) 번호 2022-4-7 https://forward-movement.tistory.com/188

# 3. 백업용 클라우드 스토리지 준비

## 3-1. 클라우드 스토리지

`인터넷 스토리지` (인터넷에 있는 데이터 보관장소 = 디스크) 에, 나의 `데이터와 파일`을 저장할 수 있는 **클라우드 컴퓨팅 모델**

## 3-2. outlook.kr 메일계정 만들기

login.live.com
계정이 없으신가요? 계정을 만드세요!
자세히 > 뒤로
자세히 > 뒤로 > 동의
동의하고 계정만들기
이름입력
생년월일 입력
퍼즐
확인 > 계속

## 3-3. mega.io 계정 만들기

mega.io/login > 계정 생성 선택
당신의 무료 계정을 만드세요 > 입력
이해 및 이용 약관 체크 > 계정 생성 클릭
outlook.kr 이메일 열림 > 계정 활성화 클릭
당신의 계정을 확인하세요 > 비번 입력 > 당신의 계정을 확인하세요 클릭
키 생성중 > 당신에게 맞는 요금제를 선택하세요
무료 요금제로 시작하세요 > 무료로 시작하세요 클릭
계정 복구 > 복구키 내보내기 다운로드 클릭
계정 복구 > OK 클릭


## 3-4. OrangePiZero2W 에 rclone 설치

1. 240123 - orangepizero2w 6.1.31-sun50iw9 #1.0.0 SMP Wed Sep 13 12:26:14 CST 2023 aarch64 GNU/Linux 에서 rclone 설치후 MEGA drive 가 없어서 다시 설치함. https://rclone.org/downloads/
```
sudo -v ; curl https://rclone.org/install.sh | sudo bash
```
### 1. 재설치 전
```
13:27:57화240123 yoran@orangepizero2w ~
~ $ rclone --version
rclone v1.53.3-DEV
- os/arch: linux/arm64
- go version: go1.18.1
13:28:03화240123 yoran@orangepizero2w ~
```
### 2. 재설치 후
```
13:32:55화240123 yoran@orangepizero2w ~
~ $ rclone --version
rclone v1.65.1
- os/version: ubuntu 22.04 (64 bit)
- os/kernel: 6.1.31-sun50iw9 (aarch64)
- os/type: linux
- os/arch: arm64 (ARMv8 compatible)
- go/version: go1.21.5
- go/linking: static
- go/tags: none
13:35:18화240123 yoran@orangepizero2w ~
```

## 3-5. rclone 명령으로 mega.io 연결하기

### 1. 새로운 원격 드라이브 (remote) 등록
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

### 2. rclone 정보파일 rclone.conf 백업
```
7za a -p ~/rclone-HOME_snap_rclone_current_.config_rclone_rclone.conf-231129-1431.7z ~/snap/rclone/current/.config/rclone/rclone.conf
```

### 3. 백업한 rclone.conf 를 로컬에 복사
```
13:51:17화240123 yoran@orangepizero2w ~
~ $ cd .config/rclone/
13:51:37화240123 yoran@orangepizero2w ~/.config/rclone
rclone $ 7za x ~/rclone-HOME_snap_rclone_current_.config_rclone_rclone.conf-231129-1431.7z

7-Zip (a) [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
p7zip Version 16.02 (locale=ko_KR.UTF-8,Utf16=on,HugeFiles=on,64 bits,4 CPUs LE)

Scanning the drive for archives:
1 file, 5394 bytes (6 KiB)

Extracting archive: /home/yoran/rclone-HOME_snap_rclone_current_.config_rclone_rclone.conf-231129-1431.7z
--
Path = /home/yoran/rclone-HOME_snap_rclone_current_.config_rclone_rclone.conf-231129-1431.7z
Type = 7z
Physical Size = 5394
Headers Size = 146
Method = LZMA2:13 7zAES
Solid = -
Blocks = 1


Enter password (will not be echoed):
Everything is Ok

Size:       7988
Compressed: 5394
13:52:02화240123 yoran@orangepizero2w ~/.config/rclone
rclone $ ll
합계 12
-rw------- 1 yoran yoran 7988 11월 15 07:36 rclone.conf
13:52:03화240123 yoran@orangepizero2w ~/.config/rclone
rclone $ rclone config
Current remotes:

Name                 Type
====                 ====
edone                onedrive
jjdrb                dropbox
jjone                onedrive
kaos1mi              mega
kaos2mi              mega
kaos3mi              mega
kaos4mi              mega
kaosngc              drive
swlibgc              drive
tpn1mi               mega
tpn2mi               mega
tpn3mi               mega
tpn4mi               mega
y5dnmi               mega
y5ncmi               mega
yosjgc               drive
ysw10mi              mega
yswone               onedrive

e) Edit existing remote
n) New remote
d) Delete remote
r) Rename remote
c) Copy remote
s) Set configuration password
q) Quit config
e/n/d/r/c/s/q> q
13:52:13화240123 yoran@orangepizero2w ~/.config/rclone
rclone $
```

# 4. 데이터 백업과 리스토어

## 4-1. 단순백업 보관하기

```
lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

for i in {0..3}; do echo "#"; done

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

LOCAL_BACKUP_DIR="/home/docker/backup/pgsql" #-- dwjs 압축한 데이터베이스 백업 디렉토리
#-------------------------------------^^^^^ 데이터베이스 컨테이너 이름
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

    CLOUD_Y2M2=pgsql/${this_y4m2}
    #----------^^^^^ 데이터베이스 컨테이너 이름

    echo "(5-4) 위키 컨테이너를 중단합니다."
    echo "sudo docker ps -a ; sudo docker stop wikijs"
    #------------------------------------------^^^^^^ 위키 컨테이너
    sudo docker ps -a ; sudo docker stop wikijs
    #------------------------------------^^^^^^ 위키 컨테이너

    ymd_hm=$(date +"%y%m%d%a-%H%M")
    current_backup_7z="wikidb_${ymd_hm}_$(uname -n).sql.7z" #- 압축파일 이름
    cat <<__EOF__
///
/// DB 백업
///
/// (5-5) wili.js 데이터베이스를 백업하기 위해서 아래에 ---비밀번호--- 를 입력하세요. (prn 0m9.770s; yscart 0m56.533s)
///
///       오늘 요일이름의 로컬 보관장소에 백업합니다.
__EOF__
    echo "time sudo docker exec pgsql pg_dumpall -U imwiki | 7za a -p -mx=9 -si ${LOCAL_Y2M2}/${current_backup_7z}"
    #---------------------------^^^^^ 데이터베이스 컨테이너 이름
    time sudo docker exec pgsql pg_dumpall -U imwiki | 7za a -p -mx=9 -si ${LOCAL_Y2M2}/${current_backup_7z}
    #---------------------^^^^^ 데이터베이스 컨테이너 이름

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
    echo "(5-9) wikijs 위키 컨테이너를 다시 시작합니다: sudo docker start wikijs ; sudo docker ps -a"
    #---------------------------------------------------------------------^^^^^^ 위키 컨테이너
    sudo docker start wikijs ; sudo docker ps -a
    #-----------------^^^^^^ 위키 컨테이너
fi
echo "🎶 (5-10) --------------------"
```

## 4-2. 백업파일을 DB 에 도로담는 리스토어 작업

1. 구글 클라우드로 백업했던 wiki.js db 파일을 로컬 폴더로 복사한다.
1. 복사한 db 파일 이름 을 다음과 같이 스크립트를 사용해서 wiki.js 에 올린다.
1. 리스토어 하기 전에, 현재의 데이터베이스를 저장할 것인지 물어서, 답에 따라 현재 db 를 만들어 놓고 나서 리스토어한다

`백업 backup`: 현재의 데이터베이스를 **wikipg-220907수-1802-proenpi4b.sql.7z** 와 같은 이름으로 압축해서 저장한다.
`리스토어 restore`: 압축해서 보관했던 백업 파일을 데이터베이스에 도로 부어 담는다.
`현재 상태의 마지막 백업`: 백업파일을 리스토어 하는 경우, 현재의 db 에 들어있던 데이터는 백업파일에 의해 지워진다. 그래서 일단 현재상태의 db 를
**" last-pgsql-\$(date +%y%m%d_%H%M%S)-\$(uname -n).sql.7z "** 등으로 백업하고서 리스토어 하기 위해서 마지막 백업을 실시한다.

```
lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

for i in {0..3}; do echo "#"; done

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

LOCAL_BACKUP_DIR="/home/docker/backup/pgsql" #-- dwjs 압축한 데이터베이스 백업 디렉토리
#-------------------------------------^^^^^ 데이터베이스 컨테이너 이름
#--
#<---- wiki.js 도커에서 쓰는 bash 변수 선언.

#--> 로컬과 원격 보관장소
this_y4m2=$(date +%Y)-$(date +%m) #- 2022-08
LOCAL_Y2M2=${LOCAL_BACKUP_DIR}/${this_y4m2}
if [ ! -d ${LOCAL_Y2M2} ]; then
    echo "(6-1) ${LOCAL_Y2M2} 로컬 디렉토리를 만듭니다: mkdir -p ${LOCAL_Y2M2}"
    mkdir -p ${LOCAL_Y2M2}
fi
CLOUD_Y2M2=pgsql/${this_y4m2}
#----------^^^^^ 데이터베이스 컨테이너 이름
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
||| "last-pgsql-\$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z" 인 경우:
||| 
||| zzz="${LOCAL_Y2M2}/last-pgsql-\$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
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
(6-6) 백업을 시작하기전 wikijs 위키 컨테이너를 멈춥니다.
        sudo docker ps -a ; sudo docker stop wikijs ; sudo docker ps -a
        #------------------------------------^^^^^^ 위키 컨테이너
__EOF__
    sudo docker ps -a ; sudo docker stop wikijs ; sudo docker ps -a
    #------------------------------------^^^^^^ 위키 컨테이너
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

        current_backup_7z="${LOCAL_Y2M2}/last-pgsql-$(date +%y%m%d_%H%M%S)-$(uname -n).sql.7z"
        #-------------------------------------^^^^^ 데이터베이스 컨테이너 이름
        cat <<__EOF__
(6-8) 지정한 백업파일을 데이터베이스에 붓기 전에,
        현재 운영중인 DB 를 먼저 ${LOCAL_Y2M2} 에 백업합니다.
      
        time sudo docker exec pgsql pg_dumpall -U imwiki | 7za a -mx=9 -p -si ${current_backup_7z}
        #-------------------------------------^^^^^ 데이터베이스 컨테이너 이름

🖍️ (6-9) 백업하는 .7z 파일에 지정해 줄 새로운 ===비밀번호=== 를 입력하세요.

__EOF__
        time sudo docker exec pgsql pg_dumpall -U imwiki | 7za a -mx=9 -p -si ${current_backup_7z}
        #---------------------^^^^^ 데이터베이스 컨테이너 이름
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
        time sudo docker exec -it pgsql dropdb -U imwiki wikidb
        #-------------------------^^^^^ 데이터베이스 컨테이너 이름
__EOF__
    time sudo docker exec -it pgsql dropdb -U imwiki wikidb
    #-------------------------^^^^^ 데이터베이스 컨테이너 이름
cat <<__EOF__
(6-13) 빈 데이터베이스를 새로 만듭니다.
        time sudo docker exec -it pgsql createdb -U imwiki wikidb
        #-------------------------^^^^^ 데이터베이스 컨테이너 이름
__EOF__
    time sudo docker exec -it pgsql createdb -U imwiki wikidb
    #-------------------------^^^^^ 데이터베이스 컨테이너 이름
    cat <<__EOF__
(6-14) 지정한 백업파일을 데이터베이스에 다시 붓습니다. (RESTORE)

        time 7za x -so ${zzz} | sudo docker exec -i pgsql psql -U imwiki wikidb
        #-------------------------------------------^^^^^ 데이터베이스 컨테이너 이름

🖍️ (6-15) 백업할때 입력한 ----비밀번호---- 를 입력하세요.

__EOF__
    time 7za x -so ${zzz} | sudo docker exec -i pgsql psql -U imwiki wikidb
    #-------------------------------------------^^^^^ 데이터베이스 컨테이너 이름
    cat <<__EOF__
(6-16) 멈췄던 위키 컨테이너를 다시 시작합니다.
        sudo docker start pgsql ; sudo docker ps -a
        #-----------------^^^^^ 데이터베이스 컨테이너 이름
__EOF__
    sudo docker start pgsql ; sudo docker ps -a
    #-----------------^^^^^ 데이터베이스 컨테이너 이름
    echo "(6-17) 백업 작업이 끝났습니다."
    #-- <---- 리스토어 할 .7z 파일이 있다.
fi
zzz=""
echo "🎶 (6-18) --------------------"
```

## 4-3. 리스토어 스크립트

`sh cli-psql-backup-restore-script.sh` [ `업로드하려는 백업파일 이름` ]
```
#!/bin/sh

cat <<__EOF__
#-- wiki58 240213-1703

proenpi@pi4b /opt/backup/wikidb $
yoran@orangepizero2w /home/docker/backup $

__EOF__

DB_NAME="wikidb" #-- pgsql 데이터베이스 이름 #--> 정리한 이름들
DB_USER="imwiki" #-- pgsql 사용자 이름
DB_PASS="wikiam9ho" #-- pgsql 비번
DB_VOLUME="/home/docker/pgreswiki" #-- DB 설치위치
DB_CONTAINER="dbcont" #-- 데이터베이스 컨테이너
#--
WIKI_PORTS="5900" #-- ports: 5900
WIKI_CONTAINER="wikicont" #-- 위키 컨테이너 #<-- 정리한 이름들

DB_NAME="wiki" #-- DB_NAME: wiki > wikidb #-- pgsql 데이터베이스 이름
DB_USER="wikijs" #-- DB_USER: wikijs > imwiki #-- pgsql 사용자 이름
DB_PASS="wikijsrocks" #-- DB_PASS: wikijsrocks > wikiam9ho #-- pgsql 비번
DB_VOLUME="/home/docker/pgreswiki" #-- db: volumes: /home/docker/pgreswiki #-- DB 설치위치
DB_CONTAINER="wikijsdb" #-- db: container_name: wikijsdb > dbcont #-- 데이터베이스 컨테이너
#--
WIKI_PORTS="5900" #-- ports: 5900
WIKI_CONTAINER="wikijs" #-- wiki: container_name: wikijs > wikicont #-- 위키 컨테이너

BACKUP_DIR=/home/docker/backup/$(date +%Y)
if [ ! -d ${BACKUP_DIR} ]; then
    mkdir ${BACKUP_DIR}
fi
BACKUP_FILE=${BACKUP_DIR}/wiki_$(date +%y%m%d%a-%H%M)-$(uname -n).sql.7z
RESTORE_FILE=$1
if [ ! -f "${RESTORE_FILE}" ]; then
    RESTORE_FILE=${BACKUP_DIR}/wiki_$(date +%y%m%d%a-%H%M)-$(uname -n).sql.7z
    cat <<__EOF__
----> 리스토어 하려는 파일의 이름을
----> ${RESTORE_FILE}
----> 처럼 지정해 주세요.
__EOF__
    read a
    if [ "x$a" = "x" ]; then
        a=${RESTORE_FILE}
    fi
    RESTORE_FILE=${a}
fi
cat <<__EOF__
----> ls -l ${BACKUP_DIR} #-- BACKUP_DIR
$(ls -l ${BACKUP_DIR})
----> ls -l ${RESTORE_FILE} #-- RESTORE_FILE
$(ls -l ${RESTORE_FILE})
----> sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a #-- WIKI STOP
__EOF__
sudo docker ps -a ; sudo docker stop ${WIKI_CONTAINER} ; sudo docker ps -a

cat <<__EOF__
----> time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -p -si ${BACKUP_FILE}
----> 백업하려는 파일의 새로운 비번을 입력하세요.
__EOF__
time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${DB_USER} | 7za a -mx=9 -p -si ${BACKUP_FILE}

#-- Archive size: 169271234 bytes (162 MiB)
#-- Everything is Ok
#--
#-- real  16m0.764s
#-- user  26m26.057s
#-- sys  0m22.980s

if [ ! -f ${RESTORE_FILE} ]; then
    echo "----> 리스토어할 파일이 없습니다."
    exit -11
fi
cat <<__EOF__

----> 리스토어 하기전 최종 백업한 BACKUP_FILE: ${BACKUP_FILE}
$(ls -l ${BACKUP_FILE})
----> DB 는 이 파일로 복구할 예정입니다 - RESTORE_FILE: ${RESTORE_FILE}
$(ls -l ${RESTORE_FILE})

----> 지정한 백업파일을 리스토어 하기 위해서는 현재 데이터베이스를 삭제해야 합니다.
---->
----> sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}
----> 리스토어 하기 전에, 현재의 위키 데이터베이스를 지워야 하므로,
----> 삭제하려면 'y' 를 입력하세요.
__EOF__
read a
if [ "x$a" != "xy" ]; then
    cat <<__EOF__

----> 리스토어 하기전 최종 백업한 BACKUP_FILE: ${BACKUP_FILE}
$(ls -l ${BACKUP_FILE})
====> 백업만 하고 현재의 위키를 그대로 두고 작업을 끝냅니다.
__EOF__
else
    echo "----> sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}"
    sudo docker exec -it ${DB_CONTAINER} dropdb -U ${DB_USER} ${DB_NAME}
    echo "----> sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}"
    sudo docker exec -it ${DB_CONTAINER} createdb -U ${DB_USER} ${DB_NAME}
    cat <<__EOF__
----> time 7za x -so ${RESTORE_FILE} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} postgress
----> 백업했을때, 저 파일에 지정한 비번을 입력하세요.
__EOF__
    time 7za x -so ${RESTORE_FILE} | sudo docker exec -i ${DB_CONTAINER} psql -U ${DB_USER} postgres
cat <<__EOF__
----> 리스토어 하기전 최종 백업한 BACKUP_FILE: ${BACKUP_FILE}
$(ls -l ${BACKUP_FILE})
----> DB 는 이 파일로 복구 하였음 - RESTORE_FILE: ${RESTORE_FILE}
$(ls -l ${RESTORE_FILE})
----> sudo docker ps -a ; sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a #-- WIKI START
__EOF__
    sudo docker ps -a ; sudo docker start ${WIKI_CONTAINER} ; sudo docker ps -a
fi
cat <<__EOF__
version: "3"
services:

  db:
    image: postgres:11-alpine
    environment:
      POSTGRES_DB: ${DB_NAME} #-- DB_NAME: wiki > wikidb #-- 데이터베이스 이름
#--
      POSTGRES_USER: ${DB_USER} #-- DB_USER: wikijs > imwiki #-- 데이터베이스 사용자 이름
      POSTGRES_PASSWORD: ${DB_PASS} #-- DB_PASS: wikijsrocks > wikiam9ho #-- 데이터베이스 비번

    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - ${DB_VOLUME}:/var/lib/postgresql/data #-- db: volumes: /home/dicker/pgreswiki #-- DB 설치위치
    container_name:
      ${DB_CONTAINER} #-- db: container_name: wikijsdb > dncont #-- 데이터베이스 컨테이너

  wiki:
    image: requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_NAME: ${DB_NAME} #-- wiki > wikidb #-- wiki 데이터베이스 이름
      DB_USER: ${DB_USER} #-- wikijs > imwiki #-- wikijs 사용자 이름
      DB_PASS: ${DB_PASS} #-- wikijsrocks > wikiam9ho #-- wikijsrocks 비번

    restart: unless-stopped
    ports:
      - "${WIKI_PORT}:3000" #-- ports: 5900
    container_name:
      ${WIKI_CONTAINER} #-- wiki: container_name: wikijs > wikicont #-- 위키 컨테이너
__EOF__
```

```
┏━┳┓
┃╌┃┃🇰🇷
┣━╋┫
┗━┻┛
```
