## wiki.js 단순백업 보관하기

sudo docker ps -a ; sudo docker stop wikijs #- (1) 위키 도커를 중단합니다.
#-
DB_NAME="wiki" #- (2) 백업할 데이터베이스 이름
LOCAL_FOLDER="/home/backup/wikidb" #- 백업파일을 일시적으로 저장하는 로컬 저장소의 디렉토리 이름
if [ ! -d ${LOCAL_FOLDER} ];then
    sudo mkdir -p ${LOCAL_FOLDER} ; sudo chown ${USER}.${USER} ${LOCAL_FOLDER} ; echo "#-- 보관용 ${LOCAL_FOLDER} 로컬 디렉토리를 만듭니다."
fi
REMOTE_FOLDER="wiki.js" #- 원격 저장소의 첫번째 폴더 이름
RCLONE_NAME="yosgc" #- rclone 이름
this_year=$(date +%Y) #- 2022
this_wol=$(date +%m) #- 07
ymd_hm=$(date +"%y%m%d%a-%H%M")

DB_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}.sql.7z #- 압축파일 이름

pswd_ym=$(date +"%y%m")
yoil_number0to6=$(date +%u) #- (3) 일0 월1 화2 수3 목4 금5 토6
yoil_number1to7=$(( ${yoil_number0to6} + 1 )) #- 1 2 3 4 5 6 7
ju_beonho=$(date +%V) #- 1년중 몇번째 주인지 표시.
#- V: 월요일마다 하나씩 증가한다.
#- U: (1월1일이 일요일 이면 01, 아니면 00), 일요일마다 하나씩 증가한다.
#-
yoil_sql_7z=".${yoil_number1to7}yoil.sql.7z" #- (4) 요일 표시
uname_n=$(uname -n)
this_wol_sql_7z=".${this_wol}wol.sql.7z" #- 월 표시
WOL_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${this_wol_sql_7z}
ju_beonho_sql_7z=".${ju_beonho}ju.sql.7z" #- 1년중 몇번째 주인지 표시
JU_sql7z=${DB_NAME}_${ymd_hm}_${uname_n}${ju_beonho_sql_7z}
#-
LOCAL_THIS_YEAR=${LOCAL_FOLDER}/${this_year} #- (5) 년도 폴더에는 매월 마지막 백업 1개씩만 보관한다.
LOCAL_YOIL=${LOCAL_THIS_YEAR}/1_7yoil #- 년도의 yoil 폴더에는 최근 1주일치만 보관한다.
LOCAL_JU=${LOCAL_THIS_YEAR}/01_53ju #- 년도의 ju 폴더에는 매주 마지막 백업 1개씩만 보관한다.
#-
REMOTE_YEAR=${REMOTE_FOLDER}/${this_year}
REMOTE_YOIL=${REMOTE_YEAR}/1_7yoil #- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년도/last7 폴더이름
REMOTE_JU=${REMOTE_YEAR}/01_53ju #- rclone 명령으로 보내는 원격 저장소의 데이터베이스구분/년도/sunday 폴더이름
if [ ! -d ${LOCAL_YOIL} ]; then
    mkdir -p ${LOCAL_YOIL} #-- 보관용 로컬 디렉토리를 만듭니다.
fi
if [ ! -d ${LOCAL_JU} ]; then
    mkdir -p ${LOCAL_JU} #-- 보관용 로컬 디렉토리를 만듭니다.
