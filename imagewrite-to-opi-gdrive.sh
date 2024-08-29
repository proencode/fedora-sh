#!/bin/sh

localDIR="img/$(date +%y%m)" #-- 로컬에서 파일을 저장하는 디렉토리

if [ ! -d ${localDIR} ]; then
	cat <<__EOF__

!!! 로컬 현위치에 ${localDIR}/ 디렉토리를 만들고 이미지를 저장해야 합니다 !!!

__EOF__
	exit -1
fi

cat <<__EOF__

#-- ls -l ${localDIR}/
$(ls -l ${localDIR}/)
__EOF__

#--

cat <<__EOF__
#--
#-- ${localDIR} COPYTO userID@svrURL:${svrDIR} AND cloud Drive
#-- (1) INPUT: port no (서버 포트번호 입력시 숫자 표시 안됨)
#--            ----
__EOF__
read -s svrPORT #-- 호스트 접속시 포트번호, '-s' 타이핑하는 글자를 안보여준다.

svrDIR="${localDIR}" #-- 서버에서 파일을 저장하는 디렉토리

cat <<__EOF__
#-- (2) INPUT: 서버 디렉토리 [ ${svrDIR} ]
#--            -------------
__EOF__
read a

if [ "x$a" != "x" ]; then
        svrDIR=$a
fi
svrDIR=$(echo "$svrDIR" | perl -pe 's/\/+$//') #-- 마지막에 있는 '/' 는 모두 삭제하는 perl 스크립트

#--

cloudDRV="dosomi" #-- 클라우드 드라이브
cloudDIR="${localDIR}" #-- 클라우드에서 파일을 저장하는 디렉토리

cat <<__EOF__
#-- (3) INPUT: 클라우드 디렉토리 [ ${cloudDIR} ]
#--            -----------------
__EOF__
read a

if [ "x$a" != "x" ]; then
        cloudDIR=$a
fi
cloudDIR=$(echo "$cloudDIR" | perl -pe 's/\/+$//') #-- 마지막에 있는 '/' 는 모두 삭제하는 perl 스크립트

#--

userID="orangepi" #-- 호스트의 사용자
svrURL="proen.duckdns.org" #-- 호스트 URL

cat <<__EOF__
#-- (4) 서버로 복사
#-- rsync -avzr -e \"ssh -p svrPORT\" ${localDIR} userID@svrURL:${svrDIR}/
__EOF__
rsync -avzr -e "ssh -p ${svrPORT}" ${localDIR} ${userID}@${svrURL}:${svrDIR}/

cat <<__EOF__
#-- (5) 복사후 서버의 파일
#-- ssh -p svrPORT userID@svrURL ls -l ./${svrDIR}/
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} ls -l ./${svrDIR}/

cat <<__EOF__
#-- (6) 클라우드로 복사
#-- ssh -p svrPORT userID@svrURL rclone copy ./svrDIR/ cloudDRV:cloudDIR/
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} rclone copy ./${svrDIR}/ ${cloudDRV}:${cloudDIR}/

cat <<__EOF__
#-- (7) 백업 완료후 클라우드의 파일
#-- ssh -p svrPORT userID@svrURL rclone lsl cloudDRV:cloudDIR/
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} rclone lsl ${cloudDRV}:${cloudDIR}/
