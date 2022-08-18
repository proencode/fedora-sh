#!/bin/sh

cBlack=$(tput bold)$(tput setaf 0); cRed=$(tput bold)$(tput setaf 1); cGreen=$(tput bold)$(tput setaf 2); cYellow=$(tput bold)$(tput setaf 3); cBlue=$(tput bold)$(tput setaf 4); cMagenta=$(tput bold)$(tput setaf 5); cCyan=$(tput bold)$(tput setaf 6); cWhite=$(tput bold)$(tput setaf 7); cReset=$(tput bold)$(tput sgr0); cUp=$(tput cuu 2)

cat <<__EOF__

bbop edit2022 에디터 MVGQHT6HGBvKZYEA3Q 대지거퍼 코드네임
git config --global credential.helper store #-- 토큰의 유효기간동안 비번없이 진행한다.
ghp_oHVLCLWM8l9Dt0vM5a5VcYrBw1dIvO3Uhl 대소쿠리
ghp_oqmCyGaHfr0ztUEO4n6AD525xgWGpU02B 육ㅠㅠ

${cYellow}git config --global user.name "${USER} at $(uname -n)"${cReset}
${cYellow}git config --global user.email "yosjeon@gmail.com"${cReset}
${cYellow}git config --global alias.ll "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # ----> 한줄로 로그보기${cReset}
${cYellow}git config --global --list${cReset}
__EOF__

cd ~/git-projects
for dir in $(ls -d *)
do
	if [ -d $dir ]; then
		cd $dir
		echo "${cYellow}----> ${dir}${cReset}"
		git status ; echo -e "${cGreen}$(git pull)\n${cCyan}$(git ll -1)${cReset}"
		cd ..
	else
		echo "${cRed}!!!! ${cYellow}----> ${dir} 폴더가 없습니다."
	fi
done
