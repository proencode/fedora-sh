#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cat <<__EOF__
--------------------
${bbb}이번 선거 서초갑 현수막 칭찬합니다 ㄷㄷㄷ [12]17:23:28
확님${xxx}
--------------------
#----> 위와 같이 제목을 복사/붙여넣기 하고, Enter 를 눌러주세요~

__EOF__
read a

msg=$(echo ${a} | awk -F'[' '{print $1}')
sibuncho=$(echo ${a} | awk -F"]" '{print $2}')
hm=$(echo ${sibuncho} | awk -F":" '{print $1$2}')
read user
c="$(date +%y%m%d)-${hm}${user}-${msg}"
underc=$(echo ${c,,} | sed 's/ /_/g')
cat <<__EOF__
${mmm}
${underc}${xxx}

__EOF__
