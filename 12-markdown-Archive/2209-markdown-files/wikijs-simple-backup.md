## wiki.js 단순백업 보관하기

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
REMOTE_FOLDER="11-simple_wiki.js" #- 원격 저장소의 첫번째 폴더 이름
RCLONE_NAME="yosgc" #- rclone 이름
REMOTE_Y2M2=${REMOTE_FOLDER}/${this_y4m2}
#-
ymd_hm=$(date +"%y%m%d%a-%H%M")
DB_sql7z=${DB_NAME}_${ymd_hm}_$(uname -n).sql.7z #- 압축파일 이름
cat <<__EOF__
#-
#- DB 백업
#-
#- (10) wili.js 데이터베이스를 백업하기 위해서 아래에 ---비밀번호--- 를 입력하세요.
#-
__EOF__
sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${LOCAL_Y2M2}/${DB_sql7z} -p ; echo "#-- (4) 오늘 요일이름의 로컬 보관장소에 백업합니다."
ls -lR ${LOCAL_Y2M2} ; echo "#-- (5) 보관용 로컬 폴더입니다."
/usr/bin/rclone copy ${LOCAL_Y2M2}/${DB_sql7z} ${RCLONE_NAME}:${REMOTE_Y2M2}/ ; echo "#-- (6) 오늘 요일이름의 파일을 클라우드로 복사합니다."
/usr/bin/rclone lsl ${RCLONE_NAME}:${REMOTE_Y2M2} ; echo "#-- (7) 클라우드 폴더입니다."
#-
sudo docker start wikijs ; sudo docker ps -a ; echo "#-- (8) 위키 도커를 다시 시작합니다."
