#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)
cmdrun () {
        #-- echo "${yyy}#-- ${ccc}$1 ${ggg}#-- ${bbb}$2${xxx}"; echo "$1" | bash
        echo "${yyy}#-- ${ccc}$1 ${bbb}#-- $2${xxx}"; echo "$1" | bash
        echo "${rrr}#// ${bbb}$1 #-- $2${xxx}"
}

i=$(ls 15-*html)
cmdrun "ls -l ${i}" "보내려는 파일입니다."
cmdrun "rsync -avzr -e 'ssh -p 5822' ${i} proenpi@pi:bin/" "파일을 서버의 bin 으로 보냅니다."
cmdrun "ssh -p 5822 proenpi@pi 'rsync -avzr bin/${i} g*/f*/bin/; mv a*/my*/last-01*/15* a*/my*/old-01*/; rsync -avzr bin/${i} a*/my*/01*/; rsync -avzr bin/${i} a*/my*/last-01*/; ls -l a*/my*/01*/15* a*/m*/old-01*/15* bin/15* g*/f*/b*/15*'" "서버의 git- 폴더와 01- 폴더에도 복사하고 확인합니다."
