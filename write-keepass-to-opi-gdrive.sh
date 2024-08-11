#!/bin/sh

file_name="keepassproen" #-- keepass 파일의 이름만
file_ext="kdbx" #-- 확장자
file="${file_name}.${file_ext}" #-- keepass 파일명 전체

echo "#-- ${file} 파일이 있는곳에서 실행해야 한다."
echo "#-- INPUT 수정메모"
echo "#--       --------"
read logmsg

logmemo=$(date +%y%m%d%a-%H%M" ${logmsg}") #-- 날짜 + 수정메모
echo "#----------"
echo ""
echo "${logmemo}"
ls -l ${file}
echo ""

echo "#-- keepass 파일의 공유항목에 수정메모를 업데이트 하고,"
echo "#-- 수정메모를 keep 에 붙인다."
echo "#-- press Enter:"
read a

user="orangepi" #-- 호스트의 사용자
addr="proen.duckdns.org" #-- 호스트 이름
svr_ArKe="archive/keepass" #-- 파일을 저장하는 디렉토리
echo "#--"
echo "#-- ${file} COPYTO user@server:${svr_ArKe} AND GDrive"
echo "#-- (1) INPUT port no"
echo "#--           ----"
read -s port #-- 호스트 접속시 포트번호, '-s' 타이핑하는 글자를 안보여준다.

echo "#-- (2) INPUT arc./kee.: [ ${svr_ArKe} ]"
echo "#--           ---------"
read a
if [ "x$a" != "x" ]; then
        svr_ArKe=$a
fi
svr_ArKe=$(echo "$svr_ArKe" | perl -pe 's/\/+$//')
echo "#--> ${svr_ArKe}"

file_date_ext=${file_name}-$(date +%y%m%d-%H%M).${file_ext}
echo "#-- ssh -p ${port} ${user}@${addr} mv ./${svr_ArKe}/${file} ./${svr_ArKe}/backup/${file_date_ext} #-- (3) 서버의 최종 파일을 backup/ 으로 이동"
ssh -p ${port} ${user}@${addr} mv ./${svr_ArKe}/${file} ./${svr_ArKe}/backup/${file_date_ext}

echo "#-- rsync -avzr -e \"ssh -p 65536\" ${file} user@${addr}:${svr_ArKe}/ #-- (4) 서버로 복사"
rsync -avzr -e "ssh -p ${port}" ${file} ${user}@${addr}:${svr_ArKe}/

echo "#-- ssh -p ${port} ${user}@${addr} rclone lsl yosjgc:keepass/ --include "${file_name}*.${file_ext}" #-- (5) 서버 파일 확인"
#  echo "#-- ssh -p ${port} ${user}@${addr} rclone lsl yosjgc:keepass/ --include "${file_name}*.${file_ext}" #-- (5) 서버 파일 확인"
#  ssh -p ${port} ${user}@${addr} rclone lsl yosjgc:keepass/ --include "${file_name}*.${file_ext}"

echo "#-- ssh -p ${port} ${user}@${addr} rclone moveto yosjgc:keepass/${file} yosjgc:keepass/backup/${file_date_ext} #-- (6) 클라우드 파일 이름바꾸기"
ssh -p ${port} ${user}@${addr} rclone moveto yosjgc:keepass/${file} yosjgc:keepass/backup/${file_date_ext}

echo "#-- ssh -p 65536 user@${addr} rclone copy ./${svr_ArKe}/${file} cloud:keepass/ #-- (7) 클라우드로 복사"
ssh -p ${port} ${user}@${addr} rclone copy ./${svr_ArKe}/${file} yosjgc:keepass/

echo "#-- ssh -p 65536 user@${addr} rclone lsl cloud:keepass/ --include "${file_name}*" #-- (8) 복사확인"
ssh -p ${port} ${user}@${addr} rclone lsl yosjgc:keepass/ --include "${file_name}*"
