#!/bin/sh

CMD_NAME=$(basename $0) # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${CMD_DIR}/bash_color #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp cat_and_run cat_and_read cat_and_readY

cat <<__EOF__
${cYellow}git config --global credential.helper store${cReset}
${cYellow}git config --global user.password "MVGQHT6HGBvKZYEA3Q" #-- bbop대지둘코드네임${cReset}
${cYellow}git config --global user.name "${USER} at $(uname -n)" #-- 아이버스${cReset}
${cYellow}git config --global user.email "yosjeon@gmail.com" #-- 데몬&${cReset}
${cYellow}git config --global user.password "ghp_oqmCyGaHfr0ztUEO4n6AD525xgWGpU02B" #--깃헙육ㅠㅠ신공${cReset}
${cYellow}git config --global alias.ll "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit" # ----> 한줄로 로그보기${cReset}
${cYellow}git config --global --list${cReset}
__EOF__

cd ~/git-projects
for dir in $(ls -d *)
do
	if [ -d ${dir} ]; then
		cd ${dir}
		echo "${cYellow}----> ${dir}${cReset}"
		git status ; echo -e "${cGreen}$(git pull)\n${cCyan}$(git ll -1)${cReset}"
		cd ..
	else
		echo "${cRed}!!!! ${cYellow}----> ${dir} 폴더가 없습니다."
	fi
done
