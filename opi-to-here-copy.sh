#!/bin/sh

keeps_name="keepassproen" #-- keepass 파일의 이름만
keeps_ext="kdbx" #-- 확장자
keepsNameExt="${keeps_name}.${keeps_ext}" #-- keepass 파일명 전체

userID="orangepi" #-- 호스트의 사용자
svrURL="proen.duckdns.org" #-- 호스트 URL
svrDIR="picture" #-- 호스트 파일이 있는 디렉토리

cat <<__EOF__
#-- !!! 호스트 파일을 받을 로컬 디렉토리 에서 실행해야 한다. !!!

#-- userID@svrURL:${svrDIR} COPY TO current Directory
#-- (1) INPUT: port no (서버 포트번호 입력시 숫자 표시 안됨)
#--            ----
__EOF__
read -s svrPORT #-- 호스트 접속시 포트번호, '-s' 타이핑하는 글자를 안보여준다.

cat <<__EOF__
#-- (2) INPUT: 받을 파일의 서버 디렉토리 지정 [ ${svrDIR} ]
#--                        -------------
__EOF__
read a

if [ "x$a" != "x" ]; then
        svrDIR=$a
fi
svrDIR=$(echo "$svrDIR" | perl -pe 's/\/+$//') #-- 마지막에 있는 '/' 는 모두 삭제하는 perl 스크립트

cat <<__EOF__
#--> ${svrDIR}

#-- (3) 서버 디렉토리의 파일
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} ls -l ${svrDIR}/

cat <<__EOF__
#-- (4) INPUT: 받을 파일 (이름을 지정, name*.ext 처럼 쓸수도 있음)
#--            ---------
__EOF__
read svrFILES

if [ "x$svrFILES" != "x" ]; then
	cat <<__EOF__
#-- (5) 서버에서 받아온다.
#-- rsync -avzr -e "ssh -p svrPORT" userID@svrURL:${svrDIR}/${svrFILES} .
__EOF__
	rsync -avzr -e "ssh -p ${svrPORT}" ${userID}@${svrURL}:${svrDIR}/${svrFILES} .
	echo "#-- ls -l"
	ls -l
fi
