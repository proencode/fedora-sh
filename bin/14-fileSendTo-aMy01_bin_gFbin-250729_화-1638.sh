#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        #-- echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${yyy}#-- ${ccc}$1 ${bbb}#-- $2${xxx}"; echo "$1" | bash
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}

fff="$1" #-- file to server
if [ -f "${fff}" ]; then
	cmdrun "ls -l ${fff}" "보내려는 파일입니다."
fi
cat <<__EOF__
${ggg}#-- ${ccc}파일을 바꾸려면, 지금 입력하세요.
${ggg}#-- Enter new File name, or Press Enter Only ${rrr}[ ${ccc}${fff} ${rrr}]${xxx}
__EOF__
read a
if [ "x$a" != "x" ]; then
	fff=$a
fi
if [ ! -f "${fff}" ]; then
	echo "${ggg}#-- ${rrr}[ ${mmm}${fff} ${rrr}]${bbb} 파일이 없습니다."
	exit -1
fi
cmdrun "rsync -avzr -e 'ssh -p 5822' ${fff} proenpi@pi:bin/" "파일을 서버의 bin 으로 보냅니다."
cmdrun "ssh -p 5822 proenpi@pi 'mv a*/my*/last-01-files/* a*/my*/old-01*/; chmod 644 bin/${fff}; rsync -avzr bin/${fff} a*/my*/01*/; rsync -avzr bin/${fff} a*/my*/last-01*/; rsync -avzr bin/${fff} g*/f*/b*/; cd a*/m*/ol*/; echo ${ggg}; pwd; echo ${bbb}; ls -l ${fff:0:5}*; cd ../../../a*/m*/la*/; echo ${ggg}; pwd; echo ${ccc}; ls -l ${fff:0:5}*; cd ../../../a*/my*/01*/; echo ${ggg}; pwd; echo ${yyy}; ls -l ${fff:0:5}*; cd ../../../bin/; echo ${ggg}; pwd; echo ${rrr}; ls -l ${fff:0:5}*; cd ../g*/f*/b*/; echo ${ggg}; pwd; echo ${mmm}; ls -l ${fff:0:5}*; echo ${mmm}'" "서버의 git- 폴더와 01- 폴더에도 복사하고 확인합니다."
