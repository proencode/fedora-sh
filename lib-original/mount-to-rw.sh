#!/bin/sh

CMD_NAME=`basename $0` # 명령줄에서 실행 프로그램 이름만 꺼냄
CMD_DIR=${0%/$CMD_NAME} # 실행 이름을 빼고 나머지 디렉토리만 담음
if [ "x$CMD_DIR" == "x" ] || [ "x$CMD_DIR" == "x$CMD_NAME" ]; then
	CMD_DIR="."
fi
source ${HOME}/lib/color_base #-- cBlack cRed cGreen cYellow cBlue cMagenta cCyan cWhite cReset cUp
# ~/lib/color_base 220827-0920 cat_and_run cat_and_run_cr cat_and_read cat_and_readY view_and_read show_then_run show_then_view show_title value_keyin () {


cat_and_run "ls -l /media | grep sf_" "출처: https://forums.virtualbox.org/viewtopic.php?t=79965"
echo ""
cat_and_run "sudo grep vbox /etc/group | grep ${USER}"
cat <<__EOF__

----> vbox 그룹에 ${USER} 사용자가 추가돼 있지 않으면,
----> 사용자에게 vbox 그룹을 추가하기 위해, 'y' 를 입력하세요.
__EOF__
read a
if [ "x$a" = "xy" ]; then
	cat_and_run "sudo gpasswd -a ${USER} vboxsf"
	echo ""
	cat_and_run "sudo grep vbox /etc/group | grep ${USER}"
fi

echo ""
cat_and_run "id" "id 명령으로 uid 와 gid 값을 확인합니다."
echo ""
cat_and_run "ls -l /media | grep sf_"

cat <<__EOF__

gid 와 mid 가 모두 1000 이 아니면,
uid 와 gid 를 1000 대신 직접 넣어야 합니다.
__EOF__
cat_and_readY "sudo mount -t vboxsf -o remount,uid=1000,gid=1000,rw wind /media/sf_Downloads" "remount 를 하려면, 'y' 를 입력하세요."
