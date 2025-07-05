#!/bin/sh

lll=$(tput bold)$(tput setaf 0); rrr=$(tput bold)$(tput setaf 1); ggg=$(tput bold)$(tput setaf 2); yyy=$(tput bold)$(tput setaf 3); bbb=$(tput bold)$(tput setaf 4); mmm=$(tput bold)$(tput setaf 5); ccc=$(tput bold)$(tput setaf 6); www=$(tput bold)$(tput setaf 7); xxx=$(tput bold)$(tput sgr0); uuu=$(tput cuu 2)

cat <<__EOF__
${yyy}#-- ${bbb} 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 팔아이대아이엘 2507장마철 — repo Expires on Thu, Oct 2 2025.
bitbucket 4카 BBwjLQ6yLFTmNrygzXrP3fdm9f6172DA 앹대..육이

${bbb}#${xxx}  ssh -oHostKeyAlgorithms=+ssh-dss -Y -p2022 kaoscOKr
${bbb}#${xxx}  rsync -avzr --delete -e 'ssh -oHostKeyAlgorithms=+ssh-dss -p 2022' --exclude=target/classes kaoscOKr:dir/ ./ #-- 받을때
${bbb}#${xxx}  rsync -avzr --delete --rsh="/usr/bin/sshpass -f \${HOME}/.ssh/kaosco.4ssh ssh -oHostKeyAlgorithms=+ssh-dss -Y -p2022 -o StrictHostKeyChecking=no -l kaosco" --no-o --no-g --delete kaoscOK:\${from_dir} .
${bbb}#${xxx}  rclone copy --include "Ktor*epub" yosjgc:ebooks ~/wind_bada/Downloads/
${bbb}#${xxx}  2. atyosjswlib 격화소양 i6ytjwudrk 촉견폐일소액구 kaosdesysclubi 씨큐둘째프로젝트 3rhg5vyrr

${yyy}git config --global user.name "${USER} at $(uname -n)" #-- 아이버스${xxx}
${yyy}git config --global user.email "yosjeon@gmail.com" #-- 데몬&${xxx}
${yyy}git config --global alias.ll "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # ----> 한줄로 로그보기${xxx}
${yyy}git config --global --list${xxx}
${yyy}git config --global credential.helper store${xxx}

__EOF__

cd ~/git-projects
for dir in $(ls -d *)
do
	if [ -d ${dir} ]; then
		cd ${dir}
		echo "${bbb}#  ${mmm}----> ${dir}${xxx}"
		git status ; echo -e "${ggg}$(git pull)\n${ccc}$(git ll -1)${xxx}"
		cd ..
	else
		echo "#  ${rrr}!!!! ${yyy}----> ${dir} 폴더가 없습니다."
	fi
done
cat <<__EOF__
${yyy}#-- ${bbb} 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 팔아이대아이엘 2507장마철 — repo Expires on Thu, Oct 2 2025.
bitbucket 4카 BBwjLQ6yLFTmNrygzXrP3fdm9f6172DA 앹대..육이
${xxx}
__EOF__
