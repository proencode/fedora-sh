#!/bin/sh

keeps_name="keepassproen" #-- keepass 파일의 이름만
keeps_ext="kdbx" #-- 확장자
keepsNameExt="${keeps_name}.${keeps_ext}" #-- keepass 파일명 전체

userID="orangepi" #-- 호스트의 사용자
svrURL="proen.duckdns.org" #-- 호스트 URL
svrDIR="archive/keepass" #-- 파일을 저장하는 디렉토리

cloudDRV="yosjgc" #-- 클라우드 드라이브
cloudDIR="keepass" #-- 파일을 저장하는 디렉토리

keepass_dir="archive/keepass"
if [ ! -d ~/${keepass_dir} ]; then
	mkdir -p ~/${keepass_dir}
fi
cd ~/${keepass_dir}
cat <<__EOF__
#-- !!! ${keepsNameExt} 파일이 있는곳에서 실행해야 한다. !!!

#-- userID@svrURL:${svrDIR} COPY TO ${keepsNameExt}
#-- (1) INPUT: port no (서버 포트번호 입력시 숫자 표시 안됨)
#--            ----
__EOF__
read -s svrPORT #-- 호스트 접속시 포트번호, '-s' 타이핑하는 글자를 안보여준다.

cat <<__EOF__
#-- (2) INPUT: 서버 디렉토리 [ ${svrDIR} ]
#--            -------------
__EOF__
read a

if [ "x$a" != "x" ]; then
        svrDIR=$a
fi
svrDIR=$(echo "$svrDIR" | perl -pe 's/\/+$//') #-- 마지막에 있는 '/' 는 모두 삭제하는 perl 스크립트

cat <<__EOF__
#--> ${svrDIR}

#-- ssh -p svrPORT userID@svrURL ls -l ${svrDIR}/${keepsNameExt}
#--                           -----|--------------- (3) 서버 의 현재 파일
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} ls -l ${svrDIR}/${keepsNameExt}
cat <<__EOF__
#--                           -----|--------------- (3) 서버 의 현재 파일
#--                                |
#--                                V
#-- ls -l ${keepsNameExt}
#--                           --------------------- (4) 로컬 (이 PC) 의 현재 파일
__EOF__
ls -l ${keepsNameExt}
cat <<__EOF__
#--                           --------------------- (4) 로컬 (이 PC) 의 현재 파일
#--
#-- [ (3) 서버의 파일 시각 이 (4) 로컬의 파일 시각 보다 최신인 경우만 받아온다 ]
#--       ----------------   >>   ---------------- 
#--
#-- 서버의 파일이 더 최근이면 'y' 입력:
__EOF__
read a
if [ "x$a" = "xy" ]; then
	cat <<__EOF__
#-- (5) 서버에서 받아온다.
#-- rsync -avzr -e "ssh -p svrPORT" userID@svrURL:${svrDIR}/${keepsNameExt} ${keepsNameExt}
__EOF__
	rsync -avzr -e "ssh -p ${svrPORT}" ${userID}@${svrURL}:${svrDIR}/${keepsNameExt} ${keepsNameExt}
	echo "#-- ls -l ${keepsNameExt}"
	echo "#--                           --------------------- (6) 로컬의 최종 파일"
	ls -l ${keepsNameExt}
	echo "#--                           --------------------- (6) 로컬의 최종 파일"
fi
cd - #-- 원래 위치로 갑니다.
cat <<__EOF__
echo "$(ping -n 1 ${svrURL} | awk -F'[' '{print $2}' | awk -F']' '{print $1}') pi #-- for Windows"
#xxxx $(ping -n 1 ${svrURL} | grep PING | awk -F'(' '{print $2}' | awk -F')' '{print $1}') pi
$(ifconfig | grep -B1 tm | grep 192.168 | awk -F'inet' '{print $2}' | awk -F'netmask' '{print $1"vb"}')
__EOF__
