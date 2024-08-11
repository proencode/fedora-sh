#!/bin/sh

file="keepassproen.kdbx"
user="orangepi"
addr="proen.duckdns.org"
svrdir="ar*/ke*" #-- svrdir="archive/keepass"
#--- localdir="${HOME}/Downloads/bada"
#--- localdir=$(echo "$localdir" | perl -pe 's/\/+$//') #-- 마지막 '/' 를 삭제한다.
localdir="" #-- 현재 위치에 파일을 받기로 한다.

#--- if [ ! -d ${localdir} ]; then
#---    echo "#-- mkdir ${localdir}"
#---    mkdir ${localdir}
#--- fi

echo "#-- ${user}@${addr}:${svrdir} COPY TO ${file}"

echo "#-- INPUT port no"
echo "#--       ----"
read -s port #-- 호스트 접속시 포트번호, '-s' 타이핑하는 글자를 안보여준다.

echo "#-- INPUT svrdir: [ ${svrdir} ]"
echo "#--       ------"
read a
if [ "x$a" != "x" ]; then
        svrdir=$a
fi
svrdir=$(echo "$svrdir" | perl -pe 's/\/+$//') #-- 마지막 '/' 를 삭제한다.
echo "#--> ${svrdir}/"

echo ""
echo "#-- ssh -p 65536 user@${addr} ls -l ${svrdir}/${file}"
ssh -p ${port} ${user}@${addr} ls -l ${svrdir}/${file}
echo "#--                           -----|--------------- (1) 서버의 현재 파일"
echo "                                   |"
echo "                                   V"
echo "#-- ls -l ${localdir}${file}"
ls -l ${localdir}${file}
echo "#--                     --------------------- (2) 로컬의 현재 파일"

echo ""
echo "#-- [ (1) 서버의 파일 시각이 (2) 로컬의 파일 시각보다 최신인 경우만 받아온다 ]"
echo "#--       ----------------       ---------------- "
echo ""
echo "#-- rsync -avzr -e \"ssh -p 65536\" user@${addr}:${svrdir}/${file} ${localdir}${file}"
echo "#-- 서버에서 받아온다."
rsync -avzr -e "ssh -p ${port}" ${user}@${addr}:${svrdir}/${file} ${localdir}${file}

echo ""
echo "#-- ls -l ${localdir}${file}"
ls -l ${localdir}${file}
echo "#--                     --------------------- (3) 로컬의 최종 파일"
