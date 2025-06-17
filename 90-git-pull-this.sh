#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cat_and_run () {
	echo "${ggg}----> ${yyy}$1 ${ccc}$2${xxx}"; echo "$1" | bash
	echo "${mmm}<---- ${bbb}$1 $2${xxx}"
}

# ---

cat <<__EOF__

${yyy}git config --global user.name "${USER} at $(uname -n)"${xxx}
${yyy}git config --global user.email "yosjeon@gmail.com"${xxx}
${yyy}git config --global alias.ll "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # ----> 한줄로 로그보기${xxx}
${yyy}git config --global --list${xxx}
__EOF__

cat_and_run "git config --global --list" "git 의 설정을 확인합니다."
cat_and_run "git ll -5" "다섯개의 로그를 확인합니다."
cat <<__EOF__

${yyy}----> ${ggg}git pull ${xxx}//////// ${yyy}//////// ${bbb}//////// ${yyy}//////// ${bbb}//////// ${yyy}//////// ${bbb}//////// ${xxx}//////// ${yyy}---->${xxx}
$(git pull)
${rrr}<---- ${bbb}git pull ${xxx}//////// ${mmm}//////// ${bbb}//////// ${mmm}//////// ${bbb}//////// ${mmm}//////// ${bbb}//////// ${xxx}//////// ${rrr}<----${xxx}

__EOF__
cat_and_run "git ll -5" "최근 다섯개의 로그를 확인합니다."
cat_and_run "git status" "현재의 상태를 확인합니다."
