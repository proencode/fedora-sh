#!/bin/sh

file="keepassproen.kdbx"
user="orangepi"
addr="proen.duckdns.org"
sdir="archive/keepass"
echo "#-- ${file} COPYTO ${user}@${addr}:${sdir} AND GDrive"
echo "#-- ${file} 파일이 있는곳에서 실행해야 한다."

echo "#-- INPUT port no"
echo "#--       ----"
read -s port

echo "#-- INPUT sdir: [ ${sdir} ]"
echo "#--       ----"
read a
if [ "x$a" != "x" ]; then
	sdir=$a
fi
sdir=$(echo "$sdir" | perl -pe 's/\/+$//')
echo "#--> ${sdir}"

echo "#-- INPUT 수정 메모: 'keepassxc 수정메모' 를 복사해서 붙인다."
echo "#--       ----"
read logmsg

echo "#-- rsync -avzr -e \"ssh -p 65536\" ${file} user@${addr}:${sdir}/ #-- 서버로 복사"
rsync -avzr -e "ssh -p ${port}" ${file} ${user}@${addr}:${sdir}/
echo "#-- ssh -p 65536 user@${addr} rclone copy ${sdir}/${file} cloud:keepass/ #-- 클라우드로 복사"
ssh -p ${port} ${user}@${addr} rclone copy ${sdir}/${file} yosjgc:keepass/
echo "#-- ssh -p 65536 user@${addr} rclone lsl cloud:keepass/${file} #-- 복사확인"
echo "$(ls -l ${file} ; date +%y%m%d%a-%H%M) ${logmsg}"
ssh -p ${port} ${user}@${addr} rclone lsl yosjgc:keepass/${file}
echo "#-- 위 내용을 keep.google.com 에 복사해둔다."
