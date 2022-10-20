#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${HOME}/lib/color_base #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp
# ~/lib/color_base 220827-0920 cat_and_run cat_and_run_cr cat_and_read cat_and_readY view_and_read show_then_run show_then_view show_title value_keyin () {

cat <<__EOF__
2. atyosjswlib 격화소양 i6ytjwudrk 촉견폐일소액구 
${cYellow}git config --global credential.helper store${cReset}
${cYellow}git config --global user.password "ATBBn9e5ZGpH6qk8yNbXfMUfeGe49D6AB2" #-- bbop대아투코드네임${cReset}
${cYellow}git config --global user.name "${USER} at $(uname -n)" #-- 아이버스${cReset}
${cYellow}git config --global user.email "yosjeon@gmail.com" #-- 데몬&${cReset}
${cYellow}git config --global user.password "ghp_LXVMgJ7YJe16DqPvj4m5Xf26nqqMwh2i0" #--깃헙대이지6신공 221117${cReset}
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
