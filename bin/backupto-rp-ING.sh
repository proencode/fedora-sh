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
readEquals () { #-- "(3) INPUT: 서버 디렉토리"  "${Equals}"
        echo "${yyy}#-- ${ccc}$1 ${bbb}[ ${xxx}$2 ${bbb}]${xxx}"
        read readEquals
	if [ "x${readEquals}" = "x" ]; then
		readEquals="$2"
	fi
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}

keeps_name="keepassproen" #-- keepass 파일의 이름 앞부분만
minusYYdot="-*." #-- keepass 이름의 년도표시 부분
keeps_ext="kdbx" #-- 확장자
keepsNameExt="${keeps_name}${minusYYdot}${keeps_ext}" #-- keepass 파일이름 전체

cloudDRV="yosjgc" #-- 클라우드 드라이브
cloudDIR="keepass" #-- 클라우드쪽 파일을 저장하는 디렉토리

svrDIR="git*/fed*" #-- 서버쪽 파일을 저장하는 디렉토리

send_file_name="${1}"
server_dir="${2}"
if [ "x$${send_file_name}" = "x" ]; then
	echo "${mmm}#-- ${bbb} 실행시 ${xxx}$0 file.name ${bbb}---> 이와 같이 보내줄 파일 이름을 지정해야 합니다.${xxx}"
	exit -101
fi
cd ~/${keepass_dir}

pswdonly "서버 사용자" "(1) 타이핑하는 글자를 보여주지 않습니다."; userID="${pswdonly}"
pswdonly "서버 주소" "(2) 타이핑하는 글자를 보여주지 않습니다."; svrURL="${pswdonly}"
pswdonly "서버 포트번호" "(3) 타이핑하는 글자를 보여주지 않습니다."; svrPORT="${pswdonly}"
readEquals "(4) 파일을 받을 서버 디렉토리" "git*/fed*/bin/"

svrDIR=$(echo "$svrDIR" | perl -pe 's/\/+$//') #-- 마지막에 있는 '/' 는 모두 삭제하는 perl 스크립트
echo "${bbb}#----> ${mmm}svrDIR= ${ccc}${svrDIR}${xxx}"

tmpfle="x$(date +%y%m%d%H%M%S)"
tmpfle2="xx$(date +%y%m%d%H%M%S)"
echo "${yyy}#-- ${ccc}ssh -p svrPORT userID@svrURL ls -l ${keeps_name}${rrr}${minusYYdot}${mmm}${keeps_ext}${ccc} | awk -F'${svrDIR}/' ${bbb}#-- (5) 서버의 파일 확인${xxx}"
ssh -p ${svrPORT} ${userID}@${svrURL} ls -l ${svrDIR}/${keepsNameExt} > ${tmpfle}
cat ${tmpfle} | awk -F"${svrDIR}/" '{print $1 $2}' > ${tmpfle2} #-- 디렉토리 부분을 뺀다.
echo "${rrr}#// ${bbb}ssh -p svrPORT userID@svrURL ls -l keepName #-- (6) 서버의 파일 확인${xxx}"

kdbsiz=$(awk '{print $5}' ${tmpfle2})
echo "${bbb}$(awk -F${kdbsiz} '{print $1}' ${tmpfle2}) ${rrr}${kdbsiz} ${ggg}$(awk -F${kdbsiz} '{print $2}' ${tmpfle2}; rm -f ${tmpfle} ${tmpfle2}) ${bbb}#-- (7) 서버의 **최종** 파일${xxx}"

if [ -f ${keepsNameExt} ]; then
	tmpfle="x$(date +%y%m%d%H%M%S)"
	ls -l ${keepsNameExt} > ${tmpfle}
	kdbsiz=$(awk '{print $5}' ${tmpfle})
	echo "${bbb}$(awk -F${kdbsiz} '{print $1}' ${tmpfle}) ${rrr}${kdbsiz} ${ggg}$(awk -F${kdbsiz} '{print $2}' ${tmpfle}; rm -f ${tmpfle}) ${bbb}#-- (8) 로컬의 --변경전-- 파일${xxx}"
	oldkne="o"
else
	echo "${bbb}#-- (9) 로컬의 --변경전-- 파일이 없습니다.${xxx}"
	oldkne="x"
fi

echo "${bbb}#-- ${ccc}<4> 서버의 파일 ${bbb}이 ${ccc}<5> 로컬의 파일 ${bbb}보다 최신인 경우만 받아옵니다."
if [ "${oldkne}" == "x" ]; then
	readecho="y"
	echo "${bbb}#-- ${yyy}'y' ${bbb}#-- (10) 로컬에 파일이 없으므로 무조건 받아옵니다.${xxx}"
else
	readecho "'y' or Enter:" "(11) 서버의 파일이 더 최근이면, 받아오기 위해 'y' 를 입력하세요."
fi
if [ "x${readecho}" = "xy" ]; then
	echo "${yyy}#-- ${ccc}rsync avzr ${mmm}${keepsNameExt} ${bbb}#-- (12.1) 서버에서 받아옵니다.${xxx}"
	rsync -avzr -e "ssh -p ${svrPORT}" ${userID}@${svrURL}:${svrDIR}/${keepsNameExt} .
	echo "${rrr}#// ${bbb}rsync avzr ${mmm}${keepsNameExt} ${bbb}#-- (12.2) 서버에서 받아옵니다.${xxx}"
	tmpfle="x$(date +%y%m%d%H%M%S)"
	ls -l ${keepsNameExt} > ${tmpfle}
	kdbsiz=$(awk '{print $5}' ${tmpfle})
	echo "${bbb}$(awk -F${kdbsiz} '{print $1}' ${tmpfle}) ${rrr}${kdbsiz} ${ggg}$(awk -F${kdbsiz} '{print $2}' ${tmpfle}; rm -f ${tmpfle}) ${bbb}#-- (13) 로컬의 **최종** 파일.${xxx}"
else
	echo "${bbb}#-- (12.3) 'y' 가 아니므로 서버에서 받아오지 않습니다.${xxx}"
fi

echo "${yyy}#-- ${ccc}cd - ${bbb}#-- (14) 원래 위치로 갑니다.${xxx}"
cd -
echo "${bbb}#-- cd - #-- (15) 원래 위치로 갑니다.${xxx}"

#xxxx $(ping -n 1 ${svrURL} | grep PING | awk -F'(' '{print $2}' | awk -F')' '{print $1}') pi
#xxxx $(ifconfig | grep -B1 tm | grep 192.168 | awk -F'inet' '{print $2}' | awk -F'netmask' '{print $1"vb"}')
cat <<__EOF__
$(ping -n 1 ${svrURL} | awk -F'[' '{print $2}' | awk -F']' '{print $1}') pi
192.168.100.217 pu
192.168.100.156 jj

#-- 13 gg 57 yr 58 rp 59 yo 65 my 89 nl 95 mn

#--    notepad c:\Windows\System32\drivers\etc\hosts    #-- Windows cmd 관리자 권한으로 열기

cd ~/Dow*/02-*/; time rsync -avzr -e 'ssh -p   22' proenpi@pi:a*/01-*/u*svr.04* ./
cd ~/Dow*/02-*/; time rsync -avzr -e 'ssh -p   22' proenpi@pi:a*/iso*/u*[12]-live* ../

\$(ipconfig | grep -a "192.168." | grep -av ".1\$" | awk -F': ' '{print \$2}') vb #-- for Windows
ifconfig | grep -B1 tm #-- for Linux
sudo hostnamectl set-hostname u24041svr-VB

__EOF__
cmdend "서버에서 keepass 파일을 받아오는 스크립트"
