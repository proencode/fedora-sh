#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        #-- echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${yyy}#-- ${ccc}$1 ${bbb}#-- $2${xxx}"; echo "$1" | bash
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}
cmdend () {
        echo "${rrr}#--///-- ${mmm}$1${xxx}"
}
pswdonly () { #-- "(1) INPUT: port #"  "(입력시 표시 안됨)"
        #-- echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"
        echo "${yyy}#-- ${ccc}$1 ${bbb}#-- $2${xxx}"
        read -s pswdonly
	echo " "
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}
readecho () { #-- "(2) INPUT: 서버 디렉토리"  "${svrDIR}"
        echo "${yyy}#-- ${ccc}$1 ${bbb}#-- $2${xxx}"
        read readecho
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}

keeps_name="keepassproen" #-- keepass 파일의 이름만
keeps_ext="kdbx" #-- 확장자
keepsNameExt="${keeps_name}.${keeps_ext}" #-- keepass 현재 파일명
keepsName_Date_Ext=${keeps_name}-$(date +%y%m%d-%H%M).${keeps_ext} #-- 백업위해 바꿀 현재파일 새이름

if [ ! -f ${keepsNameExt} ]; then
	cat <<__EOF__
${bbb}#--
#-- !!! ${keepsNameExt} 파일이 있는곳에서 실행해야 한다. !!!
#--${xxx}
__EOF__
	exit -1
fi

pswdonly "(1) INPUT: 서버 사용자" "타이핑하는 글자를 보여주지 않습니다."
userID="${pswdonly}"

pswdonly "(2) INPUT: 서버 주소" "타이핑하는 글자를 보여주지 않습니다."
svrURL="${pswdonly}"

pswdonly "(3) INPUT: 서버 포트번호" "타이핑하는 글자를 보여주지 않습니다."
svrPORT=${pswdonly}

svrDIR="archive/keepass" #-- 파일을 저장하는 디렉토리
readecho "(4) INPUT: 서버 디렉토리"  "${svrDIR}"
svrDIR="${readecho}"
svrDIR=$(echo "$svrDIR" | perl -pe 's/\/+$//') #-- 마지막에 있는 '/' 는 모두 삭제하는 perl 스크립트

cloudDRV="yosjgc" #-- 클라우드 드라이브
readecho "(5) INPUT: 클라우드 드라이브"  "${cloudDRV}"
cloudDRV="${readecho}"
cloudDIR="keepass" #-- 파일을 저장하는 디렉토리
readecho "(6) INPUT: 클라우드 디렉토리"  "${cloudDIR}"
cloudDIR="${readecho}"

cat <<__EOF__
${bbb}#--
#-- (7) INPUT: 수정메모
#--            --------${xxx}
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
${bbb}#----------${xxx}
$(cat ${log_keepass})
${bbb}#----------
위 내용을 keepass.kdbx 에 저장한 뒤에 진행해야 합니다.
#-- press Enter:${xxx}
__EOF__
read a


cat <<__EOF__
${bbb}#--> ${ccc}${svrDIR}
${bbb}#--
#-- (8) 서버의 keepass 파일을 backup/ 으로 이동
#-- ssh -p svrPORT userID@svrURL mv ./${svrDIR}/${keepsNameExt} ./${svrDIR}/backup/${keepsName_Date_Ext}${xxx}
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} mv ./${svrDIR}/${keepsNameExt} ./${svrDIR}/backup/${keepsName_Date_Ext}
cat <<__EOF__
${bbb}#-- rsync -avzr ${keepsNameExt} backup/${keepsName_Date_Ext} #-- 로컬 백업 폴더로 복사"${xxx}
__EOF__
rsync -avzr ${keepsNameExt} backup/${keepsName_Date_Ext}

cat <<__EOF__
${bbb}#--
#-- (9) 서버로 복사
#-- rsync -avzr -e \"ssh -p svrPORT\" ${keepsNameExt} userID@svrURL:${svrDIR}/${xxx}
__EOF__
rsync -avzr -e "ssh -p ${svrPORT}" ${keepsNameExt} ${userID}@${svrURL}:${svrDIR}/

cat <<__EOF__
${bbb}#--
#-- (10) 백업하기 전의 클라우드 파일
#-- ssh -p svrPORT userID@svrURL rclone lsl cloudDRV:cloudDIR/ --include \"${keeps_name}*.${keeps_ext}\"${xxx}
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} rclone lsl ${cloudDRV}:${cloudDIR}/ --include "${keeps_name}*.${keeps_ext}"

cat <<__EOF__
${bbb}#--
#-- (11) 클라우드 파일 이름바꾸기
#-- ssh -p svrPORT userID@svrURL rclone moveto cloudDRV:cloudDIR/${keepsNameExt} cloudDRV:cloudDIR/backup/${keepsName_Date_Ext}${xxx}
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} rclone moveto ${cloudDRV}:${cloudDIR}/${keepsNameExt} ${cloudDRV}:${cloudDIR}/backup/${keepsName_Date_Ext}

cat <<__EOF__
${bbb}#--
#-- (12) 클라우드로 복사
#-- ssh -p svrPORT userID@svrURL rclone copy ./svrDIR/${keepsNameExt} cloudDRV:cloudDIR/${xxx}
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} rclone copy ./${svrDIR}/${keepsNameExt} ${cloudDRV}:${cloudDIR}/

cat <<__EOF__
${bbb}#--
#-- (13) 백업 완료후 클라우드의 파일
#-- ssh -p svrPORT userID@svrURL rclone lsl cloudDRV:cloudDIR/ --include "${keeps_name}*"${xxx}
__EOF__
ssh -p ${svrPORT} ${userID}@${svrURL} rclone lsl ${cloudDRV}:${cloudDIR}/ --include "${keeps_name}*.${keeps_ext}"

cat <<__EOF__
${bbb}#--
#-- (14) 로컬의 파일과 server 파일, cloud 파일을 확인하기 위해, 원격 서버에 로그인을 두번 실행합니다.${xxx}
__EOF__
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

echo "${bbb}#---------- (15) cat ${log_keepass} ----------${xxx}"
cat ${log_keepass}
echo "${bbb}#========== (15) cat ${log_keepass} ==========${xxx}"