fi
ls -lR ${LOCAL_THIS_YEAR} ; echo "#-- (6) 보관용 로컬 디렉토리 입니다."
#-
#- DB 백업
#-
ymd_hm=$(date +"%y%m%d%a-%H%M")
cat <<__EOF__
---->
----> (10) wili.js 데이터베이스를 백업하기 위해서 아래에 ---비밀번호--- 를 입력하세요.
---->
__EOF__
sudo docker exec wikijsdb pg_dumpall -U wikijs | 7za a -si ${LOCAL_YOIL}/${DB_sql7z} -p ; echo "#-- (9) 오늘 요일이름의 로컬 보관장소에 백업합니다."
/usr/bin/rclone copy ${LOCAL_YOIL}/${DB_sql7z} ${RCLONE_NAME}:${REMOTE_YOIL}/ ; echo "#-- (10) 오늘 요일이름의 파일을 클라우드로 복사합니다."
/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YOIL} ; echo "#-- (11) 오늘 요일이름의 백업 확인"
#-
#- 오늘의 월 이름으로 된 지난백업 삭제
#-
rm -f ${LOCAL_THIS_YEAR}/*${this_wol_sql_7z} ; echo "#-- (12) 전에 보관한 월이름의 로컬 백업파일을 삭제합니다."
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR}/ | grep ${this_wol_sql_7z} | awk '{print $2}') #- 전에 보관한 월이름의 백업파일이 클라우드에 있는지 확인 합니다.
if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
    mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"
    for val in "${Remote_Sql7z_Array[@]}"
    do
        file_name=$(echo ${val} | sed 's/ *$//g') #- 빈칸 삭제
        /usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_YEAR}/${file_name} ; echo "#-- (13) 전에 보관한 월이름의 클라우드 백업파일을 삭제합니다."
    done
fi
#-
#- 오늘의 월 이름으로 복사
#-
cp ${LOCAL_YOIL}/${YOIL_sql7z} ${LOCAL_THIS_YEAR}/${WOL_sql7z} ; echo "#-- (14) 오늘 요일이름의 파일을 월 이름으로 바꾸어 로컬의 년도폴더에 복사합니다."
/usr/bin/rclone copy ${LOCAL_THIS_YEAR}/${WOL_sql7z} ${RCLONE_NAME}:${REMOTE_YEAR}/ ; echo "#-- (15) 이달 백업파일을 년도 폴더에 복사합니다."
/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_YEAR} ; echo "#-- (16) 폴더 확인"
#-
#- 오늘의 이번주 일련번호 이름으로 된 지난백업 삭제
#-
rm -f ${LOCAL_JU}/*${ju_beonho_sql_7z} ; echo "#-- (17) 전에 보관한 이번주 번호 로컬 백업파일을 삭제합니다."
REMOTE_SQL_7Z_LIST=$(/usr/bin/rclone ls ${RCLONE_NAME}:${REMOTE_JU}/ | grep ${ju_beonho_sql_7z} | awk '{print \$2}') #- 전에 보관한 이번주 번호 백업파일이 클라우드에 있는지 확인 합니다.
if [ "x$REMOTE_SQL_7Z_LIST" != "x" ]; then
    mapfile -t Remote_Sql7z_Array <<< "$REMOTE_SQL_7Z_LIST"
    for val in "${Remote_Sql7z_Array[@]}"
    do
        file_name=$(echo ${val} | sed 's/ *$//g') #- 빈칸 삭제
        /usr/bin/rclone deletefile ${RCLONE_NAME}:${REMOTE_JU}/${file_name} ; echo "#-- (18) 전에 보관한 이번주 번호의 클라우드 백업파일을 삭제합니다."
    done
fi
#-
#- 오늘의 이번주 번호 이름으로 복사
#-
cp ${LOCAL_YOIL}/${YOIL_sql7z} ${LOCAL_JU}/${JU_sql7z} ; echo "#-- (19) 오늘 요일이름의 파일을 이번주 번호 이름으로 바꾸어 로컬의 주번호 폴더에 복사합니다."
/usr/bin/rclone copy ${LOCAL_JU}/${JU_sql7z} ${RCLONE_NAME}:${REMOTE_JU}/) ; echo "#-- (20) ${this_wol}월 백업파일을 ${REMOTE_JU} 폴더로 복사합니다."
#-
ls -lR ${LOCAL_THIS_YEAR} ; echo "#-- (21) 보관용 로컬 폴더입니다."
/usr/bin/rclone lsl ${RCLONE_NAME}:${REMOTE_YEAR} ; echo "#-- (22) 클라우드 폴더입니다."
#-
sudo docker start wikijs ; sudo docker ps -a ; echo "#-- (23) 위키 도커를 다시 시작합니다."
