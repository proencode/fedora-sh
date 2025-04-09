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
keepsNameExt="${keeps_name}.${keeps_ext}" #-- keepass 파일명 전체

userID="orangepi" #-- 호스트의 사용자
svrURL="proen.duckdns.org" #-- 호스트 URL
svrDIR="archive/keepass" #-- 파일을 저장하는 디렉토리

cloudDRV="yosjgc" #-- 클라우드 드라이브
cloudDIR="keepass" #-- 파일을 저장하는 디렉토리

keepass_dir="Downloads/01-bada"
if [ ! -d ~/${keepass_dir} ]; then
	cmdrun "mkdir -p ~/${keepass_dir}" "(0.1) 폴더 만들기"
fi
cd ~/${keepass_dir}

pswdonly "input: 호스트 접속시 포트번호" "(1) 타이핑하는 글자를 보여주지 않습니다."
svrPORT=${pswdonly}

readecho "서버 디렉토리 지정" "(2) 또는, Enter를 눌러서 ${svrDIR} 폴더로 지정."
if [ "x$readecho" != "x" ]; then
        svrDIR=$readecho
fi
svrDIR=$(echo "$svrDIR" | perl -pe 's/\/+$//') #-- 마지막에 있는 '/' 는 모두 삭제하는 perl 스크립트
echo "${bbb}#----> ${mmm}svrDIR= ${ccc}${svrDIR}${xxx}"

tmpfle="x$(date +%y%m%d%H%M%S)"
tmpfle2="xx$(date +%y%m%d%H%M%S)"
echo "${yyy}#-- ${ccc}ssh -p svrPORT userID@svrURL ls -l keepName | awk -F'${svrDIR}/' ${bbb}#-- (3) 서버의 파일 확인${xxx}"
ssh -p ${svrPORT} ${userID}@${svrURL} ls -l ${svrDIR}/${keepsNameExt} > ${tmpfle}
cat ${tmpfle} | awk -F"${svrDIR}/" '{print $1 $2}' > ${tmpfle2} #-- 디렉토리 부분을 뺀다.
echo "${rrr}#// ${bbb}ssh -p svrPORT userID@svrURL ls -l keepName #-- (3) 서버의 파일 확인${xxx}"

kdbsiz=$(awk '{print $5}' ${tmpfle2})
echo "${bbb}$(awk -F${kdbsiz} '{print $1}' ${tmpfle2}) ${rrr}${kdbsiz} ${ggg}$(awk -F${kdbsiz} '{print $2}' ${tmpfle2}; rm -f ${tmpfle} ${tmpfle2}) ${bbb}#-- (4) 서버의 **최종** 파일${xxx}"

if [ -f ${keepsNameExt} ]; then
	tmpfle="x$(date +%y%m%d%H%M%S)"
	ls -l ${keepsNameExt} > ${tmpfle}
	kdbsiz=$(awk '{print $5}' ${tmpfle})
	echo "${bbb}$(awk -F${kdbsiz} '{print $1}' ${tmpfle}) ${rrr}${kdbsiz} ${ggg}$(awk -F${kdbsiz} '{print $2}' ${tmpfle}; rm -f ${tmpfle}) ${bbb}#-- (5) 로컬의 --변경전-- 파일${xxx}"
	oldkne="o"
else
	echo "${bbb}#-- (5) 로컬의 --변경전-- 파일이 없습니다.${xxx}"
	oldkne="x"
fi

echo "${bbb}#-- ${ccc}<4> 서버의 파일 ${bbb}이 ${ccc}<5> 로컬의 파일 ${bbb}보다 최신인 경우만 받아옵니다."
if [ "${oldkne}" == "x" ]; then
	readecho="y"
	echo "${bbb}#-- ${yyy}'y' ${bbb}#-- (6) 로컬에 파일이 없으므로 무조건 받아옵니다.${xxx}"
else
	readecho "'y' or Enter:" "(6) 서버의 파일이 더 최근이면, 받아오기 위해 'y' 를 입력하세요."
fi
if [ "x$readecho" = "xy" ]; then
	echo "${yyy}#-- ${ccc}rsync avzr -e \"ssh -p svrPORT\" userID@svrURL:svrDIR/keepsNameExt keepsNameExt ${bbb}#-- (7.1) 서버에서 받아옵니다.${xxx}"
	rsync -avzr -e "ssh -p ${svrPORT}" ${userID}@${svrURL}:${svrDIR}/${keepsNameExt} ${keepsNameExt}
	echo "${rrr}#// ${bbb}rsync avzr -e \"ssh -p svrPORT\" userID@svrURL:svrDIR/keepsNameExt keepsNameExt #-- (7.1) 서버에서 받아옵니다.${xxx}"
else
	echo "${bbb}#-- (7.2) 'y' 가 아니므로 서버에서 받아오지 않습니다.${xxx}"
fi

tmpfle="x$(date +%y%m%d%H%M%S)"
ls -l ${keepsNameExt} > ${tmpfle}
kdbsiz=$(awk '{print $5}' ${tmpfle})
echo "${bbb}$(awk -F${kdbsiz} '{print $1}' ${tmpfle}) ${rrr}${kdbsiz} ${ggg}$(awk -F${kdbsiz} '{print $2}' ${tmpfle}; rm -f ${tmpfle}) ${bbb}#-- (8) 로컬의 **최종** 파일.${xxx}"

echo "${yyy}#-- ${ccc}cd - ${bbb}#-- (9) 원래 위치로 갑니다.${xxx}"
cd -
echo "${bbb}#-- cd - #-- (9) 원래 위치로 갑니다.${xxx}"

#xxxx $(ping -n 1 ${svrURL} | grep PING | awk -F'(' '{print $2}' | awk -F')' '{print $1}') pi
#xxxx $(ifconfig | grep -B1 tm | grep 192.168 | awk -F'inet' '{print $2}' | awk -F'netmask' '{print $1"vb"}')
cat <<__EOF__
$(ping -n 1 ${svrURL} | awk -F'[' '{print $2}' | awk -F']' '{print $1}') pi
192.168.100.248 pu    #-- pu13
192.168.100.183 jj    #-- jj18

C:\Windows\System32\drivers\etc\hosts
위치
\$(ipconfig | grep -a "192.168." | grep -av ".1\$" | awk -F': ' '{print \$2}') vb #-- for Windows
ifconfig | grep -B1 tm #-- for Linux
sudo hostnamectl set-hostname u24041svr-VB

__EOF__
cmdend "서버에서 keepass 파일을 받아오는 스크립트"
