#!/bin/sh

cat <<__EOF__

proenpi@pi4b /opt/backup/wikidb $
yoran@orangepizero2w /home/docker/backup $

__EOF__

USER_NAME="wikijs"
DB_NAME="wiki"
DB_CONTAINER="wikijsdb"

BACKUP_DIR=/home/docker/backup/$(date +%Y)
if [ ! -d ${BACKUP_DIR} ]; then
	mkdir ${BACKUP_DIR}
fi
BACKUP_FILE=${BACKUP_DIR}/wikipsql-$(date +%y%m%d%a-%H%M)-$(uname -n).sql.7z
RESTORE_FILE=$1
if [ ! -f "${RESTORE_FILE}" ]; then
	RESTORE_FILE=${BACKUP_DIR}/wikipsql-$(date +%y%m%d%a-%H%M)-$(uname -n).sql.7z
	cat <<__EOF__
----> 리스토어 하려는 파일의 이름을
----> ${RESTORE_FILE}
----> 처럼 지정해 주세요.
__EOF__
	read a
	if [ "x$a" = "x" ]; then
		echo "---->"
		exit -10
	fi
	if [ ! -f "$a" ]; then
		echo "----> 해당 파일이 없습니다."
		exit -11
	fi
	RESTORE_FILE=${a}
fi
cat <<__EOF__
----> ls -l ${RESTORE_FILE}
$(ls -l ${RESTORE_FILE})
----> sudo docker stop wikijs ; sudo docker ps -a
__EOF__
sudo docker stop wikijs ; sudo docker ps -a

cat <<__EOF__
----> time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${USER_NAME} | 7za a -mx=9 -p -si ${BACKUP_FILE}
----> 백업하려는 파일의 새로운 비번을 입력하세요.
__EOF__
time sudo docker exec ${DB_CONTAINER} pg_dumpall -U ${USER_NAME} | 7za a -mx=9 -p -si ${BACKUP_FILE}

#-- Archive size: 169271234 bytes (162 MiB)
#-- Everything is Ok
#-- 
#-- real	16m0.764s
#-- user	26m26.057s
#-- sys	0m22.980s

cat <<__EOF__

----> 지정한 백업파일을 리스토어 하기 위해서는 현재 데이터베이스를 삭제해야 합니다.
---->
----> 최종 백업한 파일 입니다.
----> ls -l ${BACKUP_FILE}
$(ls -l ${BACKUP_FILE})
----> sudo docker exec -it ${DB_CONTAINER} dropdb -U ${USER_NAME} ${DB_NAME}
----> 리스토어 하기 전에, 현재의 위키 데이터베이스를 지워야 하므로,
----> 삭제하려면 'y' 를 입력하세요.
__EOF__
read a
if [ "x$a" != "xy" ]; then
	echo "====> 백업만 하고 현재의 위키를 그대로 두고 작업을 끝냅니다."
else
	echo "----> sudo docker exec -it ${DB_CONTAINER} dropdb -U ${USER_NAME} ${DB_NAME}"
	sudo docker exec -it ${DB_CONTAINER} dropdb -U ${USER_NAME} ${DB_NAME}
	echo "----> sudo docker exec -it ${DB_CONTAINER} createdb -U ${USER_NAME} ${DB_NAME}"
	sudo docker exec -it ${DB_CONTAINER} createdb -U ${USER_NAME} ${DB_NAME}
	echo "----> time 7za x -so ${RESTORE_FILE} | sudo docker exec -i ${DB_CONTAINER} psql -U ${USER_NAME} postgres"
	echo "----> 백업했을때 입력한 비번을 입력하세요."
	time 7za x -so ${RESTORE_FILE} | sudo docker exec -i ${DB_CONTAINER} psql -U ${USER_NAME} postgres
fi
echo "----> sudo docker start wikijs ; sudo docker ps -a"
sudo docker start wikijs ; sudo docker ps -a
