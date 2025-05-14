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

svrURL="pi" #-- 호스트 URL
userID="orangepi" #-- 호스트의 사용자
svrDIR="archive/keepass" #-- 파일을 저장하는 디렉토리

cloudDRV="yosjgc" #-- 클라우드 드라이브
cloudDIR="keepass" #-- 파일을 저장하는 디렉토리
DIR_Downloads_qna="Downloads/qna-$(date +%y%m%d-%H%M)"
if [ ! -d ~/${DIR_Downloads_qna} ]; then
	cmdrun "mkdir -p ~/${DIR_Downloads_qna}" "(0) 폴더 만들기"
fi

cd ~/${DIR_Downloads_qna}
cmdrun "ls -al ~/${DIR_Downloads_qna}" "(1) 폴더 내용"

pswdonly "input: 호스트 접속시 포트번호" "(2) 타이핑하는 글자를 보여주지 않습니다."
svrPORT=${pswdonly}

echo "${yyy}#-- ${ccc} rsync -avzr -e \"ssh -p ${svrPORT}\" ${userID}@${svrURL}:git-projects/fedora-sh/qna-chrome-extension-md/ yow-git-fed-qna/ ${bbb}#-- (3.1) 서버에서 받아옵니다.${xxx}"
rsync -avzr -e "ssh -p ${svrPORT}" ${userID}@${svrURL}:git-projects/fedora-sh/qna-chrome-extension-md/ yow-git-fed-qna/
echo "${rrr}#// ${bbb} rsync -avzr -e \"ssh -p ${svrPORT}\" ${userID}@${svrURL}:git-projects/fedora-sh/qna-chrome-extension-md/ yow-git-fed-qna/ #-- (3.1) 서버에서 받아옵니다.${xxx}"

echo "${yyy}#-- ${ccc} rsync -avzr -e \"ssh -p ${svrPORT}\" ${userID}@${svrURL}:qna-chrome-extension/running-qna/ running-qna/ ${bbb}#-- (3.2) 서버에서 받아옵니다.${xxx}"
rsync -avzr -e "ssh -p ${svrPORT}" ${userID}@${svrURL}:qna-chrome-extension/running-qna/ running-qna/
echo "${rrr}#-- ${bbb} rsync -avzr -e \"ssh -p ${svrPORT}\" ${userID}@${svrURL}:qna-chrome-extension/running-qna/ running-qna/ #-- (3.2) 서버에서 받아옵니다.${xxx}"

cmdend "서버에서 qna 파일을 받아오는 스크립트"
