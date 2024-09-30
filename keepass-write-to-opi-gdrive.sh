#!/bin/sh

keeps_name="keepassproen" #-- keepass 파일의 이름만
keeps_ext="kdbx" #-- 확장자
keepsNameExt="${keeps_name}.${keeps_ext}" #-- keepass 현재 파일명
keepsName_Date_Ext=${keeps_name}-$(date +%y%m%d-%H%M).${keeps_ext} #-- 백업위해 바꿀 현재파일 새이름

if [ ! -f ${keepsNameExt} ]; then
	cat <<__EOF__
#--
#-- !!! ${keepsNameExt} 파일이 있는곳에서 실행해야 한다. !!!
#--
__EOF__
	exit -1
fi

userID="orangepi" #-- 호스트의 사용자
svrURL="proen.duckdns.org" #-- 호스트 URL
svrDIR="archive/keepass" #-- 파일을 저장하는 디렉토리

cloudDRV="yosjgc" #-- 클라우드 드라이브
cloudDIR="keepass" #-- 파일을 저장하는 디렉토리

cat <<__EOF__
#--
#-- (1) INPUT: 수정메모
#--            --------
__EOF__
read logmsg

logmemo=$(date +%y%m%d%a-%H%M" ${logmsg}") #-- 날짜 + 수정메모
log_keepass=log_keepass-$(date +%y%m%d-%H%M).txt
cat > ${log_keepass} <<__EOF__
${logmemo}
$(ls -l ${keepsNameExt})
keepassXC 현대공 ~/git-projects/fedora-sh/keepass-write-to-opi-gdrive.sh
__EOF__

cat <<__EOF__
#----------
#--
$(cat ${log_keepass})
#--
#----------
위 내용을 keepass.kdbx 에 저장한 뒤에 진행한다.
#-- press Enter:
__EOF__
read a

cat <<__EOF__

=======
#--
#-- ${keepsNameExt} COPYTO userID@svrURL:${svrDIR} AND GDrive
#--
#-- (2) INPUT: port no (서버 포트번호 입력시 숫자 표시 안됨)
#--            -------
__EOF__
read -s svrPORT #-- 호스트 접속시 포트번호, '-s' 타이핑하는 글자를 안보여준다.

cat <<__EOF__
#--
#-- (3) INPUT: 서버 디렉토리 [ ${svrDIR} ]
#--            -------------
__EOF__
read a

if [ "x$a" != "x" ]; then
        svrDIR=$a
fi
svrDIR=$(echo "$svrDIR" | perl -pe 's/\/+$//') #-- 마지막에 있는 '/' 는 모두 삭제하는 perl 스크립트

cat <<__EOF__
#--> ${svrDIR}
#--
#-- (4) 서버의 keepass 파일을 backup/ 으로 이동
#-- ssh -p svrPORT userID@svrURL mv ./${svrDIR}/${keepsNameExt} ./${svrDIR}/backup/${keepsName_Date_Ext}
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} mv ./${svrDIR}/${keepsNameExt} ./${svrDIR}/backup/${keepsName_Date_Ext}
echo "#-- rsync -avzr ${keepsNameExt} backup/${keepsName_Date_Ext} #-- 로컬 백업 폴더로 복사"
rsync -avzr ${keepsNameExt} backup/${keepsName_Date_Ext}

cat <<__EOF__
#--
#-- (5) 서버로 복사
#-- rsync -avzr -e \"ssh -p svrPORT\" ${keepsNameExt} userID@svrURL:${svrDIR}/
__EOF__
rsync -avzr -e "ssh -p ${svrPORT}" ${keepsNameExt} ${userID}@${svrURL}:${svrDIR}/

cat <<__EOF__
#-- (6) 백업하기 전의 클라우드 파일
#-- ssh -p svrPORT userID@svrURL rclone lsl cloudDRV:cloudDIR/ --include \"${keeps_name}*.${keeps_ext}\"
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} rclone lsl ${cloudDRV}:${cloudDIR}/ --include "${keeps_name}*.${keeps_ext}"

cat <<__EOF__
#--
#-- (7) 클라우드 파일 이름바꾸기
#-- ssh -p svrPORT userID@svrURL rclone moveto cloudDRV:cloudDIR/${keepsNameExt} cloudDRV:cloudDIR/backup/${keepsName_Date_Ext}
ssh -p ${svrPORT} ${userID}@${svrURL} rclone moveto ${cloudDRV}:${cloudDIR}/${keepsNameExt} ${cloudDRV}:${cloudDIR}/backup/${keepsName_Date_Ext}
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} rclone moveto ${cloudDRV}:${cloudDIR}/${keepsNameExt} ${cloudDRV}:${cloudDIR}/backup/${keepsName_Date_Ext}

cat <<__EOF__
#--
#-- (8) 클라우드로 복사
#-- ssh -p svrPORT userID@svrURL rclone copy ./svrDIR/${keepsNameExt} cloudDRV:cloudDIR/
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} rclone copy ./${svrDIR}/${keepsNameExt} ${cloudDRV}:${cloudDIR}/

cat <<__EOF__
#--
#-- (9) 백업 완료후 클라우드의 파일
#-- ssh -p svrPORT userID@svrURL rclone lsl cloudDRV:cloudDIR/ --include "${keeps_name}*"
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} rclone lsl ${cloudDRV}:${cloudDIR}/ --include "${keeps_name}*.${keeps_ext}"

cat >> ${log_keepass} <<__EOF__
=======
#-- 최종 파일
$(ls -l ${keepsNameExt})
#-- 지난 파일
$(ls -l backup/${keepsName_Date_Ext})
#-- server 내역
$(ssh -p ${svrPORT} ${userID}@${svrURL} ls -l ${svrDIR}/${keeps_name}*.${keeps_ext} ./${svrDIR}/backup/${keeps_name}*.${keeps_ext})
#-- cloud 내역
$(ssh -p ${svrPORT} ${userID}@${svrURL} rclone lsl ${cloudDRV}:${cloudDIR}/ --include "${keeps_name}*.${keeps_ext}")
__EOF__

cat <<__EOF__
#----
#---- (10) cat ${log_keepass}
#----
__EOF__
cat ${log_keepass}
cat <<__EOF__
#====
#==== (10) cat ${log_keepass}
#====
__EOF__
