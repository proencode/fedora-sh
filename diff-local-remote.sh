#!/bin/sh

# CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_NAME=`basename $PWD` # Print Working Directory 전체경로 말고 현재 디렉토리 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi

#-- 찾는 파일
file_dir=("[79Bd]*" "4winApp" "apps" "vdi")
#-- diff 저장파일 접두어
diffPrefix=("./51-diff" "./52-diff" "./53-diff" "./54-diff")
#-- 찾는 파일 갯수
dimCnt=4

#-- 폴더중 제외한것
# backup
# epub-files
# mp4-copy

Raddress="proenpi@192.168.219.58"
cat <<__EOF__
#-- remote address = ${Raddress}

----> press Enter: (or enter NEW address)
__EOF__
read a
if [ "x$a" != "x" ]; then
	Raddress = "$a"
	cat <<__EOF__
#-- NEW remote address = ${Raddress}

----> press Enter:
__EOF__
	read a
fi

i=0
until [ $i -ge $dimCnt ]
do
	echo "$((i + 1)). 찾는 파일/폴더: ${file_dir[${i}]}  (${diffPrefix[${i}]})"
	i=$(expr $i + 1)
done

Rfolder="${CMD_NAME}"
cat <<__EOF__

#-- 로컬의 현재 위치 = ${CMD_DIR} / ${CMD_NAME}
#-- 원격지의 지정 위치 = ${Rfolder}

----> press Enter: (or enter NEW dir from HOME)
__EOF__
read a
if [ "x$a" != "x" ]; then
	Rfolder = "$a"
	cat <<__EOF__
#-- NEW remote dir from HOME = ${Rfolder}

----> press Enter:
__EOF__
	read a
fi

LocalFile="500-tmpLocal"
RemoteFile="501-tmpRemote"

i=0
until [ $i -ge $dimCnt ]
do
	# echo "#-- ls -l ${file_dir[${i}]} | sort >> ${LocalFile}"
	ls -l ${file_dir[${i}]} | sort >> ${LocalFile}
	echo "#-- ssh ${Raddress} cd ${Rfolder} ; ls -l ${file_dir[${i}]} | sort >> ${RemoteFile}"
	ssh ${Raddress} cd ${Rfolder} ; ls -l ${file_dir[${i}]} | sort >> ${RemoteFile}

	DiffFile="${diffPrefix[${i}]}-$(date +%y%m%d%a-%H%M%S)"
	# echo "#-- diff ${LocalFile} ${RemoteFile} > ${DiffFile}"
	diff ${LocalFile} ${RemoteFile} >> ${DiffFile}
	# echo "#-- ls -l ${DiffFile}"
	echo "#-- ---------- ----------"
	ls -l ${DiffFile}
	echo "#-- ---------- ----------"
	i=$(expr $i + 1)
done

echo "#-- ls -l 5*"
ls -l 5*
